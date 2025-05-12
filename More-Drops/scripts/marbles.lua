local utils = require("utils")

local marbleChance = GetModConfigData("marbleChance", KnownModIndex:GetModActualName("More Drops JEM"))
local marbleAmount = GetModConfigData("marbleAmount", KnownModIndex:GetModActualName("More Drops JEM"))
local marblebeanChance = GetModConfigData("marblebeanChance", KnownModIndex:GetModActualName("More Drops JEM"))
local marblebeanAmount = GetModConfigData("marblebeanAmount", KnownModIndex:GetModActualName("More Drops JEM"))

local function ImproveMarble(inst)
	local oldonwork = inst.components.workable.onwork
		inst.components.workable.onwork = function(inst, worker, workleft, numworks)
		--Allow marble to spawn while mining
		utils.DropLootRandomWithAmount(inst, "marble", marbleChance, marbleAmount)
		oldonwork(inst, worker, workleft, numworks)
	end

	local oldonfinish = inst.components.workable.onfinish
    inst.components.workable:SetOnFinishCallback(function(inst, worker)
      utils.DropLootRandomWithAmount(inst, "marblebean", marblebeanChance, marblebeanAmount)
      oldonfinish(inst, worker)
    end)
end

return ImproveMarble