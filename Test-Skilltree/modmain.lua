local TUNING = GLOBAL.TUNING
local UIAnim = GLOBAL.require("widgets/uianim")
local TextButton = GLOBAL.require("widgets/textbutton")
local Widget = GLOBAL.require("widgets/widget")

-- Configurable options
-- local max_skill_points = GetModConfigData("max_skill_points")
local max_skill_points = 35
-- local instant_unlock = GetModConfigData("instant_unlock")
local instant_unlock = true

-- Custom skill thresholds array generation
local function GetCustomSkillThresholds(max_points, unlock_all)
    local thresholds = {}
    for i = 1, max_points do
        if unlock_all then
            thresholds[i] = 0
        elseif i <= 2 then
            thresholds[i] = 3
        elseif i <= 5 then
            thresholds[i] = 4
        elseif i <= 19 then
            thresholds[i] = 5
        else
            thresholds[i] = 6
        end
    end
    return thresholds
end

-- Generate and apply the custom skill thresholds
TUNING.SKILL_THRESHOLDS = GetCustomSkillThresholds(max_skill_points, instant_unlock)

-- Hook into game initialization to ensure thresholds are applied
local function InitializeCustomSkillThresholds()
    TUNING.SKILL_THRESHOLDS = GetCustomSkillThresholds(max_skill_points, instant_unlock)
end

AddSimPostInit(InitializeCustomSkillThresholds)

-- Skill tree prefabs table
local function skilltree_prefabs_table(skiltree_prefabs)
    local prefabs = {}
    for _, name in ipairs(skiltree_prefabs) do
        prefabs[name] = true
    end
    return prefabs
end

local SKILLTREE_PREFABS = skilltree_prefabs_table({
    "wilson", 
    "woodie", 
    "wolfgang", 
    "wormwood", 
    "wathgrithr", 
    "willow",
    "wurt",
    "winona",
    "walter",
    "wendy",
    "wortox"
})

-- Apply skill XP and set key-value pairs for eligible characters
AddPrefabPostInit("world", function(world)    
    world:ListenForEvent("playeractivated", function(world, player)
        if player == GLOBAL.ThePlayer and 
           player.components.skilltreeupdater and
           SKILLTREE_PREFABS[player.prefab] 
        then
            GLOBAL.TheGenericKV:SetKV("fuelweaver_killed", "1")
            GLOBAL.TheGenericKV:SetKV("celestialchampion_killed", "1")
            player.components.skilltreeupdater:AddSkillXP(160)
        end
    end)
end)

-- Add UI button to increase/decrease skill points
AddClassPostConstruct("screens/skilltreescreen", function(self)
    local player = self.owner
    if not player or not player.components.skilltreeupdater then
        return
    end

    -- Create a widget to hold the buttons
    local skill_point_widget = self:AddChild(Widget("skill_point_widget"))
    skill_point_widget:SetPosition(0, -200, 0) -- Adjust position as needed

    -- Increase skill points button
    local increase_button = skill_point_widget:AddChild(TextButton())
    increase_button:SetText("+ Skill Point")
    increase_button:SetFont(GLOBAL.BUTTONFONT)
    increase_button:SetTextSize(30)
    increase_button:SetPosition(-100, 0, 0)
    increase_button:SetOnClick(function()
        if player.components.skilltreeupdater then
            local current_points = player.components.skilltreeupdater:GetAvailableSkillPoints()
            if current_points < max_skill_points then
                player.components.skilltreeupdater:AddSkillXP(1) -- Add 1 skill point worth of XP
                print("Added 1 skill point. Total: " .. (current_points + 1))
            else
                print("Max skill points reached: " .. max_skill_points)
            end
        end
    end)

    -- Decrease skill points button
    local decrease_button = skill_point_widget:AddChild(TextButton())
    decrease_button:SetText("- Skill Point")
    decrease_button:SetFont(GLOBAL.BUTTONFONT)
    decrease_button:SetTextSize(30)
    decrease_button:SetPosition(100, 0, 0)
    decrease_button:SetOnClick(function()
        if player.components.skilltreeupdater then
            local current_points = player.components.skilltreeupdater:GetAvailableSkillPoints()
            if current_points > 0 then
                player.components.skilltreeupdater:AddSkillXP(-1) -- Remove 1 skill point worth of XP
                print("Removed 1 skill point. Total: " .. (current_points - 1))
            else
                print("No skill points to remove.")
            end
        end
    end)
end)