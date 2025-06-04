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
}

modimport("scripts/common.lua")

modimport("scripts/ui.lua")

modimport("ea_main_scripts/constants.lua")

if EA_CONSTANTS.ADDED_HARVEST then
    table.insert(PrefabFiles,"ea_harvest_machine")
end
if EA_CONSTANTS.ADDED_SEEDING then
    table.insert(PrefabFiles,"ea_seeding_machine")
end
if EA_CONSTANTS.ADDED_SHOP then
    table.insert(PrefabFiles,"ea_shop")
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
    uses = 1,
}

local rotable_placers = {}
function _G.RegisterRotablePlacer(prefab_name)
    if type(prefab_name) == "string" then
        rotable_placers[prefab_name] = true
    end
end
AddComponentPostInit("playercontroller", function(self)
    local old_GetHoverTextOverride = self.GetHoverTextOverride
    self.GetHoverTextOverride = function (self)
        if self.placer_recipe then
            if rotable_placers[self.placer_recipe.name] then
                return STRINGS.UI.HUD.BUILD.." "..(STRINGS.NAMES[string.upper(self.placer_recipe.name)] or STRINGS.UI.HUD.HERE).."\n"..string.format(STRINGS.EA_ROTATE, EA_CONSTANTS.HARVEST_MACHINE_PLACER_ROTATE_KEY)
            end
        end
        return old_GetHoverTextOverride(self)
    end
end)

AddGlobalClassPostConstruct("cameras/followcamera", "FollowCamera", function(self)
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
end)