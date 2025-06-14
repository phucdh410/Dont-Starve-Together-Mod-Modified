name = "AI_farmer_catseventh_fixing"
description = "会自己干活的农民,给他一个捕虫网就能帮你抓蝴蝶，给他一个锤子就不会再捡东西"
author = "oldfish & catseventh"
version = "5.2.5"
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
        name = "language",
        label = "language",
        options =
        {
            
            {description = "English", data = 1},
            {description = "中文", data = 2},
        },
        default = 2,
    },
    {
        name = "backpack_setting",
        label = "背包配置（backpack_setting）",
        options =
        {

            {description = "(正常)normal", data = 1},
            {description = "(保鲜)remain", data = 2},
            {description = "(反鲜)reverse", data = 3},
        },
        default = 3,
    },
    {
        name = "refresh_time",
        label = "农民死亡刷新时间（Renewal Time of Farmers'Death）",
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