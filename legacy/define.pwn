#define forex(%0,%1) for(new %0 = 0; %0 < %1; %0++)

#define FUNC::%0(%1) forward %0(%1); public %0(%1)

#define IsNull(%1) \
((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))

#define COLOR_YELLOW 			0xFFFF00FF
#define COLOR_SERVER      		0xC6E2FFFF
#define COLOR_GREY   			0xAFAFAFFF
#define COLOR_PURPLE 			0xD0AEEBFF
#define COLOR_CLIENT 			0xC6E2FFFF
#define COLOR_WHITE  			0xFFFFFFFF
#define COLOR_LIGHTRED    		0xFF6347FF
#define COLOR_LIGHTGREEN  		0x9ACD32FF
#define COLOR_RADIO 			0x8D8DFFFF
#define COLOR_DEPARTMENT		0xF0CC00FF
#define COLOR_GREEN       		0x33CC33FF
#define COLOR_RED 				0xFF0000FF
#define COLOR_LIGHTORANGE   	0xF7A763FF

#define DATABASE_ADDRESS "localhost" //Change this to your Database Address
#define DATABASE_USERNAME "root" // Change this to your database username
#define DATABASE_PASSWORD "" //Change this to your database password
#define DATABASE_NAME "revitali_rp"

#define SERVER_VERSION "3.2b consistent"

#if !defined BCRYPT_HASH_LENGTH
	#define BCRYPT_HASH_LENGTH 250
#endif

#if !defined BCRYPT_COST
	#define BCRYPT_COST 12
#endif

#define NO_PERMISSION "You don't have permission to use this command."

#define MDC_ERROR               (21001)
#define MDC_SELECT              (21000)
#define MDC_OPEN                (45400)

#define PRESSED(%0) (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

#define PRESSING(%0,%1) \
	(%0 & (%1))

#define RELEASE(%0) (((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

#define SendServerMessage(%0,%1) \
	SendClientMessageEx(%0, 0x62da92FF, "SERVER:{FFFFFF} "%1)

#define SendSyntaxMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_GREY, "USAGE:{FFFFFF} "%1)
	
#define SendErrorMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_GREY, "ERROR: "%1)


#define BODY_PART_TORSO (3)
#define BODY_PART_GROIN (4)
#define BODY_PART_LEFT_ARM (5)
#define BODY_PART_RIGHT_ARM (6)
#define BODY_PART_LEFT_LEG (7)
#define BODY_PART_RIGHT_LEG (8)
#define BODY_PART_HEAD (9)

#define MAX_HOUSE_STORAGE			10
#define MAX_WHEAT					1000
#define MAX_TAGS					500
#define MAX_ACTOR 					100
#define MAX_WEAPONS 				55
#define MAX_BODY_PARTS 				7
#define MAX_HOUSE_FURNITURE			30
#define MAX_FURNITURE 				2000
#define MAX_PLAYER_TICKETS			15
#define MAX_PLAYER_VEHICLE 			1000
#define MAX_INVENTORY 				15
#define MAX_BUSINESS                100
#define MAX_DROPPED_ITEMS  			1000
#define MAX_RENTAL                  20
#define MAX_CRATES 					1000
#define MAX_WEED					1000
#define MAX_GROW                    20
#define MAX_LISTED_ITEMS 			10
#define MAX_FACTIONS				10
#define MAX_DDOORS					100
#define MAX_REPORTS					20
#define MAX_EMERGENCY				300
#define MAX_SPEEDCAM 				100
#define MAX_CONTACTS				15
#define MAX_CHARS					3
#define MAX_DEALER 					20
#define MAX_ATM 					50
#define MAX_ADVERT					50
#define MAX_HOUSES					300
#define MAX_VENDOR					3
#define MAX_TREE					50
#define MAX_GATES 					100
#define MAX_FACTION_VEHICLE			200
	