enum 
{
	FISH_NONE,
	FISH_BIG,
	FISH_SMALL,
};

new FishNames[11][11] =
{
	"Carp", "Cat Fish", "Cod", "Conger Eel", "Barracuda", "Herring",
	"Pollack", "Salmon", "Sardine", "Swordfish", "Trout"
};

new FishName[MAX_PLAYERS][10][12];
new Float:FishWeight[MAX_PLAYERS][10];

stock ReturnFishArea(playerid)
{
	forex(i, 3) if(IsPlayerInDynamicArea(playerid, AreaData[areaFishBig][i]))
		return FISH_BIG;

	forex(i, 2) if(IsPlayerInDynamicArea(playerid, AreaData[areaFishSmall][i]))
		return FISH_SMALL;

	return FISH_NONE;
}

FUNC::TimeFishing(playerid)
{
	if(!PlayerData[playerid][pFishing])
		return 0;

	PlayerData[playerid][pFishing] = false;
	ClearAnimations(playerid, 1);
	RemovePlayerAttachedObject(playerid, 9);

	if(ReturnFishArea(playerid) == FISH_NONE)
		return 0;

	new SlotToUse = -1, FishNameId = random(sizeof(FishNames));
	if(FishWeight[playerid][0] == 0) SlotToUse = 0;
	else if(FishWeight[playerid][1] == 0) SlotToUse = 1;
	else if(FishWeight[playerid][2] == 0) SlotToUse = 2;
	else if(FishWeight[playerid][3] == 0) SlotToUse = 3;
	else if(FishWeight[playerid][4] == 0) SlotToUse = 4;
	else if(FishWeight[playerid][5] == 0) SlotToUse = 5;
	else if(FishWeight[playerid][6] == 0) SlotToUse = 6;
	else if(FishWeight[playerid][7] == 0) SlotToUse = 7;
	else if(FishWeight[playerid][8] == 0) SlotToUse = 8;
	else if(FishWeight[playerid][9] == 0) SlotToUse = 9;

	new gacha = random(3);

	if(ReturnFishArea(playerid) == FISH_SMALL)
	{
		if(gacha == 0 || gacha == 2)
		{
		    new fWeight = random(5)+random(3)+5;
		    new desimal = random(5)+random(50);
		    new str[25];
		    format(str, sizeof(str), "%d.%d", fWeight, desimal);
	        FishWeight[playerid][SlotToUse] = floatstr(str);
	        format(FishName[playerid][SlotToUse], 12, FishNames[FishNameId]);
	        SendClientMessageEx(playerid, COLOR_SERVER, "FISH: {FFFFFF}You've caught {FF6347}%s {FFFFFF}with weight {FFFF00}%.2f lbs{FFFFFF}. Type /myfish to see all the fish.", FishName[playerid][SlotToUse], FishWeight[playerid][SlotToUse]);
		}
		else
		{
			SetTimerEx("HidePlayerBox", 500, false, "dd", playerid, _:ShowPlayerBox(playerid, 0xFF000066));
			SendClientMessageEx(playerid, COLOR_RED, "* You've caught a jellyfish and get stinged!");
			if(ReturnHealth(playerid) - 3 <= 7)
			{
				SetPlayerHealth(playerid, ReturnHealth(playerid)-1);
				InjuredPlayer(playerid, INVALID_PLAYER_ID, WEAPON_COLLISION);
			}
			else
			{
				SetPlayerHealth(playerid, ReturnHealth(playerid)-3);
			}
		}
	}
	else if(ReturnFishArea(playerid) == FISH_BIG)
	{
		if(gacha == 0 || gacha == 1)
		{
		    new fWeight = random(19)+random(25)+5;
		    new desimal = random(5)+random(50);
		    new str[25];
		    format(str, sizeof(str), "%d.%d", fWeight, desimal);
	        FishWeight[playerid][SlotToUse] = floatstr(str);
	        format(FishName[playerid][SlotToUse], 12, FishNames[FishNameId]);
	        SendClientMessageEx(playerid, COLOR_SERVER, "FISH: {FFFFFF}You've caught {FF6347}%s {FFFFFF}with weight {FFFF00}%.2f lbs{FFFFFF}. Type /myfish to see all the fish.", FishName[playerid][SlotToUse], FishWeight[playerid][SlotToUse]);
		}
		else
		{
			SendClientMessageEx(playerid, COLOR_RED, "* You've caught a jellyfish and get stinged!");
			if(ReturnHealth(playerid) - 3 <= 7)
			{
				InjuredPlayer(playerid, INVALID_PLAYER_ID, WEAPON_COLLISION);
			}
			else
			{
				SetPlayerHealth(playerid, ReturnHealth(playerid)-3);
			}
		}
	}
	return 1;
}
CMD:sellfish(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1333.7576,1582.0439,3001.0859))
	    return SendErrorMessage(playerid, "You are not inside Fish Factory!");

 	if(FishWeight[playerid][0] == 0 && FishWeight[playerid][1] == 0 && FishWeight[playerid][2] == 0 && FishWeight[playerid][3] == 0 && FishWeight[playerid][4] == 0 && FishWeight[playerid][5] == 0 && FishWeight[playerid][6] == 0 && FishWeight[playerid][7] == 0 && FishWeight[playerid][8] == 0 && FishWeight[playerid][9] == 0)
		return SendErrorMessage(playerid, "You don't have any fish!");
		
	if(PlayerData[playerid][pFishDelay] > 0 && PlayerData[playerid][pAdmin] < 7)
		return SendErrorMessage(playerid, "Please wait %d minute to sold your fishes.", PlayerData[playerid][pFishDelay]/60);

	new str[356];
	format(str, sizeof(str), "Fish\tWeight\tWorth\n");
	for(new i = 0; i < 10; i++) if(FishWeight[playerid][i] != 0)
	{
	    format(str, sizeof(str), "%s%s\t%.2f lbs\t{009000}%s\n", str, FishName[playerid][i], FishWeight[playerid][i], FormatNumber(95 * floatround(FishWeight[playerid][i], floatround_round)));
	}
	ShowPlayerDialog(playerid, DIALOG_SELLFISH, DIALOG_STYLE_TABLIST_HEADERS, "Sell all Fish", str, "Sell All", "Cancel");
	return 1;
}

CMD:buybait(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1331.9070,1575.5684,3001.0859))
		return SendErrorMessage(playerid, "You are not inside Fish Factory!");

	new amount;
	if(sscanf(params, "d", amount))
		return SendSyntaxMessage(playerid, "/buybait [amount] | $0.5 per Bait");

	if(amount < 1 || amount < 0)
		return SendErrorMessage(playerid, "Invalid amount specified!");

	if(GetMoney(playerid) < amount * 5)
		return SendErrorMessage(playerid, "You don't have enough money! ($%s)", FormatNumber(amount * 5));

	if(amount > 100)
		return SendErrorMessage(playerid, "Invalid bait amount!");
	
	Inventory_Add(playerid, "Bait", 19566, amount);
	SendServerMessage(playerid, "You have successfully purchase %d Bait for {00FF00}$%s", amount, FormatNumber(amount * 5));
	GiveMoney(playerid, -amount * 5);
	return 1;
}

CMD:fish(playerid, params[])
{	    
	if(Inventory_Count(playerid, "Bait") < 1)
	    return SendErrorMessage(playerid, "You don't have 'Bait' !");

	if(Inventory_Count(playerid, "Fish Rod") < 1)
	    return SendErrorMessage(playerid, "You don't have 'Fish Rod' !");
	    
	if(PlayerData[playerid][pFishing])
	    return SendErrorMessage(playerid, "Cannot do this at the moment.");
	    
 	if(FishWeight[playerid][0] != 0 && FishWeight[playerid][1] != 0 && FishWeight[playerid][2] != 0 && FishWeight[playerid][3] != 0 && FishWeight[playerid][4] != 0 && FishWeight[playerid][5] != 0 && FishWeight[playerid][6] != 0 && FishWeight[playerid][7] != 0 && FishWeight[playerid][8] != 0 && FishWeight[playerid][9] != 0)
		return SendErrorMessage(playerid, "You cannot bring more fish!");

	if(ReturnFishArea(playerid) == FISH_NONE)
		return SendErrorMessage(playerid, "You are not in any Fishing Area's!");

	if(PlayerData[playerid][pThirst] < 20)
		return SendErrorMessage(playerid, "You are too tired to work.");

	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
		return SendErrorMessage(playerid, "You must be onfoot!");

	PlayerData[playerid][pFishing] = true;
	SetTimerEx("TimeFishing", 20000, false, "i", playerid);
	SendClientMessage(playerid, COLOR_SERVER, "FISH: {FFFFFF}You start fishing, please wait for the moment.");
	Inventory_Remove(playerid, "Bait", 1);
	PlayerData[playerid][pThirst] -= RandomEx(1, 3);
 	ApplyAnimation(playerid, "SAMP", "FishingIdle", 4.1, 0, 0, 0, 1, 0, 1);
	SetPlayerAttachedObject(playerid, 9, 18632, 6, 0.1, 0.05, 0, 0, 180, 180, 0);
	return 1;
}

CMD:myfish(playerid, params[])
{
	new str[512];
	format(str, sizeof(str), "Fish\tWeight\n");
	forex(i, 10)
	{
	    format(str, sizeof(str), "%s%s\t%.2f lbs\n", str, FishName[playerid][i], FishWeight[playerid][i]);
	}
	ShowPlayerDialog(playerid, DIALOG_NONE, DIALOG_STYLE_TABLIST_HEADERS, "Fish List", str, "Close", "");
	return 1;
}
