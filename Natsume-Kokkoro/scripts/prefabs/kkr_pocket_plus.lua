local assets = {
    Asset("ANIM", "anim/kkr_pocket_plus.zip"),
    Asset("IMAGE", "images/inventoryimages/kkr_pocket_plus.tex"),
    Asset("ATLAS", "images/inventoryimages/kkr_pocket_plus.xml")
}
local function onopen(inst)
    inst.AnimState:PlayAnimation("open")
    if inst.components.inventoryitem then
        inst.components.inventoryitem:ChangeImageName("kkr_pocket_plus_open")
    end
end

local function onclose(inst)
    inst.AnimState:PlayAnimation("closed")
    if inst.components.inventoryitem then
        inst.components.inventoryitem:ChangeImageName("kkr_pocket_plus")
    end
end

local function PreserverRate(inst, item)
    return (item ~= nil and item:HasTag("deployedfarmplant")) and 0.1 or 0.5
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

    inst.AnimState:SetBank("kkr_pocket_plus")
    inst.AnimState:SetBuild("kkr_pocket_plus")
    inst.AnimState:PlayAnimation("closed")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        inst.OnEntityReplicated = function(inst)
            inst.replica.container:WidgetSetup("kkr_pocket_plus")
        end
        return inst
    end

    inst:AddTag("meteor_protection")

    inst:AddTag("nosteal")
    inst:AddTag("NORATCHECK")

    inst:AddTag("structure")

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/kkr_pocket_plus.xml"
    inst.components.inventoryitem.imagename = "kkr_pocket_plus"
    inst.components.inventoryitem.onpickupfn = topocket

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("kkr_pocket_plus")
    inst.components.container.skipclosesnd = true
    inst.components.container.skipopensnd = true
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
    inst:AddComponent("preserver")
    inst.components.preserver:SetPerishRateMultiplier(PreserverRate)

    MakeHauntableLaunchAndPerish(inst)
    return inst
end

return Prefab("kkr_pocket_plus", fn, assets)
