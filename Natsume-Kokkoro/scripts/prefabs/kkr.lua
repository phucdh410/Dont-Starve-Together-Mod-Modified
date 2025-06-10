local MakePlayerCharacter = require "prefabs/player_common"

local assets = {
    Asset("ANIM", "anim/kkr.zip"),
    Asset("ANIM", "anim/kkr_skin_uniform.zip"),
    Asset("ANIM", "anim/ghost_kkr_build.zip"),
    Asset("IMAGE", "images/saveslot_portraits/kkr.tex"),
    Asset("ATLAS", "images/saveslot_portraits/kkr.xml"),
    Asset("IMAGE", "images/selectscreen_portraits/kkr.tex"),
    Asset("ATLAS", "images/selectscreen_portraits/kkr.xml"),
    Asset("IMAGE", "images/selectscreen_portraits/kkr_silho.tex"),
    Asset("ATLAS", "images/selectscreen_portraits/kkr_silho.xml"),
    Asset("IMAGE", "bigportraits/kkr.tex"),
    Asset("ATLAS", "bigportraits/kkr.xml"),
    Asset("IMAGE", "images/map_icons/kkr.tex"),
    Asset("ATLAS", "images/map_icons/kkr.xml"),
    Asset("IMAGE", "images/avatars/avatar_kkr.tex"),
    Asset("ATLAS", "images/avatars/avatar_kkr.xml"),
    Asset("IMAGE", "images/avatars/avatar_ghost_kkr.tex"),
    Asset("ATLAS", "images/avatars/avatar_ghost_kkr.xml"),
    Asset("IMAGE", "images/avatars/self_inspect_kkr.tex"),
    Asset("ATLAS", "images/avatars/self_inspect_kkr.xml"),
    Asset("IMAGE", "images/names_kkr.tex"),
    Asset("ATLAS", "images/names_kkr.xml"),
    Asset("ANIM", "anim/player_lunge_kkr.zip"),
    Asset("ANIM", "anim/kkr_fly.zip")
}
local prefabs = {}

local start_inv = {"kkr_gemstaff", "kkr_elfrobe", "kkr_pocket", "sewing_kit"}
if TUNING.GAMEMODE_STARTING_ITEMS and TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT then
    TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.KKR = start_inv
    for _, item in ipairs(start_inv) do
        if item ~= "sewing_kit" then
            TUNING.STARTING_ITEM_IMAGE_OVERRIDE[item] = {
                atlas = "images/inventoryimages/" .. item .. ".xml",
                image = item .. ".tex"
            }
        end
    end
end

local function DoPlantBonus(inst)
    if inst and inst.components.sanity then
        inst.components.sanity:DoDelta(3)
    end
end

local function WatchWorldPlants(inst)
    if not inst._onitemplanted then
        inst._onitemplanted = function(src, data)
            if not data then
            elseif data.doer == inst then
                DoPlantBonus(inst)
            end
        end
        inst:ListenForEvent("itemplanted", inst._onitemplanted, TheWorld)
    end
end

local function StopWatchingWorldPlants(inst)
    if inst._onitemplanted then
        inst:RemoveEventCallback("itemplanted", inst._onitemplanted, TheWorld)
        inst._onitemplanted = nil
    end
end

local function onhitother(inst, data)
    if inst:IsValid() then
        inst:AddDebuff("kkr_speedup", "kkr_speedup")
    end
end

local function CustomCombatDamage(inst, target, weapon, multiplier, mount)
    local mul = 1
    if inst:IsValid() then
        if inst.components.locomotor then
            local speedMultiplier = inst.components.locomotor:GetSpeedMultiplier()
            if speedMultiplier < 1 then
                speedMultiplier = 1
            end

            mul = mul + (speedMultiplier - 1) * KKRENV.KKR_SPEEDATKMUL
        end
    end

    return mul
end

local function SpawnButterfly(inst)
    if not inst.kkr_wind_spirit_leader then
        local leader = SpawnPrefab("kkr_wind_spirit_leader")
        inst.kkr_wind_spirit_leader = leader
        leader.components.kkrspiritleader:SetTarget(inst)
    end

    local num_spirits = inst.kkr_wind_spirit_leader.components.kkrspiritleader:GetFormationSize()
    if num_spirits >= 3 then
        return
    end

    local x, y, z = inst.Transform:GetWorldPosition()
    local offset_x = math.cos(PI / 3) * 3
    local offset_z = math.sin(PI / 3) * 3

    local spirit = SpawnPrefab("kkr_wind_spirit")
    spirit.Transform:SetPosition(x + offset_x, y, z + offset_z)

    inst.kkr_wind_spirit_leader.components.kkrspiritleader:SetMember(spirit)
    inst.kkr_wind_spirit_leader.components.kkrspiritleader:StartUpdatingComponent()
end

local function OnCooldown(inst)
    inst._cdtaskd = nil
end

local function kkr_domain(inst)
    if not inst or not inst.kkr_wind_spirit_leader then
        inst.components.talker:Say("There are currently no following wind elves")
        return false
    end

    local num_spirits = inst.kkr_wind_spirit_leader.components.kkrspiritleader:GetFormationSize()
    if num_spirits <= 0 then
        inst.components.talker:Say("There are currently no following wind elves")
        return false
    end

    local is_flying = inst:HasTag("kkr_fly")
    local spirits_required = is_flying and 1 or 2

    if inst._cdtaskd == nil and num_spirits >= spirits_required then
        inst._cdtaskd = inst:DoTaskInTime(KKRENV.KKR_DOMAINCD, OnCooldown)

        local formation = inst.kkr_wind_spirit_leader.components.kkrspiritleader.formation
        for i = 1, spirits_required do
            local random_index = math.random(1, #formation)
            if formation[random_index] and formation[random_index]:IsValid() then
                formation[random_index]:Remove()
                table.remove(formation, random_index)
            end
        end

        local pos = inst:GetPosition()
        if is_flying then
            local domain = SpawnPrefab("kkr_domain")
            domain.Transform:SetPosition(pos:Get())
            inst.components.talker:Say("Aurora Sanctuary！")
        else
            inst.components.talker:Say("Aurora bloom！")
        end

        local cure_flower = SpawnPrefab("kkr_cureflower")
        if is_flying then
            cure_flower.ongroundmode = false
        end
        cure_flower.Transform:SetPosition(pos:Get())
        cure_flower:Start(cure_flower)

        return true
    else
        inst.components.talker:Say("The realm is still on cooldown or there are not enough wind spirits.")
        return false
    end
end

local function RemoveButterfly(inst)
    if inst.kkr_wind_spirit_leader then
        inst.kkr_wind_spirit_leader.components.kkrspiritleader:DisbandFormation()
        inst.kkr_wind_spirit_leader = nil
    end
    if inst.kkr_wind_spirit_leader_task then
        inst.kkr_wind_spirit_leader_task:Cancel()
        inst.kkr_wind_spirit_leader_task = nil
    end
end

local function onbecamehuman(inst)
    inst.components.locomotor:SetExternalSpeedMultiplier(inst, "kkr_speed_mod", 1)

    WatchWorldPlants(inst)
end

local function onbecameghost(inst)
    inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "kkr_speed_mod")
    StopWatchingWorldPlants(inst)
end

local function onload(inst)
    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end

local common_postinit = function(inst)
    inst.MiniMapEntity:SetIcon("kkr.tex")
    inst:AddTag("kkr")
    inst:AddTag("expertchef")
    inst.AnimState:OverrideSymbol("fx_lunge_streak", "player_lunge_kkr", "fx_lunge_streak")
end

local master_postinit = function(inst)
    inst.soundsname = "wendy"

    inst:AddComponent("kkrfly")

    inst.components.health:SetMaxHealth(KKRENV.TUNING.KKR_HEALTH)
    inst.components.hunger:SetMax(KKRENV.TUNING.KKR_SANITY)
    inst.components.sanity:SetMax(KKRENV.TUNING.KKR_HUNGER)

    inst.components.combat.damagemultiplier = KKRENV.KKR_DAMAGEMULTIPLIER

    inst.components.health.absorb = KKRENV.KKR_HEALTHABSORB

    inst.components.hunger.hungerrate = 1 * TUNING.WILSON_HUNGER_RATE

    inst.components.temperature.mintemp = -10
    inst.components.temperature.maxtemp = 80
    inst.components.freezable.resistance = 180

    WatchWorldPlants(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)
    if KKRENV.KKR_ATKBUFF_ENABLE then
        inst:ListenForEvent("onhitother", onhitother)
    end
    inst.components.combat.customdamagemultfn = CustomCombatDamage
    inst.kkr_wind_spirit_leader_task = inst:DoPeriodicTask(KKRENV.KKR_SPIRITCD, SpawnButterfly)
    inst.kkr_domain = kkr_domain
    inst.OnLoad = onload
    inst.OnNewSpawn = onload
end

KKRENV.MakeCharacterSkin(
    "kkr",
    "kkr_none",
    {
        name = "Coconut",
        des = "Coconut",
        quotes = "Coconut",
        rarity = "Coconut",
        rarityorder = 1,
        raritycorlor = {123 / 255, 104 / 255, 238 / 255, 1},
        skins = {normal_skin = "kkr", ghost_skin = "ghost_kkr_build"},
        skin_tags = {"BASE", "kkr", "CHARACTER"},
        build_name_override = "kkr",
        share_bigportrait_name = "kkr"
    }
)
KKRENV.MakeCharacterSkin(
    "kkr",
    "kkr_skin_uniform",
    {
        name = "Cocoro (school uniform)",
        des = "Cocoro (school uniform)",
        quotes = "Cocoro (school uniform)",
        rarity = "Cocoro (school uniform)",
        rarityorder = 1,
        raritycorlor = {135 / 255, 206 / 255, 250 / 255, 1},
        skins = {normal_skin = "kkr_skin_uniform", ghost_skin = "ghost_kkr_build"},
        skin_tags = {"BASE", "kkr", "CHARACTER"},
        build_name_override = "kkr",
        share_bigportrait_name = "kkr"
    }
)

return MakePlayerCharacter("kkr", prefabs, assets, common_postinit, master_postinit, start_inv)
