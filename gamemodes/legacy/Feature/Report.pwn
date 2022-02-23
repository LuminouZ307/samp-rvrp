enum reportData
{
	rExists,
	rType,
	rPlayer,
	rText[128],
	rOwner,
};
new ReportData[MAX_REPORTS][reportData];

stock ClearReports()
{
	forex(i, MAX_REPORTS)
	{
		ReportData[i][rExists] = false;
		ReportData[i][rPlayer] = INVALID_PLAYER_ID;
		format(ReportData[i][rText], 128, "");
	}
	return 1;
}

stock Report_GetCount(playerid)
{
	new count;

    for (new i = 0; i != MAX_REPORTS; i ++)
	{
	    if (ReportData[i][rExists] && ReportData[i][rPlayer] == playerid)
	    {
	        count++;
		}
	}
	return count;
}

stock RemovePlayerReports(playerid)
{
	for (new i = 0; i != MAX_REPORTS; i ++) if(ReportData[i][rOwner] == PlayerData[playerid][pID])
	{
	    Report_Remove(i);
	}
	return 1;
}

stock Report_Add(playerid, text[], type = 1)
{
	for (new i = 0; i != MAX_REPORTS; i ++)
	{
	    if (!ReportData[i][rExists])
	    {
	        ReportData[i][rExists] = true;
	        ReportData[i][rType] = type;
	        ReportData[i][rPlayer] = playerid;
	        
			ReportData[i][rOwner] = PlayerData[playerid][pID];
			
	        format(ReportData[i][rText], 128, text);
			return i;
		}
	}
	return -1;
}

stock Report_Remove(reportid)
{
	if (reportid != -1 && ReportData[reportid][rExists])
	{
	    ReportData[reportid][rExists] = false;
	    ReportData[reportid][rPlayer] = INVALID_PLAYER_ID;
	}
	return 1;
}


CMD:report(playerid, params[])
{
	new reportid = -1;

	    
	if(Report_GetCount(playerid) >= 1)
	    return SendErrorMessage(playerid, "You already have a(n) pending report!");
	    
	if (isnull(params))
	{
	    SendSyntaxMessage(playerid, "/report [reason]");
	    SendClientMessage(playerid, COLOR_LIGHTRED, "WARNING:{FFFFFF} Please only use this command for valid purposes only!");
	    return 1;
	}

	if ((reportid = Report_Add(playerid, params)) != -1)
	{
		if (strlen(params) > 64)
		{
		    SendAdminMessage(COLOR_LIGHTRED, "[REPORT %d] {FFFFFF}%s (%d) - {FFFF00}Reason: {FFFFFF}%.64s", reportid, GetName(playerid), playerid, params);
		    SendAdminMessage(COLOR_WHITE, "...%s", params[64]);
		}
		else
		{
		    SendAdminMessage(COLOR_LIGHTRED, "[REPORT %d] {FFFFFF}%s (%d) - {FFFF00}Reason: {FFFFFF}%.64s", reportid, GetName(playerid), playerid, params);
		}
		SendServerMessage(playerid, "Your report successfully sended to online administrator!");
	}
	else
	{
	    SendErrorMessage(playerid, "The report list is full. Please wait for a while.");
	}
	return 1;
}

CMD:ar(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 1)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (isnull(params))
	    return SendServerMessage(playerid, "/ar [report id] (/reports for a list)");

	new
		reportid = strval(params);

	if ((reportid < 0 || reportid >= MAX_REPORTS) || !ReportData[reportid][rExists])
	    return SendErrorMessage(playerid, "Invalid report ID. Reports list from 0 to %d.", MAX_REPORTS);

	SendAdminMessage(COLOR_LIGHTRED, "REPORT: {FF0000}%s {FFFFFF}has accepted the report from {00FFFF}%s[id:%d].",PlayerData[playerid][pUCP], GetName(ReportData[reportid][rPlayer]),ReportData[reportid][rPlayer]);
	SendClientMessageEx(ReportData[reportid][rPlayer], COLOR_SERVER, "REPORT: {FF0000}%s {FFFFFF}has accepted your report", PlayerData[playerid][pUCP]);
	Report_Remove(reportid);
	return 1;
}

CMD:reports(playerid, params[])
{

	if(PlayerData[playerid][pAdmin] < 1)
		return SendErrorMessage(playerid, "You don't have permission to use this command!");

	new
		count,
		reportdialog[712];

	format(reportdialog, sizeof(reportdialog), "Report ID\tIssuer\tReportMsg\n");
	for (new i = 0; i != MAX_REPORTS; i ++)
	{
	    if (!ReportData[i][rExists])
			continue;
		format(reportdialog, sizeof(reportdialog), "%s%d\t[%d]%s\t%s", reportdialog, i, ReportData[i][rPlayer], GetName(ReportData[i][rPlayer]), ReportData[i][rText]);
        format(reportdialog, sizeof(reportdialog), "%s\n", reportdialog);
		count++;
	}
	if (!count)
	    return SendErrorMessage(playerid, "There are no active reports to display.");

	ShowPlayerDialog(playerid, DIALOG_NONE, DIALOG_STYLE_TABLIST_HEADERS, "Report List", reportdialog, "Close", "");
	return 1;
}


CMD:dr(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 1)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (isnull(params))
	    return SendServerMessage(playerid, "/dr [report id] (/reports for a list)");

	new
		reportid = strval(params);

	if ((reportid < 0 || reportid >= MAX_REPORTS) || !ReportData[reportid][rExists])
	    return SendErrorMessage(playerid, "Invalid report ID. Reports list from 0 to %d.", MAX_REPORTS);

	SendAdminMessage(COLOR_LIGHTRED, "REPORT: {FF0000}%s {FFFFFF}has denied the report from {00FFFF}%s[id:%d].",PlayerData[playerid][pUCP], GetName(ReportData[reportid][rPlayer]),ReportData[reportid][rPlayer]);
	SendClientMessageEx(ReportData[reportid][rPlayer], COLOR_SERVER, "REPORT: {FF0000}%s {FFFFFF}has denied your report", PlayerData[playerid][pUCP]);
	Report_Remove(reportid);
	return 1;
}


CMD:clearreports(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5)
	    return SendErrorMessage(playerid, "You don't have permission to use this Command!");
	    
	ClearReports();
	SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has cleared all reports.", PlayerData[playerid][pUCP]);
    return 1;
}

