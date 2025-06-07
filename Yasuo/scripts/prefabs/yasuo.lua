local MakePlayerCharacter = require "prefabs/player_common"

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}
local prefabs = {}

local start_inv = {     --初始物品
    "yasuo_sword"
}

local function StartAttack(self, oldstartattack)
    if oldstartattack then
        oldstartattack(self)
    end
    local weapon = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    if weapon and weapon:HasTag("yasuo_sword") then
        if self.inst.in_last_breath_damageup then
            weapon.SoundEmitter:PlaySound("yasuo/yasuo_sfx/attack_crit")
        else
            weapon.SoundEmitter:PlaySound("yasuo/yasuo_sfx/attack")
        end
    end
end

local function customidleanimfn(inst)
    local item = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    return item ~= nil and item.prefab == "yasuo_sword" and "idle_woodie" or nil
end

local function OnNewState(inst, data)
    if data and data.statename ~= "run" then
        if inst.components.yasuo_skills then
            inst.components.yasuo_skills:StopRegenWay()
        end
    end
end

-------------------------------------------------------------------------------------------
--E技能拖尾
-------------------------------------------------------------------------------------------

local SPRINT_TRAIL_SOUND_POOL = {}
local SPRINT_TRAIL_SOUND_COUNT = 0 --live count, excludes ones in pool
local SPRINT_TRAIL_SOUND_POOL_CLEANUP_TASK = nil

local function IncSprintTrailSound()
	if SPRINT_TRAIL_SOUND_POOL_CLEANUP_TASK then
		SPRINT_TRAIL_SOUND_POOL_CLEANUP_TASK:Cancel()
		SPRINT_TRAIL_SOUND_POOL_CLEANUP_TASK = nil
	end
	SPRINT_TRAIL_SOUND_COUNT = SPRINT_TRAIL_SOUND_COUNT + 1
end

local function DumpSprintTrailSoundPool()
	for i = 1, #SPRINT_TRAIL_SOUND_POOL do
		SPRINT_TRAIL_SOUND_POOL[i]:Remove()
		SPRINT_TRAIL_SOUND_POOL[i] = nil
	end
end

local function DecSprintTrailSound()
	SPRINT_TRAIL_SOUND_COUNT = SPRINT_TRAIL_SOUND_COUNT - 1
	if SPRINT_TRAIL_SOUND_COUNT <= 0 then
		if SPRINT_TRAIL_SOUND_POOL_CLEANUP_TASK == nil then
			SPRINT_TRAIL_SOUND_POOL_CLEANUP_TASK = TheWorld:DoTaskInTime(30, DumpSprintTrailSoundPool)
		else
			assert(false) --sanity check
		end
	end
end

local function CreateSprintTrailSound()
	local fx = CreateEntity()

	fx:AddTag("CLASSIFIED")

	--[[Non-networked entity]]
	fx.entity:SetCanSleep(false)
	fx.persists = false

	fx.entity:AddTransform()
	fx.entity:AddSoundEmitter()
	fx:Hide()

	return fx
end

local function GetSprintTrailSound()
	local fx = table.remove(SPRINT_TRAIL_SOUND_POOL)
	if fx then
		fx:ReturnToScene()
	else
		fx = CreateSprintTrailSound()
	end

	fx.OnRemoveEntity = DecSprintTrailSound --This is just in case somehow something else removes us
	IncSprintTrailSound()

	return fx
end

local function RecycleSprintTrailSound(fx)
	fx.SoundEmitter:KillSound("loop")
	fx.entity:SetParent(nil)
	fx.OnRemoveEntity = nil
	fx:RemoveFromScene()
	table.insert(SPRINT_TRAIL_SOUND_POOL, fx)
	DecSprintTrailSound()
end

local SPRINT_TRAIL_FX_POOL = {}
local SPRINT_TRAIL_FX_COUNT = 0 --live count, excludes ones in pool
local SPRINT_TRAIL_FX_POOL_CLEANUP_TASK = nil

local function IncSprintTrailFx()
	if SPRINT_TRAIL_FX_POOL_CLEANUP_TASK then
		SPRINT_TRAIL_FX_POOL_CLEANUP_TASK:Cancel()
		SPRINT_TRAIL_FX_POOL_CLEANUP_TASK = nil
	end
	SPRINT_TRAIL_FX_COUNT = SPRINT_TRAIL_FX_COUNT + 1
end

local function DumpSprintTrailFxPool()
	for i = 1, #SPRINT_TRAIL_FX_POOL do
		SPRINT_TRAIL_FX_POOL[i]:Remove()
		SPRINT_TRAIL_FX_POOL[i] = nil
	end
end

local function DecSprintTrailFx()
	SPRINT_TRAIL_FX_COUNT = SPRINT_TRAIL_FX_COUNT - 1
	if SPRINT_TRAIL_FX_COUNT <= 0 then
		if SPRINT_TRAIL_FX_POOL_CLEANUP_TASK == nil then
			SPRINT_TRAIL_FX_POOL_CLEANUP_TASK = TheWorld:DoTaskInTime(30, DumpSprintTrailFxPool)
		else
			assert(false) --sanity check
		end
	end
end

local function CreateSprintTrailFx()
	local fx = CreateEntity()

	fx:AddTag("FX")
	fx:AddTag("NOCLICK")
	--[[Non-networked entity]]
	fx.entity:SetCanSleep(false)
	fx.persists = false

	fx.entity:AddTransform()
	fx.entity:AddAnimState()

	fx.Transform:SetFourFaced()

	fx.AnimState:SetBank("wilson")
	fx.AnimState:SetBuild("yasuo")
	fx.AnimState:SetAddColour(1, 1, 1, 0)
	fx.AnimState:UsePointFiltering(true)

	fx:AddComponent("updatelooper")

	return fx
end

local function GetSprintTrailFx()
	local fx = table.remove(SPRINT_TRAIL_FX_POOL)
	if fx then
		fx:ReturnToScene()
	else
		fx = CreateSprintTrailFx()
	end

	--Reset the entity
	fx.a = nil
	fx:Hide()

	fx.OnRemoveEntity = DecSprintTrailFx --This is just in case somehow something else removes us
	IncSprintTrailFx()

	return fx
end

--------------------------------------------------------------------------

local function SprintTrailFx_PostUpdate(fx)
	local inst = fx.entity:GetParent()
	if inst then
		fx.Transform:SetPosition(inst.entity:WorldToLocalSpace(fx.x, fx.y, fx.z))
		fx.Transform:SetRotation(fx.rot - inst.Transform:GetRotation())
		fx.AnimState:MakeFacingDirty()
	end
end

local TRAIL_LENGTH = 7
local TRAIL_ALPHA = 0.1
local TRAIL_FADE_DELTA = TRAIL_ALPHA / TRAIL_LENGTH
local function SprintTrailFx_OnUpdate(fx)
	if fx.a == nil then
		fx.a = TRAIL_ALPHA
		fx:Show()
	else
		fx.a = fx.a - TRAIL_FADE_DELTA
	end
	if fx.a > 0 then
		fx.AnimState:SetMultColour(1, 1, 1, fx.a)
	else
		--Return to pool
		fx.components.updatelooper:RemovePostUpdateFn(SprintTrailFx_PostUpdate)
		fx.components.updatelooper:RemoveOnUpdateFn(SprintTrailFx_OnUpdate)
		fx.OnRemoveEntity = nil
		fx:RemoveFromScene()
		table.insert(SPRINT_TRAIL_FX_POOL, fx)
		DecSprintTrailFx()
	end
end

local function OnUpdateSprintTrail(inst, dt)
    local anim = "sweeping_blade_loop"
	if anim then
		local fx = GetSprintTrailFx()
		fx.entity:SetParent(inst.entity)
		fx.AnimState:PlayAnimation(anim)
		fx.AnimState:SetTime(inst.AnimState:GetCurrentAnimationTime())
		fx.AnimState:Pause()
		fx.x, fx.y, fx.z = inst.Transform:GetWorldPosition()
		fx.rot = inst.Transform:GetRotation()
		fx.components.updatelooper:AddPostUpdateFn(SprintTrailFx_PostUpdate)
		fx.components.updatelooper:AddOnUpdateFn(SprintTrailFx_OnUpdate)

		if inst._sprinttrailsfx == nil then
			inst._sprinttrailsfx = GetSprintTrailSound()
			inst._sprinttrailsfx.entity:SetParent(inst.entity)
			inst._sprinttrailsfx.SoundEmitter:PlaySound("meta5/woby/sprint_wind_lp", "loop")
		end
	elseif inst._sprinttrailsfx then
		RecycleSprintTrailSound(inst._sprinttrailsfx)
		inst._sprinttrailsfx = nil
	end
end

local function SprintTrail_OnEntitySleep(inst)
	if inst._sprinttrail_onudpate then
		inst._sprinttrail_onudpate = nil
		inst.components.updatelooper:RemoveOnUpdateFn(OnUpdateSprintTrail)
		if inst._sprinttrailsfx then
			RecycleSprintTrailSound(inst._sprinttrailsfx)
			inst._sprinttrailsfx = nil
		end
	end
end

local function SprintTrail_OnEntityWake(inst)
	if not inst._sprinttrail_onudpate then
		inst._sprinttrail_onudpate = true
		inst.components.updatelooper:AddOnUpdateFn(OnUpdateSprintTrail)
	end
end

local function OnHasSprintTrail(inst)
	if inst._predict_sprint_trail or inst.has_sprint_trail:value() then
		if not inst._updatingsprinttrail then
			if inst.components.updatelooper == nil then
				inst:AddComponent("updatelooper")
			end
			if TheWorld.ismastersim then
				inst:ListenForEvent("entitysleep", SprintTrail_OnEntitySleep)
				inst:ListenForEvent("entitywake", SprintTrail_OnEntityWake)
				if not inst:IsAsleep() then
					SprintTrail_OnEntityWake(inst)
				end
			else
				inst.components.updatelooper:AddOnUpdateFn(OnUpdateSprintTrail)
			end
			inst._updatingsprinttrail = true
		end
	elseif inst._updatingsprinttrail then
		if TheWorld.ismastersim then
			inst:RemoveEventCallback("entitysleep", SprintTrail_OnEntitySleep)
			inst:RemoveEventCallback("entitywake", SprintTrail_OnEntityWake)
			SprintTrail_OnEntitySleep(inst)
		else
			inst.components.updatelooper:RemoveOnUpdateFn(OnUpdateSprintTrail)
			if inst._sprinttrailsfx then
				RecycleSprintTrailSound(inst._sprinttrailsfx)
				inst._sprinttrailsfx = nil
			end
		end
		inst._updatingsprinttrail = false
	end
end

local function OnDisableSprintTask_Server(inst)
	inst._disablesprinttrailtask = nil
	inst.has_sprint_trail:set(false)
	if not TheNet:IsDedicated() then
		OnHasSprintTrail(inst)
	end
end

local function EnableWobySprintTrail_Server(inst, enable)
	if enable then
		if inst._disablesprinttrailtask then
			inst._disablesprinttrailtask:Cancel()
			inst._disablesprinttrailtask = nil
		elseif not inst.has_sprint_trail:value() then
			inst.has_sprint_trail:set(true)
			if not TheNet:IsDedicated() then
				OnHasSprintTrail(inst)
			end
		end
	elseif inst.has_sprint_trail:value() and inst._disablesprinttrailtask == nil then
		inst._disablesprinttrailtask = inst:DoStaticTaskInTime(0, OnDisableSprintTask_Server)
	end
end

--------------------------------------------------------------------------
--For prediction

local function OnDisableSprintTask_Client(inst)
	inst._disablesprinttrailtask = nil
	inst._predict_sprint_trail = false
	OnHasSprintTrail(inst)
end

local function EnableWobySprintTrail_Client(inst, enable)
	if enable then
		if inst._disablesprinttrailtask then
			inst._disablesprinttrailtask:Cancel()
			inst._disablesprinttrailtask = nil
		elseif not inst._predict_sprint_trail then
			inst._predict_sprint_trail = true
			OnHasSprintTrail(inst)
		end
	elseif inst._predict_sprint_trail and inst._disablesprinttrailtask == nil then
		inst._disablesprinttrailtask = inst:DoStaticTaskInTime(0, OnDisableSprintTask_Client)
	end
end

local function OnEnableMovementPrediction_Client(inst, enable)
	if not enable and inst._predict_sprint_trail then
		if inst._disablesprinttrailtask then
			inst._disablesprinttrailtask:Cancel()
			inst._disablesprinttrailtask = nil
		end
		inst._predict_sprint_trail = nil
		OnHasSprintTrail(inst)
	end
end

-------------------------------------------------------------------------------------------

local common_postinit = function(inst)
    inst.MiniMapEntity:SetIcon("yasuo.tex")
    inst.AnimState:AddOverrideBuild("yasuo_skills_fx_build")

    inst.has_sprint_trail = net_bool(inst.GUID, "yasuo.has_sprint_trail", "has_sprint_trail_dirty")

    if not TheWorld.ismastersim then
		inst:ListenForEvent("has_sprint_trail_dirty", OnHasSprintTrail)
		inst:ListenForEvent("enablemovementprediction", OnEnableMovementPrediction_Client)
		inst.EnableWobySprintTrail = EnableWobySprintTrail_Client
	end
end

local master_postinit = function(inst)
    inst.soundsname = "wilson"

    inst.customidleanim = customidleanimfn
    --三维    
    inst.components.health:SetMaxHealth(YASUO.HEALTH)
    inst.components.hunger:SetMax(YASUO.HUNGER)
    inst.components.sanity:SetMax(YASUO.SANITY)

    inst:AddTag("yasuo")

    inst:AddComponent("yasuo_skills")

    local oldstartattack = inst.components.combat.StartAttack
    inst.components.combat.StartAttack = function ()
        StartAttack(inst.components.combat, oldstartattack)
    end

    inst:ListenForEvent("newstate", OnNewState)

    inst.EnableWobySprintTrail = EnableWobySprintTrail_Server
end

return MakePlayerCharacter("yasuo", prefabs, assets, common_postinit, master_postinit, start_inv)