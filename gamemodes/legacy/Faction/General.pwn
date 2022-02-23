new
	SanNewsVehicles[14],
	LSMDVehicles[3],
	LSPDVehicles[28],
	BusVehicle[3],
	SweeperVehicle[3];

stock ShowMDC(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "You must inside faction vehicle!");

	if(GetFactionType(playerid) == FACTION_POLICE)
	{
		if(!IsPoliceVehicle(GetPlayerVehicleID(playerid)))
			return SendErrorMessage(playerid, "You must be inside Police Vehicle!");

		ShowPlayerDialog(playerid, DIALOG_MDC, DIALOG_STYLE_LIST, "MDC - Dashboard", "Recent 911 calls\nPlate Search", "Select", "Logout");
		PlayerPlayNearbySound(playerid, MDC_OPEN);
		SetPlayerChatBubble(playerid, "* Logs into the Mobile Data Computer *", COLOR_PURPLE, 15.0, 10000);
	}
	else
	{
		if(!IsMedicVehicle(GetPlayerVehicleID(playerid)))
			return SendErrorMessage(playerid, "You must be inside Medic Vehicle!");		

		ShowPlayerDialog(playerid, DIALOG_MDC, DIALOG_STYLE_LIST, "MDC - Dashboard", "Recent 911 calls", "Select", "Close");
		PlayerPlayNearbySound(playerid, MDC_OPEN);
		SetPlayerChatBubble(playerid, "* Logs into the Mobile Data Computer *", COLOR_PURPLE, 15.0, 10000);
	}
	return 1;
}

stock SendDutyMessage(faction, color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[256]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit ADD.C 4
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

        foreach (new i : Player)
		{
			if (GetFactionType(i) == faction && PlayerData[i][pOnDuty])
			{
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
	foreach (new i : Player)
	{
		if (GetFactionType(i) == faction && PlayerData[i][pOnDuty]) {
			SendClientMessage(i, color, str);
		}
	}
	return 1;
}

stock SendFactionMessageEx(faction, color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[256]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit ADD.C 4
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

        foreach (new i : Player)
		{
			if (GetFactionType(i) == faction)
			{
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
	foreach (new i : Player)
	{
		if (GetFactionType(i) == faction) {
			SendClientMessage(i, color, str);
		}
	}
	return 1;
}

stock SendFactionMessage(factionid, color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 12)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 12); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string
		#emit PUSH.C args

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

		foreach (new i : Player) if (PlayerData[i][pFaction] == factionid) 
		{
		    SendClientMessage(i, color, string);
		}
		return 1;
	}
	foreach (new i : Player) if (PlayerData[i][pFaction] == factionid) 
	{
 		SendClientMessage(i, color, str);
	}
	return 1;
}

stock SetFactionSkin(playerid, model)
{
	SetPlayerSkin(playerid, model);
	PlayerData[playerid][pFactionSkin] = model;
}
stock ResetFaction(playerid)
{
    PlayerData[playerid][pFaction] = -1;
    PlayerData[playerid][pFactionID] = -1;
    PlayerData[playerid][pFactionRank] = 0;
    PlayerData[playerid][pOnDuty] = false;
    SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);
    SetPlayerColor(playerid, COLOR_WHITE);
}
stock IsNewsVehicle(vehicleid)
{
	forex(i, sizeof(SanNewsVehicles))
	{
		if(vehicleid == SanNewsVehicles[i]) return 1;
	}
	return 0;	
}

stock IsMedicVehicle(vehicleid)
{
	forex(i, sizeof(LSMDVehicles))
	{
		if(vehicleid == LSMDVehicles[i]) return 1;
	}	
	return 0;
}

stock IsPoliceVehicle(vehicleid)
{
	forex(i, sizeof(LSPDVehicles))
	{
		if(vehicleid == LSPDVehicles[i]) return 1;
	}	
	return 0;
}

stock CountFaction(faction)
{
	new count = 0;
	foreach(new i : Player) if(GetFactionType(i) == faction && PlayerData[i][pOnDuty])
	{
		count++;
	}
	return count;
}

CMD:mdc(playerid, params[])
{
	if(GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_MEDIC)
		return SendErrorMessage(playerid, "You don't have permission to use this command!");

	ShowMDC(playerid);
	return 1;
}

CMD:megaphone(playerid, params[])
	return cmd_m(playerid, params);

CMD:m(playerid, params[])
{
	if (GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_MEDIC && GetFactionType(playerid) != FACTION_GOV)
		return SendErrorMessage(playerid, "You must be a part of Departement Faction!");

	if(!PlayerData[playerid][pOnDuty])
	    return SendErrorMessage(playerid, "You can't use this while not onduty.");
	    
	if(isnull(params))
	    return SendSyntaxMessage(playerid, "/m(egaphone) [megaphone]");
	    
    SendNearbyMessage(playerid, 60.0, COLOR_YELLOW, "[MEGAPHONE] %s: %s", ReturnName(playerid), params);
    return 1;
}

CMD:callsign(playerid, params[])
{
    new vehicleid;
    vehicleid = GetPlayerVehicleID(playerid);
	new string[32];
	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "You're not in a vehicle.");
		
	if (GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_MEDIC)
		return SendErrorMessage(playerid, "You must be a LSPD or LSES!");
		
	if (!IsPoliceVehicle(GetPlayerVehicleID(playerid)) && !IsMedicVehicle(GetPlayerVehicleID(playerid)))
		return SendErrorMessage(playerid, "You must be inside a police or medic vehicles");
	    
	if(vehiclecallsign[GetPlayerVehicleID(playerid)] == 1)
	{
 		Delete3DTextLabel(vehicle3Dtext[vehicleid]);
	    vehiclecallsign[vehicleid] = 0;
	    SendClientMessage(playerid, COLOR_SERVER, "CALLSIGN: {FFFFFF}Vehicle Callsign removed.");
	    return 1;
	}
	if(sscanf(params, "s[32]",string))
		return SendSyntaxMessage(playerid, "/callsign [callsign]");
		
	if(vehiclecallsign[GetPlayerVehicleID(playerid)] == 0)
	{
		vehicle3Dtext[vehicleid] = Create3DTextLabel(string, COLOR_WHITE, 0.0, 0.0, 0.0, 10.0, 0, 1);
		Attach3DTextLabelToVehicle(vehicle3Dtext[vehicleid], vehicleid, 0.0, -2.8, 0.0);
		vehiclecallsign[vehicleid] = 1;
		SendClientMessage(playerid, COLOR_SERVER, "CALLSIGN: {FFFFFF}Type {FFFF00}/callsign {FFFFFF}again to remove.");
	}
	return 1;
}

CMD:r(playerid, params[])
{
	if (GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_MEDIC && GetFactionType(playerid) != FACTION_GOV)
	    return SendErrorMessage(playerid, "You must be a civil service worker.");
	    
	if(isnull(params))
	    return SendSyntaxMessage(playerid, "/r [radio ic]");

	new
	    string[128];
		
	format(string, sizeof(string), "[RADIO] %s", params);
 	SetPlayerChatBubble(playerid, string, COLOR_RADIO, 30.0, 5000);

	if (strlen(params) > 64)
	{
  		SendFactionMessage(PlayerData[playerid][pFaction], COLOR_RADIO, "[RADIO] %s %s: %.64s", Faction_GetRank(playerid), GetName(playerid), params);
		SendFactionMessage(PlayerData[playerid][pFaction], COLOR_RADIO, "...%s", params[64]);
	}
	else
	{
		SendFactionMessage(PlayerData[playerid][pFaction], COLOR_RADIO, "[RADIO] %s %s: %.64s", Faction_GetRank(playerid), GetName(playerid), params);
	}
	return 1;
}

CMD:d(playerid, params[])
{
	if (GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_MEDIC && GetFactionType(playerid) != FACTION_GOV)
	    return SendErrorMessage(playerid, "You must be a civil service worker.");

	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/d(ept) [department radio]");

	params[0] = toupper(params[0]);
	for (new i = 0; i != MAX_FACTIONS; i ++) if (FactionData[i][factionType] == FACTION_POLICE || FactionData[i][factionType] == FACTION_MEDIC || FactionData[i][factionType] == FACTION_GOV) {
		SendFactionMessage(i, COLOR_DEPARTMENT, "[%s] %s %s: %s", GetInitials(Faction_GetName(playerid)), Faction_GetRank(playerid), GetName(playerid), params);
	}
	return 1;
}

CMD:od(playerid, params[])
{
	if (GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_MEDIC && GetFactionType(playerid) != FACTION_GOV)
	    return SendErrorMessage(playerid, "You must be a civil service worker.");

	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/od [ooc department radio]");

	for (new i = 0; i != MAX_FACTIONS; i ++) if (FactionData[i][factionType] == FACTION_POLICE || FactionData[i][factionType] == FACTION_MEDIC || FactionData[i][factionType] == FACTION_GOV) {
		SendFactionMessage(i, COLOR_DEPARTMENT, " (( [%s] %s: %s ))", GetInitials(Faction_GetName(playerid)), GetName(playerid), params);
	}
	return 1;
}

CMD:or(playerid, params[])
{
    new factionid = PlayerData[playerid][pFaction];

 	if (factionid == -1)
	    return SendErrorMessage(playerid, "You must be a faction member.");

	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/or [ooc radio message]");

	SendFactionMessage(factionid, 0x01FCFFC8, "(( (%d) %s %s: %s ))", PlayerData[playerid][pFactionRank], Faction_GetRank(playerid), GetName(playerid), params);
	return 1;
}

CMD:detain(playerid, params[])
{
	new
		userid,
		vehicleid = GetNearestVehicle(playerid, 5.0);

	if (GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_MEDIC)
		return SendErrorMessage(playerid, "You must be a police officer or emergency service!");

	if (sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/detain [playerid/name]");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "That player is disconnected.");

    if (userid == playerid)
	    return SendErrorMessage(playerid, "You cannot detained yourself.");

    if (!IsPlayerNearPlayer(playerid, userid, 3.0))
	    return SendErrorMessage(playerid, "You must be near this player.");

	if (vehicleid == INVALID_VEHICLE_ID)
	    return SendErrorMessage(playerid, "You are not near any vehicle.");

	if (GetVehicleMaxSeats(vehicleid) < 2)
  	    return SendErrorMessage(playerid, "You can't detain that player in this vehicle.");

	if (IsPlayerInVehicle(userid, vehicleid))
	{
		TogglePlayerControllable(userid, 1);

		RemovePlayerFromVehicle(userid);
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s opens the door and pulls %s out the vehicle.", ReturnName(playerid), ReturnName(userid));
	}
	else
	{
		new seatid = GetAvailableSeat(vehicleid, 2);

		if (seatid == -1)
		    return SendErrorMessage(playerid, "There are no more seats remaining.");

		new
		    string[64];

		format(string, sizeof(string), "You've been ~r~detained~w~ by %s.", ReturnName(playerid));
		RemoveDrag(userid);
		TogglePlayerControllable(userid, 0);

		PutPlayerInVehicle(userid, vehicleid, seatid);

		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s opens the door and places %s into the vehicle.", ReturnName(playerid), ReturnName(userid));
		ShowMessage(userid, string, 2);
	}
	return 1;
}

CMD:factions(playerid, params[])
{
	new str[512];
	forex(i, MAX_FACTIONS) if(FactionData[i][factionExists])
	{
		format(str, sizeof(str), "%s{FFFFFF}[ID: %d] {%06x}%s\n", str, i, FactionData[i][factionColor] >>> 8, FactionData[i][factionName]);
	}
	ShowPlayerDialog(playerid, DIALOG_NONE, DIALOG_STYLE_MSGBOX, "Faction List", str, "Close", "");
	return 1;
}
