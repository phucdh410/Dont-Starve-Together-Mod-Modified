local assets = {
    Asset("ANIM", "anim/kkr_dragon_meat.zip"),
    Asset("ATLAS", "images/inventoryimages/kkr_dragon_meat.xml"),
    Asset("IMAGE", "images/inventoryimages/kkr_dragon_meat.tex")
}

local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("kkr_dragon_meat")
    inst.AnimState:SetBuild("kkr_dragon_meat")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("meat")

    MakeInventoryFloatable(inst)

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")

    inst.components.inventoryitem.atlasname = "images/inventoryimages/kkr_dragon_meat.xml"
    inst.components.inventoryitem.imagename = "kkr_dragon_meat"

    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.MEAT
    inst.components.edible.ismeat = true
    inst.components.edible.hungervalue = 25
    inst.components.edible.healthvalue = 15
    inst.components.edible.sanityvalue = 20

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_SLOW)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("tradable")
    inst.components.tradable.goldvalue = 3

    MakeHauntableLaunch(inst)

    return inst
end
return Prefab("kkr_dragon_meat", fn, assets)
