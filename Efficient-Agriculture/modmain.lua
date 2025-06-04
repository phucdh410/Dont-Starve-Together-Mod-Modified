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


-------------------------
-- [文本本地化]
-------------------------
local mod_loc_files = {         --本mod的所有本地化文件名
    "common",                   --无法归类或没必要归类的文本
    "ui",                       --界面相关文本
}

local user_setting_lan = GetModConfigData("language")       --读取Mod语言自定义设置
local loc = require "languages/loc"
local lan = loc and loc.GetLanguage and loc.GetLanguage()   --读取玩家的客户端语言设置
local folder = ""
if user_setting_lan == "CHINESE" then
    folder = "zh-cn"
elseif user_setting_lan == "ENGLISH" then
    folder = "en"
else
    if lan == LANGUAGE.CHINESE_S or lan == LANGUAGE.CHINESE_S_RAIL then
        folder = "zh-cn"
    else
        folder = "en"
    end
end
assert(folder and folder ~= "", "[Efficient Agriculture Error] Failed to load loc file")    --语言设置报错
for _, f_name in ipairs(mod_loc_files) do
    modimport("scripts/localization/"..folder.."/"..f_name)     --加载所有本地化文件
end


--------------------------
-- main_scripts
--------------------------
-- [全局常量(大量mod数据配置)]
modimport("ea_main_scripts/constants.lua")

-- [加入机器prefab]
if EA_CONSTANTS.ADDED_HARVEST then
    table.insert(PrefabFiles,"ea_harvest_machine")
end
if EA_CONSTANTS.ADDED_SEEDING then
    table.insert(PrefabFiles,"ea_seeding_machine")
end
if EA_CONSTANTS.ADDED_SHOP then
    table.insert(PrefabFiles,"ea_shop")
end

-- [工具函数]
modimport("ea_main_scripts/tools.lua")

-- [注册RPC]
modimport("ea_main_scripts/rpc.lua")

--[Controller]
modimport("ea_main_scripts/controller.lua")

--[Containers]
modimport("ea_main_scripts/containers.lua")

-- [UI修改]
modimport("ea_main_scripts/ui.lua")

-- [SG]
-- modimport("ea_main_scripts/sg.lua")

-- [Actions]
modimport("ea_main_scripts/actions.lua")

-- [配方]
modimport("ea_main_scripts/recipes.lua")

-- [Replica Components]
AddReplicableComponent("ea_rectangle")


-- [小地图图标注册]
AddMinimapAtlas("images/minimap/ea_fertilizer_machine_mini.xml")
AddMinimapAtlas("images/minimap/ea_seeding_machine_mini.xml")
AddMinimapAtlas("images/minimap/ea_harvest_machine_mini.xml")
AddMinimapAtlas("images/minimap/ea_harvest_machine2_mini.xml")
AddMinimapAtlas("images/minimap/ea_farm_plow_machine_mini.xml")
AddMinimapAtlas("images/minimap/ea_shop_mini.xml")
AddMinimapAtlas("images/minimap/ea_well_mini.xml")

-------------------------
-- [针对本MOD的其它修改]
-------------------------

-- 金坷垃可研究
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

-- 显示旋转收获机提示文本
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

-- [Camera]
-- 视角锁定(通过设置摄像机的lock_heading_target属性为true来锁定视角)
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