local MakePlayerCharacter = require ("prefabs/player_common")

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
    Asset("ANIM", "anim/player_idles_wonkey.zip"),
    Asset("SOUND", "sound/webber.fsb"),
}

TUNING.WONKEY2_HUNGER = CONFIG.wonkey_hunger
TUNING.WONKEY2_SANITY = CONFIG.wonkey_sanity
TUNING.WONKEY2_HEALTH = CONFIG.wonkey_health

TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.WONKEY2 = {
    "cursed_monkey_token",
    "cursed_monkey_token",
    "cursed_monkey_token",
    "cursed_monkey_token",
    "cursed_monkey_token",
    "cursed_monkey_token",
    "cursed_monkey_token",
    "cursed_monkey_token",
    "cursed_monkey_token",
    "cursed_monkey_token",
    "palmcone_seed",
    "palmcone_seed",
    "palmcone_seed",
    "monkey_smallhat",
    "cutless",
}

if CONFIG.wonkey_notrinkets == false then
    TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.WONKEY2 = {
        "palmcone_seed",
        "palmcone_seed",
        "palmcone_seed",
        "monkey_smallhat",
        "cutless",
    }
end

local start_inv = {}
for k, v in pairs(TUNING.GAMEMODE_STARTING_ITEMS) do
    start_inv[string.lower(k)] = v.WONKEY2
end
local prefabs = FlattenTree(start_inv, true)


--Change sanity based on the amount of trinkets------------------------------------------
local function IsToken(item)
    return item.prefab == "cursed_monkey_token"
end

local function GetTokens(inst)
    local tokens = inst.components.inventory:FindItems(IsToken)
    local count = 0
    for i, v in ipairs(tokens) do
        count = count + GetStackSize(v)
        if count >= 10 then
            count = 10
        end
    end
    return count
end

local function CalcPenalty(inst)
    local count = GetTokens(inst)
    local missingtokens = 0
    if count <= 6 then missingtokens = (10 - count)*0.05 + 0.2
    elseif count <= 8 then missingtokens = (10 - count)*0.1 + 0.05
    elseif count == 9 then missingtokens = 0.15
    elseif count >= 10 then missingtokens = 0
    end
    return missingtokens
end

local function AddPenalty(inst)
    local penalty = CalcPenalty(inst)
    inst.components.sanity:AddSanityPenalty("tokenpenalty", penalty)
end


--Sanity gain when near pirate banner----------------------------------------------------
local function sanityFn(inst)
    local delta = 0
    local x, y, z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, y, z, TUNING.SANITY_EFFECT_RANGE, "pirate_flag_pole")
    for i, v in ipairs(ents) do
        if v and v.prefab == "pirate_flag_pole" then
            local distsq = inst:GetDistanceSqToInst(v)
            delta = TUNING.SANITYAURA_TINY / math.max(1, distsq)
        end
    end
    return delta
end


--Monkeys help if you're attacked--------------------------------------------------------
local function RedirectMonkeyTargets(inst, data)
    local x, y, z = inst.Transform:GetWorldPosition()
    local entities = TheSim:FindEntities(x, y, z, 20, {"monkey"}, {"shadow"})

    for _, entity in pairs(entities) do
        if entity and entity.components and entity.components.combat and data and data.attacker and not data.attacker:HasTag("monkey") then
            entity.components.combat:SetTarget(data.attacker)
        end
    end
end


--Pirate hat buffs-----------------------------------------------------------------------
local function OnEquipMonkeyHat(inst)
    local head = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
    if head and head:HasTag("monkeybandana") then
        if CONFIG.bandana_sanity then
            inst.components.sanity.dapperness = 0.1
        end

    elseif head and head:HasTag("captainhat") then
        if CONFIG.tricorn_dmg then
            inst.components.combat.damagemultiplier = 1.25
        end
        inst.components.locomotor.runspeed = TUNING.WILSON_RUN_SPEED - TUNING.WONKEY_WALK_SPEED_PENALTY

    elseif head and head:HasTag("pollyshat") then
        if CONFIG.pollys_masterhat then
            inst.components.sanity.dapperness = TUNING.DAPPERNESS_LARGE
            inst.components.combat.damagemultiplier = 1.25
            inst:AddTag("master_crewman")
            inst:AddTag("boat_health_buffer")
        end
    else
        inst.components.sanity.dapperness = 0
        inst.components.combat.damagemultiplier = 1
        inst.components.locomotor.runspeed = TUNING.WILSON_RUN_SPEED + TUNING.WONKEY_WALK_SPEED_PENALTY
        if inst:HasTag("master_crewman") then
            inst:RemoveTag("master_crewman")
        end
        if inst:HasTag("boat_health_buffer") then
            inst:RemoveTag("boat_health_buffer")
        end
    end
end


--Make monkeys unfollow------------------------------------------------------------------
local function oneatfn(inst, food)
    if food ~= nil and food.prefab == "cave_banana_cooked" then
        if inst.components.leader and not inst.components.health:IsDead() then
            for follower, _ in pairs(inst.components.leader.followers) do
                follower:PushEvent("losemonkeys")
                if follower:HasTag("powdermonkey") then
                    follower.components.follower:StopFollowing()
                end
            end
        end
    end
end


--Keep followers into caves and keep buffs-----------------------------------------------
local function OnDespawn(inst)
    for k, v in pairs(inst.components.leader.followers) do
        if k:HasTag("supermonkey") and (k.components.inventoryitem == nil or not (k.components.inventoryitem:GetGrandOwner() == inst)) then
            local savedata = k:GetSaveRecord()
            table.insert(inst.wonkey_followers, savedata)
            k:AddTag("notarget")
            k:AddTag("NOCLICK")
            k.persists = false
            if k.components.health then
                k.components.health:SetInvincible(true)
            end
            k:DoTaskInTime(math.random()*0.2, function(k)
                local fx = SpawnPrefab("spawn_fx_small")
                fx.Transform:SetPosition(k.Transform:GetWorldPosition())
                if not k.components.colourtweener then
                    k:AddComponent("colourtweener")
                end
                k.components.colourtweener:StartTween({ 0, 0, 0, 1 }, 13 * FRAMES, k.Remove)
            end)
        end
    end
end

local function OnSave(inst, data)
    data.wonkey_followers = inst.wonkey_followers
end

local function OnLoad(inst, data)
    if data and data.wonkey_followers then
        for k, v in pairs(data.wonkey_followers) do
            inst:DoTaskInTime(0.2*math.random(), function(inst)
                local monkey = SpawnSaveRecord(v)
                inst.components.leader:AddFollower(monkey)
                monkey:DoTaskInTime(0, function(monkey)
                    local x, y, z = inst.Transform:GetWorldPosition()
                    if inst:IsValid() and not monkey:IsNear(inst, 10) then
                        monkey.Transform:SetPosition(x+math.random(-5, 5), y, z+math.random(-5, 5))
                        monkey.sg:GoToState("idle")
                    end
                end)
                local fx = SpawnPrefab("spawn_fx_medium")
                fx.Transform:SetPosition(monkey.Transform:GetWorldPosition())
            end)
        end
    end

    inst:DoTaskInTime(1, function(inst)
        for k, v in pairs(inst.components.leader.followers) do
            if k:HasTag("powdermonkey") then
                k:RemoveTag("hostile")
                k.hasLeader = true
                k.components.health:SetMaxHealth(TUNING.POWDER_MONKEY_HEALTH + 200)
                k.components.locomotor.walkspeed = TUNING.MONKEY_MOVE_SPEED + 0.5
                k.components.combat:SetDefaultDamage(TUNING.POWDER_MONKEY_DAMAGE + 10)
            end
        end
    end)
end


--Keep trinkets on drown and death-------------------------------------------------------
local function OnGetItem(inst, data)
    local item = data ~= nil and data.item or nil
    if item ~= nil and item.prefab == "cursed_monkey_token" then
        item.components.inventoryitem.keepondrown = true
    end
end

local function OnDeath(inst)
    local tokens = inst.components.inventory:FindItems(IsToken)
    for i, v in ipairs(tokens) do
        if CONFIG.wonkey_keep_trinkets then
            v:RemoveComponent("curseditem")
            v.components.inventoryitem.keepondeath = true
        end
    end
end

local function OnRevive(inst)
    local tokens = inst.components.inventory:FindItems(IsToken)
    for i, v in ipairs(tokens) do
        v:AddComponent("curseditem")
        v.components.inventoryitem.keepondeath = false
    end
end


local function CLIENT_Wonkey_HostileTest(inst, target)
	if target.HostileToPlayerTest ~= nil then
		return target:HostileToPlayerTest(inst)
	end
    return target:HasTag("hostile") and not target:HasTag("monkey")
end

local common_postinit = function(inst) 
	inst.MiniMapEntity:SetIcon("wonkey2.tex")
    inst:AddTag("monkey")
    inst:AddTag("pirate")
    inst:AddTag("monkeypirate")

    inst.HostileTest = CLIENT_Wonkey_HostileTest
end

local master_postinit = function(inst)
    inst.starting_inventory = start_inv[TheNet:GetServerGameMode()] or start_inv.default

	inst.soundsname = "wonkey"

    inst.customidleanim = "idle_wonkey"
    inst.talker_path_override = "monkeyisland/characters/"

    inst.components.foodaffinity:AddPrefabAffinity("bananajuice", TUNING.AFFINITY_15_CALORIES_SMALL)
    inst.components.locomotor.runspeed = TUNING.WILSON_RUN_SPEED + TUNING.WONKEY_WALK_SPEED_PENALTY
	inst.components.hunger:SetMax(TUNING.WONKEY2_HUNGER)
	inst.components.sanity:SetMax(TUNING.WONKEY2_SANITY)
    inst.components.health:SetMaxHealth(TUNING.WONKEY2_HEALTH)

    inst:AddComponent("expertsailor")
    inst.components.expertsailor:SetRowForceMultiplier(TUNING.MIGHTY_ROWER_MULT)
    inst.components.expertsailor:SetRowExtraMaxVelocity(TUNING.MIGHTY_ROWER_EXTRA_MAX_VELOCITY)
    inst.components.expertsailor:SetAnchorRaisingSpeed(TUNING.MIGHTY_ANCHOR_SPEED)
    inst.components.expertsailor:SetLowerSailStrength(TUNING.MIGHTY_SAIL_BOOST_STRENGTH)


    inst.components.eater:SetOnEatFn(oneatfn)

    if CONFIG.banner_sanity == "Wonkey" or "Universal" then
        inst.components.sanity.custom_rate_fn = sanityFn
    end

    inst.components.builder.seafaring_bonus = 5

    inst.components.builder:UnlockRecipe("seafaring_prototyper")

    inst:ListenForEvent("attacked", RedirectMonkeyTargets)
    inst:ListenForEvent("equip", function(inst, data)
        OnEquipMonkeyHat(inst, data.owner)
    end)

    inst:ListenForEvent("unequip", function(inst, data)
        OnEquipMonkeyHat(inst, data.owner)
    end)

    if CONFIG.wonkey_notrinkets then
        inst:DoPeriodicTask(0, AddPenalty)
    end

    inst:ListenForEvent("itemget", OnGetItem)
    inst:ListenForEvent("death", OnDeath)
    inst:ListenForEvent("respawnfromghost", OnRevive)
    inst:ListenForEvent("respawnfromcorpse", OnRevive)

    inst.wonkey_followers = {}

    inst.OnDespawn = OnDespawn
    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

end

return MakePlayerCharacter("wonkey2", prefabs, assets, common_postinit, master_postinit, prefabs)