GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

local require = GLOBAL.require
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local STRINGS = GLOBAL.STRINGS
local TECH = GLOBAL.TECH

STRINGS.REFRESH_TIME = GetModConfigData("refresh_time")
STRINGS.BACKPACK_SETTING = GetModConfigData("backpack_setting")

STRINGS.FERTILIZER_NOTIFICATION = "Master, I have no material to fertilize"
STRINGS.PLANT_NOTIFICATION = "Master, I have no seeds to plant"
STRINGS.ACTIVATE_MUSHROOM = "Master, I need livinglog to activate the mushroom farm"
STRINGS.FIRESUPPRESSOR_FUEL = "Master, I have no material to fuel the firesuppressor"
STRINGS.CONTAINER_FULL = "Master, my bag is full and I can't put any more things in it."
STRINGS.NAMES.OLDFISH_FARMHOME = "AI Farmhome"
STRINGS.RECIPE_DESC.OLDFISH_FARMHOME = "A cozy home for a hardworking farmer."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.OLDFISH_FARMHOME = "Feels like hope."
STRINGS.NAMES.OLDFISH_FARMER = "Shi Zhenxiang"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.OLDFISH_FARMER = "Hard work never gets old!"


PrefabFiles = {
    "oldfish_farmer",
    "oldfish_farmhome"
}
Assets = {
    Asset("ATLAS", "images/inventoryimages/oldfish_farmhome.xml"),
    Asset("ANIM", "anim/ui_chest_8x8.zip"),
}
AddRecipe2("oldfish_farmhome",
{Ingredient("boards", 10),Ingredient("cutstone", 5)},
GLOBAL.TECH.SCIENCE_ONE,
{
    placer = "oldfish_farmhome_placer",
    min_spacing = 1,
    atlas = "images/inventoryimages/oldfish_farmhome.xml",
    image = "oldfish_farmhome.tex"
},
{"GARDENING", "STRUCTURES"})

local PERDGIVE = Action()
PERDGIVE.id = "PERDGIVE"
PERDGIVE.str = STRINGS.PERDGIVE
PERDGIVE.fn = function(act)
    if act.doer and act.target and act.target.components.trader then
        local able, reason = act.target.components.trader:AbleToAccept(act.invobject, act.doer)
        if not able then
            return false,
            reason
        end
        act.target.components.trader:AcceptGift(act.doer, act.invobject, 1)
        return true
    end
    return false
end
AddAction(PERDGIVE)


local AUTO_PLANT = GLOBAL.Action()
AUTO_PLANT.id = "AUTO_PLANT"
AUTO_PLANT.str = "AUTO_PLANT"
AUTO_PLANT.fn = function(act)
    if act.doer.components.container ~= nil then
        local seed = act.doer.components.container:RemoveItem(act.invobject)
        if seed ~= nil then
            if act.target.components.grower ~= nil and act.target.components.grower:PlantItem(seed) then
                return true
            end
        end
    end
    return false
end
AddAction(AUTO_PLANT)

local AUTO_FERTILIZE = GLOBAL.Action()
AUTO_FERTILIZE.id = "AUTO_FERTILIZE"
AUTO_FERTILIZE.str = "AUTO_FERTILIZE"
AUTO_FERTILIZE.fn = function(act)
    if act.doer.components.container ~= nil then
        if act.invobject ~= nil then
            if act.target.components.grower ~= nil  then
                act.target.components.grower:Fertilize(act.invobject, act.doer)
                return true
            elseif act.target.components.pickable ~= nil  then
                act.target.components.pickable:Fertilize(act.invobject, act.doer)
                return true
            end
        end
    end
    return false
end
AddAction(AUTO_FERTILIZE)

local AUTO_FARM_PLANT = GLOBAL.Action()
AUTO_FARM_PLANT.id = "AUTO_FARM_PLANT"
AUTO_FARM_PLANT.str = "AUTO_FARM_PLANT"
AUTO_FARM_PLANT.fn = function(act)
    local p = act.pos
    if not p.Get then p = p.local_pt end

    local result = string.find(act.invobject.prefab, "dug_")
    if result ~= nil then
        --        act.invobject.components.deployable.ondeploy(act.invobject,act.pos, act.doer)
        act.invobject.components.deployable.ondeploy(act.invobject, p, act.doer)
    else
        local obj = act.doer.components.container and act.doer.components.container:RemoveItem(act.invobject)
        --        obj.components.deployable.ondeploy(obj,act.pos, act.doer)
        obj.components.deployable.ondeploy(obj, p, act.doer)
    end
    return true

end
AddAction(AUTO_FARM_PLANT)

local function oldfish_widgetcreation()
    local params = {}
    params.oldfish_farmer = {
        widget = {
            slotpos = {},
            animbank = "ui_chest_8x8",
            animbuild = "ui_chest_8x8",
            pos = GLOBAL.Vector3(0, 200, 0),
            side_align_tip = 160,
        },
        type = "chest"
    }

    for y = 7, 0, -1 do
        for x = 0, 7 do
            table.insert(params.oldfish_farmer.widget.slotpos, GLOBAL.Vector3(70 * x -250, 70 * y - 270, 0))
        end
    end

    local containers = GLOBAL.require "containers"
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, params.oldfish_farmer.widget.slotpos ~= nil and #params.oldfish_farmer.widget.slotpos or 0)
    local old_widgetsetup = containers.widgetsetup
    function containers.widgetsetup(container, prefab, data)
        local pref = prefab or container.inst.prefab
        if pref == "oldfish_farmer" then
            local t = params[pref]
            if t ~= nil then
                for k, v in pairs(t) do
                    container[k] = v
                end
                container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
            end
        else
            return old_widgetsetup(container, prefab)
        end
    end

end

oldfish_widgetcreation()

AddMinimapAtlas("images/inventoryimages/oldfish_farmhome.xml")

local needTags = {"berrybush","grass","berrybush2","berrybush_juicy","firesuppressor","berries","beebox","berries_juicy","cutgrass","twigs","mushroom_farm","meatrack","slow_farmplot","fast_farmplot"}

for k,v in ipairs(needTags) do
    AddPrefabPostInit(v, function (inst)
        inst:AddTag("oldfish_"..v)
    end)
end