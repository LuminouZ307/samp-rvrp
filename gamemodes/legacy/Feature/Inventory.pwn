enum inventoryData
{
	invExists,
	invID,
	invItem[32 char],
	invModel,
	invQuantity
};

new InventoryData[MAX_PLAYERS][MAX_INVENTORY][inventoryData];

	
enum e_InventoryItems
{
	e_InventoryItem[32],
	e_InventoryModel
};


new const g_aInventoryItems[][e_InventoryItems] =
{
	{"GPS", 18875},
	{"Cellphone", 18867},
	{"Medkit", 1580},
	{"Portable Radio", 19942},
	{"Mask", 19036},
	{"Snack", 2768},
	{"Water", 2958},
	{"Rolling Paper", 19873},
	{"Rolled Weed", 3027},
	{"Weed", 1578},
	{"Component", 19627},
	{"Weed Seed", 1279},
	{"9mm Luger", 19995},
	{"12 Gauge", 19995},
	{"9mm Silenced Schematic", 3111},
	{"Shotgun Schematic", 3111},
	{"9mm Silenced Material", 3052},
	{"Shotgun Material", 3052},
	{"Axe", 19631},
	{"Fish Rod", 18632},
	{"Bait", 19566}
};

stock Inventory_Clear(playerid)
{
	static
	    string[64];

	forex(i, MAX_INVENTORY)
	{
	    if (InventoryData[playerid][i][invExists])
	    {
	        InventoryData[playerid][i][invExists] = 0;
	        InventoryData[playerid][i][invModel] = 0;
	        InventoryData[playerid][i][invQuantity] = 0;
		}
	}
	mysql_format(sqlcon, string, sizeof(string), "DELETE FROM `inventory` WHERE `ID` = '%d'", PlayerData[playerid][pID]);
	return mysql_tquery(sqlcon, string);
}

stock Inventory_GetItemID(playerid, item[])
{
	forex(i, MAX_INVENTORY)
	{
	    if (!InventoryData[playerid][i][invExists])
	        continue;

		if (!strcmp(InventoryData[playerid][i][invItem], item)) return i;
	}
	return -1;
}

stock Inventory_GetFreeID(playerid)
{
	if (Inventory_Items(playerid) >= 20)
		return -1;

	forex(i, MAX_INVENTORY)
	{
	    if (!InventoryData[playerid][i][invExists])
	        return i;
	}
	return -1;
}

stock Inventory_Items(playerid)
{
    new count;

    forex(i, MAX_INVENTORY) if (InventoryData[playerid][i][invExists]) {
        count++;
	}
	return count;
}

stock Inventory_Count(playerid, item[])
{
	new itemid = Inventory_GetItemID(playerid, item);

	if (itemid != -1)
	    return InventoryData[playerid][itemid][invQuantity];

	return 0;
}

stock PlayerHasItem(playerid, item[])
{
	return (Inventory_GetItemID(playerid, item) != -1);
}

stock Inventory_Set(playerid, item[], model, amount)
{
	new itemid = Inventory_GetItemID(playerid, item);

	if (itemid == -1 && amount > 0)
		Inventory_Add(playerid, item, model, amount);

	else if (amount > 0 && itemid != -1)
	    Inventory_SetQuantity(playerid, item, amount);

	else if (amount < 1 && itemid != -1)
	    Inventory_Remove(playerid, item, -1);

	return 1;
}

stock Inventory_SetQuantity(playerid, item[], quantity)
{
	new
	    itemid = Inventory_GetItemID(playerid, item),
	    string[128];

	if (itemid != -1)
	{
	    format(string, sizeof(string), "UPDATE `inventory` SET `invQuantity` = %d WHERE `ID` = '%d' AND `invID` = '%d'", quantity, PlayerData[playerid][pID], InventoryData[playerid][itemid][invID]);
	    mysql_tquery(sqlcon, string);

	    InventoryData[playerid][itemid][invQuantity] = quantity;
	}
	return 1;
}

stock Inventory_Remove(playerid, item[], quantity = 1)
{
	new
		itemid = Inventory_GetItemID(playerid, item),
		string[128];

	if (itemid != -1)
	{
	    if (InventoryData[playerid][itemid][invQuantity] > 0)
	    {
	        InventoryData[playerid][itemid][invQuantity] -= quantity;
		}
		if (quantity == -1 || InventoryData[playerid][itemid][invQuantity] < 1)
		{
		    InventoryData[playerid][itemid][invExists] = false;
		    InventoryData[playerid][itemid][invModel] = 0;
		    InventoryData[playerid][itemid][invQuantity] = 0;
		    strpack(InventoryData[playerid][itemid][invItem], "", 32 char);

		    mysql_format(sqlcon, string, sizeof(string), "DELETE FROM `inventory` WHERE `ID` = '%d' AND `invID` = '%d'", PlayerData[playerid][pID], InventoryData[playerid][itemid][invID]);
	        mysql_tquery(sqlcon, string);

			/*forex(i, MAX_INVENTORY)
			{
			    InventoryData[playerid][i][invExists] = false;
			    InventoryData[playerid][i][invModel] = 0;
			    InventoryData[playerid][i][invQuantity] = 0;
			}
			new invQuery[256];

		    mysql_format(sqlcon,invQuery, sizeof(invQuery), "SELECT * FROM `inventory` WHERE `ID` = '%d'", PlayerData[playerid][pID]);
			mysql_tquery(sqlcon, invQuery, "LoadPlayerItems", "d", playerid);*/
		}
		else if (quantity != -1 && InventoryData[playerid][itemid][invQuantity] > 0)
		{
			mysql_format(sqlcon, string, sizeof(string), "UPDATE `inventory` SET `invQuantity` = `invQuantity` - %d WHERE `ID` = '%d' AND `invID` = '%d'", quantity, PlayerData[playerid][pID], InventoryData[playerid][itemid][invID]);
            mysql_tquery(sqlcon, string);
		}
		return 1;
	}
	return 0;
}

stock Inventory_Add(playerid, item[], model, quantity = 1)
{
	new
		itemid = Inventory_GetItemID(playerid, item),
		string[128];

	if (itemid == -1)
	{
	    itemid = Inventory_GetFreeID(playerid);

	    if (itemid != -1)
	    {
	        InventoryData[playerid][itemid][invExists] = true;
	        InventoryData[playerid][itemid][invModel] = model;
	        InventoryData[playerid][itemid][invQuantity] = quantity;

	        strpack(InventoryData[playerid][itemid][invItem], item, 32 char);

			format(string, sizeof(string), "INSERT INTO `inventory` (`ID`, `invItem`, `invModel`, `invQuantity`) VALUES('%d', '%s', '%d', '%d')", PlayerData[playerid][pID], item, model, quantity);
			mysql_tquery(sqlcon, string, "OnInventoryAdd", "dd", playerid, itemid);
	        return itemid;
		}
		return -1;
	}
	else
	{
	    format(string, sizeof(string), "UPDATE `inventory` SET `invQuantity` = `invQuantity` + %d WHERE `ID` = '%d' AND `invID` = '%d'", quantity, PlayerData[playerid][pID], InventoryData[playerid][itemid][invID]);
	    mysql_tquery(sqlcon, string);

	    InventoryData[playerid][itemid][invQuantity] += quantity;
	}
	return itemid;
}

FUNC::OnInventoryAdd(playerid, itemid)
{
	InventoryData[playerid][itemid][invID] = cache_insert_id();
	return 1;
}

FUNC::ShowInventory(playerid, targetid)
{
    if (!IsPlayerConnected(playerid))
	    return 0;

	new
	    items[MAX_INVENTORY],
		amounts[MAX_INVENTORY],
		str[512],
		string[352],
		count = 0;

	format(str, sizeof(str), "Name\tAmount\n");
	format(str, sizeof(str), "%s\nMoney\t$%s", str, FormatNumber(GetMoney(targetid)));
    forex(i, MAX_INVENTORY)
	{
 		if (InventoryData[targetid][i][invExists])
        {
            count++;
   			items[i] = InventoryData[targetid][i][invModel];
   			amounts[i] = InventoryData[targetid][i][invQuantity];
   			strunpack(string, InventoryData[targetid][i][invItem]);
   			format(str, sizeof(str), "%s\n%s\t%d", str, string, amounts[i]);
		}
	}
	ShowPlayerDialog(playerid, DIALOG_NONE, DIALOG_STYLE_TABLIST_HEADERS, sprintf("%s Inventory", ReturnName(targetid)), str,  "Close", "");
	return 1;

}

stock OpenInventory(playerid)
{
    if (!IsPlayerConnected(playerid))
	    return 0;

	new
		amounts[MAX_INVENTORY],
		str[512],
		string[256];

	format(str, sizeof(str), "Name\tAmount\n");
    forex(i, MAX_INVENTORY)
	{
	    if (!InventoryData[playerid][i][invExists])
	        format(str, sizeof(str), "%s{AFAFAF}Empty Slot\n", str);

		else
		{
			amounts[i] = InventoryData[playerid][i][invQuantity];
			strunpack(string, InventoryData[playerid][i][invItem]);
			format(str, sizeof(str), "%s{FFFFFF}%s\t%d\n", str, string, amounts[i]);
		}
	}
	ShowPlayerDialog(playerid, DIALOG_INVENTORY, DIALOG_STYLE_TABLIST_HEADERS, "Inventory Data", str, "Select", "Close");
	return 1;
}

FUNC::LoadPlayerItems(playerid)
{
	new name[128];
	new count = cache_num_rows();
	if(count > 0)
	{
	    forex(i, count)
	    {
	        InventoryData[playerid][i][invExists] = true;

	        cache_get_value_name_int(i, "invID", InventoryData[playerid][i][invID]);
	        cache_get_value_name_int(i, "invModel", InventoryData[playerid][i][invModel]);
	        cache_get_value_name_int(i, "invQuantity", InventoryData[playerid][i][invQuantity]);

	        cache_get_value_name(i, "invItem", name);

			strpack(InventoryData[playerid][i][invItem], name, 32 char);
		}
	}
	return 1;
}

FUNC::OnPlayerUseItem(playerid, itemid, name[])
{
	if(!strcmp(name, "Snack"))
	{
        if (PlayerData[playerid][pHunger] > 90)
            return SendErrorMessage(playerid, "Kamu tidak membutuhkan makanan saat ini.");

        PlayerData[playerid][pHunger] += 10;
		Inventory_Remove(playerid, "Snack", 1);
		ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 0, 0, 0, 0, 0, 1);
        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s takes a snack and eats it.", ReturnName(playerid));
	}
	else if(!strcmp(name, "Water"))
	{
        if (PlayerData[playerid][pThirst] > 90)
            return SendErrorMessage(playerid, "Kamu tidak membutuhkan minum saat ini.");

        PlayerData[playerid][pThirst] += 10;
		Inventory_Remove(playerid, "Water", 1);
		ApplyAnimation(playerid, "VENDING", "VEND_DRINK2_P", 4.1, 0, 0, 0, 0, 0, 1);
        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s takes a water mineral and drinks it.", ReturnName(playerid));
	}
	else if(!strcmp(name, "Cellphone"))
	{
		cmd_phone(playerid, "");
	}
	else if(!strcmp(name, "GPS"))
	{
		cmd_gps(playerid, "");
	}
	else if(!strcmp(name, "Axe"))
	{
		if(!PlayerData[playerid][pAxe])
		{
			SetPlayerArmedWeapon(playerid, 0);
			SendServerMessage(playerid, "You have {00FF00}equipped {FFFFFF}your Axe.");
			SetPlayerAxe(playerid, true);
			PlayerData[playerid][pAxe] = true;
		}
		else
		{
			SendServerMessage(playerid, "You have {FF0000}unequipped {FFFFFF}your Axe.");
			SetPlayerAxe(playerid, false);
			PlayerData[playerid][pAxe] = false;
		}
	}
	else if(!strcmp(name, "9mm Silenced Schematic"))
	{
		if(Inventory_Count(playerid, "9mm Silenced Material") < 1)
			return SendErrorMessage(playerid, "Kamu tidak memiliki 9mm Silenced Material!");

		if(PlayerHasWeapon(playerid, 23))
			return SendErrorMessage(playerid, "Kamu masih membawa 9mm Silenced!");

		if(PlayerHasWeapon(playerid, 24))
			return SendErrorMessage(playerid, "Kamu masih membawa senjata dengan jenis yang sama! (Pistol)");

		if(PlayerHasWeapon(playerid, 22))
			return SendErrorMessage(playerid, "Kamu masih membawa senjata dengan jenis yang sama! (Pistol)");

		Inventory_Remove(playerid, "9mm Silenced Material", 1);
		GiveWeaponToPlayer(playerid, 23, 34, 500);
		SendServerMessage(playerid, "Successfully crafting {FF0000}9mm Silenced");
	}
	else if(!strcmp(name, "Shotgun Schematic"))
	{
		if(Inventory_Count(playerid, "Shotgun Material") < 1)
			return SendErrorMessage(playerid, "Kamu tidak memiliki Shotgun Material!");

		if(PlayerHasWeapon(playerid, 25))
			return SendErrorMessage(playerid, "Kamu masih membawa Shotgun!");

		Inventory_Remove(playerid, "Shotgun Material", 1);
		GiveWeaponToPlayer(playerid, 25, 12, 500);
		SendServerMessage(playerid, "Successfully crafting {FF0000}Shotgun");
	}
	else if(!strcmp(name, "9mm Luger"))
	{
		new wep = GetWeapon(playerid);
		if(wep != 23)
			return SendErrorMessage(playerid, "You must holding 9mm Silenced!");

		if(PlayerData[playerid][pAmmo][g_aWeaponSlots[wep]]+17 > 170)
			return SendErrorMessage(playerid, "Total peluru tidak bisa lebih dari 170!");

		PlayerData[playerid][pAmmo][g_aWeaponSlots[wep]] += 17;
		SetPlayerAmmo(playerid, 23, PlayerData[playerid][pAmmo][g_aWeaponSlots[wep]]);
		PlayReloadAnimation(playerid, 23);
		PlayerPlayNearbySound(playerid, 1131);
		Inventory_Remove(playerid, "9mm Luger", 1);
	}
	else if(!strcmp(name, "12 Gauge"))
	{
		new wep = GetWeapon(playerid);
		if(wep != 25)
			return SendErrorMessage(playerid, "You must holding Shotgun!");

		if(PlayerData[playerid][pAmmo][g_aWeaponSlots[wep]]+12 > 120)
			return SendErrorMessage(playerid, "Total peluru tidak bisa lebih dari 120!");

		PlayerData[playerid][pAmmo][g_aWeaponSlots[wep]] += 12;
		SetPlayerAmmo(playerid, 25, PlayerData[playerid][pAmmo][g_aWeaponSlots[wep]]);
		PlayReloadAnimation(playerid, 25);
		PlayerPlayNearbySound(playerid, 1131);
		Inventory_Remove(playerid, "12 Gauge", 1);
	}
	else if(!strcmp(name, "Rolling Paper"))
	{
		if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
			return SendErrorMessage(playerid, "You must be on-foot!");

		if(Inventory_Count(playerid, "Weed") < 1)
			return SendErrorMessage(playerid, "Kamu membutuhkan 1 weed untuk membuat Rolled Weed!");

		if(IsValidLoading(playerid))
			return SendErrorMessage(playerid, "You can't do this at the moment.");

		CreatePlayerLoadingBar(playerid, 15, "Combining_Weed...");
		SetTimerEx("Combined", 15000, false, "d", playerid);
		ApplyAnimation(playerid, "CASINO", "dealone", 4.1, 1, 0, 0, 0, 0, 1);
		Inventory_Remove(playerid, "Weed", 1);
		Inventory_Remove(playerid, "Rolling Paper", 1);
	}
	else if(!strcmp(name, "Weed Seed"))
	{
		new wid = Weed_Nearest(playerid);

		if(!IsAtDrugField(playerid))
			return SendErrorMessage(playerid, "You only can plant weed at Weed Field!");

		if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
			return SendErrorMessage(playerid, "You must be on-foot!");

		if(IsValidLoading(playerid))
			return SendErrorMessage(playerid, "You can't do this at the moment.");

		if(wid != -1)
			return SendErrorMessage(playerid, "Kamu terlalu dekat dengan tanaman lain!");

		if(Weed_Count() >= MAX_WEED)
			return SendErrorMessage(playerid, "The server cannot create more Weeds!");

		Inventory_Remove(playerid, "Weed Seed", 1);
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s plants some weed seeds into the ground.", ReturnName(playerid));
		CreatePlayerLoadingBar(playerid, 5, "Planting_weed...");
		SetTimerEx("PlantWeed", 5000, false, "d", playerid);
		ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.1, 1, 0, 0, 1, 0, 1);
	}
	else if(!strcmp(name, "Medkit"))
	{
		if(PlayerData[playerid][pFirstAid])
			return SendErrorMessage(playerid, "You already using a Medkit");

		if (ReturnHealth(playerid) > 99)
		    return SendErrorMessage(playerid, "You don't need to use a medkit right now.");

		if (!IsPlayerInAnyVehicle(playerid))
		    ApplyAnimation(playerid, "SWAT", "gnstwall_injurd", 4.0, 1, 0, 0, 0, 0);

	    PlayerData[playerid][pFirstAid] = true;
	    PlayerData[playerid][pAidTimer] = SetTimerEx("FirstAidUpdate", 1000, true, "d", playerid);

	    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s opens a first aid kit and uses it.", ReturnName(playerid));
	    Inventory_Remove(playerid, "Medkit");
	}
	return 1;
}

CMD:inventory(playerid, params[])
{
	PlayerData[playerid][pStorageSelect] = 0;
	OpenInventory(playerid);
	return 1;
}

CMD:setitem(playerid, params[])
{
	new
	    userid,
		item[32],
		amount;

	if (PlayerData[playerid][pAdmin] < 6)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "uds[32]", userid, amount, item))
	    return SendSyntaxMessage(playerid, "/setitem [playerid/PartOfName] [amount] [item name]");

	for (new i = 0; i < sizeof(g_aInventoryItems); i ++) if (!strcmp(g_aInventoryItems[i][e_InventoryItem], item, true))
	{
        Inventory_Set(userid, g_aInventoryItems[i][e_InventoryItem], g_aInventoryItems[i][e_InventoryModel], amount);

		return SendServerMessage(playerid, "You have set %s's \"%s\" to %d.", ReturnName(userid), item, amount);
	}
	SendErrorMessage(playerid, "Invalid item name (use /itemlist for a list).");
	return 1;
}

CMD:itemlist(playerid, params[])
{
	new
	    string[1024];

	if (!strlen(string)) {
		for (new i = 0; i < sizeof(g_aInventoryItems); i ++) {
			format(string, sizeof(string), "%s%s\n", string, g_aInventoryItems[i][e_InventoryItem]);
		}
	}
	return ShowPlayerDialog(playerid, DIALOG_NONE, DIALOG_STYLE_LIST, "List of Items", string, "Select", "Cancel");
}
