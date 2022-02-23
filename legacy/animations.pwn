stock AnimationCheck(playerid)
{
	return (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && !PlayerData[playerid][pCuffed] && !PlayerData[playerid][pTazed]);
}

stock ApplyAnimationEx(playerid, animlib[], animname[], Float:fDelta, loop, lockx, locky, freeze, time, forcesync = 0)
{
	ApplyAnimation(playerid, animlib, animname, fDelta, loop, lockx, locky, freeze, time, forcesync);

	PlayerData[playerid][pLoopAnim] = true;
	ShowMessage(playerid, "Press ~r~SPACE ~w~to stop animation", 3);

	return 1;
}

CMD:animlist(playerid, params[])
{
	SendClientMessage(playerid, COLOR_SERVER, "ANIMATION:{FFFFFF} /dance, /handsup, /bat, /slap, /bar, /wash, /lay, /workout, /blowjob, /bomb.");
	SendClientMessage(playerid, COLOR_SERVER, "ANIMATION:{FFFFFF} /carry, /crack, /sleep, /jump, /deal, /dancing, /eating, /puke, /gsign, /chat.");
	SendClientMessage(playerid, COLOR_SERVER, "ANIMATION:{FFFFFF} /goggles, /spray, /throw, /swipe, /office, /kiss, /knife, /cpr, /scratch, /point.");
	SendClientMessage(playerid, COLOR_SERVER, "ANIMATION:{FFFFFF} /cheer, /wave, /strip, /smoke, /reload, /taichi, /wank, /cower, /skate, /drunk.");
	SendClientMessage(playerid, COLOR_SERVER, "ANIMATION:{FFFFFF} /cry, /tired, /sit, /crossarms, /fucku, /walk, /piss, /sa, /anim");
	return 1;
}

CMD:stopanim(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You don't need to use this command right now.");

	if(IsValidLoading(playerid))
		return SendErrorMessage(playerid, "You don't need to use this command right now.");
	ClearAnimations(playerid, 1);

	PlayerData[playerid][pLoopAnim] = false;
	SendServerMessage(playerid, "You have stopped any animations.");
	return 1;
}

stock PlayAnimation(playerid, animlib[], animname[])
{
	ShowMessage(playerid, "Press ~r~SPACE ~w~to stop animation", 1);
	ApplyAnimation(playerid, animlib, animname, 4.0, 1, 0, 0, 0, 0);
	return 1;
}
CMD:anim(playerid, params[])
{
	new
	animlib[32], animname[32],
	iAnimIndex;
	
	if(sscanf(params, "d", iAnimIndex))
	    return SendSyntaxMessage(playerid, "/anim [index]");
	    
	if(iAnimIndex < 1 || iAnimIndex > 1812)
		return SendClientMessage(playerid, COLOR_GREY, "Animation Index: {FFFFFF}(Index 1-1812)");
	else
	{
		GetAnimationName(iAnimIndex, animlib, 32, animname, 32);
		PlayAnimation(playerid, animlib, animname);
		PlayerData[playerid][pLoopAnim] = true;
	}
	return 1;
}

CMD:bat(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendSyntaxMessage(playerid, "/bat [1-5]");

	if (type < 1 || type > 5)
	    return SendErrorMessage(playerid, "Invalid type specified.");

    ShowMessage(playerid, "Press ~r~SPACE ~w~to stop animation", 3);
	switch (type)
	{
	    case 1: ApplyAnimation(playerid, "BASEBALL", "Bat_1", 4.1, 0, 1, 1, 0, 0, 1);
	    case 2: ApplyAnimation(playerid, "BASEBALL", "Bat_2", 4.1, 0, 1, 1, 0, 0, 1);
	    case 3: ApplyAnimation(playerid, "BASEBALL", "Bat_3", 4.1, 0, 1, 1, 0, 0, 1);
	    case 4: ApplyAnimation(playerid, "BASEBALL", "Bat_4", 4.1, 0, 0, 0, 0, 0, 1);
	    case 5: ApplyAnimationEx(playerid, "BASEBALL", "Bat_IDLE", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:slap(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "BASEBALL", "Bat_M", 4.1, 0, 0, 0, 0, 0, 1);
	ShowMessage(playerid, "Press ~r~SPACE ~w~to stop animation", 3);
	return 1;
}

CMD:bar(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendSyntaxMessage(playerid, "/bar [1-8]");

	if (type < 1 || type > 8)
	    return SendErrorMessage(playerid, "Invalid type specified.");

    ShowMessage(playerid, "Press ~r~SPACE ~w~to stop animation", 3);
	switch (type)
	{
	    case 1: ApplyAnimation(playerid, "BAR", "Barserve_bottle", 4.1, 0, 0, 0, 0, 0, 1);
	    case 2: ApplyAnimation(playerid, "BAR", "Barserve_give", 4.1, 0, 0, 0, 0, 0, 1);
	    case 3: ApplyAnimation(playerid, "BAR", "Barserve_glass", 4.1, 0, 0, 0, 0, 0, 1);
	    case 4: ApplyAnimation(playerid, "BAR", "Barserve_in", 4.1, 0, 0, 0, 0, 0, 1);
	    case 5: ApplyAnimation(playerid, "BAR", "Barserve_order", 4.1, 0, 0, 0, 0, 0, 1);
	    case 6: ApplyAnimationEx(playerid, "BAR", "BARman_idle", 4.1, 1, 0, 0, 0, 0, 1);
	    case 7: ApplyAnimationEx(playerid, "BAR", "dnk_stndM_loop", 4.1, 0, 0, 0, 0, 0, 1);
	    case 8: ApplyAnimationEx(playerid, "BAR", "dnk_stndF_loop", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:wash(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 1, 1, 1, 1, 0, 1);
	ShowMessage(playerid, "Press ~r~SPACE ~w~to stop animation", 3);
	return 1;
}

stock OnePlayAnim(playerid,animlib[],animname[], Float:Speed, looping, lockx, locky, freeze, lp)
{
	ApplyAnimation(playerid, animlib, animname, Speed, looping, lockx, locky, freeze, lp, 1);
}

stock LoopingAnimEx(playerid,animlib[],animname[], Float:Speed, looping, lockx, locky, freeze, lp)
{
    ShowMessage(playerid, "Press ~r~SPACE ~w~to stop animation", 3);
	ApplyAnimation(playerid, animlib, animname, Speed, looping, lockx, locky, freeze, lp, 1);
}

FUNC::CarAnim1(playerid)
{
	LoopingAnimEx(playerid, "CAR", "Fixn_Car_Out", 4.1, 0, 1, 1, 1, 1);
	return true;
}
FUNC::CarAnim2(playerid)
{
	LoopingAnimEx(playerid,"CAR", "Fixn_Car_Loop", 4.0, 1, 0, 0, 0, 0);
	return true;
}

CMD:car(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
		return SendClientMessage(playerid, COLOR_RED, "You must be on-foot to perform this animation.");
		
	if(isnull(params))
		return SendSyntaxMessage(playerid,"/car [1-3]");

	switch(strval(params))
	{
		case 1:
		{
			ClearAnimations(playerid);
			LoopingAnimEx(playerid, "CAR", "Fixn_Car_Out", 4.1, 0, 1, 1, 1, 1); 
			SetTimerEx("CarAnim1", 125, false, "i", playerid);
			SetTimerEx("CarAnim2", 1500, false, "i", playerid);
		}
		case 2: LoopingAnimEx(playerid, "CAR", "Fixn_Car_Out", 4.1, 0, 1, 1, 1, 1);
		case 3: LoopingAnimEx(playerid, "CAR", "flag_drop", 4.1, 0, 1, 1, 1, 1);
		default: SendSyntaxMessage(playerid,"/car [1-3]");
	}
	return true;
}

CMD:cop(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
		return SendClientMessage(playerid, COLOR_RED, "You must be on-foot to perform this animation.");

	if(isnull(params))
		return SendSyntaxMessage(playerid,"/cop [1-4]");
		
	switch(strval(params))
	{
		case 1: PlayAnimation(playerid, "POLICE","CopTraf_Come");
		case 2: PlayAnimation(playerid, "POLICE","CopTraf_Away");
		case 3: PlayAnimation(playerid, "POLICE","CopTraf_Stop");
		case 4: PlayAnimation(playerid,  "POLICE","CopTraf_Left");
		default: SendSyntaxMessage(playerid,"/cop [1-4]");
	}
	return true;
}

CMD:lay(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendSyntaxMessage(playerid, "/lay [1-5]");

	if (type < 1 || type > 5)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "BEACH", "bather", 4.1, 1, 0, 0, 0, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "BEACH", "Lay_Bac_Loop", 4.1, 1, 0, 0, 0, 0, 1);
	    case 3: ApplyAnimationEx(playerid, "BEACH", "ParkSit_M_loop", 4.1, 1, 0, 0, 0, 0, 1);
	    case 4: ApplyAnimationEx(playerid, "BEACH", "ParkSit_W_loop", 4.1, 1, 0, 0, 0, 0, 1);
	    case 5: ApplyAnimationEx(playerid, "BEACH", "SitnWait_loop_W", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:workout(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendSyntaxMessage(playerid, "/workout [1-7]");

	if (type < 1 || type > 7)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimation(playerid, "benchpress", "gym_bp_celebrate", 4.1, 0, 0, 0, 0, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "benchpress", "gym_bp_down", 4.1, 0, 0, 0, 1, 0, 1);
	    case 3: ApplyAnimation(playerid, "benchpress", "gym_bp_getoff", 4.1, 0, 0, 0, 0, 0, 1);
	    case 4: ApplyAnimationEx(playerid, "benchpress", "gym_bp_geton", 4.1, 0, 0, 0, 1, 0, 1);
	    case 5: ApplyAnimationEx(playerid, "benchpress", "gym_bp_up_A", 4.1, 0, 0, 0, 1, 0, 1);
	    case 6: ApplyAnimationEx(playerid, "benchpress", "gym_bp_up_B", 4.1, 0, 0, 0, 1, 0, 1);
	    case 7: ApplyAnimationEx(playerid, "benchpress", "gym_bp_up_smooth", 4.1, 0, 0, 0, 1, 0, 1);
	}
	return 1;
}

CMD:blowjob(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendSyntaxMessage(playerid, "/blowjob [1-4]");

	if (type < 1 || type > 4)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "BLOWJOBZ", "BJ_COUCH_LOOP_W", 4.1, 1, 0, 0, 0, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "BLOWJOBZ", "BJ_COUCH_LOOP_P", 4.1, 1, 0, 0, 0, 0, 1);
	    case 3: ApplyAnimationEx(playerid, "BLOWJOBZ", "BJ_STAND_LOOP_W", 4.1, 1, 0, 0, 0, 0, 1);
	    case 4: ApplyAnimationEx(playerid, "BLOWJOBZ", "BJ_STAND_LOOP_P", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:bomb(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:carry(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendSyntaxMessage(playerid, "/carry [1-6]");

	if (type < 1 || type > 6)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimation(playerid, "CARRY", "liftup", 4.1, 0, 0, 0, 0, 0, 1);
	    case 2: ApplyAnimation(playerid, "CARRY", "liftup05", 4.1, 0, 0, 0, 0, 0, 1);
	    case 3: ApplyAnimation(playerid, "CARRY", "liftup105", 4.1, 0, 0, 0, 0, 0, 1);
	    case 4: ApplyAnimation(playerid, "CARRY", "putdwn", 4.1, 0, 0, 0, 0, 0, 1);
	    case 5: ApplyAnimation(playerid, "CARRY", "putdwn05", 4.1, 0, 0, 0, 0, 0, 1);
	    case 6: ApplyAnimation(playerid, "CARRY", "putdwn105", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:crack(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendSyntaxMessage(playerid, "/crack [1-6]");

	if (type < 1 || type > 6)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "CRACK", "crckdeth1", 4.1, 0, 0, 0, 1, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "CRACK", "crckdeth2", 4.1, 1, 0, 0, 0, 0, 1);
	    case 3: ApplyAnimationEx(playerid, "CRACK", "crckdeth3", 4.1, 0, 0, 0, 1, 0, 1);
	    case 4: ApplyAnimationEx(playerid, "CRACK", "crckidle1", 4.1, 0, 0, 0, 1, 0, 1);
	    case 5: ApplyAnimationEx(playerid, "CRACK", "crckidle2", 4.1, 0, 0, 0, 1, 0, 1);
	    case 6: ApplyAnimationEx(playerid, "CRACK", "crckidle3", 4.1, 0, 0, 0, 1, 0, 1);
	}
	return 1;
}

CMD:sleep(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendSyntaxMessage(playerid, "/sleep [1-2]");

	if (type < 1 || type > 2)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "CRACK", "crckdeth4", 4.1, 0, 0, 0, 1, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "CRACK", "crckidle4", 4.1, 0, 0, 0, 1, 0, 1);
	}
	return 1;
}

CMD:jump(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "DODGE", "Crush_Jump", 4.1, 0, 1, 1, 0, 0, 1);
	return 1;
}

CMD:deal(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendSyntaxMessage(playerid, "/deal [1-6]");

	if (type < 1 || type > 6)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimation(playerid, "DEALER", "DEALER_DEAL", 4.1, 0, 0, 0, 0, 0, 1);
	    case 2: ApplyAnimation(playerid, "DEALER", "DRUGS_BUY", 4.1, 0, 0, 0, 0, 0, 1);
	    case 3: ApplyAnimation(playerid, "DEALER", "shop_pay", 4.1, 0, 0, 0, 0, 0, 1);
	    case 4: ApplyAnimationEx(playerid, "DEALER", "DEALER_IDLE_01", 4.1, 1, 0, 0, 0, 0, 1);
	    case 5: ApplyAnimationEx(playerid, "DEALER", "DEALER_IDLE_02", 4.1, 1, 0, 0, 0, 0, 1);
	    case 6: ApplyAnimationEx(playerid, "DEALER", "DEALER_IDLE_03", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:handsup(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_HANDSUP);
	return 1;
}

CMD:piss(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	SetPlayerSpecialAction(playerid, 68);
	return 1;
}

CMD:dance(playerid, params[])
{
	new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendSyntaxMessage(playerid, "/dance [1-4]");

	if (type < 1 || type > 4)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
		case 1: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE1);
	    case 2: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE2);
	    case 3: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE3);
	    case 4: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE4);
	}
	return 1;
}

CMD:dancing(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendSyntaxMessage(playerid, "/dancing [1-10]");

	if (type < 1 || type > 10)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "DANCING", "dance_loop", 4.1, 1, 0, 0, 0, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "DANCING", "DAN_Left_A", 4.1, 1, 0, 0, 0, 0, 1);
	    case 3: ApplyAnimationEx(playerid, "DANCING", "DAN_Right_A", 4.1, 1, 0, 0, 0, 0, 1);
	    case 4: ApplyAnimationEx(playerid, "DANCING", "DAN_Loop_A", 4.1, 1, 0, 0, 0, 0, 1);
	    case 5: ApplyAnimationEx(playerid, "DANCING", "DAN_Up_A", 4.1, 1, 0, 0, 0, 0, 1);
	    case 6: ApplyAnimationEx(playerid, "DANCING", "DAN_Down_A", 4.1, 1, 0, 0, 0, 0, 1);
	    case 7: ApplyAnimationEx(playerid, "DANCING", "dnce_M_a", 4.1, 1, 0, 0, 0, 0, 1);
	    case 8: ApplyAnimationEx(playerid, "DANCING", "dnce_M_e", 4.1, 1, 0, 0, 0, 0, 1);
	    case 9: ApplyAnimationEx(playerid, "DANCING", "dnce_M_b", 4.1, 1, 0, 0, 0, 0, 1);
	    case 10: ApplyAnimationEx(playerid, "DANCING", "dnce_M_c", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:eating(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendSyntaxMessage(playerid, "/eating [1-3]");

	if (type < 1 || type > 3)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 0, 0, 0, 0, 0, 1);
	    case 2: ApplyAnimation(playerid, "FOOD", "EAT_Chicken", 4.1, 0, 0, 0, 0, 0, 1);
	    case 3: ApplyAnimation(playerid, "FOOD", "EAT_Pizza", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:puke(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "FOOD", "EAT_Vomit_P", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:salute(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");
	    
    ApplyAnimation(playerid, "GHANDS", "gsign5LH", 4.1, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:gsign(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendSyntaxMessage(playerid, "/gsign [1-15]");

	if (type < 1 || type > 15)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
		case 1: ApplyAnimation(playerid, "GHANDS", "gsign1", 4.1, 0, 0, 0, 0, 0, 1);
		case 2: ApplyAnimation(playerid, "GHANDS", "gsign1LH", 4.1, 0, 0, 0, 0, 0, 1);
		case 3: ApplyAnimation(playerid, "GHANDS", "gsign2", 4.1, 0, 0, 0, 0, 0, 1);
		case 4: ApplyAnimation(playerid, "GHANDS", "gsign2LH", 4.1, 0, 0, 0, 0, 0, 1);
		case 5: ApplyAnimation(playerid, "GHANDS", "gsign3", 4.1, 0, 0, 0, 0, 0, 1);
		case 6: ApplyAnimation(playerid, "GHANDS", "gsign3LH", 4.1, 0, 0, 0, 0, 0, 1);
		case 7: ApplyAnimation(playerid, "GHANDS", "gsign4", 4.1, 0, 0, 0, 0, 0, 1);
		case 8: ApplyAnimation(playerid, "GHANDS", "gsign4LH", 4.1, 0, 0, 0, 0, 0, 1);
		case 9: ApplyAnimation(playerid, "GHANDS", "gsign5", 4.1, 0, 0, 0, 0, 0, 1);
		case 10: ApplyAnimation(playerid, "GHANDS", "gsign5", 4.1, 0, 0, 0, 0, 0, 1);
		case 11: ApplyAnimation(playerid, "GHANDS", "gsign5LH", 4.1, 0, 0, 0, 0, 0, 1);
		case 12: ApplyAnimation(playerid, "GANGS", "Invite_No", 4.1, 0, 0, 0, 0, 0, 1);
		case 13: ApplyAnimation(playerid, "GANGS", "Invite_Yes", 4.1, 0, 0, 0, 0, 0, 1);
		case 14: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkD", 4.1, 0, 0, 0, 0, 0, 1);
		case 15: ApplyAnimation(playerid, "GANGS", "smkcig_prtl", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:chat(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendSyntaxMessage(playerid, "/chat [1-6]");

	if (type < 1 || type > 6)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
		case 1: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkA", 4.1, 0, 0, 0, 0, 0, 1);
		case 2: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkB", 4.1, 0, 0, 0, 0, 0, 1);
		case 3: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkE", 4.1, 0, 0, 0, 0, 0, 1);
		case 4: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkF", 4.1, 0, 0, 0, 0, 0, 1);
		case 5: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkG", 4.1, 0, 0, 0, 0, 0, 1);
		case 6: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkH", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:goggles(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "goggles", "goggles_put_on", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:spray(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

 	ApplyAnimationEx(playerid, "GRAFFITI", "spraycan_fire", 4.1, 1, 0, 0, 0, 0, 1);
	return 1;
}

CMD:throw(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "GRENADE", "WEAPON_throw", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:swipe(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "HEIST9", "Use_SwipeCard", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:office(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendSyntaxMessage(playerid, "/office [1-6]");

	if (type < 1 || type > 6)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
		case 1: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Bored_Loop", 4.1, 1, 0, 0, 0, 0, 1);
		case 2: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Crash", 4.1, 1, 0, 0, 0, 0, 1);
		case 3: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Drink", 4.1, 1, 0, 0, 0, 0, 1);
		case 4: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Read", 4.1, 1, 0, 0, 0, 0, 1);
		case 5: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Type_Loop", 4.1, 1, 0, 0, 0, 0, 1);
		case 6: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Watch", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:kiss(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendSyntaxMessage(playerid, "/kiss [1-6]");

	if (type < 1 || type > 6)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
		case 1: ApplyAnimation(playerid, "KISSING", "Grlfrd_Kiss_01", 4.1, 0, 0, 0, 0, 0, 1);
		case 2: ApplyAnimation(playerid, "KISSING", "Grlfrd_Kiss_02", 4.1, 0, 0, 0, 0, 0, 1);
		case 3: ApplyAnimation(playerid, "KISSING", "Grlfrd_Kiss_03", 4.1, 0, 0, 0, 0, 0, 1);
		case 4: ApplyAnimation(playerid, "KISSING", "Playa_Kiss_01", 4.1, 0, 0, 0, 0, 0, 1);
		case 5: ApplyAnimation(playerid, "KISSING", "Playa_Kiss_02", 4.1, 0, 0, 0, 0, 0, 1);
		case 6: ApplyAnimation(playerid, "KISSING", "Playa_Kiss_03", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:knife(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendSyntaxMessage(playerid, "/knife [1-8]");

	if (type < 1 || type > 8)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
		case 1: ApplyAnimation(playerid, "KNIFE", "knife_1", 4.1, 0, 1, 1, 0, 0, 1);
		case 2: ApplyAnimation(playerid, "KNIFE", "knife_2", 4.1, 0, 1, 1, 0, 0, 1);
		case 3: ApplyAnimation(playerid, "KNIFE", "knife_3", 4.1, 0, 1, 1, 0, 0, 1);
		case 4: ApplyAnimation(playerid, "KNIFE", "knife_4", 4.1, 0, 1, 1, 0, 0, 1);
		case 5: ApplyAnimationEx(playerid, "KNIFE", "WEAPON_knifeidle", 4.1, 1, 0, 0, 0, 0, 1);
		case 6: ApplyAnimation(playerid, "KNIFE", "KILL_Knife_Player", 4.1, 0, 0, 0, 0, 0, 1);
		case 7: ApplyAnimation(playerid, "KNIFE", "KILL_Knife_Ped_Damage", 4.1, 0, 0, 0, 0, 0, 1);
		case 8: ApplyAnimation(playerid, "KNIFE", "KILL_Knife_Ped_Die", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:cpr(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "MEDIC", "CPR", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:scratch(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendSyntaxMessage(playerid, "/scratch [1-4]");

	if (type < 1 || type > 4)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
    	case 1: ApplyAnimationEx(playerid, "SCRATCHING", "scdldlp", 4.1, 1, 0, 0, 0, 0, 1);
		case 2: ApplyAnimationEx(playerid, "SCRATCHING", "scdlulp", 4.1, 1, 0, 0, 0, 0, 1);
		case 3: ApplyAnimationEx(playerid, "SCRATCHING", "scdrdlp", 4.1, 1, 0, 0, 0, 0, 1);
		case 4: ApplyAnimationEx(playerid, "SCRATCHING", "scdrulp", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:point(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendSyntaxMessage(playerid, "/point [1-4]");

	if (type < 1 || type > 4)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "PED", "ARRESTgun", 4.1, 0, 0, 0, 1, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "SHOP", "ROB_Loop_Threat", 4.1, 1, 0, 0, 0, 0, 1);
    	case 3: ApplyAnimationEx(playerid, "ON_LOOKERS", "point_loop", 4.1, 1, 0, 0, 0, 0, 1);
		case 4: ApplyAnimationEx(playerid, "ON_LOOKERS", "Pointup_loop", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:cheer(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendSyntaxMessage(playerid, "/cheer [1-8]");

	if (type < 1 || type > 8)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
		case 1: ApplyAnimation(playerid, "ON_LOOKERS", "shout_01", 4.1, 0, 0, 0, 0, 0, 1);
		case 2: ApplyAnimation(playerid, "ON_LOOKERS", "shout_02", 4.1, 0, 0, 0, 0, 0, 1);
		case 3: ApplyAnimation(playerid, "ON_LOOKERS", "shout_in", 4.1, 0, 0, 0, 0, 0, 1);
		case 4: ApplyAnimationEx(playerid, "RIOT", "RIOT_ANGRY_B", 4.1, 1, 0, 0, 0, 0, 1);
		case 5: ApplyAnimation(playerid, "RIOT", "RIOT_CHANT", 4.1, 0, 0, 0, 0, 0, 1);
		case 6: ApplyAnimation(playerid, "RIOT", "RIOT_shout", 4.1, 0, 0, 0, 0, 0, 1);
		case 7: ApplyAnimation(playerid, "STRIP", "PUN_HOLLER", 4.1, 0, 0, 0, 0, 0, 1);
		case 8: ApplyAnimation(playerid, "OTB", "wtchrace_win", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:strip(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendSyntaxMessage(playerid, "/strip [1-7]");

	if (type < 1 || type > 7)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
		case 1: ApplyAnimationEx(playerid, "STRIP", "strip_A", 4.1, 1, 0, 0, 0, 0, 1);
		case 2: ApplyAnimationEx(playerid, "STRIP", "strip_B", 4.1, 1, 0, 0, 0, 0, 1);
		case 3: ApplyAnimationEx(playerid, "STRIP", "strip_C", 4.1, 1, 0, 0, 0, 0, 1);
		case 4: ApplyAnimationEx(playerid, "STRIP", "strip_D", 4.1, 1, 0, 0, 0, 0, 1);
		case 5: ApplyAnimationEx(playerid, "STRIP", "strip_E", 4.1, 1, 0, 0, 0, 0, 1);
		case 6: ApplyAnimationEx(playerid, "STRIP", "strip_F", 4.1, 1, 0, 0, 0, 0, 1);
		case 7: ApplyAnimationEx(playerid, "STRIP", "strip_G", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:wave(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendSyntaxMessage(playerid, "/wave [1-3]");

	if (type < 1 || type > 3)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimation(playerid, "PED", "endchat_03", 4.1, 0, 0, 0, 0, 0, 1);
	    case 2: ApplyAnimation(playerid, "KISSING", "gfwave2", 4.1, 0, 0, 0, 0, 0, 1);
	    case 3: ApplyAnimationEx(playerid, "ON_LOOKERS", "wave_loop", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:smoke(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendSyntaxMessage(playerid, "/smoke [1-3]");

	if (type < 1 || type > 3)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimation(playerid, "SMOKING", "M_smk_drag", 4.1, 0, 0, 0, 0, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "SMOKING", "M_smklean_loop", 4.1, 1, 0, 0, 0, 0, 1);
	    case 3: ApplyAnimation(playerid, "SMOKING", "M_smkstnd_loop", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:reload(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendSyntaxMessage(playerid, "/reload [1-4]");

	if (type < 1 || type > 4)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
		case 1: ApplyAnimation(playerid, "BUDDY", "buddy_reload", 4.1, 0, 0, 0, 0, 0, 1);
		case 2: ApplyAnimation(playerid, "UZI", "UZI_reload", 4.1, 0, 0, 0, 0, 0, 1);
		case 3: ApplyAnimation(playerid, "COLT45", "colt45_reload", 4.1, 0, 0, 0, 0, 0, 1);
		case 4: ApplyAnimation(playerid, "RIFLE", "rifle_load", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:taichi(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "PARK", "Tai_Chi_Loop", 4.1, 1, 0, 0, 0, 0, 1);
	return 1;
}

CMD:wank(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendSyntaxMessage(playerid, "/wank [1-3]");

	if (type < 1 || type > 3)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
		case 1: ApplyAnimationEx(playerid, "PAULNMAC", "wank_loop", 4.1, 1, 0, 0, 0, 0, 1);
		case 2: ApplyAnimation(playerid, "PAULNMAC", "wank_in", 4.1, 0, 0, 0, 0, 0, 1);
		case 3: ApplyAnimation(playerid, "PAULNMAC", "wank_out", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:cower(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "PED", "cower", 4.1, 0, 0, 0, 1, 0, 1);
	return 1;
}

CMD:skate(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendSyntaxMessage(playerid, "/skate [1-2]");

	if (type < 1 || type > 2)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type)
	{
		case 1: ApplyAnimationEx(playerid, "SKATE", "skate_idle", 4.1, 1, 0, 0, 0, 0, 1);
		case 2: SendClientMessage(playerid, -1, "Nah mau ngapain???");
	}
	return 1;
}

CMD:drunk(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "PED", "WALK_drunk", 4.1, 1, 1, 1, 1, 1, 1);
	return 1;
}

CMD:cry(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "GRAVEYARD", "mrnF_loop", 4.1, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:tired(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendSyntaxMessage(playerid, "/tired [1-2]");

	if (type < 1 || type > 2)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "PED", "IDLE_tired", 4.1, 1, 0, 0, 0, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "FAT", "IDLE_tired", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:sit(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendSyntaxMessage(playerid, "/sit [1-6]");

	if (type < 1 || type > 6)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
		case 1: ApplyAnimationEx(playerid, "CRIB", "PED_Console_Loop", 4.1, 1, 0, 0, 0, 0);
		case 2: ApplyAnimationEx(playerid, "INT_HOUSE", "LOU_In", 4.1, 0, 0, 0, 1, 0);
		case 3: ApplyAnimationEx(playerid, "MISC", "SEAT_LR", 4.1, 1, 0, 0, 0, 0);
		case 4: ApplyAnimationEx(playerid, "MISC", "Seat_talk_01", 4.1, 1, 0, 0, 0, 0);
		case 5: ApplyAnimationEx(playerid, "MISC", "Seat_talk_02", 4.1, 1, 0, 0, 0, 0);
		case 6: ApplyAnimationEx(playerid, "ped", "SEAT_down", 4.1, 0, 0, 0, 1, 0);
	}
	return 1;
}

CMD:crossarms(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendSyntaxMessage(playerid, "/crossarms [1-4]");

	if (type < 1 || type > 4)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "COP_AMBIENT", "Coplook_loop", 4.1, 0, 1, 1, 1, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "GRAVEYARD", "prst_loopa", 4.1, 1, 0, 0, 0, 0, 1);
	    case 3: ApplyAnimationEx(playerid, "GRAVEYARD", "mrnM_loop", 4.1, 1, 0, 0, 0, 0, 1);
	    case 4: ApplyAnimationEx(playerid, "DEALER", "DEALER_IDLE", 4.1, 0, 1, 1, 1, 0, 1);
	}
	return 1;
}

CMD:fucku(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimation(playerid, "PED", "fucku", 4.1, 0, 0, 0, 0, 0);
	return 1;
}

CMD:walk(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendSyntaxMessage(playerid, "/walk [1-16]");

	if (type < 1 || type > 17)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "FAT", "FatWalk", 4.1, 1, 1, 1, 1, 1, 1);
	    case 2: ApplyAnimationEx(playerid, "MUSCULAR", "MuscleWalk", 4.1, 1, 1, 1, 1, 1, 1);
	    case 3: ApplyAnimationEx(playerid, "PED", "WALK_armed", 4.1, 1, 1, 1, 1, 1, 1);
	    case 4: ApplyAnimationEx(playerid, "PED", "WALK_civi", 4.1, 1, 1, 1, 1, 1, 1);
	    case 5: ApplyAnimationEx(playerid, "PED", "WALK_fat", 4.1, 1, 1, 1, 1, 1, 1);
	    case 6: ApplyAnimationEx(playerid, "PED", "WALK_fatold", 4.1, 1, 1, 1, 1, 1, 1);
	    case 7: ApplyAnimationEx(playerid, "PED", "WALK_gang1", 4.1, 1, 1, 1, 1, 1, 1);
	    case 8: ApplyAnimationEx(playerid, "PED", "WALK_gang2", 4.1, 1, 1, 1, 1, 1, 1);
	    case 9: ApplyAnimationEx(playerid, "PED", "WALK_player", 4.1, 1, 1, 1, 1, 1, 1);
	    case 10: ApplyAnimationEx(playerid, "PED", "WALK_old", 4.1, 1, 1, 1, 1, 1, 1);
	    case 11: ApplyAnimationEx(playerid, "PED", "WALK_wuzi", 4.1, 1, 1, 1, 1, 1, 1);
	    case 12: ApplyAnimationEx(playerid, "PED", "WOMAN_walkbusy", 4.1, 1, 1, 1, 1, 1, 1);
	    case 13: ApplyAnimationEx(playerid, "PED", "WOMAN_walkfatold", 4.1, 1, 1, 1, 1, 1, 1);
	    case 14: ApplyAnimationEx(playerid, "PED", "WOMAN_walknorm", 4.1, 1, 1, 1, 1, 1, 1);
	    case 15: ApplyAnimationEx(playerid, "PED", "WOMAN_walksexy", 4.1, 1, 1, 1, 1, 1, 1);
	    case 16: ApplyAnimationEx(playerid, "PED", "WOMAN_walkshop", 4.1, 1, 1, 1, 1, 1, 1);
	}
	return 1;
}
