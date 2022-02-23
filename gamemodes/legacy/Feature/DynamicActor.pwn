enum e_dynamic_actor
{
	actorID,
	Float:actorPos[4],
	actorInterior,
	actorWorld,
	actorSkin,
	actorAnim,
	actorName[MAX_PLAYER_NAME],
	STREAMER_TAG_ACTOR:actorModel,
	STREAMER_TAG_3D_TEXT_LABEL:actorLabel,
};

new ActorData[MAX_ACTORS][e_dynamic_actor];
new Iterator:DynamicActor<MAX_ACTOR>;

stock Actor_Create(skin, Float:x, Float:y, Float:z, Float:a, world, interior, anim = 0, name[] = "")
{
	new id = Iter_Free(DynamicActor);
	if(id != INVALID_ITERATOR_SLOT)
	{
		ActorData[id][actorPos][0] = x;
		ActorData[id][actorPos][1] = y;
		ActorData[id][actorPos][2] = z;
		ActorData[id][actorPos][3] = a;
		ActorData[id][actorSkin] = skin;
		ActorData[id][actorInterior] = interior;
		ActorData[id][actorWorld] = world;
		ActorData[id][actorAnim] = anim;
		format(ActorData[id][actorName], MAX_PLAYER_NAME, name);

		Iter_Add(DynamicActor, id);
		Actor_Spawn(id);
		mysql_tquery(sqlcon, "INSERT INTO `actors` (`Skin`) VALUES(0)", "OnActorCreated", "d", id);
		return id;
	}
	return INVALID_ITERATOR_SLOT;
}

FUNC::OnActorCreated(id)
{
	ActorData[id][actorID] = cache_insert_id();
	Actor_Save(id);
}

stock Actor_Spawn(id)
{
	new animlib[32], animname[32];

	if(!IsValidDynamicActor(ActorData[id][actorModel]))
	{
		ActorData[id][actorModel] = CreateDynamicActor(ActorData[id][actorSkin], ActorData[id][actorPos][0], ActorData[id][actorPos][1], ActorData[id][actorPos][2], ActorData[id][actorPos][3], 1, 100.0, ActorData[id][actorWorld], ActorData[id][actorInterior], -1, 20.0);
		ActorData[id][actorLabel] = CreateDynamic3DTextLabel(sprintf("[ID:%d]\n{FFFFFF}%s", id, ActorData[id][actorName]), COLOR_SERVER, ActorData[id][actorPos][0], ActorData[id][actorPos][1], ActorData[id][actorPos][2] + 1.0, 3.0);
		if(ActorData[id][actorAnim] != 0)
		{
			GetAnimationName(ActorData[id][actorAnim], animlib, 32, animname, 32);
			ApplyDynamicActorAnimation(ActorData[id][actorModel], animlib, animname, 4.1, 1, 0, 0, 1, 0);
		}
	}
	return 1;
}

stock Actor_Save(id)
{
	if(!Iter_Contains(DynamicActor, id))
		return 1;

	new query[1012];
	mysql_format(sqlcon, query, sizeof(query), "UPDATE `actors` SET ");
	mysql_format(sqlcon, query, sizeof(query), "%s`Skin` = '%d', ", query, ActorData[id][actorSkin]);
	mysql_format(sqlcon, query, sizeof(query), "%s`PosX` = '%f', ", query, ActorData[id][actorPos][0]);
	mysql_format(sqlcon, query, sizeof(query), "%s`PosY` = '%f', ", query, ActorData[id][actorPos][1]);
	mysql_format(sqlcon, query, sizeof(query), "%s`PosZ` = '%f', ", query, ActorData[id][actorPos][2]);
	mysql_format(sqlcon, query, sizeof(query), "%s`PosA` = '%f', ", query, ActorData[id][actorPos][3]);
	mysql_format(sqlcon, query, sizeof(query), "%s`Anim` = '%d', ", query, ActorData[id][actorAnim]);
	mysql_format(sqlcon, query, sizeof(query), "%s`World` = '%d', ", query, ActorData[id][actorWorld]);
	mysql_format(sqlcon, query, sizeof(query), "%s`Interior` = '%d', ", query, ActorData[id][actorInterior]);
	mysql_format(sqlcon, query, sizeof(query), "%s`Name` = '%s' ", query, ActorData[id][actorName]);
	mysql_format(sqlcon, query, sizeof(query), "%sWHERE `ID` = '%d'", query, ActorData[id][actorID]);
	mysql_query(sqlcon, query, true);
	return 1;
}

stock Actor_Delete(id)
{
	if(Iter_Contains(DynamicActor, id))
	{
		new query[128];
		mysql_format(sqlcon, query, 128, "DELETE FROM `actors` WHERE `ID` = '%d'", ActorData[id][actorID]);
		mysql_query(sqlcon, query, true);

		if(IsValidDynamicActor(ActorData[id][actorModel]))
			DestroyDynamicActor(ActorData[id][actorModel]);

		if(IsValidDynamic3DTextLabel(ActorData[id][actorLabel]))
			DestroyDynamic3DTextLabel(ActorData[id][actorLabel]);

		ActorData[id][actorID] = 0;
		Iter_SafeRemove(DynamicActor, id, id);
	}
	return 1;
}

stock Actor_Refresh(id)
{
	if(Iter_Contains(DynamicActor, id))
	{
		SetDynamicActorPos(ActorData[id][actorModel], ActorData[id][actorPos][0], ActorData[id][actorPos][1], ActorData[id][actorPos][2]);
		SetDynamicActorFacingAngle(ActorData[id][actorModel], ActorData[id][actorPos][3]);

		Streamer_SetPosition(STREAMER_TYPE_3D_TEXT_LABEL, ActorData[id][actorLabel], ActorData[id][actorPos][0], ActorData[id][actorPos][1], ActorData[id][actorPos][2] + 1.0);
		UpdateDynamic3DTextLabelText(ActorData[id][actorLabel], COLOR_SERVER, sprintf("[ID:%d]\n{FFFFFF}%s", id, ActorData[id][actorName]));

		Streamer_SetIntData(STREAMER_TYPE_ACTOR, ActorData[id][actorModel], E_STREAMER_MODEL_ID, ActorData[id][actorSkin]);
		if(ActorData[id][actorAnim] != 0)
		{
			new animlib[32], animname[32];
			GetAnimationName(ActorData[id][actorAnim], animlib, 32, animname, 32);
			ApplyDynamicActorAnimation(ActorData[id][actorModel], animlib, animname, 4.1, 1, 0, 0, 1, 0);
		}
	}
	return 1;
}
FUNC::Actor_Load()
{
	if(cache_num_rows())
	{
		forex(i, cache_num_rows())
		{
			cache_get_value_name_int(i, "ID", ActorData[i][actorID]);
			cache_get_value_name(i, "Name", ActorData[i][actorName]);
			cache_get_value_name_int(i, "Anim", ActorData[i][actorAnim]);
			cache_get_value_name_int(i, "Skin", ActorData[i][actorSkin]);
			cache_get_value_name_int(i, "World", ActorData[i][actorWorld]);
			cache_get_value_name_int(i, "Interior", ActorData[i][actorInterior]);
			cache_get_value_name_float(i, "PosX", ActorData[i][actorPos][0]);
			cache_get_value_name_float(i, "PosY", ActorData[i][actorPos][1]);
			cache_get_value_name_float(i, "PosZ", ActorData[i][actorPos][2]);
			cache_get_value_name_float(i, "PosA", ActorData[i][actorPos][3]);

			Iter_Add(DynamicActor, i);

			Actor_Spawn(i);
		}
		printf("[ACTOR] Loaded %d Dynamic Actor from database", cache_num_rows());
	}
	return 1;
}

CMD:createactor(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 6)
		return SendErrorMessage(playerid, NO_PERMISSION);

	new name[MAX_PLAYER_NAME], skinid, Float:x, Float:y, Float:z, Float:a;
	if(sscanf(params, "ds[24]", skinid, name))
		return SendSyntaxMessage(playerid, "/createactor [skinid] [name]");

	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, a);

	new id = Actor_Create(skinid, x, y, z, a, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), 0, name);

	if(id == INVALID_ITERATOR_SLOT)
		return SendErrorMessage(playerid, "You cannot create more actor's!");

	SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has created actorid %d with name %s", PlayerData[playerid][pUCP], id, name);
	SetPlayerPos(playerid, x + 1, y, z);
	return 1;
}

CMD:destroyactor(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 6)
		return SendErrorMessage(playerid, NO_PERMISSION);

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/destroyactor [actorid]");

	if(!IsNumeric(params))
		return SendSyntaxMessage(playerid, "/destroyactor [actorid]");

	if(!Iter_Contains(DynamicActor, strval(params)))
		return SendErrorMessage(playerid, "Invalid actor specified id!");

	Actor_Delete(strval(params));
	SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has destroyed actorid %d", PlayerData[playerid][pUCP], strval(params));
	return 1;
}
CMD:editactor(playerid, params[])
{
	new
	    id,
	    type[24],
	    string[128];

	if (PlayerData[playerid][pAdmin] < 6)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	SendSyntaxMessage(playerid, "/editactor [id] [name]");
	    SendClientMessage(playerid, COLOR_YELLOW, "Names:{FFFFFF} pos, model, name, anim");
		return 1;
	}
	if(!Iter_Contains(DynamicActor, id))
		return SendErrorMessage(playerid, "You have specified invalid actor!");

	if(!strcmp(type, "pos", true))
	{

		GetPlayerPos(playerid, ActorData[id][actorPos][0], ActorData[id][actorPos][1], ActorData[id][actorPos][2]);
		GetPlayerFacingAngle(playerid, ActorData[id][actorPos][3]);	

		Actor_Refresh(id);
		Actor_Save(id);

		SetPlayerPos(playerid, ActorData[id][actorPos][0] + 1, ActorData[id][actorPos][1], ActorData[id][actorPos][2]);

		SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has adjusted location actorid %d", PlayerData[playerid][pUCP], id);

	}
	else if(!strcmp(type, "model", true))
	{
		if(isnull(string))
			return SendSyntaxMessage(playerid, "/editactor [id] [model] [new skin model]");

		if(!IsNumeric(string))
			return SendSyntaxMessage(playerid, "/editactor [id] [model] [new skin model]");

		ActorData[id][actorSkin] = strval(string);
		Actor_Refresh(id);
		Actor_Save(id);
		SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has adjusted model of actorid %d to %d", PlayerData[playerid][pUCP], id, strval(string));
	}
	else if(!strcmp(type, "name", true))
	{
		if(isnull(string))
			return SendSyntaxMessage(playerid, "/editactor [id] [name] [new actor name]");

		format(ActorData[id][actorName], MAX_PLAYER_NAME, string);
		Actor_Refresh(id);
		Actor_Save(id);

		SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has adjusted name of actorid %d to %s", PlayerData[playerid][pUCP], id, string);
	}
	else if(!strcmp(type, "anim", true))
	{
		if(isnull(string))
			return SendSyntaxMessage(playerid, "/editactor [id] [anim] [animation index]");

		if(!IsNumeric(string))
			return SendSyntaxMessage(playerid, "/editactor [id] [anim] [animation index]");

		if(strval(string) < 1 || strval(string) > 1812)
			return SendErrorMessage(playerid, "Invalid animation index!");

		ClearDynamicActorAnimations(ActorData[id][actorModel]);

		new animlib[32], animname[32];
		ActorData[id][actorAnim] = strval(string);
		GetAnimationName(ActorData[id][actorAnim], animlib, 32, animname, 32);
		ApplyDynamicActorAnimation(ActorData[id][actorModel], animlib, animname, 4.1, 1, 0, 0, 1, 0);

		Actor_Save(id);

		SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has adjusted animation index of actorid %d to %d", PlayerData[playerid][pUCP], id, strval(string));
	}
	return 1;
}