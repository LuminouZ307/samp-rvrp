enum ddInfo
{
	ddDescription[128],
	ddPickupID,
	Text3D: ddTextID,
	ddCustomInterior,
	ddExteriorVW,
	ddExteriorInt,
	ddInteriorVW,
	ddInteriorInt,
	Float: ddExteriorX,
	Float: ddExteriorY,
	Float: ddExteriorZ,
	Float: ddExteriorA,
	Float: ddInteriorX,
	Float: ddInteriorY,
	Float: ddInteriorZ,
	Float: ddInteriorA,
	ddCustomExterior,
	ddVIP,
	ddFamily,
	ddFaction,
	ddAdmin,
	ddWanted,
	ddVehicleAble,
	ddColor,
	ddPickupModel,
	dPass[24],
	dLocked,
	dCP,
};
new DoorData[MAX_DDOORS][ddInfo];

stock SaveDynamicDoors()
{

	new	szFileStr[512],
	File: fHandle = fopen("dynamicdoors.cfg", io_write);

	for(new iIndex; iIndex < MAX_DDOORS; iIndex++)
	{
		format(szFileStr, sizeof(szFileStr), "%s|%d|%d|%d|%d|%d|%f|%f|%f|%f|%f|%f|%f|%f|%d|%d|%d|%d|%d|%d|%d|%d|%d|%s|%d\r\n",
		DoorData[iIndex][ddDescription],
		DoorData[iIndex][ddCustomInterior],
		DoorData[iIndex][ddExteriorVW],
		DoorData[iIndex][ddExteriorInt],
		DoorData[iIndex][ddInteriorVW],
		DoorData[iIndex][ddInteriorInt],
		DoorData[iIndex][ddExteriorX],
		DoorData[iIndex][ddExteriorY],
		DoorData[iIndex][ddExteriorZ],
		DoorData[iIndex][ddExteriorA],
		DoorData[iIndex][ddInteriorX],
		DoorData[iIndex][ddInteriorY],
		DoorData[iIndex][ddInteriorZ],
		DoorData[iIndex][ddInteriorA],
		DoorData[iIndex][ddCustomExterior],
		DoorData[iIndex][ddVIP],
		DoorData[iIndex][ddFamily],
		DoorData[iIndex][ddFaction],
		DoorData[iIndex][ddAdmin],
		DoorData[iIndex][ddWanted],
		DoorData[iIndex][ddVehicleAble],
		DoorData[iIndex][ddColor],
		DoorData[iIndex][ddPickupModel],
		DoorData[iIndex][dPass],
		DoorData[iIndex][dLocked]
		);
		fwrite(fHandle, szFileStr);
	}
	return fclose(fHandle);
}

stock CreateDynamicDoor(doorid)
{
	new string[300];
	format(string, sizeof(string), "[{C6E2FF}ID: %d{FFFFFF}]\n[ {C6E2FF}%s {FFFFFF}] \nPress {FF0000}ENTER {FFFFFF}or {FF0000}/enter\n{FFFFFF}To enter/exit the door.",doorid, DoorData[doorid][ddDescription]);
	DoorData[doorid][ddTextID] = CreateDynamic3DTextLabel(string, -1, DoorData[doorid][ddExteriorX], DoorData[doorid][ddExteriorY], DoorData[doorid][ddExteriorZ]+0.5,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1);
	DoorData[doorid][ddPickupID] = CreateDynamicPickup(19130, 23, DoorData[doorid][ddExteriorX], DoorData[doorid][ddExteriorY], DoorData[doorid][ddExteriorZ], -1, -1);
}

LoadDynamicDoors()
{
	new arrCoords[25][64];
	new strFromFile2[256];
	new File: file = fopen("dynamicdoors.cfg", io_read);
	if (file)
	{
		new idx;
		while (idx < sizeof(DoorData))
		{
			fread(file, strFromFile2);
			splits(strFromFile2, arrCoords, '|');
			strmid(DoorData[idx][ddDescription], arrCoords[0], 0, strlen(arrCoords[0]), 128);
	  		DoorData[idx][ddCustomInterior] = strval(arrCoords[1]);
	  		DoorData[idx][ddExteriorVW] = strval(arrCoords[2]);
	  		DoorData[idx][ddExteriorInt] = strval(arrCoords[3]);
	  		DoorData[idx][ddInteriorVW] = strval(arrCoords[4]);
	  		DoorData[idx][ddInteriorInt] = strval(arrCoords[5]);
	  		DoorData[idx][ddExteriorX] = floatstr(arrCoords[6]);
	  		DoorData[idx][ddExteriorY] = floatstr(arrCoords[7]);
	  		DoorData[idx][ddExteriorZ] = floatstr(arrCoords[8]);
	  		DoorData[idx][ddExteriorA] = floatstr(arrCoords[9]);
	  		DoorData[idx][ddInteriorX] = floatstr(arrCoords[10]);
	  		DoorData[idx][ddInteriorY] = floatstr(arrCoords[11]);
	  		DoorData[idx][ddInteriorZ] = floatstr(arrCoords[12]);
	  		DoorData[idx][ddInteriorA] = floatstr(arrCoords[13]);
	  		DoorData[idx][ddCustomExterior] = strval(arrCoords[14]);
	  		DoorData[idx][ddVIP] = strval(arrCoords[15]);
	  		DoorData[idx][ddFamily] = strval(arrCoords[16]);
	  		DoorData[idx][ddFaction] = strval(arrCoords[17]);
	  		DoorData[idx][ddAdmin] = strval(arrCoords[18]);
	  		DoorData[idx][ddWanted] = strval(arrCoords[19]);
	  		DoorData[idx][ddVehicleAble] = strval(arrCoords[20]);
	  		DoorData[idx][ddColor] = strval(arrCoords[21]);
	  		DoorData[idx][ddPickupModel] = strval(arrCoords[22]);
	  		strmid(DoorData[idx][dPass], arrCoords[23], 0, strlen(arrCoords[23]), 24);
	  		DoorData[idx][dLocked] = strval(arrCoords[24]);
	  		if(DoorData[idx][ddExteriorX])
	  		{
		  		if(!IsNull(DoorData[idx][ddDescription]))
		  		{
		  		    CreateDynamicDoor(idx);
				}
			}
			idx++;
		}
		fclose(file);
	}
	return 1;
}

CMD:doorname(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 6)
		return SendClientMessageEx(playerid, COLOR_GREY, "ERROR: You don't have the privilege to use this command!");

	new doorid, doorname[128];
	if(sscanf(params, "ds[128]", doorid, doorname))
		return SendSyntaxMessage(playerid, "USAGE: /doorname [doorid] [name]");
		
	FormatText(doorname);
	format(DoorData[doorid][ddDescription], 128, "%s", doorname);
	SendClientMessageEx(playerid, COLOR_WHITE, "You have changed the name of the door!");
	if(IsValidDynamicPickup(DoorData[doorid][ddPickupID]))
	DestroyDynamicPickup(DoorData[doorid][ddPickupID]);
	if(IsValidDynamic3DTextLabel(DoorData[doorid][ddTextID]))
	DestroyDynamic3DTextLabel(DoorData[doorid][ddTextID]);
	CreateDynamicDoor(doorid);
	SaveDynamicDoors();
	return 1;
}

CMD:editdoor(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 6)
		return SendClientMessageEx(playerid, COLOR_GREY, "ERROR: You don't have the privilege to use this command!");

	new choice[32], doorid;
	if(sscanf(params, "s[32]d", choice, doorid))
	{
		SendSyntaxMessage(playerid, "/editdoor [name] [doorid]");
		SendClientMessageEx(playerid, COLOR_GREY, "Names: Exterior, Interior, Delete");
		return 1;
	}
	if(doorid >= MAX_DDOORS)
	    return SendErrorMessage(playerid,"Invalid door ID!");
	    
	if(strcmp(choice, "interior", true) == 0)
	{
		GetPlayerPos(playerid, DoorData[doorid][ddInteriorX], DoorData[doorid][ddInteriorY], DoorData[doorid][ddInteriorZ]);
		GetPlayerFacingAngle(playerid, DoorData[doorid][ddInteriorA]);
		DoorData[doorid][ddInteriorInt] = GetPlayerInterior(playerid);
		DoorData[doorid][ddInteriorVW] = GetPlayerVirtualWorld(playerid);
		SendClientMessageEx(playerid, COLOR_WHITE, "You have changed the interior!");
		SaveDynamicDoors();
		return 1;
	}
	else if(strcmp(choice, "exterior", true) == 0)
	{
		GetPlayerPos(playerid, DoorData[doorid][ddExteriorX], DoorData[doorid][ddExteriorY], DoorData[doorid][ddExteriorZ]);
		GetPlayerFacingAngle(playerid, DoorData[doorid][ddExteriorA]);
		DoorData[doorid][ddExteriorVW] = GetPlayerVirtualWorld(playerid);
		DoorData[doorid][ddExteriorInt] = GetPlayerInterior(playerid);
		SendClientMessageEx(playerid, COLOR_WHITE, "You have changed the exterior!");
		DestroyDynamicPickup(DoorData[doorid][ddPickupID]);
		DestroyDynamic3DTextLabel(DoorData[doorid][ddTextID]);
		CreateDynamicDoor(doorid);
		SaveDynamicDoors();
	}
	else if(strcmp(choice, "delete", true) == 0)
	{
	    if (DoorData[doorid][ddExteriorX] == 0)
			return SendErrorMessage(playerid, "Door ID %d does not exist.", doorid);
			
    	if(IsValidDynamicPickup(DoorData[doorid][ddPickupID]))
		DestroyDynamicPickup(DoorData[doorid][ddPickupID]);
	    DestroyDynamic3DTextLabel(DoorData[doorid][ddTextID]);
		DoorData[doorid][ddDescription] = 0;
		DoorData[doorid][ddCustomInterior] = 0;
		DoorData[doorid][ddExteriorVW] = 0;
		DoorData[doorid][ddExteriorInt] = 0;
		DoorData[doorid][ddInteriorVW] = 0;
		DoorData[doorid][ddInteriorInt] = 0;
		DoorData[doorid][ddExteriorX] = 0;
		DoorData[doorid][ddExteriorY] = 0;
		DoorData[doorid][ddExteriorZ] = 0;
		DoorData[doorid][ddExteriorA] = 0;
		DoorData[doorid][ddInteriorX] = 0;
		DoorData[doorid][ddInteriorY] = 0;
		DoorData[doorid][ddInteriorZ] = 0;
		DoorData[doorid][ddInteriorA] = 0;
		DoorData[doorid][ddCustomExterior] = 0;
		DoorData[doorid][ddVIP] = 0;
		DoorData[doorid][ddFamily] = 0;
		DoorData[doorid][ddFaction] = 0;
		DoorData[doorid][ddAdmin] = 0;
		DoorData[doorid][ddWanted] = 0;
		DoorData[doorid][ddVehicleAble] = 0;
		DoorData[doorid][ddColor] = 0;
		DoorData[doorid][dPass] = 0;
		DoorData[doorid][dLocked] = 0;
		DoorData[doorid][dCP] = 0;
		SaveDynamicDoors();
		return 1;
	}
	return 1;
}
