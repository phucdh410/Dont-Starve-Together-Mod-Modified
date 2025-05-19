local utils = require("utils")

local infinitefertilize = GetModConfigData("infinitefertilize", KnownModIndex:GetModActualName("More Drops - DHPModified"))

local pickables = {}

local function FertilizedInfinite(inst)
	if infinitefertilize == true then
    inst.components.pickable.max_cycles = 9999999999
    inst.components.pickable.cycles_left = 9999999999
  end
end

--Grass
pickables.ImproveGrass = function(inst)
	local grassChance = GetModConfigData("grassChance", KnownModIndex:GetModActualName("More Drops - DHPModified"))
	local grassAmount = GetModConfigData("grassAmount", KnownModIndex:GetModActualName("More Drops - DHPModified"))
  if utils.LootRandom(grassChance) then
		inst.components.pickable.numtoharvest = grassAmount + 1
	else
		inst.components.pickable.numtoharvest = 1
	end
  FertilizedInfinite(inst)
end

--Sapling
pickables.ImproveSapling = function(inst)
	local twigChance = GetModConfigData("twigChance", KnownModIndex:GetModActualName("More Drops - DHPModified"))
	local twigAmount = GetModConfigData("twigAmount", KnownModIndex:GetModActualName("More Drops - DHPModified"))
	if utils.LootRandom(twigChance) then
		inst.components.pickable.numtoharvest = twigAmount + 1
	else	
		inst.components.pickable.numtoharvest = 1
	end
  FertilizedInfinite(inst)
end

--Reeds
pickables.ImproveReeds = function(inst)
	local reedChance = GetModConfigData("reedChance", KnownModIndex:GetModActualName("More Drops - DHPModified"))
	local reedAmount = GetModConfigData("reedAmount", KnownModIndex:GetModActualName("More Drops - DHPModified"))
	if utils.LootRandom(reedChance) then
		inst.components.pickable.numtoharvest = reedAmount + 1
	else
		inst.components.pickable.numtoharvest = 1
	end
	FertilizedInfinite(inst)
end

-- Berry Bushes
pickables.ImproveBerries = function(inst)
	local berryChance = GetModConfigData("berryChance", KnownModIndex:GetModActualName("More Drops - DHPModified"))
	local berryAmount = GetModConfigData("berryAmount", KnownModIndex:GetModActualName("More Drops - DHPModified"))
	if utils.LootRandom(berryChance) then
		inst.components.pickable.numtoharvest = berryAmount + 1
	else 
		inst.components.pickable.numtoharvest = 1
	end
	FertilizedInfinite(inst)
end

-- Juicy Berry Bushes
pickables.ImproveJuicy = function(inst)
	local berry_JuicyChance = GetModConfigData("berry_JuicyChance", KnownModIndex:GetModActualName("More Drops - DHPModified"))
	local berry_JuicyAmount = GetModConfigData("berry_JuicyAmount", KnownModIndex:GetModActualName("More Drops - DHPModified"))
	if utils.LootRandom(berry_JuicyChance) then
		inst.components.pickable.numtoharvest = berry_JuicyAmount + 3
	else
		inst.components.pickable.numtoharvest = 3
	end
	FertilizedInfinite(inst)
end
-- //TODO
-- Banana *** NEW FEATURE, TEST IS NECESSARY
pickables.ImproveBanana = function(inst)
	local bananaChance = GetModConfigData("bananaChance", KnownModIndex:GetModActualName("More Drops - DHPModified"))
	local bananaAmount = GetModConfigData("bananaAmount", KnownModIndex:GetModActualName("More Drops - DHPModified"))
	if utils.LootRandom(bananaChance) then
		inst.components.pickable.numtoharvest = bananaAmount + 1
	else
		inst.components.pickable.numtoharvest = 1
	end
	FertilizedInfinite(inst)
end
-- //TODO
-- Mushroom *** NEW FEATURE, TEST IS NECESSARY
pickables.ImproveMushroom = function(inst)
	local mushroomChance = GetModConfigData("mushroomChance", KnownModIndex:GetModActualName("More Drops - DHPModified"))
	local mushroomAmount = GetModConfigData("mushroomAmount", KnownModIndex:GetModActualName("More Drops - DHPModified"))
	if utils.LootRandom(mushroomChance) then
		inst.components.pickable.numtoharvest = mushroomAmount + 1
	else
		inst.components.pickable.numtoharvest = 1
	end
	FertilizedInfinite(inst)
end

return pickables