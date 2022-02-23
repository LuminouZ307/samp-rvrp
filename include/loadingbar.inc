/*

	> SA:MP LoadingBar include
	
	> Download progress2: https://github.com/Southclaws/progress2
	
	> Include author: LuminouZ
	
*/


#if !defined _samp_included
	#tryinclude <a_samp>
	#if !defined _samp_included
		#error could not locate a_samp.inc file, please check your server includes
	#endif
#endif

#if !defined _progress2_included
	#tryinclude <progress2>
	#if !defined _progress2_included
		#error could not locate progress2.inc, please download from github.com/Southclaws/progress2
	#endif
#endif

enum e_player_loading
{
	barMaxVal,
	barTimer,
	bool:barExists,
	barVal,
};

new
	PlayerLoading[MAX_PLAYERS][e_player_loading];
	
new PlayerText:LOADBARTEXT[MAX_PLAYERS];
new PlayerBar:LOADBAR[MAX_PLAYERS];

stock CreateLoadingHeader(playerid)
{
	LOADBARTEXT[playerid] = CreatePlayerTextDraw(playerid, 322.000000, 353.000000, "");
	PlayerTextDrawFont(playerid, LOADBARTEXT[playerid], 1);
	PlayerTextDrawLetterSize(playerid, LOADBARTEXT[playerid], 0.216666, 1.200001);
	PlayerTextDrawTextSize(playerid, LOADBARTEXT[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, LOADBARTEXT[playerid], 1);
	PlayerTextDrawSetShadow(playerid, LOADBARTEXT[playerid], 0);
	PlayerTextDrawAlignment(playerid, LOADBARTEXT[playerid], 2);
	PlayerTextDrawColor(playerid, LOADBARTEXT[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, LOADBARTEXT[playerid], 255);
	PlayerTextDrawBoxColor(playerid, LOADBARTEXT[playerid], 50);
	PlayerTextDrawUseBox(playerid, LOADBARTEXT[playerid], 0);
	PlayerTextDrawSetProportional(playerid, LOADBARTEXT[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, LOADBARTEXT[playerid], 0);
}

stock DestroyPlayerLoadingBar(playerid)
{
    DestroyPlayerProgressBar(playerid, LOADBAR[playerid]);
    PlayerLoading[playerid][barExists] = false;
    KillTimer(PlayerLoading[playerid][barTimer]);
    PlayerLoading[playerid][barVal] = 0;
	PlayerLoading[playerid][barMaxVal] = 0;
	PlayerTextDrawDestroy(playerid, LOADBARTEXT[playerid]);
}

stock IsValidLoading(playerid)
    return PlayerLoading[playerid][barExists];

stock CreatePlayerLoadingBar(playerid, maxval, text[] = "")
{
	if(PlayerLoading[playerid][barExists])
 		return printf("ERROR: Unable for creating Loadingbar for Player ID: %d!", playerid);
 		
	PlayerLoading[playerid][barMaxVal] = maxval;
	PlayerLoading[playerid][barVal] = 0;
	PlayerLoading[playerid][barExists] = true;
	
	CreateLoadingHeader(playerid);
	PlayerTextDrawShow(playerid, LOADBARTEXT[playerid]);
	
	PlayerTextDrawSetString(playerid, LOADBARTEXT[playerid], text);
	
	LOADBAR[playerid] = CreatePlayerProgressBar(playerid, 273.000000, 370.000000, 101.500000, 9.500000, -1094795521, PlayerLoading[playerid][barMaxVal], 0);
	
	PlayerLoading[playerid][barTimer] = SetTimerEx("LOAD_UpdateLoading", 1000, true, "d", playerid);
	return 1;
}

forward LOAD_UpdateLoading(playerid);
public LOAD_UpdateLoading(playerid)
{
	if(!PlayerLoading[playerid][barExists])
	    return 0;
	    
	if(PlayerLoading[playerid][barVal] < PlayerLoading[playerid][barMaxVal])
	{
	    PlayerLoading[playerid][barVal]++;
	    SetPlayerProgressBarValue(playerid, LOADBAR[playerid], PlayerLoading[playerid][barVal]);
	}
	else
	{
	    DestroyPlayerLoadingBar(playerid);
	}
	return 1;
}
	
	    



