local itemlist = require "SEscripts/itemlist"

local function MergeTables(tabA, tabB, name)
    if name == "name" then
        for _, v in ipairs(tabA) do
            table.insert(tabB, v.name)
        end
    else
        for _, v in ipairs(tabA) do
            table.insert(tabB, v)
        end
    end
end

local seworldstatus =
    Class(
    function(self, inst)
        self.inst = inst
        self.playerdata = {}
        self.repeativecheck = {}
        self.makelist()
    end
)
function seworldstatus:makelist()
    if TUNING.UPDATELIST then
        itemlist = require "SEscripts/itemlist"
    end
    TUNING.selist_food = {}
    TUNING.selist_cloth = {}
    TUNING.selist_smithing = {}
    TUNING.selist_resource = {}
    TUNING.selist_special = {}
    TUNING.selist_blueprint = {}
    TUNING.selist_precioustwo = {}
    TUNING.selist_precious = {}

    if TUNING.EXCLUSIVEITEM then
        for _, newItem in ipairs(itemlist.selist_precioustwo) do
            table.insert(itemlist.selist_precious, newItem)
        end
    else
        for _, item in ipairs(itemlist.selist_precioustwo) do
            table.insert(TUNING.selist_precioustwo, item.name)
        end
    end

    if TUNING.UNCOMPROMISING_MODE and TUNING.umswitch then
        MergeTables(itemlist.selist_foodum, itemlist.selist_food)
        MergeTables(itemlist.selist_clothum, itemlist.selist_cloth)
        MergeTables(itemlist.selist_smithingum, itemlist.selist_smithing)
        MergeTables(itemlist.selist_resourceum, itemlist.selist_resource)
        MergeTables(itemlist.selist_blueprintum, itemlist.selist_blueprint)
        MergeTables(itemlist.selist_preciousum, itemlist.selist_precious)
    end

    if TUNING.FUNCTIONAL_MEDAL_IS_OPEN and TUNING.Functionalswitch then
        MergeTables(itemlist.selist_smithing_xz, itemlist.selist_smithing)
        MergeTables(itemlist.selist_resource_xz, itemlist.selist_resource)
        MergeTables(itemlist.selist_blueprint_xz, itemlist.selist_blueprint)
        MergeTables(itemlist.selist_precious_xz, itemlist.selist_precious)

        if TUNING.Functionalsell then
            MergeTables(itemlist.selist_precious_xzxz, itemlist.selist_precious)
        end
    end

    if TUNING.autoLegion and TUNING.Legionswitch then
        MergeTables(itemlist.selist_food_lj, itemlist.selist_food)
        MergeTables(itemlist.selist_cloth_lj, itemlist.selist_cloth)
        MergeTables(itemlist.selist_smithing_lj, itemlist.selist_smithing)
        MergeTables(itemlist.selist_resource_lj, itemlist.selist_resource)
        MergeTables(itemlist.selist_blueprint_lj, itemlist.selist_blueprint)
        MergeTables(itemlist.selist_precious_lj, itemlist.selist_precious)

        if TUNING.Legionsell then
            MergeTables(itemlist.selist_precious_ljlj, itemlist.selist_precious)
        end
    end

    if TUNING.NDNR_ACTIVE and TUNING.NDNR_SWITCH then
        if TUNING.autoLegion then
            for i, entry in ipairs(itemlist.selist_food_ndnr) do
                if entry.name == "dish_medicinalliquor" then
                    table.remove(itemlist.selist_food_ndnr, i)
                    break
                end
            end
        end
        MergeTables(itemlist.selist_food_ndnr, itemlist.selist_food)
        MergeTables(itemlist.selist_cloth_ndnr, itemlist.selist_cloth)
        MergeTables(itemlist.selist_smithing_ndnr, itemlist.selist_smithing)
        MergeTables(itemlist.selist_resource_ndnr, itemlist.selist_resource)
        MergeTables(itemlist.selist_blueprint_ndnr, itemlist.selist_blueprint)
        MergeTables(itemlist.selist_precious_ndnr, itemlist.selist_precious)
    end

    if TUNING.Island_Adventures_se and TUNING.Island_switch then
        MergeTables(itemlist.selist_food_Island, itemlist.selist_food)
        MergeTables(itemlist.selist_cloth_Island, itemlist.selist_cloth)
        MergeTables(itemlist.selist_smithing_Island, itemlist.selist_smithing)
        MergeTables(itemlist.selist_resource_Island, itemlist.selist_resource)
        MergeTables(itemlist.selist_precious_Island, itemlist.selist_precious)
    end

    MergeTables(itemlist.selist_food_mod, itemlist.selist_food)
    MergeTables(itemlist.selist_cloth_mod, itemlist.selist_cloth)
    MergeTables(itemlist.selist_smithing_mod, itemlist.selist_smithing)
    MergeTables(itemlist.selist_resource_mod, itemlist.selist_resource)
    MergeTables(itemlist.selist_precious_mod, itemlist.selist_precious)
    MergeTables(itemlist.selist_blueprint_mod, itemlist.selist_blueprint)

    for n = 1, #itemlist.selist_food do
        TUNING.selist_food[n] = {}
        TUNING.selist_food[n].name = itemlist.selist_food[n].name
        TUNING.selist_food[n].price = itemlist.selist_food[n].price
        TUNING.selist_food[n].atl = itemlist.selist_food[n].atl
        TUNING.selist_food[n].tex = itemlist.selist_food[n].tex
    end
    for n = 1, #itemlist.selist_cloth do
        TUNING.selist_cloth[n] = {}
        TUNING.selist_cloth[n].name = itemlist.selist_cloth[n].name
        TUNING.selist_cloth[n].price = itemlist.selist_cloth[n].price
        TUNING.selist_cloth[n].atl = itemlist.selist_cloth[n].atl
        TUNING.selist_cloth[n].tex = itemlist.selist_cloth[n].tex
    end

    for n = 1, #itemlist.selist_smithing do
        TUNING.selist_smithing[n] = {}
        TUNING.selist_smithing[n].name = itemlist.selist_smithing[n].name
        TUNING.selist_smithing[n].price = itemlist.selist_smithing[n].price
        TUNING.selist_smithing[n].atl = itemlist.selist_smithing[n].atl
        TUNING.selist_smithing[n].tex = itemlist.selist_smithing[n].tex
    end

    for n = 1, #itemlist.selist_resource do
        TUNING.selist_resource[n] = {}
        TUNING.selist_resource[n].name = itemlist.selist_resource[n].name
        TUNING.selist_resource[n].price = itemlist.selist_resource[n].price
        TUNING.selist_resource[n].atl = itemlist.selist_resource[n].atl
        TUNING.selist_resource[n].tex = itemlist.selist_resource[n].tex
    end
    if TUNING.allow_selist_special then
        for n = 1, #itemlist.selist_special do
            TUNING.selist_special[n] = {}
            TUNING.selist_special[n].name = itemlist.selist_special[n].name
            TUNING.selist_special[n].price = itemlist.selist_special[n].price
            TUNING.selist_special[n].atl = itemlist.selist_special[n].atl
            TUNING.selist_special[n].tex = itemlist.selist_special[n].tex
        end
    end
    for n = 1, #itemlist.selist_blueprint do
        TUNING.selist_blueprint[n] = {}
        TUNING.selist_blueprint[n].name = itemlist.selist_blueprint[n].name
        TUNING.selist_blueprint[n].price = itemlist.selist_blueprint[n].price
        TUNING.selist_blueprint[n].atl = itemlist.selist_blueprint[n].atl
        TUNING.selist_blueprint[n].tex = itemlist.selist_blueprint[n].tex
    end

    for n = 1, #itemlist.selist_precious do
        TUNING.selist_precious[n] = {}
        TUNING.selist_precious[n].name = itemlist.selist_precious[n].name
        TUNING.selist_precious[n].price = itemlist.selist_precious[n].price
        TUNING.selist_precious[n].atl = itemlist.selist_precious[n].atl
        TUNING.selist_precious[n].tex = itemlist.selist_precious[n].tex
    end

    TUNING.selist_low = {}
    for n = 1, #itemlist.selist_precious do
        table.insert(TUNING.selist_low, TUNING.selist_precious[n])
    end

    for n = 1, #itemlist.selist_special do
        table.insert(TUNING.selist_low, TUNING.selist_special[n])
    end

    for n = 1, #itemlist.selist_blueprint do
        table.insert(TUNING.selist_low, TUNING.selist_blueprint[n])
    end

    TUNING.SEseasonchange = false
    seworldstatus:changelist()
    seworldstatus:seasoncheck()
end

function seworldstatus:SumOfRecipePrices(name)
    if self.repeativecheck[name] then
        return 0
    end

    self.repeativecheck[name] = true

    local recipe = AllRecipes[name]

    if recipe == nil then
        return 0
    end

    local price = 0

    for i, ingredient in ipairs(recipe.ingredients) do
        local ingreprice = 0

        local selists = {
            itemlist.selist_food,
            itemlist.selist_cloth,
            itemlist.selist_smithing,
            itemlist.selist_resource,
            itemlist.selist_precious
        }
        for _, selist in ipairs(selists) do
            for _, tabv in pairs(selist) do
                if tabv.name == ingredient.type then
                    ingreprice = (tabv.price or 0) * 1.5
                    break
                end
            end
        end

        if ingreprice == 0 then
            local subPrice = self:SumOfRecipePrices(ingredient.type)
            ingreprice = subPrice
        end

        price = price + ingreprice * (ingredient.amount or 1)
        if price >= 3500 then
            price = price / 1.5 * 1.2
        end
    end

    return math.ceil(price / (recipe.numtogive or 1))
end

function seworldstatus:changelist()
    if TUNING.SEASONALCHANGE then
        local curseason = TheWorld.components.worldstate.data.season
        TUNING.seseasonfood = curseason == "spring" and .5 or curseason == "winter" and 1.5 or 1
        TUNING.seseasoncloth = curseason == "summer" and .5 or curseason == "winter" and 1.5 or 1
        TUNING.seseasonsmithing = curseason == "winter" and .5 or curseason == "summer" and 1.5 or 1
        TUNING.seseasonresource = curseason == "autumn" and .5 or curseason == "summer" and 1.5 or 1
    else
        TUNING.seseasonfood, TUNING.seseasoncloth, TUNING.seseasonsmithing, TUNING.seseasonresource = 1, 1, 1, 1
    end

    for k, v in pairs(itemlist.selist_food) do
        TUNING.selist_food[k].price =
            math.ceil((v.price or self:SumOfRecipePrices(v.name) or 5200) * TUNING.seseasonfood)
        if TUNING.selist_food[k].price > 99999999 then
            TUNING.selist_food[k].price = 99999999
        end
        self.repeativecheck = {}
    end
    for k, v in pairs(itemlist.selist_cloth) do
        TUNING.selist_cloth[k].price =
            math.ceil((v.price or self:SumOfRecipePrices(v.name) or 5200) * TUNING.seseasoncloth)
        if TUNING.selist_cloth[k].price > 99999999 then
            TUNING.selist_cloth[k].price = 99999999
        end
        self.repeativecheck = {}
    end
    for k, v in pairs(itemlist.selist_smithing) do
        TUNING.selist_smithing[k].price =
            math.ceil((v.price or self:SumOfRecipePrices(v.name) or 5200) * TUNING.seseasonsmithing)
        if TUNING.selist_smithing[k].price > 99999999 then
            TUNING.selist_smithing[k].price = 99999999
        end
        self.repeativecheck = {}
    end
    for k, v in pairs(itemlist.selist_resource) do
        TUNING.selist_resource[k].price =
            math.ceil((v.price or self:SumOfRecipePrices(v.name) or 5200) * TUNING.seseasonresource)
        if TUNING.selist_resource[k].price > 99999999 then
            TUNING.selist_resource[k].price = 99999999
        end
        self.repeativecheck = {}
    end
    for k, v in pairs(itemlist.selist_precious) do
        TUNING.selist_precious[k].price = math.ceil((v.price or self:SumOfRecipePrices(v.name) or 5200))
        if TUNING.selist_precious[k].price > 99999999 then
            TUNING.selist_precious[k].price = 99999999
        end
        self.repeativecheck = {}
    end

    TUNING.allgoods = {}
    for n = 1, #TUNING.selist_food do
        table.insert(TUNING.allgoods, TUNING.selist_food[n])
    end
    for n = 1, #TUNING.selist_cloth do
        table.insert(TUNING.allgoods, TUNING.selist_cloth[n])
    end
    for n = 1, #TUNING.selist_smithing do
        table.insert(TUNING.allgoods, TUNING.selist_smithing[n])
    end
    for n = 1, #TUNING.selist_resource do
        table.insert(TUNING.allgoods, TUNING.selist_resource[n])
    end
    for n = 1, #itemlist.price_basa do
        table.insert(TUNING.allgoods, itemlist.price_basa[n])
    end

    if TUNING.SEseasonchange == false then
        TUNING.SEseasonchange = true
    else
        TUNING.SEseasonchange = false
    end
end

function seworldstatus:seasoncheck()
    TheWorld:ListenForEvent(
        "seasontick",
        function()
            self:changelist()
        end
    )
end

function seworldstatus:OnSave()
    local data = {
        playerdata = self.playerdata
    }
    return data
end

function seworldstatus:OnLoad(data)
    self.playerdata = data.playerdata or {}
end

return seworldstatus
