local utils = require("utils")

local function ImproveGlacier(inst)
	local oldonwork = inst.components.workable.onwork
		inst.components.workable.onwork = function(inst, worker, workleft, numworks)
		--Allow ice to spawn while mining
		utils.DropLootRandom(inst, "ice", .1)
		oldonwork(inst, worker, workleft, numworks)
	end
end

return ImproveGlacier