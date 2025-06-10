require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/kkr_wind_spirit.zip"),

}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    -- inst.entity:AddDynamicShadow()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()


    MakeTinyFlyingCharacterPhysics(inst, 1, .5)

    inst:AddTag("NOCLICK")  --无视鼠标
    inst:AddTag("NOBLOCK")  --不妨碍玩家摆放建筑物
    inst:AddTag("ignorewalkableplatformdrowning")
    inst:AddTag("kkr_wind_spirit")

    inst.Transform:SetEightFaced()

    inst.AnimState:SetBank("kkr_wind_spirit")
    inst.AnimState:SetBuild("kkr_wind_spirit")
    inst.AnimState:PlayAnimation("idle",true)
    inst.AnimState:SetRayTestOnBB(true)
    inst.AnimState:SetLightOverride(.3)
    -- inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    -- inst.DynamicShadow:SetSize(.8, .5)
    MakeInventoryFloatable(inst)
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false



    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor:EnableGroundSpeedMultiplier(false)
    inst.components.locomotor:SetTriggersCreep(false)
    inst.components.locomotor.walkspeed = 4    --苍蝇是8
    inst.components.locomotor.runspeed = 6 --苍蝇是12
    inst.components.locomotor.pathcaps = { allowocean = true }

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
    --[[Non-networked entity]]

	return inst
end
return Prefab("kkr_wind_spirit", fn, assets),
Prefab("kkr_wind_spirit_leader", fn_kkr_wind_spirit_leader)
