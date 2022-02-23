enum contactData
{
	contactID,
	contactExists,
	contactName[32],
	contactNumber,
	contactOwner,
};

new ContactData[MAX_PLAYERS][MAX_CONTACTS][contactData];
new ListedContacts[MAX_PLAYERS][MAX_CONTACTS];

stock HasPhoneSignal(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid, 40.0, 322.8956,1795.4436,899.3750)) return true;
	if(IsPlayerInRangeOfPoint(playerid, 50.0, -1271.2010, -2061.0656, 22.9706)) return true;
	if(IsPlayerInRangeOfPoint(playerid, 50.0, -185.9363,1886.0468,102.80237)) return true;
	if(IsPlayerInArea(playerid, -2172.085, -2931.147, -980.9415, -2172.085)) return false;
	if(IsPlayerInArea(playerid, 46.7115, -1599.869, -1564.835, -2989.536)) return false;
	if(IsPlayerInArea(playerid, 945.9079, -2989.536, 2989.536, 2697.589)) return false;
	if(IsPlayerInArea(playerid, 2966.18, 1868.46, -315.3026, -899.1964)) return false;
	if(IsPlayerInArea(playerid, 548.8602, -934.23, 2872.757, 2195.441)) return false;
	if(!IsPlayerInArea(playerid, 3000.0, -3000.0, 3000.0, -3000.0)) return false;
	return true;
}

stock CancelCall(playerid)
{
    if (PlayerData[playerid][pCallLine] != INVALID_PLAYER_ID)
	{
 		PlayerData[PlayerData[playerid][pCallLine]][pCallLine] = INVALID_PLAYER_ID;
   		PlayerData[PlayerData[playerid][pCallLine]][pIncomingCall] = 0;

		PlayerData[playerid][pCallLine] = INVALID_PLAYER_ID;
		PlayerData[playerid][pIncomingCall] = 0;
	}
	return 1;
}

stock IsPlayerOnPhone(playerid)
{
	if (PlayerData[playerid][pCallLine] != INVALID_PLAYER_ID || ServiceIndex[playerid] != 0)
	    return 1;

	return 0;
}

FUNC::LoadPlayerContact(playerid)
{
	new count = cache_num_rows();
	if(count > 0)
	{
		for(new i = 0; i < count; i++)
		{
		    ContactData[playerid][i][contactExists] = true;
	        cache_get_value_name(i, "contactName", ContactData[playerid][i][contactName]);
            cache_get_value_name_int(i, "contactOwner", ContactData[playerid][i][contactOwner]);
		    cache_get_value_name_int(i, "contactNumber", ContactData[playerid][i][contactNumber]);
		    cache_get_value_name_int(i, "contactID", ContactData[playerid][i][contactID]);
		}
	}
	return 1;
}

stock ShowContacts(playerid)
{
	new
	    string[32 * MAX_CONTACTS],
		count = 0;

	string = "Add Contact\n";

	for (new i = 0; i != MAX_CONTACTS; i ++) if (ContactData[playerid][i][contactExists] && ContactData[playerid][i][contactOwner] == PlayerData[playerid][pID])
	{
	    format(string, sizeof(string), "%s%s - #%d\n", string, ContactData[playerid][i][contactName], ContactData[playerid][i][contactNumber]);

		ListedContacts[playerid][count++] = i;
	}
	ShowPlayerDialog(playerid, DIALOG_CONTACT, DIALOG_STYLE_LIST, "Contact List", string, "Select", "Back");
	return 1;
}

CMD:phone(playerid, params[])
{
	if(!PlayerHasItem(playerid, "Cellphone"))
	    return SendErrorMessage(playerid, "You don't have a cellphone on you.");

    if (PlayerData[playerid][pInjured])
	    return SendErrorMessage(playerid, "You can't use this command now.");

	    
	new
	    str[156];


	if (PlayerData[playerid][pPhoneOff])
	{
		format(str, sizeof(str), "Number: %d\nCredits: %d\nDial Number\nMy Contacts\nSend Text Message\nAdvertisement List\nSan Andreas Media\nTurn On Phone", PlayerData[playerid][pPhoneNumber], PlayerData[playerid][pCredit]);
	}
	else
	{
	    format(str, sizeof(str), "Number: %d\nCredits: %d\nDial Number\nMy Contacts\nSend Text Message\nAdvertisement List\nSan Andreas Media\nTurn Off Phone", PlayerData[playerid][pPhoneNumber], PlayerData[playerid][pCredit]);
	}
	ShowPlayerDialog(playerid, DIALOG_PHONE, DIALOG_STYLE_LIST, "Home Screen", str, "Select", "Close");
	new string[128];
	format(string, sizeof(string), "* %s Take out cellphone and use it", ReturnName(playerid), params);
 	SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 30.0, 5000);
	return 1;
}

CMD:sms(playerid, params[])
{
	SendServerMessage(playerid, "This feature is coming soon!");
	return 1;
}
CMD:call(playerid, params[])
{
	if(!PlayerHasItem(playerid, "Cellphone"))
	    return SendErrorMessage(playerid, "You don't have a cellphone on you.");

    if (PlayerData[playerid][pPhoneOff])
		return SendErrorMessage(playerid, "Your phone must be powered on.");

    if (PlayerData[playerid][pInjured])
	    return SendErrorMessage(playerid, "You can't use this command now.");

	if(!HasPhoneSignal(playerid))
		return SendErrorMessage(playerid, "Signal Service is unreachable on your location.");

	if(IsPlayerOnPhone(playerid))
		return SendErrorMessage(playerid, "You already on a call.");

	if(ServiceIndex[playerid] != 0)
		return SendErrorMessage(playerid, "You already on a call.");

	new
	    targetid,
		number;

	if (sscanf(params, "d", number))
 	   return SendSyntaxMessage(playerid, "/call [phone number] (1222 - Taxi | 911 - Emergency | 143 - Mechanic)");

	if (!number)
	    return SendErrorMessage(playerid, "The specified phone number is not in service.");
	    
	if (number == 911)
	{
		if(!IsPlayerInAnyVehicle(playerid))
		{
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
		}
		SetPlayerAttachedObject(playerid, 3, 18867, 6, 0.0909, -0.0030, 0.0000, 80.4001, 159.8000, 18.0000, 1.0000, 1.0000, 1.0000, 0xFFFFFFFF, 0xFFFFFFFF);

		ServiceIndex[playerid] = 1;
		PlayerPlaySound(playerid, 3600, 0.0, 0.0, 0.0);
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s takes out their cellphone and places a call.", ReturnName(playerid));
		SendClientMessage(playerid, COLOR_SERVER, "OPERATOR:{FFFFFF} Which service do you require: \"lspd\" or \"lses\"?");
	}
	else if (number == 1222)
	{
		PlayerData[playerid][pTaxiCalled] = true;
		PlayerPlayNearbySound(playerid, 3600);
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s takes out their cellphone and places a call.", ReturnName(playerid));
		SendClientMessage(playerid, COLOR_YELLOW, "OPERATOR:{FFFFFF} The taxi department has been notified of your call.");
		SendJobMessage(JOB_TAXI, COLOR_YELLOW, "TAXI CALL: {FFFFFF}%s[%d] is requesting a taxi at %s (use /taxi calls to accept).", GetName(playerid), PlayerData[playerid][pPhoneNumber], GetSpecificLocation(playerid));
	}
	else if (number == 143)
	{
	    PlayerPlayNearbySound(playerid, 3600);
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s takes out their cellphone and places a call.", ReturnName(playerid));
		SendClientMessage(playerid, COLOR_LIGHTGREEN, "OPERATOR:{FFFFFF} The mechanic has been notified of your call.");
		SendJobMessage(JOB_MECHANIC, COLOR_LIGHTGREEN, "MECH CALL: {FFFFFF}%s is requesting a mechanic at %s (%d)", GetName(playerid), GetSpecificLocation(playerid), PlayerData[playerid][pPhoneNumber]);
	}
	else if ((targetid = GetNumberOwner(number)) != INVALID_PLAYER_ID)
	{
	    if (targetid == playerid)
	        return SendErrorMessage(playerid, "You can't call yourself!");

		if (PlayerData[targetid][pPhoneOff])
		    return SendErrorMessage(playerid, "The recipient has their cellphone powered off.");
		    
		if(PlayerData[playerid][pCredit] < 5)
		    return SendErrorMessage(playerid, "You don't have enough phone credits!");

		if(PlayerData[targetid][pIncomingCall])
		    return SendErrorMessage(playerid, "There are already recipient on this number.");

        if (IsPlayerOnPhone(targetid))
		    return SendErrorMessage(playerid, "There are already recipient on this number.");
		    
		PlayerData[targetid][pIncomingCall] = 1;
		PlayerData[playerid][pIncomingCall] = 1;

		PlayerData[targetid][pCallLine] = playerid;
		PlayerData[playerid][pCallLine] = targetid;

		SendClientMessageEx(playerid, COLOR_YELLOW, "PHONE:{FFFFFF} Attempting to dial #%d, please wait for an answer...", number);
		SendClientMessageEx(targetid, COLOR_YELLOW, "PHONE:{FFFFFF} Incoming call from #%d (type \"/answer\" to answer the phone).", PlayerData[playerid][pPhoneNumber]);
		PlayerData[playerid][pCredit] -= 5;
        PlayerPlayNearbySound(playerid, 3600);
        PlayerPlayNearbySound(targetid, 23000);

		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s takes out their cellphone and places a call.", ReturnName(playerid));

		if(!IsPlayerInAnyVehicle(playerid))
		{
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
		}
		SetPlayerAttachedObject(playerid, 3, 18867, 6, 0.0909, -0.0030, 0.0000, 80.4001, 159.8000, 18.0000, 1.0000, 1.0000, 1.0000, 0xFFFFFFFF, 0xFFFFFFFF);
	}
	else
	{
	    SendErrorMessage(playerid, "The specified phone number is not in service.");
	}
	return 1;
}
