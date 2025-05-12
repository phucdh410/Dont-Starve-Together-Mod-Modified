local utils = GLOBAL.require("utils")

local pickables = GLOBAL.require("pickables")
local boulders = GLOBAL.require("boulders")
local ImproveTree = GLOBAL.require("trees")
local ImproveGlacier = GLOBAL.require("glaciers")
local ImproveMarble = GLOBAL.require("marbles")
local ImproveCrop = GLOBAL.require("crops")

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
AddPrefabPostInit("marbleshrub_tall", utils.Bind(utils.RunFunctionServerOnly, ImproveMarble))

--Double crops received from farm
AddComponentPostInit("crop", utils.Bind(utils.RunFunctionServerOnly, ImproveCrop))