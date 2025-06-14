name = "AI Farmer - DHPModified"
description = [[
Original mod: https://steamcommunity.com/sharedfiles/filedetails/?id=3244792939
From update version: 12 May 2024
]]
author = "PhucDH410"
version = "1.0.0"
api_version = 6
api_version_dst = 10
dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
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

            {description = "Normal", data = 1},
            {description = "Remain", data = 2},
            {description = "Reverse", data = 3},
        },
        default = 3,
    },
    {
        name = "refresh_time",
        label = "Revival Time",
        hover = "Revival time of farmer's death",
        options =
        {
            {description = "1", data = 1},
            {description = "2", data = 2},
            {description = "3", data = 3},
            {description = "4", data = 4},
            {description = "5", data = 5},
        },
        default = 1,
    },
}