-- This information tells other players more about the mod
name = '芮塔'
description = '世界之花,即将绽放'
author = '丧芝，LUOXIA11，vandoordeep'
version = '0.5.4' -- This is the version of the template. Change it to your own number.

-- This is the URL name of the mod's thread on the forum; the part after the ? and before the first & in the url
forumthread = '/files/file/950-extended-sample-character/'

-- This lets other players know if your mod is out of date, update it to match the current version in the game
api_version = 10

-- Compatible with Don't Starve Together
dst_compatible = true

-- Not compatible with Don't Starve
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false

-- Character mods are required by all clients
all_clients_require_mod = true

icon_atlas = 'modicon.xml'
icon = 'modicon.tex'

-- The mod's tags displayed on the server list
server_filter_tags = {
    'character',
    '芮塔',
    'ruita',
    'Rui Ta'
}

configuration_options = {
    {
        name = 'xxx3_wf_producebutterfly',
        label = '蝴蝶生成',
        hover = '世界花是否生成蝴蝶',
        options = {
            {description = '是', data = true},
            {description = '否', data = false}
        },
        default = true
    },
    {
        name = 'xxx3_wf_producefirefly',
        label = '萤火虫生成',
        hover = '世界花是否生成萤火虫',
        options = {
            {description = '是', data = true},
            {description = '否', data = false}
        },
        default = true
    },
    {
        name = 'xxx3_wf_produceitem',
        label = '世界花掉落',
        hover = '世界花是否在每日清晨掉落物品',
        options = {
            {description = '是', data = true},
            {description = '否', data = false}
        },
        default = true
    },
    {
        name = 'xxx3_itemduring',
        label = '物品耐久',
        hover = '花束与各种眼球草花环是否有耐久',
        options = {
            {description = '是', data = true},
            {description = '否', data = false}
        },
        default = false
    },
    {
        name = 'xxx3_foodvalue',
        label = '食物属性',
        hover = '芮塔专属食物的回复效果',
        options = {
            {description = '大砍', data = 0.5},
            {description = '小削', data = 0.75},
            {description = '默认', data = 1},
            {description = '加强', data = 1.5},
            {description = '变态', data = 2}
        },
        default = 1
    }
}
