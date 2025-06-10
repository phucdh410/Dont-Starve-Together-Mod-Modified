local assets = {
    Asset("ANIM", "anim/kkr_flower_ribbon.zip"),
    Asset("ANIM", "anim/kkr_flower_ribbon_head.zip"),
    Asset("ATLAS", "images/inventoryimages/kkr_flower_ribbon.xml"),
    Asset("IMAGE", "images/inventoryimages/kkr_flower_ribbon.tex")
}

local function onequip(inst, owner)
    if not owner then
        return
    end

    if owner:HasTag("kkr") then
        owner.AnimState:OverrideSymbol("headbase", "kkr_flower_ribbon_head", "headbase")
        owner.AnimState:OverrideSymbol("headbase_hat", "kkr_flower_ribbon_head", "headbase_hat")
    else
        owner:DoTaskInTime(
            0,
            function()
                local inventory = owner.components.inventory
                if inventory then
                    inventory:DropItem(inst)
                end
            end
        )
    end
end

local function onunequip(inst, owner)
    if owner:HasTag("kkr") then
        owner.AnimState:ClearOverrideSymbol("headbase")
        owner.AnimState:ClearOverrideSymbol("headbase_hat")
    end
end

local function onload(inst, data)
end

local function onsave(inst, data)
end

local function fn(Sim)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("kkr_flower_ribbon")
    inst.AnimState:SetBuild("kkr_flower_ribbon")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("amulet")

    MakeInventoryFloatable(inst, "med", nil, 0.75)

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddTag("meteor_protection")
    inst:AddTag("nosteal")
    inst:AddTag("NORATCHECK")
    inst:AddTag("kkr_sewing")

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/kkr_flower_ribbon.xml"

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.NECK or EQUIPSLOTS.HEAD

    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.equippable.walkspeedmult = 1.05
    inst.components.equippable.dapperness = 5 / 60
    inst.components.equippable.restrictedtag = "kkr"

    inst.OnSave = onsave
    inst.OnPreLoad = onload

    return inst
end

return Prefab("kkr_flower_ribbon", fn, assets)
