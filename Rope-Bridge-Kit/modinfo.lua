local L = locale ~= "zh" and locale ~= "zhr"
name = "地上绳索桥"
description = [[
    洞穴才能搭建的绳索桥现在也能在地上搭建了
    Cave rope bridges can now also be built on the ground
]]

author = "󰀈 Jack 󰀈" --作者

version = "Beta v0.0.1.3" --版本

forumthread = ""

api_version = 10 --mod是否过时，更新匹配版本

dst_compatible = true --是否和联机版兼容
dont_starve_compatible = false
reign_of_giants_compatible = false --是否和单机版兼容
hamlet_compatible = false 

forge_compatible = false

all_clients_require_mod = true --玩家进入必须拥有本mod，服务器mod为true

icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = {  --服务器确定mod标签
	"item" --物品
} 
priority = -10

configuration_options =
{
    {
        name = "rope_bridge_kit",
        label = "Rope Bridge Kit/绳索桥",
        hover =
        "洞穴的绳索桥可以在地上搭建 \n The rope bridge of the cave can be built on the ground",
        options = {
            { description = "默认/Default",  data = 8, hover = "8" },
            { description = "长/Long", data = 10 , hover = "10"} ,
            { description = "更长/Longer", data = 15 , hover = "15"} 
        },
        default = 8
    },
}