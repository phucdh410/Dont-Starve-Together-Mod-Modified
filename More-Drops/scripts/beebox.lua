local utils = require("utils")

local beeboxAmount = GetModConfigData("beeboxAmount", KnownModIndex:GetModActualName("More Drops - DHPModified"))

local function ImproveBeebox(inst)
  if inst.components.harvestable then
		local old_onharvest = inst.components.harvestable.onharvestfn
		inst.components.harvestable:SetOnHarvestFn(function(self, picker, produce, ...)
			inst:DoTaskInTime(0.2, function()
				if picker and picker.components.inventory and beeboxAmount ~= 0 then
					utils.DoTimes(beeboxAmount, function() picker.components.inventory:GiveItem(SpawnPrefab("honey")) end)
				end
			end)
			old_onharvest(self, picker, produce, ...)
		end)
	end
end

return ImproveBeebox