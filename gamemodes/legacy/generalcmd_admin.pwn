CMD:ahelp(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendErrorMessage(playerid, "You're not an Administrator!");

	if(PlayerData[playerid][pAdmin] >= 1)
	{
		SendClientMessage(playerid, COLOR_YELLOW, "Helper: {FFFFFF}/aduty, /ar, /dr, /a(dmin chat), /sendto, /apm, /reports, /setvw");
		SendClientMessage(playerid, COLOR_YELLOW, "Helper: {FFFFFF}/ans, /ban, /unban, /oban, /kick, /jail, /unjail, /asay, /setinterior");
		SendClientMessage(playerid, COLOR_YELLOW, "Helper: {FFFFFF}/freeze, /unfreeze, /spec, /unspec, /aslap, /ojail, /checkvehicle, /ahide");
		SendClientMessage(playerid, COLOR_YELLOW, "Helper: {FFFFFF}/warn, /owarn, /checkwarn");
	}
	if(PlayerData[playerid][pAdmin] >= 2)
	{
		SendClientMessage(playerid, COLOR_YELLOW, "Senior Helper: {FFFFFF}/checkstats, /goto, /get, /setskin, /mark [set/goto], /destroyveh");
		SendClientMessage(playerid, COLOR_YELLOW, "Senior Helper: {FFFFFF}/findmask, /findnumber");
	}
	if(PlayerData[playerid][pAdmin] >= 3)
	{
		SendClientMessage(playerid, COLOR_YELLOW, "Admin Level 1: {FFFFFF}/getcar, /gotocar, /maxmotive, /afrisk, /arevive, /setweather, /setskin");
	}
	if(PlayerData[playerid][pAdmin] >= 4)
	{
		SendClientMessage(playerid, COLOR_YELLOW, "Admin Level 2: {FFFFFF}/entercar, /sethp, /flipcar, /arevive, /gotoloc, /veh, /fixveh, /respawncar");
		SendClientMessage(playerid, COLOR_YELLOW, "Admin Level 2: {FFFFFF}/gotointerior, /clearitems");
	}
	if(PlayerData[playerid][pAdmin] >= 5)
	{
		SendClientMessage(playerid, COLOR_YELLOW, "Senior Admin: {FFFFFF}/setfuel, /clearreports, /setarmor, /forceinsurance, /setname, /givewep");
	}
	if(PlayerData[playerid][pAdmin] >= 6)
	{
		SendClientMessage(playerid, COLOR_YELLOW, "High Administrator: {FFFFFF}/motd, /amotd, /editdoor, /editplayer, /nextdoor, /setitem, ");
		SendClientMessage(playerid, COLOR_YELLOW, "High Administrator: {FFFFFF}/(create/destroy)atm, /doorname, /createcar, /destroycar, /givesalary");
		SendClientMessage(playerid, COLOR_YELLOW, "High Administrator: {FFFFFF}/(create/destroy)tree. /destroyusername, /destroychar");
		SendClientMessage(playerid, COLOR_YELLOW, "High Administrator: {FFFFFF}/(create/destroy/edit)gate, /(create/destroy/edit/goto)factionveh");
		SendClientMessage(playerid, COLOR_YELLOW, "High Administrator: {FFFFFF}/(create/destroy/edit)actor, /reloadpveh");
	}
	if(PlayerData[playerid][pAdmin] >= 7)
	{
		SendClientMessage(playerid, COLOR_YELLOW, "Management: {FFFFFF}/(create/destroy/edit)faction, /(create/edit)biz, /(create/destroy/edit)house");
		SendClientMessage(playerid, COLOR_YELLOW, "Management: {FFFFFF}/givecash, /setcash, /setadmin, /(/create/edit)rental, /(create/destroy)speed");
		SendClientMessage(playerid, COLOR_YELLOW, "Management: {FFFFFF}/(create/destroy/edit)dealer");
	}
	return 1;
}

CMD:setfuel(playerid, params[])
{
	new
	    id = 0,
		amount;

    if (PlayerData[playerid][pAdmin] < 5)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "dd", id, amount))
 	{
	 	if (IsPlayerInAnyVehicle(playerid))
		{
		    id = GetPlayerVehicleID(playerid);

		    if (sscanf(params, "d", amount))
		        return SendSyntaxMessage(playerid, "/setfuel [amount]");

			if (amount < 0)
			    return SendErrorMessage(playerid, "The amount can't be below 0.");

			VehCore[id][vehFuel] = amount;
			SendServerMessage(playerid, "You have set the fuel of vehicle ID: %d to %d percent.", id, amount);
			return 1;
		}
		else return SendSyntaxMessage(playerid, "/setfuel [vehicle id] [amount]");
	}
	if (!IsValidVehicle(id))
	    return SendErrorMessage(playerid, "You have specified an invalid vehicle ID.");

	if (amount < 0)
 		return SendErrorMessage(playerid, "The amount can't be below 0.");

	VehCore[id][vehFuel] = amount;
	SendServerMessage(playerid, "You have set the fuel of vehicle ID: %d to %d percent.", id, amount);
	return 1;
}

CMD:reloadpveh(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 6)
		return SendErrorMessage(playerid, NO_PERMISSION);

	SetTimer("ReloadPveh", 5000, false);
	SendClientMessageToAllEx(COLOR_LIGHTRED, "VehicleInfo: All player vehicle will be reloaded in 5 seconds!");
	SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has initiating reload player vehicles.", PlayerData[playerid][pUCP]);
	return 1;
}
CMD:ahide(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendErrorMessage(playerid, NO_PERMISSION);	

	PlayerData[playerid][pAhide] = (!PlayerData[playerid][pAhide]);
	SendClientMessageEx(playerid, COLOR_LIGHTRED, "INFO: {FFFFFF}You are now %s {FFFFFF}%s the admin list.", (PlayerData[playerid][pAhide]) ? ("Hidden") : ("Visible"), (PlayerData[playerid][pAhide]) ? ("from") : ("in"));
	return 1;
}
CMD:findnumber(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2)
		return SendErrorMessage(playerid, NO_PERMISSION);

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/findnumber [phone number]");

	if(!IsNumeric(params))
		return SendSyntaxMessage(playerid, "/findnumber [phone number]");

	new query[128];
	mysql_format(sqlcon, query, 128, "SELECT * FROM `characters` WHERE `Number` = '%d' LIMIT 1", strval(params));
	mysql_query(sqlcon, query);
	if(cache_num_rows())
	{
		new name[MAX_PLAYER_NAME], ucp[MAX_PLAYER_NAME];
		cache_get_value_name(0, "Name", name);
		cache_get_value_name(0, "UCP", ucp);

		SendClientMessageEx(playerid, COLOR_LIGHTRED, "NUMINFO: {FFFFFF}Number %d is owned by {FFFF00}%s {FFFFFF}with username {FFFF00}%s", strval(params), name, ucp);
	}
	else
	{
		SendErrorMessage(playerid, "There is no character with number %d", strval(params));
	}
	return 1;
}

CMD:findmask(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2)
		return SendErrorMessage(playerid, NO_PERMISSION);

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/findmask [mask id]");

	if(!IsNumeric(params))
		return SendSyntaxMessage(playerid, "/findmask [mask id]");

	new query[128];
	mysql_format(sqlcon, query, 128, "SELECT * FROM `characters` WHERE `MaskID` = '%d' LIMIT 1", strval(params));
	mysql_query(sqlcon, query);
	if(cache_num_rows())
	{
		new name[MAX_PLAYER_NAME], ucp[MAX_PLAYER_NAME];
		cache_get_value_name(0, "Name", name);
		cache_get_value_name(0, "UCP", ucp);

		SendClientMessageEx(playerid, COLOR_LIGHTRED, "MASKINFO: {FFFFFF}Mask %d is owned by {FFFF00}%s {FFFFFF}with username {FFFF00}%s", strval(params), name, ucp);
	}
	else
	{
		SendErrorMessage(playerid, "There is no character with maskid %d", strval(params));
	}
	return 1;
}
CMD:checkvehicle(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendErrorMessage(playerid, NO_PERMISSION);

	new targetid; 
	if(sscanf(params, "u", targetid))
		return SendSyntaxMessage(playerid, "/checkvehicle [playerid/PartOfName]");

	if(targetid == INVALID_PLAYER_ID)
		return SendErrorMessage(playerid, "You have specified invalid player!");

    new bool:have, str[512];
    format(str, sizeof(str), "Model\tPlate\tInsurance\n");
	foreach(new i : PlayerVehicle)
	{
	    if(Vehicle_IsOwner(targetid, i))
	    {
	        if(VehicleData[i][vInsuTime] != 0)
	        {
	            format(str, sizeof(str), "%s%s(Insurance)\t%s\t%d Left\n", str, GetVehicleModelName(VehicleData[i][vModel]), VehicleData[i][vPlate], VehicleData[i][vInsurance]);
			}
			else if(VehicleData[i][vRental] != -1)
	        {
	            format(str, sizeof(str), "%s%s(Rental)\t%s\tN/A\n", str, GetVehicleModelName(VehicleData[i][vModel]), VehicleData[i][vPlate]);
			}
			else if(VehicleData[i][vHouse] != -1)
	        {
	            format(str, sizeof(str), "%s%s(House Parked)\t%s\t%d Left\n", str, GetVehicleModelName(VehicleData[i][vModel]), VehicleData[i][vPlate], VehicleData[i][vInsurance]);
			}
			else
			{
	            format(str, sizeof(str), "%s%s(ID: %d)\t%s\t%d Left\n", str, GetVehicleModelName(VehicleData[i][vModel]), VehicleData[i][vVehicle], VehicleData[i][vPlate], VehicleData[i][vInsurance]);
			}
		}
		have = true;
	}
	if(have)
	    ShowPlayerDialog(playerid, DIALOG_MV, DIALOG_STYLE_TABLIST_HEADERS, "Vehicle List", str, "Close", "");
	else
		SendErrorMessage(playerid, "That player doesn't have any vehicle");
	return 1;
}
CMD:gotointerior(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
		return SendErrorMessage(playerid, NO_PERMISSION);
		
    new
        str[1536];

	str[0] = '\0';

	for (new i = 0; i < sizeof(g_arrInteriorData); i ++)
	{
	    strcat(str, g_arrInteriorData[i][e_InteriorName]);
	    strcat(str, "\n");
    }
   	ShowPlayerDialog(playerid, DIALOG_INTERIOR, DIALOG_STYLE_LIST, "Teleport: Interior List", str, "Select", "Cancel");
    return 1;
}


CMD:clearitems(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
		return SendErrorMessage(playerid, NO_PERMISSION);

	new targetid;
	if(sscanf(params, "u", targetid))
		return SendSyntaxMessage(playerid, "/clearitems [playerid/PartOfName]");

	if(targetid == INVALID_PLAYER_ID)
		return SendErrorMessage(playerid, "You have specified invalid player!");

	SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has cleared %s's inventory.", PlayerData[playerid][pUCP], ReturnName(targetid));
	Inventory_Clear(targetid);
	return 1;
}

CMD:aslap(playerid, params[])
{
	static
	    userid;

    if (PlayerData[playerid][pAdmin] < 1)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/aslap [playerid/name]");

    if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "You have specified an invalid player.");

	static
	    Float:x,
	    Float:y,
	    Float:z;

	GetPlayerPos(userid, x, y, z);
	SetPlayerPos(userid, x, y, z + 5);

	PlayerPlaySound(userid, 1130, 0.0, 0.0, 0.0);
	SendServerMessage(playerid, "You have slapped %s", ReturnName(userid));
	return 1;
}

CMD:destroyusername(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 6)
		return SendErrorMessage(playerid, NO_PERMISSION);

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/destroyusername [Username]");

	if(!strcmp(params, "vyn", true))
		return SendErrorMessage(playerid, "Cannot destroy this username.");

	new str[257];
	mysql_format(sqlcon, str, sizeof(str), "DELETE FROM `playerucp` WHERE `UCP` = '%s'", params);
	mysql_query(sqlcon, str, true);

	mysql_format(sqlcon, str, sizeof(str), "DELETE FROM `characters` WHERE `UCP` = '%s'", params);
	mysql_query(sqlcon, str, true);

	foreach(new i : Player) if(!strcmp(PlayerData[i][pUCP], params, true))
	{
		SendServerMessage(playerid, "Your Username has been destroyed from the server :(");
		KickEx(i);
	}

	SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has deleted username %s", PlayerData[playerid][pUCP], params);
	return 1;
}


CMD:respawnveh(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
		return SendErrorMessage(playerid, NO_PERMISSION);

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/respawnveh [vehicle id OR stock vehicle]"), SendClientMessage(playerid, COLOR_YELLOW, "stock Vehicle: {FFFFFF}lspd, lses, lsn, sweeper, bus");

	if(IsNumeric(params))
	{
		new vehicleid = strval(params);
		if(vehicleid == INVALID_VEHICLE_ID)
			return SendErrorMessage(playerid, "You have specified invalid vehicle id");

		if(!IsValidVehicle(vehicleid))
			return SendErrorMessage(playerid, "You have specified invalid vehicle id");

		RespawnVehicle(vehicleid);
		SendServerMessage(playerid, "You have respawned vehicle id %d", vehicleid);
	}
	else
	{
		if(!strcmp(params, "lspd", true))
		{
			forex(i, sizeof(LSPDVehicles)) if(GetVehicleDriver(LSPDVehicles[i]) == INVALID_PLAYER_ID)
			{
				SetVehicleToRespawn(LSPDVehicles[i]);
				VehCore[LSPDVehicles[i]][vehFuel] = 100;
			}
			SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: all LSPD faction vehicle has been respawned by %s", PlayerData[playerid][pUCP]);
		}
		else if(!strcmp(params, "bus", true))
		{
			forex(i, sizeof(BusVehicle)) if(GetVehicleDriver(BusVehicle[i]) == INVALID_PLAYER_ID)
			{
				SetVehicleToRespawn(BusVehicle[i]);
				VehCore[BusVehicle[i]][vehFuel] = 100;
			}
			SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: all Bus sidejob vehicle has been respawned by %s", PlayerData[playerid][pUCP]);
		}
		else if(!strcmp(params, "sweeper", true))
		{
			forex(i, sizeof(SweeperVehicle)) if(GetVehicleDriver(SweeperVehicle[i]) == INVALID_PLAYER_ID)
			{
				SetVehicleToRespawn(SweeperVehicle[i]);
				VehCore[SweeperVehicle[i]][vehFuel] = 100;
			}
			SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: all Sweeper sidejob vehicle has been respawned by %s", PlayerData[playerid][pUCP]);
		}
		else if(!strcmp(params, "lsn", true))
		{
			forex(i, sizeof(SanNewsVehicles)) if(GetVehicleDriver(SanNewsVehicles[i]) == INVALID_PLAYER_ID)
			{
				SetVehicleToRespawn(SanNewsVehicles[i]);
				VehCore[SanNewsVehicles[i]][vehFuel] = 100;
			}
			SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: all LSN faction vehicle has been respawned by %s", PlayerData[playerid][pUCP]);
		}
		else if(!strcmp(params, "lses", true))
		{
			forex(i, sizeof(LSMDVehicles)) if(GetVehicleDriver(LSMDVehicles[i]) == INVALID_PLAYER_ID)
			{
				SetVehicleToRespawn(LSMDVehicles[i]);
				VehCore[LSMDVehicles[i]][vehFuel] = 100;
			}
			SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: all LSES faction vehicle has been respawned by %s", PlayerData[playerid][pUCP]);
		}
	}
	return 1;
}

CMD:givesalary(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 6)
		return SendErrorMessage(playerid, NO_PERMISSION);

	new targetid, amount[32];
	if(sscanf(params, "us[32]", targetid, amount))
		return SendSyntaxMessage(playerid, "/givesalary [playerid/PartOfName] [amount]");

	if(targetid == INVALID_PLAYER_ID)
		return SendErrorMessage(playerid, "Invalid player specified!");

	if(targetid == playerid && PlayerData[playerid][pAdmin] < 7)
		return SendErrorMessage(playerid, "You can't give to yourself!");

	if(strcash(amount) < 1)
		return SendErrorMessage(playerid, "Invalid amount!");

	AddSalary(targetid, "From server", strcash(amount));
	SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has given $%s salary to %s", PlayerData[playerid][pUCP], FormatNumber(strcash(amount)), GetName(targetid));
	return 1;
}
CMD:setname(playerid, params[])
{
	static
	    userid,
	    newname[24],
		query[128];

    if (PlayerData[playerid][pAdmin] < 5)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "us[24]", userid, newname))
	    return SendSyntaxMessage(playerid, "/setname [playerid/PartOfName] [new name]");

	if (userid == INVALID_PLAYER_ID)
		return SendErrorMessage(playerid, "You have specified an invalid player.");

	if (!IsRoleplayName(newname))
	    return SendErrorMessage(playerid, "You have specified an invalid name format.");

	foreach (new i : Player) if (!strcmp(ReturnName(i), newname))
	{
	    return SendErrorMessage(playerid, "The specified name is in use.");
	}
	mysql_format(sqlcon, query,sizeof(query),"UPDATE `characters` SET `Name` = '%s' WHERE `Name` = '%s'", newname, PlayerData[userid][pName]);
	mysql_query(sqlcon, query, true);
	mysql_format(sqlcon, query, sizeof(query), "UPDATE `toys` SET `Owner` = '%s' WHERE `Owner` = '%s'", newname, PlayerData[userid][pName]);
	mysql_query(sqlcon, query, true);
	SendServerMessage(userid, "Your name has been changed to %s", newname);
	SendServerMessage(playerid, "You've been changed %s name to %s", GetName(userid), newname);
	SetPlayerName(userid, newname);
	format(PlayerData[userid][pName], MAX_PLAYER_NAME, newname);
	return 1;
}

CMD:fixveh(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);

	if (PlayerData[playerid][pAdmin] < 4)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (vehicleid > 0 && isnull(params))
	{
		RepairVehicle(vehicleid);
		SendServerMessage(playerid, "You have repaired your current vehicle.");
	}
	else
	{
		if (sscanf(params, "d", vehicleid))
	    	return SendSyntaxMessage(playerid, "/arepair [vehicle ID]");

		else if (!IsValidVehicle(vehicleid))
	    	return SendErrorMessage(playerid, "You have specified an invalid vehicle ID.");

		RepairVehicle(vehicleid);
		SendServerMessage(playerid, "You have repaired vehicle ID: %d.", vehicleid);
	}
	return 1;
}

CMD:givewep(playerid, params[])
{
	new
	    userid,
	    weaponid,
	    ammo;

    if (PlayerData[playerid][pAdmin] < 5)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "udI(100)", userid, weaponid, ammo))
	    return SendSyntaxMessage(playerid, "/givewep [playerid/PartOfName] [weaponid] [ammo]");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "You cannot give weapons to disconnected players.");

	if (weaponid <= 0 || weaponid > 46 || (weaponid >= 19 && weaponid <= 21))
		return SendErrorMessage(playerid, "You have specified an invalid weapon.");
	    
	GiveWeaponToPlayer(userid, weaponid, ammo, 500);
	SendServerMessage(playerid, "You have gave %s weapon id %d with %d ammo.", ReturnName(userid), weaponid, ammo);
	return 1;
}

CMD:spec(playerid, params[])
{
	new userid;

	if (PlayerData[playerid][pAdmin] < 1)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "u", userid))
		return SendSyntaxMessage(playerid, "/spec(tate) [playerid/PartOfName] - Type \"/unspec\" to stop spectating.");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "You have specified an invalid player.");

	    
	if (GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
	{
		GetPlayerPos(playerid, PlayerData[playerid][sPos][0], PlayerData[playerid][sPos][1], PlayerData[playerid][sPos][2]);

		PlayerData[playerid][pInterior] = GetPlayerInterior(playerid);
		PlayerData[playerid][pWorld] = GetPlayerVirtualWorld(playerid);
	}
	SetPlayerInterior(playerid, GetPlayerInterior(userid));
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(userid));

	TogglePlayerSpectating(playerid, 1);

	if (IsPlayerInAnyVehicle(userid))
	    PlayerSpectateVehicle(playerid, GetPlayerVehicleID(userid));

	else
		PlayerSpectatePlayer(playerid, userid);

	SendServerMessage(playerid, "You are now spectating %s (ID: %d).", GetName(userid), userid);
	PlayerData[playerid][pSpectator] = userid;

	return 1;
}

CMD:gotoco(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] >= 2)
	{
		new Float: pos[3], int;
		if(sscanf(params, "fffd", pos[0], pos[1], pos[2], int))
			return SendSyntaxMessage(playerid, "USAGE: /gotoco [x coordinate] [y coordinate] [z coordinate] [interior]");

		SendClientMessage(playerid, COLOR_WHITE, "You have been teleported to the coordinates specified.");
		SetPlayerPos(playerid, pos[0], pos[1], pos[2]);
		SetPlayerInterior(playerid, int);
	}
	return 1;
}

CMD:veh(playerid, params[])
{
	new
	    model[32],
		color1,
		color2;

	if(PlayerData[playerid][pAdmin] < 4)
		return SendErrorMessage(playerid, NO_PERMISSION);

	if (sscanf(params, "s[32]I(-1)I(-1)", model, color1, color2))
	    return SendSyntaxMessage(playerid, "/veh [model id/name] <color 1> <color 2>");

	if ((model[0] = GetVehicleModelByName(model)) == 0)
	    return SendErrorMessage(playerid, "Invalid model ID.");

	new
	    Float:x,
	    Float:y,
	    Float:z,
	    Float:a,
		vehicleid;

	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, a);

	vehicleid = CreateVehicle(model[0], x, y + 2, z, a, color1, color2, 0);

	if (GetPlayerInterior(playerid) != 0)
	    LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));

	if (GetPlayerVirtualWorld(playerid) != 0)
		SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));

	PutPlayerInVehicle(playerid, vehicleid, 0);
	SwitchVehicleEngine(vehicleid, true);
	VehCore[vehicleid][vehFuel] = 100;
	VehCore[vehicleid][vehAdmin] = true;
	SendServerMessage(playerid, "You have spawned a %s.", ReturnVehicleModelName(model[0]));
	return 1;
}

CMD:unspec(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 1)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");
	    
    if (GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
		return SendErrorMessage(playerid, "You are not spectating any player.");

    PlayerSpectatePlayer(playerid, INVALID_PLAYER_ID);
    PlayerSpectateVehicle(playerid, INVALID_VEHICLE_ID);

    SetSpawnInfo(playerid, 0, PlayerData[playerid][pSkin], PlayerData[playerid][sPos][0], PlayerData[playerid][sPos][1], PlayerData[playerid][sPos][2], 0, 0, 0, 0, 0, 0, 0);
    TogglePlayerSpectating(playerid, false);
	SetPlayerVirtualWorld(playerid, PlayerData[playerid][pWorld]);
	SetPlayerInterior(playerid, PlayerData[playerid][pInterior]);
    SendServerMessage(playerid, "You are no longer in spectator mode.");
    SetValidColor(playerid);
    if(PlayerData[playerid][pAduty])
    {
		SetPlayerColor(playerid, COLOR_RED);
	}
    return 1;
}

CMD:editplayer(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 6)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	new
	    userid,
	    type[16],
	    amount[32],
	    val[32];

	if (sscanf(params, "us[16]S()[32]", userid, type, amount))
 	{
	 	SendSyntaxMessage(playerid, "/editplayer [playerid/PartOfName] [name]");
	 	SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} gender, bank, origin, level, birthdate");
		return 1;
	}
	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "You have specified an invalid player.");

	if (!strcmp(type, "gender", true))
	{
	    if (isnull(amount) || strval(amount) < 1 || strval(amount) > 2)
	        return SendSyntaxMessage(playerid, "/editplayer [playerid/PartOfName] [gender] [1: male - 2: female]");

		PlayerData[userid][pGender] = strval(amount);

		if (PlayerData[userid][pGender] == 1)
			SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s have set %s's gender to male.", PlayerData[playerid][pUCP], GetName(userid));

		else if (PlayerData[userid][pGender] == 2)
			SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s have set %s's gender to female.", PlayerData[playerid][pUCP], GetName(userid));
	}
	else if (!strcmp(type, "birthdate", true))
	{
	    if (isnull(amount) || strlen(amount) > 24)
	        return SendSyntaxMessage(playerid, "/editplayer [playerid/PartOfName] [birthdate] [new birthdate]");

		format(PlayerData[userid][pBirthdate], 24, amount);
		SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s have set %s's birthdate to \"%s\".", PlayerData[playerid][pUCP], ReturnName(userid), amount);
	}
	else if (!strcmp(type, "origin", true))
	{
	    if (isnull(amount) || strlen(amount) > 32)
	        return SendSyntaxMessage(playerid, "/editplayer [playerid/PartOfName] [origin] [new origin]");

		format(PlayerData[userid][pOrigin], 32, amount);
		SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s have set %s's origin to \"%s\".", PlayerData[playerid][pUCP], ReturnName(userid), amount);
	}
	else if (!strcmp(type, "bank", true))
	{
		if (PlayerData[playerid][pAdmin] < 7)
		    return SendErrorMessage(playerid, "This option only for Management.");
		    
	    if (sscanf(amount, "s[32]", val))
	        return SendSyntaxMessage(playerid, "/editplayer [playerid/PartOfName] [bank] [bank funds]");

		PlayerData[userid][pBank] = strcash(val);
		SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s have set %s's bank money to $%s.", PlayerData[playerid][pUCP], ReturnName(userid), FormatNumber(strcash(val)));
	}
	else if (!strcmp(type, "level", true))
	{
	    if (isnull(amount))
	        return SendSyntaxMessage(playerid, "/editplayer [playerid/PartOfName] [level] [amount]");

		PlayerData[userid][pLevel] = strval(amount);
		SetPlayerScore(userid, PlayerData[userid][pLevel]);
		SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s have set %s's level to %d.", PlayerData[playerid][pUCP], ReturnName(userid), strval(amount));
	}
	return 1;
}


CMD:destroycar(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 6)
		return SendErrorMessage(playerid, "You don't have authorized to use this command!");

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/destroycar [vehicle id]");

	if(strval(params) == INVALID_VEHICLE_ID)
		return SendErrorMessage(playerid, "You have specified invalid vehicle id");

	if(Vehicle_GetID(strval(params)) != -1)
	{

		SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has destroyed player vehicle with Database ID: %d", PlayerData[playerid][pUCP], VehicleData[Vehicle_GetID(strval(params))][vID]);

		Vehicle_Delete(Vehicle_GetID(strval(params)));
	}
	else
		SendErrorMessage(playerid, "Invalid player vehicle!");
	
	return 1;
}
CMD:createcar(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 6)
		return SendErrorMessage(playerid, "You don't have authorized to use this command!");

    new
        model[32],
        color1,
        color2,
        otherid;

    if (sscanf(params, "ds[32]I(-1)I(-1)", otherid, model, color1, color2))
        return SendSyntaxMessage(playerid, "/createcar [playerid/PartOfName] [model id/name] <color 1> <color 2>");
		
	if(otherid == INVALID_PLAYER_ID)
		return SendErrorMessage(playerid, "Invalid player ID!");

    if ((model[0] = GetVehicleModelByName(model)) == 0)
        return SendErrorMessage(playerid, "Invalid model ID.");
		
	new Float:pos[4];
	GetPlayerPos(otherid, pos[0], pos[1], pos[2]);
	GetPlayerFacingAngle(otherid, pos[3]);
    Vehicle_Create(PlayerData[otherid][pID], model[0], pos[0], pos[1], pos[2], pos[3], color1, color2);
    SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has created %s for %s", PlayerData[playerid][pUCP], ReturnVehicleModelName(model[0]), GetName(otherid));
	return 1;
}

CMD:togooc(playerid, paramas[])
{
	if(PlayerData[playerid][pAdmin] < 4)
	    return SendErrorMessage(playerid, NO_PERMISSION);
	    
	if(!ToggleData[togOOC])
	{
	    ToggleData[togOOC] = true;
	    SendClientMessageToAllEx(COLOR_SERVER, "TOGGLE: {FFFFFF}%s has disabled global ooc chat.", PlayerData[playerid][pUCP]);
	}
	else
	{
		ToggleData[togOOC] = false;
		SendClientMessageToAllEx(COLOR_SERVER, "TOGGLE: {FFFFFF}%s has enabled global ooc chat.", PlayerData[playerid][pUCP]);
	}
	return 1;
}


CMD:setinterior(playerid, params[])
{
	static
		userid,
	    interior;

	if (PlayerData[playerid][pAdmin] < 1)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "ud", userid, interior))
		return SendSyntaxMessage(playerid, "/setinterior [playerid/PartOfName] [interior]");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "You have specified an invalid player.");

	SetPlayerInterior(userid, interior);
	PlayerData[userid][pInterior] = interior;

	SendServerMessage(playerid, "You have set %s's interior to %d.", ReturnName(userid), interior);
	return 1;
}

CMD:setvw(playerid, params[])
{
	static
		userid,
	    world;

	if (PlayerData[playerid][pAdmin] < 1)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "ud", userid, world))
		return SendSyntaxMessage(playerid, "/setvw [playerid/PartOfName] [world]");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "You have specified an invalid player.");

	SetPlayerVirtualWorld(userid, world);
	PlayerData[userid][pWorld] = world;

	SendServerMessage(playerid, "You have set %s's virtual world to %d.", ReturnName(userid), world);
	return 1;
}

CMD:freeze(playerid, params[])
{
	static
	    userid;

    if (PlayerData[playerid][pAdmin] < 1)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/freeze [playerid/PartOfName]");

    if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "You have specified an invalid player.");

	TogglePlayerControllable(userid, 0);
	SendServerMessage(playerid, "You have frozen %s's movements.", ReturnName(userid));
	return 1;
}

CMD:unfreeze(playerid, params[])
{
	static
	    userid;

    if (PlayerData[playerid][pAdmin] < 1)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/unfreeze [playerid/PartOfName]");

    if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "You have specified an invalid player.");


	TogglePlayerControllable(userid, 1);
	SendServerMessage(playerid, "You have unfrozen %s's movements.", ReturnName(userid));
	return 1;
}

CMD:gotoloc(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 4)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");	

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/gotoloc [house/biz/dealer/door]");

	new str[512];
	if(!strcmp(params, "house", true))
	{
		format(str, sizeof(str), "ID\tLocation\n");
		foreach(new i : House)
		{
			format(str, sizeof(str), "%s%d\t%s\n", str, i, GetLocation(HouseData[i][housePos][0], HouseData[i][housePos][1], HouseData[i][housePos][2]));
		}
		ShowPlayerDialog(playerid, DIALOG_GOTOLOC_HOUSE, DIALOG_STYLE_TABLIST_HEADERS, "Teleport to House", str, "Teleport", "Close");
	}
	else if(!strcmp(params, "biz", true))
	{
		format(str, sizeof(str), "ID\tType\tName\n");
		forex(i, MAX_BUSINESS) if(BizData[i][bizExists])
		{
			format(str, sizeof(str), "%s%d\t%s\t%s{FFFFFF}\n", str, i, GetBizType(BizData[i][bizType]), BizData[i][bizName]);
		}
		ShowPlayerDialog(playerid, DIALOG_GOTOLOC_BUSINESS, DIALOG_STYLE_TABLIST_HEADERS, "Teleport to Business", str, "Teleport", "Close");
	}
	else if(!strcmp(params, "dealer", true))
	{
		format(str, sizeof(str), "ID\tName\n");
		forex(i, MAX_DEALER) if(DealerData[i][dealerExists])
		{
			format(str, sizeof(str), "%s%d\t%s{FFFFFF}\n", str, i, DealerData[i][dealerName]);
		}
		ShowPlayerDialog(playerid, DIALOG_GOTOLOC_DEALER, DIALOG_STYLE_TABLIST_HEADERS, "Teleport to Dealership", str, "Teleport", "Close");
	}
	else if(!strcmp(params, "door", true))
	{
		format(str, sizeof(str), "ID\tName\n");
		forex(i, MAX_DDOORS) if(DoorData[i][ddExteriorX] != 0)
		{
			format(str, sizeof(str), "%s%d\t%s\n", str, i, DoorData[i][ddDescription]);
		}
		ShowPlayerDialog(playerid, DIALOG_GOTOLOC_DOOR, DIALOG_STYLE_TABLIST_HEADERS, "Teleport to Door", str, "Teleport", "Close");
	}
	return 1;
}
CMD:destroyveh(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 2)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");
	    
	new vehicleid = GetPlayerVehicleID(playerid);
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendErrorMessage(playerid, "You must be inside temporary vehicle!");
		
	if(!VehCore[vehicleid][vehAdmin])
	    return SendErrorMessage(playerid, "You only can destroy temporary vehicle!");
	    
	VehCore[vehicleid][vehAdmin] = false;
	SendServerMessage(playerid, "You've destroyed temporary vehicle ID: %d", vehicleid);
	DestroyVehicle(vehicleid);
	return 1;
}

CMD:entercar(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
		return SendErrorMessage(playerid, NO_PERMISSION);

	new vid = strval(params);
	if(isnull(params))
		return SendSyntaxMessage(playerid, "/entercar [vehicle id]");

	if(!IsNumeric(params))
		return SendErrorMessage(playerid, "Invalid vehicle id!");

	if(vid == INVALID_VEHICLE_ID)
		return SendErrorMessage(playerid, "Invalid vehicle id!");

	SendServerMessage(playerid, "You have entered vehicle id %d", vid);
	PutPlayerInVehicle(playerid, vid, 0);
	return 1;
}

CMD:afrisk(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 3)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");
	    
	new targetid;
	if(sscanf(params, "u", targetid))
	    return SendSyntaxMessage(playerid, "/afrisk [playerid/PartOfName]");
	    
	if(targetid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "You've specified an invalid player ID!");
	    
	ShowInventory(playerid, targetid);
	return 1;
}

CMD:gotocar(playerid, params[])
{
	new vehicleid;

    if (PlayerData[playerid][pAdmin] < 3)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "d", vehicleid))
	    return SendSyntaxMessage(playerid, "/gotocar [veh]");

	if (vehicleid < 1 || vehicleid > MAX_VEHICLES || !IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "You have specified an invalid vehicle ID.");

	static
	    Float:x,
	    Float:y,
	    Float:z;

	GetVehiclePos(vehicleid, x, y, z);
	SetPlayerPos(playerid, x, y - 2, z + 2);
	return 1;
}

CMD:getcar(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 3)
	    return SendErrorMessage(playerid, NO_PERMISSION);
	    
	new vehicleid;
	if(sscanf(params, "d", vehicleid))
	    return SendSyntaxMessage(playerid, "/getcar [vehicle id]");
	    
	if(vehicleid == INVALID_VEHICLE_ID)
		return SendErrorMessage(playerid, "Invalid specified Vehicle id!");

	new Float:Pos[3];
	GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
	SetVehiclePos(vehicleid, Pos[0], Pos[1], Pos[2]);
	SetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]+1.5);
	LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));
	SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));
	return 1;
}


CMD:checkstats(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2)
	    return SendErrorMessage(playerid, NO_PERMISSION);

	new targetid;
	if(sscanf(params, "u", targetid))
		return SendSyntaxMessage(playerid, "/checkstats [playerid/PartOfName]");

	if(targetid == INVALID_PLAYER_ID)
		return SendErrorMessage(playerid, "Invalid player specified!");

	ShowStats(targetid, playerid);
	return 1;
}
CMD:mark(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2)
	    return SendErrorMessage(playerid, NO_PERMISSION);

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/mark [set/goto]");

	if(!strcmp(params, "set", true))
	{
		SendClientMessageEx(playerid, COLOR_LIGHTRED, "MARK: {FFFFFF}Mark successfully {FFFF00}Activated{FFFFFF} use {FFFF00}/mark goto {FFFFFF}to teleport");
		GetPlayerPos(playerid, PlayerData[playerid][pMark][0], PlayerData[playerid][pMark][1], PlayerData[playerid][pMark][2]);
		PlayerData[playerid][pMarkWorld] = GetPlayerVirtualWorld(playerid);
		PlayerData[playerid][pMarkInterior] = GetPlayerInterior(playerid);
		PlayerData[playerid][pMarkActive] = true;
	}
	else if(!strcmp(params, "goto", true))
	{
		if(!PlayerData[playerid][pMarkActive])
			return SendErrorMessage(playerid, "Kamu belum mengaktifkan Mark!");

		SetPlayerPos(playerid, PlayerData[playerid][pMark][0], PlayerData[playerid][pMark][1], PlayerData[playerid][pMark][2]);
		SetPlayerInterior(playerid, PlayerData[playerid][pMarkInterior]);
		SetPlayerVirtualWorld(playerid, PlayerData[playerid][pMarkWorld]);
	}
	return 1;
}
CMD:setadmin(playerid, params[])
{
	new rank, targetid, query[256];
	if(PlayerData[playerid][pAdmin] < 7)
	    return SendErrorMessage(playerid, NO_PERMISSION);
	    
	if(sscanf(params, "ud", targetid, rank))
	    return SendSyntaxMessage(playerid, "/setadmin [playerid/PartOfName] [rank]");
	    
	if(targetid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "You've specified an invalid player!");
	    
	UcpData[targetid][ucpAdmin] = rank;
	PlayerData[targetid][pAdmin] = UcpData[targetid][ucpAdmin];
	SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has adjusted %s admin level to %d", PlayerData[playerid][pUCP], GetName(targetid), rank);
	SendServerMessage(targetid, "Your admin level has been adjusted by %s to %d", PlayerData[playerid][pUCP], rank);
	mysql_format(sqlcon,query,sizeof(query),"UPDATE `playerucp` SET `Admin` = '%d' WHERE `UCP` = '%s'", rank, PlayerData[targetid][pUCP]);
	mysql_query(sqlcon,query,true);
	return 1;
}

CMD:unjail(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendErrorMessage(playerid, NO_PERMISSION);

	new targetid;
	if(sscanf(params, "u", targetid))
	    return SendSyntaxMessage(playerid, "/unjail [playerid/PartOfName]");

	if(targetid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Invalid player ID!");

	if(PlayerData[targetid][pJailTime] < 1)
	    return SendErrorMessage(playerid, "That player is not jailed!");

	if(PlayerData[targetid][pArrest])
	    return SendErrorMessage(playerid, "You can't release Prisoned Player! (IC Jail)");

	PlayerData[targetid][pJailTime] = 0;
	PlayerTextDrawHide(targetid, JAILTD[targetid]);
	SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s has been released from admin jail by %s", GetName(targetid), PlayerData[playerid][pUCP]);
	SetPlayerPos(targetid, 1543.8755,-1675.7900,13.5573);
	SetPlayerInterior(targetid, 0);
	SetPlayerVirtualWorld(targetid, 0);
	return 1;
}

CMD:setskin(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2)
		return SendErrorMessage(playerid, NO_PERMISSION);

	new skinid, userid;
	if (sscanf(params, "ud", userid, skinid))
	    return SendSyntaxMessage(playerid, "/setskin [playerid/PartOfName] [skin id]");

    if (userid == INVALID_PLAYER_ID)
	 return SendErrorMessage(playerid, "You have specified an invalid player.");

	if (skinid < 0 || skinid > 311)
	    return SendErrorMessage(playerid, "Invalid skin ID. Skins range from 0 to 311.");

	UpdatePlayerSkin(userid, skinid);
	return 1;
}
CMD:arevive(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 3)
	    return SendErrorMessage(playerid, NO_PERMISSION);
	    
	new targetid;
	if(sscanf(params, "u", targetid))
	    return SendSyntaxMessage(playerid, "/arevive [playerid]");

	if(targetid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Invalid Player ID!");
	    
	if(!PlayerData[targetid][pInjured])
	    return SendErrorMessage(playerid, "That player is not injured!");
	    
	PlayerData[targetid][pInjured] = false;
	PlayerData[targetid][pDead] = false;
	PlayerData[targetid][pInjuredTime] = 0;
	ClearAnimations(targetid, 1);
	SendServerMessage(playerid, "You've healing %s", GetName(targetid));

	if(IsValidDynamic3DTextLabel(PlayerData[targetid][pInjuredLabel]))
		DestroyDynamic3DTextLabel(PlayerData[targetid][pInjuredLabel]);
	return 1;
}

CMD:goto(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");
	    
	new targetid;
	if(sscanf(params, "u", targetid))
	    return SendSyntaxMessage(playerid, "/goto [playerid]");
	    
	if(targetid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Invalid player ID!");
	    
	if(!PlayerData[targetid][pSpawned])
	    return SendErrorMessage(playerid, "That player is not spawned.");
	    
	SendPlayerToPlayer(playerid, targetid);
	return 1;
}
CMD:get(playerid, params[])
{
	static
	    userid;

	if (PlayerData[playerid][pAdmin] < 2)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/get [playerid/PartOfName]");

    if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "You have specified an invalid player.");

	if (!PlayerData[playerid][pSpawned])
		return SendErrorMessage(playerid, "You can't teleport a player that's not spawned.");

	SendPlayerToPlayer(userid, playerid);
	SendServerMessage(playerid, "You have teleported %s to you.", ReturnName(userid));
	return 1;
}

CMD:nextdoor(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 6)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");
	    
	for(new x;x<MAX_DDOORS;x++)
	{
	    if(DoorData[x][ddExteriorX] == 0)
	    {
	        SendClientMessageEx(playerid, COLOR_SERVER, "DOOR: {FFFFFF}ID %d is available to use.", x);
	        break;
		}
	}
	return 1;
}

CMD:unban(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendErrorMessage(playerid, "You don't have permission to use this command.");

	new name[MAX_PLAYER_NAME];
	if(sscanf(params, "s[24]", name))
		return SendSyntaxMessage(playerid, "/unban [UCP name]");

	new characterQuery[178];
	mysql_format(sqlcon, characterQuery, sizeof(characterQuery), "SELECT * FROM `playerucp` WHERE `UCP` = '%s' LIMIT 1", name);
	mysql_tquery(sqlcon, characterQuery, "OnUCPUnban", "ds", playerid, name);
	return 1;	
}

CMD:oban(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendErrorMessage(playerid, "You don't have permission to use this command.");

	new name[MAX_PLAYER_NAME], reason[32];
	if(sscanf(params, "s[24]s[32]", name, reason))
		return SendSyntaxMessage(playerid, "/obanucp [UCP name] [Reason]");

	new characterQuery[178];
	mysql_format(sqlcon, characterQuery, sizeof(characterQuery), "SELECT * FROM `playerucp` WHERE `UCP` = '%s' LIMIT 1", name);
	mysql_tquery(sqlcon, characterQuery, "OnUCPBanned", "dss", playerid, name, reason);
	return 1;
}

CMD:ban(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendErrorMessage(playerid, "You don't have permission to use this command.");

	new targetid, reason[32];
	if(sscanf(params, "ds[32]", targetid, reason))
		return SendSyntaxMessage(playerid, "/ban [playerid/PartOfName] [reason]");

	if(targetid == INVALID_PLAYER_ID)
		return SendErrorMessage(playerid, "You have specified an invalid player id!");

	SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: Account %s has been banned by %s", PlayerData[targetid][pUCP], PlayerData[playerid][pUCP]);
	SendClientMessageToAllEx(COLOR_LIGHTRED, "Reason: %s", reason);

	new temptime = gettime();
	new date[6];

	TimestampToDate(temptime, date[2], date[1], date[0], date[3], date[4], date[5]);

	new query[256];
	mysql_format(sqlcon, query,sizeof(query),"UPDATE `playerucp` SET `Banned` = 1, `BannedBy` = '%s', `BannedReason` = '%s', `BannedTime` = '%d' WHERE `UCP` = '%s'", PlayerData[playerid][pUCP], reason, temptime,PlayerData[targetid][pUCP]);
	mysql_query(sqlcon, query, true);	

	new zstr[325];
	format(zstr, sizeof(zstr),"{FFFFFF}Your UCP has been Banned from this server\n{FF0000}Reason: {FFFFFF}%s\n{FF0000}Banned By: {FFFFFF}%s\n{FF0000}Banned Date: {FFFFFF}%i/%02d/%02d %02d:%02d\n{FFFFFF}For Unbanned please visit our discord at {FF0000}https://discord.gg/WQKYCW8pzQ", reason, PlayerData[playerid][pUCP], date[2], date[0], date[1], date[3], date[4]);
	ShowPlayerDialog(playerid, DIALOG_NONE, DIALOG_STYLE_MSGBOX, "{FFFFFF}Banned Alert - UCP Ban", zstr, "Close", "");	

	KickEx(targetid);
	return 1;
}
CMD:asay(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if(isnull(params))
	    return SendSyntaxMessage(playerid, "/asay [text]");
	    
	SendClientMessageToAllEx(COLOR_LIGHTRED, "%s %s: %s", GetAdminRank(playerid), PlayerData[playerid][pUCP], params);
	return 1;
}
CMD:ans(playerid, params[])
{
	new
	    userid,
	    text[128];

    if (PlayerData[playerid][pAdmin] < 1)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "us[128]", userid, text))
		return SendSyntaxMessage(playerid, "/ans [playerid/PartOfName] [answer]");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "You have specified an invalid player.");

	if(!PlayerData[userid][pAsking])
	    return SendErrorMessage(playerid, "That player is not asking.");
	    
	SendClientMessageEx(userid, COLOR_SERVER, "ANSWER: {FFFFFF}%s", text);
	SendAdminMessage(COLOR_LIGHTRED, "%s Answer To %s: %s", PlayerData[playerid][pUCP], GetName(userid), text);
	PlayerData[userid][pAsking] = false;
	return 1;
}

CMD:apm(playerid, params[])
{
	static
	    userid,
	    text[128];

    if (PlayerData[playerid][pAdmin] < 1)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "us[128]", userid, text))
		return SendSyntaxMessage(playerid, "/apm [playerid/PartOfName] [message]");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "You have specified an invalid player.");

	SendClientMessageEx(userid, COLOR_LIGHTRED, "PM From Admin: {FFFFFF}%s", text);
	SendAdminMessage(COLOR_LIGHTRED, "%s APM To %s: %s", PlayerData[playerid][pUCP], GetName(userid), text);
	PlayerPlaySound(userid, 1085, 0.0, 0.0, 0.0);
	return 1;
}

CMD:sendto(playerid, params[])
{
	static
	    userid,
	    targetid;

    if (PlayerData[playerid][pAdmin] < 1)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "uu", userid, targetid))
	    return SendSyntaxMessage(playerid, "/sendto [playerid/PartOfName] [playerid/PartOfName]");

	if (userid == INVALID_PLAYER_ID || targetid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "The specified user(s) are not connected.");

	SendPlayerToPlayer(userid, targetid);

	SendServerMessage(playerid, "You have teleported %s to %s.", ReturnName(userid), ReturnName(targetid));
	SendServerMessage(userid, "%s has teleported you to %s.", PlayerData[playerid][pUCP], ReturnName(targetid));
	return 1;
}

CMD:a(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");
	    
	if(isnull(params))
	    return SendSyntaxMessage(playerid, "/a [admin chat]");
	    
	SendAdminMessage(COLOR_GREEN, "%s {FFFF00}%s: {FFFFFF}%s", GetAdminRank(playerid), PlayerData[playerid][pUCP], params);
	return 1;
}

CMD:flipcar(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);

	if (PlayerData[playerid][pAdmin] < 4)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (vehicleid > 0 && isnull(params))
	{
		FlipVehicle(vehicleid);
		SendServerMessage(playerid, "You have flipped your current vehicle.");
	}
	else
	{
		if (sscanf(params, "d", vehicleid))
	    	return SendSyntaxMessage(playerid, "/flipcar [vehicle ID]");

		else if (!IsValidVehicle(vehicleid))
	    	return SendErrorMessage(playerid, "You have specified an invalid vehicle ID.");

		FlipVehicle(vehicleid);
		SendServerMessage(playerid, "You have flipped vehicle ID: %d.", vehicleid);
	}
	return 1;
}

CMD:setweather(playerid, params[])
{
	new weatherid;

	if (PlayerData[playerid][pAdmin] < 3)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "d", weatherid))
	    return SendSyntaxMessage(playerid, "/setweather [weather ID]");

	SetWeather(weatherid);
	SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: {FFFFFF}%s has adjusted weather to weatherid %d", PlayerData[playerid][pUCP], weatherid);
	return 1;
}

CMD:maxmotive(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 3)
		return SendErrorMessage(playerid, "You don't have permission to use this command!");

	if(!PlayerData[playerid][pAduty])
		return SendErrorMessage(playerid, "You must be admin duty!");

	PlayerData[playerid][pHunger] = 100;
	PlayerData[playerid][pThirst] = 100;
	return 1;
}
CMD:setarmor(playerid, params[])
{
	static
		userid,
	    Float:amount;

	if (PlayerData[playerid][pAdmin] < 5)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "uf", userid, amount))
		return SendSyntaxMessage(playerid, "/setarmor [playerid/PartOfName] [amount]");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "You have specified an invalid player.");

	SetPlayerArmour(userid, amount);
	SendServerMessage(playerid, "You have set %s's armour to %.2f.", GetName(userid), amount);
	return 1;
}

CMD:sethp(playerid, params[])
{
	new
		userid,
	    Float:amount;

	if (PlayerData[playerid][pAdmin] < 4)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "uf", userid, amount))
		return SendSyntaxMessage(playerid, "/sethp [playerid/PartOfName] [amount]");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "You have specified an invalid player.");

	if(amount <= 7.0)
	{
		InjuredPlayer(userid, INVALID_PLAYER_ID, WEAPON_COLLISION);
	}
	else
	{
		SetPlayerHealth(userid, amount);
	}
	SendServerMessage(playerid, "You have set %s's health to %.2f.", GetName(userid), amount);
	return 1;
}

CMD:kick(playerid, params[])
{
	static
	    userid,
	    reason[128];

    if (PlayerData[playerid][pAdmin] < 1)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "us[128]", userid, reason))
	    return SendSyntaxMessage(playerid, "/kick [playerid/PartOfName] [reason]");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "You have specified an invalid player.");

    if (PlayerData[userid][pAdmin] > PlayerData[playerid][pAdmin])
	    return SendErrorMessage(playerid, "The specified player has higher authority.");

	SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s has been kicked by %s reason: %s.", GetName(userid), PlayerData[playerid][pUCP], reason);
	KickEx(userid);
	return 1;
}

CMD:setcash(playerid, params[])
{
	static
		userid,
	    amount[32];

	if (PlayerData[playerid][pAdmin] < 7)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "us[32]", userid, amount))
		return SendSyntaxMessage(playerid, "/setcash [playerid/PartOfName] [amount]");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "You have specified an invalid player.");

	ResetPlayerMoney(userid);
	PlayerData[userid][pMoney] = strcash(amount);
	GivePlayerMoney(userid, strcash(amount));
	SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has set %s cash to $%s", PlayerData[playerid][pUCP], ReturnName(userid), FormatNumber(strcash(amount)));
	return 1;	
}

CMD:givecash(playerid, params[])
{
	new targetid, amount[32];
	if(PlayerData[playerid][pAdmin] < 7)
		return SendErrorMessage(playerid, "You don't have permission to use this command!");

	if(sscanf(params, "us[32]", targetid, amount))
		return SendSyntaxMessage(playerid, "/givecash [playerid/PartOfName] [amount]");

	if(targetid == INVALID_PLAYER_ID)
		return SendErrorMessage(playerid, "Invalid player ID!");

	SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has give $%s cash to %s", PlayerData[playerid][pUCP], FormatNumber(strcash(amount)), GetName(targetid));
	GiveMoney(targetid, strcash(amount));
	return 1;
}
CMD:jetpack(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1)
        return SendErrorMessage(playerid, "You don't have permission to use this command!");

    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
    return 1;
}
CMD:aduty(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1)
        return SendErrorMessage(playerid, "You don't have permission to use this command!");
        
	if(!PlayerData[playerid][pAduty])
	{
	    PlayerData[playerid][pAduty] = true;
	    SetPlayerColor(playerid, 0xFF0000FF);
	    SetPlayerName(playerid, PlayerData[playerid][pUCP]);
	    SendAdminMessage(0x008080FF, "AdmCmd: %s is now {FFFF00}onduty {008080}as Administrator.", PlayerData[playerid][pUCP]);
	}
	else
	{
	    PlayerData[playerid][pAduty] = false;
	    SetValidColor(playerid);
	    SetPlayerName(playerid, PlayerData[playerid][pName]);
	    SendAdminMessage(0x008080FF, "AdmCmd: %s is now {FFFF00}offduty {008080}as Administrator.", PlayerData[playerid][pUCP]);
	}
	return 1;
}