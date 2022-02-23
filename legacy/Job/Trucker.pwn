stock IsTruckerCar(vehicleid)
{
	new modelid = GetVehicleModel(vehicleid);

	if (GetVehicleTrailer(vehicleid))
	    modelid = GetVehicleModel(GetVehicleTrailer(vehicleid));

	switch (modelid)
	{
	    case 456, 499: return 1;
	}
	return 0;
}

CMD:cargo(playerid, params[])
{
	if(PlayerData[playerid][pJob] != JOB_TRUCKER)
		return SendErrorMessage(playerid, "Kamu bukan seorang Trucker!");

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/cargo [Type]"), SendClientMessage(playerid, COLOR_SERVER, "Type: {FFFFFF}list, place, buy, sell, remove");

	if(!strcmp(params, "list", true))
	{
		new pvid = Vehicle_Nearest(playerid, 5.0);
		if(pvid == -1)
			return SendErrorMessage(playerid, "Kamu tidak berada dibelakang Truck manapun!");

		if(!IsTruckerCar(VehicleData[pvid][vVehicle]))
			return SendErrorMessage(playerid, "Kamu tidak berada dibelakang Truck manapun!");
		
		if(!IsPlayerNearBoot(playerid, VehicleData[pvid][vVehicle]))
			return SendErrorMessage(playerid, "Kamu tidak berada dibelakang Truck manapun!");

		new str[312], bool:found = false;
		forex(i, MAX_CRATES) 
		{
			if(CrateData[i][crateExists] && CrateData[i][crateVehicle] == VehicleData[pvid][vID])
			{

				format(str, sizeof(str), "%s%s Cargo\n", str, Crate_Name[CrateData[i][crateType]]);
				found = true;
			}
		}
		if(found)
			ShowPlayerDialog(playerid, DIALOG_CRATE, DIALOG_STYLE_LIST, "Crate List", str, "Take", "Close");
		else
			SendErrorMessage(playerid, "Tidak ada Cargo pada Truck ini!");

		PlayerData[playerid][pVehicle] = pvid;
	}
	else if(!strcmp(params, "sell", true))
	{
		new id = Business_NearestDeliver(playerid);
		if(id == -1)
			return SendErrorMessage(playerid, "Kamu tidak berada di Delivery Point manapun!");

		if(PlayerData[playerid][pCrate] == -1)
			return SendErrorMessage(playerid, "Kamu tidak sedang mengangkat Cargo!");

		if(CrateData[PlayerData[playerid][pCrate]][crateType] != BizData[id][bizType])
			return SendErrorMessage(playerid, "Tipe Cargo tidak sesuai dengan Tipe business!");

		if(BizData[id][bizStock] >= 100)
			return SendErrorMessage(playerid, "Stock pada business ini sudah penuh!");

		if(!BizData[id][bizReq])
			return SendErrorMessage(playerid, "This business is not requesting Product Restock!");

		new str[256];
		format(str, sizeof(str), "{FFFFFF}Business: %s\n{FFFFFF}Type: %s\nCargo Price: {00FF00}$%s\n\n{FFFFFF}Tekan {FFFF00}Confirm {FFFFFF}untuk menjual Cargo.", BizData[id][bizName], GetBizType(BizData[id][bizType]), FormatNumber(BizData[id][bizCargo]));
		ShowPlayerDialog(playerid, DIALOG_SELLCARGO, DIALOG_STYLE_MSGBOX, "Sell Cargo", str, "Confirm", "Close");
		PlayerData[playerid][pBusiness] = id;
	}
	else if(!strcmp(params, "place", true))
	{
		new pvid = Vehicle_Nearest(playerid, 5.0);

		if(PlayerData[playerid][pCrate] == -1)
			return SendErrorMessage(playerid, "Kamu tidak sedang tidak mengangkat Cargo!");

		if(pvid == -1)
			return SendErrorMessage(playerid, "Kamu tidak berada dibelakang Truck manapun!");

		if(!IsTruckerCar(VehicleData[pvid][vVehicle]))
			return SendErrorMessage(playerid, "Kamu tidak berada dibelakang Truck manapun!");

		if(!IsPlayerNearBoot(playerid, VehicleData[pvid][vVehicle]))
			return SendErrorMessage(playerid, "Kamu tidak berada dibelakang Truck manapun!");

		if(Crate_Count(pvid) >= 5)
			return SendErrorMessage(playerid, "Truck ini tidak bisa menampung lebih banyak Cargo!");

		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);		
		ApplyAnimation(playerid, "CARRY", "putdwn", 4.1, 0, 0, 0, 0, 0, 1);
		RemovePlayerAttachedObject(playerid, 9);
		SendClientMessageEx(playerid, COLOR_SERVER, "CARGO: {FFFFFF}Kamu menyimpan {FFFF00}%s Cargo {FFFFFF}kedalam %s!", Crate_Name[CrateData[PlayerData[playerid][pCrate]][crateType]], GetVehicleName(VehicleData[pvid][vVehicle]));
		CrateData[PlayerData[playerid][pCrate]][crateVehicle] = VehicleData[pvid][vID];
		Crate_Save(PlayerData[playerid][pCrate]);
		PlayerData[playerid][pCrate] = -1;
	}
	else if(!strcmp(params, "remove", true))
	{
		if(PlayerData[playerid][pCrate] == -1)
			return SendErrorMessage(playerid, "Kamu tidak sedang tidak mengangkat Cargo!");

		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);		
		ApplyAnimation(playerid, "CARRY", "putdwn", 4.1, 0, 0, 0, 0, 0, 1);
		RemovePlayerAttachedObject(playerid, 9);
		Crate_Delete(PlayerData[playerid][pCrate]);
		SendClientMessage(playerid, COLOR_SERVER, "CARGO: {FFFFFF}You've successfully removed the Cargo.");		
	}
	else if(!strcmp(params, "buy", true))
	{
		if(PlayerData[playerid][pCrate] != -1)
			return SendErrorMessage(playerid, "Kamu sedang mengangkat Cargo!");

		if(IsPlayerInRangeOfPoint(playerid, 3.0, 2615.1174,-2382.3147,13.6250))
		{
			if(GetMoney(playerid) < 5000)
				return SendErrorMessage(playerid, "Kamu tidak memiliki cukup uang.");

			new id = Crate_Create(playerid, TYPE_ELECTRO);
			if(id == -1)
				return SendErrorMessage(playerid, "The server cannot create more cargo's!");

			GiveMoney(playerid, -5000);
			SendClientMessage(playerid, COLOR_SERVER, "CARGO: {FFFFFF}Kamu berhasil membeli Electronic Cargo seharga {00FF00}$50.0");
		}
		else if(IsPlayerInRangeOfPoint(playerid, 3.0, 2255.7563,-2387.6526,17.4219))
		{
			if(GetMoney(playerid) < 5000)
				return SendErrorMessage(playerid, "Kamu tidak memiliki cukup uang.");

			new id = Crate_Create(playerid, TYPE_CLOTHES);
			
			if(id == -1)
				return SendErrorMessage(playerid, "The server cannot create more cargo's!");

			GiveMoney(playerid, -5000);
			SendClientMessage(playerid, COLOR_SERVER, "CARGO: {FFFFFF}Kamu berhasil membeli Clothes Cargo seharga {00FF00}$50.0");			
		}		
		else if(IsPlayerInRangeOfPoint(playerid, 3.0, 2445.5408,-2548.0427,17.9107))
		{
			if(GetMoney(playerid) < 7000)
				return SendErrorMessage(playerid, "Kamu tidak memiliki cukup uang.");

			new id = Crate_Create(playerid, TYPE_247);
			
			if(id == -1)
				return SendErrorMessage(playerid, "The server cannot create more cargo's!");

			GiveMoney(playerid, -7000);
			SendClientMessage(playerid, COLOR_SERVER, "CARGO: {FFFFFF}Kamu berhasil membeli 24/7 Cargo seharga {00FF00}$70.0");			
		}
		else if(IsPlayerInRangeOfPoint(playerid, 3.0, 2719.2068,-2516.9297,17.3672))
		{
			if(GetMoney(playerid) < 7500)
				return SendErrorMessage(playerid, "Kamu tidak memiliki cukup uang.");

			new id = Crate_Create(playerid, TYPE_FASTFOOD);

			if(id == -1)
				return SendErrorMessage(playerid, "The server cannot create more cargo's!");

			GiveMoney(playerid, -7500);
			SendClientMessage(playerid, COLOR_SERVER, "CARGO: {FFFFFF}Kamu berhasil membeli Fast Food Cargo seharga {00FF00}$75.0");			
		}
	}
	return 1;
}
