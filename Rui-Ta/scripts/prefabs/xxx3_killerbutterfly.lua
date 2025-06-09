local brain = require 'brains/xxx3_killerbutterfly_brain'

local function NormalRetargetFn(inst)
    return FindEntity(
        inst,
        TUNING.PIG_TARGET_DIST,
        function(guy)
            return guy:HasTag('monster') and guy.components.health and not guy.components.health:IsDead() and
                inst.components.combat:CanTarget(guy)
        end,
        nil,
        {'character'},
        nil
    )
end

local function makebutterfly(name, build, ex1, ex2)
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddDynamicShadow()
        inst.entity:AddNetwork()

        MakeTinyFlyingCharacterPhysics(inst, 1, .5)

        inst.DynamicShadow:SetSize(.8, .5)

        inst.Transform:SetTwoFaced()

        inst.AnimState:SetBuild(build)
        inst.AnimState:SetBank('butterfly')
        inst.AnimState:PlayAnimation('idle')
        inst.AnimState:SetRayTestOnBB(true)

        inst:AddTag('butterfly')
        inst:AddTag('killerbutterfly')
        inst:AddTag('flying')
        inst:AddTag('insect')
        inst:AddTag('smallcreature')
        inst:AddTag('notarget')

        MakeInventoryFloatable(inst)

        MakeFeedableSmallLivestockPristine(inst)

        if ex1 then
            ex1(inst)
        end

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst.persists = false

        inst:AddComponent('combat')
        inst.components.combat:SetDefaultDamage(15)
        inst.components.combat:SetAttackPeriod(1)
        inst.components.combat:SetRange(1.5, 1.5)
        inst.components.combat:SetRetargetFunction(3, NormalRetargetFn)

        inst:AddComponent('follower')

        inst:AddComponent('health')
        inst.components.health:SetMaxHealth(1)
        inst.components.health.absorb = 1
        inst.components.health.fire_damage_scale = 0
        inst.components.health.invincible = true

        inst:AddComponent('inspectable')

        inst:AddComponent('locomotor')
        inst.components.locomotor:EnableGroundSpeedMultiplier(false)
        inst.components.locomotor:SetTriggersCreep(false)
        inst.components.locomotor.walkspeed = 5
        inst:SetStateGraph('SGxxx3_killerbutterfly')

        inst:SetBrain(brain)

        if ex2 then
            ex2(inst)
        end

        return inst
    end

    return Prefab(name, fn)
end

return makebutterfly('xxx3_killerbutterfly', 'butterfly_basic', nil, nil), makebutterfly(
    'xxx3_killerbutterfly_shadow',
    'butterfly_basic',
    function(inst)
        inst.AnimState:SetMultColour(0, 0, 0, .5)
    end,
    function(inst)
        inst:AddComponent('planardamage')
        inst.components.planardamage:SetBaseDamage(5)

        inst:AddComponent('damagetypebonus')
        inst.components.damagetypebonus:AddBonus('lunar_aligned', inst, 1.5)
    end
), makebutterfly(
    'xxx3_killerbutterfly_lunar',
    'butterfly_moon',
    function(inst)
        inst:AddTag('crazy')
    end,
    function(inst)
        inst:AddComponent('planardamage')
        inst.components.planardamage:SetBaseDamage(5)

        inst:AddComponent('damagetypebonus')
        inst.components.damagetypebonus:AddBonus('shadow_aligned', inst, 1.5)
    end
)
