local utils = require("utils")

local function ImproveCrop(component, inst)
	--Do this for each harvest
	local oldharvest = component.Harvest
	component.Harvest = function(self, harvester)
		--Give the product twice
		if harvester ~= nil then
			if utils.LootRandom(GetModConfigData("cropChance", KnownModIndex:GetModActualName("More Drops JEM"))) then
				for i = 1, GetModConfigData("extracrops", KnownModIndex:GetModActualName("More Drops JEM")) do
					harvester.components.inventory:GiveItem(SpawnPrefab(self.product_prefab), nil, self.inst:GetPosition())
				end
			end
		end
		oldharvest(self, harvester)
	end
end

return ImproveCrop