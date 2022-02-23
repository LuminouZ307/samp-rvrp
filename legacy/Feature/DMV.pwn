new Float:DMVPoint[][] = 
{
	{1134.1816,-1676.4950,13.4070},
	{1152.5792,-1662.8425,13.4352},
	{1143.4576,-1569.8146,12.9235},
	{919.5980,-1569.9597,13.0394},
	{915.3822,-1392.9874,13.0022},
	{635.0762,-1390.6177,13.0391},
	{633.5551,-1216.3459,17.7617},
	{792.0850,-1055.1306,24.3173},
	{808.1508,-1327.7343,13.1483},
	{1055.9081,-1332.4580,13.0354},
	{1072.6074,-1407.6460,13.1839},
	{1340.0424,-1412.1584,13.0190},
	{1295.0867,-1633.2543,13.0370},
	{1288.4333,-1849.6576,13.0427},
	{1182.2166,-1803.3959,13.0526},
	{1180.1763,-1710.2159,13.1706},
	{1152.4880,-1696.8613,13.4333},
	{1134.4633,-1676.5829,13.4104}
};

stock CheckPlayerTest(playerid)
{
	if(PlayerData[playerid][pIndexTest] < 6)
	{
		SendClientMessageEx(playerid, COLOR_SERVER, "DMV: {FFFFFF}Kamu dinyatakan {FF0000}gagal {FFFFFF}dalam test teori");
		SendClientMessageEx(playerid, COLOR_SERVER, "DMV: {FFFFFF}Kamu hanya menjawab {FFFF00}%d {FFFFFF}pertanyaan benar dari {FFFF00}7 {FFFFFF}pertanyaan", PlayerData[playerid][pIndexTest]);
		PlayerData[playerid][pIndexTest] = 0;
		PlayerData[playerid][pOnTest] = false;
	}
	else
	{
		PlayerData[playerid][pVehicleDMV] = CreateVehicle(410,1134.4376,-1694.0143,13.4074,359.6444,2, 2, 60000, 0);
		VehCore[PlayerData[playerid][pVehicleDMV]][vehFuel] = 20;
		SetPlayerVirtualWorld(playerid, 0);
		PlayerData[playerid][pInDoor] = -1;
		SetPlayerInterior(playerid, 0);
		PutPlayerInVehicle(playerid, PlayerData[playerid][pVehicleDMV], 0);
		PlayerData[playerid][pOnDMV] = true;
		PlayerData[playerid][pIndexDMV] = 0;
		SetPlayerCheckpoint(playerid, DMVPoint[PlayerData[playerid][pIndexDMV]][0], DMVPoint[PlayerData[playerid][pIndexDMV]][1], DMVPoint[PlayerData[playerid][pIndexDMV]][2], 3.4);
		SendClientMessage(playerid, COLOR_SERVER, "DMV: {FFFFFF}Kamu dinyatakan {00FF00}lulus {FFFFFF}dalam test teori!");
		SendClientMessage(playerid, COLOR_SERVER, "DMV: {FFFFFF}Step selanjutnya adalah test mengemudi, silahkan ikuti semua Marker yang ada di radar!");
	}
	return 1;
}

CMD:drivingtest(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, -2032.6390,-117.4360,1035.1719))
		return SendErrorMessage(playerid, "You are not inside Departement of Motorvehicle!");

	if(PlayerData[playerid][pLicense][0])
		return SendErrorMessage(playerid, "You already have Driving License!");

	if(PlayerData[playerid][pOnTest])
		return SendErrorMessage(playerid, "Kamu sedang memulai Driving Test!");

	if(GetMoney(playerid) < 2500)
		return SendErrorMessage(playerid, "Kamu tidak memiliki cukup uang!");

	new str[412];
	strcat(str, "Selamat datang di Departement of Motorvehicle\n");
	strcat(str, "Silahkan perhatikan hal-hal dibawah ini:\n\n");
	strcat(str, "I. Sebelum melanjutkan ke test mengemudi, akan ada test teori terlebih dahulu.\n");
	strcat(str, "II. Tersedia 7 soal untuk dijawab dan minimal memperoleh 6 jawaban benar untuk ke step selanjutnya.\n");
	strcat(str, "III. Jika sengaja keluar pada saat test, maka akan dinyatakan GAGAL.\n\n");

	strcat(str, "Silahkan klik 'Next' untuk memulai test teori.");
	ShowPlayerDialog(playerid, DIALOG_TEST_MAIN, DIALOG_STYLE_MSGBOX, "Theory Test | DMV", str, "Next", "Close");
	return 1;
}
