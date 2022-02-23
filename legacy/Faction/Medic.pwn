new StretcherEquipped[MAX_PLAYERS];
new StretcherHolding[MAX_PLAYERS];
new StretcherPlayerID[MAX_PLAYERS];
new StretcherTimer[MAX_PLAYERS];

FUNC::Float:DistanceBetweenPoints(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2)
{
	return floatadd(floatadd(floatsqroot(floatpower(floatsub(x1,x2),2)),floatsqroot(floatpower(floatsub(y1,y2),2))),floatsqroot(floatpower(floatsub(z1,z2),2)));
}

FUNC::Float:GetXYInFrontOfPlayer(playerid, &Float:X, &Float:Y, Float:distance)
{
	new Float:A;
	GetPlayerPos(playerid, X, Y, A);

	if(IsPlayerInAnyVehicle(playerid)) GetVehicleZAngle(GetPlayerVehicleID(playerid), A);
	else GetPlayerFacingAngle(playerid, A);

	X += (distance * floatsin(-A, degrees));
	Y += (distance * floatcos(-A, degrees));

	return A;
}

stock SpawnStretcher(playerid)
{
	new Float:angle;
	GetPlayerFacingAngle(playerid, angle);
	SetPlayerFacingAngle(playerid, angle + 180);

	AttachDynamicObjectToPlayer(StretcherEquipped[playerid], playerid, 0.0, 1.4, -1.0, 0.0, 0.0, 180.0);

	SendClientMessage(playerid, COLOR_SERVER, "INFO: {FFFFFF}You now have a stretcher. Use /stretcher for actions.");
	return true;
}

FUNC::DestroyStretcher(playerid, objectid)
{
	DestroyDynamicObject(StretcherEquipped[playerid]);
	StretcherTimer[playerid] = -1;
	StretcherEquipped[playerid] = -1;
	StretcherHolding[playerid] = 0;
}

CMD:stretcher(playerid, params[])
{

	if(GetFactionType(playerid) != FACTION_MEDIC)
		return SendErrorMessage(playerid,"You need to be a member of the LSES!");
		
	new action[24], playa = -1, string[128];
	if (sscanf(params, "s[24]S()[128]", action, string))
	{
	    SendSyntaxMessage(playerid, "/stretcher [name]");
	    SendClientMessage(playerid, COLOR_YELLOW, "NAMES:{FFFFFF} equip/drop/pickup/putaway/load/unload/ambulance");
	    return 1;
	}
	new Float:pX,Float:pY,Float:pZ, Float:oX,Float:oY,Float:oZ;
	GetPlayerPos(playerid, pX, pY, pZ);
			
	if(!strcmp(action, "equip", true))
	{
		if(StretcherEquipped[playerid] > 0)
			return SendErrorMessage(playerid,"You already have a stretcher.");
		
		if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 416)
			return SendErrorMessage(playerid,"You must be in the back of an Ambulance to get a stretcher.");

		if(GetPlayerVehicleSeat(playerid) != 2 && GetPlayerVehicleSeat(playerid) != 3)
			return SendErrorMessage(playerid,"You must be in the back of an Ambulance to get a stretcher.");
			
		StretcherEquipped[playerid] = CreateDynamicObject(1997, pX, pY + 1.5, pZ - 1.0, 0.0, 0.0, 100.0);//2146
		StretcherHolding[playerid] = 1;
		RemovePlayerFromVehicle(playerid);
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s pulls a stretcher out of the Ambulance. *",ReturnName(playerid));
	}
	else if(!strcmp(action, "drop", true))
	{
		new Float:pXb, Float:pYb;
		new Float:Ang = GetXYInFrontOfPlayer(playerid, pXb, pYb, 1.7);

		if(StretcherHolding[playerid] == 0)
			return SendErrorMessage(playerid,"You need to have a stretcher.");
		
		if(StretcherPlayerID[playerid] != -1)
			return SendErrorMessage(playerid,"You can not drop the stretcher with someone on it");

		DestroyDynamicObject(StretcherEquipped[playerid]);
		StretcherEquipped[playerid] = CreateDynamicObject(1997, pXb, pYb, pZ-1.0, 0.0, 0.0, Ang+180);
		StretcherHolding[playerid] = 0;
		StretcherTimer[playerid] = SetTimerEx("DestroyStretcher", 300000, 0, "ii", playerid, StretcherEquipped[playerid]);
		Streamer_Update(playerid, STREAMER_TYPE_OBJECT);

		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s locks the wheels of the stretcher in place. *",ReturnName(playerid));
	}
	else if(!strcmp(action, "pickup", true))
	{
		GetDynamicObjectPos(StretcherEquipped[playerid],oX,oY,oZ);
		new Float:distance = DistanceBetweenPoints(pX,pY,pZ,oX,oY,oZ);
		
		if(!IsValidDynamicObject(StretcherEquipped[playerid]))
			return SendErrorMessage(playerid,"You need to have a stretcher.");
		
		if(StretcherPlayerID[playerid] != -1)
			return SendErrorMessage(playerid,"You can not drop the stretcher with someone on it");

		if(StretcherHolding[playerid] == 2)
			return SendErrorMessage(playerid,"You already have a stretcher");
		
		if(distance > 5)
			return SendErrorMessage(playerid,"You aren't close enough");

		KillTimer(StretcherTimer[playerid]);
		StretcherTimer[playerid] = -1;
		StretcherHolding[playerid] = 2;

		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s unlocks the wheels of the stretcher *",ReturnName(playerid));
	}
	else if(!strcmp(action, "putaway", true))
	{
		if(!IsValidDynamicObject(StretcherEquipped[playerid]))
			return SendErrorMessage(playerid,"You do not have a stretcher to put away.");
			
		if(StretcherPlayerID[playerid] >= 0)
			return SendErrorMessage(playerid,"Please unload the stretcher before putting it away.");

		new Float:vX, Float:vY, Float:vZ;
		for(new v = 1, x = GetVehiclePoolSize(); v <= x; v++)
		{
			if(GetVehicleModel(v) == 416)
			{
				GetVehiclePos(v, vX, vY, vZ);
				if(IsPlayerInRangeOfPoint(playerid, 10.0, vX, vY, vZ))
				{
					DestroyDynamicObject(StretcherEquipped[playerid]);
					StretcherEquipped[playerid] = 0;
					StretcherHolding[playerid] = 0;

					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s puts their stretcher into the back of the Ambulance. *",ReturnName(playerid));
					return 1;
				}
			}
		}
		SendErrorMessage(playerid,"You must be near an Ambulance in order to put a stretcher away.");

	}
	else if(!strcmp(action, "load", true))
	{
		if(!IsValidDynamicObject(StretcherEquipped[playerid]))
			return SendErrorMessage(playerid,"You must have a stretcher to load someone on it.");
			
		if(StretcherPlayerID[playerid] >= 0)
			return SendErrorMessage(playerid,"You already have someone loaded on the stretcher.");

	    if (sscanf(string, "u", playa))
	        return SendSyntaxMessage(playerid,"/stretcher load [playerid/name]");
			 
		if(playa == INVALID_PLAYER_ID)
			return SendErrorMessage(playerid,"That player is not connected.");
			
		if(playa == playerid)
			return SendErrorMessage(playerid,"You may not do this to yourself.");
			
		if(StretcherEquipped[playa] > 0)
			return SendErrorMessage(playerid,"You may not put someone with a stretcher on a stretcher.");
			
		if(StretcherHolding[playerid] == 0)
			return SendErrorMessage(playerid, "You need to be holding the stretcher");

		new Float:tX,Float:tY,Float:tZ;
		GetPlayerPos(playa,tX,tY,tZ);
		
		if(!IsPlayerInRangeOfPoint(playerid,3.5,tX,tY,tZ))
			return SendErrorMessage(playerid,"You must be close to the player to put them on a stretcher.");

		StretcherPlayerID[playerid] = playa;
		ApplyAnimation(playa,"BEACH", "bather", 4.0, 1, 0, 0, 1, -1, 1);

		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s is now pulling the stretcher with %s on it. *", GetName(playerid), GetName(StretcherPlayerID[playerid]));

		SendServerMessage(playerid, "%s in now on your stretcher. You can get them off using '/stretcher unload'",ReturnName(StretcherPlayerID[playerid]));

		SendServerMessage(StretcherPlayerID[playerid] ,"%s has put you onto their stretcher.",ReturnName(playerid));

	}
	else if(!strcmp(action, "unload", true))
	{
		if(!IsValidDynamicObject(StretcherEquipped[playerid]))
			return SendErrorMessage(playerid,"You must have a stretcher to load someone on it.");
			
		if(StretcherPlayerID[playerid] == -1)
			return SendErrorMessage(playerid,"You don't even have someone loaded on the stretcher.");
			
		if(StretcherHolding[playerid] == 0)
			return SendErrorMessage(playerid, "You need to be holding the stretcher");

		new Float:playerpos[4];
		TogglePlayerControllable(StretcherPlayerID[playerid], 1);
		GetPlayerPos(playerid, playerpos[0], playerpos[1], playerpos[2]);
		GetXYInFrontOfPlayer(playerid, playerpos[0], playerpos[1], -2);
		SetPlayerPos(StretcherPlayerID[playerid], playerpos[0], playerpos[1], playerpos[2]);
		ClearAnimations(StretcherPlayerID[playerid]);

		SendServerMessage(playerid,"%s has been removed from the stretcher.",ReturnName(StretcherPlayerID[playerid]));
		
		SendServerMessage(playerid,"%s has removed you from their stretcher.",ReturnName(playerid));

		StretcherPlayerID[playerid] = -1;

	}
	else if(!strcmp(action, "ambulance", true))
	{
		if(!IsValidDynamicObject(StretcherEquipped[playerid]))
			return SendErrorMessage(playerid,"You must have a stretcher.");
			
		if(StretcherPlayerID[playerid] == -1)
			return SendErrorMessage(playerid,"You don't even have someone loaded on the stretcher.");

		new Float:vX, Float:vY, Float:vZ;
		for(new v = 1, x = GetVehiclePoolSize(); v <= x; v++)
		{
			if(GetVehicleModel(v) == 416)
			{
				GetVehiclePos(v, vX, vY, vZ);
				if(IsPlayerInRangeOfPoint(playerid, 10.0, vX, vY, vZ))
				{
					new seatid = 2;
					foreach(new i: Player)
					{
						if(GetPlayerVehicleID(i) == v)
						{
							if(GetPlayerVehicleSeat(i) == 2) seatid = 3;
							if(GetPlayerVehicleSeat(i) == 3 && seatid == 3) seatid = -1;
						}
					}
					if(seatid == -1)
						return SendErrorMessage(playerid,"There are no seats free in the back of this Ambulance.");

					PutPlayerInVehicle(StretcherPlayerID[playerid], v, seatid);
					TogglePlayerControllable(StretcherPlayerID[playerid], 1);

					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s pushes the stretcher with %s on it into the back of the Ambulance. *",ReturnName(playerid),ReturnName(StretcherPlayerID[playerid]));

					DestroyDynamicObject(StretcherEquipped[playerid]);
					StretcherEquipped[playerid] = 0;
					StretcherPlayerID[playerid] = -1;
					StretcherHolding[playerid] = 0;

				}
			}
		}
		SendErrorMessage(playerid,"You must be near an Ambulance in order to put a stretcher inside.");
		return 1;
	}

	return 1;
}
CMD:treatment(playerid, params[])
{
	if(GetFactionType(playerid) != FACTION_MEDIC)
		return SendErrorMessage(playerid, "This command is only for LSES!");

	if(!PlayerData[playerid][pOnDuty])
		return SendErrorMessage(playerid, "You must be faction duty first!");

	new targetid;
	if(sscanf(params, "u", targetid))
		return SendErrorMessage(playerid, "/treatment [playerid/PartOfName]");

	if(!IsPlayerNearPlayer(playerid, targetid, 5.0) || targetid == INVALID_PLAYER_ID)
		return SendErrorMessage(playerid, "You must be close to that player!");

	PlayerData[playerid][pTargetid] = targetid;
	ShowPlayerDialog(playerid, DIALOG_TREATMENT, DIALOG_STYLE_LIST, "Treatment Menu", "Revive\nHeal\nCure\nOperate", "Select", "Close");
	return 1;
}