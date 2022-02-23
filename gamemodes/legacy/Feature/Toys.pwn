new Bone_Name[][] = {
	"None",
	"Spine",
	"Head",
	"Left upper arm",
	"Right upper arm",
	"Left hand",
	"Right hand",
	"Left thigh",
	"Right thigh",
	"Left foot",
	"Right foot",
	"Right calf",
	"Left calf",
	"Left forearm",
	"Right forearm",
	"Left clavicle",
	"Right clavicle",
	"Neck",
	"Jaw"
};

enum e_toy_data
{
	toy_model,
	toy_bone,
	Float:toy_x,
	Float:toy_y,
	Float:toy_z,
	Float:toy_rx,
	Float:toy_ry,
	Float:toy_rz,
	Float:toy_sx,
	Float:toy_sy,
	Float:toy_sz
}
new pToys[MAX_PLAYERS][6][e_toy_data];
new toySlot[MAX_PLAYERS][4];
new toyToggle[MAX_PLAYERS][4];
new toySelect[MAX_PLAYERS];

stock GetPlayerFreeToySlot(playerid)
{
	forex(i, 4)
	{
		if(pToys[playerid][i][toy_model] == 0)
		{
			return i;
		}
	}
	return -1;
}
FUNC::Load_LoadPlayerToys(playerid)
{
	new rows = cache_num_rows();
	if(rows)
	{
		cache_get_value_name_int(0, "Slot0_Model", pToys[playerid][0][toy_model]);
  		cache_get_value_name_int(0, "Slot0_Bone", pToys[playerid][0][toy_bone]);
  		cache_get_value_name_float(0, "Slot0_XPos", pToys[playerid][0][toy_x]);
  		cache_get_value_name_float(0, "Slot0_YPos", pToys[playerid][0][toy_y]);
  		cache_get_value_name_float(0, "Slot0_ZPos", pToys[playerid][0][toy_z]);
  		cache_get_value_name_float(0, "Slot0_XRot", pToys[playerid][0][toy_rx]);
  		cache_get_value_name_float(0, "Slot0_YRot", pToys[playerid][0][toy_ry]);
  		cache_get_value_name_float(0, "Slot0_ZRot", pToys[playerid][0][toy_rz]);
  		cache_get_value_name_float(0, "Slot0_XScale", pToys[playerid][0][toy_sx]);
  		cache_get_value_name_float(0, "Slot0_YScale", pToys[playerid][0][toy_sy]);
		cache_get_value_name_float(0, "Slot0_ZScale", pToys[playerid][0][toy_sz]);
		
		cache_get_value_name_int(0, "Slot1_Model", pToys[playerid][1][toy_model]);
  		cache_get_value_name_int(0, "Slot1_Bone", pToys[playerid][1][toy_bone]);
  		cache_get_value_name_float(0, "Slot1_XPos", pToys[playerid][1][toy_x]);
  		cache_get_value_name_float(0, "Slot1_YPos", pToys[playerid][1][toy_y]);
  		cache_get_value_name_float(0, "Slot1_ZPos", pToys[playerid][1][toy_z]);
  		cache_get_value_name_float(0, "Slot1_XRot", pToys[playerid][1][toy_rx]);
  		cache_get_value_name_float(0, "Slot1_YRot", pToys[playerid][1][toy_ry]);
  		cache_get_value_name_float(0, "Slot1_ZRot", pToys[playerid][1][toy_rz]);
  		cache_get_value_name_float(0, "Slot1_XScale", pToys[playerid][1][toy_sx]);
  		cache_get_value_name_float(0, "Slot1_YScale", pToys[playerid][1][toy_sy]);
		cache_get_value_name_float(0, "Slot1_ZScale", pToys[playerid][1][toy_sz]);
		
		cache_get_value_name_int(0, "Slot2_Model", pToys[playerid][2][toy_model]);
  		cache_get_value_name_int(0, "Slot2_Bone", pToys[playerid][2][toy_bone]);
  		cache_get_value_name_float(0, "Slot2_XPos", pToys[playerid][2][toy_x]);
  		cache_get_value_name_float(0, "Slot2_YPos", pToys[playerid][2][toy_y]);
  		cache_get_value_name_float(0, "Slot2_ZPos", pToys[playerid][2][toy_z]);
  		cache_get_value_name_float(0, "Slot2_XRot", pToys[playerid][2][toy_rx]);
  		cache_get_value_name_float(0, "Slot2_YRot", pToys[playerid][2][toy_ry]);
  		cache_get_value_name_float(0, "Slot2_ZRot", pToys[playerid][2][toy_rz]);
  		cache_get_value_name_float(0, "Slot2_XScale", pToys[playerid][2][toy_sx]);
  		cache_get_value_name_float(0, "Slot2_YScale", pToys[playerid][2][toy_sy]);
		cache_get_value_name_float(0, "Slot2_ZScale", pToys[playerid][2][toy_sz]);
		
		cache_get_value_name_int(0, "Slot3_Model", pToys[playerid][3][toy_model]);
  		cache_get_value_name_int(0, "Slot3_Bone", pToys[playerid][3][toy_bone]);
  		cache_get_value_name_float(0, "Slot3_XPos", pToys[playerid][3][toy_x]);
  		cache_get_value_name_float(0, "Slot3_YPos", pToys[playerid][3][toy_y]);
  		cache_get_value_name_float(0, "Slot3_ZPos", pToys[playerid][3][toy_z]);
  		cache_get_value_name_float(0, "Slot3_XRot", pToys[playerid][3][toy_rx]);
  		cache_get_value_name_float(0, "Slot3_YRot", pToys[playerid][3][toy_ry]);
  		cache_get_value_name_float(0, "Slot3_ZRot", pToys[playerid][3][toy_rz]);
  		cache_get_value_name_float(0, "Slot3_XScale", pToys[playerid][3][toy_sx]);
  		cache_get_value_name_float(0, "Slot3_YScale", pToys[playerid][3][toy_sy]);
		cache_get_value_name_float(0, "Slot3_ZScale", pToys[playerid][3][toy_sz]);
		
		//cache_get_value_name_int(0, "Slot0_Toggle", toyToggle[playerid][0]);
		//cache_get_value_name_int(0, "Slot1_Toggle", toyToggle[playerid][1]);
		//cache_get_value_name_int(0, "Slot2_Toggle", toyToggle[playerid][2]);
		//cache_get_value_name_int(0, "Slot3_Toggle", toyToggle[playerid][3]);
	}
	return 1;
}
stock LoadPlayerToys(playerid)
{
	new tstr[156];
	mysql_format(sqlcon, tstr, sizeof(tstr), "SELECT * FROM toys WHERE Owner='%s' LIMIT 1", PlayerData[playerid][pName]);
	mysql_tquery(sqlcon, tstr, "Load_LoadPlayerToys", "i", playerid);
}

stock CreatePlayerToy(playerid)
{
	new query[156];
	mysql_format(sqlcon, query, sizeof(query), "INSERT INTO `toys` (`Owner`) VALUES ('%s');", PlayerData[playerid][pName]);
	mysql_tquery(sqlcon, query);

	for(new i = 0; i < 4; i++)
	{
		pToys[playerid][i][toy_model] = 0;
		pToys[playerid][i][toy_bone] = 1;
		pToys[playerid][i][toy_x] = 0.0;
		pToys[playerid][i][toy_y] = 0.0;
		pToys[playerid][i][toy_z] = 0.0;
		pToys[playerid][i][toy_rx] = 0.0;
		pToys[playerid][i][toy_ry] = 0.0;
		pToys[playerid][i][toy_rz] = 0.0;
		pToys[playerid][i][toy_sx] = 1.0;
		pToys[playerid][i][toy_sy] = 1.0;
		pToys[playerid][i][toy_sz] = 1.0;
	}
}

stock GetFreeToySlot(playerid, slot)
{
	for(new i=MAX_PLAYER_ATTACHED_OBJECTS-1; i!=0; i--)
	{
		if(!IsPlayerAttachedObjectSlotUsed(playerid, i))
		{
			toySlot[playerid][slot] = i;
			return i;
		}
	}
	return -1;
}

stock SavePlayerToys(playerid)
{
	new line4[1700], lstr[1600];

	mysql_format(sqlcon, lstr, sizeof(lstr),
	"UPDATE `toys` SET \
	`Slot0_Model` = %i, `Slot0_Bone` = %i, `Slot0_XPos` = %.3f, `Slot0_YPos` = %.3f, `Slot0_ZPos` = %.3f, `Slot0_XRot` = %.3f, `Slot0_YRot` = %.3f, `Slot0_ZRot` = %.3f, `Slot0_XScale` = %.3f, `Slot0_YScale` = %.3f, `Slot0_ZScale` = %.3f,",
		pToys[playerid][0][toy_model],
        pToys[playerid][0][toy_bone],
        pToys[playerid][0][toy_x],
        pToys[playerid][0][toy_y],
        pToys[playerid][0][toy_z],
        pToys[playerid][0][toy_rx],
        pToys[playerid][0][toy_ry],
        pToys[playerid][0][toy_rz],
        pToys[playerid][0][toy_sx],
        pToys[playerid][0][toy_sy],
        pToys[playerid][0][toy_sz]);
	strcat(line4, lstr);

	mysql_format(sqlcon, lstr, sizeof(lstr),
	" `Slot1_Model` = %i, `Slot1_Bone` = %i, `Slot1_XPos` = %.3f, `Slot1_YPos` = %.3f, `Slot1_ZPos` = %.3f, `Slot1_XRot` = %.3f, `Slot1_YRot` = %.3f, `Slot1_ZRot` = %.3f, `Slot1_XScale` = %.3f, `Slot1_YScale` = %.3f, `Slot1_ZScale` = %.3f,",
		pToys[playerid][1][toy_model],
        pToys[playerid][1][toy_bone],
        pToys[playerid][1][toy_x],
        pToys[playerid][1][toy_y],
        pToys[playerid][1][toy_z],
        pToys[playerid][1][toy_rx],
        pToys[playerid][1][toy_ry],
        pToys[playerid][1][toy_rz],
        pToys[playerid][1][toy_sx],
        pToys[playerid][1][toy_sy],
        pToys[playerid][1][toy_sz]);
  	strcat(line4, lstr);

    mysql_format(sqlcon, lstr, sizeof(lstr),
	" `Slot2_Model` = %i, `Slot2_Bone` = %i, `Slot2_XPos` = %.3f, `Slot2_YPos` = %.3f, `Slot2_ZPos` = %.3f, `Slot2_XRot` = %.3f, `Slot2_YRot` = %.3f, `Slot2_ZRot` = %.3f, `Slot2_XScale` = %.3f, `Slot2_YScale` = %.3f, `Slot2_ZScale` = %.3f,",
		pToys[playerid][2][toy_model],
        pToys[playerid][2][toy_bone],
        pToys[playerid][2][toy_x],
        pToys[playerid][2][toy_y],
        pToys[playerid][2][toy_z],
        pToys[playerid][2][toy_rx],
        pToys[playerid][2][toy_ry],
        pToys[playerid][2][toy_rz],
        pToys[playerid][2][toy_sx],
        pToys[playerid][2][toy_sy],
        pToys[playerid][2][toy_sz]);
  	strcat(line4, lstr);

    mysql_format(sqlcon, lstr, sizeof(lstr),
	" `Slot3_Model` = %i, `Slot3_Bone` = %i, `Slot3_XPos` = %.3f, `Slot3_YPos` = %.3f, `Slot3_ZPos` = %.3f, `Slot3_XRot` = %.3f, `Slot3_YRot` = %.3f, `Slot3_ZRot` = %.3f, `Slot3_XScale` = %.3f, `Slot3_YScale` = %.3f, `Slot3_ZScale` = %.3f,",
		pToys[playerid][3][toy_model],
        pToys[playerid][3][toy_bone],
        pToys[playerid][3][toy_x],
        pToys[playerid][3][toy_y],
        pToys[playerid][3][toy_z],
        pToys[playerid][3][toy_rx],
        pToys[playerid][3][toy_ry],
        pToys[playerid][3][toy_rz],
        pToys[playerid][3][toy_sx],
        pToys[playerid][3][toy_sy],
        pToys[playerid][3][toy_sz]);
  	strcat(line4, lstr);

	mysql_format(sqlcon, lstr, sizeof(lstr),
	" `Slot4_Model` = %i, `Slot4_Bone` = %i, `Slot4_XPos` = %.3f, `Slot4_YPos` = %.3f, `Slot4_ZPos` = %.3f, `Slot4_XRot` = %.3f, `Slot4_YRot` = %.3f, `Slot4_ZRot` = %.3f, `Slot4_XScale` = %.3f, `Slot4_YScale` = %.3f, `Slot4_ZScale` = %.3f,",
		pToys[playerid][4][toy_model],
        pToys[playerid][4][toy_bone],
        pToys[playerid][4][toy_x],
        pToys[playerid][4][toy_y],
        pToys[playerid][4][toy_z],
        pToys[playerid][4][toy_rx],
        pToys[playerid][4][toy_ry],
        pToys[playerid][4][toy_rz],
        pToys[playerid][4][toy_sx],
        pToys[playerid][4][toy_sy],
        pToys[playerid][4][toy_sz]);
  	strcat(line4, lstr);

	mysql_format(sqlcon, lstr, sizeof(lstr),
	" `Slot5_Model` = %i, `Slot5_Bone` = %i, `Slot5_XPos` = %.3f, `Slot5_YPos` = %.3f, `Slot5_ZPos` = %.3f, `Slot5_XRot` = %.3f, `Slot5_YRot` = %.3f, `Slot5_ZRot` = %.3f, `Slot5_XScale` = %.3f, `Slot5_YScale` = %.3f, `Slot5_ZScale` = %.3f WHERE `Owner` = '%s'",
		pToys[playerid][5][toy_model],
        pToys[playerid][5][toy_bone],
        pToys[playerid][5][toy_x],
        pToys[playerid][5][toy_y],
        pToys[playerid][5][toy_z],
        pToys[playerid][5][toy_rx],
        pToys[playerid][5][toy_ry],
        pToys[playerid][5][toy_rz],
        pToys[playerid][5][toy_sx],
        pToys[playerid][5][toy_sy],
        pToys[playerid][5][toy_sz],
		PlayerData[playerid][pName]);
  	strcat(line4, lstr);

    mysql_tquery(sqlcon, line4);
    return 1;
}
stock AttachPlayerToys(playerid)
{

	if(pToys[playerid][0][toy_model] != 0)
	{
		SetPlayerAttachedObject(playerid,
		0,
		pToys[playerid][0][toy_model],
		pToys[playerid][0][toy_bone],
		pToys[playerid][0][toy_x],
		pToys[playerid][0][toy_y],
		pToys[playerid][0][toy_z],
		pToys[playerid][0][toy_rx],
		pToys[playerid][0][toy_ry],
		pToys[playerid][0][toy_rz],
		pToys[playerid][0][toy_sx],
		pToys[playerid][0][toy_sy],
		pToys[playerid][0][toy_sz]);
	}
	
	if(pToys[playerid][1][toy_model] != 0)
	{
		SetPlayerAttachedObject(playerid,
		1,
		pToys[playerid][1][toy_model],
		pToys[playerid][1][toy_bone],
		pToys[playerid][1][toy_x],
		pToys[playerid][1][toy_y],
		pToys[playerid][1][toy_z],
		pToys[playerid][1][toy_rx],
		pToys[playerid][1][toy_ry],
		pToys[playerid][1][toy_rz],
		pToys[playerid][1][toy_sx],
		pToys[playerid][1][toy_sy],
		pToys[playerid][1][toy_sz]);
	}
	
	if(pToys[playerid][2][toy_model] != 0)
	{
		SetPlayerAttachedObject(playerid,
		2,
		pToys[playerid][2][toy_model],
		pToys[playerid][2][toy_bone],
		pToys[playerid][2][toy_x],
		pToys[playerid][2][toy_y],
		pToys[playerid][2][toy_z],
		pToys[playerid][2][toy_rx],
		pToys[playerid][2][toy_ry],
		pToys[playerid][2][toy_rz],
		pToys[playerid][2][toy_sx],
		pToys[playerid][2][toy_sy],
		pToys[playerid][2][toy_sz]);
	}
	
	if(pToys[playerid][3][toy_model] != 0)
	{
		SetPlayerAttachedObject(playerid,
		3,
		pToys[playerid][3][toy_model],
		pToys[playerid][3][toy_bone],
		pToys[playerid][3][toy_x],
		pToys[playerid][3][toy_y],
		pToys[playerid][3][toy_z],
		pToys[playerid][3][toy_rx],
		pToys[playerid][3][toy_ry],
		pToys[playerid][3][toy_rz],
		pToys[playerid][3][toy_sx],
		pToys[playerid][3][toy_sy],
		pToys[playerid][3][toy_sz]);
	}
	
	return 1;
}

CMD:accessories(playerid, params[])
	return cmd_acc(playerid, "");

CMD:acc(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid)) 
		return SendErrorMessage(playerid, "This command can only be used on foot, exit your vehicle!");

	new string[350];
	format(string, sizeof(string), "Index\tAccessory Model\tBone\n");
	forex(i, 4)
	{
		if(pToys[playerid][i][toy_model] != 0)
		{
			format(string, sizeof(string), "%s{FFFFFF}#%d\t%d\t%s\n", string, i, pToys[playerid][i][toy_model], Bone_Name[pToys[playerid][i][toy_bone]]);
		}
		else
		{
			format(string, sizeof(string), "%s{AFAFAF}Empty Slot\n", string);
		}
	}
	ShowPlayerDialog(playerid, DIALOG_TOY, DIALOG_STYLE_TABLIST_HEADERS, "Accessory Menu", string, "Select", "Close");
	SavePlayerToys(playerid);
	return 1;
}
