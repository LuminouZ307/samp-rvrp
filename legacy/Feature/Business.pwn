enum 
{
	TYPE_FASTFOOD = 1,
	TYPE_247,
	TYPE_CLOTHES,
	TYPE_ELECTRO
};

enum e_biz_data
{
	bizID,
	bizName[32],
	bizOwner,
	bizOwnerName[MAX_PLAYER_NAME],
	bool:bizExists,
	Float:bizInt[3],
	Float:bizExt[3],
	Float:bizDeliver[3],
	bizWorld,
	bizInterior,
	bizVault,
	bizPrice,
	bizLocked,
	bizFuel,
	bizProduct[7],
	bizType,
	bizStock,
	bizCargo,
	bizDiesel,
	bool:bizReq,
	Float:bizFuelPos[3],
	STREAMER_TAG_PICKUP:bizFuelPickup,
	STREAMER_TAG_3D_TEXT_LABEL:bizFuelText,
	STREAMER_TAG_PICKUP:bizDeliverPickup,
	STREAMER_TAG_3D_TEXT_LABEL:bizDeliverText,
	STREAMER_TAG_PICKUP:bizPickup,
	STREAMER_TAG_3D_TEXT_LABEL:bizText,
	STREAMER_TAG_CP:bizCP,
	STREAMER_TAG_MAP_ICON:bizIcon,
};

new BizData[MAX_BUSINESS][e_biz_data];
new ProductName[MAX_BUSINESS][7][24], ProductDescription[MAX_BUSINESS][7][42];

stock ShowNumberIndex(playerid)
{
	new str[256];

	forex(i, 5)
	{
		NumberIndex[playerid][i] = RandomEx(11111, 98888);
		format(str, sizeof(str), "%s{FFFF00}%d\n", str, NumberIndex[playerid][i]);
	}
	format(str, sizeof(str), "%s{FF0000}Refresh Number List", str);
	ShowPlayerDialog(playerid, DIALOG_NUMBERPHONE, DIALOG_STYLE_LIST, "Select Phone Number", str, "Select", "Close");
	return 1;
}

stock ShowBizStats(playerid)
{
	new id = PlayerData[playerid][pInBiz];
	if(id == -1)
		return 0;

	new str[512];
	strcat(str, "Name\tInfo\n");
	strcat(str, sprintf("Business Name:\t%s\n", BizData[id][bizName]));
	strcat(str, sprintf("Business Type:\t%s\n", GetBizType(BizData[id][bizType])));
	strcat(str, sprintf("Available stock:\t%d left\n", BizData[id][bizStock]));
	strcat(str, sprintf("Cash Vault:\t$%s\t", FormatNumber(BizData[id][bizVault])));
	ShowPlayerDialog(playerid, DIALOG_NONE, DIALOG_STYLE_TABLIST_HEADERS, "Business Stats", str, "Close", "");
	return 1;
}

stock Biz_GetCount(playerid)
{
	new count = 0;
	forex(i, MAX_BUSINESS) if(BizData[i][bizExists] && BizData[i][bizOwner] == PlayerData[playerid][pID])
	{
	    count++;
	}
	return count;
}

stock SetProductName(playerid)
{
	new bid = PlayerData[playerid][pInBiz], string[712];
	if(!BizData[bid][bizExists])
	    return 0;

	switch(BizData[bid][bizType])
	{
	    case 1:
	    {
	        format(string, sizeof(string), "Product\tPrice\n%s (Food +20)\t$%s\n%s (Food +40)\t$%s\n%s (Drink)\t$%s",
				ProductName[bid][0],
				FormatNumber(BizData[bid][bizProduct][0]),
				ProductName[bid][1],
	            FormatNumber(BizData[bid][bizProduct][1]),
	            ProductName[bid][2],
	            FormatNumber(BizData[bid][bizProduct][2])
			);
		}
		case 2:
		{
		    format(string, sizeof(string), "Product\tPrice\n%s\t$%s\n%s\t$%s\n%s\t$%s\n%s\t$%s\n%s\t$%s\n%s\t$%s\n%s\t$%s",
                ProductName[bid][0],
				FormatNumber(BizData[bid][bizProduct][0]),
				ProductName[bid][1],
	            FormatNumber(BizData[bid][bizProduct][1]),
	            ProductName[bid][2],
	            FormatNumber(BizData[bid][bizProduct][2]),
	            ProductName[bid][3],
	            FormatNumber(BizData[bid][bizProduct][3]),
	        	ProductName[bid][4],
	            FormatNumber(BizData[bid][bizProduct][4]),
	        	ProductName[bid][5],
	            FormatNumber(BizData[bid][bizProduct][5]),
	            ProductName[bid][6],
	            FormatNumber(BizData[bid][bizProduct][6])
			);
		}
		case 3:
		{
		    format(string, sizeof(string), "Product\tPrice\n%s (Clothes)\t$%s\n%s (Accessory)\t$%s",
                ProductName[bid][0],
		        FormatNumber(BizData[bid][bizProduct][0]),
                ProductName[bid][1],
		        FormatNumber(BizData[bid][bizProduct][1])
			);
		}
		case 4:
		{
		    format(string, sizeof(string), "Product\tPrice\n%s (Cellphone)\t$%s\n%s (GPS)\t$%s\n%s (Radio)\t$%s\n%s (Phone Credit)\t$%s",
                ProductName[bid][0],
				FormatNumber(BizData[bid][bizProduct][0]),
				ProductName[bid][1],
	            FormatNumber(BizData[bid][bizProduct][1]),
	            ProductName[bid][2],
	            FormatNumber(BizData[bid][bizProduct][2]),
	            ProductName[bid][3],
	            FormatNumber(BizData[bid][bizProduct][3])
			);
		}
	}
	ShowPlayerDialog(playerid, DIALOG_BIZPROD, DIALOG_STYLE_TABLIST_HEADERS, "Set Product Name", string, "Select", "Close");
	return 1;
}

stock Business_Create(playerid, type, price)
{
	new
	    Float:x,
	    Float:y,
	    Float:z;

	if (GetPlayerPos(playerid, x, y, z))
	{
		forex(i, MAX_BUSINESS)
		{
	    	if (!BizData[i][bizExists])
		    {
    	        BizData[i][bizExists] = true;
        	    BizData[i][bizOwner] = -1;
            	BizData[i][bizPrice] = price;
            	BizData[i][bizType] = type;

				format(BizData[i][bizName], 32, "None Business");
				format(BizData[i][bizOwnerName], MAX_PLAYER_NAME, "No Owner");
    	        BizData[i][bizExt][0] = x;
    	        BizData[i][bizExt][1] = y;
    	        BizData[i][bizExt][2] = z;

				if (type == 1)
				{
                	BizData[i][bizInt][0] = 363.22;
                	BizData[i][bizInt][1] = -74.86;
                	BizData[i][bizInt][2] = 1001.50;
					BizData[i][bizInterior] = 10;
					format(ProductName[i][0], 24, "French Fries");
					format(ProductName[i][1], 24, "Fried Chicken");
					format(ProductName[i][2], 24, "Coca Cola");
				}
				else if (type == 2)
				{
                	BizData[i][bizInt][0] = 5.73;
                	BizData[i][bizInt][1] = -31.04;
                	BizData[i][bizInt][2] = 1003.54;
					BizData[i][bizInterior] = 10;
					format(ProductName[i][0], 24, "Chitato");
					format(ProductName[i][1], 24, "Danone Mineral");
					format(ProductName[i][2], 24, "Mask");
					format(ProductName[i][3], 24, "First Aid");
					format(ProductName[i][4], 24, "Rolling Paper");
					format(ProductName[i][5], 24, "Axe");
					format(ProductName[i][6], 24, "Fish Rod");
				}
				else if(type == 3)
				{
                	BizData[i][bizInt][0] = 207.55;
                	BizData[i][bizInt][1] = -110.67;
                	BizData[i][bizInt][2] = 1005.13;
					BizData[i][bizInterior] = 15;
					format(ProductName[i][0], 24, "Clothes");
					format(ProductName[i][1], 24, "Accessory");
				}
				else if(type == 4)
				{
                	BizData[i][bizInt][0] = -2240.7825;
                	BizData[i][bizInt][1] = 137.1855;
                	BizData[i][bizInt][2] = 1035.4141;
					BizData[i][bizInterior] = 6;
					format(ProductName[i][0], 24, "Huawei Mate");
					format(ProductName[i][1], 24, "GPS");
					format(ProductName[i][2], 24, "Walkie Talkie");
					format(ProductName[i][3], 24, "Electric Credit");
				}
				forex(e, 7)
				{
					format(ProductDescription[i][e], 40, "No description");
				}
				BizData[i][bizVault] = 0;
				BizData[i][bizStock] = 100;
				BizData[i][bizCargo] = 10000;
				BizData[i][bizFuel] = 1000;
				BizData[i][bizDiesel] = 1000;
				BizData[i][bizLocked] = true;
				Business_Spawn(i);
				mysql_tquery(sqlcon, "INSERT INTO `business` (`bizOwner`) VALUES(0)", "OnBusinessCreated", "d", i);
				return i;
			}
		}
	}
	return -1;
}

stock Biz_IsOwner(playerid, id)
{
	if(!BizData[id][bizExists])
	    return 0;
	    
	if(BizData[id][bizOwner] == PlayerData[playerid][pID])
		return 1;
		
	return 0;
}

FUNC::OnBusinessCreated(bizid)
{
	if (bizid == -1 || !BizData[bizid][bizExists])
	    return 0;

	BizData[bizid][bizID] = cache_insert_id();
	BizData[bizid][bizWorld] = BizData[bizid][bizID]+1000;
	
	Business_Save(bizid);
	return 1;
}

FUNC::Business_Load()
{
	new rows = cache_num_rows(), str[128], desc[312];
 	if(rows)
  	{
		forex(i, rows)
		{
		    BizData[i][bizExists] = true;
		    cache_get_value_name(i, "bizName", BizData[i][bizName]);
		    cache_get_value_name_int(i, "bizOwner", BizData[i][bizOwner]);
		    cache_get_value_name_int(i, "bizID", BizData[i][bizID]);
		    cache_get_value_name_float(i, "bizExtX", BizData[i][bizExt][0]);
		    cache_get_value_name_float(i, "bizExtY", BizData[i][bizExt][1]);
		    cache_get_value_name_float(i, "bizExtZ", BizData[i][bizExt][2]);
		    cache_get_value_name_float(i, "bizIntX", BizData[i][bizInt][0]);
		    cache_get_value_name_float(i, "bizIntY", BizData[i][bizInt][1]);
		    cache_get_value_name_float(i, "bizIntZ", BizData[i][bizInt][2]);
			forex(j, 7)
			{
				format(str, 32, "bizProduct%d", j + 1);
				cache_get_value_name_int(i, str, BizData[i][bizProduct][j]);
				format(str, 32, "bizProdName%d", j + 1);
				cache_get_value_name(i, str, ProductName[i][j]);
				format(desc, 312, "bizDescription%d", j + 1);
				cache_get_value_name(i, desc, ProductDescription[i][j]);
			}

			cache_get_value_name_int(i, "bizVault", BizData[i][bizVault]);
			cache_get_value_name_int(i, "bizPrice", BizData[i][bizPrice]);
			cache_get_value_name_int(i, "bizType", BizData[i][bizType]);
			cache_get_value_name_int(i, "bizWorld", BizData[i][bizWorld]);
			cache_get_value_name_int(i, "bizInterior", BizData[i][bizInterior]);
			cache_get_value_name_int(i, "bizType", BizData[i][bizType]);
			cache_get_value_name_int(i, "bizStock", BizData[i][bizStock]);
			cache_get_value_name_int(i, "bizFuel", BizData[i][bizFuel]);
			cache_get_value_name(i, "bizOwnerName", BizData[i][bizOwnerName]);
			cache_get_value_name_float(i, "bizDeliverX", BizData[i][bizDeliver][0]);
			cache_get_value_name_float(i, "bizDeliverY", BizData[i][bizDeliver][1]);
			cache_get_value_name_float(i, "bizDeliverZ", BizData[i][bizDeliver][2]);
			cache_get_value_name_int(i, "bizCargo", BizData[i][bizCargo]);
			cache_get_value_name_float(i, "bizFuelX", BizData[i][bizFuelPos][0]);
			cache_get_value_name_float(i, "bizFuelY", BizData[i][bizFuelPos][1]);
			cache_get_value_name_float(i, "bizFuelZ", BizData[i][bizFuelPos][2]);
			cache_get_value_name_int(i, "bizLocked", BizData[i][bizLocked]);
			cache_get_value_name_int(i, "bizDiesel", BizData[i][bizDiesel]);

			Business_Spawn(i);
		}
		printf("[BUSINESS] Loaded %d Business from database", rows);
	}
	return 1;
}

stock Business_Spawn(i)
{
	new
	    string[256], icon;
	//1: Fast Food | 2: 24/7 | 3: Clothes | 4: Electronic
	switch(BizData[i][bizType])
	{
		case 1: icon = 50;
		case 2: icon = 48;
		case 3: icon = 45;
		case 4: icon = 25;
	}
	if(BizData[i][bizDeliver][0] != 0 && BizData[i][bizDeliver][1] != 0 && BizData[i][bizDeliver][2] != 0)
	{
		BizData[i][bizDeliverPickup] = CreateDynamicPickup(1239, 23, BizData[i][bizDeliver][0], BizData[i][bizDeliver][1], BizData[i][bizDeliver][2], -1, -1);
		BizData[i][bizDeliverText] = CreateDynamic3DTextLabel(sprintf("%s\n{C6E2FF}Delivery Point", BizData[i][bizName]), COLOR_SERVER, BizData[i][bizDeliver][0], BizData[i][bizDeliver][1], BizData[i][bizDeliver][2], 15.0);
	}
	if(BizData[i][bizFuelPos][0] != 0 && BizData[i][bizFuelPos][1] != 0 && BizData[i][bizFuelPos][2] != 0)
	{
		BizData[i][bizFuelText] = CreateDynamic3DTextLabel(sprintf("Gasoline: %d Liter\nDiesel: %d Liter\nType /refuel to refuel", BizData[i][bizFuel], BizData[i][bizDiesel]), COLOR_SERVER, BizData[i][bizFuelPos][0], BizData[i][bizFuelPos][1], BizData[i][bizFuelPos][2], 15.0);
		BizData[i][bizFuelPickup] = CreateDynamicPickup(1650, 23, BizData[i][bizFuelPos][0], BizData[i][bizFuelPos][1], BizData[i][bizFuelPos][2], -1, -1);
	}
	if (BizData[i][bizOwner] == -1)
	{
		format(string, sizeof(string), "[ID: %d]\nType: {C6E2FF}%s\n{FFFFFF}Price: {C6E2FF}$%s\n{FFFFFF}This business for sell\n{FFFF00}/biz buy {FFFFFF}for purchase this business.", i, GetBizType(BizData[i][bizType]), FormatNumber(BizData[i][bizPrice]));
        BizData[i][bizText] = CreateDynamic3DTextLabel(string, -1, BizData[i][bizExt][0], BizData[i][bizExt][1], BizData[i][bizExt][2], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1);
	}
	else
	{
		format(string, sizeof(string), "[ID: %d]\nName: %s{FFFFFF}\nStatus: {C6E2FF}%s{FFFFFF}\nType: {C6E2FF}%s", i, BizData[i][bizName], (!BizData[i][bizLocked]) ? ("{00FF00}Open{FFFFFF}") : ("{FF0000}Closed{FFFFFF}"), GetBizType(BizData[i][bizType]));
		BizData[i][bizText] = CreateDynamic3DTextLabel(string, -1, BizData[i][bizExt][0], BizData[i][bizExt][1], BizData[i][bizExt][2], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1);
	}
	BizData[i][bizCP] = CreateDynamicCP(BizData[i][bizExt][0], BizData[i][bizExt][1], BizData[i][bizExt][2], 1.0, -1, -1, -1, 2.0);
	BizData[i][bizPickup] = CreateDynamicPickup(19130, 23, BizData[i][bizExt][0], BizData[i][bizExt][1], BizData[i][bizExt][2], -1, -1);
	BizData[i][bizIcon] = CreateDynamicMapIcon(BizData[i][bizExt][0], BizData[i][bizExt][1], BizData[i][bizExt][2], icon, -1, -1, -1, -1, 70.0);
	return 1;
}
stock Business_Save(bizid)
{
	new
	    query[2048];

	mysql_format(sqlcon, query, sizeof(query), "UPDATE `business` SET `bizName` = '%s', `bizOwner` = '%d', `bizExtX` = '%f', `bizExtY` = '%f', `bizExtZ` = '%f', `bizIntX` = '%f', `bizIntY` = '%f', `bizIntZ` = '%f', `bizDeliverX` = '%f', `bizDeliverY` = '%f', `bizDeliverZ` = '%f', `bizCargo` = '%d', `bizDiesel` = '%d', `bizLocked` = '%d'",
		BizData[bizid][bizName],
		BizData[bizid][bizOwner],
		BizData[bizid][bizExt][0],
		BizData[bizid][bizExt][1],
		BizData[bizid][bizExt][2],
		BizData[bizid][bizInt][0],
		BizData[bizid][bizInt][1],
		BizData[bizid][bizInt][2],
		BizData[bizid][bizDeliver][0],
		BizData[bizid][bizDeliver][1],
		BizData[bizid][bizDeliver][2],
		BizData[bizid][bizCargo],
		BizData[bizid][bizDiesel],
		BizData[bizid][bizLocked]
	);
	forex(i, 7)
	{
		mysql_format(sqlcon, query, sizeof(query), "%s, `bizProduct%d` = '%d'", query, i + 1, BizData[bizid][bizProduct][i]);
	}
	forex(i, 7)
	{
		mysql_format(sqlcon, query, sizeof(query), "%s, `bizProdName%d` = '%s', `bizDescription%d` = '%s'", query, i + 1, ProductName[bizid][i], i + 1, ProductDescription[bizid][i]);
	}
	mysql_format(sqlcon, query, sizeof(query), "%s, `bizWorld` = '%d', `bizInterior` = '%d', `bizVault` = '%d', `bizType` = '%d', `bizStock` = '%d', `bizPrice` = '%d', `bizFuel` = '%d', `bizOwnerName` = '%s', `bizFuelX` = '%f', `bizFuelY` = '%f', `bizFuelZ` = '%f' WHERE `bizID` = '%d'",
		query,
		BizData[bizid][bizWorld],
		BizData[bizid][bizInterior],
		BizData[bizid][bizVault],
		BizData[bizid][bizType],
		BizData[bizid][bizStock],
		BizData[bizid][bizPrice],
		BizData[bizid][bizFuel],
		BizData[bizid][bizOwnerName],
		BizData[bizid][bizFuelPos][0], 
		BizData[bizid][bizFuelPos][1], 
		BizData[bizid][bizFuelPos][2], 
		BizData[bizid][bizID]
	);
	return mysql_tquery(sqlcon, query);
}

stock GetBizType(type)
{
	new str[32];
	switch(type)
	{
	    case 1: str = "Fast Food";
	    case 2: str = "24/7";
	    case 3: str = "Clothes";
	    case 4: str = "Electronic";
	}
	return str;
}

stock Business_Refresh(bizid)
{
	if (bizid != -1 && BizData[bizid][bizExists])
	{

		new
		    string[256];

		if(BizData[bizid][bizDeliver][0] != 0 && BizData[bizid][bizDeliver][1] != 0 && BizData[bizid][bizDeliver][2] != 0)
		{
			Streamer_SetFloatData(STREAMER_TYPE_PICKUP, BizData[bizid][bizDeliverPickup], E_STREAMER_X, BizData[bizid][bizDeliver][0]);
			Streamer_SetFloatData(STREAMER_TYPE_PICKUP, BizData[bizid][bizDeliverPickup], E_STREAMER_Y, BizData[bizid][bizDeliver][1]);
			Streamer_SetFloatData(STREAMER_TYPE_PICKUP, BizData[bizid][bizDeliverPickup], E_STREAMER_Z, BizData[bizid][bizDeliver][2]);

			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, BizData[bizid][bizDeliverText], E_STREAMER_X, BizData[bizid][bizDeliver][0]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, BizData[bizid][bizDeliverText], E_STREAMER_Y, BizData[bizid][bizDeliver][1]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, BizData[bizid][bizDeliverText], E_STREAMER_Z, BizData[bizid][bizDeliver][2]);

			UpdateDynamic3DTextLabelText(BizData[bizid][bizDeliverText], COLOR_SERVER, sprintf("%s\nDelivery Point", BizData[bizid][bizName]));
		}
		if(BizData[bizid][bizFuelPos][0] != 0 && BizData[bizid][bizFuelPos][1] != 0 && BizData[bizid][bizFuelPos][2] != 0)
		{
			Streamer_SetFloatData(STREAMER_TYPE_PICKUP, BizData[bizid][bizFuelPickup], E_STREAMER_X, BizData[bizid][bizFuelPos][0]);
			Streamer_SetFloatData(STREAMER_TYPE_PICKUP, BizData[bizid][bizFuelPickup], E_STREAMER_Y, BizData[bizid][bizFuelPos][1]);
			Streamer_SetFloatData(STREAMER_TYPE_PICKUP, BizData[bizid][bizFuelPickup], E_STREAMER_Z, BizData[bizid][bizFuelPos][2]);

			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, BizData[bizid][bizFuelText], E_STREAMER_X, BizData[bizid][bizFuelPos][0]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, BizData[bizid][bizFuelText], E_STREAMER_Y, BizData[bizid][bizFuelPos][1]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, BizData[bizid][bizFuelText], E_STREAMER_Z, BizData[bizid][bizFuelPos][2]);


			UpdateDynamic3DTextLabelText(BizData[bizid][bizFuelText], COLOR_SERVER, sprintf("Gasoline: %d Liter\nDiesel: %d Liter\nType /refuel to refuel", BizData[bizid][bizFuel], BizData[bizid][bizDiesel]));
		}
		if (BizData[bizid][bizOwner] == -1)
		{
			format(string, sizeof(string), "[ID: %d]\nType: {C6E2FF}%s\n{FFFFFF}Price: {C6E2FF}$%s\n{FFFFFF}This business for sell\n{FFFF00}/biz buy {FFFFFF}for purchase this business.", bizid, GetBizType(BizData[bizid][bizType]), FormatNumber(BizData[bizid][bizPrice]));
		}
		else
		{
  			format(string, sizeof(string), "[ID: %d]\nName: %s{FFFFFF}\nStatus: {C6E2FF}%s{FFFFFF}\nType: {C6E2FF}%s", bizid, BizData[bizid][bizName], (!BizData[bizid][bizLocked]) ? ("{00FF00}Open{FFFFFF}") : ("{FF0000}Closed{FFFFFF}"), GetBizType(BizData[bizid][bizType]));
		}
		Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, BizData[bizid][bizText], E_STREAMER_X, BizData[bizid][bizExt][0]);
		Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, BizData[bizid][bizText], E_STREAMER_Y, BizData[bizid][bizExt][1]);
		Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, BizData[bizid][bizText], E_STREAMER_Z, BizData[bizid][bizExt][2]);

		Streamer_SetFloatData(STREAMER_TYPE_PICKUP, BizData[bizid][bizPickup], E_STREAMER_X, BizData[bizid][bizExt][0]);
		Streamer_SetFloatData(STREAMER_TYPE_PICKUP, BizData[bizid][bizPickup], E_STREAMER_Y, BizData[bizid][bizExt][1]);
		Streamer_SetFloatData(STREAMER_TYPE_PICKUP, BizData[bizid][bizPickup], E_STREAMER_Z, BizData[bizid][bizExt][2]);

		Streamer_SetFloatData(STREAMER_TYPE_CP, BizData[bizid][bizCP], E_STREAMER_X, BizData[bizid][bizExt][0]);
		Streamer_SetFloatData(STREAMER_TYPE_CP, BizData[bizid][bizCP], E_STREAMER_Y, BizData[bizid][bizExt][1]);
		Streamer_SetFloatData(STREAMER_TYPE_CP, BizData[bizid][bizCP], E_STREAMER_Z, BizData[bizid][bizExt][2]);
		UpdateDynamic3DTextLabelText(BizData[bizid][bizText], COLOR_SERVER, string);

		Streamer_SetPosition(STREAMER_TYPE_MAP_ICON, BizData[bizid][bizIcon], BizData[bizid][bizExt][0], BizData[bizid][bizExt][1], BizData[bizid][bizExt][2]);
	}
	return 1;
}

stock Business_Nearest(playerid, Float:range = 4.0)
{
	forex(i, MAX_BUSINESS) if(BizData[i][bizExists])
	{
		if(IsPlayerInRangeOfPoint(playerid, range, BizData[i][bizExt][0], BizData[i][bizExt][1], BizData[i][bizExt][2]))
		{
			return i;
		}
	}
	return -1;
}

stock Business_NearestDeliver(playerid, Float:range = 4.0)
{
	forex(i, MAX_BUSINESS) if(BizData[i][bizExists])
	{
		if(IsPlayerInRangeOfPoint(playerid, range, BizData[i][bizDeliver][0], BizData[i][bizDeliver][1], BizData[i][bizDeliver][2]))
		{
			return i;
		}
	}
	return -1;
}

stock Business_NearestFuel(playerid, Float:range = 4.0)
{
	forex(i, MAX_BUSINESS) if(BizData[i][bizExists])
	{
		if(IsPlayerInRangeOfPoint(playerid, range, BizData[i][bizFuelPos][0], BizData[i][bizFuelPos][1], BizData[i][bizFuelPos][2]))
		{
			return i;
		}
	}
	return -1;
}

stock Business_Delete(bizid)
{
	if(BizData[bizid][bizExists])
	{
		new string[64];
		mysql_format(sqlcon, string, sizeof(string), "DELETE FROM `business` WHERE `bizID` = '%d'", BizData[bizid][bizID]);
		mysql_tquery(sqlcon, string);

		if (IsValidDynamic3DTextLabel(BizData[bizid][bizText]))
		    DestroyDynamic3DTextLabel(BizData[bizid][bizText]);

		if (IsValidDynamicPickup(BizData[bizid][bizPickup]))
		    DestroyDynamicPickup(BizData[bizid][bizPickup]);

		if(IsValidDynamicCP(BizData[bizid][bizCP]))
		    DestroyDynamicCP(BizData[bizid][bizCP]);
		   
		if(IsValidDynamicPickup(BizData[bizid][bizDeliverPickup]))
			DestroyDynamicPickup(BizData[bizid][bizDeliverPickup]);

		if(IsValidDynamic3DTextLabel(BizData[bizid][bizDeliverText]))
			DestroyDynamic3DTextLabel(BizData[bizid][bizDeliverText]);

		if(IsValidDynamicPickup(BizData[bizid][bizFuelPickup]))
			DestroyDynamicPickup(BizData[bizid][bizFuelPickup]);

		if(IsValidDynamic3DTextLabel(BizData[bizid][bizFuelText]))
			DestroyDynamic3DTextLabel(BizData[bizid][bizFuelText]);

		if(IsValidDynamicMapIcon(BizData[bizid][bizIcon]))
			DestroyDynamicMapIcon(BizData[bizid][bizIcon]);

		BizData[bizid][bizID] = 0;
		BizData[bizid][bizExists] = false;
		BizData[bizid][bizOwner] = -1;
	}
	return 1;
}

stock SetProductPrice(playerid)
{
	new bid = PlayerData[playerid][pInBiz], string[712];
	if(!BizData[bid][bizExists])
	    return 0;

	switch(BizData[bid][bizType])
	{
	    case 1:
	    {
	        format(string, sizeof(string), "Product\tPrice\n%s\t$%s\n%s\t$%s\n%s\t$%s",
				ProductName[bid][0],
				FormatNumber(BizData[bid][bizProduct][0]),
				ProductName[bid][1],
	            FormatNumber(BizData[bid][bizProduct][1]),
	            ProductName[bid][2],
	            FormatNumber(BizData[bid][bizProduct][2])
			);
		}
		case 2:
		{
		    format(string, sizeof(string), "Product\tPrice\n%s\t$%s\n%s\t$%s\n%s\t$%s\n%s\t$%s\n%s\t$%s\n%s\t$%s\n%s\t$%s",
                ProductName[bid][0],
				FormatNumber(BizData[bid][bizProduct][0]),
				ProductName[bid][1],
	            FormatNumber(BizData[bid][bizProduct][1]),
	            ProductName[bid][2],
	            FormatNumber(BizData[bid][bizProduct][2]),
	            ProductName[bid][3],
	            FormatNumber(BizData[bid][bizProduct][3]),
	        	ProductName[bid][4],
	            FormatNumber(BizData[bid][bizProduct][4]),
	        	ProductName[bid][5],
	            FormatNumber(BizData[bid][bizProduct][5]),
	            ProductName[bid][6],
	            FormatNumber(BizData[bid][bizProduct][6])
			);
		}
		case 3:
		{
		    format(string, sizeof(string), "Product\tPrice\n%s\t$%s\n%s\t$%s",
                ProductName[bid][0],
		        FormatNumber(BizData[bid][bizProduct][0]),
                ProductName[bid][1],
		        FormatNumber(BizData[bid][bizProduct][1]) 
			);
		}
		case 4:
		{
		    format(string, sizeof(string), "Product\tPrice\n%s\t$%s\n%s\t$%s\n%s\t$%s\n%s\t$%s",
                ProductName[bid][0],
				FormatNumber(BizData[bid][bizProduct][0]),
				ProductName[bid][1],
	            FormatNumber(BizData[bid][bizProduct][1]),
	            ProductName[bid][2],
	            FormatNumber(BizData[bid][bizProduct][2]),
	            ProductName[bid][3],
	            FormatNumber(BizData[bid][bizProduct][3])
			);
		}
	}
	ShowPlayerDialog(playerid, DIALOG_BIZPRICE, DIALOG_STYLE_TABLIST_HEADERS, "Set Product Price", string, "Select", "Close");
	return 1;
}

Store:BusinessElectronic(playerid, response, itemid, modelid, price, amount, itemname[])
{
	new bizid = PlayerData[playerid][pInBiz];

    if(!response)
        return true;

    if(GetMoney(playerid) < price)
        return SendErrorMessage(playerid, "You don't have enough money to purchase %s!", itemname);

    if(modelid == 18875 && Inventory_Count(playerid, "GPS") > 0)
    	return SendErrorMessage(playerid, "You already have a GPS!");

    if(itemid == 1)
    {
    	ShowNumberIndex(playerid);
    }
    else if(itemid == 4)
    {
		PlayerData[playerid][pCredit] += 50;
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s has paid $%s and purchased a %s.", ReturnName(playerid), FormatNumber(price), ProductName[bizid][itemid - 1]);
		GiveMoney(playerid, -price);
		BizData[bizid][bizStock]--;
		BizData[bizid][bizVault] += price;
    }
    else
    {
    	new const itemnames[3][24] = {
    		"Cellphone",
    		"GPS",
    		"Portable Radio"
    	};

    	Inventory_Add(playerid, itemnames[itemid - 1], modelid, 1);
	 	GiveMoney(playerid, -price);
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s has paid $%s and purchased a %s.", ReturnName(playerid), FormatNumber(price), ProductName[bizid][itemid - 1]);
		BizData[bizid][bizStock]--;
		BizData[bizid][bizVault] += price;
    }
    TogglePlayerControllable(playerid, 1);
    return 1;
}
Store:BusinessMarket(playerid, response, itemid, modelid, price, amount, itemname[])
{
	new bizid = PlayerData[playerid][pInBiz];

    if(!response)
        return true;

    if(GetMoney(playerid) < price)
        return SendErrorMessage(playerid, "You don't have enough money to purchase %s!", itemname);

    if(modelid == 19036 && Inventory_Count(playerid, "Mask") > 0)
    	return SendErrorMessage(playerid, "You already have a mask!");


 	GiveMoney(playerid, -price);
	SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s has paid $%s and purchased a %s.", ReturnName(playerid), FormatNumber(price), ProductName[bizid][itemid - 1]);	GiveMoney(playerid, -price);
	BizData[bizid][bizStock]--;
	BizData[bizid][bizVault] += price;
	new const itemnames[7][24] = {
		"Snack",
		"Water",
		"Mask",
		"Medkit",
		"Rolling Paper",
		"Axe",
		"Fish Rod"
	};

	Inventory_Add(playerid, itemnames[itemid - 1], modelid, 1);

	if(modelid == 19036)
	{
		PlayerData[playerid][pMaskID] = PlayerData[playerid][pID]+random(90000) + 10000;
		SendClientMessageEx(playerid, -1, "* You have purchased a mask, your MaskID {FFFF00}%d", PlayerData[playerid][pMaskID]);
	}
	TogglePlayerControllable(playerid, 1);
    return true;
}
stock ShowBusinessMenu(playerid)
{
	new bid = PlayerData[playerid][pInBiz], string[712];
	if(!BizData[bid][bizExists])
	    return 0;
	    
	switch(BizData[bid][bizType])
	{
	    case 1:
	    {
	        format(string, sizeof(string), "Product\tPrice\n%s\t$%s\n%s\t$%s\n%s\t$%s",
				ProductName[bid][0],
				FormatNumber(BizData[bid][bizProduct][0]),
				ProductName[bid][1],
	            FormatNumber(BizData[bid][bizProduct][1]),
	            ProductName[bid][2],
	            FormatNumber(BizData[bid][bizProduct][2])
			);
			ShowPlayerDialog(playerid, DIALOG_BIZBUY, DIALOG_STYLE_TABLIST_HEADERS, "Business Product", string, "Select", "Close");
		}
		case 2://anjime
		{
			if(PlayerData[playerid][pTogBuy])
			{
				MenuStore_AddItem(playerid, 1, 2768, ProductName[bid][0], BizData[bid][bizProduct][0], ProductDescription[bid][0], 200);
				MenuStore_AddItem(playerid, 2, 2958, ProductName[bid][1], BizData[bid][bizProduct][1], ProductDescription[bid][1], 200);
				MenuStore_AddItem(playerid, 3, 19036, ProductName[bid][2], BizData[bid][bizProduct][2], ProductDescription[bid][2], 200);
				MenuStore_AddItem(playerid, 4, 1580, ProductName[bid][3], BizData[bid][bizProduct][3], ProductDescription[bid][3], 200);
				MenuStore_AddItem(playerid, 5, 19873, ProductName[bid][4], BizData[bid][bizProduct][4], ProductDescription[bid][4], 200);
				MenuStore_AddItem(playerid, 6, 19631, ProductName[bid][5], BizData[bid][bizProduct][5], ProductDescription[bid][5], 200);
				MenuStore_AddItem(playerid, 7, 18632, ProductName[bid][6], BizData[bid][bizProduct][6], ProductDescription[bid][6], 200);
				MenuStore_Show(playerid, BusinessMarket, BizData[bid][bizName]);
			}
			else
			{
			    format(string, sizeof(string), "Product\tPrice\n%s\t$%s\n%s\t$%s\n%s\t$%s\n%s\t$%s\n%s\t$%s\n%s\t$%s\n%s\t$%s",
	                ProductName[bid][0],
					FormatNumber(BizData[bid][bizProduct][0]),
					ProductName[bid][1],
		            FormatNumber(BizData[bid][bizProduct][1]),
		            ProductName[bid][2],
		            FormatNumber(BizData[bid][bizProduct][2]),
		            ProductName[bid][3],
		            FormatNumber(BizData[bid][bizProduct][3]),
		        	ProductName[bid][4],
		            FormatNumber(BizData[bid][bizProduct][4]),
		            ProductName[bid][5],
		            FormatNumber(BizData[bid][bizProduct][5]),
		            ProductName[bid][6],
		            FormatNumber(BizData[bid][bizProduct][6])

				);
				ShowPlayerDialog(playerid, DIALOG_BIZBUY, DIALOG_STYLE_TABLIST_HEADERS, "Business Product", string, "Select", "Close");
			}
		}
		case 3:
		{
		    format(string, sizeof(string), "Product\tPrice\n%s\t$%s\n%s\t$%s",
                ProductName[bid][0],
		        FormatNumber(BizData[bid][bizProduct][0]),
                ProductName[bid][1],
		        FormatNumber(BizData[bid][bizProduct][1])
			);
			ShowPlayerDialog(playerid, DIALOG_BIZBUY, DIALOG_STYLE_TABLIST_HEADERS, "Business Product", string, "Select", "Close");
		}
		case 4:
		{
			if(PlayerData[playerid][pTogBuy])
			{
				MenuStore_AddItem(playerid, 1, 18867, ProductName[bid][0], BizData[bid][bizProduct][0], ProductDescription[bid][0], 200);
				MenuStore_AddItem(playerid, 2, 18875, ProductName[bid][1], BizData[bid][bizProduct][1], ProductDescription[bid][1], 200);
				MenuStore_AddItem(playerid, 3, 19942, ProductName[bid][2], BizData[bid][bizProduct][2], ProductDescription[bid][2], 200);
				MenuStore_AddItem(playerid, 4, 19792, ProductName[bid][3], BizData[bid][bizProduct][3], ProductDescription[bid][3], 200);
				MenuStore_Show(playerid, BusinessElectronic, BizData[bid][bizName]);
			}
			else
			{   
			    format(string, sizeof(string), "Product\tPrice\n%s\t$%s\n%s\t$%s\n%s\t$%s\n%s\t$%s",
	                ProductName[bid][0],
					FormatNumber(BizData[bid][bizProduct][0]),
					ProductName[bid][1],
		            FormatNumber(BizData[bid][bizProduct][1]),
		            ProductName[bid][2],
		            FormatNumber(BizData[bid][bizProduct][2]),
		            ProductName[bid][3],
		            FormatNumber(BizData[bid][bizProduct][3])
				);
				ShowPlayerDialog(playerid, DIALOG_BIZBUY, DIALOG_STYLE_TABLIST_HEADERS, "Business Product", string, "Select", "Close");
			}
		}
	}
	return 1;
}

CMD:refuel(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
	new id = Business_NearestFuel(playerid);

	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendErrorMessage(playerid, "Kamu harus mengemudikan kendaraan!");

	if(id == -1)
		return SendErrorMessage(playerid, "You aren't in range of any Fuel point!");

	if(BizData[id][bizOwner] == -1)
		return SendErrorMessage(playerid, "This business is closed.");

	if(!IsEngineVehicle(vehicleid))
		return SendErrorMessage(playerid, "This vehicle doesn't have engine!");

	if(GetEngineStatus(vehicleid))
		return SendErrorMessage(playerid, "Turn off the engine first!");

	if(VehCore[vehicleid][vehFuel] >= 100)
		return SendErrorMessage(playerid, "Your vehicle doesn't need refuel.");

	ShowPlayerDialog(playerid, DIALOG_REFUEL, DIALOG_STYLE_INPUT, "Vehicle Refuel", "Masukan jumlah fuel (per liter) :\nPrice: $1.00/1L", "Refuel", "Close");
	PlayerData[playerid][pBusiness] = id;
	return 1;
}

CMD:biz(playerid, params[])
{
	new
	    type[24],
	    string[128];

	if (sscanf(params, "s[24]S()[128]", type, string))
	{
	    SendSyntaxMessage(playerid, "/biz [name]");
	    SendClientMessage(playerid, COLOR_SERVER, "Names:{FFFFFF} buy, convertfuel, reqstock, menu, lock");
	    return 1;
	}
	if(!strcmp(type, "buy", true))
	{
	    if(Biz_GetCount(playerid) >= 1 && PlayerData[playerid][pAdmin] < 1)
	        return SendErrorMessage(playerid, "Kamu hanya bisa memiliki 1 Bisnis!");
	        
		forex(i, MAX_BUSINESS)if(BizData[i][bizExists])
		{
      		if(IsPlayerInRangeOfPoint(playerid, 3.5, BizData[i][bizExt][0], BizData[i][bizExt][1], BizData[i][bizExt][2]))
			{
			    if(BizData[i][bizOwner] != -1)
			        return SendErrorMessage(playerid, "Bisnis ini sudah dimiliki seseorang!");
			        
				if(GetMoney(playerid) < BizData[i][bizPrice])
				    return SendErrorMessage(playerid, "Kamu tidak memiliki cukup uang untuk membeli Bisnis ini!");
				    
				BizData[i][bizOwner] = PlayerData[playerid][pID];
                format(BizData[i][bizOwnerName], MAX_PLAYER_NAME, GetName(playerid));
                SendServerMessage(playerid, "Kamu berhasil membeli Business ini seharga {00FF00}$%s", FormatNumber(BizData[i][bizPrice]));
                GiveMoney(playerid, -BizData[i][bizPrice]);
                Business_Refresh(i);
                Business_Save(i);
			}
		}
	}
	else if(!strcmp(type, "convertfuel", true))
	{
		new bid = PlayerData[playerid][pInBiz];
		if(bid == -1)
			return SendErrorMessage(playerid, "You must be inside your own business!");

		if(BizData[bid][bizOwner] != PlayerData[playerid][pID])
			return SendErrorMessage(playerid, "You must be inside your own business!");

		if(BizData[bid][bizType] != 2)
			return SendErrorMessage(playerid, "The business type must be 24/7!");

		if(BizData[bid][bizStock] < 50)
			return SendErrorMessage(playerid, "Harus ada 50 stock product dalam business-mu!");

		BizData[bid][bizFuel] = 1000;
		BizData[bid][bizDiesel] = 1000;
		SendClientMessage(playerid, COLOR_SERVER, "BUSINESS: {FFFFFF}50 percent product stock converted successfully to Fuel stock!");
		Business_Refresh(bid);
		Business_Save(bid);	
	}
	else if(!strcmp(type, "reqstock", true))
	{
		new bid = PlayerData[playerid][pInBiz];
		if(bid == -1)
			return SendErrorMessage(playerid, "You must be inside your own business!");

		if(BizData[bid][bizOwner] != PlayerData[playerid][pID])
			return SendErrorMessage(playerid, "You must be inside your own business!");

		if(!BizData[bid][bizReq])
		{
			BizData[bid][bizReq] = true;
			SendClientMessage(playerid, COLOR_SERVER, "BUSINESS: {FFFFFF}You've requesting the business restock, informing to all online Trucker!");
			foreach(new i : Player) if(PlayerData[i][pSpawned] && PlayerData[i][pJob] == JOB_TRUCKER)
			{
				SendClientMessageEx(i, COLOR_SERVER, "RESTOCK: {FFFFFF}Business {FFFF00}%s {FFFFFF}is requesting product Restock for Type {00FFFF}%s", BizData[bid][bizName], GetBizType(BizData[bid][bizType]));
			}
		}
		else
		{
			BizData[bid][bizReq] = false;
			SendClientMessage(playerid, COLOR_SERVER, "BUSINESS: {FFFFFF}Your business no longer requesting Product Restock.");
			foreach(new i : Player) if(PlayerData[i][pSpawned] && PlayerData[i][pJob] == JOB_TRUCKER)
			{
				SendClientMessageEx(i, COLOR_SERVER, "RESTOCK: {FFFFFF}Business {FFFF00}%s {FFFFFF}is no longer requesting product Restock");
			}			
		}
	}
	else if(!strcmp(type, "lock", true))
	{
		new inbiz = PlayerData[playerid][pInBiz];
		new bnear = Business_Nearest(playerid, 3.5);
		if(inbiz == -1)
		{
			if(bnear != -1)
			{
				if(Biz_IsOwner(playerid, bnear))
				{
					BizData[bnear][bizLocked] = (!BizData[bnear][bizLocked]);
					ShowMessage(playerid, sprintf("You have %s ~w~your business.", (BizData[bnear][bizLocked]) ? ("~r~Locked") : ("~g~Unlocked")), 3);

				}
			}
		}
		else
		{
			if(Biz_IsOwner(playerid, inbiz))
			{
				BizData[inbiz][bizLocked] = (!BizData[inbiz][bizLocked]);
				ShowMessage(playerid, sprintf("You have %s ~w~your business.", (BizData[inbiz][bizLocked]) ? ("~r~Locked") : ("~g~Unlocked")), 3);

			}
		}
	}
	else if(!strcmp(type, "menu", true))
	{
		if(PlayerData[playerid][pInBiz] != -1 && GetPlayerInterior(playerid) == BizData[PlayerData[playerid][pInBiz]][bizInterior] && GetPlayerVirtualWorld(playerid) == BizData[PlayerData[playerid][pInBiz]][bizWorld] && Biz_IsOwner(playerid, PlayerData[playerid][pInBiz]))
		{
		    ShowPlayerDialog(playerid, DIALOG_BIZMENU, DIALOG_STYLE_LIST, "Business Menu", "Business Details\nSet Product Name\nSet Product Price\nSet Business Name\nSet Cargo Price\nWithdraw Vault\nDeposit Vault\nSet Product Description", "Select", "Close");
		}
		else
			SendErrorMessage(playerid, "Kamu tidak berada didalam bisnis milikmu!");
	}
	return 1;
}

CMD:hidebuy(playerid, params[])
{
	MenuStore_Close(playerid);
	return 1;
}
CMD:buy(playerid, params[])
{
	if(PlayerData[playerid][pInBiz] != -1 && GetPlayerInterior(playerid) == BizData[PlayerData[playerid][pInBiz]][bizInterior] && GetPlayerVirtualWorld(playerid) == BizData[PlayerData[playerid][pInBiz]][bizWorld])
	{
		if(BizData[PlayerData[playerid][pInBiz]][bizOwner] == -1)
			return SendErrorMessage(playerid, "This busines is Closed!");

	    ShowBusinessMenu(playerid);
	}
	return 1;
}

CMD:createbiz(playerid, params[])
{
    new
		type,
	    price[32],
	    id;

    if (PlayerData[playerid][pAdmin] < 7)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "ds[32]", type, price))
 	{
	 	SendSyntaxMessage(playerid, "/createbiz [type] [price]");
    	SendClientMessage(playerid, COLOR_SERVER, "Type:{FFFFFF} 1: Fast Food | 2: 24/7 | 3: Clothes | 4: Electronic");
    	return 1;
	}
	if (type < 1 || type > 4)
	    return SendErrorMessage(playerid, "Invalid type specified. Types range from 1 to 7.");

	id = Business_Create(playerid, type, strcash(price));

	if (id == -1)
	    return SendErrorMessage(playerid, "The server has reached the limit for businesses.");

	SendServerMessage(playerid, "You have successfully created business ID: %d.", id);
	return 1;
}

CMD:editbiz(playerid, params[])
{
    new
        id,
        type[24],
        string[256];

    if(PlayerData[playerid][pAdmin] < 6)
        return SendErrorMessage(playerid, "You don't have permission to use this command!");

    if(sscanf(params, "ds[24]S()[128]", id, type, string))
    {
        SendSyntaxMessage(playerid, "/editbiz [id] [name]");
        SendClientMessage(playerid, COLOR_SERVER, "Names:{FFFFFF} location, interior, fuelpoint, fuelstock, price, stock, deliver, delete, asell");
        return 1;
    }
    if((id < 0 || id >= MAX_BUSINESS))
        return SendErrorMessage(playerid, "You have specified an invalid ID.");

	if(!BizData[id][bizExists])
        return SendErrorMessage(playerid, "You have specified an invalid ID.");

    if(!strcmp(type, "location", true))
    {
		GetPlayerPos(playerid, BizData[id][bizExt][0], BizData[id][bizExt][1], BizData[id][bizExt][2]);
		Business_Save(id);
		Business_Refresh(id);

		SendClientMessageEx(playerid, COLOR_LIGHTRED, "AdmBiz: {FFFFFF}Kamu telah mengubah posisi Business ID: %d", id);
    }
    else if(!strcmp(type, "interior", true))
    {
    	BizData[id][bizInterior] = GetPlayerInterior(playerid);

		GetPlayerPos(playerid, BizData[id][bizInt][0], BizData[id][bizInt][1], BizData[id][bizInt][2]);
		Business_Save(id);
		Business_Refresh(id);

		SendClientMessageEx(playerid, COLOR_LIGHTRED, "AdmBiz: {FFFFFF}Kamu telah mengubah posisi Business ID: %d", id);
    }
    else if(!strcmp(type, "fuelpoint", true))
    {
    	if(BizData[id][bizType] != 2)
    		return SendErrorMessage(playerid, "Fuelpoint hanya bisa dengan Business type 24/7!");

		if(BizData[id][bizFuelPos][0] == 0 && BizData[id][bizFuelPos][1] == 0 && BizData[id][bizFuelPos][2] == 0)
		{
			BizData[id][bizFuelText] = CreateDynamic3DTextLabel(sprintf("Gasoline: %d Liter\nDiesel: %d Liter\nType /refuel to refuel", BizData[id][bizFuel], BizData[id][bizDiesel]), COLOR_SERVER, BizData[id][bizFuelPos][0], BizData[id][bizFuelPos][1], BizData[id][bizFuelPos][2], 15.0);
			BizData[id][bizFuelPickup] = CreateDynamicPickup(1650, 23, BizData[id][bizFuelPos][0], BizData[id][bizFuelPos][1], BizData[id][bizFuelPos][2], -1, -1);
		}

    	GetPlayerPos(playerid, BizData[id][bizFuelPos][0], BizData[id][bizFuelPos][1], BizData[id][bizFuelPos][2]);
    	Business_Save(id);
    	Business_Refresh(id);

    	SendClientMessageEx(playerid, COLOR_LIGHTRED, "AdmBiz: {FFFFFF}Kamu telah mengubah posisi Fuel Point Business ID: %d", id);  
    }
    else if(!strcmp(type, "deliver", true))
    {
		if(BizData[id][bizDeliver][0] == 0 && BizData[id][bizDeliver][1] == 0 && BizData[id][bizDeliver][2] == 0)
		{
			BizData[id][bizDeliverPickup] = CreateDynamicPickup(1239, 23, BizData[id][bizDeliver][0], BizData[id][bizDeliver][1], BizData[id][bizDeliver][2], -1, -1);
			BizData[id][bizDeliverText] = CreateDynamic3DTextLabel(sprintf("%s\nDelivery Point", BizData[id][bizName]), COLOR_SERVER, BizData[id][bizDeliver][0], BizData[id][bizDeliver][1], BizData[id][bizDeliver][2], 15.0);
		}
 		GetPlayerPos(playerid, BizData[id][bizDeliver][0], BizData[id][bizDeliver][1], BizData[id][bizDeliver][2]);
		Business_Save(id);
		Business_Refresh(id);

		SendClientMessageEx(playerid, COLOR_LIGHTRED, "AdmBiz: {FFFFFF}Kamu telah mengubah posisi Deliver Point Business ID: %d", id);   	
    }
    else if(!strcmp(type, "price", true))
    {
    	new amount[32];

    	if(sscanf(string, "s[32]", amount))
    		return SendSyntaxMessage(playerid, "/editbiz [id] [price] [new price]");

    	BizData[id][bizPrice] = strcash(amount);
    	SendAdminMessage(COLOR_LIGHTRED, "AdmBiz: %s has set Business ID %d price to $%s", PlayerData[playerid][pUCP], id, FormatNumber(strcash(amount)));
    	Business_Save(id);
    	Business_Refresh(id);
    }
    else if(!strcmp(type, "stock", true))
    {
    	new amount;

    	if(sscanf(string, "d", amount))
    		return SendSyntaxMessage(playerid, "/editbiz [id] [stock] [amount]");

    	BizData[id][bizStock] = amount;
    	SendAdminMessage(COLOR_LIGHTRED, "AdmBiz: %s has set Business ID %d stock to %d", PlayerData[playerid][pUCP], id, amount);
    	Business_Save(id);
    }
    else if(!strcmp(type, "delete", true))
    {
    	Business_Delete(id);
    	SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has deleted Business ID: %d", PlayerData[playerid][pUCP], id);
    }
    else if(!strcmp(type, "asell", true))
    {
    	BizData[id][bizOwner] = -1;
    	Business_Refresh(id);
    	Business_Save(id);
    	SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: Business %d has aselled by %s", id, PlayerData[playerid][pUCP]);
    }
    return 1;
}

