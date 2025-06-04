local utils = require("utils")

local function ImproveBeequeen(inst)
  local royaljellyExtra = GetModConfigData("royaljellyExtra", KnownModIndex:GetModActualName("More Drops - DHPModified"))
  if inst.components and inst.components.lootdropper and royaljellyExtra ~=0 then
    utils.DoTimes(royaljellyExtra, function() inst.components.lootdropper.AddChanceLoot("royal_jelly", 1.00) end)
  end
end

return ImproveBeequeen