local MakePlayerCharacter = require 'prefabs/player_common'
local brain = require 'brains/xxx3brain'

local assets = {
    Asset('SCRIPT', 'scripts/prefabs/player_common.lua')
}

local XXX3_BONUS_TILES = {
    WORLD_TILES.XXX3_TURF,
    WORLD_TILES.XXX3_TURF_SP
}

-- Your character's stats
TUNING.XXX3_HEALTH = 90
TUNING.XXX3_HUNGER = 100
TUNING.XXX3_SANITY = 200

-- Custom starting inventory
TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.XXX3 = {
    'lureplantbulb'
}

local function onpick(inst, data)
    if data.object.prefab == 'flower' then
        inst.components.sanity:DoDelta(-20)
    end
end

local function getsanfromflowers(inst)
    local n = 0
    local x, y, z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, y, z, 5)
    for k, v in pairs(ents) do
        if v:HasTag('flower') or v.prefab == 'xxx3_wf' then
            n = n + 1
        end
    end
    inst.components.sanity.dapperness = 0.03 * n
end

local start_inv = {}
for k, v in pairs(TUNING.GAMEMODE_STARTING_ITEMS) do
    start_inv[string.lower(k)] = v.XXX3
end
local prefabs = FlattenTree(start_inv, true)

-- When the character is revived from human
local function onbecamehuman(inst)
    -- Set speed when not a ghost (optional)
    inst.components.locomotor:SetExternalSpeedMultiplier(inst, 'xxx3_speed_mod', 1)
    local x, y, z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, y, z, 4)
    for k, v in pairs(ents) do
        if v.prefab == 'xxx3_bulbfx' then
            v:Remove()
        end
    end
end

local function onbecameghost(inst)
    -- Remove speed modifier when becoming a ghost
    inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, 'xxx3_speed_mod')
    if inst.components.minionspawner then
        inst.components.xxx3_skill:SetEnabled(false)
        inst.components.minionspawner.shouldspawn = false
        inst.components.minionspawner:KillAllMinions()
        inst:RemoveComponent('minionspawner')

        local x, y, z = inst.Transform:GetWorldPosition()
        local ents = TheSim:FindEntities(x, y, z, 4)
        for k, v in pairs(ents) do
            if v.prefab == 'xxx3_bulbfx' then
                v:Remove()
            end
        end
    end
end

-- When loading or spawning the character
local function onload(inst)
    inst:ListenForEvent('ms_respawnedfromghost', onbecamehuman)
    inst:ListenForEvent('ms_becameghost', onbecameghost)

    if inst:HasTag('playerghost') then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end

-- This initializes for both the server and client. Tags can be added here.
local common_postinit = function(inst)
    -- Minimap icon
    inst.MiniMapEntity:SetIcon('xxx3.tex')
    inst:AddTag('xxx3')
    inst:AddTag('eyeplant_friend')
end

local function seasonchange(inst, season)
    if inst.components.xxx3_minionspawner then
        inst.components.xxx3_minionspawner.shouldspawn = false
        inst.components.xxx3_minionspawner:KillAllMinions()
        if (season == 'summer') then
            inst.components.xxx3_minionspawner.miniontype = 'xxx3_eyeplant_2'
        elseif season == 'winter' then
            inst.components.xxx3_minionspawner.miniontype = 'xxx3_eyeplant_4'
        elseif season == 'autumn' then
            inst.components.xxx3_minionspawner.miniontype = 'xxx3_eyeplant_3'
        elseif season == 'spring' then
            inst.components.xxx3_minionspawner.miniontype = 'xxx3_eyeplant_1'
        end
        inst.components.xxx3_minionspawner.shouldspawn = true
    end
    if season ~= 'summer' then
        inst.components.health.fire_damage_scale = 1
    end
end

local function onattack(inst, tar)
    local target = tar.target
    if target.prefab == 'lureplant' and target.components.health and not target.components.health:IsDead() then
        target.components.health:DoDelta(-60)
    end
end
-- This initializes for the server only. Components are added here.
local master_postinit = function(inst)
    inst.soundsname = 'wendy'

    inst.Transform:SetScale(1.0, 1.0, 1.0)
    inst.components.health:SetMaxHealth(90)
    inst.components.hunger:SetMax(100)
    inst.components.sanity:SetMax(200)
    inst.components.sanity.no_moisture_penalty = true
    inst.components.combat.damagemultiplier = 1

    inst.components.combat:SetAttackPeriod(TUNING.WILSON_ATTACK_PERIOD * 1)
    inst.components.hunger.hungerrate = 1 * TUNING.WILSON_HUNGER_RATE --0.15625
    inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1)
    inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1)
    inst.components.health:StartRegen(0, 0)
    inst.components.sanity.no_moisture_penalty = true

    for _, tile in ipairs(XXX3_BONUS_TILES) do
        inst.components.locomotor:SetFasterOnGroundTile(tile, true)
    end

    inst.attackSpeed = 0
    inst.hasAttack = 0
    inst.hasAttackDispear = 0
    inst.OnLoad = onload
    inst.OnNewSpawn = onload

    inst:AddComponent('xxx3_skill')
    inst:WatchWorldState('season', seasonchange)

    inst:SetBrain(brain)

    inst:ListenForEvent('picksomething', onpick)
    inst:ListenForEvent('onattackother', onattack)
    inst:DoPeriodicTask(1, getsanfromflowers)
    -- inst:DoPeriodicTask(4, getposition)
end

local function MakeSkin(name, data)
    local d = {}
    d.skin_tags = {'XXX3', 'CHARACTER', 'BASE'}
    d.skins = {normal_skin = name, ghost_skin = 'ghost_xxx3_build'}
    d.checkfn = nil
    d.checkclientfn = nil
    for k, v in pairs(data) do
        d[k] = v
    end
    SoraAPI.MakeCharacterSkin('xxx3', name, d)
end
MakeSkin(
    'xxx3_none',
    {
        name = STRINGS.NAMES.XXX3,
        type = 'base',
        des = STRINGS.CHARACTER_DESCRIPTIONS.xxx3,
        quotes = STRINGS.CHARACTER_QUOTES.xxx3,
        build_name_override = 'xxx3',
        rarity = 'Character',
        skins = {normal_skin = 'xxx3', ghost_skin = 'ghost_xxx3_build'},
        assets = {
            Asset('ANIM', 'anim/xxx3.zip'),
            Asset('ANIM', 'anim/ghost_xxx3_build.zip')
        }
    }
)

MakeSkin(
    'xxx3_victorian',
    {
        name = STRINGS.SKIN_NAMES.xxx3_victorian,
        des = STRINGS.SKIN_DESCRIPTIONS.xxx3_victorian,
        quotes = STRINGS.SKIN_QUOTES.xxx3_victorian,
        build_name_override = 'xxx3_victorian',
        rarity = 'Classy',
        rarity_modifier = 'CharacterModifier',
        skip_item_gen = true,
        skip_giftable_gen = true,
        assets = {
            Asset('ANIM', 'anim/xxx3_victorian.zip'),
            Asset('ANIM', 'anim/ghost_xxx3_build.zip')
        }
    }
)
MakeSkin(
    'xxx3_shadow',
    {
        name = STRINGS.SKIN_NAMES.xxx3_shadow,
        des = STRINGS.SKIN_DESCRIPTIONS.xxx3_shadow,
        quotes = STRINGS.SKIN_QUOTES.xxx3_shadow,
        build_name_override = 'xxx3_shadow',
        type = 'base',
        rarity = 'Elegant',
        rarity_modifier = 'CharacterModifier',
        skip_item_gen = true,
        skip_giftable_gen = true,
        assets = {
            Asset('ANIM', 'anim/xxx3_shadow.zip'),
            Asset('ANIM', 'anim/ghost_xxx3_build.zip')
        }
    }
)

MakeSkin(
    'xxx3_myth',
    {
        name = STRINGS.SKIN_NAMES.xxx3_myth,
        des = STRINGS.SKIN_DESCRIPTIONS.xxx3_myth,
        quotes = STRINGS.SKIN_QUOTES.xxx3_myth,
        build_name_override = 'xxx3_myth',
        type = 'base',
        rarity = 'Distinguished',
        rarity_modifier = 'CharacterModifier',
        skip_item_gen = true,
        skip_giftable_gen = true,
        assets = {
            Asset('ANIM', 'anim/xxx3_myth.zip'),
            Asset('ANIM', 'anim/ghost_xxx3_build.zip')
        }
    }
)

MakeSkin(
    'xxx3_huohuo',
    {
        name = STRINGS.SKIN_NAMES.xxx3_huohuo,
        des = STRINGS.SKIN_DESCRIPTIONS.xxx3_huohuo,
        quotes = STRINGS.SKIN_QUOTES.xxx3_huohuo,
        build_name_override = 'xxx3_huohuo',
        type = 'base',
        rarity = 'Distinguished',
        rarity_modifier = 'CharacterModifier',
        skip_item_gen = true,
        skip_giftable_gen = true,
        assets = {
            Asset('ANIM', 'anim/xxx3_huohuo.zip'),
            Asset('ANIM', 'anim/ghost_xxx3_build.zip')
        }
    }
)

return MakePlayerCharacter('xxx3', prefabs, assets, common_postinit, master_postinit, prefabs)
