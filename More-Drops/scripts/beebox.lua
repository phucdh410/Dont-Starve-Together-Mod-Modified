local beeboxMultiple = GetModConfigData("beeboxMultiple", KnownModIndex:GetModActualName("More Drops - DHPModified"))

local function ImproveBeebox(inst)
  if inst.components.harvestable then
		print("MULTIPLE",beeboxMultiple)
		local old_onharvest = inst.components.harvestable.onharvestfn
		print("OLDHARVEST",old_onharvest)
		inst.components.harvestable:SetOnHarvestFn(function(self, picker, produce, ...)
			print("ORG_PRODUCE",produce)
			local new_produce = math.floor(produce * beeboxMultiple)
			print("NEW_PRODUCE",new_produce)
			return old_onharvest(self, picker, new_produce, ...)
		end)
	end
end

return ImproveBeebox