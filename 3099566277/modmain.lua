--[NEW] This is how we tell the game we've created a new prefab.
 PrefabFiles =
{

	--GLASS

	--CANNON
	--cannonballs
	"des_cb_ground",
	"des_bcannon",
	"des_cannon_stick",

    "gt_boat_spotlight",
    "gt_steam_engine",
	"des_boat_torch",	


	
	--RIVER
	-- "des_river",
	-- "des_river_fishinghole",
	-- "des_river_sinkhole",
	-- "des_river_circle"
	
	--Chainik
	--"des_chainik"
}

Assets = 
{

	--[[
	Asset("IMAGE", "images/inventoryimages/des_sand.tex"),
    Asset("ATLAS", "images/inventoryimages/des_sand.xml"),
	
	Asset("IMAGE", "images/inventoryimages/des_sand_castle.tex"),
	Asset("ATLAS", "images/inventoryimages/des_sand_castle.xml"),

    Asset("IMAGE", "images/inventoryimages/des_glass_shards.tex"),
	Asset("ATLAS", "images/inventoryimages/des_glass_shards.xml"),

	--]]
	
	
	
    Asset("IMAGE", "images/inventoryimages/des_cannon_stick.tex"),
	Asset("ATLAS", "images/inventoryimages/des_cannon_stick.xml"),
	
    Asset("IMAGE", "images/inventoryimages/des_bcannon.tex"),
	Asset("ATLAS", "images/inventoryimages/des_bcannon.xml"),
	
    Asset("IMAGE", "images/inventoryimages/des_cannonball_stone.tex"),
	Asset("ATLAS", "images/inventoryimages/des_cannonball_stone.xml"),
	
    Asset("IMAGE", "images/inventoryimages/des_cannonball_red.tex"),
	Asset("ATLAS", "images/inventoryimages/des_cannonball_red.xml"),	

    Asset("IMAGE", "images/inventoryimages/des_cannonball_glass.tex"),
	Asset("ATLAS", "images/inventoryimages/des_cannonball_glass.xml"),	
	
	
    Asset("IMAGE", "images/inventoryimages/gt_boat_spotlight.tex"),
	Asset("ATLAS", "images/inventoryimages/gt_boat_spotlight.xml"),	

    Asset("IMAGE", "images/inventoryimages/gt_boat_spotlight_moon.tex"),
	Asset("ATLAS", "images/inventoryimages/gt_boat_spotlight_moon.xml"),	
	
    Asset("IMAGE", "images/inventoryimages/gt_steam_engine.tex"),
	Asset("ATLAS", "images/inventoryimages/gt_steam_engine.xml"),	
	
    Asset("IMAGE", "images/inventoryimages/des_boat_torch.tex"),
	Asset("ATLAS", "images/inventoryimages/des_boat_torch.xml"),	
	
	
}

------------------------------------------------------


--------------------------

local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local STRINGS = GLOBAL.STRINGS
local TUNING = GLOBAL.TUNING
local ACTIONS = GLOBAL.ACTIONS
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local STRINGS = GLOBAL.STRINGS
local TECH = GLOBAL.TECH
local STRINGS = GLOBAL.STRINGS
local ACTIONS = GLOBAL.ACTIONS
local Action = GLOBAL.Action
local require = GLOBAL.require
local EQUIPSLOTS = GLOBAL.EQUIPSLOTS
local GetString=GLOBAL.GetString
local SpawnPrefab=GLOBAL.SpawnPrefab


----------------TUNING---------------
local day_time = 60 * 8
local total_day_time = day_time
local wilson_attack = 34
local wilson_health = 150
local calories_per_day = 75


-------STACKSIZE_FIX--------
local STACKSIZE_FIX={
	[5]=TUNING.STACK_SIZE_LARGEITEM,
	[10]=TUNING.STACK_SIZE_LARGEITEM,
	[15]=TUNING.STACK_SIZE_MEDITEM,
	[20]=TUNING.STACK_SIZE_MEDITEM,
	[30]=TUNING.STACK_SIZE_SMALLITEM,
	[40]=TUNING.STACK_SIZE_SMALLITEM,
	[999]=TUNING.STACK_SIZE_SMALLITEM,
	[60]=TUNING.STACK_SIZE_TINYITEM,
}
-------CANNONBALSS--------
local STACKSIZE=STACKSIZE_FIX[GetModConfigData("DES_CB_STACKSIZE")]
TUNING.DES_CB_STACKSIZE = STACKSIZE

TUNING.DES_CB_SMALL_CRAFT_NUM = GetModConfigData("DES_CB_SMALL_CRAFT_NUM")
TUNING.DES_CB_RED_CRAFT_NUM = GetModConfigData("DES_CB_RED_CRAFT_NUM")
TUNING.DES_CB_GLASS_CRAFT_NUM = GetModConfigData("DES_CB_GLASS_CRAFT_NUM")

TUNING.DES_CB_SMALL_DAMAGE= GetModConfigData("DES_CB_SMALL_DAMAGE")
TUNING.DES_CB_RED_DAMAGE= GetModConfigData("DES_CB_RED_DAMAGE")
TUNING.DES_CB_GLASS_DAMAGE= GetModConfigData("DES_CB_GLASS_DAMAGE")


-------FLOODLIGHT--------
TUNING.GT_LIGHT_LIFETIME = GetModConfigData("GT_LIGHT_LIFETIME")* total_day_time
TUNING.GT_LIGHT_LIFETIME_FUELMULT = GetModConfigData("GT_LIGHT_LIFETIME_FUELMULT")
TUNING.GT_LIGHT_LIFETIME_FUELTYPE = GetModConfigData("GT_LIGHT_LIFETIME_FUELTYPE")
TUNING.GT_LIGHT_LIFETIME_MOON = TUNING.GT_LIGHT_LIFETIME*2


-------STEAM ENGINE--------
TUNING.GT_STEAM_ENGINE_RECIPE = GetModConfigData("GT_STEAM_ENGINE_RECIPE")
TUNING.GT_STEAM_ENGINE_SPEED = GetModConfigData("GT_STEAM_ENGINE_SPEED")
TUNING.GT_STEAM_ENGINE_OVERHEAT = GetModConfigData("GT_STEAM_ENGINE_OVERHEAT")
TUNING.GT_STEAM_ENGINE_LIFETIME = GetModConfigData("GT_STEAM_ENGINE_LIFETIME")* total_day_time
TUNING.GT_STEAM_ENGINE_FUELMULT = GetModConfigData("GT_STEAM_ENGINE_FUELMULT")


TUNING.DES_CANNON_WIDGETS = {}


-------LIGHT--------
TUNING.DES_BOAT_TORCH_LIFETIME = GetModConfigData("DES_BOAT_TORCH_LIFETIME")* total_day_time
TUNING.DES_BOAT_TORCH_LIFETIME_FUELMULT = GetModConfigData("DES_BOAT_TORCH_LIFETIME_FUELMULT")


------- RECIPES ------
TUNING.DES_CANNON_RECIPE = GetModConfigData("DES_CANNON_RECIPE")
TUNING.GT_LIGHT_RECIPE = GetModConfigData("GT_LIGHT_RECIPE")
TUNING.GT_LIGHT_RECIPE_MOON = GetModConfigData("GT_LIGHT_RECIPE_MOON")


modimport("des_cannon_new_widgets.lua")

modimport("des_glass_bombs_fix.lua")

modimport("des_cannon_strings.lua")

------------------------------------


AddPrefabPostInit("gunpowder",function(inst)
    inst:AddComponent("tradable")
end)




local function BoatTest(pos,rot)
    local boat=GLOBAL.TheWorld.Map:GetPlatformAtPoint(pos.x,pos.y,pos.z)
    return boat~=nil,false
end


------RECIPES------
local sort = 8

local cannon_ingr = {
    {Ingredient("transistor", 3), Ingredient("log", 6)},
    {Ingredient("transistor", 3), Ingredient("gears", 1), Ingredient("driftwood_log", 6)},
    {Ingredient("redgem", 3), Ingredient("gears", 3), Ingredient("driftwood_log", 6)},
}

local light_ingr = {
    {Ingredient("transistor", 1), Ingredient("log", 6)},
    {Ingredient("minerhat", 1), Ingredient("transistor", 1), Ingredient("boards", 2)},
    {Ingredient("transistor", 2), Ingredient("torch", 1), Ingredient("log", 3)},
    {Ingredient("bluegem", 1), Ingredient("gears", 1), Ingredient("driftwood_log", 3)},
}

local light_ingr_moon = {
    {Ingredient("moonrocknugget", 2), Ingredient("log", 3)},
    {Ingredient("minerhat", 1), Ingredient("moonglass", 2), Ingredient("boards", 3)},
    {Ingredient("moonrocknugget", 2), Ingredient("moonglass", 1), Ingredient("boards", 2)},
    {Ingredient("purplegem", 1), Ingredient("moonglass", 4), Ingredient("moonrockcrater", 1)},
}

local steam_engine_ingr = {
    {Ingredient("gears", 2), Ingredient("transistor", 2), Ingredient("driftwood_log", 3)},
    {Ingredient("gears", 2), Ingredient("redgem", 3), Ingredient("driftwood_log", 10)},
    {Ingredient("gears", 2), Ingredient("malbatross_beak", 1), Ingredient("driftwood_log", 10)},
}

local des_boat_torch = AddRecipe2("des_boat_torch",
	{Ingredient("twigs", 4), Ingredient("cutgrass", 12)},
	TECH.SEAFARING_ONE,
	{placer="des_boat_torch_placer",
	min_spacing=0.001,
	nounlock=nil,
	numtogive=1,
	builder_tag=nil,
	atlas="images/inventoryimages/des_boat_torch.xml",
	image="des_boat_torch.tex",
	testfn=BoatTest},
	{"SEAFARING", "LIGHT", "STRUCTURES"})
des_boat_torch.sortkey = sort
sort = sort + 1


local gt_boat_spotlight = AddRecipe2("gt_boat_spotlight",
	light_ingr[TUNING.GT_LIGHT_RECIPE],
	TECH.SEAFARING_ONE,
	{placer="gt_boat_spotlight_placer",
	min_spacing=0.5,
	atlas="images/inventoryimages/gt_boat_spotlight.xml",
	testfn=BoatTest},
	{"SEAFARING", "LIGHT", "STRUCTURES"})
gt_boat_spotlight.sortkey = sort
sort = sort + 1

local gt_boat_spotlight_moon = AddRecipe2("gt_boat_spotlight_moon",
	light_ingr_moon[TUNING.GT_LIGHT_RECIPE_MOON],
	TECH.SEAFARING_ONE,
	{placer="gt_boat_spotlight_moon_placer",
	min_spacing=0.5,
	atlas="images/inventoryimages/gt_boat_spotlight_moon.xml",
	testfn=BoatTest},
	{"SEAFARING", "LIGHT", "STRUCTURES"})
gt_boat_spotlight_moon.sortkey = sort
sort = sort + 1


local gt_steam_engine = AddRecipe2("gt_steam_engine",
	steam_engine_ingr[TUNING.GT_STEAM_ENGINE_RECIPE],
	TECH.SEAFARING_ONE,
	{placer="gt_steam_engine_placer",
	min_spacing=1,
	atlas="images/inventoryimages/gt_steam_engine.xml",
	testfn=BoatTest},
	{"SEAFARING", "STRUCTURES"})
gt_steam_engine.sortkey = sort
sort = sort + 1

local des_bcannon = AddRecipe2("des_bcannon",
	cannon_ingr[TUNING.DES_CANNON_RECIPE],
	TECH.SEAFARING_ONE,
	{placer="des_bcannon_placer",
	min_spacing=1,
	atlas="images/inventoryimages/des_bcannon.xml"},
	{"SEAFARING","CONTAINERS","STRUCTURES"})
des_bcannon.sortkey = sort
sort = sort + 1

local des_cannon_stick = AddRecipe2("des_cannon_stick",
	{Ingredient("twigs", 3), Ingredient("cutgrass", 3)},
	TECH.SEAFARING_ONE,
	{numtogive=1,
	atlas="images/inventoryimages/des_cannon_stick.xml",
	image="des_cannon_stick.tex"},
	{"SEAFARING", "WEAPONS"})
des_cannon_stick.sortkey = sort
sort = sort + 1

local des_cb_ground_stone = AddRecipe2("des_cb_ground_stone",
	{Ingredient("rocks", TUNING.DES_CB_SMALL_CRAFT_NUM),Ingredient("gunpowder", 1)},
	TECH.SEAFARING_ONE,
	{numtogive=TUNING.DES_CB_SMALL_CRAFT_NUM,
	atlas="images/inventoryimages/des_cannonball_stone.xml",
	image="des_cannonball_stone.tex"},
	{"SEAFARING", "WEAPONS"})
des_cb_ground_stone.sortkey = sort
sort = sort + 1

local des_cb_ground_red = AddRecipe2("des_cb_ground_red",
	{Ingredient("rocks", TUNING.DES_CB_RED_CRAFT_NUM),Ingredient("redgem", 1), Ingredient("gunpowder", 1)},
	TECH.SEAFARING_ONE,
	{numtogive=TUNING.DES_CB_RED_CRAFT_NUM,
	atlas="images/inventoryimages/des_cannonball_red.xml",
	image="des_cannonball_red.tex"},
	{"SEAFARING", "WEAPONS"})
des_cb_ground_red.sortkey = sort
sort = sort + 1

local des_cb_ground_glass = AddRecipe2("des_cb_ground_glass",
	{Ingredient("rocks", TUNING.DES_CB_GLASS_CRAFT_NUM),Ingredient("moonglass", 1), Ingredient("gunpowder", 1)},
	TECH.CELESTIAL_THREE,
	{numtogive=TUNING.DES_CB_GLASS_CRAFT_NUM,
	nounlock=true,
	atlas="images/inventoryimages/des_cannonball_glass.xml",
	image="des_cannonball_glass.tex"},
	{"SEAFARING", "WEAPONS", "CELESTIAL"})
des_cb_ground_glass.sortkey = sort
sort = sort + 1
