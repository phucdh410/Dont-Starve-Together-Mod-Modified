local utils = require("utils")

local pickables = {}

--Grass
pickables.ImproveGrass = function(inst)
	local grassChance = GetModConfigData("grassChance", KnownModIndex:GetModActualName("More Drops JEM"))
    if utils.LootRandom(grassChance) then
		inst.components.pickable.numtoharvest = GetModConfigData("grassamount", KnownModIndex:GetModActualName("More Drops JEM")) + 1
	else
		inst.components.pickable.numtoharvest = 1
	end
  if GetModConfigData("infinitefertilize", KnownModIndex:GetModActualName("More Drops JEM")) == true then
    inst.components.pickable.max_cycles = 9999999999
    inst.components.pickable.cycles_left = 9999999999
  end
end

--Sapling
pickables.ImproveSapling = function(inst)
	local twigChance = GetModConfigData("twigChance", KnownModIndex:GetModActualName("More Drops JEM"))
	if utils.LootRandom(twigChance) then
		inst.components.pickable.numtoharvest = GetModConfigData("twigamount", KnownModIndex:GetModActualName("More Drops JEM")) + 1
	else	
		inst.components.pickable.numtoharvest = 1
	end
  if GetModConfigData("infinitefertilize", KnownModIndex:GetModActualName("More Drops JEM")) == true then
    inst.components.pickable.max_cycles = 9999999999
    inst.components.pickable.cycles_left = 9999999999
  end
end

--Reeds
pickables.ImproveReeds = function(inst)
	local reedChance = GetModConfigData("reedChance", KnownModIndex:GetModActualName("More Drops JEM"))
	if utils.LootRandom(reedChance) then
		inst.components.pickable.numtoharvest = GetModConfigData("reedamount", KnownModIndex:GetModActualName("More Drops JEM")) + 1
	else
		inst.components.pickable.numtoharvest = 1
	end
	if GetModConfigData("infinitefertilize", KnownModIndex:GetModActualName("More Drops JEM")) == true then
		inst.components.pickable.max_cycles = 9999999999
		inst.components.pickable.cycles_left = 9999999999
	end
end

-- Berry Bushes
pickables.ImproveBerries = function(inst)
	local berryChance = GetModConfigData("berryChance", KnownModIndex:GetModActualName("More Drops JEM"))
	if utils.LootRandom(berryChance) then
		inst.components.pickable.numtoharvest = GetModConfigData("berryAmount", KnownModIndex:GetModActualName("More Drops JEM")) + 1
	else 
		inst.components.pickable.numtoharvest = 1
	end

	if GetModConfigData("infinitefertilize", KnownModIndex:GetModActualName("More Drops JEM")) == true then
		inst.components.pickable.max_cycles = 9999999999
		inst.components.pickable.cycles_left = 9999999999
	end
end

-- Juicy Berry Bushes
pickables.ImproveJuicy = function(inst)
	local berry_JuicyChance = GetModConfigData("berry_JuicyChance", KnownModIndex:GetModActualName("More Drops JEM"))
	if utils.LootRandom(berry_JuicyChance) then
		inst.components.pickable.numtoharvest = GetModConfigData("berry_JuicyAmount", KnownModIndex:GetModActualName("More Drops JEM")) + 3
	else
		inst.components.pickable.numtoharvest = 3
	end

	if GetModConfigData("infinitefertilize", KnownModIndex:GetModActualName("More Drops JEM")) == true then
		inst.components.pickable.max_cycles = 9999999999
		inst.components.pickable.cycles_left = 9999999999
	end
end


return pickables