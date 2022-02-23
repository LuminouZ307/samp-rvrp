stock AFKCheck(playerid)
{
	if(PlayerData[playerid][pVendor] != -1)
		return 0;

	if(PlayerData[playerid][pFishing])
		return 0;

	new
	    Float:x,
	    Float:y,
	    Float:z,
	    Float:cx,
	    Float:cy,
	    Float:cz;

	GetPlayerPos(playerid, x, y, z);
	GetPlayerCameraPos(playerid, cx, cy, cz);

	if(PlayerData[playerid][pAFKPos][0] == x && PlayerData[playerid][pAFKPos][1] == y && PlayerData[playerid][pAFKPos][2] == z && PlayerData[playerid][pAFKPos][3] == cx && PlayerData[playerid][pAFKPos][4] == cy && PlayerData[playerid][pAFKPos][5] == cz)
	{
		PlayerData[playerid][pAFKTime]++;

	    if(!PlayerData[playerid][pAFK] && PlayerData[playerid][pAFKTime] >= 180)
	    {
			SendClientMessage(playerid, COLOR_LIGHTORANGE, "* You are now in {FFFF00}Away from Keyboard{F7A763} mode.");
		    PlayerData[playerid][pAFK] = 1;
		    SetPlayerColor(playerid, COLOR_GREY);
		}
	}
	else
	{
		if(PlayerData[playerid][pAFK])
		{
		    if(PlayerData[playerid][pAFKTime] < 120) 
		    {
		    	SendClientMessageEx(playerid, COLOR_LIGHTORANGE, "* You are no longer in {FFFF00}Away from Keyboard {F7A763}after %d seconds.", PlayerData[playerid][pAFKTime]);
			} 
			else 
			{
			    SendClientMessageEx(playerid, COLOR_LIGHTORANGE, "* You are no longer in {FFFF00}Away from Keyboard {F7A763}after %d minutes.", PlayerData[playerid][pAFKTime] / 60);
			}
			SetValidColor(playerid);
			PlayerData[playerid][pAFK] = 0;
			TogglePlayerControllable(playerid, true);
		}

		PlayerData[playerid][pAFKTime] = 0;
	}

	PlayerData[playerid][pAFKPos][0] = x;
	PlayerData[playerid][pAFKPos][1] = y;
	PlayerData[playerid][pAFKPos][2] = z;
	PlayerData[playerid][pAFKPos][3] = cx;
	PlayerData[playerid][pAFKPos][4] = cy;
	PlayerData[playerid][pAFKPos][5] = cz;
	return 1;
}

CMD:isafk(playerid, params[])
{
	new targetid;
	if(sscanf(params, "u", targetid))
		return SendSyntaxMessage(playerid, "/isafk [playerid/PartOfName]");

	if(targetid == INVALID_PLAYER_ID)
		return SendErrorMessage(playerid, "Invalid player specified!");

	SendClientMessageEx(playerid, COLOR_SERVER, "AFK-INFO: {FFFFFF}Player {00FFFF}%s {FFFFFF}is %s", GetName(targetid), (PlayerData[targetid][pAFK]) ? ("{FFFFFF}AFK") : ("{FF0000}not {FFFFFF}AFK"));
	return 1;
}
