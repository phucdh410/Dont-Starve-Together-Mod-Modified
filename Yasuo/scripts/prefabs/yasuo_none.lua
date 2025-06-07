local assets =
{
	Asset( "ANIM", "anim/yasuo.zip" ),
	Asset( "ANIM", "anim/ghost_yasuo_build.zip" ),
}

local skins =
{
	normal_skin = "yasuo",
	ghost_skin = "ghost_yasuo_build",
}

return CreatePrefabSkin("yasuo_none",
{
	base_prefab = "yasuo",
	type = "base",
	assets = assets,
	skins = skins,
	skin_tags = {"YASUO", "CHARACTER", "BASE"},
	build_name_override = "yasuo",
	rarity = "Character",
})