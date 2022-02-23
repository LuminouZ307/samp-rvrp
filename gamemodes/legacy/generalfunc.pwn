stock GetHoodStatus(vehicleid)
{
	static
	engine,
	lights,
	alarm,
	doors,
	bonnet,
	boot,
	objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if(bonnet != 1)
		return 0;

	return 1;
}

stock IsABike(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 448, 461..463, 468, 521..523, 581, 586, 481, 509, 510: return 1;
	}
	return 0;
}

stock ReturnTimelapse(start, till)
{
    new ret[32];
	new second = till - start;

	const
		MINUTE = 60,
		HOUR = 60 * MINUTE,
		DAY = 24 * HOUR,
		MONTH = 30 * DAY;

	if (second == 1)
		format(ret, sizeof(ret), "a second");
	if (second < (1 * MINUTE))
		format(ret, sizeof(ret), "%i seconds", second);
	else if (second < (2 * MINUTE))
		format(ret, sizeof(ret), "a minute");
	else if (second < (45 * MINUTE))
		format(ret, sizeof(ret), "%i minutes", (second / MINUTE));
	else if (second < (90 * MINUTE))
		format(ret, sizeof(ret), "an hour");
	else if (second < (24 * HOUR))
		format(ret, sizeof(ret), "%i hours", (second / HOUR));
	else if (second < (48 * HOUR))
		format(ret, sizeof(ret), "a day");
	else if (second < (30 * DAY))
		format(ret, sizeof(ret), "%i days", (second / DAY));
	else if (second < (12 * MONTH))
    {
		new month = floatround(second / DAY / 30);
      	if (month <= 1)
			format(ret, sizeof(ret), "a month");
      	else
			format(ret, sizeof(ret), "%i months", month);
	}
    else
    {
      	new year = floatround(second / DAY / 365);
      	if (year <= 1)
			format(ret, sizeof(ret), "a year");
      	else
			format(ret, sizeof(ret), "%i years", year);
	}
	return ret;
}
		

stock ReturnWeaponName(weaponid)
{
    new weapon[22];
    switch(weaponid)
    {
        case 0: weapon = "Fist";
        case 18: weapon = "Molotov Cocktail";
        case 44: weapon = "Night Vision Goggles";
        case 45: weapon = "Thermal Goggles";
        case 54: weapon = "Fall";
        default: GetWeaponName(weaponid, weapon, sizeof(weapon));
    }
    return weapon;
}

stock GetNearestVehicle(playerid, Float:radius)
{
	static
	    Float:fX,
	    Float:fY,
	    Float:fZ;

	for (new i = 1; i != MAX_VEHICLES; i ++) if (IsValidVehicle(i) && GetVehiclePos(i, fX, fY, fZ))
	{
	    if (IsPlayerInRangeOfPoint(playerid, radius, fX, fY, fZ)) return i;
	}
	return INVALID_VEHICLE_ID;
}

stock LockVehicle(vehicleid,status)
{
	new engine,lights,alarm,doors,bonnet,boot,objective;
	GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
	SetVehicleParamsEx(vehicleid,engine,lights,alarm,status,bonnet,boot,objective);
}

stock GetTrunkStatus(vehicleid)
{
	static
	engine,
	lights,
	alarm,
	doors,
	bonnet,
	boot,
	objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if(boot != 1)
		return 0;

	return 1;
}

stock GetElapsedTime(time, &hours, &minutes, &seconds)
{
	hours = 0;
	minutes = 0;
	seconds = 0;

	if (time >= 3600)
	{
		hours = (time / 3600);
		time -= (hours * 3600);
	}
	while (time >= 60)
	{
	    minutes++;
	    time -= 60;
	}
	return (seconds = time);
}

stock ShowBox(playerid, header[] = "", text[] = "", time)
{
	new validtime = time*1000;
	forex(i, 4)
	{
		PlayerTextDrawShow(playerid, SHOWBOXTD[playerid][i]);
	}
	PlayerTextDrawSetString(playerid, SHOWBOXTD[playerid][1], header);
	PlayerTextDrawSetString(playerid, SHOWBOXTD[playerid][3], text);
	SetTimerEx("HideBoxText", validtime, false, "d", playerid);
	PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
	return 1;
}

FUNC::HideBoxText(playerid)
{
	forex(i, 4)
	{
		PlayerTextDrawHide(playerid, SHOWBOXTD[playerid][i]);
	}
	return 1;
}
stock ShowMessage(playerid, string[], time)//Time in Sec.
{
	new validtime = time*1000;

	PlayerTextDrawSetString(playerid, MSGTD[playerid], string);
	PlayerTextDrawShow(playerid, MSGTD[playerid]);
	SetTimerEx("HideMessage", validtime, false, "d", playerid);
	return 1;
}

FUNC::HideMessage(playerid)
{
	return PlayerTextDrawHide(playerid, MSGTD[playerid]);
}

stock RandomEx(min, max)
{
	new rand = random(max-min)+min;
	return rand;
}

FUNC::HideCashText(playerid)
{
	PlayerTextDrawHide(playerid, CASHTD[playerid]);
}


stock SetPlayerPosEx(playerid, Float:x, Float:y, Float:z)
{
	TogglePlayerControllable(playerid, false);
	SetPlayerPos(playerid, x, y, z);
	SetTimerEx("UnFreeze", 2000, false, "d", playerid);
}

FUNC::UnFreeze(playerid)
{
    TogglePlayerControllable(playerid, true);
}

stock ShowText(playerid, text[], time)
{
	new total = time * 1000;
	new str[256];
	format(str, sizeof(str), "%s", text);
	GameTextForPlayer(playerid, str, total, 3);
	return 1;
}

IsNumeric(const str[])
{
	for (new i = 0, l = strlen(str); i != l; i ++)
	{
	    if (i == 0 && str[0] == '-')
			continue;

	    else if (str[i] < '0' || str[i] > '9')
			return 0;
	}
	return 1;
}

new stock g_arrVehicleNames[][] = {
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
    "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
    "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach",
    "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
    "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
    "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
    "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
    "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
    "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
    "Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
    "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain",
    "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
    "Fortune", "Cadrona", "SWAT Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
    "Blade", "Streak", "Freight", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
    "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
    "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
    "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "LSPD", "SFPD", "LVPD",
    "Police Rancher", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
    "Boxville", "Tiller", "Utility Trailer"
};


stock GetVehicleModelByName(const name[])
{
	if(IsNumeric(name) && (strval(name) >= 400 && strval(name) <= 611))
		return strval(name);

	for (new i = 0; i < sizeof(g_arrVehicleNames); i ++)
	{
		if(strfind(g_arrVehicleNames[i], name, true) != -1)
		{
			return i + 400;
		}
	}
	return 0;
}

ReturnVehicleModelName(model)
{
	new
	    name[32] = "None";

    if (model < 400 || model > 611)
	    return name;

	format(name, sizeof(name), g_arrVehicleNames[model - 400]);
	return name;
}

stock GetVehicleSpeedKMH(vehicleid)
{
	new Float:speed_x, Float:speed_y, Float:speed_z, Float:temp_speed, round_speed;
	GetVehicleVelocity(vehicleid, speed_x, speed_y, speed_z);

	temp_speed = temp_speed = floatsqroot(((speed_x*speed_x) + (speed_y*speed_y)) + (speed_z*speed_z)) * 136.666667;

	round_speed = floatround(temp_speed);
	return round_speed;
}

stock GetFuel(vehicleid)
{
	return VehCore[vehicleid][vehFuel];
}
GetEngineStatus(vehicleid)
{
	static
	engine,
	lights,
	alarm,
	doors,
	bonnet,
	boot,
	objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if(engine != 1)
		return 0;

	return 1;
}

stock HideCharacterSetup(playerid)
{
	CancelSelectTextDraw(playerid);
	forex(i, 7)
	{
		PlayerTextDrawHide(playerid, SETUPTD[playerid][i]);
	}
	PlayerTextDrawHide(playerid, SETNAME[playerid]);
	PlayerTextDrawHide(playerid, SETBIRTHDATE[playerid]);
	PlayerTextDrawHide(playerid, SETORIGIN[playerid]);
	PlayerTextDrawHide(playerid, SETGENDER[playerid]);
	PlayerTextDrawHide(playerid, ORIGINTD[playerid]);
	PlayerTextDrawHide(playerid, BIRTHDATETD[playerid]);
	PlayerTextDrawHide(playerid, GENDERTD[playerid]);
	PlayerTextDrawHide(playerid, NAMETD[playerid]);
	PlayerTextDrawHide(playerid, FINISHSETUP[playerid]);	
	return 1;
}
stock ShowCharacterSetup(playerid)
{
	SelectTextDraw(playerid, COLOR_YELLOW);
	forex(i, 7)
	{
		PlayerTextDrawShow(playerid, SETUPTD[playerid][i]);
	}
	PlayerTextDrawShow(playerid, SETNAME[playerid]);
	PlayerTextDrawShow(playerid, SETBIRTHDATE[playerid]);
	PlayerTextDrawShow(playerid, SETORIGIN[playerid]);
	PlayerTextDrawShow(playerid, SETGENDER[playerid]);
	PlayerTextDrawShow(playerid, ORIGINTD[playerid]);
	PlayerTextDrawShow(playerid, BIRTHDATETD[playerid]);
	PlayerTextDrawShow(playerid, GENDERTD[playerid]);
	PlayerTextDrawShow(playerid, NAMETD[playerid]);
	PlayerTextDrawShow(playerid, FINISHSETUP[playerid]);
	return 1;
}

stock CreateGlobalTextDraw()
{
	sen = TextDrawCreate(580.000000, 80.000000, ".");
	TextDrawBackgroundColor(sen, 255);
	TextDrawFont(sen, 1);
	TextDrawLetterSize(sen, 0.549999, 2.200002);
	TextDrawColor(sen, 794437320);
	TextDrawSetOutline(sen, 1);
	TextDrawSetProportional(sen, 1);
	TextDrawSetSelectable(sen, 0);

	koma2 = TextDrawCreate(543.000000, 80.000000, ",");
	TextDrawBackgroundColor(koma2, 255);
	TextDrawFont(koma2, 0);
	TextDrawLetterSize(koma2, 0.549999, 2.200002);
	TextDrawColor(koma2, 794437320);
	TextDrawSetOutline(koma2, 1);
	TextDrawSetProportional(koma2, 1);
	TextDrawSetSelectable(koma2, 0);
}

stock FormatNumber(Float:amount, delimiter[2]=".", comma[2]=",")
{
	#define MAX_MONEY_String 16
	new txt[MAX_MONEY_String];
	format(txt, MAX_MONEY_String, "%d", floatround(amount));
	new l = strlen(txt);
	if (amount < 0) // -
	{
		if (l > 2) strins(txt,delimiter,l-2);
		if (l > 5) strins(txt,comma,l-5);
		if (l > 8) strins(txt,comma,l-8);
	}
	else
	{//1000000
		if (l > 2) strins(txt,delimiter,l-2);
		if (l > 5) strins(txt,comma,l-5);
		if (l > 9) strins(txt,comma,l-8);
	}
//	if (l <= 2) format(txt,sizeof( szStr ),"00,%s",txt);
	return txt;
}

stock KickEx(playerid)
{
	SaveData(playerid);
	SetTimerEx("KickTimer", 400, false, "d", playerid);
}

FUNC::KickTimer(playerid)
{
	Kick(playerid);
}

stock Database_Connect()
{
	sqlcon = mysql_connect(DATABASE_ADDRESS,DATABASE_USERNAME,DATABASE_PASSWORD,DATABASE_NAME);

	if(mysql_errno(sqlcon) != 0)
	{
	    print("[MySQL] - Connection Failed!");
	    SetGameModeText("Revitalize | Connection Failed!");
	}
	else
	{
		print("[MySQL] - Connection Estabilished!");
		SetGameModeText("RV:RP "SERVER_VERSION"");
	}
}

stock IsRoleplayName(player[])
{
    forex(n,strlen(player))
    {
        if (player[n] == '_' && player[n+1] >= 'A' && player[n+1] <= 'Z') return 1;
        if (player[n] == ']' || player[n] == '[') return 0;
	}
    return 0;
}

stock IsPlayerNearPlayer(playerid, targetid, Float:radius)
{
	static
		Float:fX,
		Float:fY,
		Float:fZ;

	GetPlayerPos(targetid, fX, fY, fZ);

	return (GetPlayerInterior(playerid) == GetPlayerInterior(targetid) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(targetid)) && IsPlayerInRangeOfPoint(playerid, radius, fX, fY, fZ);
}

stock SendClientMessageEx(playerid, colour, const text[], va_args<>)
{
    new str[145];
    va_format(str, sizeof(str), text, va_start<3>);
    return SendClientMessage(playerid, colour, str);
}

stock IsDiesel(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 499, 609, 598, 524, 532, 578, 486, 406, 573, 455, 588, 403, 423, 414, 443, 515, 525: return 1;
	}
	return 0;
}
stock IsEngineVehicle(vehicleid)
{
	new const g_aEngineStatus[] = {
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1,
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0
	};
    new modelid = GetVehicleModel(vehicleid);

    if (modelid < 400 || modelid > 611)
        return 0;

    return (g_aEngineStatus[modelid - 400]);
}

stock IsSpeedoVehicle(vehicleid)
{
	if (GetVehicleModel(vehicleid) == 509 || GetVehicleModel(vehicleid) == 510 || GetVehicleModel(vehicleid) == 481 || !IsEngineVehicle(vehicleid)) {
	    return 0;
	}
	return 1;
}

FUNC::EngineStatus(playerid, vehicleid)
{
	if(!GetEngineStatus(vehicleid))
	{
		new Float: f_vHealth;
		GetVehicleHealth(vehicleid, f_vHealth);
		if(f_vHealth < 350.0)
			return SendErrorMessage(playerid, "This vehicle is damaged!");

		if(VehCore[vehicleid][vehFuel] <= 0)
			return SendErrorMessage(playerid, "There is no fuel on this vehicle!");

		SwitchVehicleEngine(vehicleid, true);
		ShowMessage(playerid, "Engine turned ~g~ON", 3);
	}
	else
	{
		SwitchVehicleEngine(vehicleid, false);
		ShowMessage(playerid, "Engine turned ~r~OFF", 3);
		SwitchVehicleLight(vehicleid, false);
	}
	return 1;
}

stock ProxDetector(Float: f_Radius, playerid, string[],col1,col2,col3,col4,col5)
{
	new
		Float: f_playerPos[3];

	GetPlayerPos(playerid, f_playerPos[0], f_playerPos[1], f_playerPos[2]);
	foreach(new i : Player)
	{
		if(GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid) && GetPlayerInterior(i) == GetPlayerInterior(playerid))
		{
			if(IsPlayerInRangeOfPoint(i, f_Radius / 16, f_playerPos[0], f_playerPos[1], f_playerPos[2])) {
				SendClientMessage(i, col1, string);
			}
			else if(IsPlayerInRangeOfPoint(i, f_Radius / 8, f_playerPos[0], f_playerPos[1], f_playerPos[2])) {
				SendClientMessage(i, col2, string);
			}
			else if(IsPlayerInRangeOfPoint(i, f_Radius / 4, f_playerPos[0], f_playerPos[1], f_playerPos[2])) {
				SendClientMessage(i, col3, string);
			}
			else if(IsPlayerInRangeOfPoint(i, f_Radius / 2, f_playerPos[0], f_playerPos[1], f_playerPos[2])) {
				SendClientMessage(i, col4, string);
			}
			else if(IsPlayerInRangeOfPoint(i, f_Radius, f_playerPos[0], f_playerPos[1], f_playerPos[2])) {
				SendClientMessage(i, col5, string);
			}
		}
	}
	return 1;
}

stock GetVehicleFromBehind(vehicleid)
{
	static
	    Float:fCoords[7];

	GetVehiclePos(vehicleid, fCoords[0], fCoords[1], fCoords[2]);
	GetVehicleZAngle(vehicleid, fCoords[3]);

	for (new i = 1; i != MAX_VEHICLES; i ++) if (i != vehicleid && GetVehiclePos(i, fCoords[4], fCoords[5], fCoords[6]))
	{
		if (floatabs(fCoords[0] - fCoords[4]) < 6 && floatabs(fCoords[1] - fCoords[5]) < 6 && floatabs(fCoords[2] - fCoords[6]) < 6)
			return i;
	}
	return INVALID_VEHICLE_ID;
}

stock IsPlayerNearBoot(playerid, vehicleid)
{
	static
		Float:fX,
		Float:fY,
		Float:fZ;

	GetVehicleBoot(vehicleid, fX, fY, fZ);

	return (GetPlayerVirtualWorld(playerid) == GetVehicleVirtualWorld(vehicleid)) && IsPlayerInRangeOfPoint(playerid, 3.5, fX, fY, fZ);
}

stock GetVehicleBoot(vehicleid, &Float:x, &Float:y, &Float:z)
{
	if (!GetVehicleModel(vehicleid) || vehicleid == INVALID_VEHICLE_ID)
	    return (x = 0.0, y = 0.0, z = 0.0), 0;

	static
	    Float:pos[7]
	;
	GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, pos[0], pos[1], pos[2]);
	GetVehiclePos(vehicleid, pos[3], pos[4], pos[5]);
	GetVehicleZAngle(vehicleid, pos[6]);

	x = pos[3] - (floatsqroot(pos[1] + pos[1]) * floatsin(-pos[6], degrees));
	y = pos[4] - (floatsqroot(pos[1] + pos[1]) * floatcos(-pos[6], degrees));
 	z = pos[5];

	return 1;
}

FUNC::ClosePDDoor()
{
	if(DoorOpened == 1)
	{
	    MoveDynamicObject(door, 861.31, 2325.16, 1910.66, 3);
		DoorOpened = 0;
	}
	return 1;
}

FUNC::PDDoorCheck()
{
    if(LSPD_Door[Opened] == 1)
	{
		MoveDynamicObject(LSPD_Door[ObjectID1], 872.87, 2312.50, 1910.64, 1.50);
	    MoveDynamicObject(LSPD_Door[ObjectID2], 875.87, 2312.50, 1910.64, 1.50);
		LSPD_Door[Opened] = 0; KillTimer(LSPD_Door[TimerID]);
	}
	return 1;
}

FUNC::CloseWestLobby()
{
    MoveDynamicObject(westlobby1,-549.68927, 475.48151, 1367.40540,4);
    MoveDynamicObject(westlobby2,-546.68890, 475.48520, 1367.40540,4);
}

FUNC::CloseSANewsPrivate()
{
    MoveDynamicObject(SANewsPrivateA,625.61999512,-0.55000001,1106.96081543,4);
    MoveDynamicObject(SANewsPrivateB,625.65002441,-3.54999995,1106.96081543,4);
    return 1;
}

FUNC::CloseSANewsOffice()
{
    MoveDynamicObject(SANewsOfficeA,176.652496,136.940963,1002.049682,4);
    return 1;
}

FUNC::PressJump(playerid)
{
    PlayerPressedJump[playerid] = 0; // Reset the variable
    ClearAnimations(playerid);
    Falling[playerid] = false;
    return 1;
}
FUNC::PressJumpReset(playerid)
{
    PlayerPressedJump[playerid] = 0; // Reset the variable
    return 1;
}

stock strcash(value[])
{
	new dollars, cents, totalcash[25];
	if(strfind(value, ".", true) != -1)
	{
		sscanf(value, "p<.>dd", dollars, cents);
		format(totalcash, sizeof(totalcash), "%d%02d", dollars, cents);
	}
	else
	{
		sscanf(value, "d", dollars);
		format(totalcash, sizeof(totalcash), "%d00", dollars);
	}
	return strval(totalcash);
}

FUNC::SyncPlayerTime(playerid)
{
	new hour, minutes, second;
	gettime(hour, minutes, second);
	SetPlayerTime(playerid, hour, minutes);
	return 1;
}

stock GetMonthName(Month)
{
	new MonthName[12];

	switch(Month)
	{
		case 1: MonthName = "Jan";
		case 2: MonthName = "Febr";
		case 3: MonthName = "Mar";
		case 4: MonthName = "Apr";
		case 5: MonthName = "May";
		case 6: MonthName = "Jun";
		case 7: MonthName = "Jul";
		case 8: MonthName = "Aug";
		case 9: MonthName = "Sept";
		case 10: MonthName = "Oct";
		case 11: MonthName = "Nov";
		case 12: MonthName = "Dec";
	}

	return MonthName;
}

stock GetDay(Day)
{
	new str[12];
	switch(Day)
	{
		case 1: str = "1";
		case 2: str = "2";
		case 3: str = "3";
		case 4: str = "4";
		case 5: str = "5";
		case 6: str = "6";
		case 7: str = "7";
		case 8: str = "8";
		case 9: str = "9";
		case 10: str = "10";
		case 11: str = "11";
		case 12: str = "12";
		case 13: str = "13";
		case 14: str = "14";
		case 15: str = "15";
		case 16: str = "16";
		case 17: str = "17";
		case 18: str = "18";
		case 19: str = "19";
		case 20: str = "20";
		case 21: str = "21";
		case 22: str = "22";
		case 23: str = "23";
		case 24: str = "24";
		case 25: str = "25";
		case 26: str = "26";
		case 27: str = "27";
		case 28: str = "28";
		case 29: str = "29";
		case 30: str = "30";
		case 31: str = "31";
	}
	return str;
}
stock GetWeekDay(day=0, month=0, year=0)
{
	if(!day)
			getdate(year, month, day);
	new
		szWeekDay[17],
		j,
		e;

	if(month <= 2)
	{
		month += 12;
		--year;
	}

	j = year % 100;
	e = year / 100;

	switch((day + (month+1)*26/10 + j + j/4 + e/4 - 2*e) % 7)
	{
		case 0: szWeekDay = "Sat";
		case 1: szWeekDay = "Sun";
		case 2: szWeekDay = "Mon";
		case 3: szWeekDay = "Tue";
		case 4: szWeekDay = "Wed";
		case 5: szWeekDay = "Thu";
		case 6: szWeekDay = "Fri";
	}
	return szWeekDay;
}

stock GetHealthName(Float:amount)
{
	new str[80];
	if(amount <= 20.0)
	{
	    str = "{FF0000}Fatal";
	}
	else if(amount > 20.0 && amount <= 70.0)
	{
	    str = "{FFFF00}Normal";
	}
	else if(amount > 70.0 && amount <= 100.0)
	{
	    str = "{00FF00}Healthy";
	}
	return str;
}


stock FlipVehicle(vehicleid)
{
	new
	    Float:fAngle;

	GetVehicleZAngle(vehicleid, fAngle);

	SetVehicleZAngle(vehicleid, fAngle);
	SetVehicleVelocity(vehicleid, 0.0, 0.0, 0.0);
}

stock LoadRemoveBuilding(playerid)
{
	RemoveVendingMachines(playerid);

	/* Fish Pier */
	RemoveBuildingForPlayer(playerid, 1280, 150.664, -1809.359, 3.085, 0.250);
	/* Idlewood Project*/
	RemoveBuildingForPlayer(playerid, 3644, 2069.620, -1556.699, 15.062, 0.250);
	RemoveBuildingForPlayer(playerid, 3645, 2069.620, -1556.699, 15.062, 0.250);
	RemoveBuildingForPlayer(playerid, 3644, 2070.760, -1586.020, 15.062, 0.250);
	RemoveBuildingForPlayer(playerid, 3645, 2070.760, -1586.020, 15.062, 0.250);
	RemoveBuildingForPlayer(playerid, 1524, 2074.179, -1579.150, 14.031, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 2055.270, -1594.229, 13.765, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 2055.270, -1599.500, 13.765, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 2058.050, -1602.229, 13.765, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 2063.330, -1602.229, 13.765, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 2078.489, -1602.229, 13.765, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 2083.770, -1602.229, 13.765, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 2086.459, -1599.589, 13.765, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 2086.459, -1594.319, 13.765, 0.250);

	//sanews exterior
    RemoveBuildingForPlayer(playerid, 1226, 778.8594, -1391.1563, 16.3125, 0.25);
    RemoveBuildingForPlayer(playerid, 1226, 642.0938, -1359.8203, 16.2734, 0.25);
    RemoveBuildingForPlayer(playerid, 1689, 745.5859, -1381.1094, 25.8750, 0.25);
    RemoveBuildingForPlayer(playerid, 1689, 751.3359, -1368.0313, 25.8750, 0.25);
    RemoveBuildingForPlayer(playerid, 1415, 732.8516, -1332.8984, 12.6875, 0.25);
    RemoveBuildingForPlayer(playerid, 1439, 732.7266, -1341.7734, 12.6328, 0.25);
    //House Interior
	RemoveBuildingForPlayer(playerid, 2520, 234.602, 1109.380, 1079.949, 0.250);
	RemoveBuildingForPlayer(playerid, 2522, 235.602, 1112.239, 1079.969, 0.250);
	RemoveBuildingForPlayer(playerid, 2523, 232.656, 1108.829, 1079.989, 0.250);
	RemoveBuildingForPlayer(playerid, 2528, 232.632, 1110.589, 1079.979, 0.250);
	RemoveBuildingForPlayer(playerid, 1567, 2231.300, -1111.459, 1049.859, 0.250);
	RemoveBuildingForPlayer(playerid, 15039, 2232.340, -1106.739, 1049.750, 0.250);
	RemoveBuildingForPlayer(playerid, 15038, 2235.290, -1108.130, 1051.270, 0.250);
	RemoveBuildingForPlayer(playerid, 1741, 248.483, 306.125, 998.140, 0.250);
	RemoveBuildingForPlayer(playerid, 2088, 248.492, 304.351, 998.226, 0.250);
	RemoveBuildingForPlayer(playerid, 14863, 246.983, 303.578, 998.750, 0.250);
	RemoveBuildingForPlayer(playerid, 1741, 248.867, 301.960, 998.140, 0.250);
	RemoveBuildingForPlayer(playerid, 14861, 245.757, 302.234, 998.546, 0.250);
	RemoveBuildingForPlayer(playerid, 14862, 245.554, 300.859, 998.835, 0.250);
	RemoveBuildingForPlayer(playerid, 14860, 246.516, 301.585, 1000.000, 0.250);
	RemoveBuildingForPlayer(playerid, 2103, 248.406, 300.562, 999.304, 0.250);
	RemoveBuildingForPlayer(playerid, 1744, 250.102, 301.960, 999.453, 0.250);
	RemoveBuildingForPlayer(playerid, 1744, 250.102, 301.960, 1000.159, 0.250);
	RemoveBuildingForPlayer(playerid, 1740, 243.882, 301.976, 998.234, 0.250);
	RemoveBuildingForPlayer(playerid, 14864, 246.188, 303.109, 998.265, 0.250);
	RemoveBuildingForPlayer(playerid, 2091, 2819.800, -1165.660, 1028.160, 0.250);
	RemoveBuildingForPlayer(playerid, 2157, 2818.709, -1173.949, 1024.569, 0.250);
	RemoveBuildingForPlayer(playerid, 2046, 2819.449, -1174.000, 1026.359, 0.250);
	RemoveBuildingForPlayer(playerid, 2059, 2814.840, -1173.479, 1025.359, 0.250);
	RemoveBuildingForPlayer(playerid, 2047, 2817.310, -1170.969, 1031.170, 0.250);
	RemoveBuildingForPlayer(playerid, 2300, 2818.649, -1166.510, 1028.170, 0.250);
	RemoveBuildingForPlayer(playerid, 2069, 2806.389, -1166.819, 1024.630, 0.250);
	RemoveBuildingForPlayer(playerid, 2100, 2805.510, -1165.560, 1024.569, 0.250);
	RemoveBuildingForPlayer(playerid, 2068, 2809.199, -1169.369, 1027.530, 0.250);
	RemoveBuildingForPlayer(playerid, 2156, 2813.649, -1167.000, 1024.569, 0.250);
	RemoveBuildingForPlayer(playerid, 2160, 2815.899, -1164.910, 1024.560, 0.250);
	RemoveBuildingForPlayer(playerid, 2159, 2817.270, -1164.910, 1024.560, 0.250);
	RemoveBuildingForPlayer(playerid, 2157, 2818.639, -1164.910, 1024.560, 0.250);
	RemoveBuildingForPlayer(playerid, 2157, 2820.629, -1167.310, 1024.569, 0.250);
	RemoveBuildingForPlayer(playerid, 2116, 2814.300, -1173.420, 1024.550, 0.250);
	RemoveBuildingForPlayer(playerid, 2121, 2815.379, -1172.479, 1025.089, 0.250);
	RemoveBuildingForPlayer(playerid, 2121, 2813.949, -1172.459, 1025.089, 0.250);
	RemoveBuildingForPlayer(playerid, 1765, 2811.479, -1168.410, 1024.560, 0.250);
	RemoveBuildingForPlayer(playerid, 2053, 2810.610, -1167.579, 1024.630, 0.250);
	RemoveBuildingForPlayer(playerid, 2297, 2811.020, -1165.060, 1024.560, 0.250);
	RemoveBuildingForPlayer(playerid, 2058, 2809.639, -1165.339, 1024.579, 0.250);
	RemoveBuildingForPlayer(playerid, 1821, 2810.590, -1167.619, 1024.560, 0.250);
	RemoveBuildingForPlayer(playerid, 1764, 2808.659, -1166.949, 1024.569, 0.250);
	RemoveBuildingForPlayer(playerid, 2276, 2809.209, -1165.270, 1026.689, 0.250);
	RemoveBuildingForPlayer(playerid, 2272, 2811.340, -1165.270, 1026.790, 0.250);
	RemoveBuildingForPlayer(playerid, 2275, 2812.610, -1168.109, 1026.449, 0.250);
	RemoveBuildingForPlayer(playerid, 2060, 2810.020, -1171.229, 1024.699, 0.250);
	RemoveBuildingForPlayer(playerid, 1736, 2812.830, -1172.300, 1027.050, 0.250);
	RemoveBuildingForPlayer(playerid, 2051, 2813.129, -1171.290, 1026.339, 0.250);
	RemoveBuildingForPlayer(playerid, 2050, 2813.129, -1173.339, 1026.339, 0.250);
	RemoveBuildingForPlayer(playerid, 2064, 2810.840, -1171.900, 1025.199, 0.250);
	RemoveBuildingForPlayer(playerid, 2060, 2811.600, -1172.849, 1025.209, 0.250);
	RemoveBuildingForPlayer(playerid, 2060, 2811.600, -1172.849, 1025.050, 0.250);
	RemoveBuildingForPlayer(playerid, 2060, 2811.600, -1172.849, 1024.699, 0.250);
	RemoveBuildingForPlayer(playerid, 2060, 2811.600, -1172.849, 1024.880, 0.250);
	RemoveBuildingForPlayer(playerid, 2060, 2810.300, -1172.849, 1025.209, 0.250);
	RemoveBuildingForPlayer(playerid, 2060, 2810.300, -1172.849, 1025.050, 0.250);
	RemoveBuildingForPlayer(playerid, 2060, 2810.300, -1172.849, 1024.880, 0.250);
	RemoveBuildingForPlayer(playerid, 2060, 2810.300, -1172.849, 1024.699, 0.250);
	RemoveBuildingForPlayer(playerid, 2046, 2806.229, -1174.569, 1026.359, 0.250);
	RemoveBuildingForPlayer(playerid, 2049, 2805.209, -1173.489, 1026.520, 0.250);
	RemoveBuildingForPlayer(playerid, 2241, 2805.689, -1173.520, 1025.069, 0.250);
	RemoveBuildingForPlayer(playerid, 2048, 2805.209, -1172.050, 1026.890, 0.250);
	RemoveBuildingForPlayer(playerid, 2055, 2805.199, -1170.540, 1026.510, 0.250);
	RemoveBuildingForPlayer(playerid, 2255, 2814.570, -1169.290, 1029.910, 0.250);
	RemoveBuildingForPlayer(playerid, 1755, 2325.270, -1025.060, 1049.140, 0.250);
	RemoveBuildingForPlayer(playerid, 2112, 2322.659, -1026.420, 1049.589, 0.250);
	RemoveBuildingForPlayer(playerid, 2241, 2322.449, -1026.449, 1050.500, 0.250);
	RemoveBuildingForPlayer(playerid, 2105, 2323.020, -1026.859, 1050.449, 0.250);
	RemoveBuildingForPlayer(playerid, 1760, 2327.800, -1021.030, 1049.199, 0.250);
	RemoveBuildingForPlayer(playerid, 2117, 2329.699, -1022.590, 1049.199, 0.250);
	RemoveBuildingForPlayer(playerid, 1739, 2329.050, -1022.700, 1050.109, 0.250);
	RemoveBuildingForPlayer(playerid, 1739, 2328.840, -1023.599, 1050.109, 0.250);
	RemoveBuildingForPlayer(playerid, 2868, 2329.770, -1023.020, 1050.000, 0.250);
	RemoveBuildingForPlayer(playerid, 2829, 2329.469, -1023.630, 1050.010, 0.250);
	RemoveBuildingForPlayer(playerid, 1739, 2330.370, -1022.690, 1050.109, 0.250);
	RemoveBuildingForPlayer(playerid, 1739, 2330.370, -1023.520, 1050.109, 0.250);
	RemoveBuildingForPlayer(playerid, 2243, 2329.300, -1018.030, 1049.400, 0.250);
	RemoveBuildingForPlayer(playerid, 2295, 2328.790, -1015.830, 1049.199, 0.250);
	RemoveBuildingForPlayer(playerid, 2229, 2329.070, -1017.280, 1049.199, 0.250);
	RemoveBuildingForPlayer(playerid, 2104, 2327.169, -1017.210, 1049.209, 0.250);
	RemoveBuildingForPlayer(playerid, 2229, 2325.639, -1017.280, 1049.199, 0.250);
	RemoveBuildingForPlayer(playerid, 2224, 2322.699, -1019.090, 1049.199, 0.250);
	RemoveBuildingForPlayer(playerid, 2242, 2321.459, -1019.750, 1049.369, 0.250);
	RemoveBuildingForPlayer(playerid, 2244, 2322.360, -1019.890, 1049.479, 0.250);
	RemoveBuildingForPlayer(playerid, 2078, 2318.260, -1017.599, 1049.199, 0.250);
	RemoveBuildingForPlayer(playerid, 2291, 2323.790, -1009.590, 1049.209, 0.250);
	RemoveBuildingForPlayer(playerid, 2291, 2324.780, -1009.590, 1049.209, 0.250);
	RemoveBuildingForPlayer(playerid, 2291, 2325.780, -1009.590, 1049.209, 0.250);
	RemoveBuildingForPlayer(playerid, 2291, 2326.770, -1009.590, 1049.209, 0.250);
	RemoveBuildingForPlayer(playerid, 2291, 2327.760, -1009.590, 1049.209, 0.250);
	RemoveBuildingForPlayer(playerid, 2291, 2329.189, -1010.020, 1049.209, 0.250);
	RemoveBuildingForPlayer(playerid, 2291, 2329.189, -1011.010, 1049.209, 0.250);
	RemoveBuildingForPlayer(playerid, 2291, 2329.189, -1011.989, 1049.209, 0.250);
	RemoveBuildingForPlayer(playerid, 1822, 2326.629, -1012.219, 1049.209, 0.250);
	RemoveBuildingForPlayer(playerid, 1822, 2324.340, -1012.219, 1049.209, 0.250);
	RemoveBuildingForPlayer(playerid, 2107, 2326.070, -1016.669, 1050.660, 0.250);
	RemoveBuildingForPlayer(playerid, 2261, 2322.459, -1015.429, 1051.160, 0.250);
	RemoveBuildingForPlayer(playerid, 2281, 2324.310, -1017.799, 1051.229, 0.250);
	RemoveBuildingForPlayer(playerid, 2285, 2328.979, -1007.640, 1051.229, 0.250);
	RemoveBuildingForPlayer(playerid, 1735, 2318.800, -1007.969, 1049.199, 0.250);
	RemoveBuildingForPlayer(playerid, 2139, 2317.340, -1009.590, 1049.199, 0.250);
	RemoveBuildingForPlayer(playerid, 2139, 2317.340, -1007.609, 1049.199, 0.250);
	RemoveBuildingForPlayer(playerid, 2139, 2317.340, -1008.599, 1049.199, 0.250);
	RemoveBuildingForPlayer(playerid, 2305, 2312.370, -1007.630, 1049.199, 0.250);
	RemoveBuildingForPlayer(playerid, 2135, 2313.340, -1007.630, 1049.199, 0.250);
	RemoveBuildingForPlayer(playerid, 2138, 2314.330, -1007.630, 1049.199, 0.250);
	RemoveBuildingForPlayer(playerid, 2138, 2312.370, -1008.609, 1049.199, 0.250);
	RemoveBuildingForPlayer(playerid, 2831, 2312.189, -1010.659, 1050.270, 0.250);
	RemoveBuildingForPlayer(playerid, 2136, 2312.360, -1010.609, 1049.199, 0.250);
	RemoveBuildingForPlayer(playerid, 2830, 2312.139, -1013.669, 1050.260, 0.250);
	RemoveBuildingForPlayer(playerid, 2203, 2312.159, -1014.549, 1050.420, 0.250);
	RemoveBuildingForPlayer(playerid, 2139, 2312.379, -1014.549, 1049.199, 0.250);
	RemoveBuildingForPlayer(playerid, 2139, 2312.379, -1013.559, 1049.199, 0.250);
	RemoveBuildingForPlayer(playerid, 2139, 2312.379, -1012.570, 1049.199, 0.250);
	RemoveBuildingForPlayer(playerid, 2303, 2312.360, -1011.590, 1049.199, 0.250);
	RemoveBuildingForPlayer(playerid, 2079, 2313.889, -1011.580, 1049.839, 0.250);
	RemoveBuildingForPlayer(playerid, 2079, 2313.889, -1010.539, 1049.839, 0.250);
	RemoveBuildingForPlayer(playerid, 2832, 2315.050, -1011.280, 1050.000, 0.250);
	RemoveBuildingForPlayer(playerid, 2079, 2314.979, -1009.299, 1049.839, 0.250);
	RemoveBuildingForPlayer(playerid, 2079, 2315.929, -1010.549, 1049.839, 0.250);
	RemoveBuildingForPlayer(playerid, 2079, 2315.929, -1011.590, 1049.839, 0.250);
	RemoveBuildingForPlayer(playerid, 2115, 2314.989, -1011.409, 1049.199, 0.250);
	RemoveBuildingForPlayer(playerid, 2079, 2314.979, -1012.679, 1049.839, 0.250);
	RemoveBuildingForPlayer(playerid, 2165, 2323.379, -1015.900, 1053.699, 0.250);
	RemoveBuildingForPlayer(playerid, 1714, 2323.750, -1014.859, 1053.709, 0.250);
	RemoveBuildingForPlayer(playerid, 2088, 2325.530, -1015.090, 1053.699, 0.250);
	RemoveBuildingForPlayer(playerid, 2088, 2327.479, -1015.090, 1053.699, 0.250);
	RemoveBuildingForPlayer(playerid, 2295, 2329.260, -1015.830, 1053.790, 0.250);
	RemoveBuildingForPlayer(playerid, 2096, 2330.229, -1012.969, 1053.709, 0.250);
	RemoveBuildingForPlayer(playerid, 2240, 2330.739, -1010.780, 1054.260, 0.250);
	RemoveBuildingForPlayer(playerid, 2096, 2330.229, -1009.190, 1053.709, 0.250);
	RemoveBuildingForPlayer(playerid, 2106, 2327.729, -1006.950, 1054.229, 0.250);
	RemoveBuildingForPlayer(playerid, 2106, 2325.040, -1006.950, 1054.229, 0.250);
	RemoveBuildingForPlayer(playerid, 2298, 2325.060, -1010.719, 1053.699, 0.250);
	RemoveBuildingForPlayer(playerid, 2331, 2323.449, -1009.280, 1053.949, 0.250);
	RemoveBuildingForPlayer(playerid, 2333, 2323.489, -1009.729, 1053.699, 0.250);
	RemoveBuildingForPlayer(playerid, 1502, 2317.050, -1006.700, 1053.699, 0.250);
	RemoveBuildingForPlayer(playerid, 2194, 2322.360, -1008.450, 1054.949, 0.250);
	RemoveBuildingForPlayer(playerid, 2526, 2318.379, -1003.070, 1053.739, 0.250);
	RemoveBuildingForPlayer(playerid, 2523, 2322.250, -1003.070, 1053.719, 0.250);
	RemoveBuildingForPlayer(playerid, 2528, 2321.270, -1006.030, 1053.729, 0.250);
	RemoveBuildingForPlayer(playerid, 2249, 2323.020, -1005.880, 1054.400, 0.250);
	RemoveBuildingForPlayer(playerid, 1567, 2315.760, -1011.520, 1053.709, 0.250);
}
stock FormatText(text[])
{
	new len = strlen(text);
	if(len > 1)
	{
		for(new i = 0; i < len; i++)
		{
			if(text[i] == 92)
			{
				// New line
			    if(text[i+1] == 'n')
			    {
					text[i] = '\n';
					for(new j = i+1; j < len; j++) text[j] = text[j+1], text[j+1] = 0;
					continue;
			    }

				// Tab
			    if(text[i+1] == 't')
			    {
					text[i] = '\t';
					for(new j = i+1; j < len-1; j++) text[j] = text[j+1], text[j+1] = 0;
					continue;
			    }

				// Literal
			    if(text[i+1] == 92)
			    {
					text[i] = 92;
					for(new j = i+1; j < len-1; j++) text[j] = text[j+1], text[j+1] = 0;
			    }
			}
		}
	}
	return 1;
}

stock PlayReloadAnimation(playerid, weaponid)
{
	switch (weaponid)
	{
	    case 22: ApplyAnimation(playerid, "COLT45", "colt45_reload", 4.0, 0, 0, 0, 0, 0);
		case 23: ApplyAnimation(playerid, "SILENCED", "Silence_reload", 4.0, 0, 0, 0, 0, 0);
		case 24: ApplyAnimation(playerid, "PYTHON", "python_reload", 4.0, 0, 0, 0, 0, 0);
		case 25, 27: ApplyAnimation(playerid, "BUDDY", "buddy_reload", 4.0, 0, 0, 0, 0, 0);
		case 26: ApplyAnimation(playerid, "COLT45", "sawnoff_reload", 4.0, 0, 0, 0, 0, 0);
		case 29..31, 33, 34: ApplyAnimation(playerid, "RIFLE", "rifle_load", 4.0, 0, 0, 0, 0, 0);
		case 28, 32: ApplyAnimation(playerid, "TEC", "tec_reload", 4.0, 0, 0, 0, 0, 0);
	}
	return 1;
}

stock IsWindowedVehicle(vehicleid)
{
	new const g_aWindowStatus[] = {
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 1, 1,
	    1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1,
	    1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0,
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1,
		1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1,
		1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0
	};
	new modelid = GetVehicleModel(vehicleid);

    if (modelid < 400 || modelid > 611)
        return 0;

    return (g_aWindowStatus[modelid - 400]);
}


stock SendVehicleMessage(vehicleid, color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 12)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 12); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string
		#emit PUSH.C args

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

		foreach (new i : Player) if (GetPlayerVehicleID(i) == vehicleid) {
		    SendClientMessage(i, color, string);
		}
		return 1;
	}
	foreach (new i : Player) if (GetPlayerVehicleID(i) == vehicleid)
	{
 		SendClientMessage(i, color, string);
	}
	return 1;
}


stock DragCheck(playerid)
{
	new targetid = IsDragging[playerid];
	if(targetid != INVALID_PLAYER_ID)
	{
		TogglePlayerControllable(targetid, 1);
	}
	return 1;
}
stock RemoveDrag(playerid)
{
	foreach(new i : Player) if(IsDragging[i] == playerid)
	{
		IsDragging[i] = INVALID_PLAYER_ID;
	}
	return 1;
}

FUNC::LoginTime(playerid)
{
	Kick(playerid);
	return 1;
}
stock GetNameFromSQLID(sqlid)
{
	new query[128], Cache:execute, name[24];
	mysql_format(sqlcon, query, sizeof(query), "SELECT * FROM `characters` WHERE `pID` = '%d' LIMIT 1", sqlid);
	execute = mysql_query(sqlcon, query, true);
	if(cache_num_rows())
	{
		cache_get_value_name(0, "Name", name, 24);
	}
	cache_delete(execute);
	return name;
}

FUNC::HidePlayerBox(playerid, PlayerText:boxid)
{
	if (!IsPlayerConnected(playerid))
	    return 0;

	PlayerTextDrawHide(playerid, boxid);
	PlayerTextDrawDestroy(playerid, boxid);
	return 1;
}

stock PlayerText:ShowPlayerBox(playerid, color)
{
	new
	    PlayerText:textid;

    textid = CreatePlayerTextDraw(playerid, 0.000000, 0.000000, "_");
	PlayerTextDrawFont(playerid, textid, 1);
	PlayerTextDrawLetterSize(playerid, textid, 0.500000, 50.000000);
	PlayerTextDrawColor(playerid, textid, -1);
	PlayerTextDrawUseBox(playerid, textid, 1);
	PlayerTextDrawBoxColor(playerid, textid, color);
	PlayerTextDrawTextSize(playerid, textid, 640.000000, 30.000000);
	PlayerTextDrawShow(playerid, textid);
	return textid;
}

FUNC::StopChatting(playerid)
{
    ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);
}

stock IsABoat(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 430, 446, 452, 453, 454, 472, 473, 484, 493, 595: return 1;
	}
	return 0;
}

stock SetPlayerCurrentPos(playerid)
{
	new Float:x, Float:y, Float:z, Float:a;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, a);

	SetPlayerPos(playerid, x, y, z);
	SetPlayerFacingAngle(playerid, a);
	return 1;
}

stock GetLightStatus(vehicleid)
{
	static
	engine,
	lights,
	alarm,
	doors,
	bonnet,
	boot,
	objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if(lights != 1)
		return 0;

	return 1;
}

stock VariableConfig()
{
	ToggleData[togOOC] = true;
}

stock SendSplitMessage(playerid, color, msg[])
{
	if(strlen(msg) > 64)
	{
		SendClientMessageEx(playerid, color, "%.64s", msg);
		SendClientMessageEx(playerid, color, "...%s", msg[64]);
	}
	else
	{
		SendClientMessage(playerid, color, msg);
	}
	return 1;
}

stock IsDoorVehicle(vehicleid)
{
	switch (GetVehicleModel(vehicleid))
	{
		case 400..424, 426..429, 431..440, 442..445, 451, 455, 456, 458, 459, 466, 467, 470, 474, 475:
		    return 1;

		case 477..480, 482, 483, 486, 489, 490..492, 494..496, 498..500, 502..508, 514..518, 524..529, 533..536:
		    return 1;

		case 540..547, 549..552, 554..562, 565..568, 573, 575, 576, 578..580, 582, 585, 587..589, 596..605, 609:
			return 1;
	}
	return 0;
}

stock GetVehicleMaxSeats(vehicleid)
{
    new const g_arrMaxSeats[] = {
		4, 2, 2, 2, 4, 4, 1, 2, 2, 4, 2, 2, 2, 4, 2, 2, 4, 2, 4, 2, 4, 4, 2, 2, 2, 1, 4, 4, 4, 2,
		1, 7, 1, 2, 2, 0, 2, 7, 4, 2, 4, 1, 2, 2, 2, 4, 1, 2, 1, 0, 0, 2, 1, 1, 1, 2, 2, 2, 4, 4,
		2, 2, 2, 2, 1, 1, 4, 4, 2, 2, 4, 2, 1, 1, 2, 2, 1, 2, 2, 4, 2, 1, 4, 3, 1, 1, 1, 4, 2, 2,
		4, 2, 4, 1, 2, 2, 2, 4, 4, 2, 2, 1, 2, 2, 2, 2, 2, 4, 2, 1, 1, 2, 1, 1, 2, 2, 4, 2, 2, 1,
		1, 2, 2, 2, 2, 2, 2, 2, 2, 4, 1, 1, 1, 2, 2, 2, 2, 7, 7, 1, 4, 2, 2, 2, 2, 2, 4, 4, 2, 2,
		4, 4, 2, 1, 2, 2, 2, 2, 2, 2, 4, 4, 2, 2, 1, 2, 4, 4, 1, 0, 0, 1, 1, 2, 1, 2, 2, 1, 2, 4,
		4, 2, 4, 1, 0, 4, 2, 2, 2, 2, 0, 0, 7, 2, 2, 1, 4, 4, 4, 2, 2, 2, 2, 2, 4, 2, 0, 0, 0, 4,
		0, 0
	};
	new
	    model = GetVehicleModel(vehicleid);

	if (400 <= model <= 611)
	    return g_arrMaxSeats[model - 400];

	return 0;
}


stock IsVehicleSeatUsed(vehicleid, seat)
{
	foreach (new i : Player) if (IsPlayerInVehicle(i, vehicleid) && GetPlayerVehicleSeat(i) == seat) {
	    return 1;
	}
	return 0;
}

stock GetAvailableSeat(vehicleid, start = 1)
{
	new seats = GetVehicleMaxSeats(vehicleid);

	for (new i = start; i < seats; i ++) if (!IsVehicleSeatUsed(vehicleid, i)) {
	    return i;
	}
	return -1;
}

stock ReturnHealth(playerid)
{
	new Float:hp;
	GetPlayerHealth(playerid, hp);
	return floatround(hp);
}

stock SetPlayerFace(playerid, Float:X, Float:Y)
{
	new Float:pX, Float:pY, Float:pZ, Float:ang;
	GetPlayerPos(playerid, pX, pY, pZ);

	if(Y > pY) ang = (-acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);
	else if(Y < pY && X < pX) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 450.0);
	else if(Y < pY) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);

	if(X > pX) ang = (floatabs(floatabs(ang) + 180.0));
	else ang = (floatabs(ang) - 180.0);

	SetPlayerFacingAngle(playerid, ang);
	return false;
}

stock SetPlayerToFacePlayer(playerid, targetid)
{
	if(!IsPlayerConnected(playerid) || !IsPlayerConnected(targetid)) return false;

	new Float:pX, Float:pY, Float:pZ, Float:X, Float:Y, Float:Z, Float:ang;
	GetPlayerPos(targetid, X, Y, Z);
	GetPlayerPos(playerid, pX, pY, pZ);

	if(Y > pY) ang = (-acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);
	else if(Y < pY && X < pX) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 450.0);
	else if(Y < pY) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);

	if(X > pX) ang = (floatabs(floatabs(ang) + 180.0));
	else ang = (floatabs(ang) - 180.0);

	SetPlayerFacingAngle(playerid, ang);
	return false;
}

stock RV_GetBodyPartName(num)
{
	new str[56];
	switch(num)
	{
		case 0: str = "Head";
		case 1: str = "Torso";
		case 2: str = "Right Arm";
		case 3: str = "Left Arm";
		case 4: str = "Groin";
		case 5: str = "Right Leg";
		case 6: str = "Left Left";
	}
	return str;
}

Float:DistanceCameraTargetToLocation(Float:CamX, Float:CamY, Float:CamZ, Float:ObjX, Float:ObjY, Float:ObjZ, Float:FrX, Float:FrY, Float:FrZ)
{
        new Float:TGTDistance;

        TGTDistance = floatsqroot((CamX - ObjX) * (CamX - ObjX) + (CamY - ObjY) * (CamY - ObjY) + (CamZ - ObjZ) * (CamZ - ObjZ));

        new Float:tmpX, Float:tmpY, Float:tmpZ;

        tmpX = FrX * TGTDistance + CamX;
        tmpY = FrY * TGTDistance + CamY;
        tmpZ = FrZ * TGTDistance + CamZ;

        return floatsqroot((tmpX - ObjX) * (tmpX - ObjX) + (tmpY - ObjY) * (tmpY - ObjY) + (tmpZ - ObjZ) * (tmpZ - ObjZ));
}

FUNC::WeatherRotator()
{
	new index = random(sizeof(g_aWeatherRotations));

	SetWeather(g_aWeatherRotations[index]);
}


stock TimestampToDate(Timestamp, &year, &month, &day, &hour, &minute, &second, HourGMT = 7, MinuteGMT = 0)
{
	new tmp = 2;
	year = 1970;
	month = 1;
	Timestamp -= 172800; // Delete two days from the current timestamp. This is necessary, because the timestamp retrieved using gettime() includes two too many days.
	for(;;)
	{
		if(Timestamp >= 31536000)
		{
			year ++;
			Timestamp -= 31536000;
			tmp ++;
			if(tmp == 4)
			{
				if(Timestamp >= 31622400)
				{
					tmp = 0;
					year ++;
					Timestamp -= 31622400;
				}
				else break;
			}
		}
		else break;
	}		
	for(new i = 0; i < 12; i ++)
	{
		if(Timestamp >= MonthTimes[i][2 + IsLeapYear(year)])
		{
			month ++;
			Timestamp -= MonthTimes[i][2 + IsLeapYear(year)];
		}
		else break;
	}
	day = Timestamp / 86400;
	Timestamp %= 86400;
	hour = HourGMT + (Timestamp / 3600);
	Timestamp %= 3600;
	minute = MinuteGMT + (Timestamp / 60);
	second = (Timestamp % 60);
	if(minute > 59)
	{
		minute = 0;
		hour ++;
	}
	if(hour > 23)
	{
		hour -= 24;
		day ++;
	}	
	if(day > MonthTimes[month][IsLeapYear(year)])
	{
		day = 1;
		month ++;
	}
	if(month > 12)
	{
		month = 1;
		year ++;
	}
	return 1;
}

stock IsLeapYear(year)
{
	if(year % 4 == 0) return true;
	else return false;
}

stock PlayerPlayNearbySound(playerid, soundid)
{
	new Float:plPos[3];
	GetPlayerPos(playerid, plPos[0], plPos[1], plPos[2]);
	foreach(new p: Player)
	{
		if(IsPlayerInRangeOfPoint(p, 5.0, plPos[0], plPos[1], plPos[2]))
		{
			PlayerPlaySound(p, soundid, plPos[0], plPos[1], plPos[2]);
		}
	}
	return true;
}

stock SendClientMessageToAllEx(color, const text[], {Float, _}:...)
{
	static
	    args,
	    str[144];

	/*
     *  Custom function that uses #emit to format variables into a string.
     *  This code is very fragile; touching any code here will cause crashing!
	*/
	if ((args = numargs()) == 2)
	{
	    SendClientMessageToAll(color, text);
	}
	else
	{
		while (--args >= 2)
		{
			#emit LCTRL 5
			#emit LOAD.alt args
			#emit SHL.C.alt 2
			#emit ADD.C 12
			#emit ADD
			#emit LOAD.I
			#emit PUSH.pri
		}
		#emit PUSH.S text
		#emit PUSH.C 144
		#emit PUSH.C str
		#emit LOAD.S.pri 8
		#emit ADD.C 4
		#emit PUSH.pri
		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

		SendClientMessageToAll(color, str);

		#emit RETN
	}
	return 1;
}

stock ReturnDate()
{
	static
	    date[36];

	getdate(date[2], date[1], date[0]);
	gettime(date[3], date[4], date[5]);

	format(date, sizeof(date), "%02d/%02d/%d, %02d:%02d", date[0], date[1], date[2], date[3], date[4]);
	return date;
}

stock GetDuration(time)
{
	new
	    str[32];

	if (time < 0 || time == gettime()) {
	    format(str, sizeof(str), "Never");
	    return str;
	}
	else if (time < 60)
		format(str, sizeof(str), "%d seconds", time);

	else if (time >= 0 && time < 60)
		format(str, sizeof(str), "%d seconds", time);

	else if (time >= 60 && time < 3600)
		format(str, sizeof(str), (time >= 120) ? ("%d minutes") : ("%d minute"), time / 60);

	else if (time >= 3600 && time < 86400)
		format(str, sizeof(str), (time >= 7200) ? ("%d hours") : ("%d hour"), time / 3600);

	else if (time >= 86400 && time < 2592000)
 		format(str, sizeof(str), (time >= 172800) ? ("%d days") : ("%d day"), time / 86400);

	else if (time >= 2592000 && time < 31536000)
 		format(str, sizeof(str), (time >= 5184000) ? ("%d months") : ("%d month"), time / 2592000);

	else if (time >= 31536000)
		format(str, sizeof(str), (time >= 63072000) ? ("%d years") : ("%d year"), time / 31536000);

	strcat(str, " ago");

	return str;
}

stock Log_Write(const path[], const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    File:file,
	    string[1024]
	;
	if ((start = strfind(path, "/")) != -1) {
	    strmid(string, path, 0, start + 1);

	    if (!fexist(string))
	        return printf("* Warning: Directory \"%s\" doesn't exist.", string);
	}
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	file = fopen(path, io_append);

	if (!file)
	    return 0;

	if (args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 1024
		#emit PUSH.C string
		#emit PUSH.C args
		#emit SYSREQ.C format

		fwrite(file, string);
		fwrite(file, "\r\n");
		fclose(file);

		#emit LCTRL 5
		#emit SCTRL 4
		#emit RETN
	}
	fwrite(file, str);
	fwrite(file, "\r\n");
	fclose(file);

	return 1;
}

FUNC::splits(const strsrc[], strdest[][], delimiter)
{
	new i, li;
	new aNum;
	new len;
	while(i <= strlen(strsrc)){
		if(strsrc[i]==delimiter || i==strlen(strsrc)){
			len = strmid(strdest[aNum], strsrc, li, i, 128);
			strdest[aNum][len] = 0;
			li = i+1;
			aNum++;
		}
		i++;
	}
	return 1;
}
Float:GetPointAngleToPoint(Float:x2, Float:y2, Float:X, Float:Y)
{

  new Float:DX, Float:DY;
  new Float:angle;

  DX = floatabs(floatsub(x2,X));
  DY = floatabs(floatsub(y2,Y));

  if (DY == 0.0 || DX == 0.0)
  {
    if(DY == 0 && DX > 0) angle = 0.0;
    else if(DY == 0 && DX < 0) angle = 180.0;
    else if(DY > 0 && DX == 0) angle = 90.0;
    else if(DY < 0 && DX == 0) angle = 270.0;
    else if(DY == 0 && DX == 0) angle = 0.0;
  }
  else
  {
    angle = atan(DX/DY);

    if(X > x2 && Y <= y2) angle += 90.0;
    else if(X <= x2 && Y < y2) angle = floatsub(90.0, angle);
    else if(X < x2 && Y >= y2) angle -= 90.0;
    else if(X >= x2 && Y > y2) angle = floatsub(270.0, angle);
  }
  return floatadd(angle, 90.0);
}

stock GetXYInFrontOfPoint(&Float:x, &Float:y, Float:angle, Float:distance)
{
        x += (distance * floatsin(-angle, degrees));
        y += (distance * floatcos(-angle, degrees));
}

stock IsPlayerAimingAt(playerid, Float:x, Float:y, Float:z, Float:radius)
{
    new Float:camera_x,Float:camera_y,Float:camera_z,Float:vector_x,Float:vector_y,Float:vector_z;
    GetPlayerCameraPos(playerid, camera_x, camera_y, camera_z);
    GetPlayerCameraFrontVector(playerid, vector_x, vector_y, vector_z);

    new Float:vertical, Float:horizontal;

    switch (GetPlayerWeapon(playerid))
    {
        case 34,35,36: {
        if (DistanceCameraTargetToLocation(camera_x, camera_y, camera_z, x, y, z, vector_x, vector_y, vector_z) < radius) return true;
        return false;
        }
        case 30,31: {vertical = 4.0; horizontal = -1.6;}
        case 33: {vertical = 2.7; horizontal = -1.0;}
        default: {vertical = 6.0; horizontal = -2.2;}
    }

    new Float:angle = GetPointAngleToPoint(0, 0, floatsqroot(vector_x*vector_x+vector_y*vector_y), vector_z) - 270.0;
    new Float:resize_x, Float:resize_y, Float:resize_z = floatsin(angle+vertical, degrees);
    GetXYInFrontOfPoint(resize_x, resize_y, GetPointAngleToPoint(0, 0, vector_x, vector_y)+horizontal, floatcos(angle+vertical, degrees));

    if (DistanceCameraTargetToLocation(camera_x, camera_y, camera_z, x, y, z, resize_x, resize_y, resize_z) < radius) return true;
    return false;
}

stock UpdateTime(playerid)
{
	new hour, minute, second;
	gettime(hour, minute, second);
	PlayerTextDrawSetString(playerid, TIMETD[playerid], sprintf("%02d:%02d:%02d", hour, minute, second));
}

stock GetFullDate()
{
	new date[56], year, month, day, hour, minute, second;

	getdate(year, month, day);
	gettime(hour, minute, second);
	format(date, sizeof(date), "%02d/%02d/%i, %02d:%02d:%02d", day, month, year, hour, minute, second);
	return date;
}

stock IsValidObjectModel(modelid)
{
	if (modelid < 0 || modelid > 20000)
	    return 0;

    switch (modelid)
	{
		case 18632..18645, 18646..18658, 18659..18667, 18668..19299, 19301..19515, 18631, 331, 333..339, 318..321, 325, 326, 341..344, 346..353, 355..370, 372:
			return 1;
	}
    new const g_arrModelData[] =
	{
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -128,
        -515899393, -134217729, -1, -1, 33554431, -1, -1, -1, -14337, -1, -33,
      	127, 0, 0, 0, 0, 0, -8388608, -1, -1, -1, -16385, -1, -1, -1, -1, -1,
       -1, -1, -33, -1, -771751937, -1, -9, -1, -1, -1, -1, -1, -1, -1, -1, -1,
       -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
       -1, -1, -1, -1, -1, -1, -1, -1, 33554431, -25, -1, -1, -1, -1, -1, -1,
       -1073676289, -2147483648, 34079999, 2113536, -4825600, -5, -1, -3145729,
       -1, -16777217, -63, -1, -1, -1, -1, -201326593, -1, -1, -1, -1, -1,
       -257, -1, 1073741823, -133122, -1, -1, -65, -1, -1, -1, -1, -1, -1,
       -2146435073, -1, -1, -1, -1, -1, -1, -1, -1, -1, 1073741823, -64, -1,
       -1, -1, -1, -2635777, 134086663, 0, -64, -1, -1, -1, -1, -1, -1, -1,
       -536870927, -131069, -1, -1, -1, -1, -1, -1, -1, -1, -16384, -1,
       -33554433, -1, -1, -1, -1, -1, -1610612737, 524285, -128, -1,
       2080309247, -1, -1, -1114113, -1, -1, -1, 66977343, -524288, -1, -1, -1,
       -1, -2031617, -1, 114687, -256, -1, -4097, -1, -4097, -1, -1,
       1010827263, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -32768, -1, -1, -1, -1, -1,
       2147483647, -33554434, -1, -1, -49153, -1148191169, 2147483647,
       -100781080, -262145, -57, 134217727, -8388608, -1, -1, -1, -1, -1, -1,
       -1, -1, -1, -1, -1, -1, -1, -1, -1048577, -1, -449, -1017, -1, -1, -1,
       -1, -1, -1, -1, -1, -1, -1, -1, -1835009, -2049, -1, -1, -1, -1, -1, -1,
       -8193, -1, -536870913, -1, -1, -1, -1, -1, -87041, -1, -1, -1, -1, -1,
       -1, -209860, -1023, -8388609, -2096897, -1, -1048577, -1, -1, -1, -1,
       -1, -1, -897, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1610612737,
       -3073, -28673, -1, -1, -1, -1537, -1, -1, -13, -1, -1, -1, -1, -1985,
       -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1056964609, -1, -1, -1,
       -1, -1, -1, -1, -2, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
       -236716037, -1, -1, -1, -1, -1, -1, -1, -536870913, 3, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
       -1, -1, -1, -1, -1, -2097153, -2109441, -1, 201326591, -4194304, -1, -1,
       -241, -1, -1, -1, -1, -1, -1, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, -32768, -1, -1, -1, -2, -671096835, -1, -8388609, -66323585, -13,
       -1793, -32257, -247809, -1, -1, -513, 16252911, 0, 0, 0, -131072,
       33554383, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
       -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 8356095, 0, 0, 0, 0, 0,
       0, -256, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
       -268435449, -1, -1, -2049, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
       92274627, -65536, -2097153, -268435457, 591191935, 1, 0, -16777216, -1,
       -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 127
	};
 	return ((modelid >= 0) && ((modelid / 32) < sizeof(g_arrModelData)) && (g_arrModelData[modelid / 32] & (1 << (modelid % 32))));
}

stock RemovePlayerADO(playerid)
{
	if(IsValidDynamic3DTextLabel(PlayerADO[playerid]))
		DestroyDynamic3DTextLabel(PlayerADO[playerid]);
	return 1;
}

stock RemoveVendingMachines(playerid)
{

	/* Vendings */
	RemoveBuildingForPlayer(playerid, 956, 1634.1487,-2238.2810,13.5077, 20.0); //Snack vender @ LS Airport
	RemoveBuildingForPlayer(playerid, 956, 2480.9885,-1958.5117,13.5831, 20.0); //Snack vender @ Sushi Shop in Willowfield
	RemoveBuildingForPlayer(playerid, 955, 1729.7935,-1944.0087,13.5682, 20.0); //Sprunk machine @ Unity Station
	RemoveBuildingForPlayer(playerid, 955, 2060.1099,-1898.4543,13.5538, 20.0); //Sprunk machine opposite Tony's Liqour in Willowfield
	RemoveBuildingForPlayer(playerid, 955, 2325.8708,-1645.9584,14.8270, 20.0); //Sprunk machine @ Ten Green Bottles
	RemoveBuildingForPlayer(playerid, 955, 1153.9130,-1460.8893,15.7969, 20.0); //Sprunk machine @ Market
	RemoveBuildingForPlayer(playerid, 955,1788.3965,-1369.2336,15.7578, 20.0); //Sprunk machine in Downtown Los Santos
	RemoveBuildingForPlayer(playerid, 955, 2352.9939,-1357.1105,24.3984, 20.0); //Sprunk machine @ Liquour shop in East Los Santos
	RemoveBuildingForPlayer(playerid, 1775, 2224.3235,-1153.0692,1025.7969, 20.0); //Sprunk machine @ Jefferson Motel
	RemoveBuildingForPlayer(playerid, 956, 2140.2566,-1161.7568,23.9922, 20.0); //Snack machine @ pick'n'go market in Jefferson
	RemoveBuildingForPlayer(playerid, 956, 2154.1199,-1015.7635,62.8840, 20.0); //Snach machine @ Carniceria El Pueblo in Las Colinas
	RemoveBuildingForPlayer(playerid, 956, 662.5665,-551.4142,16.3359, 20.0); //Snack vender at Dillimore Gas Station
	RemoveBuildingForPlayer(playerid, 955, 200.2010,-107.6401,1.5513, 20.0); //Sprunk machine @ Blueberry Safe House
	RemoveBuildingForPlayer(playerid, 956, 2271.4666,-77.2104,26.5824, 20.0); //Snack machine @ Palomino Creek Library
	RemoveBuildingForPlayer(playerid, 955, 1278.5421,372.1057,19.5547, 20.0); //Sprunk machine @ Papercuts in Montgomery
	RemoveBuildingForPlayer(playerid, 955, 1929.5527,-1772.3136,13.5469, 20.0); //Sprunk machine @ Idlewood Gas Station

	//San Fierro
	RemoveBuildingForPlayer(playerid, 1302, -2419.5835,984.4185,45.2969, 20.0); //Soda machine 1 @ Juniper Hollow Gas Station
	RemoveBuildingForPlayer(playerid, 1209, -2419.5835,984.4185,45.2969, 20.0); //Soda machine 2 @ Juniper Hollow Gas Station
	RemoveBuildingForPlayer(playerid, 956, -2229.2075,287.2937,35.3203, 20.0); //Snack vender @ King's Car Park
	RemoveBuildingForPlayer(playerid, 955, -1349.3947,493.1277,11.1953, 20.0); //Sprunk machine @ SF Aircraft Carrier
	RemoveBuildingForPlayer(playerid, 956, -1349.3947,493.1277,11.1953, 20.0); //Snack vender @ SF Aircraft Carrier
	RemoveBuildingForPlayer(playerid, 955, -1981.6029,142.7232,27.6875, 20.0); //Sprunk machine @ Cranberry Station
	RemoveBuildingForPlayer(playerid, 955, -2119.6245,-422.9411,35.5313, 20.0); //Sprunk machine 1/2 @ SF Stadium
	RemoveBuildingForPlayer(playerid, 955, -2097.3696,-397.5220,35.5313, 20.0); //Sprunk machine 3 @ SF Stadium
	RemoveBuildingForPlayer(playerid, 955, -2068.5593,-397.5223,35.5313, 20.0); //Sprunk machine 3 @ SF Stadium
	RemoveBuildingForPlayer(playerid, 955, -2039.8802,-397.5214,35.5313, 20.0); //Sprunk machine 3 @ SF Stadium
	RemoveBuildingForPlayer(playerid, 955, -2011.1403,-397.5225,35.5313, 20.0); //Sprunk machine 3 @ SF Stadium
	RemoveBuildingForPlayer(playerid, 955, -2005.7861,-490.8688,35.5313, 20.0); //Sprunk machine 3 @ SF Stadium
	RemoveBuildingForPlayer(playerid, 955, -2034.5267,-490.8681,35.5313, 20.0); //Sprunk machine 3 @ SF Stadium
	RemoveBuildingForPlayer(playerid, 955, -2063.1875,-490.8687,35.5313, 20.0); //Sprunk machine 3 @ SF Stadium
	RemoveBuildingForPlayer(playerid, 955, -2091.9780,-490.8684,35.5313, 20.0); //Sprunk machine 3 @ SF Stadium

	//Las Venturas
	RemoveBuildingForPlayer(playerid, 956, -1455.1298,2592.4138,55.8359, 20.0); //Snack vender @ El Quebrados GONE
	RemoveBuildingForPlayer(playerid, 955, -252.9574,2598.9048,62.8582, 20.0); //Sprunk machine @ Las Payasadas GONE
	RemoveBuildingForPlayer(playerid, 956, -252.9574,2598.9048,62.8582, 20.0); //Snack vender @ Las Payasadas GONE
	RemoveBuildingForPlayer(playerid, 956, 1398.7617,2223.3606,11.0234, 20.0); //Snack vender @ Redsands West GONE
	RemoveBuildingForPlayer(playerid, 955, -862.9229,1537.4246,22.5870, 20.0); //Sprunk machine @ The Smokin' Beef Grill in Las Barrancas GONE
	RemoveBuildingForPlayer(playerid, 955, -14.6146,1176.1738,19.5634, 20.0); //Sprunk machine @ Fort Carson GONE
	RemoveBuildingForPlayer(playerid, 956, -75.2839,1227.5978,19.7360, 20.0); //Snack vender @ Fort Carson GONE
	RemoveBuildingForPlayer(playerid, 955, 1519.3328,1055.2075,10.8203, 20.0); //Sprunk machine @ LVA Freight Department GONE
	RemoveBuildingForPlayer(playerid, 956, 1659.5096,1722.1096,10.8281, 20.0); //Snack vender near Binco @ LV Airport GONE
	RemoveBuildingForPlayer(playerid, 955, 2086.5872,2071.4958,11.0579, 20.0); //Sprunk machine @ Sex Shop on The Strip
	RemoveBuildingForPlayer(playerid, 955, 2319.9001,2532.0376,10.8203, 20.0); //Sprunk machine @ Pizza co by Julius Thruway (North)
	RemoveBuildingForPlayer(playerid, 955, 2503.2061,1244.5095,10.8203, 20.0); //Sprunk machine @ Club in the Camels Toe
	RemoveBuildingForPlayer(playerid, 956, 2845.9919,1294.2975,11.3906, 20.0); //Snack vender @ Linden Station

	//Interiors: 24/7 and Clubs
	RemoveBuildingForPlayer(playerid, 1775, 496.0843,-23.5310,1000.6797, 20.0); //Sprunk machine 1 @ Club in Camels Toe
	RemoveBuildingForPlayer(playerid, 1775, 501.1219,-2.1968,1000.6797, 20.0); //Sprunk machine 2 @ Club in Camels Toe
	RemoveBuildingForPlayer(playerid, 1776, 501.1219,-2.1968,1000.6797, 20.0); //Snack vender @ Club in Camels Toe
	RemoveBuildingForPlayer(playerid, 1775, -19.2299,-57.0460,1003.5469, 20.0); //Sprunk machine @ Roboi's type 24/7 stores
	RemoveBuildingForPlayer(playerid, 1776, -35.9012,-57.1345,1003.5469, 20.0); //Snack vender @ Roboi's type 24/7 stores
	RemoveBuildingForPlayer(playerid, 1775, -17.0036,-90.9709,1003.5469, 20.0); //Sprunk machine @ Other 24/7 stores
	RemoveBuildingForPlayer(playerid, 1776, -17.0036,-90.9709,1003.5469, 20.0); //Snach vender @ Others 24/7 stores
}
