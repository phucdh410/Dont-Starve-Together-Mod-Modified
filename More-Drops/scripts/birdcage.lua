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

  if bird and bird:IsValid() and bird.components.perishable and immortalBird then
    local hunger = GetHunger(bird)
    if hunger < 0.5 then
      bird.components.perishable:SetPercent(1)
    end
  end  
end

local function ImproveBirdcage(inst)
  inst:DoPeriodicTask(5.0, KeepBirdAlive)
end

return ImproveBirdcage