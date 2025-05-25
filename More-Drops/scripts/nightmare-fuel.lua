local utils = require("utils")

local function ImproveNightmareFuel(inst)
  local nightmareFuelAmount = GetModConfigData("nightmareFuelAmount", KnownModIndex:GetModActualName("More Drops - DHPModified"))
  local nightmareFuelChance = GetModConfigData("nightmareFuelChance", KnownModIndex:GetModActualName("More Drops - DHPModified"))
  inst:ListenForEvent("death",function()
    if utils.LootRandom(nightmareFuelChance) then
		  utils.DropLootRandomWithAmount(inst, "nightmarefuel", nightmareFuelChance, nightmareFuelAmount)
    end
  end)
end

return ImproveNightmareFuel