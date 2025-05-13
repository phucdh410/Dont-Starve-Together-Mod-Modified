local utils = require("utils")

local boulders = {}
local rockChance = GetModConfigData("rockChance", KnownModIndex:GetModActualName("More Drops - DHPModified"))
local flintChance = GetModConfigData("flintChance", KnownModIndex:GetModActualName("More Drops - DHPModified"))
local specialChance = GetModConfigData("specialChance", KnownModIndex:GetModActualName("More Drops - DHPModified"))
local redChance = GetModConfigData("redChance", KnownModIndex:GetModActualName("More Drops - DHPModified"))
local blueChance = GetModConfigData("blueChance", KnownModIndex:GetModActualName("More Drops - DHPModified"))
local purpleChance = GetModConfigData("purpleChance", KnownModIndex:GetModActualName("More Drops - DHPModified"))
local orangeChance = GetModConfigData("orangeChance", KnownModIndex:GetModActualName("More Drops - DHPModified"))
local yellowChance = GetModConfigData("yellowChance", KnownModIndex:GetModActualName("More Drops - DHPModified"))
local greenChance = GetModConfigData("greenChance", KnownModIndex:GetModActualName("More Drops - DHPModified"))

boulders.ImproveRock = function(inst)
	--Do these for each swing
	local oldonwork = inst.components.workable.onwork
	inst.components.workable.onwork = function(inst, worker, workleft)
		--Allow rocks, flint, and nitre to spawn while mining (Added Gems - Amnesiac)
		utils.DropLootRandom(inst, "rocks", rockChance)
		utils.DropLootRandom(inst, "flint", flintChance)
		utils.DropLootRandom(inst, "nitre", specialChance)
		utils.DropLootRandom(inst, "redgem", redChance)
		utils.DropLootRandom(inst, "bluegem", blueChance)
		utils.DropLootRandom(inst, "purplegem", purpleChance)
		utils.DropLootRandom(inst, "orangegem", orangeChance)
		utils.DropLootRandom(inst, "yellowgem", yellowChance)
		utils.DropLootRandom(inst, "greengem", greenChance)
		oldonwork(inst, worker, workleft)
	end
	--Do these for each full mine
	inst.components.workable:SetOnFinishCallback(function(inst, worker)
		utils.GiveLootRandomPick(worker, {"redgem", "bluegem", "purplegem", "orangegem", "yellowgem", "greengem"}, {0.0002, 0.0004, 0.0002, 0.0001, 0.0001, 0.0002})
    print("Done mining.")
	end)
end

boulders.ImproveGold = function(inst)
	--Do these for each swing
	local oldonwork = inst.components.workable.onwork
	inst.components.workable.onwork = function(inst, worker, workleft)
		--Allow rocks, flint, and gold to spawn while mining (Added Gems - Amnesiac)
		utils.DropLootRandom(inst, "rocks", rockChance)
		utils.DropLootRandom(inst, "flint", flintChance)
		utils.DropLootRandom(inst, "goldnugget", specialChance)
		utils.DropLootRandom(inst, "redgem", redChance)
		utils.DropLootRandom(inst, "bluegem", blueChance)
		utils.DropLootRandom(inst, "purplegem", purpleChance)
		utils.DropLootRandom(inst, "orangegem", orangeChance)
		utils.DropLootRandom(inst, "yellowgem", yellowChance)
		utils.DropLootRandom(inst, "greengem", greenChance)
		oldonwork(inst, worker, workleft)
	end
end

boulders.ImproveMoon = function(inst)
	--Do these for each swing
	local oldonwork = inst.components.workable.onwork
	inst.components.workable.onwork = function(inst, worker, workleft)
		--Allow rocks, flint, and gold to spawn while mining
		utils.DropLootRandom(inst, "rocks", rockChance)
		utils.DropLootRandom(inst, "flint", flintChance)
		utils.DropLootRandom(inst, "moonrocknugget", specialChance)
		utils.DropLootRandom(inst, "redgem", redChance)
		utils.DropLootRandom(inst, "bluegem", blueChance)
		utils.DropLootRandom(inst, "purplegem", purpleChance)
		utils.DropLootRandom(inst, "orangegem", orangeChance)
		utils.DropLootRandom(inst, "yellowgem", yellowChance)
		utils.DropLootRandom(inst, "greengem", greenChance)
		oldonwork(inst, worker, workleft)
	end
end

return boulders