require "prefabutil"

local assets = {
    Asset("ANIM", "anim/kkr_wind_spirit.zip")
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()

    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeTinyFlyingCharacterPhysics(inst, 1, .5)

    inst:AddTag("NOCLICK")
    inst:AddTag("NOBLOCK")
    inst:AddTag("ignorewalkableplatformdrowning")
    inst:AddTag("kkr_wind_spirit")

    inst.Transform:SetEightFaced()

    inst.AnimState:SetBank("kkr_wind_spirit")
    inst.AnimState:SetBuild("kkr_wind_spirit")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetRayTestOnBB(true)
    inst.AnimState:SetLightOverride(.3)

    MakeInventoryFloatable(inst)
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    inst:AddComponent("locomotor")
    inst.components.locomotor:EnableGroundSpeedMultiplier(false)
    inst.components.locomotor:SetTriggersCreep(false)
    inst.components.locomotor.walkspeed = 4
    inst.components.locomotor.runspeed = 6
    inst.components.locomotor.pathcaps = {allowocean = true}

    inst:AddComponent("follower")

    return inst
end

local function fn_kkr_wind_spirit_leader()
    local inst = CreateEntity()

    inst.entity:AddTransform()

    inst:AddTag("NOCLICK")
    inst:AddTag("NOBLOCK")
    inst:AddTag("formationleader")
    inst:AddComponent("kkrspiritleader")

    return inst
end
return Prefab("kkr_wind_spirit", fn, assets), Prefab("kkr_wind_spirit_leader", fn_kkr_wind_spirit_leader)
