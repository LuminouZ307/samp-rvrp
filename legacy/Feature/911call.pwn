new ServiceIndex[MAX_PLAYERS];
new ServiceRequest[MAX_PLAYERS];
new ServiceType[MAX_PLAYERS];
new ServiceLocation[MAX_PLAYERS][32];
new ServiceName[MAX_PLAYERS][MAX_PLAYER_NAME];
new ServiceInfo[MAX_PLAYERS][64];

enum
{
	SECTOR_POLICE = 1,
	SECTOR_MEDIC
}

enum emergency_data
{
	emgID,
	bool:emgExists,
	emgReason[64],
	emgType,
	emgSector,
	emgNumber,
	emgIssuerName[MAX_PLAYER_NAME],
	emgIssuerID,
	emgLocation[32],
	emgTime,
};
new EmergencyData[MAX_EMERGENCY][emergency_data];

stock ShowEmergencyDetails(playerid, id)
{
	new date[6];
	TimestampToDate(EmergencyData[id][emgTime], date[2], date[1], date[0], date[3], date[4], date[5]);

	new str[712];
	strcat(str, sprintf("Reporter: %s\n", EmergencyData[id][emgIssuerName]));
	strcat(str, sprintf("Phone Number: %d\n", EmergencyData[id][emgNumber]));
	strcat(str, sprintf("Last Location: %s\n", EmergencyData[id][emgLocation]));
	strcat(str, sprintf("Problem: %s\n", GetProblemType(EmergencyData[id][emgSector], EmergencyData[id][emgType])));
	strcat(str, sprintf("Description: %s\n", EmergencyData[id][emgReason]));
	strcat(str, sprintf("Report Time: %02d/%02d\n", date[0], date[1]));
	strcat(str, sprintf("Report Date: %i/%02d:%02d", date[2], date[3], date[4]));
	ShowPlayerDialog(playerid, DIALOG_MDC_RETURN, DIALOG_STYLE_LIST, "MDC - 911 Details", str, "Return", "");
	return 1;
}

stock ReturnSector(playerid)
{
	if(GetFactionType(playerid) == FACTION_POLICE)
	{
		return SECTOR_POLICE;
	}
	else if(GetFactionType(playerid) == FACTION_MEDIC)
	{
		return SECTOR_MEDIC;
	}
	else 
	{
		return 0;
	}
}
stock ShowEmergency(playerid)
{
	new str[1012];
	new bool:found = false;
	new date[6];
	forex(i, MAX_EMERGENCY) if(EmergencyData[i][emgExists])
	{
		if(EmergencyData[i][emgSector] == ReturnSector(playerid))
		{
			TimestampToDate(EmergencyData[i][emgTime], date[2], date[1], date[0], date[3], date[4], date[5]);
			format(str, sizeof(str), "%s%d | %s | %i/%02d/%02d %02d:%02d\n", str, i + 1, EmergencyData[i][emgReason], date[2], date[0], date[1], date[3], date[4]);
			found = true;
		}
	}
	if(found)
		ShowPlayerDialog(playerid, DIALOG_MDC_911, DIALOG_STYLE_LIST, "MDC - 911 List", str, "Select", "Return");
	else
		ShowPlayerDialog(playerid, DIALOG_MDC_RETURN, DIALOG_STYLE_MSGBOX, "MDC - Error", "There is no recent 911 calls!", "Return", ""), PlayerPlayNearbySound(playerid, MDC_ERROR);

	return 1;
}


stock ProcessServiceCall(playerid, text[])
{
	if(ServiceIndex[playerid] == 1)
	{
		new gstr[712];
		if(!strcmp(text, "lspd", true))
		{
			ServiceRequest[playerid] = SECTOR_POLICE;
			SendClientMessage(playerid, 0x1394BFFF, "911 Dispatch: 911 here, What is going on?");
			strcat(gstr,"Abandoned Vehicle\nAccident-Major\nAccident-Minor");
			strcat(gstr,"\nAlarm\nAssault\nAssist-Public\nBurglary\nBurglary (In Progress)\nCriminal Mischief");
			strcat(gstr,"\nDisturbance\nDOA\nDrunk\nDrugs\nDWI\nFight\nFire\nInformation\nInjured/Sick Person");
			strcat(gstr,"\nMiscellaneous\nMissing Person\nOfficer In Trouble\nRape\nRape (In Progress)\nRobbery\nShooting\nShooting (In Progress)\nSuicide");
			strcat(gstr,"\nSuspicious Person\nSuspicious Vehicle\nThreats\nThreats Bomb\nTraffic Related\n");
			ShowPlayerDialog(playerid, DIALOG_CALL_911, DIALOG_STYLE_LIST, "Please Select a Problem Type", gstr, "Choose", "Cancel");	
			return 0;		
		}
		else if(!strcmp(text, "lses", true))
		{
			ServiceRequest[playerid] = SECTOR_MEDIC;
			SendClientMessage(playerid, 0x1394BFFF, "911 Dispatch: 911 here, What is going on?");
			strcat(gstr,"Aircraft Emergency\nAccident-Major\nAccident-Minor\nAlarm\nArcing Electrical\nAssist-Public");
			strcat(gstr,"\nBomb Threat\nEntrapment\nExplosion\nFire\nFire-Structure\nFire-Vehicle\nGas/Fuel-Leak");
			strcat(gstr,"\nHazardous Materials\nMed-Sick Person\nMed-Injured Person\nRescue\nRescue-Water\nRescue-Search\nTrain Derailment");
			ShowPlayerDialog(playerid, DIALOG_CALL_911, DIALOG_STYLE_LIST, "Please Select a Problem Type", gstr, "Choose", "Cancel");
			return 0;
		}
		else
		{
			SendClientMessage(playerid, COLOR_SERVER, "OPERATOR:{FFFFFF} Sorry I don't quite understand you. Did you say \"lspd\" or \"lses\"?");
			return 0;
		}
	}
	else if(ServiceIndex[playerid] == 2)
	{
		if(strlen(text) < 6)
		{
			SendClientMessage(playerid, 0x1394BFFF, "911 Dispatch: Sorry I don't understand. Can you give us some more details?");
			return false;
		}
		format(ServiceInfo[playerid], 64, text);
		SendClientMessage(playerid, 0x1394BFFF, "911 Dispatch: Okay, we have sent the information to the responders. Can I have your name?");
		ServiceIndex[playerid] = 3;
		return 0;
	}
	else if(ServiceIndex[playerid] == 3)
	{
		if(strlen(text) >= 24)
		{
			SendClientMessage(playerid, 0x1394BFFF, "911 Dispatch: Sorry I don't understand. Can I have your name please? ((Name is too long))");
			return 0;
		}	
		format(ServiceName[playerid], MAX_PLAYER_NAME, text);
		SendClientMessageEx(playerid, 0x1394BFFF, "911 Dispatch: Okay %s %s, Can i know your current location now?", (PlayerData[playerid][pGender] == 1) ? ("mr") : ("mrs"), ServiceName[playerid]);
		ServiceIndex[playerid] = 4;
		return 0;	
	}
	else if(ServiceIndex[playerid] == 4)
	{
		if(strlen(text) >= 32)
		{
			SendClientMessage(playerid, 0x1394BFFF, "911 Dispatch: Sorry I don't understand. Can i know your current location? ((Location is too long))");
			return 0;			
		}
		format(ServiceLocation[playerid], 32, text);
		Emergency_Add(playerid);
		ServiceIndex[playerid] = 0;
	    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	    RemovePlayerAttachedObject(playerid, 3);
		SendClientMessage(playerid, 0x1394BFFF, "911 Dispatch: Okay we will have our closest available unit en route to your location right away.");
		if(ServiceRequest[playerid] == SECTOR_POLICE)
		{
			SendFactionMessageEx(FACTION_POLICE, COLOR_RED, "[911] Incident: [ {FFFF00}%s {FF0000}]", ServiceInfo[playerid]);
			SendFactionMessageEx(FACTION_POLICE, COLOR_RED, "[911] Reporter: [ {FFFF00}%s {FF0000}] Number: [ {FFFF00}%d {FF0000}] Location: [ {FFFF00}%s {FF0000}]", ServiceName[playerid], PlayerData[playerid][pPhoneNumber], ServiceLocation[playerid]);
		}
		else
		{
			SendFactionMessageEx(FACTION_MEDIC, COLOR_RADIO, "[911] Reporter: %s | Number: %d", ServiceName[playerid], PlayerData[playerid][pPhoneNumber]);
			SendFactionMessageEx(FACTION_MEDIC, COLOR_RADIO, "[911] Description: %s", ServiceInfo[playerid]);
			SendFactionMessageEx(FACTION_MEDIC, COLOR_RADIO, "[911] Location: %s", ServiceLocation[playerid]);
		}
	}
	return 1;
}

stock Emergency_Delete(id)
{
	if(!EmergencyData[id][emgExists])
		return 0;

	new string[64];
	mysql_format(sqlcon, string, sizeof(string), "DELETE FROM `911calls` WHERE `ID` = '%d'", EmergencyData[id][emgID]);
	mysql_query(sqlcon, string, true);

	EmergencyData[id][emgExists] = false;
	EmergencyData[id][emgID] = 0;
	return 1;
}
stock Emergency_Add(playerid)
{
	forex(i, MAX_EMERGENCY) if(!EmergencyData[i][emgExists])
	{
		EmergencyData[i][emgExists] = true;
		format(EmergencyData[i][emgIssuerName], MAX_PLAYER_NAME, ServiceName[playerid]);
		format(EmergencyData[i][emgReason], 64, ServiceInfo[playerid]);
		format(EmergencyData[i][emgLocation], 32, ServiceLocation[playerid]);
		EmergencyData[i][emgSector] = ServiceRequest[playerid];
		EmergencyData[i][emgIssuerID] = PlayerData[playerid][pID];
		EmergencyData[i][emgType] = ServiceType[playerid];
		EmergencyData[i][emgTime] = gettime();
		EmergencyData[i][emgNumber] = PlayerData[playerid][pPhoneNumber];
		mysql_tquery(sqlcon, "INSERT INTO `911calls` (`Sector`) VALUES(0)", "OnEmergencyAdded", "d", i);
		return i;
	}
	return -1;
}

FUNC::Emergency_Load()
{
	new rows = cache_num_rows();
	if(rows)
	{
		forex(i, rows)
		{
			EmergencyData[i][emgExists] = true;

			cache_get_value_name_int(i, "ID", EmergencyData[i][emgID]);
			cache_get_value_name(i, "IssuerName", EmergencyData[i][emgIssuerName], MAX_PLAYER_NAME);
			cache_get_value_name(i, "Reason", EmergencyData[i][emgReason], 64);
			cache_get_value_name(i, "Location", EmergencyData[i][emgLocation], 32);
			cache_get_value_name_int(i, "IssuerID", EmergencyData[i][emgIssuerID]);
			cache_get_value_name_int(i, "Number", EmergencyData[i][emgNumber]);
			cache_get_value_name_int(i, "Sector", EmergencyData[i][emgSector]);
			cache_get_value_name_int(i, "Type", EmergencyData[i][emgType]);
			cache_get_value_name_int(i, "Time", EmergencyData[i][emgTime]);
		}
		printf("[EMERGENCY] Loaded %d emergency calls from database", rows);
	}
	return 1;
}
stock Emergency_Save(id)
{
	new query[1052];
	mysql_format(sqlcon, query, sizeof(query), "UPDATE `911calls` SET ");
	mysql_format(sqlcon, query, sizeof(query), "%s`IssuerName`='%s', ", query, EmergencyData[id][emgIssuerName]);
	mysql_format(sqlcon, query, sizeof(query), "%s`IssuerID`='%d', ", query, EmergencyData[id][emgIssuerID]);
	mysql_format(sqlcon, query, sizeof(query), "%s`Reason`='%s', ", query, EmergencyData[id][emgReason]);
	mysql_format(sqlcon, query, sizeof(query), "%s`Type`='%d', ", query, EmergencyData[id][emgType]);
	mysql_format(sqlcon, query, sizeof(query), "%s`Time`='%d', ", query, EmergencyData[id][emgTime]);
	mysql_format(sqlcon, query, sizeof(query), "%s`Sector`='%d', ", query, EmergencyData[id][emgSector]);
	mysql_format(sqlcon, query, sizeof(query), "%s`Location`='%s', ", query, EmergencyData[id][emgLocation]);
	mysql_format(sqlcon, query, sizeof(query), "%s`Number`='%d' ", query, EmergencyData[id][emgNumber]);
	mysql_format(sqlcon, query, sizeof(query), "%sWHERE `ID` = '%d'", query, EmergencyData[id][emgID]);
	mysql_query(sqlcon, query, true);	
}
FUNC::OnEmergencyAdded(id)
{
	EmergencyData[id][emgID] = cache_insert_id();
	Emergency_Save(id);
}

stock GetProblemType(sectorid,problemid)
{
	new reason[64];
	if(sectorid == 1)
	{
		switch(problemid)
		{
			case 0: reason = "Abandoned Vehicle";
			case 1: reason = "Accident-Major";
			case 2: reason = "Accident-Minor";
			case 3: reason = "Alarm";
			case 4: reason = "Assault";
			case 5: reason = "Assist-Public";
			case 6: reason = "Burglary";
			case 7: reason = "Burglary (In Progress)";
			case 8: reason = "Criminal Mischief";
			case 9: reason = "Disturbance";
			case 10: reason = "DOA";
			case 11: reason = "Drunk";
			case 12: reason = "Drugs";
			case 13: reason = "DWI";
			case 14: reason = "Fight";
			case 15: reason = "Fire";
			case 16: reason = "Information";
			case 17: reason = "Injured/Sick Person";
			case 18: reason = "Miscellaneous";
			case 19: reason = "Missing Person";
			case 20: reason = "Officer In Trouble";
			case 21: reason = "Rape";
			case 22: reason = "Rape (In Progress)";
			case 23: reason = "Robbery";
			case 24: reason = "Shooting";
			case 25: reason = "Shooting (In Progress)";
			case 26: reason = "Suicide";
			case 27: reason = "Suspicious Person";
			case 28: reason = "Suspicious Vehicle";
			case 29: reason = "Threats";
			case 30: reason = "Threats Bomb";
			case 31: reason = "Traffic Related";
			case 32: reason = "Wanted Person";
			case 33: reason = "On Site Activity";
			case 34: reason = "Traffic Stop";
			case 35: reason = "Assist Fire/EMS";
		}
	}
	if(sectorid == 2)//RCFD
	{
		switch(problemid)//RFPD
		{
			case 0: reason = "Aircraft Emergency";
			case 1: reason = "Accident-Major";
			case 2: reason = "Accident-Minor";
			case 3: reason = "Alarm";
			case 4: reason = "Arcing Electrical";
			case 5: reason = "Assist-Public";
			case 6: reason = "Bomb Threat";
			case 7: reason = "Entrapment";
			case 8: reason = "Explosion";
			case 9: reason = "Fire";
			case 10: reason = "Fire-Structure";
			case 11: reason = "Fire-Vehicle";
			case 12: reason = "Gas/Fuel-Leak";
			case 13: reason = "Hazardous Materials";
			case 14: reason = "Med-Sick Person";
			case 15: reason = "Med-Injured Person";
			case 16: reason = "Rescue";
			case 17: reason = "Rescue-Water";
			case 18: reason = "Rescue-Search";
			case 19: reason = "Train Derailment";
			case 20: reason = "Miscellanious";
			case 21: reason = "On Site Activity";
			case 22: reason = "Special Assignment";
			case 23: reason = "Stand By";
			case 24: reason = "Assist PD";
		}
	}
	return reason;
}


