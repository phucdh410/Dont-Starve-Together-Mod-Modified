local chinese = locale == "zh" or locale  == "zhr"

name = chinese and "高效农业" or "Efficient Agriculture"

description = chinese and "更高效的农业生产方式，解放生产力！是时候告别饥荒了"
    or "More efficient agricultural production methods, liberating productivity! Its time to say good-bye to starvation!"

author = "liximi"
version = "2.9.0"

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
    "高效农业",
}

configuration_options = {
    {
        name = "language",
        label = chinese and "语言" or "Language",
        hover = chinese and "设置语言" or "Set Language",
        options = {
            {description = "English", data = "ENGLISH"},
            {description = "中文", data = "CHINESE"},
            {description = "Auto/自动", data = "AUTO"}
        },
        default = "AUTO",
    },
    {
        name = "max_store_num",
        label = chinese and "最大存储数量" or "Max Storage Quantity",
        hover = chinese and "肥料机器最大可存储物品的数量" or "Max number of items that can be stored in the fertilizer machine",
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
        label = chinese and "价格系数" or "Coefficient of Price",
        hover = chinese and "自动贩卖机的兑换比例系数" or "Coefficient of vending machine exchange ratio",
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
        label = chinese and "贩卖机刷新频率" or "Vending Machine Refresh Frequency",
        hover = chinese and "自动贩卖机货物刷新频率(单位:天)" or "Vending machine refresh frequency (unit:day)",
        options = {
            {description = chinese and "1天" or "1 Day", data = 1},
            {description = chinese and "2天" or "2 Day", data = 2},
            {description = chinese and "3天" or "3 Day", data = 3},
            {description = chinese and "4天" or "4 Day", data = 4},
            {description = chinese and "5天" or "5 Day", data = 5},
        },
        default = 2,
    },
    {
        name = "harvest_machine",
        label = chinese and "启用自动收获机" or "Enable Harvest Machine",
        hover = chinese and "启用自动收获机" or "Enable Harvest Machine",
        options = {
            {description = chinese and "开启" or "Yes", data = true},
            {description = chinese and "关闭" or "No", data = false},
        },
        default = true,
    },
    {
        name = "harvest_machine_rotate_key",
        label = chinese and "收获机旋转按键" or "Harvester Rotation Key",
        hover = chinese and "在放置收获机时旋转其方向的按键" or "The key that rotates the direction of the harvester when placing it",
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
        label = chinese and "收获机检测时间间隔" or "Harvest Machine Check Interval",
        hover = chinese and "时间间隔越短，消耗的性能越大" or "The shorter the time interval, the greater the performance consumption",
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
        label = chinese and "启用自动播种机" or "Enable Seeding Machine",
        hover = chinese and "启用自动播种机" or "Enable Seeding Machine",
        options = {
            {description = chinese and "开启" or "Yes", data = true},
            {description = chinese and "关闭" or "No", data = false},
        },
        default = true,
    },
    {
        name = "vending_machine",
        label = chinese and "启用自动贩卖机" or "Enable Vending Machine",
        hover = chinese and "启用自动贩卖机" or "Enable Vending Machine",
        options = {
            {description = chinese and "开启" or "Yes", data = true},
            {description = chinese and "关闭" or "No", data = false},
        },
        default = true,
    },
    {
        name = "farm_plow_machine",
        label = chinese and "启用自动耕地机" or "Enable Plowing Machine",
        hover = chinese and "启用自动耕地机" or "Enable Plowing Machine",
        options = {
            {description = chinese and "开启" or "Yes", data = true},
            {description = chinese and "关闭" or "No", data = false},
        },
        default = true,
    },
    {
        name = "enable_harvest_machine_area_show",
        label = chinese and "启用自动收获机范围显示" or "Show Harvest Machine Range",
        hover = chinese and "启用自动收获机范围显示" or "Show Harvest Machine Range",
        options = {
            {description = chinese and "开启" or "Yes", data = true},
            {description = chinese and "关闭" or "No", data = false},
        },
        default = true,
    },
    {
        name = "enable_harvest_machine_auto_pickup",
        label = chinese and "启用自动收获机拾取物品" or "Enable Harvest Machine Auto Picking Up",
        hover = chinese and "启用后将自动拾取面前的农作物、种子和花瓣" or "Once enabled, it will automatically pick up crops, seeds, and petals in front of it",
        options = {
            {description = chinese and "开启" or "Yes", data = true},
            {description = chinese and "关闭" or "No", data = false},
        },
        default = true,
    },
}