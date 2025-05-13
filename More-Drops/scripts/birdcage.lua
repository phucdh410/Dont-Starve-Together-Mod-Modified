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
  print("BIRD: ",bird)
  if bird and bird:IsValid() and bird.components.perishable then
    bird.components.perishable:SetPercent(1.0)
    bird.components.health:SetPercent(1.0)
  end
end

local function ImproveBirdcage(inst)
  if immortalBird then
    TheWorld:WatchWorldState("cycles", KeepBirdAlive)
    TheWorld:WatchWorldState("cycles", function()
      print("CHAY LOG MOI KHI QUA NGAY")
    end)
  end
end

return ImproveBirdcage