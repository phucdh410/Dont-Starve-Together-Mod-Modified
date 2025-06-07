GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})
PrefabFiles = {
"fy_starmoonaltar",
"fy_StarMoonAltar_fx",
}
Assets = {
Asset( "ANIM", "anim/fy_StarMoonAltar_build.zip" ),
Asset( "ANIM", "anim/deluxe_firepit.zip" ),
Asset( "ANIM", "anim/deluxe_firepit_fire.zip" ),
Asset( "ANIM", "anim/endo_firepit.zip" ),
Asset( "ANIM", "anim/endo_firepit_fire.zip" ),
Asset( "ANIM", "anim/heat_star.zip" ),
Asset( "ANIM", "anim/heat_star_flame.zip" ),
Asset( "ANIM", "anim/ice_star.zip" ),
Asset( "ANIM", "anim/ice_star_flame.zip" ),
Asset( "IMAGE", "images/inventoryimages/fy_starmoonaltar.tex" ),
Asset( "ATLAS", "images/inventoryimages/fy_starmoonaltar.xml" ),
}
AddMinimapAtlas("images/inventoryimages/fy_starmoonaltar.xml")
AddRecipe2( 
"fy_starmoonaltar", {
-- Ingredient("shyerrylog", 1, "images/inventoryimages/shyerrylog.xml")
-- 制作配方晶洞果10彩虹宝石2电器元件4石砖10
Ingredient("townportaltalisman", 10), Ingredient("opalpreciousgem", 1), Ingredient("transistor", 4), Ingredient("cutstone", 10)
}, TECH.CELESTIAL_ONE, {
placer = "fy_starmoonaltar_placer",
atlas = "images/inventoryimages/fy_starmoonaltar.xml",
image = "fy_starmoonaltar.tex",
 min_spacing = .5,          -- 默认值或自定义值
-- nounlock = false,             -- 默认值或自定义值
-- numtogive = 1,                -- 默认值或自定义值
-- builder_tag = nil,            -- 默认值或自定义值
-- testfn = nil,                 -- 默认值或自定义值
-- product = "fy_StarMoonAltar", -- 默认值或自定义值
-- build_mode = BUILDMODE.LAND,  -- 默认值或自定义值
-- build_distance = 1            -- 默认值或自定义值
}, { "LIGHT"}
)
