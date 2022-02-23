new const Job_Name[5][20] = {
	"None",
	"Trucker",
	"Taxi Driver",
	"Mechanic",
	"Lumberjack"
};

stock SendJobMessage(job, color, const str[], {Float,_}:...)
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

        foreach (new i : Player)
		{
			if (PlayerData[i][pJob] == job)
			{
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
	foreach (new i : Player)
	{
		if (PlayerData[i][pJob] == job) {
			SendClientMessage(i, color, str);
		}
	}
	return 1;
}

CMD:takejob(playerid, params[])
{
	new job = GetNearestJob(playerid);

	if(job == JOB_NONE)
		return SendErrorMessage(playerid, "You aren't in any Takejob point!");

	if(PlayerData[playerid][pJob] != JOB_NONE)
		return SendErrorMessage(playerid, "Kamu masih memiliki job!");

	new str[256];
	format(str, sizeof(str), "{FFFFFF}Tekan {00FF00}Confirm {FFFFFF}untuk mengambil job {FFFF00}%s", Job_Name[job]);
	ShowPlayerDialog(playerid, DIALOG_TAKEJOB, DIALOG_STYLE_MSGBOX, "Job Confirmation", str, "Confirm", "Close");
	return 1;
}

CMD:quitjob(playerid, params[])
{
	if(PlayerData[playerid][pQuitjob] > 0 && PlayerData[playerid][pAdmin] < 7)
		return SendErrorMessage(playerid, "Kamu harus melakukan %d paycheck lagi untuk quitjob!", PlayerData[playerid][pQuitjob]);

	if(PlayerData[playerid][pJob] == JOB_NONE)
		return SendErrorMessage(playerid, "Kamu tidak memiliki pekerjaan untuk keluar!");

	SendServerMessage(playerid, "Kamu berhasil keluar dari pekerjaan {FFFF00}%s {FFFFFF}kamu bisa takejob lagi sekarang!", Job_Name[PlayerData[playerid][pJob]]);
	PlayerData[playerid][pJob] = JOB_NONE;
	return 1;
}

stock GetNearestJob(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid, 5.0, 2329.9319,-2315.6492,13.5469))
	{
		return JOB_TRUCKER;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 5.0, 1830.4312,-1075.4193,23.8549))
	{
		return JOB_TAXI;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 5.0, -547.9644,-181.2153,78.4063))
	{
		return JOB_LUMBERJACK;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 5.0, 1035.0580,-1027.5889,32.1016))
	{
		return JOB_MECHANIC;
	}
	return JOB_NONE;
}

CMD:jobdelay(playerid, params[])
{
	new str[512];
	strcat(str, "Job Name\tTime\n");
	strcat(str, sprintf("Street Sweeper\t%d Minute\n", PlayerData[playerid][pSweeperDelay]/60));
	strcat(str, sprintf("Bus Driver\t%d Minute\n", PlayerData[playerid][pBusDelay]/60));
	strcat(str, sprintf("Selling Fish\t%d Minute\n", PlayerData[playerid][pFishDelay]/60));
	ShowPlayerDialog(playerid, DIALOG_NONE, DIALOG_STYLE_TABLIST_HEADERS, "Delay's information", str, "Close", "");
	return 1;
}
