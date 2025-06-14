local assets = {
    Asset("ANIM", "anim/kkr_pocket.zip"),
    Asset("IMAGE", "images/inventoryimages/kkr_pocket.tex"),
    Asset("ATLAS", "images/inventoryimages/kkr_pocket.xml")
}
local function onopen(inst)
    inst.AnimState:PlayAnimation("open")
    if inst.components.inventoryitem then
        inst.components.inventoryitem:ChangeImageName("kkr_pocket_open")
    end
end

local function onclose(inst)
    inst.AnimState:PlayAnimation("closed")
    if inst.components.inventoryitem then
        inst.components.inventoryitem:ChangeImageName("kkr_pocket")
    end
end

local function SeedPreserverRate(inst, item)
    return (item ~= nil and item:HasTag("deployedfarmplant")) and 0.5 or nil
end

local function topocket(inst, picker)
    if not picker then
        return
    end
    if not picker:HasTag("kkr") then
        if picker.components.inventory then
            picker:DoTaskInTime(
                0,
                function()
                    local inventory = picker.components.inventory
                    if inventory then
                        inventory:DropItem(inst)
                    end
                end
            )
        end
    end
    local items = picker.components.inventory:ReferenceAllItems()
    for _, item in ipairs(items) do
        if item.prefab == "kkr_pocket" or item.prefab == "kkr_pocket_plus" then
            if picker.components.inventory then
                picker:DoTaskInTime(
                    0,
                    function()
                        local inventory = picker.components.inventory
                        if inventory then
                            inventory:DropItem(inst)
                        end
                    end
                )
            end
        end
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst, "med", nil, 0.75)

    inst.AnimState:SetBank("kkr_pocket")
    inst.AnimState:SetBuild("kkr_pocket")
    inst.AnimState:PlayAnimation("closed")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        inst.OnEntityReplicated = function(inst)
            inst.replica.container:WidgetSetup("kkr_pocket")
        end
        return inst
    end

    inst:AddTag("meteor_protection")

    inst:AddTag("nosteal")
    inst:AddTag("NORATCHECK")

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/kkr_pocket.xml"
    inst.components.inventoryitem.imagename = "kkr_pocket"
    inst.components.inventoryitem.onpickupfn = topocket

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("kkr_pocket")
    inst.components.container.skipclosesnd = true
    inst.components.container.skipopensnd = true
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
    inst:AddComponent("preserver")
    inst.components.preserver:SetPerishRateMultiplier(SeedPreserverRate)

    MakeHauntableLaunchAndPerish(inst)
    return inst
end

return Prefab("kkr_pocket", fn, assets)
