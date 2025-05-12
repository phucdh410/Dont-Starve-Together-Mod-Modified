local utils = require("utils")

local logChance = GetModConfigData("logChance", KnownModIndex:GetModActualName("More Drops JEM"))

local function ImproveTree(inst)
	--Do these when the tree is fully chopped
  local seed_chance  = GetModConfigData("treeseedchance", KnownModIndex:GetModActualName("More Drops JEM"))
  
	local oldonfinish = inst.components.workable.onfinish
	inst.components.workable:SetOnFinishCallback(function(inst, chopper)
		--Drop base logs
    if utils.LootRandom(logChance) then
		utils.DoTimes(GetModConfigData("extralogs", KnownModIndex:GetModActualName("More Drops JEM")), inst.components.lootdropper.SpawnLootPrefab, inst.components.lootdropper, "log")
	end	
		--Have a chance to spawn the appropriate seed item
		if inst.name == "Evergreen" and inst.components.growable.stage ~= 1 then
			if utils.DropLootRandom(inst, "pinecone", seed_chance) then print("Dropped seed") end
		elseif inst.name == "Birchnut Tree" and inst.components.growable.stage ~= 1 then
			if utils.DropLootRandom(inst, "acorn", seed_chance) then print("Dropped seed") end
    elseif inst.name == "Twiggy Tree" and inst.components.growable.stage ~= 1 then
      if utils.DropLootRandom(inst, "twiggy_nut", seed_chance) then print("Dropped seed") end
    end
		--Spawn extra logs for tall trees
		if inst.components.growable.stage == 3 and utils.LootRandom(logChance) then
			utils.DoTimes(GetModConfigData("extralogstall", KnownModIndex:GetModActualName("More Drops JEM")), inst.components.lootdropper.SpawnLootPrefab, inst.components.lootdropper, "log")
		end
		oldonfinish(inst, chopper)
	end)
end

return ImproveTree