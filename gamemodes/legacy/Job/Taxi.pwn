FUNC::UpdateFare(playerid, driverid)
{
	PlayerData[playerid][pTotalFare] += PlayerData[driverid][pFare];
	PlayerData[driverid][pTotalFare] = PlayerData[playerid][pTotalFare];
	new string[128];
	format(string, sizeof(string), "Trip_Fare:_~g~$%s", FormatNumber(PlayerData[playerid][pTotalFare]));
	PlayerTextDrawSetString(playerid, FARETOTALTD[playerid], string);
    PlayerTextDrawSetString(driverid, FARETOTALTD[driverid], string);
    return 1;
}

stock CreateTaxi(playerid)
{
	PlayerTextDrawShow(playerid, TAXIBOX[playerid]);
	PlayerTextDrawShow(playerid, FARETD[playerid]);
	PlayerTextDrawShow(playerid, FARETOTALTD[playerid]);
	return 1;
}

stock HideTaxi(playerid)
{
	PlayerTextDrawHide(playerid, TAXIBOX[playerid]);
	PlayerTextDrawHide(playerid, FARETD[playerid]);
	PlayerTextDrawHide(playerid, FARETOTALTD[playerid]);
	return 1;
}

stock Taxi_ShowCalls(playerid)
{
    static
	    string[2048];

	string[0] = 0;

	foreach (new i : Player) if (PlayerData[i][pTaxiCalled])
	{
	    format(string, sizeof(string), "%s%d: %s (%s)\n", string, i, GetName(i), GetSpecificLocation(i));
	}
	if (!strlen(string))
	{
	    SendErrorMessage(playerid, "There are no taxi calls to accept.");
	}
	else ShowPlayerDialog(playerid, DIALOG_TAXI, DIALOG_STYLE_LIST, "Taxi Calls", string, "Accept", "Cancel");
	return 1;
}

CMD:taxi(playerid, params[])
{
	if(PlayerData[playerid][pJob] != JOB_TAXI)
		return SendErrorMessage(playerid, "Kamu bukan seorang Supir Taxi!");

	new
	    type[24],
	    string[128];

	if (sscanf(params, "s[24]S()[128]", type, string))
		return SendSyntaxMessage(playerid, "/taxi [Names]"), SendClientMessage(playerid, COLOR_YELLOW, "Names: {FFFFFF}duty, setfare");

	if(!strcmp(type, "duty", true))
	{
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			return SendErrorMessage(playerid, "You must be inside Taxi Vehicle!");		

		new modelid = GetVehicleModel(GetPlayerVehicleID(playerid));

		if(modelid != 438 && modelid != 420)
			return SendErrorMessage(playerid, "You must be inside Taxi Vehicle!");

	    if(PlayerData[playerid][pThirst] < 15)
	    	return SendErrorMessage(playerid, "Kamu terlalu lelah untuk bekerja!");

		if(!PlayerData[playerid][pJobduty])
		{
			PlayerData[playerid][pJobduty] = true;
			PlayerData[playerid][pFare] = 20;
			SetPlayerColor(playerid, COLOR_YELLOW);
			SendClientMessage(playerid, COLOR_SERVER, "JOB: {FFFFFF}You're now onduty as {FFFF00}Taxi Driver {FFFFFF}you will receive any calls.");
			SendClientMessageEx(playerid, COLOR_SERVER, "JOB: {FFFFFF}Your current fare is {00FF00}$%s {FFFFFF}type {FFFF00}/taxi setfare {FFFFFF}to change.", FormatNumber(PlayerData[playerid][pFare]));
			CreateTaxi(playerid);
			PlayerTextDrawSetString(playerid, FARETD[playerid], sprintf("Fare: ~g~$%s", FormatNumber(PlayerData[playerid][pFare])));
		}
		else
		{
			HideTaxi(playerid);
			PlayerData[playerid][pJobduty] = false;
			SetPlayerColor(playerid, COLOR_WHITE);
			SendClientMessage(playerid, COLOR_SERVER, "JOB: {FFFFFF}You are no longer onduty as {FFFF00}Taxi Driver");
		}
	}
	else if(!strcmp(type, "calls", true))
	{
		if(!PlayerData[playerid][pJobduty])
			return SendErrorMessage(playerid, "You must jobduty first!");

		Taxi_ShowCalls(playerid);	
	}
	else if(!strcmp(type, "setfare", true))
	{
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			return SendErrorMessage(playerid, "You must be inside Taxi Vehicle!");

		new modelid = GetVehicleModel(GetPlayerVehicleID(playerid));

		if(modelid != 438 && modelid != 420)
			return SendErrorMessage(playerid, "You must be inside Taxi Vehicle!");	

		if(!PlayerData[playerid][pJobduty])
			return SendErrorMessage(playerid, "You must jobduty first!");

		new amount;
		if(sscanf(string, "d", amount))
			return SendSyntaxMessage(playerid, "/taxi [setfare] [new fare]");

		if(amount < 1 || amount > 300)
			return SendErrorMessage(playerid, "Fare cannot below 0.01 or above 3.00");

		PlayerData[playerid][pFare] = amount;	
		PlayerTextDrawSetString(playerid, FARETD[playerid], sprintf("Fare: ~g~$%s", FormatNumber(PlayerData[playerid][pFare])));
		SendClientMessageEx(playerid, COLOR_SERVER, "JOB: {FFFFFF}You've adjusted the taxi fare to {00FF00}$%s", FormatNumber(PlayerData[playerid][pFare]));
	}
	return 1;
}