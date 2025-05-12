local utils = require("utils")

local marbleChance = GetModConfigData("marbleChance", KnownModIndex:GetModActualName("More Drops JEM"))
local marbleAmount = GetModConfigData("marbleAmount", KnownModIndex:GetModActualName("More Drops JEM"))

local function ImproveMarble(inst)
	local oldonwork = inst.components.workable.onwork
		inst.components.workable.onwork = function(inst, worker, workleft, numworks)
		--Allow marble to spawn while mining
		utils.DropLootRandomWithAmount(inst, "marble", marbleChance, marbleAmount)
		oldonwork(inst, worker, workleft, numworks)
	end
end

return ImproveMarble