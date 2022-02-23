enum e_rental
{
	rentID,
	bool:rentExists,
	Float:rentPos[3],
	Float:rentSpawn[4],
	rentModel[2],
	rentPrice[2],
	STREAMER_TAG_3D_TEXT_LABEL:rentText,
	STREAMER_TAG_PICKUP:rentPickup,
	STREAMER_TAG_MAP_ICON:rentIcon,
};

new RentData[MAX_RENTAL][e_rental];

stock Rental_Create(playerid, veh1, veh2)
{
	new
	    Float:x,
	    Float:y,
	    Float:z;

	if (GetPlayerPos(playerid, x, y, z))
	{
		forex(i, MAX_RENTAL)
		{
		    if(!RentData[i][rentExists])
		    {
		        RentData[i][rentExists] = true;
		        RentData[i][rentModel][0] = veh1;
		        RentData[i][rentModel][1] = veh2;
		        RentData[i][rentPos][0] = x;
		        RentData[i][rentPos][1] = y;
		        RentData[i][rentPos][2] = z;
		        RentData[i][rentSpawn][0] = 0;
		        RentData[i][rentSpawn][1] = 0;
		        RentData[i][rentSpawn][2] = 0;
		        
		        Rental_Spawn(i);

		        mysql_tquery(sqlcon, "INSERT INTO `rental` (`Vehicle1`) VALUES(0)", "OnRentalCreated", "d", i);
		        return i;
			}
		}
	}
	return -1;
}

FUNC::OnRentalCreated(id)
{
	if (id == -1 || !RentData[id][rentExists])
	    return 0;

	RentData[id][rentID] = cache_insert_id();
	Rental_Save(id);

	return 1;
}

FUNC::Rental_Load()
{
	new rows = cache_num_rows();
	if(rows)
	{
	    forex(i, rows)
	    {
	        RentData[i][rentExists] = true;
	        cache_get_value_name_int(i, "ID", RentData[i][rentID]);
	        cache_get_value_name_float(i, "PosX", RentData[i][rentPos][0]);
	        cache_get_value_name_float(i, "PosY", RentData[i][rentPos][1]);
	        cache_get_value_name_float(i, "PosZ", RentData[i][rentPos][2]);
	        cache_get_value_name_float(i, "SpawnX", RentData[i][rentSpawn][0]);
	        cache_get_value_name_float(i, "SpawnY", RentData[i][rentSpawn][1]);
	        cache_get_value_name_float(i, "SpawnZ", RentData[i][rentSpawn][2]);
	        cache_get_value_name_float(i, "SpawnA", RentData[i][rentSpawn][3]);
	        cache_get_value_name_int(i, "Vehicle1", RentData[i][rentModel][0]);
	        cache_get_value_name_int(i, "Vehicle2", RentData[i][rentModel][1]);
	        cache_get_value_name_int(i, "Price1", RentData[i][rentPrice][0]);
	        cache_get_value_name_int(i, "Price2", RentData[i][rentPrice][1]);
	        
	        Rental_Spawn(i);
		}
		printf("[RENTAL] Loaded %d Rental from database", rows);
	}
	return 1;
}

stock Rental_Spawn(i)
{
	new string[156];
	format(string, sizeof(string), "[ID %d]\n{FFFFFF}Rental Point\n{FFFFFF}Use {FFFF00}/renthelp", i);
    RentData[i][rentText] = CreateDynamic3DTextLabel(string, COLOR_CLIENT, RentData[i][rentPos][0], RentData[i][rentPos][1], RentData[i][rentPos][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1);
	RentData[i][rentPickup] = CreateDynamicPickup(1239, 23, RentData[i][rentPos][0], RentData[i][rentPos][1], RentData[i][rentPos][2], -1, -1);
	return 1;
}

stock Rental_Delete(id)
{
	if(!RentData[id][rentExists])
		return 0;

    if(IsValidDynamic3DTextLabel(RentData[id][rentText]))
        DestroyDynamic3DTextLabel(RentData[id][rentText]);
        
	if(IsValidDynamicPickup(RentData[id][rentPickup]))
	    DestroyDynamicPickup(RentData[id][rentPickup]);

	new string[64];
	mysql_format(sqlcon, string, sizeof(string), "DELETE FROM `rental` WHERE `ID` = '%d'", RentData[id][rentID]);
	mysql_tquery(sqlcon, string);

	RentData[id][rentID] = 0;
	RentData[id][rentExists] = false;
	return 1;
}

stock Rental_Refresh(id)
{
	if(id != -1 && RentData[id][rentExists])
	{		    
		Streamer_SetFloatData(STREAMER_TYPE_PICKUP, RentData[id][rentPickup], E_STREAMER_X, RentData[id][rentPos][0]);
		Streamer_SetFloatData(STREAMER_TYPE_PICKUP, RentData[id][rentPickup], E_STREAMER_Y, RentData[id][rentPos][1]);
		Streamer_SetFloatData(STREAMER_TYPE_PICKUP, RentData[id][rentPickup], E_STREAMER_Z, RentData[id][rentPos][2]);

		Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, RentData[id][rentText], E_STREAMER_X, RentData[id][rentPos][0]);
		Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, RentData[id][rentText], E_STREAMER_Y, RentData[id][rentPos][1]);
		Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, RentData[id][rentText], E_STREAMER_Z, RentData[id][rentPos][2]);
	}
	return 1;
}

stock Rental_Save(id)
{
	new query[1052];
	mysql_format(sqlcon, query, sizeof(query), "UPDATE `rental` SET ");
	mysql_format(sqlcon, query, sizeof(query), "%s`PosX`='%f', ", query, RentData[id][rentPos][0]);
	mysql_format(sqlcon, query, sizeof(query), "%s`PosY`='%f', ", query, RentData[id][rentPos][1]);
	mysql_format(sqlcon, query, sizeof(query), "%s`PosZ`='%f', ", query, RentData[id][rentPos][2]);
	mysql_format(sqlcon, query, sizeof(query), "%s`SpawnX`='%f', ", query, RentData[id][rentSpawn][0]);
	mysql_format(sqlcon, query, sizeof(query), "%s`SpawnY`='%f', ", query, RentData[id][rentSpawn][1]);
	mysql_format(sqlcon, query, sizeof(query), "%s`SpawnZ`='%f', ", query, RentData[id][rentSpawn][2]);
	mysql_format(sqlcon, query, sizeof(query), "%s`SpawnA`='%f', ", query, RentData[id][rentSpawn][3]);
	mysql_format(sqlcon, query, sizeof(query), "%s`Vehicle1`='%d', ", query, RentData[id][rentModel][0]);
	mysql_format(sqlcon, query, sizeof(query), "%s`Vehicle2`='%d', ", query, RentData[id][rentModel][1]);
	mysql_format(sqlcon, query, sizeof(query), "%s`Price1`='%d', ", query, RentData[id][rentModel][0]);
	mysql_format(sqlcon, query, sizeof(query), "%s`Price2`='%d' ", query, RentData[id][rentModel][1]);
	mysql_format(sqlcon, query, sizeof(query), "%sWHERE `ID` = '%d'", query, RentData[id][rentID]);
	mysql_query(sqlcon, query, true);
	return 1;
}

stock VehicleRental_Count(playerid)
{
	new count = 0;
	foreach(new i : PlayerVehicle) if(VehicleData[i][vRental] != -1 && VehicleData[i][vOwner] == PlayerData[playerid][pID])
	{
	    count++;
	}
	return count;
}

stock VehicleRental_Create(ownerid, modelid, Float:x, Float:y, Float:z, Float:angle, time, rentid)
{

	new i = Iter_Free(PlayerVehicle);

	if(i == INVALID_ITERATOR_SLOT)
		return print("Unable to create rental vehicle!");

	VehicleData[i][vExists] = true;

    VehicleData[i][vModel] = modelid;
    VehicleData[i][vOwner] = ownerid;

	format(VehicleData[i][vPlate], 16, "RENTAL");

    VehicleData[i][vPos][0] = x;
    VehicleData[i][vPos][1] = y;
    VehicleData[i][vPos][2] = z;
    VehicleData[i][vPos][3] = angle;

	VehicleData[i][vInsurance] = 0;
	VehicleData[i][vInsuTime] = 0;

    VehicleData[i][vColor][0] = random(126);

    VehicleData[i][vColor][1] = random(126);
    VehicleData[i][vInsuranced] = false;

    VehicleData[i][vLocked] = false;

	VehicleData[i][vFuel] = 100;
	VehicleData[i][vHealth] = 1000.0;

	VehicleData[i][vRental] = rentid;
	VehicleData[i][vRentTime] = time;
	VehicleData[i][vHouse] = -1;

	VehicleData[i][vVehicle] = CreateVehicle(VehicleData[i][vModel], VehicleData[i][vPos][0], VehicleData[i][vPos][1], VehicleData[i][vPos][2], VehicleData[i][vPos][3], VehicleData[i][vColor][0], VehicleData[i][vColor][1], 60000);
    VehCore[VehicleData[i][vVehicle]][vehFuel] = VehicleData[i][vFuel];
    VehCore[VehicleData[i][vVehicle]][vehWood] = 0;

    SetVehicleNumberPlate(VehicleData[i][vVehicle], VehicleData[i][vPlate]);

    Iter_Add(PlayerVehicle, i);

    mysql_tquery(sqlcon, "INSERT INTO `vehicle` (`vehModel`) VALUES(0)", "OnPlayerVehicleCreated", "d", i);
    return 1;
}

CMD:unrentvehicle(playerid, params[])
{
	new pvid = Vehicle_Inside(playerid);
	new vehicleid = GetPlayerVehicleID(playerid);
	
	if(VehicleRental_Count(playerid) < 1)
	    return SendErrorMessage(playerid, "Kamu tidak memiliki kendaraan Rental!");
	    
	forex(i, MAX_RENTAL) if(RentData[i][rentExists])
	{
	    if(IsPlayerInRangeOfPoint(playerid, 5.0, RentData[i][rentPos][0], RentData[i][rentPos][1], RentData[i][rentPos][2]))
	    {
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			    return SendErrorMessage(playerid, "Kamu harus mengemudi kendaraan Rental milikmu!");
			    
			if(pvid == -1)
			    return SendErrorMessage(playerid, "Kamu harus mengemudi kendaraan Rental milikmu!");

			if(!Vehicle_IsOwner(playerid, pvid))
				return SendErrorMessage(playerid, "Kamu harus mengemudi kendaraan Rental milikmu!");
			
			if(VehicleData[pvid][vRental] != i)
				return SendErrorMessage(playerid, "Disini bukan tempat penyewaan kendaraan ini.");

			SendClientMessageEx(playerid, COLOR_SERVER, "RENTAL: {FFFFFF}Kamu telah mengembalikan %s Rental milikmu!", GetVehicleName(vehicleid));

			Vehicle_Delete(pvid);

		}
	}
	return 1;
}
CMD:rentvehicle(playerid, params[])
{
	if(VehicleRental_Count(playerid) > 0)
	    return SendErrorMessage(playerid, "Kamu hanya bisa memiliki 1 kendaraan Rental!");
	    
	new gstr[256];
	forex(i, MAX_RENTAL) if(RentData[i][rentExists])
	{
	    if(IsPlayerInRangeOfPoint(playerid, 3.0, RentData[i][rentPos][0], RentData[i][rentPos][1], RentData[i][rentPos][2]))
	    {
	        if(RentData[i][rentSpawn][0] == 0)
	            return SendErrorMessage(playerid, "Rental Point ini belum memiliki Spawn Point!");


	        forex(z, 2)
	        {
	            format(gstr, sizeof(gstr), "%s%i\t~w~%s~n~~g~Price: $%s\n", gstr, RentData[i][rentModel][z], GetVehicleModelName(RentData[i][rentModel][z]), FormatNumber(RentData[i][rentPrice][z]));
			}
			ShowPlayerDialog(playerid, DIALOG_RENTAL, DIALOG_STYLE_PREVIEW_MODEL, "Vehicle Rental", gstr, "Select", "Close");
			PlayerData[playerid][pRenting] = i;
		}
	}
	return 1;
}


CMD:rentinfo(playerid, params[])
{
	new bool:have, str[512], time[3];
	format(str, sizeof(str), "Model(ID)\tDuration\n");
	foreach(new i : PlayerVehicle)
	{
		if(Vehicle_IsOwner(playerid, i) && IsValidVehicle(VehicleData[i][vVehicle]) && VehicleData[i][vRental] != -1)
		{
		    GetElapsedTime(VehicleData[i][vRentTime], time[0], time[1], time[2]);
		    format(str, sizeof(str), "%s%s(%d)\t%02d:%02d:%02d\n", str, GetVehicleModelName(VehicleData[i][vModel]),VehicleData[i][vVehicle], time[0], time[1], time[2]);
			have = true;
		}
	}
	if(have)
		ShowPlayerDialog(playerid, DIALOG_NONE, DIALOG_STYLE_TABLIST_HEADERS, "Rental Information", str, "Close", "");
	else
		SendErrorMessage(playerid, "Kamu tidak memiliki kendaraan Rental!");
	return 1;
}

CMD:editrental(playerid, params[])
{
    new
        id,
        type[24],
        string[128];

    if(PlayerData[playerid][pAdmin] < 6)
        return SendErrorMessage(playerid, "You don't have permission to use this command!");
        
    if(sscanf(params, "ds[24]S()[128]", id, type, string))
    {
        SendSyntaxMessage(playerid, "/editrental [id] [name]");
        SendClientMessage(playerid, COLOR_SERVER, "Names:{FFFFFF} location, spawn, vehicle(1-2), price(1-2), delete");
        return 1;
    }
    if((id < 0 || id >= MAX_RENTAL))
        return SendErrorMessage(playerid, "You have specified an invalid ID.");

	if(!RentData[id][rentExists])
        return SendErrorMessage(playerid, "You have specified an invalid ID.");

	if(!strcmp(type, "location", true))
	{
	    GetPlayerPos(playerid, RentData[id][rentPos][0], RentData[id][rentPos][1], RentData[id][rentPos][2]);
	    Rental_Save(id);
	    Rental_Refresh(id);
	    
	    SendClientMessageEx(playerid, COLOR_LIGHTRED, "AdmRental: {FFFFFF}Kamu telah mengubah posisi Rental ID: %d", id);
	}
	else if(!strcmp(type, "vehicle1", true))
	{
	    new val;
	    if(sscanf(string, "d", val))
	        return SendSyntaxMessage(playerid, "/editrental [vehicle1] [model]");
	        
		if(val < 400 || val > 611)
			return SendErrorMessage(playerid, "Vehicle Number can't be below 400 or above 611 !");

		RentData[id][rentModel][0] = val;
		Rental_Save(id);
		SendClientMessageEx(playerid, COLOR_LIGHTRED, "AdmRental: {FFFFFF}Kamu telah mengubah Vehicle Model 1 Rental ID: %d", id);
	}
	else if(!strcmp(type, "vehicle2", true))
	{
	    new val;
	    if(sscanf(string, "d", val))
	        return SendSyntaxMessage(playerid, "/editrental [vehicle2] [model]");

		if(val < 400 || val > 611)
			return SendErrorMessage(playerid, "Vehicle Number can't be below 400 or above 611 !");

		RentData[id][rentModel][1] = val;
		Rental_Save(id);
		SendClientMessageEx(playerid, COLOR_LIGHTRED, "AdmRental: {FFFFFF}Kamu telah mengubah Vehicle Model 2 Rental ID: %d", id);
	}
	else if(!strcmp(type, "price1", true))
	{
	    new val[32];
	    if(sscanf(string, "s[32]", val))
	        return SendSyntaxMessage(playerid, "/editrental [price1] [price]");

		RentData[id][rentPrice][0] = strcash(val);
		Rental_Save(id);
		SendClientMessageEx(playerid, COLOR_LIGHTRED, "AdmRental: {FFFFFF}Kamu telah mengubah Rental Price 1 Rental ID: %d", id);
	}
	else if(!strcmp(type, "price2", true))
	{
	    new val[32];
	    if(sscanf(string, "s", val))
	        return SendSyntaxMessage(playerid, "/editrental [price2] [price]");

		RentData[id][rentPrice][1] = strcash(val);
		Rental_Save(id);
		SendClientMessageEx(playerid, COLOR_LIGHTRED, "AdmRental: {FFFFFF}Kamu telah mengubah Rental Price 2 Rental ID: %d", id);
	}
	else if(!strcmp(type, "spawn", true))
	{
	    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	        return SendErrorMessage(playerid, "Kamu harus berada didalam kendaraan!");
	        
		GetVehiclePos(GetPlayerVehicleID(playerid), RentData[id][rentSpawn][0], RentData[id][rentSpawn][1], RentData[id][rentSpawn][2]);
		GetVehicleZAngle(GetPlayerVehicleID(playerid), RentData[id][rentSpawn][3]);
		
		SendClientMessageEx(playerid, COLOR_LIGHTRED, "AdmRental: {FFFFFF}Kamu telah mengubah posisi Spawn Rental ID: %d", id);
		Rental_Save(id);
	}
	else if(!strcmp(type, "delete", true))
	{
		Rental_Delete(id);
		SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has destroyed Rental ID: %d", PlayerData[playerid][pUCP], id);
	}
	return 1;
}

CMD:renthelp(playerid, params[])
{
	SendClientMessage(playerid, COLOR_SERVER, "RENTAL: {FFFFFF}/rentvehicle - Untuk merental kendaraan");
	SendClientMessage(playerid, COLOR_SERVER, "RENTAL: {FFFFFF}/unrentvehicle - Untuk mengembalikan kendaraan rental");
	SendClientMessage(playerid, COLOR_SERVER, "RENTAL: {FFFFFF}/rentinfo - Untuk melihat semua kendaraan yang dirental");
	return 1;
}

CMD:createrental(playerid, params[])
{
	new vehicle[2], id;

    if (PlayerData[playerid][pAdmin] < 6)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if(sscanf(params, "dd", vehicle[0], vehicle[1]))
		return SendSyntaxMessage(playerid, "/createrental [Vehicle 1] [Vehicle 2]");
		
	id = Rental_Create(playerid, vehicle[0], vehicle[1]);
	
	if(id == -1)
	    return SendErrorMessage(playerid, "Kamu tidak bisa membuat lebih banyak Rental!");
	    
	SendServerMessage(playerid, "Kamu telah membuat Rental Point ID: %d", id);
	return 1;
}
