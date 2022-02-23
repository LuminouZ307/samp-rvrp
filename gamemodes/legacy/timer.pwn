task MinuteUpdate[60000]()
{
	forex(i, MAX_WEED) if(WeedData[i][weedExists])
	{
		if(WeedData[i][weedGrow] < MAX_GROW)
		{
			WeedData[i][weedGrow]++;
			Weed_Save(i);
		}
	}
	for(new i = 0; i < MAX_ADVERT; i ++) if(AdvertData[i][advertExists])
	{
	    if(AdvertData[i][advertTime] > 0)
	    {
	        AdvertData[i][advertTime]--;
	        if(AdvertData[i][advertTime] <= 0)
	        {
				foreach(new  p: Player)
				{
					SendClientMessageEx(p, -1, "{FF0000}ADS: {33CC33}%s", AdvertData[i][advertText]);
					SendClientMessageEx(p, COLOR_GREEN, "Phone: {FF0000}%d {33CC33}| Name: {FF0000}%s", AdvertData[i][advertNumber], AdvertData[i][advertName]);
				}   
	            Advert_Delete(i);
			}
		}
	}
	return 1;
}

ptask CheckEnergy[12000](playerid)
{
	if(PlayerData[playerid][pThirst] <= 15 || PlayerData[playerid][pHunger] <= 15)
	{
		new Float:hp;
		GetPlayerHealth(playerid, hp);
		if(hp - 0.5 <= 7.0)
		{
			InjuredPlayer(playerid, INVALID_PLAYER_ID, WEAPON_COLLISION);
		}
		else
		{
			SetPlayerHealth(playerid, hp-0.5);
		}
		if(PlayerData[playerid][pHealthy] > 0)
		{
			PlayerData[playerid][pHealthy]--;
		}
	}
	return 1;
}
task EnergyUpdate[70000]()
{
	foreach(new playerid : Player) if(PlayerData[playerid][pSpawned] && !PlayerData[playerid][pAduty])
	{
		if(PlayerData[playerid][pHunger] > 0)
		{
		    PlayerData[playerid][pHunger] -= RandomEx(1, 2);
		}
		if(PlayerData[playerid][pThirst] > 0)
		{
			PlayerData[playerid][pThirst] -= RandomEx(1, 2);
		}
		if(PlayerData[playerid][pHunger] < 0)
		{
			PlayerData[playerid][pHunger] = 0;
		}
		if(PlayerData[playerid][pThirst] < 0)
		{
			PlayerData[playerid][pThirst] = 0;
		}
	}
	return 1;
}

task SecondUpdate[1000]()
{
	forex(i, MAX_TREE) if(TreeData[i][treeExists] && TreeData[i][treeTime] > 0)
	{
		TreeData[i][treeTime]--;
		if(TreeData[i][treeTime] <= 0)
		{
			TreeData[i][treeCutted] = false;
			TreeData[i][treeObject] = CreateDynamicObject(657, TreeData[i][treePos][0], TreeData[i][treePos][1], TreeData[i][treePos][2], TreeData[i][treePos][3], TreeData[i][treePos][4], TreeData[i][treePos][5], -1, -1, -1, 500.0, 500.0);
			Tree_Refresh(i);
		}
	}
	return 1;
}
ptask RentalUpdate[1000](playerid)
{
	foreach(new v : PlayerVehicle) if(Iter_Contains(PlayerVehicle, v) && VehicleData[v][vOwner] == PlayerData[playerid][pID] && VehicleData[v][vRental] != 0)
	{
		if(VehicleData[v][vRentTime] > 0)
		{
			VehicleData[v][vRentTime]--;
			if(VehicleData[v][vRentTime] <= 0)
			{
				SendClientMessageEx(playerid, COLOR_SERVER, "RENTAL: {FFFFFF}Durasi waktu Rental {FFFF00}%s {FFFFFF}telah habis, kendaraan otomatis dihilangkan.", GetVehicleName(VehicleData[v][vVehicle]));
				new query[128];
				mysql_format(sqlcon, query, sizeof(query), "DELETE FROM vehicle WHERE vehID = '%d'", VehicleData[v][vID]);
				mysql_tquery(sqlcon, query);

				for(new idx = 0; idx < 5; idx ++)
				{
				    if(VehicleData[v][vToyID][idx] != 0)
				    {
				    	if(IsValidDynamicObject(VehicleData[v][vToy][idx]))
							DestroyDynamicObject(VehicleData[v][vToy][idx]);
					}
				}
				VehicleData[v][vToyID][0] = 0;
				VehicleData[v][vToyID][1] = 0;
				VehicleData[v][vToyID][2] = 0;
				VehicleData[v][vToyID][3] = 0;
				VehicleData[v][vToyID][4] = 0;

				if(IsValidVehicle(VehicleData[v][vVehicle]))
					DestroyVehicle(VehicleData[v][vVehicle]);

				Iter_SafeRemove(PlayerVehicle, v, v);				
			}
		}
	}
}
task VehicleUpdate[50000]()
{
	forex(i, MAX_VEHICLES) if (IsEngineVehicle(i) && GetEngineStatus(i))
	{
	    if (GetFuel(i) > 0)
	    {
	        VehCore[i][vehFuel]--;
			if (GetFuel(i) <= 0)
			{
			    VehCore[i][vehFuel] = 0;
	      		SwitchVehicleEngine(i, false);
	      		GameTextForPlayer(GetVehicleDriver(i), "Vehicle out of ~r~Fuel!", 3000, 3);
			}
		}
	}
	foreach(new i : PlayerVehicle)
	{
		if(VehicleData[i][vInsuTime] != 0 && VehicleData[i][vInsuTime] <= gettime())
		{
			VehicleData[i][vInsuTime] = 0;
		}
	}
	return 1;
}

task HeartTenMinute[600000]()
{
	foreach(new i : Player)
	{
		if(PlayerData[i][pSpawned])
		{
			SaveData(i);
		}
	}
	foreach(new i : PlayerVehicle)
	{
		SaveVehicle(i);
	}
	return 1;
}


ptask PlayerUpdate[1000](playerid)
{
	if(PlayerData[playerid][pSpawned])
	{
		UpdateHBE(playerid);
		AFKCheck(playerid);
		UpdateTime(playerid);
		if(PlayerData[playerid][pHunger] > 100)
		{
			PlayerData[playerid][pHunger] = 100;
		}
		if(PlayerData[playerid][pThirst] > 100)
		{
			PlayerData[playerid][pThirst] = 100;
		}
		if (GetPlayerMoney(playerid) != PlayerData[playerid][pMoney])
		{
		    ResetPlayerMoney(playerid);
		    GivePlayerMoney(playerid, PlayerData[playerid][pMoney]);
		}
		if(PlayerData[playerid][pTazer] && GetWeapon(playerid) > 0)
		{
			SetPlayerArmedWeapon(playerid, 0);
			SendClientMessage(playerid, COLOR_LIGHTRED, "WARNING: {FFFFFF}You can't holding weapon since you holding Tazer");
		}
		if(PlayerData[playerid][pAxe] && GetWeapon(playerid) > 0)
		{
			SetPlayerArmedWeapon(playerid, 0);
			SendClientMessage(playerid, COLOR_LIGHTRED, "WARNING: {FFFFFF}You can't holding weapon since you holding Axe!");
		}
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsEngineVehicle(GetPlayerVehicleID(playerid)) && !PlayerData[playerid][pTogHud])
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			new Float:fDamage;
			GetVehicleHealth(vehicleid, fDamage);

			new Float:fuel = VehCore[vehicleid][vehFuel] * 46.5/100;
		    PlayerTextDrawTextSize(playerid,FUELTD[playerid], fuel, 14.5);
		    PlayerTextDrawShow(playerid,FUELTD[playerid]);

			if(fDamage <= 1000.0)
			{
				new Float:darah = fDamage * 46.5/1000.0;
			    PlayerTextDrawTextSize(playerid,VHPTD[playerid], darah, 14.5);
			    PlayerTextDrawShow(playerid,VHPTD[playerid]);
			}
			else
			{
			    PlayerTextDrawTextSize(playerid,VHPTD[playerid], 46.5, 14.5);
			    PlayerTextDrawShow(playerid,VHPTD[playerid]);
			}
            new chtr[56];
			format(chtr, sizeof(chtr), "%.1f", fDamage);
			PlayerTextDrawSetString(playerid, VHPTEXT[playerid], chtr);

            new ctr[56];
			format(ctr, sizeof(ctr), "%d", VehCore[vehicleid][vehFuel]);
			PlayerTextDrawSetString(playerid,FUELTEXT[playerid], ctr);

            new str[56];
			format(str, sizeof(str), "%iKM/H", GetVehicleSpeedKMH(vehicleid));
			PlayerTextDrawSetString(playerid, SPEEDTEXT[playerid], str);
		}
		if(IsDragging[playerid] != INVALID_PLAYER_ID)
		{
			new targetid = IsDragging[playerid];
			PlayerData[targetid][pInBiz] = PlayerData[playerid][pInBiz];
			PlayerData[targetid][pInHouse] = PlayerData[playerid][pInHouse];
			PlayerData[targetid][pInDoor] = PlayerData[playerid][pInDoor];

			new Float:X, Float:Y, Float:Z, Float:Ang;
			GetPlayerPos(playerid, X, Y, Z);
			GetPlayerFacingAngle(playerid, Ang);

			X += (0.75 * -floatsin(-Ang, degrees));
			Y += (0.75 * -floatcos(-Ang, degrees));
			SetPlayerPos(targetid, X, Y, Z);
			if(GetPlayerInterior(targetid) != GetPlayerInterior(playerid))
			{
				SetPlayerInterior(targetid, GetPlayerInterior(playerid));
			}
			if(GetPlayerVirtualWorld(targetid) != GetPlayerVirtualWorld(playerid))
			{
				SetPlayerVirtualWorld(targetid, GetPlayerVirtualWorld(playerid));
			}
		}
		if(OnBus[playerid] && IsBusVehicle(GetPlayerVehicleID(playerid)) && BusWaiting[playerid])
		{
			if(BusTime[playerid] > 0)
			{
				BusTime[playerid]--;
				GameTextForPlayer(playerid, sprintf("Waiting_time: %d", BusTime[playerid]), 1000, 6);
				PlayerPlaySound(playerid, 43000, 0.0, 0.0, 0.0);		
			}
			else
			{
				if(BusIndex[playerid] == 5)
				{
					BusIndex[playerid] = 6;
					BusWaiting[playerid] = false;
					BusTime[playerid] = 0;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, 1572.4673,-2283.9280,13.4162, 1517.5294,-2258.6445,13.4865, 5.0);
				}
				else if(BusIndex[playerid] == 14)
				{
					BusIndex[playerid] = 15;
					BusWaiting[playerid] = false;
					BusTime[playerid] = 0;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, 2073.8169,-1929.0842,13.4298, 1824.8662,-1919.8773,13.4844, 5.0);
				}
				else if(BusIndex[playerid] == 21)
				{
					BusIndex[playerid] = 22;
					BusWaiting[playerid] = false;
					BusTime[playerid] = 0;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, 1314.8708,-1729.7445,13.4834, 1353.8236,-1464.6906,13.4840, 5.0);
				}
				else if(BusIndex[playerid] == 25)
				{
					BusIndex[playerid] = 26;
					BusWaiting[playerid] = false;
					BusTime[playerid] = 0;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, 1144.7260,-1277.7739,13.6474, 1027.3414,-1320.6429,13.4868, 5.0);					
				}
			}
		}
		if(PlayerData[playerid][pFishing] && GetPlayerAnimationIndex(playerid) != 1812 && ReturnFishArea(playerid) != FISH_NONE)
		{
			ApplyAnimation(playerid, "SAMP", "FishingIdle", 4.1, 0, 0, 0, 1, 0, 1);
		}
		if(PlayerData[playerid][pWP])
		{
			PlayerTextDrawSetString(playerid, GPSTD[playerid], sprintf("%s~n~Distance:_%.2f_Meter", GetLocation(Destination[playerid][0], Destination[playerid][1], Destination[playerid][2]), GetPlayerDistanceFromPoint(playerid, Destination[playerid][0], Destination[playerid][1], Destination[playerid][2])));
		}
		PlayerData[playerid][pSecond]++;
		if(PlayerData[playerid][pSecond] >= 60)
		{
			SyncPlayerTime(playerid);
			PlayerData[playerid][pMinute]++;
			PlayerData[playerid][pSecond] = 0;
			if(PlayerData[playerid][pMinute] >= 60)
			{
				PlayerData[playerid][pHour]++;
				PlayerData[playerid][pMinute] = 0;
			}
		}
		if(PlayerData[playerid][pOnDuty])
		{
			PlayerData[playerid][pDutySecond]++;
			if(PlayerData[playerid][pDutySecond] >= 60)
			{
				PlayerData[playerid][pDutyMinute]++;
				PlayerData[playerid][pDutySecond] = 0;
				if(PlayerData[playerid][pDutyMinute] >= 60)
				{
					PlayerData[playerid][pDutyHour]++;
					PlayerData[playerid][pDutyMinute] = 0;
				}
			}
		}
		if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK && PlayerData[playerid][pAdmin] < 1)
		{
			SendAdminMessage(COLOR_LIGHTRED, "AdmWarning: Cheat detected on {FFFF00}%s (%s) {FF6347}(Jetpack Hack)", GetName(playerid), PlayerData[playerid][pUCP]);
			KickEx(playerid);
		}
		if(GetPlayerAnimationIndex(playerid) != 1701 && PlayerData[playerid][pInjured])
		{
		    ApplyAnimation(playerid, "WUZI", "CS_DEAD_GUY", 4.1, 0, 0, 0, 1, 0, 1);
		}
		if(NetStats_GetConnectedTime(playerid) - WeaponTick[playerid] >= 250)
		{
			new weaponid, ammo, objectslot, count, index;

			for (new i = 2; i <= 7; i++) //Loop only through the slots that may contain the wearable weapons
			{
				GetPlayerWeaponData(playerid, i, weaponid, ammo);
				index = weaponid - 22;

				if (weaponid && ammo && !WeaponSettings[playerid][index][Hidden] && IsWeaponWearable(weaponid) && EditingWeapon[playerid] != weaponid)
				{
					objectslot = GetWeaponObjectSlot(weaponid);

					if (GetPlayerWeapon(playerid) != weaponid)
						SetPlayerAttachedObject(playerid, objectslot, GetWeaponModel(weaponid), WeaponSettings[playerid][index][Bone], WeaponSettings[playerid][index][Position][0], WeaponSettings[playerid][index][Position][1], WeaponSettings[playerid][index][Position][2], WeaponSettings[playerid][index][Position][3], WeaponSettings[playerid][index][Position][4], WeaponSettings[playerid][index][Position][5], 1.0, 1.0, 1.0);

					else if (IsPlayerAttachedObjectSlotUsed(playerid, objectslot)) RemovePlayerAttachedObject(playerid, objectslot);
				}
			}
			for (new i = 4; i <= 8; i++) if (IsPlayerAttachedObjectSlotUsed(playerid, i))
			{
				count = 0;

				for (new j = 22; j <= 38; j++) if (PlayerHasWeapon(playerid, j) && GetWeaponObjectSlot(j) == i)
					count++;

				if(!count) RemovePlayerAttachedObject(playerid, i);
			}
			WeaponTick[playerid] = NetStats_GetConnectedTime(playerid);
		}
	}
	return 1;
}

ptask HeartThreeSec[3000](playerid)
{
	if(PlayerData[playerid][pSpawned])
	{
		if(IsPlayerInDynamicArea(playerid, AreaData[areaFishSmall][0]) || IsPlayerInDynamicArea(playerid, AreaData[areaFishSmall][1]))
		{
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsABoat(GetPlayerVehicleID(playerid)))
			{
				ShowText(playerid, "~n~~w~Boat Signal~n~~y~Small", 1);
			}
		}
		if(IsPlayerInDynamicArea(playerid, AreaData[areaFishBig][0]) || IsPlayerInDynamicArea(playerid, AreaData[areaFishBig][1]))
		{
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsABoat(GetPlayerVehicleID(playerid)))
			{
				ShowText(playerid, "~n~~w~Boat Signal~n~~r~Big", 1);
			}
		}
	}
	return 1;
}

task DelayUpdate[1000]()
{
	foreach(new i : Player) if(PlayerData[i][pSpawned])
	{
		if(PlayerData[i][pSweeperDelay] > 0)
		{
			PlayerData[i][pSweeperDelay]--;
			if(PlayerData[i][pSweeperDelay] <= 0)
			{
				SendServerMessage(i, "Kamu bisa bekerja kembali sebagai {FFFF00}Street Sweeper");
				PlayerData[i][pSweeperDelay] = 0;
			}
		}
		if(PlayerData[i][pFishDelay] > 0)
		{
			PlayerData[i][pFishDelay]--;
			if(PlayerData[i][pFishDelay] <= 0)
			{
				SendServerMessage(i, "Kamu bisa {FFFF00}menjual ikan {FFFFFF}lagi sekarang!");
				PlayerData[i][pFishDelay] = 0;
			}
		}
		if(PlayerData[i][pBusDelay] > 0)
		{
			PlayerData[i][pBusDelay]--;
			if(PlayerData[i][pBusDelay] <= 0)
			{
				SendServerMessage(i, "Kamu bisa bekerja kembali sebagai {FFFF00}Bus Driver");
				PlayerData[i][pBusDelay] = 0;
			}
		}
		if(PlayerData[i][pInjuredTime] > 0)
		{
			PlayerData[i][pInjuredTime]--;
		}
		if(PlayerData[i][pJailTime] > 0)
		{
			PlayerData[i][pJailTime]--;
			new hours, seconds, minutes;
			GetElapsedTime(PlayerData[i][pJailTime], hours, minutes, seconds);
			new string[156];
			if(!PlayerData[i][pArrest])
			{
				format(string, sizeof(string), "~r~Jail_Time:~w~_%02d:%02d:%02d~n~~r~Jail_Reason:~w~_%s~n~~r~Jailed_by:~w~_%s", hours, minutes, seconds, PlayerData[i][pJailReason], PlayerData[i][pJailBy]);
			}
			else
			{
				format(string, sizeof(string), "~r~Arrest_Time:~w~_%02d:%02d:%02d~n~~r~Arrest_Reason:~w~_%s~n~~r~Arrested_by:~w~_%s", hours, minutes, seconds, PlayerData[i][pJailReason], PlayerData[i][pJailBy]);
			}	
			PlayerTextDrawSetString(i, JAILTD[i], string);
			if(PlayerData[i][pJailTime] <= 0)
			{
		        PlayerData[i][pArrest] = 0;
		        format(PlayerData[i][pJailBy], MAX_PLAYER_NAME, "");
		        format(PlayerData[i][pJailReason], 32, "");

				SetPlayerPos(i, 1543.8755,-1675.7900,13.5573);
				SetPlayerInterior(i, 0);
				SetPlayerVirtualWorld(i, 0);

				SendServerMessage(i, "You have been released from jail.");
		        PlayerTextDrawHide(i, JAILTD[i]);
			}
		}
		if(PlayerData[i][pPaycheck] > 3600)
		{
			PlayerData[i][pPaycheck] = 0;
		}
		if(PlayerData[i][pPaycheck] > 0)
		{
			PlayerData[i][pPaycheck]--;
			if(PlayerData[i][pPaycheck] <= 0)
			{
				SendServerMessage(i, "Kamu sudah bisa mengambil Paycheck sekarang!");
				PlayerData[i][pPaycheck] = 0;
			}
		}
		if(PlayerData[i][pFaction] != -1 && PlayerData[i][pOnDuty] && !PlayerData[i][pAFK])
		{
			PlayerData[i][pDutyTime]--;
			if(PlayerData[i][pDutyTime] <= 0)
			{
				AddSalary(i, "Faction Duty", FactionData[PlayerData[i][pFaction]][factionSalary][PlayerData[i][pFactionRank] - 1]);
				PlayerData[i][pDutyTime] = 3600;
				SendClientMessage(i, COLOR_SERVER, "FACTION: {FFFFFF}Faction salary has been issued to your {FFFF00}/salary");
			}
		}
	}
	return 1;
}