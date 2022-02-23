enum adData
{
	advertID,
	advertExists,
	advertOwner,
	advertText[64],
	advertNumber,
	advertName[32],
	advertTime,
};
new AdvertData[MAX_ADVERT][adData];

stock Advert_Show(playerid)
{
	new list[2012];
	format(list, sizeof(list), "Owner\tAdvertisement\n");
	for(new i; i < MAX_ADVERT; i++) if(AdvertData[i][advertExists])
	{
	    format(list, sizeof(list), "%s%s[#%d]\t%s\n", list, AdvertData[i][advertName], AdvertData[i][advertNumber], AdvertData[i][advertText]);
	}
	ShowPlayerDialog(playerid, DIALOG_NONE, DIALOG_STYLE_TABLIST_HEADERS, "Advertisement List", list, "Close", "");
	return 1;
}

stock Advert_Count()
{
	new count = 0;
	for(new i = 0; i < MAX_ADVERT; i ++) if(AdvertData[i][advertExists])
	{
	    count++;
	}
	return count;
}
stock Advert_CountPlayer(playerid)
{
	new count = 0;
	for(new i = 0; i < MAX_ADVERT; i ++) if(AdvertData[i][advertExists])
	{
	    if(AdvertData[i][advertOwner] == PlayerData[playerid][pID])
	    {
	        count++;
		}
	}
	return count;
}
stock Advert_Create(playerid, text[])
{
	for(new i = 0; i < MAX_ADVERT; i ++) if(!AdvertData[i][advertExists])
	{
	    AdvertData[i][advertExists] = true;
	    AdvertData[i][advertOwner] = PlayerData[playerid][pID];
	    format(AdvertData[i][advertText], 64, text);
	    format(AdvertData[i][advertName], 32, GetName(playerid));
	    AdvertData[i][advertNumber] = PlayerData[playerid][pPhoneNumber];
	    AdvertData[i][advertTime] = 300;
	    return i;
	}
	return -1;
}

stock Advert_Delete(adid)
{
	if (adid != -1 && AdvertData[adid][advertExists])
	{
	    AdvertData[adid][advertExists] = false;
	    AdvertData[adid][advertOwner] = -1;
	}
	return 1;
}

CMD:ad(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, 177.9645,131.2774,1003.0295))
	    return SendErrorMessage(playerid, "You only can perform this inside Los Santos News!");

	if(Advert_CountPlayer(playerid) > 0)
	    return SendErrorMessage(playerid, "You already have a pending advertisement, you must wait first.");

	if(Advert_Count() >= 50)
		return SendErrorMessage(playerid, "The server has reached limit of ads list, comeback later.");

	if(!PlayerHasItem(playerid, "Cellphone"))
		return SendErrorMessage(playerid, "You don't have Cellphone on you!");

	if(PlayerData[playerid][pPhoneNumber] == 0)
		return SendErrorMessage(playerid, "You don't have Phone Number!");

	if(isnull(params))
	    return SendSyntaxMessage(playerid, "/ad [advertisement]"), SendClientMessage(playerid, COLOR_YELLOW, "INFO: {FFFFFF}Advertisement is charged {009000}$1.10 {FFFFFF}per character.");

	if(strlen(params) > 64)
	    return SendErrorMessage(playerid, "Text cannot more than 64 characters.");

	if(GetMoney(playerid) < strlen(params)*110)
	    return SendErrorMessage(playerid, "You need $%s to make advertisement", FormatNumber(strlen(params)*110));

	GiveMoney(playerid, -strlen(params)*110);
	Advert_Create(playerid, params);
	SendClientMessage(playerid, COLOR_SERVER, "ADS: {FFFFFF}Your advertisement will be appear 5 minutes from now.");
	return 1;
}