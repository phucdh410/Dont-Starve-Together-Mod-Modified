-- Utilities

local function RGBA(R, G, B, A) return {R / 255, G / 255, B / 255, A or 1} end


-- Server handlers

local function OnMount(rider, data)
    local mount = data.target
    if mount and mount.prefab == "beefalo" then
        local saddle = rider.replica.rider:GetSaddle()
        local mountData = {
            health = mount.replica.health:GetCurrent(),
            maxHealth = mount.replica.health:Max(),
            domestication = mount.components.domesticatable:GetDomestication() * 100,
            tendency = mount.tendency,
            obedience = mount.components.domesticatable:GetObedience() * 100,
            bucktime = GLOBAL.GetTaskRemaining(mount._bucktask),
            hunger = mount.replica.hunger:GetCurrent(),
            maxHunger = mount.replica.hunger:Max(),
            saddleUses = (saddle and saddle.components.finiteuses) and saddle.components.finiteuses:GetUses() or 0
        }

        rider.player_classified.beefaloData:set(GLOBAL.json.encode(mountData))
        rider.player_classified.beefaloHealth:set_local(mountData.health)
        rider.player_classified.beefaloDomestication:set_local(GLOBAL.json.encode({domestication = mountData.domestication, tendency = mountData.tendency}))
        rider.player_classified.beefaloObedience:set_local(mountData.obedience)
        rider.player_classified.beefaloHunger:set_local(mountData.hunger)
        rider:ListenForEvent("healthdelta", rider.player_classified.OnBeefaloHealthDelta, mount)
        rider:ListenForEvent("domesticationdelta", rider.player_classified.OnBeefaloDomesticationDelta, mount)
        rider:ListenForEvent("obediencedelta", rider.player_classified.OnBeefaloObedienceDelta, mount)
        rider:ListenForEvent("hungerdelta", rider.player_classified.OnBeefaloHungerDelta, mount)
    end
end

local function OnDismount(rider, data)
    local mount = data.target
    if mount and mount.prefab == "beefalo" then
        rider.player_classified.beefaloData:set("dismount")
        rider:RemoveEventCallback("healthdelta", rider.player_classified.OnBeefaloHealthDelta, mount)
        rider:RemoveEventCallback("domesticationdelta", rider.player_classified.OnBeefaloDomesticationDelta, mount)
        rider:RemoveEventCallback("obediencedelta", rider.player_classified.OnBeefaloObedienceDelta, mount)
        rider:RemoveEventCallback("hungerdelta", rider.player_classified.OnBeefaloHungerDelta, mount)
    end
end


-- Network setup

AddPrefabPostInit("player_classified", function(inst)
    inst.beefaloData = GLOBAL.net_string(inst.GUID, "beefaloData", "beefaloDataDirty")
    inst.beefaloHealth = GLOBAL.net_ushortint(inst.GUID, "beefaloHealth", "beefaloHealthDirty")
    inst.beefaloDomestication = GLOBAL.net_string(inst.GUID, "beefaloDomestication", "beefaloDomesticationDirty")
    inst.beefaloObedience = GLOBAL.net_byte(inst.GUID, "beefaloObedience", "beefaloObedienceDirty")
    inst.beefaloBuckTime = GLOBAL.net_float(inst.GUID, "beefaloBuckTime", "beefaloBuckTimeDirty")
    inst.beefaloHunger = GLOBAL.net_ushortint(inst.GUID, "beefaloHunger", "beefaloHungerDirty")
    
    if not GLOBAL.TheWorld.ismastersim then return end

    inst.OnBeefaloHealthDelta = function(beefalo, data)
        inst.beefaloHealth:set(beefalo.replica.health:GetCurrent())
    end
    
    inst.OnBeefaloDomesticationDelta = function(beefalo, data)
        local domestData = {domestication = beefalo.components.domesticatable:GetDomestication() * 100, tendency = beefalo.tendency}
        inst.beefaloDomestication:set(GLOBAL.json.encode(domestData))
    end
    
    inst.OnBeefaloObedienceDelta = function(beefalo, data)
        inst.beefaloObedience:set(beefalo.components.domesticatable:GetObedience() * 100)
        if data.new > data.old then
            local bucktime = GLOBAL.GetTaskRemaining(beefalo._bucktask)
            inst.beefaloBuckTime:set_local(bucktime)
            inst.beefaloBuckTime:set(bucktime)
        end
    end
    
    inst.OnBeefaloHungerDelta = function(beefalo, data)
        inst.beefaloHunger:set(beefalo.replica.hunger:GetCurrent())
    end
    

    inst:DoStaticTaskInTime(0, function()
        local parent = inst.entity:GetParent()
        -- Events from components/rider
        inst:ListenForEvent("mounted", OnMount, parent)
        inst:ListenForEvent("dismounted", OnDismount, parent)
    end)
    
end)


-- Configuration and settings

local COLORS = {
    ORANGE = RGBA(145, 55, 30),
    ORANGE_ALT = RGBA(186, 72, 41),
    BLUE = RGBA(33, 69, 69),
    BLUE_ALT = RGBA(15, 120, 120),
    PURPLE = RGBA(100, 40, 80),
    PURPLE_ALT = RGBA(115, 30, 80),
    RED = RGBA(115, 30, 30),
    RED_ALT = RGBA(150, 25, 25),
    GREEN = RGBA(33, 69, 48),
    GREEN_ALT = RGBA(20, 125, 65),
    BEIGE = RGBA(180, 165, 125),
    WHITE = RGBA(180, 180, 180),
    YELLOW = RGBA(195, 165, 15)
}

local CLIENT_CONFIG = GetModConfigData("ClientConfig", true)

local BADGE_COLORS = {
    ORNERY = COLORS[GetModConfigData("COLOR_DOMESTICATION_ORNERY", CLIENT_CONFIG)],
    RIDER = COLORS[GetModConfigData("COLOR_DOMESTICATION_RIDER", CLIENT_CONFIG)],
    PUDGY = COLORS[GetModConfigData("COLOR_DOMESTICATION_PUDGY", CLIENT_CONFIG)],
    DEFAULT = COLORS[GetModConfigData("COLOR_DOMESTICATION_DEFAULT", CLIENT_CONFIG)],
    OBEDIENCE = COLORS[GetModConfigData("COLOR_OBEDIENCE", CLIENT_CONFIG)],
    TIMER = COLORS[GetModConfigData("COLOR_TIMER", CLIENT_CONFIG)]
}

local OFFSETS = {
    -- Offsets X
    X = GetModConfigData("OffsetX", CLIENT_CONFIG),
    X_MULT = GetModConfigData("OffsetXMult", CLIENT_CONFIG),
    X_FINE = GetModConfigData("OffsetXFine", CLIENT_CONFIG),
    -- Offsets Y
    Y = GetModConfigData("OffsetY", CLIENT_CONFIG),
    Y_MULT = GetModConfigData("OffsetYMult", CLIENT_CONFIG),
    Y_FINE = GetModConfigData("OffsetYFine", CLIENT_CONFIG)
}

local SCALE = GetModConfigData("Scale", CLIENT_CONFIG)
local SCALE_OFFSET = 1 + (SCALE - 1) / 3


local CONFIG = {
    SHOW_BY_DEFAULT = GetModConfigData("ShowByDefault", CLIENT_CONFIG),
    ENABLE_SOUNDS = GetModConfigData("EnableSounds", CLIENT_CONFIG),

    THEME = GetModConfigData("Theme", CLIENT_CONFIG),
    HUNGER_THRESHOLD = GetModConfigData("HungerThreshold", CLIENT_CONFIG),
    HEALTH_CLEAR_BG = GetModConfigData("HEALTH_BADGE_CLEAR_BG", CLIENT_CONFIG),
    BG_BRIGHTNESS = GetModConfigData("BADGE_BG_BRIGHTNESS", CLIENT_CONFIG) / 100,
    BG_OPACITY = GetModConfigData("BADGE_BG_OPACITY", CLIENT_CONFIG) / 100,
    GAP_MODIFIER = GetModConfigData("GapModifier", CLIENT_CONFIG),
    TOGGLE_KEY = GetModConfigData("ToggleKey", CLIENT_CONFIG),
    SCALE = SCALE,
    BADGE_COLORS = BADGE_COLORS,
    
    BASE_X = (OFFSETS.X * OFFSETS.X_MULT) + OFFSETS.X_FINE,
    BASE_Y = (95 * SCALE_OFFSET) + (OFFSETS.Y * OFFSETS.Y_MULT) + OFFSETS.Y_FINE,
    BASE_Y_MODIFIED = false,

    ROOT_X = 0,
    ROOT_Y = 0,
    ROOT_Y_HIDDEN = -130 / SCALE_OFFSET
}


-- Widget setup

local BeefaloStatusBar = require "widgets/beefaloStatusBar"
AddClassPostConstruct("widgets/controls", function(self, owner)
    self.BeefaloStatusBar = self.bottom_root:AddChild(BeefaloStatusBar(owner, CONFIG))
    self.BeefaloStatusBar:MoveToBack()
end)

-- Reposition for integrated backpack
local InventoryBar = require "widgets/inventorybar"
local DefaultRebuild = InventoryBar.Rebuild
function InventoryBar:Rebuild(...)
    -- This also runs once when you load in, even with separated backpack (probably triggered from Inventory:AttachClassified()).
	DefaultRebuild(self, ...)
    self.owner:PushEvent("RepositionStatusBar")
end


if CONFIG.TOGGLE_KEY then
    GLOBAL.TheInput:AddKeyUpHandler(GLOBAL[CONFIG.TOGGLE_KEY], function()
        if GLOBAL.ThePlayer then GLOBAL.ThePlayer:PushEvent("ToggleStatusBar") end
    end)
end

if GetModConfigData("isBuffDomestication") == true then
    TUNING.BEEFALO_MIN_BUCK_TIME = 999 * 60 * 60 -- 999 hours
    TUNING.BEEFALO_MAX_BUCK_TIME = 9999 * 60 * 60 -- 9999 hours
    
    local function OnEat(inst, food, feeder)
        local full = inst.components.hunger:GetPercent() >= 1
        if inst.components and inst.components.hunger then
            inst.components.hunger:DoDelta(500)
        end
        inst.components.domesticatable:DeltaObedience(1)
        inst.components.domesticatable:DeltaDomestication(0.1, feeder)
        if not full then
            inst.components.domesticatable:TryBecomeDomesticated()
        else
            inst.components.domesticatable:DeltaTendency(GLOBAL.TENDENCY.PUDGY, TUNING.BEEFALO_PUDGY_OVERFEED)
        end
        inst:PushEvent("eat", { full = full, food = food })
        inst.components.knownlocations:RememberLocation("loiteranchor", inst:GetPosition())
    end
    
    AddPrefabPostInit("beefalo",function(inst)
        inst:DoTaskInTime(0.1, function(inst)
            if inst.components and inst.components.eater then
                inst.components.eater:SetOnEatFn(OnEat)
            end
            inst:WatchWorldState("cycles",function(inst)
                if inst.components and inst.components.domesticatable then
                    if inst.components.domesticatable:IsDomesticated() then
                        inst.components.domesticatable:DeltaObedience(1)         
                        if inst.components and inst.components.hunger then
                            inst.components.hunger:DoDelta(500)
                        end
                    end
                end
            end)
        end)
    end)
end
 
