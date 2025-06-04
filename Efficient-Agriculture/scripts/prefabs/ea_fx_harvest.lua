local assets =
{
    Asset("ANIM", "anim/ea_fx_harvest.zip"),
}


local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    -- inst.Transform:SetEightFaced()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("ea_fx_harvest")
    inst.AnimState:SetBuild("ea_fx_harvest")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

    inst:ListenForEvent("animover", inst.Remove)

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("ea_fx_harvest", fn, assets)