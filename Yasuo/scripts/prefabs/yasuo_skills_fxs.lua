local assets_steel_tempest =
{
    Asset("ANIM", "anim/yasuo_shadow_lunge_fx.zip"),
    Asset("ANIM", "anim/yasuo_steel_tempest_flow.zip"),
}

local assets_wind_wall =
{
    Asset("ANIM", "anim/yasuo_wind_wall.zip"),
}

local assets_sweeping_blade =
{
    Asset("ANIM", "anim/yasuo_sweeping_blade_fx.zip"),
}

local function steel_tempest_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("lavaarena_shadow_lunge_fx")
    inst.AnimState:SetBuild("yasuo_shadow_lunge_fx")
    inst.AnimState:PlayAnimation("line")
    inst.AnimState:SetFinalOffset(1)

    inst.Transform:SetEightFaced()
    inst.Transform:SetScale(1.25 * 1.3, 1.25 * 1.3, 1.25 * 1.3)

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")

    inst.entity:SetPristine()
    inst.persists = false

    return inst
end

local function steel_tempest_flow_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.entity:AddSoundEmitter()

    inst.AnimState:SetBank("cursed_fx")
    inst.AnimState:SetBuild("cursed_fx")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetAddColour(0, 0.3, 0.8, 1)
    inst.Transform:SetNoFaced()
    inst.Transform:SetScale(2, 1, 1)

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

    inst:ListenForEvent("animover", inst.Remove)

    inst.persists = false

    return inst
end

local function SetDuration(inst, duration)
    if inst.task ~= nil then
        inst.task:Cancel()
    end
    inst.task = inst:DoTaskInTime(duration, inst.Remove)
end

local WORK_ACTIONS =
{
    CHOP = true,
    DIG = true,
    HAMMER = true,
    MINE = true,
}
local TARGET_TAGS = { "_combat" }
for k, v in pairs(WORK_ACTIONS) do
    table.insert(TARGET_TAGS, k.."_workable")
end

local function EnableControl(inst, enable)
    if enable then
        inst:RestartBrain()
        if inst.AnimState then
            inst.AnimState:Resume()
        end
    else
        inst:StopBrain()
        if inst.AnimState then
            inst.AnimState:Pause()
        end
    end
end

local function BeKnocked(attacker, inst)
    attacker.knocked[inst] = true
    inst:AddTag("yasuo_tornado_knocked")

    local y_speed = 0.5
    local oldx, oldy, oldz = inst.Transform:GetWorldPosition()

    EnableControl(inst, false)

    if inst.yasuo_knocked_task ~= nil then
        inst.yasuo_knocked_task:Cancel()
    end

    inst.yasuo_knocked_task = inst:DoPeriodicTask(0, function ()
        local x, y, z = inst.Transform:GetWorldPosition()
        if y >= oldy + 5 and y_speed > 0 then
            y_speed = -y_speed
        end

        if y <= oldy + 0.2 and y_speed < 0 then
            inst:RemoveTag("yasuo_tornado_knocked")
            inst.Transform:SetPosition(x, 0, z)
            if inst.yasuo_knocked_task ~= nil then
                inst.yasuo_knocked_task:Cancel()
                inst.yasuo_knocked_task = nil
            end
            EnableControl(inst, true)
        else
            inst.Transform:SetPosition(x, y + y_speed, z)
        end
    end)
end

local TARGET_IGNORE_TAGS = { "INLIMBO" }
local function KnockOther(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, y, z, 2, nil, TARGET_IGNORE_TAGS, TARGET_TAGS)
    for i, v in ipairs(ents) do
        if v ~= inst.CASTER and v:IsValid() then
            if v.components.health ~= nil and
                not v.components.health:IsDead() and
                v.components.combat ~= nil and
                v.components.combat:CanBeAttacked() and
                (TheNet:GetPVPEnabled() or not (inst.CASTER_ISPLAYER and v:HasTag("player"))) and
                not inst.knocked[v] then
                local damage = inst.CASTER.components.yasuo_skills.skills["steel_tempest"].damage(inst.CASTER)
                v.components.combat:GetAttacked(inst.CASTER, damage, nil, "yasuo_tornado")
                if v:IsValid() and
                    inst.CASTER ~= nil and inst.CASTER:IsValid() and
                    v.components.combat ~= nil and
                    not (v.components.health ~= nil and v.components.health:IsDead()) and
                    not (v.components.follower ~= nil and
                        v.components.follower.keepleaderonattacked and
                        v.components.follower:GetLeader() == inst.CASTER) then
                    v.components.combat:SuggestTarget(inst.CASTER)
                end
            elseif v.components.workable ~= nil and
                v.components.workable:CanBeWorked() and
                v.components.workable:GetWorkAction() and
                WORK_ACTIONS[v.components.workable:GetWorkAction().id] then
                SpawnPrefab("collapse_small").Transform:SetPosition(v.Transform:GetWorldPosition())
                v.components.workable:WorkedBy(inst, 2)
            end
        end
        if v.Physics ~= nil and v.components.combat ~= nil and v.components.health ~= nil and not v.components.health:IsDead()
        and v.Transform ~= nil and v ~= inst.CASTER and not inst.knocked[v] and not v:HasTag("wall") then
            BeKnocked(inst, v)
        end
    end
end

local function GrowUp(inst)
    local scale = inst.Transform:GetScale()
    inst.Transform:SetScale(scale + 0.05, scale + 0.05, scale + 0.05)
end


local function tornado_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetFinalOffset(2)
    inst.AnimState:SetBank("tornado")
    inst.AnimState:SetBuild("tornado")
    inst.AnimState:PlayAnimation("tornado_pre")
    inst.AnimState:PushAnimation("tornado_loop")

    inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/tornado", "spinLoop")

    MakeInventoryPhysics(inst)
    RemovePhysicsColliders(inst)

    inst.Transform:SetScale(0.2, 0.2, 0.2)

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("knownlocations")

    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = TUNING.TORNADO_WALK_SPEED * .33
    inst.components.locomotor.runspeed = TUNING.TORNADO_WALK_SPEED

    inst.persists = false

    inst.knocked = {}

    inst.SetDuration = SetDuration
    inst:SetDuration(0.8)

    inst:DoPeriodicTask(0, GrowUp)
    inst:DoPeriodicTask(0, KnockOther)

    return inst
end

local function DestoryProjectile(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local projectiles = TheSim:FindEntities(x, y, z, 2)
    if projectiles ~= nil then
        for _, projectile in pairs(projectiles) do
            if projectile:HasTag("projectile") or projectile.components.projectile ~= nil or projectile.components.complexprojectile ~= nil then
                local fx = SpawnPrefab("sparks")
                fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
                fx:FacePoint(projectile.Transform:GetWorldPosition())
                projectile:Remove()

                inst.SoundEmitter:PlaySound("yasuo/yasuo_sfx/wind_wall_blocked")
            end
        end
    end
end

local function SetDestoryTime(inst, time)
    inst:DoTaskInTime(time, function ()
        inst.AnimState:PlayAnimation("despawn")
        inst.SoundEmitter:KillSound("protecting")
        inst:ListenForEvent("animover", function ()
            inst:Remove()
        end)
    end)
end

local function wind_wall_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("yasuo_wind_wall")
    inst.AnimState:SetBuild("yasuo_wind_wall")
    inst.AnimState:PlayAnimation("spawn")
    inst.AnimState:PushAnimation("idle", true)
    inst.AnimState:SetRayTestOnBB(true)
    inst.AnimState:SetLightOverride(0.1)
	inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")

    inst.Transform:SetSixFaced()
    inst.Transform:SetScale(2, 2, 2)

    inst:AddTag("NOCLICK")

    inst.SoundEmitter:PlaySound("yasuo/yasuo_sfx/wind_wall_protecting_4s", "protecting")

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

    inst:DoPeriodicTask(0, DestoryProjectile)
    inst.SetDestoryTime = SetDestoryTime

    inst.persists = false

    return inst
end

local function sweeping_blade_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("yasuo_sweeping_blade_fx")
    inst.AnimState:SetBuild("yasuo_sweeping_blade_fx")
    inst.AnimState:PlayAnimation("sweeping_blade_circle")

    inst.Transform:SetFourFaced()

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

    inst:ListenForEvent("animover", inst.Remove)

    inst.persists = false

    return inst
end

return Prefab("yasuo_shadow_lunge_fx", steel_tempest_fn, assets_steel_tempest),
       Prefab("yasuo_tornado", tornado_fn),
       Prefab("yasuo_steel_tempest_flow", steel_tempest_flow_fn),
       Prefab("yasuo_wind_wall", wind_wall_fn, assets_wind_wall),
       Prefab("yasuo_sweeping_blade_fx", sweeping_blade_fn, assets_sweeping_blade)