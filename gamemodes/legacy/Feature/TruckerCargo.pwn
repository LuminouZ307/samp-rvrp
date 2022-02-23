new const Crate_Name[5][20] = {
	"None",
	"Fast Food",
	"24/7",
	"Clothes",
	"Electronic"
};

enum e_crate
{
	crateID,
	bool:crateExists,
	crateType,
	crateVehicle
};
new CrateData[MAX_CRATES][e_crate];

stock Crate_Delete(id)
{

	new str[156];
	mysql_format(sqlcon, str, sizeof(str), "DELETE FROM `crates` WHERE `ID` = '%d'", CrateData[id][crateID]);

	CrateData[id][crateExists] = false;
	CrateData[id][crateVehicle] = -1;

	return mysql_tquery(sqlcon, str);
}

stock Crate_Create(playerid, type)
{
	forex(i, MAX_CRATES)
	{
		if(!CrateData[i][crateExists])
		{
			CrateData[i][crateExists] = true;
			CrateData[i][crateType] = type;
			CrateData[i][crateVehicle] = -1;

			PlayerData[playerid][pCrate] = i;
		    ApplyAnimation(playerid, "CARRY", "liftup", 4.1, 0, 0, 0, 0, 0, 1);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
		    SetPlayerAttachedObject(playerid,  9, 1271, 5, 0.044377, 0.029049, 0.161334, 265.922912, 9.904896, 21.765972, 0.500000, 0.500000, 0.500000);			
			mysql_tquery(sqlcon, "INSERT INTO `crates` (`Type`) VALUES(0)", "OnCrateCreated", "d", i);
			return i;
		}
	}
	return -1;
}

FUNC::OnCrateCreated(cid)
{
	CrateData[cid][crateID] = cache_insert_id();
	Crate_Save(cid);
}

stock Crate_Save(cid)
{
	new query[352];
	mysql_format(sqlcon, query, sizeof(query), "UPDATE `crates` SET ");
	mysql_format(sqlcon, query, sizeof(query), "%s`Type`='%d', ", query, CrateData[cid][crateType]);
	mysql_format(sqlcon, query, sizeof(query), "%s`Vehicle`='%d' ", query, CrateData[cid][crateVehicle]);
	mysql_format(sqlcon, query, sizeof(query), "%sWHERE `ID` = '%d'", query, CrateData[cid][crateID]);
	mysql_query(sqlcon, query, true);
	return 1;
}