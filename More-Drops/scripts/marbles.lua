local utils = require("utils")

local marbleChance = GetModConfigData("marbleChance", KnownModIndex:GetModActualName("More Drops JEM - DHPModified"))
local marbleAmount = GetModConfigData("marbleAmount", KnownModIndex:GetModActualName("More Drops JEM - DHPModified"))
local marblebeanChance = GetModConfigData("marblebeanChance", KnownModIndex:GetModActualName("More Drops JEM - DHPModified"))
local marblebeanAmount = GetModConfigData("marblebeanAmount", KnownModIndex:GetModActualName("More Drops JEM - DHPModified"))

local function ImproveMarble(inst)
	local oldonfinish = inst.components.workable.onfinish
    inst.components.workable:SetOnFinishCallback(function(inst, worker)
      utils.DropLootRandomWithAmount(inst, "marble", marbleChance, marbleAmount)
      utils.DropLootRandomWithAmount(inst, "marblebean", marblebeanChance, marblebeanAmount)
			if oldonfinish then
				oldonfinish(inst, worker)
			end
    end)
end

return ImproveMarble