stock ResetDamages(playerid)
{
    for(new i = 0; i < MAX_BODY_PARTS; i++)
    {
        for(new z = 0; z < MAX_WEAPONS; z++) Damage[playerid][i][z] = 0, DamageTime[playerid][i][z] = 0;
    }
    return 1;
}

stock CountDamages(playerid)
{
    new count = 0;
    forex(i, MAX_BODY_PARTS)
    {
        forex(z, MAX_WEAPONS)
        {
            if(Damage[playerid][i][z]) count += Damage[playerid][i][z];
        }
    }
    return count;
}

stock GetBodyPartName(bodypart)
{
    new part[11];
    switch(bodypart)
    {
        case BODY_PART_TORSO: part = "Torso";
        case BODY_PART_GROIN: part = "Groin";
        case BODY_PART_LEFT_ARM: part = "Left Arm";
        case BODY_PART_RIGHT_ARM: part = "Right Arm";
        case BODY_PART_LEFT_LEG: part = "Left Leg";
        case BODY_PART_RIGHT_LEG: part = "Right Leg";
        case BODY_PART_HEAD: part = "Head";
        default: part = "None";
    }
    return part;
}

stock DisplayTemporaryDamages(targetid, playerid)
{
    if(!CountDamages(playerid)) 
    	return SendErrorMessage(targetid, "There is no temporary damages on %s", ReturnName(targetid));

    new gsText[1000];
    format(gsText, sizeof(gsText), "Bullet(s)\tWeapon\tBodypart\n");
    forex(i, MAX_BODY_PARTS)
    {
        forex(z, MAX_WEAPONS)
        {
            if(!Damage[playerid][i][z]) 
            	continue;

            format(gsText, sizeof(gsText), "%s%d\t%s\t%s\n", gsText, Damage[playerid][i][z], ReturnWeaponName(z), GetBodyPartName(i + 3));
        }
    }
    return ShowPlayerDialog(targetid, DIALOG_NONE, DIALOG_STYLE_TABLIST_HEADERS, sprintf("%s temporary damages", ReturnName(playerid)), gsText, "Close", "");
}

CMD:tempdamage(playerid, params[])
{
    if(!PlayerData[playerid][pSpawned])
        return SendErrorMessage(playerid, "You're not spawned.");
        
    new targetid;
    if(sscanf(params, "u", targetid))
        return DisplayTemporaryDamages(playerid, playerid);

    if (targetid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, targetid, 5.0))
        return SendErrorMessage(playerid, "That player is disconnected or not near you.");
        
    DisplayTemporaryDamages(playerid, targetid);
    return 1;   
}
