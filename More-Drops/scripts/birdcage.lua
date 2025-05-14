local immortalBird = GetModConfigData("immortalBird", KnownModIndex:GetModActualName("More Drops - DHPModified"))
local birdcageTradeAmount = GetModConfigData("birdcageTradeAmount", KnownModIndex:GetModActualName("More Drops - DHPModified"))

local function GetBird(inst)
  return (inst.components.occupiable and inst.components.occupiable:GetOccupant()) or nil
end

local function GetHunger(bird)
  return (bird and bird.components.perishable and bird.components.perishable:GetPercent()) or 1
end

local function KeepBirdAlive(inst)
  local bird = GetBird(inst)
  if bird and bird:IsValid() and bird.components.perishable then
    bird.components.perishable:SetPercent(1.0)
    bird.components.health:SetPercent(1.0)
  end
end

local function ImproveBirdcage(inst)
  if immortalBird then
    TheWorld:WatchWorldState("cycles", function()
      KeepBirdAlive(inst)
    end)
  end

  if birdcageTradeAmount ~= 1 then
    if inst.components.lootdropper then
      -- Save original DigestFood of birdcage
      local OldDigestFood = inst.components.lootdropper.SpawnLootPrefab
      inst.components.lootdropper.SpawnLootPrefab = function(prefab, ...)
        local loot
        for i = 1, birdcageTradeAmount do
          loot = OldDigestFood(prefab, ...)
        end
        return loot
      end
    end
  end
end

return ImproveBirdcage