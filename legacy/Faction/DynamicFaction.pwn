enum
{
	FACTION_POLICE = 1,
	FACTION_NEWS,
	FACTION_MEDIC,
	FACTION_GOV,
	FACTION_FAMILY

};

enum factionData 
{
	factionID,
	factionExists,
	factionName[32],
	factionColor,
	factionType,
	factionRanks,
	Float:factionLockerPos[3],
	factionLockerInt,
	factionLockerWorld,
	factionSkins[8],
	factionWeapons[10],
	factionAmmo[10],
	factionDurability[10],
	factionSalary[15],
	STREAMER_TAG_3D_TEXT_LABEL:factionText3D,
	STREAMER_TAG_PICKUP:factionPickup,
	Float:SpawnX,
	Float:SpawnY,
	Float:SpawnZ,
	SpawnInterior,
	SpawnVW
};
new FactionData[MAX_FACTIONS][factionData];
new FactionRanks[MAX_FACTIONS][15][32];

stock GetInitials(const string[])
{
	new
	    ret[32],
		index = 0;

	for (new i = 0, l = strlen(string); i != l; i ++)
	{
	    if (('A' <= string[i] <= 'Z') && (i == 0 || string[i - 1] == ' '))
			ret[index++] = string[i];
	}
	return ret;
}

stock IsNearFactionLocker(playerid)
{
	new factionid = PlayerData[playerid][pFaction];

	if (factionid == -1)
	    return 0;

	if (IsPlayerInRangeOfPoint(playerid, 3.0, FactionData[factionid][factionLockerPos][0], FactionData[factionid][factionLockerPos][1], FactionData[factionid][factionLockerPos][2]) && GetPlayerInterior(playerid) == FactionData[factionid][factionLockerInt] && GetPlayerVirtualWorld(playerid) == FactionData[factionid][factionLockerWorld])
	    return 1;

	return 0;
}

stock GetFactionByID(sqlid)
{
	forex(i, MAX_FACTIONS) if (FactionData[i][factionExists] && FactionData[i][factionID] == sqlid)
	    return i;

	return -1;
}

stock SetFaction(playerid, id)
{
	if (id != -1 && FactionData[id][factionExists])
	{
		PlayerData[playerid][pFaction] = id;
		PlayerData[playerid][pFactionID] = FactionData[id][factionID];
	}
	return 1;
}

stock RemoveAlpha(color) {
    return (color & ~0xFF);
}

stock SetFactionColor(playerid)
{
	new factionid = PlayerData[playerid][pFaction];

	if (factionid != -1)
		return SetPlayerColor(playerid, RemoveAlpha(FactionData[factionid][factionColor]));

	return 0;
}

stock Faction_Update(factionid)
{
	if (factionid != -1 || FactionData[factionid][factionExists])
	{
	    foreach (new i : Player) if (PlayerData[i][pFaction] == factionid)
		{
 			if (GetFactionType(i) == FACTION_FAMILY || (GetFactionType(i) != FACTION_FAMILY && PlayerData[i][pOnDuty]))
			 	SetFactionColor(i);
		}
	}
	return 1;
}

stock Faction_Refresh(factionid)
{
	if (factionid != -1 && FactionData[factionid][factionExists])
	{
	    if (FactionData[factionid][factionLockerPos][0] != 0.0 && FactionData[factionid][factionLockerPos][1] != 0.0 && FactionData[factionid][factionLockerPos][2] != 0.0)
	    {
		    static
		        string[128];

			if (IsValidDynamicPickup(FactionData[factionid][factionPickup]))
			    DestroyDynamicPickup(FactionData[factionid][factionPickup]);

			if (IsValidDynamic3DTextLabel(FactionData[factionid][factionText3D]))
			    DestroyDynamic3DTextLabel(FactionData[factionid][factionText3D]);

			FactionData[factionid][factionPickup] = CreateDynamicPickup(1239, 23, FactionData[factionid][factionLockerPos][0], FactionData[factionid][factionLockerPos][1], FactionData[factionid][factionLockerPos][2], FactionData[factionid][factionLockerWorld], FactionData[factionid][factionLockerInt]);

			format(string, sizeof(string), "[ID: %d]\n{FFFFFF}Type {FFFF00}/faction locker {FFFFFF}to access the locker.", factionid);
	  		FactionData[factionid][factionText3D] = CreateDynamic3DTextLabel(string, -1, FactionData[factionid][factionLockerPos][0], FactionData[factionid][factionLockerPos][1], FactionData[factionid][factionLockerPos][2], 5.0, INVALID_VEHICLE_ID, INVALID_PLAYER_ID, 0, FactionData[factionid][factionLockerWorld], FactionData[factionid][factionLockerInt]);
		}
	}
	return 1;
}

stock Faction_Save(factionid)
{
	static
	    query[2048];

	mysql_format(sqlcon, query, sizeof(query), "UPDATE `factions` SET `factionName` = '%s', `factionColor` = '%d', `factionType` = '%d', `factionRanks` = '%d', `factionLockerX` = '%.4f', `factionLockerY` = '%.4f', `factionLockerZ` = '%.4f', `factionLockerInt` = '%d', `factionLockerWorld` = '%d', `SpawnX` = '%f', `SpawnY` = '%f', `SpawnZ` = '%f', `SpawnInterior` = '%d', `SpawnVW` = '%d'",
		FactionData[factionid][factionName],
		FactionData[factionid][factionColor],
		FactionData[factionid][factionType],
		FactionData[factionid][factionRanks],
		FactionData[factionid][factionLockerPos][0],
		FactionData[factionid][factionLockerPos][1],
		FactionData[factionid][factionLockerPos][2],
		FactionData[factionid][factionLockerInt],
		FactionData[factionid][factionLockerWorld],
		FactionData[factionid][SpawnX],
		FactionData[factionid][SpawnY],
		FactionData[factionid][SpawnZ],
		FactionData[factionid][SpawnInterior],
		FactionData[factionid][SpawnVW]
	);
	forex(i, 10)
	{
	    if (i < 8)
			mysql_format(sqlcon, query, sizeof(query), "%s, `factionSkin%d` = '%d', `factionWeapon%d` = '%d', `factionAmmo%d` = '%d', `factionDurability%d` = '%d'", query, i + 1, FactionData[factionid][factionSkins][i], i + 1, FactionData[factionid][factionWeapons][i], i + 1, FactionData[factionid][factionAmmo][i], i + 1, FactionData[factionid][factionDurability][i]);

		else
			mysql_format(sqlcon, query, sizeof(query), "%s, `factionWeapon%d` = '%d', `factionAmmo%d` = '%d', `factionDurability%d` = '%d'", query, i + 1, FactionData[factionid][factionWeapons][i], i + 1, FactionData[factionid][factionAmmo][i], i + 1, FactionData[factionid][factionDurability][i]);
	}
	forex(i, 15)
	{
		mysql_format(sqlcon, query, sizeof(query), "%s, `factionSalary%d` = '%d'", query, i + 1, FactionData[factionid][factionSalary][i]);
	}
	mysql_format(sqlcon, query, sizeof(query), "%s WHERE `factionID` = '%d'",
		query,
		FactionData[factionid][factionID]
	);
	return mysql_tquery(sqlcon, query);
}

stock Faction_SaveRanks(factionid)
{
	static
	    query[768];

	mysql_format(sqlcon, query, sizeof(query), "UPDATE `factions` SET `factionRank1` = '%s', `factionRank2` = '%s', `factionRank3` = '%s', `factionRank4` = '%s', `factionRank5` = '%s', `factionRank6` = '%s', `factionRank7` = '%s', `factionRank8` = '%s', `factionRank9` = '%s', `factionRank10` = '%s', `factionRank11` = '%s', `factionRank12` = '%s', `factionRank13` = '%s', `factionRank14` = '%s', `factionRank15` = '%s' WHERE `factionID` = '%d'",
	    FactionRanks[factionid][0],
	    FactionRanks[factionid][1],
	    FactionRanks[factionid][2],
	    FactionRanks[factionid][3],
	    FactionRanks[factionid][4],
	    FactionRanks[factionid][5],
	    FactionRanks[factionid][6],
	    FactionRanks[factionid][7],
	    FactionRanks[factionid][8],
	    FactionRanks[factionid][9],
	    FactionRanks[factionid][10],
	    FactionRanks[factionid][11],
	    FactionRanks[factionid][12],
	    FactionRanks[factionid][13],
	    FactionRanks[factionid][14],
	    FactionData[factionid][factionID]
	);
	return mysql_tquery(sqlcon, query);
}

Faction_Delete(factionid)
{
	if (factionid != -1 && FactionData[factionid][factionExists])
	{
	    new
	        string[64];

		format(string, sizeof(string), "DELETE FROM `factions` WHERE `factionID` = '%d'", FactionData[factionid][factionID]);
		mysql_tquery(sqlcon, string);

		format(string, sizeof(string), "UPDATE `characters` SET `Faction` = '-1' WHERE `Faction` = '%d'", FactionData[factionid][factionID]);
		mysql_tquery(sqlcon, string);

		foreach (new i : Player)
		{
			if (PlayerData[i][pFaction] == factionid) {
		    	PlayerData[i][pFaction] = -1;
		    	PlayerData[i][pFactionID] = -1;
		    	PlayerData[i][pFactionRank] = -1;
			}
			if (PlayerData[i][pFactionEdit] == factionid) {
			    PlayerData[i][pFactionEdit] = -1;
			}
		}
		if (IsValidDynamicPickup(FactionData[factionid][factionPickup]))
  			DestroyDynamicPickup(FactionData[factionid][factionPickup]);

		if (IsValidDynamic3DTextLabel(FactionData[factionid][factionText3D]))
  			DestroyDynamic3DTextLabel(FactionData[factionid][factionText3D]);

	    FactionData[factionid][factionExists] = false;
	    FactionData[factionid][factionType] = 0;
	    FactionData[factionid][factionID] = 0;
	}
	return 1;
}

stock GetFactionType(playerid)
{
	if (PlayerData[playerid][pFaction] == -1)
	    return 0;

	return (FactionData[PlayerData[playerid][pFaction]][factionType]);
}

stock Faction_ShowSalary(playerid, factionid)
{
    if (factionid != -1 && FactionData[factionid][factionExists])
	{
		static
		    string[640];

		string[0] = 0;

		forex(i, FactionData[factionid][factionRanks])
			format(string, sizeof(string), "%sRank %d: $%s\n", string, i + 1, FormatNumber(FactionData[factionid][factionSalary][i]));

		PlayerData[playerid][pFactionEdit] = factionid;
		ShowPlayerDialog(playerid, DIALOG_EDITFACTION_SALARY_LIST, DIALOG_STYLE_LIST, FactionData[factionid][factionName], string, "Change", "Cancel");
	}
	return 1;
}

stock Faction_ShowRanks(playerid, factionid)
{
    if (factionid != -1 && FactionData[factionid][factionExists])
	{
		static
		    string[640];

		string[0] = 0;

		forex(i, FactionData[factionid][factionRanks])
		    format(string, sizeof(string), "%sRank %d: %s\n", string, i + 1, FactionRanks[factionid][i]);

		PlayerData[playerid][pFactionEdit] = factionid;
		ShowPlayerDialog(playerid, DIALOG_EDITRANK, DIALOG_STYLE_LIST, FactionData[factionid][factionName], string, "Change", "Cancel");	
	}
	return 1;
}

stock Faction_Create(name[], type)
{
	forex(i, MAX_FACTIONS) if (!FactionData[i][factionExists])
	{
	    format(FactionData[i][factionName], 32, name);

        FactionData[i][factionExists] = true;
        FactionData[i][factionColor] = 0xFFFFFF00;
        FactionData[i][factionType] = type;
        FactionData[i][factionRanks] = 5;

        FactionData[i][factionLockerPos][0] = 0.0;
        FactionData[i][factionLockerPos][1] = 0.0;
        FactionData[i][factionLockerPos][2] = 0.0;
        FactionData[i][factionLockerInt] = 0;
        FactionData[i][factionLockerWorld] = 0;

        for (new j = 0; j < 8; j ++) {
            FactionData[i][factionSkins][j] = 0;
        }
        for (new j = 0; j < 10; j ++) {
            FactionData[i][factionWeapons][j] = 0;
            FactionData[i][factionAmmo][j] = 0;
            FactionData[i][factionDurability][j] = 0;
	    }
	    for (new j = 0; j < 15; j ++) {
			format(FactionRanks[i][j], 32, "Rank %d", j + 1);
	    }
	    mysql_tquery(sqlcon, "INSERT INTO `factions` (`factionType`) VALUES(0)", "OnFactionCreated", "d", i);
	    return i;
	}
	return -1;
}

FUNC::OnFactionCreated(factionid)
{
	if (factionid == -1 || !FactionData[factionid][factionExists])
	    return 0;

	FactionData[factionid][factionID] = cache_insert_id();

	Faction_Save(factionid);
	Faction_SaveRanks(factionid);

	return 1;
}
FUNC::Faction_Load()
{
	new
	    rows = cache_num_rows(),
		str[56];

	if(rows)
	{
		forex(i, rows)
		{
		    FactionData[i][factionExists] = true;
		    cache_get_value_name_int(i, "factionID", FactionData[i][factionID]);
		    cache_get_value_name(i, "factionName", FactionData[i][factionName], 32);
		    cache_get_value_name_int(i, "factionColor", FactionData[i][factionColor]);
		    cache_get_value_name_int(i, "factionType", FactionData[i][factionType]);
		    cache_get_value_name_int(i, "factionRanks", FactionData[i][factionRanks]);
		    cache_get_value_name_float(i, "factionLockerX", FactionData[i][factionLockerPos][0]);
		    cache_get_value_name_float(i, "factionLockerY", FactionData[i][factionLockerPos][1]);
		    cache_get_value_name_float(i, "factionLockerZ", FactionData[i][factionLockerPos][2]);
		    cache_get_value_name_int(i, "factionLockerInt", FactionData[i][factionLockerInt]);
		    cache_get_value_name_int(i, "factionLockerWorld", FactionData[i][factionLockerWorld]);
		    cache_get_value_name_float(i, "SpawnX", FactionData[i][SpawnX]);
		    cache_get_value_name_float(i, "SpawnY", FactionData[i][SpawnY]);
		    cache_get_value_name_float(i, "SpawnZ", FactionData[i][SpawnZ]);
		    cache_get_value_name_int(i, "SpawnInterior", FactionData[i][SpawnInterior]);
		    cache_get_value_name_int(i, "SpawnVW", FactionData[i][SpawnVW]);

		    for (new j = 0; j < 8; j ++) {
		        format(str, sizeof(str), "factionSkin%d", j + 1);

		        cache_get_value_name_int(i, str, FactionData[i][factionSkins][j]);
			}
	        for (new j = 0; j < 10; j ++) {
		        format(str, sizeof(str), "factionWeapon%d", j + 1);

		        cache_get_value_name_int(i, str, FactionData[i][factionWeapons][j]);

		        format(str, sizeof(str), "factionAmmo%d", j + 1);

				cache_get_value_name_int(i, str, FactionData[i][factionAmmo][j]);

		        format(str, sizeof(str), "factionDurability%d", j + 1);

				cache_get_value_name_int(i, str, FactionData[i][factionDurability][j]);
			}
			for (new j = 0; j < 15; j ++) 
			{
			    format(str, sizeof(str), "factionRank%d", j + 1);

			    cache_get_value_name(i, str, FactionRanks[i][j], 32);

			    format(str, sizeof(str), "factionSalary%d", j + 1);

			    cache_get_value_name_int(i, str, FactionData[i][factionSalary][j]);
			}
			Faction_Refresh(i);
		}
		printf("[FACTION] Loaded %d faction from database", rows);
	}
	return 1;
}
stock Faction_GetName(playerid)
{
    new
		factionid = PlayerData[playerid][pFaction],
		name[32] = "None";

 	if (factionid == -1)
	    return name;

	format(name, 32, FactionData[factionid][factionName]);
	return name;
}

stock Faction_GetRank(playerid)
{
    new
		factionid = PlayerData[playerid][pFaction],
		rank[32] = "None";

 	if (factionid == -1)
	    return rank;

	format(rank, 32, FactionRanks[factionid][PlayerData[playerid][pFactionRank] - 1]);
	return rank;
}

CMD:setleader(playerid, params[])
{
	static
		userid,
		id;

    if (PlayerData[playerid][pAdmin] < 6)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "ud", userid, id))
	    return SendSyntaxMessage(playerid, "/setleader [playerid/PartOfName] [faction id] (Use -1 to unset)");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "You have specified an invalid player.");

    if ((id < -1 || id >= MAX_FACTIONS) || (id != -1 && !FactionData[id][factionExists]))
	    return SendErrorMessage(playerid, "You have specified an invalid faction ID.");

	if (id == -1)
	{
	    ResetFaction(userid);

	    SendServerMessage(playerid, "You have removed %s's faction leadership.", ReturnName(userid));
    	SendServerMessage(userid, "%s has removed your faction leadership.", PlayerData[playerid][pUCP]);
	}
	else
	{
		SetFaction(userid, id);
		PlayerData[userid][pFactionRank] = FactionData[id][factionRanks];

		SendServerMessage(playerid, "You have made %s the leader of \"%s\".", ReturnName(userid), FactionData[id][factionName]);
    	SendServerMessage(userid, "%s has made you the leader of \"%s\".",PlayerData[playerid][pUCP], FactionData[id][factionName]);
	}
    return 1;
}

CMD:createfaction(playerid, params[])
{
	static
	    id = -1,
		type,
		name[32];

    if (PlayerData[playerid][pAdmin] < 6)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "ds[32]", type, name))
	{
	    SendSyntaxMessage(playerid, "/createfaction [type] [name]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[TYPES]:{FFFFFF} 1: Police | 2: News | 3: Medical | 4: Government | 5: Family");
		return 1;
	}
	if (type < 1 || type > 5)
	    return SendErrorMessage(playerid, "Invalid type specified. Types range from 1 to 5.");

	id = Faction_Create(name, type);

	if (id == -1)
	    return SendErrorMessage(playerid, "The server has reached the limit for factions.");

	SendServerMessage(playerid, "You have successfully created faction ID: %d.", id);
	return 1;
}

CMD:editfaction(playerid, params[])
{
	static
	    id,
	    type[24],
	    string[128];

	if (PlayerData[playerid][pAdmin] < 6)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	SendSyntaxMessage(playerid, "/editfaction [id] [name]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} name, color, type, models, locker, ranks, maxranks, salary");
		return 1;
	}
	if ((id < 0 || id >= MAX_FACTIONS) || !FactionData[id][factionExists])
	    return SendErrorMessage(playerid, "You have specified an invalid faction ID.");

    if (!strcmp(type, "name", true))
	{
	    new name[32];

	    if (sscanf(string, "s[32]", name))
	        return SendSyntaxMessage(playerid, "/editfaction [id] [name] [new name]");

	    format(FactionData[id][factionName], 32, name);

	    Faction_Save(id);
		SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has adjusted the name of faction ID: %d to \"%s\".", PlayerData[playerid][pUCP], id, name);
	}
	else if (!strcmp(type, "maxranks", true))
	{
	    new ranks;

	    if (sscanf(string, "d", ranks))
	        return SendSyntaxMessage(playerid, "/editfaction [id] [maxranks] [maximum ranks]");

		if (ranks < 1 || ranks > 15)
		    return SendErrorMessage(playerid, "The specified ranks can't be below 1 or above 15.");

	    FactionData[id][factionRanks] = ranks;

	    Faction_Save(id);
		SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has adjusted the maximum ranks of faction ID: %d to %d.", PlayerData[playerid][pUCP], id, ranks);
	}
	else if (!strcmp(type, "ranks", true))
	{
	    Faction_ShowRanks(playerid, id);
	}
	else if (!strcmp(type, "color", true))
	{
	    new color;

	    if (sscanf(string, "h", color))
	        return SendSyntaxMessage(playerid, "/editfaction [id] [color] [hex color]");

	    FactionData[id][factionColor] = color;
	    Faction_Update(id);

	    Faction_Save(id);
		SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has adjusted the {%06x}color{FF6347} of faction ID: %d.", PlayerData[playerid][pUCP], color >>> 8, id);
	}
	else if (!strcmp(type, "type", true))
	{
	    new typeint;

	    if (sscanf(string, "d", typeint))
     	{
		 	SendSyntaxMessage(playerid, "/editfaction [id] [type] [faction type]");
            SendClientMessage(playerid, COLOR_YELLOW, "[TYPES]:{FFFFFF} 1: Police | 2: News | 3: Medical | 4: Government | 5: Family");
            return 1;
		}
		if (typeint < 1 || typeint > 5)
		    return SendErrorMessage(playerid, "Invalid type specified. Types range from 1 to 5.");

	    FactionData[id][factionType] = typeint;

	    Faction_Save(id);
		SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has adjusted the type of faction ID: %d to %d.", PlayerData[playerid][pUCP], id, typeint);
	}
	else if (!strcmp(type, "models", true))
	{
	    static
	        skins[8];

		for (new i = 0; i < sizeof(skins); i ++)
		    skins[i] = (FactionData[id][factionSkins][i]) ? (FactionData[id][factionSkins][i]) : (19300);

	    PlayerData[playerid][pFactionEdit] = id;
		ShowModelSelectionMenu(playerid, "Faction Skins", MODEL_SELECTION_FACTION_SKINS, skins, sizeof(skins), -16.0, 0.0, -55.0);
	}
	else if (!strcmp(type, "locker", true))
	{
        PlayerData[playerid][pFactionEdit] = id;
		ShowPlayerDialog(playerid, DIALOG_EDITLOCKER, DIALOG_STYLE_LIST, "Faction Locker", "Set Location\nLocker Weapons", "Select", "Cancel");
	}
	else if(!strcmp(type, "salary", true))
	{
		Faction_ShowSalary(playerid, id);
	}
	return 1;
}

CMD:destroyfaction(playerid, params[])
{
	static
	    id = 0;

    if (PlayerData[playerid][pAdmin] < 6)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "d", id))
	    return SendSyntaxMessage(playerid, "/destroyfaction [faction id]");

	if ((id < 0 || id >= MAX_FACTIONS) || !FactionData[id][factionExists])
	    return SendErrorMessage(playerid, "You have specified an invalid faction ID.");

	Faction_Delete(id);
	SendServerMessage(playerid, "You have successfully destroyed faction ID: %d.", id);
	return 1;
}

CMD:f(playerid, params[])
	return cmd_faction(playerid, params);

CMD:faction(playerid, params[])
{

	new type[24], string[128];
	if (sscanf(params, "s[24]S()[128]", type, string))
		return SendSyntaxMessage(playerid, "/faction [Names]"), SendClientMessage(playerid, COLOR_SERVER, "Names: {FFFFFF}locker, invite, kick, menu, accept, setrank");

	if(!strcmp(type, "locker", true))
	{
		if(PlayerData[playerid][pFaction] == -1)
			return SendErrorMessage(playerid, "You aren't in any faction.");

		new factionid = PlayerData[playerid][pFaction];

	 	if (factionid == -1)
		    return SendErrorMessage(playerid, "You must be a faction member.");

		if (!IsNearFactionLocker(playerid))
		    return SendErrorMessage(playerid, "You are not in range of your faction's locker.");

	 	if (FactionData[factionid][factionType] != FACTION_FAMILY)
			ShowPlayerDialog(playerid, DIALOG_LOCKER, DIALOG_STYLE_LIST, "Faction Locker", "Toggle Duty\nArmored Vest\nLocker Skins\nLocker Weapons", "Select", "Cancel");

		else ShowPlayerDialog(playerid, DIALOG_LOCKER, DIALOG_STYLE_LIST, "Faction Locker", "Locker Weapons\nRespawn Vehicles", "Select", "Cancel");	
	}
	else if(!strcmp(type, "invite", true))
	{

		new
		    userid;

		if (PlayerData[playerid][pFaction] == -1)
		    return SendErrorMessage(playerid, "You must be a faction member.");

		if (PlayerData[playerid][pFactionRank] < FactionData[PlayerData[playerid][pFaction]][factionRanks] - 1)
		    return SendErrorMessage(playerid, "You must be at least rank %d.", FactionData[PlayerData[playerid][pFaction]][factionRanks] - 1);

		if (sscanf(string, "u", userid))
		    return SendSyntaxMessage(playerid, "/faction invite [playerid/PartOfName]");

		if (userid == INVALID_PLAYER_ID)
		    return SendErrorMessage(playerid, "That player is disconnected.");

		if (PlayerData[userid][pFaction] == PlayerData[playerid][pFaction])
		    return SendErrorMessage(playerid, "That player is already part of your faction.");

	    if (PlayerData[userid][pFaction] != -1)
		    return SendErrorMessage(playerid, "That player is already part of another faction.");

		if(!IsPlayerNearPlayer(playerid, userid, 5.0))
			return SendErrorMessage(playerid, "You must close to that player!");

		PlayerData[userid][pFactionOffer] = playerid;
	    PlayerData[userid][pFactionOffered] = PlayerData[playerid][pFaction];

	    SendServerMessage(playerid, "You have requested %s to join \"%s\".", ReturnName(userid), Faction_GetName(playerid));
	    SendServerMessage(userid, "%s has offered you to join \"%s\" (type \"/faction accept\").", ReturnName(playerid), Faction_GetName(playerid));
	}
	else if(!strcmp(type, "accept", true) && PlayerData[playerid][pFactionOffer] != INVALID_PLAYER_ID)
	{
	    new
	        targetid = PlayerData[playerid][pFactionOffer],
	        factionid = PlayerData[playerid][pFactionOffered];

		if (!FactionData[factionid][factionExists] || PlayerData[targetid][pFactionRank] < FactionData[PlayerData[targetid][pFaction]][factionRanks] - 1)
	   	 	return SendErrorMessage(playerid, "The faction offer is no longer available.");

		SetFaction(playerid, factionid);
		PlayerData[playerid][pFactionRank] = 1;

		SendServerMessage(playerid, "You have accepted %s's offer to join \"%s\".", ReturnName(targetid), Faction_GetName(targetid));
		SendServerMessage(targetid, "%s has accepted your offer to join \"%s\".", ReturnName(playerid), Faction_GetName(targetid));

        PlayerData[playerid][pFactionOffer] = INVALID_PLAYER_ID;
        PlayerData[playerid][pFactionOffered] = -1;
	}
	else if(!strcmp(type, "menu", true))
	{
		if(PlayerData[playerid][pFaction] == -1)
			return SendErrorMessage(playerid, "You must be a faction member.");

		ShowPlayerDialog(playerid, DIALOG_FACTION_MENU, DIALOG_STYLE_LIST, "Faction Menu", "Online Member(s)\nTotal Member(s)", "Select", "Close");
	}
	else if(!strcmp(type, "setrank", true))
	{
    	new
		    userid,
			rankid;

		if (PlayerData[playerid][pFaction] == -1)
		    return SendErrorMessage(playerid, "You must be a faction member.");

		if (PlayerData[playerid][pFactionRank] < FactionData[PlayerData[playerid][pFaction]][factionRanks] - 1)
		    return SendErrorMessage(playerid, "You must be at least rank %d.", FactionData[PlayerData[playerid][pFaction]][factionRanks] - 1);

		if (sscanf(string, "ud", userid, rankid))
		    return SendSyntaxMessage(playerid, "/faction setrank [playerid/PartOfName] [rank (1-%d)]", FactionData[PlayerData[playerid][pFaction]][factionRanks]);

		if (userid == INVALID_PLAYER_ID)
		    return SendErrorMessage(playerid, "That player is disconnected.");

		if (PlayerData[userid][pFaction] != PlayerData[playerid][pFaction])
		    return SendErrorMessage(playerid, "That player is not part of your faction.");

		if (rankid < 0 || rankid > FactionData[PlayerData[playerid][pFaction]][factionRanks])
		    return SendErrorMessage(playerid, "Invalid rank specified. Ranks range from 1 to %d.", FactionData[PlayerData[playerid][pFaction]][factionRanks]);

		PlayerData[userid][pFactionRank] = rankid;

	    SendServerMessage(playerid, "You have adjusted %s rank to %s (%d).", ReturnName(userid), Faction_GetRank(userid), rankid);
	    SendServerMessage(userid, "%s has adjusted your rank to %s (%d).", ReturnName(playerid), Faction_GetRank(userid), rankid);
	}
	else if(!strcmp(type, "kick", true))
	{
		new
		    userid;

		if (PlayerData[playerid][pFaction] == -1)
		    return SendErrorMessage(playerid, "You must be a faction member.");

		if (PlayerData[playerid][pFactionRank] < FactionData[PlayerData[playerid][pFaction]][factionRanks] - 1)
		    return SendErrorMessage(playerid, "You must be at least rank %d.", FactionData[PlayerData[playerid][pFaction]][factionRanks] - 1);

		if (sscanf(string, "u", userid))
		    return SendSyntaxMessage(playerid, "/faction kick [playerid/PartOfName]");

		if (userid == INVALID_PLAYER_ID)
		    return SendErrorMessage(playerid, "That player is disconnected.");

		if (PlayerData[userid][pFaction] != PlayerData[playerid][pFaction])
		    return SendErrorMessage(playerid, "That player is not part of your faction.");

		if(!IsPlayerNearPlayer(playerid, userid, 5.0))
			return SendErrorMessage(playerid, "You must close to that player!");

		ResetFaction(userid);
		SendServerMessage(playerid, "You have kicked %s from your faction!", ReturnName(userid));
	}
	return 1;
}