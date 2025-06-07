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


    Asset( "IMAGE", "images/saveslot_portraits/yasuo.tex" ),     
    Asset( "ATLAS", "images/saveslot_portraits/yasuo.xml" ),

	Asset( "IMAGE", "images/map_icons/yasuo.tex" ),              
	Asset( "ATLAS", "images/map_icons/yasuo.xml" ),

	Asset( "IMAGE", "images/avatars/avatar_yasuo.tex" ),         
    Asset( "ATLAS", "images/avatars/avatar_yasuo.xml" ),

	Asset( "IMAGE", "images/avatars/avatar_ghost_yasuo.tex" ),   
    Asset( "ATLAS", "images/avatars/avatar_ghost_yasuo.xml" ),

	Asset( "IMAGE", "images/avatars/self_inspect_yasuo.tex" ),   
    Asset( "ATLAS", "images/avatars/self_inspect_yasuo.xml" ),

	Asset( "IMAGE", "images/names_yasuo.tex" ),                  
    Asset( "ATLAS", "images/names_yasuo.xml" ),

    Asset( "IMAGE", "bigportraits/yasuo_none.tex" ),             
    Asset( "ATLAS", "bigportraits/yasuo_none.xml" ),

    Asset( "IMAGE", "bigportraits/yasuo.tex" ),                  
    Asset( "ATLAS", "bigportraits/yasuo.xml" ),
}


STRINGS.CHARACTER_TITLES.yasuo = "Yasuo"
STRINGS.CHARACTER_NAMES.yasuo = "Yasuo"
STRINGS.CHARACTER_DESCRIPTIONS.yasuo = "An Ionian of deep resolve, Yasuo is an agile swordsman who wields the air itself against his enemies"
STRINGS.CHARACTER_QUOTES.yasuo = "Death is like the wind — always by my side"
STRINGS.CHARACTER_SURVIVABILITY.yasuo = "Elegant"

STRINGS.CHARACTERS.YASUO = require "speech_wilson"

STRINGS.NAMES.YASUO = "Yasuo"
STRINGS.SKIN_NAMES.yasuo_none = "Yasuo"

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

