local immortalBird = GetModConfigData("immortalBird", KnownModIndex:GetModActualName("More Drops - DHPModified"))
local birdcageTradeAmount = GetModConfigData("birdcageTradeAmount", KnownModIndex:GetModActualName("More Drops - DHPModified"))

local function GetBird(inst)
  return (inst.components.occupiable and inst.components.occupiable:GetOccupant()) or nil
end

local function GetHunger(bird)
  return (bird and bird.components.perishable and bird.components.perishable:GetPercent()) or 1
end

local function ImproveBirdcage(inst)
  if immortalBird then
    local old_onoccupied = inst.components.occupiable.onoccupied
    inst.components.occupiable.onoccupied = function(inst, bird)
      bird.components.health:SetInvincible(true)
      if old_onoccupied then
        old_onoccupied(inst, bird)
      end
    end
  end 
end

return ImproveBirdcage