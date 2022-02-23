stock IsLumberVehicle(vehicleid)
{
	new modelid = GetVehicleModel(vehicleid);
	switch (modelid)
	{
	    case 422, 554: return 1;
	}
	return 0;
}
stock GetMaxWood(vehicleid)
{
	new amount;
	if(GetVehicleModel(vehicleid) == 422)
	{
	    amount = 5;
	}
	else if(GetVehicleModel(vehicleid) == 554)
	{
	    amount = 10;
	}
	return amount;
}

FUNC::CutTree(playerid, id)
{
	TreeData[id][treeCut] = false;
	new rand = RandomEx(5, 12);
	ClearAnimations(playerid, 1);
	TogglePlayerControllable(playerid, 1);
	if(TreeData[id][treeProgress] + rand >= 100)
	{
		TreeData[id][treeProgress] = 0;
		SendClientMessage(playerid, COLOR_SERVER, "JOB: {FFFFFF}Good job! You have successfully cutting down the Tree");
		SendClientMessage(playerid, COLOR_SERVER, "JOB: {FFFFFF}Now press {FF0000}H {FFFFFF}to create the wood timber (You must near the Lumberjack Vehicle)");
		TreeData[id][treeCutted] = true;

		MoveDynamicObject(TreeData[id][treeObject], TreeData[id][treePos][0], TreeData[id][treePos][1], TreeData[id][treePos][2], 4.0,  TreeData[id][treePos][3] + 90.0,  TreeData[id][treePos][4],  TreeData[id][treePos][5]);
	}
	else
	{
		TreeData[id][treeProgress] += rand;
		SendClientMessageEx(playerid, COLOR_SERVER, "JOB: {FFFFFF}The tree cutting progress now is {FFFF00}%d percent", TreeData[id][treeProgress]);
		SendClientMessage(playerid, COLOR_SERVER, "JOB: {FFFFFF}Keep cut the tree until the progress is {FFFF00}100 percent");

	}
	return 1;
}

FUNC::CreateTimber(playerid, id, vid)
{
	ClearAnimations(playerid, 1);
	TogglePlayerControllable(playerid, 1);
	TreeData[id][treeCut] = false;
	if(GetNearestVehicle(playerid, 5.0) != vid)
		return SendErrorMessage(playerid, "The nearest vehicle no longer valid!");

	VehCore[vid][vehWood]++;
	SendClientMessageEx(playerid, COLOR_SERVER, "JOB: {FFFFFF}You've successfully loaded timber into the vehicle! (loaded %d/%d)", VehCore[vid][vehWood], GetMaxWood(vid));


	TreeData[id][treeTime] = 3600;
	TreeData[id][treeCutted] = false;
	TreeData[id][treeProgress] = 0;

	if(IsValidDynamicObject(TreeData[id][treeObject]))
		DestroyDynamicObject(TreeData[id][treeObject]);

	return 1;
}

CMD:selltimber(playerid, params[])
{
	if(PlayerData[playerid][pJob] != JOB_LUMBERJACK)
		return SendErrorMessage(playerid, "You are not work as Lumberjack!");

	if(!IsPlayerInRangeOfPoint(playerid, 5.0, -535.0215,-177.6707,78.4047))
		return SendErrorMessage(playerid, "You are not at Timber Storage!");

	new vid = GetPlayerVehicleID(playerid);

	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendErrorMessage(playerid, "You must driving Lumberjack Vehicle!");

	if(!IsLumberVehicle(vid))
		return SendErrorMessage(playerid, "You must driving Lumberjack Vehicle!");

	if(VehCore[vid][vehWood] < 1)
		return SendErrorMessage(playerid, "There is no Timber on this vehicle.");

	new str[156];
	format(str, sizeof(str), "JOB: {FFFFFF}You've sold {FFFF00}%d {FFFFFF}timber and earn {00FF00}$%s {FFFFFF}on Salary.", VehCore[vid][vehWood], FormatNumber(VehCore[vid][vehWood]*2000));
	AddSalary(playerid, "Selling Timber", VehCore[vid][vehWood]*2000);
	SendClientMessage(playerid, COLOR_SERVER, str);
	VehCore[vid][vehWood] = 0;
	return 1;
}
