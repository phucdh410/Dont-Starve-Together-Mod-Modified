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
  print("Bird: ", bird)
  if bird and bird:IsValid() and bird.components.perishable then
    bird.components.perishable:SetPercent(1.0)
    bird.components.health:SetPercent(1.0)
    print("Bird health and perishable reset to full at end of day!")
  end
end

local function ImproveBirdcage(inst)
  print("immortalBird: ", immortalBird)
  if immortalBird then
    inst:DoPeriodicTask(480.0, KeepBirdAlive)
  end 
end

return ImproveBirdcage