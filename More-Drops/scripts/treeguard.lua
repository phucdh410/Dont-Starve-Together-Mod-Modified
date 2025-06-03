local utils = require("utils")

local function ImproveTreeguard(inst)
  if inst.components.lootdropper == nil then
    return
  end
  local treeguardLoot = GetModConfigData("treeguardLoot", KnownModIndex:GetModActualName("More Drops - DHPModified"))
  if treeguardLoot == 1 then
    return
  end
  local extraLivinglog = 0
  local extraMonstermeat = 0
  if treeguardLoot == 2 then
    extraLivinglog = 4
    extraMonstermeat = 2
  elseif treeguardLoot == 3 then
    extraLivinglog = 9
    extraMonstermeat = 4
  else
    extraLivinglog = 14
    extraMonstermeat = 9
  end
  utils.DoTimes(extraLivinglog, function() inst.components.lootdropper:AddChanceLoot("livinglog", 1.00) end)
  utils.DoTimes(extraMonstermeat, function() inst.components.lootdropper:AddChanceLoot("monstermeat", 1.00) end)
end

return ImproveTreeguard