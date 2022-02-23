stock LoadStaticVehicle()
{
	SweeperVehicle[0] = AddStaticVehicleEx(574,1825.6514,-1404.5709,13.1549,359.8893,1, 1, 60000);
	SweeperVehicle[1] = AddStaticVehicleEx(574,1828.3218,-1404.5905,13.1549,359.0922,1, 1, 60000);
	SweeperVehicle[2] = AddStaticVehicleEx(574,1830.9319,-1404.6415,13.1549,359.6531,1, 1, 60000);
	forex(i, sizeof(SweeperVehicle))
	{
		VehCore[SweeperVehicle[i]][vehFuel] = 100;
		SetVehicleNumberPlate(SweeperVehicle[i], "SWEEPER-LS");
	}
	BusVehicle[0] = AddStaticVehicleEx(431,1542.8407,-2214.0898,13.6496,179.7028,1, 1, 60000);
	BusVehicle[1] = AddStaticVehicleEx(431,1536.2914,-2213.9951,13.6526,180.4069,1, 1, 60000);
	BusVehicle[2] = AddStaticVehicleEx(431,1529.8724,-2214.1211,13.6533,180.5210,1, 1, 60000);
	forex(i, sizeof(BusVehicle))
	{
		VehCore[BusVehicle[i]][vehFuel] = 100;
		SetVehicleNumberPlate(BusVehicle[i], "BUS-LS");
	}
	SanNewsVehicles[1] = AddStaticVehicleEx(582, 740.8425, -1350.1150, 13.5608, 270.1750,6,6, 60000);
	SanNewsVehicles[2] = AddStaticVehicleEx(582, 740.8268, -1345.2783, 13.5731, 269.6423,6,6, 60000);
	SanNewsVehicles[3] = AddStaticVehicleEx(582, 740.8323, -1340.4932, 13.5844, 270.3435,6,6, 60000);
	SanNewsVehicles[4] = AddStaticVehicleEx(582, 740.8392, -1335.7560, 13.5946, 269.7987,6,6, 60000);
	SanNewsVehicles[5] = AddStaticVehicleEx(582, 740.9189, -1331.6019, 13.6048, 270.3356,6,6, 60000);
	SanNewsVehicles[6] = AddStaticVehicleEx(560, 771.8953, -1381.5955, 13.3783, 0.3974,6,6, 60000);
	SanNewsVehicles[7] = AddStaticVehicleEx(560, 767.8303, -1381.5265, 13.3720, 359.8817,6,6, 60000);
	SanNewsVehicles[8] = AddStaticVehicleEx(560, 763.7784, -1381.4996, 13.3698, 359.5485,6,6, 60000);
	SanNewsVehicles[9] = AddStaticVehicleEx(579, 759.6081, -1381.0505, 13.5876, 359.7089,6,6, 60000);
	SanNewsVehicles[10] = AddStaticVehicleEx(400, 760.6287, -1363.8038, 13.5953, 270.5869,6,6, 60000);
	SanNewsVehicles[11] = AddStaticVehicleEx(533, 760.8224, -1359.0710, 13.2543, 269.6531,6,6, 60000);
	SanNewsVehicles[12] = AddStaticVehicleEx(500, 760.1707, -1354.3617, 13.6252, 270.9430,6,6, 60000);
	SanNewsVehicles[13] = AddStaticVehicleEx(488,740.2965,-1374.4309,25.9422,269.1684,6,6, 60000);
	forex(i, sizeof(SanNewsVehicles))
	{
		VehCore[SanNewsVehicles[i]][vehFuel] = 100;
	}
	LSMDVehicles[0] = AddStaticVehicleEx(416,1178.3732,-1361.4330,14.4257,270.3365,1,3, 60000);	
	LSMDVehicles[1] = AddStaticVehicleEx(416,1177.7573,-1338.8455,14.0491,269.1903,1,3, 60000);
	forex(i, sizeof(LSMDVehicles))
	{
		VehCore[LSMDVehicles[i]][vehFuel] = 100;
	}
	LSPDVehicles[0] = AddStaticVehicleEx(596,1585.8813,-1667.5236,5.5589,268.9741,36,1, 60000); // Cruiser HC
	LSPDVehicles[1] = AddStaticVehicleEx(596,1585.6987,-1671.8832,5.5520,271.2573,15,1, 60000); // Cruiser Command Team
	LSPDVehicles[2] = AddStaticVehicleEx(596,1585.7786,-1675.9716,5.5531,270.9127,108,1, 60000); // Cruiser Supervisor 1
	LSPDVehicles[3] = AddStaticVehicleEx(596,1585.8177,-1679.6355,5.5674,270.8011,108,1, 60000); // Cruiser Supervisor 2
	LSPDVehicles[4] = AddStaticVehicleEx(596,1602.5104,-1684.0599,5.5721,91.0629,0,1, 60000); // Cruiser
	LSPDVehicles[5] = AddStaticVehicleEx(596,1602.5287,-1688.0629,5.5712,88.9105,0,1, 60000); // Cruiser
	LSPDVehicles[6] = AddStaticVehicleEx(596,1602.4117,-1692.0302,5.5735,88.5088,0,1, 60000); // Cruiser
	LSPDVehicles[7] = AddStaticVehicleEx(596,1602.4979,-1696.1620,5.5303,92.1094,0,1, 60000); // Cruiser
	LSPDVehicles[8] = AddStaticVehicleEx(596,1602.3427,-1700.1394,5.5328,89.7606,0,1, 60000); // Cruiser
	LSPDVehicles[9] = AddStaticVehicleEx(596,1602.3191,-1704.4431,5.5304,88.5293,0,1, 60000); // Cruiser
	LSPDVehicles[10] = AddStaticVehicleEx(599,1595.4366,-1711.3505,5.9677,0.7363,0,1, 60000); // Bear 1
	LSPDVehicles[11] = AddStaticVehicleEx(599,1591.4089,-1711.5291,5.9700,359.3976,0,1, 60000); // Bear 2
	LSPDVehicles[12] = AddStaticVehicleEx(525,1587.2430,-1711.1858,5.7928,1.0158,0,0, 60000, 1); // TEU 1
	LSPDVehicles[13] = AddStaticVehicleEx(525,1583.3402,-1711.1707,5.7788,0.7643,0,0, 60000, 1); // TEU 2
	LSPDVehicles[14] = AddStaticVehicleEx(411,1578.4225,-1710.9680,5.0722,0.0436,1,1, 60000, 1); // HSIU 1
	LSPDVehicles[15] = AddStaticVehicleEx(541,1574.3672,-1711.1157,5.0319,1.2399,0,1, 60000, 1); // HSIU 2
	LSPDVehicles[26] = AddStaticVehicleEx(451,1570.1216,-1710.7482,5.5953,358.6434,3,1, 60000, 1); // HSIU 3
	LSPDVehicles[16] = AddStaticVehicleEx(468,1566.6353,-1708.4395,5.5598,359.7773,0,0, 60000, 1); // Marry 1
	LSPDVehicles[17] = AddStaticVehicleEx(468,1566.9927,-1711.9053,5.5516,359.1170,0,0, 60000, 1); // Marry 2
	LSPDVehicles[18] = AddStaticVehicleEx(500,1558.8192,-1710.5981,6.0259,358.9276,6,1, 60000, 1); // RTD
	LSPDVehicles[19] = AddStaticVehicleEx(560,1546.4496,-1684.2610,5.6907,89.4153,0,0, 60000, 1); // DAVID 1
	LSPDVehicles[20] = AddStaticVehicleEx(560,1546.5052,-1680.2144,5.6320,91.8623,0,0, 60000, 1); // DAVID 2
	LSPDVehicles[21] = AddStaticVehicleEx(490,1545.6080,-1676.0394,6.0064,89.7384,0,1, 60000); // DAVID 3
	LSPDVehicles[22] = AddStaticVehicleEx(427,1544.9503,-1672.2172,6.1394,90.8040,0,0, 60000); // DAVID 4
	LSPDVehicles[23] = AddStaticVehicleEx(427,1544.9486,-1667.9055,6.1157,90.7017,0,0, 60000); // DAVID 5
	LSPDVehicles[24] = AddStaticVehicleEx(426,1528.6735,-1684.0107,5.6811,269.4669,198,198, 60000, 1); // TEU Premier 1
	LSPDVehicles[25] = AddStaticVehicleEx(426,1528.6068,-1687.9893,5.6737,271.4348,1,1, 60000, 1); // TEU Premier 2
	LSPDVehicles[27] = AddStaticVehicleEx(497,1566.6866,-1696.0535,28.6456,269.6936,0,1, 60000, 1);
	forex(i, sizeof(LSPDVehicles))
	{
		VehCore[LSPDVehicles[i]][vehFuel] = 100;
	}
}

stock LoadActor()
{
	CreateActor(29, -1112.0999,-1676.1182,76.3672,3.2336); //sell drugs actor
	CreateDynamic3DTextLabel("Drop the {FFFF00}Rolled Weed {FFFFFF}here to sell", -1, -1112.0999,-1676.1182,76.3672, 5.0);
	CreateDynamicCP(-1112.0999,-1676.1182,76.3672, 1.3, -1, -1, -1, 3.0);

	CreateActor(269, 2699.9746,-1108.3888,69.5781,86.3907); //sell drugs actor
	CreateDynamic3DTextLabel("Type {FFFF00}/buyweed {FFFFFF}to purchase weed seeds.", -1, 2699.9746,-1108.3888,69.5781, 3.0);

	CreateActor(30, 2503.6985,-2640.4846,13.8623,270.3391); //material
	CreateDynamic3DTextLabel("Gun Clip Market\nPress {FFFF00}H {FFFFFF}to interract.", -1, 2503.6985,-2640.4846,13.8623, 1.0);

	CreateActor(28, 2711.0886,-2195.4951,13.5469,273.9583); //material
	CreateDynamic3DTextLabel("Material Market\nPress {FFFF00}H {FFFFFF}to interract.", -1, 2711.0886,-2195.4951,13.5469, 1.0);

	CreateActor(24, -2109.1277,-2408.5168,31.3128,56.2477); //schematic
	CreateDynamic3DTextLabel("Schematic Market\nPress {FFFF00}H {FFFFFF}to interract.", -1, -2109.1277,-2408.5168,31.3128, 1.0);
}

stock LoadPoint()
{

	CreateDynamicPickup(1581, 23, -2032.6390,-117.4360,1035.1719, -1);
	CreateDynamic3DTextLabel("Departement of Motorvehicle\nGunakan {FFFF00}/drivingtest {FFFFFF}untuk memulai tes mengemudi\nPrice: {00FF00}$25.00", -1, -2032.6390,-117.4360,1035.1719, 10.0);

	CreateDynamicPickup(1239, 23, 1331.9070,1575.5684,3001.0859, -1);
	CreateDynamic3DTextLabel("/buybait", -1, 1331.9070,1575.5684,3001.0859, 10.0);

	CreateDynamicPickup(1239, 23, 1333.7576,1582.0439,3001.0859, -1);
	CreateDynamic3DTextLabel("Fishing Factory\n/sellfish", -1, 1333.7576,1582.0439,3001.0859, 10.0);

	CreateDynamicPickup(1239, 23, -535.0215,-177.6707,78.4047, -1);
	CreateDynamic3DTextLabel("Timber Storage\nType {FFFF00}/selltimber {FFFFFF}to sell all Timber\nPrice: {00FF00}$20.0{FFFFFF} per Timber", -1, -535.0215,-177.6707,78.4047, 10.0);

	CreateDynamicPickup(1239, 23, 1256.2085,-1286.8181,1061.1492, -1);
	CreateDynamic3DTextLabel("/autotreatment\nPrice: $50.0", -1, 1256.2085,-1286.8181,1061.1492, 10.0);

	CreateDynamicPickup(1239, 23, 2195.5918,-1977.5160,13.5526, -1);
	CreateDynamic3DTextLabel("Component Store\nPrice: $0.50 / 1\n/buycomponent", -1, 2195.5918,-1977.5160,13.5526, 10.0);

	CreateDynamicPickup(1239, 23, 177.9645,131.2774,1003.0295, -1);
	CreateDynamic3DTextLabel("Advertisement\n/ad", -1, 177.9645,131.2774,1003.0295, 10.0);

	CreateDynamicPickup(1247, 23, 1775.4489,-1572.7673,1734.9430, -1);
	CreateDynamic3DTextLabel("Arrest Point\n/arrest", COLOR_SERVER, 1775.4489,-1572.7673,1734.9430, 4.0);

	CreateDynamic3DTextLabel("Bank Point\n/help > Bank Commands", COLOR_WHITE,1460.1772,1400.8265,14.2063,3.0);
	CreateDynamicPickup(1274, 23, 1460.1772,1400.8265,14.2063);

	CreateDynamicPickup(1210, 23, -547.9644,-181.2153,78.4063, -1, -1);
	CreateDynamic3DTextLabel("Lumberjack Job\nType {FFFF00}/takejob {FFFFFF}to acquire this Job", -1, -547.9644,-181.2153,78.4063, 20.0);
	CreateDynamicMapIcon(-547.9644,-181.2153,78.4063, 56, -1, -1, -1, -1, 100.0);

	CreateDynamicPickup(1210, 23, 1035.0580,-1027.5889,32.1016, -1, -1);
	CreateDynamic3DTextLabel("Mechanic Job\nType {FFFF00}/takejob {FFFFFF}to acquire this Job", -1, 1035.0580,-1027.5889,32.1016, 20.0);
	CreateDynamicMapIcon(1035.0580,-1027.5889,32.1016, 56, -1, -1, -1, -1, 100.0);

	CreateDynamicPickup(1210, 23, 1830.4312,-1075.4193,23.8549, -1, -1);
	CreateDynamic3DTextLabel("Taxi Job\nType {FFFF00}/takejob {FFFFFF}to acquire this Job", -1, 1830.4312,-1075.4193,23.8549, 20.0);
	CreateDynamicMapIcon(1830.4312,-1075.4193,23.8549, 56, -1, -1, -1, -1, 100.0);

	CreateDynamicPickup(1210, 23, 2329.9319,-2315.6492,13.5469, -1, -1);
	CreateDynamic3DTextLabel("Trucker Job\nType {FFFF00}/takejob {FFFFFF}to acquire this Job", -1, 2329.9319,-2315.6492,13.5469, 20.0);
	CreateDynamicMapIcon(2329.9319,-2315.6492,13.5469, 56, -1, -1, -1, -1, 100.0);

	CreateDynamicPickup(1239, 23, 2615.1174,-2382.3147,13.6250, -1, -1);
	CreateDynamic3DTextLabel("Electronic Cargo\nPrice: {009000}$50.0", COLOR_SERVER, 2615.1174,-2382.3147,13.6250, 20.0);

	CreateDynamicPickup(1239, 23, 2445.5408,-2548.0427,17.9107, -1, -1);
	CreateDynamic3DTextLabel("24/7 Cargo\nPrice: {009000}$70.0", COLOR_SERVER, 2445.5408,-2548.0427,17.9107, 20.0);

	CreateDynamicPickup(1239, 23, 2255.7563,-2387.6526,17.4219, -1, -1);
	CreateDynamic3DTextLabel("Clothes Cargo\nPrice: {009000}$50.0", COLOR_SERVER, 2255.7563,-2387.6526,17.4219, 20.0);

	CreateDynamicPickup(1239, 23, 2719.2068,-2516.9297,17.3672, -1, -1);
	CreateDynamic3DTextLabel("Fast Food Cargo\nPrice: {009000}$75.0", COLOR_SERVER, 2719.2068,-2516.9297,17.3672, 20.0);

	CreateDynamicPickup(1239, 23, -528.2017,467.6121,1368.4100, -1, -1);
	CreateDynamic3DTextLabel("/buyplate - for buy plate\n/payticket - for pay ticket\n/unimpound - for release vehicle", -1, -528.2017,467.6121,1368.4100, 20.0);

	CreateDynamicPickup(1239, 23, 1111.7264,-1795.5878,16.5938, -1, -1);
	CreateDynamic3DTextLabel("Insurance Center\n{FFFF00}/insu buy {FFFFFF}- to purchase insurance\n{FFFF00}/insu claim {FFFFFF}- to claim vehicle", -1, 1111.7264,-1795.5878,16.5938, 20.0);
}

stock SaveServerData()
{
	new coordsString[128];
	format(coordsString, sizeof(coordsString), "%s, %s, %d, %d", MotdData[motdPlayer], MotdData[motdAdmin], GovData[govVault], GovData[govTax]);
	new File: file2 = fopen("server.ini", io_write);
	fwrite(file2, coordsString);
	fclose(file2);
	return 1;	
}

stock LoadServerData()
{
	new arrCoords[20][64];
	new strFromFile2[256];
	new File: file = fopen("server.ini", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		splits(strFromFile2, arrCoords, ',');
		strmid(MotdData[motdPlayer], arrCoords[0], 0, strlen(arrCoords[0]), 255);
		strmid(MotdData[motdAdmin], arrCoords[1], 0, strlen(arrCoords[1]), 255);
		GovData[govVault] = strval(arrCoords[2]);
		GovData[govTax] = strval(arrCoords[3]);
		fclose(file);
	}
	return 1;
}
