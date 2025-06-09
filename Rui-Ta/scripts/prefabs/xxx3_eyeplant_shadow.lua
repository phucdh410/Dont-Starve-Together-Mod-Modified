local assets = {
    Asset('ANIM', 'anim/xxx3_eyeplant_shadow.zip'),
    Asset('SOUND', 'sound/plant.fsb')
}

local function checkmaster(tar, inst)
    if inst.xxx3_minionlord then
        return tar == inst.xxx3_minionlords
    end

    if tar.xxx3_minionlord and inst.xxx3_minionlord then
        return tar.xxx3_minionlord == inst.xxx3_minionlord
    else
        return false
    end
end

local RETARGET_MUST_TAGS = {'_combat', '_health'}
local RETARGET_CANT_TAGS = {'INLIMBO', 'plantkin'}
local RETARGET_ONEOF_TAGS = {'character', 'monster', 'animal', 'prey', 'epic'}
local function retargetfn(inst)
    return FindEntity(
        inst,
        2.2,
        function(guy)
            return not (guy.components.health:IsDead() or checkmaster(guy, inst) or guy:HasTag('eyeplant_friend'))
        end,
        RETARGET_MUST_TAGS, -- see entityreplica.lua
        RETARGET_CANT_TAGS,
        RETARGET_ONEOF_TAGS
    )
end

local function shouldKeepTarget(inst, target)
    if target and target:IsValid() and target.components.health and not target.components.health:IsDead() then
        local distsq = target:GetDistanceSqToInst(inst)

        return distsq < TUNING.EYEPLANT_STOPATTACK_DIST * TUNING.EYEPLANT_STOPATTACK_DIST
    else
        return false
    end
end

local function onnewcombattarget(inst, data)
    if
        data.target and not inst.sg:HasStateTag('attack') and not inst.sg:HasStateTag('hit') and
            not inst.components.health:IsDead()
     then
        inst.sg:GoToState('attack')
    end
end

local function ongotnewitem(inst, data)
    --print ("got item", data.item)
    --print (debugstack())
    if data.item.components.health ~= nil then
        inst:DoTaskInTime(0, inst.PushBufferedAction, BufferedAction(inst, data.item, ACTIONS.MURDER))
    end
end

---------------------------------------------------------------------------------

local function RecycleHorrorDebuffFX(fx, pool)
    fx:RemoveFromScene()
    table.insert(pool, fx)
end

local function OnUpdate_HorrorFuel(target, attacker, data, endtime, first)
    if
        not (target.components.health and target.components.health:IsDead()) and target.components.combat and
            target.components.combat:CanBeAttacked()
     then
        local rnd = math.random(math.clamp(6 - #data.tasks, 2, 6 / 2))
        local variation = data.variations[rnd]
        for i = rnd, 6 - 1 do
            data.variations[i] = data.variations[i + 1]
        end
        data.variations[6] = variation

        local fx
        if #data.pool > 0 then
            fx = table.remove(data.pool)
            fx:ReturnToScene()
        else
            fx = SpawnPrefab('slingshotammo_horrorfuel_debuff_fx')
            fx.pool = data.pool
            fx.onrecyclefn = RecycleHorrorDebuffFX
        end
        fx.entity:SetParent(target.entity)
        fx:Restart(attacker, target, variation, data.pool, first)
    end

    if GetTime() >= endtime then
        table.remove(data.tasks, 1):Cancel()
        if #data.tasks <= 0 then
            for i, v in ipairs(data.pool) do
                v:Remove()
            end
            target._xxx3_horror = nil
        end
    end
end

local function OnHitOther(inst, target)
    if target and target:IsValid() then
        local data = target._xxx3_horror
        if data == nil then
            data = {tasks = {}, variations = {}, pool = {}}
            for i = 1, 6 do
                table.insert(data.variations, math.random(i), i)
            end
            target._xxx3_horror = data
        end

        local numticks = 5
        local endtime = GetTime() + (numticks - 1) - 0.001
        table.insert(data.tasks, target:DoPeriodicTask(1, OnUpdate_HorrorFuel, nil, inst, data, endtime))
        OnUpdate_HorrorFuel(target, inst, data, endtime, true)
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddLight()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, .1)

    inst.Transform:SetFourFaced()

    inst.AnimState:SetBank('xxx3_eyeplant_shadow')
    inst.AnimState:SetBuild('xxx3_eyeplant_shadow')
    inst.AnimState:PlayAnimation('spawn')
    inst.AnimState:PushAnimation('idle')

    inst.Light:SetFalloff(0.5)
    inst.Light:SetIntensity(0.8)
    inst.Light:SetRadius(0.4)
    inst.Light:SetColour(204 / 255, 0 / 255, 255 / 255, 0.4)
    inst.Light:Enable(false)

    inst:AddTag('eyeplant')
    inst:AddTag('veggie')
    inst:AddTag('smallcreature')
    inst:AddTag('hostile')
    inst:AddTag('xxx3_eyeplant')
    inst:AddTag('shadow_aligned')

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent('locomotor')
    inst.components.locomotor:SetSlowMultiplier(1)
    inst.components.locomotor:SetTriggersCreep(false)
    inst.components.locomotor.pathcaps = {ignorecreep = true}
    inst.components.locomotor.walkspeed = 0

    inst:AddComponent('combat')
    inst.components.combat:SetAttackPeriod(1.75)
    inst.components.combat:SetRange(2.5)
    inst.components.combat:SetRetargetFunction(0.2, retargetfn)
    inst.components.combat:SetKeepTargetFunction(shouldKeepTarget)
    inst.components.combat:SetDefaultDamage(15)
    inst.components.combat.onhitotherfn = OnHitOther

    inst:AddComponent('planarentity')
    inst:AddComponent('planardamage')
    inst.components.planardamage:SetBaseDamage(10)

    inst:ListenForEvent('newcombattarget', onnewcombattarget)

    inst:ListenForEvent('gotnewitem', ongotnewitem)

    inst:AddComponent('health')
    inst.components.health:SetMaxHealth(50)

    inst:AddComponent('eater')
    inst.components.eater:SetDiet({FOODTYPE.MEAT}, {FOODTYPE.MEAT})

    inst:AddComponent('inventory')

    inst:AddComponent('inspectable')

    inst:SetStateGraph('SGxxx3_eyeplant_3')

    inst:AddComponent('lootdropper')

    MakeSmallBurnable(inst)
    MakeMediumPropagator(inst)
    inst:DoPeriodicTask(
        2 + math.random() * 2,
        function()
            if inst.master ~= nil and not inst.master:IsValid() then
                inst.components.health:Kill()
            end
            if TheWorld:HasTag('cave') or TheWorld.state.isnight then
                inst.Light:Enable(true)
            else
                inst.Light:Enable(false)
            end
        end
    )

    MakeHauntableIgnite(inst)
    inst.owner = nil
    inst.persists = false

    return inst
end

return Prefab('xxx3_eyeplant_shadow', fn, assets)
