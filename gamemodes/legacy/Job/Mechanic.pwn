FUNC::TimeRepairTire(playerid, vehicleid)
{
	new nearest = GetNearestVehicle(playerid, 4.0);
	if(nearest != vehicleid)
		return SendErrorMessage(playerid, "The vehicle is no longer valid.");

	SendClientMessage(playerid, COLOR_SERVER, "INFO: {FFFFFF}You've successfully repaired the tires of vehicle!");
	ClearAnimations(playerid, 1);
    PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
	new panels, doors, lights, tires;
    GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
	UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, 0);
	VehCore[vehicleid][vehRepair] = false;
	return 1;
}

FUNC::SprayTimer(playerid)
{
	new modelid = PlayerData[playerid][pColor];
	new vehicleid = PlayerData[playerid][pVehicle];
	new nearest = GetNearestVehicle(playerid, 4.5);
	if(PlayerData[playerid][pSpraying] && PlayerData[playerid][pJob] == JOB_MECHANIC)
	{
		if(nearest != PlayerData[playerid][pVehicle])
		{
		    SendServerMessage(playerid, "Kamu gagal mengganti warna kendaraan!");
			PlayerData[playerid][pSpraying] = false;
			KillTimer(PlayerData[playerid][pSprayTime]);
			ResetWeapon(playerid, 41);
			PlayerData[playerid][pColoring] = 0;
			return 1;
		}
	    if(PlayerData[playerid][pColoring] < 15)
	    {
	        PlayerData[playerid][pColoring]++;
			ShowMessage(playerid, sprintf("~g~Spray the Vehicle: ~y~%d/15", PlayerData[playerid][pColoring]), 1);
	        return 1;
		}
		else if(PlayerData[playerid][pColoring] >= 15)
		{
 		    SendServerMessage(playerid, "Kamu berhasil mengganti warna kendaraan!");
	  		foreach(new i : PlayerVehicle)
			{
				if(vehicleid == VehicleData[i][vVehicle])
				{
					VehicleData[i][vColor][0] = modelid;
					VehicleData[i][vColor][1] = modelid;
				}
			}
			ChangeVehicleColor(vehicleid, modelid, modelid);
			ShowMessage(playerid, "Vehicle ~y~Resprayed!", 3);
			PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
			Inventory_Remove(playerid, "Component", 30);
			KillTimer(PlayerData[playerid][pSprayTime]);
			PlayerData[playerid][pSpraying] = false;
			ResetWeapon(playerid, 41);
			return 1;
		}
	}
	return 1;
}

FUNC::TimeRepairBody(playerid, vehicleid)
{
	new nearest = GetNearestVehicle(playerid, 4.0);
	if(nearest != vehicleid)
		return SendErrorMessage(playerid, "The vehicle is no longer valid.");

	SendClientMessage(playerid, COLOR_SERVER, "INFO: {FFFFFF}You've successfully repaired the body of vehicle!");
	TogglePlayerControllable(playerid, 1);
	ClearAnimations(playerid, 1);
    PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
	new panels, doors, lights, tires;
    GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
	UpdateVehicleDamageStatus(vehicleid, 0, 0, 0, tires);
    VehCore[vehicleid][vehRepair] = false;
	return 1;
}

FUNC::TimeRepairEngine(playerid, vehicleid)
{
	new nearest = GetNearestVehicle(playerid, 4.0);
	if(nearest != vehicleid)
		return SendErrorMessage(playerid, "The vehicle is no longer valid.");

	SetVehicleHealth(vehicleid, 1000.0);
	SendClientMessage(playerid, COLOR_SERVER, "INFO: {FFFFFF}You've successfully repaired the engine of vehicle!");
	ClearAnimations(playerid, 1);
	PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
	VehCore[vehicleid][vehRepair] = false;
	return 1;
}

stock GetComponent(playerid)
{
	return Inventory_Count(playerid, "Component");
}

CMD:mech(playerid, params[])
{

	if(PlayerData[playerid][pJob] != JOB_MECHANIC)
	    return SendErrorMessage(playerid, "You must be a Mechanic!");

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/mech [Names]"), SendClientMessage(playerid, COLOR_SERVER, "Names: {FFFFFF}duty, menu");

	if(!strcmp(params, "menu", true))
	{

		if(IsPlayerInAnyVehicle(playerid))
		    return SendErrorMessage(playerid, "You must exit the vehicle first!");
		    
		if(IsValidLoading(playerid))
		    return SendErrorMessage(playerid, "You can't do this at the moment.");

	    if(!IsPlayerInDynamicArea(playerid, AreaData[areaMechanic]))
	        return SendErrorMessage(playerid, "You're not at Mechanic Area!");

		if(!PlayerData[playerid][pJobduty])
		    return SendErrorMessage(playerid, "You must mechanic duty to use this command.");

		new vehicleid = GetNearestVehicle(playerid, 4.0);
		new Float:health;
		new panels, doors, light, tires;
		
		if(vehicleid == INVALID_VEHICLE_ID)
		    return SendErrorMessage(playerid, "You're not in range of any vehicles!");

	    if(!GetHoodStatus(vehicleid) && !IsABike(vehicleid))
	        return SendErrorMessage(playerid, "The Hood must be Opened.");

		GetVehicleHealth(vehicleid, health);
		if(health > 1000.0) health = 1000.0;
		if(health > 0.0) health *= -1;

		GetVehicleDamageStatus(vehicleid, panels, doors, light, tires);
	    new cpanels = panels / 1000000, string[312];
	    new lights = light / 2;
	    new pintu;
	    if(doors != 0) pintu = 5;
	    if(doors == 0) pintu = 0;
	    PlayerData[playerid][pMechPrice][0] = floatround(health, floatround_round) / 10 + 100;
	    PlayerData[playerid][pMechPrice][1] = cpanels + lights + pintu + 10;

	    format(string, sizeof(string), "Repair Engine\t\t%d Component\nRepair Body\t\t%d Component\nRepair Tire\t\t15 Component\nChange Color\t\t30 Component", PlayerData[playerid][pMechPrice][0], PlayerData[playerid][pMechPrice][1]);
	    ShowPlayerDialog(playerid, DIALOG_MM, DIALOG_STYLE_LIST, "Vehicle Menu", string, "Select", "Close");

	    PlayerData[playerid][pVehicle] = vehicleid;
	}
	else if(!strcmp(params, "duty", true))
	{
	    if(!IsPlayerInDynamicArea(playerid, AreaData[areaMechanic]))
	        return SendErrorMessage(playerid, "You're not at Mechanic Area!");

	    if(PlayerData[playerid][pThirst] < 15)
	    	return SendErrorMessage(playerid, "Kamu terlalu lelah untuk bekerja!");

	    if(!PlayerData[playerid][pJobduty])
	    {
	    	PlayerData[playerid][pJobduty] = true; 
	    	SetPlayerColor(playerid, COLOR_LIGHTGREEN);
	    	SendClientMessage(playerid, COLOR_SERVER, "JOB: {FFFFFF}You're now onduty as a {FFFF00}Mechanic");
	    }
	    else
	    {
	    	PlayerData[playerid][pJobduty] = false;
	    	SetPlayerColor(playerid, COLOR_WHITE);
	    	SendClientMessage(playerid, COLOR_SERVER, "JOB: {FFFFFF}You're now no longer onduty as {FFFF00}Mechanic");
	    }
	}
    return 1;

}
