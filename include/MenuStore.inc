/*
	MenuStore - Version 4.2
	Created by CaioTJF
*/


/*	
	You can NOT change 
*/

#define MS_MAX_ITEMS_PER_PAGE 6
#define MS_MAX_ITEMS_CART 4
#define MSTORE_INVALID_ITEM_ID -1
#define MS_MAX_SIZE_DESCRIPTION	7.5

/*
	You can change
*/

#define MS_MAX_ITEMS (MS_MAX_ITEMS_PER_PAGE*5) // --> Limit of 5 Pages
#define MS_DEFAULT_MONEY_SIGN "$"
#define MS_DEFAULT_CONFIRM "Buy"

#define MS_COLOR_SELECT_TD 0xffffffFF
#define MS_COLOR_TEXT_MAIN 0xffffffFF

#define MS_COLOR_BACKGROUND_1 0x00000080
#define MS_COLOR_BACKGROUND_2 0x2c2c2cAA
#define	MS_COLOR_BACKGROUND_ITEM 0x3e3e3eFF
#define MS_COLOR_BACKGROUND_ITEMSELECTED 0xffffff50
#define MS_COLOR_BACKGROUND_CONFIRM 0x5eaf3aFF
#define MS_COLOR_BACKGROUND_MODEL 0xffffff50

#define MS_COLOR_CART_REMOVEITEM 0xcc30a0aFF
#define MS_COLOR_CART_BACKGROUND_ITEM MS_COLOR_BACKGROUND_ITEM

#define MS_COLOR_DESCRIPTION_NAMEITEM MS_COLOR_TEXT_MAIN
#define MS_COLOR_DESCRIPTION_TEXT 0xffffffAA
#define MS_COLOR_DESCRIPTION_BACKGROUND_1 MS_COLOR_BACKGROUND_1
#define MS_COLOR_DESCRIPTION_BACKGROUND_2 MS_COLOR_BACKGROUND_2
#define MS_COLOR_DESCRIPTION_BACKGROUND_MODEL 0xffffff50

#define MS_COLOR_TITLE_DIALOG "{ffffff}"
#define MS_COLOR_TEXT_DIALOG "{ffffff}"

#define MS_MSG_TITLE_DIALOG "Choose quantity"
#define MS_MSG_DIALOG "Enter the quantity you want to buy"

#define MS_WORD_LIMIT "Limit"
#define MS_WORD_CLOSE "Close"
#define MS_WORD_TOTAL "Total"
#define MS_WORD_GO "Go"
#define MS_WORD_CANCEL "Cancel"
#define MS_WORD_CART "Cart"

#define MS_INTERVAL_DOUBLECLICK 300
#define DIALOG_MSTORE 23132

//-------------------------------------------

static Num_Format(Float:amount, delimiter[2]=".", comma[2]=",")
{
	#define MAX_MONEY_String 16
	new txt[MAX_MONEY_String];
	format(txt, MAX_MONEY_String, "%d", floatround(amount));
	new l = strlen(txt);
	if (amount < 0) // -
	{
		if (l > 2) strins(txt,delimiter,l-2);
		if (l > 5) strins(txt,comma,l-5);
		if (l > 8) strins(txt,comma,l-8);
	}
	else
	{//1000000
		if (l > 2) strins(txt,delimiter,l-2);
		if (l > 5) strins(txt,comma,l-5);
		if (l > 9) strins(txt,comma,l-8);
	}
//	if (l <= 2) format(txt,sizeof( szStr ),"00,%s",txt);
	return txt;
}

#if !defined isnull
	#define isnull(%1) \
		((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#endif

#define STORE:%0(%1) \
	forward store_%0(%1); public store_%0(%1)

#define Store:%0(%1) \
	STORE:%0(%1)

#define MenuStore_Show(%0,%1, \
	MenuStore_Open(%0, #%1,

enum enum_ms_Items
{
	ms_ItemID,
	ms_ItemModel,
	ms_ItemPrice,
	ms_ItemStack,
	ms_ItemName[32 char],
	ms_ItemDescription[256 char],
	Float:ms_ItemDescriptionBonus,
	bool:ms_ItemLineJump,
	Float:ms_ItemPreviewRot[4]
}		

static ms_Items[MAX_PLAYERS][MS_MAX_ITEMS][enum_ms_Items];

enum enum_ms_Info
{
	ms_TotalItems,
	ms_CurrentPage,
	bool:ms_IsOpen,
	ms_StoreID[32],
	ms_MoneySign[32],
	ms_DoubleClick,
	ms_DoubleClickRow,
	ms_Selected,
	bool:ms_ToggleControll
}

static ms_Info[MAX_PLAYERS][enum_ms_Info];

enum enum_ms_Cart
{
	ms_Cart_ItemID[MS_MAX_ITEMS_CART],
	ms_Cart_ItemPrice[MS_MAX_ITEMS_CART],
	ms_Cart_ItemAmount[MS_MAX_ITEMS_CART]

}

static ms_Cart[MAX_PLAYERS][enum_ms_Cart];

static ms_String[256];

// -- Global Textdraws

static Text:ms_TD_Backgrounds[2] = {Text:INVALID_TEXT_DRAW, ...};
static Text:ms_TD_Next = Text:INVALID_TEXT_DRAW;
static Text:ms_TD_Previous = Text:INVALID_TEXT_DRAW;

static Text:ms_TD_Cart_Backgrounds[2] = {Text:INVALID_TEXT_DRAW, ...};
static Text:ms_TD_Cart_BackgroundConfirm = Text:INVALID_TEXT_DRAW;
static Text:ms_TD_Cart_CartName = Text:INVALID_TEXT_DRAW;

// -- Player Textdraws

static PlayerText:ms_TD_ItemName[MAX_PLAYERS][MS_MAX_ITEMS_PER_PAGE];
static PlayerText:ms_TD_ItemPrice[MAX_PLAYERS][MS_MAX_ITEMS_PER_PAGE];
static PlayerText:ms_TD_ItemModel[MAX_PLAYERS][MS_MAX_ITEMS_PER_PAGE];
static PlayerText:ms_TD_ItemBackground[MAX_PLAYERS][MS_MAX_ITEMS_PER_PAGE];
static PlayerText:ms_TD_StoreName[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};
static PlayerText:ms_TD_Pagination[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};
static PlayerText:ms_TD_DescriptionItemName[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};
static PlayerText:ms_TD_DescriptionItemText[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};
static PlayerText:ms_TD_DescriptionItemModel[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};
static PlayerText:ms_TD_DescriptionBackground[MAX_PLAYERS][2];

static PlayerText:ms_TD_Cart_ItemBackground[MAX_PLAYERS][MS_MAX_ITEMS_CART];
static PlayerText:ms_TD_Cart_ItemName[MAX_PLAYERS][MS_MAX_ITEMS_CART];
static PlayerText:ms_TD_Cart_ItemClose[MAX_PLAYERS][MS_MAX_ITEMS_CART];
static PlayerText:ms_TD_Cart_BuyName[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};
static PlayerText:ms_TD_Cart_Total[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};

forward PlayerText:CreatePlayerTextDrawEx(playerid, Float:x, Float:y, text[], Float:size_x, Float:size_y, Float:textsize_x, Float:textsize_y, align, color, usebox,	boxcolor, shadow, outline, bg_color, font, proportional, model = 0,	Float:preview_x= 0.0, Float:preview_y = 0.0, Float:preview_z = 0.0, Float:preview_zoom = 1.0, selectable = 0);
forward Text:CreateTextDrawEx(Float:x, Float:y, text[], Float:size_x, Float:size_y, Float:textsize_x, Float:textsize_y,	align, color, usebox, boxcolor,	shadow,	outline, bg_color, font, proportional, model = 0, Float:preview_x = 0.0, Float:preview_y = 0.0, Float:preview_z = 0.0, Float:preview_zoom = 0.0, selectable = 0);

//-------------------------------------------

public OnGameModeInit()
{
	ms_TD_Backgrounds[0]  = CreateTextDrawEx(145.500000, 130.499969, "box",
										0.000000, 30.198539,
										322.000000, 0.000000,
										1,
										-1,
										1,
										MS_COLOR_BACKGROUND_1,
										0,
										0,
										255,
										1,
										1);

	ms_TD_Backgrounds[1] = CreateTextDrawEx(153.000000, 149.383575, "box",
										0.000000, 26.226503,
										315.000000, 0.000000,
										1,
										-1,
										1,
										MS_COLOR_BACKGROUND_2,
										0,
										0,
										255,
										1,
										1);

	ms_TD_Next = CreateTextDrawEx(251.485229, 390.033355, "ld_beat:right",
							0.000000, 0.000000,
							11.000000, 13.000000,
							1,
							MS_COLOR_TEXT_MAIN,
							0,
							0,
							0,
							0,
							255,
							4,
							1,
							0,
							0.0, 0.0, 0.0, 0.0,
							1);

	ms_TD_Previous = CreateTextDrawEx(201.945220, 390.033355, "ld_beat:left",
								0.000000, 0.000000,
								11.000000, 13.000000,
								1,
								MS_COLOR_TEXT_MAIN,
								0,
								0,
								0,
								0,
								255,
								4,
								1,
								0,
								0.0, 0.0, 0.0, 0.0,
								1);	

	ms_TD_Cart_Backgrounds[0] = CreateTextDrawEx(333.201141, 271.666656, "box",
											0.000000, 14.450012,
											516.000000, 0.000000,
											1,
											-1,
											1,
											MS_COLOR_BACKGROUND_1,
											0,
											0,
											255,
											1,
											1);

	ms_TD_Cart_Backgrounds[1] = CreateTextDrawEx(341.000000, 290.133575, "box",
											0.000000, 10.134258,
											508.000000, 0.000000,
											1,
											-1,
											1,
											MS_COLOR_BACKGROUND_2,
											0,
											0,
											255,
											1,
											1);

	ms_TD_Cart_BackgroundConfirm = CreateTextDrawEx(444.899230, 390.233489, "box",
									0.000000, 0.850001,
									507.701690, 15.000000,
									1,
									-1,
									1,
									MS_COLOR_BACKGROUND_CONFIRM,
									0,
									0,
									255,
									1,
									1,
									0,
									0.0, 0.0, 0.0, 0.0,
									1);

	ms_TD_Cart_CartName = CreateTextDrawEx(339.143798, 270.733520, MS_WORD_CART,
									0.310357, 1.434998,
									508.000000, 0.0,
									1,
									MS_COLOR_TEXT_MAIN,
									1,
									0xffffff00,
									0,
									0,
									255,
									2,
									1);

	#if defined MS_OnGameModeInit
		return MS_OnGameModeInit();
	#else
		return 1;
	#endif
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit MS_OnGameModeInit

#if defined MS_OnGameModeInit
	forward MS_OnGameModeInit();
#endif

//-------------------------------------------

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	if(ms_Info[playerid][ms_ToggleControll])
	{
		for(new i = 0; i < MS_MAX_ITEMS_PER_PAGE; i++)
		{
			if(playertextid == ms_TD_ItemBackground[playerid][i])
			{
				new index = i+(MS_MAX_ITEMS_PER_PAGE * (ms_Info[playerid][ms_CurrentPage] - 1));	

				// --> Doubleclick
		        if((GetTickCount() - ms_Info[playerid][ms_DoubleClick]) < MS_INTERVAL_DOUBLECLICK && ms_Info[playerid][ms_DoubleClickRow] == i)
				{

					if(ms_Items[playerid][index][ms_ItemStack] > 1)
					{
						MenuStore_ToggleControll(playerid, false);
						MenuStore_SelectRow(playerid, i);
						format(ms_String, sizeof(ms_String), ""#MS_COLOR_TEXT_DIALOG""#MS_MSG_DIALOG" ("#MS_WORD_LIMIT": %d)", ms_Items[playerid][index][ms_ItemStack]);
						ShowPlayerDialog(playerid, DIALOG_MSTORE, DIALOG_STYLE_INPUT, ""#MS_COLOR_TITLE_DIALOG""#MS_MSG_TITLE_DIALOG":", ms_String, MS_WORD_GO, MS_WORD_CANCEL);
					}
					else
					{
						MenuStore_AddToCart(playerid, ms_Items[playerid][index][ms_ItemID], ms_Items[playerid][index][ms_ItemPrice], ms_Items[playerid][index][ms_ItemStack]);
						MenuStore_UnselectRow(playerid);
						MenuStore_CloseDescription(playerid);
					}

					ms_Info[playerid][ms_DoubleClickRow] = -1;
					ms_Info[playerid][ms_DoubleClick] = 0;
					return true;
			    }
				else
				{
					ms_Info[playerid][ms_DoubleClickRow] = i;
					ms_Info[playerid][ms_DoubleClick] = GetTickCount();
				}

				if(ms_Info[playerid][ms_Selected] == i)
				{
					MenuStore_UnselectRow(playerid);
					MenuStore_CloseDescription(playerid);
					return true;
				}
				else if(ms_Info[playerid][ms_Selected] != -1)
					MenuStore_UnselectRow(playerid);

				MenuStore_SelectRow(playerid, i);
		      	MenuStore_OpenDescription(playerid, index);
				return true;
			}
		}

		for(new row = 0; row < MS_MAX_ITEMS_CART; row++)
		{
			if(playertextid == ms_TD_Cart_ItemBackground[playerid][row])
			{
				MenuStore_RemoveFromCart(playerid, row);
				return true;
			}
		}
	}

	#if defined MS_OnPlayerClickPlayerTD
		return MS_OnPlayerClickPlayerTD(playerid, playertextid);
	#else
		return 1;
	#endif
}


#if defined _ALS_OnPlayerClickPlayerTD
	#undef OnPlayerClickPlayerTextDraw
#else
	#define _ALS_OnPlayerClickPlayerTD
#endif
#define OnPlayerClickPlayerTextDraw MS_OnPlayerClickPlayerTD

#if defined MS_OnPlayerClickPlayerTD
	forward MS_OnPlayerClickPlayerTD(playerid, PlayerText:playertextid);
#endif

//-------------------------------------------

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(clickedid == Text:INVALID_TEXT_DRAW && MenuStore_IsOpen(playerid) && ms_Info[playerid][ms_ToggleControll])
	{
		new storeid[32] = "store_";
		strcat(storeid, ms_Info[playerid][ms_StoreID]);
		CallLocalFunction(storeid, "iiiiiis", playerid, false, MSTORE_INVALID_ITEM_ID, 0, 0, 0, "N/A");
		MenuStore_Close(playerid);
		return true;
	}
	else if(clickedid == Text:INVALID_TEXT_DRAW && !ms_Info[playerid][ms_ToggleControll])
	{
		SelectTextDraw(playerid, MS_COLOR_SELECT_TD);
		return true;
	}

	if(ms_Info[playerid][ms_ToggleControll])
	{
		if(clickedid == ms_TD_Next)
		{
			if(ms_Info[playerid][ms_CurrentPage] < MenuStore_GetNumbersOfPage(playerid))
			{
				ms_Info[playerid][ms_CurrentPage]++;
				MenuStore_SetPage(playerid, ms_Info[playerid][ms_CurrentPage]);
				MenuStore_UnselectRow(playerid);
				return true;
			}
		}

		if(clickedid == ms_TD_Previous)
		{
			if(ms_Info[playerid][ms_CurrentPage] > 1)
			{
				ms_Info[playerid][ms_CurrentPage]--;
				MenuStore_SetPage(playerid, ms_Info[playerid][ms_CurrentPage]);
				MenuStore_UnselectRow(playerid);
				return true;
			}
		}

		if(clickedid == ms_TD_Cart_BackgroundConfirm)
		{
			if(MenuStore_GetTotalItemsInCart(playerid) != 0)
			{
				new storeid[32] = "store_", itemid;
				strcat(storeid, ms_Info[playerid][ms_StoreID]);

				for(new i = 0; i < MS_MAX_ITEMS_CART; i++)
				{
					itemid = ms_Cart[playerid][ms_Cart_ItemID][i];
					if(itemid != MSTORE_INVALID_ITEM_ID)
					{
						CallLocalFunction(storeid, "iiiiiis", playerid, true, itemid, MenuStore_GetItemModelByID(playerid, itemid), (ms_Cart[playerid][ms_Cart_ItemPrice][i] * ms_Cart[playerid][ms_Cart_ItemAmount][i]), ms_Cart[playerid][ms_Cart_ItemAmount][i], MenuStore_GetItemNameByID(playerid, itemid));
					}
				}

				MenuStore_Close(playerid);
			}
			return true;
		}
	}

	#if defined MS_OnPlayerClickTextDraw
		return MS_OnPlayerClickTextDraw(playerid, clickedid);
	#else
		return 1;
	#endif
}


#if defined _ALS_OnPlayerClickTextDraw
	#undef OnPlayerClickTextDraw
#else
	#define _ALS_OnPlayerClickTextDraw
#endif
#define OnPlayerClickTextDraw MS_OnPlayerClickTextDraw

#if defined MS_OnPlayerClickTextDraw
	forward MS_OnPlayerClickTextDraw(playerid, Text:clickedid);
#endif

//-------------------------------------------

public OnPlayerConnect(playerid)
{
	for(new i = 0; i < MS_MAX_ITEMS_PER_PAGE; i++) 
	{
		ms_TD_ItemName[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
		ms_TD_ItemPrice[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
		ms_TD_ItemModel[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
		ms_TD_ItemBackground[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
	}

	ms_TD_StoreName[playerid] = PlayerText:INVALID_TEXT_DRAW;

	ms_TD_DescriptionItemName[playerid] = PlayerText:INVALID_TEXT_DRAW;
	ms_TD_DescriptionItemText[playerid] = PlayerText:INVALID_TEXT_DRAW;
	ms_TD_DescriptionItemModel[playerid] = PlayerText:INVALID_TEXT_DRAW;
	ms_TD_DescriptionBackground[playerid][0] = PlayerText:INVALID_TEXT_DRAW;
	ms_TD_DescriptionBackground[playerid][1] = PlayerText:INVALID_TEXT_DRAW;
	
	for(new i = 0; i < MS_MAX_ITEMS_CART; i++) 
	{
		ms_TD_Cart_ItemBackground[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
		ms_TD_Cart_ItemName[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
		ms_TD_Cart_ItemClose[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
	}

	ms_TD_Cart_BuyName[playerid] = PlayerText:INVALID_TEXT_DRAW;
	ms_TD_Cart_Total[playerid] = PlayerText:INVALID_TEXT_DRAW;

	MenuStore_ResetVariables(playerid);

	#if defined MS_OnPlayerConnect
		return MS_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect MS_OnPlayerConnect

#if defined MS_OnPlayerConnect
	forward MS_OnPlayerConnect(playerid);
#endif

//-------------------------------------------

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_MSTORE)
	{
		MenuStore_ToggleControll(playerid, true);
		MenuStore_CloseDescription(playerid);

		if(!response || ms_Info[playerid][ms_Selected] == -1 || isnull(inputtext))
		{
			MenuStore_UnselectRow(playerid);
			return true;
		}	

		new index = ms_Info[playerid][ms_Selected]+(MS_MAX_ITEMS_PER_PAGE * (ms_Info[playerid][ms_CurrentPage] - 1));
		MenuStore_UnselectRow(playerid);

		if(strval(inputtext) < 1 || strval(inputtext) > ms_Items[playerid][index][ms_ItemStack])
			return true;

		MenuStore_AddToCart(playerid, ms_Items[playerid][index][ms_ItemID], ms_Items[playerid][index][ms_ItemPrice], strval(inputtext));
		return true;
	}

	#if defined MS_OnDialogResponse
		return MS_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	#else
		return 1;
	#endif
}

#if defined _ALS_OnDialogResponse
    #undef OnDialogResponse
#else
    #define _ALS_OnDialogResponse
#endif
#define OnDialogResponse MS_OnDialogResponse

#if defined MS_OnDialogResponse
    forward MS_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif

//-------------------------------------------

stock MenuStore_SetPage(playerid, pageid)
{
	new Float:ms_Item_Name_Base_X = 190.000000,
		Float:ms_Item_Name_Base_Y = 153.933349,
		Float:ms_Item_Price_Base_X = 311.100158,
		Float:ms_Item_Price_Base_Y = 173.217605,
		Float:ms_Item_Model_Base_X = 158.699859,
		Float:ms_Item_Model_Base_Y = 156.116775,
		Float:ms_Item_Background_Base_X = 158.000000,
		Float:ms_Item_Background_Base_Y = 155.200027,
		lane_break = 0,
		Float:padding = 39.0,
		start_index, end_index,
		current_row = -1;

	start_index = MS_MAX_ITEMS_PER_PAGE * (pageid - 1);
	end_index = start_index + MS_MAX_ITEMS_PER_PAGE;

	if (ms_Info[playerid][ms_TotalItems] % end_index == ms_Info[playerid][ms_TotalItems]) {
		end_index = start_index + ms_Info[playerid][ms_TotalItems] % MS_MAX_ITEMS_PER_PAGE;
	}

	// Remove any previous
	for(new i = 0; i < MS_MAX_ITEMS_PER_PAGE; i++)
	{
		RemovePlayerTD(playerid, ms_TD_ItemBackground[playerid][i]);
		RemovePlayerTD(playerid, ms_TD_ItemName[playerid][i]);
		RemovePlayerTD(playerid, ms_TD_ItemPrice[playerid][i]);
		RemovePlayerTD(playerid, ms_TD_ItemModel[playerid][i]);
	}

	RemovePlayerTD(playerid, ms_TD_Pagination[playerid]);

	// Write
	for(new i = start_index; i < end_index; i++)
	{
		current_row++;

		if(lane_break != 0)
		{
			ms_Item_Name_Base_Y += padding;
			ms_Item_Price_Base_Y += padding;
			ms_Item_Model_Base_Y += padding;
			ms_Item_Background_Base_Y += padding;
		}

		ms_TD_ItemBackground[playerid][current_row] = CreatePlayerTextDrawEx(playerid, ms_Item_Background_Base_X, ms_Item_Background_Base_Y, "box",
											0.000000, 3.299997,
											311.000000, 22.000000,
											1,
											-1,
											1,
											MS_COLOR_BACKGROUND_ITEM,
											0,
											0,
											255,
											1,
											1,
											0,
											0.0, 0.0, 0.0, 1.0,
											1);

		ms_TD_ItemName[playerid][current_row] = CreatePlayerTextDrawEx(playerid, ms_Item_Name_Base_X, ms_Item_Name_Base_Y, ms_Items[playerid][i][ms_ItemName][0],
										0.231024, 1.198331,
										310.000000, 0.0,
										1,
										MS_COLOR_TEXT_MAIN,
										1,
										0xffffff00,
										0,
										0,
										255,
										2,
										1);

		format(ms_String, sizeof(ms_String), "%s%s", ms_Info[playerid][ms_MoneySign], Num_Format(ms_Items[playerid][i][ms_ItemPrice]));
		ms_TD_ItemPrice[playerid][current_row] = CreatePlayerTextDrawEx(playerid, ms_Item_Price_Base_X, ms_Item_Price_Base_Y, ms_String,
										0.283500, 1.227498,
										0.0, 0.0,
										3,
										MS_COLOR_TEXT_MAIN,
										0,
										0,
										0,
										0,
										255,
										2,
										1);

		ms_TD_ItemModel[playerid][current_row] = CreatePlayerTextDrawEx(playerid, ms_Item_Model_Base_X, ms_Item_Model_Base_Y, "",
										0.000000, 0.000000,
										29.000000, 28.000000,
										1,
										-1,
										0,
										0,
										0,
										0,
										MS_COLOR_BACKGROUND_MODEL,
										5,
										0,
										ms_Items[playerid][i][ms_ItemModel],
										ms_Items[playerid][i][ms_ItemPreviewRot][0], ms_Items[playerid][i][ms_ItemPreviewRot][1], ms_Items[playerid][i][ms_ItemPreviewRot][2], ms_Items[playerid][i][ms_ItemPreviewRot][3]);

		lane_break++;

		PlayerTextDrawShow(playerid, ms_TD_ItemBackground[playerid][current_row]);
		PlayerTextDrawShow(playerid, ms_TD_ItemName[playerid][current_row]);
		PlayerTextDrawShow(playerid, ms_TD_ItemPrice[playerid][current_row]);
		PlayerTextDrawShow(playerid, ms_TD_ItemModel[playerid][current_row]);
	}

	if(ms_Info[playerid][ms_TotalItems] > MS_MAX_ITEMS_PER_PAGE)
	{
		format(ms_String, sizeof(ms_String), "%d/%d", pageid, MenuStore_GetNumbersOfPage(playerid));
		ms_TD_Pagination[playerid] = CreatePlayerTextDrawEx(playerid, 232.255233, 388.983795, ms_String,
								0.318008, 1.454166,
								0.0, 0.0,
								2,
								MS_COLOR_TEXT_MAIN,
								0,
								0,
								0,
								0,
								255,
								2,
								1);

		PlayerTextDrawShow(playerid, ms_TD_Pagination[playerid]);
	}
}


 stock MenuStore_GetNumbersOfPage(playerid)
 {
 	if((ms_Info[playerid][ms_TotalItems] >= MS_MAX_ITEMS_PER_PAGE) && (ms_Info[playerid][ms_TotalItems] % MS_MAX_ITEMS_PER_PAGE) == 0)
 	{
 		return (ms_Info[playerid][ms_TotalItems] / MS_MAX_ITEMS_PER_PAGE);
 	}
 	else return (ms_Info[playerid][ms_TotalItems] / MS_MAX_ITEMS_PER_PAGE) + 1;
 }

stock MenuStore_GetTotalItemsInCart(playerid)
{
	static count;
	count = 0;

	for(new i = 0; i < MS_MAX_ITEMS_CART; i++)
		if(ms_Cart[playerid][ms_Cart_ItemID][i] != MSTORE_INVALID_ITEM_ID)
			count++;

	return count;
}

stock MenuStore_GetCartTotalValue(playerid)
{
	static count;
	count = 0;

	for(new i = 0; i < MS_MAX_ITEMS_CART; i++)
		if(ms_Cart[playerid][ms_Cart_ItemID][i] != MSTORE_INVALID_ITEM_ID)
			count += (ms_Cart[playerid][ms_Cart_ItemPrice][i]*ms_Cart[playerid][ms_Cart_ItemAmount][i]);

	return count;
}

stock MenuStore_AddToCart(playerid, itemid, price, amount)
{
	for(new i = 0; i < MS_MAX_ITEMS_CART; i++)
	{
		if(ms_Cart[playerid][ms_Cart_ItemID][i] == MSTORE_INVALID_ITEM_ID)
		{
			ms_Cart[playerid][ms_Cart_ItemID][i] = itemid;
			ms_Cart[playerid][ms_Cart_ItemPrice][i] = price;
			ms_Cart[playerid][ms_Cart_ItemAmount][i] = amount;
			
			MenuStore_CreateCartRow(playerid, i);
			MenuStore_UpdateCartTotalValue(playerid);
			break;
		}
	}
}

stock MenuStore_RemoveFromCart(playerid, row)
{
	ms_Cart[playerid][ms_Cart_ItemID][row] = MSTORE_INVALID_ITEM_ID;
	ms_Cart[playerid][ms_Cart_ItemPrice][row] = 0;
	ms_Cart[playerid][ms_Cart_ItemAmount][row] = 0;

	MenuStore_UpdateCartTotalValue(playerid);
	MenuStore_SortCart(playerid);
}


stock MenuStore_SortCart(playerid)
{
	for(new i = 0; i < MS_MAX_ITEMS_CART; i++)
	{
		if(ms_Cart[playerid][ms_Cart_ItemID][i] == MSTORE_INVALID_ITEM_ID)
		{
			for(new x = i; x < MS_MAX_ITEMS_CART; x++)
			{
				if(ms_Cart[playerid][ms_Cart_ItemID][x] != MSTORE_INVALID_ITEM_ID)
				{
					ms_Cart[playerid][ms_Cart_ItemID][i] = ms_Cart[playerid][ms_Cart_ItemID][x];
					ms_Cart[playerid][ms_Cart_ItemPrice][i] = ms_Cart[playerid][ms_Cart_ItemPrice][x];
					ms_Cart[playerid][ms_Cart_ItemAmount][i] = ms_Cart[playerid][ms_Cart_ItemAmount][x];

					ms_Cart[playerid][ms_Cart_ItemID][x] = MSTORE_INVALID_ITEM_ID;
					ms_Cart[playerid][ms_Cart_ItemPrice][x] = 0;
					ms_Cart[playerid][ms_Cart_ItemAmount][x] = 0;
					break;
				}
			}
		}
	}

	MenuStore_UpdateCart(playerid);
}

stock MenuStore_GetItemNameByID(playerid, id)
{
	format(ms_String, sizeof(ms_String), "N/A");

	for(new i = 0; i < MS_MAX_ITEMS; i++)
	{
		if(ms_Items[playerid][i][ms_ItemID] == id)
		{
			strunpack(ms_String, ms_Items[playerid][i][ms_ItemName]);
			return ms_String;
		}
	}

	return ms_String;
}

stock MenuStore_GetItemModelByID(playerid, id)
{
	for(new i = 0; i < MS_MAX_ITEMS; i++)
	{
		if(ms_Items[playerid][i][ms_ItemID] == id)
		{
			return ms_Items[playerid][i][ms_ItemModel];
		}
	}

	return 0;
}

stock MenuStore_CreateCartRow(playerid, row)
{
	new Float:ms_Cart_Item_Background_Base_Y = 293.883270,
		Float:ms_Cart_Item_ItemName_Base_Y = 294.566619,
		Float:ms_Cart_Item_ItemClose_Base_Y = 293.683410,
		Float:padding = 23.0;

	if(row > 0)
	{
		ms_Cart_Item_Background_Base_Y += (padding*row);
		ms_Cart_Item_ItemName_Base_Y += (padding*row);
		ms_Cart_Item_ItemClose_Base_Y += (padding*row);
	}

	ms_TD_Cart_ItemBackground[playerid][row] = CreatePlayerTextDrawEx(playerid, 344.000000, ms_Cart_Item_Background_Base_Y, "box",
												0.000000, 1.550000,
												505.000000, 15.000000,
												1,
												-1,
												1,
												MS_COLOR_CART_BACKGROUND_ITEM,
												0,
												0,
												255,
												1,
												1,
												0,
												0.0, 0.0, 0.0, 1.0,
												1);

	format(ms_String, sizeof(ms_String), "%dx_%s", ms_Cart[playerid][ms_Cart_ItemAmount][row], MenuStore_GetItemNameByID(playerid, ms_Cart[playerid][ms_Cart_ItemID][row]));
	ms_TD_Cart_ItemName[playerid][row] = CreatePlayerTextDrawEx(playerid, 345.200073, ms_Cart_Item_ItemName_Base_Y, ms_String,
										0.210997, 1.169996,
										506.000000, 0.0,
										1,
										MS_COLOR_TEXT_MAIN,
										1,
										0xffffff00,
										0,
										0,
										255,
										2,
										1);

	ms_TD_Cart_ItemClose[playerid][row] = CreatePlayerTextDrawEx(playerid, 501.965087, ms_Cart_Item_ItemClose_Base_Y, "X",
										0.387349, 1.546665,
										0.0, 0.0,
										3,
										MS_COLOR_CART_REMOVEITEM,
										0,
										0,
										0,
										0,
										255,
										1,
										1);

	PlayerTextDrawShow(playerid, ms_TD_Cart_ItemBackground[playerid][row]);
	PlayerTextDrawShow(playerid, ms_TD_Cart_ItemName[playerid][row]);
	PlayerTextDrawShow(playerid, ms_TD_Cart_ItemClose[playerid][row]);
}

stock MenuStore_RemoveCartRows(playerid)
{
	for(new i = 0; i < MS_MAX_ITEMS_CART; i++)
	{
		RemovePlayerTD(playerid, ms_TD_Cart_ItemBackground[playerid][i]);
		RemovePlayerTD(playerid, ms_TD_Cart_ItemName[playerid][i]);
		RemovePlayerTD(playerid, ms_TD_Cart_ItemClose[playerid][i]);
	}
}

stock MenuStore_UpdateCartTotalValue(playerid)
{
	format(ms_String, sizeof(ms_String), ""#MS_WORD_TOTAL": %s%s", ms_Info[playerid][ms_MoneySign], Num_Format(MenuStore_GetCartTotalValue(playerid)));
	PlayerTextDrawSetString(playerid, ms_TD_Cart_Total[playerid], ms_String);
}

stock MenuStore_UpdateCart(playerid)
{
	// Remove any previous
	MenuStore_RemoveCartRows(playerid);

	// Write
	for(new row = 0; row < MS_MAX_ITEMS_CART; row++)
	{
		if(ms_Cart[playerid][ms_Cart_ItemID][row] != MSTORE_INVALID_ITEM_ID)
		{
			MenuStore_CreateCartRow(playerid, row);
		}
	}
}

stock MenuStore_AddItem(playerid, itemid, modelid, const name[], price, const description[] = EOS, Float:description_size = 0.0, bool:description_line_jump = true, stack = 1, Float:rotX = 0.0, Float:rotY = 0.0, Float:rotZ = 0.0, Float:zoom = 1.0)
{
	for(new i = 0; i < MS_MAX_ITEMS; i++)
		if(ms_Items[playerid][i][ms_ItemID] == itemid)
			return false;

	for(new i = 0; i < MS_MAX_ITEMS; i++)
	{
		if(ms_Items[playerid][i][ms_ItemID] == MSTORE_INVALID_ITEM_ID)
		{
			ms_Items[playerid][i][ms_ItemID] = itemid;	
			ms_Items[playerid][i][ms_ItemModel] = modelid;
			ms_Items[playerid][i][ms_ItemPrice] = price;
			ms_Items[playerid][i][ms_ItemStack] = stack;

			strpack(ms_Items[playerid][i][ms_ItemName], name, 32 char);
			strpack(ms_Items[playerid][i][ms_ItemDescription], description, 256 char);
			
			if(description_size > MS_MAX_SIZE_DESCRIPTION) {
				ms_Items[playerid][i][ms_ItemDescriptionBonus] = MS_MAX_SIZE_DESCRIPTION;
			}
			else {
				ms_Items[playerid][i][ms_ItemDescriptionBonus] = description_size;
			}

			ms_Items[playerid][i][ms_ItemLineJump] = description_line_jump;

			ms_Items[playerid][i][ms_ItemPreviewRot][0] = rotX;
			ms_Items[playerid][i][ms_ItemPreviewRot][1] = rotY;
			ms_Items[playerid][i][ms_ItemPreviewRot][2] = rotZ;
			ms_Items[playerid][i][ms_ItemPreviewRot][3] = zoom;

			ms_Info[playerid][ms_TotalItems]++;
			break;
		}	
	}

	return true;
}


stock MenuStore_Open(playerid, const menuid[], store_name[], const money_sign[] = MS_DEFAULT_MONEY_SIGN, button_confirm[] = MS_DEFAULT_CONFIRM)
{
	if(MenuStore_IsOpen(playerid))
		return false;

	SelectTextDraw(playerid, MS_COLOR_SELECT_TD);
	ms_Info[playerid][ms_IsOpen] = true;
	format(ms_Info[playerid][ms_MoneySign], 32, money_sign);
	format(ms_Info[playerid][ms_StoreID], 32, menuid);

	TextDrawShowForPlayer(playerid, ms_TD_Backgrounds[0]);
	TextDrawShowForPlayer(playerid, ms_TD_Backgrounds[1]);

	ms_TD_StoreName[playerid] = CreatePlayerTextDrawEx(playerid, 150.843780, 129.850082, store_name,
								0.310358, 1.434999,
								315.000000, 0.0,
								1,
								MS_COLOR_TEXT_MAIN,
								1,
								0,
								0,
								0,
								255,
								2,
								1);

	if(ms_Info[playerid][ms_TotalItems] > MS_MAX_ITEMS_PER_PAGE)
	{
		TextDrawShowForPlayer(playerid, ms_TD_Previous);
		TextDrawShowForPlayer(playerid, ms_TD_Next);
	}

	PlayerTextDrawShow(playerid, ms_TD_StoreName[playerid]);

	// Cart

	format(ms_String, sizeof(ms_String), ""#MS_WORD_TOTAL": %s0", ms_Info[playerid][ms_MoneySign]);
	ms_TD_Cart_Total[playerid] = CreatePlayerTextDrawEx(playerid, 339.200012, 386.949951, ms_String,
							0.219999, 1.331665,
							437.000000, 0.0,
							1,
							MS_COLOR_TEXT_MAIN,
							1,
							0xffffff00,
							0,
							0,
							255,
							2,
							1);

	ms_TD_Cart_BuyName[playerid] = CreatePlayerTextDrawEx(playerid, 476.000152, 386.683441, button_confirm,
							0.282000, 1.442499,
							0.000000, 61.000000,
							2,
							MS_COLOR_TEXT_MAIN,
							1,
							0xffffff00,
							0,
							0,
							255,
							2,
							1);

	TextDrawShowForPlayer(playerid, ms_TD_Cart_Backgrounds[0]);
	TextDrawShowForPlayer(playerid, ms_TD_Cart_Backgrounds[1]);
	TextDrawShowForPlayer(playerid, ms_TD_Cart_BackgroundConfirm);
	TextDrawShowForPlayer(playerid, ms_TD_Cart_CartName);

	PlayerTextDrawShow(playerid, ms_TD_Cart_BuyName[playerid]);
	PlayerTextDrawShow(playerid, ms_TD_Cart_Total[playerid]);

	ms_Info[playerid][ms_CurrentPage] = 1;
	MenuStore_SetPage(playerid, ms_Info[playerid][ms_CurrentPage]);
	return true;
}

stock MenuStore_Close(playerid)
{
	MenuStore_ResetVariables(playerid);

	CancelSelectTextDraw(playerid);
	MenuStore_UnselectRow(playerid);
	MenuStore_CloseDescription(playerid);

	TextDrawHideForPlayer(playerid, ms_TD_Backgrounds[0]);
	TextDrawHideForPlayer(playerid, ms_TD_Backgrounds[1]);
	TextDrawHideForPlayer(playerid, ms_TD_Previous);
	TextDrawHideForPlayer(playerid, ms_TD_Next);

	RemovePlayerTD(playerid, ms_TD_StoreName[playerid]);

	// Cart TextDraws

	TextDrawHideForPlayer(playerid, ms_TD_Cart_Backgrounds[0]);
	TextDrawHideForPlayer(playerid, ms_TD_Cart_Backgrounds[1]);
	TextDrawHideForPlayer(playerid, ms_TD_Cart_BackgroundConfirm);
	TextDrawHideForPlayer(playerid, ms_TD_Cart_CartName);

	RemovePlayerTD(playerid, ms_TD_Cart_BuyName[playerid]);
	RemovePlayerTD(playerid, ms_TD_Cart_Total[playerid]);

	for(new i = 0; i < MS_MAX_ITEMS_PER_PAGE; i++)
	{
		RemovePlayerTD(playerid, ms_TD_ItemBackground[playerid][i]);
		RemovePlayerTD(playerid, ms_TD_ItemName[playerid][i]);
		RemovePlayerTD(playerid, ms_TD_ItemPrice[playerid][i]);
		RemovePlayerTD(playerid, ms_TD_ItemModel[playerid][i]);
	}

	RemovePlayerTD(playerid, ms_TD_Pagination[playerid]);

	MenuStore_RemoveCartRows(playerid);

}

stock MenuStore_IsOpen(playerid)
	return ms_Info[playerid][ms_IsOpen];


stock MenuStore_SelectRow(playerid, row)
{
	ms_Info[playerid][ms_Selected] = row;

	PlayerTextDrawBoxColor(playerid, ms_TD_ItemBackground[playerid][row], MS_COLOR_BACKGROUND_ITEMSELECTED);
	PlayerTextDrawHide(playerid, ms_TD_ItemBackground[playerid][row]);
	PlayerTextDrawShow(playerid, ms_TD_ItemBackground[playerid][row]);
}

stock MenuStore_UnselectRow(playerid)
{
	if(ms_Info[playerid][ms_Selected] != -1)
	{
		new row = ms_Info[playerid][ms_Selected];
		PlayerTextDrawBoxColor(playerid, ms_TD_ItemBackground[playerid][row], MS_COLOR_BACKGROUND_ITEM);
		PlayerTextDrawHide(playerid, ms_TD_ItemBackground[playerid][row]);
		PlayerTextDrawShow(playerid, ms_TD_ItemBackground[playerid][row]);
	}

	ms_Info[playerid][ms_Selected] = -1;
}

stock MenuStore_ToggleControll(playerid, bool:toggle)
	return ms_Info[playerid][ms_ToggleControll] = toggle;


stock MenuStore_OpenDescription(playerid, index)
{
	if(ms_Info[playerid][ms_Selected] == -1)
		return false;

	if(ms_TD_DescriptionItemModel[playerid] == PlayerText:INVALID_TEXT_DRAW)
	{
		ms_TD_DescriptionBackground[playerid][0] = CreatePlayerTextDrawEx(playerid, 333.100463, 130.980590, "box",
												0.000000, (6.630985+ms_Items[playerid][index][ms_ItemDescriptionBonus]),
												516.000000, 0.000000,
												1,
												-1,
												1,
												MS_COLOR_DESCRIPTION_BACKGROUND_1,
												0,
												0,
												255,
												1,
												1);

		ms_TD_DescriptionBackground[playerid][1] = CreatePlayerTextDrawEx(playerid, 335.215118, 133.416717, "box",
												0.000000, (6.111274+ms_Items[playerid][index][ms_ItemDescriptionBonus]),
												514.000000, 0.000000,
												1,
												-1,
												1,
												MS_COLOR_DESCRIPTION_BACKGROUND_2,
												0,
												0,
												255,
												1,
												1);

		ms_TD_DescriptionItemName[playerid] = CreatePlayerTextDrawEx(playerid, 336.807769, 134.333419, ms_Items[playerid][index][ms_ItemName],
												0.225572, 1.349166,
												514.000000, 0.0,
												1,
												MS_COLOR_DESCRIPTION_NAMEITEM,
												1,
												0xffffff00,
												0,
												0,
												255,
												2,
												1);

		new Float:description_text_size_y = 460.000000,
			Float:description_text_size_x = 0.000000;

		if(!ms_Items[playerid][index][ms_ItemLineJump])
			description_text_size_y = 513.000000;

		ms_TD_DescriptionItemText[playerid] = CreatePlayerTextDrawEx(playerid, 336.981842, 147.783721, ms_Items[playerid][index][ms_ItemDescription],
												0.199804, 1.098332,
												description_text_size_y, description_text_size_x,
												1,
												MS_COLOR_DESCRIPTION_TEXT,
												1,
												0xffffff00,
												0,
												0,
												255,
												2,
												1);

		ms_TD_DescriptionItemModel[playerid] = CreatePlayerTextDrawEx(playerid, 460.658721, 135.700027, "",
												0.000000, 0.000000,
												52.000000, 51.000000,
												1,
												-1,
												0,
												0,
												0,
												0,
												MS_COLOR_DESCRIPTION_BACKGROUND_MODEL,
												5,
												0,
												ms_Items[playerid][index][ms_ItemModel],
												ms_Items[playerid][index][ms_ItemPreviewRot][0], ms_Items[playerid][index][ms_ItemPreviewRot][1], ms_Items[playerid][index][ms_ItemPreviewRot][2], ms_Items[playerid][index][ms_ItemPreviewRot][3]);
	}
	else
	{
		PlayerTextDrawHide(playerid, ms_TD_DescriptionItemName[playerid]);
		PlayerTextDrawHide(playerid, ms_TD_DescriptionItemText[playerid]);
		PlayerTextDrawHide(playerid, ms_TD_DescriptionItemModel[playerid]);

		PlayerTextDrawSetPreviewModel(playerid, ms_TD_DescriptionItemModel[playerid], ms_Items[playerid][index][ms_ItemModel]);
		PlayerTextDrawSetPreviewRot(playerid, ms_TD_DescriptionItemModel[playerid], ms_Items[playerid][index][ms_ItemPreviewRot][0], ms_Items[playerid][index][ms_ItemPreviewRot][1], ms_Items[playerid][index][ms_ItemPreviewRot][2], ms_Items[playerid][index][ms_ItemPreviewRot][3]);

		PlayerTextDrawSetString(playerid, ms_TD_DescriptionItemName[playerid], ms_Items[playerid][index][ms_ItemName][0]);
		PlayerTextDrawSetString(playerid, ms_TD_DescriptionItemText[playerid], ms_Items[playerid][index][ms_ItemDescription][0]);

		new Float:description_text_size_y = 460.000000,
			Float:description_text_size_x = 0.000000;

		if(!ms_Items[playerid][index][ms_ItemLineJump])
			description_text_size_y = 513.000000;

		PlayerTextDrawTextSize(playerid, ms_TD_DescriptionItemText[playerid], description_text_size_y, description_text_size_x);

		PlayerTextDrawLetterSize(playerid, ms_TD_DescriptionBackground[playerid][0], 0.000000, (6.630985+ms_Items[playerid][index][ms_ItemDescriptionBonus]));
		PlayerTextDrawLetterSize(playerid, ms_TD_DescriptionBackground[playerid][1], 0.000000, (6.111274+ms_Items[playerid][index][ms_ItemDescriptionBonus]));
	}

	PlayerTextDrawShow(playerid, ms_TD_DescriptionBackground[playerid][0]);
	PlayerTextDrawShow(playerid, ms_TD_DescriptionBackground[playerid][1]);
	PlayerTextDrawShow(playerid, ms_TD_DescriptionItemName[playerid]);
	PlayerTextDrawShow(playerid, ms_TD_DescriptionItemText[playerid]);
	PlayerTextDrawShow(playerid, ms_TD_DescriptionItemModel[playerid]);
	return true;
}

stock MenuStore_CloseDescription(playerid)
{
	RemovePlayerTD(playerid, ms_TD_DescriptionBackground[playerid][0]);
	RemovePlayerTD(playerid, ms_TD_DescriptionBackground[playerid][1]);
	RemovePlayerTD(playerid, ms_TD_DescriptionItemName[playerid]);
	RemovePlayerTD(playerid, ms_TD_DescriptionItemText[playerid]);
	RemovePlayerTD(playerid, ms_TD_DescriptionItemModel[playerid]);
}


stock MenuStore_ResetVariables(playerid)
{
	for(new i = 0; i < MS_MAX_ITEMS; i++) 
	{
		ms_Items[playerid][i][ms_ItemID] = MSTORE_INVALID_ITEM_ID;
		ms_Items[playerid][i][ms_ItemModel] = 0;
		ms_Items[playerid][i][ms_ItemPrice] = 0;
		ms_Items[playerid][i][ms_ItemStack] = 0;
		ms_Items[playerid][i][ms_ItemName][0] = EOS;
		ms_Items[playerid][i][ms_ItemDescription][0] = EOS;
		ms_Items[playerid][i][ms_ItemPreviewRot][0] = ms_Items[playerid][i][ms_ItemPreviewRot][1] = ms_Items[playerid][i][ms_ItemPreviewRot][2] = ms_Items[playerid][i][ms_ItemPreviewRot][3] = 0.0;
		ms_Items[playerid][i][ms_ItemLineJump] = true;
		ms_Items[playerid][i][ms_ItemDescriptionBonus] = 0.0;
	}

	for(new i = 0; i < MS_MAX_ITEMS_CART; i++)
	{
		ms_Cart[playerid][ms_Cart_ItemID][i] = MSTORE_INVALID_ITEM_ID;
		ms_Cart[playerid][ms_Cart_ItemPrice][i] = 0;
		ms_Cart[playerid][ms_Cart_ItemAmount][i] = 0;
	}

	ms_Info[playerid][ms_TotalItems] = 0;
	ms_Info[playerid][ms_CurrentPage] = 1;
	ms_Info[playerid][ms_IsOpen] = false;
	ms_Info[playerid][ms_StoreID][0] = EOS;
	ms_Info[playerid][ms_MoneySign][0] = EOS;
	ms_Info[playerid][ms_DoubleClickRow] = -1;
	ms_Info[playerid][ms_DoubleClick] = 0;
	ms_Info[playerid][ms_Selected] = -1;
	ms_Info[playerid][ms_ToggleControll] = true;
}


static stock RemovePlayerTD(playerid, &PlayerText:td)
{
	if(td == PlayerText:INVALID_TEXT_DRAW)
		return false;

	PlayerTextDrawHide(playerid, td);
	PlayerTextDrawDestroy(playerid, td);
	td = PlayerText:INVALID_TEXT_DRAW;
	return true;
}

static stock PlayerText:CreatePlayerTextDrawEx(playerid, Float:x, Float:y, text[],
							Float:size_x, Float:size_y,
							Float:textsize_x, Float:textsize_y,
							align,
							color,
							usebox,
							boxcolor,
							shadow,
							outline,
							bg_color,
							font,
							proportional,
							model = 0,
							Float:preview_x= 0.0, Float:preview_y = 0.0, Float:preview_z = 0.0, Float:preview_zoom = 1.0,
							selectable = 0)
{
	new PlayerText:td;
    td = CreatePlayerTextDraw(playerid, x, y, text);
	PlayerTextDrawLetterSize(playerid, td, size_x, size_y);
	PlayerTextDrawTextSize(playerid, td, textsize_x, textsize_y);
	PlayerTextDrawAlignment(playerid, td, align);
	PlayerTextDrawColor(playerid, td, color);
	PlayerTextDrawUseBox(playerid, td, usebox);
	PlayerTextDrawBoxColor(playerid, td, boxcolor);
	PlayerTextDrawSetShadow(playerid, td, shadow);
	PlayerTextDrawSetOutline(playerid, td, outline);
	PlayerTextDrawBackgroundColor(playerid, td, bg_color);
	PlayerTextDrawFont(playerid, td, font);
	PlayerTextDrawSetProportional(playerid, td, proportional);
	PlayerTextDrawSetPreviewModel(playerid, td, model);
	PlayerTextDrawSetPreviewRot(playerid, td, preview_x, preview_y, preview_z, preview_zoom);
	PlayerTextDrawSetSelectable(playerid, td, selectable);
	return td;
}

static stock Text:CreateTextDrawEx(Float:x, Float:y, text[],
					Float:size_x, Float:size_y,
					Float:textsize_x, Float:textsize_y,
					align,
					color,
					usebox,
					boxcolor,
					shadow,
					outline,
					bg_color,
					font,
					proportional,
					model = 0,
					Float:preview_x = 0.0, Float:preview_y = 0.0, Float:preview_z = 0.0, Float:preview_zoom = 0.0,
					selectable = 0)
{
	new Text:td;
	td = TextDrawCreate(x, y, text);
	TextDrawLetterSize(td, size_x, size_y);
	TextDrawTextSize(td, textsize_x, textsize_y);
	TextDrawAlignment(td, align);
	TextDrawColor(td, color);
	TextDrawUseBox(td, usebox);
	TextDrawBoxColor(td, boxcolor);
	TextDrawSetShadow(td, shadow);
	TextDrawSetOutline(td, outline);
	TextDrawBackgroundColor(td, bg_color);
	TextDrawFont(td, font);
	TextDrawSetProportional(td, proportional);
	TextDrawSetPreviewModel(td, model);
	TextDrawSetPreviewRot(td, preview_x, preview_y, preview_z, preview_zoom);
	TextDrawSetSelectable(td, selectable);
	return td;
}
