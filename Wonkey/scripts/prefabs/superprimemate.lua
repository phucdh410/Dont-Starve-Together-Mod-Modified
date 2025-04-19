local assets =
{
    Asset("ANIM", "anim/ds_pig_basic.zip"),
    Asset("ANIM", "anim/ds_pig_actions.zip"),
    Asset("ANIM", "anim/ds_pig_attacks.zip"),
    Asset("ANIM", "anim/ds_pig_elite.zip"),
    Asset("ANIM", "anim/ds_pig_boat_jump.zip"),
    Asset("ANIM", "anim/ds_pig_monkey.zip"),
    Asset("ANIM", "anim/monkeymen_build.zip"),

    --for water fx build overrides
    Asset("ANIM", "anim/slide_puff.zip"),
    Asset("ANIM", "anim/splash_water_rot.zip"),

    Asset("SOUND", "sound/monkey.fsb"),
}

local prefabs =
{
    "poop",
    "monkeyprojectile",
    "smallmeat",
    "cave_banana",
    "pirate_stash",
    "monkey_mediumhat",
    "stash_map",
    "cursed_monkey_token",
	"oar_monkey",
}

local brain = require "brains/superprimematebrain"

SetSharedLootTable('primemate',
{
    {'meat',     1.0},
    {'bananajuice',  1.0},
})


local MONKEY_TAGS = { "monkey" }
local function OnAttacked(inst, data)
    inst.components.combat:SetTarget(data.attacker)
    if inst.task ~= nil then
        inst.task:Cancel()
    end

    local x, y, z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, y, z, 30, MONKEY_TAGS)
    for i, v in ipairs(ents) do
        if v ~= inst and v.components.combat then
            v.components.combat:SuggestTarget(data.attacker)
            if v.task ~= nil then
                v.task:Cancel()
            end
        end
    end
end

local function OnWaterTarget(inst, data)
    if not data.target:IsOnValidGround() then
        inst.components.combat:SetRange(TUNING.MONKEY_MELEE_RANGE)
        inst.components.timer:StartTimer("divecooldown", CONFIG.diveatk_cooldown)
    end
end

local function Downgrade(inst)
    if not inst.components.follower.leader then
        local fx = SpawnPrefab("monkey_morphin_power_players_fx")
        fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
        local fx2 = SpawnPrefab("explode_reskin")
        fx2.Transform:SetPosition(inst.Transform:GetWorldPosition())

        local monkeydowngrade = SpawnPrefab("powder_monkey")
        monkeydowngrade.Transform:SetPosition(inst.Transform:GetWorldPosition())

        if CONFIG.follower_names then
            monkeydowngrade.components.named:SetName(inst.name)
        end

        local oar = SpawnPrefab("oar_monkey")
        oar.components.finiteuses:SetPercent(5/100)
        monkeydowngrade.components.inventory:GiveItem(oar)
        monkeydowngrade.components.inventory:Equip(oar)

        local hat = SpawnPrefab("monkey_mediumhat")
        hat.components.fueled:SetPercent(5/100)
        monkeydowngrade.components.inventory:GiveItem(hat)
        monkeydowngrade.components.inventory:Equip(hat)

        inst:Remove()

        return
    end

    local fx = SpawnPrefab("monkey_morphin_power_players_fx")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    local fx2 = SpawnPrefab("explode_reskin")
    fx2.Transform:SetPosition(inst.Transform:GetWorldPosition())

    local monkeydowngrade = SpawnPrefab("powder_monkey")
    monkeydowngrade.Transform:SetPosition(inst.Transform:GetWorldPosition())

    local leader = inst.components.follower.leader
    if CONFIG.follower_names then
        monkeydowngrade.components.named:SetName(inst.name)
    end
    monkeydowngrade.components.follower:SetLeader(leader)
    leader.components.leader:AddFollower(monkeydowngrade)
    monkeydowngrade:RemoveTag("hostile")
    monkeydowngrade.hasLeader = true
    monkeydowngrade.components.health:SetMaxHealth(TUNING.POWDER_MONKEY_HEALTH + 150)
    monkeydowngrade.components.locomotor.walkspeed = TUNING.MONKEY_MOVE_SPEED + 0.5
    monkeydowngrade.components.combat:SetDefaultDamage(TUNING.POWDER_MONKEY_DAMAGE + 10)

    local oar = SpawnPrefab("oar_monkey")
    oar.components.finiteuses:SetPercent(5/100)
    monkeydowngrade.components.inventory:GiveItem(oar)
    monkeydowngrade.components.inventory:Equip(oar)

    local hat = SpawnPrefab("monkey_mediumhat")
    hat.components.fueled:SetPercent(5/100)
    monkeydowngrade.components.inventory:GiveItem(hat)
    monkeydowngrade.components.inventory:Equip(hat)

    inst:Remove()
end

local function spearretargetfn(inst)
    local RETARGET_MUST_TAGS = { "_combat" }
    local RETARGET_CANT_TAGS = { "playerghost", "INLIMBO" }

    local leader = inst.components.follower:GetLeader()
    return leader ~= nil
        and FindEntity(
            leader,
            TUNING.SHADOWWAXWELL_TARGET_DIST,
            function(guy)
                return guy ~= inst
                    and (guy.components.combat:TargetIs(leader) or
                        guy.components.combat:TargetIs(inst))
                    and inst.components.combat:CanTarget(guy)
            end,
            RETARGET_MUST_TAGS,
            RETARGET_CANT_TAGS
        )
        or nil
end

local function retargetfn(inst)
    local leader = inst.components.follower:GetLeader()
    if leader ~= nil then
        return spearretargetfn(inst)
    else
        return nil
    end
end

local function shouldKeepTarget(inst, target)
    if inst.components.crewmember then
        return true
    else
        return inst.components.combat:CanTarget(target)
    end
end


local function OnSave(inst, data)
	local personal_item = {}
	for k, v in pairs(inst.components.inventory.itemslots) do
		if v.persists and v:HasTag("personal_possession") then
			personal_item[k] = v.prefab
		end
	end
	local personal_equip = {}
	for k, v in pairs(inst.components.inventory.equipslots) do
		if v.persists and v:HasTag("personal_possession") then
			personal_equip[k] = v.prefab
		end
	end
	data.personal_item = next(personal_item) ~= nil and personal_item or nil
	data.personal_equip = next(personal_equip) ~= nil and personal_equip or nil
end

local function OnLoad(inst, data)
    if data ~= nil then
		if data.personal_item ~= nil then
			for k, v in pairs(data.personal_item) do
				local item = inst.components.inventory:GetItemInSlot(k)
				if item ~= nil and item.prefab == v then
					item:AddTag("personal_possession")
				end
			end
		end
		if data.personal_equip ~= nil then
			for k, v in pairs(data.personal_equip) do
				local item = inst.components.inventory:GetEquippedItem(k)
				if item ~= nil and item.prefab == v then
					item:AddTag("personal_possession")
				end
			end
		end
	end
end

local function OnEquip(inst)
    local hand = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    local head = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
    if hand and hand.prefab == "oar_monkey" then
        hand:AddTag("personal_possession")
        hand:AddTag("nosteal")
        hand:RemoveComponent("finiteuses")
        hand:ListenForEvent("ondropped", function(inst)
            inst:Remove()
        end)
    end
    if head and head.prefab == "monkey_mediumhat" then
        head:AddTag("personal_possession")
        head:AddTag("nosteal")
        head:RemoveComponent("fueled")
        head:ListenForEvent("ondropped", function(inst)
            inst:Remove()
        end)
    end
end

local function OnAbandonShip(inst)
    inst:DoTaskInTime((math.random()*1.5)+0.3, function() inst.abandon = true end)
end

local function speech_override_fn(inst, speech)
    if not ThePlayer or ThePlayer:HasTag("monkey") then
        return speech
    else
        return CraftMonkeySpeech()
    end 
end

local function battlecry(combatcmp, target)
    local strtbl = nil
    
    if target ~= nil then
        if target:HasTag("monkey") ~= nil then
            strtbl = "MONKEY_MONKEY_BATTLECRY"
        elseif target.components.inventory ~= nil and target.components.inventory:NumItems() > 0 then
            strtbl = "MONKEY_STUFF_BATTLECRY"
        else
            strtbl = "MONKEY_BATTLECRY"
        end

        return strtbl, math.random(#STRINGS[strtbl])
    end
end

local function onmonkeychange(inst, data)
    if data and data.player then
        if inst.components.combat and inst.components.combat.target and inst.components.combat.target == data.player then
            inst.components.combat:DropTarget()
        end
    end
end

local function ontalk(inst, script)
    inst.SoundEmitter:PlaySound("monkeyisland/primemate/taunt")
end

local function IsAbleToAccept(inst, item, giver)
    if inst.components.health ~= nil and inst.components.health:IsDead() then
        return false, "DEAD"
    end
    return true
end

local function ShouldAcceptItem(inst, item, giver)
    if inst.components.sleeper and inst.components.sleeper:IsAsleep() then
        inst.components.sleeper:WakeUp()
    end

    return (inst.components.follower.leader and giver:HasTag("monkey")
    and (item.prefab == "cave_banana" or item.prefab == "cave_banana_cooked"
    or item.prefab == "spoiled_food"))
end

local function OnGetItemFromPlayer(inst, giver, item)
    if not (inst.components.follower == nil or inst.components.follower.leader) then
        return nil
    end

    if item.prefab == "cave_banana" or item.prefab == "cave_banana_cooked" then
        inst:PushEvent("eat")
        inst.components.health:DoDelta(200)
        if inst.components.timer:TimerExists("supermonkey") then
            local timeleft = inst.components.timer:GetTimeLeft("supermonkey")
            inst.components.timer:SetTimeLeft("supermonkey", timeleft+300)
        end
        item:Remove()
    end


    if item.prefab == "spoiled_food" then
        inst:PushEvent("eat")
        item:Remove()
        return inst:DoTaskInTime(1, Downgrade)
    end
end

local function OnTimerDone(inst, data)
    if data.name == "facetime" then
        inst.components.timer:StartTimer("dontfacetime", 10)
    end
    if data.name == "divecooldown" then
        if inst.components.combat.target and not inst.components.combat.target:IsOnValidGround() then
            inst.components.timer:StartTimer("divecooldown", CONFIG.diveatk_cooldown)
        else
            inst.components.combat:SetRange(TUNING.MONKEY_MELEE_RANGE+3)
        end
    end

    if data.name == "supermonkey" then
        return Downgrade(inst)
    end
end

local function OnWashedAshore(inst)
    local oar = SpawnPrefab("oar_monkey")
    inst.components.inventory:GiveItem(oar)
    inst.components.inventory:Equip(oar)

    local hat = SpawnPrefab("monkey_mediumhat")
    inst.components.inventory:GiveItem(hat)
    inst.components.inventory:Equip(hat)
end

local function DiveAttack(inst)
	local x, y, z = inst.Transform:GetWorldPosition()

	local fx = SpawnPrefab("explode_small")
    fx.Transform:SetPosition(x, y, z)
    fx.Transform:SetScale(2,2,2)

    local fx2 = SpawnPrefab("collapse_small")
    fx2.Transform:SetPosition(x, y, z)
    fx2.Transform:SetScale(1.4,1.4,1.4)

    local fxdust = SpawnPrefab("winona_catapult_projectile")
    fxdust.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fxdust.AnimState:PlayAnimation("impact3_special")
    fxdust.hideanim:set(true)
    fxdust:ListenForEvent("animover", fxdust.Remove)

    local scorch = SpawnPrefab("deerclops_laserscorch")
    scorch.Transform:SetPosition(x, y, z)
    scorch.Transform:SetScale(1.3,1.3,1.3)

    for i, v in ipairs(AllPlayers) do
        local distSq = v:GetDistanceSqToInst(inst)
        local k = math.max(0, math.min(1, distSq / 400))
        local intensity = k * 0.75 * (k - 2) + 0.75 --easing.outQuad(k, 1, -1, 1)
        if intensity > 0 then
            v:ScreenFlash(intensity)
            v:ShakeCamera(CAMERASHAKE.FULL, .7, .02, intensity / 2)
        end
    end

    local AREAATTACK_EXCLUDE_TAGS = { "INLIMBO", "wall", "monkey", "notarget", "noattack", "structure", "playerghost", "player", "companion" }
    inst.components.combat:DoAreaAttack(inst, 6, nil, nil, nil, AREAATTACK_EXCLUDE_TAGS)

    inst.components.combat:SetRange(TUNING.MONKEY_MELEE_RANGE)
    inst.components.timer:StartTimer("divecooldown", CONFIG.diveatk_cooldown)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.DynamicShadow:SetSize(2, 1.25)

    inst.Transform:SetFourFaced()

    MakeCharacterPhysics(inst, 10, 0.25)

    inst.AnimState:SetBank("pigman")
    inst.AnimState:SetBuild("monkeymen_build")
    inst.AnimState:PlayAnimation("idle_loop", true)
    inst.Transform:SetScale(1.4,1.4,1.4)

    inst.AnimState:Hide("ARM_carry_up")

    inst.AnimState:OverrideSymbol("fx_slidepuff01", "slide_puff", "fx_slidepuff01")
    inst.AnimState:OverrideSymbol("splash_water_rot", "splash_water_rot", "splash_water_rot")
    inst.AnimState:OverrideSymbol("fx_water_spot", "splash_water_rot", "fx_water_spot")
    inst.AnimState:OverrideSymbol("fx_splash_wide", "splash_water_rot", "fx_splash_wide")
    inst.AnimState:OverrideSymbol("fx_water_spray", "splash_water_rot", "fx_water_spray")

    inst:AddTag("character")
    inst:AddTag("monkey")
    inst:AddTag("supermonkey")
	inst:AddTag("scarytoprey")
    inst:AddTag("pirate")
    inst:AddTag("stronggrip")

    inst:AddComponent("talker")
    inst.components.talker.fontsize = 35
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.offset = Vector3(0, -400, 0)
    inst.components.talker:MakeChatter()
    inst.components.talker.ontalk = ontalk    

    inst.speech_override_fn = speech_override_fn

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.soundtype = ""

    MakeMediumBurnableCharacter(inst,"pig_torso")
    inst.components.burnable:SetBurnTime(TUNING.PLAYER_BURN_TIME)

    MakeMediumFreezableCharacter(inst)
    inst.components.freezable:SetResistance(4)
    inst.components.freezable.wearofftime = 5

    inst.DiveAttack = DiveAttack

    inst:AddComponent("bloomer")

    inst:AddComponent("inventory")

    inst:AddComponent("inspectable")

    inst:AddComponent("thief")

    if CONFIG.follower_names then
        inst:AddComponent("named")
    end

    inst:AddComponent("locomotor")
    inst.components.locomotor:SetSlowMultiplier( 1 )
    inst.components.locomotor:SetTriggersCreep(false)
    inst.components.locomotor.pathcaps = { ignorecreep = false }
    inst.components.locomotor.walkspeed = TUNING.MONKEY_MOVE_SPEED/2
    inst.components.locomotor.runspeed = TUNING.MERM_GUARD_RUN_SPEED
    inst.components.locomotor:SetAllowPlatformHopping(true)

    inst:AddComponent("embarker")
    inst.components.embarker.embark_speed = inst.components.locomotor.runspeed

    inst:AddComponent("drownable")
    inst.components.drownable:ShouldDropItems(false)

    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(94)
    inst.components.combat.damagemultiplier = 1 + CONFIG.supermonkey_dmg/100
    inst.components.combat:SetAttackPeriod(TUNING.MONKEY_ATTACK_PERIOD-0.5)
    inst.components.combat:SetRange(TUNING.MONKEY_MELEE_RANGE+3)
    if not CONFIG.diveatk_toggle then
        inst.components.combat:SetRange(TUNING.MONKEY_MELEE_RANGE)
    end
    inst.components.combat:SetRetargetFunction(1, retargetfn)
    inst.components.combat.GetBattleCryString = battlecry
    inst.components.combat:SetKeepTargetFunction(shouldKeepTarget)

    inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(ShouldAcceptItem)
    inst.components.trader:SetAbleToAcceptTest(IsAbleToAccept)
    inst.components.trader.onaccept = OnGetItemFromPlayer
	inst.components.trader.deleteitemonaccept = false

    inst:AddComponent("follower")
    inst.components.follower:KeepLeaderOnAttacked()
    inst.components.follower.keepdeadleader = true
    inst.components.follower.keepleaderduringminigame = true

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(CONFIG.supermonkey_hp)
    inst.components.health:StartRegen(10, TUNING.BEEFALO_HEALTH_REGEN_PERIOD)
    inst.components.health:SetAbsorptionAmount(0.5)

    inst:AddComponent("timer")

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable("primemate")

    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.VEGGIE }, { FOODTYPE.VEGGIE })

    inst:AddComponent("sleeper")
    inst.components.sleeper.sleeptestfn = onmonkeychange
    inst.components.sleeper.waketestfn = DefaultWakeTest
    
    inst:AddComponent("areaaware")

    inst:SetBrain(brain)
    inst:SetStateGraph("SGsuperprimemate")

    inst:AddComponent("knownlocations")

    inst:ListenForEvent("timerdone", OnTimerDone)
    inst:ListenForEvent("attacked", OnAttacked)
    inst:ListenForEvent("newcombattarget", OnWaterTarget)
    inst:ListenForEvent("abandon_ship", OnAbandonShip)
    inst:ListenForEvent("equip", OnEquip)
    inst:ListenForEvent("on_washed_ashore", OnWashedAshore)

    MakeHauntablePanic(inst)

	inst.OnSave = OnSave
	inst.OnLoad = OnLoad

    return inst
end

return Prefab("superprimemate", fn, assets, prefabs)
