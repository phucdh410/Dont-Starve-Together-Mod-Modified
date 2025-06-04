name = "Efficient Agriculture - DHPModified"

description = [[
Original mod: https://steamcommunity.com/sharedfiles/filedetails/?id=2303894106&searchtext=Efficient+Agriculture
From update version: 21 May 2025

More efficient agricultural production methods, liberating productivity! Its time to say good-bye to starvation!
]]

author = "PhucDH410"
version = "1.0.0"

forumthread = ""

dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = true
all_clients_require_mod=true

api_version = 10
priority = -9999

icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = {
    "Efficient Agriculture",
}

configuration_options = {
    {
        name = "max_store_num",
        label = "Max Storage Quantity",
        hover = "Max number of items that can be stored in the fertilizer machine",
        options = {
            {description = "20", data = 20},
            {description = "40", data = 40},
            {description = "60", data = 60},
            {description = "80", data = 80},
        },
        default = 20,
    },
    {
        name = "coefficient_of_price",
        label = "Coefficient of Price",
        hover = "Coefficient of vending machine exchange ratio",
        options = {
            {description = "0.5", data = 0.5},
            {description = "0.6", data = 0.6},
            {description = "0.8", data = 0.8},
            {description = "1.0", data = 1.0},
            {description = "1.1", data = 1.1},
            {description = "1.2", data = 1.2},
            {description = "1.3", data = 1.3},
            {description = "1.5", data = 1.5},
        },
        default = 1,
    },
    {
        name = "refresh_frequency",
        label = "Vending Machine Refresh Frequency",
        hover = "Vending machine refresh frequency (unit:day)",
        options = {
            {description = "1 Day", data = 1},
            {description = "2 Day", data = 2},
            {description = "3 Day", data = 3},
            {description = "4 Day", data = 4},
            {description = "5 Day", data = 5},
        },
        default = 2,
    },
    {
        name = "harvest_machine",
        label = "Enable Harvest Machine",
        hover = "Enable Harvest Machine",
        options = {
            {description = "Yes", data = true},
            {description = "No", data = false},
        },
        default = true,
    },
    {
        name = "harvest_machine_rotate_key",
        label = "Harvester Rotation Key",
        hover = "The key that rotates the direction of the harvester when placing it",
        options = {
            {description = "B", data = "B"},
            {description = "G", data = "G"},
            {description = "H", data = "H"},
            {description = "J", data = "J"},
            {description = "K", data = "K"},
            {description = "L", data = "L"},
            {description = "N", data = "N"},
            {description = "O", data = "O"},
            {description = "R", data = "R"},
            {description = "T", data = "T"},
            {description = "V", data = "V"},
            {description = "X", data = "X"},
            {description = "Z", data = "Z"},
        },
        default = "R",
    },
    {
        name = "harvest_machine_check_interval",
        label = "Harvest Machine Check Interval",
        hover = "The shorter the time interval, the greater the performance consumption",
        options = {
            {description = "4s", data = 4},
            {description = "5s", data = 5},
            {description = "8s", data = 8},
            {description = "10s", data = 10},
            {description = "15s", data = 15},
            {description = "30s", data = 30},
            {description = "60s", data = 60},
            {description = "90s", data = 90},
        },
        default = 4,
    },
    {
        name = "seeding_machine",
        label = "Enable Seeding Machine",
        hover = "Enable Seeding Machine",
        options = {
            {description = "Yes", data = true},
            {description = "No", data = false},
        },
        default = true,
    },
    {
        name = "vending_machine",
        label = "Enable Vending Machine",
        hover = "Enable Vending Machine",
        options = {
            {description = "Yes", data = true},
            {description = "No", data = false},
        },
        default = true,
    },
    {
        name = "farm_plow_machine",
        label = "Enable Plowing Machine",
        hover = "Enable Plowing Machine",
        options = {
            {description = "Yes", data = true},
            {description = "No", data = false},
        },
        default = true,
    },
    {
        name = "enable_harvest_machine_area_show",
        label = "Show Harvest Machine Range",
        hover = "Show Harvest Machine Range",
        options = {
            {description = "Yes", data = true},
            {description = "No", data = false},
        },
        default = true,
    },
    {
        name = "enable_harvest_machine_auto_pickup",
        label = "Enable Harvest Machine Auto Picking Up",
        hover = "Once enabled, it will automatically pick up crops, seeds, and petals in front of it",
        options = {
            {description = "Yes", data = true},
            {description = "No", data = false},
        },
        default = true,
    },
}