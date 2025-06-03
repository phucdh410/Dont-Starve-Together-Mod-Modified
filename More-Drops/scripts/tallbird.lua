local utils = require("utils")

local function ImproveTallbird(inst)
  local tallbirdExtra = GetModConfigData("tallbirdExtra", KnownModIndex:GetModActualName("More Drops - DHPModified"))
  if tallbirdExtra ~= 0 and inst.components and inst.components.lootdropper then
    utils.DoTimes(tallbirdExtra, function() inst.components.lootdropper:AddChanceLoot("meat", 1.00) end)
  end
end

return ImproveTallbird