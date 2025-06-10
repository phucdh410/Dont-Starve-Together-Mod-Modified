local foods = require("kkr_food_def")

local prefabs = {
    "spoiled_food"
}
local function MakeFoodFloatable(inst, float)
    if float ~= nil then
        MakeInventoryFloatable(inst, float[2], float[3], float[4])
        if float[1] ~= nil then
            local OnLandedClient_old = inst.components.floater.OnLandedClient
            inst.components.floater.OnLandedClient = function(self)
                OnLandedClient_old(self)
                self.inst.AnimState:SetFloatParams(float[1], 1, self.bob_percent)
            end
        end
    end
end

local function createfood(data)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    MakeFoodFloatable(inst, data.float)
    inst:AddTag("kkrfood")
    if data.tags then
        for i, v in pairs(data.tags) do
            inst:AddTag(v)
        end
    end
    return inst
end

local function master_common(inst, data)
    if data.hs then
        data.hs(inst)
    end
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.wet_prefix = data.wet_prefix

    if data.OnPutInInventory then
        inst:ListenForEvent("onputininventory", data.OnPutInInventory)
    end
    inst:AddComponent("edible")
    inst.components.edible.healthvalue = data.health
    inst.components.edible.hungervalue = data.hunger
    inst.components.edible.foodtype = data.foodtype or FOODTYPE.GENERIC
    inst.components.edible.secondaryfoodtype = data.secondaryfoodtype or nil
    inst.components.edible.sanityvalue = data.sanity or 0
    inst.components.edible.temperaturedelta = data.temperature or 0
    inst.components.edible.temperatureduration = data.temperatureduration or 0
    inst.components.edible.nochill = data.nochill or nil
    inst.components.edible.spice = data.spice
    inst.components.edible:SetOnEatenFn(data.oneatenfn)

    if data.perishtime ~= nil and data.perishtime > 0 then
        inst:AddComponent("perishable")
        inst.components.perishable:SetPerishTime(data.perishtime)
        inst.components.perishable:StartPerishing()
        inst.components.perishable.onperishreplacement = "spoiled_food"
    end
    inst:AddComponent("bait")
    inst:AddComponent("tradable")

    if data.float == nil then
        inst.components.inventoryitem:SetSinks(true)
    end

    if not data.noburnable then
        MakeSmallBurnable(inst)
        MakeSmallPropagator(inst)
    end

    MakeHauntableLaunchAndPerish(inst)

    if data.fn_server ~= nil then
        data.fn_server(inst)
    end
    return inst
end

local function MakeFood(data)
    local foodname = data.name
    local fn = function()
        local inst = createfood(data)
        inst.AnimState:SetBank(foodname)
        inst.AnimState:SetBuild(foodname)
        inst.AnimState:PlayAnimation("idle")
        inst:AddTag("preparedfood")
        if not TheWorld.ismastersim then
            return inst
        end
        master_common(inst, data)

        inst.components.inventoryitem.atlasname = "images/inventoryimages/kkr_foods.xml"
        inst.components.inventoryitem.imagename = foodname
        return inst
    end
    return Prefab(
        foodname,
        fn,
        {
            Asset("ANIM", "anim/" .. foodname .. ".zip"),
            Asset("ATLAS", "images/inventoryimages/kkr_foods.xml"),
            Asset("IMAGE", "images/inventoryimages/kkr_foods.tex")
        }
    )
end

local function MakeSpicesFood(data)
    local realname = data.basename or data.name
    local assets = {
        Asset("ANIM", "anim/" .. (data.overridebuild or realname) .. ".zip"),
        Asset("ATLAS", "images/inventoryimages/kkr_foods.xml"),
        Asset("IMAGE", "images/inventoryimages/kkr_foods.tex")
    }

    local spicename = data.spice ~= nil and string.lower(data.spice) or nil
    if spicename ~= nil then
        table.insert(assets, Asset("ANIM", "anim/spices.zip"))
        table.insert(assets, Asset("ANIM", "anim/plate_food.zip"))
        table.insert(assets, Asset("INV_IMAGE", spicename .. "_over"))
    end

    local foodprefabs = prefabs
    if data.prefabs ~= nil then
        foodprefabs = shallowcopy(prefabs)
        for i, v in ipairs(data.prefabs) do
            if not table.contains(foodprefabs, v) then
                table.insert(foodprefabs, v)
            end
        end
    end
    local function fn()
        local inst = createfood(data)
        if spicename ~= nil then
            inst.AnimState:SetBuild("plate_food")
            inst.AnimState:SetBank("plate_food")
            inst.AnimState:OverrideSymbol("swap_garnish", "spices", spicename)
            inst:AddTag("spicedfood")

            inst.inv_image_bg = {atlas = "images/inventoryimages/kkr_foods.xml", image = realname .. ".tex"}
        else
            inst.AnimState:SetBuild(data.overridebuild or realname)
            inst.AnimState:SetBank(data.overridebuild or realname)
        end
        inst.AnimState:PlayAnimation("idle")
        inst.AnimState:OverrideSymbol("swap_food", data.overridebuild or realname, realname)
        inst:AddTag("preparedfood")
        if data.basename ~= nil then
            inst:SetPrefabNameOverride(data.basename)
            if data.spice ~= nil then
                inst.displaynamefn = function(inst)
                    return subfmt(
                        STRINGS.NAMES[data.spice .. "_FOOD"],
                        {food = STRINGS.NAMES[string.upper(data.basename)]}
                    )
                end
            end
        end
        if data.fn_common ~= nil then
            data.fn_common(inst)
        end
        inst.entity:SetPristine()
        if not TheWorld.ismastersim then
            return inst
        end
        master_common(inst, data)
        inst.food_symbol_build = data.overridebuild or realname
        inst.food_basename = data.basename
        inst.components.inventoryitem.imagename = realname
        if spicename ~= nil then
            inst.components.inventoryitem:ChangeImageName(spicename .. "_over")
        elseif data.basename ~= nil then
            inst.components.inventoryitem:ChangeImageName(data.basename)
        else
            inst.components.inventoryitem.atlasname = "images/inventoryimages/kkr_foods.xml"
        end
        return inst
    end
    return Prefab(data.name, fn, assets, foodprefabs)
end

local kkr_foods = {}
for _, v in pairs(foods) do
    table.insert(kkr_foods, MakeFood(v))
end
for _, v in pairs(KKRENV.KKR_FOODS_SPICED) do
    table.insert(kkr_foods, MakeSpicesFood(v))
end

return unpack(kkr_foods)
