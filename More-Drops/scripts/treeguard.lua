local function ImproveTreeguard(inst)
  if inst.components.lootdropper == nil then
    return
  end
  local treeguardLoot = GetModConfigData("treeguardLoot", KnownModIndex:GetModActualName("More Drops - DHPModified"))
  if treeguardLoot == 1 then
    return
  end
  local extraLivinglog = 5 * treeguardLoot
  local extraMonstermeat = 1.5 * treeguardLoot * treeguardLoot - 5.5 * treeguardLoot + 8
  for i = 1, extraLivinglog do
    inst.components.lootdropper:AddChanceLoot("livinglog", 1.00)
  end
  for i = 1, extraMonstermeat do
    inst.components.lootdropper:AddChanceLoot("monstermeat", 1.00)
  end
end

return ImproveTreeguard