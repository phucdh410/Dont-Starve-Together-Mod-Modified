require = GLOBAL.require
require "components/stackable"
require "components/inventoryitem"
require "components/follower"

TUNING.STACK_SIZE_LARGEITEM = GetModConfigData("cfgChangeLargeStacksSize");
TUNING.STACK_SIZE_MEDITEM = GetModConfigData("cfgChangeMediumStacksSize");
TUNING.STACK_SIZE_SMALLITEM = GetModConfigData("cfgChangeSmallStacksSize");

 


local r_s = GLOBAL.require("components/stackable_replica")
r_s._ctor = function(self, inst)
	self.inst = inst
	self._stacksize = GLOBAL.net_shortint(inst.GUID, "stackable._stacksize", "stacksizedirty")
	self._maxsize = GLOBAL.net_tinybyte(inst.GUID, "stackable._maxsize")
end

local function makeStackable(inst)

    if not inst.components.stackable and GLOBAL.TheWorld.ismastersim then
        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    end
end

local function unmakeFeedable(inst)
    if inst.components.perishable and GLOBAL.TheWorld.ismastersim then
        inst:RemoveComponent("perishable")
    end
    if inst.components.inventoryitem and GLOBAL.TheWorld.ismastersim then
        inst.components.inventoryitem:SetOnPutInInventoryFn(function(inst)
            if oninventory then
                oninventory(inst)
            end
        end)
        inst.components.inventoryitem:SetOnDroppedFn(function(inst)
		if string.match(inst.prefab, "spider") then
				if inst.components.follower then
					lastowner = inst.components.inventoryitem.lastowner
					if lastowner then
						local stacksize = inst.components.stackable.stacksize
						inst.components.stackable:SetStackSize(1)
						if (stacksize > 1) then
							stacksize = stacksize - 1
							for i = 1, stacksize do
								spider = GLOBAL.SpawnPrefab(inst.prefab)
								if spider then
									local x, y, z = lastowner.Transform:GetWorldPosition()
									spider.components.follower:SetLeader(lastowner)
									spider.Transform:SetPosition( x, y, z )	

								end
							end
						end
					end
				end
			end
            if ondropped then
                ondropped(inst)
			end
		end)
    end
end

local function removeMurder(inst)
    if inst.components.health and GLOBAL.TheWorld.ismastersim then
        inst.components.health.canmurder = false
    end
end

-- local function makeFriendIfPossiable(inst, data)
-- 	local item = data.prev_item
-- 	if item and string.match(item.prefab, "spider") then
-- 		if item.components.follower then
-- 			item.components.follower:SetLeader(inst)
-- 			item.components.inventoryitem.lastowner = inst
-- 		end
-- 	end
-- end

-- local function connectWebber(inst)
-- 	inst:ListenForEvent("itemlose", makeFriendIfPossiable)
-- end

-- drop friendly spiders for webber
--  AddPrefabPostInit("webber", connectWebber)
 
 -- make stackable
 
 AddPrefabPostInit("minotaurhorn", makeStackable)
 AddPrefabPostInit("tallbirdegg", makeStackable)
 if GetModConfigData("cfgRabbitsCanStackToggle") then
    AddPrefabPostInit("rabbit", makeStackable)
 end
 if GetModConfigData("cfgBirdsCanStackToggle")then
    AddPrefabPostInit("crow", makeStackable)
    AddPrefabPostInit("robin", makeStackable)
    AddPrefabPostInit("robin_winter", makeStackable)
    AddPrefabPostInit("canary", makeStackable)
 end
 if GetModConfigData("cfgMolesCanStackToggle") then
    AddPrefabPostInit("mole", makeStackable)
 end
  if GetModConfigData("cfgSpidersCanStackToggle") then
	AddPrefabPostInit("spider", makeStackable)
    AddPrefabPostInit("spider_warrior", makeStackable)
    AddPrefabPostInit("spider_hider", makeStackable)
    AddPrefabPostInit("spider_spitter", makeStackable)
	AddPrefabPostInit("spider_dropper", makeStackable)
	AddPrefabPostInit("spider_moon", makeStackable)
    AddPrefabPostInit("spider_healer", makeStackable)
    AddPrefabPostInit("spider_water", makeStackable)
 end
 
 -- remove feedable
 if GetModConfigData("cfgMolesDontDieToggle") then
    AddPrefabPostInit("mole", unmakeFeedable)
 end
 if GetModConfigData("cfgRabbitsDotDieToggle") then
    AddPrefabPostInit("rabbit", unmakeFeedable)
 end
 if GetModConfigData("cfgBirdsDontDieToggle") then
    AddPrefabPostInit("crow", unmakeFeedable)
    AddPrefabPostInit("robin", unmakeFeedable)
    AddPrefabPostInit("robin_winter", unmakeFeedable)
    AddPrefabPostInit("canary", unmakeFeedable)
 end
 if GetModConfigData("cfgBeesDontDieToggle") then
    AddPrefabPostInit("bee", unmakeFeedable)
    AddPrefabPostInit("killerbee", unmakeFeedable)
 end
 if GetModConfigData("cfgButterfliesDontDieToggle") then
    AddPrefabPostInit("butterfly", unmakeFeedable)
 end
 if GetModConfigData("cfgMosquitosDontDieToggle") then
    AddPrefabPostInit("mosquito", unmakeFeedable)
 end
  if GetModConfigData("cfgSpidersDontDieToggle") then
	AddPrefabPostInit("spider", unmakeFeedable)
    AddPrefabPostInit("spider_warrior", unmakeFeedable)
    AddPrefabPostInit("spider_hider", unmakeFeedable)
    AddPrefabPostInit("spider_spitter", unmakeFeedable)
	AddPrefabPostInit("spider_dropper", unmakeFeedable)
	AddPrefabPostInit("spider_moon", unmakeFeedable)
    AddPrefabPostInit("spider_healer", unmakeFeedable)
    AddPrefabPostInit("spider_water", unmakeFeedable)
 end

 -- remove murder
 if GetModConfigData("cfgMolesRemoveMurderToggle") then
    AddPrefabPostInit("mole", removeMurder)
 end
 if GetModConfigData("cfgBeesRemoveMurderToggle") then
    AddPrefabPostInit("bee", removeMurder)
    AddPrefabPostInit("killerbee", removeMurder)
 end
 if GetModConfigData("cfgButterfliesRemoveMurderToggle") then
    AddPrefabPostInit("butterfly", removeMurder)
 end
 if GetModConfigData("cfgRabbitsRemoveMurderToggle") then
    AddPrefabPostInit("rabbit", removeMurder)
 end
 if GetModConfigData("cfgBirdsRemoveMurderToggle") then
    AddPrefabPostInit("crow", removeMurder)
    AddPrefabPostInit("robin", removeMurder)
    AddPrefabPostInit("robin_winter", removeMurder)
    AddPrefabPostInit("canary", removeMurder)
 end
 if GetModConfigData("cfgMosquitosRemoveMurderToggle") then
    AddPrefabPostInit("mosquito", removeMurder)
 end
  if GetModConfigData("cfgSpidersRemoveMurderToggle") then
    AddPrefabPostInit("spider", removeMurder)
    AddPrefabPostInit("spider_warrior", removeMurder)
    AddPrefabPostInit("spider_hider", removeMurder)
    AddPrefabPostInit("spider_spitter", removeMurder)
	AddPrefabPostInit("spider_dropper", removeMurder)
	AddPrefabPostInit("spider_moon", removeMurder)
    AddPrefabPostInit("spider_healer", removeMurder)
    AddPrefabPostInit("spider_water", removeMurder)
 end

local function crsRemovePerish(inst)
    if inst.components.perishable and GLOBAL.TheWorld.ismastersim then
        inst:RemoveComponent("perishable")
    end
end

if GetModConfigData("cfgJerkyDoesntPerish") then
    AddPrefabPostInit("meat_dried", crsRemovePerish)
    AddPrefabPostInit("smallmeat_dried", crsRemovePerish)
    AddPrefabPostInit("monstermeat_dried", crsRemovePerish)
end

if GetModConfigData("cfgSeedsDontPerish") then
    AddPrefabPostInit("seeds", crsRemovePerish)
end

if GetModConfigData("cfgVegSeedsDontPerish") then
    AddPrefabPostInit("carrot_seeds", crsRemovePerish)
    AddPrefabPostInit("corn_seeds", crsRemovePerish)
    AddPrefabPostInit("dragonfruit_seeds", crsRemovePerish)
    AddPrefabPostInit("durian_seeds", crsRemovePerish)
    AddPrefabPostInit("eggplant_seeds", crsRemovePerish)
    AddPrefabPostInit("pomegranate_seeds", crsRemovePerish)
    AddPrefabPostInit("pumpkin_seeds", crsRemovePerish)
    AddPrefabPostInit("watermelon_seeds", crsRemovePerish)
    AddPrefabPostInit("garlic_seeds", crsRemovePerish)
    AddPrefabPostInit("onion_seeds", crsRemovePerish)
    AddPrefabPostInit("pepper_seeds", crsRemovePerish)
    AddPrefabPostInit("potato_seeds", crsRemovePerish)
    AddPrefabPostInit("tomato_seeds", crsRemovePerish)
    AddPrefabPostInit("asparagus_seeds", crsRemovePerish)
end