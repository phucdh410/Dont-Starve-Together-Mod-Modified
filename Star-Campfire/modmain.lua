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
Ingredient("townportaltalisman", 10), Ingredient("ice", 20), Ingredient("boards", 20), Ingredient("transistor", 4), Ingredient("cutstone", 10)
}, TECH.CELESTIAL_ONE, {
placer = "fy_starmoonaltar_placer",
atlas = "images/inventoryimages/fy_starmoonaltar.xml",
image = "fy_starmoonaltar.tex",
 min_spacing = .5,
}, { "LIGHT"}
)
