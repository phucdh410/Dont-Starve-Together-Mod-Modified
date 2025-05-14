local beeboxMultiple = GetModConfigData("beeboxMultiple", KnownModIndex:GetModActualName("More Drops - DHPModified"))

local function ImproveBeebox(inst)
  if inst.components.harvestable then
		local old_onharvest = inst.components.harvestable.onharvestfn
		inst.components.harvestable:SetOnHarvestFn(function(self, picker, produce, ...)
			local new_produce = math.floor(produce * beeboxMultiple)
			local additional_honey = math.max(0, new_produce - produce)
			inst:DoTaskInTime(0.2, function()
				if picker and picker.components.inventory then
					for i = 1, additional_honey do
							picker.components.inventory:GiveItem(SpawnPrefab("honey"))
					end
				end
			end)
			old_onharvest(self, picker, produce, ...)
		end)
	end
end

return ImproveBeebox