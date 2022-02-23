enum e_gangzone
{
	gzSafezone,
};

new GangZoneData[e_gangzone];

enum e_area
{
	STREAMER_TAG_AREA:areaMechanic,
	STREAMER_TAG_AREA:areaPershing,
	STREAMER_TAG_AREA:areaNews,
	STREAMER_TAG_AREA:areaHospital,
	STREAMER_TAG_AREA:areaBank,
	STREAMER_TAG_AREA:areaFishBig[3],
	STREAMER_TAG_AREA:areaFishSmall[2],
	STREAMER_TAG_AREA:areaDrug[2],
};
new AreaData[e_area];

stock IsPlayerInArea(playerid, Float:max_x, Float:min_x, Float:max_y, Float:min_y)
{
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	if(X <= max_x && X >= min_x && Y <= max_y && Y >= min_y) return true;
	return false;
}

stock LoadGangZone()
{
	GangZoneData[gzSafezone] = GangZoneCreate(-3000, -3000, 3000, 3000);

}

stock LoadArea()
{

	AreaData[areaDrug][0] = CreateDynamicRectangle(904, -393.5, 1004, -293.5);
	AreaData[areaDrug][1] = CreateDynamicRectangle(1907, 171.5, 2008, 246.5);

	AreaData[areaFishBig][0] = CreateDynamicRectangle(-93, -2304.5, 200, -2129.5);
	AreaData[areaFishBig][1] = CreateDynamicRectangle(200, -2391.5, 445, -2207.5);
	AreaData[areaFishBig][2] = CreateDynamicRectangle(-59, -2404.5, 200, -2304.5);

	AreaData[areaFishSmall][0] = CreateDynamicRectangle(-158, -2123.5, 115, -1966.5);
	AreaData[areaFishSmall][1] = CreateDynamicRectangle(-118, -1966.5, 150, -1797.5);

	AreaData[areaPershing] = CreateDynamicRectangle(1378, -1879.5, 1594, -1584.5);
	AreaData[areaHospital] = CreateDynamicRectangle(1050, -1407.5, 1249, -1264.5);
	AreaData[areaBank] = CreateDynamicRectangle(489, -1342.5, 624, -1232.5);
	AreaData[areaNews] = CreateDynamicRectangle(619, -1409.5, 806, -1312.5);

	AreaData[areaMechanic] = CreateDynamicSphere(1878.7712,-1852.1006,13.5770, 35.0);
}

stock IsSafeZone(STREAMER_TAG_AREA:areaid)
{
	if(areaid == AreaData[areaPershing] || areaid == AreaData[areaHospital] || areaid == AreaData[areaBank] || areaid == AreaData[areaNews])
		return 1;

	return 0;
}