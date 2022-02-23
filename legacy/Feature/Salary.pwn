stock AddSalary(playerid, name[], amount)
{
	new query[512];
	mysql_format(sqlcon, query, sizeof(query), "INSERT INTO playersalary(owner, name, amount, date) VALUES ('%d', '%s', '%d', CURRENT_TIMESTAMP())", PlayerData[playerid][pID], name, amount);
	mysql_tquery(sqlcon, query);
	PlayerData[playerid][pSalary] += amount;
	return 1;
}

stock ShowPlayerSalary(playerid, targetid)
{
	new query[512], list[2056], name[32], date[40], amount;
	mysql_format(sqlcon, query, sizeof(query), "SELECT * FROM playersalary WHERE owner='%d' ORDER BY id ASC", PlayerData[targetid][pID]);
	mysql_query(sqlcon, query);
	new rows = cache_num_rows();
	if(rows)
	{
	    format(list, sizeof(list), "{FFFFFF}Name\t{FFFFFF}Amount\t{FFFFFF}Date\n");
		for(new i; i < rows; ++i)
	    {
			cache_get_value_name(i, "name", name);
			cache_get_value_name(i, "date", date);
			cache_get_value_name_int(i, "amount", amount);

			format(list, sizeof(list), "%s{FFFFFF}%s\t{00FF00}$%s\t{FFFFFF}%s\n", list, name, FormatNumber(amount), date);
		}
		new title[48];
		format(title, sizeof(title), "Total Salary: $%s", FormatNumber(PlayerData[targetid][pSalary]));
		ShowPlayerDialog(playerid, DIALOG_NONE, DIALOG_STYLE_TABLIST_HEADERS, title, list, "Close", "");
	}
	else
	{
		SendServerMessage(playerid, "There is no Salary to display.");
	}
	return 1;
}

CMD:salary(playerid, params[])
{
	ShowPlayerSalary(playerid, playerid);
	return 1;
}