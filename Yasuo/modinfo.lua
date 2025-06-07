name = "疾风剑豪·亚索"
description = "感谢万万（万万沃姆沃德），亚索都是他画的，只有风墙是我自己画的~".."\n".."tips:所有技能释放需要装备专属武器。".."\n"..
"亚索的设定80%与原版相同，但也做了一部分调整。".."\n"..
"1.关于原版的暴击率与暴击伤害全部取消，因为觉得暴击对于饥荒来说不是一个有趣的属性。".."\n"..
"2.被动的护盾在第一次受到伤害后就会完全移除，而不是像原版一样可以短暂存在一段时间。".."\n"..
"3.技能【踏前斩】和【斩钢闪】的组合环状出剑在饥荒中并不适用（E、Q技能正好被占用，且【斩钢闪】是用鼠标右键释放），所以修改为【斩钢闪】2层旋风烈斩效果且冷却完毕后的下一次【踏前斩】自动呈环状并且是沿途的敌人都可以击飞。".."\n"..
"2024.9.21 0:26更新：调整亚索武器伤害为51；调整亚索生命值为200；调整亚索R技能狂风绝息斩冷却时间为默认30秒；修复了E技能踏前斩位移不一致的bug；修复了Q技能斩钢闪鼠标释放不计入cd的bug；不知道有没有修复R技能造成的生物无法掉到地面的bug".."\n"..
"2025.2.22 11:16更新：大概修复了玩到后期特别卡的情况，以及修改了亚索的名字贴图，把亚索的幻影换成新版沃比的幻影方式了。".."\n"..
"加入QQ群反馈BUG或者提一下建议哦~群号892328804"
author = "老杨"
version = "1.1.2"

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
        label = "亚索语音",
        hover = "亚索语音",
        options = {
            {description = "开启", data = true},
            {description = "关闭", data = false},
        },
        default = true,
    },
    {
        name = "damage_mult",
        label = "伤害系数",
        hover = "伤害系数（所有技能的伤害）",
        options = {
            {description = "极低（0.25倍）", data = 0.25},
            {description = "较低（0.5倍）", data = 0.5},
            {description = "默认（1倍）", data = 1},
            {description = "较高（1.5倍）", data = 1.5},
            {description = "极高（2倍）", data = 2},
        },
        default = 1,
    },
    {
        name = "cooldown_mult",
        label = "冷却缩减",
        hover = "冷却缩减（除踏前斩外其他技能的冷却时间）",
        options = {
            {description = "极快（0.25倍）", data = 0.25},
            {description = "较快（0.5倍）", data = 0.5},
            {description = "默认（1倍）", data = 1},
            {description = "较慢（1.5倍）", data = 1.5},
            {description = "极慢（2倍）", data = 2},
        },
        default = 1,
    },
    {
        name = "doskill_way",
        label = "技能释放方式",
        hover = "【踏前斩】技能释放方式",
        options = {
            {description = "只能使用按键", data = "only_key"},
            {description = "只能使用鼠标右键", data = "only_mouse"},
            {description = "按键和鼠标右键都可以", data = "all"},
        },
        default = "all",
    },
    {
        name = "steel_tempest_key",
        label = "【斩钢闪】技能按键",
        hover = "【斩钢闪】技能按键",
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
        label = "【风之障壁】技能按键",
        hover = "【风之障壁】技能按键（这个技能按键不好挑，你们随意）",
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
        label = "【踏前斩】技能按键",
        hover = "【踏前斩】技能按键（鼠标右键物体也可以释放）",
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
        label = "【狂风绝息斩】技能按键",
        hover = "【狂风绝息斩】技能按键（这不把R键扣烂？）",
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