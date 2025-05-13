local utils = require("utils")

local glacierChance = GetModConfigData("glacierChance", KnownModIndex:GetModActualName("More Drops - DHPModified"))
local glacierAmount = GetModConfigData("glacierAmount", KnownModIndex:GetModActualName("More Drops - DHPModified"))

local function ImproveGlacier(inst)
	local oldonwork = inst.components.workable.onwork
		inst.components.workable.onwork = function(inst, worker, workleft, numworks)
		--Allow ice to spawn while mining
		utils.DropLootRandomWithAmount(inst, "ice", glacierChance, glacierAmount)
		oldonwork(inst, worker, workleft, numworks)
	end
end

return ImproveGlacier