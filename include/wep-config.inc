#if defined _inc_wep_config
    #undef _inc_wep_config
#endif

#if defined _wepconfig_included
    #endinput
#endif
#define _wepconfig_included

//Library
#include <a_samp>

//Include Define
#define RWC_BODY_PART_TORSO                 (3)
#define RWC_BODY_PART_GROIN                 (4)
#define RWC_BODY_PART_RIGHT_ARM             (6)
#define RWC_BODY_PART_LEFT_ARM              (5)
#define RWC_BODY_PART_RIGHT_LEG             (8)
#define RWC_BODY_PART_LEFT_LEG              (7)
#define RWC_BODY_PART_HEAD                  (9)

//Global Variable
enum RWC_PLAYER_FLAG {
    rwc_head,
    rwc_torso,
    rwc_leftarm,
    rwc_rightarm,
    rwc_leftleg,
    rwc_rightleg,
    rwc_groin
};

static rwc_PlayerData[MAX_PLAYERS][RWC_PLAYER_FLAG];

//Include Function
stock static rwc_GetFlagHead(playerid)
{
	return rwc_PlayerData[playerid][rwc_head];
}

stock static rwc_SetFlagHead(playerid, status)
{
	if(status)
		return rwc_PlayerData[playerid][rwc_head] = true;
	else
	    return rwc_PlayerData[playerid][rwc_head] = false;
}

stock static rwc_GetFlagTorso(playerid)
{
	return rwc_PlayerData[playerid][rwc_torso];
}

stock static rwc_SetFlagTorso(playerid, status)
{
	if(status)
		return rwc_PlayerData[playerid][rwc_torso] = true;
	else
	    return rwc_PlayerData[playerid][rwc_torso] = false;
}


stock static rwc_GetFlagLA(playerid)
{
	return rwc_PlayerData[playerid][rwc_leftarm];
}

stock static rwc_SetFlagLA(playerid, status)
{
	if(status)
		return rwc_PlayerData[playerid][rwc_leftarm] = true;
	else
	    return rwc_PlayerData[playerid][rwc_leftarm] = false;
}


stock static rwc_GetFlagRA(playerid)
{
	return rwc_PlayerData[playerid][rwc_rightarm];
}

stock static rwc_SetFlagRA(playerid, status)
{
	if(status)
		return rwc_PlayerData[playerid][rwc_rightarm] = true;
	else
	    return rwc_PlayerData[playerid][rwc_rightarm] = false;
}


stock static rwc_GetFlagLL(playerid)
{
	return rwc_PlayerData[playerid][rwc_leftleg];
}

stock static rwc_SetFlagLL(playerid, status)
{
	if(status)
		return rwc_PlayerData[playerid][rwc_leftleg] = true;
	else
	    return rwc_PlayerData[playerid][rwc_leftleg] = false;
}


stock static rwc_GetFlagRL(playerid)
{
	return rwc_PlayerData[playerid][rwc_rightleg];
}

stock static rwc_SetFlagRL(playerid, status)
{
	if(status)
		return rwc_PlayerData[playerid][rwc_rightleg] = true;
	else
	    return rwc_PlayerData[playerid][rwc_rightleg] = false;
}


stock static rwc_GetFlagGroin(playerid)
{
	return rwc_PlayerData[playerid][rwc_groin];
}

stock static rwc_SetFlagGroin(playerid, status)
{
	if(status)
		return rwc_PlayerData[playerid][rwc_groin] = true;
	else
	    return rwc_PlayerData[playerid][rwc_groin] = false;
}

//Function Prototype
forward OnPlayerShootHead(playerid, targetid, Float:amount, weaponid);
forward OnPlayerShootTorso(playerid, targetid, Float:amount, weaponid);
forward OnPlayerShootRightArm(playerid, targetid, Float:amount, weaponid);
forward OnPlayerShootLeftArm(playerid, targetid, Float:amount, weaponid);
forward OnPlayerShootRightLeg(playerid, targetid, Float:amount, weaponid);
forward OnPlayerShootLeftLeg(playerid, targetid, Float:amount, weaponid);
forward OnPlayerShootGroin(playerid, targetid, Float:amount, weaponid);


stock IsBulletHitHead(playerid)
{
    return rwc_GetFlagHead(playerid);
}

stock IsBulletHitTorso(playerid)
{
    return rwc_GetFlagTorso(playerid);
}

stock IsBulletHitLeftArm(playerid)
{
    return rwc_GetFlagLA(playerid);
}

stock IsBulletHitRightArm(playerid)
{
    return rwc_GetFlagRA(playerid);
}

stock IsBulletHitRightLeg(playerid)
{
    return rwc_GetFlagRL(playerid);
}

stock IsBulletHitLeftLeg(playerid)
{
    return rwc_GetFlagLL(playerid);
}


stock IsBulletHitGroin(playerid)
{
    return rwc_GetFlagLL(playerid);
}

//Timers

forward rwc_ResetFlag(playerid);
public rwc_ResetFlag(playerid)
{
    if(rwc_GetFlagHead(playerid))
        rwc_SetFlagHead(playerid, false);

    if(rwc_GetFlagTorso(playerid))
        rwc_SetFlagTorso(playerid, false);

    if(rwc_GetFlagRA(playerid))
        rwc_SetFlagRA(playerid, false);

    if(rwc_GetFlagRL(playerid))
        rwc_SetFlagRL(playerid, false);

    if(rwc_GetFlagLL(playerid))
        rwc_SetFlagLL(playerid, false);

    if(rwc_GetFlagLA(playerid))
        rwc_SetFlagLA(playerid, false);

    if(rwc_GetFlagGroin(playerid))
        rwc_SetFlagGroin(playerid, false);
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
    if(issuerid != INVALID_PLAYER_ID)
    {
        switch(bodypart)
        {
            case RWC_BODY_PART_HEAD: 
            {
                CallRemoteFunction("OnPlayerShootHead", "ddfd", issuerid, playerid, amount, weaponid);
                rwc_SetFlagHead(playerid, true);
            }
            case RWC_BODY_PART_TORSO: 
            {
                CallRemoteFunction("OnPlayerShootTorso", "ddfd", issuerid, playerid, amount, weaponid);
                rwc_SetFlagTorso(playerid, true);
            }
            case RWC_BODY_PART_LEFT_ARM: 
            {
                CallRemoteFunction("OnPlayerShootLeftArm", "ddfd", issuerid, playerid, amount, weaponid);
                rwc_SetFlagLA(playerid, true);
            }
            case RWC_BODY_PART_LEFT_LEG: 
            {
                CallRemoteFunction("OnPlayerShootLeftLeg", "ddfd", issuerid, playerid, amount, weaponid);
                rwc_SetFlagLL(playerid, true);
            }
            case RWC_BODY_PART_RIGHT_ARM: 
            {
                CallRemoteFunction("OnPlayerShootRightArm", "ddfd", issuerid, playerid, amount, weaponid);
                rwc_SetFlagRA(playerid, true);
            }
            case RWC_BODY_PART_RIGHT_LEG: 
            {
                CallRemoteFunction("OnPlayerShootRightLeg", "ddfd", issuerid, playerid, amount, weaponid);
                rwc_SetFlagRL(playerid, true);
            }
            case RWC_BODY_PART_GROIN: 
            {
                CallRemoteFunction("OnPlayerShootGroin", "ddfd", issuerid, playerid, amount, weaponid);
                rwc_SetFlagGroin(playerid, true);
            }
        }
        SetTimerEx("rwc_ResetFlag", 200, false, "i", playerid);
    }
    #if defined rwc_OnPlayerTakeDamage
        return rwc_OnPlayerTakeDamage(playerid, issuerid, amount, weaponid, bodypart);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerTakeDamage
    #undef OnPlayerTakeDamage
#else
    #define _ALS_OnPlayerTakeDamage
#endif
#define OnPlayerTakeDamage rwc_OnPlayerTakeDamage
#if defined rwc_OnPlayerTakeDamage
    forward rwc_OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart);
#endif

