local assets = {
    Asset("ANIM", "anim/ea_jinkela_ash.zip"),
    Asset("IMAGE", "images/inventoryimages/ea_jinkela_ash.tex"),
    Asset("ATLAS", "images/inventoryimages/ea_jinkela_ash.xml"),
}


local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("ea_jinkela_ash")
    inst.AnimState:SetBuild("ea_jinkela_ash")
    inst.AnimState:PlayAnimation("idle")

    MakeInventoryFloatable(inst, "small", 0.2, 0.95)

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_TINYITEM

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/ea_jinkela_ash.xml" --物品贴图

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("ea_jinkela_ash", fn, assets)