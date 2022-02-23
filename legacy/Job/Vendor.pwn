new const FoodName[][] = {
	"None",
	"Burger",
	"Pizza"
};

new const DrinkName[][] = {
	"None",
	"Cola",
	"Sprunk"
};

enum 
{
	FOOD_NONE,
	FOOD_BURGER,
	FOOD_PIZZA
};

enum 
{
	DRINK_NONE,
	DRINK_COLA,
	DRINK_SPRUNK
};


enum vendor_data
{
	STREAMER_TAG_CP:vendorCP,
	vendorActor,
	vendorFood,
	vendorDrink,
	vendorReqFood,
	vendorReqDrink,
};
new VendorData[MAX_VENDOR][vendor_data];

stock SetupVendor()
{
	VendorData[0][vendorCP] = CreateDynamicCP(1774.8690,-1906.6188,13.3856, 1.0, -1, -1, -1, 2.0);
	VendorData[1][vendorCP] = CreateDynamicCP(1774.8695,-1912.0247,13.3856, 1.0, -1, -1, -1, 2.0);
	VendorData[2][vendorCP] = CreateDynamicCP(1774.8652,-1917.7609,13.3856, 1.0, -1, -1, -1, 2.0);
	forex(i, MAX_VENDOR)
	{
		VendorData[i][vendorFood] = FOOD_NONE;
		VendorData[i][vendorDrink] = DRINK_NONE;
	}
}

FUNC::MakeDrink(playerid, drink, id)
{
	VendorData[id][vendorDrink] = drink;
	SendClientMessageEx(playerid, COLOR_SERVER, "SIDEJOB: {FFFFFF}Kamu berhasil membuat {FFFF00}%s", DrinkName[VendorData[id][vendorDrink]]);
	PlayerTextDrawSetString(playerid, DONEDRINK[playerid], sprintf("-_%s", DrinkName[VendorData[id][vendorDrink]]));
	return 1;
}


FUNC::CookFood(playerid, food, id)
{
	VendorData[id][vendorFood] = food;
	SendClientMessageEx(playerid, COLOR_SERVER, "SIDEJOB: {FFFFFF}Kamu berhasil memasak {FFFF00}%s", FoodName[VendorData[id][vendorFood]]);
	PlayerTextDrawSetString(playerid, DONEFOOD[playerid], sprintf("-_%s", FoodName[VendorData[id][vendorFood]]));
	return 1;
}

stock IsVendorUsed(id)
{
	foreach(new i : Player) if(PlayerData[i][pVendor] == id)
	{
		return 1;
	}
	return 0;
}
stock SetupPlayerVendor(playerid)
{
	switch(PlayerData[playerid][pVendor])
	{
		case 0:
		{
			SetPlayerCameraPos(playerid, 1774.8690,-1906.6188,13.3856);
			SetPlayerCameraLookAt(playerid, 1774.8690,-1906.6188,13.3856);
			VendorData[PlayerData[playerid][pVendor]][vendorActor] = CreateDynamicActor(g_aMaleSkins[random(sizeof(g_aMaleSkins))], 1776.9357,-1906.6758,13.3871,92.9013, 1, 100.0, -1, -1, -1, 15.0);

		}
		case 1:
		{
			SetPlayerCameraPos(playerid, 1774.8695,-1912.0247,13.3856);
			SetPlayerCameraLookAt(playerid, 1774.8695,-1912.0247,13.3856);
			VendorData[PlayerData[playerid][pVendor]][vendorActor] = CreateDynamicActor(g_aMaleSkins[random(sizeof(g_aMaleSkins))], 1776.9357,-1911.9794,13.3871,90.5199, 1, 100.0, -1, -1, -1, 15.0);
		}
		case 2:
		{
			SetPlayerCameraPos(playerid, 1774.8652,-1917.7609,13.3856);
			SetPlayerCameraLookAt(playerid, 1774.8652,-1917.7609,13.3856);	
			VendorData[PlayerData[playerid][pVendor]][vendorActor] = CreateDynamicActor(g_aMaleSkins[random(sizeof(g_aMaleSkins))], 1776.9343,-1917.6980,13.3871,91.5226, 1, 100.0, -1, -1, -1, 15.0);		
		}
	}
	forex(i, 18)
	{
		PlayerTextDrawShow(playerid, VENDORTD[playerid][i]);
	}
	PlayerTextDrawShow(playerid, DONEJOB[playerid]);
	PlayerTextDrawShow(playerid, BURGERTD[playerid]);
	PlayerTextDrawShow(playerid, PIZZATD[playerid]);
	PlayerTextDrawShow(playerid, COLATD[playerid]);
	PlayerTextDrawShow(playerid, SPRUNKTD[playerid]);
	PlayerTextDrawShow(playerid, FOODTD[playerid]);
	PlayerTextDrawShow(playerid, DRINKTD[playerid]);
	PlayerTextDrawShow(playerid, RESETJOB[playerid]);
	PlayerTextDrawShow(playerid, EXITJOB[playerid]);
	PlayerTextDrawShow(playerid, DONEFOOD[playerid]);
	PlayerTextDrawShow(playerid, DONEDRINK[playerid]);
	SelectTextDraw(playerid, COLOR_YELLOW);

	VendorData[PlayerData[playerid][pVendor]][vendorReqFood] = random(2)+1;
	VendorData[PlayerData[playerid][pVendor]][vendorReqDrink] = random(2)+1;

	PlayerTextDrawSetString(playerid, DRINKTD[playerid], sprintf("-_%s", DrinkName[VendorData[PlayerData[playerid][pVendor]][vendorReqDrink]]));
	PlayerTextDrawSetString(playerid, FOODTD[playerid], sprintf("-_%s", FoodName[VendorData[PlayerData[playerid][pVendor]][vendorReqFood]]));
	TogglePlayerControllable(playerid, 0);
	SetPlayerFacingAngle(playerid, 270.6022);

	SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "Buyer %d says: Hello, i want to order %s and %s.", PlayerData[playerid][pVendor] + 1, FoodName[VendorData[PlayerData[playerid][pVendor]][vendorReqFood]], DrinkName[VendorData[PlayerData[playerid][pVendor]][vendorReqDrink]]);
	return 1;
}