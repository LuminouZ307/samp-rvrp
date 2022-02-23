new Float:ArrestPoint[][] = 
{
    {1778.5369,-1564.1693,1734.9430},
    {1770.5372,-1563.5914,1734.9430},
    {1761.7734,-1563.6096,1734.9430},
    {1757.6842,-1582.1555,1738.7173},
    {1770.0521,-1564.4563,1738.6935},
    {1769.8129,-1581.5953,1734.9430},
    {1761.7849,-1582.2428,1734.9430}
};

stock SetPlayerArrest(playerid)
{
    new rand = random(7);

    SetPlayerPos(playerid, ArrestPoint[rand][0], ArrestPoint[rand][1], ArrestPoint[rand][2]);

    SetPlayerInterior(playerid, 2);
    ResetWeapons(playerid);
    PlayerTextDrawShow(playerid, JAILTD[playerid]);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
    PlayerData[playerid][pCuffed] = false;
    RemovePlayerAttachedObject(playerid, GetPVarInt(playerid, "Cuff_Index"));
}

FUNC::OnLightFlash(vehicleid)
{
    new panels, doors, lights, tires;
    GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);

    switch(Flash[vehicleid])
    {
    	case 0: UpdateVehicleDamageStatus(vehicleid, panels, doors, 2, tires);

        case 1: UpdateVehicleDamageStatus(vehicleid, panels, doors, 5, tires);

        case 2: UpdateVehicleDamageStatus(vehicleid, panels, doors, 2, tires);

        case 3: UpdateVehicleDamageStatus(vehicleid, panels, doors, 4, tires);

        case 4: UpdateVehicleDamageStatus(vehicleid, panels, doors, 5, tires);

        case 5: UpdateVehicleDamageStatus(vehicleid, panels, doors, 4, tires);
    }
    if(Flash[vehicleid] >=5) Flash[vehicleid] = 0;
    else Flash[vehicleid] ++;
    return 1;
}

CMD:cuff(playerid, params[])
{
    new
        userid;

    if (GetFactionType(playerid) != FACTION_POLICE)
        return SendErrorMessage(playerid, "You must be a police officer.");
        
    if (sscanf(params, "u", userid))
        return SendSyntaxMessage(playerid, "/cuff [playerid/name]");

    if (userid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "That player is disconnected.");

    if (!IsPlayerNearPlayer(playerid, userid, 5.0))
        return SendErrorMessage(playerid, "You must be near this player.");

    if (GetPlayerState(userid) != PLAYER_STATE_ONFOOT)
        return SendErrorMessage(playerid, "The player must be onfoot before you can cuff them.");

    if (PlayerData[userid][pCuffed])
        return SendErrorMessage(playerid, "The player is already cuffed at the moment.");

    static
        string[64];

    PlayerData[userid][pCuffed] = true;

    format(string, sizeof(string), "You've been cuffed by ~r~%s", GetName(playerid));
    ShowMessage(userid, string, 3);
    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s tightens a pair of handcuffs on %s's wrists.", ReturnName(playerid), ReturnName(userid));
    SetPlayerSpecialAction(userid, SPECIAL_ACTION_CUFFED);

    for(new i=MAX_PLAYER_ATTACHED_OBJECTS-1; i!=0; i--)
    {
        if(!IsPlayerAttachedObjectSlotUsed(userid, i))
        {
            SetPlayerArmedWeapon(userid, 0);
            SetPVarInt(userid, "Cuff_Index", i);
            SetPlayerAttachedObject(userid, i, 19418, 6, -0.027999, 0.051999, -0.030000, -18.699926, 0.000000, 104.199928, 1.489999, 3.036000, 1.957999);
            return 1;
        }
    }
    return 1;
}

CMD:seizeweed(playerid, params[])
{
    if (GetFactionType(playerid) != FACTION_POLICE)
        return SendErrorMessage(playerid, "You must be a police officer.");

    new id = Weed_Nearest(playerid);
    if(id == -1)
        return SendErrorMessage(playerid, "You are not in range of any weed.");

    SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s performing seized a plant.", ReturnName(playerid));
    Weed_Delete(id);
    ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0, 1);
    return 1;
}
CMD:uncuff(playerid, params[])
{
    new
        userid;

    if (GetFactionType(playerid) != FACTION_POLICE)
        return SendErrorMessage(playerid, "You must be a police officer.");

    if (sscanf(params, "u", userid))
        return SendSyntaxMessage(playerid, "/uncuff [playerid/name]");

    if (userid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "That player is disconnected.");

    if (!IsPlayerNearPlayer(playerid, userid, 5.0))
        return SendErrorMessage(playerid, "You must be near this player.");

    if (GetPlayerState(userid) != PLAYER_STATE_ONFOOT)
        return SendErrorMessage(playerid, "The player must be onfoot before you can uncuff them.");

    if (!PlayerData[userid][pCuffed])
        return SendErrorMessage(playerid, "The player is not cuffed at the moment.");

    static
        string[64];

    PlayerData[userid][pCuffed] = false;

    format(string, sizeof(string), "You've been uncuffed by ~g~%s", GetName(playerid));
    ShowMessage(userid, string, 3);
    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s taken outs handcuffs from %s's wrists.", ReturnName(playerid), ReturnName(userid));
    RemovePlayerAttachedObject(userid, GetPVarInt(userid, "Cuff_Index"));
    SetPlayerSpecialAction(userid, SPECIAL_ACTION_NONE);
    return 1;
}

CMD:arrest(playerid, params[])
{
    new
        userid,
        time,
        fine[32],
        reason[64];

    if (GetFactionType(playerid) != FACTION_POLICE)
        return SendErrorMessage(playerid, "You must be a officer.");

    if (sscanf(params, "uds[32]s[64]", userid, time, fine, reason))
        return SendSyntaxMessage(playerid, "/arrest [playerid/PartOfName] [minutes] [fine] [reason]");

    if (userid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, userid, 5.0))
        return SendErrorMessage(playerid, "The player is disconnected or not near you.");

    if(userid == playerid)
        return SendErrorMessage(playerid, "You can't arrest yourself.");
        
    if (time < 1 || time > 120)
        return SendErrorMessage(playerid, "The specified time can't be below 1 or above 120.");

    if (!PlayerData[userid][pCuffed])
        return SendErrorMessage(playerid, "The player must be cuffed before an arrest is made.");

    if (!IsPlayerInRangeOfPoint(playerid, 5.0, 1775.4489,-1572.7673,1734.9430))
        return SendErrorMessage(playerid, "You must be near an arrest point.");

    PlayerData[userid][pArrest] = 1;
    PlayerData[userid][pJailTime] = time * 60;
    format(PlayerData[userid][pJailBy], MAX_PLAYER_NAME, GetName(playerid));
    format(PlayerData[userid][pJailReason], 32, reason);

    GiveMoney(userid, -strcash(fine));
    
    SetPlayerArrest(userid);

    SendClientMessageEx(userid, COLOR_SERVER, "ARREST: {FFFFFF}You've been arrested by {FFFF00}%s {FFFFFF}For {FF0000}%d Minutes.", GetName(playerid), time);
    SendClientMessageEx(userid, COLOR_SERVER, "FINE: {FFFFFF}$%s", FormatNumber(strcash(fine)));
    SendFactionMessage(PlayerData[playerid][pFaction], COLOR_RADIO, "ARREST: %s was arrested by %s %s", GetName(userid), Faction_GetRank(playerid), GetName(playerid));
    SendFactionMessage(PlayerData[playerid][pFaction], COLOR_RADIO, "REASON: %s", reason);
    
    new query[512];
    mysql_format(sqlcon, query, sizeof(query), "INSERT INTO arrest(owner, fine, reason, date) VALUES ('%d', '%d', '%s', CURRENT_TIMESTAMP())", PlayerData[userid][pID], fine, reason);
    mysql_tquery(sqlcon, query);
    return 1;
}

CMD:tazer(playerid, params[])
{
    if(GetFactionType(playerid) != FACTION_POLICE)
        return SendErrorMessage(playerid, "This command is only for Los Santos Police Departement!");

    if(!PlayerData[playerid][pTazer])
    {
        
        for(new i=MAX_PLAYER_ATTACHED_OBJECTS-1; i!=0; i--)
        {
            if(!IsPlayerAttachedObjectSlotUsed(playerid, i))
            {
                SetPlayerArmedWeapon(playerid, 0);
                SetPVarInt(playerid, "Tazer_Index", i);
                PlayerData[playerid][pTazer] = true;
                SetPlayerAttachedObject(playerid, i, 18642, 6, 0.06, 0.01, 0.08, 180.0, 0.0, 0.0);
                SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s takes out a tazer from their utility belt.", ReturnName(playerid));
                return 1;
            }
        }
    }
    else
    {
        PlayerData[playerid][pTazer] = false;
        RemovePlayerAttachedObject(playerid, GetPVarInt(playerid, "Tazer_Index"));
        DeletePVar(playerid, "Tazer_Index");
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s puts their tazer into their utility belt.", ReturnName(playerid));
    }
    return 1;
}
