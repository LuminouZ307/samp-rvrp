enum speedData
{
	speedID,
	speedExists,
	Float:speedPos[4],
	Float:speedRange,
	Float:speedLimit,
	speedPlate[32],
	speedVehicle,
	speedTime,
	STREAMER_TAG_AREA:speedArea,
	STREAMER_TAG_OBJECT:speedObject,
	STREAMER_TAG_3D_TEXT_LABEL:speedText3D
};

new SpeedData[MAX_SPEEDCAM][speedData];

FUNC::Speed_Load()
{
	new rows = cache_num_rows();
 	if(rows)
  	{
    	for(new i; i < rows; i++)
		{
		    SpeedData[i][speedExists] = true;
		    cache_get_value_name_int(i,"speedID",SpeedData[i][speedID]);
            cache_get_value_name_float(i,"speedRange",SpeedData[i][speedRange]);
            cache_get_value_name_float(i,"speedLimit",SpeedData[i][speedLimit]);
            cache_get_value_name_float(i,"speedX",SpeedData[i][speedPos][0]);
            cache_get_value_name_float(i,"speedY",SpeedData[i][speedPos][1]);
            cache_get_value_name_float(i,"speedZ",SpeedData[i][speedPos][2]);
            cache_get_value_name_float(i,"speedAngle",SpeedData[i][speedPos][3]);
            cache_get_value_name(i,"speedplate",SpeedData[i][speedPlate]);
            cache_get_value_name_int(i,"speedvehicle",SpeedData[i][speedVehicle]);
            cache_get_value_name_int(i, "speedTime", SpeedData[i][speedTime]);

		    Speed_Refresh(i);
		}
		printf("[SPEEDCAM] Loaded %d Speed Camera from database", rows);
	}
	return 1;
}
stock Speed_Refresh(speedid)
{
	if (speedid != -1 && SpeedData[speedid][speedExists])
	{
	    new
	        string[80];

		if (IsValidDynamicObject(SpeedData[speedid][speedObject]))
		    DestroyDynamicObject(SpeedData[speedid][speedObject]);

		if (IsValidDynamic3DTextLabel(SpeedData[speedid][speedText3D]))
		    DestroyDynamic3DTextLabel(SpeedData[speedid][speedText3D]);

		if(IsValidDynamicArea(SpeedData[speedid][speedArea]))
			DestroyDynamicArea(SpeedData[speedid][speedArea]);

		format(string, sizeof(string), "[ID %d]\n{FFFFFF}Speed Limit: %.0f KM/H\nVehicle: %s\nPlate: %s", speedid, SpeedData[speedid][speedLimit], ReturnVehicleModelName(SpeedData[speedid][speedVehicle]), SpeedData[speedid][speedPlate]);

		SpeedData[speedid][speedText3D] = CreateDynamic3DTextLabel(string, COLOR_YELLOW, SpeedData[speedid][speedPos][0], SpeedData[speedid][speedPos][1], SpeedData[speedid][speedPos][2] + 2.5, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0);
        SpeedData[speedid][speedObject] = CreateDynamicObject(18880, SpeedData[speedid][speedPos][0], SpeedData[speedid][speedPos][1], SpeedData[speedid][speedPos][2], 0.0, 0.0, SpeedData[speedid][speedPos][3]);
		SpeedData[speedid][speedArea] = CreateDynamicSphere(SpeedData[speedid][speedPos][0], SpeedData[speedid][speedPos][1], SpeedData[speedid][speedPos][2],SpeedData[speedid][speedRange]);
	}
	return 1;
}

stock Speed_RefreshText(speedid)
{
	if (speedid != -1 && SpeedData[speedid][speedExists])
	{
	    new
	        string[128];

		if (IsValidDynamic3DTextLabel(SpeedData[speedid][speedText3D]))
		    DestroyDynamic3DTextLabel(SpeedData[speedid][speedText3D]);

		format(string, sizeof(string), "[ID %d]\n{FFFFFF}Speed Limit: %.0f KM/H\nVehicle: %s\nPlate: %s", speedid, SpeedData[speedid][speedLimit], ReturnVehicleModelName(SpeedData[speedid][speedVehicle]), SpeedData[speedid][speedPlate]);

		SpeedData[speedid][speedText3D] = CreateDynamic3DTextLabel(string, COLOR_YELLOW, SpeedData[speedid][speedPos][0], SpeedData[speedid][speedPos][1], SpeedData[speedid][speedPos][2] + 2.5, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0);
	}
	return 1;
}

stock Speed_Save(speedid)
{
	new
	    query[352];

	mysql_format(sqlcon, query, sizeof(query), "UPDATE `speedcameras` SET `speedRange` = '%.4f', `speedLimit` = '%.4f', `speedX` = '%.4f', `speedY` = '%.4f', `speedZ` = '%.4f', `speedAngle` = '%.4f', `speedplate` = '%s', `speedTime` = '%d', `speedvehicle` = '%d' WHERE `speedID` = '%d'",
	    SpeedData[speedid][speedRange],
	    SpeedData[speedid][speedLimit],
	    SpeedData[speedid][speedPos][0],
	    SpeedData[speedid][speedPos][1],
	    SpeedData[speedid][speedPos][2],
	    SpeedData[speedid][speedPos][3],
	    SpeedData[speedid][speedPlate],
	    SpeedData[speedid][speedTime],
	    SpeedData[speedid][speedVehicle],
	    SpeedData[speedid][speedID]
	);
	return mysql_tquery(sqlcon, query);
}

stock Speed_Nearest(playerid)
{
	for (new i = 0; i < MAX_SPEEDCAM; i ++) if (SpeedData[i][speedExists] && IsPlayerInRangeOfPoint(playerid, SpeedData[i][speedRange], SpeedData[i][speedPos][0], SpeedData[i][speedPos][1], SpeedData[i][speedPos][2]))
	    return i;

	return -1;
}

stock Speed_Delete(speedid)
{
    if (speedid != -1 && SpeedData[speedid][speedExists])
	{
	    new
	        string[64];

		if (IsValidDynamicObject(SpeedData[speedid][speedObject]))
		    DestroyDynamicObject(SpeedData[speedid][speedObject]);

		if (IsValidDynamic3DTextLabel(SpeedData[speedid][speedText3D]))
		    DestroyDynamic3DTextLabel(SpeedData[speedid][speedText3D]);

		if(IsValidDynamicArea(SpeedData[speedid][speedArea]))
			DestroyDynamicArea(SpeedData[speedid][speedArea]);

		mysql_format(sqlcon, string, sizeof(string), "DELETE FROM `speedcameras` WHERE `speedID` = '%d'", SpeedData[speedid][speedID]);
		mysql_tquery(sqlcon, string);

		SpeedData[speedid][speedExists] = false;
		SpeedData[speedid][speedLimit] = 0.0;
		SpeedData[speedid][speedRange] = 0.0;
		SpeedData[speedid][speedID] = 0;
	}
	return 1;
}

stock Speed_Create(playerid, Float:limit, Float:range)
{
	new
	    Float:x,
	    Float:y,
	    Float:z,
	    Float:angle;

	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);

	for (new i = 0; i < MAX_SPEEDCAM; i ++) if (!SpeedData[i][speedExists])
	{
	    SpeedData[i][speedExists] = true;
	    SpeedData[i][speedRange] = range;
        SpeedData[i][speedLimit] = limit;

		SpeedData[i][speedPos][0] = x + (1.5 * floatsin(-angle, degrees));
	    SpeedData[i][speedPos][1] = y + (1.5 * floatcos(-angle, degrees));
	    SpeedData[i][speedPos][2] = z - 1.2;
	    SpeedData[i][speedPos][3] = angle;

	    Speed_Refresh(i);
	    mysql_tquery(sqlcon, "INSERT INTO `speedcameras` (`speedRange`) VALUES(0.0)", "OnSpeedCreated", "d", i);
	    return i;
	}
	return -1;
}

FUNC::OnSpeedCreated(speedid)
{
	if (speedid == -1 || !SpeedData[speedid][speedExists])
	    return 0;

	SpeedData[speedid][speedID] = cache_insert_id();
	Speed_Save(speedid);

	return 1;
}

CMD:createspeed(playerid, params[])
{
	static
	    Float:limit,
	    Float:range;

    if (PlayerData[playerid][pAdmin] < 6)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");
	    
	if (sscanf(params, "ff", limit, range))
		return SendSyntaxMessage(playerid, "/createspeed [speed limit] [range] (default range: 30)");

	if (limit < 5.0 || limit > 150.0)
	    return SendErrorMessage(playerid, "The speed limit can't be below 5 or above 150.");

	if (range < 5.0 || range > 50.0)
	    return SendErrorMessage(playerid, "The range can't be below 5 or above 50.");

	if (Speed_Nearest(playerid) != -1)
	    return SendErrorMessage(playerid, "You can't do this in range another speed camera.");

	new id = Speed_Create(playerid, limit, range);

	if (id == -1)
	    return SendErrorMessage(playerid, "The server has reached the limit for speed cameras.");

	SendServerMessage(playerid, "You have created speed camera ID: %d.", id);
	return 1;
}

CMD:destroyspeed(playerid, params[])
{
	static
	    id = 0;

    if (PlayerData[playerid][pAdmin] < 6)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "d", id))
	    return SendSyntaxMessage(playerid, "/destroyspeed [speed id]");

	if ((id < 0 || id >= MAX_SPEEDCAM) || !SpeedData[id][speedExists])
	    return SendErrorMessage(playerid, "You have specified an invalid speed camera ID.");

	Speed_Delete(id);
	SendServerMessage(playerid, "You have successfully destroyed speed camera ID: %d.", id);
	return 1;
}
