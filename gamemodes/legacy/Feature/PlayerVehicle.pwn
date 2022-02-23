enum vData
{
	vID,
	vOwner,
	vColor[2],
	vModel,
	vLocked,
	vInsuranced,
	vInsurance,
	vInsuTime,
	vPlate[16],
	Float:vHealth,
	Float:vPos[4],
	vWorld,
	vInterior,
	vFuel,
	vVehicle,
	vDamage[4],
	bool:vExists,
	vRental,
	vRentTime,
	vHouse,
	vWood,
	vMod[17],
	STREAMER_TAG_OBJECT:vToy[5],
	vToyID[5],
	cAttachedToy[5],
	Float:vToyPosX[5],
	Float:vToyPosY[5],
	Float:vToyPosZ[5],
	Float:vToyRotX[5],
	Float:vToyRotY[5],
	Float:vToyRotZ[5],
};
new VehicleData[MAX_PLAYER_VEHICLE][vData];
new Iterator:PlayerVehicle<MAX_PLAYER_VEHICLE>;

stock Vehicle_Nearest(playerid, Float:range = 4.5)
{
	static
	Float:fX,
	Float:fY,
	Float:fZ;

 	foreach(new i : PlayerVehicle)
	{
	    if(IsValidVehicle(VehicleData[i][vVehicle]))
	    {
			GetVehiclePos(VehicleData[i][vVehicle], fX, fY, fZ);

			if(IsPlayerInRangeOfPoint(playerid, range, fX, fY, fZ))
			{
				return i;
			}
		}
	}
	return -1;
}

stock RespawnVehicle(vehicleid)
{
	new id = Vehicle_GetID(vehicleid);

	if (id != -1)
	{
	    Vehicle_GetStatus(id);
	    
	    if(IsValidVehicle(VehicleData[id][vVehicle]))
			DestroyVehicle(VehicleData[id][vVehicle]);
			

		for(new idx = 0; idx < 5; idx ++)
		{
			if(IsValidDynamicObject(VehicleData[id][vToy][idx]))
				DestroyDynamicObject(VehicleData[id][vToy][idx]);
		}
		OnPlayerVehicleRespawn(id);
	}
	else
	{
		SetVehicleToRespawn(vehicleid);
	}
	return 1;
}

FUNC::LoadPveh()
{
	foreach(new i : Player) if(PlayerData[i][pSpawned])
	{
		LoadPlayerVehicle(i);
	}	
	return 1;
}

FUNC::ReloadPveh()
{
	foreach(new i : Player) if(PlayerData[i][pSpawned])
	{
		UnloadPlayerVehicle(i);
	}	
	Iter_Clear(PlayerVehicle);
	SetTimer("LoadPveh", 2000, false);
}

stock Vehicle_Delete(vid)
{
	if(!Iter_Contains(PlayerVehicle, vid))
		return 0;

	for(new idx = 0; idx < 5; idx ++)
	{
		if(IsValidDynamicObject(VehicleData[vid][vToy][idx]))
			DestroyDynamicObject(VehicleData[vid][vToy][idx]);
	}
	forex(c, MAX_CRATES) if(CrateData[c][crateExists] && CrateData[c][crateVehicle] == VehicleData[vid][vID])
	{
		CrateData[c][crateExists] = false;
		CrateData[c][crateVehicle] = -1;
		CrateData[c][crateType] = 0;
	}
	new query[128];
	mysql_format(sqlcon, query, sizeof(query), "DELETE FROM vehicle WHERE vehID = '%d'", VehicleData[vid][vID]);
	mysql_query(sqlcon, query, true);

    VehicleData[vid][vExists] = false;
   
	if(IsValidVehicle(VehicleData[vid][vVehicle]))
		DestroyVehicle(VehicleData[vid][vVehicle]);

    Iter_SafeRemove(PlayerVehicle, vid, vid);

	return 1;
}

stock IsVehicleCanSpawn(vehicleid)
{
	if(!VehicleData[vehicleid][vInsuranced] && VehicleData[vehicleid][vHouse] == -1)
		return 1;

	return 0;
}

stock Vehicle_GetID(vehicleid)
{
	foreach(new i : PlayerVehicle) if (VehicleData[i][vVehicle] == vehicleid)
	{
	    return i;
	}
	return -1;
}

stock Vehicle_Count(playerid)
{
	new count = 0;
	foreach(new i : PlayerVehicle) if(VehicleData[i][vOwner] == PlayerData[playerid][pID] && VehicleData[i][vRental] == -1)
	{
	    count++;
	}
	return count;
}

stock Vehicle_Inside(playerid)
{
	new carid;

	if (IsPlayerInAnyVehicle(playerid) && (carid = Vehicle_GetID(GetPlayerVehicleID(playerid))) != -1)
	    return carid;

	return -1;
}

FUNC::OnPlayerVehicleCreated(carid)
{
	if (carid == -1 || !VehicleData[carid][vExists])
	    return 0;

	VehicleData[carid][vID] = cache_insert_id();
	VehicleData[carid][vExists] = true;
	SaveVehicle(carid);
	return 1;
}

FUNC::Vehicle_GetStatus(carid)
{
	if(IsValidVehicle(VehicleData[carid][vVehicle]))
	{
		GetVehicleDamageStatus(VehicleData[carid][vVehicle], VehicleData[carid][vDamage][0], VehicleData[carid][vDamage][1], VehicleData[carid][vDamage][2], VehicleData[carid][vDamage][3]);

		GetVehicleHealth(VehicleData[carid][vVehicle], VehicleData[carid][vHealth]);
		VehicleData[carid][vFuel] = VehCore[VehicleData[carid][vVehicle]][vehFuel];
		VehicleData[carid][vWood] = VehCore[VehicleData[carid][vVehicle]][vehWood];

		VehicleData[carid][vWorld] = GetVehicleVirtualWorld(VehicleData[carid][vVehicle]);

		GetVehiclePos(VehicleData[carid][vVehicle], VehicleData[carid][vPos][0], VehicleData[carid][vPos][1], VehicleData[carid][vPos][2]);
		GetVehicleZAngle(VehicleData[carid][vVehicle],VehicleData[carid][vPos][3]);

	}
	return 1;
}

stock Vehicle_IsOwner(playerid, carid)
{
	if(PlayerData[playerid][pID] == -1)
		return 0;

	if(Iter_Contains(PlayerVehicle, carid) && VehicleData[carid][vOwner] == PlayerData[playerid][pID])
		return 1;

	return 0;
}

stock Crate_Count(vid)
{
	new count = 0;
	forex(i, MAX_CRATES) if(CrateData[i][crateExists] && CrateData[i][crateVehicle] == VehicleData[vid][vID])
	{
		count++;
	}
	return count;
}

FUNC::OnLoadCrate(carid)
{
	new rows = cache_num_rows();
	if(rows)
	{
		forex(i, rows)
		{
			CrateData[i][crateExists] = true;
			cache_get_value_name_int(i, "ID", CrateData[i][crateID]);
			cache_get_value_name_int(i, "Vehicle", CrateData[i][crateVehicle]);
			cache_get_value_name_int(i, "Type", CrateData[i][crateType]);
		}
		printf("[CRATE] Loaded %d crate for Vehicle SQLID %d", rows, VehicleData[carid][vID]);
	}
	return 1;
}

stock Vehicle_HaveAccess(playerid, carid)
{
	if(PlayerData[playerid][pID] == -1)
		return 0;

	if(Iter_Contains(PlayerVehicle, carid) && VehicleData[carid][vOwner] == PlayerData[playerid][pID])
		return 1;

	return 0;
}
FUNC::UnloadPlayerVehicle(playerid)
{
 	foreach(new i : PlayerVehicle)
	{
		if(Vehicle_IsOwner(playerid, i))
		{   
		    SaveVehicle(i);

			forex(c, MAX_CRATES) if(CrateData[c][crateExists] && CrateData[c][crateVehicle] == VehicleData[i][vID])
			{
				CrateData[c][crateExists] = false;
				CrateData[c][crateVehicle] = -1;
				CrateData[c][crateType] = 0;
			}

			for(new idx = 0; idx < 5; idx ++)
			{
				if(IsValidDynamicObject(VehicleData[i][vToy][idx]))
					DestroyDynamicObject(VehicleData[i][vToy][idx]);
			}

			if(IsValidVehicle(VehicleData[i][vVehicle]))
				DestroyVehicle(VehicleData[i][vVehicle]);

			VehicleData[i][vExists] = false;

			Iter_SafeRemove(PlayerVehicle, i, i);
		}
	}
	return 1;
}

stock Vehicle_Create(ownerid, modelid, Float:x, Float:y, Float:z, Float:angle, color1, color2)
{

	new i = Iter_Free(PlayerVehicle);

	if(i == INVALID_ITERATOR_SLOT)
		return print("Unable to create player vehicle!");

	VehicleData[i][vExists] = true;

	VehicleData[i][vModel] = modelid;
	VehicleData[i][vOwner] = ownerid;


	format(VehicleData[i][vPlate], 16, "NONE");

	VehicleData[i][vPos][0] = x;
	VehicleData[i][vPos][1] = y;
	VehicleData[i][vPos][2] = z;
	VehicleData[i][vPos][3] = angle;

	VehicleData[i][vInsurance] = 3;
	VehicleData[i][vInsuTime] = 0;

	VehicleData[i][vColor][0] = color1;

	VehicleData[i][vColor][1] = color2;

	VehicleData[i][vLocked] = false;
	VehicleData[i][vInsuranced] = false;
	VehicleData[i][vFuel] = 100;
	VehicleData[i][vHealth] = 1000.0;
	VehicleData[i][vRentTime] = 0;
	VehicleData[i][vRental] = -1;
	VehicleData[i][vHouse] = -1;

	VehicleData[i][vVehicle] = CreateVehicle(VehicleData[i][vModel], VehicleData[i][vPos][0], VehicleData[i][vPos][1], VehicleData[i][vPos][2], VehicleData[i][vPos][3], VehicleData[i][vColor][0], VehicleData[i][vColor][1], 60000);
	VehCore[VehicleData[i][vVehicle]][vehFuel] = VehicleData[i][vFuel];
	VehCore[VehicleData[i][vVehicle]][vehWood] = 0;

	forex(v, 5)
	{
		VehicleData[i][vToyID][v] = 0;
	}
	SetVehicleNumberPlate(VehicleData[i][vVehicle], VehicleData[i][vPlate]);

	Iter_Add(PlayerVehicle, i);

	mysql_tquery(sqlcon, "INSERT INTO `vehicle` (`vehModel`) VALUES(0)", "OnPlayerVehicleCreated", "d", i);
	return 1;
}

FUNC::LoadPlayerVehicle(playerid)
{
	new query[128];
	mysql_format(sqlcon, query, sizeof(query), "SELECT * FROM `vehicle` WHERE `vehOwner` = %d", PlayerData[playerid][pID]);
	mysql_query(sqlcon, query, true);
	new count = cache_num_rows();
	if(count > 0)
	{
		forex(z,count)
		{
		    new i = Iter_Free(PlayerVehicle);
		    
			VehicleData[i][vExists] = true;
			cache_get_value_name_int(z, "vehID", VehicleData[i][vID]);
			cache_get_value_name_int(z, "vehOwner", VehicleData[i][vOwner]);
			cache_get_value_name_int(z, "vehLocked", VehicleData[i][vLocked]);
			cache_get_value_name_float(z, "vehX", VehicleData[i][vPos][0]);
			cache_get_value_name_float(z, "vehY", VehicleData[i][vPos][1]);
			cache_get_value_name_float(z, "vehZ", VehicleData[i][vPos][2]);
			cache_get_value_name_float(z, "vehA", VehicleData[i][vPos][3]);
            cache_get_value_name_float(z, "vehHealth", VehicleData[i][vHealth]);
            cache_get_value_name_int(z, "vehModel", VehicleData[i][vModel]);
            cache_get_value_name_int(z, "vehDamage1", VehicleData[i][vDamage][0]);
            cache_get_value_name_int(z, "vehDamage2", VehicleData[i][vDamage][1]);
            cache_get_value_name_int(z, "vehDamage3", VehicleData[i][vDamage][2]);
            cache_get_value_name_int(z, "vehDamage4", VehicleData[i][vDamage][3]);
            cache_get_value_name_int(z, "vehInterior", VehicleData[i][vInterior]);
            cache_get_value_name_int(z, "vehWorld", VehicleData[i][vWorld]);
            cache_get_value_name_int(z, "vehColor1", VehicleData[i][vColor][0]);
            cache_get_value_name_int(z, "vehColor2", VehicleData[i][vColor][1]);
            cache_get_value_name_int(z, "vehFuel", VehicleData[i][vFuel]);
            cache_get_value_name_int(z, "vehInsurance", VehicleData[i][vInsurance]);
            cache_get_value_name_int(z, "vehInsuTime", VehicleData[i][vInsuTime]);
            cache_get_value_name(z, "vehPlate", VehicleData[i][vPlate]);
            cache_get_value_name_int(z, "vehRental", VehicleData[i][vRental]);
            cache_get_value_name_int(z, "vehRentalTime", VehicleData[i][vRentTime]);
            cache_get_value_name_int(z, "vehInsuranced", VehicleData[i][vInsuranced]);
            cache_get_value_name_int(z, "vehHouse", VehicleData[i][vHouse]);
            cache_get_value_name_int(z, "vehWood", VehicleData[i][vWood]);
			cache_get_value_name_int(z, "mod0", VehicleData[i][vMod][0]);
			cache_get_value_name_int(z, "mod1", VehicleData[i][vMod][1]);
			cache_get_value_name_int(z, "mod2", VehicleData[i][vMod][2]);
			cache_get_value_name_int(z, "mod3", VehicleData[i][vMod][3]);
			cache_get_value_name_int(z, "mod4", VehicleData[i][vMod][4]);
			cache_get_value_name_int(z, "mod5", VehicleData[i][vMod][5]);
			cache_get_value_name_int(z, "mod6", VehicleData[i][vMod][6]);
			cache_get_value_name_int(z, "mod7", VehicleData[i][vMod][7]);
			cache_get_value_name_int(z, "mod8", VehicleData[i][vMod][8]);
			cache_get_value_name_int(z, "mod9", VehicleData[i][vMod][9]);
			cache_get_value_name_int(z, "mod10", VehicleData[i][vMod][10]);
			cache_get_value_name_int(z, "mod11", VehicleData[i][vMod][11]);
			cache_get_value_name_int(z, "mod12", VehicleData[i][vMod][12]);
			cache_get_value_name_int(z, "mod13", VehicleData[i][vMod][13]);
			cache_get_value_name_int(z, "mod14", VehicleData[i][vMod][14]);
			cache_get_value_name_int(z, "mod15", VehicleData[i][vMod][15]);
			cache_get_value_name_int(z, "mod16", VehicleData[i][vMod][16]);

			cache_get_value_name_int(z, "toyid0", VehicleData[i][vToyID][0]);
			cache_get_value_name_int(z, "toyid1", VehicleData[i][vToyID][1]);
			cache_get_value_name_int(z, "toyid2", VehicleData[i][vToyID][2]);
			cache_get_value_name_int(z, "toyid3", VehicleData[i][vToyID][3]);
			cache_get_value_name_int(z, "toyid4", VehicleData[i][vToyID][4]);
			
			cache_get_value_name_float(z, "toyposx0", VehicleData[i][vToyPosX][0]);
			cache_get_value_name_float(z, "toyposy0", VehicleData[i][vToyPosY][0]);
			cache_get_value_name_float(z, "toyposz0", VehicleData[i][vToyPosZ][0]);
			
			cache_get_value_name_float(z, "toyposx1", VehicleData[i][vToyPosX][1]);
			cache_get_value_name_float(z, "toyposy1", VehicleData[i][vToyPosY][1]);
			cache_get_value_name_float(z, "toyposz1", VehicleData[i][vToyPosZ][1]);
			
			cache_get_value_name_float(z, "toyposx2", VehicleData[i][vToyPosX][2]);
			cache_get_value_name_float(z, "toyposy2", VehicleData[i][vToyPosY][2]);
			cache_get_value_name_float(z, "toyposz2", VehicleData[i][vToyPosZ][2]);
			
			cache_get_value_name_float(z, "toyposx3", VehicleData[i][vToyPosX][3]);
			cache_get_value_name_float(z, "toyposy3", VehicleData[i][vToyPosY][3]);
			cache_get_value_name_float(z, "toyposz3", VehicleData[i][vToyPosZ][3]);
			
			cache_get_value_name_float(z, "toyposx4", VehicleData[i][vToyPosX][4]);
			cache_get_value_name_float(z, "toyposy4", VehicleData[i][vToyPosY][4]);
			cache_get_value_name_float(z, "toyposz4", VehicleData[i][vToyPosZ][4]);
			
			cache_get_value_name_float(z, "toyrotx0", VehicleData[i][vToyRotX][0]);
			cache_get_value_name_float(z, "toyroty0", VehicleData[i][vToyRotY][0]);
			cache_get_value_name_float(z, "toyrotz0", VehicleData[i][vToyRotZ][0]);

			cache_get_value_name_float(z, "toyrotx1", VehicleData[i][vToyRotX][1]);
			cache_get_value_name_float(z, "toyroty1", VehicleData[i][vToyRotY][1]);
			cache_get_value_name_float(z, "toyrotz1", VehicleData[i][vToyRotZ][1]);

			cache_get_value_name_float(z, "toyrotx2", VehicleData[i][vToyRotX][2]);
			cache_get_value_name_float(z, "toyroty2", VehicleData[i][vToyRotY][2]);
			cache_get_value_name_float(z, "toyrotz2", VehicleData[i][vToyRotZ][2]);

			cache_get_value_name_float(z, "toyrotx3", VehicleData[i][vToyRotX][3]);
			cache_get_value_name_float(z, "toyroty3", VehicleData[i][vToyRotY][3]);
			cache_get_value_name_float(z, "toyrotz3", VehicleData[i][vToyRotZ][3]);

			cache_get_value_name_float(z, "toyrotx4", VehicleData[i][vToyRotX][4]);
			cache_get_value_name_float(z, "toyroty4", VehicleData[i][vToyRotY][4]);
			cache_get_value_name_float(z, "toyrotz4", VehicleData[i][vToyRotZ][4]);


            Iter_Add(PlayerVehicle, i);

			if(IsVehicleCanSpawn(i))
			{
				mysql_tquery(sqlcon, sprintf("SELECT * FROM `crates` WHERE `Vehicle` = '%d'", VehicleData[i][vID]), "OnLoadCrate", "d", i);

				VehicleData[i][vVehicle] = CreateVehicle(VehicleData[i][vModel], VehicleData[i][vPos][0], VehicleData[i][vPos][1], VehicleData[i][vPos][2], VehicleData[i][vPos][3], VehicleData[i][vColor][0], VehicleData[i][vColor][1], 60000);
				SetVehicleNumberPlate(VehicleData[i][vVehicle], VehicleData[i][vPlate]);
				SetVehicleVirtualWorld(VehicleData[i][vVehicle], VehicleData[i][vWorld]);
				LinkVehicleToInterior(VehicleData[i][vVehicle], VehicleData[i][vInterior]);
				VehCore[VehicleData[i][vVehicle]][vehFuel] = VehicleData[i][vFuel];
				VehCore[VehicleData[i][vVehicle]][vehWood] = VehicleData[i][vWood];
				if(VehicleData[i][vHealth] < 350.0)
				{
					SetVehicleHealth(VehicleData[i][vVehicle], 350.0);
				}
				else
				{
					SetVehicleHealth(VehicleData[i][vVehicle], VehicleData[i][vHealth]);
				}
				UpdateVehicleDamageStatus(VehicleData[i][vVehicle], VehicleData[i][vDamage][0], VehicleData[i][vDamage][1], VehicleData[i][vDamage][2], VehicleData[i][vDamage][3]);
				LockVehicle(VehicleData[i][vVehicle], VehicleData[i][vLocked]);
				for(new idx = 0; idx < 5; idx ++)
				{
				    if(VehicleData[i][vToyID][idx] != 0)
				    {
				        VehicleData[i][vToy][idx] = CreateDynamicObject(VehicleData[i][vToyID][idx], VehicleData[i][vToyPosX][idx], VehicleData[i][vToyPosY][idx], VehicleData[i][vToyPosZ][idx], VehicleData[i][vToyRotX][idx], VehicleData[i][vToyRotY][idx], VehicleData[i][vToyRotZ][idx],  -1, -1, -1, 50.0, 0.0);
						AttachDynamicObjectToVehicle(VehicleData[i][vToy][idx], VehicleData[i][vVehicle], VehicleData[i][vToyPosX][idx], VehicleData[i][vToyPosY][idx], VehicleData[i][vToyPosZ][idx], VehicleData[i][vToyRotX][idx], VehicleData[i][vToyRotY][idx], VehicleData[i][vToyRotZ][idx]);
					}
				}
			}
		}
		printf("[VEHICLE] Loaded %d player vehicle from: %s(%d)", count, GetName(playerid), playerid);
	}
	return 1;
}

FUNC::OnPlayerVehicleRespawn(i)
{
	VehicleData[i][vVehicle] = CreateVehicle(VehicleData[i][vModel], VehicleData[i][vPos][0], VehicleData[i][vPos][1], VehicleData[i][vPos][2], VehicleData[i][vPos][3], VehicleData[i][vColor][0], VehicleData[i][vColor][1], 60000);
	SetVehicleNumberPlate(VehicleData[i][vVehicle], VehicleData[i][vPlate]);
	SetVehicleVirtualWorld(VehicleData[i][vVehicle], VehicleData[i][vWorld]);
	LinkVehicleToInterior(VehicleData[i][vVehicle], VehicleData[i][vInterior]);
	VehCore[VehicleData[i][vVehicle]][vehFuel] = VehicleData[i][vFuel];
	VehCore[VehicleData[i][vVehicle]][vehWood] = VehicleData[i][vWood];
	if(VehicleData[i][vHealth] < 350.0)
	{
		SetVehicleHealth(VehicleData[i][vVehicle], 350.0);
	}
	else
	{
		SetVehicleHealth(VehicleData[i][vVehicle], VehicleData[i][vHealth]);
	}
	UpdateVehicleDamageStatus(VehicleData[i][vVehicle], VehicleData[i][vDamage][0], VehicleData[i][vDamage][1], VehicleData[i][vDamage][2], VehicleData[i][vDamage][3]);
	LockVehicle(VehicleData[i][vVehicle], VehicleData[i][vLocked]);
	for(new idx = 0; idx < 5; idx ++)
	{
	    if(VehicleData[i][vToyID][idx] != 0)
	    {
	        VehicleData[i][vToy][idx] = CreateDynamicObject(VehicleData[i][vToyID][idx], VehicleData[i][vToyPosX][idx], VehicleData[i][vToyPosY][idx], VehicleData[i][vToyPosZ][idx], VehicleData[i][vToyRotX][idx], VehicleData[i][vToyRotY][idx], VehicleData[i][vToyRotZ][idx],  -1, -1, -1, 50.0, 0.0);
			AttachDynamicObjectToVehicle(VehicleData[i][vToy][idx], VehicleData[i][vVehicle], VehicleData[i][vToyPosX][idx], VehicleData[i][vToyPosY][idx], VehicleData[i][vToyPosZ][idx], VehicleData[i][vToyRotX][idx], VehicleData[i][vToyRotY][idx], VehicleData[i][vToyRotZ][idx]);
		}
	}
    return 1;
}

stock SaveVehicle(i)
{
	Vehicle_GetStatus(i);

	new cQuery[2512];
	mysql_format(sqlcon, cQuery, sizeof(cQuery), "UPDATE `vehicle` SET ");
	mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`vehX`='%f', ", cQuery, VehicleData[i][vPos][0]);
	mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`vehY`='%f', ", cQuery, VehicleData[i][vPos][1]);
	mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`vehZ`='%f', ", cQuery, VehicleData[i][vPos][2]+0.1);
	mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`vehA`='%f', ", cQuery, VehicleData[i][vPos][3]);
	mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`vehOwner`='%d', ", cQuery, VehicleData[i][vOwner]);
    mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`vehColor1`='%d', ", cQuery, VehicleData[i][vColor][0]);
    mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`vehColor2`='%d', ", cQuery, VehicleData[i][vColor][1]);
    mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`vehModel`='%d', ", cQuery, VehicleData[i][vModel]);
    mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`vehHealth`='%f', ", cQuery, VehicleData[i][vHealth]);
    mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`vehDamage1`='%d', ", cQuery, VehicleData[i][vDamage][0]);
    mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`vehDamage2`='%d', ", cQuery, VehicleData[i][vDamage][1]);
    mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`vehDamage3`='%d', ", cQuery, VehicleData[i][vDamage][2]);
    mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`vehDamage4`='%d', ", cQuery, VehicleData[i][vDamage][3]);
    mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`vehInterior`='%d', ", cQuery, VehicleData[i][vInterior]);
    mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`vehWorld`='%d', ", cQuery, VehicleData[i][vWorld]);
    mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`vehFuel`='%d', ", cQuery, VehicleData[i][vFuel]);
    mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`vehLocked`='%d', ", cQuery, VehicleData[i][vLocked]);
    mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`vehPlate`='%s', ", cQuery, VehicleData[i][vPlate]);
    mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`vehRental`='%d', ", cQuery, VehicleData[i][vRental]);
    mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`vehHouse`='%d', ", cQuery, VehicleData[i][vHouse]);
    mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`vehWood`='%d', ", cQuery, VehicleData[i][vWood]);
	new tempString[56];
	for(new z = 0; z < 17; z++)
	{
		format(tempString, sizeof(tempString), "mod%d", z);
		mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`%s`='%d', ", cQuery, tempString, VehicleData[i][vMod][z]);
	}
	mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyid0` = '%d', ", cQuery, VehicleData[i][vToyID][0]);
	mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyid1` = '%d', ", cQuery, VehicleData[i][vToyID][1]);
	mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyid2` = '%d', ", cQuery, VehicleData[i][vToyID][2]);
    mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyid3` = '%d', ", cQuery, VehicleData[i][vToyID][3]);
    mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyid4` = '%d', ", cQuery, VehicleData[i][vToyID][4]);

	mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyposx0` = '%f', ", cQuery, VehicleData[i][vToyPosX][0]);
	mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyposx1` = '%f', ", cQuery, VehicleData[i][vToyPosX][1]);
	mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyposx2` = '%f', ", cQuery, VehicleData[i][vToyPosX][2]);
    mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyposx3` = '%f', ", cQuery, VehicleData[i][vToyPosX][3]);
    mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyposx4` = '%f', ", cQuery, VehicleData[i][vToyPosX][4]);

	mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyposy0` = '%f', ", cQuery, VehicleData[i][vToyPosY][0]);
	mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyposy1` = '%f', ", cQuery, VehicleData[i][vToyPosY][1]);
	mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyposy2` = '%f', ", cQuery, VehicleData[i][vToyPosY][2]);
    mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyposy3` = '%f', ", cQuery, VehicleData[i][vToyPosY][3]);
    mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyposy4` = '%f', ", cQuery, VehicleData[i][vToyPosY][4]);

	mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyposz0` = '%f', ", cQuery, VehicleData[i][vToyPosZ][0]);
	mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyposz1` = '%f', ", cQuery, VehicleData[i][vToyPosZ][1]);
	mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyposz2` = '%f', ", cQuery, VehicleData[i][vToyPosZ][2]);
    mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyposz3` = '%f', ", cQuery, VehicleData[i][vToyPosZ][3]);
    mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyposz4` = '%f', ", cQuery, VehicleData[i][vToyPosZ][4]);

	mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyrotx0` = '%f', ", cQuery, VehicleData[i][vToyRotX][0]);
	mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyrotx1` = '%f', ", cQuery, VehicleData[i][vToyRotX][1]);
	mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyrotx2` = '%f', ", cQuery, VehicleData[i][vToyRotX][2]);
    mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyrotx3` = '%f', ", cQuery, VehicleData[i][vToyRotX][3]);
    mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyrotx4` = '%f', ", cQuery, VehicleData[i][vToyRotX][4]);

	mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyroty0` = '%f', ", cQuery, VehicleData[i][vToyRotY][0]);
	mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyroty1` = '%f', ", cQuery, VehicleData[i][vToyRotY][1]);
	mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyroty2` = '%f', ", cQuery, VehicleData[i][vToyRotY][2]);
    mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyroty3` = '%f', ", cQuery, VehicleData[i][vToyRotY][3]);
    mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyroty4` = '%f', ", cQuery, VehicleData[i][vToyRotY][4]);

	mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyrotz0` = '%f', ", cQuery, VehicleData[i][vToyRotZ][0]);
	mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyrotz1` = '%f', ", cQuery, VehicleData[i][vToyRotZ][1]);
	mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyrotz2` = '%f', ", cQuery, VehicleData[i][vToyRotZ][2]);
	mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyrotz3` = '%f', ", cQuery, VehicleData[i][vToyRotZ][3]);
	mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`toyrotz4` = '%f', ", cQuery, VehicleData[i][vToyRotZ][4]);
	
    mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`vehRentalTime`='%d', ", cQuery, VehicleData[i][vRentTime]);
    mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`vehInsurance`='%d', ", cQuery, VehicleData[i][vInsurance]);
    mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`vehInsuranced`='%d', ", cQuery, VehicleData[i][vInsuranced]);
    mysql_format(sqlcon, cQuery, sizeof(cQuery), "%s`vehInsuTime`='%d' ", cQuery, VehicleData[i][vInsuTime]);
	mysql_format(sqlcon, cQuery, sizeof(cQuery), "%sWHERE `vehID` = %d", cQuery, VehicleData[i][vID]);
	mysql_query(sqlcon, cQuery, true);
	
	return 1;
}
