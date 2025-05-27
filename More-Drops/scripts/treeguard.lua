local function ImproveTreeguard(inst)
  if inst.components.lootdropper == nil then
    return
  end
  local treeguardLoot = GetModConfigData("treeguardLoot", KnownModIndex:GetModActualName("More Drops - DHPModified"))
  local lootTable = {
    [1] = { livinglog = 6, monstermeat = 1 },
    [2] = { livinglog = 10, monstermeat = 3 },
    [3] = { livinglog = 15, monstermeat = 5 },
    [4] = { livinglog = 20, monstermeat = 10 },
  }
  local lootAmounts = lootTable[treeguardLoot] or lootTable[1]
  local loot = {}
  for item, amount in pairs(lootAmounts) do
    for i = 1, amount do
      table.insert(loot, item)
    end
  end
  inst.components.lootdropper:SetLoot(loot)
end

return ImproveTreeguard