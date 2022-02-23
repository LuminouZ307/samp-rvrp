/*=========================================================*\
|--------------------------[How To]-------------------------|
|   	  Use BlockGarages(); to block the garages. 	  	|
|   	  Add a .text="" parameter to set the text.  	 	|
|   	Add a .type=int parameter to block one type.     	|
|	 Add a .block=bool parameter to set remove or block. 	|
|-----------------------------------------------------------|
\*=========================================================*/

/*
native BlockGarages(bool:block=true, GarageType:type=GARAGE_TYPE_ALL, text[]="");
*/

#if !defined STREAMER_TYPE_OBJECT
	#error streamer-tp requires streamer to be included.
#endif

#if !defined isnull
    #define isnull(%1) ((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#endif

enum GarageType {
	GARAGE_TYPE_ALL = 1, // 1
	GARAGE_TYPE_PAINT,   // 2
	GARAGE_TYPE_BOMB,    // 3
	GARAGE_TYPE_MODSHOP  // 4
}

enum GarageEnum {
	GarageType:g_type,
	g_object,
	
	Float:g_doorx,
	Float:g_doory,
	Float:g_doorz,
	Float:g_doorr
}

new G_Blocker[][GarageEnum] = {
	{GARAGE_TYPE_PAINT,		INVALID_STREAMER_ID,	1968.74219,		2162.49219,		12.09380,	0.0},
	{GARAGE_TYPE_BOMB,		INVALID_STREAMER_ID,	2006.00000,		2303.72656,		11.31250,	90.0},
	{GARAGE_TYPE_BOMB,		INVALID_STREAMER_ID,	2006.00000,		2317.60156,		11.31250,	-90.0},
	{GARAGE_TYPE_PAINT,		INVALID_STREAMER_ID,	720.01563,		-462.52341,		16.85940,	90.0},
	{GARAGE_TYPE_PAINT,		INVALID_STREAMER_ID,	-100.00000,		1111.41406,		21.14060,	90.0},
	{GARAGE_TYPE_PAINT,		INVALID_STREAMER_ID,	-1420.52686,	2591.15747,		57.24220,	-90.0},
	{GARAGE_TYPE_BOMB,		INVALID_STREAMER_ID,	1843.36719,		-1856.32031,	13.87500,	0.0},
	{GARAGE_TYPE_MODSHOP,	INVALID_STREAMER_ID,	-2716.35156,	217.47659,		5.38280,	180.0},
	{GARAGE_TYPE_MODSHOP,	INVALID_STREAMER_ID,	-1935.85938,	239.53130,		35.35160,	90.0},
	{GARAGE_TYPE_PAINT,		INVALID_STREAMER_ID,	-1904.53125,	277.89841,		42.45310,	90.0},
	{GARAGE_TYPE_PAINT,		INVALID_STREAMER_ID,	-1786.81250,	1209.42188,		25.83590,	90.0},
	{GARAGE_TYPE_ALL,		INVALID_STREAMER_ID,	1798.68750,		-2146.73438,	14.00000,	0.0},
	{GARAGE_TYPE_MODSHOP,	INVALID_STREAMER_ID,	2644.85938,		-2039.23438,	14.03910,	-90.0},
	{GARAGE_TYPE_PAINT,		INVALID_STREAMER_ID,	2071.47656,		-1831.42188,	14.56250,	180.0},
	{GARAGE_TYPE_PAINT,		INVALID_STREAMER_ID,	488.28131,		-1734.69531,	12.39060,	-101.0},
	{GARAGE_TYPE_PAINT,		INVALID_STREAMER_ID,	-2425.72656,	1027.99219,		51.78130,	-90.0},
	{GARAGE_TYPE_PAINT,		INVALID_STREAMER_ID,	2393.76563,		1483.68750,		12.21090,	90.0},
	{GARAGE_TYPE_MODSHOP,	INVALID_STREAMER_ID,	2386.65625,		1043.60156,		11.59380,	90.0},
	{GARAGE_TYPE_PAINT,		INVALID_STREAMER_ID,  	1025.01672, 	-1029.21533, 	33.11600,   90.0},
	{GARAGE_TYPE_MODSHOP,	INVALID_STREAMER_ID,	1041.35254, 	-1025.90967, 	32.67188,   90.0}
};

static stock DestroyGarageBlockerObject(garageid)
{
	if(G_Blocker[garageid][g_object] != INVALID_STREAMER_ID) {
		DestroyDynamicObject(G_Blocker[garageid][g_object]);
		G_Blocker[garageid][g_object] = INVALID_STREAMER_ID;
	}
}

stock BlockGarages(bool:block = true, GarageType:type = GARAGE_TYPE_ALL, text[] = "")
{
	if(type == GARAGE_TYPE_ALL) {
		if(block == false) {
			for(new i; i < sizeof(G_Blocker); i++)
				DestroyGarageBlockerObject(i);
		}
		else {
			for(new i; i < sizeof(G_Blocker); i++) {
				DestroyGarageBlockerObject(i);
				
				G_Blocker[i][g_object] = CreateDynamicObject(19325, G_Blocker[i][g_doorx], G_Blocker[i][g_doory], G_Blocker[i][g_doorz], 0.00000, 0.00000, G_Blocker[i][g_doorr]);
				
				if(!isnull(text))
					SetDynamicObjectMaterialText(G_Blocker[i][g_object], 0, text, OBJECT_MATERIAL_SIZE_128x128, "Arial", 16, 1, 0xFFFF0000, 0x00000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
				else
					SetDynamicObjectMaterial(G_Blocker[i][g_object], 0, 0, "none", "none", 0x00FFFFFF);
			}
		}
	}
	else {
		if(block == false) {
			for(new i; i < sizeof(G_Blocker); i++) {
				if(G_Blocker[i][g_type] == type)
					DestroyGarageBlockerObject(i);
			}
		}
		else {
			for(new i; i < sizeof(G_Blocker); i++) {
				if(G_Blocker[i][g_type] == type) {
					DestroyGarageBlockerObject(i);
					
					G_Blocker[i][g_object] = CreateDynamicObject(19325, G_Blocker[i][g_doorx], G_Blocker[i][g_doory], G_Blocker[i][g_doorz], 0.00000, 0.00000, G_Blocker[i][g_doorr]);
					
					if(!isnull(text))
						SetDynamicObjectMaterialText(G_Blocker[i][g_object], 0, text, OBJECT_MATERIAL_SIZE_128x128, "Arial", 16, 0, 0xFFFF0000, 0x00000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
					else
						SetDynamicObjectMaterial(G_Blocker[i][g_object], 0, 0, "none", "none", 0x00FFFFFF);
				}
			}
		}
	}
	return 1;
}