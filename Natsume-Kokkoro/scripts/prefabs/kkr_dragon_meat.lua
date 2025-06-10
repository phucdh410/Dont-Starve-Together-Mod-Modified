local assets =
{
    Asset("ANIM", "anim/kkr_dragon_meat.zip"),  --地上的动画

	Asset("ATLAS", "images/inventoryimages/kkr_dragon_meat.xml"), --加载物品栏贴图
    Asset("IMAGE", "images/inventoryimages/kkr_dragon_meat.tex"),
}

local function fn()

    local inst = CreateEntity() -- 创建实体
    inst.entity:AddTransform() -- 添加xyz形变对象
    inst.entity:AddAnimState() -- 添加动画状态
    inst.entity:AddNetwork() -- 添加这一行才能让所有客户端都能看到这个实体

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("kkr_dragon_meat") -- 地上动画
    inst.AnimState:SetBuild("kkr_dragon_meat") -- 材质包，就是anim里的zip包
    inst.AnimState:PlayAnimation("idle") -- 默认播放哪个动画

    inst:AddTag("meat")

    MakeInventoryFloatable(inst)
    --------------------------------------------------------------------------
    if not TheWorld.ismastersim then
        return inst
    end
    --------------------------------------------------------------------------
    inst:AddComponent("inspectable") -- 可检查组件

    inst:AddComponent("inventoryitem") -- 物品组件

    inst.components.inventoryitem.atlasname = "images/inventoryimages/kkr_dragon_meat.xml" -- 在背包里的贴图
    inst.components.inventoryitem.imagename = "kkr_dragon_meat"

    inst:AddComponent("edible") -- 可食物组件
    inst.components.edible.foodtype = FOODTYPE.MEAT
    inst.components.edible.ismeat = true
    inst.components.edible.hungervalue = 25
    inst.components.edible.healthvalue = 15
    inst.components.edible.sanityvalue = 20


    inst:AddComponent("perishable") -- 可腐烂的组件
    inst.components.perishable:SetPerishTime(TUNING.PERISH_SLOW)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food" -- 腐烂后变成腐烂食物

    inst:AddComponent("stackable") -- 可堆叠
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("tradable")
    inst.components.tradable.goldvalue = 3

    MakeHauntableLaunch(inst)

    return inst
end
return Prefab("kkr_dragon_meat", fn, assets)