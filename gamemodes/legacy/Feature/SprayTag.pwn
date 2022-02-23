enum e_tag_data
{
	tagID,
	Float:tagPos[6],
	tagInterior,
	tagWorld,
	tagOwner,
	tagFont[24],
	tagSize,
	tagBold,
	tagColor,
	tagText[64],
	STREAMER_TAG_OBJECT:tagObject
}
new TagData[MAX_TAGS][e_tag_data],
	Iterator:SprayTag<MAX_TAGS>;

new TagText[MAX_PLAYERS][64],
	TagFont[MAX_PLAYERS][24],
	TagSize[MAX_PLAYERS],
	TagBold[MAX_PLAYERS],
	TagColor[MAX_PLAYERS];


stock Tag_Create(playerid)
{
	new id = Iter_Free(SprayTag), Float:x, Float:y, Float:z, Float:a;
	if(id != INVALID_ITERATOR_SLOT)
	{
		GetPlayerPos(playerid, x,y,z);
		GetPlayerFacingAngle(playerid, a);
		format(TagData[id][tagText], 64, TagText[playerid]);
		format(TagData[id][tagFont], 24, TagFont[playerid]);
		TagData[id][tagPos][0] = x;
		TagData[id][tagPos][1] = y;
		TagData[id][tagPos][2] = z; 
		TagData[id][tagPos][3] = 0.0;
		TagData[id][tagPos][4] = 0.0;
		TagData[id][tagPos][5] = a - 90.0;
		TagData[id][tagBold] = TagBold[playerid];
		TagData[id][tagColor] = TagColor[playerid];
		TagData[id][tagSize] = TagSize[playerid];
		TagData[id][tagOwner] = PlayerData[playerid][pID];
		TagData[id][tagInterior] = GetPlayerInterior(playerid);
		TagData[id][tagWorld] = GetPlayerVirtualWorld(playerid);

		Iter_Add(SprayTag, id);

		Tag_Spawn(id);

		mysql_tquery(sqlcon, "INSERT INTO `tags` (`Size`) VALUES(0)", "OnSprayTagCreated", "d", id);

		return id;
	}
	return INVALID_ITERATOR_SLOT;
}

stock Tag_Delete(id)
{
	if(!Iter_Contains(SprayTag, id))
		return 1;

	new query[128];
	mysql_format(sqlcon, query, 128, "DELETE FROM `tags` WHERE `ID` = '%d'", TagData[id][tagID]);
	mysql_query(sqlcon, query);

	if(IsValidDynamicObject(TagData[id][tagObject]))
		DestroyDynamicObject(TagData[id][tagObject]);

	Iter_SafeRemove(SprayTag, id, id);
	return 1;
}

stock Tag_Spawn(id)
{
	TagData[id][tagObject] = CreateDynamicObject(19483, TagData[id][tagPos][0], TagData[id][tagPos][1], TagData[id][tagPos][2], TagData[id][tagPos][3], TagData[id][tagPos][4], TagData[id][tagPos][5], TagData[id][tagWorld], TagData[id][tagInterior], -1, 30.0, 30.0);

	SetDynamicObjectMaterialText(
		TagData[id][tagObject],
		0,
		TagData[id][tagText],
		OBJECT_MATERIAL_SIZE_512x512,
		TagData[id][tagFont],
		TagData[id][tagSize],
		TagData[id][tagBold],
		TagData[id][tagColor]
	);

	return 1;
}

stock ShowTagSetup(playerid)
{
	ShowPlayerDialog(playerid, DIALOG_SPRAYTAG, DIALOG_STYLE_LIST, "Tag - Setup", "Font\nFont Size\nToggle Bold\nText Color\n{FFFF00}Create", "Select", "Close");
	return 1;
}

stock HexToInt(string[])
{
	if(!string[0])
  	{
  		return 0;
	}
	
  	new cur = 1;
  	new res = 0;
  	
  	for(new i = strlen(string); i > 0; i--)
 	{
  		if(string[i - 1] < 58)
  		{
		  	res= res + cur * (string[i - 1] - 48);
  		}
  		else
  		{
	  		res = res + cur * (string[i - 1] - 65 + 10);
		}
    	cur = cur * 16;
  	}
	return res;
}

FUNC::OnSprayTagCreated(id)
{
	TagData[id][tagID] = cache_insert_id();
	Tag_Save(id);
}

stock Tag_Save(id)
{
	if(!Iter_Contains(SprayTag, id))
		return 1;

	new query[1012];
	mysql_format(sqlcon, query, sizeof(query), "UPDATE `tags` SET ");
	mysql_format(sqlcon, query, sizeof(query), "%s`PosX` = '%f', ", query, TagData[id][tagPos][0]);
	mysql_format(sqlcon, query, sizeof(query), "%s`PosY` = '%f', ", query, TagData[id][tagPos][1]);
	mysql_format(sqlcon, query, sizeof(query), "%s`PosZ` = '%f', ", query, TagData[id][tagPos][2]);
	mysql_format(sqlcon, query, sizeof(query), "%s`RotX` = '%f', ", query, TagData[id][tagPos][3]);
	mysql_format(sqlcon, query, sizeof(query), "%s`RotY` = '%f', ", query, TagData[id][tagPos][4]);
	mysql_format(sqlcon, query, sizeof(query), "%s`RotZ` = '%f', ", query, TagData[id][tagPos][5]);
	mysql_format(sqlcon, query, sizeof(query), "%s`Interior` = '%d', ", query, TagData[id][tagInterior]);
	mysql_format(sqlcon, query, sizeof(query), "%s`World` = '%d', ", query, TagData[id][tagWorld]);
	mysql_format(sqlcon, query, sizeof(query), "%s`Font` = '%s', ", query, TagData[id][tagFont]);
	mysql_format(sqlcon, query, sizeof(query), "%s`Text` = '%s', ", query, TagData[id][tagText]);
	mysql_format(sqlcon, query, sizeof(query), "%s`Bold` = '%d', ", query, TagData[id][tagBold]);
	mysql_format(sqlcon, query, sizeof(query), "%s`Size` = '%d', ", query, TagData[id][tagSize]);
	mysql_format(sqlcon, query, sizeof(query), "%s`Color` = '%d', ", query, TagData[id][tagColor]);
	mysql_format(sqlcon, query, sizeof(query), "%s`Owner` = '%d' ", query, TagData[id][tagOwner]);
	mysql_format(sqlcon, query, sizeof(query), "%sWHERE `ID` = '%d'", query, TagData[id][tagID]);
	mysql_query(sqlcon, query, true);
	return 1;
}


FUNC::Tag_Load()
{
	if(cache_num_rows())
	{
		forex(i, cache_num_rows())
		{
			cache_get_value_name_int(i, "ID", TagData[i][tagID]);
			cache_get_value_name_float(i, "PosX", TagData[i][tagPos][0]);
			cache_get_value_name_float(i, "PosY", TagData[i][tagPos][1]);
			cache_get_value_name_float(i, "PosZ", TagData[i][tagPos][2]);
			cache_get_value_name_float(i, "RotX", TagData[i][tagPos][3]);
			cache_get_value_name_float(i, "RotY", TagData[i][tagPos][4]);
			cache_get_value_name_float(i, "RotZ", TagData[i][tagPos][5]);
			cache_get_value_name(i, "Text", TagData[i][tagText], 64);
			cache_get_value_name(i, "Font", TagData[i][tagFont], 24);
			cache_get_value_name_int(i, "Interior", TagData[i][tagInterior]);
			cache_get_value_name_int(i, "World", TagData[i][tagWorld]);
			cache_get_value_name_int(i, "Color", TagData[i][tagColor]);
			cache_get_value_name_int(i, "Bold", TagData[i][tagBold]);
			cache_get_value_name_int(i, "Size", TagData[i][tagSize]);
			cache_get_value_name_int(i, "Owner", TagData[i][tagOwner]);
			Iter_Add(SprayTag, i);
			Tag_Spawn(i);
		}
		printf("[SPRAYTAG] Loaded %d spraytags from database", cache_num_rows());
	}
	return 1;
}

CMD:tag(playerid, params[])
{
	new
	    type[24],
	    string[128];

	if (sscanf(params, "s[24]S()[128]", type, string))
 	{
	 	SendSyntaxMessage(playerid, "/tag [names]");
	    SendClientMessage(playerid, COLOR_YELLOW, "Names:{FFFFFF} create, destroy, nearest");
		return 1;
	}	
	if(!strcmp(type, "create", true))
	{
		if(PlayerData[playerid][pLevel] < 3)
			return SendErrorMessage(playerid, "You must level 3 first to create tag!");

		ShowPlayerDialog(playerid, DIALOG_SPRAYTAG_TEXT, DIALOG_STYLE_INPUT, "Tag - Create", "Please input the text:", "Set", "Close");
	}
	else if(!strcmp(type, "destroy", true))
	{
		if(PlayerData[playerid][pAdmin] < 1)
			return SendErrorMessage(playerid, NO_PERMISSION);
		
		new id;
		if(sscanf(string, "d", id))
			return SendSyntaxMessage(playerid, "/tag [destroy] [id]");

		if(!Iter_Contains(SprayTag, id))
			return SendErrorMessage(playerid, "You have specified invalid tag id!");

		SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has destroyed Tag ID: %d", PlayerData[playerid][pUCP], id);
		Tag_Delete(id);

	}
	else if(!strcmp(type, "nearest", true))
	{
		if(PlayerData[playerid][pAdmin] < 1)
			return SendErrorMessage(playerid, NO_PERMISSION);

		new Float:range, bool:has = false;
		if(sscanf(string, "f", range))
			return SendSyntaxMessage(playerid, "/tag [nearest] [radius]");

		foreach(new i : SprayTag)
		{
			if(IsPlayerInRangeOfPoint(playerid, range, TagData[i][tagPos][0], TagData[i][tagPos][1], TagData[i][tagPos][2]))
			{
				SendClientMessageEx(playerid, -1, "ID: %d | Creator: %s | Font: %s", i, GetNameFromSQLID(TagData[i][tagOwner]), TagData[i][tagFont]);
				has = true;
			}
		}
		if(!has)
			return SendErrorMessage(playerid, "There is no tag on specified radius.");
	}
	return 1;
}