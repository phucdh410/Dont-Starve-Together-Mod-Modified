local utils = require("utils")

-- regen_time_default = 120 seconds
-- release_time_default = 37.5 seconds

local buffBeebox = GetModConfigData("buffBeebox", KnownModIndex:GetModActualName("More Drops - DHPModified"))
local boostBeebox = GetModConfigData("boostBeebox", KnownModIndex:GetModActualName("More Drops - DHPModified"))
local maxHoney = GetModConfigData("maxHoney", KnownModIndex:GetModActualName("More Drops - DHPModified"))
local maxBee = GetModConfigData("maxBee", KnownModIndex:GetModActualName("More Drops - DHPModified"))

local BASE_REGEN_TIME = TUNING.BEEBOX_REGEN_TIME*boostBeebox
local BASE_RELEASE_TIME = TUNING.BEEBOX_RELEASE_TIME*boostBeebox
local BASE_HONEY_TIME = TUNING.BEEBOX_HONEY_TIME*boostBeebox
local FLOWER_TEST_RADIUS = 30
local FLOWER_MUST_TAG = {"flower"}

local levels =
{
    { amount=maxHoney, idle="honey3", hit="hit_honey3" },
    { amount=math.ceil(maxHoney/2), idle="honey2", hit="hit_honey2" },
    { amount=math.ceil(maxHoney/2)-1, idle="honey1", hit="hit_honey1" },
    { amount=0, idle="bees_loop", hit="hit_idle" },
}

-- Keep almost base behavior
local function setlevel(inst, level)
	if not inst:HasTag("burnt") then
			if inst.anims == nil then
					inst.anims = { idle = level.idle, hit = level.hit }
			else
					inst.anims.idle = level.idle
					inst.anims.hit = level.hit
			end
			inst.AnimState:PlayAnimation(inst.anims.idle)
	end
end

local function updatelevel(inst)
	if not inst:HasTag("burnt") then
			for k, v in pairs(levels) do
					if inst.components.harvestable.produce >= v.amount then
							setlevel(inst, v)
							break
					end
			end
	end
end

local function onharvest(inst, picker, produce)
	if not inst:HasTag("burnt") then
			if inst.components.harvestable then
					inst.components.harvestable:SetGrowTime(nil)
					inst.components.harvestable.pausetime = nil
					inst.components.harvestable:StopGrowing()
			end
	if produce == levels[1].amount then
		AwardPlayerAchievement("honey_harvester", picker)
	end
			updatelevel(inst)

			if inst.components.childspawner ~= nil and
					not TheWorld.state.iswinter and
					not (picker ~= nil and picker.components.skilltreeupdater ~= nil and picker.components.skilltreeupdater:IsActivated("wormwood_bugs"))
			then
					inst.components.childspawner:ReleaseAllChildren(picker)
			end
	end
end

local function SeasonalSpawnChanges(inst, season)
	if season == SEASONS.SPRING then
		inst.components.childspawner:SetRegenPeriod(BASE_REGEN_TIME / TUNING.SPRING_COMBAT_MOD)
		inst.components.childspawner:SetSpawnPeriod(BASE_RELEASE_TIME / TUNING.SPRING_COMBAT_MOD)
		inst.components.childspawner:SetMaxChildren(maxBee * TUNING.SPRING_COMBAT_MOD)
	else
		inst.components.childspawner:SetRegenPeriod(BASE_REGEN_TIME)
		inst.components.childspawner:SetSpawnPeriod(BASE_RELEASE_TIME)
		inst.components.childspawner:SetMaxChildren(maxBee)
	end
end

local function CanStartGrowing(inst)
	return not inst:HasTag("burnt") and
			inst.components.harvestable and
			not TheWorld.state.iswinter and
			(inst.components.childspawner and inst.components.childspawner:NumChildren() > 0) and
			FindEntity(inst, FLOWER_TEST_RADIUS, nil, FLOWER_MUST_TAG)
end

local function TryStartSleepGrowing(inst)
	if CanStartGrowing(inst) then
			inst.components.harvestable:SetGrowTime(BASE_HONEY_TIME)
			inst.components.harvestable:StartGrowing()
	elseif inst.components.harvestable then
			inst.components.harvestable:PauseGrowing()
	end
end

local function OnEntitySleep(inst)
	TryStartSleepGrowing(inst)
	inst.SoundEmitter:KillSound("loop")
end

local function ImproveBeebox(inst)
	if buffBeebox then
		if inst.components.harvestable then
			inst.components.harvestable:SetUp("honey", maxHoney, nil, onharvest, updatelevel)
		end
		if inst.components.childspawner then
			SeasonalSpawnChanges(inst, TheWorld.state.season)
			inst:WatchWorldState("season", SeasonalSpawnChanges)
		end
		inst.OnEntitySleep = OnEntitySleep
	end
end

return ImproveBeebox