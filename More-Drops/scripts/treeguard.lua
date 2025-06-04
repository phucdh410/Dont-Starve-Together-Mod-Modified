local utils = require("utils")

local function ImproveTreeguard(inst)
  if inst.components.lootdropper == nil then
    return
  end
  local livinglogTreeguard = GetModConfigData("livinglogTreeguard", KnownModIndex:GetModActualName("More Drops - DHPModified"))
  if livinglogTreeguard ~= 0 then
    utils.DoTimes(livinglogTreeguard, function() inst.components.lootdropper:AddChanceLoot("livinglog", 1.00) end)
  end
  local monstermeatTreeguard = GetModConfigData("monstermeatTreeguard", KnownModIndex:GetModActualName("More Drops - DHPModified"))
  if monstermeatTreeguard ~= 0 then
    utils.DoTimes(monstermeatTreeguard, function() inst.components.lootdropper:AddChanceLoot("monstermeat", 1.00) end)
  end
end

return ImproveTreeguard