/*
 * android-check, an include for checking if user connects from android "illegal" clients.
 * Originally made by Fairuz, modified by ff-agus44
 *
 * Credits:
 *   - Fairuz (Orignal Code)
 *   - Y_Less (YSI-Includes and his y_rconfix functions)
*/


#include <a_samp>

#tryinclude <YSI_Coding\y_hooks>

#if !defined _INC_y_hooks
	#error Please download YSI-Includes from: https://github.com/pawn-lang/YSI-Includes
#endif

#if defined OnClientChecked
 	forward OnClientChecked(playerid, Client:type);
#endif

#if !defined SendClientCheck
	native SendClientCheck(playerid, type, memAddr, memOffset, byteCount);
#endif

enum Client {
	CLIENT_TYPE_PC,
	CLIENT_TYPE_ANDROID
};

static stock Client:clientType[MAX_PLAYERS] = {CLIENT_TYPE_ANDROID, ...};

DEFINE_HOOK_REPLACEMENT__(ClientCheck, ClCheck);
hook FIXES_OnClCheckResponse(playerid, actionid, memaddr, retndata) 
{
	if (actionid == 0x48) 
	{
		clientType[playerid] = CLIENT_TYPE_PC;
	}
	return 1;
}

hook OnGameModeInit()
{
	#if !defined y_rconfix_Load && !defined _INC_SAMP_Community_fixes
		LoadClientCheckFix();
	#endif

	return 1;
}

hook OnPlayerConnect(playerid)
{
	// SendClientCheck example script by evgen1137
	// thanks to MTA devs for structs
	SendClientCheck(playerid, 0x48, 0, 0, 2);
	SetTimerEx(#__InternalCheck, 1000, false, "i", playerid);
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	// when player exit, we need to reset it back to "true"
	clientType[playerid] = CLIENT_TYPE_ANDROID;
	return 1;
}

forward __InternalCheck(playerid);
public __InternalCheck(playerid)
{
    CallLocalFunction(#OnClientChecked, "ii", playerid, _:clientType[playerid]);
    return 1;
}

stock Client:GetClientType(playerid)
{
	return clientType[playerid];
}

stock IsPlayerUsingAndroid(playerid)
{
	return (clientType[playerid] != CLIENT_TYPE_PC);
}

/* 
	functions to fix OnClientCheckResponse, originally made by Y_Less.

	Source:
  		- https://github.com/pawn-lang/YSI-Includes/blob/aaeb2cc8200bfc64c0133002e7ce6398ea6c5959/YSI_Core/y_master/y_rconfix.inc
  		- https://github.com/pawn-lang/sa-mp-fixes/issues/80#issuecomment-338402500
*/

stock LoadClientCheckFix()
{
	// If it is not exists, create the file first.
	if (!fexist("callbackfix.amx"))
	{
		static
			lRCFixCode[] = {
				0x000000ED, 0x0808F1E0, 0x00080014, 0x0000008C, 0x000000F0,
				0x00000174, 0x00004174, 0xFFFFFFFF, 0x00000038, 0x00000048,
				0x00000050, 0x00000050, 0x00000050, 0x00000050, 0x00000014,
				0x00000052, 0x00000008, 0x00000068, 0x00000000, 0x00000076,
				0x6E4F001F, 0x65696C43, 0x6843746E, 0x526B6365, 0x6F707365,
				0x0065736E, 0x63526E4F, 0x6F436E6F, 0x6E616D6D, 0x61430064,
				0x65526C6C, 0x65746F6D, 0x636E7546, 0x6E6F6974, 0x00000000,
				0x2E007880, 0x2E305980, 0x81180581, 0x05811405, 0x0C058110,
				0x27708027, 0x80182700, 0x1C2C007B, 0x80468030, 0x80588049,
				0x80538045, 0x804F805F, 0x8043806E, 0x8069806C, 0x806E8065,
				0x80438074, 0x80658068, 0x806B8063, 0x80658052, 0x80708073,
				0x806E806F, 0x00658073, 0x69806980, 0x69806980, 0x00000000
			};
		new
			File:fs = fopen("callbackfix.amx", io_write);

		if (fs)
		{
			fblockwrite(fs, lRCFixCode);
			fclose(fs);
		}
	}

	/* 
		after that we check if the caller is actually exist, then send the rcon command
		the reason why the original code using this instead of else is because when the file is not exists
		using else here will not be called.
	*/
	if (fexist("callbackfix.amx"))
	{
		SendRconCommand("loadfs ../scriptfiles/callbackfix");
	}
}
