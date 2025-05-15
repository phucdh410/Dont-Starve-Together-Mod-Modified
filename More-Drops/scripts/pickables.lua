local utils = require("utils")

local infinitefertilize = GetModConfigData("infinitefertilize", KnownModIndex:GetModActualName("More Drops - DHPModified"))

local pickables = {}

--Grass
pickables.ImproveGrass = function(inst)
	local grassChance = GetModConfigData("grassChance", KnownModIndex:GetModActualName("More Drops - DHPModified"))
	local grassAmount = GetModConfigData("grassAmount", KnownModIndex:GetModActualName("More Drops - DHPModified"))
  if utils.LootRandom(grassChance) then
		inst.components.pickable.numtoharvest = grassAmount + 1
	else
		inst.components.pickable.numtoharvest = 1
	end
  if infinitefertilize == true then
    inst.components.pickable.max_cycles = 9999999999
    inst.components.pickable.cycles_left = 9999999999
  end
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
  if infinitefertilize == true then
    inst.components.pickable.max_cycles = 9999999999
    inst.components.pickable.cycles_left = 9999999999
  end
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
	if infinitefertilize == true then
		inst.components.pickable.max_cycles = 9999999999
		inst.components.pickable.cycles_left = 9999999999
	end
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
	if infinitefertilize == true then
		inst.components.pickable.max_cycles = 9999999999
		inst.components.pickable.cycles_left = 9999999999
	end
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

	if infinitefertilize == true then
		inst.components.pickable.max_cycles = 9999999999
		inst.components.pickable.cycles_left = 9999999999
	end
end

-- Banana *** NEW FEATURE, TEST IS NECESSARY
pickables.ImproveBanana = function(inst)
	local bananaChance = GetModConfigData("bananaChance", KnownModIndex:GetModActualName("More Drops - DHPModified"))
	local bananaAmount = GetModConfigData("bananaAmount", KnownModIndex:GetModActualName("More Drops - DHPModified"))
	if utils.LootRandom(bananaChance) then
		inst.components.pickable.numtoharvest = bananaAmount + 1
	else
		inst.components.pickable.numtoharvest = 1
	end
	-- Because banana tree maybe not exist 2 these attributes
	if infinitefertilize == true and inst.components.pickable.max_cycles and inst.components.pickable.cycles_left then
		inst.components.pickable.max_cycles = 9999999999
		inst.components.pickable.cycles_left = 9999999999
	end
end


return pickables