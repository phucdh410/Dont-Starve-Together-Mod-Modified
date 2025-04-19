local assets =
{
	Asset( "ANIM", "anim/wonkey2.zip" ),
	Asset( "ANIM", "anim/ghost_wonkey2_build.zip" ),
}

local skins =
{
	normal_skin = "wonkey2",
	ghost_skin = "ghost_wonkey2_build",
}

return CreatePrefabSkin("wonkey2_none",
{
	base_prefab = "wonkey2",
	type = "base",
	assets = assets,
	skins = skins, 
	skin_tags = {"WONKEY2", "CHARACTER", "BASE"},
	build_name_override = "wonkey2",
	rarity = "Character",
})