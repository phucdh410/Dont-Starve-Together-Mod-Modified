GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})
PrefabFiles = {
	"gembeans",
	"gem_crystal_clusters",
}

Assets = {	
}

local map_icons= {
	"blue","green","orange","purple","red","yellow","opalprecious",
}

TUNING.GEMCRYSTAL_COST = GetModConfigData("gemcost")
TUNING.GEMCRYSTAL_TIME = GetModConfigData("growtime")*480

local zhongwen = {
	blue = "Blue ",green = "Green ",orange = "Orange ",purple = "Purple ",
	red = "Red ",yellow = "Yellow ",opalprecious = "Opal "
}

for k,v in pairs(map_icons) do
	table.insert(Assets, Asset( "IMAGE", "images/minimap/gem_crystal_cluster_"..v..".tex" )) 
	table.insert(Assets, Asset( "ATLAS", "images/minimap/gem_crystal_cluster_"..v..".xml" ))
	AddMinimapAtlas("images/minimap/gem_crystal_cluster_"..v..'.xml')

	STRINGS.NAMES[string.upper("gembean_"..v)]= zhongwen[v].."Crystal Seed"
	STRINGS.RECIPE_DESC[string.upper("gembean_"..v)] = "Precious and Special"
	STRINGS.CHARACTERS.GENERIC.DESCRIBE[string.upper("gembean_"..v)] = "Precious and Special"

	STRINGS.NAMES[string.upper("gem_crystal_cluster_"..v)]= zhongwen[v].."Gem Crystal Cluster"
	STRINGS.CHARACTERS.GENERIC.DESCRIBE[string.upper("gem_crystal_cluster_"..v)] = "So Beautiful!"

	AddRecipe("gembean_"..v,
	{Ingredient("ice", 40),Ingredient(v.."gem", TUNING.GEMCRYSTAL_COST),Ingredient("moonglass", 10)},
	RECIPETABS.REFINE, TECH.CELESTIAL_THREE,
	nil, nil, true, nil, nil,
	"images/inventoryimages/gembean_"..v..".xml")
end
