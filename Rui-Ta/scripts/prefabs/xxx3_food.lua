-- local prefabs =
-- {
--     "xxx3_healthregenbuff",
-- 	"xxx3_butterflybuff",
-- }

local function oneaten_nmtd(inst, eater)
    if
        eater.components.debuffable ~= nil and eater.components.debuffable:IsEnabled() and
            not (eater.components.health ~= nil and eater.components.health:IsDead()) and
            not eater:HasTag('playerghost')
     then
        eater.components.debuffable:AddDebuff('xxx3_healthregenbuff', 'xxx3_healthregenbuff')
    end
end

local function oneaten_hbsl(inst, eater)
    if
        eater.components.debuffable ~= nil and eater.components.debuffable:IsEnabled() and
            not (eater.components.health ~= nil and eater.components.health:IsDead()) and
            not eater:HasTag('playerghost')
     then
        eater.components.debuffable:AddDebuff('xxx3_butterflybuff', 'xxx3_butterflybuff')
    end
end

local function foodfn(mc, nc, ms, hs)
    STRINGS.NAMES[string.upper(mc)] = nc
    STRINGS.CHARACTERS.GENERIC.DESCRIBE[string.upper(mc)] = ms
    return Prefab(
        mc,
        function()
            local inst = CreateEntity()
            inst.entity:AddTransform()
            inst.entity:AddAnimState()
            inst.entity:AddNetwork()

            if not TheWorld.ismastersim then
                return inst
            end

            MakeInventoryPhysics(inst)

            inst.AnimState:SetBank(mc)
            inst.AnimState:SetBuild(mc)
            inst.AnimState:PlayAnimation('idle')

            if hs then
                hs(inst)
            end

            inst:AddComponent('stackable')
            inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

            inst:AddComponent('inspectable')

            inst:AddComponent('inventoryitem')
            inst.components.inventoryitem.atlasname = 'images/' .. mc .. '.xml'
            return inst
        end,
        {
            Asset('ANIM', 'anim/' .. mc .. '.zip'),
            Asset('ATLAS', 'images/' .. mc .. '.xml')
        }
    )
end

-------------------------------------------------------------------------------------

local prefs = {}

local prefabs = {
    'spoiled_food'
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

local function MakePreparedFood(data)
    local realname = data.basename or data.name
    local assets = {
        Asset('ANIM', 'anim/' .. (data.overridebuild or realname) .. '.zip'),
        Asset('ATLAS', 'images/' .. realname .. '.xml'),
        Asset('IMAGE', 'images/' .. realname .. '.tex')
    }

    local spicename = data.spice ~= nil and string.lower(data.spice) or nil
    if spicename ~= nil then
        table.insert(assets, Asset('ANIM', 'anim/spices.zip'))
        table.insert(assets, Asset('ANIM', 'anim/plate_food.zip'))
        table.insert(assets, Asset('INV_IMAGE', spicename .. '_over'))
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
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)

        if spicename ~= nil then
            inst.AnimState:SetBuild('plate_food')
            inst.AnimState:SetBank('plate_food')
            inst.AnimState:OverrideSymbol('swap_garnish', 'spices', spicename)

            inst:AddTag('spicedfood')

            inst.inv_image_bg = {atlas = 'images/' .. realname .. '.xml', image = realname .. '.tex'}
        else
            inst.AnimState:SetBuild(data.overridebuild or realname)
            inst.AnimState:SetBank(data.overridebuild or realname)
        end
        inst.AnimState:PlayAnimation('idle')
        inst.AnimState:OverrideSymbol('swap_food', data.overridebuild or realname, realname)

        inst:AddTag('preparedfood')
        if data.tags then
            for i, v in pairs(data.tags) do
                inst:AddTag(v)
            end
        end

        if data.basename ~= nil then
            inst:SetPrefabNameOverride(data.basename)
            if data.spice ~= nil then
                inst.displaynamefn = function(inst)
                    return subfmt(
                        STRINGS.NAMES[data.spice .. '_FOOD'],
                        {food = STRINGS.NAMES[string.upper(data.basename)]}
                    )
                end
            end
        end

        MakeFoodFloatable(inst, data.float)

        if data.fn_common ~= nil then
            data.fn_common(inst)
        end

        inst.entity:SetPristine()
        if not TheWorld.ismastersim then
            return inst
        end

        inst.food_symbol_build = data.overridebuild or realname
        inst.food_basename = data.basename

        inst:AddComponent('edible')
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

        inst:AddComponent('inspectable')
        inst.wet_prefix = data.wet_prefix

        inst:AddComponent('inventoryitem')
        if data.OnPutInInventory then
            inst:ListenForEvent('onputininventory', data.OnPutInInventory)
        end
        inst.components.inventoryitem.imagename = realname
        if spicename ~= nil then 
            inst.components.inventoryitem:ChangeImageName(spicename .. '_over')
        elseif data.basename ~= nil then
            inst.components.inventoryitem:ChangeImageName(data.basename)
        else
            inst.components.inventoryitem.atlasname = 'images/' .. realname .. '.xml'
        end
        if data.float == nil then
            inst.components.inventoryitem:SetSinks(true)
        end

        inst:AddComponent('stackable')
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

        if data.perishtime ~= nil and data.perishtime > 0 then
            inst:AddComponent('perishable')
            inst.components.perishable:SetPerishTime(data.perishtime)
            inst.components.perishable:StartPerishing()
            inst.components.perishable.onperishreplacement = 'spoiled_food'
        end

        if not data.noburnable then
            MakeSmallBurnable(inst)
            MakeSmallPropagator(inst)
        end

        MakeHauntableLaunchAndPerish(inst)

        inst:AddComponent('bait')

        inst:AddComponent('tradable')

        if data.fn_server ~= nil then
            data.fn_server(inst)
        end

        return inst
    end

    return Prefab(data.name, fn, assets, foodprefabs)
end

for k, v in pairs(TUNING.XXX3_FOODS_SPICED) do
    table.insert(prefs, MakePreparedFood(v))
end

-------------------------------------------------------------------------------------

return foodfn(
    'xxx3_hbsl',
    'Flower Salad',
    'Flowers are delicious, why not try some？',
    function(inst)
        inst:AddTag('preparedfood')

        inst:AddComponent('edible')
        inst.components.edible.healthvalue = 50 * TUNING.XXX3_FOODVALUE
        inst.components.edible.hungervalue = 25 * TUNING.XXX3_FOODVALUE
        inst.components.edible.sanityvalue = 0
        inst.components.edible.foodtype = FOODTYPE.VEGGIE
        inst.components.edible:SetOnEatenFn(oneaten_hbsl)

        inst:AddComponent('perishable')
        inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)
        inst.components.perishable:StartPerishing()
        inst.components.perishable.onperishreplacement = 'spoiled_food'
    end
), foodfn(
    'xxx3_hjmdj',
    'Golden Honey Butterfly Roll',
    'Looks so sweet',
    function(inst)
        inst:AddTag('preparedfood')

        inst:AddComponent('edible')
        inst.components.edible.healthvalue = 35 * TUNING.XXX3_FOODVALUE
        inst.components.edible.hungervalue = 50 * TUNING.XXX3_FOODVALUE
        inst.components.edible.sanityvalue = 20 * TUNING.XXX3_FOODVALUE
        inst.components.edible.foodtype = FOODTYPE.VEGGIE

        inst:AddComponent('perishable')
        inst.components.perishable:SetPerishTime(TUNING.PERISH_MED)
        inst.components.perishable:StartPerishing()
        inst.components.perishable.onperishreplacement = 'spoiled_food'
    end
), foodfn(
    'xxx3_hmhb',
    'Nectar burger',
    'It should be filling enough',
    function(inst)
        inst:AddTag('preparedfood')

        inst:AddComponent('edible')
        inst.components.edible.healthvalue = 15 * TUNING.XXX3_FOODVALUE
        inst.components.edible.hungervalue = 112.5 * TUNING.XXX3_FOODVALUE
        inst.components.edible.sanityvalue = 5 * TUNING.XXX3_FOODVALUE
        inst.components.edible.foodtype = FOODTYPE.MEAT

        inst:AddComponent('perishable')
        inst.components.perishable:SetPerishTime(TUNING.PERISH_SLOW)
        inst.components.perishable:StartPerishing()
        inst.components.perishable.onperishreplacement = 'spoiled_food'
    end
), foodfn(
    'xxx3_hjdg',
    'Golden Cake',
    'Delicious Baking',
    function(inst)
        inst:AddTag('preparedfood')

        inst:AddComponent('edible')
        inst.components.edible.healthvalue = 40 * TUNING.XXX3_FOODVALUE
        inst.components.edible.hungervalue = 85 * TUNING.XXX3_FOODVALUE
        inst.components.edible.sanityvalue = 5 * TUNING.XXX3_FOODVALUE
        inst.components.edible.foodtype = FOODTYPE.VEGGIE

        inst:AddComponent('perishable')
        inst.components.perishable:SetPerishTime(TUNING.PERISH_SLOW)
        inst.components.perishable:StartPerishing()
        inst.components.perishable.onperishreplacement = 'spoiled_food'
    end
), foodfn(
    'xxx3_nmtd',
    'Nano jelly beans',
    'The product of some mysterious technology',
    function(inst)
        inst:AddTag('preparedfood')

        inst:AddComponent('edible')
        inst.components.edible.healthvalue = 0
        inst.components.edible.hungervalue = 2
        inst.components.edible.sanityvalue = 0
        inst.components.edible.foodtype = FOODTYPE.GOODIES
        inst.components.edible:SetOnEatenFn(oneaten_nmtd)
    end
), unpack(prefs)
