
enum
{
	TYPE_WARN = 1,
	TYPE_JAIL,
	TYPE_BAN
}
stock JailUser(playerid, targetid, minutes, reason[])
{
	PlayerData[targetid][pJailTime] = minutes* 60;
	format(PlayerData[targetid][pJailReason], 32, reason);
	format(PlayerData[targetid][pJailBy], MAX_PLAYER_NAME, PlayerData[playerid][pUCP]);
	SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s has been Jailed by %s for %d minute(s).", GetName(targetid), PlayerData[playerid][pUCP], minutes);
	SendClientMessageToAllEx(COLOR_LIGHTRED, "Reason: %s", reason);
    SetPlayerPos(targetid, 197.6346, 175.3765, 1003.0234);
    SetPlayerInterior(targetid, 3);
    PlayerTextDrawShow(targetid, JAILTD[targetid]);
	SetPlayerVirtualWorld(targetid, (targetid + 100));
	SetCameraBehindPlayer(targetid);
	SaveData(targetid);

	new string [192];
	mysql_format(sqlcon, string, sizeof(string), "INSERT INTO `warnings` (`Owner`, `Type`, `Reason`, `Admin`, `Date`) VALUES('%d', '%d', '%e', '%e', CURRENT_TIMESTAMP())", PlayerData[targetid][pID], TYPE_JAIL, reason, PlayerData[playerid][pUCP]);
	mysql_query(sqlcon, string, false);
	return 1;
}

stock GetTotalWarning(playerid)
{
	new query[128], Cache:result, total = 0;
	mysql_format(sqlcon, query, 128, "SELECT * FROM `warnings` WHERE `Owner` = '%d' AND `Type` = '%d'", PlayerData[playerid][pID], TYPE_WARN);
	result = mysql_query(sqlcon, query, true);
	if(cache_num_rows())
	{
		return total = cache_num_rows();
	}
	cache_delete(result);
	return total;
}

FUNC::OnWarnUser(playerid, targetid, reason[])
{
	SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s has been warned by %s (%d warnings)", GetName(targetid), PlayerData[playerid][pUCP], GetTotalWarning(targetid));
	SendClientMessageToAllEx(COLOR_LIGHTRED, "Reason: %s", reason);
}
stock WarnUser(playerid, targetid, reason[])
{
	new string [192];
	mysql_format(sqlcon, string, sizeof(string), "INSERT INTO `warnings` (`Owner`, `Type`, `Reason`, `Admin`, `Date`) VALUES('%d', '%d', '%e', '%e', CURRENT_TIMESTAMP())", PlayerData[targetid][pID], TYPE_WARN, reason, PlayerData[playerid][pUCP]);
	mysql_tquery(sqlcon, string, "OnWarnUser", "dds", playerid, targetid, reason);
	return 1;
}

stock OfflineWarnUser(playerid, name[], reason[])
{
	new sqlid;
	new string [192];

	mysql_format(sqlcon, string, sizeof(string), "SELECT * FROM `characters` WHERE `Name` = '%e' LIMIT 1", name);
	mysql_query(sqlcon, string, true);
	if(cache_num_rows())
	{
		cache_get_value_name_int(0, "pID", sqlid);
		mysql_format(sqlcon, string, sizeof(string), "INSERT INTO `warnings` (`Owner`, `Type`, `Reason`, `Admin`, `Date`) VALUES('%d', '%d', '%e', '%e', CURRENT_TIMESTAMP())", sqlid, TYPE_WARN, reason, PlayerData[playerid][pUCP]);
		mysql_query(sqlcon, string, false);

		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s has been offline warned by %s", name, PlayerData[playerid][pUCP]);
		SendClientMessageToAllEx(COLOR_LIGHTRED, "Reason: %s", reason);
	}
	else
	{
		SendErrorMessage(playerid, "There is no character with name '%s'!", name);
	}
	return 1;
}

stock ShowPlayerWarning(playerid, targetid)
{

	new const warntype[][] = {
		"None",
		"{00FF00}Warning",
		"{FFFF00}OOC Jail",
		"{FF0000}Banned"
	};
	new query[128], str[1012];
	mysql_format(sqlcon, query, 128, "SELECT * FROM `warnings` WHERE `Owner` = '%d'", PlayerData[playerid][pID]);
	mysql_query(sqlcon, query, true);
	if(cache_num_rows())
	{
		format(str, sizeof(str), "Type\tAdmin\tReason\tDate\n");
		forex(i, cache_num_rows())
		{
			new type, admin[24], reason[32], date[40], id;
			cache_get_value_name_int(i, "ID", id);
			cache_get_value_name_int(i, "Type", type);
			cache_get_value_name(i, "Admin", admin, 24);
			cache_get_value_name(i, "Reason", reason, 32);
			cache_get_value_name(i, "Date", date, 40);
			format(str, sizeof(str), "%s%s {FFFFFF}(%d)\t%s\t%s\t%s\n", str, warntype[type], id, admin, reason, date);
		}
		ShowPlayerDialog(targetid, DIALOG_NONE, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Warning List: %s", GetName(playerid)), str, "Close", "");
	}
	else
	{
		SendErrorMessage(targetid, "That player has no warnings.");
	}
	return 1;
}
CMD:warnings(playerid, params[])
{
	ShowPlayerWarning(playerid, playerid);
	return 1;
}
CMD:owarn(playerid, params[])
{
	new name[24], reason[32];

	if(PlayerData[playerid][pAdmin] < 1)
		return SendErrorMessage(playerid, "You don't have permission to use this command!");

	if(sscanf(params, "s[24]s[32]", name, reason))
		return SendSyntaxMessage(playerid, "/warn [playername] [warning reason]");

	if(!IsRoleplayName(name))
		return SendErrorMessage(playerid, "Invalid specified PlayerName (Use _ as space)");

	if(strlen(reason) > 32)
		return SendErrorMessage(playerid, "Reason is too long.");

	OfflineWarnUser(playerid, name, reason);
	return 1;
}
CMD:warn(playerid, params[])
{
	new targetid, reason[32];

	if(PlayerData[playerid][pAdmin] < 1)
		return SendErrorMessage(playerid, "You don't have permission to use this command!");

	if(sscanf(params, "us[32]", targetid, reason))
		return SendSyntaxMessage(playerid, "/warn [playerid/PartOfName] [warning reason]");

	if(targetid == INVALID_PLAYER_ID)
		return SendErrorMessage(playerid, "You have specified invalid player!");

	if(strlen(reason) > 32)
		return SendErrorMessage(playerid, "Reason is too long.");

	WarnUser(playerid, targetid, reason);
	return 1;
}
CMD:jail(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendErrorMessage(playerid, "You don't have permission to use this command!");

	new
		minutes, targetid, reason[32];
		
	if(sscanf(params, "uds[32]", targetid, minutes, reason))
	    return SendSyntaxMessage(playerid, "/jail [playerid/PartOfName] [time in minute] [reason]");

	if(targetid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Invalid player ID!");

    if (PlayerData[targetid][pAdmin] > PlayerData[playerid][pAdmin])
	    return SendErrorMessage(playerid, "The specified player has higher authority.");

	if(minutes < 1)
	    return SendErrorMessage(playerid, "Invalid specified minute!");
	    
	JailUser(playerid, targetid, minutes, reason);
	return 1;
}

FUNC::OnOfflineJailed(playerid, minute, name[], reason[])
{
	new rows = cache_num_rows(), sqlid;
	if(rows)
	{
		cache_get_value_name_int(0, "pID", sqlid);

		new query[256];
		mysql_format(sqlcon, query,sizeof(query),"UPDATE `characters` SET `JailTime` = '%d', `JailBy` = '%s', `JailReason` = '%s' WHERE `Name` = '%s'", minute, PlayerData[playerid][pUCP], reason, name);
		mysql_query(sqlcon, query, true);	

		new string [192];
		mysql_format(sqlcon, string, sizeof(string), "INSERT INTO `warnings` (`Owner`, `Type`, `Reason`, `Admin`, `Date`) VALUES('%d', '%d', '%e', '%e', CURRENT_TIMESTAMP())", sqlid, TYPE_WARN, reason, PlayerData[playerid][pUCP]);
		mysql_query(sqlcon, string, false);

		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s has been offline jailed by %s for %d minute(s)", name, PlayerData[playerid][pUCP], minute);
		SendClientMessageToAllEx(COLOR_LIGHTRED, "Reason: %s", reason);		
	}
	else
	{
		SendErrorMessage(playerid, "Character with name '%s' is not registered on database!", name);
	}
	return 1;
}


CMD:ojail(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendErrorMessage(playerid, "You don't have permission to use this command.");
	new
		minutes, name[24], reason[32];
		
	if(sscanf(params, "s[24]ds[32]", name, minutes, reason))
	    return SendSyntaxMessage(playerid, "/ojail [character name] [time in minute] [reason]");

	foreach(new i : Player) if(!strcmp(PlayerData[i][pName], name, true))
		return SendErrorMessage(playerid, "That player is online! use /jail");

	new characterQuery[178];
	mysql_format(sqlcon, characterQuery, sizeof(characterQuery), "SELECT * FROM `characters` WHERE `Name` = '%s' LIMIT 1", name);
	mysql_tquery(sqlcon, characterQuery, "OnOfflineJailed", "ddss", playerid, minutes, name, reason);	
	return 1;
}