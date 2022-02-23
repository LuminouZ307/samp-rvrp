enum motd_data
{
	motdPlayer[64],
	motdAdmin[64]
};
new MotdData[motd_data];

CMD:amotd(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 6)
		return SendErrorMessage(playerid, NO_PERMISSION);

	new motd[64];
	if(sscanf(params, "s[64]", motd))
		return SendSyntaxMessage(playerid, "/amotd [set new admin motd]");

	format(MotdData[motdAdmin], 64, motd);
	SendClientMessageEx(playerid, COLOR_SERVER, "AMOTD: {FFFFFF}You have changed motd to %s", MotdData[motdAdmin]);
	SaveServerData();
	return 1;
}

CMD:motd(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 6)
		return SendErrorMessage(playerid, NO_PERMISSION);

	new motd[64];
	if(sscanf(params, "s[64]", motd))
		return SendSyntaxMessage(playerid, "/motd [set new motd]");

	format(MotdData[motdPlayer], 64, motd);
	SendClientMessageEx(playerid, COLOR_SERVER, "MOTD: {FFFFFF}You have changed motd to %s", MotdData[motdPlayer]);
	SaveServerData();
	return 1;
}