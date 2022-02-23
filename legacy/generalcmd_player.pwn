CMD:cursor(playerid, params[])
{
	if(isnull(params))
		return SendSyntaxMessage(playerid, "/cursor [show/hide]");

	if(!strcmp(params, "show", true))
	{
		SelectTextDraw(playerid, COLOR_YELLOW);
	}
	else if(!strcmp(params, "hide", true))
	{
		CancelSelectTextDraw(playerid);
	}
	return 1;
}

CMD:tog(playerid, params[])
	return cmd_toggle(playerid, params);

CMD:toggle(playerid, params[])
{
	if(isnull(params))
		return SendSyntaxMessage(playerid, "/tog(gle) [Names]"), SendClientMessage(playerid, COLOR_SERVER, "Names: {FFFFFF}hud, chatanim, login, ooc, pm");

	if(!strcmp(params, "hud", true))
	{
		if(!PlayerData[playerid][pTogHud])
		{
			PlayerData[playerid][pTogHud] = true;
			forex(i, 8)
			{
				PlayerTextDrawHide(playerid, HUDTD[playerid][i]);
			}
			PlayerTextDrawHide(playerid, TIMETD[playerid]);
			PlayerTextDrawHide(playerid, THIRSTTD[playerid]);
			PlayerTextDrawHide(playerid, THRISTTEXT[playerid]);
			PlayerTextDrawHide(playerid, HUNGERTD[playerid]);
			PlayerTextDrawHide(playerid, HUNGERTEXT[playerid]);
			PlayerTextDrawHide(playerid, CASHTEXT[playerid]);

			TextDrawHideForPlayer(playerid,sen);
			TextDrawHideForPlayer(playerid,koma2);
			SendClientMessage(playerid, COLOR_CLIENT, "HUD: {FFFFFF}You have {FF0000}disabled {FFFFFF}the HUD");

			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsEngineVehicle(GetPlayerVehicleID(playerid)))
			{
		        PlayerTextDrawHide(playerid, FUELTEXT[playerid]);
		        PlayerTextDrawHide(playerid, FUELTD[playerid]);
		        PlayerTextDrawHide(playerid, FUELTEXT[playerid]);
		        PlayerTextDrawHide(playerid, VHPTD[playerid]);
		        PlayerTextDrawHide(playerid, VHPTEXT[playerid]);
		        PlayerTextDrawHide(playerid, SPEEDTEXT[playerid]);
				for (new i = 8; i != 21; i ++)
				{
				    PlayerTextDrawHide(playerid, HUDTD[playerid][i]);
				}
			}
		}
		else
		{
			PlayerData[playerid][pTogHud] = false;
			SendClientMessage(playerid, COLOR_CLIENT, "HUD: {FFFFFF}You have {00FF00}enabled {FFFFFF}the HUD");

			forex(i, 8)
			{
				PlayerTextDrawShow(playerid, HUDTD[playerid][i]);
			}
			PlayerTextDrawShow(playerid, TIMETD[playerid]);
			PlayerTextDrawShow(playerid, THIRSTTD[playerid]);
			PlayerTextDrawShow(playerid, THRISTTEXT[playerid]);
			PlayerTextDrawShow(playerid, HUNGERTD[playerid]);
			PlayerTextDrawShow(playerid, HUNGERTEXT[playerid]);
			PlayerTextDrawShow(playerid, CASHTEXT[playerid]);

			TextDrawShowForPlayer(playerid,sen);
			TextDrawShowForPlayer(playerid,koma2);
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsEngineVehicle(GetPlayerVehicleID(playerid)))
			{
		        PlayerTextDrawShow(playerid, FUELTEXT[playerid]);
		        PlayerTextDrawShow(playerid, FUELTD[playerid]);
		        PlayerTextDrawShow(playerid, FUELTEXT[playerid]);
		        PlayerTextDrawShow(playerid, VHPTD[playerid]);
		        PlayerTextDrawShow(playerid, VHPTEXT[playerid]);
		        PlayerTextDrawShow(playerid, SPEEDTEXT[playerid]);
				for (new i = 8; i != 21; i ++)
				{
				    PlayerTextDrawShow(playerid, HUDTD[playerid][i]);
				}
			}
		}
	}
	else if(!strcmp(params, "ooc", true))
	{
		PlayerData[playerid][pTogGlobal] = !(PlayerData[playerid][pTogGlobal]);
		SendClientMessageEx(playerid, COLOR_CLIENT, "OOC: {FFFFFF}You have %s {FFFFFF}Global OOC chat's!", (PlayerData[playerid][pTogGlobal]) ? ("{FF0000}disabled") : ("{00FF00}enabled"));
	}
	else if(!strcmp(params, "login", true))
	{
		PlayerData[playerid][pTogLogin] = !(PlayerData[playerid][pTogLogin]);
		SendClientMessageEx(playerid, COLOR_CLIENT, "LOGIN: {FFFFFF}You have %s {FFFFFF}Login message's!", (PlayerData[playerid][pTogLogin]) ? ("{FF0000}disabled") : ("{00FF00}enabled"));
	}
	else if(!strcmp(params, "pm", true))
	{
		PlayerData[playerid][pTogPM] = !(PlayerData[playerid][pTogPM]);
		SendClientMessageEx(playerid, COLOR_CLIENT, "PM: {FFFFFF}You have %s {FFFFFF}Private Message!", (PlayerData[playerid][pTogPM]) ? ("{FF0000}disabled") : ("{00FF00}enabled"));
	}
	else if(!strcmp(params, "buy", true))
	{
		PlayerData[playerid][pTogBuy] = !(PlayerData[playerid][pTogBuy]);
		SendClientMessageEx(playerid, COLOR_CLIENT, "BUY: {FFFFFF}You have changed /buy display to %s", (PlayerData[playerid][pTogBuy]) ? ("{FF0000}TextDraw") : ("{00FF00}Dialog list"));
	}
	else if(!strcmp(params, "chatanim", true))
	{
		PlayerData[playerid][pTogAnim] = !(PlayerData[playerid][pTogAnim]);
		SendClientMessageEx(playerid, COLOR_CLIENT, "ANIM: {FFFFFF}You have %s {FFFFFF}Chat animation!", (PlayerData[playerid][pTogAnim]) ? ("{FF0000}disabled") : ("{00FF00}enabled"));
	}
	return 1;
}
CMD:time(playerid, params[])
{
	new
	    string[128],
		month[12],
		date[6];

	getdate(date[2], date[1], date[0]);
	gettime(date[3], date[4], date[5]);

	switch (date[1])
	{
	    case 1: month = "January";
	    case 2: month = "February";
	    case 3: month = "March";
	    case 4: month = "April";
	    case 5: month = "May";
	    case 6: month = "June";
	    case 7: month = "July";
	    case 8: month = "August";
	    case 9: month = "September";
	    case 10: month = "October";
	    case 11: month = "November";
	    case 12: month = "December";
	}
	format(string, sizeof(string), "~g~%s %02d %d~n~~b~%02d:%02d:%02d", month, date[0], date[2], date[3], date[4], date[5]);
	GameTextForPlayer(playerid, string, 6000, 1);
	ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_watch", 4.1, 0, 0, 0, 0, 0);
	if(PlayerData[playerid][pPaycheck] > 0)
	{
	    SendClientMessageEx(playerid, COLOR_SERVER, "INFO: {FFFFFF}Kamu dapat mengambil Paycheck dalam %d Menit lagi.", PlayerData[playerid][pPaycheck]/60);
	}
	else
	{
	    SendClientMessage(playerid, COLOR_SERVER, "INFO: {FFFFFF}Kamu sudah bisa mengambil Paycheck di Bank/ATM sekarang!");
	}
	if(PlayerData[playerid][pOnDuty])
	{
		new hour, minute, second;
		GetElapsedTime(PlayerData[playerid][pDutyTime], hour, minute, second);
		SendClientMessageEx(playerid, COLOR_SERVER, "SALARYINFO: {FFFFFF}Salary dari faction akan di-issue dalam %02d menit dan %02d detik.", minute, second);
	}
	return 1;
}

CMD:clearchat(playerid, params[])
{
	for (new i = 0; i < 100; i ++)
	{
	    SendClientMessage(playerid, -1, "");
	}
	return 1;
}
CMD:sw(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "You must inside a vehicle!");

	if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)
		return SendErrorMessage(playerid, "You must be passenger!");

	new str[512];
	format(str, sizeof(str), "Weapon\tAmmo\n");
	for(new i = 0; i < 13; i++)
	{
		if(PlayerData[playerid][pGuns][i] != 0)
		{
			format(str, sizeof(str), "%s%s\t%d Left\n", str, ReturnWeaponName(PlayerData[playerid][pGuns][i]), PlayerData[playerid][pAmmo][i]);
		}
		else
		{
			format(str, sizeof(str), "%sEmpty slot\n", str);
		}
	}
	ShowPlayerDialog(playerid, DIALOG_DRIVEBY, DIALOG_STYLE_TABLIST_HEADERS, "Switch Weapon (on vehicle)", str, "Switch", "Close");
	return 1;
}

CMD:untow(playerid, params[])
{
	if (GetVehicleModel(GetPlayerVehicleID(playerid)) != 525)
	    return SendErrorMessage(playerid, "You are not driving a tow truck.");

	if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendErrorMessage(playerid, "You are not the driver.");

	new
	    trailerid = GetVehicleTrailer(GetPlayerVehicleID(playerid));

    if (!trailerid)
	    return SendErrorMessage(playerid, "There is no vehicle hooked onto the truck.");

	DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
	SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s has unhooked the %s from the tow truck.", ReturnName(playerid), ReturnVehicleModelName(GetVehicleModel(trailerid)));

	return 1;
}

CMD:tow(playerid, params[])
{
	if (GetVehicleModel(GetPlayerVehicleID(playerid)) != 525)
	    return SendErrorMessage(playerid, "You are not driving a tow truck.");

	if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendErrorMessage(playerid, "You are not the driver.");

	new vehicleid = GetVehicleFromBehind(GetPlayerVehicleID(playerid));

	if (vehicleid == INVALID_VEHICLE_ID)
	    return SendErrorMessage(playerid, "There is no vehicle in range.");

	if (!IsDoorVehicle(vehicleid))
	    return SendErrorMessage(playerid, "You can't tow this vehicle.");

	AttachTrailerToVehicle(vehicleid, GetPlayerVehicleID(playerid));
	SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s has hooked a %s onto their tow truck.", ReturnName(playerid), ReturnVehicleModelName(GetVehicleModel(vehicleid)));
	return 1;
}

CMD:seatbelt(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "You must be inside of any car!");

	if(!IsDoorVehicle(GetPlayerVehicleID(playerid)))
		return SendErrorMessage(playerid, "You must be inside of any car!");

	SetPlayerSeatbelt(playerid);
	return 1;
}

CMD:myproperty(playerid, params[])
{
	new str[1012], date[6], curtime = gettime(), time[3], header[128];
	gettime(time[0], time[1], time[2]);

	TimestampToDate(curtime, date[2], date[1], date[0], date[3], date[4], date[5]);
	format(header, sizeof(header), "{AFAFAF}%s %s %s %i | %02d:%02d:%02d", GetWeekDay(date[0], date[1], date[2]), GetDay(date[0]), GetMonthName(date[1]), date[2], time[0], time[1], time[2]);
	format(str, sizeof(str), "Property Type\tProperty ID\tProperty Location\n");
	foreach(new i : House) if(House_IsOwner(playerid, i))
	{
		format(str, sizeof(str), "%sHouse\t%d\t%s\n", str, i, GetLocation(HouseData[i][housePos][0], HouseData[i][housePos][1], HouseData[i][housePos][2]));
	}
	forex(i, MAX_BUSINESS) if(BizData[i][bizExists] && Biz_IsOwner(playerid, i))
	{
		format(str, sizeof(str), "%sBusiness\t%d\t%s\n", str, i, GetLocation(BizData[i][bizExt][0], BizData[i][bizExt][1], BizData[i][bizExt][2]));
	}
	forex(i, MAX_DEALER) if(DealerData[i][dealerExists] && Dealer_IsOwner(playerid, i))
	{
		format(str, sizeof(str), "%sDealership\t%d\t%s\n", str, i, GetLocation(DealerData[i][dealerPos][0], DealerData[i][dealerPos][1], DealerData[i][dealerPos][2]));
	}
	ShowPlayerDialog(playerid, DIALOG_NONE, DIALOG_STYLE_TABLIST_HEADERS, header, str, "Close", "");
	return 1;
}
CMD:licenses(playerid, params[])
{
	static
	    userid;

	if (sscanf(params, "u", userid))
	{
		SendClientMessage(playerid, COLOR_GREY, "-----------------------------------------------------------");

		if (PlayerData[playerid][pLicense][0]) SendClientMessageEx(playerid, COLOR_WHITE, "Driving License: {33CC33}Passed");
	 	else SendClientMessageEx(playerid, COLOR_WHITE, "Driving License: {AA3333}Not Passed");

		if (PlayerData[playerid][pLicense][1]) SendClientMessageEx(playerid, COLOR_WHITE, "Boat License: {33CC33}Passed");
		else SendClientMessageEx(playerid, COLOR_WHITE, "Boat License: {AA3333}Not Passed");

		if (PlayerData[playerid][pLicense][2]) SendClientMessageEx(playerid, COLOR_WHITE, "Lumberjack License: {33CC33}Passed");
		else SendClientMessageEx(playerid, COLOR_WHITE, "Lumberjack License: {AA3333}Not Passed");

		SendClientMessage(playerid, COLOR_GREY, "-----------------------------------------------------------");
		return 1;
	}

	if (userid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendErrorMessage(playerid, "That player is disconnected or not near you.");

	SendClientMessage(userid, COLOR_GREY, "-----------------------------------------------------------");

	if (PlayerData[playerid][pLicense][0]) SendClientMessageEx(userid, COLOR_WHITE, "Driving License: {33CC33}Passed");
 	else SendClientMessageEx(userid, COLOR_WHITE, "Driving License: {AA3333}Not Passed");

	if (PlayerData[playerid][pLicense][1]) SendClientMessageEx(userid, COLOR_WHITE, "Boat License: {33CC33}Passed");
	else SendClientMessageEx(userid, COLOR_WHITE, "Boat License: {AA3333}Not Passed");

	if (PlayerData[playerid][pLicense][2]) SendClientMessageEx(userid, COLOR_WHITE, "Lumberjack License: {33CC33}Passed");
	else SendClientMessageEx(userid, COLOR_WHITE, "Lumberjack License: {AA3333}Not Passed");

	SendClientMessage(userid, COLOR_GREY, "-----------------------------------------------------------");
	SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s takes out their licenses and shows them to %s.", ReturnName(playerid), ReturnName(userid));
	return 1;
}

CMD:id(playerid, params[])
{
	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/id [playerid/name]");

	if (strlen(params) < 3)
		return SendErrorMessage(playerid, "You must specify at least 3 characters.");

	new count;

	foreach (new i : Player)
	{
	    if (strfind(GetName(i), params, true) != -1)
	    {
	        SendClientMessageEx(playerid, COLOR_SERVER, "* [ID: %d]  - [Name: %s] - [Ping: %d] - [Packetloss: %.2f] - [Level: %d]", i, GetName(i), GetPlayerPing(i), NetStats_PacketLossPercent(i), PlayerData[i][pLevel]);
	        count++;
		}
	}
	if (!count)
	    return SendErrorMessage(playerid, "No users matched the search criteria: \"%s\".", params);

	return 1;
}

CMD:admins(playerid, params[])
{
	new count = 0;

    SendClientMessage(playerid, COLOR_GREY, "-----------------------------------------------------------");

    foreach (new i : Player) if (PlayerData[i][pAdmin] > 0 && !PlayerData[i][pAhide])
	{
        if (PlayerData[i][pAduty])
			SendClientMessageEx(playerid, COLOR_WHITE, "* {FFFF00}%s {FFFFFF}({FF0000}%s{FFFFFF}) Duty: {33CC33}YES", PlayerData[i][pUCP], GetAdminRank(i));

		else
		    SendClientMessageEx(playerid, COLOR_WHITE, "* {FFFF00}%s {FFFFFF}({FF0000}%s{FFFFFF}) Duty: {FF6347}NO", PlayerData[i][pUCP], GetAdminRank(i));

        count++;
	}
	if (!count)
	{
	    SendClientMessage(playerid, COLOR_WHITE, "* No admins online.");
	}
	SendClientMessage(playerid, COLOR_GREY, "-----------------------------------------------------------");
	return 1;
}

CMD:pr(playerid, params[])
{

    if (!Inventory_Count(playerid, "Portable Radio"))
	    return SendErrorMessage(playerid, "You must have a portable radio.");
	    
	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/pr [radio chat]"), SendClientMessage(playerid, COLOR_LIGHTRED, "WARNING: {FFFFFF}Radio chat is only for IC purposes!");

	if (!PlayerData[playerid][pChannel])
	    return SendErrorMessage(playerid, "Your portable radio is disabled (/setfreq).");

	new
	    stringz[128], string[128];
		
	format(stringz, sizeof(stringz), "[RADIO] %s", params);
 	SetPlayerChatBubble(playerid, stringz, 0xF5DEB3FF, 30.0, 5000);

 	foreach(new i : Player) if(PlayerData[i][pChannel] == PlayerData[playerid][pChannel] && Inventory_Count(i, "Portable Radio"))
	{
		if(strlen(params) > 64)
		{
			format(string, sizeof(string), "[CH %d] %s: %.64s", PlayerData[playerid][pChannel], ReturnName(playerid), params);
			SendClientMessageEx(i, 0xF5DEB3FF, string);
			format(string, sizeof(string), "...%s", PlayerData[playerid][pChannel], ReturnName(playerid), params[64]);
			SendClientMessageEx(i, 0xF5DEB3FF, string);
		}
		else
		{
			format(string, sizeof(string), "[CH %d] %s: %s", PlayerData[playerid][pChannel], ReturnName(playerid), params);
			SendClientMessageEx(i, 0xF5DEB3FF, string);			
		}
	}
	return 1;
}

CMD:setfreq(playerid, params[])
{
	new channel;

    if (!Inventory_Count(playerid, "Portable Radio"))
	    return SendErrorMessage(playerid, "You must have a portable radio.");

	if (sscanf(params, "d", channel))
 	{
 	    if(channel == 911)
 	        return SendErrorMessage(playerid, "This frequency only for Police Departement.");
 	        
	 	SendSyntaxMessage(playerid, "/setfreq [radio channel] (0 to disable)");

	 	if (PlayerData[playerid][pChannel] > 0)
			SendClientMessageEx(playerid, COLOR_YELLOW, "NOTE:{FFFFFF} Your current radio channel is set to %d.", PlayerData[playerid][pChannel]);

		return 1;
	}
	if (channel < 0 || channel > 999999)
	    return SendErrorMessage(playerid, "The channel can't be below 0 or above 999,999.");

	PlayerData[playerid][pChannel] = channel;

	if (channel == 0)
	    SendServerMessage(playerid, "You have disabled your portable radio.");

	else SendServerMessage(playerid, "You have set your radio's channel to %d (\"/pr [text]\" to chat).", channel);
	return 1;
}

CMD:shout(playerid, params[])
	return cmd_s(playerid, params);

CMD:s(playerid, params[])
{
	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/s(hout) [shouts chat]");
	    
    params[0] = toupper(params[0]);
	SendNearbyMessage(playerid, 47.0, COLOR_WHITE, "%s shouts: %s!", ReturnName(playerid), params);
	return 1;
}
CMD:health(playerid, params[])
{
	if(!PlayerData[playerid][pSpawned])
	    return SendErrorMessage(playerid, "You're not spawned.");
	    
	new targetid;
	if(sscanf(params, "u", targetid))
	{
		DisplayHealth(playerid, playerid);
		return 1;
	}
	if (targetid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, targetid, 5.0))
	    return SendErrorMessage(playerid, "That player is disconnected or not near you.");
	    
	DisplayHealth(targetid, playerid);
	SendServerMessage(playerid, "You have showing your body status to {FFFF00}%s", ReturnName(targetid));
	return 1;
}

CMD:accept(playerid, params[])
{
	if(isnull(params))
		return SendSyntaxMessage(playerid, "/accept [Options]"), SendClientMessage(playerid, COLOR_SERVER, "Option: {FFFFFF}death, frisk");

	if(!strcmp(params, "death", true))
	{
		new hours, minutes, seconds;
		GetElapsedTime(PlayerData[playerid][pInjuredTime], hours, minutes, seconds);

		if(!PlayerData[playerid][pInjured])
			return SendErrorMessage(playerid, "You are not injured at the moment.");

		if(PlayerData[playerid][pInjuredTime] > 0 && PlayerData[playerid][pAdmin] < 7)
			return SendErrorMessage(playerid, "Kamu harus menunggu %02d menit dan %02d detik untuk accept death!", minutes, seconds);

		PlayerData[playerid][pInjured] = false;
		PlayerData[playerid][pDead] = false;
		ClearAnimations(playerid, 1);
		
	    SetPlayerPos(playerid, 1179.9133,-1327.0813,14.2512);
		     
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerHealth(playerid, 100);
		SetPlayerFacingAngle(playerid, 271.9647);
		SetCameraBehindPlayer(playerid);
		ResetWeapons(playerid);
		SetPlayerHealth(playerid, 100);
        TogglePlayerControllable(playerid, 1);
		SendServerMessage(playerid, "You have been respawned at {FFFF00}All Saints General Hospital {FFFFFF}and fined {FF0000}$50.00");
		GiveMoney(playerid, -5000);
		ResetDamages(playerid);

		if(IsValidDynamic3DTextLabel(PlayerData[playerid][pInjuredLabel]))
			DestroyDynamic3DTextLabel(PlayerData[playerid][pInjuredLabel]);

	}
	else if(!strcmp(params, "drag", true))
	{

		new dragerid = PlayerData[playerid][pDragOffer];
		if(dragerid == INVALID_PLAYER_ID)
			return SendErrorMessage(playerid, "No one offered you a drag request!");

		IsDragging[dragerid] = playerid;

		SendNearbyMessage(dragerid, 20.0, COLOR_PURPLE, "* %s grabs hold of %s and starts dragging them.", ReturnName(playerid), ReturnName(dragerid));
		SendServerMessage(dragerid, "You are now start dragging {FFFF00}%s {FFFFFF}type {00FFFF}/undrag {FFFFFF}to stop.", ReturnName(dragerid));
	}
	else if(!strcmp(params, "frisk", true))
	{
		new targetid = PlayerData[playerid][pFrisked];
		if(targetid == INVALID_PLAYER_ID)
			return SendErrorMessage(playerid, "No one ask you for a frisk!");

		ShowInventory(targetid, playerid);
		PlayerData[playerid][pFrisked] = INVALID_PLAYER_ID;
	}
	return 1;
}

CMD:rcp(playerid, params[])
	return cmd_disablecp(playerid, "");

CMD:disablecp(playerid, params[])
{
	HideWaypoint(playerid);
	DisablePlayerRaceCheckpoint(playerid);
	DisablePlayerCheckpoint(playerid);
	SendServerMessage(playerid, "You have disabled any active checkpoints.");
	return 1;
}

CMD:ask(playerid, params[])
{
	if(PlayerData[playerid][pAsking])
		return SendErrorMessage(playerid, "You already have an active ask.");

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/ask [question]");

	if(strlen(params) >= 64)
		return SendErrorMessage(playerid, "Panjang teks tidak bisa lebih dari 64 huruf!");

	format(PlayerData[playerid][pAsk], 64, params);
	PlayerData[playerid][pAsking] = true;
	SendAdminMessage(COLOR_YELLOW, "ASK from {00FFFF}%s [%d]: {FFFFFF}%s", GetName(playerid), playerid, params);
	SendServerMessage(playerid, "Berhasil mengirim pertanyaan ke Administrator!");
	return 1;
}

CMD:o(playerid, params[])
{
 	new String[256];
	if (ToggleData[togOOC] && PlayerData[playerid][pAdmin] < 1)
	    return SendErrorMessage(playerid, "An administrator has disabled global OOC chat.");

	if(PlayerData[playerid][pTogGlobal])
		return SendErrorMessage(playerid, "You must enabled global ooc chats first.");
	
	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/o [Global OOC]");
	    
	if(PlayerData[playerid][pAduty])
	{
		format(String, sizeof(String), "(( {FF0000}%s %s : {FFFFFF}%s ))", GetAdminRank(playerid), PlayerData[playerid][pUCP], params);
	}
	else
	{
		format(String, sizeof(String), "(( {ADD8E6}Player %s: {FFFFFF}%s ))", GetName(playerid), params);
	}
	foreach(new i : Player) if(!PlayerData[i][pTogGlobal])
	{
		SendClientMessageEx(i, COLOR_WHITE, String);
	}
	return 1;
}

CMD:b(playerid, params[])
{

	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/b [local ooc]");
	    
	SendNearbyMessage(playerid, 15.0, COLOR_WHITE, "(( %s: %s ))",ReturnName(playerid), params);
	return 1;
}

CMD:me(playerid, params[])
{

	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/me [action]");

	if (strlen(params) > 64)
	{
	    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s %.64s", ReturnName(playerid), params);
	    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "...%s", params[64]);
	}
	else
	{
	    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s %s", ReturnName(playerid), params);
	}
	return 1;
}

CMD:ame(playerid, params[])
{
	new
	    string[128];

	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/ame [action]");

	format(string, sizeof(string), "* %s",  params);
 	SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 30.0, 5000);

 	SendClientMessageEx(playerid, COLOR_WHITE, "* [AME]: {D0AEEB}%s", params);
	return 1;
}

CMD:low(playerid, params[])
	return cmd_l(playerid, params);

CMD:l(playerid, params[])
{
	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/(l)ow [low text]");

	if (strlen(params) > 64)
	{
	    params[0] = toupper(params[0]);
	    SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "[low] %s says: %.64s", ReturnName(playerid), params);
	    SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "...%s", params[64]);
	}
	else
	{
 		params[0] = toupper(params[0]);
	    SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "[low] %s says: %s", ReturnName(playerid), params);
	}
	return 1;
}

CMD:do(playerid, params[])
{
	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/do [description]");

	if (strlen(params) > 64) {
	    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %.64s", params);
	    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "...%s (( %s ))", params[64], ReturnName(playerid));
	}
	else 
	{
	    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s (( %s ))", params, ReturnName(playerid));
	}
	return 1;
}

CMD:answer(playerid, params[])
{
	if (!PlayerData[playerid][pIncomingCall])
	    return SendErrorMessage(playerid, "There are no incoming calls to accept.");

	if (PlayerData[playerid][pCuffed])
	    return SendErrorMessage(playerid, "You can't use this command at the moment.");

    if (PlayerData[playerid][pPhoneOff])
    	return SendErrorMessage(playerid, "Your phone must be powered on.");

	new targetid = PlayerData[playerid][pCallLine];

	PlayerData[playerid][pIncomingCall] = 0;
	PlayerData[targetid][pIncomingCall] = 0;

	SendClientMessage(playerid, COLOR_YELLOW, "PHONE:{FFFFFF} You have answered the call.");
	SendClientMessage(targetid, COLOR_YELLOW, "PHONE:{FFFFFF} The other line has accepted the call.");
	SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has accepted the incoming call.", ReturnName(playerid));
	if(!IsPlayerInAnyVehicle(playerid))
	{
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
	}
	SetPlayerAttachedObject(playerid, 3, 18867, 6, 0.0909, -0.0030, 0.0000, 80.4001, 159.8000, 18.0000, 1.0000, 1.0000, 1.0000, 0xFFFFFFFF, 0xFFFFFFFF);
	return 1;
}

CMD:h(playerid, params[])
	return cmd_hangup(playerid, "");

CMD:hangup(playerid, params[])
{
	new targetid = PlayerData[playerid][pCallLine];

	if (targetid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "There are no calls to hangup.");

	if (PlayerData[playerid][pIncomingCall])
	{
	    SendClientMessage(playerid, COLOR_YELLOW, "PHONE:{FFFFFF} You have declined the incoming call.");
	    SendClientMessage(targetid, COLOR_YELLOW, "PHONE:{FFFFFF} The other line has declined the call.");
	    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
	    RemovePlayerAttachedObject(playerid, 3);
	}
	else
	{
        SendClientMessage(playerid, COLOR_YELLOW, "PHONE:{FFFFFF} You have hung up the call.");
	    SendClientMessage(targetid, COLOR_YELLOW, "PHONE:{FFFFFF} The other line has hung up the call.");

	    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has hung up their cellphone.", ReturnName(playerid));
	    SendNearbyMessage(targetid, 30.0, COLOR_PURPLE, "* %s has hung up their cellphone.", ReturnName(targetid));
	    SetPlayerSpecialAction(targetid, SPECIAL_ACTION_STOPUSECELLPHONE);
	    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
	    RemovePlayerAttachedObject(playerid, 3);
	    RemovePlayerAttachedObject(targetid, 3);

	}
	PlayerData[playerid][pIncomingCall] = 0;
	PlayerData[targetid][pIncomingCall] = 0;
	ServiceIndex[playerid] = 0;
	PlayerData[playerid][pCallLine] = INVALID_PLAYER_ID;
	PlayerData[targetid][pCallLine] = INVALID_PLAYER_ID;
	PlayerData[playerid][pCalling] = INVALID_PLAYER_ID;
	PlayerData[targetid][pCalling] = INVALID_PLAYER_ID;
	return 1;
}

CMD:autotreatment(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 4.5, 1256.2085,-1286.8181,1061.1492))
		return SendErrorMessage(playerid, "Kamu tidak berada di ASGH!");

	if(CountFaction(FACTION_MEDIC) > 0)
		return SendErrorMessage(playerid, "Kamu bisa melakukan command ini hanya jika tidak ada LSES Onduty!");

	if(GetMoney(playerid) < 5000)
		return SendErrorMessage(playerid, "Kamu tidak memiliki cukup uang!");

	GiveMoney(playerid, -5000);
	SetPlayerHealth(playerid, 100.0);
	PlayerData[playerid][pHealthy] = 100.0;
	SendServerMessage(playerid, "Kamu berhasil melakukan autotreatment!");
	return 1;
}

CMD:stats(playerid, params[])
{
	ShowStats(playerid, playerid);
	return 1;
}


CMD:deleteado(playerid, params[])
{
	if(!IsValidDynamic3DTextLabel(PlayerADO[playerid]))
		return SendErrorMessage(playerid, "You don't have placed ADO!");

	RemovePlayerADO(playerid);
	SendServerMessage(playerid, "You have removed your placed ADO");
	return 1;
}
CMD:ado(playerid, params[])
{
    static
		String[225],
		msg[128],
		Float:x,
		Float:y,
		Float:z;

    GetPlayerPos(playerid, x, y, z);

	if (sscanf(params,"s[128]",msg))
		return SendClientMessage(playerid,COLOR_GREY, "SYNTAX: {FFFFFF}/ado [text]");

	SendClientMessage(playerid,COLOR_GREY,"INFO: {FFFFFF}ADO Has been placed, use {FFFF00}/deleteado {FFFFFF}to remove your ADO.");

	FormatText(msg);
	format(String,sizeof(String),"%s\n(( %s ))", msg, ReturnName(playerid));
	if (IsPlayerInAnyVehicle(playerid))
	{
	    RemovePlayerADO(playerid);
	    
		new carid = GetPlayerVehicleID(playerid);
		PlayerADO[playerid] = CreateDynamic3DTextLabel(String, COLOR_PURPLE, x, y, 200, 20, INVALID_PLAYER_ID, carid);
	}
	else
	{
	    RemovePlayerADO(playerid);
		PlayerADO[playerid] = CreateDynamic3DTextLabel(String, COLOR_PURPLE, x, y, z, 20);
	}
	return 1;
}

CMD:drag(playerid, params[])
{
	if(IsDragging[playerid] != INVALID_PLAYER_ID) 
		return SendErrorMessage(playerid,"You are already dragging someone.");

	if(IsPlayerInAnyVehicle(playerid)) 
		return SendErrorMessage(playerid,"You can't drag from inside a vehicle.");

	new targetid;
	if(sscanf(params, "u", targetid)) 
		return SendSyntaxMessage(playerid, "/drag [playerid/PartOfName]");

	if(targetid == INVALID_PLAYER_ID)
		return SendErrorMessage(playerid, "You have specified invalid player!");

	if(!IsPlayerNearPlayer(playerid, targetid, 5.0))
		return SendErrorMessage(playerid, "You must close to this player!");

	if(IsPlayerInAnyVehicle(targetid))
		return SendErrorMessage(playerid, "The target must be onfoot!");

	foreach(new i: Player)
	{
		if(IsDragging[i] == targetid) 
			return SendErrorMessage(playerid, "That player is already dragged by someone!");
	}

	SendServerMessage(targetid, "%s has offered to drag you (type \"/accept drag\").", ReturnName(playerid));
	SendServerMessage(playerid, "You have offering drag to %s, please wait for the respond.", ReturnName(targetid));
	PlayerData[targetid][pDragOffer] = playerid;
	return true;
}
CMD:undrag(playerid, params[])
{

	if(IsDragging[playerid] == INVALID_PLAYER_ID) 
		return SendErrorMessage(playerid,"You are not dragging anyone.");

	new targetid = IsDragging[playerid];
	TogglePlayerControllable(targetid, 1);
	SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s releases their grip on %s and lets them go.", ReturnName(playerid), ReturnName(targetid));
	IsDragging[playerid] = INVALID_PLAYER_ID;
	return true;
}

CMD:buycomponent(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 2195.5918,-1977.5160,13.5526))
		return SendErrorMessage(playerid, "Kamu tidak berada di Component Store!");

	new amount;
	if(sscanf(params, "d", amount))
		return SendSyntaxMessage(playerid, "/buycomponent [amount]"), SendClientMessage(playerid, COLOR_YELLOW, "INFO: {FFFFFF}Harga component adalah {00FF00}$0.50 {FFFFFF}per 1 Component.");

	if(amount < 1)
		return SendErrorMessage(playerid, "Invalid amount!");

	if(GetMoney(playerid) < amount*50)
		return SendErrorMessage(playerid, "You don't have enough money!");

	GiveMoney(playerid, -amount*50);
	SendServerMessage(playerid, "Kamu berhasil membeli {FFFF00}%d {FFFFFF}component dengan harga {00FF00}$%s", amount, FormatNumber(amount*50));
	Inventory_Add(playerid, "Component", 19627, amount);
	return 1;
}

CMD:pm(playerid, params[])
{
	new
	    targetid,
		msg[128];
	    
/*	if(!PlayerData[playerid][pSpawn])
	    return SendErrorMessage(playerid, "You're not spawned!");
	    
	if(PlayerData[playerid][pMuted])
	    return SendErrorMessage(playerid, "You're still muted by the system.");*/
	    
	if(sscanf(params, "us[128]", targetid, msg))
	    return SendSyntaxMessage(playerid, "/pm [playerid/PartOfName] [message]");

	if(targetid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Invalid player!");
	    
	if (strlen(msg) > 128)
	    return SendErrorMessage(playerid, "Cannot more than 128 Characters!");

	if(PlayerData[playerid][pTogPM])
	    return SendErrorMessage(playerid, "You must enabled your Private Message!");
	    
	if(PlayerData[targetid][pTogPM])
	    return SendErrorMessage(playerid, "That players has disabled Private Message!");
	    
	SendClientMessageEx(targetid, COLOR_YELLOW, "(( PM From %s[%d]: %s ))", GetName(playerid), playerid, msg);
	SendClientMessageEx(playerid, COLOR_YELLOW, "(( PM To %s[%d]: %s ))", GetName(targetid), targetid, msg);
	PlayerPlaySound(targetid, 1085, 0.0, 0.0, 0.0);
	return 1;
}

CMD:help(playerid, params[])
{
	if(!PlayerData[playerid][pSpawned])
		return SendErrorMessage(playerid, "You're not spawned!");

	ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_LIST, "Help Menu", "General Commands\nChat Commands\nJob Commands\nFaction Commands\nBusiness Commands\nHouse Commands\nBank Commands\nDealership Commands", "Select", "Close");
	return 1;
}

CMD:unimpound(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, -528.2017,467.6121,1368.4100))
		return SendErrorMessage(playerid, "You're not at LSPD lobby!");

	SendServerMessage(playerid, "This feature is Coming Soon!");
	return 1;	
}

CMD:buyplate(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, -528.2017,467.6121,1368.4100))
		return SendErrorMessage(playerid, "You're not at LSPD lobby!");

	new str[512], bool:found = false;
	format(str, sizeof(str), "Model\tPrice\n");
	foreach(new i : PlayerVehicle)
	{
		if(Vehicle_IsOwner(playerid, i) && !strcmp(VehicleData[i][vPlate], "NONE", true))
		{
			format(str, sizeof(str), "%s%s\t$150.00\n", str, ReturnVehicleModelName(VehicleData[i][vModel]));
			found = true;
		}
	}
	if(found)
		ShowPlayerDialog(playerid, DIALOG_BUYPLATE, DIALOG_STYLE_TABLIST_HEADERS, "Vehicle Plate", str, "Buy", "Close");
	else
		SendErrorMessage(playerid, "You don't have any unnamed Vehicle Plate");

	return 1;
}

CMD:weapon(playerid, params[])
{
	new
	    type[24],
	    string[128],
	    weaponid = GetWeapon(playerid);

	if (sscanf(params, "s[24]S()[128]", type, string))
	{
	    SendSyntaxMessage(playerid, "/weapon [Name]");
	    SendClientMessage(playerid, COLOR_YELLOW, "Name:{FFFFFF} give, view, attachment");
	    return 1;
	}
	if(!strcmp(type, "view", true))
	{
		new targetid;
		if(sscanf(string, "u", targetid))
		{
		    ShowWeapon(playerid, playerid);
		    return 1;
		}
		if(targetid == INVALID_PLAYER_ID)
			return SendErrorMessage(playerid, "You're not close to that player!");
			
		if(!IsPlayerNearPlayer(playerid, targetid, 7.0))
			return SendErrorMessage(playerid, "You're not close to that player!");

		ShowWeapon(targetid, playerid);
		SendServerMessage(playerid, "You have showing your weapon list to {FFFF00}%s", ReturnName(targetid));
	}
	else if(!strcmp(type, "attachment", true))
	{
		if(!weaponid)
			return SendErrorMessage(playerid, "You are not holding any weapon.");

		if (EditingWeapon[playerid] != 0)
			return SendErrorMessage(playerid, "You are already editing a weapon attachment");

		if (!IsWeaponWearable(weaponid))
			return SendErrorMessage(playerid, "You can't edit this weapon attachment!");

		ShowPlayerDialog(playerid, DIALOG_HIDEGUN, DIALOG_STYLE_LIST, sprintf("%s Weapon Attachment", ReturnWeaponName(weaponid)), "Edit Attachment Position\nEdit Attachment Bone\nHide Weapon Attachment", "Select", "Close");
	}
	else if(!strcmp(type, "give", true))
	{

		new 
			targetid;

		new
		    ammo = GetPlayerAmmo(playerid);

		if(sscanf(string, "u", targetid))
			return SendSyntaxMessage(playerid, "/weapon give [playerid/PartOfName]");

		if (!weaponid)
		    return SendErrorMessage(playerid, "You are not holding any weapon to pass.");

		if(targetid == INVALID_PLAYER_ID)
			return SendErrorMessage(playerid, "You're not close to that player!");

		if(!IsPlayerNearPlayer(playerid, targetid, 7.0))
			return SendErrorMessage(playerid, "You're not close to that player!");

		if (targetid == playerid)
			return SendErrorMessage(playerid, "You can't give yourself a weapon.");

		if (PlayerData[targetid][pGuns][g_aWeaponSlots[weaponid]] != 0)
		    return SendErrorMessage(playerid, "That player has a weapon in the same slot already.");

		if(PlayerData[targetid][pLevel] < 3)
		    return SendErrorMessage(playerid, "That Player must level 3 first to holding weapon.");

		if(GetFactionType(playerid) == FACTION_POLICE && GetFactionType(targetid) != FACTION_POLICE)
			return SendErrorMessage(playerid, "You only can give weapon to police!");
				    
		ResetWeapon(playerid, weaponid);
		PassWeaponToPlayer(targetid, weaponid, ammo, PlayerData[playerid][pDurability][g_aWeaponSlots[weaponid]]);
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has passed their %s to %s.", ReturnName(playerid), ReturnWeaponName(weaponid), ReturnName(targetid));
	}
	return 1;
}

CMD:paycheck(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, 1460.1772,1400.8265,14.2063))
		return SendErrorMessage(playerid, "Kamu tidak berada di Bank Point!");

	if(PlayerData[playerid][pPaycheck] > 0 && PlayerData[playerid][pAdmin] < 7)
		return SendErrorMessage(playerid, "Kamu harus menunggu %d menit untuk Paycheck!", PlayerData[playerid][pPaycheck]/60);

	new str[256];
	new taxval = PlayerData[playerid][pSalary]/100*GovData[govTax];
	format(str, sizeof(str), "{FFFFFF}Salary: {009000}$%s\n{FFFFFF}Tax: {FFFF00}-$%s {FF0000}(%d percent)\n{FFFFFF}Total Interest: {00FF00}$%s", FormatNumber(PlayerData[playerid][pSalary]), FormatNumber(taxval), GovData[govTax], FormatNumber(PlayerData[playerid][pSalary]-taxval));
	ShowPlayerDialog(playerid, DIALOG_PAYCHECK, DIALOG_STYLE_MSGBOX, "Paycheck", str, "Get", "Close");
	return 1;
}

CMD:transfer(playerid, params[])
{
    new id, cash[32];
    new dollars, cents, totalcash[25];
    if(sscanf(params, "us[32]", id, cash)) 
    	return SendSyntaxMessage(playerid, "/transfer [playerid/PartOfName] [amount (dollar.cents)]");

    if(PlayerData[playerid][pLevel] < 2) 
    	return SendErrorMessage(playerid, "Minimal level 2 untuk menggunakan Command ini.");

 	if(id == INVALID_PLAYER_ID)
 		return SendErrorMessage(playerid, "Invalid player specified.");

 	if(id == playerid)
 		return SendErrorMessage(playerid, "Tidak bisa transfer ke diri sendiri!");

    if(strfind(cash, ".", true) != -1)
    {
		sscanf(cash, "p<.>dd", dollars, cents);
		format(totalcash, sizeof(totalcash), "%d%02d", dollars, cents);

		if(strval(totalcash) < 0) 
			return SendErrorMessage(playerid, "Jumlah tidak bisa dibawah $0.00!");

		if(PlayerData[playerid][pBank] < strval(totalcash))
			return SendErrorMessage(playerid, "Kamu tidak memiliki uang sebanyak itu di bank.");

       	PlayerData[playerid][pBank] -= strval(totalcash); 
		PlayerData[id][pBank] += strval(totalcash);
		SendClientMessageEx(playerid, COLOR_SERVER, "TRANSFER: {FFFFFF}You have successfully transfer {00FF00}$%s {FFFFFF}to {FFFF00}", FormatNumber(strval(totalcash)), GetName(id));
		SendClientMessageEx(id, COLOR_SERVER, "TRANSFER: {FFFFFF}You've received {00FF00}$%s {FFFFFF}from {FFFF00}%s", FormatNumber(strval(totalcash)), GetName(playerid));
	}
	else
	{
		sscanf(cash, "d", dollars);
		format(totalcash, sizeof(totalcash), "%d00", dollars);

		if(strval(totalcash) < 0) 
			return SendErrorMessage(playerid, "Jumlah tidak bisa dibawah $0.00!");

		if(PlayerData[playerid][pBank] < strval(totalcash))
			return SendErrorMessage(playerid, "Kamu tidak memiliki uang sebanyak itu di bank.");

       	PlayerData[playerid][pBank] -= strval(totalcash); 
		PlayerData[id][pBank] += strval(totalcash);
		SendClientMessageEx(playerid, COLOR_SERVER, "TRANSFER: {FFFFFF}You have successfully transfer {00FF00}$%s {FFFFFF}to {FFFF00}", FormatNumber(strval(totalcash)), GetName(id));
		SendClientMessageEx(id, COLOR_SERVER, "TRANSFER: {FFFFFF}You've received {00FF00}$%s {FFFFFF}from {FFFF00}%s", FormatNumber(strval(totalcash)), GetName(playerid));
	}
    return 1;
 }

CMD:balance(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, 1460.1772,1400.8265,14.2063))
		return SendErrorMessage(playerid, "Kamu tidak berada di Bank Point!");

	SendClientMessage(playerid, 0x6896F1FF,     "< ======== Bank Balance ======== >");
	SendClientMessageEx(playerid, -1,   		"Balance: {00FF00}$%s", FormatNumber(PlayerData[playerid][pBank]));
	SendClientMessageEx(playerid, -1,   		"Current Tax: {FFFF00}%d percent", GovData[govTax]);	
	SendClientMessage(playerid, 0x6896F1FF,     "< ============================ >");

	return 1;
}
CMD:deposit(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, 1460.1772,1400.8265,14.2063))
		return SendErrorMessage(playerid, "Kamu tidak berada di Bank Point!");

	new dollars, cents, totalcash[25], cash[32];
	if(sscanf(params, "s[32]", cash))
		return SendSyntaxMessage(playerid, "/deposit [amount (dollar.cents)]");

	if(strfind(cash, ".", true) != -1)
	{
		sscanf(cash, "p<.>dd", dollars, cents);
		format(totalcash, sizeof(totalcash), "%d%02d", dollars, cents);
		if(strval(totalcash) < 0)
			return SendErrorMessage(playerid, "Jumlah tidak bisa dibawah $0.00!");

		if(GetMoney(playerid) < strval(totalcash))
			return SendErrorMessage(playerid, "Kamu tidak membawa uang sebanyak itu!");

		GiveMoney(playerid, -strval(totalcash));
		PlayerData[playerid][pBank] += strval(totalcash);
		SendClientMessageEx(playerid, COLOR_SERVER, "BANK: {FFFFFF}Kamu berhasil menyimpan {009000}$%s {FFFFFF}ke akun Bank!", FormatNumber(strval(totalcash)));
	}
	else
	{
		sscanf(cash, "d", dollars);
		format(totalcash, sizeof(totalcash), "%d00", dollars);

		if(strval(totalcash) < 0)
			return SendErrorMessage(playerid, "Jumlah tidak bisa dibawah $0.00!");

		if(PlayerData[playerid][pBank] < strval(totalcash))
			return SendErrorMessage(playerid, "Kamu tidak membawa uang sebanyak itu!");

		GiveMoney(playerid, -strval(totalcash));
		PlayerData[playerid][pBank] += strval(totalcash);
		SendClientMessageEx(playerid, COLOR_SERVER, "BANK: {FFFFFF}Kamu berhasil menyimpan {009000}$%s {FFFFFF}ke akun Bank!", FormatNumber(strval(totalcash)));
	}
	return 1;
}

CMD:withdraw(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, 1460.1772,1400.8265,14.2063))
		return SendErrorMessage(playerid, "Kamu tidak berada di Bank Point!");

	new dollars, cents, totalcash[25], cash[32];
	if(sscanf(params, "s[32]", cash))
		return SendSyntaxMessage(playerid, "/withdraw [amount (dollar.cents)]");

	if(strfind(cash, ".", true) != -1)
	{
		sscanf(cash, "p<.>dd", dollars, cents);
		format(totalcash, sizeof(totalcash), "%d%02d", dollars, cents);
		if(strval(totalcash) < 0)
			return SendErrorMessage(playerid, "Jumlah tidak bisa dibawah $0.00!");

		if(PlayerData[playerid][pBank] < strval(totalcash))
			return SendErrorMessage(playerid, "Tidak ada uang sebanyak itu dalam Bank-mu!");

		GiveMoney(playerid, strval(totalcash));
		PlayerData[playerid][pBank] -= strval(totalcash);
		SendClientMessageEx(playerid, COLOR_SERVER, "BANK: {FFFFFF}Kamu berhasil mengambil {009000}$%s {FFFFFF}dari akun Bank!", FormatNumber(strval(totalcash)));
	}
	else
	{
		sscanf(cash, "d", dollars);
		format(totalcash, sizeof(totalcash), "%d00", dollars);

		if(strval(totalcash) < 0)
			return SendErrorMessage(playerid, "Jumlah tidak bisa dibawah $0.00!");

		if(PlayerData[playerid][pBank] < strval(totalcash))
			return SendErrorMessage(playerid, "Tidak ada uang sebanyak itu dalam Bank-mu!");

		GiveMoney(playerid, strval(totalcash));
		PlayerData[playerid][pBank] -= strval(totalcash);
		SendClientMessageEx(playerid, COLOR_SERVER, "BANK: {FFFFFF}Kamu berhasil mengambil {009000}$%s {FFFFFF}dari akun Bank!", FormatNumber(strval(totalcash)));
	}
	return 1;
}


CMD:pay(playerid, params[])
{
    new id, cash[32];
    new dollars, cents, totalcash[25];
    if(sscanf(params, "us[32]", id, cash)) 
    	return SendSyntaxMessage(playerid, "/pay [playerid/PartOfName] [amount (dollar.cents)]");

    if(PlayerData[playerid][pLevel] < 2) 
    	return SendErrorMessage(playerid, "Minimal level 2 untuk menggunakan Command ini.");

 	if(id == INVALID_PLAYER_ID)
 		return SendErrorMessage(playerid, "Invalid player specified.");

 	if(id == playerid)
 		return SendErrorMessage(playerid, "You can't pay to yourself!");

 	if(!IsPlayerNearPlayer(playerid, id, 3.0))  
 		return SendErrorMessage(playerid, "You must close to that player!");

    if(strfind(cash, ".", true) != -1)
    {
		sscanf(cash, "p<.>dd", dollars, cents);
		format(totalcash, sizeof(totalcash), "%d%02d", dollars, cents);

		if(strval(totalcash) < 0) 
			return SendErrorMessage(playerid, "Jumlah tidak bisa dibawah $0.00!");

		if(strval(totalcash) > 2000)
			return SendErrorMessage(playerid, "Amount cannot more than $2000.00!");

		if(GetMoney(playerid) < strval(totalcash))
			return SendErrorMessage(playerid, "Kamu tidak memiliki uang sebanyak itu.");

       	GiveMoney(playerid, -strval(totalcash));
		GiveMoney(id, strval(totalcash));
		SendClientMessageEx(id, COLOR_SERVER, "PAYINFO: {FFFFFF}You've received {009000}$%s {FFFFFF}from {00FFFF}%s", FormatNumber(strval(totalcash)), ReturnName(playerid));
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s takes out $%s from their wallet and hands it to %s.", ReturnName(playerid), FormatNumber(strval(totalcash)), ReturnName(id));
		SendClientMessageEx(playerid, COLOR_SERVER, "PAYINFO: {FFFFFF}You've given {009000}$%s {FFFFFF}to {00FFFF}%s", FormatNumber(strval(totalcash)), ReturnName(id));
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		PlayerPlaySound(id, 1052, 0.0, 0.0, 0.0);
        ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
        ApplyAnimation(id, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
        if(!IsPlayerInAnyVehicle(playerid))
        	SetPlayerToFacePlayer(playerid, id);

        if(!IsPlayerInAnyVehicle(id))
        	SetPlayerToFacePlayer(id, playerid);
	}
	else
	{
		sscanf(cash, "d", dollars);
		format(totalcash, sizeof(totalcash), "%d00", dollars);

		if(strval(totalcash) < 0) 
			return SendErrorMessage(playerid, "Jumlah tidak bisa dibawah $0.00!");

		if(strval(totalcash) > 2000)
			return SendErrorMessage(playerid, "Amount cannot more than $2000.00!");
		
		if(GetMoney(playerid) < strval(totalcash))
			return SendErrorMessage(playerid, "Kamu tidak memiliki uang sebanyak itu.");

       	GiveMoney(playerid, -strval(totalcash));
		GiveMoney(id, strval(totalcash));
		SendClientMessageEx(id, COLOR_SERVER, "PAYINFO: {FFFFFF}You've received {009000}$%s {FFFFFF}from {00FFFF}%s", FormatNumber(strval(totalcash)), ReturnName(playerid));
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s takes out $%s from their wallet and hands it to %s.", ReturnName(playerid), FormatNumber(strval(totalcash)), ReturnName(id));
		SendClientMessageEx(playerid, COLOR_SERVER, "PAYINFO: {FFFFFF}You've given {009000}$%s {FFFFFF}to {00FFFF}%s", FormatNumber(strval(totalcash)), ReturnName(id));
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		PlayerPlaySound(id, 1052, 0.0, 0.0, 0.0);
        ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
        ApplyAnimation(id, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
        if(!IsPlayerInAnyVehicle(playerid))
        	SetPlayerToFacePlayer(playerid, id);

        if(!IsPlayerInAnyVehicle(id))
        	SetPlayerToFacePlayer(id, playerid);
	}
    return 1;
}



CMD:frisk(playerid, params[])
{
	new targetid;
	if(sscanf(params, "u", targetid))
		return SendSyntaxMessage(playerid, "/frisk [playerid/PartOfName]");

	if(targetid == INVALID_PLAYER_ID)
		return SendErrorMessage(playerid, "You have specified invalid player!");

	if(!IsPlayerNearPlayer(playerid, targetid, 5.0))
		return SendErrorMessage(playerid, "You must close to that player!");

	PlayerData[targetid][pFrisked] = playerid;
	SendClientMessageEx(playerid, COLOR_SERVER, "INFO: {FFFFFF}You've requested {FFFF00}%s {FFFFFF}For Frisk.",ReturnName(targetid));
	SendClientMessageEx(targetid, COLOR_SERVER, "INFO: {FFFF00}%s {FFFFFF}requested for frisking you, use {00FFFF}/accept frisk", ReturnName(playerid));
	return 1;
}

CMD:getfunds(playerid, params[])
{
	if(PlayerData[playerid][pFunds])
		return SendErrorMessage(playerid, "You have already claimed server starterpack!");

	GiveMoney(playerid, 25000);
	SendServerMessage(playerid, "You have claimed server starterpack with worth {00FF00}$250.00");
	PlayerData[playerid][pFunds] = true;
	return 1;
}

CMD:enter(playerid, params[])
{
	new id;
	if(!IsPlayerInAnyVehicle(playerid))
	{
		forex(bid, MAX_BUSINESS) if(BizData[bid][bizExists])
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, BizData[bid][bizExt][0], BizData[bid][bizExt][1], BizData[bid][bizExt][2]))
			{
				if(BizData[bid][bizLocked])
					return ShowText(playerid, "~r~Locked", 2);

				if(BizData[bid][bizOwner] == -1)
					return SendErrorMessage(playerid, "This business is closed.");

				PlayerData[playerid][pInBiz] = bid;
				SetPlayerPosEx(playerid, BizData[bid][bizInt][0], BizData[bid][bizInt][1], BizData[bid][bizInt][2]);

				SetPlayerInterior(playerid, BizData[bid][bizInterior]);
				SetPlayerVirtualWorld(playerid, BizData[bid][bizWorld]);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, 0);
			}
	    }
		new inbiz = PlayerData[playerid][pInBiz];
		if(PlayerData[playerid][pInBiz] != -1 && IsPlayerInRangeOfPoint(playerid, 2.8, BizData[inbiz][bizInt][0], BizData[inbiz][bizInt][1], BizData[inbiz][bizInt][2]))
		{
			SetPlayerPos(playerid, BizData[inbiz][bizExt][0], BizData[inbiz][bizExt][1], BizData[inbiz][bizExt][2]);

			PlayerData[playerid][pInBiz] = -1;
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetCameraBehindPlayer(playerid);
		}
	    if ((id = House_Nearest(playerid)) != -1)
	    {
	        if (HouseData[id][houseLocked])
	            return ShowText(playerid, "~r~Locked", 2);

			SetPlayerPos(playerid, HouseData[id][houseInt][0], HouseData[id][houseInt][1], HouseData[id][houseInt][2]);
			SetPlayerFacingAngle(playerid, HouseData[id][houseInt][3]);

			SetPlayerInterior(playerid, HouseData[id][houseInterior]);
			SetPlayerVirtualWorld(playerid, HouseData[id][houseID] + 5000);

			SetCameraBehindPlayer(playerid);
			PlayerData[playerid][pInHouse] = HouseData[id][houseID];
			return 1;
		}
		if ((id = House_Inside(playerid)) != -1 && IsPlayerInRangeOfPoint(playerid, 2.5, HouseData[id][houseInt][0], HouseData[id][houseInt][1], HouseData[id][houseInt][2]))
	    {
			SetPlayerPos(playerid, HouseData[id][housePos][0], HouseData[id][housePos][1], HouseData[id][housePos][2]);
			SetPlayerFacingAngle(playerid, HouseData[id][housePos][3] - 180.0);

			SetPlayerInterior(playerid, HouseData[id][houseExterior]);
			SetPlayerVirtualWorld(playerid, HouseData[id][houseExteriorVW]);

			SetCameraBehindPlayer(playerid);
			PlayerData[playerid][pInHouse] = -1;
			return 1;
		}
		forex(i, sizeof(DoorData))
		{
	        if (IsPlayerInRangeOfPoint(playerid,1.0,DoorData[i][ddExteriorX], DoorData[i][ddExteriorY], DoorData[i][ddExteriorZ]))
			{
	            SetPlayerPositionEx(playerid, DoorData[i][ddInteriorX],DoorData[i][ddInteriorY],DoorData[i][ddInteriorZ], DoorData[i][ddInteriorA]);
	            SetPlayerInterior(playerid, DoorData[i][ddInteriorInt]);
	            SetPlayerVirtualWorld(playerid, DoorData[i][ddInteriorVW]);
	            SetCameraBehindPlayer(playerid);
	            Streamer_UpdateEx(playerid, DoorData[i][ddInteriorX],DoorData[i][ddInteriorY],DoorData[i][ddInteriorZ]);

	            PlayerData[playerid][pInDoor] = i;
	        }
	        if (IsPlayerInRangeOfPoint(playerid,1.0,DoorData[i][ddInteriorX], DoorData[i][ddInteriorY], DoorData[i][ddInteriorZ]))
			{
				SetPlayerPositionEx(playerid, DoorData[i][ddExteriorX],DoorData[i][ddExteriorY],DoorData[i][ddExteriorZ], DoorData[i][ddExteriorA]);
				SetPlayerInterior(playerid,DoorData[i][ddExteriorInt]);
				SetPlayerVirtualWorld(playerid, DoorData[i][ddExteriorVW]);
				SetCameraBehindPlayer(playerid);
				PlayerData[playerid][pInDoor] = -1;
	        }
		}
	}
	return 1;
}

CMD:c(playerid, params[])
{
	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/c [Car Chat]");

    if(IsPlayerInAnyVehicle(playerid) && IsWindowedVehicle(GetPlayerVehicleID(playerid)))
    {
		SendVehicleMessage(GetPlayerVehicleID(playerid), 0xBBFFEEFF, "%s says [car]: %s", ReturnName(playerid), params);
	}
	else
	{
	    SendErrorMessage(playerid, "You're not in any Vehicle's!");
	}
	return 1;
}

CMD:whisper(playerid, params[])
	return cmd_w(playerid, params);

CMD:w(playerid, params[])
{
	new userid, text[128];

    if (sscanf(params, "us[128]", userid, text))
	    return SendSyntaxMessage(playerid, "/(w)hisper [playerid/PartOfName] [text]");

	if (userid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, userid, 3.0))
	    return SendErrorMessage(playerid, "That player is disconnected or not near you.");

	if (userid == playerid)
		return SendErrorMessage(playerid, "You can't whisper yourself.");

    if (strlen(text) > 64)
	{
	    text[0] = toupper(text[0]);
	    SendClientMessageEx(userid, COLOR_YELLOW, "* Whisper from %s (%d): %.64s", ReturnName(playerid), playerid, text);
	    SendClientMessageEx(userid, COLOR_YELLOW, "...%s **", text[64]);

	    SendClientMessageEx(playerid, COLOR_YELLOW, "* Whisper to %s (%d): %.64s", ReturnName(userid), userid, text);
	    SendClientMessageEx(playerid, COLOR_YELLOW, "...%s **", text[64]);
	}
	else
	{
	    text[0] = toupper(text[0]);
	    SendClientMessageEx(userid, COLOR_YELLOW, "* Whisper from %s (%d): %s **", ReturnName(playerid), playerid, text);
	    SendClientMessageEx(playerid, COLOR_YELLOW, "* Whisper to %s (%d): %s **", ReturnName(userid), userid, text);
	}
	SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s mutters something in %s's ear.", ReturnName(playerid), ReturnName(userid));
    Log_Write("Logs/whisper_log.txt", "[%s] ** Whisper to %s (%d): %s **", ReturnDate(), ReturnName(userid), userid, text);
	return 1;
}

CMD:vehicle(playerid, params[])
	return cmd_v(playerid, params);

CMD:v(playerid, params[])
{
	new
	    type[24],
	    string[128],
		vehicleid = GetPlayerVehicleID(playerid),
		pvid;

	if (sscanf(params, "s[24]S()[128]", type, string))
	{
	    SendSyntaxMessage(playerid, "/v(ehicle) [name]");
	    SendClientMessage(playerid, COLOR_SERVER, "Names:{FFFFFF} list, lock, engine, hood, trunk, light, attachment");
	    return 1;
	}
	if(!strcmp(type, "engine", true))
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			pvid = Vehicle_GetID(vehicleid);

			if(!IsEngineVehicle(vehicleid))
				return SendErrorMessage(playerid, "You're not inside of any engine vehicle!");

			if(pvid != -1 && !Vehicle_HaveAccess(playerid, pvid))
				return ShowMessage(playerid, "~r~ERROR ~w~Kamu tidak memiliki kunci kendaraan ini!", 2);
				
			if(GetEngineStatus(vehicleid))
			{
			    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s inserts the key into the ignition and stops the engine.", ReturnName(playerid));
				EngineStatus(playerid, vehicleid);
			}
			else
			{
				if(VehCore[vehicleid][vehHandbrake])
					return SendErrorMessage(playerid, "Please disable vehicle handbrake first!");

			    ShowMessage(playerid, "Turning on the engine....", 3);
				SetTimerEx("EngineStatus", 3000, false, "id", playerid, vehicleid);
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s inserts the key into the ignition and starts the engine.", ReturnName(playerid));
			}
		}
	}
	else if(!strcmp(type, "attachment", true))
	{
		if(!IsPlayerInAnyVehicle(playerid))
			return SendErrorMessage(playerid, "You must be inside of any Vehicle's!");
	        
	    if(GetEngineStatus(GetPlayerVehicleID(playerid)))
	        return SendErrorMessage(playerid, "Turn off the engine first!");
	        
		new veh = Vehicle_Inside(playerid);
		if(veh == -1)
		    return SendErrorMessage(playerid, "You're not inside valid player vehicle!");
		    
	    if(IsPlayerInDynamicArea(playerid, AreaData[areaMechanic]))
		{
			format(string, sizeof(string), "idx\tModel\tSlot Status\n");
			forex(i, 5)
			{
				if(VehicleData[veh][vToyID][i] != 0)
				{
					format(string, sizeof(string), "%s%d\t%d\t{FF0000}Unavailable{FFFFFF}\n", string, i + 1, VehicleData[veh][vToyID][i]);
				}	
				else
				{
					format(string, sizeof(string), "%s%d\tINVALID_OBJECT_ID\t{00FF00}Available{FFFFFF}\n", string, i + 1);
				}
			}
			ShowPlayerDialog(playerid, DIALOG_MODSHOP, DIALOG_STYLE_TABLIST_HEADERS, "Vehicle Attachment(s)", string, "Select", "Cancel");
			PlayerData[playerid][pVehicle] = veh;
		}
		else
			SendErrorMessage(playerid, "You must be in Mechanic Center!");
	}
	else if(!strcmp(type, "hood", true))
	{
	    if(IsPlayerInAnyVehicle(playerid))
			return SendErrorMessage(playerid, "You must be in front of Vehicle.");

	    new vvehicleid = GetNearestVehicle(playerid, 4.5);

	    if(vvehicleid == INVALID_VEHICLE_ID)
	    	return SendErrorMessage(playerid, "You're not in range of any vehicles.");

	    switch (VehCore[vvehicleid][vehHood])
	    {
	    	case false:
	    	{
	    		SwitchVehicleBonnet(vvehicleid, true);
	    		ShowMessage(playerid, "Hood ~g~Opened", 1);
	   		 	ApplyAnimation(playerid, "CARRY", "liftup", 3.0, 0, 0, 0, 0, 0);
	   		 	VehCore[vvehicleid][vehHood] = true;
	    	}
	    	case true:
	    	{
	    		SwitchVehicleBonnet(vvehicleid, false);
	    		ShowMessage(playerid, "Hood ~r~Closed", 1);
	    		ApplyAnimation(playerid, "CARRY", "putdwn", 3.0, 0, 0, 0, 0, 0);
	    		VehCore[vvehicleid][vehHood] = false;
	    	}
	    }
	}
	else if(!strcmp(type, "trunk", true))
	{

		new vvehicleid = GetNearestVehicle(playerid, 4.5);

		if(vvehicleid == INVALID_VEHICLE_ID)
			return SendErrorMessage(playerid, "You are not in behind of any vehicle!");

		if(!IsPlayerNearBoot(playerid, vvehicleid))
			return SendErrorMessage(playerid, "You are not in behind of any vehicle!");

    	switch (GetTrunkStatus(vvehicleid))
    	{
    		case false:
    		{
    			SwitchVehicleBoot(vvehicleid, true);
    			ShowMessage(playerid, "Trunk ~g~Opened", 1);
    		}
    		case true:
    		{
    			SwitchVehicleBoot(vvehicleid, false);
    			ShowMessage(playerid, "Trunk ~r~Closed", 1);
    		}
    	}
	}
	else if(!strcmp(type, "light", true))
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			if(!IsEngineVehicle(vehicleid))
				return SendErrorMessage(playerid, "This vehicle doesn't have a lights!");

			switch(GetLightStatus(vehicleid))
			{
				case false:
				{
					SwitchVehicleLight(vehicleid, true);
					SendClientMessage(playerid, COLOR_SERVER, "VEHICLE: {FFFFFF}Lights {00FF00}ON");
				}
				case true:
				{
					SwitchVehicleLight(vehicleid, false);
					SendClientMessage(playerid, COLOR_SERVER, "VEHICLE: {FFFFFF}Lights {FF0000}OFF");
				}
			}
		}
	}
	else if(!strcmp(type, "lock", true))
	{
		new bool:found = false, carid = -1;

		if(IsPlayerInAnyVehicle(playerid))
		{
			if((carid = Vehicle_Inside(playerid)) != -1)
			{
				if(Vehicle_HaveAccess(playerid, carid))
				{
					PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
					VehicleData[carid][vLocked] = !(VehicleData[carid][vLocked]);
					LockVehicle(VehicleData[carid][vVehicle], VehicleData[carid][vLocked]);

					ShowMessage(playerid, sprintf("%s %s", GetVehicleName(VehicleData[carid][vVehicle]), (VehicleData[carid][vLocked]) ? ("~r~Locked") : ("~g~Unlocked")), 3);
				}
				else
					return SendClientMessage(playerid, -1, "You don't have key for this vehicle!");
			}
		}
		else
		{
			new str[512];
			format(str, sizeof(str), "VehiceId\tModel\tStatus\n");
			foreach(new i : PlayerVehicle) if(IsValidVehicle(VehicleData[i][vVehicle]) && Vehicle_HaveAccess(playerid, i))
			{
				format(str, sizeof(str), "%s%d\t%s\t%s\n", str, VehicleData[i][vVehicle], GetVehicleName(VehicleData[i][vVehicle]), (VehicleData[i][vLocked]) ? ("{FF0000}Locked") : ("{00FF00}Unlocked"));
			}
			found = true;
			if(found)
				ShowPlayerDialog(playerid, DIALOG_LOCK, DIALOG_STYLE_TABLIST_HEADERS, "Lock Vehicle", str, "Select", "Close");
			else
				SendErrorMessage(playerid, "You don't have any vehicle.");
		}
	}
	else if(!strcmp(type, "handbrake", true))
	{
		if(vehicleid == INVALID_VEHICLE_ID)
			return SendErrorMessage(playerid, "You must driving a vehicle!");

		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			return SendErrorMessage(playerid, "You must driving a vehicle!");

		if(!IsDoorVehicle(vehicleid))
			return SendErrorMessage(playerid, "You can't handbrake this vehicle!");
		
		if(GetEngineStatus(vehicleid))
			return SendErrorMessage(playerid, "Turn off your vehicle engine first!");

		VehCore[vehicleid][vehHandbrake] = (!VehCore[vehicleid][vehHandbrake]);
		SendClientMessageEx(playerid, COLOR_SERVER, "VEHICLE: {FFFFFF}You have successfully %s {FFFFFF}vehicle Handbrake!", (VehCore[vehicleid][vehHandbrake]) ? ("{00FF00}engaged") : ("{FF0000}disengaged"));
		GetVehiclePos(vehicleid, VehCore[vehicleid][vehHandbrakePos][0], VehCore[vehicleid][vehHandbrakePos][1], VehCore[vehicleid][vehHandbrakePos][2]);
		GetVehicleZAngle(vehicleid, VehCore[vehicleid][vehHandbrakePos][3]);
	}
	else if(!strcmp(type, "list", true))
	{
	    new bool:have, str[512];
	    format(str, sizeof(str), "Model\tPlate\tInsurance\n");
		foreach(new i : PlayerVehicle)
		{
		    if(Vehicle_IsOwner(playerid, i))
		    {
		        if(VehicleData[i][vInsuTime] != 0)
		        {
		            format(str, sizeof(str), "%s%s(Insurance)\t%s\t%d Left\n", str, GetVehicleModelName(VehicleData[i][vModel]), VehicleData[i][vPlate], VehicleData[i][vInsurance]);
				}
				else if(VehicleData[i][vRental] != -1)
		        {
		            format(str, sizeof(str), "%s%s(Rental)\t%s\tN/A\n", str, GetVehicleModelName(VehicleData[i][vModel]), VehicleData[i][vPlate]);
				}
				else if(VehicleData[i][vHouse] != -1)
		        {
		            format(str, sizeof(str), "%s%s(House Parked)\t%s\t%d Left\n", str, GetVehicleModelName(VehicleData[i][vModel]), VehicleData[i][vPlate], VehicleData[i][vInsurance]);
				}
				else
				{
		            format(str, sizeof(str), "%s%s(ID: %d)\t%s\t%d Left\n", str, GetVehicleModelName(VehicleData[i][vModel]), VehicleData[i][vVehicle], VehicleData[i][vPlate], VehicleData[i][vInsurance]);
				}
			}
			have = true;
		}
		if(have)
		    ShowPlayerDialog(playerid, DIALOG_MV, DIALOG_STYLE_TABLIST_HEADERS, "Vehicle List", str, "Close", "");
		else
			SendErrorMessage(playerid, "You don't have any Vehicles!");
	}
	return 1;
}