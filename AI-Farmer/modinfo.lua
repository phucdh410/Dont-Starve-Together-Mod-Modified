name = "AI Farmer - DHPModified"
description = [[
A.I Farmer

Feature:
- Pickup (sapling, grass, ...)
- Harvest (Berrybush, Beebox at full, Farm's product)
- Chop tree and replant it
- Mining rocks
- Auto fertilize farm and other plants (grass, berrybush)

***IMPORTANT: If you want to destroy the home, make sure to take all everything from the farmer's backpack first, as the farmer will be destroyed along with the home.
]]
author = "PhucDH410"

version = "1.0.0"

api_version = 10

dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = true
all_clients_require_mod = true 

icon_atlas = "images/modicon.xml"
icon = "modicon.tex"

forumthread = ""

server_filter_tags = {
	"pet",
	"creature",
	"autopick",
}

configuration_options = {
    {
        name = "backpack_setting",
        label = "Backpack Setting",
        options =
        {

            {description = "Normal", data = 1, hover = "Food spoils over time like basic game"},
            {description = "Remain", data = 2, hover = "Food keeps freeze its fresh rate"},
            {description = "Reverse", data = 3, hover = "Food reverse fress over time"},
        },
        default = 3,
    },
    {
        name = "refresh_time",
        label = "Revival Day",
        hover = "Revival day of farmer",
        options =
        {

            {description = "1", data = 1, hover = "When died, your farmer needs 1 day to comeback"},
            {description = "2", data = 2, hover = "When died, your farmer needs 2 day to comeback"},
            {description = "3", data = 3, hover = "When died, your farmer needs 3 day to comeback"},
            {description = "4", data = 4, hover = "When died, your farmer needs 4 day to comeback"},
            {description = "5", data = 5, hover = "When died, your farmer needs 5 day to comeback"},
        },
        default = 1,
    },
}