name = "Rope Bridge Kit - DHPModified"
description = [[
Original mod: https://steamcommunity.com/sharedfiles/filedetails/?id=3426512803&searchtext=%E5%9C%B0%E4%B8%8A%E7%BB%B3%E7%B4%A2%E6%A1%A5
From update version: 17 Feb 2025

Cave rope bridges can now also be built on the ground
]]

author = "PhucDH410" 

version = "1.0.0" 

forumthread = ""

api_version = 10 

dst_compatible = true 
dont_starve_compatible = false
reign_of_giants_compatible = false 
hamlet_compatible = false 

forge_compatible = false

all_clients_require_mod = true 

icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = {  
	"item" 
} 
priority = -10

configuration_options =
{
    {
        name = "rope_bridge_kit",
        label = "Bridge Length",
        hover =
        "The length of bridge can achieve",
        options = {
            { description = "Default",  data = 8, hover = "8" },
            { description = "Long", data = 10 , hover = "10"} ,
            { description = "Longer", data = 15 , hover = "15"} 
        },
        default = 8
    },
}