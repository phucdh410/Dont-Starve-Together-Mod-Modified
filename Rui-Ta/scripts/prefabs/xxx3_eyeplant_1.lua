local assets =
{
    Asset("ANIM", "anim/xxx3_eyeplant_1.zip"),
    Asset("SOUND", "sound/plant.fsb"),
}

local function checkmaster(tar, inst)
    if inst.xxx3_minionlord then
        return tar == inst.xxx3_minionlord
    end

    if tar.xxx3_minionlord and inst.xxx3_minionlord then
        return tar.xxx3_minionlord == inst.xxx3_minionlord
    else
        return false
    end
end

local RETARGET_MUST_TAGS = { "_combat", "_health" }
local RETARGET_CANT_TAGS = { "INLIMBO", "plantkin" }
local RETARGET_ONEOF_TAGS = { "character", "monster", "animal", "prey", "epic" }
local function retargetfn(inst)
    return FindEntity(
        inst,
        3.2,
        function(guy)
            return not (guy.components.health:IsDead() or checkmaster(guy, inst)or guy:HasTag("eyeplant_friend"))
        end,
        RETARGET_MUST_TAGS, -- see entityreplica.lua
        RETARGET_CANT_TAGS,
        RETARGET_ONEOF_TAGS
    )
end

local function shouldKeepTarget(inst, target)
    if target and target:IsValid() and target.components.health and not target.components.health:IsDead() then
        local distsq = target:GetDistanceSqToInst(inst)

        return distsq < 36
    else
        return false
    end
end

local function onnewcombattarget(inst, data)
    if data.target and not inst.sg:HasStateTag("attack") and not inst.sg:HasStateTag("hit") and not inst.components.health:IsDead() then
        inst.sg:GoToState("attack")
    end
end

local function ongotnewitem(inst, data)
    --print ("got item", data.item)
    --print (debugstack())
    if data.item.components.health ~= nil then
        inst:DoTaskInTime(0, inst.PushBufferedAction, BufferedAction(inst, data.item, ACTIONS.MURDER))
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, .1)

    inst.Transform:SetFourFaced()

    inst.AnimState:SetBank("xxx3_eyeplant_1")
    inst.AnimState:SetBuild("xxx3_eyeplant_1")
    inst.AnimState:PlayAnimation("spawn")
    inst.AnimState:PushAnimation("idle")

    inst:AddTag("eyeplant")
    inst:AddTag("veggie")
    inst:AddTag("smallcreature")
    inst:AddTag("hostile")
    inst:AddTag("xxx3_eyeplant")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("locomotor")
    inst.components.locomotor:SetSlowMultiplier( 1 )
    inst.components.locomotor:SetTriggersCreep(false)
    inst.components.locomotor.pathcaps = { ignorecreep = true }
    inst.components.locomotor.walkspeed = 0

    inst:AddComponent("combat")
    inst.components.combat:SetAttackPeriod(TUNING.EYEPLANT_ATTACK_PERIOD)
    inst.components.combat:SetRange(3.2)
    inst.components.combat:SetRetargetFunction(0.2, retargetfn)
    inst.components.combat:SetKeepTargetFunction(shouldKeepTarget)
    inst.components.combat:SetDefaultDamage(TUNING.EYEPLANT_DAMAGE)

    inst:ListenForEvent("newcombattarget", onnewcombattarget)

    inst:ListenForEvent("gotnewitem", ongotnewitem)

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(30)

    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.MEAT }, { FOODTYPE.MEAT })

    inst:AddComponent("inventory")

    inst:AddComponent("inspectable")

    inst:SetStateGraph("SGxxx3_eyeplant_1")

    inst:AddComponent("lootdropper")
    inst:DoPeriodicTask(2+math.random()*2,function ()
        if inst.master ~= nil and not inst.master:IsValid() then
            inst.components.health:Kill()
        end
    end)

    MakeSmallBurnable(inst)
    MakeMediumPropagator(inst)

    MakeHauntableIgnite(inst)
    inst.cloudincd = false
    inst.owner = nil
    inst.persists = false

    return inst
end

return Prefab("xxx3_eyeplant_1", fn, assets)