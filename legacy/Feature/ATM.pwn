enum atm_data
{
	atmID,
	atmExists,
	Float:atmPos[4],
	atmInterior,
	atmWorld,
	STREAMER_TAG_OBJECT:atmObject,
	STREAMER_TAG_3D_TEXT_LABEL:atmText3D,
	STREAMER_TAG_AREA:atmArea,
};

new AtmData[MAX_ATM][atm_data];

stock ATM_Delete(atmid)
{
	if (atmid != -1 && AtmData[atmid][atmExists])
	{
	    new
	        string[64];

		mysql_format(sqlcon, string, sizeof(string), "DELETE FROM `atm` WHERE `atmID` = '%d'", AtmData[atmid][atmID]);
		mysql_tquery(sqlcon, string);

        if (IsValidDynamicObject(AtmData[atmid][atmObject]))
	        DestroyDynamicObject(AtmData[atmid][atmObject]);

		if(IsValidDynamic3DTextLabel(AtmData[atmid][atmText3D]))
			DestroyDynamic3DTextLabel(AtmData[atmid][atmText3D]);

		if(IsValidDynamicArea(AtmData[atmid][atmArea]))
			DestroyDynamicArea(AtmData[atmid][atmArea]);

	    AtmData[atmid][atmExists] = false;
	    AtmData[atmid][atmID] = 0;
	}
	return 1;
}

stock ATM_Create(playerid)
{
    new
	    Float:x,
	    Float:y,
	    Float:z,
	    Float:angle;

	if (GetPlayerPos(playerid, x, y, z) && GetPlayerFacingAngle(playerid, angle))
	{
		for (new i = 0; i < MAX_ATM; i ++) if (!AtmData[i][atmExists])
		{
		    AtmData[i][atmExists] = true;

		    x += 1.0 * floatsin(-angle, degrees);
			y += 1.0 * floatcos(-angle, degrees);

            AtmData[i][atmPos][0] = x;
            AtmData[i][atmPos][1] = y;
            AtmData[i][atmPos][2] = z;
            AtmData[i][atmPos][3] = angle;

            AtmData[i][atmInterior] = GetPlayerInterior(playerid);
            AtmData[i][atmWorld] = GetPlayerVirtualWorld(playerid);

			ATM_Refresh(i);
			mysql_tquery(sqlcon, "INSERT INTO `atm` (`atmInterior`) VALUES(0)", "OnATMCreated", "d", i);

			return i;
		}
	}
	return -1;
}

stock ATM_Refresh(atmid)
{
	if (atmid != -1 && AtmData[atmid][atmExists])
	{
	    if (IsValidDynamicObject(AtmData[atmid][atmObject]))
	        DestroyDynamicObject(AtmData[atmid][atmObject]);

	    if(IsValidDynamic3DTextLabel(AtmData[atmid][atmText3D]))
	    	DestroyDynamic3DTextLabel(AtmData[atmid][atmText3D]);
		
		if(IsValidDynamicArea(AtmData[atmid][atmArea]))
			DestroyDynamicArea(AtmData[atmid][atmArea]);

		AtmData[atmid][atmObject] = CreateDynamicObject(2942, AtmData[atmid][atmPos][0], AtmData[atmid][atmPos][1], AtmData[atmid][atmPos][2] - 0.4, 0.0, 0.0, AtmData[atmid][atmPos][3], AtmData[atmid][atmWorld], AtmData[atmid][atmInterior]);
		AtmData[atmid][atmArea] = CreateDynamicSphere(AtmData[atmid][atmPos][0], AtmData[atmid][atmPos][1], AtmData[atmid][atmPos][2] - 0.4, 1.3);
		//AtmData[atmid][atmText3D] = CreateDynamic3DTextLabel(string, COLOR_SERVER, AtmData[atmid][atmPos][0], AtmData[atmid][atmPos][1], AtmData[atmid][atmPos][2], 7.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, AtmData[atmid][atmWorld], AtmData[atmid][atmInterior]);
		return 1;
	}
	return 0;
}

stock ATM_Nearest(playerid)
{
    for (new i = 0; i != MAX_ATM; i ++) if (AtmData[i][atmExists] && IsPlayerInDynamicArea(playerid, AtmData[i][atmArea]))
		return i;

	return -1;
}

FUNC::ATM_Load()
{
	new rows = cache_num_rows();
 	if(rows)
  	{
		for(new i; i < rows; i++)
		{
		    AtmData[i][atmExists] = true;
		    cache_get_value_name_int(i,"atmID",AtmData[i][atmID]);
            cache_get_value_name_float(i,"atmX",AtmData[i][atmPos][0]);
            cache_get_value_name_float(i,"atmY",AtmData[i][atmPos][1]);
            cache_get_value_name_float(i,"atmZ",AtmData[i][atmPos][2]);
            cache_get_value_name_float(i,"atmA",AtmData[i][atmPos][3]);
            cache_get_value_name_int(i,"atmInterior",AtmData[i][atmInterior]);
            cache_get_value_name_int(i,"atmWorld",AtmData[i][atmWorld]);

			ATM_Refresh(i);
		}
		printf("[ATM] Loaded %d ATM from the database", rows);
	}
	return 1;
}

FUNC::OnATMCreated(atmid)
{
    if (atmid == -1 || !AtmData[atmid][atmExists])
		return 0;

	AtmData[atmid][atmID] = cache_insert_id();
 	ATM_Save(atmid);

	return 1;
}

stock ATM_Save(atmid)
{
	new
	    query[512];

	mysql_format(sqlcon, query, sizeof(query), "UPDATE `atm` SET `atmX` = '%.4f', `atmY` = '%.4f', `atmZ` = '%.4f', `atmA` = '%.4f', `atmInterior` = '%d', `atmWorld` = '%d' WHERE `atmID` = '%d'",
	    AtmData[atmid][atmPos][0],
	    AtmData[atmid][atmPos][1],
	    AtmData[atmid][atmPos][2],
	    AtmData[atmid][atmPos][3],
	    AtmData[atmid][atmInterior],
	    AtmData[atmid][atmWorld],
	    AtmData[atmid][atmID]
	);
	return mysql_tquery(sqlcon, query);
}

CMD:createatm(playerid, params[])
{
	static
	    id = -1;

    if (PlayerData[playerid][pAdmin] < 6)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	id = ATM_Create(playerid);

	if (id == -1)
	    return SendErrorMessage(playerid, "The server has reached the limit for ATM machines.");

	SendServerMessage(playerid, "You have successfully created ATM ID: %d.", id);
	return 1;
}
	
CMD:destroyatm(playerid, params[])
{
	static
	    id = 0;

    if (PlayerData[playerid][pAdmin] < 6)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "d", id))
	    return SendSyntaxMessage(playerid, "/destroyatm [atm id]");

	if ((id < 0 || id >= MAX_ATM) || !AtmData[id][atmExists])
	    return SendErrorMessage(playerid, "You have specified an invalid ATM ID.");

	ATM_Delete(id);
	SendServerMessage(playerid, "You have successfully destroyed ATM ID: %d.", id);
	return 1;
}

CMD:atm(playerid, params[])
{
	if(ATM_Nearest(playerid) == -1)
		return SendErrorMessage(playerid, "Kamu tidak berada didekat ATM manapun!");

	ShowPlayerDialog(playerid, DIALOG_ATM, DIALOG_STYLE_LIST, "Auto Teller Machine", sprintf("Balance: {00FF00}$%s\n{FFFFFF}Withdraw Cash\nTransfer\nGet PayCheck", FormatNumber(PlayerData[playerid][pBank])), "Select", "Close");
	return 1;
}