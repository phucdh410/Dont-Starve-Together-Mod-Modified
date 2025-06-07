name = "Yasuo - DHPModified"
description = [[
Original mod: https://steamcommunity.com/sharedfiles/filedetails/?id=3065307292&searchtext=%E4%BA%9A%E7%B4%A2
From update version: 18 Mar 2025

Death is like the wind — always by my side.
]]
author = "PhucDH410"
version = "1.0.0"

forumthread = ""

api_version = 10

dst_compatible = true
forge_compatible = true
gorge_compatible = true

dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false

all_clients_require_mod = true

icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = {
    "yasuo"
}

configuration_options = {
    {
        name = "yasuo_sound",
        label = "Yasuo Voice",
        hover = "Yasuo Voice",
        options = {
            {description = "Enable", data = true},
            {description = "Disable", data = false},
        },
        default = true,
    },
    {
        name = "damage_mult",
        label = "Damage Multiply",
        hover = "Damage Multiply (Abilities)",
        options = {
            {description = "25%", data = 0.25},
            {description = "50%", data = 0.5},
            {description = "100%", data = 1},
            {description = "150%", data = 1.5},
            {description = "200%", data = 2},
        },
        default = 1,
    },
    {
        name = "cooldown_mult",
        label = "Cooldown Multiply",
        hover = "Cooldown Multiply (Ablities without Forward Slash)",
        options = {
            {description = "25%", data = 0.25},
            {description = "50%", data = 0.5},
            {description = "100%", data = 1},
            {description = "150%", data = 1.5},
            {description = "200%", data = 2},
        },
        default = 1,
    },
    {
        name = "doskill_way",
        label = "Activation Skill Method",
        hover = "Activation Skill Method",
        options = {
            {description = "Keyboard", data = "only_key"},
            {description = "Mouse", data = "only_mouse"},
            {description = "Both", data = "all"},
        },
        default = "all",
    },
    {
        name = "steel_tempest_key",
        label = "Steel Tempest",
        hover = "Steel Tempest",
        options = {
            {description = "A", data = 97},
            {description = "B", data = 98},
            {description = "C", data = 99},
            {description = "D", data = 100},
            {description = "E", data = 101},
            {description = "F", data = 102},
            {description = "G", data = 103},
            {description = "H", data = 104},
            {description = "I", data = 105},
            {description = "J", data = 106},
            {description = "K", data = 107},
            {description = "L", data = 108},
            {description = "M", data = 109},
            {description = "N", data = 110},
            {description = "O", data = 111},
            {description = "P", data = 112},
            {description = "Q", data = 113},
            {description = "R", data = 114},
            {description = "S", data = 115},
            {description = "T", data = 116},
            {description = "U", data = 117},
            {description = "V", data = 118},
            {description = "W", data = 119},
            {description = "X", data = 120},
            {description = "Y", data = 121},
            {description = "Z", data = 122},
        },
        default = 122,
    },
    {
        name = "wind_wall_key",
        label = "Wind Wall",
        hover = "Wind Wall",
        options = {
            {description = "A", data = 97},
            {description = "B", data = 98},
            {description = "C", data = 99},
            {description = "D", data = 100},
            {description = "E", data = 101},
            {description = "F", data = 102},
            {description = "G", data = 103},
            {description = "H", data = 104},
            {description = "I", data = 105},
            {description = "J", data = 106},
            {description = "K", data = 107},
            {description = "L", data = 108},
            {description = "M", data = 109},
            {description = "N", data = 110},
            {description = "O", data = 111},
            {description = "P", data = 112},
            {description = "Q", data = 113},
            {description = "R", data = 114},
            {description = "S", data = 115},
            {description = "T", data = 116},
            {description = "U", data = 117},
            {description = "V", data = 118},
            {description = "W", data = 119},
            {description = "X", data = 120},
            {description = "Y", data = 121},
            {description = "Z", data = 122},
        },
        default = 120,
    },
    {
        name = "sweeping_blade_key",
        label = "Sweeping Blade",
        hover = "Sweeping Blade",
        options = {
            {description = "A", data = 97},
            {description = "B", data = 98},
            {description = "C", data = 99},
            {description = "D", data = 100},
            {description = "E", data = 101},
            {description = "F", data = 102},
            {description = "G", data = 103},
            {description = "H", data = 104},
            {description = "I", data = 105},
            {description = "J", data = 106},
            {description = "K", data = 107},
            {description = "L", data = 108},
            {description = "M", data = 109},
            {description = "N", data = 110},
            {description = "O", data = 111},
            {description = "P", data = 112},
            {description = "Q", data = 113},
            {description = "R", data = 114},
            {description = "S", data = 115},
            {description = "T", data = 116},
            {description = "U", data = 117},
            {description = "V", data = 118},
            {description = "W", data = 119},
            {description = "X", data = 120},
            {description = "Y", data = 121},
            {description = "Z", data = 122},
        },
        default = 103,
    },
    {
        name = "last_breath_key",
        label = "Last Breath",
        hover = "Last Breath",
        options = {
            {description = "A", data = 97},
            {description = "B", data = 98},
            {description = "C", data = 99},
            {description = "D", data = 100},
            {description = "E", data = 101},
            {description = "F", data = 102},
            {description = "G", data = 103},
            {description = "H", data = 104},
            {description = "I", data = 105},
            {description = "J", data = 106},
            {description = "K", data = 107},
            {description = "L", data = 108},
            {description = "M", data = 109},
            {description = "N", data = 110},
            {description = "O", data = 111},
            {description = "P", data = 112},
            {description = "Q", data = 113},
            {description = "R", data = 114},
            {description = "S", data = 115},
            {description = "T", data = 116},
            {description = "U", data = 117},
            {description = "V", data = 118},
            {description = "W", data = 119},
            {description = "X", data = 120},
            {description = "Y", data = 121},
            {description = "Z", data = 122},
        },
        default = 114,
    },
}