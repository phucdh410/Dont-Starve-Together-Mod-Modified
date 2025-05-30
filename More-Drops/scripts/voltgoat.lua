local voltgoatBuff = GetModConfigData("voltgoatBuff", KnownModIndex:GetModActualName("More Drops - DHPModified"))

local function ImproveVoltgoat(inst)
  if voltgoatBuff and inst.components.lootdropper then
    inst.components.lootdropper:AddChanceLoot("meat", 1.00)
    inst.components.lootdropper:AddChanceLoot("meat", 1.00)
    inst.components.lootdropper:AddChanceLoot("meat", 1.00)
    inst.components.lootdropper:AddChanceLoot("meat", 1.00)

    inst.components.lootdropper:AddChanceLoot("lightninggoathorn", 0.75)
    inst.components.lootdropper:AddChanceLoot("lightninggoathorn", 0.50) 
    inst.components.lootdropper:AddChanceLoot("lightninggoathorn", 0.50) 
    inst.components.lootdropper:AddChanceLoot("lightninggoathorn", 0.25)
    
    inst.components.lootdropper:AddChanceLoot("goatmilk", 0.75) 
    inst.components.lootdropper:AddChanceLoot("goatmilk", 0.75) 
    inst.components.lootdropper:AddChanceLoot("goatmilk", 0.50) 
    inst.components.lootdropper:AddChanceLoot("goatmilk", 0.25)
  end
end

return ImproveVoltgoat