local utils = require("utils")

local moonglassChance = GetModConfigData("moonglassChance", KnownModIndex:GetModActualName("More Drops - DHPModified"))
local moonglassAmount = GetModConfigData("moonglassAmount", KnownModIndex:GetModActualName("More Drops - DHPModified"))

local function ImproveMoonglassRock(inst)
	local oldonwork = inst.components.workable.onwork
		inst.components.workable.onwork = function(inst, worker, workleft, numworks)
		utils.DropLootRandomWithAmount(inst, "moonglass", moonglassChance, moonglassAmount)
		oldonwork(inst, worker, workleft, numworks)
	end
end

return ImproveMoonglassRock