local utils = require("utils")

local marbleChance = GetModConfigData("marbleChance", KnownModIndex:GetModActualName("More Drops JEM - DHPModified"))
local marbleAmount = GetModConfigData("marbleAmount", KnownModIndex:GetModActualName("More Drops JEM - DHPModified"))
local marblebeanChance = GetModConfigData("marblebeanChance", KnownModIndex:GetModActualName("More Drops JEM - DHPModified"))
local marblebeanAmount = GetModConfigData("marblebeanAmount", KnownModIndex:GetModActualName("More Drops JEM - DHPModified"))

local function ImproveMarble(inst)
	local oldonfinish = inst.components.workable.onfinish
    inst.components.workable:SetOnFinishCallback(function(inst, worker)
      --Drop more marbles
      if utils.LootRandom(marbleChance) then
        utils.DoTimes(marbleAmount, inst.components.lootdropper.SpawnLootPrefab, inst.components.lootdropper, "marble")
      end
      
      if inst.components.growable.stage ~= 1 and utils.LootRandom(marblebeanChance) then
        utils.DoTimes(marblebeanAmount, inst.components.lootdropper.SpawnLootPrefab, inst.components.lootdropper, "marblebean")
      end
			if oldonfinish then
				oldonfinish(inst, worker)
			end
    end)
end

return ImproveMarble