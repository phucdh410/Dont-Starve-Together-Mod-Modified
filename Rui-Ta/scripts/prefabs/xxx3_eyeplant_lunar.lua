local assets = {
    Asset('ANIM', 'anim/xxx3_eyeplant_lunar.zip')
}

local exclude_tags = {'INLIMBO', 'wall', 'structure', 'eyeplant_friend'}

local function doattack(inst)
    local x, y, z = inst.Transform:GetWorldPosition()

    local pulse_fx = SpawnPrefab('moonpulse_fx')
    pulse_fx.Transform:SetScale(3, 2, 3)
    pulse_fx.Transform:SetPosition(x, 0, z)

    local ents = TheSim:FindEntities(x, 0, z, 15, {'_combat', '_health'}, exclude_tags)
    for i, v in ipairs(ents) do
        if not v.components.health:IsDead() then
            inst.components.combat:DoAttack(v)
            if v.components.combat.target and v.components.combat.target:HasTag('eyeplant_friend') then
                v.components.combat:DropTarget(false)
            end
        end
    end

    for i = 1, 15 do
        inst:DoTaskInTime(
            2 * math.random(),
            function()
                local rad = math.random(4, 16)
                local arc = math.random(0, 360)
                local a, b, c = x + rad * math.cos(arc), 0, z + rad * math.sin(arc)

                local projectile = SpawnPrefab('xxx3_eyeplant_lunar_projectile')
                projectile.owner = inst
                projectile.Transform:SetPosition(a, b, c)
            end
        )
    end

    inst:DoTaskInTime(5, doattack)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank('xxx3_eyeplant_lunar')
    inst.AnimState:SetBuild('xxx3_eyeplant_lunar')
    inst.AnimState:PlayAnimation('open')
    inst.AnimState:PushAnimation('idle', true)
    inst.AnimState:SetLightOverride(1)

    inst.Transform:SetScale(3, 3, 3)

    inst:AddTag('eyeplant')
    inst:AddTag('veggie')
    inst:AddTag('hostile')
    inst:AddTag('xxx3_eyeplant')
    inst:AddTag('lunar_aligned')

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.owner = nil

    inst:AddComponent('inspectable')

    inst:AddComponent('combat')
    inst.components.combat.ignorehitrange = true
    inst.components.combat:SetDefaultDamage(50)

    inst:AddComponent('planardamage')
    inst.components.planardamage:SetBaseDamage(50)

    inst:DoTaskInTime(2.5, doattack)

    inst:DoPeriodicTask(
        1,
        function()
            if (inst.owner and inst.owner._lunarbulb == nil) or inst.owner == nil then
                inst.AnimState:PlayAnimation('close')
                inst:ListenForEvent(
                    'animover',
                    function()
                        inst:Remove()
                    end
                )
            end
        end
    )

    inst.persists = false

    return inst
end

----------------------------------------------------------------------

local function do_landed(inst)
    ShakeAllCameras(CAMERASHAKE.VERTICAL, .5, 0.1, 0.1, inst, 35)

    local attacker = (inst.owner ~= nil and inst.owner:IsValid() and inst.owner) or inst
    local attacker_combat = attacker.components.combat

    local x, y, z = inst.Transform:GetWorldPosition()
    local potential_targets = TheSim:FindEntities(x, y, z, 5.5, {'_combat', '_health'}, exclude_tags)
    for _, target in ipairs(potential_targets) do
        if target:IsValid() then
            if not target.components.health:IsDead() then
                if attacker_combat ~= nil then
                    attacker_combat:DoAttack(target)
                elseif target.components.combat ~= nil then
                    target.components.combat:GetAttacked(attacker, 50)
                end
            end
        end
    end
end

local function explode(inst)
    local attacker = (inst.owner ~= nil and inst.owner:IsValid() and inst.owner) or inst
    local attacker_combat = attacker.components.combat

    local x, y, z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, y, z, 5.5, {'_combat', '_health'}, exclude_tags)
    for i, v in ipairs(ents) do
        if not v.components.health:IsDead() then
            if attacker_combat ~= nil then
                attacker_combat:DoAttack(v)
            elseif v.components.combat ~= nil then
                v.components.combat:GetAttacked(attacker, 50)
            end

            if v.components.combat.target and v.components.combat.target:HasTag('eyeplant_friend') then
                v.components.combat:DropTarget(false)
            end
        end
    end

    local fx = SpawnPrefab('beefalo_transform_fx')
    fx.Transform:SetScale(1.3, 1, 1.3)
    fx.Transform:SetPosition(x, y, z)

    inst:Remove()
end

local function projectile_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddLight()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.Light:SetIntensity(0.7)
    inst.Light:SetRadius(1.5)
    inst.Light:SetFalloff(0.85)
    inst.Light:SetColour(0.05, 0.05, 1)

    inst.AnimState:SetBank('alterguardian_meteor')
    inst.AnimState:SetBuild('alterguardian_meteor')
    inst.AnimState:PlayAnimation('meteor_pre')

    inst.SoundEmitter:PlaySound('moonstorm/creatures/boss/alterguardian3/atk_traps')

    inst:AddTag('FX')
    inst:AddTag('NOCLICK')

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

    inst.owner = nil

    inst:DoTaskInTime(31 * FRAMES, do_landed)
    inst:ListenForEvent('animover', explode)

    inst.persists = false

    return inst
end

return Prefab('xxx3_eyeplant_lunar', fn, assets), Prefab('xxx3_eyeplant_lunar_projectile', projectile_fn, assets)
