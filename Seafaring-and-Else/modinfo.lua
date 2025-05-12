name = "Seafaring and Else - Fix crash cannon - DHPModified"
description = [[
Original mod: https://steamcommunity.com/sharedfiles/filedetails/?id=1910111177&searchtext=Seafaring

I have fixed the bug caught crash when u craft cannonball.

Sorry i can't modify or update anythings more!.
]]

author = "Desblat & Trololarion - DHPModified"
version = "1.1.13"

forumthread = ""

api_version = 10
priority = 1 ---for real wtf this means?

dst_compatible = true
dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = true

dst_compatible = true
all_clients_require_mod = true


icon_atlas = "modicon.xml"
icon = "modicon.tex"



----------------TUNING---------------
local day_time = 60 * 8
local total_day_time = day_time
local wilson_attack = 34
local wilson_health = 150
local calories_per_day = 75



local opt_Empty = {{description = "", data = 0}}
local function Title(title,hover)
return {
name=title,
hover=hover,
options=opt_Empty,
default=0,
}
end
local SEPARATOR = Title("")

	

configuration_options =
{
	Title("CANNON"),
	{
		name = "DES_CANNON_RECIPE",
		label = "Cannon recipe",
		hover = "EASY = transistors. NORMAL = gears and driftwood. HARD = redgems and gears",
		options =
		{
			{description = "Easy", data = 1},
			{description = "Normal", data = 2},
			{description = "Hard", data = 3},
		},
		default = 2,
	},
	
	SEPARATOR,	
	Title("CANNONBALLS"),
	{
		name = "DES_CB_STACKSIZE",
		label = "Max stack size",
		hover = "Max stack size of cannonballs",
		options =
		{
			{description = "10", data = 10},
			{description = "20", data = 20},
			{description = "50", data = 50},
			{description = "100", data = 100},
			{description = "200", data = 200},
			{description = "500", data = 500},

		},
		default = 10,
	},
	{
		name = "DES_CB_SMALL_CRAFT_NUM",
		label = "Stone cannonball crafting",
		hover = "Craft X cannonballs at once. Recipe: X rocks + 1 gunpowder. \n Setting alters X",
		options =
		{
			{description = "2", data = 2},
			{description = "3", data = 3},
			{description = "4", data = 4},
			{description = "5", data = 5},
			{description = "10", data = 10},
			{description = "20", data = 20},
		},
		default = 3,
	},
	{
		name = "DES_CB_SMALL_DAMAGE",
		label = "Stone cannonball Damage",
		hover = "Stone cannonball damage to mobs and players",
		options =
	{
			{description = "150", data = 150},
			{description = "200", data = 200},
			{description = "300", data = 300},
			{description = "400", data = 400},
			{description = "500", data = 500},
	},
		default = 200,
	},

	{
		name = "DES_CB_RED_CRAFT_NUM",
		label = "Fire cannonball crafting",
		hover = "Craft X fire cannonballs at once. Recipe: X rocks + 1 gunpowder + 1 redgem. \n Setting alters X",
		options =
		{
			{description = "2", data = 2},
			{description = "3", data = 3},
			{description = "4", data = 4},
			{description = "5", data = 5},
			{description = "10", data = 10},
			{description = "20", data = 20},
		},
		default = 3,
	},
	{
		name = "DES_CB_RED_DAMAGE",
		label = "Fire cannonball Damage",
		hover = "Fire cannonball damage to mobs and players",
		options =
		{
			{description = "200", data = 200},
			{description = "250", data = 250},
			{description = "300", data = 300},
			{description = "400", data = 400},
			{description = "500", data = 500},
			{description = "650", data = 650},
			{description = "1000", data = 1010},
		},
		default = 250,
	},

	{
		name = "DES_CB_GLASS_CRAFT_NUM",
		label = "Glass cannonball crafting",
		hover = "Craft X glass cannonballs at once. Recipe: X moonrock + 2 moonglass + 1 rope. \n Setting alters X",
		options =
		{
			{description = "2", data = 2},
			{description = "3", data = 3},
			{description = "4", data = 4},
			{description = "5", data = 5},
			{description = "10", data = 10},
			{description = "20", data = 20},
		},
		default = 3,
	},

	{
		name = "DES_CB_GLASS_DAMAGE",
		label = "Glass cannonball Damage",
		hover = "Glass cannonball damage to mobs and players",
		options =
		{
			{description = "300", data = 300},
			{description = "400", data = 400},
			{description = "500", data = 500},
			{description = "600", data = 600},
			{description = "850", data = 850},
			{description = "1000", data = 1010},
		},
		default = 600,
	},


	SEPARATOR,
	Title("BOAT FLOODLIGHT"),
	{
		name = "GT_LIGHT_RECIPE",
		label = "Floodlight recipe",
		hover = "EASY = transistors. NORMAL = minerhat + transistor.  \n HARD = bluegems + gears",
		options =
		{
			{description = "Easy", data = 1},
			--{description = "Cave", data = 2},
			{description = "Normal", data = 2},
			{description = "Hard", data = 4},
		},
		default = 2,
	},
	{
		name = "GT_LIGHT_RECIPE_MOON",
		label = "Moon Floodlight recipe",
		hover = "EASY = moonrocks. NORMAL = minerhat + moonglass. \n HARD = moonlense + moonglass + purplegem",
		options =
		{
			{description = "Easy", data = 1},
			--{description = "Cave", data = 2},
			{description = "Normal", data = 2},
			{description = "Hard", data = 4},
		},
		default = 2,
	},
	{
		name = "GT_LIGHT_LIFETIME",
		label = "Floodlight life time",
		hover = "How long floodlight lasts? Moon floodlight lasts twice as much",
		options =
		{
			{description = "1 day", data = 1},
			{description = "2 days", data = 2},
			{description = "3 days", data = 3},
			{description = "4 days", data = 4},
			{description = "10 days", data = 10},
			{description = "20 days", data = 20},
			{description = "Infinite", data = 99999},
		},
		default = 1,
	},
	{
		name = "GT_LIGHT_LIFETIME_FUELMULT",
		label = "Fuel effeciency",
		hover = "Fuel refills multi, moon floodlight is twice as effecienct",
		options =
		{
			{description = "0.5x", data = 0.5},
			{description = "1x", data = 1},
			{description = "1.5x", data = 1.5},
			{description = "2x", data = 2},
			{description = "3x", data = 3},
			{description = "4x", data = 4},
			{description = "5x", data = 5},
			{description = "10x", data = 10},
		},
		default = 1,
	},
	
	{
		name = "GT_LIGHT_LIFETIME_FUELTYPE",
		label = "Fuel type",
		hover = "What fuels floodlight? Same for moon floodlight",
		options =
		{
			{description = "Campfire", data = 0},
			{description = "Cave Lantern", data = 1},
			{description = "Nightmare fuel", data = 2},
		},
		default = 0,
	},
    SEPARATOR,
    Title("STEAM ENGINE"),
	{		
        name = "GT_STEAM_ENGINE_RECIPE",
		label = "Engine craft",
		hover = "EASY = gears and driftwood. NORMAL = gears and redgems. HARD = malbatross beak and gears",
		options =
		{
 			{description = "Easy", data = 1},
            {description = "Normal", data = 2},
			{description = "Hard", data = 3},
        },
		default = 2,
    },		
    {		
		name = "GT_STEAM_ENGINE_SPEED",
        label = "Speed",
        hover = "How much speed engine gives compairing to default mast?",
        options =
        {			
            {description = "1.25x", data = 1.25},
            {description = "1.4x", data = 1.4},
			{description = "1.5x", data = 1.5},
            {description = "1.75x", data = 1.75},
            {description = "2x", data = 2},
            {description = "2.25x", data = 2.25},
        },
		default = 1.4,	
    },
    {		
        name = "GT_STEAM_ENGINE_OVERHEAT",
		label = "Overheat difficulty",
		hover = "How fast engine overheats?",
		options =
		{
            {description = "0.5 day", data = 0.5},
			{description = "1 day", data = 1},
			{description = "2 days", data = 2},
			{description = "3 days", data = 3},
			{description = "4 days", data = 4},
			{description = "10 days", data = 10},
        },
		default = 0.5,
    },
	{
        name = "GT_STEAM_ENGINE_LIFETIME",
		label = "Engine work time",
		hover = "How long engine lasts?",
		options =
		{			
            {description = "1 day", data = 1},
			{description = "2 days", data = 2},
			{description = "3 days", data = 3},
			{description = "4 days", data = 4},
			{description = "10 days", data = 10},
        },
		default = 1,
    },
    {
        name = "GT_STEAM_ENGINE_FUELMULT",
		label = "Fuel effeciency",
		hover = "Fuel refills multi.",
		options =
        {
            {description = "0.5x", data = 0.5},
            {description = "1x", data = 1},
            {description = "1.5x", data = 1.5},
            {description = "2x", data = 2},
            {description = "3x", data = 3},
            {description = "4x", data = 4},
            {description = "5x", data = 5},
            {description = "10x", data = 10},
        },
        default = 1,
    },
	
	SEPARATOR,		
	Title("BOAT TORCH"),
	{
		name = "DES_BOAT_TORCH_LIFETIME",
		label = "Boat Torch life time",
		hover = "How long boat torch lasts?",
		options =
		{
			{description = "1 day", data = 1},
			{description = "2 days", data = 2},
			{description = "3 days", data = 3},
			{description = "4 days", data = 4},
			{description = "5 days", data = 5},
			{description = "10 days", data = 10},
		},
		default = 2,
	},
	{
		name = "DES_BOAT_TORCH_LIFETIME_FUELMULT",
		label = "Fuel effeciency",
		hover = "Fuel refills multi",
		options =
		{
			{description = "0.5x", data = 0.5},
			{description = "1x", data = 1},
			{description = "1.5x", data = 1.5},
			{description = "2x", data = 2},
			{description = "3x", data = 3},
			{description = "4x", data = 4},
			{description = "5x", data = 5},
			{description = "10x", data = 10},
		},
		default = 1,
	},
	
}

server_filter_tags = {"thirst", "water", "realism"}
