local beeboxMultiple = GetModConfigData("beeboxMultiple", KnownModIndex:GetModActualName("More Drops - DHPModified"))

local function ImproveBeebox(inst)
  if inst.components.harvestable then
			local old_onharvest = inst.components.harvestable.onharvestfn
			inst.components.harvestable.onharvest = function(self, picker, produce)
					local new_produce = math.floor(produce * beeboxMultiple)
					old_onharvest(self, picker, new_produce)
			end
	end
end

return ImproveBeebox