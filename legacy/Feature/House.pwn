enum hData
{
	houseID,
	bool:houseExists,
	houseOwner,
	houseOwnerName[64],
	housePrice,
	Float:housePos[4],
	Float:houseInt[4],
	houseInterior,
	houseExterior,
	houseExteriorVW,
	houseLocked,
	STREAMER_TAG_3D_TEXT_LABEL:houseText3D,
	STREAMER_TAG_PICKUP:housePickup,
	STREAMER_TAG_CP:houseCP,
	houseWeapons[10],
	houseAmmo[10],
	houseDurability[10],
	houseMoney,
	housePark,
	Float:houseParkPos[3],
	STREAMER_TAG_CP:houseParkCP,
	STREAMER_TAG_3D_TEXT_LABEL:houseParkLabel,
	STREAMER_TAG_MAP_ICON:houseIcon,

};

new HouseData[MAX_HOUSES][hData];
new Iterator:House<MAX_HOUSES>;
new Iterator:Furniture<MAX_FURNITURE>;

enum furnitureData {
	furnitureID,
	furnitureHouse,
	furnitureExists,
	furnitureModel,
	furnitureName[32],
	Float:furniturePos[3],
	Float:furnitureRot[3],
	STREAMER_TAG_OBJECT:furnitureObject
};

new FurnitureData[MAX_FURNITURE][furnitureData];
new ListedFurniture[MAX_PLAYERS][MAX_HOUSE_FURNITURE];

enum houseStorage
{
	hItemID,
	hItemExists,
	hItemName[32 char],
	hItemModel,
	hItemQuantity
};

new HouseStorage[MAX_HOUSES][MAX_HOUSE_STORAGE][houseStorage];

enum e_FurnitureData {
	e_FurnitureType,
	e_FurnitureName[32],
	e_FurnitureModel
};

new const g_aFurnitureTypes[][] = {
	{"Frames"},
	{"Tables"},
	{"Chairs"},
	{"Beds"},
	{"Cabinets"},
	{"Television Sets"},
	{"Kitchen Appliances"},
	{"Bathroom Appliances"},
	{"Misc Furniture"}
};

new const g_aFurnitureData[][e_FurnitureData] = {
	{1, "Frame 1", 2289},
	{1, "Frame 2", 2288},
	{1, "Frame 3", 2287},
	{1, "Frame 4", 2286},
	{1, "Frame 5", 2285},
	{1, "Frame 6", 2284},
    {1, "Frame 7", 2283},
    {1, "Frame 8", 2282},
    {1, "Frame 9", 2281},
    {1, "Frame 10", 2280},
    {1, "Frame 11", 2279},
	{1, "Frame 12", 2278},
	{1, "Frame 13", 2277},
	{1, "Frame 14", 2276},
	{1, "Frame 15", 2275},
	{1, "Frame 16", 2274},
    {1, "Frame 17", 2273},
    {1, "Frame 18", 2272},
    {1, "Frame 19", 2271},
    {1, "Frame 20", 2270},
    {2, "Table 1", 1433},
	{2, "Table 2", 1998},
	{2, "Table 3", 2008},
	{2, "Table 4", 2180},
	{2, "Table 5", 2185},
    {2, "Table 6", 2205},
    {2, "Table 7", 2314},
    {2, "Table 8", 2635},
    {2, "Table 9", 2637},
    {2, "Table 10", 2644},
	{2, "Table 11", 2747},
	{2, "Table 12", 2764},
	{2, "Table 13", 2763},
	{2, "Table 14", 2762},
	{2, "Table 15", 936},
	{2, "Table 16", 937},
	{2, "Table 17", 941},
	{2, "Table 18", 2115},
	{2, "Table 19", 2116},
	{2, "Table 20", 2112},
	{2, "Table 21", 2111},
	{2, "Table 22", 2110},
	{2, "Table 23", 2109},
	{2, "Table 24", 2085},
	{2, "Table 25", 2032},
	{2, "Table 26", 2031},
	{2, "Table 27", 2030},
	{2, "Table 28", 2029},
    {3, "Chair 1", 1671},
    {3, "Chair 2", 1704},
    {3, "Chair 3", 1705},
    {3, "Chair 4", 1708},
    {3, "Chair 5", 1711},
    {3, "Chair 6", 1715},
    {3, "Chair 7", 1721},
    {3, "Chair 8", 1724},
    {3, "Chair 9", 1727},
    {3, "Chair 10", 1729},
    {3, "Chair 11", 1735},
    {3, "Chair 12", 1739},
    {3, "Chair 13", 1805},
    {3, "Chair 14", 1806},
    {3, "Chair 15", 1810},
    {3, "Chair 16", 1811},
    {3, "Chair 17", 2079},
    {3, "Chair 18", 2120},
    {3, "Chair 19", 2124},
    {3, "Chair 20", 2356},
    {3, "Chair 21", 1768},
    {3, "Chair 22", 1766},
    {3, "Chair 23", 1764},
    {3, "Chair 24", 1763},
    {3, "Chair 25", 1761},
    {3, "Chair 26", 1760},
    {3, "Chair 27", 1757},
    {3, "Chair 28", 1756},
    {3, "Chair 29", 1753},
    {3, "Chair 30", 1713},
    {3, "Chair 31", 1712},
    {3, "Chair 32", 1706},
    {3, "Chair 33", 1703},
    {3, "Chair 34", 1702},
    {3, "Chair 35", 1754},
    {3, "Chair 36", 1755},
    {3, "Chair 37", 1758},
    {3, "Chair 38", 1759},
    {3, "Chair 39", 1762},
    {3, "Chair 40", 1765},
    {3, "Chair 41", 1767},
    {3, "Chair 42", 1769},
	{4, "Bed 1", 1700},
	{4, "Bed 2", 1701},
	{4, "Bed 3", 1725},
	{4, "Bed 4", 1745},
	{4, "Bed 5", 1793},
	{4, "Bed 6", 1794},
	{4, "Bed 7", 1795},
	{4, "Bed 8", 1796},
	{4, "Bed 9", 1797},
	{4, "Bed 10", 1771},
	{4, "Bed 11", 1798},
	{4, "Bed 12", 1799},
    {4, "Bed 13", 1800},
    {4, "Bed 14", 1801},
    {4, "Bed 15", 1802},
    {4, "Bed 16", 1812},
    {4, "Bed 17", 2090},
    {4, "Bed 18", 2299},
    {5, "Cabinet 1", 1416},
	{5, "Cabinet 2", 1417},
	{5, "Cabinet 3", 1741},
	{5, "Cabinet 4", 1742},
	{5, "Cabinet 5", 1743},
	{5, "Cabinet 6", 2025},
	{5, "Cabinet 7", 2065},
	{5, "Cabinet 8", 2066},
	{5, "Cabinet 9", 2067},
	{5, "Cabinet 10", 2087},
    {5, "Cabinet 11", 2088},
    {5, "Cabinet 12", 2094},
    {5, "Cabinet 13", 2095},
    {5, "Cabinet 14", 2306},
    {5, "Cabinet 15", 2307},
	{5, "Cabinet 16", 2323},
	{5, "Cabinet 17", 2328},
	{5, "Cabinet 18", 2329},
	{5, "Cabinet 19", 2330},
	{5, "Cabinet 20", 2708},
	{6, "Television 1", 1518},
	{6, "Television 2", 1717},
	{6, "Television 3", 1747},
	{6, "Television 4", 1748},
	{6, "Television 5", 1749},
	{6, "Television 6", 1750},
	{6, "Television 7", 1752},
	{6, "Television 8", 1781},
	{6, "Television 9", 1791},
	{6, "Television 10", 1792},
    {6, "Television 11", 2312},
	{6, "Television 12", 2316},
	{6, "Television 13", 2317},
	{6, "Television 14", 2318},
	{6, "Television 15", 2320},
	{6, "Television 16", 2595},
	{6, "Television 17", 16377},
	{7, "Kitchen 1", 2013},
	{7, "Kitchen 2", 2017},
	{7, "Kitchen 3", 2127},
	{7, "Kitchen 4", 2130},
	{7, "Kitchen 5", 2131},
	{7, "Kitchen 6", 2132},
	{7, "Kitchen 7", 2135},
	{7, "Kitchen 8", 2136},
	{7, "Kitchen 9", 2144},
	{7, "Kitchen 10", 2147},
    {7, "Kitchen 11", 2149},
    {7, "Kitchen 12", 2150},
    {7, "Kitchen 13", 2415},
    {7, "Kitchen 14", 2417},
    {7, "Kitchen 15", 2421},
    {7, "Kitchen 16", 2426},
    {7, "Kitchen 17", 2014},
    {7, "Kitchen 18", 2015},
    {7, "Kitchen 19", 2016},
    {7, "Kitchen 20", 2018},
    {7, "Kitchen 21", 2019},
    {7, "Kitchen 22", 2022},
    {7, "Kitchen 23", 2133},
    {7, "Kitchen 24", 2134},
	{7, "Kitchen 25", 2137},
	{7, "Kitchen 26", 2138},
	{7, "Kitchen 27", 2139},
	{7, "Kitchen 28", 2140},
	{7, "Kitchen 29", 2141},
	{7, "Kitchen 30", 2142},
	{7, "Kitchen 31", 2143},
	{7, "Kitchen 32", 2145},
	{7, "Kitchen 33", 2148},
	{7, "Kitchen 34", 2151},
	{7, "Kitchen 35", 2152},
	{7, "Kitchen 36", 2153},
	{7, "Kitchen 37", 2154},
	{7, "Kitchen 38", 2155},
	{7, "Kitchen 39", 2156},
	{7, "Kitchen 40", 2157},
	{7, "Kitchen 41", 2158},
	{7, "Kitchen 42", 2159},
	{7, "Kitchen 43", 2160},
	{7, "Kitchen 44", 2134},
	{7, "Kitchen 45", 2135},
	{7, "Kitchen 46", 2338},
	{7, "Kitchen 47", 2341},
	{8, "Bathroom 1", 2514},
	{8, "Bathroom 2", 2516},
	{8, "Bathroom 3", 2517},
	{8, "Bathroom 4", 2518},
	{8, "Bathroom 5", 2520},
	{8, "Bathroom 6", 2521},
	{8, "Bathroom 7", 2522},
	{8, "Bathroom 8", 2523},
	{8, "Bathroom 9", 2524},
	{8, "Bathroom 10", 2525},
    {8, "Bathroom 11", 2526},
    {8, "Bathroom 12", 2527},
    {8, "Bathroom 13", 2528},
    {8, "Bathroom 14", 2738},
    {8, "Bathroom 15", 2739},
	{9, "Washer", 1208},
	{9, "Ceiling Fan", 1661},
	{9, "Moose Head", 1736},
	{9, "Radiator", 1738},
	{9, "Mop and Pail", 1778},
	{9, "Water Cooler", 1808},
	{9, "Water Cooler 2", 2002},
	{9, "Money Safe", 1829},
	{9, "Printer", 2186},
	{9, "Computer", 2190},
	{9, "Treadmill", 2627},
	{9, "Bench Press", 2629},
	{9, "Exercise Bike", 2630},
	{9, "Mat 1", 2631},
	{9, "Mat 2", 2632},
	{9, "Mat 3", 2817},
	{9, "Mat 4", 2818},
	{9, "Mat 5", 2833},
	{9, "Mat 6", 2834},
	{9, "Mat 7", 2835},
	{9, "Mat 8", 2836},
	{9, "Mat 9", 2841},
	{9, "Mat 10", 2842},
	{9, "Mat 11", 2847},
	{9, "Book Pile 1", 2824},
	{9, "Book Pile 2", 2826},
	{9, "Book Pile 3", 2827},
	{9, "Basketball", 2114},
	{9, "Lamp 1", 2108},
	{9, "Lamp 2", 2106},
	{9, "Lamp 3", 2069},
	{9, "Dresser 1", 2569},
	{9, "Dresser 2", 2570},
	{9, "Dresser 3", 2573},
	{9, "Dresser 4", 2574},
	{9, "Dresser 5", 2576},
	{9, "Book", 2894}
};

stock House_WeaponStorage(playerid, houseid)
{
	static
	    string[712];

	string[0] = 0;

	for (new i = 0; i < 10; i ++)
	{
	    if (!HouseData[houseid][houseWeapons][i])
	        format(string, sizeof(string), "%sEmpty Slot\n", string);

		else
			format(string, sizeof(string), "%s%s ({FFFF00}Ammo: %d{FFFFFF}) ({00FFFF}Durability: %d{FFFFFF})\n", string, ReturnWeaponName(HouseData[houseid][houseWeapons][i]), HouseData[houseid][houseAmmo][i], HouseData[houseid][houseDurability][i]);
	}
	ShowPlayerDialog(playerid, DIALOG_HOUSEWEAPON, DIALOG_STYLE_LIST, "Weapon Storage", string, "Select", "Cancel");
	return 1;
}

stock House_OpenStorage(playerid, houseid)
{
	new
		items[2],
		string[MAX_HOUSE_STORAGE * 32];

	for (new i = 0; i < MAX_HOUSE_STORAGE; i ++) if (HouseStorage[houseid][i][hItemExists])
	{
	    items[0]++;
	}
	for (new i = 0; i < 10; i ++) if (HouseData[houseid][houseWeapons][i])
	{
	    items[1]++;
	}
 	format(string, sizeof(string), "Item Storage (%d/%d)\nWeapon Storage (%d/10)", items[0], MAX_HOUSE_STORAGE, items[1]);
	ShowPlayerDialog(playerid, DIALOG_HOUSESTORAGE, DIALOG_STYLE_LIST, "House Storage", string, "Select", "Cancel");
	return 1;
}


stock House_ShowItems(playerid, houseid)
{
    if (houseid == -1 || !HouseData[houseid][houseExists])
	    return 0;

	static
	    string[MAX_HOUSE_STORAGE * 32],
		name[32];

	string[0] = 0;

	for (new i = 0; i != MAX_HOUSE_STORAGE; i ++)
	{
	    if (!HouseStorage[houseid][i][hItemExists])
	        format(string, sizeof(string), "%sEmpty Slot\n", string);

		else
		{
			strunpack(name, HouseStorage[houseid][i][hItemName]);

			if (HouseStorage[houseid][i][hItemQuantity] == 1)
			{
			    format(string, sizeof(string), "%s%s\n", string, name);
			}
			else format(string, sizeof(string), "%s%s (%d)\n", string, name, HouseStorage[houseid][i][hItemQuantity]);
		}
	}
	ShowPlayerDialog(playerid, DIALOG_HOUSEITEM, DIALOG_STYLE_LIST, "Item Storage", string, "Select", "Cancel");
	return 1;
}

stock House_GetItemID(houseid, item[])
{
	if (houseid == -1 || !HouseData[houseid][houseExists])
	    return 0;

	for (new i = 0; i < MAX_HOUSE_STORAGE; i ++)
	{
	    if (!HouseStorage[houseid][i][hItemExists])
	        continue;

		if (!strcmp(HouseStorage[houseid][i][hItemName], item)) return i;
	}
	return -1;
}

stock House_GetFreeID(houseid)
{
	if (houseid == -1 || !HouseData[houseid][houseExists])
	    return 0;

	for (new i = 0; i < MAX_HOUSE_STORAGE; i ++)
	{
	    if (!HouseStorage[houseid][i][hItemExists])
	        return i;
	}
	return -1;
}

stock House_AddItem(houseid, item[], model, quantity = 1, slotid = -1)
{
    if (houseid == -1 || !HouseData[houseid][houseExists])
	    return 0;

	new
		itemid = House_GetItemID(houseid, item),
		string[128];

	if (itemid == -1)
	{
	    itemid = House_GetFreeID(houseid);

	    if (itemid != -1)
	    {
	        if (slotid != -1)
	            itemid = slotid;

	        HouseStorage[houseid][itemid][hItemExists] = true;
	        HouseStorage[houseid][itemid][hItemModel] = model;
	        HouseStorage[houseid][itemid][hItemQuantity] = quantity;

	        strpack(HouseStorage[houseid][itemid][hItemName], item, 32 char);

			mysql_format(sqlcon, string, sizeof(string), "INSERT INTO `housestorage` (`ID`, `itemName`, `itemModel`, `itemQuantity`) VALUES('%d', '%s', '%d', '%d')", HouseData[houseid][houseID], item, model, quantity);
			mysql_tquery(sqlcon, string, "OnStorageAdd", "dd", houseid, itemid);

	        return itemid;
		}
		return -1;
	}
	else
	{
	    mysql_format(sqlcon, string, sizeof(string), "UPDATE `housestorage` SET `itemQuantity` = `itemQuantity` + %d WHERE `ID` = '%d' AND `itemID` = '%d'", quantity, HouseData[houseid][houseID], HouseStorage[houseid][itemid][hItemID]);
	    mysql_tquery(sqlcon, string);

	    HouseStorage[houseid][itemid][hItemQuantity] += quantity;
	}
	return itemid;
}

FUNC::OnStorageAdd(houseid, itemid)
{
	HouseStorage[houseid][itemid][hItemID] = cache_insert_id();
	return 1;
}

stock House_RemoveItem(houseid, item[], quantity = 1)
{
    if (houseid == -1 || !HouseData[houseid][houseExists])
	    return 0;

	new
		itemid = House_GetItemID(houseid, item),
		string[128];

	if (itemid != -1)
	{
	    if (HouseStorage[houseid][itemid][hItemQuantity] > 0)
	    {
	        HouseStorage[houseid][itemid][hItemQuantity] -= quantity;
		}
		if (quantity == -1 || HouseStorage[houseid][itemid][hItemQuantity] < 1)
		{
		    HouseStorage[houseid][itemid][hItemExists] = false;
		    HouseStorage[houseid][itemid][hItemModel] = 0;
		    HouseStorage[houseid][itemid][hItemQuantity] = 0;

		    mysql_format(sqlcon, string, sizeof(string), "DELETE FROM `housestorage` WHERE `ID` = '%d' AND `itemID` = '%d'", HouseData[houseid][houseID], HouseStorage[houseid][itemid][hItemID]);
	        mysql_tquery(sqlcon, string);
		}
		else if (quantity != -1 && HouseStorage[houseid][itemid][hItemQuantity] > 0)
		{
			mysql_format(sqlcon, string, sizeof(string), "UPDATE `housestorage` SET `itemQuantity` = `itemQuantity` - %d WHERE `ID` = '%d' AND `itemID` = '%d'", quantity, HouseData[houseid][houseID], HouseStorage[houseid][itemid][hItemID]);
            mysql_tquery(sqlcon, string);
		}
		return 1;
	}
	return 0;
}

stock House_Inside(playerid)
{
	if (PlayerData[playerid][pInHouse] != -1)
	{
	    foreach(new i : House) if (HouseData[i][houseID] == PlayerData[playerid][pInHouse] && GetPlayerInterior(playerid) == HouseData[i][houseInterior] && GetPlayerVirtualWorld(playerid) > 0) {
	        return i;
		}
	}
	return -1;
}

stock House_Nearest(playerid)
{
    foreach(new i : House) if (IsPlayerInRangeOfPoint(playerid, 3.0, HouseData[i][housePos][0], HouseData[i][housePos][1], HouseData[i][housePos][2]))
	{
		return i;
	}
	return -1;
}

stock HousePark_Nearest(playerid)
{
	foreach(new i : House) if(IsPlayerInDynamicCP(playerid, HouseData[i][houseParkCP]))
	{
		return i;
	}
	return 1;
}

stock House_IsOwner(playerid, houseid)
{
	if (PlayerData[playerid][pID] == -1)
	    return 0;

    if (HouseData[houseid][houseOwner] != 0 && HouseData[houseid][houseOwner] == PlayerData[playerid][pID])
		return 1;

	return 0;
}

stock House_Spawn(i)
{
	static
	    string[256];

	if(HouseData[i][houseParkPos][0] != 0 && HouseData[i][houseParkPos][1] != 0 && HouseData[i][houseParkPos][2] != 0 && HouseData[i][housePark] != 0)
	{
		new str[156];
		format(str, sizeof(str), "[ID: %d]\n{FFFFFF}Parking Slot: {FF6347}%d\n{FFFFFF}Type {FF0000}/house park {FFFFFF}to access", i, HouseData[i][housePark]);

		HouseData[i][houseParkCP] = CreateDynamicCP(HouseData[i][houseParkPos][0], HouseData[i][houseParkPos][1], HouseData[i][houseParkPos][2], 3.0, -1, -1, -1, 3.0);
		HouseData[i][houseParkLabel] = CreateDynamic3DTextLabel(str, 0x007FFFFF, HouseData[i][houseParkPos][0], HouseData[i][houseParkPos][1], HouseData[i][houseParkPos][2], 15.0);
	}
	if (!HouseData[i][houseOwner])
	{
		format(string, sizeof(string), "[ID: %d]\n{33CC33}This house for sell\n{FFFFFF}Address: {FFFF00}%s\n{FFFFFF}Price: {FFFF00}$%s\n{FFFFFF}Parking Slot: {FF6347}%d\n{FFFFFF}Type /house buy to purchase", i, GetLocation(HouseData[i][housePos][0], HouseData[i][housePos][1], HouseData[i][housePos][2]), FormatNumber(HouseData[i][housePrice]), HouseData[i][housePark]);
        HouseData[i][houseText3D] = CreateDynamic3DTextLabel(string, 0x007FFFFF, HouseData[i][housePos][0], HouseData[i][housePos][1], HouseData[i][housePos][2], 7.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, HouseData[i][houseExteriorVW], HouseData[i][houseExterior]);
        HouseData[i][housePickup] = CreateDynamicPickup(1272, 23, HouseData[i][housePos][0], HouseData[i][housePos][1], HouseData[i][housePos][2], HouseData[i][houseExteriorVW], HouseData[i][houseExterior]);
		HouseData[i][houseIcon] = CreateDynamicMapIcon(HouseData[i][housePos][0], HouseData[i][housePos][1], HouseData[i][housePos][2], 31, -1, -1, -1, -1, 30.0);
	}
	else
	{
		format(string, sizeof(string), "[ID: %d]\n{FFFFFF}Owner: {FFFF00}%s\n{FFFFFF}Address: {FFFF00}%s\n{FFFFFF}Parking Slot: {FF6347}%d\n{FFFFFF}Press {FF0000}ENTER {FFFFFF}to enter house", i, HouseData[i][houseOwnerName], GetLocation(HouseData[i][housePos][0], HouseData[i][housePos][1], HouseData[i][housePos][2]), HouseData[i][housePark]);
		HouseData[i][houseText3D] = CreateDynamic3DTextLabel(string, 0x007FFFFF, HouseData[i][housePos][0], HouseData[i][housePos][1], HouseData[i][housePos][2], 7.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, HouseData[i][houseExteriorVW], HouseData[i][houseExterior]);
        HouseData[i][housePickup] = CreateDynamicPickup(1272, 23, HouseData[i][housePos][0], HouseData[i][housePos][1], HouseData[i][housePos][2], HouseData[i][houseExteriorVW], HouseData[i][houseExterior]);
		HouseData[i][houseIcon] = CreateDynamicMapIcon(HouseData[i][housePos][0], HouseData[i][housePos][1], HouseData[i][housePos][2], 32, -1, -1, -1, -1, 15.0);
	}
	HouseData[i][houseCP] = CreateDynamicCP(HouseData[i][housePos][0], HouseData[i][housePos][1], HouseData[i][housePos][2], 1.0, -1, -1, -1, 2.0);
	return 1;
}
stock House_Create(playerid, price, type)
{
	static
	    Float:x,
	    Float:y,
	    Float:z,
		Float:angle;

	if (GetPlayerPos(playerid, x, y, z) && GetPlayerFacingAngle(playerid, angle))
	{
		new i = Iter_Free(House);

        HouseData[i][houseExists] = true;
	    HouseData[i][houseOwner] = 0;
    	HouseData[i][housePrice] = price;
    	HouseData[i][houseMoney] = 0;
        HouseData[i][housePos][0] = x;
        HouseData[i][housePos][1] = y;
        HouseData[i][housePos][2] = z;
        HouseData[i][housePos][3] = angle;
        HouseData[i][housePark] = 0;

        if(type == 1)
        {
            HouseData[i][houseInt][0] = 2233.6909;
            HouseData[i][houseInt][1] = -1115.2598;
            HouseData[i][houseInt][2] = 1050.8828;
            HouseData[i][houseInt][3] = 50.0;
			HouseData[i][houseInterior] = 5;
        }
        else if(type == 2)
        {
            HouseData[i][houseInt][0] = 243.8560;
            HouseData[i][houseInt][1] = 305.0099;
            HouseData[i][houseInt][2] = 999.1484;
            HouseData[i][houseInt][3] = 50.0;
			HouseData[i][houseInterior] = 1;    	        	
        }
        else if(type == 3)
        {
            HouseData[i][houseInt][0] = 2807.5889;
            HouseData[i][houseInt][1] = -1174.6934;
            HouseData[i][houseInt][2] = 1025.5703;
            HouseData[i][houseInt][3] = 50.0;
			HouseData[i][houseInterior] = 8;    	        	
        }
        else if(type == 4)
        {
            HouseData[i][houseInt][0] = 2317.8176;
            HouseData[i][houseInt][1] = -1026.7137;
            HouseData[i][houseInt][2] = 1050.2178;
            HouseData[i][houseInt][3] = 50.0;
			HouseData[i][houseInterior] = 9;    	        	
        }
		HouseData[i][houseExterior] = GetPlayerInterior(playerid);
		HouseData[i][houseExteriorVW] = GetPlayerVirtualWorld(playerid);

		HouseData[i][houseLocked] = true;

		House_Spawn(i);
		Iter_Add(House, i);
		mysql_tquery(sqlcon, "INSERT INTO `houses` (`houseOwner`) VALUES(0)", "OnHouseCreated", "d", i);
		return i;
	}
	return -1;
}

stock House_Save(houseid)
{
	new
	    query[1536];

	mysql_format(sqlcon, query, sizeof(query), "UPDATE `houses` SET `houseOwner` = '%d', `housePrice` = '%d', `houseOwnerName` = '%s', `housePosX` = '%.4f', `housePosY` = '%.4f', `housePosZ` = '%.4f', `housePosA` = '%.4f', `houseIntX` = '%.4f', `houseIntY` = '%.4f', `houseIntZ` = '%.4f', `houseIntA` = '%.4f', `houseInterior` = '%d', `houseExterior` = '%d', `houseExteriorVW` = '%d'",
	    HouseData[houseid][houseOwner],
	    HouseData[houseid][housePrice],
	    HouseData[houseid][houseOwnerName],
	    HouseData[houseid][housePos][0],
	    HouseData[houseid][housePos][1],
	    HouseData[houseid][housePos][2],
	    HouseData[houseid][housePos][3],
	    HouseData[houseid][houseInt][0],
	    HouseData[houseid][houseInt][1],
	    HouseData[houseid][houseInt][2],
	    HouseData[houseid][houseInt][3],
        HouseData[houseid][houseInterior],
        HouseData[houseid][houseExterior],
        HouseData[houseid][houseExteriorVW]
	);
	for (new i = 0; i < 10; i ++)
	{
		mysql_format(sqlcon,query, sizeof(query), "%s, `houseWeapon%d` = '%d', `houseAmmo%d` = '%d', `houseDurability%d` = '%d'", query, i + 1, HouseData[houseid][houseWeapons][i], i + 1, HouseData[houseid][houseAmmo][i], i + 1, HouseData[houseid][houseDurability][i]);
	}
	mysql_format(sqlcon,query, sizeof(query), "%s, `houseLocked` = '%d', `houseMoney` = '%d', `housePark` = '%d', `houseParkX` = '%f', `houseParkY` = '%f', `houseParkZ` = '%f' WHERE `houseID` = '%d'",
	    query,
	    HouseData[houseid][houseLocked],
	    HouseData[houseid][houseMoney],
	    HouseData[houseid][housePark],
	    HouseData[houseid][houseParkPos][0],
	    HouseData[houseid][houseParkPos][1],
	    HouseData[houseid][houseParkPos][2],
        HouseData[houseid][houseID]
	);
	return mysql_tquery(sqlcon, query);
}

stock House_CountVehicle(id)
{
	new count = 0;
	foreach(new i : PlayerVehicle) if(VehicleData[i][vHouse] == id)
	{
		count++;
	}
	return count;
}

FUNC::OnHouseCreated(houseid)
{
	if (houseid == -1 || !HouseData[houseid][houseExists])
	    return 0;

	HouseData[houseid][houseID] = cache_insert_id();
	House_Save(houseid);

	return 1;
}

FUNC::OnLoadFurniture(houseid)
{
	new
	    rows = cache_num_rows();

	forex(i, rows)
	{
		new id = Iter_Free(Furniture);

	    FurnitureData[id][furnitureExists] = true;
	    FurnitureData[id][furnitureHouse] = houseid;

	    cache_get_value_name(i, "furnitureName", FurnitureData[id][furnitureName], 32);

	    cache_get_value_name_int(i, "furnitureID", FurnitureData[id][furnitureID]);
	    cache_get_value_name_int(i, "furnitureModel", FurnitureData[id][furnitureModel]);

	    cache_get_value_name_float(i, "furnitureX", FurnitureData[id][furniturePos][0]);
	    cache_get_value_name_float(i, "furnitureY", FurnitureData[id][furniturePos][1]);
	    cache_get_value_name_float(i, "furnitureZ", FurnitureData[id][furniturePos][2]);

	    cache_get_value_name_float(i, "furnitureRX", FurnitureData[id][furnitureRot][0]);
	    cache_get_value_name_float(i, "furnitureRY", FurnitureData[id][furnitureRot][1]);
	    cache_get_value_name_float(i, "furnitureRZ", FurnitureData[id][furnitureRot][2]);

	    Iter_Add(Furniture, id);

	    Furniture_Spawn(id);
	}
	return 1;
}
stock GetFurnitureNameByModel(model)
{
	new
	    name[32];

	for (new i = 0; i < sizeof(g_aFurnitureData); i ++) if (g_aFurnitureData[i][e_FurnitureModel] == model) {
		strcat(name, g_aFurnitureData[i][e_FurnitureName]);

		break;
	}
	return name;
}

stock Furniture_ReturnPrice(index)
{
	new price;
	switch(index)
	{
		case 0: price = 3000;
		case 1: price = 5000;
		case 2: price = 3500;
		case 3: price = 4500;
		case 4: price = 6300;
		case 5: price = 10000;
		case 6: price = 7000;
		case 7: price = 7000;
		case 8: price = 6800;
		case 9: price = 5500;
	}
	return price;
}
stock Furniture_GetCount(houseid)
{
	new count;

	foreach(new i : Furniture) if (FurnitureData[i][furnitureHouse] == houseid) {
	    count++;
	}
	return count;
}

stock Furniture_Spawn(furnitureid)
{
	if(Iter_Contains(Furniture, furnitureid))
	{
	    FurnitureData[furnitureid][furnitureObject] = CreateDynamicObject(
			FurnitureData[furnitureid][furnitureModel],
			FurnitureData[furnitureid][furniturePos][0],
			FurnitureData[furnitureid][furniturePos][1],
			FurnitureData[furnitureid][furniturePos][2],
			FurnitureData[furnitureid][furnitureRot][0],
			FurnitureData[furnitureid][furnitureRot][1],
			FurnitureData[furnitureid][furnitureRot][2],
			HouseData[FurnitureData[furnitureid][furnitureHouse]][houseID] + 5000,
			HouseData[FurnitureData[furnitureid][furnitureHouse]][houseInterior]	
		);	
	}
	return 1;
}

stock Furniture_Refresh(furnitureid)
{
	if(Iter_Contains(Furniture, furnitureid))
	{
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnitureData[furnitureid][furnitureObject], E_STREAMER_X, FurnitureData[furnitureid][furniturePos][0]);
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnitureData[furnitureid][furnitureObject], E_STREAMER_Y, FurnitureData[furnitureid][furniturePos][1]);
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnitureData[furnitureid][furnitureObject], E_STREAMER_Z, FurnitureData[furnitureid][furniturePos][2]);

		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnitureData[furnitureid][furnitureObject], E_STREAMER_R_X, FurnitureData[furnitureid][furnitureRot][0]);
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnitureData[furnitureid][furnitureObject], E_STREAMER_R_Y, FurnitureData[furnitureid][furnitureRot][1]);
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnitureData[furnitureid][furnitureObject], E_STREAMER_R_Z, FurnitureData[furnitureid][furnitureRot][2]);
	}
	return 1;
}

stock Furniture_Save(furnitureid)
{
	static
	    string[300];

	mysql_format(sqlcon, string, sizeof(string), "UPDATE `furniture` SET `furnitureModel` = '%d', `furnitureName` = '%s', `furnitureX` = '%.4f', `furnitureY` = '%.4f', `furnitureZ` = '%.4f', `furnitureRX` = '%.4f', `furnitureRY` = '%.4f', `furnitureRZ` = '%.4f' WHERE `ID` = '%d' AND `furnitureID` = '%d'",
	    FurnitureData[furnitureid][furnitureModel],
	    FurnitureData[furnitureid][furnitureName],
	    FurnitureData[furnitureid][furniturePos][0],
	    FurnitureData[furnitureid][furniturePos][1],
	    FurnitureData[furnitureid][furniturePos][2],
	    FurnitureData[furnitureid][furnitureRot][0],
	    FurnitureData[furnitureid][furnitureRot][1],
	    FurnitureData[furnitureid][furnitureRot][2],
	    HouseData[FurnitureData[furnitureid][furnitureHouse]][houseID],
	    FurnitureData[furnitureid][furnitureID]
	);
	return mysql_tquery(sqlcon, string);
}

stock Furniture_Add(houseid, name[], modelid, Float:x, Float:y, Float:z, Float:rx = 0.0, Float:ry = 0.0, Float:rz = 0.0)
{
	static
	    string[64],
		id = -1;

 	if (!Iter_Contains(House, houseid))
	    return 0;

	id = Iter_Free(Furniture);

    FurnitureData[id][furnitureExists] = true;
    format(FurnitureData[id][furnitureName], 32, name);

    FurnitureData[id][furnitureHouse] = houseid;
    FurnitureData[id][furnitureModel] = modelid;
    FurnitureData[id][furniturePos][0] = x;
    FurnitureData[id][furniturePos][1] = y;
    FurnitureData[id][furniturePos][2] = z;
    FurnitureData[id][furnitureRot][0] = rx;
    FurnitureData[id][furnitureRot][1] = ry;
    FurnitureData[id][furnitureRot][2] = rz;

    FurnitureData[id][furnitureObject] = CreateDynamicObject(
		FurnitureData[id][furnitureModel],
		FurnitureData[id][furniturePos][0],
		FurnitureData[id][furniturePos][1],
		FurnitureData[id][furniturePos][2],
		FurnitureData[id][furnitureRot][0],
		FurnitureData[id][furnitureRot][1],
		FurnitureData[id][furnitureRot][2],
		HouseData[houseid][houseID] + 5000,
		HouseData[houseid][houseInterior]	
	);	

    Iter_Add(Furniture, id);

	mysql_format(sqlcon, string, sizeof(string), "INSERT INTO `furniture` (`ID`) VALUES(%d)", HouseData[houseid][houseID]);
	mysql_tquery(sqlcon, string, "OnFurnitureCreated", "d", id);

	return id;
}

FUNC::OnFurnitureCreated(furnitureid)
{
	FurnitureData[furnitureid][furnitureID] = cache_insert_id();
	Furniture_Save(furnitureid);
	return 1;
}
stock Furniture_Delete(furnitureid)
{
	static
	    string[72];

	if (Iter_Contains(Furniture, furnitureid))
	{
	    mysql_format(sqlcon, string, sizeof(string), "DELETE FROM `furniture` WHERE `ID` = '%d' AND `furnitureID` = '%d'", HouseData[FurnitureData[furnitureid][furnitureHouse]][houseID], FurnitureData[furnitureid][furnitureID]);
		mysql_tquery(sqlcon, string);

		FurnitureData[furnitureid][furnitureExists] = false;
		FurnitureData[furnitureid][furnitureModel] = 0;

		if(IsValidDynamicObject(FurnitureData[furnitureid][furnitureObject]))
			DestroyDynamicObject(FurnitureData[furnitureid][furnitureObject]);

		Iter_SafeRemove(Furniture, furnitureid, furnitureid);
	}
	return 1;
}


FUNC::House_Load()
{
	new owner[64], str[128];
	
	new rows = cache_num_rows();
 	if(rows)
  	{
		for(new i; i < rows; i++)
		{
			HouseData[i][houseExists] = true;
            cache_get_value_name_int(i,"houseID",HouseData[i][houseID]);
            cache_get_value_name_int(i,"houseOwner",HouseData[i][houseOwner]);
            cache_get_value_name_int(i,"housePrice",HouseData[i][housePrice]);

			cache_get_value_name(i, "houseOwnerName", owner);
			format(HouseData[i][houseOwnerName], 64, owner);

            cache_get_value_name_float(i,"housePosX",HouseData[i][housePos][0]);
            cache_get_value_name_float(i,"housePosY",HouseData[i][housePos][1]);
            cache_get_value_name_float(i,"housePosZ",HouseData[i][housePos][2]);
            cache_get_value_name_float(i,"housePosA",HouseData[i][housePos][3]);

            cache_get_value_name_float(i,"houseIntX",HouseData[i][houseInt][0]);
            cache_get_value_name_float(i,"houseIntY",HouseData[i][houseInt][1]);
            cache_get_value_name_float(i,"houseIntZ",HouseData[i][houseInt][2]);
            cache_get_value_name_float(i,"houseIntA",HouseData[i][houseInt][3]);

            cache_get_value_name_int(i,"houseInterior",HouseData[i][houseInterior]);
            cache_get_value_name_int(i,"houseExterior",HouseData[i][houseExterior]);
			cache_get_value_name_int(i,"houseExteriorVW",HouseData[i][houseExteriorVW]);
			cache_get_value_name_int(i,"houseLocked",HouseData[i][houseLocked]);
			cache_get_value_name_int(i,"houseMoney",HouseData[i][houseMoney]);
			cache_get_value_name_int(i,"housePark", HouseData[i][housePark]);

			cache_get_value_name_float(i, "houseParkX", HouseData[i][houseParkPos][0]);
			cache_get_value_name_float(i, "houseParkY", HouseData[i][houseParkPos][1]);
			cache_get_value_name_float(i, "houseParkZ", HouseData[i][houseParkPos][2]);

	        for (new j = 0; j < 10; j ++)
			{
	            format(str, 24, "houseWeapon%d", j + 1);
	            cache_get_value_name_int(i,str,HouseData[i][houseWeapons][j]);

	            format(str, 24, "houseAmmo%d", j + 1);
	            cache_get_value_name_int(i,str,HouseData[i][houseAmmo][j]);
	            
	            format(str, 24, "houseDurability%d", j + 1);
	            cache_get_value_name_int(i,str,HouseData[i][houseDurability][j]);
			}
			mysql_format(sqlcon, str, sizeof(str), "SELECT * FROM `furniture` WHERE `ID` = '%d'", HouseData[i][houseID]);

			mysql_tquery(sqlcon, str, "OnLoadFurniture", "d", i);

			Iter_Add(House, i);
			House_Spawn(i);
		}
		printf("[HOUSE] Loaded %d House from the Database", rows);
	}
	foreach(new i : House)
	{
		mysql_format(sqlcon, str, sizeof(str), "SELECT * FROM `housestorage` WHERE `ID` = '%d'", HouseData[i][houseID]);
		mysql_tquery(sqlcon, str, "OnLoadStorage", "d", i);
	}
	return 1;
}

FUNC::OnLoadStorage(houseid)
{
	static
		str[32];

	new rows = cache_num_rows();
 	if(rows)
  	{
		for(new i; i < rows; i++)
		{
		    HouseStorage[houseid][i][hItemExists] = true;
		    
		    cache_get_value_name_int(i, "itemID", HouseStorage[houseid][i][hItemID]);
		    cache_get_value_name_int(i, "itemModel", HouseStorage[houseid][i][hItemModel]);
		    cache_get_value_name_int(i, "itemQuantity", HouseStorage[houseid][i][hItemQuantity]);
		    cache_get_value_name(i, "itemName", str);
			strpack(HouseStorage[houseid][i][hItemName], str, 32 char);
		}
	}
	return 1;
}
stock House_Refresh(houseid)
{
	if (houseid != -1 && HouseData[houseid][houseExists])
	{
		new string[256];
		if(HouseData[houseid][houseParkPos][0] != 0 && HouseData[houseid][houseParkPos][1] != 0 && HouseData[houseid][houseParkPos][2] != 0 && HouseData[houseid][housePark] != 0)
		{
			new str[156];
			format(str, sizeof(str), "[ID: %d]\n{FFFFFF}Parking Slot: {FF6347}%d\n{FFFFFF}Type {FF0000}/house park {FFFFFF}to access", houseid, HouseData[houseid][housePark]);
			UpdateDynamic3DTextLabelText(HouseData[houseid][houseParkLabel], 0x007FFFFF, str);

			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, HouseData[houseid][houseParkLabel], E_STREAMER_X, HouseData[houseid][houseParkPos][0]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, HouseData[houseid][houseParkLabel], E_STREAMER_Y, HouseData[houseid][houseParkPos][1]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, HouseData[houseid][houseParkLabel], E_STREAMER_Z, HouseData[houseid][houseParkPos][2]);

			Streamer_SetFloatData(STREAMER_TYPE_CP, HouseData[houseid][houseParkCP], E_STREAMER_X, HouseData[houseid][houseParkPos][0]);
			Streamer_SetFloatData(STREAMER_TYPE_CP, HouseData[houseid][houseParkCP], E_STREAMER_Y, HouseData[houseid][houseParkPos][1]);
			Streamer_SetFloatData(STREAMER_TYPE_CP, HouseData[houseid][houseParkCP], E_STREAMER_Z, HouseData[houseid][houseParkPos][2]);
		}
		if(!HouseData[houseid][houseOwner])
		{
			format(string, sizeof(string), "[ID: %d]\n{33CC33}This house for sell\n{FFFFFF}Address: {FFFF00}%s\n{FFFFFF}Price: {FFFF00}$%s\n{FFFFFF}Parking Slot: {FF6347}%d\n{FFFFFF}Type /house buy to purchase", houseid, GetLocation(HouseData[houseid][housePos][0], HouseData[houseid][housePos][1], HouseData[houseid][housePos][2]), FormatNumber(HouseData[houseid][housePrice]), HouseData[houseid][housePark]);
		}
		else
		{
			format(string, sizeof(string), "[ID: %d]\n{FFFFFF}Owner: {FFFF00}%s\n{FFFFFF}Address: {FFFF00}%s\n{FFFFFF}Parking Slot: {FF6347}%d\n{FFFFFF}Press {FF0000}ENTER {FFFFFF}to enter house", houseid, HouseData[houseid][houseOwnerName], GetLocation(HouseData[houseid][housePos][0], HouseData[houseid][housePos][1], HouseData[houseid][housePos][2]), HouseData[houseid][housePark]);
		}

		UpdateDynamic3DTextLabelText(HouseData[houseid][houseText3D], 0x007FFFFF, string);
		Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, HouseData[houseid][houseText3D], E_STREAMER_X, HouseData[houseid][housePos][0]);
		Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, HouseData[houseid][houseText3D], E_STREAMER_Y, HouseData[houseid][housePos][1]);
		Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, HouseData[houseid][houseText3D], E_STREAMER_Z, HouseData[houseid][housePos][2]);

		Streamer_SetFloatData(STREAMER_TYPE_PICKUP, HouseData[houseid][housePickup], E_STREAMER_X, HouseData[houseid][housePos][0]);
		Streamer_SetFloatData(STREAMER_TYPE_PICKUP, HouseData[houseid][housePickup], E_STREAMER_Y, HouseData[houseid][housePos][1]);
		Streamer_SetFloatData(STREAMER_TYPE_PICKUP, HouseData[houseid][housePickup], E_STREAMER_Z, HouseData[houseid][housePos][2]);

		Streamer_SetFloatData(STREAMER_TYPE_CP, HouseData[houseid][houseCP], E_STREAMER_X, HouseData[houseid][housePos][0]);
		Streamer_SetFloatData(STREAMER_TYPE_CP, HouseData[houseid][houseCP], E_STREAMER_Y, HouseData[houseid][housePos][1]);
		Streamer_SetFloatData(STREAMER_TYPE_CP, HouseData[houseid][houseCP], E_STREAMER_Z, HouseData[houseid][housePos][2]);

		Streamer_SetPosition(STREAMER_TYPE_MAP_ICON, HouseData[houseid][houseIcon], HouseData[houseid][housePos][0], HouseData[houseid][housePos][1], HouseData[houseid][housePos][2]);
	}
	return 1;
}

stock House_Delete(houseid)
{
	if (Iter_Contains(House, houseid))
	{
	    new
	        string[128];


		mysql_format(sqlcon,string, sizeof(string), "DELETE FROM `houses` WHERE `houseID` = '%d'", HouseData[houseid][houseID]);
		mysql_tquery(sqlcon, string);

        if (IsValidDynamic3DTextLabel(HouseData[houseid][houseText3D]))
		    DestroyDynamic3DTextLabel(HouseData[houseid][houseText3D]);

		if (IsValidDynamicPickup(HouseData[houseid][housePickup]))
		    DestroyDynamicPickup(HouseData[houseid][housePickup]);

		if(IsValidDynamicCP(HouseData[houseid][houseCP]))
			DestroyDynamicCP(HouseData[houseid][houseCP]);
        
        if(IsValidDynamicCP(HouseData[houseid][houseParkCP]))
        	DestroyDynamicCP(HouseData[houseid][houseParkCP]);

        if(IsValidDynamic3DTextLabel(HouseData[houseid][houseParkLabel]))
        	DestroyDynamic3DTextLabel(HouseData[houseid][houseParkLabel]);

        if(IsValidDynamicMapIcon(HouseData[houseid][houseIcon]))
        	DestroyDynamicMapIcon(HouseData[houseid][houseIcon]);

	    foreach(new i : Furniture) if (FurnitureData[i][furnitureHouse] == houseid) 
	    {
	        FurnitureData[i][furnitureExists] = false;
	        FurnitureData[i][furnitureModel] = 0;
            FurnitureData[i][furnitureHouse] = -1;

            if(IsValidDynamicObject(FurnitureData[i][furnitureObject]))
	        	DestroyDynamicObject(FurnitureData[i][furnitureObject]);
		}
		mysql_format(sqlcon, string, sizeof(string), "DELETE FROM `furniture` WHERE `ID` = '%d'", HouseData[houseid][houseID]);
		mysql_tquery(sqlcon, string);

	    HouseData[houseid][houseExists] = false;
	    HouseData[houseid][houseOwner] = 0;
	    HouseData[houseid][houseID] = 0;
	    Iter_SafeRemove(House, houseid, houseid);
	}
	return 1;
}

stock House_GetCount(playerid)
{
	new
		count = 0;

	foreach(new i : House)
	{
		if (House_IsOwner(playerid, i))
   		{
   		    count++;
		}
	}
	return count;
}

CMD:house(playerid, params[])
{
	new
	    type[24],
	    string[128],
	    id;

	if (sscanf(params, "s[24]S()[128]", type, string))
	{
	    SendSyntaxMessage(playerid, "/house [name]");
	    SendClientMessage(playerid, COLOR_SERVER, "Names:{FFFFFF} buy, lock, menu, park");
	    return 1;
	}	
	if(!strcmp(type, "buy", true))
	{
		id = House_Nearest(playerid);

		if(House_GetCount(playerid) >= 2)
			return SendErrorMessage(playerid, "Kamu hanya bisa memiliki 2 rumah!");

		if(id == -1)
			return SendErrorMessage(playerid, "You're not in range of any houses!");

		if(HouseData[id][houseOwner] != 0)
			return SendErrorMessage(playerid, "This house is already owned!");

		if(GetMoney(playerid) < HouseData[id][housePrice])
			return SendErrorMessage(playerid, "You don't have enough money!");

		HouseData[id][houseOwner] = PlayerData[playerid][pID];
		format(HouseData[id][houseOwnerName], 64, PlayerData[playerid][pName]);
		GiveMoney(playerid, -HouseData[id][housePrice]);
		SendServerMessage(playerid, "Kamu berhasil membeli house ini dengan harga {00FF00}$%s", FormatNumber(HouseData[id][housePrice]));
		House_Refresh(id);
		House_Save(id);
	}
	else if(!strcmp(type, "park", true))
	{
		if((id = HousePark_Nearest(playerid)) != -1 && House_IsOwner(playerid, id))
		{
			ShowPlayerDialog(playerid, DIALOG_HOUSE_PARK, DIALOG_STYLE_LIST, sprintf("Parking Slot: %d", HouseData[id][housePark]), "Take Vehicle\nPark Vehicle", "Select", "Close");
		}
	}
	else if(!strcmp(type, "lock", true))
	{
	    if ((id = House_Nearest(playerid)) != -1 && House_IsOwner(playerid, id))
	    {
			if (!HouseData[id][houseLocked])
			{
				HouseData[id][houseLocked] = true;
				House_Save(id);

				ShowMessage(playerid, "You've ~r~locked ~w~the house", 3);
				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
			}
			else
			{
				HouseData[id][houseLocked] = false;
				House_Save(id);

				ShowMessage(playerid, "You've ~g~unlocked ~w~the house", 3);
				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
			}
			return 1;
		}
		else if ((id = House_Inside(playerid)) != -1 && House_IsOwner(playerid, id) && IsPlayerInRangeOfPoint(playerid, 2.5, HouseData[id][houseInt][0], HouseData[id][houseInt][1], HouseData[id][houseInt][2]))
	    {
			if (!HouseData[id][houseLocked])
			{
				HouseData[id][houseLocked] = true;
				House_Save(id);

				ShowMessage(playerid, "You've ~r~locked ~w~the house", 3);
				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
			}
			else
			{
				HouseData[id][houseLocked] = false;
				House_Save(id);

				ShowMessage(playerid, "You've ~g~unlocked ~w~the house", 3);
				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
			}
			return 1;
		}
	}
	else if(!strcmp(type, "menu", true))
	{
		id = House_Inside(playerid);
		if(House_Inside(playerid) == -1)
			return SendErrorMessage(playerid, "You must inside your own house!");

		if(!House_IsOwner(playerid, id))
			return SendErrorMessage(playerid, "You must inside your own house!");

		ShowPlayerDialog(playerid, DIALOG_HOUSE_MENU, DIALOG_STYLE_LIST, "House Menu", "Furniture\nStorage", "Select", "Close");
	}
	return 1;
}

CMD:edithouse(playerid, params[])
{
	static
	    id,
	    type[24],
	    string[128];

	if (PlayerData[playerid][pAdmin] < 7)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	SendSyntaxMessage(playerid, "/edithouse [id] [names]");
	    SendClientMessage(playerid, COLOR_YELLOW, "Names:{FFFFFF} location, interior, price, parkslot, parkpos, asell");
		return 1;
	}
	if (!Iter_Contains(House, id))
	    return SendErrorMessage(playerid, "You have specified an invalid house ID.");

	if (!strcmp(type, "location", true))
	{
		GetPlayerPos(playerid, HouseData[id][housePos][0], HouseData[id][housePos][1], HouseData[id][housePos][2]);
		GetPlayerFacingAngle(playerid, HouseData[id][housePos][3]);

		HouseData[id][houseExterior] = GetPlayerInterior(playerid);
		HouseData[id][houseExteriorVW] = GetPlayerVirtualWorld(playerid);

		House_Refresh(id);
		House_Save(id);

		SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has adjusted the location of house ID: %d.", PlayerData[playerid][pUCP], id);
	}
	else if (!strcmp(type, "parkpos", true))
	{
		GetPlayerPos(playerid, HouseData[id][houseParkPos][0], HouseData[id][houseParkPos][1], HouseData[id][houseParkPos][2]);

		if(!IsValidDynamic3DTextLabel(HouseData[id][houseParkLabel]))
		{
			new str[156];
			format(str, sizeof(str), "[ID: %d]\n{FFFFFF}Parking Slot: {FF6347}%d\n{FFFFFF}Type {FF0000}/house park {FFFFFF}to access", id, HouseData[id][housePark]);

			HouseData[id][houseParkCP] = CreateDynamicCP(HouseData[id][houseParkPos][0], HouseData[id][houseParkPos][1], HouseData[id][houseParkPos][2], 3.0, -1, -1, -1, 3.0);
			HouseData[id][houseParkLabel] = CreateDynamic3DTextLabel(str, 0x007FFFFF, HouseData[id][houseParkPos][0], HouseData[id][houseParkPos][1], HouseData[id][houseParkPos][2], 4.0);
		}
		House_Refresh(id);
		House_Save(id);

		SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has adjusted the park position of house ID: %d.", PlayerData[playerid][pUCP], id);
	}
	else if (!strcmp(type, "interior", true))
	{
	    GetPlayerPos(playerid, HouseData[id][houseInt][0], HouseData[id][houseInt][1], HouseData[id][houseInt][2]);
		GetPlayerFacingAngle(playerid, HouseData[id][houseInt][3]);

		HouseData[id][houseInterior] = GetPlayerInterior(playerid);

        foreach (new i : Player)
		{
			if (PlayerData[i][pInHouse] == id)
			{
				SetPlayerPos(i, HouseData[id][houseInt][0], HouseData[id][houseInt][1], HouseData[id][houseInt][2]);
				SetPlayerFacingAngle(i, HouseData[id][houseInt][3]);

				SetPlayerInterior(i, HouseData[id][houseInterior]);
				SetCameraBehindPlayer(i);
			}
		}
		House_Refresh(id);
		House_Save(id);
		SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has adjusted the interior spawn of house ID: %d.", PlayerData[playerid][pUCP], id);
	}
	else if (!strcmp(type, "price", true))
	{
	    new price[32];

	    if (sscanf(string, "s[32]", price))
	        return SendSyntaxMessage(playerid, "/edithouse [id] [price] [new price]");

	    HouseData[id][housePrice] = strcash(price);

		House_Refresh(id);
		House_Save(id);

		SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has adjusted the price of house ID: %d to $%s.",PlayerData[playerid][pUCP], id, FormatNumber(strcash(price)));
	}
	else if(!strcmp(type, "parkslot", true))
	{
		if(isnull(string))
			return SendSyntaxMessage(playerid, "/edithouse [id] [parkslot] [new slot]");

		HouseData[id][housePark] = strval(string);
		House_Refresh(id);
		House_Save(id);
		SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has adjusted the parking slot of house ID: %d to %d.",PlayerData[playerid][pUCP], id, strval(string));
	}
	else if(!strcmp(type, "asell", true))
	{
		HouseData[id][houseOwner] = 0;
		House_Refresh(id);
		House_Save(id);
		SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has aselled house ID: %d", PlayerData[playerid][pUCP], id);
	}
	return 1;
}

CMD:createhouse(playerid, params[])
{
	new
	    price[32],
	    id,
		type;

    if (PlayerData[playerid][pAdmin] < 7)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "ds[32]", type, price))
	    return SendSyntaxMessage(playerid, "/createhouse [type] [price]"), SendClientMessage(playerid, COLOR_YELLOW, "Type: {FFFFFF}1. Small#1 | 2. Small#2 | 3. Medium | 4. Big");

	if (type < 1 || type > 4)
	    return SendErrorMessage(playerid, "Invalid type specified. Types range from 1 to 4.");

	id = House_Create(playerid, strcash(price), type);

	if (id == -1)
	    return SendErrorMessage(playerid, "You can't add more Houses!");

	SendServerMessage(playerid, "You have successfully created house ID: %d.", id);
	return 1;
}

CMD:destroyhouse(playerid, params[])
{
	static
	    id = 0;

    if (PlayerData[playerid][pAdmin] < 7)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "d", id))
	    return SendSyntaxMessage(playerid, "/destroyhouse [house id]");

	if (!Iter_Contains(House, id))
	    return SendErrorMessage(playerid, "You have specified an invalid house ID.");

	House_Delete(id);
	SendServerMessage(playerid, "You have successfully destroyed house ID: %d.", id);
	return 1;
}
