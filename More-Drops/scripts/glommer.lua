local glommerfuelExtra = GetModConfigData("glommerfuelExtra", KnownModIndex:GetModActualName("More Drops - DHPModified"))

local function ImproveGlommer(inst)
  if inst.components.periodicspawner and glommerfuelExtra ~= 0 then
    local old_onspawn = inst.components.periodicspawner.onspawn
    inst.components.periodicspawner:SetOnSpawnFn(function(inst, fuel)
      if old_onspawn then
        old_onspawn(inst, fuel)
      end
      for i = 1, glommerfuelExtra do
        local poop = SpawnPrefab("glommerfuel")
        if poop then
          local x, y, z = inst.Transform:GetWorldPosition()
          poop.Transform:SetPosition(x + math.random() * 0.4 - 0.2, y, z + math.random() * 0.4 - 0.2)
        end
      end
    end)
  end
end

return ImproveGlommer