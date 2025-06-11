GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

require("prefabs/veggies")

PrefabFiles = {
    "ea_jinkela",
    "ea_jinkela_ash",
    "ea_fertilizer_machine",
    "ea_fx_harvest",
    "ea_fx_trans",
    "ea_fx_shoplight",
    "ea_fx_shopnote",
    "ea_well",
    "ea_area_edge",
    "ea_farm_plow_machine",
    "poop_flingomatic",
    "fertilizer_projectile"
}

Assets = {
    Asset("ATLAS", "images/minimap/ea_fertilizer_machine_mini.xml"),
    Asset("IMAGE", "images/minimap/ea_fertilizer_machine_mini.tex"),

    Asset("ATLAS", "images/minimap/ea_seeding_machine_mini.xml"),
    Asset("IMAGE", "images/minimap/ea_seeding_machine_mini.tex"),

    Asset("ATLAS", "images/minimap/ea_harvest_machine_mini.xml"),
    Asset("IMAGE", "images/minimap/ea_harvest_machine_mini.tex"),

    Asset("ATLAS", "images/minimap/ea_harvest_machine2_mini.xml"),
    Asset("IMAGE", "images/minimap/ea_harvest_machine2_mini.tex"),

    Asset("ANIM", "anim/bmui_7x7.zip"),

    Asset("ATLAS", "images/minimap/ea_farm_plow_machine_mini.xml"),
    Asset("IMAGE", "images/minimap/ea_farm_plow_machine_mini.tex"),

    Asset("ATLAS", "images/minimap/ea_shop_mini.xml"),
    Asset("IMAGE", "images/minimap/ea_shop_mini.tex"),

    Asset("ATLAS", "images/minimap/ea_well_mini.xml"),
    Asset("IMAGE", "images/minimap/ea_well_mini.tex"),

    Asset("ANIM", "anim/ea_ui_seeding_1x1.zip"),

    Asset("ATLAS", "images/ui/fx_multselect.xml"),
    Asset("IMAGE", "images/ui/fx_multselect.tex"),

    Asset("ATLAS", "images/ea_filter.xml"),
    Asset("IMAGE", "images/ea_filter.tex"),
    
    Asset("ANIM", "anim/ui_chest_3x3.zip"),
    Asset("ATLAS", "images/inventoryimages/poop_flingomatic.xml"),
    Asset("ATLAS", "minimap/poop_flingomatic.xml")
}

modimport("scripts/common.lua")

modimport("scripts/ui.lua")

modimport("ea_main_scripts/constants.lua")

if EA_CONSTANTS.ADDED_HARVEST then
    table.insert(PrefabFiles, "ea_harvest_machine")
end
if EA_CONSTANTS.ADDED_SEEDING then
    table.insert(PrefabFiles, "ea_seeding_machine")
end
if EA_CONSTANTS.ADDED_SHOP then
    table.insert(PrefabFiles, "ea_shop")
end

modimport("ea_main_scripts/tools.lua")

modimport("ea_main_scripts/rpc.lua")

modimport("ea_main_scripts/controller.lua")

modimport("ea_main_scripts/containers.lua")

modimport("ea_main_scripts/ui.lua")

modimport("ea_main_scripts/actions.lua")

modimport("ea_main_scripts/recipes.lua")

AddReplicableComponent("ea_rectangle")

AddMinimapAtlas("images/minimap/ea_fertilizer_machine_mini.xml")
AddMinimapAtlas("images/minimap/ea_seeding_machine_mini.xml")
AddMinimapAtlas("images/minimap/ea_harvest_machine_mini.xml")
AddMinimapAtlas("images/minimap/ea_harvest_machine2_mini.xml")
AddMinimapAtlas("images/minimap/ea_farm_plow_machine_mini.xml")
AddMinimapAtlas("images/minimap/ea_shop_mini.xml")
AddMinimapAtlas("images/minimap/ea_well_mini.xml")

local FERTILIZER_DEFS = require("prefabs/fertilizer_nutrient_defs").FERTILIZER_DEFS
local SORTED_FERTILIZERS = require("prefabs/fertilizer_nutrient_defs").SORTED_FERTILIZERS

table.insert(SORTED_FERTILIZERS, "ea_jinkela")
FERTILIZER_DEFS.ea_jinkela = {
    name = "EA_JINKELA",
    atlas = "images/inventoryimages/ea_jinkela.xml",
    inventoryimage = "ea_jinkela.tex",
    nutrients = {8, 8, 8},
    uses = 1
}

local rotable_placers = {}
function _G.RegisterRotablePlacer(prefab_name)
    if type(prefab_name) == "string" then
        rotable_placers[prefab_name] = true
    end
end
AddComponentPostInit(
    "playercontroller",
    function(self)
        local old_GetHoverTextOverride = self.GetHoverTextOverride
        self.GetHoverTextOverride = function(self)
            if self.placer_recipe then
                if rotable_placers[self.placer_recipe.name] then
                    return STRINGS.UI.HUD.BUILD ..
                        " " ..
                            (STRINGS.NAMES[string.upper(self.placer_recipe.name)] or STRINGS.UI.HUD.HERE) ..
                                "\n" .. string.format(STRINGS.EA_ROTATE, EA_CONSTANTS.HARVEST_MACHINE_PLACER_ROTATE_KEY)
                end
            end
            return old_GetHoverTextOverride(self)
        end
    end
)

AddGlobalClassPostConstruct(
    "cameras/followcamera",
    "FollowCamera",
    function(self)
        local old_SetHeadingTarget = self.SetHeadingTarget
        self.SetHeadingTarget = function(_self, r)
            if self:IsHeadingTargetLocked() then
                return old_SetHeadingTarget(_self, self.headingtarget)
            else
                return old_SetHeadingTarget(_self, r)
            end
        end
        self.LockHeadingTarget = function(_self, lock_name)
            self.headingtarget_locks = self.headingtarget_locks or {}
            self.headingtarget_locks[lock_name] = true
        end
        self.UnLockHeadingTarget = function(_self, lock_name)
            if type(self.headingtarget_locks) == "table" then
                self.headingtarget_locks[lock_name] = nil
            end
        end
        self.IsHeadingTargetLocked = function(_self)
            if type(self.headingtarget_locks) == "table" then
                for lock, _ in pairs(self.headingtarget_locks) do
                    return true
                end
            end
            return false
        end

        self:SetHeadingTarget(0)

        self.ZoomIn = function(step)
            self.distancetarget = math.max(self.mindist, self.distancetarget - self.zoomstep)
            self.time_since_zoom = 0
        end

        self.ZoomOut = function(step)
            self.distancetarget = math.min(self.maxdist, self.distancetarget + self.zoomstep)
            self.time_since_zoom = 0
        end
    end
)

-- Merge with Happy Farm mod

--Auto Aligning
local yuyuyu = {[0] = 0.667, [1] = 0.667, [2] = 2, [3] = 3.333}

if TUNING.FARM_TILL_SPACING ~= nil then
    local auto_aligning = GetModConfigData("to_auto_aligning")
    if auto_aligning ~= false then
        AddComponentPostInit(
            "farmtiller",
            function(self)
                local old_Till = self.Till
                function self:Till(pt, doer, ...)
                    if auto_aligning == "4*4" then
                        pt.x = math.floor(pt.x / 4) * 4 + (math.floor(pt.x) % 4) * 1.333
                        pt.z = math.floor(pt.z / 4) * 4 + (math.floor(pt.z) % 4) * 1.333
                    else
                        local pt1 = Point(TheWorld.Map:GetTileCenterPoint(pt:Get()))
                        local p2 = pt1 - pt
                        local p3 = Point((p2.x + 0.5) - (p2.x + 0.5) % 1.333, 0, (p2.z + 0.5) - (p2.z + 0.5) % 1.333)
                        pt = pt1 - p3
                    end
                    return old_Till(self, pt, doer, ...)
                end
            end
        )
    end
end

AddComponentPostInit(
    "growable",
    function(self)
        --To Oversize
        if GetModConfigData("to_oversize") == true then
            self.inst:DoTaskInTime(
                0,
                function()
                    if not (self.stages ~= nil and type(self.stages) == "table") then
                        return
                    end
                    for i, v in ipairs(self.stages) do
                        if v and v.name ~= nil and v.name == "full" and v.pregrowfn ~= nil then
                            local old = v.pregrowfn
                            v.pregrowfn = function(inst)
                                old(inst)
                                inst.is_oversized = true
                            end
                        end
                    end
                end
            )
        end

        --No Rotten
        if GetModConfigData("no_rotten") == true then
            local old_StartGrowing = self.StartGrowing
            function self:StartGrowing(time)
                if
                    self.stages and self.stages[self.stage] and self.stages[self.stage].name ~= nil and
                        self.stages[self.stage].name == "full"
                 then
                    self:StopGrowing()
                    return
                end
                return old_StartGrowing(self, time)
            end
            self.inst:DoTaskInTime(
                0,
                function()
                    if
                        self.stages ~= nil and self.stages[self.stage] and self.stages[self.stage].name ~= nil and
                            self.stages[self.stage].name == "full"
                     then
                        self:StopGrowing()
                    end
                end
            )
        end
    end
)

--Quick plant
if GetModConfigData("quick_plant") == true then
    AddStategraphPostInit(
        "wilson",
        function(sg)
            local plant = ACTIONS.PLANTSOIL ~= nil and sg.actionhandlers[ACTIONS.PLANTSOIL].deststate or nil
            if plant then
                sg.actionhandlers[ACTIONS.PLANTSOIL].deststate = function(inst, action)
                    return "doshortaction"
                end
            end
        end
    )
end

-- All Crops like All Seasons
if GetModConfigData("allow_all_seasons") == true then
    local function SetAllSeasonsForPlants()
        local PLANT_DEFS = require("prefabs/farm_plant_defs").PLANT_DEFS

        for _, data in pairs(PLANT_DEFS) do
            data.good_seasons = {autumn = true, winter = true, spring = true, summer = true}
        end
    end

    AddSimPostInit(SetAllSeasonsForPlants)
end

-- New Custom

-- No spoil drying meat
if GetModConfigData("dhp410_no_spoil_drying") then
    local FREEZE_TIME = 99999 * 60 * 60 -- 99999 hours
    AddComponentPostInit(
        "dryer",
        function(self)
            local function NewResume()
                if self.remainingtime ~= nil then
                    if self.task ~= nil then
                        self.task:Cancel()
                    end
                    if self.ingredient == nil then
                        self.task = self.inst:DoTaskInTime(FREEZE_TIME, DoSpoil, self)
                        self.tasktotime = GLOBAL.GetTime() + FREEZE_TIME
                    else
                        self.task = self.inst:DoTaskInTime(self.remainingtime, DoDry, self)
                        self.tasktotime = GLOBAL.GetTime() + self.remainingtime
                    end
                    self.remainingtime = nil
                end
            end
            self.Resume = NewResume
            self.DoSpoil = function()
            end
        end
    )
end

-- Soil retainer
local EntityScript = GLOBAL.EntityScript
local oldPushEvent = EntityScript.PushEvent

if GetModConfigData("dhp410_soil_retainer") then
    EntityScript.PushEvent = function(self, event, data, ...)
        if event == "breaksoil" and self.prefab == "farm_soil" then
            return
        end

        return oldPushEvent(self, event, data, ...)
    end
end

-- Poop Flingomatic
local require = GLOBAL.require
local Vector3 = GLOBAL.Vector3

local fertilizer_list = {
    ["fertilizer"] = true,
    ["glommerfuel"] = true,
    ["rottenegg"] = true,
    ["spoiled_food"] = true,
    ["guano"] = true,
    ["poop"] = true,
    ["compostwrap"] = true,
    ["compost"] = true
}

GLOBAL.STRINGS.NAMES.POOP_FLINGOMATIC = "Poop Flingomatic"
GLOBAL.STRINGS.RECIPE_DESC.POOP_FLINGOMATIC = "Fertilize plants and farms."

GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.POOP_FLINGOMATIC = "It stinks, but it's useful."

AddMinimapAtlas("minimap/poop_flingomatic.xml")

AddRecipe2(
    "poop_flingomatic",
    {Ingredient("transistor", 2),Ingredient("poop", 5),Ingredient("boards", 4)},
    GLOBAL.TECH.SCIENCE_ONE,
    {
        placer = "poop_flingomatic_placer",
        min_spacing = 2,
        atlas = "images/inventoryimages/poop_flingomatic.xml", -- atlas
        image = "poop_flingomatic.tex"
    },
    { 'GARDENING' }
)

local containers = require "containers"

local params = {}

-- used the same script of the mod "Large Chest" (workshop-396026892) to make this container setup
-- More like a "Copy and Paste" of the function... I've learned a lot reading the scripts from your mod, so, thanks!

local containers_widgetsetup_pf = containers.widgetsetup
function containers.widgetsetup(container, prefab, data, ...)
    local t = params[prefab or container.inst.prefab]
    if t ~= nil then
        for k, v in pairs(t) do
            container[k] = v
        end
        container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
    else
        containers_widgetsetup_pf(container, prefab, data, ...)
    end
end

params.poop_flingomatic = {
    widget = {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_chest_3x3",
        pos = Vector3(0, 200, 0),
        side_align_tip = 160
    },
    type = "chest"
}

for k, v in pairs(fertilizer_list) do
    AddPrefabPostInit(
        k,
        function(inst)
            inst:AddTag("poop_flingomatic_fertilizer")
        end
    )
end

function params.poop_flingomatic.itemtestfn(container, item, slot)
    if item:HasTag("poop_flingomatic_fertilizer") then
        return true
    end
    return false
end

for y = 2, 0, -1 do
    for x = 0, 2 do
        table.insert(params.poop_flingomatic.widget.slotpos, Vector3(80 * x - 80 * 2 + 80, 80 * y - 80 * 2 + 80, 0))
    end
end

containers.MAXITEMSLOTS =
    math.max(
    containers.MAXITEMSLOTS,
    params.poop_flingomatic.widget.slotpos ~= nil and #params.poop_flingomatic.widget.slotpos or 0
)
