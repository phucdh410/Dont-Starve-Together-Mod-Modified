local isCh = locale == 'zh' or locale == 'zhr' --是否为中文
-- This information tells other players more about the mod
name = isCh and "可可萝" or "Natsume Kokkoro"
description = [[可可萝
《公主连接Re:Dive》中的角色  CV:伊藤美来

mod正处于起步阶段，后续会有更多内容哦
目前可能仍然存在部分小问题，请积极反馈
如果喜欢这个mod，请务必好评，订阅，分享，支持一下作者！
Mod交流群：935957419
]]
author = "槐answer&迷子"
version = "2.7.2.1"

-- This is the URL name of the mod's thread on the forum; the part after the ? and before the first & in the url
forumthread = ""


-- This lets other players know if your mod is out of date, update it to match the current version in the game
api_version = 10

-- Compatible with Don't Starve Together
dst_compatible = true

-- Not compatible with Don't Starve
dont_starve_compatible = false
reign_of_giants_compatible = false

-- Character mods need this set to true
all_clients_require_mod = true 

icon_atlas = "modicon.xml"
icon = "modicon.tex"


-- The mod's tags displayed on the server list
server_filter_tags = {
    "character",
    "pcr",
    "Kokkoro",
    "kkr",
    "可可萝",
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
    AddTitle("基础设置"),
    {
        name = 'Language',
        label = '语言',
        hover = '设置mod所使用的语言',
        options = {
            {description = '中文', data = true},
            {description = '英文', data = false}
        },
        default = true
    },
    AddTitle("技能按键设置"),
    {
        name = 'kkr_fly_skill',
        label = '飞行按键',
        hover = '设置飞行按键',
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
        label = '领域按键',
        hover = '设置领域按键',
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
    AddTitle("角色设置"),
    {
        name = 'kkr_atkmul',
        label = '初始攻击倍率',
        hover = '设置角色初始攻击倍率',
        options = {
            {description = '1.5', data = 1.5},
            {description = '1.3', data = 1.3},
            {description = '1.25', data = 1.25},
            {description = '1.0', data = 1},
            {description = '0.75', data = 0.75},
            {description = '0.5', data = 0.5},
        },
        default = 1
    },
    {
        name = 'kkr_speedatkmul',
        label = '移速增益的攻击倍率',
        hover = '设置移速增益的攻击倍率',
        options = {
            {description = '1.0', data = 1},
            {description = '0.75', data = 0.75},
            {description = '0.5', data = 0.5},
        },
        default = 1
    },
    {
        name = 'kkr_domain_skill_enable',
        label = '法阵技能是否保留',
        hover = '设置法阵技能是否保留',
        options = {
            {description = '保留', data = true},
            {description = '不保留', data = false}
        },
        default = true
    },
    {
        name = 'kkr_fly_skill_enable',
        label = '飞行技能是否保留',
        hover = '设置飞行技能是否保留',
        options = {
            {description = '保留', data = true},
            {description = '不保留', data = false}
        },
        default = true
    },
    {
        name = 'kkr_atkbuff_enable',
        label = '攻击增加移速是否保留',
        hover = '设置攻击增加移速是否保留',
        options = {
            {description = '保留', data = true},
            {description = '不保留', data = false}
        },
        default = true
    },
    AddTitle("武器设置"),
    {
        name = 'kkr_lunge_enable',
        label = '长枪冲刺是否保留',
        hover = '设置长枪冲刺是否保留',
        options = {
            {description = '保留', data = true},
            {description = '不保留', data = false}
        },
        default = true
    },
}