local utils = GLOBAL.require("utils")

local pickables = GLOBAL.require("pickables")
local boulders = GLOBAL.require("boulders")
local ImproveTree = GLOBAL.require("trees")
local ImproveGlacier = GLOBAL.require("glaciers")
local ImproveMarble = GLOBAL.require("marbles")
local ImproveCrop = GLOBAL.require("crops")
local ImproveBirdcage = GLOBAL.require("birdcage")
local ImproveBeebox = GLOBAL.require("beebox")
local ImproveNightmareFuel = GLOBAL.require("nightmare-fuel")
local ImproveTreeguard = GLOBAL.require("treeguard")
local ImproveLobster = GLOBAL.require("lobster")
local ImproveVoltgoat = GLOBAL.require("voltgoat")
local ImproveGlommer = GLOBAL.require("glommer")
local ImproveTallbird = GLOBAL.require("tallbird")
local ImproveBeequeen = GLOBAL.require("beequeen")

-- gives math.random a random seed to use every time it runs, so that results are more random
utils.setSeed()

--Increase grass drops
AddPrefabPostInit("grass", utils.Bind(utils.RunFunctionServerOnly, pickables.ImproveGrass))
--Increase sapling drops
AddPrefabPostInit("sapling", utils.Bind(utils.RunFunctionServerOnly, pickables.ImproveSapling))
--Increase reed drops
AddPrefabPostInit("reeds", utils.Bind(utils.RunFunctionServerOnly, pickables.ImproveReeds))
--Increase berry drops
AddPrefabPostInit("berrybush", utils.Bind(utils.RunFunctionServerOnly, pickables.ImproveBerries))
AddPrefabPostInit("berrybush2", utils.Bind(utils.RunFunctionServerOnly, pickables.ImproveBerries))
--Increase Juicy Berry Drops
AddPrefabPostInit("berrybush_juicy", utils.Bind(utils.RunFunctionServerOnly, pickables.ImproveJuicy))
--Increase banana drops
AddPrefabPostInit("bananabush", utils.Bind(utils.RunFunctionServerOnly, pickables.ImproveBanana))
AddPrefabPostInit("cave_banana_tree", utils.Bind(utils.RunFunctionServerOnly, pickables.ImproveBanana))
--Increase mushroom drops (red, blue, green)
AddPrefabPostInit("red_mushroom", utils.Bind(utils.RunFunctionServerOnly, pickables.ImproveMushroom))
AddPrefabPostInit("blue_mushroom", utils.Bind(utils.RunFunctionServerOnly, pickables.ImproveMushroom))
AddPrefabPostInit("green_mushroom", utils.Bind(utils.RunFunctionServerOnly, pickables.ImproveMushroom))
--Increase kelp Drops
AddPrefabPostInit("bullkelp_plant", utils.Bind(utils.RunFunctionServerOnly, pickables.ImproveKelp))

--Add resources from trees
local trees = {"evergreen", "evergreen_sparse", "deciduoustree", "twiggytree"}
for i,v in pairs(trees) do
	AddPrefabPostInit(v, utils.Bind(utils.RunFunctionServerOnly, ImproveTree))
end

--Increase resources from boulders
local boulder_types = {"rock1", "rock_flintless", "rock_flintless_med", "rock_flintless_low"}
for i, v in pairs(boulder_types) do
	AddPrefabPostInit(v, utils.Bind(utils.RunFunctionServerOnly, boulders.ImproveRock))
end
--Gold boulders and moon rocks are special cases
AddPrefabPostInit("rock2", utils.Bind(utils.RunFunctionServerOnly, boulders.ImproveGold))
AddPrefabPostInit("rock_moon", utils.Bind(utils.RunFunctionServerOnly, boulders.ImproveMoon))

--Increase ice from mini glaciers
AddPrefabPostInit("rock_ice", utils.Bind(utils.RunFunctionServerOnly, ImproveGlacier))

--Increase marble from marble shrubs
AddPrefabPostInit("marbleshrub", utils.Bind(utils.RunFunctionServerOnly, ImproveMarble))

--Double crops received from farm
AddComponentPostInit("crop", utils.Bind(utils.RunFunctionServerOnly, ImproveCrop))

--Bonus for birdcage
AddPrefabPostInit("birdcage", utils.Bind(utils.RunFunctionServerOnly, ImproveBirdcage))

--Bonus for beebox
AddPrefabPostInit("beebox", utils.Bind(utils.RunFunctionServerOnly, ImproveBeebox))
AddPrefabPostInit("beebox_hermit", utils.Bind(utils.RunFunctionServerOnly, ImproveBeebox))

--Bonus for nightmare fuel
AddPrefabPostInit("crawlinghorror", utils.Bind(utils.RunFunctionServerOnly, ImproveNightmareFuel))
AddPrefabPostInit("terrorbeak", utils.Bind(utils.RunFunctionServerOnly, ImproveNightmareFuel))

--Bonus for treeguard
AddPrefabPostInit("leif", utils.Bind(utils.RunFunctionServerOnly, ImproveTreeguard))
AddPrefabPostInit("leif_sparse", utils.Bind(utils.RunFunctionServerOnly, ImproveTreeguard))

--Bonus for wobster
AddPrefabPostInit("wobster_sheller", utils.Bind(utils.RunFunctionServerOnly, ImproveLobster))

--Bonus for voltgoat
AddPrefabPostInit("lightninggoat", utils.Bind(utils.RunFunctionServerOnly, ImproveVoltgoat))

--Bonus for glommer
AddPrefabPostInit("glommer", utils.Bind(utils.RunFunctionServerOnly, ImproveGlommer))

--Bonus for tallbird
AddPrefabPostInit("tallbird", utils.Bind(utils.RunFunctionServerOnly, ImproveTallbird))

