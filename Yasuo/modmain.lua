GLOBAL.setmetatable(env, {__index = function(t, k) return GLOBAL.rawget(GLOBAL, k)end})

PrefabFiles = {
    "yasuo_skills_fxs",
    "yasuo_sword",
    "yasuo",
    "yasuo_none",
    "yasuo_shield",
}

local mainfiles =
{
    "yasuo_tunings",
    "yasuo_stategraph",
    "yasuo_api",
    "yasuo_actions",
    "yasuo_rpc",
    "yasuo_ui",
    "yasuo_strings",
    "yasuo_recipes"
}

for _, file in ipairs(mainfiles) do
    modimport("main_scripts/" .. file)
end

Assets = {
    Asset("ANIM", "anim/yasuo_skills.zip"),
    Asset("ANIM", "anim/yasuo_skills_fx_build.zip"),
    Asset("ANIM", "anim/way_of_wander.zip"),

    Asset("IMAGE", "images/skills/yasuo_skills_bg.tex"),
    Asset("ATLAS", "images/skills/yasuo_skills_bg.xml"),
    Asset("IMAGE", "images/skills/way_of_wander.tex"),
    Asset("ATLAS", "images/skills/way_of_wander.xml"),
    Asset("IMAGE", "images/skills/steel_tempest.tex"),
    Asset("ATLAS", "images/skills/steel_tempest.xml"),
    Asset("IMAGE", "images/skills/steel_tempest_tornado.tex"),
    Asset("ATLAS", "images/skills/steel_tempest_tornado.xml"),
    Asset("IMAGE", "images/skills/wind_wall.tex"),
    Asset("ATLAS", "images/skills/wind_wall.xml"),
    Asset("IMAGE", "images/skills/sweeping_blade.tex"),
    Asset("ATLAS", "images/skills/sweeping_blade.xml"),
    Asset("IMAGE", "images/skills/last_breath.tex"),
    Asset("ATLAS", "images/skills/last_breath.xml"),
    Asset("IMAGE", "images/skills/yasuo_skills_btn_bg.tex"),
    Asset("ATLAS", "images/skills/yasuo_skills_btn_bg.xml"),

    Asset("SOUNDPACKAGE", "sound/yasuo.fev"),
    Asset("FILE", "sound/yasuo.fsb"),


    Asset( "IMAGE", "images/saveslot_portraits/yasuo.tex" ),     --存档头像
    Asset( "ATLAS", "images/saveslot_portraits/yasuo.xml" ),

	Asset( "IMAGE", "images/map_icons/yasuo.tex" ),              --小地图图标
	Asset( "ATLAS", "images/map_icons/yasuo.xml" ),

	Asset( "IMAGE", "images/avatars/avatar_yasuo.tex" ),         --tab键人物列表显示的头像
    Asset( "ATLAS", "images/avatars/avatar_yasuo.xml" ),

	Asset( "IMAGE", "images/avatars/avatar_ghost_yasuo.tex" ),   --tab键人物列表显示的头像（死亡）
    Asset( "ATLAS", "images/avatars/avatar_ghost_yasuo.xml" ),

	Asset( "IMAGE", "images/avatars/self_inspect_yasuo.tex" ),   --人物检查按钮的图片
    Asset( "ATLAS", "images/avatars/self_inspect_yasuo.xml" ),

	Asset( "IMAGE", "images/names_yasuo.tex" ),                  --人物名字
    Asset( "ATLAS", "images/names_yasuo.xml" ),

    Asset( "IMAGE", "bigportraits/yasuo_none.tex" ),             --人物大图（椭圆的那个）
    Asset( "ATLAS", "bigportraits/yasuo_none.xml" ),

    Asset( "IMAGE", "bigportraits/yasuo.tex" ),                  --人物大图（方的那个）
    Asset( "ATLAS", "bigportraits/yasuo.xml" ),
}

--选人界面
STRINGS.CHARACTER_TITLES.yasuo = "亚索"
STRINGS.CHARACTER_NAMES.yasuo = "亚索"
STRINGS.CHARACTER_DESCRIPTIONS.yasuo = "孤独的浪客\n精通疾风剑术"
STRINGS.CHARACTER_QUOTES.yasuo = "\"死亡如风，常伴吾身\""
STRINGS.CHARACTER_SURVIVABILITY.yasuo = "飘逸"
--台词包
STRINGS.CHARACTERS.YASUO = require "speech_wilson"
--游戏内名字
STRINGS.NAMES.YASUO = "亚索"
STRINGS.SKIN_NAMES.yasuo_none = "亚索"
--选择界面人物皮肤
local skin_modes = {
    {
        type = "ghost_skin",
        anim_bank = "ghost",
        idle_anim = "idle",
        scale = 0.75,
        offset = { 0, -25 }
    },
}

AddMinimapAtlas("images/map_icons/yasuo.xml")
AddModCharacter("yasuo", "MALE", skin_modes)

AddReplicableComponent("yasuo_skills")

