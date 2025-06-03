local function ImproveBeequeen(inst)
  local royalJellyExtra = GetModConfigData("royalJellyExtra", KnownModIndex:GetModActualName("More Drops - DHPModified"))
  if royalJellyExtra ~= 0 and inst.components and inst.components.lootdropper then
    for i = 1, royalJellyExtra do
      inst.components.lootdropper:AddChanceLoot("honey", 1.00)
    end
  end
end

return ImproveBeequeen