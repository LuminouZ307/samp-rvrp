enum dealer_data
{
	dealerID,
	bool:dealerExists,
	dealerOwner,
	dealerName[24],
	Float:dealerPos[3],
	Float:dealerSpawn[4],
	STREAMER_TAG_3D_TEXT_LABEL:dealerLabel,
	STREAMER_TAG_PICKUP:dealerPickup,
	dealerVehicle[6],
	dealerStock[6],
	dealerPrice,
	dealerCost[6],
	dealerVault,
	STREAMER_TAG_MAP_ICON:dealerIcon,
};
new DealerData[MAX_DEALER][dealer_data];

stock FormatStock(id, slot)
{
	new str[32];
	if(DealerData[id][dealerVehicle][slot] == 19300)
	{
		str = "";
	}
	else
	{
		format(str, sizeof(str), "Stock_%d", DealerData[id][dealerStock][slot]);
	}
	return str;
}
stock ReturnRestockPrice(price)
{
	new str[56];
	format(str, sizeof(str), "$0.00");
	if(price > 0)
	{
		format(str, sizeof(str), "$%s", FormatNumber(floatround(price * 50 / 100)));
	}
	return str;
}
stock ReturnDealerVehicle(model)
{
	new str[32];
	if(model == 19300)
	{
		str = "NoVehicle";
	}
	else
	{
		format(str, sizeof(str), "%s", ReturnVehicleModelName(model));
	}
	return str;
}

stock Dealer_IsOwner(playerid, id)
{
	if(DealerData[id][dealerOwner] == PlayerData[playerid][pID])
		return true;

	return false;
}
stock Dealer_Nearest(playerid, Float:range = 4.0)
{
	forex(i, MAX_DEALER) if(DealerData[i][dealerExists])
	{
		if(IsPlayerInRangeOfPoint(playerid, range, DealerData[i][dealerPos][0], DealerData[i][dealerPos][1], DealerData[i][dealerPos][2]))
		{
			return i;
		}
	}
	return -1;
}

stock Dealer_Create(playerid, price)
{
	new Float:x, Float:y, Float:z;
	if(GetPlayerPos(playerid, x, y, z))
	{
		forex(i, MAX_DEALER)
		{
			if(!DealerData[i][dealerExists])
			{
				DealerData[i][dealerExists] = true;
				DealerData[i][dealerOwner] = -1;
				DealerData[i][dealerPrice] = price;
				DealerData[i][dealerVault] = 0;
				format(DealerData[i][dealerName], 24, "Undefined");
				forex(q, 6)
				{
					DealerData[i][dealerVehicle][q] = 19300;
					DealerData[i][dealerCost][q] = 0;
					DealerData[i][dealerStock][q] = 2;
				}
				DealerData[i][dealerPos][0] = x;
				DealerData[i][dealerPos][1] = y;
				DealerData[i][dealerPos][2] = z;
				DealerData[i][dealerSpawn][0] = 0.0;
				DealerData[i][dealerSpawn][1] = 0.0;
				DealerData[i][dealerSpawn][2] = 0.0;
				DealerData[i][dealerSpawn][3] = 0.0;
				Dealer_Spawn(i);
				mysql_tquery(sqlcon, "INSERT INTO `dealer` (`Price`) VALUES(0)", "OnDealerCreated", "d", i);
				return i;
			}
		}
	}
	return -1;
}

FUNC::OnDealerCreated(id)
{
	DealerData[id][dealerID] = cache_insert_id();
	Dealer_Save(id);
}

stock Dealer_Delete(id)
{
	if(!DealerData[id][dealerExists])
		return 0;

	if(IsValidDynamic3DTextLabel(DealerData[id][dealerLabel]))
		DestroyDynamic3DTextLabel(DealerData[id][dealerLabel]);

	if(IsValidDynamicPickup(DealerData[id][dealerPickup]))
		DestroyDynamicPickup(DealerData[id][dealerPickup]);

	new str[64];
	mysql_format(sqlcon, str, sizeof(str), "DELETE FROM `dealer` WHERE `ID` = '%d'", DealerData[id][dealerID]);
	mysql_tquery(sqlcon, str);

	DealerData[id][dealerID] = 0;
	DealerData[id][dealerOwner] = -1;
	DealerData[id][dealerExists] = false;
	return 1;
}

stock Dealer_Refresh(id)
{
	if(id != -1 && DealerData[id][dealerExists])
	{

		new str[175];
		if(DealerData[id][dealerOwner] == -1)
		{
			format(str, sizeof(str), "[ID %d]\nPrice: {00FF00}$%s\n{FFFFFF}This dealership is for sell\nType {FFFF00}/dealer buy {FFFFFF}to purchase", id, FormatNumber(DealerData[id][dealerPrice]));
		}
		else
		{
			format(str, sizeof(str), "[ID %d]\nName: {FFFF00}%s\n{FFFFFF}Type {FFFF00}/dealer buyvehicle {FFFFFF}to buy vehicle", id, DealerData[id][dealerName]);
		}
		UpdateDynamic3DTextLabelText(DealerData[id][dealerLabel], COLOR_SERVER, str);

		Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, DealerData[id][dealerLabel], E_STREAMER_X, DealerData[id][dealerPos][0]);
		Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, DealerData[id][dealerLabel], E_STREAMER_Y, DealerData[id][dealerPos][1]);
		Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, DealerData[id][dealerLabel], E_STREAMER_Z, DealerData[id][dealerPos][2]);

		Streamer_SetFloatData(STREAMER_TYPE_PICKUP, DealerData[id][dealerPickup], E_STREAMER_X, DealerData[id][dealerPos][0]);
		Streamer_SetFloatData(STREAMER_TYPE_PICKUP, DealerData[id][dealerPickup], E_STREAMER_Y, DealerData[id][dealerPos][1]);
		Streamer_SetFloatData(STREAMER_TYPE_PICKUP, DealerData[id][dealerPickup], E_STREAMER_Z, DealerData[id][dealerPos][2]);
	}
	return 1;
}

FUNC::Dealer_Load()
{
	new rows = cache_num_rows();
	if(rows)
	{
	    forex(i, rows)
	    {
	    	DealerData[i][dealerExists] = true;
	    	cache_get_value_name_int(i, "ID", DealerData[i][dealerID]);
	    	cache_get_value_name(i, "Name", DealerData[i][dealerName]);
	    	cache_get_value_name_int(i, "Price", DealerData[i][dealerPrice]);
	    	cache_get_value_name_int(i, "Owner", DealerData[i][dealerOwner]);
	    	cache_get_value_name_float(i, "PosX", DealerData[i][dealerPos][0]);
	    	cache_get_value_name_float(i, "PosY", DealerData[i][dealerPos][1]);
	    	cache_get_value_name_float(i, "PosZ", DealerData[i][dealerPos][2]);
	    	cache_get_value_name_float(i, "SpawnX", DealerData[i][dealerSpawn][0]);
	    	cache_get_value_name_float(i, "SpawnY", DealerData[i][dealerSpawn][1]);
	    	cache_get_value_name_float(i, "SpawnZ", DealerData[i][dealerSpawn][2]);
	    	cache_get_value_name_float(i, "SpawnA", DealerData[i][dealerSpawn][3]);
	    	cache_get_value_name_int(i, "Vault", DealerData[i][dealerVault]);

			forex(z, 6)
			{
			    new zquery[256];
			    format(zquery, sizeof(zquery), "Cost%d", z + 1);
			    cache_get_value_name_int(i,zquery,DealerData[i][dealerCost][z]);

			    format(zquery, sizeof(zquery), "Vehicle%d", z + 1);
			    cache_get_value_name_int(i,zquery,DealerData[i][dealerVehicle][z]);

			    format(zquery, sizeof(zquery), "Stock%d", z + 1);
			    cache_get_value_name_int(i, zquery, DealerData[i][dealerStock][z]);
			}
			Dealer_Spawn(i);
		}
		printf("[DEALER] Loaded %d dealership from database", rows);
	}
	return 1;
}

stock Dealer_Spawn(i)
{
	new str[175];
	if(DealerData[i][dealerOwner] == -1)
	{
		format(str, sizeof(str), "[ID %d]\nPrice: {00FF00}$%s\n{FFFFFF}This dealership is for sell\nType {FFFF00}/dealer buy {FFFFFF}to purchase", i, FormatNumber(DealerData[i][dealerPrice]));
	}
	else
	{
		format(str, sizeof(str), "[ID %d]\nName: {FFFF00}%s\n{FFFFFF}Type {FFFF00}/dealer buyvehicle {FFFFFF}to buy vehicle", i, DealerData[i][dealerName]);
	}
	DealerData[i][dealerLabel] = CreateDynamic3DTextLabel(str, -1, DealerData[i][dealerPos][0], DealerData[i][dealerPos][1], DealerData[i][dealerPos][2], 15.0);
	DealerData[i][dealerPickup] = CreateDynamicPickup(19134, 23,  DealerData[i][dealerPos][0], DealerData[i][dealerPos][1], DealerData[i][dealerPos][2]);
	return 1;
}
stock Dealer_Save(id)
{
	new query[1052];
	mysql_format(sqlcon, query, sizeof(query), "UPDATE `dealer` SET ");
	mysql_format(sqlcon, query, sizeof(query), "%s`Name`='%s', ", query, DealerData[id][dealerName]);
	mysql_format(sqlcon, query, sizeof(query), "%s`Owner`='%d', ", query, DealerData[id][dealerOwner]);
	mysql_format(sqlcon, query, sizeof(query), "%s`Stock`='%d', ", query, DealerData[id][dealerStock]);
	mysql_format(sqlcon, query, sizeof(query), "%s`Vault`='%d', ", query, DealerData[id][dealerVault]);
	mysql_format(sqlcon, query, sizeof(query), "%s`PosX`='%f', ", query, DealerData[id][dealerPos][0]);
	mysql_format(sqlcon, query, sizeof(query), "%s`PosY`='%f', ", query, DealerData[id][dealerPos][1]);
	mysql_format(sqlcon, query, sizeof(query), "%s`PosZ`='%f', ", query, DealerData[id][dealerPos][2]);
	mysql_format(sqlcon, query, sizeof(query), "%s`SpawnX`='%f', ", query, DealerData[id][dealerSpawn][0]);
	mysql_format(sqlcon, query, sizeof(query), "%s`SpawnY`='%f', ", query, DealerData[id][dealerSpawn][1]);
	mysql_format(sqlcon, query, sizeof(query), "%s`SpawnZ`='%f', ", query, DealerData[id][dealerSpawn][2]);
	mysql_format(sqlcon, query, sizeof(query), "%s`SpawnA`='%f', ", query, DealerData[id][dealerSpawn][3]);
	forex(i, 6)
	{
		mysql_format(sqlcon, query, sizeof(query), "%s`Vehicle%d` = '%d', `Cost%d` = '%d', `Stock%d` = '%d', ", query, i + 1, DealerData[id][dealerVehicle][i], i + 1, DealerData[id][dealerCost][i], i + 1, DealerData[id][dealerStock][i]);
	}
	mysql_format(sqlcon, query, sizeof(query), "%s`Price`='%d' ", query, DealerData[id][dealerPrice]);
	mysql_format(sqlcon, query, sizeof(query), "%sWHERE `ID` = '%d'", query, DealerData[id][dealerID]);
	mysql_query(sqlcon, query, true);
	return 1;
}

CMD:dealer(playerid, params[])
{
	new id = Dealer_Nearest(playerid);

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/dealer [Name]"), SendClientMessage(playerid, COLOR_SERVER, "Names: {FFFFFF}buyvehicle, buy, menu");

	if(!strcmp(params, "buy", true))
	{
		if(id == -1)
			return SendErrorMessage(playerid, "You aren't in range of any dealerships!");

		if(DealerData[id][dealerOwner] != -1)
			return SendErrorMessage(playerid, "This dealership is already owned!");

		if(GetMoney(playerid) < DealerData[id][dealerPrice])
			return SendErrorMessage(playerid, "You don't have enough money!");

		GiveMoney(playerid, -DealerData[id][dealerPrice]);
		DealerData[id][dealerOwner] = PlayerData[playerid][pID];
		SendClientMessageEx(playerid, COLOR_SERVER, "PROPERTY: {FFFFFF}Kamu berhasil membeli Dealership ID %d seharga {00FF00}$%s", id, FormatNumber(DealerData[id][dealerPrice]));
		Dealer_Refresh(id);
		Dealer_Save(id);
	}
	else if(!strcmp(params, "buyvehicle", true))
	{
		if(id == -1)
			return SendErrorMessage(playerid, "You aren't in range of any dealerships!");

    	new str[512];
    	format(str, sizeof(str), "");
    	forex(i, 6)
    	{
    		format(str, sizeof(str), "%s%i\t~g~$%s~n~~w~%s~n~~n~~n~~n~~n~%s\n", str, DealerData[id][dealerVehicle][i], FormatNumber(DealerData[id][dealerCost][i]), ReturnDealerVehicle(DealerData[id][dealerVehicle][i]), FormatStock(id, i));
    	}
    	ShowPlayerDialog(playerid, DIALOG_DEALER_BUY, DIALOG_STYLE_PREVIEW_MODEL,"Purchase Vehicle", str, "Purchase", "Close");
    	PlayerData[playerid][pSelecting] = id;
	}
	else if(!strcmp(params, "menu", true))
	{
		if(id == -1)
			return SendErrorMessage(playerid, "You aren't in range of any dealerships!");

		if(!Dealer_IsOwner(playerid, id))
			return SendErrorMessage(playerid, "Kamu bukan pemilik dealership ini!");

		new str[156];
		format(str, sizeof(str), "Set dealer name\nRestock Vehicle\nWithdraw all vault ({00FF00}$%s{FFFFFF})", FormatNumber(DealerData[id][dealerVault]));
		ShowPlayerDialog(playerid, DIALOG_DEALER_MENU, DIALOG_STYLE_LIST, "Dealer Menu", str, "Select", "Close");
		PlayerData[playerid][pSelecting] = id;
	}
	return 1;
}

CMD:editdealer(playerid, params[])
{
	new id, type[24], string[128];
    if(PlayerData[playerid][pAdmin] < 6)
        return SendErrorMessage(playerid, "You don't have permission to use this command!");

    if(sscanf(params, "ds[24]S()[128]", id, type, string))
    {
        SendSyntaxMessage(playerid, "/editdealer [id] [name]");
        SendClientMessage(playerid, COLOR_SERVER, "Names:{FFFFFF} location, vehicle, asell, spawn");
        return 1;
    }	
    if((id < 0 || id >= MAX_DEALER))
        return SendErrorMessage(playerid, "You have specified an invalid ID.");

	if(!DealerData[id][dealerExists])
        return SendErrorMessage(playerid, "You have specified an invalid ID.");  

    if(!strcmp(type, "location", true))
    {
    	GetPlayerPos(playerid, DealerData[id][dealerPos][0], DealerData[id][dealerPos][1], DealerData[id][dealerPos][2]);
    	Dealer_Save(id);
    	Dealer_Refresh(id);

    	SendClientMessageEx(playerid,COLOR_SERVER, "AdmCmd: {FFFFFF}Kamu telah mengubah posisi Dealership ID %d", id);
    }
    else if(!strcmp(type, "spawn", true))
    {
    	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
    		return SendErrorMessage(playerid, "Kamu harus berada didalam kendaraan!");

    	new vid = GetPlayerVehicleID(playerid);
    	GetVehiclePos(vid, DealerData[id][dealerSpawn][0], DealerData[id][dealerSpawn][1], DealerData[id][dealerSpawn][2]);
    	GetVehicleZAngle(vid, DealerData[id][dealerSpawn][3]);

    	Dealer_Save(id);

    	SendClientMessageEx(playerid, COLOR_SERVER, "AdmCmd: {FFFFFF}Kamu telah mengubah posisi spawn Dealership ID %d", id);
    }
    else if(!strcmp(type, "vehicle", true))
    {
    	new str[256];
    	format(str, sizeof(str), "");
    	forex(i, 6)
    	{
    		format(str, sizeof(str), "%s%i\t~g~$%s~n~~w~%s\n", str, DealerData[id][dealerVehicle][i], FormatNumber(DealerData[id][dealerCost][i]), ReturnDealerVehicle(DealerData[id][dealerVehicle][i]));
    	}
    	ShowPlayerDialog(playerid, DIALOG_EDITDEALER_SELECT, DIALOG_STYLE_PREVIEW_MODEL, "Edit Vehicle", str, "Select", "Close");
    	PlayerData[playerid][pSelecting] = id;
    }
    else if(!strcmp(type, "asell", true))
    {
    	DealerData[id][dealerOwner] = -1;
    	Dealer_Save(id);
    	Dealer_Refresh(id);
    	SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: Dealership %d has been aselled by %s", id, PlayerData[playerid][pUCP]);
    }
    return 1; 
}

CMD:createdealer(playerid, params[])
{
	new price[32];
    if (PlayerData[playerid][pAdmin] < 7)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if(sscanf(params, "s[32]", price))
		return SendSyntaxMessage(playerid, "/createdealer [price]");

	new id = Dealer_Create(playerid, strcash(price));
	if(id == -1)
		return SendErrorMessage(playerid, "The server has reached the limit for dealerships.");

	SendServerMessage(playerid, "You have successfully created Dealership ID: %d.", id);
	return 1;
}

CMD:destroydealer(playerid, params[])
{
	static
	    id = 0;

    if (PlayerData[playerid][pAdmin] < 7)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "d", id))
	    return SendSyntaxMessage(playerid, "/destroydealer [dealer id]");

	if ((id < 0 || id >= MAX_DEALER) || !DealerData[id][dealerExists])
	    return SendErrorMessage(playerid, "You have specified an invalid Delership ID.");

	Dealer_Delete(id);
	SendServerMessage(playerid, "You have successfully destroyed Dealership ID: %d.", id);
	return 1;
}

