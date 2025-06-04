local assets = {
    Asset("ANIM", "anim/ea_fx_trans.zip"),
}


local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    inst.Transform:SetEightFaced()

    inst.AnimState:SetBank("ea_fx_trans")
    inst.AnimState:SetBuild("ea_fx_trans")
    inst.AnimState:PlayAnimation("idle")

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

    inst:ListenForEvent("animover", inst.Remove)

    return inst
end


return Prefab("ea_fx_trans", fn, assets)