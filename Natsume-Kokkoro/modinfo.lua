name = "Natsume Kokkoro - DHPModified"
description = [[
Original mod: https://steamcommunity.com/sharedfiles/filedetails/?id=3243666193
From update version: 23 May 2025
]]
author = "PhucDh410"
version = "1.0.0"

api_version = 10
dst_compatible = true

dont_starve_compatible = false
reign_of_giants_compatible = false
all_clients_require_mod = true 

icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = {
    "character",
    "pcr",
    "Kokkoro",
    "kkr",
}

local function AddTitle(title)
    return {
        label = title,
        name = "",
        hover = "",
        options = {{description = "", data = 0}},
        default = 0
    }
end

configuration_options = 
{
    AddTitle("Skill button settings"),
    {
        name = 'kkr_fly_skill',
        label = 'Flight Button',
        hover = 'Set flight button',
        options = {
            {description = 'A', data = 97},
            {description = 'B', data = 98},
            {description = 'C', data = 99},
            {description = 'D', data = 100},
            {description = 'E', data = 101},
            {description = 'F', data = 102},
            {description = 'G', data = 103},
            {description = 'H', data = 104},
            {description = 'I', data = 105},
            {description = 'J', data = 106},
            {description = 'K', data = 107},
            {description = 'L', data = 108},
            {description = 'M', data = 109},
            {description = 'N', data = 110},
            {description = 'O', data = 111},
            {description = 'P', data = 112},
            {description = 'Q', data = 113},
            {description = 'R', data = 114},
            {description = 'S', data = 115},
            {description = 'T', data = 116},
            {description = 'U', data = 117},
            {description = 'V', data = 118},
            {description = 'W', data = 119},
            {description = 'X', data = 120},
            {description = 'Y', data = 121},
            {description = 'Z', data = 122},
        },
        default = 120
    },

    {
        name = 'kkr_domain_skill',
        label = 'Field Button',
        hover = 'Set field button',
        options = {
            {description = 'A', data = 97},
            {description = 'B', data = 98},
            {description = 'C', data = 99},
            {description = 'D', data = 100},
            {description = 'E', data = 101},
            {description = 'F', data = 102},
            {description = 'G', data = 103},
            {description = 'H', data = 104},
            {description = 'I', data = 105},
            {description = 'J', data = 106},
            {description = 'K', data = 107},
            {description = 'L', data = 108},
            {description = 'M', data = 109},
            {description = 'N', data = 110},
            {description = 'O', data = 111},
            {description = 'P', data = 112},
            {description = 'Q', data = 113},
            {description = 'R', data = 114},
            {description = 'S', data = 115},
            {description = 'T', data = 116},
            {description = 'U', data = 117},
            {description = 'V', data = 118},
            {description = 'W', data = 119},
            {description = 'X', data = 120},
            {description = 'Y', data = 121},
            {description = 'Z', data = 122},
        },
        default = 122
    },
    AddTitle("Role Settings"),
    {
        name = 'kkr_atkmul',
        label = 'Attack multiplier',
        hover = 'Set initial attack multiplier',
        options = {
            {description = '150%', data = 1.5},
            {description = '130%', data = 1.3},
            {description = '125%', data = 1.25},
            {description = '100%', data = 1},
            {description = '75%', data = 0.75},
            {description = '50%', data = 0.5},
        },
        default = 1
    },
    {
        name = 'kkr_speedatkmul',
        label = 'Speed ​​​Attack Multiplier',
        hover = 'Set speed ​​​​boost attack multiplier',
        options = {
            {description = '1.0', data = 1},
            {description = '0.75', data = 0.75},
            {description = '0.5', data = 0.5},
        },
        default = 1
    },
    {
        name = 'kkr_domain_skill_enable',
        label = 'Magic Circle Skill',
        hover = 'Allow magic circle skill',
        options = {
            {description = 'Enable', data = true},
            {description = 'Disable', data = false}
        },
        default = true
    },
    {
        name = 'kkr_fly_skill_enable',
        label = 'Fly Skill',
        hover = 'Allow fly skill',
        options = {
            {description = 'Enable', data = true},
            {description = 'Disable', data = false}
        },
        default = true
    },
    {
        name = 'kkr_atkbuff_enable',
        label = 'Attack Buff',
        hover = 'Allow attack buff',
        options = {
            {description = 'Enable', data = true},
            {description = 'Disable', data = false}
        },
        default = true
    },
    AddTitle("Weapon Settings"),
    {
        name = 'kkr_lunge_enable',
        label = 'Spear Charge',
        hover = 'Allow spear charge skill',
        options = {
            {description = 'Enable', data = true},
            {description = 'Disable', data = false}
        },
        default = true
    },
}