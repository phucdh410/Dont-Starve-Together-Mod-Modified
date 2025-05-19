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
local thuleciteChance = GetModConfigData("thuleciteChance", KnownModIndex:GetModActualName("More Drops - DHPModified"))
local jackpotChance = GetModConfigData("jackpotChance", KnownModIndex:GetModActualName("More Drops - DHPModified"))
local jackpotAmount = GetModConfigData("jackpotAmount", KnownModIndex:GetModActualName("More Drops - DHPModified"))

local function MiningFunction(inst, specialPrefab)
	local oldonwork = inst.components.workable.onwork
	inst.components.workable.onwork = function(inst, worker, workleft)
		--Allow rocks, flint, and "special" to spawn while mining (Added Gems - Amnesiac)
		utils.DropLootRandom(inst, specialPrefab, specialChance) --The specific drop base on rock type
		utils.DropLootRandom(inst, "rocks", rockChance)
		utils.DropLootRandom(inst, "flint", flintChance)
		utils.DropLootRandom(inst, "redgem", redChance)
		utils.DropLootRandom(inst, "bluegem", blueChance)
		utils.DropLootRandom(inst, "purplegem", purpleChance)
		utils.DropLootRandom(inst, "orangegem", orangeChance)
		utils.DropLootRandom(inst, "yellowgem", yellowChance)
		utils.DropLootRandom(inst, "greengem", greenChance)
		utils.DropLootRandom(inst, "thulecite_pieces", thuleciteChance)
		oldonwork(inst, worker, workleft)
	end
end

boulders.ImproveRock = function(inst)
	--Do these for each swing
	MiningFunction(inst, "nitre")
	--Do these for each full mine
	local prefabsList = {"rocks", "flint", "nitre", "goldnugget", "moonrocknugget", "redgem", "bluegem", "purplegem", "orangegem", "yellowgem", "greengem", "thulecite_pieces"}
	local chancesList = {rockChance, flintChance, specialChance, specialChance, specialChance, redChance, blueChance, purpleChance, orangeChance, yellowChance, greenChance, thuleciteChance}
	inst.components.workable:SetOnFinishCallback(function(inst, worker)
		if math.random() <= jackpotChance then
			utils.Jackpot(inst, worker, jackpotAmount, prefabsList)
		else
			utils.GiveLootRandomPick(worker, prefabsList, chancesList)
    end
		print("Done mining.")
	end)
end

boulders.ImproveGold = function(inst)
	--Do these for each swing
	MiningFunction(inst, "goldnugget")
end

boulders.ImproveMoon = function(inst)
	--Do these for each swing
	MiningFunction(inst, "moonrocknugget")
end

return boulders