local assets = {
    Asset("ANIM", "anim/kkr_flower_amulet.zip"),
    Asset("ANIM", "anim/kkr_flower_amulet_head.zip"),
    Asset("ATLAS", "images/inventoryimages/kkr_flower_amulet.xml"),
    Asset("IMAGE", "images/inventoryimages/kkr_flower_amulet.tex")
}

local function ShouldAcceptItem(inst, item)
    if item.prefab == "opalpreciousgem" then
        return true
    end
    return false
end

local function OnGetItemFromPlayer(inst, giver, item)
    if item.prefab == "opalpreciousgem" then
        inst:Remove()
        giver.components.inventory:GiveItem(SpawnPrefab("kkr_ameth_amulet"))
    end
end

local function CreateLight(owner)
    if owner and not owner._kkr_light then
        local light = SpawnPrefab("kkr_light")

        owner:AddChild(light)

        light.Transform:SetPosition(0, 0, 0)

        owner._kkr_light = light
    end
end

local function RemoveLight(owner)
    if owner._kkr_light then
        owner._kkr_light:Remove()
        owner._kkr_light = nil
    end
end

local function OnSanityDelta(owner)
    if owner and owner.components.sanity then
        if owner.components.sanity.current > 120 then
            CreateLight(owner)
        else
            RemoveLight(owner)
        end
    end
end

local function onequip(inst, owner)
    if not owner then
        return
    end

    if owner:HasTag("kkr") then
        owner.AnimState:OverrideSymbol("headbase", "kkr_flower_amulet_head", "headbase")
        owner.AnimState:OverrideSymbol("headbase_hat", "kkr_flower_amulet_head", "headbase_hat")
        inst:ListenForEvent("sanitydelta", OnSanityDelta, owner)
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
        inst:RemoveEventCallback("sanitydelta", OnSanityDelta, owner)
        RemoveLight(owner)
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

    inst.AnimState:SetBank("kkr_flower_amulet")
    inst.AnimState:SetBuild("kkr_flower_amulet")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("amulet")

    MakeInventoryFloatable(inst, "med", nil, 0.75)

    inst.entity:SetPristine()

    inst:AddTag("meteor_protection")
    inst:AddTag("nosteal")
    inst:AddTag("NORATCHECK")
    inst:AddTag("kkr_sewing")

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/kkr_flower_amulet.xml"

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.NECK or EQUIPSLOTS.HEAD
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.equippable.walkspeedmult = 1.2
    inst.components.equippable.dapperness = 5 / 60
    inst.components.equippable.restrictedtag = "kkr"

    inst:AddComponent("trader")
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader:SetAcceptTest(ShouldAcceptItem)

    inst.OnSave = onsave
    inst.OnPreLoad = onload

    return inst
end

return Prefab("kkr_flower_amulet", fn, assets)
