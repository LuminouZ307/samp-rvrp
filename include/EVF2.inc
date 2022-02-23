/**********************************************************************************************************************************
 *                                                                                                                                *
 *                                              )(   Extended Vehicle Functions   )(                                              *
 *                                                                                                                                *
 * Copyright © 2019 Abyss Morgan. All rights reserved.                                                                            *
 * Contributors: Emmet_, Pottus, kvann, Hanger, Freaksken, Gammix, Yashas, Admigo, RIDE2DAY, Unrea1, Katarina Calzaghe            *
 *                                                                                                                                *
 * Website:  adm.ct8.pl                                                                                                           *
 * Download: adm.ct8.pl/r/download                                                                                                *
 *                                                                                                                                *
 * Plugins: Streamer                                                                                                              *
 * Modules: None                                                                                                                  *
 *                                                                                                                                *
 * File Version: 3.3.3                                                                                                            *
 * Streamer Version: 2.9.4                                                                                                        *
 *                                                                                                                                *
 * Functions:                                                                                                                     *
 * IsValidVehicleModelID(modelid);                                                                                                *
 * GetVehiclePanels(vehicleid,&front_left,&front_right,&rear_left,&rear_right,&windshield,&front_bumper,&rear_bumper);            *
 * SetVehiclePanels(vehicleid,front_left,front_right,rear_left,rear_right,windshield,front_bumper,rear_bumper);                   *
 * GetVehicleLights(vehicleid,&front_left_light,&front_right_light,&back_lights);                                                 *
 * SetVehicleLights(vehicleid,front_left_light,front_right_light,back_lights);                                                    *
 * GetVehicleDoors(vehicleid,&bonnet,&boot,&driver_door,&passenger_door);                                                         *
 * SetVehicleDoors(vehicleid,bonnet,boot,driver_door,passenger_door);                                                             *
 * GetVehicleTires(vehicleid,&front_left,&front_right,&rear_left,&rear_right);                                                    *
 * SetVehicleTires(vehicleid,front_left,front_right,rear_left,rear_right);                                                        *
 * GetVehicleWindowState(vehicleid,doorid);                                                                                       *
 * SetVehicleWindowState(vehicleid,doorid,window_state);                                                                          *
 * GetVehicleDoorState(vehicleid,doorid);                                                                                         *
 * SetVehicleDoorState(vehicleid,doorid,door_state);                                                                              *
 * IsValidVehicleDoor(vehicleid,doorid);                                                                                          *
 * GetVehicleModelDoorAmount(modelid);                                                                                            *
 * GetVehicleDoorAmount(vehicleid);                                                                                               *
 * SwitchVehicleEngine(vehicleid,bool:engine_status);                                                                             *
 * SwitchVehicleLight(vehicleid,bool:light_status);                                                                               *
 * SwitchVehicleAlarm(vehicleid,bool:alarm_status);                                                                               *
 * SwitchVehicleDoors(vehicleid,bool:doors_status);                                                                               *
 * SwitchVehicleBonnet(vehicleid,bool:bonnet_status);                                                                             *
 * SwitchVehicleBoot(vehicleid,bool:boot_status);                                                                                 *
 * SwitchVehicleObjective(vehicleid,bool:objective_status);                                                                       *
 * GetVehicleParams(vehicleid,type);                                                                                              *
 * SetVehicleParams(vehicleid,type,status,delay = 0);                                                                             *
 * GetVehicleRandomColors(modelid,&color1,&color2);                                                                               *
 * GetNearestVehicleToPos(Float:x,Float:y,Float:z,worldid=-1,interiorid=-1,Float:maxdist=0.0,bool:fast=true,except_vid=0);        *
 * GetNearestVehicleToPlayer(playerid,Float:maxdist=0.0,bool:fast=false);                                                         *
 * GetVehicleDriver(vehicleid);                                                                                                   *
 * Float:GetVehicleModelTopSpeed(modelid);                                                                                        *
 * Float:GetVehicleTopSpeed(vehicleid);                                                                                           *
 * SetVehicleInterior(vehicleid,interiorid);                                                                                      *
 * GetVehicleSeats(vehicleid);                                                                                                    *
 * GetVehicleModelSeats(modelid);                                                                                                 *
 * IsVehicleSeatOccupied(vehicleid,seatid);                                                                                       *
 * IsValidVehicle(vehicleid);                                                                                                     *
 * RemoveVehiclePaintjob(vehicleid);                                                                                              *
 * SetVehicleHorn(vehicleid,soundid);                                                                                             *
 * GetVehicleHorn(vehicleid);                                                                                                     *
 * RestoreVehicleHorn(vehicleid);                                                                                                 *
 * GetVehicleBomb(vehicleid);                                                                                                     *
 * IsVehicleBombed(vehicleid);                                                                                                    *
 * RemoveVehicleBomb(vehicleid);                                                                                                  *
 * SetVehicleBomb(vehicleid,time = 1000);                                                                                         *
 * IsVehicleBombActivated(vehicleid);                                                                                             *
 * Float:EVF::GetVehicleSpeed(vehicleid);                                                                                         *
 * SetVehicleSpeedCap(vehicleid,Float:maxspeed);                                                                                  *
 * Float:GetVehicleSpeedCap(vehicleid);                                                                                           *
 * DisableVehicleSpeedCap(vehicleid);                                                                                             *
 * SetVehicleFuel(vehicleid,fuel);                                                                                                *
 * GetVehicleFuel(vehicleid);                                                                                                     *
 * ToggleVehicleFuel(vehicleid,bool:toggle);                                                                                      *
 * IsVehicleFuelToggled(vehicleid);                                                                                               *
 * ToggleVehicleSticky(vehicleid,bool:toggle);                                                                                    *
 * IsVehicleSticky(vehicleid);                                                                                                    *
 * ToggleUnoccupiedVehicleDamage(vehicleid,bool:toggle);                                                                          *
 * IsUnoccupiedDamageToggled(vehicleid);                                                                                          *
 * IsVehicleDamageToggled(vehicleid,type);                                                                                        *
 * ToggleVehicleDamageUpdate(vehicleid,type,toggle);                                                                              *
 * GetVehicleNextSeat(vehicleid,passenger = 1);                                                                                   *
 * TeleportVehicle(vehicleid,Float:x,Float:y,Float:z,Float:angle,worldid = -1,interiorid = -1);                                   *
 * GetVehicleSlotAttachedObject(vehicleid,slot);                                                                                  *
 * IsObjectAttachedToVehicle(objectid,vehicleid);                                                                                 *
 * EVF::UpdateVehicleDamage(vehicleid,type);                                                                                      *
 * EVF::UpdateVehicleDamageStatus(vehicleid,type,update);                                                                         *
 * EVF::GetVehicleDamageStatus(vehicleid,type);                                                                                   *
 * SetVehicleNeonLights(vehicleid,bool:enable = true,color = RED_NEON,slotid = 0);                                                *
 * VehicleSupportsNeonLights(modelid);                                                                                            *
 * GetVehicleNeonLightsState(vehicleid,slotid = 0);                                                                               *
 * IsToggledVehicleBulletproof(vehicleid);                                                                                        *
 * ToggleVehicleBulletproof(vehicleid,bool:toggle);                                                                               *
 * GetComponentName(componentid,name[],len = sizeof(name));                                                                       *
 * GetComponentTypeName(component);                                                                                               *
 * EVF::IsPlayerInModShop(playerid);                                                                                              *
 * IsValidComponentForVehicle(vehicleid,componentid);                                                                             *
 * GetVehicleComponentPrice(componentid);                                                                                         *
 * GetVehicleName(vehicleid);                                                                                                     *
 * GetVehicleModelName(modelid);                                                                                                  *
 * EVF::IsTrailer(vehicleid);                                                                                                     *
 * EVF::IsCarBlinking(vehicleid);                                                                                                 *
 * EVF::DisableCarBlinking(vehicleid);                                                                                            *
 * EVF::SetCarBlinking(vehicleid,side,bool:skip=false);                                                                           *
 * EVF::ToggleVehicleBlinking(bool:toggle);                                                                                       *
 * EVF::IsToggledVehicleBlinking();                                                                                               *
 *                                                                                                                                *
 * Remote functions:                                                                                                              *
 * EVF_ImportVehicle(vehicleid,modelid,Float:x,Float:y,Float:z,Float:angle,color1,color2,worldid,interiorid,unoccupied_damage);   *
 * EVF_RemoveVehicle(vehicleid);                                                                                                  *
 *                                                                                                                                *
 * Compatible with YSF Functions:                                                                                                 *
 * GetVehicleColor(vehicleid,&color1,&color2);                                                                                    *
 * GetVehiclePaintjob(vehicleid);                                                                                                 *
 * GetVehicleInterior(vehicleid);                                                                                                 *
 * EVF::GetVehicleSpawnInfo(vehicleid,&Float:x,&Float:y,&Float:z,&Float:rotation,&worldid,&interiorid);                           *
 * EVF::SetVehicleSpawnInfo(vehicleid,Float:x,Float:y,Float:z,Float:rotation,worldid,interiorid);                                 *
 * IsVehicleOccupied(vehicleid);                                                                                                  *
 *                                                                                                                                *
 * Callbacks:                                                                                                                     *
 * OnVehicleCreated(vehicleid);                       //Called when a vehicle is created.                                         *
 * OnVehicleDestroyed(vehicleid);                     //Called when a vehicle is deleted.                                         *
 * OnTrailerHooked(playerid,vehicleid,trailerid);     //Called when a trailer is hooked.                                          *
 * OnTrailerUnhooked(playerid,vehicleid,trailerid);   //Called when a trailer is unhooked.                                        *
 * OnPlayerShotVehicle(playerid,vehicleid,weaponid,Float:amount,EVF::VehicleBodyPart:bodypart);                                   *
 * OnVehiclePosChange(vehicleid,Float:newx,Float:newy,Float:newz,Float:newangle,Float:oldx,Float:oldy,Float:oldz,Float:oldangle); *
 * OnVehicleVelocityChange(vehicleid,Float:newx,Float:newy,Float:newz,Float:oldx,Float:oldy,Float:oldz);                          *
 * OnVehicleHealthChange(vehicleid,Float:newhealth,Float:oldhealth);                                                              *
 * OnVehicleFuelChange(vehicleid,newfuel,oldfuel);                                                                                *
 * OnVehicleBombDeactivate(vehicleid);                                                                                            *
 * OnVehicleBombExplode(vehicleid);                                                                                               *
 * OnPlayerEditVehicle(playerid,vehicleid,response,Float:fX,Float:fY,Float:fZ,Float:fRotZ);                                       *
 * OnPlayerEditVehicleObject(playerid,vehicleid,response,Float:x,Float:y,Float:z,Float:rx,Float:ry,Float:rz);                     *
 * OnPlayerReachSpeedCapLimit(playerid,vehicleid,Float:speed);                                                                    *
 * OnVehicleBombActivate(vehicleid);                                                                                              *
 * OnVehicleModEx(playerid,vehicleid,componentid,price,illegal);                                                                  *
 *                                                                                                                                *
 * Definitions:                                                                                                                   *
 * INVALID_SEAT_ID                                                                                                                *
 * INVALID_PAINTJOB_ID                                                                                                            *
 * VEHICLE_UPDATE_INTERVAL                                                                                                        *
 * MAX_VEHICLE_ATTACHED_OBJECTS                                                                                                   *
 * RESET_PAINTJOB_ID                                                                                                              *
 * MAX_VEHICLE_PARAMS                                                                                                             *
 * MAX_VEHICLE_MODELS                                                                                                             *
 * DEFAULT_VEHICLE_FUEL                                                                                                           *
 * VEHICLE_SPEED_MULTIPLIER                                                                                                       *
 * MULTIPLIER_FUEL_SYSTEM                                                                                                         *
 *                                                                                                                                *
 * BONNET_HEALTHY_CLOSED                                                                                                          *
 * BONNET_HEALTHY_OPENED                                                                                                          *
 * BONNET_DAMAGED_CLOSED                                                                                                          *
 * BONNET_DAMAGED_OPENED                                                                                                          *
 * BONNET_MISSING                                                                                                                 *
 *                                                                                                                                *
 * BOOT_HEALTHY_CLOSED                                                                                                            *
 * BOOT_HEALTHY_OPENED                                                                                                            *
 * BOOT_DAMAGED_CLOSED                                                                                                            *
 * BOOT_DAMAGED_OPENED                                                                                                            *
 * BOOT_MISSING                                                                                                                   *
 *                                                                                                                                *
 * DOOR_HEALTHY_CLOSED                                                                                                            *
 * DOOR_HEALTHY_OPENED                                                                                                            *
 * DOOR_DAMAGED_CLOSED                                                                                                            *
 * DOOR_DAMAGED_OPENED                                                                                                            *
 * DOOR_MISSING                                                                                                                   *
 *                                                                                                                                *
 * BUMPER_HEALTHY                                                                                                                 *
 * BUMPER_CRUSHED                                                                                                                 *
 * BUMPER_HANGING                                                                                                                 *
 * BUMPER_MISSING                                                                                                                 *
 *                                                                                                                                *
 * WINDSHIELD_HEALTHY                                                                                                             *
 * WINDSHIELD_DAMAGED                                                                                                             *
 * WINDSHIELD_MISSING                                                                                                             *
 *                                                                                                                                *
 * LIGHT_ENABLE                                                                                                                   *
 * LIGHT_DISABLE                                                                                                                  *
 *                                                                                                                                *
 * TIRE_HEALTHY                                                                                                                   *
 * TIRE_DAMAGED                                                                                                                   *
 *                                                                                                                                *
 * DOOR_DRIVER                                                                                                                    *
 * DOOR_PASSENGER                                                                                                                 *
 * DOOR_BACKLEFF                                                                                                                  *
 * DOOR_BACKRIGHT                                                                                                                 *
 *                                                                                                                                *
 * VEHICLE_DAMAGE_PANELS                                                                                                          *
 * VEHICLE_DAMAGE_DOORS                                                                                                           *
 * VEHICLE_DAMAGE_LIGHTS                                                                                                          *
 * VEHICLE_DAMAGE_TIRES                                                                                                           *
 *                                                                                                                                *
 * RED_NEON                                                                                                                       *
 * BLUE_NEON                                                                                                                      *
 * GREEN_NEON                                                                                                                     *
 * YELLOW_NEON                                                                                                                    *
 * PINK_NEON                                                                                                                      *
 * WHITE_NEON                                                                                                                     *
 *                                                                                                                                *
 * EVF_CAR_BLINK_NONE                                                                                                             *
 * EVF_CAR_BLINK_LEFT                                                                                                             *
 * EVF_CAR_BLINK_RIGHT                                                                                                            *
 * EVF_CAR_BLINK_EMERGENCY                                                                                                        *
 *                                                                                                                                *
 * MIN_VEHICLE_COMPONENT_ID                                                                                                       *
 * MAX_VEHICLE_COMPONENT_ID                                                                                                       *
 *                                                                                                                                *
 * Enums:                                                                                                                         *
 * enum 'EVF::VehicleProperties'                                                                                                  *
 * # e_VEHICLE_PAINTJOB                                                                                                           *
 * # e_VEHICLE_INTERIOR                                                                                                           *
 * # e_VEHICLE_COLOR_1                                                                                                            *
 * # e_VEHICLE_COLOR_2                                                                                                            *
 * # e_VEHICLE_HORN                                                                                                               *
 * # e_VEHICLE_SPAWN_X                                                                                                            *
 * # e_VEHICLE_SPAWN_Y                                                                                                            *
 * # e_VEHICLE_SPAWN_Z                                                                                                            *
 * # e_VEHICLE_SPAWN_A                                                                                                            *
 * # e_VEHICLE_SPAWN_VW                                                                                                           *
 * # e_VEHICLE_SPAWN_INT                                                                                                          *
 * # e_VEHICLE_SPEED_CAP                                                                                                          *
 * # e_VEHICLE_FUEL_USE                                                                                                           *
 * # e_VEHICLE_FUEL                                                                                                               *
 * # e_VEHICLE_STICKY                                                                                                             *
 * # e_VEHICLE_UNO_DAMAGE                                                                                                         *
 * # e_VEHICLE_EDITOR                                                                                                             *
 * # e_VEHICLE_DAMAGE_PANELS                                                                                                      *
 * # e_VEHICLE_DAMAGE_DOORS                                                                                                       *
 * # e_VEHICLE_DAMAGE_LIGHTS                                                                                                      *
 * # e_VEHICLE_DAMAGE_TIRES                                                                                                       *
 * # e_VEHICLE_BOMB                                                                                                               *
 * # e_VEHICLE_BOMB_TIMER                                                                                                         *
 * # e_VEHICLE_BULLETPROOF                                                                                                        *
 * # e_VEHICLE_STORED                                                                                                             *
 *                                                                                                                                *
 * enum 'EVF::VehicleBodyPart'                                                                                                    *
 * # VEHICLE_BODYPART_UNKNOWN                                                                                                     *
 * # VEHICLE_BODYPART_FL_WHEEL    - Front Left                                                                                    *
 * # VEHICLE_BODYPART_FR_WHEEL    - Front Right                                                                                   *
 * # VEHICLE_BODYPART_BL_WHEEL    - Back Left                                                                                     *
 * # VEHICLE_BODYPART_BR_WHEEL    - Back Right                                                                                    *
 * # VEHICLE_BODYPART_PETROLCAP                                                                                                   *
 *                                                                                                                                *
 * enum 'EVF::ParamTypes'                                                                                                         *
 * # VEHICLE_TYPE_ENGINE                                                                                                          *
 * # VEHICLE_TYPE_LIGHTS                                                                                                          *
 * # VEHICLE_TYPE_ALARM                                                                                                           *
 * # VEHICLE_TYPE_DOORS                                                                                                           *
 * # VEHICLE_TYPE_BONNET                                                                                                          *
 * # VEHICLE_TYPE_BOOT                                                                                                            *
 * # VEHICLE_TYPE_OBJECTIVE                                                                                                       *
 *                                                                                                                                *
 **********************************************************************************************************************************/

#if defined _samp_included
	#if (!defined GetPlayerPoolSize || !defined GetSVarInt)
		#error [ADM] This include requires SA:MP version 0.3.7 (adm.ct8.pl/r/download)
	#endif
#else
	#error [ADM] This include requires SA:MP Include
#endif

#if defined _Vehicle_Ex
	#error [ADM] Please remove deprecated file VehicleEx.inc (already implemented)
#endif

#if defined gVehiclePetrolCapOffsets
	#error [ADM] Please remove deprecated file vehicleplus.inc (already implemented)
#endif

#if ((defined g_anltv_VehicleData) && (defined SetVehicleNeonLights))
	#error [ADM] Please remove deprecated file SetVehicleNeonLights.inc (already implemented)
#endif

#if defined _EVF_include
	#endinput
#endif
#define _EVF_include

#define EVF_Version									(30303) //a.b.c 10000*a+100*b+c
#if defined GetPlayerCustomSkin
	#define EVF_SAMP_VERSION						"0.3 DL"
#else
	#define EVF_SAMP_VERSION						"0.3.7"
#endif

#define EVF_Public::%0(%1)							forward %0(%1); public %0(%1)
#define EVF::										EVF_

//Detect Streamer Plugin
#if ((defined Streamer_AppendArrayData) && (defined INVALID_STREAMER_ID))
	#define EVF_Streamer
#endif

#if !defined IsValidVehicle
	native IsValidVehicle(vehicleid);
#endif

#if !defined isnull
	#define isnull(%1) 								((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#endif

#if !defined INVALID_SEAT_ID
	#define INVALID_SEAT_ID 						-1
#endif

#if !defined INVALID_PAINTJOB_ID
	#define INVALID_PAINTJOB_ID						-1
#endif

#if !defined MAX_VEHICLE_ATTACHED_OBJECTS
	#define MAX_VEHICLE_ATTACHED_OBJECTS			30
#endif

#if !defined VEHICLE_UPDATE_INTERVAL
	#define VEHICLE_UPDATE_INTERVAL					250
#endif

#if !defined VEHICLE_SPEED_MULTIPLIER
	#define VEHICLE_SPEED_MULTIPLIER 				170.0
#endif

#if !defined MULTIPLIER_FUEL_SYSTEM
	#define MULTIPLIER_FUEL_SYSTEM					1
#endif

#define RESET_PAINTJOB_ID							3
#define MAX_VEHICLE_PARAMS							7
#define MAX_VEHICLE_MODELS							212
#if !defined DEFAULT_VEHICLE_FUEL
	#define DEFAULT_VEHICLE_FUEL					1000
#endif
#define MAX_VEHICLE_FUEL							DEFAULT_VEHICLE_FUEL

#define BONNET_HEALTHY_CLOSED						0
#define BONNET_HEALTHY_OPENED						1
#define BONNET_DAMAGED_CLOSED						2
#define BONNET_DAMAGED_OPENED						3
#define BONNET_MISSING								4

#define BOOT_HEALTHY_CLOSED							0
#define BOOT_HEALTHY_OPENED							1
#define BOOT_DAMAGED_CLOSED							2
#define BOOT_DAMAGED_OPENED							3
#define BOOT_MISSING								4

#define DOOR_HEALTHY_CLOSED							0
#define DOOR_HEALTHY_OPENED							1
#define DOOR_DAMAGED_CLOSED							2
#define DOOR_DAMAGED_OPENED							3
#define DOOR_MISSING								4

#define BUMPER_HEALTHY								0
#define BUMPER_CRUSHED								1
#define BUMPER_HANGING								2
#define BUMPER_MISSING								3

#define WINDSHIELD_HEALTHY							0
#define WINDSHIELD_DAMAGED							1
#define WINDSHIELD_MISSING							2

#define LIGHT_ENABLE								0
#define LIGHT_DISABLE								1

#define TIRE_HEALTHY								0
#define TIRE_DAMAGED								1

#define DOOR_DRIVER									1
#define DOOR_PASSENGER								2
#define DOOR_BACKLEFF								3
#define DOOR_BACKRIGHT								4

#define VEHICLE_DAMAGE_PANELS						0
#define VEHICLE_DAMAGE_DOORS						1
#define VEHICLE_DAMAGE_LIGHTS						2
#define VEHICLE_DAMAGE_TIRES						3

#define EVF_CAR_BLINK_NONE							-1
#define EVF_CAR_BLINK_LEFT							0
#define EVF_CAR_BLINK_RIGHT							1
#define EVF_CAR_BLINK_EMERGENCY						2

#define MAX_VEHICLE_NEON_SLOT						3
#define RED_NEON									18647
#define BLUE_NEON									18648
#define GREEN_NEON									18649
#define YELLOW_NEON									18650
#define PINK_NEON 									18651
#define WHITE_NEON									18652

#define MIN_VEHICLE_COMPONENT_ID					1000
#define MAX_VEHICLE_COMPONENT_ID					1193

enum EVF::VehicleProperties {
	e_VEHICLE_PAINTJOB,
	e_VEHICLE_INTERIOR,
	e_VEHICLE_COLOR_1,
	e_VEHICLE_COLOR_2,
	e_VEHICLE_HORN,
	e_VEHICLE_SPAWN_X,
	e_VEHICLE_SPAWN_Y,
	e_VEHICLE_SPAWN_Z,
	e_VEHICLE_SPAWN_A,
	e_VEHICLE_SPAWN_VW,
	e_VEHICLE_SPAWN_INT,
	e_VEHICLE_SPEED_CAP,
	e_VEHICLE_FUEL_USE,
	e_VEHICLE_FUEL,
	e_VEHICLE_STICKY,
	e_VEHICLE_UNO_DAMAGE,
	e_VEHICLE_EDITOR,
	e_VEHICLE_DAMAGE_PANELS,
	e_VEHICLE_DAMAGE_DOORS,
	e_VEHICLE_DAMAGE_LIGHTS,
	e_VEHICLE_DAMAGE_TIRES,
	e_VEHICLE_BOMB,
	e_VEHICLE_BOMB_TIMER,
	e_VEHICLE_BULLETPROOF,
	e_VEHICLE_STORED
};

enum EVF::VehicleBodyPart {
	VEHICLE_BODYPART_UNKNOWN,
	VEHICLE_BODYPART_FL_WHEEL,	//front left
	VEHICLE_BODYPART_FR_WHEEL,	//front right
	VEHICLE_BODYPART_BL_WHEEL,	//back left
	VEHICLE_BODYPART_BR_WHEEL,	//back right
	VEHICLE_BODYPART_PETROLCAP
};

enum EVF::ParamTypes {
	VEHICLE_TYPE_ENGINE,
	VEHICLE_TYPE_LIGHTS,
 	VEHICLE_TYPE_ALARM,
	VEHICLE_TYPE_DOORS,
	VEHICLE_TYPE_BONNET,
	VEHICLE_TYPE_BOOT,
	VEHICLE_TYPE_OBJECTIVE
};

enum EVF::VehicleData {
	#if defined EVF_Streamer
	STREAMER_TAG_OBJECT:e_attached_object[MAX_VEHICLE_ATTACHED_OBJECTS],
	#endif
	Float:e_vel_x,
	Float:e_vel_y,
	Float:e_vel_z,
	Float:e_pos_x,
	Float:e_pos_y,
	Float:e_pos_z,
	Float:e_pos_a,
	Float:e_health,
	e_uptime
};

enum EVF::PlayerData {
	e_editor_vehicle
	#if defined EVF_Streamer
	,
	STREAMER_TAG_OBJECT:e_editor_object
	#endif
};

enum EVF::NeonOffset {
	Float:EVF::NeonX,
	Float:EVF::NeonY,
	Float:EVF::NeonZ
};

#if defined EVF_Streamer
	enum EVF::BlinkOffset {
		Float:	EVF::X,
		Float:	EVF::Y,
		Float:	EVF::Z,
		Float:	EVF::rX,
		Float:	EVF::rY,
		Float:	EVF::rZ
	};
#endif

new EVF::VehicleProperty[MAX_VEHICLES][EVF::VehicleProperties];

new const EVF::NeonOffsetData[MAX_VEHICLE_MODELS][EVF::NeonOffset] = {
	{-0.924999,0.009999,-0.674999},
	{-0.979999,0.074999,-0.489999},
	{-1.034999,-0.029999,-0.579999},
	{-0.884999,1.834998,-1.099999},
	{-0.839999,-0.064999,-0.419999},
	{-0.914999,0.000000,-0.534999},
	{-1.129999,0.354999,-1.219999},
	{-1.214999,0.125000,-0.759999},
	{-0.664999,0.709999,-0.889999},
	{-0.914999,-0.294999,-0.474999},
	{-0.879999,0.000000,-0.389999},
	{-0.969999,0.004999,-0.559999},
	{-0.994999,-0.154999,-0.569999},
	{-0.919999,-0.069999,-0.719999},
	{-0.759999,-0.469999,-0.524999},
	{-0.949999,-0.009999,-0.524999},
	{-1.259999,-0.604999,-0.664999},
	{-2.255004,0.859999,-0.124999},
	{-1.004999,0.089999,-0.829999},
	{-0.934999,-0.009999,-0.584999},
	{-0.954999,-0.009999,-0.444999},
	{-0.929999,-0.029999,-0.589999},
	{-0.889999,0.009999,-0.609999},
	{-0.999999,0.164999,-0.714999},
	{-0.739999,0.039999,-0.234999},
	{-0.639999,2.475009,-0.789999},
	{-0.969999,0.000000,-0.464999},
	{-1.124999,-0.714999,-0.734999},
	{-1.124999,0.054999,-0.759999},
	{-0.844999,0.004999,-0.474999},
	{0.0,0.0,0.0},
	{-1.304998,2.300005,-0.714999},
	{0.0,0.0,0.0},
	{-0.579999,0.994999,-0.874999},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{-0.859999,-0.024999,-0.489999},
	{-1.314998,2.245003,-0.724999},
	{-0.969999,-0.034999,-0.674999},
	{-0.884999,0.034999,-0.644999},
	{-0.914999,-0.045000,-0.899999},
	{0.0,0.0,0.0},
	{-1.004999,-0.074999,-0.604999},
	{-0.809999,2.770015,-1.174999},
	{-1.064999,0.000000,0.135000},
	{-0.949999,0.000000,-0.519999},
	{0.0,0.0,0.0},
	{-1.004999,0.259999,-0.769999},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{-0.984999,-0.194999,-0.519999},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{-0.579999,0.979999,-0.859999},
	{-0.764999,-0.179999,-0.464999},
	{0.0,0.0,0.0},
	{-0.959999,-0.039999,-0.594999},
	{-0.919999,-0.069999,-0.719999},
	{-1.399998,0.554999,-1.819998},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{-0.989999,-0.064999,-0.489999},
	{-0.989999,-0.044999,-0.484999},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{-1.119999,-0.149999,-0.359999},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{-0.994999,-0.064999,-0.544999},
	{-0.904999,-0.054999,-0.549999},
	{0.0,0.0,0.0},
	{-0.979999,0.019999,-0.514999},
	{-0.804999,0.064999,-0.519999},
	{-0.854999,0.090000,-0.454999},
	{-0.879999,0.000000,-0.489999},
	{0.0,0.0,0.0},
	{-0.989999,0.000000,-0.759999},
	{-0.834999,-0.149999,-0.744999},
	{0.0,0.0,0.0},
	{-0.629999,0.164999,-0.374999},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{-1.019999,0.110000,-0.679999},
	{-1.054999,0.125000,-0.604999},
	{-0.874999,-0.009999,-0.569999},
	{-0.909999,0.000000,-0.459999},
	{0.0,0.0,0.0},
	{-0.909999,-0.199999,-0.639999},
	{-1.024999,0.184999,-0.809999},
	{-0.854999,0.029999,-0.469999},
	{0.0,0.0,0.0},
	{-1.149999,0.269999,-0.654999},
	{-0.969999,-1.404998,-0.199999},
	{-0.969999,0.189999,-0.574999},
	{0.0,0.0,0.0},
	{-0.909999,0.029999,-0.639999},
	{-0.909999,-0.184999,-0.639999},
	{-0.989999,-0.059999,-0.494999},
	{-1.019999,0.110000,-0.679999},
	{-0.904999,-0.249999,-0.509999},
	{-1.084999,-0.024999,-0.589999},
	{-1.334998,-0.424999,-0.979999},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{-0.969999,1.669998,-1.174999},
	{-1.454998,0.439999,-1.854998},
	{-0.989999,0.024999,-0.584999},
	{-0.959999,0.004999,-0.554999},
	{-1.049999,0.110000,-0.439999},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{-0.689999,1.489998,-1.319998},
	{-1.054999,0.499999,-0.329999},
	{-0.899999,0.000000,-0.564999},
	{-0.944999,0.154999,-0.419999},
	{-0.924999,0.059999,-0.529999},
	{-0.934999,-0.110000,-0.429999},
	{0.0,0.0,0.0},
	{-0.144999,0.314999,-0.444999},
	{0.0,0.0,0.0},
	{-0.924999,-0.034999,-0.479999},
	{-0.984999,0.164999,-0.564999},
	{-1.069999,-0.034999,-0.569999},
	{-0.954999,-0.019999,-0.579999},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{-1.004999,-0.049999,-0.019999},
	{-1.024999,-0.090000,-0.639999},
	{-0.904999,0.000000,-0.414999},
	{-0.894999,0.014999,-0.539999},
	{-0.904999,0.009999,-0.409999},
	{-1.089999,0.000000,-0.709999},
	{-0.939999,-0.029999,-0.564999},
	{-1.039999,-0.100000,-0.474999},
	{-0.884999,0.059999,-0.479999},
	{-1.769998,1.484998,-1.774998},
	{-0.949999,0.105000,-0.439999},
	{-1.089999,-0.059999,-0.554999},
	{-0.964999,0.004999,-0.564999},
	{-1.034999,0.749999,-0.254999},
	{0.0,0.0,0.0},
	{-1.109999,0.009999,-0.534999},
	{-0.754999,0.000000,-0.464999},
	{-1.119999,0.000000,0.184999},
	{-1.129999,0.044999,0.074999},
	{-0.894999,-0.089999,-0.374999},
	{-0.964999,0.000000,-0.444999},
	{-1.004999,0.054999,-0.414999},
	{-0.919999,0.130000,-0.574999},
	{-0.909999,0.120000,-0.404999},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{-0.824999,0.000000,-0.414999},
	{-0.989999,-0.049999,-0.479999},
	{-1.089999,0.309999,-0.609999},
	{-0.334999,0.100000,-0.374999},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{-0.924999,0.004999,-0.334999},
	{-1.019999,-0.140000,-0.419999},
	{0.0,0.0,0.0},
	{-1.429998,-0.649999,-0.879999},
	{-1.014999,0.000000,-0.484999},
	{-1.089999,0.014999,-0.474999},
	{0.0,0.0,0.0},
	{-0.984999,-0.194999,-0.709999},
	{-0.674999,0.259999,0.130000},
	{0.0,0.0,0.0},
	{-1.019999,-0.009999,-0.354999},
	{0.0,0.0,0.0},
	{-1.009999,-0.064999,-0.534999},
	{-1.374998,0.000000,-0.664999},
	{-0.909999,0.000000,-0.359999},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{-0.974999,0.000000,-0.469999},
	{-0.969999,0.000000,-0.464999},
	{-1.004999,-0.014999,-0.414999},
	{-1.019999,0.115000,-0.684999},
	{-0.959999,0.204999,-0.499999},
	{0.0,0.0,0.0},
	{-1.024999,0.000000,-0.549999},
	{-0.954999,0.034999,-0.629999},
	{-0.989999,-0.064999,-0.489999},
	{-0.904999,0.009999,-0.409999},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0},
	{-1.149999,0.269999,-0.654999},
	{0.0,0.0,0.0},
	{0.0,0.0,0.0}
};

#if defined EVF_Streamer
	new const EVF::BlinkOffsetData[][EVF::BlinkOffset] = {
		{-0.9001, 2.0490, -0.0965, -0.9605, -2.2404, -0.0965},
		{-0.9686, 2.5393, 0.0235, -0.9970, -2.2863, 0.0235},
		{-0.8788, 2.5160, -0.0565, -0.9208, -2.5936, 0.0435},
		{-1.3897, 3.6007, -0.2194, -1.1904, -0.9415, 1.8389},
		{-0.7236, 2.1715, -0.0365, -0.7906, -2.7052, 0.0635},
		{-0.9127, 2.2766, -0.0565, -0.8723, -2.6526, -0.0565},
		{-2.2165, 4.9242, -0.0332, -2.0785, -5.2054, 0.5468},
		{-0.9887, 4.0622, -0.0913, -1.0141, -3.4034, -0.0913},
		{-0.9659, 4.7615, -0.2513, -0.8430, -3.9722, -0.5113},
		{-0.7859, 3.5522, -0.0313, -0.8027, -3.8228, -0.0313},
		{-0.825, 2.105, 0.0635, -0.8723, -2.1926, 0.1235},
		{-0.9405, 2.6710, -0.1825, -0.9636, -2.4525, 0.0825},
		{-0.8965, 2.6478, -0.0575, -0.9592, -3.4870, -0.1575},
		{-0.8669, 2.5464, -0.0913, -0.8209, -2.5829, 0.0687},
		{-0.8069, 2.7473, 0.0087, -0.9058, -3.2050, 0.1094},
		{-0.8738, 2.4866, -0.2357, -0.7792, -2.3501, 0.0450},
		{-0.8469, 2.9073, 0.0087, -1.0352, -3.5937, 1.4522},
		{0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
		{-0.9511, 2.3820, -0.2357, -1.0081, -2.4904, -0.1557},
		{-1.0742, 2.3978, -0.1757, -0.8127, -2.8620, -0.1557},
		{-1.0142, 2.2978, -0.0157, -0.9637, -2.6744, 0.0043},
		{-0.9013, 2.5343, -0.1357, -0.5921, -2.9228, -0.1957},
		{-0.7813, 2.1543, -0.2657, -0.8985, -2.4349, -0.1057},
		{-0.7817, 2.2093, -0.0313, -0.8340, -2.1794, 0.0596},
		{-0.7350, 1.4505, 0.1087, -0.7062, -1.4778, 0.2996},
		{0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
		{-1.0006, 2.3164, -0.0100, -0.9627, -2.6930, -0.0100},
		{-0.8728, 2.5856, 0.1887, -0.9831, -3.8383, -0.3495},
		{-0.8728, 2.5856, -0.2103, -0.9045, -2.8871, 1.2466},
		{-0.7942, 2.2846, -0.2500, -0.8397, -2.3849, -0.0070},
		{0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
		{-0.9771, 5.8479, 0.3497, -1.0300, -5.7043, -0.1041},
		{-1.7168, 4.0330, 0.4497, -1.5830, -4.3414, 0.7039},
		{-1.2619, 3.7708, -0.2163, -1.2966, -4.6534, -0.1051},
		{0.0, 0.0, 0.0, -0.4811, -1.9838, -0.0670},
		{0.0000, 0.0000, 0.0000, -1.0697, -3.9690, -1.1053}, //trailer
		{-0.8495, 2.2519, -0.0070, -0.8948, -2.4838, 0.1130},
		{-1.1156, 5.5395, -0.2163, -0.9856, -5.3099, 1.6458},
		{-1.1128, 2.3675, -0.2870, -1.0992, -2.4601, -0.2870},
		{-0.8381, 2.3101, -0.1470, -0.8221, -2.6534, -0.1070},
		{-0.8270, 2.5573, -0.3173, -0.8676, -2.5376, -0.0149},
		{0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
		{-1.0354, 2.8278, -0.1870, -1.0226, -3.0877, -0.1270},
		{-1.0610, 5.7528, -0.9573, -1.2388, -7.1392, -0.8250},
		{-0.9880, 2.7188, 0.6140, -1.0722, -3.0184, 0.7248},
		{-0.9590, 2.3460, -0.0840, -0.9773, -2.8049, -0.0840},
		{0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
		{0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
		{ -0.1992, -0.9229, -0.1270},
		{0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
		{ 0.0000, 0.0000, 0.0000, -1.0697, -3.9690, -1.1053}, //trailer
		{-0.9826, 1.9642, -0.1399, -0.8894, -2.3991, -0.0199},
		{0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
		{0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
		{0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
		{0.0000, 0.0000, 0.0000, -1.3866, -4.5162, -0.7399},
		{0.0000, 0.0000, 0.0000, -1.3045, -4.6123, 0.4601},
		{0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
		{-0.9513, 2.4197, -0.1399, -0.9703, -2.7779, 0.0201},
		{-0.8214, 2.5716, -0.1274, -0.8760, -2.5775, 0.1127},
		{0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
		{0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
		{0.0000, 0.0000, 0.0000, -0.2054, -0.9359, -0.1399},
		{-0.2276, 0.7185, 0.3201, -0.1952, -1.0037, 0.1601},
		{0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
		{0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
		{0.0000, 0.0000, 0.0000, -1.0201, -2.7994, 0.0401},
		{0.0000, 0.0000, 0.0000, -0.9401, -3.0594, 0.1601},
		{0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
		{0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
		{-1.0259, 2.1382, 0.2001, -1.0433, -2.5463, 0.1201},
		{0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
		{0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
		{0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
		{0.0000, 0.0000, 0.0000, -0.9833, -2.7663, -0.0599},
		{-0.8681, 2.4086, -0.3399, -0.8632, -2.7629, -0.2399},
		{0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
		{-0.8081, 2.6686, -0.1999, -0.9945, -2.6987, 0.0801},
		{-1.0938, 2.0255, 0.1001, -1.0579, -2.5378, -0.2799},
		{-0.9671, 2.4844, 0.0201, -0.9578, -2.7556, 0.0601},
		{-0.5897, 2.2607, -0.4399, -0.9183, -2.3388, -0.1399},
		{0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
		{-0.8841, 2.4094, -0.3399, -0.8685, -2.5676, 0.0201},
		{-0.7770, 2.6235, -0.0199, -0.6709, -2.7712, -0.1999},
		{ 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
		{-0.6104, 1.7180, 0.2201, -0.7074, -1.3681, 0.1201},
		{0.0000, 0.0000, 0.0000, -0.5919, -3.2353, 0.9601},
		{0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
		{0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
		{-1.1024, 2.5796, 0.0401, -1.1261, -2.6473, 0.1601},
		{-1.0971, 3.1462, 0.0401, -1.1327, -3.1055, 0.1601},
		{-0.8495, 2.5284, -0.0799, -0.8870, -2.7776, 0.0001},
		{-0.7905, 2.4656, -0.0599, -0.9075, -2.8130, 0.0001},
		{0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
		{-0.8513, 2.3630, -0.2199, -0.8275, -2.8485, 0.1401},
		{-1.0909, 2.3818, 0.0001, -1.1540, -2.1156, -0.0399},
		{-0.9219, 2.1787, 0.0401, -0.7095, -2.1087, 0.0801},
		{0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
		{-0.8915, 3.0670, 0.2201, -0.9740, -3.0460, 0.3601},
		{-0.7725, 2.4576, -0.1999, -1.1318, -3.4186, 0.1401},
		{-0.9152, 1.9097, -0.0355, -0.7552, -1.9266, -0.0355},
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		{-0.8723, 2.5986, -0.1770, 0.0, 0.0, 0.0},
		{-0.8579, 2.3582, -0.0213, 0.0, 0.0, 0.0},
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		{-1.1068, 2.5744, 0.0086, -1.1365, -2.6250, 0.1679},
		{-0.7672, 2.2106, -0.3185, -0.9113, -2.3474, -0.0273},
		{-1.1143, 2.6057, -0.0456, -1.1410, -2.9714, -0.0456},
		{-0.7012, 3.0199, -0.6678, -1.3807, -3.3356, 1.2628},
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		{-1.2341, 4.2204, 0.0806, 0.0, 0.0, 0.0},
		{-1.4241, 4.4811, -0.7354, -1.2973, -4.8274, -0.8974},
		{-0.9512, 2.7208, -0.0543, -0.9926, -2.7809, -0.0348},
		{-0.9401, 2.7868, -0.0726, -1.0208, -2.7461, -0.1324},
		{-0.9166, 2.6548, -0.0487, -1.0124, -2.8219, -0.0487}, //fake
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		{-0.2607, 0.6038, 0.2881, -0.1973, -0.9958, 0.0638},
		{-0.9279, 3.6538, -0.0473, -1.3003, -3.9309, -1.0661}, //fake back
		{-0.8576, 2.9431, 0.1425, -1.0428, -2.9851, -0.1486}, //fake back
		{-0.9421, 2.3087, -0.1128, -0.9559, -2.2882, -0.0411},
		{-0.9351, 2.4078, -0.0242, -0.9825, -2.2344, 0.0844},
		{-0.8783, 2.5102, -0.1526, -0.8133, -2.5965, -0.3237}, //fake back
		{-1.0177, 2.5256, 0.0698, -1.0505, -2.5713, 0.2047},
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		{-0.4216, 1.5030, -0.1191, -0.5225, -1.0517, 0.4484}, //fake
		{-4.0331, 3.9619, -0.9118, -1.5976, -0.3739, 0.4484}, //fake!
		{-0.9410, 2.3774, 0.0985, -0.9852, -2.4663, -0.0020},
		{-1.0159, 2.9278, -0.1698, -0.8236, -2.7548, -0.0574},
		{-0.8265, 2.5014, -0.2084, -0.9267, -2.6058, -0.1784},
		{-0.8577, 2.3943, -0.1248, -0.8736, -3.0999, -0.0900},
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		{-0.9827, 2.5810, -0.1248, -1.0597, -2.7121, -0.0842},
		{-0.6055, 2.3378, -0.2108, -0.7826, -2.1992, 0.0913},
		{-0.9712, 2.6252, -0.0064, -0.8281, -2.9729, -0.0577},
		{-0.8414, 2.2904, 0.0719, -0.9831, -2.6214, -0.0116}, //fake front
		{-0.7346, 3.5720, 0.0200, -0.8597, -3.2242, -0.5918},
		{-0.4372, 1.6776, -0.0400, -0.7955, -2.0453, -0.2888},
		{-1.1294, 1.0702, 0.0719, -1.0580, -2.6948, 0.0719},
		{-0.9582, 2.5222, 0.0271, -0.9937, -2.5915, 0.0719},
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		{-0.9264, 2.4914, 0.0271, -0.9070, -2.5802, 0.0271},
		{-1.0477, 2.5642, -0.1807, -1.0302, -2.6549, -0.1297},
		{-0.9334, 2.6344, -0.0448, -0.9785, -3.0524, 0.0366},
		{-0.8757, 3.0634, 0.3600, -0.9933, -2.9119, 0.4752},
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		{-0.9409, 2.5345, 0.0600, -1.1112, -2.8095, 0.0651},
		{-0.9236, 1.1282, -0.0462, 0.0, 0.0, 0.0},
		{-0.9686, 2.5396, 0.5800, -1.1128, -2.8895, 0.7691},
		{-0.9886, 2.4796, 0.7000, -1.0904, -2.7699, 0.6871},
		{-0.9452, 2.0854, 0.0836, -0.9187, -2.4047, 0.3185},
		{-0.9037, 2.4333, -0.0168, -0.8819, -2.2910, 0.1482},
		{-0.9347, 2.5097, -0.2644, -0.9639, -2.2337, 0.1259},
		{-0.9157, 2.5754, -0.0857, -0.9317, -2.5444, -0.0191},
		{-0.9299, 2.3759, 0.0201, -0.8575, -2.2773, 0.1659},
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		{-0.8503, 2.0545, 0.0346, -0.9249, -1.9224, 0.0816},
		{-0.9539, 2.7226, 0.0346, -0.9506, -2.9199, 0.0346},
		{-0.9942, 2.9212, -0.1543, -1.0077, -2.9164, -0.1543},
		{-0.2962, 2.0729, -0.0171, -0.2384, -1.2180, 0.0720},
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		{-0.3095, 0.7291, -0.0971, -0.4318, -0.8940, -0.0510},
		{-0.7949, 3.0624, -0.3371, -0.8727, -3.0917, -0.4540},
		{-0.4348, 1.6912, -0.2171, -0.4277, -1.1358, -0.2069},
		{-0.9483, 2.3252, 0.1334, -0.9173, -2.7359, -0.0291},
		{-0.9948, 2.4505, 0.1883, -0.9983, -3.1357, -0.0291},
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		{-1.0478, 4.3687, -0.1800, -1.1188, -5.3472, -0.5099},
		{-1.0598, 2.3634, 0.1013, -1.0873, -2.7596, 0.1013},
		{-0.7970, 2.6313, -0.2429, -1.0776, -2.8302, 0.1013},
		{0.0, 0.0, 0.0, -0.1975, -1.0375, 0.3448},
		{-0.8583, 2.4404, -0.0571, -0.9214, -3.3625, 0.0521},
		{-0.5225, 1.3799, 0.2429, -0.5486, -1.5684, 0.2462},
		{0.0, 0.0, 0.0, -1.0452, -4.3338, -0.7298}, //trailer
		{-1.0068, 2.7905, 0.0907, -0.9760, -3.0160, 0.2088},
		{-0.2872, 0.5383, 0.2009, -0.1703, -1.3533, 0.2784},
		{-1.0236, 2.1415, -0.2834, -1.0832, -2.4851, 0.1047},
		{-1.0116, 3.3590, 0.1029, -1.0679, -3.9639, -0.3029},
		{-0.8107, 2.3905, 0.1834, -0.9605, -2.2799, 0.3761},
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		{0.0, 0.0, 0.0, -1.0590, -3.9902, -1.0809}, //trailer
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		{-1.0419, 2.2929, -0.0255, -1.0332, -2.6951, 0.0005},
		{-1.0419, 2.2929, -0.0255, -1.0332, -2.6951, 0.0005},
		{-1.0423, 2.3495, 0.0600, -1.0326, -2.6930, 0.0600},
		{-1.0837, 2.5663, 0.0301, -1.1267, -2.6290, 0.1451},
		{-0.8782, 2.6525, -0.0344, -1.0586, -2.6696, 0.0596},
		{-0.8094, 3.0084, 0.5429, -0.9321, -3.0808, 0.9071},
		{-1.0297, 2.0487, -0.0543, -0.8907, -2.5334, -0.3228},
		{-0.9069, 2.6672, -0.1335, -0.8647, -2.5991, -0.1335},
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		{0.0, 0.0, 0.0, -0.5702, -1.5842, 0.7956}, //trailer
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		{-0.8972, 3.0244, 0.2629, -0.9349, -2.9809, 0.2791},
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		{0.0, 0.0, 0.0, 0.0, 0.0, 0.0}
	};
#endif

new EVF::VehicleTrailerID[MAX_VEHICLES],
	EVF::VehicleTempData[MAX_VEHICLES][EVF::VehicleData],
	EVF::PlayerTempData[MAX_PLAYERS][EVF::PlayerData],
	EVF::ModShopStatus[MAX_PLAYERS];
	
#if defined EVF_Streamer
	new STREAMER_TAG_OBJECT:EVF::VehicleNeon[MAX_VEHICLES][MAX_VEHICLE_NEON_SLOT][2],
		STREAMER_TAG_OBJECT:EVF::Blink[MAX_VEHICLES][4],
		EVF::BlinkSide[MAX_VEHICLES],
		Float:EVF::BlinkR[MAX_VEHICLES],
		bool:EVF::VehicleBlinking = false;
#endif

new const Float:EVF::TopSpeed[MAX_VEHICLE_MODELS] = {
	157.0, 147.0, 186.0, 110.0, 133.0, 164.0, 110.0, 148.0, 100.0, 158.0, 129.0, 221.0, 168.0, 110.0, 105.0, 192.0, 154.0, 270.0, 115.0, 149.0,
	145.0, 154.0, 140.0, 99.0,  135.0, 270.0, 173.0, 165.0, 157.0, 201.0, 190.0, 130.0, 94.0,  110.0, 167.0, 0.0,   149.0, 158.0, 142.0, 168.0,
	136.0, 145.0, 139.0, 126.0, 110.0, 164.0, 270.0, 270.0, 111.0, 0.0,   0.0,   193.0, 270.0, 60.0,  135.0, 157.0, 106.0, 95.0,  157.0, 136.0,
	270.0, 160.0, 111.0, 142.0, 145.0, 145.0, 147.0, 140.0, 144.0, 270.0, 157.0, 110.0, 190.0, 190.0, 149.0, 173.0, 270.0, 186.0, 117.0, 140.0,
	184.0, 73.0,  156.0, 122.0, 190.0, 99.0,  64.0,  270.0, 270.0, 139.0, 157.0, 149.0, 140.0, 270.0, 214.0, 176.0, 162.0, 270.0, 108.0, 123.0,
	140.0, 145.0, 216.0, 216.0, 173.0, 140.0, 179.0, 166.0, 108.0, 79.0,  101.0, 270.0,	270.0, 270.0, 120.0, 142.0, 157.0, 157.0, 164.0, 270.0, 
	270.0, 160.0, 176.0, 151.0, 130.0, 160.0, 158.0, 149.0, 176.0, 149.0, 60.0,  70.0,  110.0, 167.0, 168.0, 158.0, 173.0, 0.0,   0.0,   270.0,
	149.0, 203.0, 164.0, 151.0, 150.0, 147.0, 149.0, 142.0, 270.0, 153.0, 145.0, 157.0, 121.0, 270.0, 144.0, 158.0, 113.0, 113.0, 156.0, 178.0,
	169.0, 154.0, 178.0, 270.0, 145.0, 165.0, 160.0, 173.0, 146.0, 0.0,   0.0,   93.0,  60.0,  110.0, 60.0,  158.0, 158.0, 270.0, 130.0, 158.0,
	153.0, 151.0, 136.0, 85.0,  0.0,   153.0, 142.0, 165.0, 108.0, 162.0, 0.0,   0.0,   270.0, 270.0, 130.0, 190.0, 175.0, 175.0, 175.0, 158.0,
	151.0, 110.0, 169.0, 171.0, 148.0, 152.0, 0.0,   0.0,   0.0,   108.0, 0.0,   0.0
};

new const EVF::CarColors[][]={
	{16, 004, 001, 123, 001, 113, 001, 101, 001, 075, 001, 062, 001, 040, 001, 036, 001},
	{16, 041, 041, 047, 047, 052, 052, 066, 066, 074, 074, 087, 087, 091, 091, 113, 113},
	{16, 010, 010, 013, 013, 022, 022, 030, 030, 039, 039, 090, 090, 098, 098, 110, 110},
	{16, 036, 001, 037, 001, 030, 001, 028, 001, 025, 001, 040, 001, 101, 001, 113, 001},
	{16, 113, 039, 119, 050, 123, 092, 109, 100, 101, 101, 095, 105, 083, 110, 066, 025},
	{16, 011, 001, 024, 001, 036, 001, 040, 001, 075, 001, 091, 001, 123, 001, 004, 001},
	{2, 001, 001},
	{2, 003, 001},
	{2, 026, 026},
	{2, 001, 001},
	{16, 004, 001, 009, 001, 010, 001, 025, 001, 036, 001, 040, 001, 045, 001, 084, 001},
	{16, 012, 001, 064, 001, 123, 001, 116, 001, 112, 001, 106, 001, 080, 001, 075, 001},
	{16, 009, 001, 010, 008, 011, 001, 025, 008, 027, 001, 029, 008, 030, 001, 037, 008},
	{16, 087, 001, 088, 001, 091, 001, 105, 001, 109, 001, 119, 001, 004, 001, 025, 001},
	{16, 025, 001, 028, 001, 043, 001, 067, 001, 072, 001, 009, 001, 095, 001, 024, 001},
	{16, 020, 001, 025, 001, 036, 001, 040, 001, 062, 001, 075, 001, 092, 001, 000, 001},
	{2, 001, 003},
	{0, 000, 000},
	{16, 119, 119, 117, 227, 114, 114, 108, 108, 095, 095, 081, 081, 061, 061, 041, 041},
	{16, 045, 075, 047, 076, 033, 075, 013, 076, 054, 075, 069, 076, 059, 075, 087, 076},
	{2, 006, 001},
	{16, 004, 001, 013, 001, 025, 001, 030, 001, 036, 001, 040, 001, 075, 001, 095, 001},
	{14, 096, 025, 097, 025, 101, 025, 111, 031, 113, 036, 083, 057, 067, 059},
	{12, 001, 016, 001, 056, 001, 017, 001, 053, 001, 005, 001, 035},
	{16, 001, 000, 002, 002, 003, 002, 003, 006, 006, 016, 015, 030, 024, 053, 035, 061},
	{2, 043, 000},
	{16, 037, 037, 042, 042, 053, 053, 062, 062, 007, 007, 010, 010, 011, 011, 015, 015},
	{2, 000, 001},
	{2, 004, 075},
	{16, 012, 012, 013, 013, 014, 014, 001, 002, 002, 001, 001, 003, 003, 001, 010, 010},
	{2, 046, 026},
	{16, 071, 059, 075, 059, 092, 072, 047, 074, 055, 083, 059, 083, 071, 087, 082, 087},
	{2, 043, 000},
	{2, 043, 000},
	{14, 001, 001, 012, 012, 002, 002, 006, 006, 004, 004, 046, 046, 053, 053},
	{2, 001, 001},
	{14, 083, 001, 087, 001, 092, 001, 095, 001, 109, 001, 119, 045, 011, 001},
	{16, 054, 007, 079, 007, 087, 007, 095, 016, 098, 020, 105, 020, 123, 020, 125, 021},
	{2, 006, 076},
	{16, 057, 008, 008, 017, 043, 021, 054, 038, 067, 008, 037, 078, 065, 079, 025, 078},
	{16, 034, 034, 032, 032, 020, 020, 110, 110, 066, 066, 084, 084, 118, 118, 121, 121},
	{16, 002, 096, 079, 042, 082, 054, 067, 086, 126, 096, 070, 096, 110, 054, 067, 098},
	{16, 000, 000, 011, 105, 025, 109, 036, 000, 040, 036, 075, 036, 000, 036, 000, 109},
	{16, 004, 001, 020, 001, 024, 001, 025, 001, 036, 001, 040, 001, 054, 001, 084, 001},
	{12, 032, 036, 032, 042, 032, 053, 032, 066, 032, 014, 032, 032},
	{16, 034, 034, 035, 035, 037, 037, 039, 039, 041, 041, 043, 043, 045, 045, 047, 047},
	{32, 000, 000, 000, 001, 001, 005, 001, 001, 003, 003, 000, 001, 001, 022, 001, 001, 001, 035, 001, 001, 001, 044, 001, 001, 001, 053, 001, 001, 001, 057, 001, 001},
	{2, 075, 002},
	{2, 001, 003},
	{2, 001, 074},
	{2, 001, 001},
	{16, 123, 123, 125, 125, 036, 036, 016, 016, 018, 018, 046, 046, 061, 061, 075, 075},
	{16, 001, 003, 001, 005, 001, 016, 001, 022, 001, 035, 001, 044, 001, 053, 001, 057},
	{2, 056, 056},
	{2, 026, 026},
	{16, 084, 015, 084, 058, 084, 031, 032, 074, 043, 031, 001, 031, 077, 031, 032, 074},
	{16, 084, 063, 091, 063, 102, 065, 105, 072, 110, 093, 121, 093, 012, 095, 023, 001},
	{16, 058, 001, 002, 001, 063, 001, 018, 001, 032, 001, 045, 001, 013, 001, 034, 001},
	{16, 091, 001, 101, 001, 109, 001, 113, 001, 004, 001, 025, 001, 030, 001, 036, 001},
	{16, 026, 026, 028, 028, 044, 044, 051, 051, 057, 057, 072, 072, 106, 106, 112, 112},
	{16, 001, 003, 001, 009, 001, 018, 001, 030, 017, 023, 046, 023, 046, 032, 057, 034},
	{16, 036, 001, 037, 001, 043, 001, 053, 001, 061, 001, 075, 001, 079, 001, 088, 001},
	{16, 012, 012, 013, 013, 014, 014, 001, 002, 002, 001, 001, 003, 003, 001, 010, 010},
	{16, 079, 079, 084, 084, 007, 007, 011, 011, 019, 019, 022, 022, 036, 036, 053, 053},
	{2, 014, 075},
	{2, 014, 075},
	{16, 067, 076, 068, 076, 078, 076, 002, 076, 016, 076, 018, 076, 025, 076, 045, 088},
	{16, 051, 001, 058, 008, 060, 001, 068, 008, 002, 001, 013, 008, 022, 001, 036, 008},
	{8, 006, 006, 046, 046, 053, 053, 003, 003},
	{0, 000, 000},
	{2, 043, 000},
	{16, 120, 117, 103, 111, 120, 114, 074, 091, 120, 112, 074, 083, 120, 113, 066, 071},
	{4, 056, 015, 056, 053},
	{4, 056, 015, 056, 053},
	{16, 097, 001, 081, 001, 105, 001, 110, 001, 091, 001, 074, 001, 084, 001, 083, 001},
	{16, 002, 039, 009, 039, 017, 001, 021, 001, 033, 000, 037, 000, 041, 029, 056, 029},
	{16, 006, 007, 007, 006, 001, 006, 089, 091, 119, 117, 103, 102, 077, 087, 071, 077},
	{16, 092, 001, 094, 001, 101, 001, 121, 001, 000, 001, 022, 001, 036, 001, 075, 001},
	{16, 072, 001, 066, 001, 059, 001, 045, 001, 040, 001, 039, 001, 035, 001, 020, 001},
	{16, 027, 036, 059, 036, 060, 035, 055, 041, 054, 031, 049, 023, 045, 032, 040, 029},
	{14, 073, 045, 012, 012, 002, 002, 006, 006, 004, 004, 046, 046, 053, 053},
	{16, 001, 001, 003, 003, 006, 006, 046, 046, 065, 009, 014, 001, 012, 009, 026, 001},
	{16, 041, 041, 048, 048, 052, 052, 064, 064, 071, 071, 085, 085, 010, 010, 062, 062},
	{32, 001, 031, 001, 000, 001, 031, 001, 000, 001, 020, 003, 000, 001, 005, 000, 000, 000, 006, 003, 000, 003, 006, 003, 000, 016, 000, 008, 000, 017, 000, 120, 000},
	{8, 012, 035, 050, 032, 040, 026, 066, 036},
	{14, 001, 073, 001, 074, 001, 075, 001, 076, 001, 077, 001, 078, 001, 079},
	{2, 001, 001},
	{16, 026, 014, 029, 042, 026, 057, 054, 029, 026, 003, 003, 029, 012, 039, 074, 035},
	{4, 002, 026, 002, 029},
	{12, 013, 118, 014, 123, 120, 123, 112, 120, 084, 110, 076, 102},
	{2, 000, 000},
	{12, 040, 065, 071, 072, 052, 066, 064, 072, 030, 072, 060, 072},
	{16, 030, 026, 077, 026, 081, 027, 024, 055, 028, 056, 049, 059, 052, 069, 071, 107},
	{2, 036, 013},
	{16, 007, 094, 036, 088, 051, 075, 053, 075, 058, 067, 075, 067, 075, 061, 079, 062},
	{16, 123, 124, 119, 122, 118, 117, 116, 115, 114, 108, 101, 106, 088, 099, 005, 006},
	{16, 074, 072, 066, 072, 053, 056, 037, 019, 022, 022, 020, 020, 009, 014, 000, 000},
	{2, 000, 001},
	{16, 011, 123, 013, 120, 020, 117, 024, 112, 027, 107, 036, 105, 037, 107, 043, 093},
	{16, 109, 025, 109, 032, 112, 032, 010, 032, 030, 044, 032, 052, 084, 066, 084, 069},
	{16, 075, 084, 040, 084, 040, 110, 028, 119, 025, 119, 021, 119, 013, 119, 004, 119},
	{2, 014, 075},
	{16, 083, 066, 087, 074, 087, 075, 098, 083, 101, 100, 103, 101, 117, 116, 123, 036},
	{16, 036, 117, 036, 013, 042, 030, 042, 033, 054, 036, 075, 079, 092, 101, 098, 109},
	{16, 051, 039, 057, 038, 045, 029, 034, 009, 065, 009, 014, 001, 012, 009, 026, 001},
	{12, 013, 118, 014, 123, 120, 123, 112, 120, 084, 110, 076, 102},
	{10, 003, 003, 006, 006, 007, 007, 052, 052, 076, 076},
	{16, 037, 037, 042, 042, 053, 053, 062, 062, 007, 007, 010, 010, 011, 011, 015, 015},
	{2, 001, 001},
	{16, 007, 001, 074, 001, 061, 001, 016, 001, 025, 001, 030, 001, 036, 001, 053, 001},
	{16, 043, 043, 046, 046, 039, 039, 028, 028, 016, 016, 006, 006, 005, 005, 002, 002},
	{16, 003, 090, 004, 090, 007, 068, 008, 066, 012, 060, 027, 097, 034, 051, 037, 051},
	{16, 017, 039, 015, 123, 032, 112, 045, 088, 052, 071, 057, 067, 061, 096, 096, 096},
	{16, 038, 051, 021, 036, 021, 034, 030, 034, 054, 034, 055, 020, 048, 018, 051, 006},
	{16, 010, 001, 025, 001, 028, 001, 036, 001, 040, 001, 054, 001, 075, 001, 113, 001},
	{16, 013, 076, 024, 077, 063, 078, 042, 076, 054, 077, 039, 078, 011, 076, 062, 077},
	{16, 116, 001, 119, 001, 122, 001, 004, 001, 009, 001, 024, 001, 027, 001, 036, 001},
	{16, 037, 036, 036, 036, 040, 036, 043, 041, 047, 041, 051, 072, 054, 075, 055, 084},
	{16, 002, 039, 009, 039, 017, 001, 021, 001, 033, 000, 037, 000, 041, 029, 056, 029},
	{2, 001, 001},
	{0, 000, 000},
	{16, 074, 074, 075, 013, 087, 118, 092, 003, 115, 118, 025, 118, 036, 000, 118, 118},
	{16, 003, 003, 003, 008, 006, 025, 007, 079, 008, 082, 036, 105, 039, 106, 051, 118},
	{0, 000, 000},
	{32, 060, 024, 023, 000, 061, 027, 123, 000, 065, 031, 031, 000, 061, 061, 030, 000, 081, 035, 023, 000, 062, 061, 062, 000, 083, 066, 064, 000, 083, 064, 064, 000},
	{14, 001, 001, 017, 020, 018, 020, 022, 030, 036, 043, 044, 051, 052, 054},
	{16, 002, 039, 009, 039, 017, 001, 021, 001, 033, 000, 037, 000, 041, 029, 056, 029},
	{16, 052, 001, 053, 001, 066, 001, 075, 001, 076, 001, 081, 001, 095, 001, 109, 001},
	{0, 000, 000},
	{16, 037, 037, 042, 042, 053, 053, 062, 062, 007, 007, 010, 010, 011, 011, 015, 015},
	{16, 110, 001, 111, 001, 112, 001, 114, 001, 119, 001, 122, 001, 004, 001, 013, 001},
	{12, 002, 035, 036, 002, 051, 053, 091, 002, 011, 022, 040, 035},
	{0, 000, 000},
	{16, 073, 001, 074, 001, 075, 001, 077, 001, 079, 001, 083, 001, 084, 001, 091, 001},
	{16, 037, 037, 042, 042, 053, 053, 062, 062, 007, 007, 010, 010, 011, 011, 015, 015},
	{16, 003, 001, 028, 001, 031, 001, 055, 001, 066, 001, 097, 001, 123, 001, 118, 001},
	{16, 009, 001, 012, 001, 026, 096, 030, 096, 032, 001, 037, 001, 057, 096, 071, 096},
	{2, 001, 001},
	{2, 001, 001},
	{14, 096, 067, 086, 070, 079, 074, 070, 086, 061, 098, 075, 075, 075, 091},
	{16, 037, 037, 042, 042, 053, 053, 062, 062, 007, 007, 010, 010, 011, 011, 015, 015},
	{16, 051, 001, 058, 008, 060, 001, 068, 008, 002, 001, 013, 008, 022, 001, 036, 008},
	{16, 013, 118, 024, 118, 031, 093, 032, 092, 045, 092, 113, 092, 119, 113, 122, 113},
	{16, 076, 008, 032, 008, 043, 008, 067, 008, 011, 011, 008, 090, 002, 002, 083, 013},
	{2, 003, 001},
	{16, 050, 001, 047, 001, 044, 096, 040, 096, 039, 001, 030, 001, 028, 096, 009, 096},
	{16, 062, 037, 078, 038, 002, 062, 003, 087, 002, 078, 113, 078, 119, 062, 007, 078},
	{16, 122, 001, 123, 001, 125, 001, 010, 001, 024, 001, 037, 001, 055, 001, 066, 001},
	{2, 001, 001},
	{16, 074, 039, 072, 039, 075, 039, 079, 039, 083, 036, 084, 036, 089, 035, 091, 035},
	{16, 037, 037, 042, 042, 053, 053, 062, 062, 007, 007, 010, 010, 011, 011, 015, 015},
	{16, 067, 001, 072, 001, 075, 001, 083, 001, 091, 001, 101, 001, 109, 001, 020, 001},
	{6, 056, 056, 049, 049, 026, 124},
	{16, 038, 009, 055, 023, 061, 074, 071, 087, 091, 087, 098, 114, 102, 119, 111, 003},
	{16, 053, 032, 015, 032, 045, 032, 034, 030, 065, 032, 014, 032, 012, 032, 043, 032},
	{16, 051, 001, 058, 001, 060, 001, 068, 001, 002, 001, 013, 001, 022, 001, 036, 001},
	{2, 001, 001},
	{2, 001, 001},
	{16, 112, 001, 116, 001, 117, 001, 024, 001, 030, 001, 035, 001, 036, 001, 040, 001},
	{16, 051, 001, 058, 008, 060, 001, 068, 008, 002, 001, 013, 008, 022, 001, 036, 008},
	{16, 052, 039, 009, 039, 017, 001, 021, 001, 033, 000, 037, 000, 041, 029, 056, 029},
	{16, 057, 008, 008, 017, 043, 021, 054, 038, 067, 008, 037, 078, 065, 079, 025, 078},
	{16, 036, 001, 035, 001, 017, 001, 011, 001, 116, 001, 113, 001, 101, 001, 092, 001},
	{2, 001, 006},
	{0, 000, 000},
	{16, 037, 037, 042, 042, 053, 053, 062, 062, 007, 007, 010, 010, 011, 011, 015, 015},
	{16, 109, 001, 030, 008, 095, 001, 084, 008, 083, 001, 072, 008, 071, 001, 052, 008},
	{16, 097, 096, 088, 064, 090, 096, 093, 064, 097, 096, 099, 081, 102, 114, 114, 001},
	{16, 002, 039, 009, 039, 017, 001, 021, 001, 033, 000, 037, 000, 041, 029, 056, 029},
	{0, 000, 000},
	{2, 001, 001},
	{12, 002, 035, 036, 002, 051, 053, 091, 002, 011, 022, 040, 035},
	{16, 094, 001, 101, 001, 116, 001, 117, 001, 004, 001, 025, 001, 030, 001, 037, 001},
	{16, 091, 038, 115, 043, 085, 006, 079, 007, 078, 008, 077, 018, 079, 018, 086, 024},
	{2, 026, 026},
	{16, 012, 001, 019, 096, 031, 064, 025, 096, 038, 001, 051, 096, 057, 001, 066, 096},
	{16, 067, 001, 068, 096, 072, 001, 074, 008, 075, 096, 076, 008, 079, 001, 084, 096},
	{12, 001, 003, 008, 007, 008, 010, 008, 016, 023, 031, 040, 044},
	{2, 001, 001},
	{16, 037, 037, 042, 042, 053, 053, 062, 062, 007, 007, 010, 010, 011, 011, 015, 015},
	{18, 092, 092, 081, 081, 067, 067, 066, 066, 061, 061, 053, 053, 051, 051, 047, 047, 043, 043},
	{16, 054, 001, 058, 001, 066, 001, 072, 001, 075, 001, 087, 001, 101, 001, 036, 001},
	{16, 041, 010, 041, 020, 049, 011, 056, 123, 110, 113, 112, 116, 114, 118, 119, 101},
	{2, 001, 001},
	{2, 001, 001},
	{16, 037, 037, 042, 042, 053, 053, 062, 062, 007, 007, 010, 010, 011, 011, 015, 015},
	{16, 119, 001, 122, 001, 008, 001, 010, 001, 013, 001, 025, 001, 027, 001, 032, 001},
	{16, 036, 001, 040, 001, 043, 001, 053, 001, 072, 001, 075, 001, 095, 001, 101, 001},
	{2, 001, 001},
	{16, 037, 037, 031, 031, 023, 023, 022, 022, 007, 007, 124, 124, 114, 114, 112, 112},
	{0, 000, 000},
	{2, 001, 001},
	{2, 001, 001},
	{16, 051, 001, 058, 008, 060, 001, 068, 008, 002, 001, 013, 008, 022, 001, 036, 008},
	{0, 000, 000},
	{2, 112, 020},
	{2, 000, 001},
	{2, 000, 001},
	{2, 000, 001},
	{2, 000, 001},
	{16, 081, 008, 032, 008, 043, 008, 067, 008, 011, 011, 008, 090, 002, 002, 083, 013},
	{2, 001, 001},
	{16, 058, 001, 069, 001, 075, 077, 018, 001, 032, 001, 045, 045, 013, 001, 034, 001},
	{16, 058, 001, 069, 001, 075, 077, 018, 001, 032, 001, 045, 045, 013, 001, 034, 001},
	{16, 067, 076, 068, 076, 078, 076, 002, 076, 016, 076, 018, 076, 025, 076, 045, 088},
	{16, 061, 008, 032, 008, 043, 008, 067, 008, 011, 011, 008, 090, 002, 002, 083, 013},
	{0, 000, 000},
	{0, 000, 000},
	{2, 001, 001},
	{2, 036, 036},
	{0, 000, 000},
	{0, 000, 000}
};

new const EVF::VehicleSeats[MAX_VEHICLE_MODELS] = {
	4,2,2,2,4,4,1,2,2,4,2,2,2,4,2,2,4,2,4,2,4,4,2,2,2,1,4,4,4,2,1,7,1,2,2,0,2,7,4,2,4,1,2,2,2,4,1,2,1,0,0,2,1,1,1,2,2,2,4,4,
	2,2,2,2,1,1,4,4,2,2,4,2,1,1,2,2,1,2,2,4,2,1,4,3,1,1,1,4,2,2,4,2,4,1,2,2,2,4,4,2,2,1,2,2,2,2,2,4,2,1,1,2,1,1,2,2,4,2,2,1,
	1,2,2,2,2,2,2,2,2,4,1,1,1,2,2,2,2,7,7,1,4,2,2,2,2,2,4,4,2,2,4,4,2,1,2,2,2,2,2,2,4,4,2,2,1,2,4,4,1,0,0,1,1,2,1,2,2,1,2,4,
	4,2,4,1,0,4,2,2,2,2,0,0,7,2,2,1,4,4,4,2,2,2,2,2,4,2,0,0,0,4,0,0
};

new const EVF::VehicleDoors[MAX_VEHICLE_MODELS] = {
	4,2,2,2,4,4,2,2,2,4,2,2,2,2,2,2,2,2,4,2,4,4,2,2,0,1,4,2,2,0,0,0,0,2,2,0,2,0,4,0,2,0,2,2,2,4,0,2,0,0,0,2,0,0,0,2,2,0,4,2,
	0,0,0,0,0,0,4,4,0,2,4,0,0,0,2,2,1,2,2,4,0,0,2,2,0,0,0,4,4,2,4,2,4,0,0,2,2,4,2,2,2,0,0,0,0,2,2,4,2,0,0,2,0,0,2,2,4,2,2,0,
	1,0,0,0,2,2,2,2,2,4,0,0,0,0,2,2,0,0,0,0,4,2,2,2,2,2,4,4,0,2,4,4,2,0,2,0,2,2,2,2,4,4,2,2,0,2,4,0,0,0,0,0,0,2,2,0,2,0,2,4,
	4,0,2,2,0,4,0,2,2,2,0,0,0,2,0,0,4,4,4,2,2,0,2,2,4,2,0,0,0,2,0,0
};

new const EVF::ComponentPrice[][] = {
	{1005, 150},	{1004, 100},	{1012, 250},	{1011, 220},
	{1143, 150},	{1145, 100},	{1020, 250},	{1021, 200},
	{1022, 150},	{1019, 300},	{1018, 350},	{1013, 100},
	{1024, 50},		{1008, 500},	{1009, 200},	{1010, 1000},
	{1006, 80},		{1001, 550},	{1014, 400},	{1002, 200},
	{1023, 350},	{1015, 500},	{1016, 200},	{1003, 250},
	{1000, 400},	{1007, 500},	{1017, 500},	{1046, 710},
	{1045, 510},	{1153, 1200},	{1152, 910},	{1150, 1090},
	{1151, 840},	{1054, 210},	{1053, 130},	{1049, 810},
	{1050, 620},	{1047, 670},	{1048, 530},	{1065, 850},
	{1066, 750},	{1160, 1050},	{1173, 950},	{1159, 1050},
	{1161, 950},	{1067, 250},	{1068, 200},	{1162, 650},
	{1158, 550},	{1069, 550},	{1070, 450},	{1034, 790},
	{1037, 690},	{1171, 990},	{1172, 900},	{1149, 1000},
	{1148, 890},	{1038, 190},	{1035, 150},	{1147, 600},
	{1146, 490},	{1036, 500},	{1039, 390},	{1064, 830},
	{1059, 720},	{1155, 1030},	{1157, 930},	{1154, 1030},
	{1156, 920},	{1055, 230},	{1061, 180},	{1058, 620},
	{1060, 530},	{1056, 520},	{1057, 430},	{1028, 770},
	{1029, 680},	{1169, 970},	{1170, 880},	{1141, 980},
	{1140, 870},	{1032, 170},	{1033, 120},	{1138, 580},
	{1139, 470},	{1026, 480},	{1031, 370},	{1092, 750},
	{1089, 650},	{1166, 950},	{1165, 850},	{1168, 950},
	{1167, 850},	{1088, 150},	{1091, 100},	{1164, 550},
	{1163, 450},	{1090, 450},	{1093, 350},	{1128, 3340},
	{1103, 3250},	{1184, 2150},	{1183, 2040},	{1182, 2130},
	{1181, 2050},	{1104, 1610},	{1105, 1540},	{1108, 780},
	{1126, 3340},	{1127, 3250},	{1179, 2150},	{1185, 2040},
	{1180, 2130},	{1178, 2050},	{1122, 780},	{1106, 780},
	{1100, 940},	{1123, 860},	{1125, 1120},	{1130, 3380},
	{1131, 3290},	{1189, 2200},	{1188, 2080},	{1187, 2175},
	{1186, 2095},	{1129, 1650},	{1132, 1590},	{1133, 830},
	{1044, 500},	{1043, 500},	{1174, 1000},	{1175, 900},
	{1176, 1000},	{1177, 900},	{1042, 1000},	{1113, 3340},
	{1114, 3250},	{1117, 2040},	{1115, 2130},	{1116, 2050},
	{1109, 1610},	{1110, 1540},	{1118, 780},	{1119, 940},
	{1136, 1000},	{1135, 1500},	{1191, 1040},	{1190, 1200},
	{1192, 940},	{1193, 1100},	{1134, 800},	{1079, 1030},
	{1075, 980},	{1077, 1620},	{1083, 1560},	{1082, 820},
	{1085, 770},	{1074, 1030},	{1081, 1230},	{1080, 900},
	{1073, 1100},	{1078, 1200},	{1076, 1560},	{1084, 1350},
	{1025, 1000},	{1096, 1000},	{1097, 620},	{1098, 1140},
	{1086, 100},	{1087, 1500}
};

new const EVF::ValidComponent[][] = {
	{400, 1024, 1021, 1020, 1019, 1018, 1013, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{401, 1145, 1144, 1143, 1142, 1020, 1019, 1017, 1013, 1007, 1006, 1005, 1004, 1003, 1001, 0000, 0000, 0000, 0000},
	{402, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{403, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{404, 1021, 1020, 1019, 1017, 1016, 1013, 1007, 1002, 1000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{405, 1023, 1021, 1020, 1019, 1018, 1014, 1001, 1000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{406, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{407, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{408, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{409, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{410, 1024, 1023, 1021, 1020, 1019, 1017, 1013, 1007, 1003, 1001, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{411, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{412, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{413, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{414, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{415, 1023, 1019, 1018, 1017, 1007, 1003, 1001, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{416, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{417, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{418, 1021, 1020, 1016, 1006, 1002, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{419, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{420, 1021, 1019, 1005, 1004, 1003, 1001, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{421, 1023, 1021, 1020, 1019, 1018, 1016, 1014, 1000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{422, 1021, 1020, 1019, 1017, 1013, 1007, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{423, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{424, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{425, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{426, 1021, 1019, 1006, 1005, 1004, 1003, 1001, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{427, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{428, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{429, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{430, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{431, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{432, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{433, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{434, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{435, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{436, 1022, 1021, 1020, 1019, 1017, 1013, 1007, 1006, 1003, 1001, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{437, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{438, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{439, 1145, 1144, 1143, 1142, 1023, 1017, 1013, 1007, 1003, 1001, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{440, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{441, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{442, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{443, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{444, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{445, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{446, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{447, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{448, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{449, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{450, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{451, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{452, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{453, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{454, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{455, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{456, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{457, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{458, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{459, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{460, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{461, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{462, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{463, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{464, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{465, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{466, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{467, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{468, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{469, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{470, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{471, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{472, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{473, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{474, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{475, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{476, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{477, 1021, 1020, 1019, 1018, 1017, 1007, 1006, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{478, 1024, 1022, 1021, 1020, 1013, 1012, 1005, 1004, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{479, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{480, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{481, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{482, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{483, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{484, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{485, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{486, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{487, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{488, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{489, 1024, 1020, 1019, 1018, 1016, 1013, 1006, 1005, 1004, 1002, 1000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{490, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{491, 1145, 1144, 1143, 1142, 1023, 1021, 1020, 1019, 1018, 1017, 1014, 1007, 1003, 0000, 0000, 0000, 0000, 0000},
	{492, 1016, 1006, 1005, 1004, 1000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{493, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{494, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{495, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{496, 1143, 1142, 1023, 1020, 1019, 1017, 1011, 1007, 1006, 1003, 1002, 1001, 0000, 0000, 0000, 0000, 0000, 0000},
	{497, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{498, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{499, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{500, 1024, 1021, 1020, 1019, 1013, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{501, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{502, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{503, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{504, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{505, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{506, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{507, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{508, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{509, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{510, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{511, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{512, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{513, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{514, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{515, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{516, 1021, 1020, 1019, 1018, 1017, 1016, 1015, 1007, 1004, 1002, 1000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{517, 1145, 1144, 1143, 1142, 1023, 1020, 1019, 1018, 1017, 1016, 1007, 1003, 1002, 0000, 0000, 0000, 0000, 0000},
	{518, 1145, 1144, 1143, 1142, 1023, 1020, 1018, 1017, 1013, 1007, 1006, 1005, 1003, 1001, 0000, 0000, 0000, 0000},
	{519, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{520, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{521, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{522, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{523, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{524, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{525, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{526, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{527, 1021, 1020, 1018, 1017, 1015, 1014, 1007, 1001, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{528, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{529, 1023, 1020, 1019, 1018, 1017, 1012, 1011, 1007, 1006, 1003, 1001, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{530, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{531, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{532, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{533, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{534, 1185, 1180, 1179, 1178, 1127, 1126, 1125, 1124, 1123, 1122, 1106, 1101, 1100, 0000, 0000, 0000, 0000, 0000},
	{535, 1121, 1120, 1119, 1118, 1117, 1116, 1115, 1114, 1113, 1110, 1109, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{536, 1184, 1183, 1182, 1181, 1128, 1108, 1107, 1105, 1104, 1103, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{537, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{538, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{539, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{540, 1145, 1144, 1143, 1142, 1024, 1023, 1020, 1019, 1018, 1017, 1007, 1006, 1004, 1001, 0000, 0000, 0000, 0000},
	{541, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{542, 1145, 1144, 1021, 1020, 1019, 1018, 1015, 1014, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{543, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{544, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{545, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{546, 1145, 1144, 1143, 1142, 1024, 1023, 1019, 1018, 1017, 1007, 1006, 1004, 1002, 1001, 0000, 0000, 0000, 0000},
	{547, 1143, 1142, 1021, 1020, 1019, 1018, 1016, 1003, 1000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{548, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{549, 1145, 1144, 1143, 1142, 1023, 1020, 1019, 1018, 1017, 1012, 1011, 1007, 1003, 1001, 0000, 0000, 0000, 0000},
	{550, 1145, 1144, 1143, 1142, 1023, 1020, 1019, 1018, 1006, 1005, 1004, 1003, 1001, 0000, 0000, 0000, 0000, 0000},
	{551, 1023, 1021, 1020, 1019, 1018, 1016, 1006, 1005, 1003, 1002, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{552, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{553, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{554, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{555, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{556, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{557, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{558, 1168, 1167, 1166, 1165, 1164, 1163, 1095, 1094, 1093, 1092, 1091, 1090, 1089, 1088, 0000, 0000, 0000, 0000},
	{559, 1173, 1162, 1161, 1160, 1159, 1158, 1072, 1071, 1070, 1069, 1068, 1067, 1066, 1065, 0000, 0000, 0000, 0000},
	{560, 1170, 1169, 1141, 1140, 1139, 1138, 1033, 1032, 1031, 1030, 1029, 1028, 1027, 1026, 0000, 0000, 0000, 0000},
	{561, 1157, 1156, 1155, 1154, 1064, 1063, 1062, 1061, 1060, 1059, 1058, 1057, 1056, 1055, 0000, 0000, 0000, 0000},
	{562, 1172, 1171, 1149, 1148, 1147, 1146, 1041, 1040, 1039, 1038, 1037, 1036, 1035, 1034, 0000, 0000, 0000, 0000},
	{563, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{564, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{565, 1153, 1152, 1151, 1150, 1054, 1053, 1052, 1051, 1050, 1049, 1048, 1047, 1046, 1045, 0000, 0000, 0000, 0000},
	{566, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{567, 1189, 1188, 1187, 1186, 1133, 1132, 1131, 1130, 1129, 1102, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{568, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{569, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{570, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{571, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{572, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{573, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{574, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{575, 1177, 1176, 1175, 1174, 1099, 1044, 1043, 1042, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{576, 1193, 1192, 1191, 1190, 1137, 1136, 1135, 1134, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{577, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{578, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{579, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{580, 1023, 1020, 1018, 1017, 1007, 1006, 1001, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{581, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{582, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{583, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{584, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{585, 1145, 1144, 1143, 1142, 1020, 1019, 1018, 1013, 1006, 1001, 1023, 1003, 1007, 1017, 0000, 0000, 0000, 0000},
	{586, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{587, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{588, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{589, 1145, 1144, 1024, 1020, 1018, 1017, 1016, 1013, 1007, 1006, 1005, 1004, 1000, 0000, 0000, 0000, 0000, 0000},
	{590, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{591, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{592, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{593, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{594, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{595, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{596, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{597, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{598, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{599, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{600, 1022, 1020, 1018, 1017, 1013, 1007, 1006, 1005, 1004, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{601, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{602, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{603, 1145, 1144, 1143, 1142, 1024, 1023, 1020, 1019, 1018, 1017, 1007, 1006, 1001, 0000, 0000, 0000, 0000, 0000},
	{604, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{605, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{606, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{607, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{608, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{609, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{610, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000},
	{611, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000}
};

new const EVF::ComponentTypes[][] = {
	"Spoiler",
	"Hood",
	"Roof",
	"Sideskirt",
	"Lamps",
	"Nitro",
	"Exhaust",
	"Wheels",
	"Stereo",
	"Hydraulics",
	"Front Bumper",
	"Rear Bumber",
	"Right Vent",
	"Left Vent"
};

new const EVF::ComponentNames[][] = {
	"Pro",
	"Win",
	"Drag",
	"Alpha",
	"Champ Scoop",
	"Fury Scoop",
	"Roof Scoop",
	"Right Sideskirt",
	"5x Nitro",
	"2x Nitro",
	"10x Nitro",
	"Race Scoop",
	"Worx Scoop",
	"Round Fog",
	"Champ",
	"Race",
	"Worx",
	"Left Sideskirt",
	"Upswept",
	"Twin",
	"Large",
	"Medium",
	"Small",
	"Fury",
	"Square Fog",
	"Offroad",
	"Right Alien Sideskirt",
	"Left Alien Sideskirt",
	"Alien",
	"X-Flow",
	"Left X-Flow Sideskirt",
	"Right X-Flow Sideskirt",
	"Alien Roof Vent",
	"X-Flow Roof Vent",
	"Alien",
	"X-Flow Roof Vent",
	"Right Alien Sideskirt",
	"X-Flow",
	"Alien Roof Vent",
	"Left X-Flow Sideskirt",
	"Left Alien Sideskirt",
	"Right X-Flow Sideskirt",
	"Right Chrome Sideskirt",
	"Slamin",
	"Chrome",
	"X-Flow",
	"Alien",
	"Right Alien Sideskirt",
	"Right X-Flow Sideskirt",
	"Alien",
	"X-Flow",
	"Left Alien Sideskirt",
	"Left X-Flow Sideskirt",
	"X-Flow",
	"Alien",
	"Alien",
	"Right Alien Sideskirt",
	"Right X-Flow Sideskirt",
	"Alien",
	"X-Flow",
	"X-Flow",
	"X-Flow",
	"Left Alien Sideskirt",
	"Left X-Flow Sideskirt",
	"Alien",
	"Alien",
	"X-Flow",
	"Alien",
	"X-Flow",
	"Right Alien Sideskirt",
	"Right X-Flow Sideskirt",
	"Left Alien Sideskirt",
	"Left X-Flow Sideskirt",
	"Shadow",
	"Mega",
	"Rimshine",
	"Wires",
	"Classic",
	"Twist",
	"Cutter",
	"Switch",
	"Grove",
	"Import",
	"Dollar",
	"Trance",
	"Atomic",
	"Stereo",
	"Hydraulics",
	"Alien",
	"X-Flow",
	"Right Alien Sideskirt",
	"X-Flow",
	"Alien",
	"Right X-Flow Sideskirt",
	"Left Alien Sideskirt",
	"Right X-Flow Sideskirt",
	"Ahab",
	"Virtual",
	"Access",
	"Left Chrome Sideskirt",
	"Chrome Grill",
	"Left Chrome Flames Sideskirt",
	"Left Chrome Strip Sideskirt",
	"Covertible",
	"Chrome",
	"Slamin",
	"Right Chrome Arches",
	"Left Chrome Strip Sideskirt",
	"Right Chrome Strip Sideskirt",
	"Chrome",
	"Slamin",
	"Little Sign?",
	"Little Sign?",
	"Chrome",
	"Slamin",
	"Chrome",
	"Slamin",
	"Chrome",
	"Right Chrome Trim Sideskirt",
	"Right Wheelcovers Sideskirt",
	"Left Chrome Trim Sideskirt",
	"Left Wheelcovers Sideskirt",
	"Right Chrome Flames Sideskirt",
	"Bullbar Chrome Bars",
	"Left Chrome Arches Sideskirt",
	"Bullbar Chrome Lights",
	"Chrome Exhaust",
	"Slamin Exhaust",
	"Vinyl Hardtop",
	"Chrome",
	"Hardtop",
	"Softtop",
	"Slamin",
	"Right Chrome Strip Sideskirt",
	"Right Chrome Strip Sideskirt",
	"Slamin",
	"Chrome",
	"Left Chrome Strip Sideskirt",
	"Alien",
	"X-Flow",
	"X-Flow",
	"Alien",
	"Left Oval Vents",
	"Right Oval Vents",
	"Left Square Vents",
	"Right Square Vents",
	"X-Flow",
	"Alien",
	"X-Flow",
	"Alien",
	"Alien",
	"X-Flow",
	"X-Flow",
	"Alien",
	"Alien",
	"Alien",
	"X-Flow",
	"X-Flow",
	"X-Flow",
	"Alien",
	"Alien",
	"X-Flow",
	"Alien",
	"X-Flow",
	"Alien",
	"X-Flow",
	"Alien",
	"X-Flow",
	"Alien",
	"Alien",
	"X-Flow",
	"Alien",
	"X-Flow",
	"X-Flow",
	"Chrome",
	"Slamin",
	"Chrome",
	"Slamin",
	"Slamin",
	"Chrome",
	"Chrome",
	"Slamin",
	"Chrome",
	"Slamin",
	"Chrome",
	"Slamin",
	"Slamin",
	"Chrome",
	"Slamin",
	"Chrome",
	"Slamin",
	"Chrome",
	"Chrome",
	"Slamin"
};

new const Float:EVF::WeaponDamage[] = {
	1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,82.5,0.0,1.0,9.9,46.2,0.0,8.25,13.2,46.2,3.3,3.3,4.95,6.6,8.25,
	9.9,9.9,6.6,24.75,41.25,82.5,82.5,1.0,46.2,82.5,0.0,0.33,0.33,0.0,0.0,0.0,0.0,0.0,2.64,9.9,330.0,82.5,1.0,1.0,165.0
};

#if !defined EVF_VehicleName
	new const EVF::VehicleName[MAX_VEHICLE_MODELS][] = {
		"Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster", "Stretch",
		"Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam", "Esperanto", "Taxi", 
		"Washington", "Bobcat", "Mr Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer", "Securicar", "Banshee", "Predator",
		"Bus", "Rhino", "Barracks", "Hotknife", "Trailer 1", "Previon", "Coach", "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero",
		"Packer", "Monster", "Admiral", "Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer 2", "Turismo", "Speeder", "Reefer", "Tropic",
		"Flatbed", "Yankee", "Caddy", "Solair", "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider",
		"Glendale", "Oceanic", "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350",
		"Walton", "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
		"FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick", "Boxville", "Benson",
		"Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher", "Super GT", "Elegant", "Journey",
		"Bike", "Mountain Bike", "Beagle", "Cropdust", "Stunt", "Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal",
		"Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck", "Fortune", "Cadrona", "FBI Truck", "Willard", "Forklift",
		"Tractor", "Combine", "Feltzer", "Remington", "Slamvan", "Blade", "Freight", "Streak", "Vortex", "Vincent", "Bullet", "Clover",
		"Sadler", "Firetruck LA", "Hustler", "Intruder", "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite",
		"Windsor", "Monster A", "Monster B", "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma",
		"Savanna", "Bandito", "Freight Flat", "Streak Carriage", "Kart", "Mower", "Duneride", "Sweeper", "Broadway", "Tornado", "AT-400",
		"DFT-30", "Huntley", "Stafford", "BF-400", "Newsvan", "Tug", "Trailer 3", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
		"Freight Carriage", "Trailer 3", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car (LSPD)", "Police Car (SFPD)",
		"Police Car (LVPD)", "Police Ranger", "Picador", "S.W.A.T. Tank", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage Trailer A",
		"Luggage Trailer B", "Stair Trailer", "Boxville", "Farm Plow", "Utility Trailer"
	};
#endif

#if (defined _FoX_Foreach)
	#define EVF_Foreach(%0) 					FoxForeach(%0,Character)
#elseif (defined _FOREACH_LOCAL_VERSION)
	#define EVF_Foreach(%0)						foreach(new %0 : Character)
#else
	#define EVF_Foreach(%0)						for(new %0 = 0, p_%0 = GetPlayerPoolSize(); %0 <= p_%0; %0++) if(IsPlayerConnected(%0))
#endif

#if (defined _FOREACH_LOCAL_VERSION && defined Vehicle@YSII_Sg)
	#define EVF_ForeachVehicle(%0)				foreach(new %0 : Vehicle)
#elseif (defined _FOREACH_LOCAL_VERSION && defined Vehicles@YSII_Sg)
	#define EVF_ForeachVehicle(%0)				foreach(new %0 : Vehicles)
#else
	#define EVF_ForeachVehicle(%0) 				for(new %0 = 1, %0_upp = GetVehiclePoolSize(); %0 <= %0_upp; %0++) if(IsValidVehicle(%0))
#endif

#define SetVehiclePropertyValue(%0,%1,%2)		EVF_VehicleProperty[(%0)][(%1)] = (%2)
#define GetVehiclePropertyValue(%0,%1)			EVF_VehicleProperty[(%0)][(%1)]
#define EVF_GetActiveCount() 					GetSVarInt("ADM:EVF:ACTIVE")
#define IsValidVehicleModelID(%0)				(400 <= (%0) <= 611)
#define SetVehicleInterior(%0,%1)				LinkVehicleToInterior(%0,%1)
#define IsValidVehicleDoor(%0,%1) 				(!((%1) > EVF::VehicleDoors[(GetVehicleModel(%0)-400)]))
#define RemoveVehiclePaintjob(%0)				ChangeVehiclePaintjob((%0),RESET_PAINTJOB_ID)
#define RestoreVehicleHorn(%0)					SetVehiclePropertyValue((%0),e_VEHICLE_HORN,0)
#define GetVehicleModelSeats(%0)				EVF::VehicleSeats[((%0)-400)]
#define GetVehicleSeats(%0)						GetVehicleModelSeats(GetVehicleModel(%0))
#define GetVehicleModelName(%0)					EVF::VehicleName[((%0)-400)]
#define GetVehicleName(%0)						GetVehicleModelName(GetVehicleModel(%0))
#define GetVehicleModelTopSpeed(%0)				EVF::TopSpeed[((%0)-400)]
#define GetVehicleTopSpeed(%0)					GetVehicleModelTopSpeed(GetVehicleModel(%0))
#define GetVehicleModelDoorAmount(%0)			EVF::VehicleDoors[((%0)-400)]
#define GetVehicleDoorAmount(%0)				GetVehicleModelDoorAmount(GetVehicleModel(%0))
#define SetVehicleSpeedCap(%0,%1) 				SetVehiclePropertyValue((%0),e_VEHICLE_SPEED_CAP,(_:%1))
#define GetVehicleSpeedCap(%0)					Float:GetVehiclePropertyValue((%0),e_VEHICLE_SPEED_CAP)
#define DisableVehicleSpeedCap(%0)				SetVehicleSpeedCap((%0),0)
#define SetVehicleHorn(%0,%1)					SetVehiclePropertyValue((%0),e_VEHICLE_HORN,(%1))
#define GetVehicleHorn(%0)						GetVehiclePropertyValue((%0),e_VEHICLE_HORN)
#define GetVehicleFuel(%0)						GetVehiclePropertyValue((%0),e_VEHICLE_FUEL)
#define SetVehicleFuel(%0,%1)					SetVehiclePropertyValue((%0),e_VEHICLE_FUEL,(%1))
#define IsVehicleFuelToggled(%0)				GetVehiclePropertyValue((%0),e_VEHICLE_FUEL_USE)
#define ToggleVehicleFuel(%0,%1)				SetVehiclePropertyValue((%0),e_VEHICLE_FUEL_USE,(_:%1))
#define IsVehicleSticky(%0)						GetVehiclePropertyValue((%0),e_VEHICLE_STICKY)
#define ToggleVehicleSticky(%0,%1)				SetVehiclePropertyValue((%0),e_VEHICLE_STICKY,(_:%1))
#define IsUnoccupiedDamageToggled(%0)			GetVehiclePropertyValue((%0),e_VEHICLE_UNO_DAMAGE)
#define ToggleUnoccupiedVehicleDamage(%0,%1)	SetVehiclePropertyValue((%0),e_VEHICLE_UNO_DAMAGE,(_:%1))
#define GetVehicleBomb(%0)						GetVehiclePropertyValue((%0),e_VEHICLE_BOMB)
#define IsVehicleBombed(%0)						(GetVehicleBomb(%0) > 0)
#define RemoveVehicleBomb(%0)					SetVehicleBomb((%0),0)
#define IsToggledVehicleBulletproof(%0)			GetVehiclePropertyValue((%0),e_VEHICLE_BULLETPROOF)
#define ToggleVehicleBulletproof(%0,%1)			SetVehiclePropertyValue((%0),e_VEHICLE_BULLETPROOF,(_:%1))

#if defined EVF_Streamer
	#define EVF_IsCarBlinking(%0)				(EVF::BlinkSide[(%0)] != EVF_CAR_BLINK_NONE)
	#define EVF_ToggleVehicleBlinking(%0)		EVF::VehicleBlinking = (%0)
	#define EVF_IsToggledVehicleBlinking()		EVF::VehicleBlinking
#endif


//Keys
#define EVF_KeyPressed(%0) 						(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define EVF_KeyReleased(%0)						(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
#define EVF_KeyHolding(%0) 						((newkeys & (%0)) == (%0))

//extra names:
#define GetVehicleDoorAmountByModelid			GetVehicleModelDoorAmount
#define ResetVehiclePaintjob					RemoveVehiclePaintjob
#define GetVehicleDriverID						GetVehicleDriver
#define SetVehicleColor 						ChangeVehicleColor
#define MAX_VEHICLE_MODEL						MAX_VEHICLE_MODELS
#define OnPlayerShootVehicle					OnPlayerShotVehicle

forward OnVehicleCreated(vehicleid);
forward OnVehicleDestroyed(vehicleid);
forward OnTrailerHooked(playerid,vehicleid,trailerid);
forward OnTrailerUnhooked(playerid,vehicleid,trailerid);
forward OnVehicleBombDeactivate(vehicleid);
forward OnVehicleBombExplode(vehicleid);
forward OnPlayerShotVehicle(playerid,vehicleid,weaponid,Float:amount,EVF::VehicleBodyPart:bodypart);
forward OnPlayerEditVehicle(playerid,vehicleid,response,Float:fX,Float:fY,Float:fZ,Float:fRotZ);
forward OnPlayerEditVehicleObject(playerid,vehicleid,response,Float:x,Float:y,Float:z,Float:rx,Float:ry,Float:rz);
forward OnPlayerReachSpeedCapLimit(playerid,vehicleid,Float:speed);
forward OnVehicleBombActivate(vehicleid);
forward OnVehicleModEx(playerid,vehicleid,componentid,price,illegal);
forward OnVehicleFuelChange(vehicleid,newfuel,oldfuel);

#if defined OnVehiclePosChange
	forward OnVehiclePosChange(vehicleid,Float:newx,Float:newy,Float:newz,Float:newangle,Float:oldx,Float:oldy,Float:oldz,Float:oldangle);
#endif

#if defined OnVehicleVelocityChange
	forward OnVehicleVelocityChange(vehicleid,Float:newx,Float:newy,Float:newz,Float:oldx,Float:oldy,Float:oldz);
#endif

#if defined OnVehicleHealthChange
	forward OnVehicleHealthChange(vehicleid,Float:newhealth,Float:oldhealth);
#endif

stock ResetVehicleProperties(vehicleid){
	EVF::VehicleTrailerID[vehicleid] = INVALID_VEHICLE_ID;
	for(new i = 0; i < _:(EVF::VehicleProperties); i++){
		EVF::VehicleProperty[vehicleid][EVF::VehicleProperties:i] = 0;
	}
}

stock GetComponentName(componentid,name[],len = sizeof(name)){
	if(MIN_VEHICLE_COMPONENT_ID <= componentid <= MAX_VEHICLE_COMPONENT_ID){
		componentid -= MIN_VEHICLE_COMPONENT_ID;
		format(name,len,"%s",EVF::ComponentNames[componentid]);
		return 1;
	}
	name[0] = '\0';
	return 0;
}

stock GetComponentTypeName(component){
    new slotid = GetVehicleComponentType(component), EVF::name[32];
    if(slotid >= 0 && slotid <= 13){
		format(EVF::name,sizeof(EVF::name),"%s",EVF::ComponentTypes[slotid]);
	}
    return EVF::name;
}

stock EVF::IsPlayerInModShop(playerid){
	if(IsPlayerConnected(playerid)) return EVF::ModShopStatus[playerid];
	return 0;
}

stock EVF::IsTrailer(vehicleid){
	switch(GetVehicleModel(vehicleid)){
		case 435, 450, 584, 591, 606: return 1;
	}
	return 0;
}

#if defined EVF_Streamer
	stock EVF::DisableCarBlinking(vehicleid){
		if(!IsValidVehicle(vehicleid)) return 0;
		if(!EVF::IsCarBlinking(vehicleid)) return 0;
		/*if(IsValidDynamicObject(EVF::Blink[vehicleid][0])) DestroyDynamicObject(EVF::Blink[vehicleid][0]);
		if(IsValidDynamicObject(EVF::Blink[vehicleid][1])) DestroyDynamicObject(EVF::Blink[vehicleid][1]);
		if(IsValidDynamicObject(EVF::Blink[vehicleid][2])) DestroyDynamicObject(EVF::Blink[vehicleid][2]);
		if(IsValidDynamicObject(EVF::Blink[vehicleid][3])) DestroyDynamicObject(EVF::Blink[vehicleid][3]);
		EVF::Blink[vehicleid][0] = EVF::Blink[vehicleid][1] = STREAMER_TAG_OBJECT:INVALID_STREAMER_ID;
		EVF::Blink[vehicleid][2] = EVF::Blink[vehicleid][3] = STREAMER_TAG_OBJECT:INVALID_STREAMER_ID;
		EVF::BlinkSide[vehicleid] = EVF_CAR_BLINK_NONE;*/
		return 1;
	}
	
	stock EVF::SetCarBlinking(vehicleid,side,bool:skip=false){
		if(!IsValidVehicle(vehicleid)) return 0;
		if(EVF::IsCarBlinking(vehicleid) && !skip) return EVF::DisableCarBlinking(vehicleid);
		new id = GetVehicleModel(vehicleid)-400, trailerid, STREAMER_TAG_OBJECT:obj[4];

		if(!skip) EVF::BlinkSide[vehicleid] = side;

		GetVehicleZAngle(vehicleid,EVF::BlinkR[vehicleid]);

		if(id > -1){
			if(EVF::BlinkOffsetData[id][EVF::X] != 0.0){
				switch(side){
					case EVF_CAR_BLINK_LEFT: {
						obj[0] = CreateDynamicObject(19294,0.0,0.0,-9000.0,0.0,0.0,0.0);
						EVF::Blink[vehicleid][0] = obj[0];
					}
					case EVF_CAR_BLINK_RIGHT: {
						obj[2] = CreateDynamicObject(19294,0.0,0.0,0.0,0.0,0.0,0.0);
						EVF::Blink[vehicleid][2] = obj[2];
					}
				}
			}
			if((trailerid = GetVehicleTrailer(vehicleid)) != 0){
				if(EVF::IsTrailer(trailerid)){
					switch(side){
						case EVF_CAR_BLINK_LEFT: {
							obj[1] = CreateDynamicObject(19294,0.0,0.0,-9000.0,0.0,0.0,0.0);
							EVF::Blink[vehicleid][1] = obj[1];
						}
						case EVF_CAR_BLINK_RIGHT: {
							obj[3] = CreateDynamicObject(19294,0.0,0.0,0.0,0.0,0.0,0.0);
							EVF::Blink[vehicleid][3] = obj[3];
						}
					}
				}
			} else {
				if(EVF::BlinkOffsetData[id][EVF::rX] != 0.0){
					switch(side){
						case EVF_CAR_BLINK_LEFT: {
							obj[1] = CreateDynamicObject(19294,0.0,0.0,0.0,0.0,0.0,0.0);
							EVF::Blink[vehicleid][1] = obj[1];
						}
						case EVF_CAR_BLINK_RIGHT: {
							obj[3] = CreateDynamicObject(19294,0.0,0.0,0.0,0.0,0.0,0.0);
							EVF::Blink[vehicleid][3] = obj[3];
						}
					}
				}
			}

			switch(side){
				case EVF_CAR_BLINK_LEFT: {
					if(obj[0] != STREAMER_TAG_OBJECT:INVALID_STREAMER_ID){
						AttachDynamicObjectToVehicle(obj[0],vehicleid,EVF::BlinkOffsetData[id][EVF::X],EVF::BlinkOffsetData[id][EVF::Y],EVF::BlinkOffsetData[id][EVF::Z],0.0,0.0,0.0);
					}
					if(trailerid != 0){
						id = GetVehicleModel(trailerid)-400;
						AttachDynamicObjectToVehicle(obj[1],trailerid,EVF::BlinkOffsetData[id][EVF::rX],EVF::BlinkOffsetData[id][EVF::rY],EVF::BlinkOffsetData[id][EVF::rZ],0.0,0.0,0.0);
					} else {
						if(obj[1] != STREAMER_TAG_OBJECT:INVALID_STREAMER_ID){
							AttachDynamicObjectToVehicle(obj[1],vehicleid,EVF::BlinkOffsetData[id][EVF::rX],EVF::BlinkOffsetData[id][EVF::rY],EVF::BlinkOffsetData[id][EVF::rZ],0.0,0.0,0.0);
						}
					}
				}
				case EVF_CAR_BLINK_RIGHT: {
					if(obj[2] != STREAMER_TAG_OBJECT:INVALID_STREAMER_ID){
						AttachDynamicObjectToVehicle(obj[2],vehicleid,-EVF::BlinkOffsetData[id][EVF::X],EVF::BlinkOffsetData[id][EVF::Y],EVF::BlinkOffsetData[id][EVF::Z],0.0,0.0,0.0);
					}
					if(trailerid != 0){
						id = GetVehicleModel(trailerid)-400;
						AttachDynamicObjectToVehicle(obj[3],trailerid,-EVF::BlinkOffsetData[id][EVF::rX],EVF::BlinkOffsetData[id][EVF::rY],EVF::BlinkOffsetData[id][EVF::rZ],0.0,0.0,0.0);
					} else {
						if(obj[3] != STREAMER_TAG_OBJECT:INVALID_STREAMER_ID){
							AttachDynamicObjectToVehicle(obj[3],vehicleid,-EVF::BlinkOffsetData[id][EVF::rX],EVF::BlinkOffsetData[id][EVF::rY],EVF::BlinkOffsetData[id][EVF::rZ],0.0,0.0,0.0);
						}
					}
				}
				case EVF_CAR_BLINK_EMERGENCY: {
					if(obj[0] != STREAMER_TAG_OBJECT:INVALID_STREAMER_ID){
						AttachDynamicObjectToVehicle(obj[0],vehicleid,EVF::BlinkOffsetData[id][EVF::X],EVF::BlinkOffsetData[id][EVF::Y],EVF::BlinkOffsetData[id][EVF::Z],0.0,0.0,0.0);
					}
					if(trailerid != 0){
						id = GetVehicleModel(trailerid)-400;
						AttachDynamicObjectToVehicle(obj[1],trailerid,EVF::BlinkOffsetData[id][EVF::rX],EVF::BlinkOffsetData[id][EVF::rY],EVF::BlinkOffsetData[id][EVF::rZ],0.0,0.0,0.0);
					} else {
						if(obj[1] != STREAMER_TAG_OBJECT:INVALID_STREAMER_ID){
							AttachDynamicObjectToVehicle(obj[1],vehicleid,EVF::BlinkOffsetData[id][EVF::rX],EVF::BlinkOffsetData[id][EVF::rY],EVF::BlinkOffsetData[id][EVF::rZ],0.0,0.0,0.0);
						}
					}
					if(obj[2] != STREAMER_TAG_OBJECT:INVALID_STREAMER_ID){
						AttachDynamicObjectToVehicle(obj[2],vehicleid,-EVF::BlinkOffsetData[id][EVF::X],EVF::BlinkOffsetData[id][EVF::Y],EVF::BlinkOffsetData[id][EVF::Z],0.0,0.0,0.0);
					}
					if(trailerid != 0){
						id = GetVehicleModel(trailerid)-400;
						AttachDynamicObjectToVehicle(obj[3],trailerid,-EVF::BlinkOffsetData[id][EVF::rX],EVF::BlinkOffsetData[id][EVF::rY],EVF::BlinkOffsetData[id][EVF::rZ],0.0,0.0,0.0);
					} else {
						if(obj[3] != STREAMER_TAG_OBJECT:INVALID_STREAMER_ID){
							AttachDynamicObjectToVehicle(obj[3],vehicleid,-EVF::BlinkOffsetData[id][EVF::rX],EVF::BlinkOffsetData[id][EVF::rY],EVF::BlinkOffsetData[id][EVF::rZ],0.0,0.0,0.0);
						}
					}
				}
			}
		}
		return 1;
	}
#endif

stock IsValidComponentForVehicle(vehicleid,componentid){
	new modelid = GetVehicleModel(vehicleid);
	// Check for nitrous, wheels, and hydraulics.
	if((1008 <= componentid <= 1010) || (componentid == 1025) || (1073 <= componentid <= 1087) || (1096 <= componentid <= 1098)){
		switch (modelid){
			case 581, 523, 462, 521, 463, 522, 461, 448, 468, 586,
				 509, 481, 510, 472, 473, 493, 595, 484, 430, 453,
				 452, 446, 454, 590, 569, 537, 538, 570, 449: return false;
			default: return true;
		}
	} else {
		modelid -= 400;
		for(new i = 0; i < sizeof(EVF::ValidComponent[]); i++){
			if(EVF::ValidComponent[modelid][i] == componentid) return true;
		}
	}
	return false;
}

stock GetVehicleComponentPrice(componentid){
	for(new i = 0; i < sizeof(EVF::ComponentPrice); i++){
		if(EVF::ComponentPrice[i][0] == componentid){
			return EVF::ComponentPrice[i][1];
		}
	}
	return 0;
}
	
#if defined EVF_Streamer
	stock SetVehicleNeonLights(vehicleid,bool:enable = true,color = RED_NEON,slotid = 0){
		if(slotid < 0 || slotid >= MAX_VEHICLE_NEON_SLOT) return 0;
		if(!IsValidVehicle(vehicleid)) return 0;
		new modelid = GetVehicleModel(vehicleid);
		if(!IsValidVehicleModelID(modelid)) return 0;
		modelid -= 400;
		
		if(IsValidDynamicObject(EVF::VehicleNeon[vehicleid][slotid][0])) DestroyDynamicObject(EVF::VehicleNeon[vehicleid][slotid][0]);
		if(IsValidDynamicObject(EVF::VehicleNeon[vehicleid][slotid][1])) DestroyDynamicObject(EVF::VehicleNeon[vehicleid][slotid][1]);
		EVF::VehicleNeon[vehicleid][slotid][0] = EVF::VehicleNeon[vehicleid][slotid][1] = STREAMER_TAG_OBJECT:INVALID_STREAMER_ID;
		
		if(!enable) return 1;
		if(18647 <= color <= 18652){
			EVF::VehicleNeon[vehicleid][slotid][0] = CreateDynamicObject(color,0.0,0.0,0.0,0.0,0.0,0.0);
			EVF::VehicleNeon[vehicleid][slotid][1] = CreateDynamicObject(color,0.0,0.0,0.0,0.0,0.0,0.0);
			AttachDynamicObjectToVehicle(EVF::VehicleNeon[vehicleid][slotid][0],vehicleid,EVF::NeonOffsetData[modelid][EVF::NeonX], EVF::NeonOffsetData[modelid][EVF::NeonY],EVF::NeonOffsetData[modelid][EVF::NeonZ],0.0,0.0,0.0);
			AttachDynamicObjectToVehicle(EVF::VehicleNeon[vehicleid][slotid][1],vehicleid,-EVF::NeonOffsetData[modelid][EVF::NeonX], EVF::NeonOffsetData[modelid][EVF::NeonY],EVF::NeonOffsetData[modelid][EVF::NeonZ],0.0,0.0,0.0);
			return 1;
		}
		return 0;
	}

	stock VehicleSupportsNeonLights(modelid){
		if(!IsValidVehicleModelID(modelid)) return 0;
		modelid -= 400;
		return !(EVF::NeonOffsetData[modelid][EVF::NeonX] == 0.0 && EVF::NeonOffsetData[modelid][EVF::NeonY] == 0.0 && EVF::NeonOffsetData[modelid][EVF::NeonZ] == 0.0);
	}

	stock GetVehicleNeonLightsState(vehicleid,slotid = 0){
		if(slotid < 0 || slotid >= MAX_VEHICLE_NEON_SLOT) return 0;
		if(!IsValidVehicle(vehicleid)) return 0;
		return (IsValidDynamicObject(EVF::VehicleNeon[vehicleid][slotid][0]) && IsValidDynamicObject(EVF::VehicleNeon[vehicleid][slotid][1]));
	}
#endif

//Detect YSF.inc
#if !defined _YSF_included
	
	#define GetVehicleInterior(%0)	GetVehiclePropertyValue((%0),e_VEHICLE_INTERIOR)
	#define GetVehiclePaintjob(%0)	GetVehiclePropertyValue((%0),e_VEHICLE_PAINTJOB)

	stock GetVehicleColor(vehicleid,&color1,&color2){
		if(IsValidVehicle(vehicleid)){
			color1 = GetVehiclePropertyValue(vehicleid,e_VEHICLE_COLOR_1);
			color2 = GetVehiclePropertyValue(vehicleid,e_VEHICLE_COLOR_2);
			return 1;
		}
		return 0;
	}
	
	stock bool:IsVehicleOccupied(vehicleid){
		EVF::Foreach(i){
			if(IsPlayerInVehicle(i,vehicleid)){
				return true;
			}
		}
		return false;
	}
#endif

#define EVF_GetVehicleInterior(%0)	GetVehiclePropertyValue((%0),e_VEHICLE_INTERIOR)
#define EVF_GetVehiclePaintjob(%0)	GetVehiclePropertyValue((%0),e_VEHICLE_PAINTJOB)

stock EVF::GetVehicleColor(vehicleid,&color1,&color2){
	if(IsValidVehicle(vehicleid)){
		color1 = GetVehiclePropertyValue(vehicleid,e_VEHICLE_COLOR_1);
		color2 = GetVehiclePropertyValue(vehicleid,e_VEHICLE_COLOR_2);
		return 1;
	}
	return 0;
}

stock bool:EVF::IsVehicleOccupied(vehicleid){
	EVF::Foreach(i){
		if(IsPlayerInVehicle(i,vehicleid)){
			return true;
		}
	}
	return false;
}

stock EVF::GetVehicleSpawnInfo(vehicleid,&Float:x,&Float:y,&Float:z,&Float:rotation,&worldid,&interiorid){
	x = Float:GetVehiclePropertyValue(vehicleid,e_VEHICLE_SPAWN_X);
	y = Float:GetVehiclePropertyValue(vehicleid,e_VEHICLE_SPAWN_Y);
	z = Float:GetVehiclePropertyValue(vehicleid,e_VEHICLE_SPAWN_Z);
	rotation = Float:GetVehiclePropertyValue(vehicleid,e_VEHICLE_SPAWN_A);
	worldid = GetVehiclePropertyValue(vehicleid,e_VEHICLE_SPAWN_VW);
	interiorid = GetVehiclePropertyValue(vehicleid,e_VEHICLE_SPAWN_INT);
	return true;
}

stock EVF::SetVehicleSpawnInfo(vehicleid,Float:x,Float:y,Float:z,Float:rotation,worldid,interiorid){
	SetVehiclePropertyValue(vehicleid,e_VEHICLE_SPAWN_X,_:x);
	SetVehiclePropertyValue(vehicleid,e_VEHICLE_SPAWN_Y,_:y);
	SetVehiclePropertyValue(vehicleid,e_VEHICLE_SPAWN_Z,_:z);
	SetVehiclePropertyValue(vehicleid,e_VEHICLE_SPAWN_A,_:rotation);
	SetVehiclePropertyValue(vehicleid,e_VEHICLE_SPAWN_VW,worldid);
	SetVehiclePropertyValue(vehicleid,e_VEHICLE_SPAWN_INT,interiorid);
}

stock SetVehicleBomb(vehicleid,time = 1000){
	if(IsVehicleBombed(vehicleid)){
		SetVehicleParams(vehicleid,VEHICLE_TYPE_ALARM,0);
		if(GetVehiclePropertyValue(vehicleid,e_VEHICLE_BOMB_TIMER) != -1){
			KillTimer(GetVehiclePropertyValue(vehicleid,e_VEHICLE_BOMB_TIMER));
			SetVehiclePropertyValue(vehicleid,e_VEHICLE_BOMB_TIMER,-1);
		}
	}
	return SetVehiclePropertyValue(vehicleid,e_VEHICLE_BOMB,time);
}

stock IsVehicleBombActivated(vehicleid){
	if(IsVehicleBombed(vehicleid)){
		if(GetVehiclePropertyValue(vehicleid,e_VEHICLE_BOMB_TIMER) != -1){
			return 1;
		}
	}
	return 0;
}

stock EVF::UpdateVehicleDamage(vehicleid,type){
	new panels, doors, lights, tires;
	GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
	switch(type){
		case VEHICLE_DAMAGE_PANELS: panels = 0x03331111;
		case VEHICLE_DAMAGE_DOORS: doors = 0x04040404;
		case VEHICLE_DAMAGE_LIGHTS: lights = 0x0000000F;
	}
	UpdateVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
	return 1;
}

stock EVF::UpdateVehicleDamageStatus(vehicleid,type,update){
	new panels, doors, lights, tires;
	GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
	switch(type){
		case VEHICLE_DAMAGE_PANELS: return UpdateVehicleDamageStatus(vehicleid,update,doors,lights,tires);
		case VEHICLE_DAMAGE_DOORS: return UpdateVehicleDamageStatus(vehicleid,panels,update,lights,tires);
		case VEHICLE_DAMAGE_LIGHTS: return UpdateVehicleDamageStatus(vehicleid,panels,doors,update,tires);
		case VEHICLE_DAMAGE_TIRES: return UpdateVehicleDamageStatus(vehicleid,panels,doors,lights,update);
	}
	return false;
}

stock EVF::GetVehicleDamageStatus(vehicleid,type){
	new panels,doors,lights,tires;
	GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
	switch(type){
		case VEHICLE_DAMAGE_PANELS: return panels;
		case VEHICLE_DAMAGE_DOORS: return doors;
		case VEHICLE_DAMAGE_LIGHTS: return lights;
		case VEHICLE_DAMAGE_TIRES: return tires;
	}
	return -1;
}

stock Float:EVF::GetVehicleSpeed(vehicleid){
	new Float:x,Float:y,Float:z;
	GetVehicleVelocity(vehicleid,x,y,z);
	return floatmul(VectorSize(x,y,z),VEHICLE_SPEED_MULTIPLIER);
}

stock GetVehicleRandomColors(modelid,&color1,&color2){
	if(!IsValidVehicleModelID(modelid)) return 0;
	new index = 0;
	
	color1 = color2 = 0;
	
	modelid -= 400;
	
	if(!EVF::CarColors[modelid][0]) return 0;
	
	if(EVF::CarColors[modelid][0] == 2){
		color1 = EVF::CarColors[modelid][1];
		color2 = EVF::CarColors[modelid][2];
	} else {
		index = random(EVF::CarColors[modelid][0]) & -2;
		color1 = EVF::CarColors[modelid][++index];
		color2 = EVF::CarColors[modelid][++index];
	}
	return 1;
}

stock GetVehicleParams(vehicleid,EVF::ParamTypes:type){
	new EVF::params[MAX_VEHICLE_PARAMS];
	GetVehicleParamsEx(vehicleid,EVF::params[0],EVF::params[1],EVF::params[2],EVF::params[3],EVF::params[4],EVF::params[5],EVF::params[6]);
	return (!(EVF::params[_:type] <= 0));
}

stock SetVehicleParams(vehicleid,EVF::ParamTypes:type,status,delay = 0){
	new EVF::params[MAX_VEHICLE_PARAMS];
	if(GetVehicleParamsEx(vehicleid,EVF::params[0],EVF::params[1],EVF::params[2],EVF::params[3],EVF::params[4],EVF::params[5],EVF::params[6])){
		EVF::params[_:type] = status;
		if(delay > 0){
			SetTimerEx("EVF::SetVehicleParamsEx",delay,false,"iiiiiiii",vehicleid,EVF::params[0],EVF::params[1],EVF::params[2],EVF::params[3],EVF::params[4],EVF::params[5],EVF::params[6]);
		} else {
			SetVehicleParamsEx(vehicleid,EVF::params[0],EVF::params[1],EVF::params[2],EVF::params[3],EVF::params[4],EVF::params[5],EVF::params[6]);
		}
		return 1;
	}
	return 0;
}

stock ToggleVehicleDamageUpdate(vehicleid,type,toggle){
	if(!toggle){
		if(GetVehicleParams(vehicleid,VEHICLE_TYPE_ENGINE)){
			SetVehicleParams(vehicleid,VEHICLE_TYPE_ENGINE,0);
		}
	}
	switch(type){
		case VEHICLE_DAMAGE_PANELS:	return SetVehiclePropertyValue(vehicleid,e_VEHICLE_DAMAGE_PANELS,_:toggle);
		case VEHICLE_DAMAGE_DOORS:	return SetVehiclePropertyValue(vehicleid,e_VEHICLE_DAMAGE_DOORS,_:toggle);
		case VEHICLE_DAMAGE_LIGHTS:	return SetVehiclePropertyValue(vehicleid,e_VEHICLE_DAMAGE_LIGHTS,_:toggle);
		case VEHICLE_DAMAGE_TIRES:	return SetVehiclePropertyValue(vehicleid,e_VEHICLE_DAMAGE_TIRES,_:toggle);
	}
	return 0;
}

stock IsVehicleDamageToggled(vehicleid,type){
	switch(type){
		case VEHICLE_DAMAGE_PANELS:	return GetVehiclePropertyValue(vehicleid,e_VEHICLE_DAMAGE_PANELS);
		case VEHICLE_DAMAGE_DOORS:	return GetVehiclePropertyValue(vehicleid,e_VEHICLE_DAMAGE_DOORS);
		case VEHICLE_DAMAGE_LIGHTS:	return GetVehiclePropertyValue(vehicleid,e_VEHICLE_DAMAGE_LIGHTS);
		case VEHICLE_DAMAGE_TIRES:	return GetVehiclePropertyValue(vehicleid,e_VEHICLE_DAMAGE_TIRES);
	}
	return 0;
}

stock GetNearestVehicleToPos(Float:x,Float:y,Float:z,worldid=-1,interiorid=-1,Float:maxdist=0.0,bool:fast=true,except_vid=0){
	new Float:distance = -1.0, foundvid = INVALID_VEHICLE_ID, Float:px, Float:py, Float:pz, Float:tmpdistance;
	EVF::ForeachVehicle(vehicleid){
		if(except_vid == vehicleid) continue;
		if(GetVehicleModel(vehicleid) == 590) continue;
		if(worldid != -1 && GetVehicleVirtualWorld(vehicleid) != worldid) continue;
		if(interiorid != -1 && GetVehicleInterior(vehicleid) != interiorid) continue;
		GetVehiclePos(vehicleid,px,py,pz);

		tmpdistance = VectorSize(x-px,y-py,z-pz);
		if(maxdist > 0.0 && tmpdistance > maxdist) continue;
		if(fast && (distance == -1.0 || tmpdistance < distance) && (maxdist == 0.0 || (tmpdistance < maxdist))) return vehicleid;
		if(distance == -1.0 || tmpdistance < distance){
			distance = tmpdistance;
			foundvid = vehicleid;
		}
	}
	return foundvid;
}

stock GetNearestVehicleToPlayer(playerid,Float:maxdist=0.0,bool:fast=false){
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	return GetNearestVehicleToPos(x,y,z,GetPlayerVirtualWorld(playerid),GetPlayerInterior(playerid),maxdist,fast);
}

stock GetVehicleDriver(vehicleid){
	EVF::Foreach(i){
		if(GetPlayerState(i) == PLAYER_STATE_DRIVER && IsPlayerInVehicle(i,vehicleid)){
			return i;
		}
	}
	return INVALID_PLAYER_ID;
}

stock IsVehicleSeatOccupied(vehicleid,seatid){
	if(!GetVehicleModel(vehicleid)) return 0;
	EVF::Foreach(i){
		if(IsPlayerInVehicle(i,vehicleid) && GetPlayerVehicleSeat(i) == seatid){
			return 1;
		}
	}
	return 0;
}

stock GetVehicleNextSeat(vehicleid,passenger = 1){
	new seats = GetVehicleSeats(vehicleid);
	if(seats > 1){
		for(new i = passenger; i < seats; i++){
			if(!IsVehicleSeatOccupied(vehicleid,i)){
				return i;
			}
		}
	}
	return INVALID_SEAT_ID;
}

stock GetVehiclePassenger(vehicleid){
	foreach(new i : Player){
		if(GetPlayerState(i) == PLAYER_STATE_PASSENGER && IsPlayerInVehicle(i,vehicleid)){
			return i;
		}
	}
	return INVALID_PLAYER_ID;
}

#if defined EVF_Streamer
	stock STREAMER_TAG_OBJECT:GetVehicleSlotAttachedObject(vehicleid,slot){
		if(!IsValidDynamicObject(EVF::VehicleTempData[vehicleid][e_attached_object][slot])) return STREAMER_TAG_OBJECT:INVALID_STREAMER_ID;
		return EVF::VehicleTempData[vehicleid][e_attached_object][slot];
	}

	stock IsObjectAttachedToVehicle(STREAMER_TAG_OBJECT:objectid,vehicleid){
		for(new i = 0; i < MAX_VEHICLE_ATTACHED_OBJECTS; i++){
			if(IsValidDynamicObject(EVF::VehicleTempData[vehicleid][e_attached_object][i])){
				if(EVF::VehicleTempData[vehicleid][e_attached_object][i] == objectid) return 1;
			}
		}
		return 0;
	}
	
	stock EditVehicle(playerid,vehicleid){
		if(IsValidDynamicObject(STREAMER_TAG_OBJECT:GetVehiclePropertyValue(vehicleid,e_VEHICLE_EDITOR))) return false;

		new Float:pos[3];
		GetVehiclePos(vehicleid,pos[0],pos[1],pos[2]);
		SetVehiclePropertyValue(vehicleid,e_VEHICLE_EDITOR,_:CreateDynamicObject(19300,pos[0],pos[1],pos[2],0.0,0.0,0.0));

		EditDynamicObject(playerid,STREAMER_TAG_OBJECT:GetVehiclePropertyValue(vehicleid,e_VEHICLE_EDITOR));

		EVF::PlayerTempData[playerid][e_editor_vehicle] = vehicleid;
		EVF::PlayerTempData[playerid][e_editor_object] = STREAMER_TAG_OBJECT:INVALID_STREAMER_ID;
		return true;
	}

	stock EditVehicleObject(playerid,vehicleid,STREAMER_TAG_OBJECT:objectid)
    	{
        	if(IsValidDynamicObject(STREAMER_TAG_OBJECT:GetVehiclePropertyValue(vehicleid,e_VEHICLE_EDITOR)) || !IsValidDynamicObject(objectid)) return false;

        	SetVehiclePropertyValue(vehicleid,e_VEHICLE_EDITOR,_:objectid);

        	new Float:pos[3];
        	GetVehiclePos(vehicleid,pos[0],pos[1],pos[2]);

        	new model = Streamer_GetIntData(STREAMER_TYPE_OBJECT,objectid,E_STREAMER_MODEL_ID);

        	DestroyDynamicObject(objectid);
        	SetVehiclePropertyValue(vehicleid,e_VEHICLE_EDITOR,_:CreateDynamicObject(model,pos[0],pos[1],pos[2],0.0,0.0,0.0,0,0,-1, 60.0, 60.0));

        	EditDynamicObject(playerid,STREAMER_TAG_OBJECT:GetVehiclePropertyValue(vehicleid,e_VEHICLE_EDITOR));

        	SetVehicleZAngle(vehicleid,0.0);

        	EVF::PlayerTempData[playerid][e_editor_vehicle] = vehicleid;
        	EVF::PlayerTempData[playerid][e_editor_object] = objectid;
        	return true;
    	}
#endif

stock TeleportVehicle(vehicleid,Float:x,Float:y,Float:z,Float:angle,worldid = -1,interiorid = -1){
	EVF::Foreach(i){
		if(GetPlayerVehicleID(i) == vehicleid){
			if(worldid != -1){
				SetPlayerVirtualWorld(i,worldid);
			} else {
				SetPlayerVirtualWorld(i,GetVehicleVirtualWorld(vehicleid));
			}
			if(interiorid != -1){
				SetPlayerInterior(i,interiorid);
			} else {
				SetPlayerInterior(i,GetVehicleInterior(vehicleid));
			}
		}
	}

 	if(worldid != -1) SetVehicleVirtualWorld(vehicleid,worldid);
	if(interiorid != -1) SetVehicleInterior(vehicleid,interiorid);

	SetVehiclePos(vehicleid,x,y,z);
	SetVehicleZAngle(vehicleid,angle);
	return 1;
}

stock GetVehiclePanels(vehicleid,&front_left,&front_right,&rear_left,&rear_right,&windshield,&front_bumper,&rear_bumper){
	new panels,doors,lights,tires;
	GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
	front_left = (panels & 0xF);
	front_right = (panels >> 4) & 0xF;
	rear_left = (panels >> 8) & 0xF;
	rear_right = (panels >> 12) & 0xF;
	windshield = (panels >> 16) & 0xF;
	front_bumper = (panels >> 20) & 0xF;
	rear_bumper = (panels >> 24) & 0xF;
}

stock SetVehiclePanels(vehicleid,front_left,front_right,rear_left,rear_right,windshield,front_bumper,rear_bumper){
	new panels,doors,lights,tires;
	GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
	panels = (front_left | (front_right << 4) | (rear_left << 8) | (rear_right << 12) | (windshield << 16) | (front_bumper << 20) | (rear_bumper << 24));
	UpdateVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
}

//Update by Freaksken
stock GetVehicleLights(vehicleid,&front_left_light,&front_right_light,&back_lights){
	new panels,doors,lights,tires;
	GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
	front_left_light = (lights & 0x1);
	front_right_light = (lights >> 2 & 0x1);
	back_lights = (lights >> 6 & 0x1);
}

//Update by Freaksken
stock SetVehicleLights(vehicleid,front_left_light,front_right_light,back_lights){
	new panels,doors,lights,tires;
	GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
	lights = (front_left_light | (front_right_light << 2) | (back_lights << 6));
	UpdateVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
}

stock GetVehicleDoors(vehicleid,&bonnet,&boot,&driver_door,&passenger_door){
	new panels,doors,lights,tires;
	GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
	bonnet = (doors & 0x7);
	boot = ((doors >> 8) & 0x7);
	driver_door = ((doors >> 16) & 0x7);
	passenger_door = ((doors >> 24) & 0x7);
}

stock SetVehicleDoors(vehicleid,bonnet,boot,driver_door,passenger_door){
	new panels,doors,lights,tires;
	GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
	doors = (bonnet | (boot << 8) | (driver_door << 16) | (passenger_door << 24));
	UpdateVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
}

stock GetVehicleTires(vehicleid,&front_left,&front_right,&rear_left,&rear_right){
	new panels,doors,lights,tires;
	GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
	rear_right = (tires & 0x1);
	front_right = (tires >> 1 & 0x1);
	rear_left = (tires >> 2 & 0x1);
	front_left = (tires >> 3 & 0x1);
}

stock SetVehicleTires(vehicleid,front_left,front_right,rear_left,rear_right){
	new panels,doors,lights,tires;
	GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
	tires = (rear_right | (front_right << 1) | (rear_left << 2) | (front_left << 3));
	UpdateVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
}

stock SwitchVehicleEngine(vehicleid,bool:engine_status){
	new engine,lights,alarm,doors,bonnet,boot,objective;
	GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
	SetVehicleParamsEx(vehicleid,_:engine_status,lights,alarm,doors,bonnet,boot,objective);
}

stock SwitchVehicleLight(vehicleid,bool:light_status){
	new engine,lights,alarm,doors,bonnet,boot,objective;
	GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
	SetVehicleParamsEx(vehicleid,engine,_:light_status,alarm,doors,bonnet,boot,objective);
}

stock SwitchVehicleAlarm(vehicleid,bool:alarm_status){
	new engine,lights,alarm,doors,bonnet,boot,objective;
	GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
	SetVehicleParamsEx(vehicleid,engine,lights,_:alarm_status,doors,bonnet,boot,objective);
}

stock SwitchVehicleDoors(vehicleid,bool:doors_status){
	new engine,lights,alarm,doors,bonnet,boot,objective;
	GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
	SetVehicleParamsEx(vehicleid,engine,lights,alarm,_:doors_status,bonnet,boot,objective);
}

stock SwitchVehicleBonnet(vehicleid,bool:bonnet_status){
	new engine,lights,alarm,doors,bonnet,boot,objective;
	GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
	SetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,_:bonnet_status,boot,objective);
}

stock SwitchVehicleBoot(vehicleid,bool:boot_status){
	new engine,lights,alarm,doors,bonnet,boot,objective;
	GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
	SetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,_:boot_status,objective);
}

stock SwitchVehicleObjective(vehicleid,bool:objective_status){
	new engine,lights,alarm,doors,bonnet,boot,objective;
	GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
	SetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,_:objective_status);
}

stock GetVehicleWindowState(vehicleid,doorid){
	new driver,passenger,backleft,backright;
	GetVehicleParamsCarWindows(vehicleid,driver,passenger,backleft,backright);
	switch(doorid){
		case DOOR_DRIVER:		return (driver > 0);
		case DOOR_PASSENGER:	return (passenger > 0);
		case DOOR_BACKLEFF:		return (backleft > 0);
		case DOOR_BACKRIGHT:	return (backright > 0);
	}
	return 0;
}

stock SetVehicleWindowState(vehicleid,doorid,window_state){
	if(!IsValidVehicleDoor(vehicleid,doorid)) return 0;
	new driver,passenger,backleft,backright;
	driver = GetVehicleWindowState(vehicleid,DOOR_DRIVER);
	passenger = GetVehicleWindowState(vehicleid,DOOR_PASSENGER);
	backleft = GetVehicleWindowState(vehicleid,DOOR_BACKLEFF);
	backright = GetVehicleWindowState(vehicleid,DOOR_BACKRIGHT);
	switch(doorid){
		case DOOR_DRIVER:		SetVehicleParamsCarWindows(vehicleid,window_state,passenger,backleft,backright);
		case DOOR_PASSENGER:	SetVehicleParamsCarWindows(vehicleid,driver,window_state,backleft,backright);
		case DOOR_BACKLEFF:		SetVehicleParamsCarWindows(vehicleid,driver,passenger,window_state,backright);
		case DOOR_BACKRIGHT:	SetVehicleParamsCarWindows(vehicleid,driver,passenger,backleft,window_state);
	}
	return 1;
}

stock GetVehicleDoorState(vehicleid,doorid){
	new driver,passenger,backleft,backright;
	GetVehicleParamsCarDoors(vehicleid,driver,passenger,backleft,backright);
	switch(doorid){
		case DOOR_DRIVER:		return (driver > 0);
		case DOOR_PASSENGER:	return (passenger > 0);
		case DOOR_BACKLEFF:		return (backleft > 0);
		case DOOR_BACKRIGHT:	return (backright > 0);
	}
	return 0;
}

stock SetVehicleDoorState(vehicleid,doorid,door_state){
	if(!IsValidVehicleDoor(vehicleid,doorid)) return 0;
	new driver,passenger,backleft,backright;
	driver = GetVehicleDoorState(vehicleid,DOOR_DRIVER);
	passenger = GetVehicleDoorState(vehicleid,DOOR_PASSENGER);
	backleft = GetVehicleDoorState(vehicleid,DOOR_BACKLEFF);
	backright = GetVehicleDoorState(vehicleid,DOOR_BACKRIGHT);
	switch(doorid){
		case DOOR_DRIVER:		SetVehicleParamsCarDoors(vehicleid,door_state,passenger,backleft,backright);
		case DOOR_PASSENGER:	SetVehicleParamsCarDoors(vehicleid,driver,door_state,backleft,backright);
		case DOOR_BACKLEFF:		SetVehicleParamsCarDoors(vehicleid,driver,passenger,door_state,backright);
		case DOOR_BACKRIGHT:	SetVehicleParamsCarDoors(vehicleid,driver,passenger,backleft,door_state);
	}
	return 1;
}

EVF::Public:: OnVehicleTimeUpdate(){
	new Float:EVF::Vec[4];
	EVF::ForeachVehicle(vehicleid){
		if(EVF::VehicleProperty[vehicleid][e_VEHICLE_STORED]){
			GetVehiclePos(vehicleid,EVF::Vec[0],EVF::Vec[1],EVF::Vec[2]);
			GetVehicleZAngle(vehicleid,EVF::Vec[3]);
			if(IsVehicleSticky(vehicleid)){
				if(VectorSize(EVF::Vec[0]-EVF::VehicleTempData[vehicleid][e_pos_x],EVF::Vec[1]-EVF::VehicleTempData[vehicleid][e_pos_y],EVF::Vec[2]-EVF::VehicleTempData[vehicleid][e_pos_z]) >= 2.0 || VectorSize(EVF::Vec[3]-EVF::VehicleTempData[vehicleid][e_pos_a],0.0,0.0) >= 1.0){
					return TeleportVehicle(vehicleid,EVF::VehicleTempData[vehicleid][e_pos_x],EVF::VehicleTempData[vehicleid][e_pos_y],EVF::VehicleTempData[vehicleid][e_pos_z],EVF::VehicleTempData[vehicleid][e_pos_a],GetVehicleInterior(vehicleid),GetVehicleVirtualWorld(vehicleid));
				}
			}
			#if defined OnVehiclePosChange
				if(VectorSize(EVF::Vec[0]-EVF::VehicleTempData[vehicleid][e_pos_x],EVF::Vec[1]-EVF::VehicleTempData[vehicleid][e_pos_y],EVF::Vec[2]-EVF::VehicleTempData[vehicleid][e_pos_z]) >= 2.0){
					if(CallRemoteFunction("OnVehiclePosChange","iffffffff",vehicleid,EVF::Vec[0],EVF::Vec[1],EVF::Vec[2],EVF::Vec[3],EVF::VehicleTempData[vehicleid][e_pos_x],EVF::VehicleTempData[vehicleid][e_pos_y],EVF::VehicleTempData[vehicleid][e_pos_z],EVF::VehicleTempData[vehicleid][e_pos_a])){
						EVF::VehicleTempData[vehicleid][e_pos_x] = EVF::Vec[0];
						EVF::VehicleTempData[vehicleid][e_pos_y] = EVF::Vec[1];
						EVF::VehicleTempData[vehicleid][e_pos_z] = EVF::Vec[2];
						EVF::VehicleTempData[vehicleid][e_pos_a] = EVF::Vec[3];
					} else {
						return TeleportVehicle(vehicleid,EVF::VehicleTempData[vehicleid][e_pos_x],EVF::VehicleTempData[vehicleid][e_pos_y],EVF::VehicleTempData[vehicleid][e_pos_z],EVF::VehicleTempData[vehicleid][e_pos_a],GetVehicleInterior(vehicleid),GetVehicleVirtualWorld(vehicleid));
					}
				}
			#endif

			GetVehicleVelocity(vehicleid,EVF::Vec[0],EVF::Vec[1],EVF::Vec[2]);
			if(IsVehicleFuelToggled(vehicleid)){
				//fuel system
				new Float:vehicle_speed = EVF::GetVehicleSpeed(vehicleid);
				//if vehicle out of fuel
				if(GetVehicleFuel(vehicleid) <= 0){
					SetVehicleParams(vehicleid,VEHICLE_TYPE_ENGINE,0);
					new vehicle_driver = GetVehicleDriverID(vehicleid);
					if(IsPlayerConnected(vehicle_driver)){
						GameTextForPlayer(vehicle_driver,"~r~Vehicle out of fuel !",5000,3);
					}
				} else {
					//if vehicle has some EVF::Vecitive fuel
					EVF::VehicleTempData[vehicleid][e_uptime] += 1;
					if(EVF::VehicleTempData[vehicleid][e_uptime] > 20){ // 250 ms * 20 = 5 seconds
						EVF::VehicleTempData[vehicleid][e_uptime] = 0;
						
						new fuel_consumption_level = 0;
						if(vehicle_speed == 0.0){
							if(GetVehicleParams(vehicleid,VEHICLE_TYPE_ENGINE)){
								fuel_consumption_level = MULTIPLIER_FUEL_SYSTEM;
							}
						} else {
							for(new i = 20, j = floatround(GetVehicleTopSpeed(vehicleid)); i <= j; i += 20){
								if(vehicle_speed > i){
									fuel_consumption_level += MULTIPLIER_FUEL_SYSTEM;
								}
							}
						}
						
						if(fuel_consumption_level > 0){
							new old_fuel = GetVehicleFuel(vehicleid), new_fuel = (old_fuel - fuel_consumption_level - 1);
							if(new_fuel < 0) new_fuel = 0;
							CallRemoteFunction("OnVehicleFuelChange","iii",vehicleid,new_fuel,old_fuel);
							SetVehicleFuel(vehicleid,new_fuel);
						}
					}
				}
			}
			
			#if defined OnVehicleVelocityChange
				if(CallRemoteFunction("OnVehicleVelocityChange","iffffff",vehicleid,EVF::Vec[0],EVF::Vec[1],EVF::Vec[2],EVF::VehicleTempData[vehicleid][e_vel_x],EVF::VehicleTempData[vehicleid][e_vel_y],EVF::VehicleTempData[vehicleid][e_vel_z])){
					EVF::VehicleTempData[vehicleid][e_vel_x] = EVF::Vec[0];
					EVF::VehicleTempData[vehicleid][e_vel_y] = EVF::Vec[1];
					EVF::VehicleTempData[vehicleid][e_vel_z] = EVF::Vec[2];
				} else {
					return SetVehicleVelocity(vehicleid,EVF::VehicleTempData[vehicleid][e_vel_x],EVF::VehicleTempData[vehicleid][e_vel_y],EVF::VehicleTempData[vehicleid][e_vel_z]);
				}
			#endif
			
			GetVehicleHealth(vehicleid,EVF::Vec[0]);
			#if defined OnVehicleHealthChange
				if(EVF::Vec[0] != EVF::VehicleTempData[vehicleid][e_health]){
					if(CallRemoteFunction("OnVehicleHealthChange","iff",vehicleid,EVF::Vec[0],EVF::VehicleTempData[vehicleid][e_health])){
						EVF::VehicleTempData[vehicleid][e_health] = EVF::Vec[0];
					} else {
						return SetVehicleHealth(vehicleid,EVF::VehicleTempData[vehicleid][e_health]);
					}
				}
			#endif
		}
	}
	return 1;
}

EVF::Public:: EVF::SetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective){
	SetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
}

EVF::Public:: EVF::OnVehicleBombActivate(playerid,vehicleid){
	SetVehicleParams(vehicleid,VEHICLE_TYPE_ALARM,1);
	SetVehiclePropertyValue(vehicleid,e_VEHICLE_BOMB_TIMER,SetTimerEx("EVF_OnVehicleBombExplode",1750,false,"ii",playerid,vehicleid));
	return 1;
}

EVF::Public:: EVF::ImportVehicle(vehicleid,modelid,Float:x,Float:y,Float:z,Float:angle,color1,color2,worldid,interiorid,unoccupied_damage){
	
	EVF::VehicleProperty[vehicleid][e_VEHICLE_SPAWN_X] = _:x;
	EVF::VehicleProperty[vehicleid][e_VEHICLE_SPAWN_Y] = _:y;
	EVF::VehicleProperty[vehicleid][e_VEHICLE_SPAWN_Z] = _:z;
	EVF::VehicleProperty[vehicleid][e_VEHICLE_SPAWN_A] = _:angle;
	
	EVF::VehicleProperty[vehicleid][e_VEHICLE_PAINTJOB] = RESET_PAINTJOB_ID;
	EVF::VehicleProperty[vehicleid][e_VEHICLE_INTERIOR] = interiorid;

	EVF::VehicleProperty[vehicleid][e_VEHICLE_COLOR_1] = color1;
	EVF::VehicleProperty[vehicleid][e_VEHICLE_COLOR_2] = color2;
	
	EVF::VehicleProperty[vehicleid][e_VEHICLE_HORN] = 0;
	EVF::VehicleProperty[vehicleid][e_VEHICLE_SPAWN_VW] = worldid;
	EVF::VehicleProperty[vehicleid][e_VEHICLE_SPAWN_INT] = interiorid;
	EVF::VehicleProperty[vehicleid][e_VEHICLE_SPEED_CAP] = 0;
	EVF::VehicleProperty[vehicleid][e_VEHICLE_FUEL_USE] = 0;
	EVF::VehicleProperty[vehicleid][e_VEHICLE_FUEL] = 0;
	EVF::VehicleProperty[vehicleid][e_VEHICLE_STICKY] = 0;
	EVF::VehicleProperty[vehicleid][e_VEHICLE_UNO_DAMAGE] = ((unoccupied_damage)?(1):(0));
	EVF::VehicleProperty[vehicleid][e_VEHICLE_EDITOR] = 0;
	EVF::VehicleProperty[vehicleid][e_VEHICLE_DAMAGE_PANELS] = 1;
	EVF::VehicleProperty[vehicleid][e_VEHICLE_DAMAGE_DOORS] = 1;
	EVF::VehicleProperty[vehicleid][e_VEHICLE_DAMAGE_LIGHTS] = 1;
	EVF::VehicleProperty[vehicleid][e_VEHICLE_DAMAGE_TIRES] = 1;
	EVF::VehicleProperty[vehicleid][e_VEHICLE_BOMB] = 0;
	EVF::VehicleProperty[vehicleid][e_VEHICLE_BOMB_TIMER] = -1;
	EVF::VehicleProperty[vehicleid][e_VEHICLE_BULLETPROOF] = 0;
	
	EVF::VehicleTempData[vehicleid][e_pos_x] = x;
	EVF::VehicleTempData[vehicleid][e_pos_y] = y;
	EVF::VehicleTempData[vehicleid][e_pos_z] = z;
	EVF::VehicleTempData[vehicleid][e_pos_a] = angle;

	EVF::VehicleTempData[vehicleid][e_vel_x] = 0.0;
	EVF::VehicleTempData[vehicleid][e_vel_y] = 0.0;
	EVF::VehicleTempData[vehicleid][e_vel_z] = 0.0;

	EVF::VehicleTempData[vehicleid][e_health] = 1000.0;
	
	EVF::VehicleTempData[vehicleid][e_uptime] = 0;
	
	SetVehiclePropertyValue(vehicleid,e_VEHICLE_STORED,1);
	
	return 1;
}

EVF::Public:: EVF::RemoveVehicle(vehicleid){
	SetVehiclePropertyValue(vehicleid,e_VEHICLE_STORED,0);
	return 1;
}

EVF::Public:: EVF::OnVehicleBombExplode(playerid,vehicleid){
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER){
		if(!CallRemoteFunction("OnVehicleBombDeactivate","i",vehicleid)){
			return SetVehicleParams(vehicleid,VEHICLE_TYPE_ALARM,0);
		}
	}
	CallRemoteFunction("OnVehicleBombExplode","i",vehicleid);
	SetVehicleParams(vehicleid,VEHICLE_TYPE_ALARM,0);
	new Float:pos[3];
	GetVehiclePos(vehicleid,pos[0],pos[1],pos[2]);
	#if defined TRYG3D_SAMP_INCLUDE
		CreateDynamicExplosion(pos[0],pos[1],pos[2],3,30.0,GetVehicleVirtualWorld(vehicleid),GetVehicleInterior(vehicleid),-1,200.0);
	#else
		CreateExplosion(pos[0],pos[1],pos[2],3,30.0);
	#endif
	SetVehicleToRespawn(vehicleid);
	if(GetPlayerVehicleID(playerid) == vehicleid){
		SetPlayerHealth(playerid,0.0);
		GameTextForPlayer(playerid,"~r~Bombed !",3500,3);
	}
	SetVehiclePropertyValue(vehicleid,e_VEHICLE_BOMB_TIMER,-1);
	return 1;
}

//Hook: SetVehicleHealth
stock EVF::SetVehicleHealth(vehicleid,Float:health){
	if(SetVehicleHealth(vehicleid,health)){
		EVF::VehicleTempData[vehicleid][e_health] = health;
		return 1;
	}
	return 0;
}
#if defined _ALS_SetVehicleHealth
	#undef SetVehicleHealth
#else
	#define _ALS_SetVehicleHealth
#endif
#define SetVehicleHealth EVF_SetVehicleHealth

//Hook: SetVehiclePos
stock EVF::SetVehiclePos(vehicleid,Float:x,Float:y,Float:z){
	if(SetVehiclePos(vehicleid,Float:x,Float:y,Float:z)){
		EVF::VehicleTempData[vehicleid][e_pos_x] = x;
		EVF::VehicleTempData[vehicleid][e_pos_y] = y;
		EVF::VehicleTempData[vehicleid][e_pos_z] = z;
		return 1;
	}
	return 0;
}

#if defined _ALS_SetVehiclePos
	#undef SetVehiclePos
#else
	#define _ALS_SetVehiclePos
#endif
#define SetVehiclePos EVF_SetVehiclePos

//Hook: SetVehicleZAngle
stock EVF::SetVehicleZAngle(vehicleid,Float:angle){
	if(SetVehicleZAngle(vehicleid,angle)){
		EVF::VehicleTempData[vehicleid][e_pos_a] = angle;
		return 1;
	}
	return 0;
}

#if defined _ALS_SetVehicleZAngle
	#undef SetVehicleZAngle
#else
	#define _ALS_SetVehicleZAngle
#endif
#define SetVehicleZAngle EVF_SetVehicleZAngle

//Hook: LinkVehicleToInterior
stock EVF::LinkVehicleToInterior(vehicleid,interiorid){
	if(LinkVehicleToInterior(vehicleid,interiorid)){
		SetVehiclePropertyValue(vehicleid,e_VEHICLE_INTERIOR,interiorid);
		return 1;
	}
	return 0;
}

#if defined _ALS_LinkVehicleToInterior
	#undef LinkVehicleToInterior
#else
	#define _ALS_LinkVehicleToInterior
#endif
#define LinkVehicleToInterior EVF_LinkVehicleToInterior

//Hook: ChangeVehicleColor
stock EVF::ChangeVehicleColor(vehicleid,color1,color2){
	new randcolor1, randcolor2;
	if(GetVehicleRandomColors(GetVehicleModel(vehicleid),randcolor1,randcolor2)){
		if(color1 == -1) color1 = randcolor1;
		if(color2 == -1) color2 = randcolor2;
	}
	if(ChangeVehicleColor(vehicleid,color1,color2)){
		SetVehiclePropertyValue(vehicleid,e_VEHICLE_COLOR_1,color1);
		SetVehiclePropertyValue(vehicleid,e_VEHICLE_COLOR_2,color2);
		return 1;
	}
	return 0;
}

#if defined _ALS_ChangeVehicleColor
	#undef ChangeVehicleColor
#else
	#define _ALS_ChangeVehicleColor
#endif
#define ChangeVehicleColor EVF_ChangeVehicleColor

//Hook: ChangeVehiclePaintjob
stock EVF::ChangeVehiclePaintjob(vehicleid,paintjobid){
	if(ChangeVehiclePaintjob(vehicleid,paintjobid)){
		SetVehiclePropertyValue(vehicleid,e_VEHICLE_PAINTJOB,paintjobid);
		if(paintjobid == RESET_PAINTJOB_ID){
			new color1,color2;
			if(EVF::GetVehicleColor(vehicleid,color1,color2)){
				ChangeVehicleColor(vehicleid,color1,color2);
			}
		}
		return 1;
	}
	return 0;
}

#if defined _ALS_ChangeVehiclePaintjob
	#undef ChangeVehiclePaintjob
#else
	#define _ALS_ChangeVehiclePaintjob
#endif
#define ChangeVehiclePaintjob EVF_ChangeVehiclePaintjob

//Hook: OnVehicleRespray
public OnVehicleRespray(playerid,vehicleid,color1,color2){
	SetVehiclePropertyValue(vehicleid,e_VEHICLE_COLOR_1,color1);
	SetVehiclePropertyValue(vehicleid,e_VEHICLE_COLOR_2,color2);
	#if defined EVF_OnVehicleRespray
		EVF::OnVehicleRespray(playerid,vehicleid,color1,color2);
	#endif
	return 1;
}

#if defined _ALS_OnVehicleRespray
	#undef OnVehicleRespray
#else
	#define _ALS_OnVehicleRespray
#endif
#define OnVehicleRespray EVF_OnVehicleRespray
#if defined EVF_OnVehicleRespray
	forward EVF_OnVehicleRespray(playerid,vehicleid,color1,color2);
#endif

//Hook: OnVehiclePaintjob
public OnVehiclePaintjob(playerid,vehicleid,paintjobid){
	SetVehiclePropertyValue(vehicleid,e_VEHICLE_PAINTJOB,paintjobid);
	#if defined EVF_OnVehiclePaintjob
		EVF::OnVehiclePaintjob(playerid,vehicleid,paintjobid);
	#endif
	return 1;
}

#if defined _ALS_OnVehiclePaintjob
	#undef OnVehiclePaintjob
#else
	#define _ALS_OnVehiclePaintjob
#endif
#define OnVehiclePaintjob EVF_OnVehiclePaintjob
#if defined EVF_OnVehiclePaintjob
	forward EVF_OnVehiclePaintjob(playerid,vehicleid,paintjobid);
#endif

//Hook: CreateVehicle
stock EVF::CreateVehicle(modelid,Float:x,Float:y,Float:z,Float:angle,color1,color2,respawn_delay,addsiren = 0,worldid = 0,interiorid = 0,bool:unoccupied_damage = false){
	if(!IsValidVehicleModelID(modelid)) return INVALID_VEHICLE_ID;
	new vehicleid = INVALID_VEHICLE_ID, randcolor1, randcolor2;
	if(GetVehicleRandomColors(modelid,randcolor1,randcolor2)){
		if(color1 == -1) color1 = randcolor1;
		if(color2 == -1) color2 = randcolor2;
	}
	switch(modelid){
		case 569, 570, 537, 538: 	vehicleid = AddStaticVehicleEx(modelid,x,y,z,angle,color1,color2,respawn_delay,addsiren);
		default: 					vehicleid = CreateVehicle(modelid,x,y,z,angle,color1,color2,respawn_delay,addsiren);
	}
	if(vehicleid == INVALID_VEHICLE_ID || !IsValidVehicle(vehicleid)){
		printf("[ADM] Error: Your server have reached MAX_VEHICLES limit (%i).",MAX_VEHICLES);
		return INVALID_VEHICLE_ID;
	}
	
	ResetVehicleProperties(vehicleid);
	
	#if defined EVF_Streamer
		for(new i = 0; i < MAX_VEHICLE_ATTACHED_OBJECTS; i++){
			EVF::VehicleTempData[vehicleid][e_attached_object][i] = STREAMER_TAG_OBJECT:INVALID_STREAMER_ID;
		}
	#endif
	EVF::VehicleTempData[vehicleid][e_pos_x] = x;
	EVF::VehicleTempData[vehicleid][e_pos_y] = y;
	EVF::VehicleTempData[vehicleid][e_pos_z] = z;
	EVF::VehicleTempData[vehicleid][e_pos_a] = angle;

	EVF::VehicleTempData[vehicleid][e_vel_x] = 0.0;
	EVF::VehicleTempData[vehicleid][e_vel_y] = 0.0;
	EVF::VehicleTempData[vehicleid][e_vel_z] = 0.0;

	EVF::VehicleTempData[vehicleid][e_health] = 1000.0;
	
	EVF::VehicleTempData[vehicleid][e_uptime] = 0;
	
	LinkVehicleToInterior(vehicleid,interiorid);
	SetVehicleVirtualWorld(vehicleid,worldid);
	
	SetVehicleHorn(vehicleid,0);
	SetVehicleFuel(vehicleid,DEFAULT_VEHICLE_FUEL);
	SetVehicleSpeedCap(vehicleid,0.0);
	
	ToggleUnoccupiedVehicleDamage(vehicleid,unoccupied_damage);
	ToggleVehicleSticky(vehicleid,0);
	ToggleVehicleFuel(vehicleid,0);
	
	SetVehiclePropertyValue(vehicleid,e_VEHICLE_COLOR_1,color1);
	SetVehiclePropertyValue(vehicleid,e_VEHICLE_COLOR_2,color2);
	SetVehiclePropertyValue(vehicleid,e_VEHICLE_PAINTJOB,RESET_PAINTJOB_ID);
	
	SetVehiclePropertyValue(vehicleid,e_VEHICLE_SPAWN_X,_:x);
	SetVehiclePropertyValue(vehicleid,e_VEHICLE_SPAWN_Y,_:y);
	SetVehiclePropertyValue(vehicleid,e_VEHICLE_SPAWN_Z,_:z);
	SetVehiclePropertyValue(vehicleid,e_VEHICLE_SPAWN_A,_:angle);
	SetVehiclePropertyValue(vehicleid,e_VEHICLE_SPAWN_VW,worldid);
	SetVehiclePropertyValue(vehicleid,e_VEHICLE_SPAWN_INT,interiorid);
	SetVehiclePropertyValue(vehicleid,e_VEHICLE_EDITOR,0);
	SetVehiclePropertyValue(vehicleid,e_VEHICLE_BOMB,0);
	SetVehiclePropertyValue(vehicleid,e_VEHICLE_BOMB_TIMER,-1);
	SetVehiclePropertyValue(vehicleid,e_VEHICLE_BULLETPROOF,0);
	SetVehiclePropertyValue(vehicleid,e_VEHICLE_STORED,1);
	
	for(new i = 0; i < 4; i++) ToggleVehicleDamageUpdate(vehicleid,i,1);
	
	CallRemoteFunction("OnVehicleCreated","i",vehicleid);
	return vehicleid;
}

#if defined _ALS_CreateVehicle
	#undef CreateVehicle
#else
	#define _ALS_CreateVehicle
#endif
#define CreateVehicle EVF_CreateVehicle

//Hook: AddStaticVehicle
stock EVF::AddStaticVehicle(modelid,Float:spawn_x,Float:spawn_y,Float:spawn_z,Float:z_angle,color1,color2){
	return EVF::CreateVehicle(modelid,spawn_x,spawn_y,spawn_z,z_angle,color1,color2,-1);
}

#if defined _ALS_AddStaticVehicle
	#undef AddStaticVehicle
#else
	#define _ALS_AddStaticVehicle
#endif
#define AddStaticVehicle 	EVF_AddStaticVehicle

//Hook: AddStaticVehicleEx
stock EVF::AddStaticVehicleEx(modelid,Float:spawn_x,Float:spawn_y,Float:spawn_z,Float:z_angle,color1,color2,respawn_delay,addsiren=0){
	return EVF::CreateVehicle(modelid,spawn_x,spawn_y,spawn_z,z_angle,color1,color2,respawn_delay,addsiren);
}

#if defined _ALS_AddStaticVehicleEx
	#undef AddStaticVehicleEx
#else
	#define _ALS_AddStaticVehicleEx
#endif
#define AddStaticVehicleEx EVF_CreateVehicle

//Hook: DestroyVehicle
stock EVF::DestroyVehicle(vehicleid){
	if(!IsValidVehicle(vehicleid)) return 0;
	EVF::Foreach(i){
		if(EVF::PlayerTempData[i][e_editor_vehicle] == GetVehiclePropertyValue(vehicleid,e_VEHICLE_EDITOR)){
			CancelEdit(i);
		}
	}
	#if defined EVF_Streamer
		new objectid = GetVehiclePropertyValue(vehicleid,e_VEHICLE_EDITOR);
		DestroyDynamicObject(STREAMER_TAG_OBJECT:objectid);
		for(new i = 0; i < MAX_VEHICLE_ATTACHED_OBJECTS; i++){
			if(IsValidDynamicObject(EVF::VehicleTempData[vehicleid][e_attached_object][i])){
				DestroyDynamicObject(EVF::VehicleTempData[vehicleid][e_attached_object][i]);
				EVF::VehicleTempData[vehicleid][e_attached_object][i] = STREAMER_TAG_OBJECT:INVALID_STREAMER_ID;
			}
		}
		for(new slotid = 0; slotid < MAX_VEHICLE_NEON_SLOT; slotid++){
			SetVehicleNeonLights(vehicleid,false,RED_NEON,slotid);
		}
	#endif
	EVF::VehicleTempData[vehicleid][e_uptime] = 0;
	CallRemoteFunction("OnVehicleDestroyed","i",vehicleid);
	ResetVehicleProperties(vehicleid);
	return DestroyVehicle(vehicleid);
}

#if defined _ALS_DestroyVehicle
	#undef DestroyVehicle
#else
	#define _ALS_DestroyVehicle
#endif
#define DestroyVehicle EVF_DestroyVehicle

//Hook: OnPlayerWeaponShot
public OnPlayerWeaponShot(playerid,weaponid,hittype,hitid,Float:fX,Float:fY,Float:fZ){
	if(hittype == BULLET_HIT_TYPE_VEHICLE){
		if(IsToggledVehicleBulletproof(hitid)) return 0;
		new Float:fHealth, EVF::VehicleBodyPart:bodypart = VEHICLE_BODYPART_UNKNOWN, Float:fDamage = EVF::WeaponDamage[GetPlayerWeapon(playerid)];
		GetVehicleHealth(hitid,fHealth);
		if(fHealth > 249.0){
			new fModelid = GetVehicleModel(hitid), Float:fOffSet[3], fUpdate;
			if(IsUnoccupiedDamageToggled(hitid) || IsVehicleOccupied(hitid)){
				//front wheels
				GetVehicleModelInfo(fModelid,VEHICLE_MODEL_INFO_WHEELSFRONT,fOffSet[0],fOffSet[1],fOffSet[2]);
				if(VectorSize(fX+fOffSet[0],fY-fOffSet[1],fZ-fOffSet[2]) <= 0.4){
					//left
					fUpdate = EVF::GetVehicleDamageStatus(hitid,VEHICLE_DAMAGE_TIRES) + 8;
					if(fUpdate > 15){
						EVF::UpdateVehicleDamageStatus(hitid,VEHICLE_DAMAGE_TIRES,fUpdate);
					}
					bodypart = VEHICLE_BODYPART_FL_WHEEL;
				} else if(VectorSize(fX-fOffSet[0],fY-fOffSet[1],fZ-fOffSet[2]) <= 0.4){
					//right
					fUpdate = EVF::GetVehicleDamageStatus(hitid,VEHICLE_DAMAGE_TIRES) + 2;
					if(fUpdate > 15){
						EVF::UpdateVehicleDamageStatus(hitid,VEHICLE_DAMAGE_TIRES,fUpdate);
					}
					bodypart = VEHICLE_BODYPART_FR_WHEEL;
				} else {
					//back wheels
					GetVehicleModelInfo(fModelid,VEHICLE_MODEL_INFO_WHEELSREAR,fOffSet[0],fOffSet[1],fOffSet[2]);
					if(VectorSize(fX+fOffSet[0],fY-fOffSet[1],fZ-fOffSet[2]) <= 0.4){
						//left
						fUpdate = EVF::GetVehicleDamageStatus(hitid,VEHICLE_DAMAGE_TIRES) + 4;
						if(fUpdate > 15){
							EVF::UpdateVehicleDamageStatus(hitid,VEHICLE_DAMAGE_TIRES,fUpdate);
						}
						bodypart = VEHICLE_BODYPART_BL_WHEEL;
					} else if(VectorSize(fX-fOffSet[0],fY-fOffSet[1],fZ-fOffSet[2]) <= 0.4){
						//right
						fUpdate = EVF::GetVehicleDamageStatus(hitid,VEHICLE_DAMAGE_TIRES) + 1;
						if(fUpdate > 15){
							EVF::UpdateVehicleDamageStatus(hitid,VEHICLE_DAMAGE_TIRES,fUpdate);
						}
						bodypart = VEHICLE_BODYPART_BR_WHEEL;
					} else {
						GetVehicleModelInfo(fModelid,VEHICLE_MODEL_INFO_PETROLCAP,fOffSet[0],fOffSet[1],fOffSet[2]);
						if(VectorSize(fX-fOffSet[0],fY-fOffSet[1],fZ-fOffSet[2]) <= 0.2){
							bodypart = VEHICLE_BODYPART_PETROLCAP;
						} else {
							fHealth -= fDamage;
							SetVehicleHealth(hitid,fHealth);
							switch(floatround(fHealth)){
								case 251..399: return EVF::UpdateVehicleDamage(hitid,VEHICLE_DAMAGE_DOORS);
								case 400..599: return EVF::UpdateVehicleDamage(hitid,VEHICLE_DAMAGE_PANELS);
								case 600..700: return EVF::UpdateVehicleDamage(hitid,VEHICLE_DAMAGE_LIGHTS);
							}
						}
					}
				}
			}
		} else {
			SetVehicleToRespawn(hitid);
		}
		CallRemoteFunction("OnPlayerShotVehicle","dddfd",playerid,hitid,weaponid,fDamage,_:bodypart);
	}
	#if defined EVF_OnPlayerWeaponShot
		return EVF::OnPlayerWeaponShot(playerid,weaponid,hittype,hitid,fX,fY,fZ);
	#else
		return 1;
	#endif
}

#if defined _ALS_OnPlayerWeaponShot
	#undef OnPlayerWeaponShot
#else
	#define _ALS_OnPlayerWeaponShot
#endif
#define OnPlayerWeaponShot EVF_OnPlayerWeaponShot
#if defined EVF_OnPlayerWeaponShot
	forward EVF_OnPlayerWeaponShot(playerid,weaponid,hittype,hitid,Float:fX,Float:fY,Float:fZ);
#endif

//Hook: OnPlayerConnect
public OnPlayerConnect(playerid){
	EVF::ModShopStatus[playerid] = false;
	#if defined EVF_OnPlayerConnect
		return EVF::OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect EVF_OnPlayerConnect
#if defined EVF_OnPlayerConnect
	forward EVF_OnPlayerConnect(playerid);
#endif

//Hook: OnEnterExitModShop
public OnEnterExitModShop(playerid,enterexit,interiorid){
	EVF::ModShopStatus[playerid] = enterexit;
	#if defined EVF_OnEnterExitModShop
	    return EVF::OnEnterExitModShop(playerid, enterexit, interiorid);
	#else
	    return 1;
	#endif
}

#if defined _ALS_OnEnterExitModShop
	#undef OnEnterExitModShop
#else
	#define _ALS_OnEnterExitModShop
#endif
#define OnEnterExitModShop EVF_OnEnterExitModShop
#if defined EVF_OnEnterExitModShop
	forward EVF_OnEnterExitModShop(playerid, enterexit, interiorid);
#endif

//Hook: OnVehicleMod
public OnVehicleMod(playerid,vehicleid,componentid){
	if(!IsValidVehicle(vehicleid)) return 0;
	if(!IsValidComponentForVehicle(vehicleid,componentid) || !EVF::ModShopStatus[playerid] || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER){
	    CallRemoteFunction("OnVehicleModEx","iiiii",playerid,vehicleid,componentid,GetVehicleComponentPrice(componentid),true);
	    return 0;
	}
	CallRemoteFunction("OnVehicleModEx","iiiii",playerid,vehicleid,componentid,GetVehicleComponentPrice(componentid),false);
	#if defined EVF_OnVehicleMod
	    return EVF::OnVehicleMod(playerid,vehicleid,componentid);
	#else
	    return 1;
	#endif
}

#if defined _ALS_OnVehicleMod
	#undef OnVehicleMod
#else
	#define _ALS_OnVehicleMod
#endif
#define OnVehicleMod EVF_OnVehicleMod
#if defined EVF_OnVehicleMod
	forward EVF_OnVehicleMod(playerid, vehicleid, componentid);
#endif

#if defined EVF_Streamer
	stock EVF::AttachObjectToVehicle(STREAMER_TAG_OBJECT:objectid,vehicleid,Float:OffsetX,Float:OffsetY,Float:OffsetZ,Float:RotX,Float:RotY,Float:RotZ){
		for(new i = 0; i < MAX_VEHICLE_ATTACHED_OBJECTS; i++){
			if(!IsValidDynamicObject(EVF::VehicleTempData[vehicleid][e_attached_object][i])){
				if(AttachDynamicObjectToVehicle(objectid,vehicleid,OffsetX,OffsetY,OffsetZ,RotX,RotY,RotZ)){
					EVF::VehicleTempData[vehicleid][e_attached_object][i] = objectid;
					return true;
				}
			}
		}
		return false;
	}

	#if defined _ALS_AttachDynamicObjectToV
		#undef AttachDynamicObjectToVehicle
	#else
		#define _ALS_AttachDynamicObjectToV
	#endif
	#define AttachDynamicObjectToVehicle EVF_AttachObjectToVehicle
	
	//Hook: OnPlayerEditDynamicObject
	public OnPlayerEditDynamicObject(playerid,STREAMER_TAG_OBJECT:objectid,response,Float:x,Float:y,Float:z,Float:rx,Float:ry,Float:rz){
		if(IsValidVehicle(EVF::PlayerTempData[playerid][e_editor_vehicle])){
			if(EVF::PlayerTempData[playerid][e_editor_object] == STREAMER_TAG_OBJECT:INVALID_STREAMER_ID){
				if(GetVehiclePropertyValue(EVF::PlayerTempData[playerid][e_editor_vehicle],e_VEHICLE_EDITOR) == _:objectid){
					SetVehiclePos(EVF::PlayerTempData[playerid][e_editor_vehicle],x,y,z);
					SetVehicleZAngle(EVF::PlayerTempData[playerid][e_editor_vehicle],rz);

					CallLocalFunction("OnPlayerEditVehicle","iiiffff",playerid,EVF::PlayerTempData[playerid][e_editor_vehicle],response,x,y,z,rz);

					switch(response){
						case EDIT_RESPONSE_CANCEL, EDIT_RESPONSE_FINAL:{
							DestroyDynamicObject(objectid);
							SetVehiclePropertyValue(EVF::PlayerTempData[playerid][e_editor_vehicle],e_VEHICLE_EDITOR,INVALID_STREAMER_ID);

							SetVehicleVelocity(EVF::PlayerTempData[playerid][e_editor_vehicle],0.0,0.0,0.0);

							EVF::PlayerTempData[playerid][e_editor_vehicle] = INVALID_VEHICLE_ID;
							EVF::PlayerTempData[playerid][e_editor_object] = STREAMER_TAG_OBJECT:INVALID_STREAMER_ID;
						}
					}
				}
			} else {
				if(GetVehiclePropertyValue(EVF::PlayerTempData[playerid][e_editor_vehicle],e_VEHICLE_EDITOR) == _:objectid){
					switch(response){
						case EDIT_RESPONSE_CANCEL, EDIT_RESPONSE_FINAL:{
							new Float:pos[4];
							GetVehiclePos(EVF::PlayerTempData[playerid][e_editor_vehicle],pos[0],pos[1],pos[2]);
							GetVehicleZAngle(EVF::PlayerTempData[playerid][e_editor_vehicle],pos[3]);

							new Float:new_pos[4];
							new_pos[0] = x - pos[0];
							new_pos[1] = y - pos[1];
							new_pos[2] = z - pos[2];
							new_pos[3] = rz - pos[3];

							new Float:final_pos[2];
							final_pos[0] = (new_pos[0] * floatcos(new_pos[3],degrees)) + (new_pos[1] * floatsin(new_pos[3],degrees));
							final_pos[1] = (new_pos[1] * floatcos(new_pos[3],degrees)) - (new_pos[0] * floatsin(new_pos[3],degrees));

							AttachDynamicObjectToVehicle(EVF::PlayerTempData[playerid][e_editor_object],EVF::PlayerTempData[playerid][e_editor_vehicle],final_pos[0],final_pos[1],new_pos[2],rx,ry,new_pos[3]);

							SetVehiclePropertyValue(EVF::PlayerTempData[playerid][e_editor_vehicle],e_VEHICLE_EDITOR,0);

							CallLocalFunction("OnPlayerEditVehicleObject","iiiffffff",playerid,EVF::PlayerTempData[playerid][e_editor_vehicle],response,final_pos[0],final_pos[1],new_pos[2],rx,ry,new_pos[3]);
							
							EVF::PlayerTempData[playerid][e_editor_vehicle] = INVALID_VEHICLE_ID;
							EVF::PlayerTempData[playerid][e_editor_object] = STREAMER_TAG_OBJECT:INVALID_STREAMER_ID;
						}
						default: 
						{
							CallLocalFunction("OnPlayerEditVehicleObject","iiiffffff",playerid,EVF::PlayerTempData[playerid][e_editor_vehicle],response,x,y,z,rx,ry,rz);
						}
					}
				}
			}
		}
		#if defined EVF_OnPlayerEditDynamicObject
			EVF::OnPlayerEditDynamicObject(playerid,objectid,response,x,y,z,rx,ry,rz);
		#endif
		return 1;
	}

	#if defined _ALS_OnPlayerEditDynamicObject
		#undef OnPlayerEditDynamicObject
	#else
		#define _ALS_OnPlayerEditDynamicObject
	#endif
	#define OnPlayerEditDynamicObject EVF_OnPlayerEditDynamicObject
	#if defined EVF_OnPlayerEditDynamicObject
		forward EVF_OnPlayerEditDynamicObject(playerid,STREAMER_TAG_OBJECT:objectid,response,Float:x,Float:y,Float:z,Float:rx,Float:ry,Float:rz);
	#endif
#endif

//Hook: OnPlayerUpdate
public OnPlayerUpdate(playerid){
 	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
		new vehicleid = GetPlayerVehicleID(playerid), Float:speedcap = GetVehicleSpeedCap(vehicleid);
		if(speedcap != 0.0){
			new Float:vel[3], Float:speed;
			GetVehicleVelocity(vehicleid,vel[0],vel[1],vel[2]);
			speed = EVF::GetVehicleSpeed(vehicleid);
			if(speed > speedcap && speed > 0.0){
				CallRemoteFunction("OnPlayerReachSpeedCapLimit","iif",playerid,vehicleid,speed);
				vel[0] = (vel[0] / speed) * speedcap;
				vel[1] = (vel[1] / speed) * speedcap;
				vel[2] = (vel[2] / speed) * speedcap;
				SetVehicleVelocity(vehicleid,vel[0],vel[1],vel[2]);
			}
		}
		new trailerid = GetVehicleTrailer(vehicleid);
		if(EVF::VehicleTrailerID[vehicleid] != trailerid){
			if(trailerid != 0){
				CallRemoteFunction("OnTrailerHooked","iii",playerid,vehicleid,trailerid);
				#if defined EVF_Streamer
					EVF::SetCarBlinking(trailerid,EVF::BlinkSide[vehicleid]);
				#endif
			} else {
				if(EVF::VehicleTrailerID[vehicleid] != INVALID_VEHICLE_ID){
					CallRemoteFunction("OnTrailerUnhooked","iii",playerid,vehicleid,EVF::VehicleTrailerID[vehicleid]);
				
					#if defined EVF_Streamer
						if(GetPlayerVehicleSeat(playerid) == 0){
							EVF::DisableCarBlinking(EVF::VehicleTrailerID[vehicleid]);
						}
					#endif
				}
			}
			EVF::VehicleTrailerID[vehicleid] = trailerid;
		}
	}
	#if defined EVF_OnPlayerUpdate
		EVF::OnPlayerUpdate(playerid);
	#endif
	return 1;
}

#if defined EVF_OnPlayerUpdate
	forward EVF_OnPlayerUpdate(playerid);
#endif
#if defined _ALS_OnPlayerUpdate
	#undef OnPlayerUpdate
#else
	#define _ALS_OnPlayerUpdate
#endif
#define OnPlayerUpdate EVF_OnPlayerUpdate

//Hook: OnPlayerStateChange
public OnPlayerStateChange(playerid,newstate,oldstate){
	if(newstate == PLAYER_STATE_DRIVER){
		new vehicleid = GetPlayerVehicleID(playerid);
		if(IsVehicleBombed(vehicleid)){
			if(!IsVehicleBombActivated(vehicleid)){
				CallRemoteFunction("OnVehicleBombActivate","i",vehicleid);
				new interval = (GetVehicleBomb(vehicleid) - 1750);
				if(interval < 1750){
					SetVehicleParams(vehicleid,VEHICLE_TYPE_ALARM,1);
					SetVehiclePropertyValue(vehicleid,e_VEHICLE_BOMB_TIMER,SetTimerEx("EVF_OnVehicleBombExplode",GetVehicleBomb(vehicleid),false,"ii",playerid,vehicleid));
				} else {
					SetVehiclePropertyValue(vehicleid,e_VEHICLE_BOMB_TIMER,SetTimerEx("EVF_OnVehicleBombActivate",interval,false,"ii",playerid,vehicleid));
				}
			}
		}
		if(IsVehicleSticky(vehicleid)){
			SetVehicleParams(vehicleid,VEHICLE_TYPE_ENGINE,0);
		}
	}
	if(oldstate == PLAYER_STATE_DRIVER){
		new vehicleid = GetPlayerVehicleID(playerid);
		if(IsVehicleSticky(vehicleid)){
			SetVehicleParams(vehicleid,VEHICLE_TYPE_ENGINE,1);
		}
		#if defined EVF_Streamer
			EVF::DisableCarBlinking(vehicleid);
			new trailerid = GetVehicleTrailer(vehicleid);
			if(IsValidVehicle(trailerid)) EVF::DisableCarBlinking(trailerid);
		#endif
	}
	#if defined EVF_OnPlayerStateChange
		EVF::OnPlayerStateChange(playerid,newstate,oldstate);
	#endif
	return 1;
}
#if defined EVF_OnPlayerStateChange
	forward EVF_OnPlayerStateChange(playerid,newstate,oldstate);
#endif
#if defined _ALS_OnPlayerStateChange
	#undef OnPlayerStateChange
#else
	#define _ALS_OnPlayerStateChange
#endif
#define OnPlayerStateChange EVF_OnPlayerStateChange

//Hook: OnPlayerKeyStateChange
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys){
	if(newkeys & KEY_CROUCH){
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
			new horn = GetVehicleHorn(GetPlayerVehicleID(playerid));
			if(horn != 0){
				new Float:pos[3];
				GetPlayerPos(playerid,pos[0],pos[1],pos[2]);
				EVF::Foreach(i){
					if(IsPlayerInRangeOfPoint(i,35.0,pos[0],pos[1],pos[2])){
						PlayerPlaySound(playerid,horn,pos[0],pos[1],pos[2]);
					}
				}
			}
		}
	}
	
	#if defined EVF_Streamer
		if(EVF::IsToggledVehicleBlinking()){
			new vehicleid = GetPlayerVehicleID(playerid);
			if(IsValidVehicle(vehicleid)){
				if(GetPlayerVehicleSeat(playerid) == 0){
					if(EVF::KeyPressed(KEY_LOOK_BEHIND)){
						if(!EVF::IsCarBlinking(vehicleid)){
							EVF::SetCarBlinking(vehicleid,EVF_CAR_BLINK_EMERGENCY);
						} else {
							EVF::DisableCarBlinking(vehicleid);
						}
					}
					if(EVF::KeyPressed(KEY_LOOK_LEFT)){
						if(!EVF::IsCarBlinking(vehicleid)){
							EVF::SetCarBlinking(vehicleid,EVF_CAR_BLINK_LEFT);
						} else {
							EVF::DisableCarBlinking(vehicleid);
						}
					} else if(EVF::KeyPressed(KEY_LOOK_RIGHT)){
						if(!EVF::IsCarBlinking(vehicleid)){
							EVF::SetCarBlinking(vehicleid,EVF_CAR_BLINK_RIGHT);
						} else {
							EVF::DisableCarBlinking(vehicleid);
						}
					}
					if(EVF::IsCarBlinking(vehicleid)){
						new Float:tmp_a, Float:tmp_b = EVF::BlinkR[vehicleid];
						GetVehicleZAngle(vehicleid,tmp_a);
						
						switch(EVF::BlinkSide[vehicleid]){
							case EVF_CAR_BLINK_LEFT: {
								tmp_b += 55.0;
								if(tmp_b > 360.0) tmp_b -= 360.0;
								if(tmp_a < tmp_b-180.0) tmp_a = tmp_a+360.0;
								if(tmp_b < tmp_a-180.0) tmp_b = tmp_b+360.0;

								if(tmp_a > tmp_b){
									EVF::DisableCarBlinking(vehicleid);
								}
							}
							case EVF_CAR_BLINK_RIGHT: {
								tmp_b -= 55.0;
								if(tmp_b < 0.0) tmp_b = 360.0 + tmp_b;
								if(tmp_a < tmp_b-180.0) tmp_a = tmp_a+360.0;
								if(tmp_b < tmp_a-180.0) tmp_b = tmp_b+360.0;

								if(tmp_a < tmp_b){
									EVF::DisableCarBlinking(vehicleid);
								}
							}
						}
					}
				}
			}
		}
	#endif
	
	#if defined EVF_OnPlayerKeyStateChange
		EVF::OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	#endif
	return 1;
}

#if defined EVF_OnPlayerKeyStateChange
	forward EVF_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif
#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange EVF_OnPlayerKeyStateChange

//Hook: OnVehicleDamageStatusUpdate
public OnVehicleDamageStatusUpdate(vehicleid, playerid){
	new panels, doors, lights, tires;
	GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);

	if(!IsVehicleDamageToggled(vehicleid,VEHICLE_DAMAGE_PANELS)) EVF::UpdateVehicleDamageStatus(vehicleid,VEHICLE_DAMAGE_PANELS,0);
	if(!IsVehicleDamageToggled(vehicleid,VEHICLE_DAMAGE_DOORS)) EVF::UpdateVehicleDamageStatus(vehicleid,VEHICLE_DAMAGE_DOORS,0);
	if(!IsVehicleDamageToggled(vehicleid,VEHICLE_DAMAGE_LIGHTS)) EVF::UpdateVehicleDamageStatus(vehicleid,VEHICLE_DAMAGE_LIGHTS,0);
	if(!IsVehicleDamageToggled(vehicleid,VEHICLE_DAMAGE_TIRES)) EVF::UpdateVehicleDamageStatus(vehicleid,VEHICLE_DAMAGE_TIRES,0);

	#if defined EVF_OVDSU
		EVF::OVDSU(vehicleid,playerid);
	#endif
	return 1;
}
#if defined EVF_OVDSU
	forward EVF_OVDSU(vehicleid, playerid);
#endif
#if defined _ALS_OnVehicleDamageStatusU
	#undef OnVehicleDamageStatusUpdate
#else
	#define _ALS_OnVehicleDamageStatusU
#endif
#define OnVehicleDamageStatusUpdate EVF_OVDSU

//Hook: OnVehicleSpawn
public OnVehicleSpawn(vehicleid){
	if(!IsValidVehicle(vehicleid)) return 0;
	SetVehiclePropertyValue(vehicleid,e_VEHICLE_PAINTJOB,RESET_PAINTJOB_ID);

	new color1,color2;
	if(EVF::GetVehicleColor(vehicleid,color1,color2)){
		ChangeVehicleColor(vehicleid,color1,color2);
	}
	
	#if defined EVF_Streamer
		EVF::DisableCarBlinking(vehicleid);
	#endif

	new Float:pos[3];
	GetVehiclePos(vehicleid,pos[0],pos[1],pos[2]);

	new Float:angle;
	GetVehicleZAngle(vehicleid,angle);

	new Float:vehicle_pos[3],Float:vehicle_angle,vehicle_worldid,vehicle_interiorid;
	EVF::GetVehicleSpawnInfo(vehicleid,vehicle_pos[0],vehicle_pos[1],vehicle_pos[2],vehicle_angle,vehicle_worldid,vehicle_interiorid);

	if(vehicle_pos[0] != 0.0 && vehicle_pos[1] != 0.0 && vehicle_pos[2] != 0.0){
		if(pos[0] != vehicle_pos[0] || pos[1] != vehicle_pos[1] || pos[2] != vehicle_pos[2] || angle != vehicle_angle || vehicle_worldid != GetVehicleVirtualWorld(vehicleid) || vehicle_interiorid != GetVehicleInterior(vehicleid)){
			TeleportVehicle(vehicleid,vehicle_pos[0],vehicle_pos[1],vehicle_pos[2],vehicle_angle,vehicle_worldid,vehicle_interiorid);
		}
	}

	#if defined EVF_OnVehicleSpawn
		EVF::OnVehicleSpawn(vehicleid);
	#endif
	return 1;
}

#if defined EVF_OnVehicleSpawn
	forward EVF_OnVehicleSpawn(vehicleid);
#endif
#if defined _ALS_OnVehicleSpawn
	#undef OnVehicleSpawn
#else
	#define _ALS_OnVehicleSpawn
#endif
#define OnVehicleSpawn EVF_OnVehicleSpawn

//Hook: OnVehicleDeath
public OnVehicleDeath(vehicleid,killerid){
	
	#if defined EVF_Streamer
		EVF::DisableCarBlinking(vehicleid);
	#endif

	#if defined EVF_OnVehicleDeath
		EVF::OnVehicleDeath(vehicleid,killerid);
	#endif
	return 1;
}

#if defined EVF_OnVehicleDeath
	forward EVF_OnVehicleDeath(vehicleid,killerid);
#endif
#if defined _ALS_OnVehicleDeath
	#undef OnVehicleDeath
#else
	#define _ALS_OnVehicleDeath
#endif
#define OnVehicleDeath EVF_OnVehicleDeath

new EVF::UpdateTimer = -1;

stock EVF::Init(){
	SetSVarInt("ADM:EVF:ACTIVE",EVF::GetActiveCount()+1);
	
	//Welcome to EVF
	new EVF::ver_name[16];
	format(EVF::ver_name,sizeof(EVF::ver_name),"%d.%d.%d",(EVF_Version / 10000),((EVF_Version % 10000) / 100),((EVF_Version % 10000) % 100));
	if(GetSVarInt("ADM:EVF:INIT") == 0){
		SetSVarInt("ADM:EVF:INIT",1);
		printf("[ADM] Info: Load EVF v%s for SA:MP %s by Abyss Morgan",EVF::ver_name,EVF_SAMP_VERSION);
	}
	
	EVF::UpdateTimer = SetTimerEx("OnVehicleTimeUpdate",VEHICLE_UPDATE_INTERVAL,true,"");
}

stock EVF::Exit(){
	SetSVarInt("ADM:EVF:ACTIVE",EVF::GetActiveCount()-1);
	
	//Goodbye EVF
	new EVF::ver_name[16];
	format(EVF::ver_name,sizeof(EVF::ver_name),"%d.%d.%d",(EVF_Version / 10000),((EVF_Version % 10000) / 100),((EVF_Version % 10000) % 100));
	if(EVF::GetActiveCount() == 0){
		SetSVarInt("ADM:EVF:INIT",0);
		printf("[ADM] Info: Unload EVF v%s for SA:MP %s by Abyss Morgan",EVF::ver_name,EVF_SAMP_VERSION);
	}
	if(EVF::UpdateTimer != -1) KillTimer(EVF::UpdateTimer);
}

new bool:CRC_EVFInit = true,
	bool:CRC_EVFExit = true;
	
//Hook: OnFilterScriptInit
public OnFilterScriptInit(){
	if(CRC_EVFInit){
		CRC_EVFInit = false;
		EVF::Init();
	}
	#if defined EVF_OnFilterScriptInit
		EVF::OnFilterScriptInit();
	#endif
	return 1;
}

#if defined _ALS_OnFilterScriptInit
	#undef OnFilterScriptInit
#else
	#define _ALS_OnFilterScriptInit
#endif
#define OnFilterScriptInit EVF_OnFilterScriptInit
#if defined EVF_OnFilterScriptInit
	forward EVF_OnFilterScriptInit();
#endif

//Hook: OnGameModeInit
public OnGameModeInit(){
	if(CRC_EVFInit){
		CRC_EVFInit = false;
		EVF::Init();
	}
	#if defined EVF_OnGameModeInit
		EVF::OnGameModeInit();
	#endif
	return 1;
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit EVF_OnGameModeInit
#if defined EVF_OnGameModeInit
	forward EVF_OnGameModeInit();
#endif

//Hook: OnFilterScriptExit
public OnFilterScriptExit(){
	if(CRC_EVFExit){
		CRC_EVFExit = false;
		EVF::Exit();
	}
	#if defined EVF_OnFilterScriptExit
		EVF::OnFilterScriptExit();
	#endif
	return 1;
}

#if defined _ALS_OnFilterScriptExit
	#undef OnFilterScriptExit
#else
	#define _ALS_OnFilterScriptExit
#endif
#define OnFilterScriptExit EVF_OnFilterScriptExit
#if defined EVF_OnFilterScriptExit
	forward EVF_OnFilterScriptExit();
#endif

//Hook: OnGameModeExit
public OnGameModeExit(){
	if(CRC_EVFExit){
		CRC_EVFExit = false;
		EVF::Exit();
	}
	#if defined EVF_OnGameModeExit
		EVF::OnGameModeExit();
	#endif
	return 1;
}

#if defined _ALS_OnGameModeExit
	#undef OnGameModeExit
#else
	#define _ALS_OnGameModeExit
#endif
#define OnGameModeExit EVF_OnGameModeExit
#if defined EVF_OnGameModeExit
	forward EVF_OnGameModeExit();
#endif

#pragma unused EVF_VehicleName
#pragma unused EVF_TopSpeed
#pragma unused EVF_PlayerTempData
#pragma unused EVF_NeonOffsetData

#if !defined TRYG3D_SAMP_INCLUDE
	#pragma unused EVF_WeaponDamage
#endif

//EOF
