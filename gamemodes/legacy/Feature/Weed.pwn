enum e_weed
{
	weedID,
	bool:weedExists,
	bool:weedHarvested,
	Float:weedPos[3],
	weedGrow,
	STREAMER_TAG_OBJECT:weedObject,
	STREAMER_TAG_AREA:weedArea,
};
new WeedData[MAX_WEED][e_weed];

stock IsAtDrugField(playerid)
{
	if(IsPlayerInDynamicArea(playerid, AreaData[areaDrug][0]))
		return 1;

	if(IsPlayerInDynamicArea(playerid, AreaData[areaDrug][1]))
		return 1;

	return 0;
}

stock Weed_Delete(id)
{
	if(!WeedData[id][weedExists])
		return 0;

	new str[158];
	mysql_format(sqlcon, str, sizeof(str), "DELETE FROM `weed` WHERE `ID` = '%d'", WeedData[id][weedID]);
	mysql_tquery(sqlcon, str);

	if (IsValidDynamicObject(WeedData[id][weedObject]))
	    DestroyDynamicObject(WeedData[id][weedObject]);

	if(IsValidDynamicCP(WeedData[id][weedArea]))
		DestroyDynamicCP(WeedData[id][weedArea]);

	WeedData[id][weedExists] = false;
	WeedData[id][weedID] = 0;
	return 1;
}
FUNC::HarvestWeed(playerid, wid)
{
	if(!WeedData[wid][weedExists])
		return 0;

	ClearAnimations(playerid, 1);
	Weed_Delete(wid);
	Inventory_Add(playerid, "Weed", 1578, 1);
	SendClientMessage(playerid, COLOR_SERVER, "DRUGS: {FFFFFF}Item added to inventory: {FFFF00}Weed +1");
	return 1;
}
stock Weed_Nearest(playerid)
{
	forex(i, MAX_WEED) if(WeedData[i][weedExists])
	{
		if(IsPlayerInDynamicArea(playerid, WeedData[i][weedArea]))
		{
			return i;
		}
	}
	return -1;
}

stock Weed_Count()
{
	new count = 0;
	forex(i, MAX_WEED) if(WeedData[i][weedExists])
	{
		count++;
	}
	return count;
}


FUNC::Combined(playerid)
{
	ClearAnimations(playerid, 1);
	SendClientMessage(playerid, COLOR_SERVER, "DRUGS: {FFFFFF}Item added to inventory: {FFFF00}Rolled Weed +1");
	Inventory_Add(playerid, "Rolled Weed", 3027, 1);
	return 1;
}

FUNC::PlantWeed(playerid)
{
	if(Weed_Count() >= MAX_WEED)
		return SendErrorMessage(playerid, "The server cannot create more Weeds!");

	ClearAnimations(playerid, 1);
	Weed_Create(playerid);
	ShowMessage(playerid, "Weed ~r~planted ~w~successfully.", 3);
	return 1;
}

stock Weed_Create(playerid)
{
	new Float:x, Float:y, Float:z;
	if(GetPlayerPos(playerid, x, y, z))
	{
		forex(i, MAX_WEED) if(!WeedData[i][weedExists])
		{ 
			WeedData[i][weedExists] = true;
			WeedData[i][weedPos][0] = x;
			WeedData[i][weedPos][1] = y;
			WeedData[i][weedPos][2] = z;
			WeedData[i][weedGrow] = 0;
			WeedData[i][weedHarvested] = false;

			Weed_Refresh(i);
			mysql_tquery(sqlcon, "INSERT INTO `weed` (`Grow`) VALUES(0)", "OnWeedCreated", "d", i);
			return i;
		}
	}
	return -1;
}

FUNC::OnWeedCreated(id)
{
	WeedData[id][weedID] = cache_insert_id();
	Weed_Save(id);
}
stock Weed_Refresh(plantid)
{
	if (plantid != -1 && WeedData[plantid][weedExists])
	{

		if (IsValidDynamicObject(WeedData[plantid][weedObject]))
		    DestroyDynamicObject(WeedData[plantid][weedObject]);

		if(IsValidDynamicCP(WeedData[plantid][weedArea]))
			DestroyDynamicCP(WeedData[plantid][weedArea]);
			
		WeedData[plantid][weedObject] = CreateDynamicObject(19473, WeedData[plantid][weedPos][0], WeedData[plantid][weedPos][1], WeedData[plantid][weedPos][2] - 1.80, 0.0, 0.0, 0.0, -1, -1);
        WeedData[plantid][weedArea] = CreateDynamicSphere( WeedData[plantid][weedPos][0], WeedData[plantid][weedPos][1], WeedData[plantid][weedPos][2],1.5);
	}
	return 1;
}


FUNC::Weed_Load()
{
	new rows = cache_num_rows();
	if(rows)
	{
		forex(i, rows)
		{
			WeedData[i][weedExists] = true;
			cache_get_value_name_int(i, "ID", WeedData[i][weedID]);
			cache_get_value_name_float(i, "PosX", WeedData[i][weedPos][0]);
			cache_get_value_name_float(i, "PosY", WeedData[i][weedPos][1]);
			cache_get_value_name_float(i, "PosZ", WeedData[i][weedPos][2]);
			cache_get_value_name_int(i, "Grow", WeedData[i][weedGrow]);
			Weed_Refresh(i);

		}
		printf("[WEED] Loaded %d Weed from database", rows);
	}
	return 1;
}

stock Weed_Save(id)
{
	new query[572];
	mysql_format(sqlcon, query, sizeof(query), "UPDATE `weed` SET ");
	mysql_format(sqlcon, query, sizeof(query), "%s`PosX`='%f', ", query, WeedData[id][weedPos][0]);
	mysql_format(sqlcon, query, sizeof(query), "%s`PosY`='%f', ", query, WeedData[id][weedPos][1]);
	mysql_format(sqlcon, query, sizeof(query), "%s`PosZ`='%f', ", query, WeedData[id][weedPos][2]);
	mysql_format(sqlcon, query, sizeof(query), "%s`Grow`='%d' ", query, WeedData[id][weedGrow]);
	mysql_format(sqlcon, query, sizeof(query), "%sWHERE `ID` = '%d'", query, WeedData[id][weedID]);
	mysql_query(sqlcon, query, true);
	return 1;
}

CMD:buyweed(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, 2700.1428,-1108.3136,69.5781))
		return SendErrorMessage(playerid, "You're not at Drug Dealer point!");

	if(PlayerData[playerid][pLevel] < 3)
		return SendErrorMessage(playerid, "Minimal level 3 untuk melakukan ini!");

	new amount;
	if(sscanf(params, "d", amount))
		return SendSyntaxMessage(playerid, "/buyweed [amount]"), SendClientMessage(playerid, COLOR_YELLOW, "INFO: {FFFFFF}The weed price is $5.00 / 1 weed seeds.");

	if(amount < 1 || amount < -1)
		return SendErrorMessage(playerid, "Invalid seeds amount!");

	if(GetMoney(playerid) < amount*500)
		return SendErrorMessage(playerid, "You don't have enough money!");

	if(amount*500 < 1)
		return SendErrorMessage(playerid, "Invalid seeds amount!");
				
	Inventory_Add(playerid, "Weed Seed", 1279, amount);
	SendClientMessageEx(playerid, COLOR_SERVER, "DRUGS: {FFFFFF}Kamu berhasil membeli {FF0000}%d Weed seeds {FFFFFF}seharga {00FF00}$%s", amount, FormatNumber(amount*500));
	GiveMoney(playerid, -amount*500);
	return 1;

}

