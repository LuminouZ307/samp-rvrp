new Float:Random_Insu[][] = {
{1084.5837,-1769.7527,13.0623,89.6688},
{1062.8273,-1769.6334,13.0713,89.7929},
{1061.9438,-1743.2505,13.1690,268.8029},
{1097.8928,-1754.9493,13.0594,90.3523}
};

stock GetInsuPrice(modelid)
{
	new price;
	switch(modelid)
	{
		case 448, 461..463, 468, 521, 523, 586, 510: price = 10000;//motorcycle normal
		case 499, 609, 598, 524, 532, 578, 486, 406, 573, 455, 588, 403, 423, 414, 443, 515, 525: price = 13000;//truck
		case 429, 541, 415, 480, 562, 565, 434, 494, 502, 503, 411, 559, 561, 560, 506, 451, 558, 555, 477, 522: price = 30000;//sport vehicle
		case 581, 481, 509: price = 5000;//bicycle
		default: price = 10000;
	}
	return price;
}

CMD:insu(playerid, params[])
{
	if(isnull(params))
		return SendSyntaxMessage(playerid, "/insu [Names]"), SendClientMessage(playerid, COLOR_SERVER, "Names: {FFFFFF}buy, claim");

	if(!IsPlayerInRangeOfPoint(playerid, 5.0, 1111.7264,-1795.5878,16.5938))
		return SendErrorMessage(playerid, "You're not at Insurance Center!");

	if(!strcmp(params, "claim", true))
	{
		new bool:found = false, str[512];
		format(str, sizeof(str), "Model\tInsurance\tStatus\n");
		foreach(new i : PlayerVehicle)
		{
			if(Vehicle_IsOwner(playerid, i))
			{
				if(VehicleData[i][vInsuranced])
				{
					if(VehicleData[i][vInsuTime] != 0)
					{
						format(str, sizeof(str), "%s%s\t%d left\t%s\n", str, ReturnVehicleModelName(VehicleData[i][vModel]), VehicleData[i][vInsurance], ReturnTimelapse(gettime(), VehicleData[i][vInsuTime]));
					}
					else 
					{
						format(str, sizeof(str), "%s%s\t%d left\tClaim now\n", str, ReturnVehicleModelName(VehicleData[i][vModel]), VehicleData[i][vInsurance]);						
					}
					found = true;
				}
			}
		}
		if(found)
			ShowPlayerDialog(playerid, DIALOG_CLAIMINSU, DIALOG_STYLE_TABLIST_HEADERS, "Insuranced Vehicle", str, "Claim", "Close");
		else
			SendErrorMessage(playerid, "There is no your vehicle on Insurance!");
	}
	else if(!strcmp(params, "buy", true))
	{
		new bool:found = false, str[512];
		format(str, sizeof(str), "Model\tInsurance\tPrice\n");
		foreach(new i : PlayerVehicle)
		{
			if(Vehicle_IsOwner(playerid, i) && VehicleData[i][vRentTime] == 0)
			{
				format(str, sizeof(str), "%s%s\t%d Left\t$%s\n", str, ReturnVehicleModelName(VehicleData[i][vModel]), VehicleData[i][vInsurance], FormatNumber(GetInsuPrice(VehicleData[i][vModel])));
				found = true;
			}
		}
		if(found)
			ShowPlayerDialog(playerid, DIALOG_BUYINSU, DIALOG_STYLE_TABLIST_HEADERS, "Purchase Insurance", str, "Purchase", "Close");		
		else
			SendErrorMessage(playerid, "You don't have any vehicle.");
	}
	return 1;
}

CMD:forceinsurance(playerid, params[])
{
	new bool:found = false, msg2[512], targetid;
	if(PlayerData[playerid][pAdmin] < 5)
 		return SendErrorMessage(playerid, NO_PERMISSION);
	    
	if(sscanf(params, "u", targetid))
	    return SendSyntaxMessage(playerid, "/forceinsurance [playerid/PartOfName]");
	    
	if(targetid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Invalid player ID!");
	    
	PlayerData[playerid][pTarget] = targetid;
	new pelir[128];
	format(pelir, sizeof(pelir), "%s Insurance's", GetName(targetid));
	format(msg2, sizeof(msg2), "Model\tPlate\n");
 	foreach(new i : PlayerVehicle)
	{
		if(VehicleData[i][vInsuranced])
		{
			if(Vehicle_IsOwner(targetid, i))
			{
				format(msg2, sizeof(msg2), "%s%s\t%s\n", msg2, GetVehicleModelName(VehicleData[i][vModel]), VehicleData[i][vPlate]);
				found = true;
			}
		}
	}
	if(found)
		ShowPlayerDialog(playerid, DIALOG_FORCEINSURANCE, DIALOG_STYLE_TABLIST_HEADERS, pelir, msg2, "Force", "Close");
	else
		ShowPlayerDialog(playerid, DIALOG_NONE, DIALOG_STYLE_MSGBOX, pelir, "There is no vehicle on insurance!", "Close", "");
	return 1;
}
