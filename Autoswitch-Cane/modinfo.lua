name = "AutoSwitchWeapon Eng ver - DHPModified"

description = [[
Original mod: https://steamcommunity.com/sharedfiles/filedetails/?id=3338335946&searchtext=AutoSwitchWeapon
From update version: 16 March 2025

Automatically switch between cane and weapon

Function:
1. Automatic switching of walking cane
2. Automatic weapon switching during attack
3. Switch according to the storage location of the weapon
4. In the settings, you can cancel whether to walk or switch the wand

Optimization of the original version:
1. When moving statues, one cannot cut a cane
2. Automatically start the game
3. Add non cutting cane items
4. Non cutting cane items can be set in the settings (if missing, please leave a message and I will add it)

Suggest pairing with Mod:
https://steamcommunity.com/sharedfiles/filedetails/?id=1598084686 https://steamcommunity.com/sharedfiles/filedetails/?id=3335860234

This mod is optimized for handling
Original Mod Address: https://steamcommunity.com/sharedfiles/filedetails/?id=3225478506
Original Mod Address: https://steamcommunity.com/sharedfiles/filedetails/?id=2781167240

If you think this mod is good, please give it a thumbs up!
If there are any areas that need to be optimized for this mod
Welcome to leave a message for discussion!
]]

author = "GEZHIJIE"
version = "1.3.9"

forumthread = ""

api_version = 10

all_clients_require_mod = false

client_only_mod = true

dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false

icon_atlas = "icon.xml"
icon = "icon.tex"

local KEY_OPTIONS = {}
local KEY_LIST = {
    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O",
    "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"
}
for i = 1, 26 do
    KEY_OPTIONS[i] = { description = KEY_LIST[i], data = KEY_LIST[i] }
end

local SLOT_OPTIONS = {}
local SLOT_LIST = {
    "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14",
    "15"
}
for i = 1, 15 do
    SLOT_OPTIONS[i] = { description = SLOT_LIST[i], data = SLOT_LIST[i] }
end

configuration_options = {
    {
        name = "KEY_SWITCH",
        label = "Start stop hotkey",
        options = KEY_OPTIONS,
        default = "K"
    },
    {
        name = "isActivation",
        label = "Enter game auto open",
        hover = "Automatically start when entering the game",
        options = {
            { description = "Disable", data = false },
            { description = "Enable", data = true }
        },
        default = true,
    },
    {
        name = "CHIP_SLOT",
        label = "To switch weapon slots",
        hover = "A mark will appear on the inventory list",
        options = SLOT_OPTIONS,
        default = "15"
    },
    {
        name = "strangeAttacks",
        label = "strangeAttacks",
        options = {
            { description = "Disable", data = false, hover = "Not turned on, strange attack, default is better this way" },
            { description = "Enable", data = true, hover = "Not recommended to enable as it is not suitable for regular players" }
        },
        default = false,
    },
    {
        name = "x1",
        label = "Follow items do not switch",
        options = { {
                        description = "",
                        data = ""
                    } },
        default = ""
    },
    {
        name = "torch",
        label = "torch",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
        },
        default = true,
    },
    {
        name = "lantern",
        label = "lantern",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
        },
        default = true,
    },
    {
        name = "umbrella",
        label = "umbrella",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
        },
        default = true,
    },
    {
        name = "grass_umbrella",
        label = "grass_umbrella",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
        },
        default = true,
    },
    {
        name = "lighter",
        label = "Willow's lighter",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "reskin_tool",
        label = "reskin_tool",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "bugnet",
        label = "bugnet",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "shovel",
        label = "shovel",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "goldenshovel",
        label = "goldenshovel",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "pitchfork",
        label = "pitchfork",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "goldenpitchfork",
        label = "goldenpitchfork",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "wateringcan",
        label = "wateringcan",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "premiumwateringcan",
        label = "premiumwateringcan",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "farm_hoe",
        label = "farm_hoe",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "golden_farm_hoe",
        label = "golden_farm_hoe",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "oar",
        label = "oar",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "oar_driftwood",
        label = "oar_driftwood",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "oar_monkey",
        label = "oar_monkey",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "malbatross_beak",
        label = "malbatross_beak",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "yotd_oar",
        label = "yotd_oar",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "oceanfishingrod",
        label = "oceanfishingrod",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "voidcloth_umbrella",
        label = "voidcloth_umbrella",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "voidcloth_scythe",
        label = "voidcloth_scythe",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "telestaff",
        label = "telestaff",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "stars_staff",
        label = "stars_staff",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "fires_ice_staff",
        label = "fires_ice_staff",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "boomerang",
        label = "boomerang",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "spear_wathgrithr_lightning",
        label = "spear_wathgrithr_lightning",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "nightstick",
        label = "nightstick",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "sleep_fire_yellow_blowdart",
        label =  "sleep_fire_yellow_blowdart",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "trident",
        label = "trident",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "staff_tornado",
        label = "staff_tornado",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "moonglassaxe",
        label = "moonglassaxe",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "multitool_axe_pickaxe",
        label = "multitool_axe_pickaxe",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "staff_lunarplant",
        label = "staff_lunarplant",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "houndstooth_blowpipe",
        label = "houndstooth_blowpipe",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "bomb_lunarplant",
        label = "bomb_lunarplant",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "shovel_lunarplant",
        label = "shovel_lunarplant",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "pickaxe_lunarplant",
        label = "pickaxe_lunarplant",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = false,
    },
    {
        name = "minifan",
        label = "minifan",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "balloon",
        label = "balloon",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "balloonparty",
        label = "balloonparty",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "balloonspeed",
        label = "balloonspeed",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "winona_telebrella",
        label = "winona_telebrella",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "x2",
        label =  "mod-Follow items do not switch-furnace",
        options = { {
                        description = "",
                        data = ""
                    } },
        default = ""
    },
    {
        name = "forgedarts",
        label = "forgedarts",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "moltendarts",
        label = "moltendarts",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "livingstaff",
        label = "livingstaff",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },
    {
        name = "infernalstaff",
        label = "infernalstaff",
        options = {
            { description = "Disable", data = false, hover = "Will automatically switch the cane" },
            { description = "Enable", data = true, hover = "Will not automatically switch canes" }
        },
        default = true,
    },


}
