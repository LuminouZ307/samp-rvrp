

enum e_faction_vehicle
{
	fvID,
	bool:fvExists,
	fvModel,
	Float:fvPos[4],
	fvColor[2],
	fvFaction,
	fvVehicle,
};
new FactionVehicle[MAX_FACTION_VEHICLE][e_faction_vehicle];

stock FactionVehicle_Create(factionid, model, Float:x, Float:y, Float:z, Float:a, color1, color2)
{
	forex(i, MAX_FACTION_VEHICLE) if(!FactionVehicle[i][fvExists])
	{
		FactionVehicle[i][fvPos][0] = x;
		FactionVehicle[i][fvPos][1] = y;
		FactionVehicle[i][fvPos][2] = z;
		FactionVehicle[i][fvPos][3] = a;
		FactionVehicle[i][fvColor][0] = color1;
		FactionVehicle[i][fvColor][1] = color2;
		FactionVehicle[i][fvModel] = model;
		FactionVehicle[i][fvExists] = true;
		FactionVehicle[i][fvFaction] = factionid;

		FactionVehicle[i][fvVehicle] = CreateVehicle(model, x, y, z, a, color1, color2, 60000);
		VehCore[FactionVehicle[i][fvVehicle]][vehFuel] = 100;
		
		mysql_tquery(sqlcon, "INSERT INTO `factionvehicle` (`Model`) VALUES(0)", "OnFactionVehicleCreated", "d", i);
		return 1;
	}
	return -1;
}

FUNC::OnFactionVehicleCreated(id)
{
	FactionVehicle[id][fvID] = cache_insert_id();
	FactionVehicle_Save(id);
}

stock FactionVehicle_Save(id)
{

	if(!FactionVehicle[id][fvExists])
		return 0;
	new query[1012];
	mysql_format(sqlcon, query, sizeof(query), "UPDATE `factionvehicle` SET ");
	mysql_format(sqlcon, query, sizeof(query), "%s`Model` = '%d', ", query,FactionVehicle[id][fvModel]);
	mysql_format(sqlcon, query, sizeof(query), "%s`PosX` = '%f', ", query, FactionVehicle[id][fvPos][0]);
	mysql_format(sqlcon, query, sizeof(query), "%s`PosY` = '%f', ", query,FactionVehicle[id][fvPos][1]);
	mysql_format(sqlcon, query, sizeof(query), "%s`PosZ` = '%f', ", query,FactionVehicle[id][fvPos][2]);
	mysql_format(sqlcon, query, sizeof(query), "%s`PosA` = '%f', ", query,FactionVehicle[id][fvPos][3]);
	mysql_format(sqlcon, query, sizeof(query), "%s`Color1` = '%d', ", query,FactionVehicle[id][fvColor][0]);
	mysql_format(sqlcon, query, sizeof(query), "%s`Color2` = '%d', ", query,FactionVehicle[id][fvColor][1]);
	mysql_format(sqlcon, query, sizeof(query), "%s`Faction` = '%d' ", query,FactionVehicle[id][fvFaction]);
	mysql_format(sqlcon, query, sizeof(query), "%sWHERE `ID` = '%d'", query, FactionVehicle[id][fvID]);
	mysql_query(sqlcon, query, true);
	return 1;
}

FUNC::FactionVehicle_Load(id)
{
	if(cache_num_rows())
	{
		forex(i, cache_num_rows())
		{
			FactionVehicle[i][fvExists] = true;
			cache_get_value_name_int(i, "ID", FactionVehicle[i][fvID]);
			cache_get_value_name_int(i, "Model", FactionVehicle[i][fvModel]);
			cache_get_value_name_float(i, "PosX", FactionVehicle[i][fvPos][0]);
			cache_get_value_name_float(i, "PosY", FactionVehicle[i][fvPos][1]);
			cache_get_value_name_float(i, "PosZ", FactionVehicle[i][fvPos][2]);
			cache_get_value_name_float(i, "PosA", FactionVehicle[i][fvPos][3]);
			cache_get_value_name_int(i, "Color1", FactionVehicle[i][fvColor][0]);
			cache_get_value_name_int(i, "Color2", FactionVehicle[i][fvColor][1]);
			cache_get_value_name_int(i, "Faction", FactionVehicle[i][fvFaction]);

			FactionVehicle[i][fvVehicle] = CreateVehicle(FactionVehicle[i][fvModel], FactionVehicle[i][fvPos][0], FactionVehicle[i][fvPos][1], FactionVehicle[i][fvPos][2], FactionVehicle[i][fvPos][3], FactionVehicle[i][fvColor][0], FactionVehicle[i][fvColor][1], 60000);
			VehCore[FactionVehicle[i][fvVehicle]][vehFuel] = 100;
		}
		printf("[FACTION VEHICLE] Loaded %d faction vehicle from database", cache_num_rows());
	}
	return 1;
}

stock FactionVehicle_Delete(id)
{
	new query[128];
	mysql_format(sqlcon, query, 128, "DELETE FROM `factionvehicle` WHERE `ID` = '%d'", FactionVehicle[id][fvID]);
	mysql_query(sqlcon, query, true);

	if(IsValidVehicle(FactionVehicle[id][fvVehicle]))
		DestroyVehicle(FactionVehicle[id][fvVehicle]);

	FactionVehicle[id][fvExists] = false;
	FactionVehicle[id][fvModel] = 0;
	return 1;
}
stock IsFactionVehicle(vehicleid)
{
	forex(i, MAX_FACTION_VEHICLE) if(FactionVehicle[i][fvExists] && FactionVehicle[i][fvVehicle] == vehicleid)
		return i;

	return -1;
}

CMD:createfactionveh(playerid, params[])
{
	new
	    model[32],
		color1,
		color2,
		factid;

	if(PlayerData[playerid][pAdmin] < 6)
		return SendErrorMessage(playerid, NO_PERMISSION);

	if (sscanf(params, "ds[32]I(-1)I(-1)", factid, model, color1, color2))
	    return SendSyntaxMessage(playerid, "/createfactionveh [factionid] [model id/name] <color 1> <color 2>");

	if(!FactionData[factid][factionExists])
		return SendErrorMessage(playerid, "Invalid factionid!");

	if ((model[0] = GetVehicleModelByName(model)) == 0)
	    return SendErrorMessage(playerid, "Invalid model ID.");

	new
	    Float:x,
	    Float:y,
	    Float:z,
	    Float:a;

	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, a);

	new id = FactionVehicle_Create(FactionData[factid][factionID], model[0], x, y, z, a, color1, color2);

	if(id == -1)
		return SendErrorMessage(playerid, "You cannot create more faction vehicle!");

	SendServerMessage(playerid, "You have successfully create vehicle for faction id %d", factid);
	return 1;
}

CMD:editfactionveh(playerid, params[])
{
	new
	    id,
	    type[24],
	    string[128];

	if (PlayerData[playerid][pAdmin] < 6)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	SendSyntaxMessage(playerid, "/editfactionveh [id] [name]");
	    SendClientMessage(playerid, COLOR_YELLOW, "Names:{FFFFFF} pos");
		return 1;
	}
	if(!strcmp(type, "pos", true))
	{
		if(!IsPlayerInVehicle(playerid, FactionVehicle[id][fvVehicle]))
			return SendErrorMessage(playerid, "You must inside the faction vehicle!");

		GetVehiclePos(GetPlayerVehicleID(playerid), FactionVehicle[id][fvPos][0], FactionVehicle[id][fvPos][1], FactionVehicle[id][fvPos][2]);
		GetVehicleZAngle(GetPlayerVehicleID(playerid), FactionVehicle[id][fvPos][3]);

		SendServerMessage(playerid, "You have adjusted position for faction vehicle id %d", id);
		FactionVehicle_Save(id);
	}

	return 1;
}

CMD:gotofactionveh(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 6)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/gotofactionveh [id]");

	if(!IsNumeric(params))
		return SendErrorMessage(playerid, "Invalid faction vehicle ID!");

	if(!FactionVehicle[strval(params)][fvExists])
		return SendErrorMessage(playerid, "Invalid faction vehicle ID!");

	new
	    Float:x,
	    Float:y,
	    Float:z;

	GetVehiclePos(FactionVehicle[strval(params)][fvVehicle], x, y, z);
	SetPlayerPos(playerid, x, y - 2, z + 2);
	return 1;
}

CMD:destroyfactionveh(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 6)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");
	
	if(isnull(params))
		return SendSyntaxMessage(playerid, "/destroyfactionveh [vehicleid]");

	if(!IsNumeric(params))
		return SendErrorMessage(playerid, "Invalid vehicle ID");

	if(!IsValidVehicle(strval(params)))
		return SendErrorMessage(playerid, "Invalid vehicle ID");

	if(IsFactionVehicle(strval(params)) == -1)
		return SendErrorMessage(playerid, "That vehicle is not faction vehicle!");	

	FactionVehicle_Delete(IsFactionVehicle(strval(params)));
	SendServerMessage(playerid, "You have removed faction vehicle id", IsFactionVehicle(strval(params)));
	return 1;
}