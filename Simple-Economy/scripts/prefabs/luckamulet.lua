local assets = {
    Asset("ANIM", "anim/luckamulet.zip"),
    Asset("ATLAS", "images/inventoryimages/luckamulet.xml")
}

local function getcoin(inst, chance)
    if math.random(0, 100) <= chance then
        local owner = inst.components.inventoryitem.owner
        if owner ~= nil then
            local pt = Point(owner.Transform:GetWorldPosition())
            local loots = SpawnPrefab("secoin")
            loots.components.secoin.amount = math.random(5, 12)
            local angle = math.random() * 2 * PI
            loots.Transform:SetPosition(pt.x, pt.y, pt.z)
            loots.Physics:SetVel(2 * math.cos(angle), 10, 2 * math.sin(angle))
            loots:DoTaskInTime(
                .3,
                function()
                    if owner.components.seplayerstatus ~= nil then
                        owner.components.seplayerstatus:givesecoin(loots)
                    end
                end
            )
            inst.components.finiteuses:Use(1)
        end
    end
end

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_body", "luckamulet", "picture")

    inst.onwalk = function()
        if owner.components.locomotor.wantstomoveforward and math.random(0, 333) <= 1 then
            getcoin(inst, 15)
        end
    end

    inst.get1 = function()
        getcoin(inst, 50)
    end

    inst.get2 = function()
        getcoin(inst, 25)
    end

    inst.get3 = function()
        getcoin(inst, 10)
    end

    inst.get4 = function()
        getcoin(inst, 25)
    end

    inst:ListenForEvent("locomote", inst.onwalk, owner)
    inst:ListenForEvent("picksomething", inst.get4, owner)
    inst:ListenForEvent("working", inst.get3, owner)
    inst:ListenForEvent("oneat", inst.get3, owner)
    inst:ListenForEvent("fishingstrain", inst.get1, owner)
    inst:ListenForEvent("refreshcrafting", inst.get2, owner)
    inst:ListenForEvent("attacked", inst.get3, owner)
end

local function onunequip(inst, owner)
    owner.AnimState:ClearOverrideSymbol("swap_body")

    inst:RemoveEventCallback("locomote", inst.onwalk, owner)
    inst:RemoveEventCallback("picksomething", inst.get4, owner)
    inst:RemoveEventCallback("working", inst.get3, owner)
    inst:RemoveEventCallback("oneat", inst.get3, owner)
    inst:RemoveEventCallback("fishingstrain", inst.get1, owner)
    inst:RemoveEventCallback("refreshcrafting", inst.get2, owner)
    inst:RemoveEventCallback("attacked", inst.get3, owner)
end

local function fn(Sim)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()

    inst.alreadybuild = false

    anim:SetBank("ground")
    anim:SetBuild("luckamulet")
    anim:PlayAnimation("idle")

    inst:AddComponent("inspectable")

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/luckamulet.xml"

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.NECK or EQUIPSLOTS.BODY
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetOnFinished(inst.Remove)
    inst.components.finiteuses:SetMaxUses(300)
    inst.components.finiteuses:SetUses(300)

    return inst
end

return Prefab("common/inventory/luckamulet", fn, assets)
