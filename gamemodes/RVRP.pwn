/*

	Revitalize Roleplay (3.0) by vyn

	Creation date : 24 december 2021

	Description : 

	* 	Gamemode ini dibuat sejak tanggal 24 desember tahun 2021, dengan base script dari 
		Xyronite Gamemode (https://github.com/LuminouZ307/xyronite-gm-unfinished) dan dilanjutkan
		oleh saya sendiri (vyn) untuk dijadikan script Revitalize Roleplay versi ketiga-nya.

	Things to Consider :

	* 	Script ini dibuat compatible untuk player desktop & mobile, namun ada beberapa part script
		yang memiliki masalah untuk mobile player seperti sistem Insurance akan selalu terpanggil
		secara random di mobile Player walau kendaraan tersebut tidak hancur ataupun tenggelam.
		Hal itu terjadi karena pada client SA:MP mobile, callback 'OnVehicleSpawn' tidak ada.
		Maka dari itu ada admin command untuk mengeluarkan kendaraan player dari insurance 
		yaitu command '/forceinsurance'.

	*   Gamemode ini belum 100% selesai! masih banyak command-command yang terdaftar namun belum dibuat, seperti beberapa command LSPD, LSNEWS, LSGOV DLL.
		Karena saya tidak lagi meneruskan gamemode ini maka kalian (yang memiliki gamemode ini) bisa membuat command yang belum tersedia itu,
		sendiri.

	Credits :

	*	Arif Rahman Hudaya | vyn (main scripter & main manager)
	* 	Muhammad Najmi | PL (run the server & second manager)


	© Copyright 2021 - 2022 Arif Rahman Hudaya (All rights reserved).
	

	| 										Please do not remove the credits ! 												|
	| 			Hapus credits / Ngaku buatan lu = DRAMA SAMA GW GOBLOK BOCIL SCRIPTER RITAT SOK NGODING KONTOL				|

*/

/* Includes */

#define CGEN_MEMORY 30000

#include <a_samp>

#include <a_zones>

#include <strlib>
#include <fixes>

#include <a_mysql>
#include <eSelection>

#include <YSI_Coding\y_va>
#include <YSI_Coding\y_timers>
#include <YSI_Server\y_colours>
#include <YSI_Data\y_foreach>

#include <samp_bcrypt>
#include <izcmd>
#include <progress2>
#include <sscanf2>
#include <streamer>
#include <EVF2>
#include <PreviewModelDialog2>
#include <yom_buttons>
#include <loadingbar>
#include <garageblock>
#include <wep-config>
#include <callbacks>
#include <MenuStore>

#include "command-guess.inc"

#include "legacy\define.pwn"
#include "legacy\textdraw.pwn"
#include "legacy\generalvar.pwn"

/* This thing is fucking important */
enum e_player_data
{
	pID,
	pUCP[22],
	pName[MAX_PLAYER_NAME],
	Float:pPos[3],
	pWorld,
	pInterior,
	pSkin,
	pAge,
	pAttempt,
	pOrigin[32],
	pGender,
	bool:pMaskOn,
	pMaskID,
	bool:pSpawned,
	pChar,
	Float:pHealth,
	pHunger,
	pThirst,
	pMoney,
	pInBiz,
	pStorageSelect,
	pAdmin,
	pAduty,
	pPhoneNumber,
	pCallLine,
	pCredit,
	pCalling,
	pTarget,
	pSkinPrice,
	pVehKey,
	pFaction,
	pRenting,
	pJob,
	pCrate,
	pVehicle,
	pBusiness,
	pGuns[13],
	pDurability[13],
	pAmmo[13],
	bool:pTracking,
	pLevel,
	pExp,
	bool:pWP,
	bool:pJobduty,
	pFareTimer,
	pFare,
	bool:pInTaxi,
	pTotalFare,
	pMechPrice[2],
	bool:pSpraying,
	pSprayStart,
	pColor,
	pColoring,
	pSprayTime,
	pDutySecond,
	pDutyMinute,
	pDutyHour,
	pFactionEdit,
	pFactionID,
	pFactionRank,
	pOnDuty,
	pSelectedSlot,
	pFactionSkin,
	pFactionOffer,
	pFactionOffered,
	pBirthdate[24],
	pTempName[MAX_PLAYER_NAME],
	Float:pArmor,
	pSalary,
	pBank,
	pInDoor,
	pFreeze,
	pFreezeTimer,
	Float:pMark[3],
	pMarkWorld,
	pMarkInterior,
	bool:pMarkActive,
	bool:pAsking,
	pAsk[64],
	pJailTime,
	pJailReason[32],
	pJailBy[MAX_PLAYER_NAME],
	pArrest,
	pInjured,
	pInjuredTime,
	bool:pDead,
	pBusDelay,
	pSweeperDelay,
	bool:pCuffed,
	pListitem,
	bool:pPhoneOff,
	pIncomingCall,
	pTargetid,
	Float:pHealthy,
	Float:pDamages[7],
	pBullets[7],
	pContact,
	pEditingItem,
	pSelecting,
	bool:pMasked,
	pPaycheck,
	pMinute,
	pSecond,
	pHour,
	pInHouse,
	Float:sPos[3],
	pSpectator,
	pFrisked,
	pMinutes,
	pDutyTime,
	pQuitjob,
	pChannel,
	pVendor,
	bool:pFirstAid,
	pAidTimer,
	pEditing,
	pEditType,
	pCutting,
	bool:pAxe,
	bool:pTazer,
	bool:pTazed,
	pFunds,
	pTempContact[32],
	pWeapon,
	bool:pEditAcc,
	pTempModel,
	bool:pOnDMV,
	pVehicleDMV,
	pIndexDMV,
	pIndexTest,
	bool:pOnTest,
	pLicense[3],
	pHaveDrivingLicense,
	Float:pAFKPos[6],
	pAFK,
	pAFKTime,
	bool:pLoopAnim,
	pEditGate,
	bool:pSeatbelt,
	STREAMER_TAG_3D_TEXT_LABEL:pInjuredLabel,
	bool:pInTuning,
	pTuningCategoryID,
	pTaxiCalled,
	bool:pLogged,
	pFishDelay,
	pFishing,
	pDragOffer,
	bool:pAhide,
	bool:pTogLogin,
	bool:pTogGlobal,
	bool:pTogAnim,
	bool:pTogPM,
	bool:pTogHud,
	bool:pTogBuy,
};

new PlayerData[MAX_PLAYERS][e_player_data];
new Float:Destination[MAX_PLAYERS][3];
new bool:OnBus[MAX_PLAYERS];
new BusIndex[MAX_PLAYERS];
new BusTime[MAX_PLAYERS];
new bool:BusWaiting[MAX_PLAYERS];
new SweeperIndex[MAX_PLAYERS];
new bool:OnSweeping[MAX_PLAYERS];
new NumberIndex[MAX_PLAYERS][5];
new PlayerPressedJump[MAX_PLAYERS];
new STREAMER_TAG_3D_TEXT_LABEL:MaskLabel[MAX_PLAYERS];
new bool:Falling[MAX_PLAYERS];
new LoginTimer[MAX_PLAYERS];
new IsDragging[MAX_PLAYERS];
new Damage[MAX_PLAYERS][MAX_BODY_PARTS][MAX_WEAPONS];
new DamageTime[MAX_PLAYERS][MAX_BODY_PARTS][MAX_WEAPONS];
new STREAMER_TAG_3D_TEXT_LABEL:PlayerADO[MAX_PLAYERS];
new tempCode[MAX_PLAYERS];

enum ucp_data
{
	ucpTime,
	ucpAdmin,
	ucpID,
	ucpEmail[48]
};
new UcpData[MAX_PLAYERS][ucp_data];

/* Important Modules */

#include "legacy\generalfunc.pwn"
#include "legacy\area.pwn"
#include "legacy\streamer.pwn"
#include "legacy\animations.pwn"

/* Faction Modules */
#include "legacy\Faction\DynamicFaction.pwn"
#include "legacy\Faction\General.pwn"
#include "legacy\Faction\FactionVehicle.pwn"
#include "legacy\Faction\Medic.pwn"
#include "legacy\Faction\Police.pwn"
#include "legacy\Faction\Government.pwn"

/* Server Feature Modules */
#include "legacy\Feature\Business.pwn"
#include "legacy\Feature\Toys.pwn"
#include "legacy\Feature\911call.pwn"
#include "legacy\Feature\Phone.pwn"
#include "legacy\Feature\TruckerCargo.pwn"
#include "legacy\Feature\DynamicActor.pwn"
#include "legacy\Feature\SprayTag.pwn"
#include "legacy\Feature\Report.pwn"
#include "legacy\Feature\PlayerVehicle.pwn"
#include "legacy\Feature\Dealership.pwn"
#include "legacy\Feature\Rental.pwn"
#include "legacy\Feature\House.pwn"
#include "legacy\Feature\Warning.pwn"
#include "legacy\Feature\Gate.pwn"
#include "legacy\Feature\Inventory.pwn"
#include "legacy\Feature\LumberTree.pwn"
#include "legacy\Feature\Dropitem.pwn"
#include "legacy\Feature\Ticket.pwn"
#include "legacy\Feature\Weed.pwn"
#include "legacy\Feature\ATM.pwn"
#include "legacy\Feature\WeaponAttachment.pwn"
#include "legacy\Feature\Speedcam.pwn"
#include "legacy\Feature\DMV.pwn"
#include "legacy\Feature\AFK.pwn"
#include "legacy\Feature\Injured.pwn"
#include "legacy\Feature\Salary.pwn"
#include "legacy\Feature\Damages.pwn"
#include "legacy\Feature\Mask.pwn"
#include "legacy\Feature\Advertisement.pwn"
#include "legacy\Feature\Insurance.pwn"
#include "legacy\Feature\Interior.pwn"
#include "legacy\Feature\Door.pwn "
#include "legacy\Feature\SAM.pwn"
#include "legacy\Feature\MOTD.pwn"
#include "legacy\Feature\GPS.pwn"
/* Job Modules */

#include "legacy\Job\Trucker.pwn"
#include "legacy\Job\General.pwn"
#include "legacy\Job\Fishing.pwn"
#include "legacy\Job\Sweeper.pwn"
#include "legacy\Job\Lumberjack.pwn"
#include "legacy\Job\Bus.pwn"
#include "legacy\Job\Vendor.pwn"
#include "legacy\Job\Mechanic.pwn"
#include "legacy\Job\Taxi.pwn"

/* Other Important Modules */
#include "legacy\player.pwn"
#include "legacy\generalcmd_player.pwn"
#include "legacy\generalcmd_admin.pwn"
#include "legacy\mapping.pwn"
#include "legacy\serverstuff.pwn"
/* Gamemode Start! */

main()
{

}

public OnGameModeInit()
{
	Database_Connect();
	CreateGlobalTextDraw();
	DisableInteriorEnterExits();
	EnableStuntBonusForAll(0);
	ManualVehicleEngineAndLights();
	StreamerConfig();
	LoadPoint();
	LoadArea();
	LoadStaticVehicle();
	LoadMap();
	LoadActor();
	LoadDynamicDoors();
	LoadGangZone();
	LoadServerData();
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_OFF);
	BlockGarages(true, GARAGE_TYPE_ALL, "Closed");
	VariableConfig();
	SetNameTagDrawDistance(15.0);
	SetupVendor();

	Iter_Init(House);
	Iter_Init(PlayerVehicle);
	Iter_Init(Furniture);
	Iter_Init(DynamicActor);
	Iter_Init(SprayTag);
	/* Load from Database */
	mysql_tquery(sqlcon, "SELECT * FROM `speedcameras`", "Speed_Load", "");
	mysql_tquery(sqlcon, "SELECT * FROM `business`", "Business_Load");
	mysql_tquery(sqlcon, "SELECT * FROM `dropped`", "Dropped_Load", "");
	mysql_tquery(sqlcon, "SELECT * FROM `rental`", "Rental_Load", "");
	mysql_tquery(sqlcon, "SELECT * FROM `weed`", "Weed_Load", "");
	mysql_tquery(sqlcon, "SELECT * FROM `factions`", "Faction_Load", "");
	mysql_tquery(sqlcon, "SELECT * FROM `911calls`", "Emergency_Load", "");
	mysql_tquery(sqlcon, "SELECT * FROM `dealer`", "Dealer_Load", "");
	mysql_tquery(sqlcon, "SELECT * FROM `atm`", "ATM_Load", "");
	mysql_tquery(sqlcon, "SELECT * FROM `houses`", "House_Load", "");
	mysql_tquery(sqlcon, "SELECT * FROM `tree`", "Tree_Load", "");
	mysql_tquery(sqlcon, "SELECT * FROM `gates`", "Gate_Load", "");
	mysql_tquery(sqlcon, "SELECT * FROM `actors`", "Actor_Load", "");
	mysql_tquery(sqlcon, "SELECT * FROM `factionvehicle`", "FactionVehicle_Load", "");
	mysql_tquery(sqlcon, "SELECT * FROM `tags`", "Tag_Load", "");

	/* End of Load Database */

	SetTimer("WeatherRotator", 2400000, true);
	return 1;
}

public OnDynamicActorStreamIn(STREAMER_TAG_ACTOR:actorid, forplayerid)
{
	foreach(new id : DynamicActor) if(actorid == ActorData[id][actorModel])
	{
		new animlib[32], animname[32];
		GetAnimationName(ActorData[id][actorAnim], animlib, 32, animname, 32);
		ApplyDynamicActorAnimation(ActorData[id][actorModel], animlib, animname, 4.1, 1, 0, 0, 1, 0);
	}
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
    if (!IsPlayerAdmin(playerid))
    {
        SendClientMessage(playerid, -1, "You don't have permission to using Spawn Button");
        return 0;
    }
	return 1;
}


public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	if(PlayerData[playerid][pAdmin] > 0)
	{
		ShowStats(clickedplayerid, playerid);
	}
	return 1;
}
public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	new fid = PlayerData[playerid][pEditing], vid = PlayerData[playerid][pVehicle], slot = PlayerData[playerid][pListitem];

	if(playertextid == PLUSX[playerid])
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			VehicleData[vid][vToyPosX][slot] = VehicleData[vid][vToyPosX][slot] + 0.2;
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleData[vid][vToy][slot], E_STREAMER_ATTACH_OFFSET_X, VehicleData[vid][vToyPosX][slot]);
		}
		else
		{
			if(PlayerData[playerid][pEditType] == EDIT_TAG)
			{
				TagData[fid][tagPos][0] = TagData[fid][tagPos][0]+0.2;
				Streamer_SetFloatData(STREAMER_TYPE_OBJECT, TagData[fid][tagObject], E_STREAMER_X, TagData[fid][tagPos][0]);
			}
			else
			{
				if(House_Inside(playerid) == -1)
					return SendErrorMessage(playerid, "You are no longer inside your house.");

				FurnitureData[fid][furniturePos][0] = FurnitureData[fid][furniturePos][0] + 0.2;

				Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnitureData[fid][furnitureObject], E_STREAMER_X, FurnitureData[fid][furniturePos][0]);
			}
		}
	}
	if(playertextid == MINX[playerid])
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			VehicleData[vid][vToyPosX][slot] = VehicleData[vid][vToyPosX][slot] - 0.2;
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleData[vid][vToy][slot], E_STREAMER_ATTACH_OFFSET_X, VehicleData[vid][vToyPosX][slot]);
		}
		else
		{
			if(PlayerData[playerid][pEditType] == EDIT_TAG)
			{
				TagData[fid][tagPos][0] = TagData[fid][tagPos][0]-0.2;
				Streamer_SetFloatData(STREAMER_TYPE_OBJECT, TagData[fid][tagObject], E_STREAMER_X, TagData[fid][tagPos][0]);
			}
			else
			{
				if(House_Inside(playerid) == -1)
					return SendErrorMessage(playerid, "You are no longer inside your house.");

				FurnitureData[fid][furniturePos][0] = FurnitureData[fid][furniturePos][0] - 0.2;

				Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnitureData[fid][furnitureObject], E_STREAMER_X, FurnitureData[fid][furniturePos][0]);
			}
		}
	}
	if(playertextid == PLUSY[playerid])
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			VehicleData[vid][vToyPosY][slot] = VehicleData[vid][vToyPosY][slot] + 0.2;
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleData[vid][vToy][slot], E_STREAMER_ATTACH_OFFSET_Y, VehicleData[vid][vToyPosY][slot]);
		}
		else
		{
			if(PlayerData[playerid][pEditType] == EDIT_TAG)
			{
				TagData[fid][tagPos][1] = TagData[fid][tagPos][1]+0.2;
				Streamer_SetFloatData(STREAMER_TYPE_OBJECT, TagData[fid][tagObject], E_STREAMER_Y, TagData[fid][tagPos][1]);
			}
			else
			{
				if(House_Inside(playerid) == -1)
					return SendErrorMessage(playerid, "You are no longer inside your house.");

				FurnitureData[fid][furniturePos][1] = FurnitureData[fid][furniturePos][1] + 0.2;

				Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnitureData[fid][furnitureObject], E_STREAMER_Y, FurnitureData[fid][furniturePos][1]);
			}
		}
	}
	if(playertextid == MINY[playerid])
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			VehicleData[vid][vToyPosY][slot] = VehicleData[vid][vToyPosY][slot] - 0.2;
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleData[vid][vToy][slot], E_STREAMER_ATTACH_OFFSET_Y, VehicleData[vid][vToyPosY][slot]);

		}
		else
		{
			if(PlayerData[playerid][pEditType] == EDIT_TAG)
			{
				TagData[fid][tagPos][1] = TagData[fid][tagPos][1]-0.2;
				Streamer_SetFloatData(STREAMER_TYPE_OBJECT, TagData[fid][tagObject], E_STREAMER_Y, TagData[fid][tagPos][1]);
			}
			else
			{
				if(House_Inside(playerid) == -1)
					return SendErrorMessage(playerid, "You are no longer inside your house.");

				FurnitureData[fid][furniturePos][1] = FurnitureData[fid][furniturePos][1] - 0.2;

				Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnitureData[fid][furnitureObject], E_STREAMER_Y, FurnitureData[fid][furniturePos][1]);
			}
		}
	}
	if(playertextid == PLUSZ[playerid])
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			VehicleData[vid][vToyPosZ][slot] = VehicleData[vid][vToyPosZ][slot] + 0.2;
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleData[vid][vToy][slot], E_STREAMER_ATTACH_OFFSET_Z, VehicleData[vid][vToyPosZ][slot]);

		}
		else
		{
			if(PlayerData[playerid][pEditType] == EDIT_TAG)
			{
				TagData[fid][tagPos][2] = TagData[fid][tagPos][2]+0.2;
				Streamer_SetFloatData(STREAMER_TYPE_OBJECT, TagData[fid][tagObject], E_STREAMER_Z, TagData[fid][tagPos][2]);
			}
			else
			{
				if(House_Inside(playerid) == -1)
					return SendErrorMessage(playerid, "You are no longer inside your house.");

				FurnitureData[fid][furniturePos][2] = FurnitureData[fid][furniturePos][2] + 0.2;

				Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnitureData[fid][furnitureObject], E_STREAMER_Z, FurnitureData[fid][furniturePos][2]);
			}
		}
	}
	if(playertextid == MINZ[playerid])
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			VehicleData[vid][vToyPosZ][slot] = VehicleData[vid][vToyPosZ][slot] - 0.2;
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleData[vid][vToy][slot], E_STREAMER_ATTACH_OFFSET_Z, VehicleData[vid][vToyPosZ][slot]);
		}
		else
		{
			if(PlayerData[playerid][pEditType] == EDIT_TAG)
			{
				TagData[fid][tagPos][2] = TagData[fid][tagPos][2]-0.2;
				Streamer_SetFloatData(STREAMER_TYPE_OBJECT, TagData[fid][tagObject], E_STREAMER_Z, TagData[fid][tagPos][2]);
			}
			else
			{
				if(House_Inside(playerid) == -1)
					return SendErrorMessage(playerid, "You are no longer inside your house.");

				FurnitureData[fid][furniturePos][2] = FurnitureData[fid][furniturePos][2] - 0.2;

				Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnitureData[fid][furnitureObject], E_STREAMER_Z, FurnitureData[fid][furniturePos][2]);
			}
		}
	}
	if(playertextid == PLUSRX[playerid])
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			VehicleData[vid][vToyRotX][slot] = VehicleData[vid][vToyRotX][slot] + 0.2;
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleData[vid][vToy][slot], E_STREAMER_ATTACH_R_X, VehicleData[vid][vToyRotX][slot]);
		}
		else
		{
			if(PlayerData[playerid][pEditType] == EDIT_TAG)
			{
				TagData[fid][tagPos][3] = TagData[fid][tagPos][3]+0.2;
				Streamer_SetFloatData(STREAMER_TYPE_OBJECT, TagData[fid][tagObject], E_STREAMER_R_X, TagData[fid][tagPos][3]);
			}
			else
			{
				if(House_Inside(playerid) == -1)
					return SendErrorMessage(playerid, "You are no longer inside your house.");

				FurnitureData[fid][furnitureRot][0] = FurnitureData[fid][furnitureRot][0] + 0.2;

				Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnitureData[fid][furnitureObject], E_STREAMER_R_X, FurnitureData[fid][furnitureRot][0]);
			}
		}
	}
	if(playertextid == MINRX[playerid])
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			VehicleData[vid][vToyRotX][slot] = VehicleData[vid][vToyRotX][slot] - 0.2;
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleData[vid][vToy][slot], E_STREAMER_ATTACH_R_X, VehicleData[vid][vToyRotX][slot]);
		}
		else
		{
			if(PlayerData[playerid][pEditType] == EDIT_TAG)
			{
				TagData[fid][tagPos][3] = TagData[fid][tagPos][3]-0.2;
				Streamer_SetFloatData(STREAMER_TYPE_OBJECT, TagData[fid][tagObject], E_STREAMER_R_X, TagData[fid][tagPos][3]);
			}
			else
			{
				if(House_Inside(playerid) == -1)
					return SendErrorMessage(playerid, "You are no longer inside your house.");

				FurnitureData[fid][furnitureRot][0] = FurnitureData[fid][furnitureRot][0] - 0.2;

				Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnitureData[fid][furnitureObject], E_STREAMER_R_X, FurnitureData[fid][furnitureRot][0]);
			}
		}
	}
	if(playertextid == PLUSRY[playerid])
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			VehicleData[vid][vToyRotY][slot] = VehicleData[vid][vToyRotY][slot] + 0.2;
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleData[vid][vToy][slot], E_STREAMER_ATTACH_R_Y, VehicleData[vid][vToyRotY][slot]);
		}
		else
		{
			if(PlayerData[playerid][pEditType] == EDIT_TAG)
			{
				TagData[fid][tagPos][4] = TagData[fid][tagPos][4]+0.2;
				Streamer_SetFloatData(STREAMER_TYPE_OBJECT, TagData[fid][tagObject], E_STREAMER_R_Y, TagData[fid][tagPos][4]);
			}
			else
			{
				if(House_Inside(playerid) == -1)
					return SendErrorMessage(playerid, "You are no longer inside your house.");

				FurnitureData[fid][furnitureRot][1] = FurnitureData[fid][furnitureRot][1] + 0.2;

				Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnitureData[fid][furnitureObject], E_STREAMER_R_Y, FurnitureData[fid][furnitureRot][1]);
			}
		}
	}
	if(playertextid == MINRY[playerid])
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			VehicleData[vid][vToyRotY][slot] = VehicleData[vid][vToyRotY][slot] - 0.2;
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleData[vid][vToy][slot], E_STREAMER_ATTACH_R_Y, VehicleData[vid][vToyRotY][slot]);
		}
		else
		{
			if(PlayerData[playerid][pEditType] == EDIT_TAG)
			{
				TagData[fid][tagPos][4] = TagData[fid][tagPos][4]-0.2;
				Streamer_SetFloatData(STREAMER_TYPE_OBJECT, TagData[fid][tagObject], E_STREAMER_R_Y, TagData[fid][tagPos][4]);
			}
			else
			{
				if(House_Inside(playerid) == -1)
					return SendErrorMessage(playerid, "You are no longer inside your house.");

				FurnitureData[fid][furnitureRot][1] = FurnitureData[fid][furnitureRot][1] - 0.2;

				Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnitureData[fid][furnitureObject], E_STREAMER_R_Y, FurnitureData[fid][furnitureRot][1]);
			}
		}
	}
	if(playertextid == PLUSRZ[playerid])
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			VehicleData[vid][vToyRotZ][slot] = VehicleData[vid][vToyRotZ][slot] + 0.2;
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleData[vid][vToy][slot], E_STREAMER_ATTACH_R_Z, VehicleData[vid][vToyRotZ][slot]);
		}
		else
		{
			if(PlayerData[playerid][pEditType] == EDIT_TAG)
			{
				TagData[fid][tagPos][5] = TagData[fid][tagPos][5]+0.2;
				Streamer_SetFloatData(STREAMER_TYPE_OBJECT, TagData[fid][tagObject], E_STREAMER_R_Z, TagData[fid][tagPos][5]);
			}
			else
			{
				if(House_Inside(playerid) == -1)
					return SendErrorMessage(playerid, "You are no longer inside your house.");

				FurnitureData[fid][furnitureRot][2] = FurnitureData[fid][furnitureRot][2] - 0.2;

				Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnitureData[fid][furnitureObject], E_STREAMER_R_Z, FurnitureData[fid][furnitureRot][2]);
			}
		}
	}
	if(playertextid == MINRZ[playerid])
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			VehicleData[vid][vToyRotZ][slot] = VehicleData[vid][vToyRotZ][slot] - 0.2;
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleData[vid][vToy][slot], E_STREAMER_ATTACH_R_Z, VehicleData[vid][vToyRotZ][slot]);
		}
		else
		{
			if(PlayerData[playerid][pEditType] == EDIT_TAG)
			{
				TagData[fid][tagPos][5] = TagData[fid][tagPos][5]-0.2;
				Streamer_SetFloatData(STREAMER_TYPE_OBJECT, TagData[fid][tagObject], E_STREAMER_R_Z, TagData[fid][tagPos][5]);
			}
			else
			{
				if(House_Inside(playerid) == -1)
					return SendErrorMessage(playerid, "You are no longer inside your house.");

				FurnitureData[fid][furnitureRot][2] = FurnitureData[fid][furnitureRot][2] - 0.2;

				Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnitureData[fid][furnitureObject], E_STREAMER_R_Z, FurnitureData[fid][furnitureRot][2]);
			}
		}
	}
	if(playertextid == FINISHEDIT[playerid])
	{
		if(PlayerData[playerid][pEditing] != -1)
		{
			if(PlayerData[playerid][pEditType] == EDIT_TAG)
			{
				Tag_Save(fid);
			}
			else
			{
				Furniture_Save(fid);
			}
		}
		PlayerData[playerid][pEditing] = -1;
		PlayerData[playerid][pEditType] = EDIT_NONE;
		HideEditTextDraw(playerid);
	}
	new vendorid = PlayerData[playerid][pVendor];
	if(playertextid == DONEJOB[playerid])
	{
		if(IsValidLoading(playerid))
			return SendErrorMessage(playerid, "You can't do this at the moment!");

		if(VendorData[vendorid][vendorFood] != VendorData[vendorid][vendorReqFood])
			return SendErrorMessage(playerid, "Makanan tidak sesuai dengan yang dipesan!");

		if(VendorData[vendorid][vendorDrink] != VendorData[vendorid][vendorReqDrink])
			return SendErrorMessage(playerid, "Minuman tidak sesuai dengan yang dipesan!");

		new cash = RandomEx(300, 600);
		GiveMoney(playerid, cash);
		SendClientMessageEx(playerid, COLOR_SERVER, "SIDEJOB: {FFFFFF}Kamu mendapatkan {00FF00}$%s {FFFFFF}dari menjual {FFFF00}%s {FFFFFF}dan {FFFF00}%s", FormatNumber(cash), FoodName[VendorData[vendorid][vendorFood]], DrinkName[VendorData[vendorid][vendorDrink]]);
		
		Streamer_SetIntData(STREAMER_TYPE_ACTOR, VendorData[vendorid][vendorActor], E_STREAMER_MODEL_ID, g_aMaleSkins[random(sizeof(g_aMaleSkins))]);
		VendorData[vendorid][vendorReqFood] = random(2)+1;
		VendorData[vendorid][vendorReqDrink] = random(2)+1;		
		VendorData[vendorid][vendorFood] = FOOD_NONE;
		VendorData[vendorid][vendorDrink] = DRINK_NONE;

		PlayerTextDrawSetString(playerid, DRINKTD[playerid], sprintf("-_%s", DrinkName[VendorData[vendorid][vendorReqDrink]]));
		PlayerTextDrawSetString(playerid, FOODTD[playerid], sprintf("-_%s", FoodName[VendorData[vendorid][vendorReqFood]]));

		PlayerTextDrawSetString(playerid, DONEFOOD[playerid], "");
		PlayerTextDrawSetString(playerid, DONEDRINK[playerid], "");

		SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "Buyer %d says: Hello, i want to order %s and %s.", PlayerData[playerid][pVendor] + 1, FoodName[VendorData[PlayerData[playerid][pVendor]][vendorReqFood]], DrinkName[VendorData[PlayerData[playerid][pVendor]][vendorReqDrink]]);
	}
	if(playertextid == EXITJOB[playerid])
	{
		if(IsValidLoading(playerid))
			return SendErrorMessage(playerid, "You can't do this at the moment.");

		if(IsValidDynamicActor(VendorData[vendorid][vendorActor]))
			DestroyDynamicActor(VendorData[vendorid][vendorActor]);

		VendorData[vendorid][vendorReqFood] = FOOD_NONE;
		VendorData[vendorid][vendorReqDrink] = DRINK_NONE;
		VendorData[vendorid][vendorFood] = FOOD_NONE;
		VendorData[vendorid][vendorDrink] = DRINK_NONE;

		forex(i, 18)
		{
			PlayerTextDrawHide(playerid, VENDORTD[playerid][i]);
		}
		PlayerTextDrawHide(playerid, DONEJOB[playerid]);
		PlayerTextDrawHide(playerid, BURGERTD[playerid]);
		PlayerTextDrawHide(playerid, PIZZATD[playerid]);
		PlayerTextDrawHide(playerid, COLATD[playerid]);
		PlayerTextDrawHide(playerid, SPRUNKTD[playerid]);
		PlayerTextDrawHide(playerid, FOODTD[playerid]);
		PlayerTextDrawHide(playerid, DRINKTD[playerid]);
		PlayerTextDrawHide(playerid, RESETJOB[playerid]);
		PlayerTextDrawHide(playerid, EXITJOB[playerid]);
		PlayerTextDrawHide(playerid, DONEFOOD[playerid]);
		PlayerTextDrawHide(playerid, DONEDRINK[playerid]);
		CancelSelectTextDraw(playerid);
		PlayerData[playerid][pVendor] = -1;
		SetCameraBehindPlayer(playerid);
		TogglePlayerControllable(playerid, 1);
	}
	if(playertextid == RESETJOB[playerid])
	{
		if(IsValidLoading(playerid))
			return SendErrorMessage(playerid, "You can't do this at the moment!");

		PlayerTextDrawSetString(playerid, DONEFOOD[playerid], "");
		PlayerTextDrawSetString(playerid, DONEDRINK[playerid], "");

		VendorData[vendorid][vendorFood] = FOOD_NONE;
		VendorData[vendorid][vendorDrink] = DRINK_NONE;

	}
	if(playertextid == COLATD[playerid])
	{
		if(VendorData[vendorid][vendorDrink] != DRINK_NONE)
			return SendErrorMessage(playerid, "Kamu sudah membuat Drink! (%s)", DrinkName[VendorData[vendorid][vendorDrink]]);

		if(IsValidLoading(playerid))
			return SendErrorMessage(playerid, "You can't do this at the moment!");

		CreatePlayerLoadingBar(playerid, 10, "Filling_Cola...");
		SetTimerEx("MakeDrink", 10000, false, "ddd", playerid, DRINK_COLA, vendorid);
	}
	if(playertextid == SPRUNKTD[playerid])
	{
		if(VendorData[vendorid][vendorDrink] != DRINK_NONE)
			return SendErrorMessage(playerid, "Kamu sudah membuat Drink! (%s)", DrinkName[VendorData[vendorid][vendorDrink]]);

		if(IsValidLoading(playerid))
			return SendErrorMessage(playerid, "Can't do this at the moment!");

		CreatePlayerLoadingBar(playerid, 10, "Filling_Sprunk...");
		SetTimerEx("MakeDrink", 10000, false, "ddd", playerid, DRINK_SPRUNK, vendorid);
	}
	if(playertextid == PIZZATD[playerid])
	{
		if(VendorData[vendorid][vendorFood] != FOOD_NONE)
			return SendErrorMessage(playerid, "Kamu sudah membuat Food! (%s)", FoodName[VendorData[vendorid][vendorFood]]);

		if(IsValidLoading(playerid))
			return SendErrorMessage(playerid, "Can't do this at the moment!");

		CreatePlayerLoadingBar(playerid, 10, "Cooking_Pizza...");
		SetTimerEx("CookFood", 10000, false, "ddd", playerid, FOOD_PIZZA, vendorid);
	}
	if(playertextid == BURGERTD[playerid])
	{
		if(VendorData[vendorid][vendorFood] != FOOD_NONE)
			return SendErrorMessage(playerid, "Kamu sudah membuat Food! (%s)", FoodName[VendorData[vendorid][vendorFood]]);

		if(IsValidLoading(playerid))
			return SendErrorMessage(playerid, "Can't do this at the moment!");

		CreatePlayerLoadingBar(playerid, 10, "Cooking_Burger...");
		SetTimerEx("CookFood", 10000, false, "ddd", playerid, FOOD_BURGER, vendorid);
	}
	if(playertextid == FINISHSETUP[playerid])
	{
		if(!strlen(PlayerData[playerid][pTempName]))
			return SendErrorMessage(playerid, "You must specify a character name.");

	    if (!strlen(PlayerData[playerid][pBirthdate]))
	        return SendErrorMessage(playerid, "You must specify a birth date.");

		if (!strlen(PlayerData[playerid][pOrigin]))
		    return SendErrorMessage(playerid, "You must specify an origin.");	

		if(!PlayerData[playerid][pGender])
			return SendErrorMessage(playerid, "You must specify a character gender.");

		new query[156], Cache:execute;
		mysql_format(sqlcon,query,sizeof(query),"INSERT INTO `characters` (`Name`,`UCP`) VALUES('%e','%e')",PlayerData[playerid][pTempName],GetName(playerid));
		execute = mysql_query(sqlcon, query);
		PlayerData[playerid][pID] = cache_insert_id();
	 	cache_delete(execute);
	 	SetPlayerName(playerid, PlayerData[playerid][pTempName]);
		format(PlayerData[playerid][pName], MAX_PLAYER_NAME, PlayerData[playerid][pTempName]);
		HideCharacterSetup(playerid);
		SetupPlayerData(playerid);
	}
	if(playertextid == SETNAME[playerid])
	{
		CancelSelectTextDraw(playerid);
		ShowPlayerDialog(playerid, DIALOG_MAKECHAR, DIALOG_STYLE_INPUT, "Character Name", "Insert your Character Name\n\nExample: Finn_Xanderz, Javier_Cooper etc.", "Submit", "Cancel");
	}
	if(playertextid == SETBIRTHDATE[playerid])
	{
		CancelSelectTextDraw(playerid);
		ShowPlayerDialog(playerid, DIALOG_BIRTHDATE, DIALOG_STYLE_INPUT, "Date of Birth", "Please enter your date of birth below (DD/MM/YYYY):", "Submit", "Cancel");
	}
	if(playertextid == SETGENDER[playerid])
	{
		CancelSelectTextDraw(playerid);
		ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Character Gender", "Male\nFemale", "Submit", "Cancel");
	}
	if(playertextid == SETORIGIN[playerid])
	{
		CancelSelectTextDraw(playerid);
		ShowPlayerDialog(playerid, DIALOG_ORIGIN, DIALOG_STYLE_INPUT, "Origin", "Please enter the geographical origin of your character below:", "Submit", "Cancel");
	}
	if(playertextid == UCPTD[playerid][2])
	{
/*		if (PlayerChar[playerid][0][0] == EOS)
			return ShowPlayerDialog(playerid, DIALOG_MAKECHAR, DIALOG_STYLE_INPUT, "Create Character", "Insert your Character Name\n\nExample: Finn_Xanderz, Javier_Cooper etc.", "Create", "Exit");
*/
		if (PlayerChar[playerid][0][0] == EOS)
			return HideCharacter(playerid), ShowCharacterSetup(playerid);

		PlayerData[playerid][pChar] = 0;
		SetPlayerName(playerid, PlayerChar[playerid][0]);

		new cQuery[256];
		mysql_format(sqlcon, cQuery, sizeof(cQuery), "SELECT * FROM `characters` WHERE `Name` = '%s' LIMIT 1;", PlayerChar[playerid][PlayerData[playerid][pChar]]);
		mysql_tquery(sqlcon, cQuery, "LoadCharacterData", "d", playerid);

		HideCharacter(playerid);
	}
	if(playertextid == UCPTD[playerid][3])
	{
/*		if (PlayerChar[playerid][1][0] == EOS)
			return ShowPlayerDialog(playerid, DIALOG_MAKECHAR, DIALOG_STYLE_INPUT, "Create Character", "Insert your Character Name\n\nExample: Finn_Xanderz, Javier_Cooper etc.", "Create", "Exit");
*/
		if (PlayerChar[playerid][1][0] == EOS)
			return HideCharacter(playerid), ShowCharacterSetup(playerid);

		PlayerData[playerid][pChar] = 1;
		SetPlayerName(playerid, PlayerChar[playerid][1]);

		new cQuery[256];
		mysql_format(sqlcon, cQuery, sizeof(cQuery), "SELECT * FROM `characters` WHERE `Name` = '%s' LIMIT 1;", PlayerChar[playerid][PlayerData[playerid][pChar]]);
		mysql_tquery(sqlcon, cQuery, "LoadCharacterData", "d", playerid);

		HideCharacter(playerid);

	}
	if(playertextid == UCPTD[playerid][4])
	{
/*		if (PlayerChar[playerid][2][0] == EOS)
			return ShowPlayerDialog(playerid, DIALOG_MAKECHAR, DIALOG_STYLE_INPUT, "Create Character", "Insert your Character Name\n\nExample: Finn_Xanderz, Javier_Cooper etc.", "Create", "Exit");
*/
		if (PlayerChar[playerid][2][0] == EOS)
			return HideCharacter(playerid), ShowCharacterSetup(playerid);

		PlayerData[playerid][pChar] = 2;
		SetPlayerName(playerid, PlayerChar[playerid][2]);

		new cQuery[256];
		mysql_format(sqlcon, cQuery, sizeof(cQuery), "SELECT * FROM `characters` WHERE `Name` = '%s' LIMIT 1;", PlayerChar[playerid][PlayerData[playerid][pChar]]);
		mysql_tquery(sqlcon, cQuery, "LoadCharacterData", "d", playerid);

		HideCharacter(playerid);
	}
	return 1;
}


public OnGameModeExit()
{
	forex(i, MAX_TREE) if(TreeData[i][treeExists])
	{
		Tree_Save(i);
	}
	mysql_close(sqlcon);
	return 1;
}

public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
	printf("[IZCMD] %s: %s", GetName(playerid), cmdtext);
	
	if(!PlayerData[playerid][pSpawned])
		return SendErrorMessage(playerid, "You are not spawned!");

    if (!success) 
    {
        new 
            guessCmd[32],
            dist = Command_Guess(guessCmd, cmdtext);

        if (dist < 3)
        {
            SendClientMessageEx(playerid, COLOR_GREY, "ERROR: {FFFFFF}Command \"%s\" is not found, did you mean \"%s\"?", cmdtext, guessCmd);
        }
        else
        {
            SendClientMessageEx(playerid, COLOR_GREY, "ERROR: {FFFFFF}Command \"%s\" is not found", cmdtext);
        }
    }
    return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if(PlayerData[playerid][pAdmin] > 0 && PlayerData[playerid][pAduty])
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			SetVehiclePos(GetPlayerVehicleID(playerid), fX, fY, fZ);

		else
			SetPlayerPosFindZ(playerid, fX, fY, fZ);
	}
	return 1;
}
public OnPlayerConnect(playerid)
{
	g_RaceCheck{playerid} ++;
	ResetVariable(playerid);
	CreatePlayerHUD(playerid);
	SetTimerEx("PlayerCheck", 1000, false, "ii", playerid, g_RaceCheck{playerid});
	LoadRemoveBuilding(playerid);
	Streamer_SetVisibleItems(STREAMER_TYPE_OBJECT, 500, playerid);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	foreach(new ii : Player)
    {
        if(PlayerData[ii][pAdmin] > 0)
        {
            SendDeathMessageToPlayer(ii, killerid, playerid, reason);
        }
    }
    if(reason == 51 || reason == 255 || reason == 49)
    {
		if(!PlayerData[playerid][pInjured])
		{
			PlayerData[playerid][pInjured] = true;
			GetPlayerPos(playerid, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]);
		}
		else
		{
			PlayerData[playerid][pDead] = true;
		}
    }
	if(PlayerData[playerid][pVendor] != -1)
	{
		if(IsValidDynamicActor(VendorData[PlayerData[playerid][pVendor]][vendorActor]))
			DestroyDynamicActor(VendorData[PlayerData[playerid][pVendor]][vendorActor]);

		VendorData[PlayerData[playerid][pVendor]][vendorReqFood] = FOOD_NONE;
		VendorData[PlayerData[playerid][pVendor]][vendorReqDrink] = DRINK_NONE;
		VendorData[PlayerData[playerid][pVendor]][vendorFood] = FOOD_NONE;
		VendorData[PlayerData[playerid][pVendor]][vendorDrink] = DRINK_NONE;
		PlayerData[playerid][pVendor] = -1;
	}
	if(IsValidDynamicObject(StretcherEquipped[playerid]))
	{
		DestroyDynamicObject(StretcherEquipped[playerid]);
		StretcherHolding[playerid] = 0;
		if(StretcherPlayerID[playerid] >= 0)
		{
			TogglePlayerControllable(StretcherPlayerID[playerid], 1);
			ClearAnimations(StretcherPlayerID[playerid], 1);
			StretcherPlayerID[playerid] = -1;
		}
	}
    return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
	if(PlayerData[playerid][pCrate] != -1)
	{
		new id = PlayerData[playerid][pCrate];
		if(CrateData[id][crateExists])
		{
			Crate_Delete(id);
		}
	}
	if (PlayerData[playerid][pCallLine] != INVALID_PLAYER_ID)
   	{
    	CancelCall(playerid);
	}
	if(PlayerData[playerid][pMasked] && IsValidDynamic3DTextLabel(MaskLabel[playerid]))
	{
		DestroyDynamic3DTextLabel(MaskLabel[playerid]);
	}
	if(PlayerData[playerid][pVendor] != -1)
	{
		if(IsValidDynamicActor(VendorData[PlayerData[playerid][pVendor]][vendorActor]))
			DestroyDynamicActor(VendorData[PlayerData[playerid][pVendor]][vendorActor]);

		VendorData[PlayerData[playerid][pVendor]][vendorReqFood] = FOOD_NONE;
		VendorData[PlayerData[playerid][pVendor]][vendorReqDrink] = DRINK_NONE;
		VendorData[PlayerData[playerid][pVendor]][vendorFood] = FOOD_NONE;
		VendorData[PlayerData[playerid][pVendor]][vendorDrink] = DRINK_NONE;
		PlayerData[playerid][pVendor] = -1;
	}
	if(PlayerData[playerid][pOnDMV])
	{
		PlayerData[playerid][pOnDMV] = false;
		PlayerData[playerid][pIndexDMV] = -1;

		if(IsValidVehicle(PlayerData[playerid][pVehicleDMV]))
			DestroyVehicle(PlayerData[playerid][pVehicleDMV]);

	}
	if(IsValidDynamic3DTextLabel(PlayerData[playerid][pInjuredLabel]))
		DestroyDynamic3DTextLabel(PlayerData[playerid][pInjuredLabel]);

	forex(i, MAX_INVENTORY)
	{
	    InventoryData[playerid][i][invExists] = false;
	    InventoryData[playerid][i][invModel] = 0;
	    InventoryData[playerid][i][invQuantity] = 0;
	}
	switch (reason)
	{
 	   	case 0:
	   	{
	   	    SendNearbyMessage(playerid, 15.0, COLOR_GREY, "%s has disconnected from RV:RP (Timeout/Crash)", ReturnName(playerid));
		}
	   	case 1:
 	  	{
			SendNearbyMessage(playerid, 15.0, COLOR_GREY, "%s has disconnected from RV:RP (Leaving)", ReturnName(playerid));
		}
		case 2:
	    {
	        SendNearbyMessage(playerid, 15.0, COLOR_GREY, "%s has disconnected from RV:RP (Kicked/Banned)", ReturnName(playerid));
		}
	}
	RemovePlayerReports(playerid);
	UnloadPlayerVehicle(playerid);
	SaveData(playerid);
	RemoveDrag(playerid);
	DragCheck(playerid);
	RemovePlayerADO(playerid);
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER)
	{
	    new vehicleid = GetPlayerVehicleID(playerid);
	    new pvid = Vehicle_Inside(playerid);
	    new time[3];
	    SetPlayerArmedWeapon(playerid, 0);
	    if(IsEngineVehicle(vehicleid) && IsSpeedoVehicle(vehicleid) && !PlayerData[playerid][pTogHud])
	    {
	        PlayerTextDrawShow(playerid, FUELTEXT[playerid]);
	        PlayerTextDrawShow(playerid, FUELTD[playerid]);
	        PlayerTextDrawShow(playerid, FUELTEXT[playerid]);
	        PlayerTextDrawShow(playerid, VHPTD[playerid]);
	        PlayerTextDrawShow(playerid, VHPTEXT[playerid]);
	        PlayerTextDrawShow(playerid, SPEEDTEXT[playerid]);
			for (new i = 8; i != 21; i ++)
			{
			    PlayerTextDrawShow(playerid, HUDTD[playerid][i]);
			}
		}
		if(pvid != -1 && VehicleData[pvid][vRental] != -1)
		{
		    GetElapsedTime(VehicleData[pvid][vRentTime], time[0], time[1], time[2]);
		    SendClientMessageEx(playerid, COLOR_SERVER, "RENTAL: {FFFFFF}Sisa rental {00FFFF}%s {FFFFFF}milikmu adalah {FFFF00}%02d jam %02d menit %02d detik", GetVehicleName(vehicleid), time[0], time[1], time[2]);
		}
		if(!IsEngineVehicle(vehicleid))
		{
		    SwitchVehicleEngine(vehicleid, true);
		}
		if(IsBusVehicle(vehicleid))
		{
			if(!OnBus[playerid])
			{
				if(PlayerData[playerid][pBusDelay] > 0)
					return SendErrorMessage(playerid, "Kamu harus menunggu %d menit sebelum bekerja kembali!", PlayerData[playerid][pBusDelay]/60), RemovePlayerFromVehicle(playerid);

				ShowPlayerDialog(playerid, DIALOG_BUS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Bus Sidejob", "{FFFFFF}Pekerjaan ini mengharuskan kamu untuk mengikuti semua petunjuk(Checkpoint)\n{FFFFFF}Pada radar hingga selesai, Gunakan Roleplay Driving saat sedang berkendara Bus\n{FFFFFF}Saat sudah selesai kamu akan mendapatkan {009000}$100.0 {FFFFFF}di Salary\nNamun jika tidak selesai, kamu tidak akan mendapat apa-apa.\n\n{FFFFFF}HINT: Jangan turun dari bus saat berkerja, atau kamu akan gagal!", "Start", "Cancel");
			}
		}
		if(IsSweeperVehicle(vehicleid))
		{
			if(!OnSweeping[playerid])
			{	
				if(PlayerData[playerid][pSweeperDelay] > 0)
					return SendErrorMessage(playerid, "Kamu harus menunggu %d menit sebelum bekerja kembali!", PlayerData[playerid][pSweeperDelay]/60), RemovePlayerFromVehicle(playerid);

				ShowPlayerDialog(playerid, DIALOG_SWEEPER, DIALOG_STYLE_MSGBOX, "{FFFFFF}Sweeper Sidejob", "{FFFFFF}Pekerjaan ini mengharuskan kamu untuk mengikuti semua petunjuk(Checkpoint)\nSelalu gunakan RP Drive & jangan abuse kendaraan jika tidak ingin\nDi beri punishment oleh {FF0000}Administrator","Continue", "Cancel");
			}
		}
		if(IsPoliceVehicle(vehicleid) && GetFactionType(playerid) != FACTION_POLICE)
		{
			RemovePlayerFromVehicle(playerid);
			SendErrorMessage(playerid, "Kamu bukan bagian dari Los Santos Police Departement!");
		}
		if(IsNewsVehicle(vehicleid) && GetFactionType(playerid) != FACTION_NEWS)
		{
			RemovePlayerFromVehicle(playerid);
			SendErrorMessage(playerid, "Kamu bukan bagian dari Los Santos News!");
		}
		if(IsMedicVehicle(vehicleid) && GetFactionType(playerid) != FACTION_MEDIC)
		{
			RemovePlayerFromVehicle(playerid);
			SendErrorMessage(playerid, "Kamu bukan bagian dari Los Santos Emergency Service!");
		}
	    foreach (new i : Player) if (PlayerData[i][pSpectator] == playerid) 
	    {
     		PlayerSpectateVehicle(i, GetPlayerVehicleID(playerid));
		}
	}
	if(newstate == PLAYER_STATE_PASSENGER)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		new driverid = GetVehicleDriver(vehicleid);
  		SetPlayerArmedWeapon(playerid, 0);
		if(PlayerData[driverid][pJob] == JOB_TAXI && PlayerData[driverid][pJobduty])
		{
		    CreateTaxi(playerid);
		    PlayerData[playerid][pFareTimer] = SetTimerEx("UpdateFare", 7000, true, "ii", playerid, driverid);
		    SendClientMessageEx(playerid, COLOR_SERVER, "TAXI: {FFFFFF}You've entering %s taxi with fare $%s", ReturnName(driverid), FormatNumber(PlayerData[driverid][pFare]));
		    SendClientMessageEx(driverid, COLOR_SERVER, "TAXI: {FFFFFF}%s has entering your taxi.", ReturnName(playerid));
		    PlayerData[playerid][pInTaxi] = true;
		}
	    foreach (new i : Player) if (PlayerData[i][pSpectator] == playerid) 
	    {
     		PlayerSpectateVehicle(i, GetPlayerVehicleID(playerid));
		}
	}
	if (oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER)
	{
	    foreach (new i : Player) if (PlayerData[i][pSpectator] == playerid)
		{
     		PlayerSpectatePlayer(i, playerid);
		}
		if(StretcherHolding[playerid] == 1)
		{
			AttachDynamicObjectToPlayer(StretcherEquipped[playerid], playerid, 0.0, 1.5, -1.0, 0.0, 0.0, 180.0);
			StretcherHolding[playerid] = 2;
		}
	}
	if(oldstate == PLAYER_STATE_PASSENGER && newstate == PLAYER_STATE_ONFOOT && StretcherHolding[playerid])
	{
 		SpawnStretcher(playerid);
	}
	if (newstate == PLAYER_STATE_WASTED && PlayerData[playerid][pJailTime] < 1)
	{
		if(PlayerData[playerid][pInjured])
		{
			PlayerData[playerid][pDead] = true;
			PlayerData[playerid][pInjured] = false;
		}
	}
	if(oldstate == PLAYER_STATE_DRIVER)
	{
        PlayerTextDrawHide(playerid, FUELTEXT[playerid]);
        PlayerTextDrawHide(playerid, FUELTD[playerid]);
        PlayerTextDrawHide(playerid, FUELTEXT[playerid]);
        PlayerTextDrawHide(playerid, VHPTD[playerid]);
        PlayerTextDrawHide(playerid, VHPTEXT[playerid]);
        PlayerTextDrawHide(playerid, SPEEDTEXT[playerid]);
		for (new i = 8; i != 21; i ++)
		{
		    PlayerTextDrawHide(playerid, HUDTD[playerid][i]);
		}
		if(PlayerData[playerid][pJobduty] && PlayerData[playerid][pJob] == JOB_TAXI)
		{
			HideTaxi(playerid);
			PlayerData[playerid][pJobduty] = false;
			SetPlayerColor(playerid, COLOR_WHITE);
		}
	}
	return 1;
}

public OnPlayerEditVehicleObject(playerid,vehicleid,response,Float:x,Float:y,Float:z,Float:rx,Float:ry,Float:rz)
{
	if(response)
	{
	    new idxs = PlayerData[playerid][pVehicle];
	    VehicleData[idxs][vToyPosX][PlayerData[playerid][pListitem]] = x;
		VehicleData[idxs][vToyPosY][PlayerData[playerid][pListitem]] = y;
		VehicleData[idxs][vToyPosZ][PlayerData[playerid][pListitem]] = z;
		VehicleData[idxs][vToyRotX][PlayerData[playerid][pListitem]] = rx;
		VehicleData[idxs][vToyRotY][PlayerData[playerid][pListitem]] = ry;
		VehicleData[idxs][vToyRotZ][PlayerData[playerid][pListitem]] = rz;
	}
	return 1;
}

public OnModelSelectionResponse(playerid, extraid, index, modelid, response)
{
	if ((response) && (extraid == MODEL_SELECTION_FURNITURE))
	{
        new
			id = House_Inside(playerid),
			price;

		new
		    Float:x,
		    Float:y,
		    Float:z,
		    Float:angle;

        GetPlayerPos(playerid, x, y, z);
        GetPlayerFacingAngle(playerid, angle);

        x += 5.0 * floatsin(-angle, degrees);
        y += 5.0 * floatcos(-angle, degrees);

	    if (id != -1)
	    {
	        price = Furniture_ReturnPrice(PlayerData[playerid][pListitem]);

	        if (GetMoney(playerid) < price)
	            return SendErrorMessage(playerid, "You have insufficient funds for the purchase.");

			new furniture = Furniture_Add(House_Inside(playerid), GetFurnitureNameByModel(modelid), modelid, x, y, z, 0.0, 0.0, angle);

			if(furniture == INVALID_ITERATOR_SLOT)
				return SendErrorMessage(playerid, "The server cannot create more furniture's!");

			GiveMoney(playerid, -price);
			SendServerMessage(playerid, "You have purchased a \"%s\" for %s.", GetFurnitureNameByModel(modelid), FormatNumber(price));
			Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
	    }
	}
	if ((response) && (extraid == MODEL_SELECTION_MODSHOP))
	{
	    if(GetMoney(playerid) < 8000)
	        return SendErrorMessage(playerid, "You need $80.00 to purchase attachment's");
	        
	    new Float:pX, Float:pY, Float:pZ, Float:pA;

		new x = PlayerData[playerid][pVehicle];

		GetVehiclePos(VehicleData[x][vVehicle], pX, pY, pZ);
		GetVehicleZAngle(VehicleData[x][vVehicle], pA);
		VehicleData[x][vToyID][PlayerData[playerid][pListitem]] = modelid;

		VehicleData[x][vToyPosX][PlayerData[playerid][pListitem]] = 0.00000;
		VehicleData[x][vToyPosY][PlayerData[playerid][pListitem]] = 0.00000;
		VehicleData[x][vToyPosZ][PlayerData[playerid][pListitem]] = 0.00000;
		VehicleData[x][vToyRotX][PlayerData[playerid][pListitem]] = 0.00000;
		VehicleData[x][vToyRotY][PlayerData[playerid][pListitem]] = 0.00000;
		VehicleData[x][vToyRotZ][PlayerData[playerid][pListitem]] = 0.00000;
		VehicleData[x][vToy][PlayerData[playerid][pListitem]] = CreateDynamicObject(modelid,pX, pY, pZ,0,0,pA);
		AttachDynamicObjectToVehicle(VehicleData[x][vToy][PlayerData[playerid][pListitem]], VehicleData[x][vVehicle], 0, 0, 0, 0, 0, 0);

		Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
		GiveMoney(playerid, -8000);
		SendServerMessage(playerid, "You have successfully purchased vehicle attachment for slot %d! (model: %d)", PlayerData[playerid][pListitem] + 1, modelid);
		SendServerMessage(playerid, "Use {FFFF00}/vehicle attachment {FFFFFF}to manage vehicle attachment's!");
	}
	if ((response) && (extraid == MODEL_SELECTION_FACTION_SKINS))
	{
	    ShowPlayerDialog(playerid, DIALOG_EDITLOCKER_SKIN, DIALOG_STYLE_LIST, "Edit Skin", "Add by Model ID\nAdd by Thumbnail\nClear Slot", "Select", "Cancel");
	    PlayerData[playerid][pSelectedSlot] = index;
	}
	if(extraid == MODEL_SELECTION_BUYSKIN)
	{
		if(response)
		{
	        GiveMoney(playerid, -PlayerData[playerid][pSkinPrice]);
			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s has paid $%s and purchased a %s.", ReturnName(playerid), FormatNumber(PlayerData[playerid][pSkinPrice]), ProductName[PlayerData[playerid][pInBiz]][0]);
			BizData[PlayerData[playerid][pInBiz]][bizStock]--;		
			BizData[PlayerData[playerid][pInBiz]][bizVault] += PlayerData[playerid][pSkinPrice];
			UpdatePlayerSkin(playerid, modelid);	
		}
	}
	if((response) && (extraid == MODEL_SELECTION_ACC))
	{
		if(GetPlayerFreeToySlot(playerid) == -1)
			return SendErrorMessage(playerid, "You already have full slot of Accessory!");

		ShowPlayerDialog(playerid, DIALOG_TOYPOSISIBUY, DIALOG_STYLE_LIST, "Bone Selection", "Spine\nHead\nLeft upper arm\nRight upper arm\nLeft hand\nRight hand\nLeft thigh\nRight thigh\nLeft foot\nRight foot\nRight calf\nLeft calf\nLeft forearm\nRight forearm\nLeft shoulder\nRight shoulder\nNeck\nJaw", "Choose", "Cancel");
		SendServerMessage(playerid, "Please select Bone for your Accessory");
		PlayerData[playerid][pTempModel] = modelid;
	}
	if ((response) && (extraid == MODEL_SELECTION_FACTION_SKIN))
	{
	    new factionid = PlayerData[playerid][pFaction];

		if (factionid == -1 || !IsNearFactionLocker(playerid))
	    	return 0;

		if (modelid == 19300)
		    return SendErrorMessage(playerid, "There is no model in the selected slot.");

  		SetFactionSkin(playerid, modelid);
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has changed their uniform.", ReturnName(playerid));
	}

	if ((response) && (extraid == MODEL_SELECTION_COLOR))
	{
	    new vehicleid = PlayerData[playerid][pVehicle];

        if (vehicleid == INVALID_VEHICLE_ID)
		    return SendErrorMessage(playerid, "You are not standing near any vehicle.");

       // GetVehicleZAngle(vehicleid, PlayerData[playerid][pAngle]);
        PlayerData[playerid][pColor] = modelid;

		GiveWeaponToPlayer(playerid, 41, 3000, 3000);
        SendServerMessage(playerid, "Spray the vehicle using Spraycan towards the vehicle!");
		PlayerData[playerid][pSpraying] = true;
	}
	if ((response) && (extraid == MODEL_SELECTION_ADD_SKIN))
	{
	    FactionData[PlayerData[playerid][pFactionEdit]][factionSkins][PlayerData[playerid][pSelectedSlot]] = modelid;
		Faction_Save(PlayerData[playerid][pFactionEdit]);

		SendServerMessage(playerid, "You have set the skin ID in slot %d to %d.", PlayerData[playerid][pSelectedSlot], modelid);
	}
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	UpdateWeapons(playerid);
    if(weaponid >= 22 && weaponid <= 38 && PlayerData[playerid][pDurability][g_aWeaponSlots[weaponid]] > 0)
    {
        PlayerData[playerid][pDurability][g_aWeaponSlots[weaponid]]--;
        PlayerData[playerid][pAmmo][g_aWeaponSlots[weaponid]]--;
	}
 	if (weaponid >= 22 && weaponid <= 38 && GetPlayerAmmo(playerid) == 1 || PlayerData[playerid][pDurability][g_aWeaponSlots[weaponid]] <= 0)
	{
	    ResetWeapon(playerid, weaponid);
	}
	return 1;
}

public OnPlayerCrashVehicle(playerid, vehicleid, Float:damage)
{
	if(IsDoorVehicle(vehicleid))
	{
		if(!PlayerData[playerid][pSeatbelt])
		{
			new Float:hp, amount = RandomEx(1, 3);
			GetPlayerHealth(playerid, hp);
			if(hp - amount <= 7.0)
			{
				InjuredPlayer(playerid, INVALID_PLAYER_ID, WEAPON_VEHICLE);
			}
			else
			{
				SetPlayerHealth(playerid, hp-amount);
			}
		}
	}
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(StretcherHolding[playerid] == 1)
	{
		SetPlayerCurrentPos(playerid);
		SendErrorMessage(playerid, "You may not enter a vehicle with a stretcher equipped.");
		return true;
	}
	if(IsFactionVehicle(vehicleid) != -1 && !ispassenger)
	{
		if(PlayerData[playerid][pFaction] != GetFactionByID(FactionVehicle[IsFactionVehicle(vehicleid)][fvFaction]))
			return SendErrorMessage(playerid, "You cannot use this vehicle!"), SetPlayerCurrentPos(playerid);
	}
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
    if(PlayerData[playerid][pInTaxi])
    {
	    new driverid = GetVehicleDriver(vehicleid);
        KillTimer(PlayerData[playerid][pFareTimer]);
        GiveMoney(driverid, PlayerData[playerid][pTotalFare]);
        GiveMoney(playerid, -PlayerData[playerid][pTotalFare]);
        SendClientMessageEx(playerid, COLOR_SERVER, "TAXI: {FFFFFF}You've paid {00FF00}$%s {FFFFFF}to the taxi driver.", FormatNumber(PlayerData[playerid][pTotalFare]));
        SendClientMessageEx(driverid, COLOR_SERVER, "TAXI: {FFFFFF}You've earn {00FF00}$%s {FFFFFF}from the passenger.", FormatNumber(PlayerData[playerid][pTotalFare]));
        PlayerData[playerid][pTotalFare] = 0;
        PlayerData[driverid][pTotalFare] = 0;
        HideTaxi(playerid);
        PlayerData[playerid][pInTaxi] = false;
		PlayerTextDrawSetString(driverid, FARETOTALTD[driverid], "Trip_Fare:_~g~$0");
	}
	if(OnSweeping[playerid] && IsSweeperVehicle(vehicleid))
	{
		SetVehicleToRespawn(vehicleid);
		VehCore[vehicleid][vehFuel] = 100;
		SendClientMessage(playerid, COLOR_SERVER, "SIDEJOB: {FFFFFF}Kamu gagal bekerja sebagai {FFFF00}Street Sweeper {FFFFFF}karena keluar dari kendaraan!");
		OnSweeping[playerid] = false;
		SweeperIndex[playerid] = 0;
		DisablePlayerCheckpoint(playerid);
	}
	if(OnBus[playerid] && IsBusVehicle(vehicleid))
	{
		SetVehicleToRespawn(vehicleid);
		VehCore[vehicleid][vehFuel] = 100;
		SendClientMessage(playerid, COLOR_SERVER, "SIDEJOB: {FFFFFF}Kamu gagal bekerja sebagai {FFFF00}Bus Driver {FFFFFF}karena keluar dari kendaraan!");
		OnBus[playerid] = false;
		BusIndex[playerid] = 0;
		DisablePlayerRaceCheckpoint(playerid);
	}
	if(PlayerData[playerid][pOnDMV] && vehicleid == PlayerData[playerid][pVehicleDMV])
	{
		PlayerData[playerid][pOnDMV] = false;
		PlayerData[playerid][pIndexDMV] = -1;
		DestroyVehicle(PlayerData[playerid][pVehicleDMV]);
		SendClientMessage(playerid, COLOR_SERVER, "DMV: {FFFFFF}Kamu gagal dalam tes mengemudi karena keluar dari kendaraan!");
	}
	if(PlayerData[playerid][pSeatbelt] && IsDoorVehicle(vehicleid))
	{
		SetPlayerSeatbelt(playerid);
	}
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	if(OnBus[playerid] && IsBusVehicle(GetPlayerVehicleID(playerid)))
	{
		BusWaiting[playerid] = false;
	}
	return 1;
}
public OnPlayerEnterRaceCheckpoint(playerid)
{
	if(OnBus[playerid] && IsBusVehicle(GetPlayerVehicleID(playerid)) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		if(BusIndex[playerid] == 1)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, 1578.6227,-2282.6621,13.4325, 1657.4299,-2256.2620,13.4442, 5.0);
			BusIndex[playerid] = 2;
		}
		else if(BusIndex[playerid] == 2)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, 1657.4299,-2256.2620,13.4442,1730.0908,-2293.9309,13.4757, 5.0);
			BusIndex[playerid] = 3;			
		}
		else if(BusIndex[playerid] == 3)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, 1730.0908,-2293.9309,13.4757,1648.6638,-2316.4980,13.4837, 5.0);
			BusIndex[playerid] = 4;			
		}
		else if(BusIndex[playerid] == 4)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, 1648.6638,-2316.4980,13.4837,1572.4673,-2283.9280,13.4162, 5.0);
			BusIndex[playerid] = 5;			
		}
		else if(BusIndex[playerid] == 5)
		{
			BusWaiting[playerid] = true;
			BusTime[playerid] = 10;
			GameTextForPlayer(playerid, "Waiting_time:_10", 1000, 6);
			PlayerPlaySound(playerid, 43000, 0.0, 0.0, 0.0);		
		}
		else if(BusIndex[playerid] == 6)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, 1517.5294,-2258.6445,13.4865, 1433.5347,-2254.0715,13.4880, 5.0);
			BusIndex[playerid] = 7;
		}
		else if(BusIndex[playerid] == 7)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, 1433.5347,-2254.0715,13.4880, 1348.7776,-2229.3777,13.4834, 5.0);
			BusIndex[playerid] = 8;			
		}
		else if(BusIndex[playerid] == 8)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, 1348.7776,-2229.3777,13.4834, 1622.6160,-1757.8160,27.6869, 5.0);
			BusIndex[playerid] = 9;			
		}
		else if(BusIndex[playerid] == 9)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, 1622.6160,-1757.8160,27.6869, 1696.1044,-1540.4541,23.2914, 5.0);
			BusIndex[playerid] = 10;			
		}
		else if(BusIndex[playerid] == 10)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, 1696.1044,-1540.4541,23.2914, 2036.7634,-1569.8619,10.7410, 5.0);
			BusIndex[playerid] = 11;			
		}
		else if(BusIndex[playerid] == 11)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, 2036.7634,-1569.8619,10.7410, 2079.0288,-1649.6421,13.4905, 5.0);
			BusIndex[playerid] = 12;			
		}
		else if(BusIndex[playerid] == 12)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, 2079.0288,-1649.6421,13.4905, 2081.5332,-1779.9885,13.4842, 5.0);
			BusIndex[playerid] = 13;			
		}
		else if(BusIndex[playerid] == 13)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, 2081.5332,-1779.9885,13.4842, 2073.8169,-1929.0842,13.4298, 5.0);
			BusIndex[playerid] = 14;			
		}
		else if(BusIndex[playerid] == 14)
		{
			BusWaiting[playerid] = true;
			BusTime[playerid] = 10;
			GameTextForPlayer(playerid, "Waiting_time:_10", 1000, 6);
			PlayerPlaySound(playerid, 43000, 0.0, 0.0, 0.0);					
		}
		else if(BusIndex[playerid] == 15)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, 1824.8662,-1919.8773,13.4844, 1804.6466,-1829.9139,13.4988, 5.0);
			BusIndex[playerid] = 16;			
		}
		else if(BusIndex[playerid] == 16)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, 1804.6466,-1829.9139,13.4988, 1686.9866,-1812.3054,13.4832, 5.0);
			BusIndex[playerid] = 17;			
		}
		else if(BusIndex[playerid] == 17)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, 1686.9866,-1812.3054,13.4832, 1578.3644,-1869.9058,13.4922, 5.0);
			BusIndex[playerid] = 18;			
		}
		else if(BusIndex[playerid] == 18)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, 1578.3644,-1869.9058,13.4922, 1571.9091,-1729.7318,13.4829, 5.0);
			BusIndex[playerid] = 19;			
		}
		else if(BusIndex[playerid] == 19)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, 1571.9091,-1729.7318,13.4829, 1447.6362,-1728.7437,13.4891, 5.0);
			BusIndex[playerid] = 20;			
		}
		else if(BusIndex[playerid] == 20)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, 1447.6362,-1728.7437,13.4891, 1314.8708,-1729.7445,13.4834, 5.0);
			BusIndex[playerid] = 21;			
		}
		else if(BusIndex[playerid] == 21)
		{
			BusWaiting[playerid] = true;
			BusTime[playerid] = 10;
			GameTextForPlayer(playerid, "Waiting_time:_10", 1000, 6);
			PlayerPlaySound(playerid, 43000, 0.0, 0.0, 0.0);				

		}
		else if(BusIndex[playerid] == 22)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, 1353.8236,-1464.6906,13.4840, 1310.0725,-1392.4016,13.4015, 5.0);
			BusIndex[playerid] = 23;			
		}
		else if(BusIndex[playerid] == 23)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, 1310.0725,-1392.4016,13.4015, 1209.3442,-1324.4760,13.4991, 5.0);
			BusIndex[playerid] = 24;	
		}
		else if(BusIndex[playerid] == 24)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, 1209.3442,-1324.4760,13.4991, 1144.7260,-1277.7739,13.6474, 5.0);
			BusIndex[playerid] = 25;	
		}
		else if(BusIndex[playerid] == 25)
		{
			BusWaiting[playerid] = true;
			BusTime[playerid] = 10;
			GameTextForPlayer(playerid, "Waiting_time:_10", 1000, 6);
			PlayerPlaySound(playerid, 43000, 0.0, 0.0, 0.0);					
		}
		else if(BusIndex[playerid] == 26)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, 1027.3414,-1320.6429,13.4868, 638.7104,-1314.1578,13.4999, 5.0);
			BusIndex[playerid] = 27;				
		}
		else if(BusIndex[playerid] == 27)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, 638.7104,-1314.1578,13.4999, 563.9636,-1227.5962,17.4035, 5.0);
			BusIndex[playerid] = 28;				
		}
		else if(BusIndex[playerid] == 28)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, 563.9636,-1227.5962,17.4035, 173.6646,-1512.7411,12.3900, 5.0);
			BusIndex[playerid] = 29;				
		}
		else if(BusIndex[playerid] == 29)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, 173.6646,-1512.7411,12.3900,161.6691,-1596.2213,13.3634, 5.0);
			BusIndex[playerid] = 30;				
		}
		else if(BusIndex[playerid] == 30)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, 161.6691,-1596.2213,13.3634, 543.2385,-1734.5708,12.5196, 5.0);
			BusIndex[playerid] = 31;				
		}
		else if(BusIndex[playerid] == 31)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, 543.2385,-1734.5708,12.5196, 1023.7906,-1817.6897,13.9530, 5.0);
			BusIndex[playerid] = 32;				
		}
		else if(BusIndex[playerid] == 32)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, 1023.7906,-1817.6897,13.9530, 1095.0101,-2368.2830,12.1141, 5.0);
			BusIndex[playerid] = 33;				
		}
		else if(BusIndex[playerid] == 33)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, 1095.0101,-2368.2830,12.1141, 1359.0200,-2437.1130,8.2462, 5.0);
			BusIndex[playerid] = 34;				
		}
		else if(BusIndex[playerid] == 34)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, 1359.0200,-2437.1130,8.2462, 1386.9279,-2289.4104,13.4278, 5.0);
			BusIndex[playerid] = 35;				
		}
		else if(BusIndex[playerid] == 35)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, 1386.9279,-2289.4104,13.4278, 1452.4850,-2332.7874,13.4836, 5.0);
			BusIndex[playerid] = 36;				
		}
		else if(BusIndex[playerid] == 36)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, 1452.4850,-2332.7874,13.4836, 1521.8217,-2301.3335,13.4930, 5.0);
			BusIndex[playerid] = 37;				
		}
		else if(BusIndex[playerid] == 37)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 0, 1521.8217,-2301.3335,13.4930, 1547.4862,-2247.9382,13.6473, 5.0);
			BusIndex[playerid] = 38;				
		}
		else if(BusIndex[playerid] == 38)
		{
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid, 1, 1547.4862,-2247.9382,13.6473, 1547.4862,-2247.9382,13.6473, 5.0);
			BusIndex[playerid] = 39;				
		}
		else if(BusIndex[playerid] == 39)
		{
			BusIndex[playerid] = 0;
			OnBus[playerid] = false;
			VehCore[GetPlayerVehicleID(playerid)][vehFuel] = 100;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid, COLOR_SERVER, "SIDEJOB: {FFFFFF}Kamu berhasil menyelesaikan pekerjaan dan mendapatkan {00FF00}$100.00 {FFFFFF}di {FFFF00}/salary");
			DisablePlayerRaceCheckpoint(playerid);
			AddSalary(playerid, "Bus Driver", 10000);
			PlayerData[playerid][pBusDelay] = 1200;
		}
	}
	return 1;
}

public OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
{
	new pvid = Vehicle_Inside(playerid);
	forex(i, MAX_SPEEDCAM) if(SpeedData[i][speedExists])
	{
		if(areaid == SpeedData[i][speedArea] && pvid != -1)
		{
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && GetVehicleSpeedKMH(VehicleData[pvid][vVehicle]) > SpeedData[i][speedLimit])
			{
			    new
					location[MAX_ZONE_NAME];

			    format(SpeedData[i][speedPlate], 32, VehicleData[i][vPlate]);
			    SpeedData[i][speedVehicle] = GetVehicleModel(VehicleData[pvid][vVehicle]);
			    SpeedData[i][speedTime] = gettime();
			    Speed_RefreshText(i);
	            GetPlayer2DZone(playerid, location, MAX_ZONE_NAME);
				SendDutyMessage(FACTION_POLICE,COLOR_RADIO, "SPEEDTRAP: %s with plate %s is speeding %i/%.0f KMH at %s.", GetVehicleName(VehicleData[pvid][vVehicle]), VehicleData[pvid][vPlate], GetVehicleSpeedKMH(VehicleData[pvid][vVehicle]), SpeedData[i][speedLimit], location);
			    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
			    ShowMessage(playerid, sprintf("~r~WARNING:~w~_You're speeding_~y~%i/%.0f_KMH",GetVehicleSpeedKMH(VehicleData[pvid][vVehicle]), SpeedData[i][speedLimit]), 3);
				Speed_Save(i);
			}
		}
	}
	forex(i, MAX_WEED) if(WeedData[i][weedExists])
	{
		new str[128];
		if(areaid == WeedData[i][weedArea])
		{
			if(WeedData[i][weedGrow] < MAX_GROW)
			{
				format(str, 128, "On Growth~n~~y~%d minute left.", MAX_GROW-WeedData[i][weedGrow]);
			}
			else
			{
				format(str, 128, "Ready to harvest~n~Press ~y~H ~w~to harvest.");
			}
			ShowBox(playerid, "~r~Plant_Info", str, 2);
		}
	}
	forex(i, MAX_ATM) if(AtmData[i][atmExists])
	{
		if(areaid == AtmData[i][atmArea])
		{
			ShowBox(playerid, sprintf("Automatic_Teller_Machine_#%d", i), "Type ~y~/atm ~w~to use this ATM", 3);
		}
	}
	if(IsSafeZone(areaid))
	{
		GangZoneShowForPlayer(playerid, GangZoneData[gzSafezone],0x007FFF99);
	}
	forex(i, MAX_TREE) if(TreeData[i][treeExists])
	{
		if(areaid == TreeData[i][treeArea])
		{

			new str[152], hours, minutes, seconds;
			if(PlayerData[playerid][pJob] == JOB_LUMBERJACK)
			{
				if(TreeData[i][treeCutted])
				{
					format(str, sizeof(str), "~w~Press ~r~H ~w~to load the timber.");
				}
				else
				{
					if(TreeData[i][treeTime] < 1)
					{
						format(str, sizeof(str), "~y~Available to cut~n~~w~Press ~r~H ~w~to begin.");
					}
					else
					{
						GetElapsedTime(TreeData[i][treeTime], hours, minutes, seconds);
						format(str, sizeof(str), "~y~Available in: ~r~%02d:%02d:%02d", hours, minutes, seconds);
					}
				}
				ShowText(playerid, str, 3);
			}
		}
	}
	return 1;
}

public OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
{
	if(areaid == AreaData[areaMechanic])
	{
		if(PlayerData[playerid][pJobduty] && PlayerData[playerid][pJob] == JOB_MECHANIC)
		{
			PlayerData[playerid][pJobduty] = false;
			SetPlayerColor(playerid, COLOR_WHITE);
			SendClientMessage(playerid, COLOR_SERVER, "JOB: {FFFFFF}You are no longer on-duty as {FFFF00}Mechanic");
		}
	}
	if(IsSafeZone(areaid))
	{
		GangZoneHideForPlayer(playerid, GangZoneData[gzSafezone]);
	}
	return 1;
}
public OnPlayerEnterDynamicCP(playerid, STREAMER_TAG_CP:checkpointid)
{
	forex(i, MAX_VENDOR) if(checkpointid == VendorData[i][vendorCP])
	{
		ShowMessage(playerid, "Press ~y~H ~w~to start food vendor.", 2);
	}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	if(PlayerData[playerid][pOnDMV] && GetPlayerVehicleID(playerid) == PlayerData[playerid][pVehicleDMV])
	{
		if(PlayerData[playerid][pIndexDMV] < 17)
		{
			PlayerData[playerid][pIndexDMV]++;
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, DMVPoint[PlayerData[playerid][pIndexDMV]][0], DMVPoint[PlayerData[playerid][pIndexDMV]][1], DMVPoint[PlayerData[playerid][pIndexDMV]][2], 3.4);
		}
		else
		{
			if(IsValidVehicle(PlayerData[playerid][pVehicleDMV]))
				DestroyVehicle(PlayerData[playerid][pVehicleDMV]);

			PlayerData[playerid][pLicense][0] = true;
			SendClientMessage(playerid, COLOR_SERVER, "DMV: {FFFFFF}Kamu berhasil menyelesaikan Driving Test!");
			PlayerData[playerid][pOnTest] = false;
			PlayerData[playerid][pIndexTest] = 0;
			PlayerData[playerid][pOnDMV] = false;
			PlayerData[playerid][pIndexDMV] = -1;
			PlayerData[playerid][pHaveDrivingLicense] = true;
			DisablePlayerCheckpoint(playerid);
			SaveData(playerid);
		}
	}
	if(OnSweeping[playerid] && IsSweeperVehicle(GetPlayerVehicleID(playerid)))
	{
		if(SweeperIndex[playerid] < 18)
		{
			SweeperIndex[playerid]++;
			SetPlayerCheckpoint(playerid, SweeperPoint[SweeperIndex[playerid]][0], SweeperPoint[SweeperIndex[playerid]][1], SweeperPoint[SweeperIndex[playerid]][2], 4.0);
		}
		else
		{
			SweeperIndex[playerid] = -1;
			OnSweeping[playerid] = false;
			new vid = GetPlayerVehicleID(playerid);
			SetVehicleToRespawn(vid);
			VehCore[vid][vehFuel] = 100;
			AddSalary(playerid, "Street Sweeper", 2500);
			SendClientMessage(playerid, COLOR_SERVER, "SIDEJOB: {FFFFFF}Kamu berhasil menyelesaikan pekerjaan dan mendapatkan {00FF00}$25.00");
			DisablePlayerCheckpoint(playerid);
			PlayerData[playerid][pSweeperDelay] = 900;
		}
	}
	if(PlayerData[playerid][pTracking])
	{
		SendClientMessage(playerid, COLOR_SERVER, "GPS: {FFFFFF}You have been reached to your vehicle.");
		PlayerData[playerid][pTracking] = false;
		DisablePlayerCheckpoint(playerid);
	}
	if(PlayerData[playerid][pWP])
	{
		HideWaypoint(playerid);
	}
	return 1;
}

public OnPlayerPressButton(playerid, buttonid)
{
    if(buttonid == SANewsStudio)
    {
        if(GetFactionType(playerid) == FACTION_NEWS)
        {
            MoveDynamicObject(SANewsStudioA,160.981506, 126.625137, 1007.120117,4);
            SetTimer("CloseSANewsStudio", 2500, 0);
        }
        else
        {
            SendErrorMessage(playerid, "You don't have access!");
            return 1;
        }
    }
    if(buttonid == SANewsPrivate)
    {
        if(GetFactionType(playerid) == FACTION_NEWS)
        {
            MoveDynamicObject(SANewsPrivateA,625.60937500,0.55000001,1106.96081543,4);
            MoveDynamicObject(SANewsPrivateB,625.65002441,-4.54999995,1106.96081543,4);
            SetTimer("CloseSANewsPrivate", 2500, 0);
        }
        else
        {
            SendErrorMessage(playerid, "You don't have access!");
            return 1;
        }
    }
    if(buttonid == SANewsPrivateOPP)
    {
        if(GetFactionType(playerid) == FACTION_NEWS)
        {
            MoveDynamicObject(SANewsPrivateA,625.60937500,0.55000001,1106.96081543,4);
            MoveDynamicObject(SANewsPrivateB,625.65002441,-4.54999995,1106.96081543,4);
            SetTimer("CloseSANewsPrivate", 2500, 0);
        }
        else
        {
            SendErrorMessage(playerid, "You don't have access!");
            return 1;
        }
    }
    if(buttonid == SANewsOffice)
    {
        if(GetFactionType(playerid) == FACTION_NEWS)
        {
            MoveDynamicObject(SANewsOfficeA,176.652496,138.410949,1002.049682,4);
            SetTimer("CloseSANewsOffice", 2500, 0);
        }
        else
        {
            SendErrorMessage(playerid, "You don't have access!");
            return 1;
        }
    }
    if(buttonid == westin)
    {
    	if(GetFactionType(playerid) != FACTION_POLICE)
    		return SendErrorMessage(playerid, "You don't have access!");

        MoveDynamicObject(westlobby1,-550.7093, 475.4815, 1367.4054,4); //interior PD new 
        MoveDynamicObject(westlobby2,-545.7000, 475.4852, 1367.4054,4); //interior PD new
        SetTimer("CloseWestLobby", 2500, 0);
    }
    if(buttonid == westout)
    {
    	if(GetFactionType(playerid) != FACTION_POLICE)
    		return SendErrorMessage(playerid, "You don't have access!");

        MoveDynamicObject(westlobby1,-550.7093, 475.4815, 1367.4054,4); //interior PD new 
        MoveDynamicObject(westlobby2,-545.7000, 475.4852, 1367.4054,4); //interior PD new
        SetTimer("CloseWestLobby", 2500, 0);
    }
    forex(i, 2) if(buttonid == GovData[govButton][i])
    {
    	if(GetFactionType(playerid) != FACTION_GOV)
    		return SendErrorMessage(playerid, "You don't have access!");

    	if(!GovData[govDoorStatus])
    	{
    		GovData[govDoorStatus] = true;
    		MoveDynamicObject(GovData[govDoor], 2110.567871, 754.213745, 96.183898, 2.0, 0.000000, 0.000000, 90.000000);
    	}
    	else
    	{
    		GovData[govDoorStatus] = false;
    		MoveDynamicObject(GovData[govDoor], 2110.567871, 755.844726, 96.183898, 2.0, 0.000000, 0.000000, 90.000000);
    	}
    }
	return 1;
}

public OnPlayerEditDynamicObject(playerid, STREAMER_TAG_OBJECT:objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	new id = PlayerData[playerid][pEditing];
	if(response == EDIT_RESPONSE_FINAL)
	{
		if(PlayerData[playerid][pEditing] != -1)
		{
			if(PlayerData[playerid][pEditType] == EDIT_TREE)
			{
				TreeData[id][treePos][0] = x;
				TreeData[id][treePos][1] = y;
				TreeData[id][treePos][2] = z;
				TreeData[id][treePos][3] = rx;
				TreeData[id][treePos][4] = ry;
				TreeData[id][treePos][5] = rz;

				Tree_Save(id);
				Tree_Refresh(id);
				SendServerMessage(playerid, "You have successfully editing Tree ID: %d", id);
			}
			else if(PlayerData[playerid][pEditType] == EDIT_FURNITURE)
			{
				FurnitureData[id][furniturePos][0] = x;
				FurnitureData[id][furniturePos][1] = y;
				FurnitureData[id][furniturePos][2] = z;

				FurnitureData[id][furnitureRot][0] = rx;
				FurnitureData[id][furnitureRot][1] = ry;
				FurnitureData[id][furnitureRot][2] = rz;

				Furniture_Save(id);
				Furniture_Refresh(id);

				SendServerMessage(playerid, "You have successfully editing furniture ID: %d", id);
			}
			else if(PlayerData[playerid][pEditType] == EDIT_TAG)
			{
				TagData[id][tagPos][0] = x;
				TagData[id][tagPos][1] = y;
				TagData[id][tagPos][2] = z;
				TagData[id][tagPos][3] = rx;
				TagData[id][tagPos][4] = ry;
				TagData[id][tagPos][5] = rz;

				SendServerMessage(playerid, "The position of SprayTag saved successfully");
				SendServerMessage(playerid, "SprayTag has been successfully created!");

/*				Streamer_SetPosition(STREAMER_TYPE_OBJECT, TagData[id][tagObject], TagData[id][tagPos][0], TagData[id][tagPos][1], TagData[id][tagPos][2]);
				Streamer_SetRotation(STREAMER_TYPE_OBJECT, TagData[id][tagObject], TagData[id][tagPos][3], TagData[id][tagPos][4], TagData[id][tagPos][5]);*/

				Tag_Save(id);
			}
		    else if (PlayerData[playerid][pEditType] == EDIT_GATE)
		    {
		        switch (PlayerData[playerid][pEditGate])
		        {
		            case 1:
		            {

		                GateData[id][gatePos][0] = x;
		                GateData[id][gatePos][1] = y;
		                GateData[id][gatePos][2] = z;
		                GateData[id][gatePos][3] = rx;
		                GateData[id][gatePos][4] = ry;
		                GateData[id][gatePos][5] = rz;

		                Streamer_SetPosition(STREAMER_TYPE_OBJECT, GateData[id][gateObject], GateData[id][gatePos][0], GateData[id][gatePos][1], GateData[id][gatePos][2]);
		                Streamer_SetRotation(STREAMER_TYPE_OBJECT, GateData[id][gateObject], GateData[id][gatePos][3], GateData[id][gatePos][4], GateData[id][gatePos][5]);
		                Streamer_SetIntData(STREAMER_TYPE_OBJECT, GateData[id][gateObject], E_STREAMER_INTERIOR_ID, GateData[id][gateInterior]);
		                Streamer_SetIntData(STREAMER_TYPE_OBJECT, GateData[id][gateObject], E_STREAMER_WORLD_ID, GateData[id][gateWorld]);

/*		                DestroyDynamicObject(GateData[id][gateObject]);
						GateData[id][gateObject] = CreateDynamicObject(GateData[id][gateModel], GateData[id][gatePos][0], GateData[id][gatePos][1], GateData[id][gatePos][2], GateData[id][gatePos][3], GateData[id][gatePos][4], GateData[id][gatePos][5], GateData[id][gateWorld], GateData[id][gateInterior]);
*/
						Gate_Save(id);
	                    SendServerMessage(playerid, "You have edited the position of gate ID: %d.", id);
					}
					case 2:
		            {

		                GateData[id][gateMove][0] = x;
		                GateData[id][gateMove][1] = y;
		                GateData[id][gateMove][2] = z;
		                GateData[id][gateMove][3] = rx;
		                GateData[id][gateMove][4] = ry;
		                GateData[id][gateMove][5] = rz;

		                Streamer_SetPosition(STREAMER_TYPE_OBJECT, GateData[id][gateObject], GateData[id][gatePos][0], GateData[id][gatePos][1], GateData[id][gatePos][2]);
		                Streamer_SetRotation(STREAMER_TYPE_OBJECT, GateData[id][gateObject], GateData[id][gatePos][3], GateData[id][gatePos][4], GateData[id][gatePos][5]);
		                Streamer_SetIntData(STREAMER_TYPE_OBJECT, GateData[id][gateObject], E_STREAMER_INTERIOR_ID, GateData[id][gateInterior]);
		                Streamer_SetIntData(STREAMER_TYPE_OBJECT, GateData[id][gateObject], E_STREAMER_WORLD_ID, GateData[id][gateWorld]);

/*		                DestroyDynamicObject(GateData[id][gateObject]);
						GateData[id][gateObject] = CreateDynamicObject(GateData[id][gateModel], GateData[id][gatePos][0], GateData[id][gatePos][1], GateData[id][gatePos][2], GateData[id][gatePos][3], GateData[id][gatePos][4], GateData[id][gatePos][5], GateData[id][gateWorld], GateData[id][gateInterior]);
*/
						Gate_Save(id);
	                    SendServerMessage(playerid, "You have edited the moving position of gate ID: %d.", id);
					}
				}
			}
		}

		PlayerData[playerid][pEditing] = -1;
		PlayerData[playerid][pEditType] = EDIT_NONE;
		PlayerData[playerid][pEditGate] = 0;
	}
	if(response == EDIT_RESPONSE_CANCEL)
	{
		if(PlayerData[playerid][pEditType] == EDIT_TREE)
			Tree_Refresh(id);

		if(PlayerData[playerid][pEditType] == EDIT_FURNITURE)
			Furniture_Refresh(id);

		PlayerData[playerid][pEditType] = EDIT_NONE;
		PlayerData[playerid][pEditing] = -1;
		PlayerData[playerid][pEditGate] = 0;

	}
	return 1;
}

public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ,Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	new weaponid = EditingWeapon[playerid];
    if(weaponid)
    {
        if(response == 1)
        {
            new enum_index = weaponid - 22, weaponname[18], string[340];

            GetWeaponName(weaponid, weaponname, sizeof(weaponname));

            WeaponSettings[playerid][enum_index][Position][0] = fOffsetX;
            WeaponSettings[playerid][enum_index][Position][1] = fOffsetY;
            WeaponSettings[playerid][enum_index][Position][2] = fOffsetZ;
            WeaponSettings[playerid][enum_index][Position][3] = fRotX;
            WeaponSettings[playerid][enum_index][Position][4] = fRotY;
            WeaponSettings[playerid][enum_index][Position][5] = fRotZ;

            RemovePlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid));
            SetPlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid), GetWeaponModel(weaponid), WeaponSettings[playerid][enum_index][Bone], fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, 1.0, 1.0, 1.0);

            SendServerMessage(playerid, "Attachment for weapon {FF0000}%s {FFFFFF}edited successfully.", weaponname);

            mysql_format(sqlcon, string, sizeof(string), "INSERT INTO weaponsettings (Owner, WeaponID, PosX, PosY, PosZ, RotX, RotY, RotZ) VALUES ('%d', %d, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f) ON DUPLICATE KEY UPDATE PosX = VALUES(PosX), PosY = VALUES(PosY), PosZ = VALUES(PosZ), RotX = VALUES(RotX), RotY = VALUES(RotY), RotZ = VALUES(RotZ)", PlayerData[playerid][pID], weaponid, fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ);
            mysql_tquery(sqlcon, string);
        }
		else if(response == 0)
		{
			new enum_index = weaponid - 22;
			SetPlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid), GetWeaponModel(weaponid), WeaponSettings[playerid][enum_index][Bone], fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, 1.0, 1.0, 1.0);
		}
        EditingWeapon[playerid] = 0;
    }
	else
	{
		if(response == 1)
		{
			pToys[playerid][index][toy_x] = fOffsetX;
			pToys[playerid][index][toy_y] = fOffsetY;
			pToys[playerid][index][toy_z] = fOffsetZ;
			pToys[playerid][index][toy_rx] = fRotX;
			pToys[playerid][index][toy_ry] = fRotY;
			pToys[playerid][index][toy_rz] = fRotZ;
			pToys[playerid][index][toy_sx] = fScaleX;
			pToys[playerid][index][toy_sy] = fScaleY;
			pToys[playerid][index][toy_sz] = fScaleZ;
			
			SavePlayerToys(playerid);
		}
		else if(response == 0)
		{
			SetPlayerAttachedObject(playerid,
				index,
				modelid,
				boneid,
				pToys[playerid][index][toy_x],
				pToys[playerid][index][toy_y],
				pToys[playerid][index][toy_z],
				pToys[playerid][index][toy_rx],
				pToys[playerid][index][toy_ry],
				pToys[playerid][index][toy_rz],
				pToys[playerid][index][toy_sx],
				pToys[playerid][index][toy_sy],
				pToys[playerid][index][toy_sz]);
		}
	}
    return 1;
}

public OnPlayerUpdate(playerid)
{
	if (GetPlayerWeapon(playerid) != PlayerData[playerid][pWeapon])
	{
	    PlayerData[playerid][pWeapon] = GetPlayerWeapon(playerid);

		if (PlayerData[playerid][pWeapon] >= 1 && PlayerData[playerid][pWeapon] <= 45 && PlayerData[playerid][pGuns][g_aWeaponSlots[PlayerData[playerid][pWeapon]]] != GetPlayerWeapon(playerid) && !PlayerData[playerid][pSpraying])
		{
		    SendAdminMessage(COLOR_LIGHTRED, "AdmWarning: Cheat detected on {FFFF00}%s (%s) {FF6347}(Weapon hack %s)", GetName(playerid), PlayerData[playerid][pUCP], ReturnWeaponName(PlayerData[playerid][pWeapon]));
			ResetWeapons(playerid);
			KickEx(playerid);
		}
	}
	if(StretcherHolding[playerid] == 2)
	{
		new Float:zX, Float:zY, Float:zZ, Float:Ang;
		GetPlayerPos(playerid, zX, zY, zZ);
		GetXYInFrontOfPlayer(playerid, zX, zY, 1.6);
		GetPlayerFacingAngle(playerid, Ang);

		SetDynamicObjectPos(StretcherEquipped[playerid], zX, zY, zZ - 1.0);
		SetDynamicObjectRot(StretcherEquipped[playerid], 0.0, 0.0, Ang-180.0);
	}
	if(IsValidDynamicObject(StretcherEquipped[playerid]) && StretcherPlayerID[playerid] >= 0)
	{
		if(IsPlayerConnected(StretcherPlayerID[playerid]))
		{
			new Float:playerpos[4];
			TogglePlayerControllable(StretcherPlayerID[playerid], 0);
			GetPlayerFacingAngle(playerid, playerpos[3]);
			SetPlayerFacingAngle(StretcherPlayerID[playerid], playerpos[3]);
			GetPlayerPos(playerid, playerpos[0], playerpos[1], playerpos[2]);
			GetXYInFrontOfPlayer(playerid, playerpos[0], playerpos[1], 2.0);
			SetPlayerPos(StretcherPlayerID[playerid], playerpos[0], playerpos[1], playerpos[2] + 0.5);
			SetCameraBehindPlayer(StretcherPlayerID[playerid]);
			SetPlayerVirtualWorld(StretcherPlayerID[playerid], GetPlayerVirtualWorld(playerid));
			SetPlayerInterior(StretcherPlayerID[playerid], GetPlayerInterior(playerid));
			ApplyAnimation(StretcherPlayerID[playerid],"BEACH", "bather", 4.0, 1, 0, 0, 1, -1, 1);
		}
		else StretcherPlayerID[playerid] = -1;
	}
	return 1;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_SPRAYTAG_MODE)
	{
		if(!response)
			return ShowTagSetup(playerid);

		new id = Tag_Create(playerid);

		if(id == INVALID_ITERATOR_SLOT)
			return SendErrorMessage(playerid, "This server cannot create more tags!");


		PlayerData[playerid][pEditing] = id;
		PlayerData[playerid][pEditType] = EDIT_TAG;
		Streamer_Update(playerid, STREAMER_TYPE_OBJECT);

		if(listitem == 0)
		{
			ShowEditTextDraw(playerid);
		}
		if(listitem == 1)
		{
			EditDynamicObject(playerid, TagData[id][tagObject]);
		}
	}
	if(dialogid == DIALOG_SPRAYTAG_TEXT)
	{
		if(response)
		{
			if(isnull(inputtext))
				return cmd_tag(playerid, "create");

			if(strlen(inputtext) > 64)
				return SendErrorMessage(playerid, "Text length cannot more than 64 chars!"), cmd_tag(playerid, "create");

			format(TagText[playerid], 64, inputtext);
			ShowTagSetup(playerid);

		}
	}
	if(dialogid == DIALOG_SPRAYTAG_FONT)
	{
		if(!response)
			return ShowTagSetup(playerid);

		if(isnull(inputtext))
			return ShowPlayerDialog(playerid, DIALOG_SPRAYTAG_FONT, DIALOG_STYLE_INPUT, "Tag - Font", "Please input the fontface name:", "Set", "Return");

		if(strlen(inputtext) > 24)
			return ShowPlayerDialog(playerid, DIALOG_SPRAYTAG_FONT, DIALOG_STYLE_INPUT, "Tag - Font", "Please input the fontface name:", "Set", "Return");

		format(TagFont[playerid], 24, inputtext);
		ShowTagSetup(playerid);
	}
	if(dialogid == DIALOG_SPRAYTAG_SIZE)
	{
		if(!response)
			return ShowTagSetup(playerid);

		if(isnull(inputtext))
			return ShowPlayerDialog(playerid, DIALOG_SPRAYTAG_SIZE, DIALOG_STYLE_INPUT, "Tag - Font Size", "Please input the fontsize:\nNote: min 24 max 255!", "Set", "Return");

		if(!IsNumeric(inputtext))
			return ShowPlayerDialog(playerid, DIALOG_SPRAYTAG_SIZE, DIALOG_STYLE_INPUT, "Tag - Font Size", "Please input the fontsize:\nNote: min 24 max 255!", "Set", "Return");

		if(strval(inputtext) < 24 || strval(inputtext) > 255)
			return ShowPlayerDialog(playerid, DIALOG_SPRAYTAG_SIZE, DIALOG_STYLE_INPUT, "Tag - Font Size", "Please input the fontsize:\nNote: min 24 max 255!", "Set", "Return");

		TagSize[playerid] = strval(inputtext);
		ShowTagSetup(playerid);
	}
	if(dialogid == DIALOG_SPRAYTAG_COLOR)
	{
		if(!response)
			return 1;

		if(isnull(inputtext))
			return ShowPlayerDialog(playerid, DIALOG_SPRAYTAG_COLOR, DIALOG_STYLE_INPUT, "Tag - Color", "Please input the color for the tag:\nExample: 0xFFFFFFFF (white)", "Set", "Return");

		TagColor[playerid] = HexToInt(inputtext);
		ShowTagSetup(playerid);
	}
	if(dialogid == DIALOG_SPRAYTAG)
	{
		if(!response)
			return 1;

		if(listitem == 0)
		{
			ShowPlayerDialog(playerid, DIALOG_SPRAYTAG_FONT, DIALOG_STYLE_INPUT, "Tag - Font", "Please input the fontface name:", "Set", "Return");
		}
		if(listitem == 1)
		{
			ShowPlayerDialog(playerid, DIALOG_SPRAYTAG_SIZE, DIALOG_STYLE_INPUT, "Tag - Font Size", "Please input the fontsize:\nNote: min 24 max 255!", "Set", "Return");
		}
		if(listitem == 2)
		{
			if(TagBold[playerid] == 0)
			{
				TagBold[playerid] = 1;
			}
			else
			{
				TagBold[playerid] = 0;
			}
			ShowTagSetup(playerid);
		}
		if(listitem == 3)
		{
			ShowPlayerDialog(playerid, DIALOG_SPRAYTAG_COLOR, DIALOG_STYLE_INPUT, "Tag - Color", "Please input the color for the tag:\nExample: 0xFFFFFFFF (white)", "Set", "Return");
		}
		if(listitem == 4)
		{
			ShowPlayerDialog(playerid, DIALOG_SPRAYTAG_MODE, DIALOG_STYLE_LIST, "Tag - Edit Mode", "TextDraw Click\nClick n Drag", "Select", "Close");
		}
	}
	if(dialogid == DIALOG_SELLFISH)
	{
	    if(response)
	    {
	        new total = 0;
	        for(new i = 0; i < 10; i++) if(FishWeight[playerid][i] != 0)
	        {
	            total += 95 * floatround(FishWeight[playerid][i], floatround_round);

				format(FishName[playerid][i], 12, "Empty");
				FishWeight[playerid][i] = 0;
			}
			PlayerData[playerid][pFishDelay] = 2200;
			AddSalary(playerid, "Sell Fish", total);
			SendClientMessageEx(playerid, COLOR_SERVER, "FISH: {FFFFFF}You have sold all the fish and earn {009000}%s {FFFFFF}on your {FFFF00}/salary", FormatNumber(total));
		}
	}
	if(dialogid == DIALOG_TAXI)
	{
		if (response)
		{
		    new targetid = strval(inputtext);

		    if (!IsPlayerConnected(targetid))
		        return SendErrorMessage(playerid, "The specified player has disconnected.");

			if (!PlayerData[targetid][pTaxiCalled])
			    return SendErrorMessage(playerid, "That player's call was accepted by another taxi driver.");

			new
				Float:x,
				Float:y,
				Float:z;


			PlayerData[targetid][pTaxiCalled] = false;
			GetPlayerPos(targetid, x, y, z);
			SetPlayerCheckpoint(playerid, x, y, z, 3.5);

	        SendServerMessage(playerid, "You have accepted %s's taxi call.", ReturnName(targetid));
	        SendServerMessage(targetid, "%s has accepted your taxi call and is on their way.", ReturnName(playerid));
		}
	}
	if(dialogid == DIALOG_HOUSEWEAPON)
	{
	    if(response)
	    {
			static
			    houseid = -1;

		    if ((houseid = House_Inside(playerid)) != -1 && (House_IsOwner(playerid, houseid)))
			{
				if (response)
				{
				    if (HouseData[houseid][houseWeapons][listitem] != 0)
				    {
				        if(PlayerData[playerid][pLevel] < 3)
				            return SendErrorMessage(playerid, "You must level 3 first to holding weapon.");
				            
				        if(PlayerHasWeapon(playerid, HouseData[houseid][houseWeapons][listitem]))
				            return SendErrorMessage(playerid, "You already have this type of weapon!");
				           
						GiveWeaponToPlayer(playerid, HouseData[houseid][houseWeapons][listitem], HouseData[houseid][houseAmmo][listitem],HouseData[houseid][houseDurability][listitem]);

						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has taken a \"%s\" from their weapon storage.", ReturnName(playerid), ReturnWeaponName(HouseData[houseid][houseWeapons][listitem]));
		          //      Log_Write("logs/storage_log.txt", "[%s] %s has taken a \"%s\" from house ID: %d (owner: %s).", ReturnDate(), ReturnName(playerid), ReturnWeaponName(HouseData[houseid][houseWeapons][listitem]), HouseData[houseid][houseID], (House_IsOwner(playerid, houseid)) ? ("Yes") : ("No"));

						HouseData[houseid][houseWeapons][listitem] = 0;
						HouseData[houseid][houseAmmo][listitem] = 0;
						HouseData[houseid][houseDurability][listitem] = 0;

						House_Save(houseid);
						House_WeaponStorage(playerid, houseid);
					}
					else
					{
					    new
							weaponid = GetWeapon(playerid),
							ammo = GetPlayerAmmo(playerid);

					    if (!weaponid)
					        return SendErrorMessage(playerid, "You are not holding any weapon!");

		                ResetWeapon(playerid, weaponid);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has stored a \"%s\" into their weapon storage.", ReturnName(playerid), ReturnWeaponName(weaponid));

						HouseData[houseid][houseWeapons][listitem] = weaponid;
						HouseData[houseid][houseAmmo][listitem] = ammo;
						HouseData[houseid][houseDurability][listitem] = PlayerData[playerid][pDurability][g_aWeaponSlots[weaponid]];

						House_Save(houseid);
						House_WeaponStorage(playerid, houseid);
					}
				}
			}
		}
	}
	if(dialogid == DIALOG_HOUSEOPTION)
	{
	    new
		    houseid = House_Inside(playerid),
			itemid = -1,
			string[32];
			
	    if(response)
	    {
		    itemid = PlayerData[playerid][pListitem];

		    strunpack(string, HouseStorage[houseid][itemid][hItemName]);
			if (response)
			{
				switch (listitem)
				{
				    case 0:
				    {
				        if (HouseStorage[houseid][itemid][hItemQuantity] == 1)
				        {
				            new id = Inventory_Add(playerid, string, HouseStorage[houseid][itemid][hItemModel], 1);

							if (id == -1)
	        					return SendErrorMessage(playerid, "You don't have any inventory slots left.");

				            House_RemoveItem(houseid, string);
				            SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has taken a \"%s\" from their house storage.", ReturnName(playerid), string);

							House_ShowItems(playerid, houseid);
						//	Log_Write("logs/storage_log.txt", "[%s] %s has taken \"%s\" from house ID: %d (owner: %s).", ReturnDate(), ReturnName(playerid), string, HouseData[houseid][houseID], (House_IsOwner(playerid, houseid)) ? ("Yes") : ("No"));
				        }
				        else
				        {
				            new str[128];
				            format(str, sizeof(str), "Item: %s (Amount: %d)\n\nPlease enter the amount that you wish to take for this item:", string, HouseStorage[houseid][itemid][hItemQuantity]);
				            ShowPlayerDialog(playerid, DIALOG_HOUSEWITHDRAW, DIALOG_STYLE_INPUT, "House Take", str, "Take", "Back");
				        }
				    }
					case 1:
					{
						new id = Inventory_GetItemID(playerid, string);

						if(id == -1)
						{
							House_ShowItems(playerid, houseid);

							return SendErrorMessage(playerid, "You don't have anymore of this item to store!");
						}
						else if (InventoryData[playerid][id][invQuantity] == 1)
						{
						    if(!strcmp(string, "Cellphone"))
						        return SendErrorMessage(playerid, "You can't do that on this item! (%s)", string);

						    if(!strcmp(string, "Mask"))
						        return SendErrorMessage(playerid, "You can't do that on this item! (%s)", string);
						        
						    if(!strcmp(string, "GPS"))
						        return SendErrorMessage(playerid, "You can't do that on this item! (%s)", string);

						    if(!strcmp(string, "Portable Radio"))
						        return SendErrorMessage(playerid, "You can't do that on this item! (%s)", string);
						        

						    House_AddItem(houseid, string, InventoryData[playerid][id][invModel]);
							Inventory_Remove(playerid, string);

							SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has stored a \"%s\" into their house storage.", ReturnName(playerid), string);
							House_ShowItems(playerid, houseid);
						}
						else if (InventoryData[playerid][id][invQuantity] > 1)
						{
						    if(!strcmp(string, "Cellphone"))
						        return SendErrorMessage(playerid, "You can't do that on this item! (%s)", string);

						    if(!strcmp(string, "Mask"))
						        return SendErrorMessage(playerid, "You can't do that on this item! (%s)", string);
						        
						    if(!strcmp(string, "GPS"))
						        return SendErrorMessage(playerid, "You can't do that on this item! (%s)", string);

						    if(!strcmp(string, "Portable Radio"))
						        return SendErrorMessage(playerid, "You can't do that on this item! (%s)", string);
						        
							PlayerData[playerid][pListitem] = id;
							new str[128];
							format(str, sizeof(str), "Item: %s (Amount: %d)\n\nPlease enter the quantity that you wish to store for this item:" , string, InventoryData[playerid][PlayerData[playerid][pListitem]][invQuantity]);
	                        ShowPlayerDialog(playerid, DIALOG_HOUSEDEPOSIT, DIALOG_STYLE_INPUT, "House Deposit", str, "Store", "Back");
						}
					}
				}
			}
		}
		else
		{
		    House_ShowItems(playerid, houseid);
		}
	}
	if(dialogid == DIALOG_HOUSEITEM)
	{
	    new houseid = House_Inside(playerid), string[156];
		if (response)
		{
    		if (HouseStorage[houseid][listitem][hItemExists])
			{
   				PlayerData[playerid][pListitem] = listitem;
   				PlayerData[playerid][pListitem] = listitem;

				strunpack(string, HouseStorage[houseid][PlayerData[playerid][pListitem]][hItemName]);

				format(string, sizeof(string), "%s (Amount: %d)", string, HouseStorage[houseid][listitem][hItemQuantity]);
				ShowPlayerDialog(playerid, DIALOG_HOUSEOPTION, DIALOG_STYLE_LIST, string, "Take Item\nStore Item", "Select", "Back");
			}
			else
			{
			    PlayerData[playerid][pStorageSelect] = 1;
			    
   				OpenInventory(playerid);
			}
		}
		else House_OpenStorage(playerid, houseid);
	}
	if(dialogid == DIALOG_HOUSESTORAGE)
	{
	    if(response)
	    {
			new
			    houseid = -1;

			if ((houseid = House_Inside(playerid)) != -1 && (House_IsOwner(playerid, houseid)))
			{
			    if (listitem == 0)
				{
			        House_ShowItems(playerid, houseid);
			    }
	      		else if (listitem == 1)
				 {
					House_WeaponStorage(playerid, houseid);
			    }
			}
		}
	}
	if(dialogid == DIALOG_HOUSEDEPOSIT)
	{
	    new
	        houseid = House_Inside(playerid),
	        string[32];

        strunpack(string, InventoryData[playerid][PlayerData[playerid][pListitem]][invItem]);
        
		if (response)
		{
			new amount = strval(inputtext);

			if (amount < 1 || amount > InventoryData[playerid][PlayerData[playerid][pListitem]][invQuantity])
			{
			    new str[152];
			    format(str, sizeof(str), "Item: %s (Amount: %d)\n\nPlease enter the quantity that you wish to store for this item:", string, InventoryData[playerid][PlayerData[playerid][pListitem]][invQuantity]);
				ShowPlayerDialog(playerid, DIALOG_HOUSEDEPOSIT, DIALOG_STYLE_INPUT, "House Deposit", str, "Store", "Back");
				return 1;
			}
			House_AddItem(houseid, string, InventoryData[playerid][PlayerData[playerid][pListitem]][invModel], amount);
			Inventory_Remove(playerid, string, amount);

			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has stored a \"%s\" into their house storage.", ReturnName(playerid), string);
			House_ShowItems(playerid, houseid);
		}
		else House_OpenStorage(playerid, houseid);
	}
	if(dialogid == DIALOG_HOUSEWITHDRAW)
	{
		new
		    houseid = House_Inside(playerid),
		    string[32];

        strunpack(string, HouseStorage[houseid][PlayerData[playerid][pListitem]][hItemName]);
        
	    if(response)
	    {
			new amount = strval(inputtext);

			if (amount < 1 || amount > HouseStorage[houseid][PlayerData[playerid][pListitem]][hItemQuantity])
			{
			    new str[152];
			    format(str, sizeof(str), "Item: %s (Amount: %d)\n\nPlease enter the quantity that you wish to take for this item:", string, HouseStorage[houseid][PlayerData[playerid][pListitem]][hItemQuantity]);
				ShowPlayerDialog(playerid, DIALOG_HOUSEWITHDRAW, DIALOG_STYLE_INPUT, "House Take", str, "Take", "Back");
				return 1;
			}
			new id = Inventory_Add(playerid, string, HouseStorage[houseid][PlayerData[playerid][pListitem]][hItemModel], amount);

			if (id == -1)
				return SendErrorMessage(playerid, "You don't have any inventory slots left.");

			if (id == -1)
				return SendErrorMessage(playerid, "You don't have any inventory slots left.");

			House_RemoveItem(houseid, string, amount);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has taken a \"%s\" from their house storage.", ReturnName(playerid), string);

			House_ShowItems(playerid, houseid);
		//	Log_Write("logs/storage_log.txt", "[%s] %s has taken %d \"%s\" from house ID: %d (owner: %s).", ReturnDate(), ReturnName(playerid), amount, string, HouseData[houseid][houseID], (House_IsOwner(playerid, houseid)) ? ("Yes") : ("No"));
		}
		else House_OpenStorage(playerid, houseid);
	}
	if(dialogid == DIALOG_INTERIOR)
	{
		if (response)
		{
		    SetPlayerInterior(playerid, g_arrInteriorData[listitem][e_InteriorID]);
		    SetPlayerPos(playerid, g_arrInteriorData[listitem][e_InteriorX], g_arrInteriorData[listitem][e_InteriorY], g_arrInteriorData[listitem][e_InteriorZ]);
		}
	}
	if(dialogid == DIALOG_MODEDIT)
	{
	    if(response)
	    {
	        if(!IsPlayerInAnyVehicle(playerid))
	            return SendErrorMessage(playerid, "You're no longer inside a Valid Player Vehicle.");
	            
			switch(listitem)
			{
			    case 0:
			    {
			        ShowEditTextDraw(playerid);
				}
				case 1:
				{
				    EditVehicleObject(playerid, GetPlayerVehicleID(playerid), VehicleData[PlayerData[playerid][pVehicle]][vToy][PlayerData[playerid][pListitem]]);
				}
				case 2:
				{
				    new veh = PlayerData[playerid][pVehicle];
				    if(IsValidDynamicObject(VehicleData[veh][vToy][PlayerData[playerid][pListitem]]))
				    	DestroyDynamicObject(VehicleData[veh][vToy][PlayerData[playerid][pListitem]]);

				    VehicleData[veh][vToyID][PlayerData[playerid][pListitem]] = 0;
					VehicleData[veh][vToyPosX][PlayerData[playerid][pListitem]] = 0.000;
                	VehicleData[veh][vToyPosY][PlayerData[playerid][pListitem]] = 0.000;
                	VehicleData[veh][vToyPosZ][PlayerData[playerid][pListitem]] = 0.000;
                	VehicleData[veh][vToyRotX][PlayerData[playerid][pListitem]] = 0.000;
                	VehicleData[veh][vToyRotY][PlayerData[playerid][pListitem]] = 0.000;
                	VehicleData[veh][vToyRotZ][PlayerData[playerid][pListitem]] = 0.000;
                	SendServerMessage(playerid, "You've successfully removed Attachment Slot: %d", PlayerData[playerid][pListitem] + 1);
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_MODSHOP)
	{
		if(response)
		{
	        if(!IsPlayerInAnyVehicle(playerid))
	            return SendErrorMessage(playerid, "You're no longer inside a Valid Player Vehicle.");
	            
			PlayerData[playerid][pListitem] = listitem;
			if(VehicleData[PlayerData[playerid][pVehicle]][vToyID][listitem] == 0)
			{
				ShowModelSelectionMenu(playerid, "Vehicle Attachment(s)", MODEL_SELECTION_MODSHOP, g_Modshop, sizeof(g_Modshop), 0.0, 0.0, 0.0);
			}
			else
			{
				ShowPlayerDialog(playerid, DIALOG_MODEDIT, DIALOG_STYLE_LIST, "Edit Vehicle Attachment(s)", "Edit Position ({FFFF00}TextDraw Click{FFFFFF})\nEdit Position ({FFFF00}Swipe Object{FFFFFF})\n{FF0000}Remove Attachment", "Select", "Close");
			}
		}
	}
	if(dialogid == DIALOG_DRIVEBY)
	{
		if(response)
		{
			new slot = listitem;

			if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)
				return SendErrorMessage(playerid, "You only can use this as a Passenger!");

			if(PlayerData[playerid][pGuns][slot] == 0)
				return ShowMessage(playerid, "~r~ERROR: ~w~no weapon on this slot!", 3);

			if(PlayerData[playerid][pGuns][slot] != 22 && PlayerData[playerid][pGuns][slot] != 25 && PlayerData[playerid][pGuns][slot] != 28 && PlayerData[playerid][pGuns][slot] != 29 && PlayerData[playerid][pGuns][slot] != 30 && PlayerData[playerid][pGuns][slot] != 31 && PlayerData[playerid][pGuns][slot] != 32 && PlayerData[playerid][pGuns][slot] !=33)
				return ShowMessage(playerid, "~r~ERROR: ~w~You ~r~can't ~w~switch to this weapon ~y~(not for driveby!)", 3);

			SetPlayerArmedWeapon(playerid, PlayerData[playerid][pGuns][slot]);
			ShowMessage(playerid, "Weapon successfully ~y~switched!", 3);
			SendServerMessage(playerid, "You're now holding a {FFFF00}%s {FFFFFF}on your hand.", ReturnWeaponName(PlayerData[playerid][pGuns][slot]));
		}
		else
		{
			ShowMessage(playerid, "Switching weapon ~r~cancelled", 3);
		}
	}
	if(dialogid == DIALOG_GATE_PASS)
	{
		if (response)
		{
		    new id = Gate_Nearest(playerid);

		    if (id == -1)
		        return 0;

	        if (isnull(inputtext))
	        	return ShowPlayerDialog(playerid, DIALOG_GATE_PASS, DIALOG_STYLE_INPUT, "Enter Password", "Please enter the password for this gate below:", "Submit", "Cancel");

			if (strcmp(inputtext, GateData[id][gatePass]) != 0)
	  			return ShowPlayerDialog(playerid, DIALOG_GATE_PASS, DIALOG_STYLE_INPUT, "Enter Password", "Error: Incorrect password specified.\n\nPlease enter the password for this gate below:", "Submit", "Cancel");

			Gate_Operate(id);
		}
	}
	if(dialogid == DIALOG_STREAMER_CONFIG)
	{
		if(response)
		{
			new config[] = {1000, 700, 500, 300};
			new const confignames[][24] = {"High", "Medium", "Low", "Potato"};

			Streamer_SetVisibleItems(STREAMER_TYPE_OBJECT, config[listitem], playerid);
			SendServerMessage(playerid, "You have adjusted maximum streamed object configuration to {FFFF00}%s", confignames[listitem]);
			Streamer_Update(playerid, STREAMER_TYPE_OBJECT);

		}
	}
	if(dialogid == DIALOG_FURNITURE_BUY)
	{
		if(response)
		{
		    new
				items[50] = {-1, ...},
				count;

		    for (new i = 0; i < sizeof(g_aFurnitureData); i ++) if (g_aFurnitureData[i][e_FurnitureType] == listitem + 1) {
				items[count++] = g_aFurnitureData[i][e_FurnitureModel];
		    }
		    PlayerData[playerid][pListitem] = listitem;

			if (listitem == 3) {
				ShowModelSelectionMenu(playerid, "Furniture", MODEL_SELECTION_FURNITURE, items, count, -12.0, 0.0, 0.0);
			}
			else {
			    ShowModelSelectionMenu(playerid, "Furniture", MODEL_SELECTION_FURNITURE, items, count);
			}
		}
	}
	if(dialogid == DIALOG_FURNITURE_MENU)
	{
		new id = PlayerData[playerid][pEditing];

		if(response)
		{
			if(listitem == 0)
			{
				Furniture_Delete(id);

				SendServerMessage(playerid, "You have successfully removed the furniture!");

				cmd_house(playerid, "menu");
			}
			if(listitem == 1)
			{
				if(House_Inside(playerid) != -1 && House_IsOwner(playerid, House_Inside(playerid)))
				{
					if(Iter_Contains(Furniture, id))
					{
						PlayerData[playerid][pEditType] = EDIT_FURNITURE;

						EditDynamicObject(playerid, FurnitureData[id][furnitureObject]);

						SendServerMessage(playerid, "You are not in editing mode of furniture index id: %d", id);
					}
				}
			}
			if(listitem == 2)
			{
				ShowEditTextDraw(playerid);

				SendServerMessage(playerid, "You are now in editing mode of furniture index id: %d", id);

			}
		}
	}
	if(dialogid == DIALOG_FURNITURE_LIST)
	{
		if(response)
		{
			if(House_Inside(playerid) != -1 && House_IsOwner(playerid, House_Inside(playerid)))
			{
				PlayerData[playerid][pEditing] = ListedFurniture[playerid][listitem];

				ShowPlayerDialog(playerid, DIALOG_FURNITURE_MENU, DIALOG_STYLE_LIST, "Furniture Option(s)", "Remove furniture\nEdit position (click n drag)\nEdit position (click textdraw)", "Select", "Close");
			}
		}
	}
	if(dialogid == DIALOG_FURNITURE)
	{
		if(response)
		{
			if(listitem == 0)
			{
			    new count = 0, string[MAX_FURNITURE * 32], houseid = House_Inside(playerid);
			    format(string, sizeof(string), "Model Name\tModel ID\tDistance\n");
				foreach(new i : Furniture) if (FurnitureData[i][furnitureHouse] == houseid)
				{
					ListedFurniture[playerid][count++] = i;
					format(string, sizeof(string), "%s%s\t%d\t%.2f meters\n", string, FurnitureData[i][furnitureName], FurnitureData[i][furnitureModel], GetPlayerDistanceFromPoint(playerid, FurnitureData[i][furniturePos][0], FurnitureData[i][furniturePos][1], FurnitureData[i][furniturePos][2]));
				}
				if (count)
				{
					ShowPlayerDialog(playerid, DIALOG_FURNITURE_LIST, DIALOG_STYLE_TABLIST_HEADERS, "Furniture List", string, "Select", "Cancel");
			 	}
			 	else SendErrorMessage(playerid, "There is no furniture on this house!"), cmd_house(playerid, "menu");
			}
			if(listitem == 1)
			{
				if(Furniture_GetCount(House_Inside(playerid)) >= 30)
					return SendErrorMessage(playerid, "You only can place 30 furniture per house!"), cmd_house(playerid, "menu");

				new str[312];

		        str[0] = 0;

		        for (new i = 0; i < sizeof(g_aFurnitureTypes); i ++) {
		            format(str, sizeof(str), "%s%s - $%s\n", str, g_aFurnitureTypes[i], FormatNumber(Furniture_ReturnPrice(i)));
				}
				ShowPlayerDialog(playerid, DIALOG_FURNITURE_BUY, DIALOG_STYLE_LIST, "Purchase Furniture", str, "Select", "Close");
			}
			if(listitem == 3)
			{
				if(Furniture_GetCount(House_Inside(playerid)) < 1)
					return SendErrorMessage(playerid, "There is no furniture on your house!"), cmd_house(playerid, "menu");

				foreach(new i : Furniture) if(FurnitureData[i][furnitureHouse] == House_Inside(playerid))
				{
					Furniture_Delete(i);
				}
				SendServerMessage(playerid, "You have removed all furniture on this house!");
				cmd_house(playerid, "menu");
			}
		}
	}
	if(dialogid == DIALOG_HOUSE_MENU)
	{
		if(response)
		{
			if(listitem == 0)
			{
				ShowPlayerDialog(playerid, DIALOG_FURNITURE, DIALOG_STYLE_LIST, "House Furniture", "Furniture list\nPurchase furniture\nRemove all furniture", "Select", "Close");
			}
			if(listitem == 1)
			{
				House_OpenStorage(playerid, House_Inside(playerid));
			}
		}
	}
	if(dialogid == DIALOG_TEST_STAGE_7)
	{
		if(response)
		{
			if(listitem == 1)
			{
				PlayerData[playerid][pIndexTest]++;
			}
			CheckPlayerTest(playerid);
		}
		else
		{
			PlayerData[playerid][pOnTest] = false;
			PlayerData[playerid][pIndexTest] = 0;
			SendServerMessage(playerid, "Kamu gagal mengambil Driving Test karena membatalkan test teori!");					
		}
	}
	if(dialogid == DIALOG_TEST_STAGE_6)
	{
		if(response)
		{
			if(listitem == 2)
			{
				PlayerData[playerid][pIndexTest]++;
			}
			ShowPlayerDialog(playerid, DIALOG_TEST_STAGE_7, DIALOG_STYLE_TABLIST_HEADERS, "Question 7 of 7",
			"Apa yang harus dilakukan jika ingin mengubah arah kendaraan ?\
			\nA. Berhenti ditengah jalan\
			\nB. Memberikan isyarat dengan lampu sein\
			\nC. Langsung berbelok tanpa isyarat",
			"Next", "Close");
		}
		else
		{
			PlayerData[playerid][pOnTest] = false;
			PlayerData[playerid][pIndexTest] = 0;
			SendServerMessage(playerid, "Kamu gagal mengambil Driving Test karena membatalkan test teori!");					
		}
	}
	if(dialogid == DIALOG_TEST_STAGE_5)
	{
		if(response)
		{
			if(listitem == 0)
			{
				PlayerData[playerid][pIndexTest]++;
			}
			ShowPlayerDialog(playerid, DIALOG_TEST_STAGE_6, DIALOG_STYLE_TABLIST_HEADERS, "Question 6 of 7",
			"Pengemudi harus memberi isyarat dengan petunjuk arah yang berkedip pada saat ?\
			\nA. Akan berjalan atau mengubah arah ke kanan\
			\nB. Pada saat akan berhenti\
			\nC. Akan berubah arah ke kiri ataupun kanan",
			"Next", "Close");
		}
		else
		{
			PlayerData[playerid][pOnTest] = false;
			PlayerData[playerid][pIndexTest] = 0;
			SendServerMessage(playerid, "Kamu gagal mengambil Driving Test karena membatalkan test teori!");				
		}
	}
	if(dialogid == DIALOG_TEST_STAGE_4)
	{
		if(response)
		{
			if(listitem == 1)
			{
				PlayerData[playerid][pIndexTest]++;
			}
			ShowPlayerDialog(playerid, DIALOG_TEST_STAGE_5, DIALOG_STYLE_TABLIST_HEADERS, "Question 5 of 7",
			"Dilarang melewati kendaraan lain walau tidak ada rambu yang melarangnya pada ?\
			\nA. Jalan tikungan\
			\nB. Jalan turunan\
			\nC. Jalan berlubang",
			"Next", "Close");
		}
		else
		{
			PlayerData[playerid][pOnTest] = false;
			PlayerData[playerid][pIndexTest] = 0;
			SendServerMessage(playerid, "Kamu gagal mengambil Driving Test karena membatalkan test teori!");			
		}

	}
	if(dialogid == DIALOG_TEST_STAGE_3)
	{
		if(response)
		{
			if(listitem == 1)
			{
				PlayerData[playerid][pIndexTest]++;
			}
			ShowPlayerDialog(playerid, DIALOG_TEST_STAGE_4, DIALOG_STYLE_TABLIST_HEADERS, "Question 4 of 7",
			"Apa yang anda lakukan jika mendengar sirine darurat dari arah belakang ?\
			\nA. Pelan-pelan dan terus maju\
			\nB. Menepi ke bahu jalan lalu berhenti\
			\nC. Mempertahankan kecepatan",
			"Next", "Close");
		}
		else
		{
			PlayerData[playerid][pOnTest] = false;
			PlayerData[playerid][pIndexTest] = 0;
			SendServerMessage(playerid, "Kamu gagal mengambil Driving Test karena membatalkan test teori!");			
		}
	}
	if(dialogid == DIALOG_TEST_STAGE_2)
	{
		if(response)
		{
			if(listitem == 1)
			{
				PlayerData[playerid][pIndexTest]++;
			}
			ShowPlayerDialog(playerid, DIALOG_TEST_STAGE_3, DIALOG_STYLE_TABLIST_HEADERS, "Question 3 of 7",
			"Dimanakah posisi parkir yang baik dan benar ?\
			\nA. Atas trotoar\
			\nB. Setengah trotoar dan setengah bahu jalan\
			\nC. Atas bahu jalan",
			"Next", "Close");
		}
		else
		{
			PlayerData[playerid][pOnTest] = false;
			PlayerData[playerid][pIndexTest] = 0;
			SendServerMessage(playerid, "Kamu gagal mengambil Driving Test karena membatalkan test teori!");			
		}
	}
	if(dialogid == DIALOG_TEST_STAGE_1)
	{
		if(response)
		{
			if(listitem == 2)
			{
				PlayerData[playerid][pIndexTest]++;
			}
			ShowPlayerDialog(playerid, DIALOG_TEST_STAGE_2, DIALOG_STYLE_TABLIST_HEADERS, "Question 2 of 7",
			"Berapakah jarak minimum parkir jika kamu parkir didekat Hydrant ?\
			\nA. 10 Meter\
			\nB. 15 Meter\
			\nC. 25 Meter",
			"Next", "Close");
		}
		else
		{
			PlayerData[playerid][pOnTest] = false;
			PlayerData[playerid][pIndexTest] = 0;
			SendServerMessage(playerid, "Kamu gagal mengambil Driving Test karena membatalkan test teori!");
		}
	}
	if(dialogid == DIALOG_TEST_MAIN)
	{
		if(response)
		{
			GiveMoney(playerid, -2500);
			ShowPlayerDialog(playerid, DIALOG_TEST_STAGE_1, DIALOG_STYLE_TABLIST_HEADERS, "Question 1 of 7",
			"Mengapa kita saat mengemudi harus memperlambat kendaraan saat tikungan ?\
			\nA. Untuk menghemat ke-ausan pada Ban\
			\nB. Untuk dapat melihat pemandangan\
			\nC. Untuk dapat berhenti jika ada seseorang dijalan",
			 "Next", "Close");
		}
		else
		{
			SendServerMessage(playerid, "Kamu batal mengambil Driving Test.");
		}
	}
	if(dialogid == DIALOG_TOYPOSX)
	{
		if(response)
		{
			if(!toyToggle[playerid][toySelect[playerid]])
				return SendErrorMessage(playerid, "Please attach your accessory first!");

			new Float:posisi = floatstr(inputtext);

			SetPlayerAttachedObject(playerid,
				toySelect[playerid],
				pToys[playerid][toySelect[playerid]][toy_model],
				pToys[playerid][toySelect[playerid]][toy_bone],
				posisi,
				pToys[playerid][toySelect[playerid]][toy_y],
				pToys[playerid][toySelect[playerid]][toy_z],
				pToys[playerid][toySelect[playerid]][toy_rx],
				pToys[playerid][toySelect[playerid]][toy_ry],
				pToys[playerid][toySelect[playerid]][toy_rz],
				pToys[playerid][toySelect[playerid]][toy_sx],
				pToys[playerid][toySelect[playerid]][toy_sy],
				pToys[playerid][toySelect[playerid]][toy_sz]);
			
			pToys[playerid][toySelect[playerid]][toy_x] = posisi;

			cmd_acc(playerid, "");

			SavePlayerToys(playerid);
		}
	}
	if(dialogid == DIALOG_TOYPOSY)
	{
		if(response)
		{

			if(!toyToggle[playerid][toySelect[playerid]])
				return SendErrorMessage(playerid, "Please attach your accessory first!");

			new Float:posisi = floatstr(inputtext);
			
			SetPlayerAttachedObject(playerid,
				toySelect[playerid],
				pToys[playerid][toySelect[playerid]][toy_model],
				pToys[playerid][toySelect[playerid]][toy_bone],
				pToys[playerid][toySelect[playerid]][toy_x],
				posisi,
				pToys[playerid][toySelect[playerid]][toy_z],
				pToys[playerid][toySelect[playerid]][toy_rx],
				pToys[playerid][toySelect[playerid]][toy_ry],
				pToys[playerid][toySelect[playerid]][toy_rz],
				pToys[playerid][toySelect[playerid]][toy_sx],
				pToys[playerid][toySelect[playerid]][toy_sy],
				pToys[playerid][toySelect[playerid]][toy_sz]);
			
			pToys[playerid][toySelect[playerid]][toy_y] = posisi;
			cmd_acc(playerid, "");

			SavePlayerToys(playerid);
		}
	}
	if(dialogid == DIALOG_TOYPOSZ)
	{
		if(response)
		{
			if(!toyToggle[playerid][toySelect[playerid]])
				return SendErrorMessage(playerid, "Please attach your accessory first!");

			new Float:posisi = floatstr(inputtext);
			
			SetPlayerAttachedObject(playerid,
				toySelect[playerid],
				pToys[playerid][toySelect[playerid]][toy_model],
				pToys[playerid][toySelect[playerid]][toy_bone],
				pToys[playerid][toySelect[playerid]][toy_x],
				pToys[playerid][toySelect[playerid]][toy_y],
				posisi,
				pToys[playerid][toySelect[playerid]][toy_rx],
				pToys[playerid][toySelect[playerid]][toy_ry],
				pToys[playerid][toySelect[playerid]][toy_rz],
				pToys[playerid][toySelect[playerid]][toy_sx],
				pToys[playerid][toySelect[playerid]][toy_sy],
				pToys[playerid][toySelect[playerid]][toy_sz]);
			
			pToys[playerid][toySelect[playerid]][toy_z] = posisi;
			cmd_acc(playerid, "");

			SavePlayerToys(playerid);
		}
	}
	if(dialogid == DIALOG_TOYPOSRX)
	{
		if(response)
		{
			if(!toyToggle[playerid][toySelect[playerid]])
				return SendErrorMessage(playerid, "Please attach your accessory first!");

			new Float:posisi = floatstr(inputtext);
			
			SetPlayerAttachedObject(playerid,
				toySelect[playerid],
				pToys[playerid][toySelect[playerid]][toy_model],
				pToys[playerid][toySelect[playerid]][toy_bone],
				pToys[playerid][toySelect[playerid]][toy_x],
				pToys[playerid][toySelect[playerid]][toy_y],
				pToys[playerid][toySelect[playerid]][toy_z],
				posisi,
				pToys[playerid][toySelect[playerid]][toy_ry],
				pToys[playerid][toySelect[playerid]][toy_rz],
				pToys[playerid][toySelect[playerid]][toy_sx],
				pToys[playerid][toySelect[playerid]][toy_sy],
				pToys[playerid][toySelect[playerid]][toy_sz]);
			
			pToys[playerid][toySelect[playerid]][toy_rx] = posisi;
			cmd_acc(playerid, "");

			SavePlayerToys(playerid);
		}
	}
	if(dialogid == DIALOG_TOYPOSRY)
	{
		if(response)
		{
			if(!toyToggle[playerid][toySelect[playerid]])
				return SendErrorMessage(playerid, "Please attach your accessory first!");

			new Float:posisi = floatstr(inputtext);
			
			SetPlayerAttachedObject(playerid,
				toySelect[playerid],
				pToys[playerid][toySelect[playerid]][toy_model],
				pToys[playerid][toySelect[playerid]][toy_bone],
				pToys[playerid][toySelect[playerid]][toy_x],
				pToys[playerid][toySelect[playerid]][toy_y],
				pToys[playerid][toySelect[playerid]][toy_z],
				pToys[playerid][toySelect[playerid]][toy_rx],
				posisi,
				pToys[playerid][toySelect[playerid]][toy_rz],
				pToys[playerid][toySelect[playerid]][toy_sx],
				pToys[playerid][toySelect[playerid]][toy_sy],
				pToys[playerid][toySelect[playerid]][toy_sz]);
			
			pToys[playerid][toySelect[playerid]][toy_ry] = posisi;
			cmd_acc(playerid, "");

			SavePlayerToys(playerid);
		}
	}
	if(dialogid == DIALOG_TOYPOSRZ)
	{
		if(response)
		{
			if(!toyToggle[playerid][toySelect[playerid]])
				return SendErrorMessage(playerid, "Please attach your accessory first!");

			new Float:posisi = floatstr(inputtext);
			
			SetPlayerAttachedObject(playerid,
				toySelect[playerid],
				pToys[playerid][toySelect[playerid]][toy_model],
				pToys[playerid][toySelect[playerid]][toy_bone],
				pToys[playerid][toySelect[playerid]][toy_x],
				pToys[playerid][toySelect[playerid]][toy_y],
				pToys[playerid][toySelect[playerid]][toy_z],
				pToys[playerid][toySelect[playerid]][toy_rx],
				pToys[playerid][toySelect[playerid]][toy_ry],
				posisi,
				pToys[playerid][toySelect[playerid]][toy_sx],
				pToys[playerid][toySelect[playerid]][toy_sy],
				pToys[playerid][toySelect[playerid]][toy_sz]);
			
			pToys[playerid][toySelect[playerid]][toy_rz] = posisi;
			cmd_acc(playerid, "");

			SavePlayerToys(playerid);
		}
	}
	if(dialogid == DIALOG_TOYPOSSX)
	{
		if(response)
		{
			if(!toyToggle[playerid][toySelect[playerid]])
				return SendErrorMessage(playerid, "Please attach your accessory first!");

			new Float:posisi = floatstr(inputtext);
			
			SetPlayerAttachedObject(playerid,
				toySelect[playerid],
				pToys[playerid][toySelect[playerid]][toy_model],
				pToys[playerid][toySelect[playerid]][toy_bone],
				pToys[playerid][toySelect[playerid]][toy_x],
				pToys[playerid][toySelect[playerid]][toy_y],
				pToys[playerid][toySelect[playerid]][toy_z],
				pToys[playerid][toySelect[playerid]][toy_rx],
				pToys[playerid][toySelect[playerid]][toy_ry],
				pToys[playerid][toySelect[playerid]][toy_rz],
				posisi,
				pToys[playerid][toySelect[playerid]][toy_sy],
				pToys[playerid][toySelect[playerid]][toy_sz]);
			
			pToys[playerid][toySelect[playerid]][toy_sx] = posisi;
			cmd_acc(playerid, "");

			SavePlayerToys(playerid);
		}
	}
	if(dialogid == DIALOG_TOYPOSSY)
	{
		if(response)
		{
			if(!toyToggle[playerid][toySelect[playerid]])
				return SendErrorMessage(playerid, "Please attach your accessory first!");

			new Float:posisi = floatstr(inputtext);
			
			SetPlayerAttachedObject(playerid,
				toySelect[playerid],
				pToys[playerid][toySelect[playerid]][toy_model],
				pToys[playerid][toySelect[playerid]][toy_bone],
				pToys[playerid][toySelect[playerid]][toy_x],
				pToys[playerid][toySelect[playerid]][toy_y],
				pToys[playerid][toySelect[playerid]][toy_z],
				pToys[playerid][toySelect[playerid]][toy_rx],
				pToys[playerid][toySelect[playerid]][toy_ry],
				pToys[playerid][toySelect[playerid]][toy_rz],
				pToys[playerid][toySelect[playerid]][toy_sx],
				posisi,
				pToys[playerid][toySelect[playerid]][toy_sz]);
			
			pToys[playerid][toySelect[playerid]][toy_sy] = posisi;
			cmd_acc(playerid, "");

			SavePlayerToys(playerid);
		}
	}
	if(dialogid == DIALOG_TOYPOSSZ)
	{
		if(response)
		{
			if(!toyToggle[playerid][toySelect[playerid]])
				return SendErrorMessage(playerid, "Please attach your accessory first!");

			new Float:posisi = floatstr(inputtext);
			
			SetPlayerAttachedObject(playerid,
				toySelect[playerid],
				pToys[playerid][toySelect[playerid]][toy_model],
				pToys[playerid][toySelect[playerid]][toy_bone],
				pToys[playerid][toySelect[playerid]][toy_x],
				pToys[playerid][toySelect[playerid]][toy_y],
				pToys[playerid][toySelect[playerid]][toy_z],
				pToys[playerid][toySelect[playerid]][toy_rx],
				pToys[playerid][toySelect[playerid]][toy_ry],
				pToys[playerid][toySelect[playerid]][toy_rz],
				pToys[playerid][toySelect[playerid]][toy_sx],
				pToys[playerid][toySelect[playerid]][toy_sy],
				posisi);
			
			pToys[playerid][toySelect[playerid]][toy_sz] = posisi;
			cmd_acc(playerid, "");

			SavePlayerToys(playerid);
		}
	}
	if(dialogid == DIALOG_TOYPOSISIBUY)
	{
		if(response)
		{
	        GiveMoney(playerid, -PlayerData[playerid][pSkinPrice]);
			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s has paid $%s and purchased a %s.", ReturnName(playerid), FormatNumber(PlayerData[playerid][pSkinPrice]), ProductName[PlayerData[playerid][pInBiz]][1]);
			BizData[PlayerData[playerid][pInBiz]][bizStock]--;		
			BizData[PlayerData[playerid][pInBiz]][bizVault] += PlayerData[playerid][pSkinPrice];
			new slot = GetPlayerFreeToySlot(playerid);
			pToys[playerid][slot][toy_model] = PlayerData[playerid][pTempModel];
			pToys[playerid][slot][toy_bone] = listitem + 1;
			toyToggle[playerid][slot] = true;
			SetPlayerAttachedObject(playerid, slot, pToys[playerid][slot][toy_model], listitem + 1);
		}
	}
	if(dialogid == DIALOG_TOYPOSISI)
	{
		if(response)
		{
			pToys[playerid][toySelect[playerid]][toy_bone] = listitem + 1;
			if(toyToggle[playerid][toySelect[playerid]])
			{
				RemovePlayerAttachedObject(playerid, toySelect[playerid]);
			}
			SetPlayerAttachedObject(playerid,
					toySelect[playerid],
					pToys[playerid][toySelect[playerid]][toy_model],
					pToys[playerid][toySelect[playerid]][toy_bone],
					pToys[playerid][toySelect[playerid]][toy_x],
					pToys[playerid][toySelect[playerid]][toy_y],
					pToys[playerid][toySelect[playerid]][toy_z],
					pToys[playerid][toySelect[playerid]][toy_rx],
					pToys[playerid][toySelect[playerid]][toy_ry],
					pToys[playerid][toySelect[playerid]][toy_rz],
					pToys[playerid][toySelect[playerid]][toy_sx],
					pToys[playerid][toySelect[playerid]][toy_sy],
					pToys[playerid][toySelect[playerid]][toy_sz]);
			SendServerMessage(playerid, "Accessory new bone position now is {FFFF00}%s", Bone_Name[listitem + 1]);
		}
	}
	if(dialogid == DIALOG_TOYEDIT)
	{
		if(response)
		{
			new mstr[156];
			switch(listitem)
			{
				case 0: // toggle attach
				{
					if(!toyToggle[playerid][toySelect[playerid]])
					{
						ShowText(playerid, "~w~Accessory ~g~attached", 3);

						SetPlayerAttachedObject(playerid,
						toySelect[playerid],
						pToys[playerid][toySelect[playerid]][toy_model],
						pToys[playerid][toySelect[playerid]][toy_bone],
						pToys[playerid][toySelect[playerid]][toy_x],
						pToys[playerid][toySelect[playerid]][toy_y],
						pToys[playerid][toySelect[playerid]][toy_z],
						pToys[playerid][toySelect[playerid]][toy_rx],
						pToys[playerid][toySelect[playerid]][toy_ry],
						pToys[playerid][toySelect[playerid]][toy_rz],
						pToys[playerid][toySelect[playerid]][toy_sx],
						pToys[playerid][toySelect[playerid]][toy_sy],
						pToys[playerid][toySelect[playerid]][toy_sz]);

						toyToggle[playerid][toySelect[playerid]] = true;
					}
					else
					{
						RemovePlayerAttachedObject(playerid, toySelect[playerid]);
						ShowText(playerid, "~w~Accessory ~r~deattached", 3);

						toyToggle[playerid][toySelect[playerid]] = false;
					}
					SavePlayerToys(playerid);
				}
				case 1: // change bone
				{
				    ShowPlayerDialog(playerid, DIALOG_TOYPOSISI, DIALOG_STYLE_LIST, "Bone Selection", "Spine\nHead\nLeft upper arm\nRight upper arm\nLeft hand\nRight hand\nLeft thigh\nRight thigh\nLeft foot\nRight foot\nRight calf\nLeft calf\nLeft forearm\nRight forearm\nLeft shoulder\nRight shoulder\nNeck\nJaw", "Choose", "Cancel");
				}
				case 2: // change placement
				{

					EditAttachedObject(playerid, toySelect[playerid]);

				}
				case 3:	//remove from list
				{
					if(IsPlayerAttachedObjectSlotUsed(playerid, toySelect[playerid]))
					{
						RemovePlayerAttachedObject(playerid, toySelect[playerid]);
					}
					pToys[playerid][toySelect[playerid]][toy_model] = 0;
					ShowText(playerid, "~w~Accessory ~y~removed!", 3);
					SavePlayerToys(playerid);
				}
				case 4: //Scale Fix
				{

					ShowText(playerid, "~w~Accessory scale ~y~Fixed", 3);

					pToys[playerid][toySelect[playerid]][toy_sx] = 1.0;
					pToys[playerid][toySelect[playerid]][toy_sy] = 1.0;
					pToys[playerid][toySelect[playerid]][toy_sz] = 1.0;

					if(!toyToggle[playerid][toySelect[playerid]])
					{
						RemovePlayerAttachedObject(playerid, toySelect[playerid]);
						SetPlayerAttachedObject(playerid,
						toySelect[playerid],
						pToys[playerid][toySelect[playerid]][toy_model],
						pToys[playerid][toySelect[playerid]][toy_bone],
						pToys[playerid][toySelect[playerid]][toy_x],
						pToys[playerid][toySelect[playerid]][toy_y],
						pToys[playerid][toySelect[playerid]][toy_z],
						pToys[playerid][toySelect[playerid]][toy_rx],
						pToys[playerid][toySelect[playerid]][toy_ry],
						pToys[playerid][toySelect[playerid]][toy_rz],
						pToys[playerid][toySelect[playerid]][toy_sx],
						pToys[playerid][toySelect[playerid]][toy_sy],
						pToys[playerid][toySelect[playerid]][toy_sz]);

						toyToggle[playerid][toySelect[playerid]] = true;
					}
				}
				case 5: //Pos X
				{
					format(mstr, sizeof(mstr), "Current X Position: %f\nInput new X Position:(Float)", pToys[playerid][toySelect[playerid]][toy_x]);
					ShowPlayerDialog(playerid, DIALOG_TOYPOSX, DIALOG_STYLE_INPUT, "Edit X Position", mstr, "Edit", "Cancel");
				}
				case 6: //Pos Y
				{
					format(mstr, sizeof(mstr), "Current Y Position: %f\nInput new Y Position:(Float)", pToys[playerid][toySelect[playerid]][toy_y]);
					ShowPlayerDialog(playerid, DIALOG_TOYPOSY, DIALOG_STYLE_INPUT, "Edit Y Position", mstr, "Edit", "Cancel");
				}
				case 7: //Pos Z
				{
					format(mstr, sizeof(mstr), "Current Z Position: %f\nInput new Z Position:(Float)", pToys[playerid][toySelect[playerid]][toy_z]);
					ShowPlayerDialog(playerid, DIALOG_TOYPOSZ, DIALOG_STYLE_INPUT, "Edit Z Position", mstr, "Edit", "Cancel");
				}
				case 8: //Pos RX
				{
					format(mstr, sizeof(mstr), "Current X Rotation: %f\nInput new X Rotation:(Float)", pToys[playerid][toySelect[playerid]][toy_rx]);
					ShowPlayerDialog(playerid, DIALOG_TOYPOSRX, DIALOG_STYLE_INPUT, "Edit X Rotation", mstr, "Edit", "Cancel");
				}
				case 9: //Pos RY
				{
					format(mstr, sizeof(mstr), "Current Y Rotation: %f\nInput new Y Rotation:(Float)", pToys[playerid][toySelect[playerid]][toy_ry]);
					ShowPlayerDialog(playerid, DIALOG_TOYPOSRY, DIALOG_STYLE_INPUT, "Edit Y Rotation", mstr, "Edit", "Cancel");
				}
				case 10: //Pos RZ
				{
					format(mstr, sizeof(mstr), "Current Z Rotation: %f\nInput new Z Rotation(Float)", pToys[playerid][toySelect[playerid]][toy_rz]);
					ShowPlayerDialog(playerid, DIALOG_TOYPOSRZ, DIALOG_STYLE_INPUT, "Edit Z Rotation", mstr, "Edit", "Cancel");
				}
				case 11: //Scale X
				{
					format(mstr, sizeof(mstr), "Current X Scale: %f\nInput new X Scale(Float)", pToys[playerid][toySelect[playerid]][toy_sx]);
					ShowPlayerDialog(playerid, DIALOG_TOYPOSSX, DIALOG_STYLE_INPUT, "Edit X Scale", mstr, "Edit", "Cancel");
				}
				case 12: //Scale Y
				{
					format(mstr, sizeof(mstr), "Current Y Scale: %f\nInput new Y Scale(Float)", pToys[playerid][toySelect[playerid]][toy_sy]);
					ShowPlayerDialog(playerid, DIALOG_TOYPOSSY, DIALOG_STYLE_INPUT, "Edit Y Scale", mstr, "Edit", "Cancel");
				}
				case 13: //Scale Z
				{
					format(mstr, sizeof(mstr), "Current Z Scale: %f\nInput new Z Scale(Float)", pToys[playerid][toySelect[playerid]][toy_sz]);
					ShowPlayerDialog(playerid, DIALOG_TOYPOSSZ, DIALOG_STYLE_INPUT, "Edit Z Scale", mstr, "Edit", "Cancel");
				}
			}
		}
	}

	if(dialogid == DIALOG_TOY)
	{
		if(response)
		{
			if(pToys[playerid][listitem][toy_model] == 0)
				return SendErrorMessage(playerid, "There is no accessory on selected index!");

			
			new string[512];
			toySelect[playerid] = listitem;
			format(string, sizeof(string), "Place %s\nChange Bone\nChange Placement\nRemove from list\nScale Fix\nPosition X: %f\nPosition Y: %f\nPosition Z: %f\nRotation X: %f\nRotation Y: %f\nRotation Z: %f\nScale X: %f\nScale Y: %f\nScale Z: %f",
			(!toyToggle[playerid][toySelect[playerid]]) ? ("On") : ("Off"), pToys[playerid][toySelect[playerid]][toy_x], pToys[playerid][toySelect[playerid]][toy_y], pToys[playerid][toySelect[playerid]][toy_z],
			pToys[playerid][toySelect[playerid]][toy_rx], pToys[playerid][toySelect[playerid]][toy_ry], pToys[playerid][toySelect[playerid]][toy_rz], pToys[playerid][toySelect[playerid]][toy_sx], pToys[playerid][toySelect[playerid]][toy_sy], pToys[playerid][toySelect[playerid]][toy_sz]);
			ShowPlayerDialog(playerid, DIALOG_TOYEDIT, DIALOG_STYLE_LIST, sprintf("Edit Accessory (#%d)", listitem), string, "Select", "Cancel");
		}
	}
	if(dialogid == DIALOG_CODE)
	{
		new string[158];
		if(response)
		{
			if(isnull(inputtext))
			{
				format(string, sizeof(string), "{FFFFFF}ERROR: Kode verifikasi salah!\n{FFFFFF}Silahkan masukan {C6E2FF}Kode verifikasi {FFFFFF}yang telah dikirimkan ke G-Mail {FFFF00}%s", UcpData[playerid][ucpEmail]),
	    		ShowPlayerDialog(playerid, DIALOG_CODE, DIALOG_STYLE_INPUT, "Account Verification", string, "Verify", "Close");
	    		return 1;
	    	}
			if(!IsNumeric(inputtext))
			{
				format(string, sizeof(string), "{FFFFFF}ERROR: Kode verifikasi salah!\n{FFFFFF}Silahkan masukan {C6E2FF}Kode verifikasi {FFFFFF}yang telah dikirimkan ke G-Mail {FFFF00}%s", UcpData[playerid][ucpEmail]),
	    		ShowPlayerDialog(playerid, DIALOG_CODE, DIALOG_STYLE_INPUT, "Account Verification", string, "Verify", "Close");
	    		return 1;
	    	}
			if(tempCode[playerid] != strval(inputtext))
			{
				format(string, sizeof(string), "{FFFFFF}ERROR: Kode verifikasi salah!\n{FFFFFF}Silahkan masukan {C6E2FF}Kode verifikasi {FFFFFF}yang telah dikirimkan ke G-Mail {FFFF00}%s", UcpData[playerid][ucpEmail]),
	    		ShowPlayerDialog(playerid, DIALOG_CODE, DIALOG_STYLE_INPUT, "Account Verification", string, "Verify", "Close");
	    		return 1;
	    	}


	    	new query[128];
	    	mysql_format(sqlcon, query, sizeof(query), "UPDATE `playerucp` SET `Active` = 1, `Registered` = '%d' WHERE `UCP` = '%s'", gettime(), GetName(playerid));
	    	mysql_query(sqlcon, query, true);

	    	CheckAccount(playerid);

	    	SendServerMessage(playerid, "Account verified successfully.");

		}
		else
		{
			Kick(playerid);
		}
	}
	if(dialogid == DIALOG_GPS_TREE)
	{
		if(response)
		{
			SetWaypoint(playerid, TreeData[listitem][treePos][0], TreeData[listitem][treePos][1], TreeData[listitem][treePos][2], 3.0);
			SendClientMessageEx(playerid, COLOR_YELLOW, "GPS: {FFFFFF}Tree at {FFA900}%s {FFFFFF}located at your radar.", GetLocation(TreeData[listitem][treePos][0], TreeData[listitem][treePos][1], TreeData[listitem][treePos][2]));
		}
	}
	if(dialogid == DIALOG_EDITBONE)
	{
		if(response)
		{
			new weaponid = EditingWeapon[playerid], weaponname[18], string[150];

			GetWeaponName(weaponid, weaponname, sizeof(weaponname));

			WeaponSettings[playerid][weaponid - 22][Bone] = listitem + 1;

			SendServerMessage(playerid, "You have successfully changed bone for %s attachment.", weaponname);

			mysql_format(sqlcon, string, sizeof(string), "INSERT INTO weaponsettings (Owner, WeaponID, Bone) VALUES ('%d', %d, %d) ON DUPLICATE KEY UPDATE Bone = VALUES(Bone)", PlayerData[playerid][pID], weaponid, listitem + 1);
			mysql_tquery(sqlcon, string);
		}
		EditingWeapon[playerid] = 0;
	}
	if(dialogid == DIALOG_HIDEGUN)
	{
		new weaponid = GetWeapon(playerid), index = weaponid - 22;
		if(response)
		{
			if(!weaponid)
				return SendErrorMessage(playerid, "You are not holding any weapon.");

			if (EditingWeapon[playerid] != 0)
				return SendErrorMessage(playerid, "You are already editing a weapon attachment");

			if (!IsWeaponWearable(weaponid))
				return SendErrorMessage(playerid, "You can't edit this weapon attachment!");

			if(listitem == 0)
			{
				if (WeaponSettings[playerid][weaponid - 22][Hidden])
					return SendErrorMessage(playerid, "This weapon is still Hidden! you must unhide this weapon.");

				EditingWeapon[playerid] = weaponid;
				SetPlayerArmedWeapon(playerid, 0);
			   
				SetPlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid), GetWeaponModel(weaponid), WeaponSettings[playerid][index][Bone], WeaponSettings[playerid][index][Position][0], WeaponSettings[playerid][index][Position][1], WeaponSettings[playerid][index][Position][2], WeaponSettings[playerid][index][Position][3], WeaponSettings[playerid][index][Position][4], WeaponSettings[playerid][index][Position][5], 1.0, 1.0, 1.0);
				EditAttachedObject(playerid, GetWeaponObjectSlot(weaponid));
			}
			if(listitem == 1)
			{
				ShowPlayerDialog(playerid, DIALOG_EDITBONE, DIALOG_STYLE_LIST, "Bone", "Spine\nHead\nLeft upper arm\nRight upper arm\nLeft hand\nRight hand\nLeft thigh\nRight thigh\nLeft foot\nRight foot\nRight calf\nLeft calf\nLeft forearm\nRight forearm\nLeft shoulder\nRight shoulder\nNeck\nJaw", "Choose", "Cancel");
				EditingWeapon[playerid] = weaponid;				
			}
			if(listitem == 2)
			{
				if (!IsWeaponHideable(weaponid))
					return SendErrorMessage(playerid, "You can't hide this weapon!");

				new weaponname[18], string[150];

				GetWeaponName(weaponid, weaponname, sizeof(weaponname));
			   
				if (WeaponSettings[playerid][index][Hidden])
				{
					format(string, sizeof(string), "{FFFF00}INFO: {FFFFFF}You have {00FF00}unhide {FFFFFF}attachment for weapon {FFFF00}%s", weaponname);
					WeaponSettings[playerid][index][Hidden] = false;
				}
				else
				{
					if (IsPlayerAttachedObjectSlotUsed(playerid, GetWeaponObjectSlot(weaponid)))
						RemovePlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid));

					format(string, sizeof(string), "{FFFF00}INFO: {FFFFFF}You have {FF0000}hide {FFFFFF}attachment for weapon {FFFF00}%s", weaponname);
					WeaponSettings[playerid][index][Hidden] = true;
				}
				SendClientMessage(playerid, -1, string);
			   
				mysql_format(sqlcon, string, sizeof(string), "INSERT INTO weaponsettings (Owner, WeaponID, Hidden) VALUES ('%d', %d, %d) ON DUPLICATE KEY UPDATE Hidden = VALUES(Hidden)", PlayerData[playerid][pID], weaponid, WeaponSettings[playerid][index][Hidden]);
				mysql_tquery(sqlcon, string);
			}
		}
	}
	if(dialogid == DIALOG_HOUSE_PARK_TAKE)
	{
		new count, id = HousePark_Nearest(playerid);
		foreach(new i : PlayerVehicle) if(Vehicle_IsOwner(playerid, i))
		{
			if(VehicleData[i][vHouse] == id && count++ == listitem)
			{
				OnPlayerVehicleRespawn(i);

				VehicleData[i][vHouse] = -1;
				mysql_tquery(sqlcon, sprintf("SELECT * FROM `crates` WHERE `Vehicle` = '%d'", VehicleData[i][vID]), "OnLoadCrate", "d", i);

				SendServerMessage(playerid, "You have successfully taken your {FFFF00}%s {FFFFFF}from house park.", ReturnVehicleModelName(VehicleData[i][vModel]));
			
				PutPlayerInVehicle(playerid, VehicleData[i][vVehicle], 0);
			}
		}
	}
	if(dialogid == DIALOG_HOUSE_PARK)
	{
		if(response)
		{
			new str[512];
			format(str, sizeof(str), "Model\tPlate\n");
			if(listitem == 0)
			{
				foreach(new i : PlayerVehicle) if(Vehicle_IsOwner(playerid, i))
				{
					if(VehicleData[i][vHouse] == HousePark_Nearest(playerid))
					{
						format(str, sizeof(str), "%s%s\t%s\n", str, ReturnVehicleModelName(VehicleData[i][vModel]), VehicleData[i][vPlate]);
					}
					ShowPlayerDialog(playerid, DIALOG_HOUSE_PARK_TAKE, DIALOG_STYLE_TABLIST_HEADERS, "Parked Vehicle", str, "Take", "Close");
				}
			}
			if(listitem == 1)
			{
				new id = Vehicle_GetID(GetPlayerVehicleID(playerid)), hid = HousePark_Nearest(playerid);

				if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
					return SendErrorMessage(playerid, "You must driving a vehicle.");

				if(id == -1)
					return SendErrorMessage(playerid, "You are not inside valid player vehicle!");

				if(!Vehicle_IsOwner(playerid, id))
					return SendErrorMessage(playerid, "You only can park your own vehicle!");

				if(VehicleData[id][vRental] != -1)
					return SendErrorMessage(playerid, "You can't park rented vehicle!");

				if(House_CountVehicle(hid) >= HouseData[hid][housePark])
					return SendErrorMessage(playerid, "This house already have full slot of parked vehicle!");

				VehicleData[id][vHouse] = hid;

				SaveVehicle(id);

				if(IsValidVehicle(VehicleData[id][vVehicle]))
					DestroyVehicle(VehicleData[id][vVehicle]);

				forex(z, 5)
				{
					if(IsValidDynamicObject(VehicleData[id][vToy][z]))
						DestroyDynamicObject(VehicleData[id][vToy][z]);
				}
				forex(z, MAX_CRATES) if(CrateData[z][crateExists] && CrateData[z][crateVehicle] == VehicleData[id][vID])
				{
					CrateData[z][crateExists] = false;
					CrateData[z][crateVehicle] = -1;
				}
				SendServerMessage(playerid, "You have successfully parked your {FFFF00}%s", ReturnVehicleModelName(VehicleData[id][vModel]));
			}
		}
	}
	if(dialogid == DIALOG_BM_MATERIAL)
	{
		if(response)
		{
			if(listitem == 0)
			{
				if(GetMoney(playerid) < 10000)
					return SendErrorMessage(playerid, "You don't have enough money!");

				GiveMoney(playerid, -10000);
				SendServerMessage(playerid, "Kamu berhasil membeli {FF0000}9mm Silenced Material");
				Inventory_Add(playerid, "9mm Silenced Material", 3052, 1);
			}
			if(listitem == 1)
			{
				if(GetMoney(playerid) < 25000)
					return SendErrorMessage(playerid, "You don't have enough money!");

				GiveMoney(playerid, -25000);
				SendServerMessage(playerid, "Kamu berhasil membeli {FF0000}Shotgun Material");
				Inventory_Add(playerid, "Shotgun Material", 3052, 1);				
			}
		}
	}
	if(dialogid == DIALOG_BM_CLIP)
	{
		if(response)
		{
			PlayerData[playerid][pListitem] = listitem;
			if(listitem == 0)
			{
				ShowPlayerDialog(playerid, DIALOG_BM_CLIP_AMOUNT, DIALOG_STYLE_INPUT, "9mm Luger", "Silahkan masukan jumlah clip yang ingin dibeli:\nPrice: $47.00 / 1 Clip", "Buy", "Close");
			}
			if(listitem == 1)
			{
				ShowPlayerDialog(playerid, DIALOG_BM_CLIP_AMOUNT, DIALOG_STYLE_INPUT, "12 Gauge", "Silahkan masukan jumlah clip yang ingin dibeli:\nPrice: $69.00 / 1 Clip", "Buy", "Close");
			}
		}
	}
	if(dialogid == DIALOG_BM_CLIP_AMOUNT)
	{
		if(response)
		{
			new wep = PlayerData[playerid][pListitem];
			if(wep == 0)
			{
				if(strval(inputtext) < 1)
					return ShowPlayerDialog(playerid, DIALOG_BM_CLIP_AMOUNT, DIALOG_STYLE_INPUT, "9mm Luger", "ERROR: Invalid amount!\nSilahkan masukan jumlah clip yang ingin dibeli:\nPrice: $47.00 / 1 Clip", "Buy", "Close");
			
				if(GetMoney(playerid) < strval(inputtext)*4700)
					return ShowPlayerDialog(playerid, DIALOG_BM_CLIP_AMOUNT, DIALOG_STYLE_INPUT, "9mm Luger", "ERROR: You don't have enough money!\nSilahkan masukan jumlah clip yang ingin dibeli:\nPrice: $47.00 / 1 Clip", "Buy", "Close");
			
				if(strval(inputtext) > 100)
					return  ShowPlayerDialog(playerid, DIALOG_BM_CLIP_AMOUNT, DIALOG_STYLE_INPUT, "9mm Luger", "ERROR: Invalid amount!\nSilahkan masukan jumlah clip yang ingin dibeli:\nPrice: $47.00 / 1 Clip", "Buy", "Close");
			
				GiveMoney(playerid, -strval(inputtext)*4700);
				Inventory_Add(playerid, "9mm Luger", 19995, strval(inputtext));
				SendServerMessage(playerid, "Kamu berhasil membeli {FF0000}%d Clip {FFFFFF}dengan harga {FFFF00}$%s", strval(inputtext), FormatNumber(strval(inputtext)*4700));
			}
			else if(wep == 1)
			{
				if(strval(inputtext) < 1)
					return ShowPlayerDialog(playerid, DIALOG_BM_CLIP_AMOUNT, DIALOG_STYLE_INPUT, "12 Gauge", "ERROR: Invalid amount!\nSilahkan masukan jumlah clip yang ingin dibeli:\nPrice: $69.00 / 1 Clip", "Buy", "Close");
			
				if(GetMoney(playerid) < strval(inputtext)*6900)
					return ShowPlayerDialog(playerid, DIALOG_BM_CLIP_AMOUNT, DIALOG_STYLE_INPUT, "12 Gauge", "ERROR: You don't have enough money!\nSilahkan masukan jumlah clip yang ingin dibeli:\nPrice: $69.00 / 1 Clip", "Buy", "Close");
			
				if(strval(inputtext) > 100)
					return ShowPlayerDialog(playerid, DIALOG_BM_CLIP_AMOUNT, DIALOG_STYLE_INPUT, "12 Gauge", "ERROR: Invalid amount!\nSilahkan masukan jumlah clip yang ingin dibeli:\nPrice: $69.00 / 1 Clip", "Buy", "Close");
			
				GiveMoney(playerid, -strval(inputtext)*6900);
				Inventory_Add(playerid, "12 Gauge", 19995, strval(inputtext));
				SendServerMessage(playerid, "Kamu berhasil membeli {FF0000}%d Clip {FFFFFF}dengan harga {FFFF00}$%s", strval(inputtext), FormatNumber(strval(inputtext)*6900));
			}
		}
	} 
	if(dialogid == DIALOG_BM_SCHEMATIC)
	{
		if(response)
		{
			if(listitem == 0)
			{
				if(GetMoney(playerid) < 170000)
					return SendErrorMessage(playerid, "You don't have enough money!");

				Inventory_Add(playerid, "9mm Silenced Schematic", 3111, 1);
				SendServerMessage(playerid, "Kamu berhasil membeli {FF0000}9mm Silenced Schematic");
				GiveMoney(playerid, -170000);
			}
			if(listitem == 1)
			{
				if(GetMoney(playerid) < 300000)
					return SendErrorMessage(playerid, "You don't have enough money!");

				Inventory_Add(playerid, "Shotgun Schematic", 3111, 1);
				SendServerMessage(playerid, "Kamu berhasil membeli {FF0000}Shotgun Schematic");		
				GiveMoney(playerid, -300000);		
			}
		}
	}
	if(dialogid == DIALOG_TICKET)
	{
		if (response)
		{
		    if (!TicketData[playerid][listitem][ticketExists])
		        return SendErrorMessage(playerid, "There is no ticket in the selected slot.");

			if (GetMoney(playerid) < TicketData[playerid][listitem][ticketFee])
			    return SendErrorMessage(playerid, "You can't afford to pay this ticket.");

			GiveMoney(playerid, -TicketData[playerid][listitem][ticketFee]);
			GovData[govVault] += TicketData[playerid][listitem][ticketFee];
			SendServerMessage(playerid, "You have paid off a %s ticket for \"$%s\".", FormatNumber(TicketData[playerid][listitem][ticketFee]), TicketData[playerid][listitem][ticketReason]);
			Ticket_Remove(playerid, listitem);
		}
	}
	if(dialogid == DIALOG_FACTION_RETURN)
	{
		cmd_faction(playerid, "menu");
	}
	if(dialogid == DIALOG_FACTION_MENU)
	{
		if(response)
		{
			new str[1012];
			if(listitem == 0)
			{
				if(GetFactionType(playerid) == FACTION_FAMILY)
				{
					format(str, sizeof(str), "Name(ID)\tRank\n");
				}
				else
				{
					format(str, sizeof(str), "Name(ID)\tStatus\tRank\tDuty Time\n");
				}
				foreach(new i : Player) if(PlayerData[i][pFaction] == PlayerData[playerid][pFaction])
				{
					if(GetFactionType(playerid) == FACTION_FAMILY)
					{
						format(str, sizeof(str), "%s%s(%d)\t%s\n", str, GetName(i), i, Faction_GetRank(i));
					}
					else
					{
						format(str, sizeof(str), "%s%s(%d)\t%s\t%s\t%dh %dm %ds\n", str, GetName(i), i, (!PlayerData[i][pOnDuty]) ? ("Off Duty") : ("On Duty"), Faction_GetRank(i), PlayerData[i][pDutyHour], PlayerData[i][pDutyMinute], PlayerData[i][pDutySecond]);
					}
				}
				ShowPlayerDialog(playerid, DIALOG_FACTION_RETURN, DIALOG_STYLE_TABLIST_HEADERS, "Online Member(s)", str, "Return", "");
			}
			if(listitem == 1)
			{
				new query[167];
				mysql_format(sqlcon, query, sizeof(query), "SELECT * FROM characters WHERE Faction = '%d'", PlayerData[playerid][pFaction]);
				mysql_query(sqlcon, query);
				if(cache_num_rows())
				{
					format(str, sizeof(str), "Name\tRank\n");
					forex(i, cache_num_rows())
					{
						new tempname[24], rank;
						cache_get_value_name(i, "Name", tempname, 24);
						cache_get_value_name_int(i, "FactionRank", rank);

						format(str, sizeof(str), "%s%s\tRank %d\n", str, tempname, rank);
					}
					ShowPlayerDialog(playerid, DIALOG_FACTION_RETURN, DIALOG_STYLE_TABLIST_HEADERS, "Total Member(s)", str, "Return", "");
				}
			}
		}
	}
	if(dialogid == DIALOG_FORCEINSURANCE)
	{
	    if(response)
	    {
	        new count;
	        new targetid = PlayerData[playerid][pTarget];
         	foreach(new i : PlayerVehicle)
	        {
	            if(VehicleData[i][vInsuranced])
	            {
	                if(Vehicle_IsOwner(targetid, i) && count++ == listitem)
	                {
	                    VehicleData[i][vInsuranced] = 0;
	                    VehicleData[i][vInsuTime] = 0;
						new randspawn = random(sizeof(Random_Insu));

						VehicleData[i][vPos][0] = Random_Insu[randspawn][0];
						VehicleData[i][vPos][1] = Random_Insu[randspawn][1];
						VehicleData[i][vPos][2] = Random_Insu[randspawn][2];
						VehicleData[i][vPos][3] = Random_Insu[randspawn][3];

						OnPlayerVehicleRespawn(i);

						VehicleData[i][vInsurance]++;
						SendServerMessage(targetid, "%s has Force insurance to your {FFFF00}%s", PlayerData[playerid][pUCP], GetVehicleModelName(VehicleData[i][vModel]));
						SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s has Force Insurance to %s %s.", PlayerData[playerid][pUCP], GetName(targetid), GetVehicleModelName(VehicleData[i][vModel]));
					}
				}
			}
		}
	}
	if(dialogid == DIALOG_GOTOLOC_HOUSE)
	{
		if(response)
		{
			SetPlayerPos(playerid, HouseData[listitem][housePos][0], HouseData[listitem][housePos][1], HouseData[listitem][housePos][2]);
		}
	}
	if(dialogid == DIALOG_GOTOLOC_BUSINESS)
	{
		if(response)
		{
			SetPlayerPos(playerid, BizData[listitem][bizExt][0], BizData[listitem][bizExt][1], BizData[listitem][bizExt][2]);
		}
	}
	if(dialogid == DIALOG_GOTOLOC_DEALER)
	{
		if(response)
		{
			SetPlayerPos(playerid, DealerData[listitem][dealerPos][0], DealerData[listitem][dealerPos][1], DealerData[listitem][dealerPos][2]);
		}
	}
	if(dialogid == DIALOG_GOTOLOC_DOOR)
	{
		if(response)
		{
			SetPlayerPos(playerid, DoorData[listitem][ddExteriorX], DoorData[listitem][ddExteriorY], DoorData[listitem][ddExteriorZ]);
		}
	}
	if(dialogid == DIALOG_PAYCHECK)
	{
		if(response)
		{
			new taxval = PlayerData[playerid][pSalary]/100*GovData[govTax];
		    new nxtlevel = PlayerData[playerid][pLevel]+1;
			new expamount = nxtlevel*1;
			PlayerData[playerid][pBank] += PlayerData[playerid][pSalary]-taxval;
			PlayerData[playerid][pExp]++;
			GameTextForPlayer(playerid, "~w~Paycheck ~y~taken!", 5000, 1);
			PlayerData[playerid][pPaycheck] = 3600;
			PlayerData[playerid][pSalary] = 0;
			new string[256];
			mysql_format(sqlcon,string, sizeof(string), "DELETE FROM `playersalary` WHERE `owner` = '%d'", PlayerData[playerid][pID]);
			mysql_tquery(sqlcon, string);

			if (PlayerData[playerid][pExp] < expamount)
			{
				SendServerMessage(playerid, "You need %d more Paycheck to the next level.", expamount - PlayerData[playerid][pExp]);
			}
			else
			{
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				PlayerData[playerid][pLevel]++;
				PlayerData[playerid][pExp] = PlayerData[playerid][pExp]-expamount;
				SetPlayerScore(playerid, PlayerData[playerid][pLevel]);
				SendServerMessage(playerid, "Level UP! Sekarang kamu level %d", PlayerData[playerid][pLevel]);
				//PlayAudioStreamForPlayer(playerid, "https://www.mboxdrive.com/GTA San Andreas - Mission passed sound.mp3");
			}
			if(PlayerData[playerid][pQuitjob] > 0)
			{
				PlayerData[playerid][pQuitjob]--;
			}
		}
	}
	if(dialogid == DIALOG_GPS_PUBLIC)
	{
		if(response)
		{
			SetWaypoint(playerid, PublicPoint[listitem][0], PublicPoint[listitem][1], PublicPoint[listitem][2], 4.0);
			SendClientMessageEx(playerid, COLOR_YELLOW, "GPS: {FFFFFF}Lokasi {FFA900}%s {FFFFFF}berhasil ditandai pada radarmu!", PublicName[listitem]);
		}
	}
	if(dialogid == DIALOG_GPS_JOB)
	{
		if(response)
		{
			SetWaypoint(playerid, JobPoint[listitem][0], JobPoint[listitem][1], JobPoint[listitem][2], 4.0);
			SendClientMessageEx(playerid, COLOR_YELLOW, "GPS: {FFFFFF}Lokasi {FFA900}%s {FFFFFF}berhasil ditandai pada radarmu!", JobLocName[listitem]);			
		}
	}
	if(dialogid == DIALOG_GPS_DEALER)
	{
		if(response)
		{
			SetWaypoint(playerid, DealerData[listitem][dealerPos][0], DealerData[listitem][dealerPos][1], DealerData[listitem][dealerPos][2], 4.0);
			SendClientMessageEx(playerid, COLOR_YELLOW, "GPS: {FFFFFF}Dealership {FFA900}%s {FFFFFF}berhasil ditandai pada radarmu!", DealerData[listitem][dealerName]);				
		}
	}
	if(dialogid == DIALOG_GPS_BUSINESS)
	{
		if(response)
		{
			SetWaypoint(playerid, BizData[listitem][bizExt][0], BizData[listitem][bizExt][1], BizData[listitem][bizExt][2], 4.0);
			SendClientMessageEx(playerid, COLOR_YELLOW, "GPS: {FFFFFF}Business {FFA900}%s {FFFFFF}berhasil ditandai pada radarmu!", BizData[listitem][bizName]);				
		}
	}
	if(dialogid == DIALOG_ATM_WITHDRAW)
	{
		if(response)
		{
			new dollars, cents, totalcash[25], cash[32];
			if(sscanf(inputtext, "s[32]", cash))
				return ShowPlayerDialog(playerid, DIALOG_ATM_TRANSFER_ID, DIALOG_STYLE_INPUT, "Transfer", "Please input playerid/PartOfName the player you want to transfer:\nFormat: [amount (opt:dollar.cents)]", "Next", "Close");

			if(strfind(cash, ".", true) != -1)
			{
				sscanf(cash, "p<.>dd", dollars, cents);
				format(totalcash, sizeof(totalcash), "%d%02d", dollars, cents);
				if(strval(totalcash) < 1)
					return ShowPlayerDialog(playerid, DIALOG_ATM_WITHDRAW, DIALOG_STYLE_INPUT, sprintf("Balance: $%s", FormatNumber(PlayerData[playerid][pBank])), "ERROR: Invalid amount!\nPlease input the amount of cash you want to withdraw:", "Get", "Close");

				if(PlayerData[playerid][pBank] < strval(totalcash))
					return ShowPlayerDialog(playerid, DIALOG_ATM_WITHDRAW, DIALOG_STYLE_INPUT, sprintf("Balance: $%s", FormatNumber(PlayerData[playerid][pBank])), "ERROR: There is no enough money on your bank!\nPlease input the amount of cash you want to withdraw:", "Get", "Close");

				GiveMoney(playerid, strval(totalcash));
				PlayerData[playerid][pBank] -= strval(totalcash);
				SendClientMessageEx(playerid, COLOR_SERVER, "ATM: {FFFFFF}You have successfully withdrawn {00FF00}$%s {FFFFFF}from ATM!", FormatNumber(strval(totalcash)));
			}
			else
			{
				sscanf(cash, "d", dollars);
				format(totalcash, sizeof(totalcash), "%d00", dollars);

				if(strval(totalcash) < 1)
					return ShowPlayerDialog(playerid, DIALOG_ATM_WITHDRAW, DIALOG_STYLE_INPUT, sprintf("Balance: $%s", FormatNumber(PlayerData[playerid][pBank])), "ERROR: Invalid amount!\nPlease input the amount of cash you want to withdraw:", "Get", "Close");

				if(PlayerData[playerid][pBank] < strval(totalcash))
					return ShowPlayerDialog(playerid, DIALOG_ATM_WITHDRAW, DIALOG_STYLE_INPUT, sprintf("Balance: $%s", FormatNumber(PlayerData[playerid][pBank])), "ERROR: There is no enough money on your bank!\nPlease input the amount of cash you want to withdraw:", "Get", "Close");

				GiveMoney(playerid, strval(totalcash));
				PlayerData[playerid][pBank] -= strval(totalcash);
				SendClientMessageEx(playerid, COLOR_SERVER, "ATM: {FFFFFF}You have successfully withdrawn {00FF00}$%s {FFFFFF}from ATM!", FormatNumber(strval(totalcash)));
			}
		}
	}
	if(dialogid == DIALOG_ATM_TRANSFER_AMOUNT)
	{
		if(response)
		{
			new dollars, cents, totalcash[25], cash[32], targetid = PlayerData[playerid][pTarget];

			if(targetid == INVALID_PLAYER_ID)
				return SendErrorMessage(playerid, "Transfer target is no longer valid (disconnected)"), cmd_atm(playerid, "");

			if(sscanf(inputtext, "s[32]", cash))
				return ShowPlayerDialog(playerid, DIALOG_ATM_TRANSFER_AMOUNT, DIALOG_STYLE_INPUT, "Transfer", "Please input amount of cash you want to transfer:\nFormat: [amount (opt:dollar.cents)]", "Transfer", "Close");

			if(strfind(cash, ".", true) != -1)
			{
				sscanf(cash, "p<.>dd", dollars, cents);
				format(totalcash, sizeof(totalcash), "%d%02d", dollars, cents);
				if(strval(totalcash) < 0)
					return ShowPlayerDialog(playerid, DIALOG_ATM_TRANSFER_AMOUNT, DIALOG_STYLE_INPUT, "Transfer", "Please input amount of cash you want to transfer:\nFormat: [amount (opt:dollar.cents)]", "Transfer", "Close");

				if(PlayerData[playerid][pBank] < strval(totalcash))
					return ShowPlayerDialog(playerid, DIALOG_ATM_TRANSFER_AMOUNT, DIALOG_STYLE_INPUT, "Transfer", "Please input amount of cash you want to transfer:\nFormat: [amount (opt:dollar.cents)]", "Transfer", "Close");

				PlayerData[targetid][pBank] += strval(totalcash);
				PlayerData[playerid][pBank] -= strval(totalcash);
				SendClientMessageEx(playerid, COLOR_SERVER, "ATM: {FFFFFF}You have successfully transfer {00FF00}$%s {FFFFFF}to {FFFF00}", FormatNumber(strval(totalcash)), GetName(targetid));
				SendClientMessageEx(targetid, COLOR_SERVER, "ATM: {FFFFFF}You've received {00FF00}$%s {FFFFFF}from {FFFF00}%s", FormatNumber(strval(totalcash)), GetName(playerid));
			}
			else
			{
				sscanf(cash, "d", dollars);
				format(totalcash, sizeof(totalcash), "%d00", dollars);

				if(strval(totalcash) < 0)
					return ShowPlayerDialog(playerid, DIALOG_ATM_TRANSFER_AMOUNT, DIALOG_STYLE_INPUT, "Transfer", "Please input amount of cash you want to transfer:\nFormat: [amount (opt:dollar.cents)]", "Transfer", "Close");

				if(PlayerData[playerid][pBank] < strval(totalcash))
					return ShowPlayerDialog(playerid, DIALOG_ATM_TRANSFER_AMOUNT, DIALOG_STYLE_INPUT, "Transfer", "Please input amount of cash you want to transfer:\nFormat: [amount (opt:dollar.cents)]", "Transfer", "Close");

				PlayerData[targetid][pBank] += strval(totalcash);
				PlayerData[playerid][pBank] -= strval(totalcash);
				SendClientMessageEx(playerid, COLOR_SERVER, "ATM: {FFFFFF}You have successfully transfer {00FF00}$%s {FFFFFF}to {FFFF00}", FormatNumber(strval(totalcash)), GetName(targetid));
				SendClientMessageEx(targetid, COLOR_SERVER, "ATM: {FFFFFF}You've received {00FF00}$%s {FFFFFF}from {FFFF00}%s", FormatNumber(strval(totalcash)), GetName(playerid));
			}			
		}
		else
		{
			cmd_atm(playerid, "");
		}
	}
	if(dialogid == DIALOG_ATM_TRANSFER_ID)
	{
		if(response)
		{
			new id;
			if(sscanf(inputtext, "u", id))
				return ShowPlayerDialog(playerid, DIALOG_ATM_TRANSFER_ID, DIALOG_STYLE_INPUT, "Transfer", "Please input playerid/PartOfName the player you want to transfer:\n", "Next", "Close");

			if(id == INVALID_PLAYER_ID)
				return ShowPlayerDialog(playerid, DIALOG_ATM_TRANSFER_ID, DIALOG_STYLE_INPUT, "Transfer", "ERROR: Invalid player specified!\nPlease input playerid/PartOfName the player you want to transfer:", "Next", "Close");
		

			PlayerData[playerid][pTarget] = id;
			ShowPlayerDialog(playerid, DIALOG_ATM_TRANSFER_AMOUNT, DIALOG_STYLE_INPUT, "Transfer", "Please input amount of cash you want to transfer:\nFormat: [amount (opt:dollar.cents)]", "Transfer", "Close");
			SendServerMessage(playerid, "Transfer target is {FFFF00}%s", GetName(playerid));
		}
		else
		{
			cmd_atm(playerid, "");
		}
	}
	if(dialogid == DIALOG_ATM)
	{
		if(response)
		{
			if(listitem == 0)
			{
				cmd_atm(playerid, "");
			}
			if(listitem == 1)
			{
				ShowPlayerDialog(playerid, DIALOG_ATM_WITHDRAW, DIALOG_STYLE_INPUT, sprintf("Balance: $%s", FormatNumber(PlayerData[playerid][pBank])), "Please input the amount of cash you want to withdraw:", "Get", "Close");
			}
			if(listitem == 2)
			{
				if(PlayerData[playerid][pLevel] < 2)
					return cmd_atm(playerid, ""), SendErrorMessage(playerid, "Kamu tidak bisa melakukan transaksi jika masih dibawah level 2!");

				ShowPlayerDialog(playerid, DIALOG_ATM_TRANSFER_ID, DIALOG_STYLE_INPUT, "Transfer", "Please input playerid/PartOfName the player you want to transfer:", "Next", "Close");
			}
			if(listitem == 3)
			{
				if(PlayerData[playerid][pPaycheck] > 0 && PlayerData[playerid][pAdmin] < 7)
					return SendErrorMessage(playerid, "Kamu harus menunggu %d menit untuk Paycheck!", PlayerData[playerid][pPaycheck]/60);

				new str[256];
				new taxval = PlayerData[playerid][pSalary]/100*GovData[govTax];
				format(str, sizeof(str), "{FFFFFF}Salary: {009000}$%s\n{FFFFFF}Tax: {FFFF00}-$%s {FF0000}(%d percent)\n{FFFFFF}Total Interest: {00FF00}$%s", FormatNumber(PlayerData[playerid][pSalary]), FormatNumber(taxval), GovData[govTax], FormatNumber(PlayerData[playerid][pSalary]-taxval));
				ShowPlayerDialog(playerid, DIALOG_PAYCHECK, DIALOG_STYLE_MSGBOX, "Paycheck", str, "Get", "Close");
			}
		}
	}
	if(dialogid == DIALOG_DEALER_BUY)
	{
		if(response)
		{
			new id = PlayerData[playerid][pSelecting];
			if(DealerData[id][dealerVehicle][listitem] == 19300)
				return SendErrorMessage(playerid, "There is no vehicle on selected slot!");

			if(Vehicle_Count(playerid) >= 3)
				return SendErrorMessage(playerid, "You only can have 3 owned vehicle at the time.");

			if(DealerData[id][dealerSpawn][0] == 0)
				return SendErrorMessage(playerid, "This dealership still doesn't have their Spawn Position!");

			if(DealerData[id][dealerStock][listitem] < 1)
				return SendErrorMessage(playerid, "The vehicle is out of stock!");

			if(GetMoney(playerid) < DealerData[id][dealerCost][listitem])
				return SendErrorMessage(playerid, "You don't have enough money!");


			Vehicle_Create(PlayerData[playerid][pID], DealerData[id][dealerVehicle][listitem], DealerData[id][dealerSpawn][0], DealerData[id][dealerSpawn][1], DealerData[id][dealerSpawn][2], DealerData[id][dealerSpawn][3], random(126), random(126));
			
			SendServerMessage(playerid, "Kamu berhasil membeli {FFFF00}%s {FFFFFF}dengan harga {00FF00}$%s", ReturnVehicleModelName(DealerData[id][dealerVehicle][listitem]), FormatNumber(DealerData[id][dealerCost][listitem]));
			GiveMoney(playerid, -DealerData[id][dealerCost][listitem]);
			DealerData[id][dealerVault] += DealerData[id][dealerCost][listitem];
			DealerData[id][dealerStock][listitem]--;
		}	
	}
	if(dialogid == DIALOG_DEALER_SETNAME)
	{
		if(isnull(inputtext))
			return ShowPlayerDialog(playerid, DIALOG_DEALER_SETNAME, DIALOG_STYLE_INPUT, "Dealer Name", "Silahkan masukan nama baru untuk dealershipmu:", "Set", "Close");

		if(strlen(inputtext) > 24)
			return ShowPlayerDialog(playerid, DIALOG_DEALER_SETNAME, DIALOG_STYLE_INPUT, "Dealer Name", "ERROR: Nama dealer tidak bisa lebih dari 24 huruf!\nSilahkan masukan nama baru untuk dealershipmu:", "Set", "Close");
		
		format(DealerData[PlayerData[playerid][pSelecting]][dealerName], 24, inputtext);
		SendServerMessage(playerid, "Kamu berhasil mengubah nama dealership menjadi {FFFF00}%s", DealerData[PlayerData[playerid][pSelecting]][dealerName]);
		Dealer_Save(PlayerData[playerid][pSelecting]);
		Dealer_Refresh(PlayerData[playerid][pSelecting]);

		cmd_dealer(playerid, "menu");
	}
	if(dialogid == DIALOG_DEALER_RESTOCK_AMOUNT)
	{
		if(response)
		{
			new amount = strval(inputtext), id = PlayerData[playerid][pSelecting], list = PlayerData[playerid][pListitem], price;
			if(amount < 1)
				return ShowPlayerDialog(playerid, DIALOG_DEALER_RESTOCK_AMOUNT, DIALOG_STYLE_INPUT, sprintf("%s - %s", ReturnDealerVehicle(DealerData[id][dealerVehicle][list]), ReturnRestockPrice(DealerData[id][dealerCost][list])), "ERROR: Invalid amount!\nPlease input amount for restock the selected vehicle:\nNote: Min 1 - Max 15", "Restock", "Close");
			
			if(DealerData[id][dealerStock][list]+amount > 15)
				return ShowPlayerDialog(playerid, DIALOG_DEALER_RESTOCK_AMOUNT, DIALOG_STYLE_INPUT, sprintf("%s - %s", ReturnDealerVehicle(DealerData[id][dealerVehicle][list]), ReturnRestockPrice(DealerData[id][dealerCost][list])), "ERROR: Total stock cannot more than 15!\nPlease input amount for restock the selected vehicle:\nNote: Min 1 - Max 15", "Restock", "Close");
		
			price = floatround(DealerData[id][dealerCost] * 50 / 100)*amount;

			if(GetMoney(playerid) < price)
				return SendErrorMessage(playerid, "You don't have enough money!");

			DealerData[id][dealerStock][list] += amount;
			GiveMoney(playerid, -price);
			Dealer_Save(id);
			SendServerMessage(playerid, "Kamu telah merestock {FFFF00}%d {FFFFFF}kendaraan dealer dengan harga {00FF00}$%s", amount, FormatNumber(price));
		}
	}
	if(dialogid == DIALOG_DEALER_RESTOCK_LIST)
	{
		if(response)
		{
			new id = PlayerData[playerid][pSelecting];
			if(DealerData[id][dealerVehicle][listitem] == 19300)
				return SendErrorMessage(playerid, "There is no vehicle on selected list!"), cmd_dealer(playerid, "menu");

			ShowPlayerDialog(playerid, DIALOG_DEALER_RESTOCK_AMOUNT, DIALOG_STYLE_INPUT, sprintf("%s - %s", ReturnDealerVehicle(DealerData[id][dealerVehicle][listitem]), ReturnRestockPrice(DealerData[id][dealerCost][listitem])), "Please input amount for restock the selected vehicle:\nNote: Min 1 - Max 15", "Restock", "Close");
			PlayerData[playerid][pListitem] = listitem;
		}
		else
		{
			cmd_dealer(playerid, "menu");
		}
	}
	if(dialogid == DIALOG_DEALER_MENU)
	{
		if(response)
		{
			if(listitem == 0)
			{
				ShowPlayerDialog(playerid, DIALOG_DEALER_SETNAME, DIALOG_STYLE_INPUT, "Dealer Name", "Silahkan masukan nama baru untuk dealershipmu:", "Set", "Close");
			}
			if(listitem == 1)
			{
				new str[512];
				new id = PlayerData[playerid][pSelecting];
				format(str, sizeof(str), "Model\tStock\tPrice\n");
				forex(i, 6)
				{
					format(str, sizeof(str), "%s%s\t%d\t%s / 1\n", str, ReturnDealerVehicle(DealerData[id][dealerVehicle][i]), DealerData[id][dealerStock][i], ReturnRestockPrice(DealerData[id][dealerCost][i]));
				}
				ShowPlayerDialog(playerid, DIALOG_DEALER_RESTOCK_LIST, DIALOG_STYLE_TABLIST_HEADERS, "Restock List", str, "Select", "Close");
			}
			if(listitem == 2)
			{
				new id = PlayerData[playerid][pSelecting];

				if(DealerData[id][dealerVault] < 1)
					return SendErrorMessage(playerid, "There is no money on Dealership Vault!"), cmd_dealer(playerid, "menu");

				GiveMoney(playerid, DealerData[id][dealerVault]);
				SendClientMessageEx(playerid, COLOR_SERVER, "DEALERSHIP: {FFFFFF}You have successfully withdrawn {00FF00}$%s {FFFFFF}from vault!", FormatNumber(DealerData[id][dealerVault]));
				DealerData[id][dealerVault] = 0;
			}
		}
	}
	if(dialogid == DIALOG_EDITDEALER_MODEL)
	{
		if(response)
		{
			if(isnull(inputtext))
				return ShowPlayerDialog(playerid, DIALOG_EDITDEALER_MODEL, DIALOG_STYLE_INPUT, "Vehicle Model", "Silahkan masukan model id atau nama kendaraan:", "Next", "Close");

			new model = GetVehicleModelByName(inputtext), id = PlayerData[playerid][pSelecting], list = PlayerData[playerid][pListitem];

			if(!model)
				return ShowPlayerDialog(playerid, DIALOG_EDITDEALER_MODEL, DIALOG_STYLE_INPUT, "Vehicle Model", "ERROR: Invalid vehicle model!\nSilahkan masukan model id atau nama kendaraan:", "Next", "Close");
		
			forex(i, 6)
			{
				if(DealerData[id][dealerVehicle][i] == model)
					return ShowPlayerDialog(playerid, DIALOG_EDITDEALER_MODEL, DIALOG_STYLE_INPUT, "Vehicle Model", "ERROR: Sudah ada kendaraan dengan model ini pada dealership ini!\nSilahkan masukan model id atau nama kendaraan:", "Next", "Close");
			}
			DealerData[id][dealerVehicle][list] = model;
			ShowPlayerDialog(playerid, DIALOG_EDITDEALER_COST, DIALOG_STYLE_INPUT, "Vehicle Cost", sprintf("Silahkan masukan harga kendaraan untuk '%s'", ReturnVehicleModelName(DealerData[id][dealerVehicle][list])), "Confirm", "Close");
		}
	}
	if(dialogid == DIALOG_EDITDEALER_COST)
	{
		new id = PlayerData[playerid][pSelecting], list = PlayerData[playerid][pListitem];
		if(response)
		{
			if(isnull(inputtext))
				return ShowPlayerDialog(playerid, DIALOG_EDITDEALER_COST, DIALOG_STYLE_INPUT, "Vehicle Cost", sprintf("Silahkan masukan harga kendaraan untuk '%s'", ReturnVehicleModelName(DealerData[id][dealerVehicle][list])), "Confirm", "Close");

			if(strval(inputtext) < 0)
				return ShowPlayerDialog(playerid, DIALOG_EDITDEALER_COST, DIALOG_STYLE_INPUT, "Vehicle Cost", sprintf("Silahkan masukan harga kendaraan untuk '%s'", ReturnVehicleModelName(DealerData[id][dealerVehicle][list])), "Confirm", "Close");

			DealerData[id][dealerCost][list] = strcash(inputtext);
			SendClientMessageEx(playerid, COLOR_SERVER, "AdmCmd: {FFFFFF}Kamu telah mengubah kendaraan menjadi {FFFF00}%s {FFFFFF}dengan harga {00FF00}$%s", ReturnVehicleModelName(DealerData[id][dealerVehicle][list]), FormatNumber(DealerData[id][dealerCost][list]));
			Dealer_Save(id);
		}
		else
		{
			DealerData[id][dealerVehicle] = 19300;
			DealerData[id][dealerCost] = 0;
		}
	}
	if(dialogid == DIALOG_EDITDEALER_SELECT)
	{
		if(response)
		{
			PlayerData[playerid][pListitem] = listitem;
			ShowPlayerDialog(playerid, DIALOG_EDITDEALER_MODEL, DIALOG_STYLE_INPUT, "Vehicle Model", "Silahkan masukan model id atau nama kendaraan:", "Next", "Close");
		}
	}
	if(dialogid == DIALOG_CONTACTNUM)
	{
		if (response)
		{
		    static
				string[256];


			new
			    cn[156];
			format(cn, sizeof(cn), "Contact Name: %s\n\nPlease enter the phone number for this contact:", PlayerData[playerid][pTempContact]);
		    if (isnull(inputtext) || !IsNumeric(inputtext))
		        return ShowPlayerDialog(playerid, DIALOG_CONTACTNUM, DIALOG_STYLE_INPUT, "Contact Number", cn, "Submit", "Back");

			for (new i = 0; i != MAX_CONTACTS; i ++)
			{
				if (!ContactData[playerid][i][contactExists])
				{
	            	ContactData[playerid][i][contactExists] = true;
	            	ContactData[playerid][i][contactNumber] = strval(inputtext);
					ContactData[playerid][i][contactOwner] = PlayerData[playerid][pID];
					format(ContactData[playerid][i][contactName], 32, PlayerData[playerid][pTempContact]);

					mysql_format(sqlcon, string, sizeof(string), "INSERT INTO `contacts` (`ID`, `contactName`, `contactNumber`, `contactOwner`) VALUES('%d', '%s', '%d', '%d')", PlayerData[playerid][pID], PlayerData[playerid][pTempContact], ContactData[playerid][i][contactNumber], PlayerData[playerid][pID]);
					mysql_tquery(sqlcon, string, "OnContactAdd", "dd", playerid, i);

					SendServerMessage(playerid, "You have added \"%s\" to your contacts.", PlayerData[playerid][pTempContact]);
	                return 1;
				}
		    }
		    SendErrorMessage(playerid, "There is no room left for anymore contacts.");
		}
		else
		{
			ShowContacts(playerid);
		}
	}
	if(dialogid == DIALOG_NEWCONTACT)
	{
		if (response)
		{
		    if (isnull(inputtext))
				return ShowPlayerDialog(playerid, DIALOG_NEWCONTACT, DIALOG_STYLE_INPUT, "New Contact", "Please enter the name of the contact below:", "Submit", "Back");

		    if (strlen(inputtext) > 32)
		        return ShowPlayerDialog(playerid, DIALOG_NEWCONTACT, DIALOG_STYLE_INPUT, "New Contact", "Please enter the name of the contact below:", "Submit", "Back");

			format(PlayerData[playerid][pTempContact], 32, inputtext);
			new cn[128];
            format(cn, sizeof(cn), "Contact Name: %s\n\nPlease enter the phone number for this contact:", inputtext);
		    ShowPlayerDialog(playerid, DIALOG_CONTACTNUM, DIALOG_STYLE_INPUT, "Contact Number", cn, "Submit", "Back");
		}
		else
		{
			ShowContacts(playerid);
		}
	}
	if(dialogid == DIALOG_CONTACTINFO)
	{
		if (response)
		{
		    new
				id = PlayerData[playerid][pContact],
				string[72];

			switch (listitem)
			{
			    case 0:
			    {
			        format(string, 16, "%d", ContactData[playerid][id][contactNumber]);
					cmd_call(playerid, string);
			    }
			    case 1:
			    {
			        mysql_format(sqlcon, string, sizeof(string), "DELETE FROM `contacts` WHERE `ID` = '%d' AND `contactID` = '%d'", PlayerData[playerid][pID], ContactData[playerid][id][contactID]);
			        mysql_tquery(sqlcon, string);

			        SendServerMessage(playerid, "You have deleted \"%s\" from your contacts.", ContactData[playerid][id][contactName]);

			        ContactData[playerid][id][contactExists] = false;
			        ContactData[playerid][id][contactNumber] = 0;
			        ContactData[playerid][id][contactID] = 0;
			        ShowContacts(playerid);
			    }
			}
		}
	}
	if(dialogid == DIALOG_CONTACT)
	{
		if (response)
		{
		    if (!listitem)
			{
		        ShowPlayerDialog(playerid, DIALOG_NEWCONTACT, DIALOG_STYLE_INPUT, "New Contact", "Please enter the name of the contact below:", "Submit", "Back");
		    }
		    else
			{
			    PlayerData[playerid][pContact] = ListedContacts[playerid][listitem - 1];

		        ShowPlayerDialog(playerid, DIALOG_CONTACTINFO, DIALOG_STYLE_LIST, ContactData[playerid][PlayerData[playerid][pContact]][contactName], "Call Contact\nDelete Contact", "Select", "Back");
		    }
		}
		for (new i = 0; i != MAX_CONTACTS; i ++)
		{
		    ListedContacts[playerid][i] = -1;
		}
	}
	if(dialogid == DIALOG_DIAL)
	{
		if (response)
		{
		    new
		        string[16];

		    if (isnull(inputtext) || !IsNumeric(inputtext))
		        return ShowPlayerDialog(playerid, DIALOG_DIAL, DIALOG_STYLE_INPUT, "Dial Number", "Please enter the number that you wish to dial below:", "Dial", "Back");

	        format(string, 16, "%d", strval(inputtext));
			cmd_call(playerid, string);
		}
	}
	if(dialogid == DIALOG_SMS)
	{
		if (response)
		{
		    new number = strval(inputtext);

		    if (isnull(inputtext) || !IsNumeric(inputtext))
		        return ShowPlayerDialog(playerid, DIALOG_SMS, DIALOG_STYLE_INPUT, "Send Text Message", "Please enter the number that you wish to send a text message to:", "Dial", "Back");

	        if (GetNumberOwner(number) == INVALID_PLAYER_ID)
	            return ShowPlayerDialog(playerid, DIALOG_SMS, DIALOG_STYLE_INPUT, "Send Text Message", "Error: That number is not online right now.\n\nPlease enter the number that you wish to send a text message to:", "Dial", "Back");

			PlayerData[playerid][pContact] = GetNumberOwner(number);
			ShowPlayerDialog(playerid, DIALOG_SMSNUM, DIALOG_STYLE_INPUT, "Text Message", "Please enter the message to send:", "Send", "Back");
		}
	}
	if(dialogid == DIALOG_SMSNUM)
	{
		if (response)
		{
			if (isnull(inputtext))
				return ShowPlayerDialog(playerid, DIALOG_SMSNUM, DIALOG_STYLE_INPUT, "Text Message", "Error: Please enter a message to send.\n\nPlease enter the message to send:", "Send", "Back");

			new targetid = PlayerData[playerid][pContact];

			if (!IsPlayerConnected(targetid) || !PlayerHasItem(playerid, "Cellphone") || PlayerData[targetid][pPhoneOff])
			    return SendErrorMessage(playerid, "The specified phone number went offline.");
		    
		    if(strlen(inputtext) > 32)
		    	return SendErrorMessage(playerid, "Text tidak bisa lebih dari 32 karakter!");

		    if(PlayerData[playerid][pCredit] < 1)
		    	return SendErrorMessage(playerid, "Kamu tidak memiliki phone credits!");

			PlayerData[playerid][pCredit]--;

			SendClientMessageEx(targetid, COLOR_YELLOW, "SMS: {FFFFFF}Message From {FF0000}#%d", PlayerData[playerid][pPhoneNumber]);
			SendClientMessageEx(targetid, COLOR_YELLOW, "MESSAGE: {FFFFFF}%s", inputtext);
			SendClientMessageEx(playerid, COLOR_YELLOW, "SMS: {FFFFFF}Message sended to {FF0000}#%d", PlayerData[targetid][pPhoneNumber]);
			SendClientMessageEx(playerid, COLOR_YELLOW, "MESSAGE: {FFFFFF}%s", inputtext);
			
			SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s takes out their phone and sends a text.", ReturnName(playerid));
		}
		else
		{
	        ShowPlayerDialog(playerid, DIALOG_SMS, DIALOG_STYLE_INPUT, "Send Text Message", "Please enter the number that you wish to send a text message to:", "Submit", "Back");
		}
	}
	if(dialogid == DIALOG_SAM_LOGIN_USERNAME)
	{
		if(response)
		{

			if(isnull(inputtext))
				return ShowPlayerDialog(playerid, DIALOG_SAM_LOGIN_USERNAME, DIALOG_STYLE_INPUT, "SA-M | Login", "ERROR: Username tidak terdaftar!\nSilahkan masukan username yang akan anda gunakan:", "Next", "Close");
		
			new query[128];
			mysql_format(sqlcon, query, 128, "SELECT * FROM `samacc` WHERE `Username` = '%s' LIMIT 1", inputtext);
			mysql_query(sqlcon, query, true);
			if(!cache_num_rows())
				return ShowPlayerDialog(playerid, DIALOG_SAM_LOGIN_USERNAME, DIALOG_STYLE_INPUT, "SA-M | Login", "ERROR: Username tidak terdaftar!\nSilahkan masukan username yang akan anda gunakan:", "Next", "Close");
		
			foreach(new i : Player) if(PlayerMedia[i][samLogged] && !strcmp(PlayerMedia[i][samName], inputtext, true))
			{
				ShowPlayerDialog(playerid, DIALOG_SAM_LOGIN_USERNAME, DIALOG_STYLE_INPUT, "SA-M | Login", "ERROR: Username ini sedang digunakan oleh pengguna lain!\nSilahkan masukan username yang akan anda gunakan:", "Next", "Close");
				return 1;
			}
			format(PlayerMedia[playerid][samName], MAX_PLAYER_NAME, inputtext);
			ShowPlayerDialog(playerid, DIALOG_SAM_LOGIN_PASSWORD, DIALOG_STYLE_PASSWORD, "SA-M | Login", sprintf("Silahkan masukkan password untuk account '%s'", PlayerMedia[playerid][samName]), "Login", "Close");
		}
		else
		{
			cmd_phone(playerid, "");
		}
	}
	if(dialogid == DIALOG_SAM_LOGIN_PASSWORD)
	{
		if(response)
		{
			if(isnull(inputtext))
				return ShowPlayerDialog(playerid, DIALOG_SAM_LOGIN_PASSWORD, DIALOG_STYLE_PASSWORD, "SA-M | Login", sprintf("Silahkan masukkan password untuk account '%s'", PlayerMedia[playerid][samName]), "Login", "Close");


			new query[128], password[64];
			mysql_format(sqlcon, query, 128, "SELECT * FROM `samacc` WHERE `Username` = '%s' LIMIT 1", PlayerMedia[playerid][samName]);
			mysql_query(sqlcon, query, true);
			if(cache_num_rows())
			{
				cache_get_value_name(0, "Password", password);
				if(!strcmp(password, inputtext, true))
				{
					SendClientMessageEx(playerid, COLOR_SERVER, "* {FFFFFF}Kamu berhasil log-in ke account San Andreas Media ({FFFF00}%s{FFFFFF})", PlayerMedia[playerid][samName]);
					cmd_phone(playerid, "");
					PlayerMedia[playerid][samLogged] = true;
				}
				else
				{
					ShowPlayerDialog(playerid, DIALOG_SAM_LOGIN_PASSWORD, DIALOG_STYLE_PASSWORD, "SA-M | Login", sprintf("ERROR: Password salah!\nSilahkan masukkan password untuk account '%s'", PlayerMedia[playerid][samName]), "Login", "Close");
				}
			}
		}
		else
		{
			format(PlayerMedia[playerid][samName], MAX_PLAYER_NAME, "");
			cmd_phone(playerid, "");
		}
	}
	if(dialogid == DIALOG_SAM_REGISTER_PASSWORD)
	{
		if(response)
		{
			if(isnull(inputtext))
				return ShowPlayerDialog(playerid, DIALOG_SAM_REGISTER_PASSWORD, DIALOG_STYLE_INPUT, "SA-M | Register", sprintf("Silahkan buat password untuk akun '%s'", PlayerMedia[playerid][samName]), "Register", "Close");

			if(strlen(inputtext) < 8 || strlen(inputtext) > 32)
				return ShowPlayerDialog(playerid, DIALOG_SAM_REGISTER_PASSWORD, DIALOG_STYLE_INPUT, "SA-M | Register", sprintf("ERROR: Tidak bisa kurang dari 8 atau lebih dari 32 karakter!\nSilahkan buat password untuk akun '%s'", PlayerMedia[playerid][samName]), "Register", "Close");
		
			new query[187];
			mysql_format(sqlcon, query, 187, "INSERT INTO `samacc` (`Username`, `Password`, `Created`) VALUES ('%s', '%s', '%d')", PlayerMedia[playerid][samName], inputtext, 1);
			mysql_query(sqlcon, query, true);

			PlayerMedia[playerid][samLogged] = true;
			SendClientMessageEx(playerid, COLOR_SERVER, "* {FFFFFF}Kamu berhasil register dan login ke San Andreas Media ({FFFF00}%s{FFFFFF})", PlayerMedia[playerid][samName]);
			cmd_phone(playerid, "");
		}
		else
		{
			format(PlayerMedia[playerid][samName], MAX_PLAYER_NAME, "");
			cmd_phone(playerid, "");
		}
	}
	if(dialogid == DIALOG_SAM_REGISTER_USERNAME)
	{
		if(response)
		{
			if(isnull(inputtext))
				return ShowPlayerDialog(playerid, DIALOG_SAM_REGISTER_USERNAME, DIALOG_STYLE_INPUT, "SA-M | Register", "Silahkan masukan username untuk membuat akun San Andreas Media:", "Next", "Close");

			if(strlen(inputtext) < 3 || strlen(inputtext) > 24)
				return ShowPlayerDialog(playerid, DIALOG_SAM_REGISTER_USERNAME, DIALOG_STYLE_INPUT, "SA-M | Register", "ERROR: Username tidak kurang dari 3 atau lebih dari 24 karakter!\nSilahkan masukan username untuk membuat akun San Andreas Media:", "Next", "Close");
		

			new query[128];
			mysql_format(sqlcon, query, 128, "SELECT * FROM `samacc` WHERE `Username` = '%s'", inputtext);
			mysql_query(sqlcon, query, true);
			if(cache_num_rows())
				return ShowPlayerDialog(playerid, DIALOG_SAM_REGISTER_USERNAME, DIALOG_STYLE_INPUT, "SA-M | Register", "ERROR: Username ini sudah terdaftar di database!\nSilahkan masukan username untuk membuat akun San Andreas Media:", "Next", "Close");
		

			format(PlayerMedia[playerid][samName], MAX_PLAYER_NAME, inputtext);
			ShowPlayerDialog(playerid, DIALOG_SAM_REGISTER_PASSWORD, DIALOG_STYLE_INPUT, "SA-M | Register", sprintf("Silahkan buat password untuk akun '%s'", PlayerMedia[playerid][samName]), "Register", "Close");
		}
		else
		{
			cmd_phone(playerid, "");
		}
	}
	if(dialogid == DIALOG_SAM)
	{
		if(response)
		{
			if(PlayerMedia[playerid][samLogged])
			{

			}
			else
			{
				if(listitem == 0)
				{
					ShowPlayerDialog(playerid, DIALOG_SAM_LOGIN_USERNAME, DIALOG_STYLE_INPUT, "SA-M | Login", "Silahkan masukan username yang akan anda gunakan:", "Next", "Close");
				}
				if(listitem == 1)
				{
					ShowPlayerDialog(playerid, DIALOG_SAM_REGISTER_USERNAME, DIALOG_STYLE_INPUT, "SA-M | Register", "Silahkan masukan username untuk membuat akun San Andreas Media:", "Next", "Close");
				}
			}
		}
		else
		{
			cmd_phone(playerid, "");
		}
	}
	if(dialogid == DIALOG_PHONE)
	{
		if(response)
		{
			if(listitem == 0 || listitem == 1)
			{
				cmd_phone(playerid, "");
			}
			if(listitem == 2)
			{
		        if (PlayerData[playerid][pPhoneOff])
		            return SendErrorMessage(playerid, "Your phone must be powered on.");                            

				ShowPlayerDialog(playerid, DIALOG_DIAL, DIALOG_STYLE_INPUT, "Dial Number", "Please enter the number that you wish to dial below:", "Call", "Back");				
			}
			if(listitem == 3)
			{
			    if (PlayerData[playerid][pPhoneOff])
		            return SendErrorMessage(playerid, "Your phone must be powered on.");

			    ShowContacts(playerid);
			}
			if(listitem == 4)
			{
		        if (PlayerData[playerid][pPhoneOff])
		            return SendErrorMessage(playerid, "Your phone must be powered on.");

				if(!HasPhoneSignal(playerid))
					return SendErrorMessage(playerid, "Signal Service is unreachable on your location.");

				ShowPlayerDialog(playerid, DIALOG_SMS, DIALOG_STYLE_INPUT, "Send Text Message", "Please enter the number that you wish to send a text message to:", "Send", "Back");
			}
			if(listitem == 5)
			{
		        if (PlayerData[playerid][pPhoneOff])
		            return SendErrorMessage(playerid, "Your phone must be powered on.");

				Advert_Show(playerid);
			}
			if(listitem == 6)
			{
				if(PlayerData[playerid][pAdmin] < 7)
					return SendServerMessage(playerid, "This feature is coming soon!");

		        if (PlayerData[playerid][pPhoneOff])
		            return SendErrorMessage(playerid, "Your phone must be powered on.");

				if(PlayerMedia[playerid][samLogged])
				{
					ShowPlayerDialog(playerid, DIALOG_SAM, DIALOG_STYLE_LIST, "San Andreas Media", "My Profile\n{AFAFAF}View Timeline\n{FFFFFF}Create Post\n{AFAFAF}Direct Message\n{FFFFFF}Logout", "Select", "Close");
				}
				else
				{
					ShowPlayerDialog(playerid, DIALOG_SAM, DIALOG_STYLE_LIST, "San Andreas Media", "Login Account\n{AFAFAF}Register Account", "Select", "Close");
				}
			}
			if(listitem == 7)
			{
			    if (!PlayerData[playerid][pPhoneOff])
			    {
           			if (PlayerData[playerid][pCallLine] != INVALID_PLAYER_ID)
				   	{
			        	CancelCall(playerid);
					}
					PlayerData[playerid][pPhoneOff] = true;
			        SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s has powered off their cellphone.", ReturnName(playerid));
				}
				else
				{
				    PlayerData[playerid][pPhoneOff] = false;
			        SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s has powered on their cellphone.", ReturnName(playerid));
				}
			}
		}
	}
	if(dialogid == DIALOG_NUMBERPHONE)
	{
		if(response)
		{
			if(listitem == 5)
			{
				ShowNumberIndex(playerid);
				SendServerMessage(playerid, "Number list refreshed.");
			}
			else
			{
				new bid = PlayerData[playerid][pInBiz];
				new price = BizData[bid][bizProduct][0];
				new prodname[34];
				prodname = ProductName[bid][0];

				PlayerData[playerid][pPhoneNumber] = NumberIndex[playerid][listitem];
				SendServerMessage(playerid, "Your new phone number is {FFFF00}#%d", NumberIndex[playerid][listitem]);
				GiveMoney(playerid, -price);
				BizData[bid][bizStock]--;
				BizData[bid][bizVault] += price;
				if(Inventory_Count(playerid, "Cellphone") < 1)
				{
					Inventory_Add(playerid, "Cellphone", 18867, 1);
					SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s has paid $%s and purchased a %s.", ReturnName(playerid), FormatNumber(price), prodname);
				}
			}
		}
		else
		{
			cmd_buy(playerid, "");
		}
	}
	if(dialogid == DIALOG_BUYPLATE)
	{
		new count;
		if(response)
		{
			foreach(new i : PlayerVehicle)
			{
				if(Vehicle_IsOwner(playerid, i) && !strcmp(VehicleData[i][vPlate], "NONE", true) && count++ == listitem)
				{
					if(GetMoney(playerid) < 15000)
						return SendErrorMessage(playerid, "You don't have enough money!");

					#define randex(%0,%1) (random(%1 - %0 + 1) + %0)
					format(VehicleData[i][vPlate], 16, "%c%c%c%c%c%c%c", randex('1', '9'), randex('A', 'Z'), randex('A', 'Z'), randex('A', 'Z'), randex('1', '9'), randex('1', '9'), randex('1', '9'));
					SendClientMessageEx(playerid, COLOR_SERVER, "VEHICLE: {FFFFFF}You have successfully purchasing plate for your {FFFF00}%s", ReturnVehicleModelName(VehicleData[i][vModel]));
					GiveMoney(playerid, -15000);

					if(IsValidVehicle(VehicleData[i][vVehicle]))
					{
						SetVehicleNumberPlate(VehicleData[i][vVehicle], VehicleData[i][vPlate]);
					}

				}
			}
		}
	}
	if(dialogid == DIALOG_TREATMENT)
	{
		if(response)
		{
			new targetid = PlayerData[playerid][pTargetid];

			if(!IsPlayerNearPlayer(playerid, targetid, 5.0) || targetid == INVALID_PLAYER_ID)
				return SendErrorMessage(playerid, "You must close to that player!");

			if(listitem == 0)
			{
				if(!PlayerData[targetid][pInjured])
					return SendErrorMessage(playerid, "That player is not in injured condition!");

				PlayerData[targetid][pInjured] = false;
				ClearAnimations(targetid, 1);
				SendServerMessage(playerid, "You have been reviving {FFFF00}%s", ReturnName(targetid));
				SendServerMessage(targetid, "You have been revived by {FFFF00}%s", ReturnName(playerid));

				if(IsValidDynamic3DTextLabel(PlayerData[targetid][pInjuredLabel]))
					DestroyDynamic3DTextLabel(PlayerData[targetid][pInjuredLabel]);
			}
			if(listitem == 1)
			{
				new Float:hp;
				GetPlayerHealth(targetid, hp);
				if(hp >= 100.0)
					return SendErrorMessage(playerid, "That player already have Max Health!");

				SetPlayerHealth(targetid, 100.0);
				SendServerMessage(playerid, "You have healing {FFFF00}%s", ReturnName(targetid));
				SendServerMessage(playerid, "You have been healed by {FFFF00}%s", ReturnName(playerid));
			}
			if(listitem == 2)
			{
				if(PlayerData[targetid][pHealthy] >= 80.0)
					return SendErrorMessage(playerid, "That player is not in unhealthy condition!");

				PlayerData[targetid][pHealthy] = 100.0;
				SendServerMessage(playerid, "You have cure {FFFF00}%s", ReturnName(targetid));
				SendServerMessage(targetid, "You have been cured by {FFFF00}%s", ReturnName(playerid));
			}
			if(listitem == 3)
			{
				forex(i, 7)
				{
					PlayerData[targetid][pDamages][i] = 100.0;
					PlayerData[targetid][pBullets][i] = 0;
				}
				SendServerMessage(playerid, "You have operating {FFFF00}%s", ReturnName(targetid));
				SendServerMessage(targetid, "You have been operated by {FFFF00}%s", ReturnName(playerid));
			}
		}
	}
	if(dialogid == DIALOG_MDC_RETURN)
	{
		PlayerPlayNearbySound(playerid, MDC_SELECT);
		ShowMDC(playerid);
	}
	if(dialogid == DIALOG_MDC_911_MENU)
	{
		if(response)
		{
			new id = PlayerData[playerid][pListitem];
			PlayerPlayNearbySound(playerid, MDC_SELECT);
			if(listitem == 0)
			{
				ShowEmergencyDetails(playerid, id);
			}
			if(listitem == 1)
			{
				SendFactionMessage(PlayerData[playerid][pFaction], COLOR_RADIO, "[911] %s %s is now responding 911 report with problem %s", Faction_GetRank(playerid), ReturnName(playerid), GetProblemType(EmergencyData[id][emgSector], EmergencyData[id][emgType]));
				SendClientMessageEx(playerid, COLOR_RADIO, "[MDC] {FFFFFF}You have respond to emergency call with problem {FFFF00}%s", GetProblemType(EmergencyData[id][emgSector], EmergencyData[id][emgType]));
				SendClientMessageEx(playerid, COLOR_RADIO, "[MDC] {FFFFFF}Location: %s | Name: %s | Number: %d", EmergencyData[id][emgLocation], EmergencyData[id][emgIssuerName], EmergencyData[id][emgNumber]);
				Emergency_Delete(id);
			}
			if(listitem == 2)
			{
				SendClientMessageEx(playerid, COLOR_RADIO, "[MDC] {FFFFFF}Successfully remove selected emergency call.");
				Emergency_Delete(id);
			}
		}
		else
		{
			ShowMDC(playerid);
			PlayerPlayNearbySound(playerid, MDC_SELECT);
		}
	}
	if(dialogid == DIALOG_MDC_911)
	{
		if(response)
		{
			new count;
			PlayerPlayNearbySound(playerid, MDC_SELECT);
			forex(i, MAX_EMERGENCY) if(EmergencyData[i][emgExists])
			{
				if(EmergencyData[i][emgSector] == ReturnSector(playerid) && count++ == listitem)
				{
					PlayerData[playerid][pListitem] = i;
					ShowPlayerDialog(playerid, DIALOG_MDC_911_MENU, DIALOG_STYLE_LIST, "MDC - 911 Menu", "Show Details\nRespond Report\nRemove Report", "Select", "Return");
				}		
			}	
		}
		else
		{
			ShowMDC(playerid);
			PlayerPlayNearbySound(playerid, MDC_SELECT);
		}
	}
	if(dialogid == DIALOG_MDC_PLATE)
	{
		if(response)
		{
			if(!strcmp(inputtext, "NONE", true) || !strcmp(inputtext, "RENTAL", true))
				return ShowPlayerDialog(playerid, DIALOG_MDC_PLATE, DIALOG_STYLE_INPUT, "MDC - Plate Search", "ERROR: Can't found vehicle with specified number plate!\nPlease input the full vehicle plate you wish to search:", "Search", "Return");
			
			new found = 0;
			new str[512];
			new date[6];
			format(str, sizeof(str), "Last Location\tTime\n");
			forex(i, MAX_SPEEDCAM) if(SpeedData[i][speedExists])
			{
				if(!strcmp(SpeedData[i][speedPlate], inputtext, true))
				{
					found++;
					TimestampToDate(SpeedData[i][speedTime], date[2], date[1], date[0], date[3], date[4], date[5]);
					format(str, sizeof(str), "%s%s\t%i/%02d/%02d %02d:%02d\n", str, GetLocation(SpeedData[i][speedPos][0], SpeedData[i][speedPos][1], SpeedData[i][speedPos][2]), date[2], date[0], date[1], date[3], date[4]);
				}
			}
			if(found)
				ShowPlayerDialog(playerid, DIALOG_MDC_RETURN, DIALOG_STYLE_TABLIST_HEADERS, "MDC - Plate Search", str, "Return", "");
			else
				ShowPlayerDialog(playerid, DIALOG_MDC_RETURN, DIALOG_STYLE_MSGBOX, "MDC - Error", "There is no SpeedTrap last vehicle matching with the plate.", "Return", "Close");
		}
		else
		{
			PlayerPlayNearbySound(playerid, MDC_SELECT);
			ShowMDC(playerid);
		}
	}
	if(dialogid == DIALOG_MDC)
	{
		if(response)
		{
			PlayerPlayNearbySound(playerid, MDC_SELECT);
			if(listitem == 0)
			{
				ShowEmergency(playerid);
			}
			if(listitem == 1)
			{
				ShowPlayerDialog(playerid, DIALOG_MDC_PLATE, DIALOG_STYLE_INPUT, "MDC - Plate Search", "Please input the full vehicle plate you wish to search:", "Search", "Return");
			}
		}
		else
		{
			PlayerPlayNearbySound(playerid, MDC_ERROR);
			SetPlayerChatBubble(playerid, "* logs off of the Mobile Data Computer *", COLOR_PURPLE, 15, 10000);
		}
	}
	if(dialogid == DIALOG_CALL_911)
	{
		if(response)
		{
			ServiceType[playerid] = listitem;
			if(ServiceIndex[playerid] == 1) ServiceIndex[playerid] = 2; SendClientMessage(playerid, 0x1394BFFF, "911 Dispatch: OK, Tell us more about what's going on.");
		}
		else
		{
			ServiceIndex[playerid] = 0;
			ServiceRequest[playerid] = 0;
			SendClientMessage(playerid, 0x1394BFFF, "911 Dispatch: Alright we will cancel our units. Thank you.");
		    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		    RemovePlayerAttachedObject(playerid, 3);
		}
	}
	if(dialogid == DIALOG_BUS)
	{
		if(response)
		{
			SetPlayerRaceCheckpoint(playerid, 0,1545.3209,-2253.3459,13.6472, 1578.6227,-2282.6621,13.4325, 5.0);
			OnBus[playerid] = true;
			BusIndex[playerid] = 1;
			SwitchVehicleEngine(GetPlayerVehicleID(playerid), true);
			SendClientMessage(playerid, COLOR_SERVER, "SIDEJOB: {FFFFFF}Ikuti semua checkpoint yang ada di radar.");
		}
		else
		{
			RemovePlayerFromVehicle(playerid);
		}
	}
	if(dialogid == DIALOG_SWEEPER)
	{
		if(response)
		{
	     	OnSweeping[playerid] = true;
	     	SweeperIndex[playerid] = 0;
			SendClientMessage(playerid, COLOR_SERVER, "SIDEJOB: {FFFFFF}Ikuti semua checkpoint yang ada di radar.");
			SetPlayerCheckpoint(playerid, SweeperPoint[SweeperIndex[playerid]][0], SweeperPoint[SweeperIndex[playerid]][1], SweeperPoint[SweeperIndex[playerid]][2], 4.0);
			SwitchVehicleEngine(GetPlayerVehicleID(playerid), true);
		}
		else
		{
			RemovePlayerFromVehicle(playerid);
		}
	}
	if(dialogid == DIALOG_HELP_RETURN)
	{
		cmd_help(playerid, "");
	}
	if(dialogid == DIALOG_HELP_JOB)//list, place, buy, sell, remove
	{
		new string[1412];
		if(response)
		{
			if(listitem == 0)
			{
				strcat(string, "/cargo buy - untuk membeli cargo di Cargo Buypoint\n");
				strcat(string, "/cargo list - untuk melihat list cargo yang ada di Truck\n");
				strcat(string, "/cargo place - untuk menyimpan cargo ke Truck\n");
				strcat(string, "/cargo sell - untuk menjual cargo ke Business\n");
				strcat(string, "/cargo remove - untuk membuang cargo\n");
				strcat(string, "\nNote: Hanya truck Benson dan Yankee untuk pekerjaan ini.");
				ShowPlayerDialog(playerid, DIALOG_HELP_RETURN, DIALOG_STYLE_MSGBOX, "Trucker", string, "Back", "");
			}
			if(listitem == 1)
			{
				strcat(string, "/mech duty - untuk Onduty sebagai Mechanic\n");
				strcat(string, "/mech menu - untuk membuka menu kendaraan\n");
				strcat(string, "\nNote: Command diatas hanya bisa diakses di Mechanic Center.");
				ShowPlayerDialog(playerid, DIALOG_HELP_RETURN, DIALOG_STYLE_MSGBOX, "Mechanic", string, "Back", "");
			}
			if(listitem == 2)
			{
				strcat(string, "/taxi duty - untuk Onduty sebagai Taxi Driver\n");
				strcat(string, "/taxi setfare - untuk mengubah Fare taxi\n");
				strcat(string, "\nNote: Command diatas hanya bisa diakses di dalam Taxi.");
				ShowPlayerDialog(playerid, DIALOG_HELP_RETURN, DIALOG_STYLE_MSGBOX, "Mechanic", string, "Back", "");				
			}
			if(listitem == 3)
			{
				strcat(string, "/selltimber - untuk menjual Timber yang ada di kendaraan\n");
				strcat(string, "- Key 'H' didekat pohon yang belum ditebang untuk mulai menebang\n");
				strcat(string, "- Key 'H' didekat pohon yang sudah ditebang untuk meload timber\n");
				ShowPlayerDialog(playerid, DIALOG_HELP_RETURN, DIALOG_STYLE_MSGBOX, "Lumberjack", string, "Back", "");
			}
		}
	}
	if(dialogid == DIALOG_HELP)
	{
		new string[1412];
		if(response)
		{
			if(listitem == 0)
			{
				strcat(string, "/phone | /salary | /insu | /weapon | /takejob | /quitjob | /renthelp | /call | /accept | /animlist\n");
				strcat(string, "/pay | /buy | /refuel | /inventory | /enter | /jobdelay | /report | /ask | /sms | /myproperty \n");
				strcat(string, "/health [opt:playerid/name] | /mask | /atm | /stats | /drag | /undrag | /frisk | /factions\n");
				strcat(string, "/tempdamage [opt:playerid/PartOfName] | /setfreq | /pr | /disablecp | /licenses [opt:playerid/PartOfName]\n");
				strcat(string, "/v(ehicle) | /seatbelt | /isafk | /clearchat | /fish | /sellfish | /myfish | /buybait | /toggle\n");
				strcat(string, "/tag | /cursor | /hidebuy | /tog(gle) | /warnings\n");
				ShowPlayerDialog(playerid, DIALOG_HELP_RETURN, DIALOG_STYLE_MSGBOX, "General Commands", string, "Back", "");
			}
			if(listitem == 1)
			{
				strcat(string, "/me | /ame | /pr | /do | /l(ow) | /w(hisper) | /o | /c | /pm");
				ShowPlayerDialog(playerid, DIALOG_HELP_RETURN, DIALOG_STYLE_MSGBOX, "Chat Commands", string, "Back", "");
			}
			if(listitem == 2)
			{
				ShowPlayerDialog(playerid, DIALOG_HELP_JOB, DIALOG_STYLE_LIST, "Job Commands", "Trucker\nMechanic\nTaxi\nLumberjack", "Select", "Close");
			}
			if(listitem == 3)
			{
				strcat(string, "/faction [invite/kick/menu/accept/locker/setrank/quit]\n");
				strcat(string, "/r | /or | /d | /od\n");
				if(GetFactionType(playerid) == FACTION_POLICE)
				{
					strcat(string, "/mdc | /arrest | /detain | /cuff | /uncuff | /impound | /seizeweed | /m(egaphone)\n");
					strcat(string, "/take | /callsign | /spike | /tazer | /backup\n");
				}
				else if(GetFactionType(playerid) == FACTION_MEDIC)
				{
					strcat(string, "/mdc | /treatment | /m(egaphone) | /stretcher");
				}
				else if(GetFactionType(playerid) == FACTION_NEWS)
				{
					strcat(string, "/live | /guest [invite/remove]");
				}
				else if(GetFactionType(playerid) == FACTION_GOV)
				{
					strcat(string, "/tax [set/withdraw/deposit]");
				}
				ShowPlayerDialog(playerid, DIALOG_HELP_RETURN, DIALOG_STYLE_MSGBOX, "Faction Commands", string, "Back", "");
			}
			if(listitem == 4)
			{
				strcat(string, "/biz buy - untuk membeli Business\n");
				strcat(string, "/biz menu - untuk membuka menu Business (for owner)\n");
				strcat(string, "/biz lock - untuk toggle lock/unlock Business\n");
				strcat(string, "/biz reqstock - untuk meminta restock kepada Trucker\n");
				strcat(string, "/biz convertfuel - untuk merestock Fuel stock (24/7 only)\n");
				ShowPlayerDialog(playerid, DIALOG_HELP_RETURN, DIALOG_STYLE_MSGBOX, "Business Commands", string, "Back", "");

			}
			if(listitem == 5)
			{
				strcat(string, "/house buy - untuk membeli house\n");
				strcat(string, "/house lock - untuk toggle lock/unlock House\n");
				strcat(string, "/house menu - untuk membuka House Menu\n");
				ShowPlayerDialog(playerid, DIALOG_HELP_RETURN, DIALOG_STYLE_MSGBOX, "House Commands", string, "Back", "");
			}
			if(listitem == 6)
			{
				strcat(string, "/withdraw - untuk menarik uang dari Bank\n");
				strcat(string, "/deposit - untuk menyimpan uang ke Bank\n");
				strcat(string, "/paycheck - untuk mencairkan salary\n");
				strcat(string, "/balance - untuk melihat total uang di Bank\n");
				strcat(string, "/transfer - untuk men-transfer uang ke player lain\n");
				strcat(string, "\nNote: Command diatas hanya bisa dilakukan di Bank Point.");
				ShowPlayerDialog(playerid, DIALOG_HELP_RETURN, DIALOG_STYLE_MSGBOX, "Bank Commands", string, "Back", "");
			}
			if(listitem == 7)
			{
				strcat(string, "/dealer buy - untuk membeli dealership\n");
				strcat(string, "/dealer buyvehicle - untuk membeli kendaraan\n");
				strcat(string, "/dealer menu - untuk membuka Dealership menu\n");
				ShowPlayerDialog(playerid, DIALOG_HELP_RETURN, DIALOG_STYLE_MSGBOX, "Dealership Commands", string, "Back", "");
			}
		}
	}
	if(dialogid == DIALOG_BIRTHDATE)
	{
		if (response)
		{
		    new
				iDay,
				iMonth,
				iYear;

		    new const
		        arrMonthDays[] = {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

		    if (sscanf(inputtext, "p</>ddd", iDay, iMonth, iYear)) {
		        ShowPlayerDialog(playerid, DIALOG_BIRTHDATE, DIALOG_STYLE_INPUT, "Date of Birth", "Error: Invalid format specified!\n\nPlease enter your date of birth below (DD/MM/YYYY):", "Submit", "Cancel");
			}
			else if (iYear < 1900 || iYear > 2014) {
			    ShowPlayerDialog(playerid, DIALOG_BIRTHDATE, DIALOG_STYLE_INPUT, "Date of Birth", "Error: Invalid year specified!\n\nPlease enter your date of birth below (DD/MM/YYYY):", "Submit", "Cancel");
			}
			else if (iMonth < 1 || iMonth > 12) {
			    ShowPlayerDialog(playerid, DIALOG_BIRTHDATE, DIALOG_STYLE_INPUT, "Date of Birth", "Error: Invalid month specified!\n\nPlease enter your date of birth below (DD/MM/YYYY):", "Submit", "Cancel");
			}
			else if (iDay < 1 || iDay > arrMonthDays[iMonth - 1]) {
			    ShowPlayerDialog(playerid, DIALOG_BIRTHDATE, DIALOG_STYLE_INPUT, "Date of Birth", "Error: Invalid day specified!\n\nPlease enter your date of birth below (DD/MM/YYYY):", "Submit", "Cancel");
			}
			else 
			{
			    format(PlayerData[playerid][pBirthdate], 24, inputtext);


			    PlayerTextDrawSetString(playerid, BIRTHDATETD[playerid], sprintf("%s", PlayerData[playerid][pBirthdate]));
			    SelectTextDraw(playerid, COLOR_YELLOW);
			}
		}
		else
		{
			SelectTextDraw(playerid, COLOR_YELLOW);
		}
	}
	if(dialogid == DIALOG_EDITLOCKER_SKIN_MODEL)
	{
		if (response)
		{
		    new skin = strval(inputtext);

		    if (isnull(inputtext))
		        return  ShowPlayerDialog(playerid, DIALOG_EDITLOCKER_SKIN_MODEL, DIALOG_STYLE_INPUT, "Add by Model ID", "Please enter the model ID of the skin below (0-311):", "Add", "Cancel");

			if (skin < 0 || skin > 311)
			    return ShowPlayerDialog(playerid, DIALOG_EDITLOCKER_SKIN_MODEL, DIALOG_STYLE_INPUT, "Add by Model ID", "Please enter the model ID of the skin below (0-311):", "Add", "Cancel");

	        FactionData[PlayerData[playerid][pFactionEdit]][factionSkins][PlayerData[playerid][pSelectedSlot]] = skin;
			Faction_Save(PlayerData[playerid][pFactionEdit]);

			if (skin) {
			    SendServerMessage(playerid, "You have set the skin ID in slot %d to %d.", PlayerData[playerid][pSelectedSlot] + 1, skin);
			}
			else {
			    SendServerMessage(playerid, "You have removed the skin ID in slot %d.", PlayerData[playerid][pSelectedSlot] + 1);
			}
		}
	}
	if(dialogid == DIALOG_EDITLOCKER_SKIN)
	{
		if (response)
		{
		    static
		        skins[299];

			switch (listitem)
			{
			    case 0:
			        ShowPlayerDialog(playerid, DIALOG_EDITLOCKER_SKIN_MODEL, DIALOG_STYLE_INPUT, "Add by Model ID", "Please enter the model ID of the skin below (0-311):", "Add", "Cancel");

				case 1:
				{
				    for (new i = 0; i < sizeof(skins); i ++)
				        skins[i] = i + 1;

					ShowModelSelectionMenu(playerid, "Add Skin", MODEL_SELECTION_ADD_SKIN, skins, sizeof(skins), -16.0, 0.0, -55.0);
				}
				case 2:
				{
				    FactionData[PlayerData[playerid][pFactionEdit]][factionSkins][PlayerData[playerid][pSelectedSlot]] = 0;

				    Faction_Save(PlayerData[playerid][pFactionEdit]);
				    SendServerMessage(playerid, "You have removed the skin ID in slot %d.", PlayerData[playerid][pSelectedSlot] + 1);
				}
			}
		}
	}
	if(dialogid == DIALOG_EDITLOCKER)
	{
		if (response)
		{
		    switch (listitem)
		    {
		        case 0:
		        {
				    new
				        Float:x,
				        Float:y,
				        Float:z;

					GetPlayerPos(playerid, x, y, z);

					FactionData[PlayerData[playerid][pFactionEdit]][factionLockerPos][0] = x;
					FactionData[PlayerData[playerid][pFactionEdit]][factionLockerPos][1] = y;
					FactionData[PlayerData[playerid][pFactionEdit]][factionLockerPos][2] = z;

					FactionData[PlayerData[playerid][pFactionEdit]][factionLockerInt] = GetPlayerInterior(playerid);
					FactionData[PlayerData[playerid][pFactionEdit]][factionLockerWorld] = GetPlayerVirtualWorld(playerid);

					Faction_Refresh(PlayerData[playerid][pFactionEdit]);
					Faction_Save(PlayerData[playerid][pFactionEdit]);
					SendServerMessage(playerid, "You have adjusted the locker position of faction ID: %d.", PlayerData[playerid][pFactionEdit]);
				}
				case 1:
				{
					new
					    string[512];

					string[0] = 0;

				    for (new i = 0; i < 10; i ++)
					{
				        if (FactionData[PlayerData[playerid][pFactionEdit]][factionWeapons][i])
							format(string, sizeof(string), "%sWeapon %d: %s\n", string, i + 1, ReturnWeaponName(FactionData[PlayerData[playerid][pFactionEdit]][factionWeapons][i]));

						else format(string, sizeof(string), "%sEmpty Slot\n", string);
				    }
				    ShowPlayerDialog(playerid, DIALOG_EDITLOCKER_WEAPON, DIALOG_STYLE_LIST, "Locker Weapons", string, "Select", "Cancel");
				}
			}
		}
	}
	if(dialogid == DIALOG_EDITLOCKER_WEAPON_ID)
	{
		if (response)
		{
		    new weaponid = strval(inputtext);

		    if (isnull(inputtext))
		        return ShowPlayerDialog(playerid, DIALOG_EDITLOCKER_WEAPON_ID, DIALOG_STYLE_INPUT, "Set Weapon", sprintf("Current Weapon: %s (%d)\n\nPlease enter the new weapon ID for slot %d:", ReturnWeaponName(FactionData[PlayerData[playerid][pFactionEdit]][factionWeapons][PlayerData[playerid][pSelectedSlot]]), FactionData[PlayerData[playerid][pFactionEdit]][factionWeapons][PlayerData[playerid][pSelectedSlot]], PlayerData[playerid][pSelectedSlot]), "Submit", "Cancel");

			if (weaponid < 0 || weaponid > 46)
			    return ShowPlayerDialog(playerid, DIALOG_EDITLOCKER_WEAPON_ID, DIALOG_STYLE_INPUT, "Set Weapon", sprintf("Current Weapon: %s (%d)\n\nPlease enter the new weapon ID for slot %d:", ReturnWeaponName(FactionData[PlayerData[playerid][pFactionEdit]][factionWeapons][PlayerData[playerid][pSelectedSlot]]), FactionData[PlayerData[playerid][pFactionEdit]][factionWeapons][PlayerData[playerid][pSelectedSlot]], PlayerData[playerid][pSelectedSlot]), "Submit", "Cancel");

	        FactionData[PlayerData[playerid][pFactionEdit]][factionWeapons][PlayerData[playerid][pSelectedSlot]] = weaponid;
	        Faction_Save(PlayerData[playerid][pFactionEdit]);

		    if (weaponid) {
			    SendServerMessage(playerid, "You have set the weapon in slot %d to %s.", PlayerData[playerid][pSelectedSlot] + 1, ReturnWeaponName(weaponid));
			}
			else {
			    SendServerMessage(playerid, "You have removed the weapon in slot %d.", PlayerData[playerid][pSelectedSlot] + 1);
			}
		}
	}
	if(dialogid == DIALOG_EDITLOCKER_WEAPON_AMMO)
	{
		if (response)
		{
		    new ammo = strval(inputtext);

		    if (isnull(inputtext))
		        return ShowPlayerDialog(playerid, DIALOG_EDITLOCKER_WEAPON_AMMO, DIALOG_STYLE_INPUT, "Set Ammunition", sprintf("Current Ammo: %d\n\nPlease enter the new ammunition for the weapon in slot %d:", FactionData[PlayerData[playerid][pFactionEdit]][factionAmmo][PlayerData[playerid][pSelectedSlot]], PlayerData[playerid][pSelectedSlot]), "Submit", "Cancel");

			if (ammo < 1 || ammo > 15000)
			    return ShowPlayerDialog(playerid, DIALOG_EDITLOCKER_WEAPON_AMMO, DIALOG_STYLE_INPUT, "Set Ammunition", sprintf("Current Ammo: %d\n\nPlease enter the new ammunition for the weapon in slot %d:", FactionData[PlayerData[playerid][pFactionEdit]][factionAmmo][PlayerData[playerid][pSelectedSlot]], PlayerData[playerid][pSelectedSlot]), "Submit", "Cancel");

	        FactionData[PlayerData[playerid][pFactionEdit]][factionAmmo][PlayerData[playerid][pSelectedSlot]] = ammo;
	        Faction_Save(PlayerData[playerid][pFactionEdit]);

			SendServerMessage(playerid, "You have set the ammunition in slot %d to %d.", PlayerData[playerid][pSelectedSlot] + 1, ammo);
		}		
	}
	if(dialogid == DIALOG_EDITLOCKER_WEAPON_SET)
	{
		if (response)
		{
		    switch (listitem)
		    {
		        case 0:
		        	ShowPlayerDialog(playerid, DIALOG_EDITLOCKER_WEAPON_ID, DIALOG_STYLE_INPUT, "Set Weapon", sprintf("Current Weapon: %s (%d)\n\nPlease enter the new weapon ID for slot %d:", ReturnWeaponName(FactionData[PlayerData[playerid][pFactionEdit]][factionWeapons][PlayerData[playerid][pSelectedSlot]]), FactionData[PlayerData[playerid][pFactionEdit]][factionWeapons][PlayerData[playerid][pSelectedSlot]], PlayerData[playerid][pSelectedSlot]), "Submit", "Cancel");

				case 1:
		            ShowPlayerDialog(playerid, DIALOG_EDITLOCKER_WEAPON_AMMO, DIALOG_STYLE_INPUT, "Set Ammunition", sprintf("Current Ammo: %d\n\nPlease enter the new ammunition for the weapon in slot %d:", FactionData[PlayerData[playerid][pFactionEdit]][factionAmmo][PlayerData[playerid][pSelectedSlot]], PlayerData[playerid][pSelectedSlot]), "Submit", "Cancel");

				case 2:
				{
				    FactionData[PlayerData[playerid][pFactionEdit]][factionWeapons][PlayerData[playerid][pSelectedSlot]] = 0;
					FactionData[PlayerData[playerid][pFactionEdit]][factionAmmo][PlayerData[playerid][pSelectedSlot]] = 0;

					Faction_Save(PlayerData[playerid][pFactionEdit]);

					SendServerMessage(playerid, "You have removed the weapon in slot %d.", PlayerData[playerid][pSelectedSlot] + 1);
				}
		    }
		}
	}
	if(dialogid == DIALOG_EDITLOCKER_WEAPON)
	{
		if (response)
		{
		    PlayerData[playerid][pSelectedSlot] = listitem;
		    ShowPlayerDialog(playerid, DIALOG_EDITLOCKER_WEAPON_SET, DIALOG_STYLE_LIST, "Edit Weapon", sprintf("Set Weapon (%d)\nSet Ammunition (%d)\nClear Slot", FactionData[PlayerData[playerid][pFactionEdit]][factionWeapons][PlayerData[playerid][pSelectedSlot]], FactionData[PlayerData[playerid][pFactionEdit]][factionAmmo][PlayerData[playerid][pSelectedSlot]]), "Select", "Cancel");
		}
	}
	if(dialogid == DIALOG_LOCKER_WEAPON)
	{
		new factionid = PlayerData[playerid][pFaction];
		if (response)
		{
		    new
		        weaponid = FactionData[factionid][factionWeapons][listitem],
		        ammo = FactionData[factionid][factionAmmo][listitem],
		        dura = FactionData[factionid][factionDurability][listitem];

		    if (weaponid)
			{
				if(GetFactionType(playerid) == FACTION_FAMILY)
				{
			        if (PlayerHasWeapon(playerid, weaponid))
			            return SendErrorMessage(playerid, "You have this weapon equipped already.");

			        GiveWeaponToPlayer(playerid, weaponid, ammo, dura);
			        SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(weaponid));

			        FactionData[factionid][factionWeapons][listitem] = 0;
			        FactionData[factionid][factionAmmo][listitem] = 0;

			        Faction_Save(factionid);
				}
				else
				{
					if(!PlayerData[playerid][pOnDuty])
						return SendErrorMessage(playerid, "You must faction duty!");

			        if (PlayerHasWeapon(playerid, weaponid))
			            return SendErrorMessage(playerid, "You have this weapon equipped already.");

			        GiveWeaponToPlayer(playerid, weaponid, ammo, 500);
			        SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s reaches inside the locker and equips a %s.", ReturnName(playerid), ReturnWeaponName(weaponid));
				}
			}
			else
			{
			    if (GetFactionType(playerid) == FACTION_FAMILY)
			    {
			        if ((weaponid = GetWeapon(playerid)) == 0)
			            return SendErrorMessage(playerid, "You are not holding any weapon.");

			        FactionData[factionid][factionWeapons][listitem] = weaponid;
			        FactionData[factionid][factionAmmo][listitem] = GetPlayerAmmo(playerid);
			        FactionData[factionid][factionDurability][listitem] = PlayerData[playerid][pDurability][g_aWeaponSlots[weaponid]];

			        Faction_Save(factionid);

	                ResetWeapon(playerid, weaponid);
			        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s takes out a %s and stores it in the locker.", ReturnName(playerid), ReturnWeaponName(weaponid));
				}
				else
				{
				    SendErrorMessage(playerid, "The selected weapon slot is empty.");
				}
		    }
		}
		else {
		    cmd_faction(playerid, "locker");
		}
	}
	if(dialogid == DIALOG_LOCKER)
	{
		if (response)
		{
			new factionid = PlayerData[playerid][pFaction];
		    new
		        skins[8],
		        string[512];

			string[0] = 0;

		    if (FactionData[factionid][factionType] != FACTION_FAMILY)
		    {
		        switch (listitem)
		        {
		            case 0:
		            {
		                if (!PlayerData[playerid][pOnDuty])
		                {
		                    PlayerData[playerid][pOnDuty] = true;
		                    SetPlayerArmour(playerid, 100.0);

		                    SetFactionColor(playerid);
		                    SetPlayerSkin(playerid, PlayerData[playerid][pFactionSkin]);
		                    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has clocked in and is now on duty.", ReturnName(playerid));

		                    PlayerData[playerid][pDutyTime] = 3600;
		                }
		                else
		                {
		                    PlayerData[playerid][pOnDuty] = false;
		                    SetPlayerArmour(playerid, 0.0);

		                    SetPlayerColor(playerid, COLOR_WHITE);
		                    SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);
		                    ResetWeapons(playerid);

		                    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has clocked out and is now off duty.", ReturnName(playerid));

							PlayerData[playerid][pDutySecond] = 0;
							PlayerData[playerid][pDutyMinute] = 0;
							PlayerData[playerid][pDutyHour] = 0;
		                }
					}
					case 1:
					{
					    SetPlayerArmour(playerid, 100.0);
					    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s reaches into the locker and takes out a vest.", ReturnName(playerid));
					}
					case 2:
					{
						for (new i = 0; i < sizeof(skins); i ++)
						    skins[i] = (FactionData[factionid][factionSkins][i]) ? (FactionData[factionid][factionSkins][i]) : (19300);

						ShowModelSelectionMenu(playerid, "Choose Skin", MODEL_SELECTION_FACTION_SKIN, skins, sizeof(skins), -16.0, 0.0, -55.0);
					}
					case 3:
					{
					    for (new i = 0; i < 10; i ++)
						{
					        if (FactionData[factionid][factionWeapons][i])
								format(string, sizeof(string), "%sWeapon %d: %s\n", string, i + 1, ReturnWeaponName(FactionData[factionid][factionWeapons][i]));

							else format(string, sizeof(string), "%sEmpty Slot\n", string);
					    }
					    ShowPlayerDialog(playerid, DIALOG_LOCKER_WEAPON, DIALOG_STYLE_LIST, "Locker Weapons", string, "Equip", "Close");
					}
				}
		    }
		    else
		    {
		        switch (listitem)
		        {
					case 0:
					{
					    for (new i = 0; i < 10; i ++)
						{
					        if (FactionData[factionid][factionWeapons][i] && GetFactionType(playerid) != FACTION_FAMILY)
								format(string, sizeof(string), "%sWeapon %d: %s\n", string, i + 1, ReturnWeaponName(FactionData[factionid][factionWeapons][i]));

							else if (FactionData[factionid][factionWeapons][i] && GetFactionType(playerid) == FACTION_FAMILY)
								format(string, sizeof(string), "%s[%d] : %s (%d ammo) (%d durability)\n", string, i + 1, ReturnWeaponName(FactionData[factionid][factionWeapons][i]), FactionData[factionid][factionAmmo][i], FactionData[factionid][factionDurability][i]);

							else format(string, sizeof(string), "%sEmpty Slot\n", string);
					    }
					    ShowPlayerDialog(playerid, DIALOG_LOCKER_WEAPON, DIALOG_STYLE_LIST, "Locker Weapons", string, "Equip", "Close");
					}
					case 1:
					{
						new count = false;
						forex(i, MAX_FACTION_VEHICLE) if(FactionVehicle[i][fvFaction] == PlayerData[playerid][pFactionID])
						{
							if(IsValidVehicle(FactionVehicle[i][fvVehicle]))
								SetVehicleToRespawn(FactionVehicle[i][fvVehicle]);

							VehCore[FactionVehicle[i][fvVehicle]][vehFuel] = 100;

							count = true;
						}
						if(count)
							SendFactionMessage(PlayerData[playerid][pFaction], COLOR_SERVER, "FACTION VEHICLE: {FFFFFF}%s faction vehicle has been respawned by {FFFF00}%s", FactionData[factionid][factionName], ReturnName(playerid));
						else
							SendErrorMessage(playerid, "Your faction doesn't have faction vehicle!");
					}
				}
		    }
		}
	}
	if(dialogid == DIALOG_EDITRANK_NAME)
	{
		new str[256];
		if (response)
		{
		    if (isnull(inputtext))
				return format(str, sizeof(str), "Rank: %s (%d)\n\nPlease enter a new name for this rank below:", FactionRanks[PlayerData[playerid][pFactionEdit]][PlayerData[playerid][pSelectedSlot]], PlayerData[playerid][pSelectedSlot] + 1), 
						ShowPlayerDialog(playerid, DIALOG_EDITRANK_NAME, DIALOG_STYLE_INPUT, "Set Rank Name", str, "Submit", "Close");

		    if (strlen(inputtext) > 32)
		        return format(str, sizeof(str), "Rank: %s (%d)\n\nPlease enter a new name for this rank below:", FactionRanks[PlayerData[playerid][pFactionEdit]][PlayerData[playerid][pSelectedSlot]], PlayerData[playerid][pSelectedSlot] + 1), 
						ShowPlayerDialog(playerid, DIALOG_EDITRANK_NAME, DIALOG_STYLE_INPUT, "Set Rank Name", str, "Submit", "Close");

			format(FactionRanks[PlayerData[playerid][pFactionEdit]][PlayerData[playerid][pSelectedSlot]], 32, inputtext);
			Faction_SaveRanks(PlayerData[playerid][pFactionEdit]);

			Faction_ShowRanks(playerid, PlayerData[playerid][pFactionEdit]);
			SendServerMessage(playerid, "You have set the name of rank %d to \"%s\".", PlayerData[playerid][pSelectedSlot] + 1, inputtext);
		}
		else Faction_ShowRanks(playerid, PlayerData[playerid][pFactionEdit]);
	}
	if(dialogid == DIALOG_EDITFACTION_SALARY_LIST)
	{
		if (response)
		{
		    if (!FactionData[PlayerData[playerid][pFactionEdit]][factionExists])
				return 0;

			PlayerData[playerid][pListitem] = listitem;
			new str[256];
			format(str, sizeof(str), "Please enter new salary for rank %d below:", PlayerData[playerid][pListitem] + 1);
			ShowPlayerDialog(playerid, DIALOG_EDITFACTION_SALARY_SET, DIALOG_STYLE_INPUT, "Set Rank Salary", str, "Submit", "Close");
		}
	}			
	if(dialogid == DIALOG_EDITFACTION_SALARY_SET)
	{
		if(response)
		{
			new id = PlayerData[playerid][pFactionEdit], slot = PlayerData[playerid][pListitem], str[256];
			if(isnull(inputtext))
				return format(str, sizeof(str), "Please enter new salary for rank %d below:", PlayerData[playerid][pListitem] + 1),
						ShowPlayerDialog(playerid, DIALOG_EDITFACTION_SALARY_SET, DIALOG_STYLE_INPUT, "Set Rank Salary", str, "Submit", "Close");

			FactionData[id][factionSalary][slot] = strcash(inputtext);
			Faction_Save(id);
			SendServerMessage(playerid, "You have set salary for rank %d to $%s", slot + 1, FormatNumber(strcash(inputtext)));
		}
	}
	if(dialogid == DIALOG_EDITRANK)
	{
		if (response)
		{
		    if (!FactionData[PlayerData[playerid][pFactionEdit]][factionExists])
				return 0;

			PlayerData[playerid][pSelectedSlot] = listitem;
			new str[256];
			format(str, sizeof(str), "Rank: %s (%d)\n\nPlease enter a new name for this rank below:", FactionRanks[PlayerData[playerid][pFactionEdit]][PlayerData[playerid][pSelectedSlot]], PlayerData[playerid][pSelectedSlot] + 1);
			ShowPlayerDialog(playerid, DIALOG_EDITRANK_NAME, DIALOG_STYLE_INPUT, "Set Rank Name", str, "Submit", "Close");
		}
	}
	if(dialogid == DIALOG_MM)
	{
		if(response)
		{
		    new vehicleid = GetNearestVehicle(playerid, 4.0);
		    
		    if(listitem == 0)
      		{
		        if(GetComponent(playerid) < PlayerData[playerid][pMechPrice][0])
					return SendErrorMessage(playerid, "You don't have enough component parts!");

		        if(VehCore[vehicleid][vehRepair])
		            return SendErrorMessage(playerid, "This vehicle is being repaired!");
		            
				new Float:hp;
				GetVehicleHealth(vehicleid, hp);
				
				if(hp >= 900)
				    return SendErrorMessage(playerid, "This Vehicle doesn't need to repaired!");
				    
				Inventory_Remove(playerid, "Component", PlayerData[playerid][pMechPrice][0]);
		        SetTimerEx("TimeRepairEngine", 10000, false, "dd", playerid, vehicleid);
		        CreatePlayerLoadingBar(playerid, 10, "Repairing_Engine...");
		     //   ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 1, 0, 0, 0, 0, 1);
				SendClientMessage(playerid, COLOR_SERVER, "INFO: {FFFFFF}Processing Repairing the Engine of Vehicle, please wait!");
				VehCore[vehicleid][vehRepair] = true;
			}
 		    if(listitem == 1)
		    {
		        if(GetComponent(playerid) < PlayerData[playerid][pMechPrice][1])
		            return SendErrorMessage(playerid, "You don't have enough component parts!");
		            
		        if(VehCore[vehicleid][vehRepair])
		            return SendErrorMessage(playerid, "This vehicle is being repaired!");
		            
				Inventory_Remove(playerid, "Component", PlayerData[playerid][pMechPrice][1]);
		        SetTimerEx("TimeRepairBody", 10000, false, "dd", playerid, vehicleid);
		        CreatePlayerLoadingBar(playerid, 10, "Repairing_Body...");
		  //      ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 1, 0, 0, 0, 0, 1);
				SendClientMessage(playerid, COLOR_SERVER, "INFO: {FFFFFF}Processing Repairing the Body of Vehicle, please wait!");
				VehCore[vehicleid][vehRepair] = true;
			}
 		    if(listitem == 2)
			{
		        if(GetComponent(playerid) < 15)
		            return SendErrorMessage(playerid, "You don't have enough component parts!");

		        if(VehCore[vehicleid][vehRepair])
		            return SendErrorMessage(playerid, "This vehicle is being repaired!");
		            
				Inventory_Remove(playerid, "Component", 15);
		        SetTimerEx("TimeRepairTire", 10000, false, "dd", playerid, vehicleid);
		        CreatePlayerLoadingBar(playerid, 10, "Repairing_Tires...");
		  //      ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 1, 0, 0, 0, 0, 1);
				SendClientMessage(playerid, COLOR_SERVER, "INFO: {FFFFFF}Processing Repairing the Tires of Vehicle, please wait!");
				VehCore[vehicleid][vehRepair] = true;
			}
			if(listitem == 3)
			{

			    if(GetComponent(playerid) < 30)
			        return SendErrorMessage(playerid, "You don't have enough component parts!");

				static
			 		colors[256];

				for (new i = 0; i < sizeof(colors); i ++)
				{
					colors[i] = i;
			   	}
			   	ShowColorSelectionMenu(playerid, MODEL_SELECTION_COLOR, colors);
			   	PlayerData[playerid][pVehicle] = vehicleid;
			}
		}
	}
	if(dialogid == DIALOG_BUYINSU)
	{
		if(response)
		{
			new price, count;
			foreach(new i : PlayerVehicle)
			{
				if(Vehicle_IsOwner(playerid, i) && VehicleData[i][vRentTime] == 0 && count++ == listitem)
				{
					if(VehicleData[i][vInsurance] >= 3)
						return SendErrorMessage(playerid, "This vehicle already have full of Insurances!");

					price = GetInsuPrice(VehicleData[i][vModel]);
					if(GetMoney(playerid) < price)
						return SendErrorMessage(playerid, "You don't have enough money!");

					VehicleData[i][vInsurance]++;
					GiveMoney(playerid, -price);
					SendClientMessageEx(playerid, COLOR_SERVER, "INSURANCE: {FFFFFF}You've successfully purchase insurance for {FFFF00}%s", ReturnVehicleModelName(VehicleData[i][vModel]));
				}
			}
		}
	}
	if(dialogid == DIALOG_CLAIMINSU)
	{
		if(response)
		{
			new count;
			foreach(new i : PlayerVehicle)
			{
				if(Vehicle_IsOwner(playerid, i) && VehicleData[i][vInsuranced] && count++ == listitem)
				{
					if(VehicleData[i][vInsuTime] > 0)
						return SendErrorMessage(playerid, "Kendaraan ini belum bisa di-Claim!");

					VehicleData[i][vInsuranced] = false;
					new randspawn = random(sizeof(Random_Insu));

					VehicleData[i][vPos][0] = Random_Insu[randspawn][0];
					VehicleData[i][vPos][1] = Random_Insu[randspawn][1];
					VehicleData[i][vPos][2] = Random_Insu[randspawn][2];
					VehicleData[i][vPos][3] = Random_Insu[randspawn][3];

					OnPlayerVehicleRespawn(i);

					SendClientMessageEx(playerid, COLOR_SERVER, "INSURANCE: {FFFFFF}You've successfully claimed {FFFF00}%s {FFFFFF}from insurance.", ReturnVehicleModelName(VehicleData[i][vModel]));
				}
			}
		}
	}
	if(dialogid == DIALOG_PICKITEM)
	{
		static
		    string[64];

		if (response)
		{
		    new id = NearestItems[playerid][listitem];

			if (id != -1 && DroppedItems[id][droppedModel])
			{

				if(PickupItem(playerid, id))
				{
					format(string, sizeof(string), "~g~%s~w~ added to inventory!", DroppedItems[id][droppedItem]);
	 				ShowMessage(playerid, string, 2);
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has picked up a \"%s\".", ReturnName(playerid), DroppedItems[id][droppedItem]);
				}
				else
					SendErrorMessage(playerid, "You don't have any slot in your inventory.");
			}
			else SendErrorMessage(playerid, "This item was already picked up.");
		}
	}
	if(dialogid == DIALOG_GPS_TRACK)
	{
		new count;
		new Float:pos[3];
		if(response)
		{
			foreach(new i : PlayerVehicle)
			{
				if(IsValidVehicle(VehicleData[i][vVehicle]) && Vehicle_HaveAccess(playerid, i) && count++ == listitem)
				{
					PlayerData[playerid][pTracking] = true;
					GetVehiclePos(VehicleData[i][vVehicle], pos[0], pos[1], pos[2]);
					SetWaypoint(playerid, pos[0], pos[1], pos[2], 4.0);
					//SetPlayerCheckpoint(playerid, pos[0], pos[1], pos[2], 4.0);
					SendClientMessageEx(playerid, COLOR_SERVER, "GPS: {FFFFFF}Your {FFFF00}%s {FFFFFF}has been marked on radar (%s)", GetVehicleName(VehicleData[i][vVehicle]), GetLocation(pos[0], pos[1], pos[2]));
				}
			}
		}
	}//My Current Location\nPublic Location\nFind Vehicle\nFind Business\nFind Dealership
	if(dialogid == DIALOG_GPS)
	{
		if(response)
		{
			if(listitem == 0)
			{
				SendClientMessageEx(playerid, COLOR_YELLOW, "GPS: {FFFFFF}Your current location is now on {00FFFF}%s", GetSpecificLocation(playerid));
			}
			if(listitem == 1)
			{
				ShowPublicLocation(playerid);
			}
			if(listitem == 2)
			{
				ShowJobLocation(playerid);
			}
			if(listitem == 3)
			{
				ShowVehicleLocation(playerid);
			}
			if(listitem == 4)
			{
				ShowBusinessLocation(playerid);
			}
			if(listitem == 5)
			{
				ShowDealerLocation(playerid);
			}
			if(listitem == 6)
			{
				if(PlayerData[playerid][pJob] != JOB_LUMBERJACK)
					return SendErrorMessage(playerid, "You are not work as Lumberjack!"), cmd_gps(playerid, "");

				ShowTreeLocation(playerid);
			}
		}
	}
	if(dialogid == DIALOG_TAKEJOB)
	{
		if(response)
		{
			new job = GetNearestJob(playerid);
			if(job == 0)
				return SendErrorMessage(playerid, "You aren't in any Takejob point!");

			PlayerData[playerid][pJob] = job;
			SendClientMessageEx(playerid, COLOR_YELLOW, "JOB: {FFFFFF}Pekerjaanmu sekarang adalah sebagai {00FFFF}%s", Job_Name[job]);
			PlayerData[playerid][pQuitjob] = 2;
		}
	}
	if(dialogid == DIALOG_REFUEL)
	{
		new id = PlayerData[playerid][pBusiness];
		new amount = strval(inputtext);
		new vehicleid = GetPlayerVehicleID(playerid);

		if(response)
		{
			if(IsDiesel(vehicleid))
			{
				if(amount < 1 || amount > 100)
					return SendErrorMessage(playerid, "Invalid fuel amount!");

				if(BizData[id][bizDiesel] < amount)
					return SendErrorMessage(playerid, "Tidak ada cukup Diesel pada business ini!");

				if(GetMoney(playerid) < amount*100)
					return SendErrorMessage(playerid, "Kamu tidak memiliki cukup uang!");

				GiveMoney(playerid, -amount*100);
				SendServerMessage(playerid, "You've successfully refuelling your vehicle!");
				VehCore[vehicleid][vehFuel] += amount;
				BizData[id][bizVault] += amount*2;
				BizData[id][bizDiesel] -= amount;
				Business_Save(id);
				Business_Refresh(id);
				if(VehCore[vehicleid][vehFuel] > 100)
				{
				    VehCore[vehicleid][vehFuel] = 100;
				}
			}
			else
			{
				if(amount < 1 || amount > 100)
					return SendErrorMessage(playerid, "Invalid fuel amount!");

				if(BizData[id][bizFuel] < amount)
					return SendErrorMessage(playerid, "Tidak ada cukup Gasoline pada business ini");

				if(GetMoney(playerid) < amount*100)
					return SendErrorMessage(playerid, "Kamu tidak memiliki cukup uang!");

				GiveMoney(playerid, -amount*100);
				SendServerMessage(playerid, "You've successfully refuelling your vehicle!");
				VehCore[vehicleid][vehFuel] += amount;
				BizData[id][bizVault] += amount*2;
				BizData[id][bizFuel] -= amount;
				Business_Save(id);
				Business_Refresh(id);
				if(VehCore[vehicleid][vehFuel] > 100)
				{
				    VehCore[vehicleid][vehFuel] = 100;
				}
			}

		}
	}
	if(dialogid == DIALOG_SELLCARGO)
	{
		if(response)
		{
			new id = PlayerData[playerid][pBusiness];
			new cid = PlayerData[playerid][pCrate];

			if(BizData[id][bizVault] < BizData[id][bizCargo])
				return SendErrorMessage(playerid, "Business ini tidak memiliki cukup uang.");

			GiveMoney(playerid, BizData[id][bizCargo]);
			BizData[id][bizStock] += 10;
			BizData[id][bizVault] -= BizData[id][bizCargo];
			SendClientMessageEx(playerid, COLOR_SERVER, "CARGO: {FFFFFF}Kamu berhasil menjual {FFFF00}%s Cargo {FFFFFF}dan mendapat {00FF00}$%s", Crate_Name[CrateData[cid][crateType]], FormatNumber(BizData[id][bizCargo]));
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);		
			ApplyAnimation(playerid, "CARRY", "putdwn", 4.1, 0, 0, 0, 0, 0, 1);
			RemovePlayerAttachedObject(playerid, 9);
			Crate_Delete(cid);
			PlayerData[playerid][pCrate] = -1;
			if(BizData[id][bizStock] > 100)
			{
				BizData[id][bizStock] = 100;
			}
			Business_Save(id);
		}
	}
	if(dialogid == DIALOG_CRATE)
	{
		if(response)
		{
			new vid = PlayerData[playerid][pVehicle], count;
			forex(i, MAX_CRATES)
			{
				if(CrateData[i][crateExists] && CrateData[i][crateVehicle] == VehicleData[vid][vID] && count++ == listitem)
				{
					SendClientMessageEx(playerid, COLOR_SERVER, "CARGO: {FFFFFF}Kamu berhasil mengambil Cargo {FFFF00}%s {FFFFFF}dari Truck!", Crate_Name[CrateData[i][crateType]]);
					PlayerData[playerid][pCrate] = i;
				    ApplyAnimation(playerid, "CARRY", "liftup", 4.1, 0, 0, 0, 0, 0, 1);
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
				    SetPlayerAttachedObject(playerid,  9, 1271, 5, 0.044377, 0.029049, 0.161334, 265.922912, 9.904896, 21.765972, 0.500000, 0.500000, 0.500000);	
					CrateData[i][crateVehicle] = -1;
					Crate_Save(i);
				}
			}
		}
	}
	if(dialogid == DIALOG_LOCK)
	{
		new count, Float:pos[3];
		if(response)
		{
			foreach(new i : PlayerVehicle)
			{
				if(IsValidVehicle(VehicleData[i][vVehicle]))
				{
					if(Vehicle_HaveAccess(playerid, i) && count++ == listitem)
					{
						GetVehiclePos(VehicleData[i][vVehicle], pos[0], pos[1], pos[2]);
						if(IsPlayerInRangeOfPoint(playerid, 5.0, pos[0], pos[1], pos[2]))
						{
							PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
							VehicleData[i][vLocked] = !(VehicleData[i][vLocked]);
							LockVehicle(VehicleData[i][vVehicle], VehicleData[i][vLocked]);

							ShowMessage(playerid, sprintf("%s %s", GetVehicleName(VehicleData[i][vVehicle]), (VehicleData[i][vLocked]) ? ("~r~Locked") : ("~g~Unlocked")), 3);
						}
					}
				}
			}
		}
	}
	if(dialogid == DIALOG_BIZPRICE)
	{
	    if(response)
	    {
			new str[256];
	        PlayerData[playerid][pListitem] = listitem;
	        format(str, sizeof(str), "{FFFFFF}Current Product Price: $%s\n{FFFFFF}Silahkan masukan harga baru untuk product {00FFFF}%s", FormatNumber(BizData[PlayerData[playerid][pInBiz]][bizProduct][listitem]), ProductName[PlayerData[playerid][pInBiz]][listitem]);
	        ShowPlayerDialog(playerid, DIALOG_BIZPRICESET, DIALOG_STYLE_INPUT, "Set Product Price", str, "Set", "Close");
		}
		else
		    cmd_biz(playerid, "menu");
	}
	if(dialogid == DIALOG_BIZPROD)
	{
	    if(response)
	    {
			new str[256];
	        PlayerData[playerid][pListitem] = listitem;
	        format(str, sizeof(str), "{FFFFFF}Current Product Name: %s\n{FFFFFF}Silahkan masukan nama baru untuk product {00FFFF}%s", ProductName[PlayerData[playerid][pInBiz]][listitem], ProductName[PlayerData[playerid][pInBiz]][listitem]);
	        ShowPlayerDialog(playerid, DIALOG_BIZPRODSET, DIALOG_STYLE_INPUT, "Set Product Name", str, "Set", "Close");
		}
		else
		    cmd_biz(playerid, "menu");
	}
	if(dialogid == DIALOG_BIZPRODSET)
	{
	    if(response)
	    {
	        if(strlen(inputtext) < 1 || strlen(inputtext) > 24)
	            return SendErrorMessage(playerid, "Invalid Product name!");

			new id = PlayerData[playerid][pInBiz];
			new slot = PlayerData[playerid][pListitem];
			SendClientMessageEx(playerid, COLOR_SERVER, "BIZ: {FFFFFF}Kamu telah mengubah nama product dari {00FFFF}%s {FFFFFF}menjadi {00FFFF}%s", ProductName[id][slot], inputtext);
			format(ProductName[id][slot], 24, inputtext);
			cmd_biz(playerid, "menu");
			Business_Save(id);
		}
	}
	if(dialogid == DIALOG_BIZPRICESET)
	{
	    if(response)
	    {
	        if(strcash(inputtext) < 1)
	            return SendErrorMessage(playerid, "Invalid Product price!");
	            
			new id = PlayerData[playerid][pInBiz];
			new slot = PlayerData[playerid][pListitem];
			SendClientMessageEx(playerid, COLOR_SERVER, "BIZ: {FFFFFF}Kamu telah mengubah harga product dari {009000}$%s {FFFFFF}menjadi {009000}$%s", FormatNumber(BizData[id][bizProduct][slot]), FormatNumber(strcash(inputtext)));
			BizData[id][bizProduct][slot] = strcash(inputtext);
			cmd_biz(playerid, "menu");
			Business_Save(id);
		}
	}
	if(dialogid == DIALOG_BIZNAME)
	{
		if(response)
		{
			new id = PlayerData[playerid][pInBiz];

			if(strlen(inputtext) > 32)
				return SendErrorMessage(playerid, "Business name was too long!"), cmd_biz(playerid, "menu");

			format(BizData[id][bizName], 24, inputtext);
			Business_Save(id);
			Business_Refresh(id);
			SendServerMessage(playerid, "Kamu berhasil mengubah nama business menjadi %s", inputtext);
		}
	}
	if(dialogid == DIALOG_BIZMENU)
	{
	    if(response)
	    {
	    	if(listitem == 0)
	    	{
	    		ShowBizStats(playerid);
	    	}
	        if(listitem == 1)
	        {
	            SetProductName(playerid);
			}
			if(listitem == 2)
			{
			    SetProductPrice(playerid);
			}
			if(listitem == 3)
			{
				new str[256];
				format(str, sizeof(str), "{FFFFFF}Current Biz Name: %s\n{FFFFFF}Silahkan masukan nama Business mu yang baru:\n\n{FFFFFF}Note: Max 24 Huruf!", BizData[PlayerData[playerid][pInBiz]][bizName]);
				ShowPlayerDialog(playerid, DIALOG_BIZNAME, DIALOG_STYLE_INPUT, "Business Name", str, "Set", "Close");
			}
			if(listitem == 4)
			{
				new str[256];
				format(str, sizeof(str), "{FFFFFF}Current Cargo Price: {00FF00}$%s\n{FFFFFF}Silahkan masukan harga Cargo yang baru:\n\nNote: Min $50.0 Max $150.0!", FormatNumber(BizData[PlayerData[playerid][pInBiz]][bizCargo]));
				ShowPlayerDialog(playerid, DIALOG_BIZCARGO, DIALOG_STYLE_INPUT, "Business Cargo", str, "Set", "Close");
			}
			if(listitem == 5)
			{
				ShowPlayerDialog(playerid, DIALOG_BIZ_WD, DIALOG_STYLE_INPUT, "Business Withdraw", "Please input amount of vault you want to withdraw:", "Withdraw", "Close");
			}
			if(listitem == 6)
			{
				ShowPlayerDialog(playerid, DIALOG_BIZ_DP, DIALOG_STYLE_INPUT, "Business Deposit", "Please input amount of money you want to deposit:", "Deposit", "Close");
			}
			if(listitem == 7)
			{
				new str[299];
				if(BizData[PlayerData[playerid][pInBiz]][bizType] == 2)
				{
					forex(i, 7)
					{
						format(str, sizeof(str), "%s#%d.\t%s\n", str, i + 1, ProductDescription[PlayerData[playerid][pInBiz]][i]);
					}
					ShowPlayerDialog(playerid, DIALOG_BIZDESC, DIALOG_STYLE_LIST, "Description List", str, "Change", "Close");
				}
				else if(BizData[PlayerData[playerid][pInBiz]][bizType] == 4)
				{
					forex(i, 4)
					{
						format(str, sizeof(str), "%s#%d.\t%s\n", str, i + 1, ProductDescription[PlayerData[playerid][pInBiz]][i]);
					}
					ShowPlayerDialog(playerid, DIALOG_BIZDESC, DIALOG_STYLE_LIST, "Description List", str, "Change", "Close");
				}
				else
				{
					cmd_biz(playerid, "menu");
					SendErrorMessage(playerid, "This option only for 24/7 and Electronic business!");
				}
			}
		}
	}
	if(dialogid == DIALOG_BIZDESC_SET)
	{
		if(!response)
			return cmd_biz(playerid, "menu");

		if(isnull(inputtext))
			return ShowPlayerDialog(playerid, DIALOG_BIZDESC_SET, DIALOG_STYLE_INPUT, "Set Description", "Please input new product description\nNote: max 40 characters", "Set", "Close");

		if(strlen(inputtext) > 40)
			return ShowPlayerDialog(playerid, DIALOG_BIZDESC_SET, DIALOG_STYLE_INPUT, "Set Description", "Please input new product description\nNote: max 40 characters", "Set", "Close");

		format(ProductDescription[PlayerData[playerid][pInBiz]][PlayerData[playerid][pListitem]], 40, inputtext);	
		Business_Save(PlayerData[playerid][pInBiz]);
		SendServerMessage(playerid, "You have adjusted the product description!");
	}
	if(dialogid == DIALOG_BIZDESC)
	{
		if(response)
		{
			PlayerData[playerid][pListitem] = listitem;
			ShowPlayerDialog(playerid, DIALOG_BIZDESC_SET, DIALOG_STYLE_INPUT, "Set Description", "Please input new product description\nNote: max 40 characters", "Set", "Close");
		}
		else
		{
			cmd_biz(playerid, "menu");
		}
	}
	if(dialogid == DIALOG_BIZ_DP)
	{
		if(response)
		{
			new amount = strcash(inputtext), id = PlayerData[playerid][pInBiz];
			if(amount < 1)
				return ShowPlayerDialog(playerid, DIALOG_BIZ_DP, DIALOG_STYLE_INPUT, "Business Deposit", "ERROR: Invalid amount!\nPlease input amount of money you want to deposit:", "Deposit", "Close");
		
			if(GetMoney(playerid) < amount)
				return ShowPlayerDialog(playerid, DIALOG_BIZ_DP, DIALOG_STYLE_INPUT, "Business Deposit", "ERROR: You dont have enough money!\nPlease input amount of money you want to deposit:", "Deposit", "Close");
		
			BizData[id][bizVault] += amount;
			GiveMoney(playerid, -amount);
			SendServerMessage(playerid, "You have deposit {009000}$%s {FFFFFF}to business vault.", FormatNumber(amount));
			Business_Save(id);
		}
		else
		{
			cmd_biz(playerid, "menu");
		}
	}
	if(dialogid == DIALOG_BIZ_WD)
	{
		if(response)
		{
			new amount = strcash(inputtext), id = PlayerData[playerid][pInBiz];
			if(amount < 1)
				return ShowPlayerDialog(playerid, DIALOG_BIZ_WD, DIALOG_STYLE_INPUT, "Business Withdraw", "ERROR: Invalid amount!\nPlease input amount of vault you want to withdraw:", "Withdraw", "Close");
		
			if(BizData[id][bizVault] < amount)
				return ShowPlayerDialog(playerid, DIALOG_BIZ_WD, DIALOG_STYLE_INPUT, "Business Withdraw", "ERROR: Not enough money on vault!\nPlease input amount of vault you want to withdraw:", "Withdraw", "Close");
		
			BizData[id][bizVault] -= amount;
			GiveMoney(playerid, amount);
			SendServerMessage(playerid, "You have withdrawn {009000}$%s {FFFFFF}from business vault.", FormatNumber(amount));
			Business_Save(id);
		}
		else
		{
			cmd_biz(playerid, "menu");
		}
	}
	if(dialogid == DIALOG_BIZCARGO)
	{
		if(response)
		{
			new id = PlayerData[playerid][pInBiz], price = strcash(inputtext);
			if(id == -1)
				return SendErrorMessage(playerid, "Business no longer valid.");

			if(price < 5000 || price > 15000)
				return SendErrorMessage(playerid, "Cannot under $50.00 or above $150!"), cmd_biz(playerid, "menu");

			BizData[id][bizCargo] = price;
			SendClientMessageEx(playerid, COLOR_SERVER, "BUSINESS: {FFFFFF}Kamu telah mengubah Cargo price menjadi {00FF00}$%s", FormatNumber(price));
			cmd_biz(playerid, "menu");
		}
	}
	if(dialogid == DIALOG_RENTAL)
	{
	    if(response)
	    {
	        new rentid = PlayerData[playerid][pRenting];
	        if(GetMoney(playerid) < RentData[rentid][rentPrice][listitem])
	            return SendErrorMessage(playerid, "Kamu tidak memiliki cukup uang!");
	            
			new str[256];
			format(str, sizeof(str), "{FFFFFF}Berapa jam kamu ingin menggunakan kendaraan Rental ini ?\n{FFFFFF}Maksimal adalah {FFFF00}4 jam\n\n{FFFFFF}Harga per Jam: {009000}$%s", FormatNumber(RentData[rentid][rentPrice][listitem]));
			ShowPlayerDialog(playerid, DIALOG_RENTTIME, DIALOG_STYLE_INPUT, "{FFFFFF}Rental Time", str, "Rental", "Close");
			PlayerData[playerid][pListitem] = listitem;
		}
	}
	if(dialogid == DIALOG_RENTTIME)
	{
	    if(response)
	    {
	        new id = PlayerData[playerid][pRenting];
	        new slot = PlayerData[playerid][pListitem];
			new time = strval(inputtext);
			if(time < 1 || time > 4)
			{
				new str[256];
				format(str, sizeof(str), "{FFFFFF}Berapa jam kamu ingin menggunakan kendaraan Rental ini ?\n{FFFFFF}Maksimal adalah {FFFF00}4 jam\n\n{FFFFFF}Harga per Jam: {009000}$%s", FormatNumber(RentData[id][rentPrice][listitem]));
				ShowPlayerDialog(playerid, DIALOG_RENTTIME, DIALOG_STYLE_INPUT, "{FFFFFF}Rental Time", str, "Rental", "Close");
				return 1;
			}
			GiveMoney(playerid, -RentData[id][rentPrice][slot] * time);
			SendClientMessageEx(playerid, COLOR_SERVER, "RENTAL: {FFFFFF}Kamu telah menyewa {00FFFF}%s {FFFFFF}untuk %d Jam seharga {009000}$%s", GetVehicleModelName(RentData[id][rentModel][slot]), time, FormatNumber(RentData[id][rentPrice][slot] * time));
            VehicleRental_Create(PlayerData[playerid][pID], RentData[id][rentModel][slot], RentData[id][rentSpawn][0], RentData[id][rentSpawn][1], RentData[id][rentSpawn][2], RentData[id][rentSpawn][3], time*3600, PlayerData[playerid][pRenting]);
		}
	}
	if(dialogid == DIALOG_BUYSKINS)
	{
	    if(response)
	    {
	        GiveMoney(playerid, -PlayerData[playerid][pSkinPrice]);
			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s has paid $%s and purchased a %s.", ReturnName(playerid), FormatNumber(PlayerData[playerid][pSkinPrice]), ProductName[PlayerData[playerid][pInBiz]][0]);
			BizData[PlayerData[playerid][pInBiz]][bizStock]--;
			if(PlayerData[playerid][pGender] == 1)
			{
				UpdatePlayerSkin(playerid, g_aMaleSkins[listitem]);
			}
			else
			{
				UpdatePlayerSkin(playerid, g_aFemaleSpawnSkins[listitem]);
			}
		}
	}
	if(dialogid == DIALOG_DROPITEM)
	{
	    if(response)
	    {
			new
			    itemid = PlayerData[playerid][pListitem],
			    string[32],
				str[356];

			strunpack(string, InventoryData[playerid][itemid][invItem]);

			if (response)
			{
			    if (isnull(inputtext))
			        return format(str, sizeof(str), "Drop Item", "Item: %s - Quantity: %d\n\nPlease specify how much of this item you wish to drop:", string, InventoryData[playerid][itemid][invQuantity]),
					ShowPlayerDialog(playerid, DIALOG_DROPITEM, DIALOG_STYLE_INPUT, "Drop Item", str, "Drop", "Cancel");

				if (strval(inputtext) < 1 || strval(inputtext) > InventoryData[playerid][itemid][invQuantity])
				    return format(str, sizeof(str), "ERROR: Insufficient amount specified.\n\nItem: %s - Quantity: %d\n\nPlease specify how much of this item you wish to drop:", string, InventoryData[playerid][itemid][invQuantity]),
					ShowPlayerDialog(playerid, DIALOG_DROPITEM, DIALOG_STYLE_INPUT, "Drop Item", str, "Drop", "Cancel");

				if(!strcmp(string, "Rolled Weed"))
				{
					if(IsPlayerInRangeOfPoint(playerid, 5.0, -1112.0999,-1676.1182,76.3672))
					{
						new amount = strval(inputtext);
						GiveMoney(playerid, amount*1000);
						SendClientMessageEx(playerid, COLOR_SERVER, "DRUGS: {FFFFFF}Kamu telah menjual {FFFF00}%d Rolled Weed {FFFFFF}dan mendapatkan {00FF00}$%s", amount, FormatNumber(amount*1000));
						Inventory_Remove(playerid, "Rolled Weed", -1);
					}
					else
					{
						DropPlayerItem(playerid, itemid, strval(inputtext));
					}
				}
				else
				{
					DropPlayerItem(playerid, itemid, strval(inputtext));
				}
			}
		}
	}
	if(dialogid == DIALOG_GIVEITEM)
	{
		if (response)
		{
		    static
		        userid = -1,
				itemid = -1,
				string[32];

			if (sscanf(inputtext, "u", userid))
			    return ShowPlayerDialog(playerid, DIALOG_GIVEITEM, DIALOG_STYLE_INPUT, "Give Item", "Please enter the name or the ID of the player:", "Submit", "Cancel");

			if (userid == INVALID_PLAYER_ID)
			    return ShowPlayerDialog(playerid, DIALOG_GIVEITEM, DIALOG_STYLE_INPUT, "Give Item", "ERROR: Invalid player specified.\n\nPlease enter the name or the ID of the player:", "Submit", "Cancel");

		    if (!IsPlayerNearPlayer(playerid, userid, 6.0))
				return ShowPlayerDialog(playerid, DIALOG_GIVEITEM, DIALOG_STYLE_INPUT, "Give Item", "ERROR: You are not near that player.\n\nPlease enter the name or the ID of the player:", "Submit", "Cancel");

		    if (userid == playerid)
				return ShowPlayerDialog(playerid, DIALOG_GIVEITEM, DIALOG_STYLE_INPUT, "Give Item", "ERROR: You can't give items to yourself.\n\nPlease enter the name or the ID of the player:", "Submit", "Cancel");

			itemid = PlayerData[playerid][pListitem];

			if (itemid == -1)
			    return 0;

			strunpack(string, InventoryData[playerid][itemid][invItem]);

			if (InventoryData[playerid][itemid][invQuantity] == 1)
			{
			    new id = Inventory_Add(userid, string, InventoryData[playerid][itemid][invModel]);

			    if (id == -1)
					return SendErrorMessage(playerid, "That player doesn't have anymore inventory slots.");

			    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s takes out a \"%s\" and gives it to %s.", ReturnName(playerid), string, ReturnName(userid));
			    SendServerMessage(userid, "%s has given you \"%s\" (added to inventory).", ReturnName(playerid), string);

				Inventory_Remove(playerid, string);
			    //Log_Write("logs/give_log.txt", "[%s] %s (%s) has given a %s to %s (%s).", ReturnDate(), ReturnName(playerid), PlayerData[playerid][pIP], string, ReturnName(userid, 0), PlayerData[userid][pIP]);
	  		}
			else
			{
				new str[152];
				format(str, sizeof(str), "Item: %s (Amount: %d)\n\nPlease enter the amount of this item you wish to give %s:", string, InventoryData[playerid][itemid][invQuantity], ReturnName(userid));
			    ShowPlayerDialog(playerid, DIALOG_GIVEAMOUNT, DIALOG_STYLE_INPUT, "Give Item", str, "Give", "Cancel");
			    PlayerData[playerid][pTarget] = userid;
			}
		}
	}
	if(dialogid == DIALOG_GIVEAMOUNT)
	{
		if (response && PlayerData[playerid][pTarget] != INVALID_PLAYER_ID)
		{
		    new
		        userid = PlayerData[playerid][pTarget],
		        itemid = PlayerData[playerid][pListitem],
				string[32],
				str[352];

			strunpack(string, InventoryData[playerid][itemid][invItem]);

			if (isnull(inputtext))
				return format(str, sizeof(str), "Item: %s (Amount: %d)\n\nPlease enter the amount of this item you wish to give %s:", string, InventoryData[playerid][itemid][invQuantity], ReturnName(userid)),
				ShowPlayerDialog(playerid, DIALOG_GIVEAMOUNT, DIALOG_STYLE_INPUT, "Give Item", str, "Give", "Cancel");

			if (strval(inputtext) < 1 || strval(inputtext) > InventoryData[playerid][itemid][invQuantity])
			    return format(str, sizeof(str), "ERROR: You don't have that much.\n\nItem: %s (Amount: %d)\n\nPlease enter the amount of this item you wish to give %s:", string, InventoryData[playerid][itemid][invQuantity], ReturnName(userid)),
				ShowPlayerDialog(playerid, DIALOG_GIVEAMOUNT, DIALOG_STYLE_INPUT, "Give Item", str, "Give", "Cancel");

	        new id = Inventory_Add(userid, string, InventoryData[playerid][itemid][invModel], strval(inputtext));

		    if (id == -1)
				return SendErrorMessage(playerid, "That player doesn't have anymore inventory slots.");

		    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s takes out a \"%s\" and gives it to %s.", ReturnName(playerid), string, ReturnName(userid));
		    SendServerMessage(userid, "%s has given you \"%s\" (added to inventory).", ReturnName(playerid), string);

			Inventory_Remove(playerid, string, strval(inputtext));
		  //  Log_Write("logs/give_log.txt", "[%s] %s (%s) has given %d %s to %s (%s).", ReturnDate(), ReturnName(playerid), PlayerData[playerid][pIP], strval(inputtext), string, ReturnName(userid, 0), PlayerData[userid][pIP]);
		}
	}
	if(dialogid == DIALOG_INVACTION)
	{
	    if(response)
	    {
		    new
				itemid = PlayerData[playerid][pListitem],
				string[64],
				str[256];

		    strunpack(string, InventoryData[playerid][itemid][invItem]);

		    switch (listitem)
		    {
		        case 0:
		        {
		            CallLocalFunction("OnPlayerUseItem", "dds", playerid, itemid, string);
		        }
		        case 1:
		        {
				    if(!strcmp(string, "Cellphone"))
				        return SendErrorMessage(playerid, "You can't do that on this item! (%s)", string);

				    if(!strcmp(string, "GPS"))
				        return SendErrorMessage(playerid, "You can't do that on this item! (%s)", string);

				    if(!strcmp(string, "Portable Radio"))
				        return SendErrorMessage(playerid, "You can't do that on this item! (%s)", string);

				    if(!strcmp(string, "Mask"))
				        return SendErrorMessage(playerid, "You can't do that on this item! (%s)", string);

					PlayerData[playerid][pListitem] = itemid;
					ShowPlayerDialog(playerid, DIALOG_GIVEITEM, DIALOG_STYLE_INPUT, "Give Item", "Please enter the name or the ID of the player:", "Submit", "Cancel");
		        }
		        case 2:
		        {
		            if (IsPlayerInAnyVehicle(playerid))
		                return SendErrorMessage(playerid, "You can't drop items right now.");

				    if(!strcmp(string, "Cellphone"))
				        return SendErrorMessage(playerid, "You can't do that on this item! (%s)", string);

				    if(!strcmp(string, "GPS"))
				        return SendErrorMessage(playerid, "You can't do that on this item! (%s)", string);

				    if(!strcmp(string, "Portable Radio"))
				        return SendErrorMessage(playerid, "You can't do that on this item! (%s)", string);

				    if(!strcmp(string, "Mask"))
				        return SendErrorMessage(playerid, "You can't do that on this item! (%s)", string);

					else if (InventoryData[playerid][itemid][invQuantity] == 1)
					{
						if(!strcmp(string, "Rolled Weed"))
						{
							if(IsPlayerInRangeOfPoint(playerid, 5.0, -1112.0999,-1676.1182,76.3672))
							{
								new amount = InventoryData[playerid][itemid][invQuantity];
								GiveMoney(playerid, amount*1000);
								SendClientMessageEx(playerid, COLOR_SERVER, "DRUGS: {FFFFFF}Kamu telah menjual {FFFF00}%d Rolled Weed {FFFFFF}dan mendapatkan {00FF00}$%s", amount, FormatNumber(amount*1000));
								Inventory_Remove(playerid, "Rolled Weed");
							}
							else
							{
								DropPlayerItem(playerid, itemid);
							}
						}
						else
						{
							DropPlayerItem(playerid, itemid);
						}
					}
					else
						format(str, sizeof(str), "Item: %s - Quantity: %d\n\nPlease specify how much of this item you wish to drop:", string, InventoryData[playerid][itemid][invQuantity]),
						ShowPlayerDialog(playerid, DIALOG_DROPITEM, DIALOG_STYLE_INPUT, "Drop Item", str, "Drop", "Cancel");
				}
			}
		}
	}
    if(dialogid == DIALOG_INVENTORY)
    {
        if(response)
        {
		    new
		        name[48], id, str[156];

            strunpack(name, InventoryData[playerid][listitem][invItem]);
            PlayerData[playerid][pListitem] = listitem;

            if(InventoryData[playerid][listitem][invQuantity] < 1)
            	return SendErrorMessage(playerid, "There is no item on selected slot!");

			switch (PlayerData[playerid][pStorageSelect])
			{
			    case 0:
			    {
		            format(name, sizeof(name), "%s (%d)", name, InventoryData[playerid][listitem][invQuantity]);
		            ShowPlayerDialog(playerid, DIALOG_INVACTION, DIALOG_STYLE_LIST, name, "Use Item\nGive Item\nDrop Item", "Select", "Cancel");
				}
				case 1:
				{
			    	if ((id = House_Inside(playerid)) != -1 && House_IsOwner(playerid, id))
					{
					    if(!strcmp(name, "Cellphone"))
					        return SendErrorMessage(playerid, "You can't do that on this item! (%s)", name);

					    if(!strcmp(name, "GPS"))
					        return SendErrorMessage(playerid, "You can't do that on this item! (%s)", name);

					    if(!strcmp(name, "Portable Radio"))
					        return SendErrorMessage(playerid, "You can't do that on this item! (%s)", name);

					    if(!strcmp(name, "Mask"))
					        return SendErrorMessage(playerid, "You can't do that on this item! (%s)", name);
					        
						if (InventoryData[playerid][listitem][invQuantity] == 1)
						{
			        		House_AddItem(id, name, InventoryData[playerid][listitem][invModel], 1);
			        		Inventory_Remove(playerid, name);
			        		
			        		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has stored a \"%s\" into their house storage.", ReturnName(playerid), name);
					 		House_ShowItems(playerid, id);
						}
						else
						{
							format(str, sizeof(str), "Item: %s (Amount: %d)\n\nPlease enter the quantity that you wish to store for this item:", name, InventoryData[playerid][PlayerData[playerid][pListitem]][invQuantity]);
							ShowPlayerDialog(playerid, DIALOG_HOUSEDEPOSIT, DIALOG_STYLE_INPUT, "House Deposit", str, "Deposit", "Close");
						}
					}
				}
			}
		}
	}
	if(dialogid == DIALOG_BIZBUY)
	{
	    if(response)
	    {
	        new bid = PlayerData[playerid][pInBiz], price, prodname[34];
	        if(bid != -1)
	        {
	            price = BizData[bid][bizProduct][listitem];
				prodname = ProductName[bid][listitem];
				PlayerData[playerid][pListitem] = listitem;
	            if(GetMoney(playerid) < price)
	                return SendErrorMessage(playerid, "You don't have enough money!");
	                
				if(BizData[bid][bizStock] < 1)
					return SendErrorMessage(playerid, "This business is out of stock.");
					
				switch(BizData[bid][bizType])
				{
				    case 1:
				    {
						if(listitem == 0)
						{
						    if(PlayerData[playerid][pHunger] >= 100)
						        return SendErrorMessage(playerid, "Kamu tidak membutuhkan makanan saat ini.");

							PlayerData[playerid][pHunger] += 20;
							SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s has paid $%s and purchased a %s.", ReturnName(playerid), FormatNumber(price), prodname);
							GiveMoney(playerid, -price);
							BizData[bid][bizStock]--;
							BizData[bid][bizVault] += price;
						}
						if(listitem == 1)
						{
						    if(PlayerData[playerid][pHunger] >= 100)
						        return SendErrorMessage(playerid, "Your energy is already full!");

							PlayerData[playerid][pHunger] += 40;
							SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s has paid $%s and purchased a %s.", ReturnName(playerid), FormatNumber(price), prodname);
							GiveMoney(playerid, -price);
							BizData[bid][bizStock]--;
							BizData[bid][bizVault] += price;
						}
						if(listitem == 2)
						{
						    if(PlayerData[playerid][pThirst] >= 100)
						        return SendErrorMessage(playerid, "Kamu tidak membutuhkan minum saat ini.");

							PlayerData[playerid][pThirst] += 15;
							SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s has paid $%s and purchased a %s.", ReturnName(playerid), FormatNumber(price), prodname);
							GiveMoney(playerid, -price);
							BizData[bid][bizStock]--;
							BizData[bid][bizVault] += price;
						}
					}
					case 2:
					{
					    if(listitem == 0)
					    {
							Inventory_Add(playerid, "Snack", 2768, 1);
							SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s has paid $%s and purchased a %s.", ReturnName(playerid), FormatNumber(price), prodname);
							GiveMoney(playerid, -price);
							BizData[bid][bizStock]--;
							BizData[bid][bizVault] += price;
						}
						if(listitem == 1)
						{
							Inventory_Add(playerid, "Water", 2958, 1);
							SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s has paid $%s and purchased a %s.", ReturnName(playerid), FormatNumber(price), prodname);
							GiveMoney(playerid, -price);
							BizData[bid][bizStock]--;
							BizData[bid][bizVault] += price;
						}
						if(listitem == 2)
						{
							if(PlayerHasItem(playerid, "Mask"))
								return SendErrorMessage(playerid, "You already have a Mask!");

							PlayerData[playerid][pMaskID] = PlayerData[playerid][pID]+random(90000) + 10000;
							Inventory_Add(playerid, "Mask", 19036, 1);
							SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s has paid $%s and purchased a %s.", ReturnName(playerid), FormatNumber(price), prodname);
							GiveMoney(playerid, -price);
							BizData[bid][bizStock]--;
							BizData[bid][bizVault] += price;
						}
						if(listitem == 3)
						{
							Inventory_Add(playerid, "Medkit", 1580, 1);
							SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s has paid $%s and purchased a %s.", ReturnName(playerid), FormatNumber(price), prodname);
							GiveMoney(playerid, -price);
							BizData[bid][bizStock]--;
							BizData[bid][bizVault] += price;
						}
						if(listitem == 4)
						{
							Inventory_Add(playerid, "Rolling Paper", 19873, 1);
							SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s has paid $%s and purchased a %s.", ReturnName(playerid), FormatNumber(price), prodname);
							GiveMoney(playerid, -price);
							BizData[bid][bizStock]--;
							BizData[bid][bizVault] += price;
						}
						if(listitem == 5)
						{
							Inventory_Add(playerid, "Axe", 19631, 1);
							SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s has paid $%s and purchased a %s.", ReturnName(playerid), FormatNumber(price), prodname);
							GiveMoney(playerid, -price);
							BizData[bid][bizStock]--;
							BizData[bid][bizVault] += price;							
						}
						if(listitem == 6)
						{
							Inventory_Add(playerid, "Fish Rod", 18632, 1);
							SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s has paid $%s and purchased a %s.", ReturnName(playerid), FormatNumber(price), prodname);
							GiveMoney(playerid, -price);
							BizData[bid][bizStock]--;
							BizData[bid][bizVault] += price;	
						}
					}
					case 3:
					{
						PlayerData[playerid][pSkinPrice] = price;
						if(listitem == 0)
						{
						    if(PlayerData[playerid][pGender] == 1)
						    {
						    	ShowModelSelectionMenu(playerid, "Male Skins", MODEL_SELECTION_BUYSKIN, g_aMaleSkins, sizeof(g_aMaleSkins), -16.0, 0.0, -55.0);
							}
							else
							{
						        ShowModelSelectionMenu(playerid, "Female Skins", MODEL_SELECTION_BUYSKIN, g_aFemaleSkins, sizeof(g_aFemaleSkins), -16.0, 0.0, -55.0);
							}
						}
						if(listitem == 1)
						{
							ShowModelSelectionMenu(playerid, "Purchase Accessory", MODEL_SELECTION_ACC, g_AccList, sizeof(g_AccList), 0.0, 0.0, 0.0);
						}
					}
					case 4:
					{
					    if(listitem == 0)
						{       
							ShowNumberIndex(playerid);
						}
					    if(listitem == 1)
						{
						    if(PlayerHasItem(playerid, "GPS"))
						        return SendErrorMessage(playerid, "Kamu sudah memiliki GPS!");

							Inventory_Add(playerid, "GPS", 18875, 1);
							SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s has paid $%s and purchased a %s.", ReturnName(playerid), FormatNumber(price), prodname);
							GiveMoney(playerid, -price);
							BizData[bid][bizStock]--;
							BizData[bid][bizVault] += price;
						}
					    if(listitem == 2)
						{
						    if(PlayerHasItem(playerid, "Portable Radio"))
						        return SendErrorMessage(playerid, "Kamu sudah memiliki Portable Radio!");

							Inventory_Add(playerid, "Portable Radio", 19942, 1);
							SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s has paid $%s and purchased a %s.", ReturnName(playerid), FormatNumber(price), prodname);
							GiveMoney(playerid, -price);
							BizData[bid][bizStock]--;
							BizData[bid][bizVault] += price;
						}
						if(listitem == 3)
						{
							PlayerData[playerid][pCredit] += 50;
							SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s has paid $%s and purchased a %s.", ReturnName(playerid), FormatNumber(price), prodname);
							GiveMoney(playerid, -price);
							BizData[bid][bizStock]--;
							BizData[bid][bizVault] += price;
						}
					}
				}
			}
		}
	}
	if(dialogid == DIALOG_REGISTER)
	{
	    if(!response)
	        return Kick(playerid);

		new str[356];
	    format(str, sizeof(str), "{FFFFFF}Welcome to Revitalize {FFFF00}%s\n{FFFFFF}Current IP: {FF0606}%s\n\n{FFFFFF}Untuk register kamu harus membuat password account-mu terlebih dahulu\nNote: Minimal 7 huruf/angka dan Maksimal 32 huruf/angka\n\nSilahkan masukkan password untuk melanjutkan register ke kolom dibawah ini:", GetName(playerid), ReturnIP(playerid));

        if(strlen(inputtext) < 7)
			return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Register to Revitalize", str, "Register", "Exit");

        if(strlen(inputtext) > 32)
			return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Register to Revitalize", str, "Register", "Exit");

        bcrypt_hash(playerid, "HashPlayerPassword", inputtext, BCRYPT_COST);
	}
	if(dialogid == DIALOG_LOGIN)
	{
	    if(!response)
	        return Kick(playerid);
	        
		new pwQuery[256], hash[BCRYPT_HASH_LENGTH];
		mysql_format(sqlcon, pwQuery, sizeof(pwQuery), "SELECT Password FROM playerucp WHERE UCP = '%e' LIMIT 1", GetName(playerid));
		mysql_query(sqlcon, pwQuery);
		
        cache_get_value_name(0, "Password", hash, sizeof(hash));
        
        bcrypt_verify(playerid, "OnPlayerPasswordChecked", inputtext, hash);

	}
    if(dialogid == DIALOG_CHARLIST)
    {
		if(response)
		{
			if (PlayerChar[playerid][listitem][0] == EOS)
				return ShowPlayerDialog(playerid, DIALOG_MAKECHAR, DIALOG_STYLE_INPUT, "Create Character", "Insert your Character Name\n\nExample: Finn_Xanderz, Javier_Cooper etc.", "Create", "Exit");

			PlayerData[playerid][pChar] = listitem;
			SetPlayerName(playerid, PlayerChar[playerid][listitem]);

			new cQuery[256];
			mysql_format(sqlcon, cQuery, sizeof(cQuery), "SELECT * FROM `characters` WHERE `Name` = '%s' LIMIT 1;", PlayerChar[playerid][PlayerData[playerid][pChar]]);
			mysql_tquery(sqlcon, cQuery, "LoadCharacterData", "d", playerid);
			
		}
	}
	if(dialogid == DIALOG_MAKECHAR)
	{
	    if(response)
	    {
		    if(strlen(inputtext) < 1 || strlen(inputtext) > 24)
				return ShowPlayerDialog(playerid, DIALOG_MAKECHAR, DIALOG_STYLE_INPUT, "Character Name", "Insert your Character Name\n\nExample: Finn_Xanderz, Javier_Cooper etc.", "Submit", "Cancel");

			if(!IsRoleplayName(inputtext))
				return ShowPlayerDialog(playerid, DIALOG_MAKECHAR, DIALOG_STYLE_INPUT, "Character Name", "Insert your Character Name\n\nExample: Finn_Xanderz, Javier_Cooper etc.", "Submit", "Cancel");

			new characterQuery[178];
			mysql_format(sqlcon, characterQuery, sizeof(characterQuery), "SELECT * FROM `characters` WHERE `Name` = '%s'", inputtext);
			mysql_tquery(sqlcon, characterQuery, "InsertPlayerName", "ds", playerid, inputtext);

		    format(PlayerData[playerid][pUCP], 22, GetName(playerid));
		}
		else
		{
			SelectTextDraw(playerid, COLOR_YELLOW);
		}
	}
	if(dialogid == DIALOG_AGE)
	{
		if(response)
		{
			if(strval(inputtext) >= 70)
			    return ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Character Age", "ERROR: Cannot more than 70 years old!", "Continue", "Cancel");

			if(strval(inputtext) < 13)
			    return ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Character Age", "ERROR: Cannot below 13 Years Old!", "Continue", "Cancel");

			PlayerData[playerid][pAge] = strval(inputtext);
			ShowPlayerDialog(playerid, DIALOG_ORIGIN, DIALOG_STYLE_INPUT, "Character Origin", "Please input your Character Origin:", "Continue", "Quit");
		}
		else
		{
		    ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Character Age", "Please Insert your Character Age", "Continue", "Cancel");
		}
	}
	if(dialogid == DIALOG_ORIGIN)
	{
		if (response)
		{
		    if (isnull(inputtext) || strlen(inputtext) > 32) {
		        ShowPlayerDialog(playerid, DIALOG_ORIGIN, DIALOG_STYLE_INPUT, "Origin", "Please enter the geographical origin of your character below:", "Submit", "Cancel");
			}
			else for (new i = 0, len = strlen(inputtext); i != len; i ++) {
			    if ((inputtext[i] >= 'A' && inputtext[i] <= 'Z') || (inputtext[i] >= 'a' && inputtext[i] <= 'z') || (inputtext[i] >= '0' && inputtext[i] <= '9') || (inputtext[i] == ' ') || (inputtext[i] == ',') || (inputtext[i] == '.'))
					continue;

				else return ShowPlayerDialog(playerid, DIALOG_ORIGIN, DIALOG_STYLE_INPUT, "Origin", "Error: Only letters and numbers are accepted in the origin.\n\nPlease enter the geographical origin of your character below:", "Submit", "Cancel");
			}
			format(PlayerData[playerid][pOrigin], 32, inputtext);

	  		PlayerTextDrawSetString(playerid, ORIGINTD[playerid], sprintf("%s", PlayerData[playerid][pOrigin]));
	  		SelectTextDraw(playerid, COLOR_YELLOW);
		}
		else
		{
			SelectTextDraw(playerid, COLOR_YELLOW);
		}
	}
/*	if(dialogid == DIALOG_ORIGIN)
	{
	    if(!response)
	        return ShowPlayerDialog(playerid, DIALOG_ORIGIN, DIALOG_STYLE_INPUT, "Character Origin", "Please input your Character Origin:", "Continue", "Quit");

		if(strlen(inputtext) < 1)
		    return ShowPlayerDialog(playerid, DIALOG_ORIGIN, DIALOG_STYLE_INPUT, "Character Origin", "Please input your Character Origin:", "Continue", "Quit");

        format(PlayerData[playerid][pOrigin], 32, inputtext);
        ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Character Gender", "Male\nFemale", "Continue", "Cancel");
	}*/
	if(dialogid == DIALOG_GENDER)
	{
		if(response)
		{
			if(listitem == 0)
			{
				new rand = random(sizeof(g_aMaleSkins));
				PlayerData[playerid][pGender] = 1;
				PlayerData[playerid][pSkin] = g_aMaleSkins[rand];
				PlayerTextDrawSetString(playerid, GENDERTD[playerid], "Male");
				SelectTextDraw(playerid, COLOR_YELLOW);
			}
			if(listitem == 1)
			{
				new rand = random(sizeof(g_aFemaleSkins));
				PlayerData[playerid][pGender] = 2;
				PlayerData[playerid][pSkin] = g_aFemaleSkins[rand];
				PlayerTextDrawSetString(playerid, GENDERTD[playerid], "Female");
				SelectTextDraw(playerid, COLOR_YELLOW);
			}
		}
		else
		{
			SelectTextDraw(playerid, COLOR_YELLOW);
		}
	}
/*	if(dialogid == DIALOG_GENDER)
	{
	    if(!response)
	        return ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Character Gender", "Male\nFemale", "Continue", "Cancel");

		if(listitem == 0)
		{
			new rand = random(sizeof(g_aMaleSkins));
			PlayerData[playerid][pGender] = 1;
			PlayerData[playerid][pSkin] = g_aMaleSkins[rand];
			PlayerData[playerid][pHealth] = 100.0;
			SetupPlayerData(playerid);
		}
		if(listitem == 1)
		{
			new rand = random(sizeof(g_aFemaleSkins));
			PlayerData[playerid][pGender] = 2;
			PlayerData[playerid][pSkin] = g_aFemaleSkins[rand];
			PlayerData[playerid][pHealth] = 100.0;
			SetupPlayerData(playerid);
			
		}
		HideCharacter(playerid);
	}*/
	return 1;
}

public OnVehicleSirenStateChange(playerid, vehicleid, newstate)
{
    if(newstate)
    {
        if(IsPoliceVehicle(vehicleid) || IsMedicVehicle(vehicleid))
        {
            SwitchVehicleLight(vehicleid, true);
        	FlashTime[vehicleid] = SetTimerEx("OnLightFlash", 115, true, "d", vehicleid);
		}
    }

    if(!newstate)
    {
        new panels, doors, lights, tires;

        KillTimer(FlashTime[vehicleid]);

        GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
    	UpdateVehicleDamageStatus(vehicleid, panels, doors, 0, tires);
    }
    return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	new animlib[32], animname[32];
	if(newkeys & KEY_JUMP && !(oldkeys & KEY_JUMP) && GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED && !PlayerData[playerid][pInjured])
	{
		ApplyAnimation(playerid, "GYMNASIUM", "gym_jog_falloff", 4.1, 0, 1, 1, 0, 0);
	}
 	if (newkeys & KEY_CROUCH && IsPlayerInAnyVehicle(playerid))
	{
		cmd_gate(playerid, "\1");

		if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER && GetPlayerWeapon(playerid) >= 22 && GetPlayerWeapon(playerid) <= 38)
		{
		//	SendClientMessage(playerid, -1, "You are now driveby");
		}
	}
    if((newkeys & KEY_JUMP) && !IsPlayerInAnyVehicle(playerid) && !PlayerData[playerid][pAduty] && !PlayerData[playerid][pInjured] && GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_USEJETPACK && !Falling[playerid])
    {
		GetAnimationName(GetPlayerAnimationIndex(playerid),animlib,32,animname,32);
		if(!strcmp(animname,"JUMP_LAND") || !strcmp(animname,"FALL_LAND"))
		{
	        PlayerPressedJump[playerid] ++;
	        SetTimerEx("PressJumpReset", 3000, false, "i", playerid); // Makes it where if they dont spam the jump key, they wont fall

	        if(PlayerPressedJump[playerid] >= 3) // change 3 to how many jump you want before they fall
	        {
	            ApplyAnimation(playerid, "PED", "BIKE_fall_off", 4.1, 0, 1, 1, 1, 0, 1); // applies the fallover animation
	            SetTimerEx("PressJump", 5000, false, "i", playerid); // Timer for how long the animation lasts
	            ShowText(playerid, "~n~~r~Bunny-hop not allowed!", 3);
	            Falling[playerid] = true;
	        }
	    }
    }
	if(newkeys & KEY_CTRL_BACK)
	{
		new wid = Weed_Nearest(playerid), id;
		if(wid != -1)
		{
			if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
				return SendErrorMessage(playerid, "You must be on-foot!");

			if(WeedData[wid][weedGrow] < MAX_GROW)
				return SendErrorMessage(playerid, "Please wait %d minute for harvest.", MAX_GROW-WeedData[wid][weedGrow]);

			if(WeedData[wid][weedHarvested])
				return SendErrorMessage(playerid, "Weed ini sedang di harvest.");

			if(IsValidLoading(playerid))
				return SendErrorMessage(playerid, "You can't do this at the moment!");

			SetPlayerFace(playerid, WeedData[wid][weedPos][0], WeedData[wid][weedPos][1]);

			ApplyAnimation(playerid, "COP_AMBIENT", "Copbrowse_loop", 4.1, 1, 0, 0, 1, 0, 1);
			WeedData[wid][weedHarvested] = true;
			CreatePlayerLoadingBar(playerid, 10, "Harvesting_weed...");
			SetTimerEx("HarvestWeed", 10000, false, "dd", playerid, wid);
			SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s begins to harvest the weed.", ReturnName(playerid));
		}
		if(Tree_Nearest(playerid) != -1)
		{
			id = Tree_Nearest(playerid);

			if(PlayerData[playerid][pJob] != JOB_LUMBERJACK)
				return SendErrorMessage(playerid, "You are not work as Lumberjack!");

			if(TreeData[id][treeTime] > 0)
				return SendErrorMessage(playerid, "This tree still unavailable!");

			if(!PlayerData[playerid][pAxe])
				return SendErrorMessage(playerid, "You must holding Axe!");

			if(TreeData[id][treeCut])
				return SendErrorMessage(playerid, "Unable to execute this tree! (being interacted with another player)");

			if(IsValidLoading(playerid))
				return SendErrorMessage(playerid, "Can't do this at the moment.");

			if(!TreeData[id][treeCutted])
			{
				if(TreeData[id][treeProgress] < 100)
				{
					SetPlayerFace(playerid, TreeData[id][treePos][0], TreeData[id][treePos][1]);
					SetTimerEx("CutTree", 3000, false, "dd", playerid, id);
					CreatePlayerLoadingBar(playerid, 3, "Cutting_down_Tree...");
					TogglePlayerControllable(playerid, 0);
					ApplyAnimation(playerid,"BASEBALL", "Bat_M", 4.1, 1, 0, 0, 1, 0, 1);
					TreeData[id][treeCut] = true;
				}
			}
			else
			{
				new vnear = GetNearestVehicle(playerid, 5.0);
				if(vnear == INVALID_VEHICLE_ID)
					return SendErrorMessage(playerid, "You must close to Lumberjack vehicle!");

				if(!IsLumberVehicle(vnear))
					return SendErrorMessage(playerid, "You must close to Lumberjack vehicle!");

				if(VehCore[vnear][vehWood] >= GetMaxWood(vnear))
					return SendErrorMessage(playerid, "The vehicle is already loaded full of Timber! (%d/%d)", VehCore[vnear][vehWood], GetMaxWood(vnear));

				SetPlayerFace(playerid, TreeData[id][treePos][0], TreeData[id][treePos][1]);
				SetTimerEx("CreateTimber", 10000, false, "ddd", playerid, id, vnear);
				CreatePlayerLoadingBar(playerid, 10, "Processing_Timber...");
				TreeData[id][treeCut] = true;
				TogglePlayerControllable(playerid, 0);
				ApplyAnimation(playerid,"BOMBER","BOM_Plant_Loop", 4.1, 1, 0, 0, 1, 0, 1);
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 3.0, -2109.1277,-2408.5168,31.3128))//schematic
		{
			if(PlayerData[playerid][pLevel] < 3)
				return SendErrorMessage(playerid, "Minimal level 3 untuk melakukan ini!");

			ShowPlayerDialog(playerid, DIALOG_BM_SCHEMATIC, DIALOG_STYLE_LIST, "Schematic Store", "9mm Silenced schematic | Price: $1,700.00\nShotgun schematic | Price: $3,000.00", "Buy", "Close");
		}
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 2503.6985,-2640.4846,13.8623))
		{
			if(PlayerData[playerid][pLevel] < 3)
				return SendErrorMessage(playerid, "Minimal level 3 untuk melakukan ini!");

			ShowPlayerDialog(playerid, DIALOG_BM_CLIP, DIALOG_STYLE_LIST, "Gun Clip Store", "9mm Luger | 17 rounds / 1 Clip | Price: $47.n00\n12 Gauge | 12 rounds / 1 Clip | Price: $69.00", "Buy", "Close");
		}
		if(IsPlayerInRangeOfPoint(playerid, 3.0,2711.0886,-2195.4951,13.5469))
		{
			if(PlayerData[playerid][pLevel] < 3)
				return SendErrorMessage(playerid, "Minimal level3 untuk melakukan ini!");

			ShowPlayerDialog(playerid, DIALOG_BM_MATERIAL, DIALOG_STYLE_LIST, "Material Store", "9mm Silenced | Price: $100.00\nShotgun | Price: $250.00", "Buy", "Close");
		}
		forex(i, MAX_VENDOR) if(IsPlayerInDynamicCP(playerid, VendorData[i][vendorCP]) && PlayerData[playerid][pVendor] == -1 && !IsVendorUsed(i))
		{
			PlayerData[playerid][pVendor] = i;
			SendClientMessage(playerid, COLOR_SERVER, "SIDEJOB: {FFFFFF}Kamu mulai bekerja sebagai {FFFF00}Food Vendor");
			SetupPlayerVendor(playerid);
		}
	}
	if (newkeys & KEY_SPRINT && PlayerData[playerid][pSpawned] && PlayerData[playerid][pLoopAnim])
	{
	    ClearAnimations(playerid);

	    PlayerData[playerid][pLoopAnim] = false;
	}
	if(PRESSED(KEY_FIRE))
	{
	    if(PlayerData[playerid][pSpraying] && GetPlayerWeapon(playerid) == 41 && PlayerData[playerid][pJob] == JOB_MECHANIC)
	    {     
	        ShowMessage(playerid, sprintf("~g~Spray the Vehicle: ~y~%d/15", PlayerData[playerid][pColoring]), 1);
	        PlayerData[playerid][pSprayTime] = SetTimerEx("SprayTimer", 1000, true, "dd", playerid,PlayerData[playerid][pVehicle]);
	        PlayerData[playerid][pSpraying] = true;
		}
	}
	if(newkeys & KEY_SUBMISSION)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			cmd_v(playerid, "lock");
		}
	}
	if((newkeys & KEY_FIRE) && PlayerData[playerid][pTazer] && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		new Float:X, Float:Y, Float:Z;
		foreach(new i : Player)
		{
		    if(IsPlayerStreamedIn(i, playerid) && i != playerid)
		    {
			    GetPlayerPos(i, X, Y, Z);
				if(IsPlayerAimingAt(playerid,X,Y,Z,1) && IsPlayerInRangeOfPoint(playerid, 1.5, X, Y, Z) && !PlayerData[i][pTazed] && GetPlayerState(i) == PLAYER_STATE_ONFOOT && (GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i)))
				{
		    		TogglePlayerControllable(i, 0);
					PlayerPlaySound(i, 6003, 0,0,0);
					PlayerPlaySound(playerid, 6003, 0,0,0);
					PlayerData[i][pTazed] = true;
					ApplyAnimation(i, "CRACK", "crckdeth4", 4.1, 0, 0, 0, 1, 0, 1);
					SetTimerEx("UnTazer", 5000, false, "d", i);
					SetPlayerChatBubble(i, "(( TAZED ))", COLOR_YELLOW, 15.0, 5000);
				}
			}
		}
	}
	if(RELEASE(KEY_FIRE))
	{
	    if(PlayerData[playerid][pSpraying] && PlayerData[playerid][pJob] == JOB_MECHANIC)
	    {
	        KillTimer(PlayerData[playerid][pSprayTime]);
		}
	}
	if(newkeys & KEY_NO)
	{
		if (GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_DUCK)
		{
		    new
				count = 0,
				id = Item_Nearest(playerid),
		        string[320];

		    if (id != -1)
		    {
		        string = "";

		        for (new i = 0; i < MAX_DROPPED_ITEMS; i ++) if (count < MAX_LISTED_ITEMS && DroppedItems[i][droppedModel] && IsPlayerInRangeOfPoint(playerid, 1.5, DroppedItems[i][droppedPos][0], DroppedItems[i][droppedPos][1], DroppedItems[i][droppedPos][2]) && GetPlayerInterior(playerid) == DroppedItems[i][droppedInt] && GetPlayerVirtualWorld(playerid) == DroppedItems[i][droppedWorld]) {
		            NearestItems[playerid][count++] = i;

		            strcat(string, DroppedItems[i][droppedItem]);
		            strcat(string, "\n");
		        }
		        if (count == 1)
		        {
					if (PickupItem(playerid, id))
					{
			    		format(string, sizeof(string), "~g~%s~w~ added to inventory!", DroppedItems[id][droppedItem]);
			    		ShowMessage(playerid, string, 2);
						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has picked up a \"%s\".", ReturnName(playerid), DroppedItems[id][droppedItem]);
					}
					else
						SendErrorMessage(playerid, "You don't have any slot left in your inventory.");
				}
				else ShowPlayerDialog(playerid, DIALOG_PICKITEM, DIALOG_STYLE_LIST, "Pickup Items", string, "Pickup", "Cancel");
			}
		}
		cmd_v(playerid, "engine");
	}
	if(newkeys & KEY_YES)
	{
	    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    {
			cmd_inventory(playerid, "");
		}
	}
	if((newkeys & KEY_SECONDARY_ATTACK ))
	{
		return cmd_enter(playerid, "");
	}
	return 1;
}

stock SetValidColor(playerid)
{
	if(!PlayerData[playerid][pOnDuty])
	{
		if(PlayerData[playerid][pJobduty])
		{
			if(PlayerData[playerid][pJob] == JOB_MECHANIC)
			{
				SetPlayerColor(playerid, COLOR_LIGHTGREEN);
			}
			else if(PlayerData[playerid][pJob] == JOB_TAXI)
			{
				SetPlayerColor(playerid, COLOR_YELLOW);
			}
		}
		else
		{
			SetPlayerColor(playerid, COLOR_WHITE);
		}
		SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);
	}
	else
	{
		SetFactionColor(playerid);
		SetPlayerSkin(playerid, PlayerData[playerid][pFactionSkin]);
	}
	return 1;
}
public OnPlayerSpawn(playerid)
{
	if(!PlayerData[playerid][pSpawned])
	{
	    PlayerData[playerid][pSpawned] = true;
	    PlayerData[playerid][pAdmin] = UcpData[playerid][ucpAdmin];
	    KillTimer(LoginTimer[playerid]);
	    GivePlayerMoney(playerid, PlayerData[playerid][pMoney]);
	    SetPlayerHealth(playerid, PlayerData[playerid][pHealth]);
	    SetPlayerArmour(playerid, PlayerData[playerid][pArmor]);
	    SetPlayerScore(playerid, PlayerData[playerid][pLevel]);
	    SetPlayerVirtualWorld(playerid, PlayerData[playerid][pWorld]);
		SetPlayerInterior(playerid, PlayerData[playerid][pInterior]);
		PlayerTextDrawSetString(playerid, CASHTEXT[playerid], sprintf("$%s", FormatNumber(PlayerData[playerid][pMoney])));
		TogglePlayerControllable(playerid, 0);
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x,y,z);
		PlayerData[playerid][pFreeze] = 1;
		PlayerData[playerid][pFreezeTimer] = SetTimerEx("SetPlayerToUnfreeze", 3000, false, "iffff", playerid, x,y,z);
		
		forex(i, 8)
		{
			PlayerTextDrawShow(playerid, HUDTD[playerid][i]);
		}
		forex(i, 3)
		{
			PlayerTextDrawShow(playerid, LOGOTD[playerid][i]);
		}
		PlayerTextDrawShow(playerid, TIMETD[playerid]);
		PlayerTextDrawShow(playerid, THIRSTTD[playerid]);
		PlayerTextDrawShow(playerid, THRISTTEXT[playerid]);
		PlayerTextDrawShow(playerid, HUNGERTD[playerid]);
		PlayerTextDrawShow(playerid, HUNGERTEXT[playerid]);
		PlayerTextDrawShow(playerid, CASHTEXT[playerid]);

		TextDrawShowForPlayer(playerid,sen);
		TextDrawShowForPlayer(playerid,koma2);

		SetValidColor(playerid);
		SendClientMessageEx(playerid, -1, "Hello {629eda}%s{FFFFFF}, Welcome back to {62da92}Revitalize Roleplay!", PlayerData[playerid][pUCP]);
		SendClientMessageEx(playerid, -1, "You are logged in as a {daba62}Level %d player {FFFFFF}and playing as {629eda}%s", PlayerData[playerid][pLevel], ReturnName(playerid));
		SendClientMessage(playerid, -1, "");

		SendLoginMessage(playerid);
		SendClientMessageEx(playerid, -1, "{00FFFF}MOTD: {FFFF00}%s", MotdData[motdPlayer]);
		if(PlayerData[playerid][pAdmin] > 0)
		{
			SendClientMessageEx(playerid, -1, "{FF0000}AMOTD: {FFFF00}%s", MotdData[motdAdmin]);
		}
	}
	if(PlayerData[playerid][pJailTime] > 0)
	{
	    if (PlayerData[playerid][pArrest])
	    {
	        SetPlayerArrest(playerid);
	    }
	    else
	    {
		    SetPlayerPos(playerid, 197.6346, 175.3765, 1003.0234);

		    SetPlayerInterior(playerid, 3);

		    SetPlayerVirtualWorld(playerid, (playerid + 100));
		    SetPlayerFacingAngle(playerid, 0.0);
            PlayerTextDrawShow(playerid, JAILTD[playerid]);
		    SetCameraBehindPlayer(playerid);
		}

	    SendServerMessage(playerid, "You have %d seconds of remaining jail time.", PlayerData[playerid][pJailTime]);
	}
    else if(PlayerData[playerid][pDead] && PlayerData[playerid][pJailTime] < 1)
    {
		PlayerData[playerid][pInjured] = false;
		PlayerData[playerid][pDead] = false;
		ClearAnimations(playerid);
		
	    SetSpawnInfo(playerid, 0, PlayerData[playerid][pSkin], 1179.9133,-1327.0813,14.2512, 0.0, 0, 0, 0, 0, 0, 0);
        SpawnPlayer(playerid);
		        
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerHealth(playerid, 100);
		SetPlayerFacingAngle(playerid, 271.9647);
		SetCameraBehindPlayer(playerid);
		ResetWeapons(playerid);
		SetPlayerHealth(playerid, 100);
        TogglePlayerControllable(playerid, 1);
		SendServerMessage(playerid, "You have been respawned at {FFFF00}All Saints General Hospital {FFFFFF}and fined {FF0000}$50.00");
		GiveMoney(playerid, -5000);
		ResetDamages(playerid);
	}
	else
	{
		SetValidColor(playerid);
		SetPlayerVirtualWorld(playerid, PlayerData[playerid][pWorld]);
		SetPlayerInterior(playerid, PlayerData[playerid][pInterior]);
		AttachPlayerToys(playerid); 
		SetWeapons(playerid);

		if(IsValidDynamic3DTextLabel(PlayerData[playerid][pInjuredLabel]))
			DestroyDynamic3DTextLabel(PlayerData[playerid][pInjuredLabel]);
	
		if(PlayerData[playerid][pInjured] && PlayerData[playerid][pJailTime] < 1)
		{
		    SetPlayerPos(playerid, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]);
			ApplyAnimation(playerid, "WUZI", "CS_DEAD_GUY", 4.1, 0, 0, 0, 1, 0, 1);
			PlayerData[playerid][pInjured] = true;
			SetPlayerHealth(playerid, 100);
			PlayerData[playerid][pInjuredTime] = 600;
			SendClientMessage(playerid, COLOR_LIGHTRED, "WARNING: {FFFFFF}You have been {E20000}downed.{FFFFFF} You may choose to {44C300}/accept death");
			SendClientMessage(playerid, COLOR_WHITE, "...after your death timer expires or wait until you are revived.");

			PlayerData[playerid][pInjuredLabel] = CreateDynamic3DTextLabel("(( THIS PLAYER IS INJURED ))", COLOR_LIGHTRED, 0.0, 0.0, 0.50, 15.0, playerid);
		}
	}
	return 1;
}


public OnPlayerShootRightLeg(playerid, targetid, Float:amount, weaponid)
{
	PlayerData[targetid][pBullets][5]++;
	if(PlayerData[targetid][pDamages][5] > 0)
	{
	    PlayerData[targetid][pDamages][5] -= amount;
	}
	else if(PlayerData[targetid][pDamages][5] <= 0)
	{
 		PlayerData[targetid][pDamages][5] = 0.0;
	}
	if(!IsPlayerInAnyVehicle(playerid))
		ApplyAnimation(targetid,"ped","FALL_COLLAPSE",4.1,0,1,1,0,0,1);
    return 1;
}

public OnPlayerShootLeftLeg(playerid, targetid, Float:amount, weaponid)
{
	PlayerData[targetid][pBullets][6]++;
	if(PlayerData[targetid][pDamages][6] > 0)
	{
	    PlayerData[targetid][pDamages][6] -= amount;
	}
	else if(PlayerData[targetid][pDamages][6] <= 0)
	{
 		PlayerData[targetid][pDamages][6] = 0;
	}
	if(!IsPlayerInAnyVehicle(playerid))
    	ApplyAnimation(targetid,"ped","FALL_COLLAPSE",4.1,0,1,1,0,0,1);
    return 1;
}
public OnPlayerShootHead(playerid, targetid, Float:amount, weaponid)
{
	PlayerData[targetid][pBullets][0]++;
	SetTimerEx("HidePlayerBox", 500, false, "dd", targetid, _:ShowPlayerBox(targetid, 0xFF000066));
	if(PlayerData[targetid][pDamages][0] > 0)
	{
	    PlayerData[targetid][pDamages][0] -= amount;
	}
    else if(PlayerData[targetid][pDamages][0] < 0)
    {
 		PlayerData[targetid][pDamages][0] = 0;
	}
    return 1;
}
public OnPlayerShootGroin(playerid, targetid, Float:amount, weaponid)
{
	PlayerData[targetid][pBullets][3]++;
	if(PlayerData[targetid][pDamages][3] > 0)
	{
	    PlayerData[targetid][pDamages][3] -= amount;
	}
    else if(PlayerData[targetid][pDamages][3] < 0)
    {
        PlayerData[targetid][pDamages][3] = 0;
	}
    return 1;
}
public OnPlayerShootTorso(playerid, targetid, Float:amount, weaponid)
{
	PlayerData[targetid][pBullets][1]++;
	if(PlayerData[targetid][pDamages][1] > 0)
	{
	    PlayerData[targetid][pDamages][1] -= amount;
	}
    else if(PlayerData[targetid][pDamages][1] < 0)
    {
        PlayerData[targetid][pDamages][1] = 0;
	}
    return 1;
}

public OnPlayerShootLeftArm(playerid, targetid, Float:amount, weaponid)
{
	PlayerData[targetid][pBullets][3]++;
	if(PlayerData[targetid][pDamages][3] > 0)
	{
	    PlayerData[targetid][pDamages][3] -= amount;
	}
    else if(PlayerData[targetid][pDamages][3] < 0)
    {
        PlayerData[targetid][pDamages][3] = 0;
	}
    return 1;
}

public OnPlayerShootRightArm(playerid, targetid, Float:amount, weaponid)
{
	PlayerData[targetid][pBullets][2]++;
	if(PlayerData[targetid][pDamages][2] > 0)
	{
	    PlayerData[targetid][pDamages][2] -= amount;
	}
    else if(PlayerData[targetid][pDamages][2] < 0)
    {
        PlayerData[targetid][pDamages][2] = 0;
	}
    return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
    if (PlayerData[playerid][pMasked])
		ShowPlayerNameTagForPlayer(forplayerid, playerid, 0), UpdatePlayerMask(playerid);
	else
	    ShowPlayerNameTagForPlayer(forplayerid, playerid, 1);
	return 1;
}

public OnPlayerFall(playerid, Float:damage)
{
	new Float:hp;
	GetPlayerHealth(playerid, hp);
	if(hp - damage <= 7.0)
	{
		InjuredPlayer(playerid, INVALID_PLAYER_ID, WEAPON_COLLISION);
	}
	return 1;
}
public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{
    new Float:health,
		Float:armour;

	GetPlayerHealth(damagedid, health);
	GetPlayerArmour(damagedid, armour);
	if(damagedid != INVALID_PLAYER_ID)
	{
		new Float:damage;
		switch(weaponid)
		{
		    case 0: damage = 2.0; // Fist
			case 1: damage = 5.0; // Brass Knuckles
			case 2: damage = 5.0;   // Golf Club
			case 3: damage = 5.0; // Nightstick
			case 4: damage = 7.0; // Knife
			case 5: damage = 5.0; // Baseball Bat
			case 6: damage = 5.0; // Shovel
			case 7: damage = 5.0; // Pool Cue
			case 8: damage = 8.0; // Katana
			case 9: damage = 10.0; // Chainsaw
			case 14: damage = 2.0; // Flowers
			case 15: damage = 5.0; // Cane
			case 16: damage = 50.0; // Grenade
			case 18: damage = 20.0; // Molotov
			case 22: damage = float(RandomEx(15, 20)); // Colt45
			case 23, 28, 29, 32: damage = float(RandomEx(17, 23)); // SD Pistol, UZI, MP5, Tec
			case 24: damage = float(RandomEx(38, 43)); // Desert Eagle
			case 25, 26, 27: // Shotgun, Sawnoff Shotgun, CombatShotgun
			{
			    new Float: p_x, Float: p_y, Float: p_z;
			    GetPlayerPos(playerid, p_x, p_y, p_z);
			    new Float: dist = GetPlayerDistanceFromPoint(damagedid, p_x, p_y, p_z);

			    if (dist < 5.0)
					damage = float(RandomEx(50, 55));

				else if (dist < 10.0)
					damage = float(RandomEx(23, 35));

				else if (dist < 15.0)
					damage = float(RandomEx(15, 25));

				else if (dist < 20.0)
					damage = float(RandomEx(10, 15));

				else if (dist < 30.0)
					damage = float(RandomEx(5, 8));
			}
			case 30: damage = float(RandomEx(20, 25)); // AK47
			case 31: damage = float(RandomEx(20, 22)); // M4A1
			case 33, 34: damage = float(RandomEx(70, 75)); // Country Rifle, Sniper Rifle
			case 35: damage = 0.0; // RPG
			case 36: damage = 0.0; // HS Rocket
			case 38: damage = 0.0; // Minigun
		}

        if(bodypart == BODY_PART_TORSO && armour > 0.0 && (22 <= weaponid <= 38))
		{
		    if(armour - damage <= 7.0)
				SetPlayerArmour(damagedid, 0.0);
	 		else
			 	SetPlayerArmour(damagedid, armour - damage);

            SetPlayerHealth(damagedid, health);
		}
		else
		{
		    if(health - damage <= 7.0)
				InjuredPlayer(damagedid, playerid, weaponid);
			else
			{
				if(health <= 30.0)
				{
					SetPlayerHealth(damagedid, health - damage / 2); 
				}
				else
				{
					SetPlayerHealth(damagedid, health - damage);
				}
			}

			if(armour)
			    SetPlayerArmour(damagedid, armour);
		}
	}
	else
	{
	    if(health - amount <= 7.0)
			InjuredPlayer(damagedid, playerid, weaponid);
	}
	return 1;
}
public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	if(weaponid != 54)
	{
		Damage[playerid][(bodypart - 3)][weaponid]++;
		DamageTime[playerid][(bodypart - 3)][weaponid] = gettime();
	}
	if (PlayerData[playerid][pFirstAid])
	{
	    SendClientMessage(playerid, COLOR_LIGHTRED, "WARNING:{FFFFFF} Your first aid kit is no longer in effect as you took damage.");

        PlayerData[playerid][pFirstAid] = false;
		KillTimer(PlayerData[playerid][pAidTimer]);
	}
	if(PlayerData[playerid][pMasked]) 
		UpdatePlayerMask(playerid);
	
	return 1;
}

public OnPlayerText(playerid, text[])
{
	text[0] = toupper(text[0]);

	if(!PlayerData[playerid][pSpawned])
	{
		SendErrorMessage(playerid, "You're not spawned!");
		return 0;
	}
	if(PlayerData[playerid][pAduty] && PlayerData[playerid][pAdmin] > 0)
	{
		SendNearbyMessage(playerid, 30.0, COLOR_RED, "{FF0000}%s: {FFFFFF}(( %s ))", PlayerData[playerid][pUCP], text);
		return 0;
	}
	if(ServiceIndex[playerid] != 0)
	{
		ProcessServiceCall(playerid, text);
		return 0;
	}
	if(PlayerData[playerid][pCallLine] != INVALID_PLAYER_ID && !PlayerData[playerid][pIncomingCall])
	{
		new lstr[1024];
		format(lstr, sizeof(lstr), "(Phone) %s says: %s", ReturnName(playerid), text);
		ProxDetector(20.0, playerid, lstr, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
		SetPlayerChatBubble(playerid, text, COLOR_WHITE, 10.0, 3000);

		SendClientMessageEx(PlayerData[playerid][pCallLine], COLOR_YELLOW, "(Phone) Caller says: %s", text);
		return 0;
	}
	else
	{
		new lstr[1024];
		format(lstr, sizeof(lstr), "%s says: %s", ReturnName(playerid), text);
		ProxDetector(20.0, playerid, lstr, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
		SetPlayerChatBubble(playerid, text, COLOR_WHITE, 10.0, 3000);
		if(!IsPlayerInAnyVehicle(playerid) && !PlayerData[playerid][pInjured] && !PlayerData[playerid][pLoopAnim] && !PlayerData[playerid][pTogAnim])
		{
			ApplyAnimation(playerid, "GANGS", "prtial_gngtlkA", 4.1, 0, 1, 1, 1, strlen(text) * 100, 1);
			SetTimerEx("StopChatting", strlen(text) * 100, false, "d", playerid);
		}
		return 0;
	}
}


public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
{
	if(VehCore[vehicleid][vehHandbrake])
	{
		if(VehCore[vehicleid][vehHandbrakePos][0] != new_x && VehCore[vehicleid][vehHandbrakePos][1] != new_y && VehCore[vehicleid][vehHandbrakePos][2] != new_z)
		{
			SetVehiclePos(vehicleid, VehCore[vehicleid][vehHandbrakePos][0], VehCore[vehicleid][vehHandbrakePos][1], VehCore[vehicleid][vehHandbrakePos][2]);
			SetVehicleZAngle(vehicleid, VehCore[vehicleid][vehHandbrakePos][3]);
		}
	}
	return 1;
}
public OnVehicleSpawn(vehicleid)
{
	foreach(new i : PlayerVehicle)
	{
		if(vehicleid == VehicleData[i][vVehicle] && IsValidVehicle(VehicleData[i][vVehicle]))
		{
		    if(VehicleData[i][vRental] == -1)
		    {
				if(VehicleData[i][vInsurance] > 0)
	    		{
					VehicleData[i][vInsurance] --;
					VehicleData[i][vInsuTime] = gettime() + (1 * 86400);
					VehicleData[i][vInsuranced] = true;

					foreach(new pid : Player) if (VehicleData[i][vOwner] == PlayerData[pid][pID])
	        		{
	            		SendServerMessage(pid, "Kendaraan {00FFFF}%s {FFFFFF}milikmu telah hancur, kamu bisa Claim setelah 24 jam dari Insurance.", GetVehicleName(vehicleid));
					}
					forex(z, MAX_CRATES) if(CrateData[z][crateExists] && CrateData[z][crateVehicle] == VehicleData[i][vID])
					{
						Crate_Delete(z);
					}
					if(IsValidVehicle(VehicleData[i][vVehicle]))
						DestroyVehicle(VehicleData[i][vVehicle]);

					VehicleData[i][vVehicle] = INVALID_VEHICLE_ID;
				}
				else
				{
					foreach(new pid : Player) if (VehicleData[i][vOwner] == PlayerData[pid][pID])
	        		{
	            		SendServerMessage(pid, "Kendaraan {00FFFF}%s {FFFFFF}milikmu telah hancur dan tidak akan dan tidak memiliki Insurance lagi.", GetVehicleName(vehicleid));
					}
					forex(z, MAX_CRATES) if(CrateData[z][crateExists] && CrateData[z][crateVehicle] == VehicleData[i][vID])
					{
						Crate_Delete(z);
					}					
					Vehicle_Delete(i);
				}
			}
			else
			{
				foreach(new pid : Player) if (VehicleData[i][vOwner] == PlayerData[pid][pID])
        		{
        		    GiveMoney(pid, -250);
            		SendServerMessage(pid, "Kendaraan Rental milikmu (%s) telah hancur, kamu dikenai denda sebesar {009000}$250.0!", GetVehicleName(vehicleid));
				}
				forex(z, MAX_CRATES) if(CrateData[z][crateExists] && CrateData[z][crateVehicle] == VehicleData[i][vID])
				{
					Crate_Delete(z);
				}
				Vehicle_Delete(i);
			}
		}
	}
	return 1;
}
#include "legacy\timer.pwn"