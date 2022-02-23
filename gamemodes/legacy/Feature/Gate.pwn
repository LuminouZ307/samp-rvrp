enum e_gateData {
	gateID,
	gateExists,
	gateOpened,
	gateModel,
	Float:gateSpeed,
	Float:gateRadius,
	gateTime,
	Float:gatePos[6],
	gateInterior,
	gateWorld,
	Float:gateMove[6],
	gateLinkID,
	gateFaction,
	gatePass[32],
	gateTimer,
	STREAMER_TAG_OBJECT:gateObject
};

new GateData[MAX_GATES][e_gateData];

stock Gate_Nearest(playerid)
{
    for (new i = 0; i != MAX_GATES; i ++) if (GateData[i][gateExists] && IsPlayerInRangeOfPoint(playerid, GateData[i][gateRadius], GateData[i][gatePos][0], GateData[i][gatePos][1], GateData[i][gatePos][2]))
	{
		if (GetPlayerInterior(playerid) == GateData[i][gateInterior] && GetPlayerVirtualWorld(playerid) == GateData[i][gateWorld])
			return i;
	}
	return -1;
}


stock GetGateByID(sqlid)
{
	for (new i = 0; i != MAX_GATES; i ++) if (GateData[i][gateExists] && GateData[i][gateID] == sqlid)
	    return i;

	return -1;
}

forward CloseGate(gateid, linkid, Float:fX, Float:fY, Float:fZ, Float:speed, Float:fRotX, Float:fRotY, Float:fRotZ);
public CloseGate(gateid, linkid, Float:fX, Float:fY, Float:fZ, Float:speed, Float:fRotX, Float:fRotY, Float:fRotZ)
{
	new id = -1;

	if (GateData[gateid][gateExists] && GateData[gateid][gateOpened])
 	{
	 	MoveDynamicObject(GateData[gateid][gateObject], fX, fY, fZ, speed, fRotX, fRotY, fRotZ);

	 	if ((id = GetGateByID(linkid)) != -1)
            MoveDynamicObject(GateData[id][gateObject], GateData[id][gatePos][0], GateData[id][gatePos][1], GateData[id][gatePos][2], speed, GateData[id][gatePos][3], GateData[id][gatePos][4], GateData[id][gatePos][5]);

		GateData[id][gateOpened] = 0;
		return 1;
	}
	return 0;
}

stock Gate_Operate(gateid)
{
	if (gateid != -1 && GateData[gateid][gateExists])
	{
	    new id = -1;

		if (!GateData[gateid][gateOpened])
		{
		    GateData[gateid][gateOpened] = true;
		    MoveDynamicObject(GateData[gateid][gateObject], GateData[gateid][gateMove][0], GateData[gateid][gateMove][1], GateData[gateid][gateMove][2], GateData[gateid][gateSpeed], GateData[gateid][gateMove][3], GateData[gateid][gateMove][4], GateData[gateid][gateMove][5]);

            if (GateData[gateid][gateTime] > 0) {
				GateData[gateid][gateTimer] = SetTimerEx("CloseGate", GateData[gateid][gateTime], false, "ddfffffff", gateid, GateData[gateid][gateLinkID], GateData[gateid][gatePos][0], GateData[gateid][gatePos][1], GateData[gateid][gatePos][2], GateData[gateid][gateSpeed], GateData[gateid][gatePos][3], GateData[gateid][gatePos][4], GateData[gateid][gatePos][5]);
			}
			if (GateData[gateid][gateLinkID] != -1 && (id = GetGateByID(GateData[gateid][gateLinkID])) != -1)
			{
			    GateData[id][gateOpened] = true;
			    MoveDynamicObject(GateData[id][gateObject], GateData[id][gateMove][0], GateData[id][gateMove][1], GateData[id][gateMove][2], GateData[id][gateSpeed], GateData[id][gateMove][3], GateData[id][gateMove][4], GateData[id][gateMove][5]);
			}
		}
		else if (GateData[gateid][gateOpened])
		{
		    GateData[gateid][gateOpened] = false;
		    MoveDynamicObject(GateData[gateid][gateObject], GateData[gateid][gatePos][0], GateData[gateid][gatePos][1], GateData[gateid][gatePos][2], GateData[gateid][gateSpeed], GateData[gateid][gatePos][3], GateData[gateid][gatePos][4], GateData[gateid][gatePos][5]);

            if (GateData[gateid][gateTime] > 0) {
				KillTimer(GateData[gateid][gateTimer]);
		    }
			if (GateData[gateid][gateLinkID] != -1 && (id = GetGateByID(GateData[gateid][gateLinkID])) != -1)
			{
			    GateData[id][gateOpened] = false;
			    MoveDynamicObject(GateData[id][gateObject], GateData[id][gatePos][0], GateData[id][gatePos][1], GateData[id][gatePos][2], GateData[id][gateSpeed], GateData[id][gatePos][3], GateData[id][gatePos][4], GateData[id][gatePos][5]);
			}
		}
	}
	return 1;
}

stock Gate_Create(playerid)
{
	new
	    Float:x,
	    Float:y,
	    Float:z,
	    Float:angle;

	if (GetPlayerPos(playerid, x, y, z) && GetPlayerFacingAngle(playerid, angle))
	{
		for (new i = 0; i < MAX_GATES; i ++) if (!GateData[i][gateExists])
		{
		    GateData[i][gateExists] = true;
			GateData[i][gateModel] = 980;
			GateData[i][gateSpeed] = 3.0;
			GateData[i][gateRadius] = 5.0;
			GateData[i][gateOpened] = 0;
			GateData[i][gateTime] = 0;

			GateData[i][gatePos][0] = x + (3.0 * floatsin(-angle, degrees));
			GateData[i][gatePos][1] = y + (3.0 * floatcos(-angle, degrees));
			GateData[i][gatePos][2] = z;
			GateData[i][gatePos][3] = 0.0;
			GateData[i][gatePos][4] = 0.0;
			GateData[i][gatePos][5] = angle;

			GateData[i][gateMove][0] = x + (3.0 * floatsin(-angle, degrees));
			GateData[i][gateMove][1] = y + (3.0 * floatcos(-angle, degrees));
			GateData[i][gateMove][2] = z - 10.0;
			GateData[i][gateMove][3] = -1000.0;
			GateData[i][gateMove][4] = -1000.0;
			GateData[i][gateMove][5] = -1000.0;

            GateData[i][gateInterior] = GetPlayerInterior(playerid);
            GateData[i][gateWorld] = GetPlayerVirtualWorld(playerid);

            GateData[i][gateLinkID] = -1;
            GateData[i][gateFaction] = -1;

            GateData[i][gatePass][0] = '\0';
            GateData[i][gateObject] = CreateDynamicObject(GateData[i][gateModel], GateData[i][gatePos][0], GateData[i][gatePos][1], GateData[i][gatePos][2], GateData[i][gatePos][3], GateData[i][gatePos][4], GateData[i][gatePos][5], GateData[i][gateWorld], GateData[i][gateInterior]);

			mysql_tquery(sqlcon, "INSERT INTO `gates` (`gateModel`) VALUES(980)", "OnGateCreated", "d", i);
			return i;
		}
	}
	return -1;
}

FUNC::OnGateCreated(id)
{
	GateData[id][gateID] = cache_insert_id();
	Gate_Save(id);
}
stock Gate_Delete(gateid)
{
	if (gateid != -1 && GateData[gateid][gateExists])
	{
		new
		    query[64];

		mysql_format(sqlcon, query, sizeof(query), "DELETE FROM `gates` WHERE `gateID` = '%d'", GateData[gateid][gateID]);
		mysql_tquery(sqlcon, query);

		if (IsValidDynamicObject(GateData[gateid][gateObject]))
		    DestroyDynamicObject(GateData[gateid][gateObject]);

		for (new i = 0; i != MAX_GATES; i ++) if (GateData[i][gateExists] && GateData[i][gateLinkID] == GateData[gateid][gateID]) {
		    GateData[i][gateLinkID] = -1;
		    Gate_Save(i);
		}
		if (GateData[gateid][gateOpened] && GateData[gateid][gateTime] > 0) {
		    KillTimer(GateData[gateid][gateTimer]);
		}
	    GateData[gateid][gateExists] = false;
	    GateData[gateid][gateID] = 0;
	    GateData[gateid][gateOpened] = 0;
	}
	return 1;
}

stock Gate_Save(gateid)
{
	new
	    query[768];

	mysql_format(sqlcon,query, sizeof(query), "UPDATE `gates` SET `gateModel` = '%d', `gateSpeed` = '%.4f', `gateRadius` = '%.4f', `gateTime` = '%d', `gateX` = '%.4f', `gateY` = '%.4f', `gateZ` = '%.4f', `gateRX` = '%.4f', `gateRY` = '%.4f', `gateRZ` = '%.4f', `gateInterior` = '%d', `gateWorld` = '%d', `gateMoveX` = '%.4f', `gateMoveY` = '%.4f', `gateMoveZ` = '%.4f', `gateMoveRX` = '%.4f', `gateMoveRY` = '%.4f', `gateMoveRZ` = '%.4f', `gateLinkID` = '%d', `gateFaction` = '%d', `gatePass` = '%s' WHERE `gateID` = '%d'",
	    GateData[gateid][gateModel],
	    GateData[gateid][gateSpeed],
	    GateData[gateid][gateRadius],
	    GateData[gateid][gateTime],
	    GateData[gateid][gatePos][0],
	    GateData[gateid][gatePos][1],
	    GateData[gateid][gatePos][2],
	    GateData[gateid][gatePos][3],
	    GateData[gateid][gatePos][4],
	    GateData[gateid][gatePos][5],
	    GateData[gateid][gateInterior],
	    GateData[gateid][gateWorld],
	    GateData[gateid][gateMove][0],
	    GateData[gateid][gateMove][1],
	    GateData[gateid][gateMove][2],
	    GateData[gateid][gateMove][3],
	    GateData[gateid][gateMove][4],
	    GateData[gateid][gateMove][5],
	    GateData[gateid][gateLinkID],
	    GateData[gateid][gateFaction],
	    GateData[gateid][gatePass],
	    GateData[gateid][gateID]
	);
	return mysql_tquery(sqlcon, query);
}

FUNC::Gate_Load()
{
	new rows = cache_num_rows();
	if(rows)
	{
		for(new i = 0; i < rows; i++)
		{
		    GateData[i][gateExists] = true;
		    GateData[i][gateOpened] = false;

		    cache_get_value_name_int(i, "gateID", GateData[i][gateID]);
		    cache_get_value_name_int(i, "gateModel", GateData[i][gateModel]);
		    cache_get_value_name_float(i, "gateSpeed", GateData[i][gateSpeed]);
		    cache_get_value_name_float(i, "gateRadius", GateData[i][gateRadius]);
		    cache_get_value_name_int(i, "gateTime", GateData[i][gateTime]);
		    cache_get_value_name_int(i, "gateInterior", GateData[i][gateInterior]);
		    cache_get_value_name_int(i, "gateWorld", GateData[i][gateWorld]);

		    cache_get_value_name_float(i, "gateX", GateData[i][gatePos][0]);
		    cache_get_value_name_float(i, "gateY", GateData[i][gatePos][1]);
		    cache_get_value_name_float(i, "gateZ", GateData[i][gatePos][2]);
		    cache_get_value_name_float(i, "gateRX", GateData[i][gatePos][3]);
		    cache_get_value_name_float(i, "gateRY", GateData[i][gatePos][4]);
		    cache_get_value_name_float(i, "gateRZ", GateData[i][gatePos][5]);

		    cache_get_value_name_float(i, "gateMoveX", GateData[i][gateMove][0]);
		    cache_get_value_name_float(i, "gateMoveY", GateData[i][gateMove][1]);
		    cache_get_value_name_float(i, "gateMoveZ", GateData[i][gateMove][2]);
		    cache_get_value_name_float(i, "gateMoveRX", GateData[i][gateMove][3]);
		    cache_get_value_name_float(i, "gateMoveRY", GateData[i][gateMove][4]);
		    cache_get_value_name_float(i, "gateMoveRZ", GateData[i][gateMove][5]);

		    cache_get_value_name_int(i, "gateLinkID", GateData[i][gateLinkID]);
		    cache_get_value_name_int(i, "gateFaction", GateData[i][gateFaction]);

		    cache_get_value_name(i, "gatePass", GateData[i][gatePass], 32);

		    GateData[i][gateObject] = CreateDynamicObject(GateData[i][gateModel], GateData[i][gatePos][0], GateData[i][gatePos][1], GateData[i][gatePos][2], GateData[i][gatePos][3], GateData[i][gatePos][4], GateData[i][gatePos][5], GateData[i][gateWorld], GateData[i][gateInterior]);
		}
	}
	return 1;
}

CMD:gate(playerid, params[])
{
	new id = Gate_Nearest(playerid);

	if (id != -1)
	{
		if (strlen(GateData[id][gatePass]) && !GateData[id][gateOpened])
		{
		    ShowPlayerDialog(playerid, DIALOG_GATE_PASS, DIALOG_STYLE_INPUT, "Enter Password", "Please enter the password for this gate below:", "Submit", "Cancel");
		}
		else
		{
		    if (GateData[id][gateFaction] != -1 && PlayerData[playerid][pFaction] != GetFactionByID(GateData[id][gateFaction]))
				return SendErrorMessage(playerid, "You can't open this gate.");

			Gate_Operate(id);

			switch (GateData[id][gateOpened])
			{
			    case 0:
				    ShowMessage(playerid, "You have ~r~closed~w~ the gate!", 3);

                case 1:
				    ShowMessage(playerid, "You have ~g~opened~w~ the gate!", 3);
			}
		}
	}
	return 1;
}

CMD:creategate(playerid, params[])
{
	static
	    id = -1;

    if (PlayerData[playerid][pAdmin] < 6)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	id = Gate_Create(playerid);

	if (id == -1)
	    return SendErrorMessage(playerid, "The server has reached the limit for gates.");

	SendServerMessage(playerid, "You have successfully created gate ID: %d.", id);
	return 1;
}

CMD:destroygate(playerid, params[])
{
	static
	    id = 0;

    if (PlayerData[playerid][pAdmin] < 6)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "d", id))
	    return SendSyntaxMessage(playerid, "/destroygate [gate id]");

	if ((id < 0 || id >= MAX_GATES) || !GateData[id][gateExists])
	    return SendErrorMessage(playerid, "You have specified an invalid gate ID.");

	Gate_Delete(id);
	SendServerMessage(playerid, "You have successfully destroyed gate ID: %d.", id);
	return 1;
}

CMD:editgate(playerid, params[])
{
	new
	    id,
	    type[24],
	    string[128];

	if (PlayerData[playerid][pAdmin] < 5)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	SendSyntaxMessage(playerid, "/editgate [id] [name]");
	    SendClientMessage(playerid, COLOR_YELLOW, "Names:{FFFFFF} location, speed, radius, time, model, pos, move, pass, linkid, faction");
		return 1;
	}
	if ((id < 0 || id >= MAX_GATES) || !GateData[id][gateExists])
	    return SendErrorMessage(playerid, "You have specified an invalid gate ID.");

    if (!strcmp(type, "location", true))
	{
		static
		    Float:x,
		    Float:y,
		    Float:z,
		    Float:angle;

		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, angle);

		x += 3.0 * floatsin(-angle, degrees);
		y += 3.0 * floatcos(-angle, degrees);

		GateData[id][gatePos][0] = x;
		GateData[id][gatePos][1] = y;
		GateData[id][gatePos][2] = z;
		GateData[id][gatePos][3] = 0.0;
		GateData[id][gatePos][4] = 0.0;
		GateData[id][gatePos][5] = angle;

		SetDynamicObjectPos(GateData[id][gateObject], x, y, z);
		SetDynamicObjectRot(GateData[id][gateObject], 0.0, 0.0, angle);

		GateData[id][gateOpened] = false;

		Gate_Save(id);
		SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has adjusted the position of gate ID: %d.", PlayerData[playerid][pUCP], id);
		return 1;
	}
	else if (!strcmp(type, "speed", true))
	{
	    static
	        Float:speed;

		if (sscanf(string, "f", speed))
		    return SendSyntaxMessage(playerid, "/editgate [id] [speed] [move speed]");

		if (speed < 0.0 || speed > 20.0)
		    return SendErrorMessage(playerid, "The specified speed can't be below 0 or above 20.");

        GateData[id][gateSpeed] = speed;

		Gate_Save(id);
		SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has adjusted the speed of gate ID: %d to %.2f.", PlayerData[playerid][pUCP], id, speed);
		return 1;
	}
	else if (!strcmp(type, "radius", true))
	{
	    static
	        Float:radius;

		if (sscanf(string, "f", radius))
		    return SendSyntaxMessage(playerid, "/editgate [id] [radius] [open radius]");

		if (radius < 0.0 || radius > 20.0)
		    return SendErrorMessage(playerid, "The specified radius can't be below 0 or above 20.");

        GateData[id][gateRadius] = radius;

		Gate_Save(id);
		SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has adjusted the radius of gate ID: %d to %.2f.", PlayerData[playerid][pUCP], id, radius);
		return 1;
	}
	else if (!strcmp(type, "time", true))
	{
	    static
	        time;

		if (sscanf(string, "d", time))
		    return SendSyntaxMessage(playerid, "/editgate [id] [time] [close time] (0 to disable)");

		if (time < 0 || time > 60000)
		    return SendErrorMessage(playerid, "The specified time can't be 0 or above 60,000 ms.");

        GateData[id][gateTime] = time;

		Gate_Save(id);
		SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has adjusted the close time of gate ID: %d to %d.", PlayerData[playerid][pUCP], id, time);
		return 1;
	}
	else if (!strcmp(type, "model", true))
	{
	    static
	        model;

		if (sscanf(string, "d", model))
		    return SendSyntaxMessage(playerid, "/editgate [id] [model] [gate model]");

		if (!IsValidObjectModel(model))
		    return SendErrorMessage(playerid, "Invalid object model.");

        GateData[id][gateModel] = model;

        Streamer_SetIntData(STREAMER_TYPE_OBJECT, GateData[id][gateObject], E_STREAMER_MODEL_ID, GateData[id][gateModel]);

		Gate_Save(id);
		SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has adjusted the model of gate ID: %d to %d.", PlayerData[playerid][pUCP], id, model);
		return 1;
	}
    else if (!strcmp(type, "pos", true))
	{
	   	EditDynamicObject(playerid, GateData[id][gateObject]);

		PlayerData[playerid][pEditGate] = 1;
		PlayerData[playerid][pEditType] = EDIT_GATE;
		PlayerData[playerid][pEditing] = id;

		SendServerMessage(playerid, "You are now adjusting the position of gate ID: %d.", id);
		return 1;
	}
	else if (!strcmp(type, "move", true))
	{
	   	EditDynamicObject(playerid, GateData[id][gateObject]);

		PlayerData[playerid][pEditGate] = 2;
		PlayerData[playerid][pEditType] = EDIT_GATE;
		PlayerData[playerid][pEditing] = id;

		SendServerMessage(playerid, "You are now adjusting the moving position of gate ID: %d.", id);
		return 1;
	}
	else if (!strcmp(type, "linkid", true))
	{
	    static
	        linkid = -1;

		if (sscanf(string, "d", linkid))
		    return SendSyntaxMessage(playerid, "/editgate [id] [linkid] [gate link] (-1 for none)");

        if ((linkid < -1 || linkid >= MAX_GATES) || (linkid != -1 && !GateData[linkid][gateExists]))
	    	return SendErrorMessage(playerid, "You have specified an invalid gate ID.");

        GateData[id][gateLinkID] = (linkid == -1) ? (-1) : (GateData[linkid][gateID]);
		Gate_Save(id);

		if (id == -1)
			SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has adjusted the faction of gate ID: %d to no gate.", PlayerData[playerid][pUCP], id);

		else
		    SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has adjusted the faction of gate ID: %d to ID: %d.", PlayerData[playerid][pUCP], id, linkid);

		return 1;
	}
	else if (!strcmp(type, "faction", true))
	{
	    static
	        factionid = -1;

		if (sscanf(string, "d", factionid))
		    return SendSyntaxMessage(playerid, "/editgate [id] [faction] [gate faction] (-1 for none)");

        if ((factionid < -1 || factionid >= MAX_FACTIONS) || (factionid != -1 && !FactionData[factionid][factionExists]))
	    	return SendErrorMessage(playerid, "You have specified an invalid faction ID.");

        GateData[id][gateFaction] = (factionid == -1) ? (-1) : (FactionData[factionid][factionID]);
		Gate_Save(id);

		if (factionid == -1)
			SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has adjusted the faction of gate ID: %d to no faction.", PlayerData[playerid][pUCP], id);

		else
		    SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has adjusted the faction of gate ID: %d to \"%s\".", PlayerData[playerid][pUCP], id, FactionData[factionid][factionName]);

		return 1;
	}
	else if (!strcmp(type, "pass", true))
	{
	    static
	        pass[32];

		if (sscanf(string, "s[32]", pass))
		    return SendSyntaxMessage(playerid, "/editgate [id] [pass] [gate password] (Use 'none' to disable)");

		if (!strcmp(params, "none", true))
			GateData[id][gatePass][0] = 0;

		else format(GateData[id][gatePass], 32, pass);

		Gate_Save(id);
		SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has adjusted the password of gate ID: %d to %s.", PlayerData[playerid][pUCP], id, pass);
		return 1;
	}
	return 1;
}
