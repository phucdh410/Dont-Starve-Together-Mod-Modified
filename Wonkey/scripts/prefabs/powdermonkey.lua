local assets =
{
    Asset("ANIM", "anim/monkey_small.zip"),

    --for water fx build overrides
    Asset("ANIM", "anim/slide_puff.zip"),
    Asset("ANIM", "anim/splash_water_rot.zip"),

    Asset("SOUND", "sound/monkey.fsb"),

    Asset("ANIM", "anim/ds_pig_basic.zip"),
    Asset("ANIM", "anim/ds_pig_actions.zip"),
    Asset("ANIM", "anim/ds_pig_attacks.zip"),
    Asset("ANIM", "anim/ds_pig_elite.zip"),
    Asset("ANIM", "anim/ds_pig_boat_jump.zip"),
    Asset("ANIM", "anim/ds_pig_monkey.zip"),
    Asset("ANIM", "anim/monkeymen_build.zip"),
}

local prefabs =
{
    "poop",
    "monkeyprojectile",
    "smallmeat",
    "cave_banana",
    "cutless",
    "cursed_monkey_token",
    "oar_monkey",
    "monkey_smallhat",
}

local brain = require "brains/powdermonkeybrain"

SetSharedLootTable('powdermonkey',
{
    {'smallmeat',     1.0},
})

local function IsPoop(item)
    return item.prefab == "poop"
end

local function oneat(inst)
    --Monkey ate some food. Give him some poop!
    if inst.components.inventory ~= nil then
        local maxpoop = 3
        local poopstack = inst.components.inventory:FindItem(IsPoop)
        if poopstack == nil or poopstack.components.stackable.stacksize < maxpoop then
            inst.components.inventory:GiveItem(SpawnPrefab("poop"))
        end
    end
end

local function ForgetTarget(inst)
    inst.components.combat:SetTarget(nil)
end

local MONKEY_TAGS = { "monkey" }
local function OnAttacked(inst, data)
    inst.components.combat:SetTarget(data.attacker)
    if inst.task ~= nil then
        inst.task:Cancel()
    end
    inst.task = inst:DoTaskInTime(math.random(55, 65), ForgetTarget) --Forget about target after a minute

    local x, y, z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, y, z, 30, MONKEY_TAGS)
    for i, v in ipairs(ents) do
        if v ~= inst and v.components.combat then
            v.components.combat:SuggestTarget(data.attacker)
            if v.task ~= nil then
                v.task:Cancel()
            end
            v.task = v:DoTaskInTime(math.random(55, 65), ForgetTarget) --Forget about target after a minute
        end
    end
end

local function retargetnormal(inst)
    if true then
        return nil
    end
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
        return retargetnormal(inst)
    end
end

local function shouldKeepTarget(inst, target)
    if inst.components.crewmember then
        return true
    else
        return inst.components.combat:CanTarget(target)
    end
end

local function OnPickup(inst, data)
	local item = data ~= nil and data.item or nil
    if item ~= nil and
        item.components.equippable ~= nil and
        item.components.equippable.equipslot == EQUIPSLOTS.HEAD and
        not inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD) then
        --Ugly special case for how the PICKUP action works.
        --Need to wait until PICKUP has called "GiveItem" before equipping item.
        inst:DoTaskInTime(0, function()
            if item:IsValid() and
                item.components.inventoryitem ~= nil and
                item.components.inventoryitem.owner == inst then
                inst.components.inventory:Equip(item)
            end
        end)
    end
end

local function OnDropItem(inst, data)
	if data ~= nil and data.item ~= nil then
		data.item:RemoveTag("personal_possession")
	end
end

local function CrewMonkey(inst)
    if inst.components.health:IsDead() then
        return
    end

    if inst and inst.components.follower.leader then
        inst:RemoveTag("hostile")
        inst.hasLeader = true
        inst.components.health:SetMaxHealth(CONFIG.powdermonkey_hp)
        inst.components.locomotor.walkspeed = TUNING.MONKEY_MOVE_SPEED + 0.5
        inst.components.combat:SetDefaultDamage(CONFIG.powdermonkey_dmg)
    end
end

local function OnSave(inst, data)
data.hasLeader = inst.hasLeader
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
	inst:DoTaskInTime(1, CrewMonkey)
end

local function ClearTinkerTarget(inst)
    if inst.tinkertarget then
        local bc = inst.components.crewmember and 
                   inst.components.crewmember.boat and 
                   inst.components.crewmember.boat.components.boatcrew or nil 
        if bc then
            bc:removeinkertarget(inst.tinkertarget)
        end
        inst.tinkertarget = nil
    end
end

local function OnDeath(inst, data)
    if inst.hasLeader then
        -- The instance has a leader, don't drop token
    else
        local item = SpawnPrefab("cursed_monkey_token")
        inst.components.inventory:DropItem(item, nil, true)
    end
end

local function OnGotItem(inst,data)
    if data.item and (data.item.prefab == "cave_banana" or data.item.prefab == "cave_banana_cooked") then
        inst:PushEvent("victory",{item = data.item, say = STRINGS["MONKEY_BATTLECRY_VICTORY"][math.random(1,#STRINGS["MONKEY_BATTLECRY_VICTORY"])]})
    end
end

local function OnAbandonShip(inst)
    inst:DoTaskInTime((math.random()*1.5)+0.3 , function() inst.abandon = true end)
end

local function speech_override_fn(inst, speech)
    if not ThePlayer or ThePlayer:HasTag("monkey") then
        return speech
    else
        return CraftMonkeySpeech()
    end 
end

--[[ local function giveupstring()
    return "RABBIT_GIVEUP", math.random(#STRINGS["RABBIT_GIVEUP"])
end ]]


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

local function modifiedsleeptest(inst)
    if inst.components.crewmember then
        return nil
    end
    if inst.components.follower == nil or inst.components.follower.leader then
        return nil
    end   
    return DefaultSleepTest(inst)
end

local function ontalk(inst, script)
    inst.SoundEmitter:PlaySound("monkeyisland/powdermonkey/speak")
end

local function IsAbleToAccept(inst, item, giver)
    if inst.components.health ~= nil and inst.components.health:IsDead() then
        return false, "DEAD"
    elseif inst.sg ~= nil and inst.sg:HasStateTag("busy") then
        if inst.sg:HasStateTag("sleeping") then
            return true
        end
        return false, "BUSY"
    end
    return true
end

local function ShouldAcceptItem(inst, item, giver)
    if inst.components.sleeper and inst.components.sleeper:IsAsleep() then
        inst.components.sleeper:WakeUp()
    end

    return (giver:HasTag("monkey") and (item.prefab == "cave_banana" or item.prefab == "cave_banana_cooked")) or
        (giver:HasTag("monkey") and inst.components.follower.leader and item.components.equippable ~= nil and (item.components.equippable.equipslot == EQUIPSLOTS.HEAD or item.components.equippable.equipslot == EQUIPSLOTS.HANDS))
end

local MONKEY_TAGS = { "powdermonkey" }
local MONKEY_IGNORE_TAGS = { "FX", "NOCLICK", "DECOR", "INLIMBO", "player" }
local function GetOtherMonkeys(inst, radius)
    local valid_monkeys = {}
    local x, y, z = inst.Transform:GetWorldPosition()
    local monkeys = TheSim:FindEntities(x, y, z, radius, nil, MONKEY_IGNORE_TAGS, MONKEY_TAGS)
    for _, monkey in ipairs(monkeys) do
        if monkey ~= inst and monkey:IsValid() and monkey.components.health and not monkey.components.health:IsDead() then
            table.insert(valid_monkeys, monkey)
        end
    end
    return valid_monkeys
end

local function OnGetItemFromPlayer(inst, giver, item)
    if item.prefab == "cave_banana" or item.prefab == "cave_banana_cooked" then
        inst:PushEvent("victory", { item = item.prefab, say = "AYE AYE CAPTAIN!" })
        giver:PushEvent("makefriend")
        giver.components.leader:AddFollower(inst)
        inst.components.follower:SetLeader(giver)
        if CONFIG.powdermonkey_time == 31 then
            --follow forever
        else
            inst.components.follower:AddLoyaltyTime(CONFIG.powdermonkey_time*60)
	    end
        inst.hasLeader = true
        if inst and inst:HasTag("hostile") then
            inst:RemoveTag("hostile")
        end
        inst.components.health:SetMaxHealth(CONFIG.powdermonkey_hp)
        inst.components.locomotor.walkspeed = TUNING.MONKEY_MOVE_SPEED + 0.5
        inst.components.combat:SetDefaultDamage(CONFIG.powdermonkey_dmg)
    end

    local hiremoremonkeys = false
    if inst.components.combat:TargetIs(giver) then
        inst.components.combat:SetTarget(nil)
    elseif giver.components.leader ~= nil and inst.components.follower ~= nil then
        hiremoremonkeys = true
    end

    if hiremoremonkeys and (item.prefab == "cave_banana" or item.prefab == "cave_banana_cooked") then
        local othermonkeys = GetOtherMonkeys(inst, 15)
        if othermonkeys == nil then

        else
            local maxmonkeys = 10
            for i, v in ipairs(othermonkeys) do
                if v ~= inst and v.components.follower.leader == nil then
                    if maxmonkeys <= 0 then
                        break
                    end
                    local effectdone = true
                    if v.components.combat.target == giver then
                        v.components.combat:SetTarget(nil)
                    elseif giver.components.leader ~= nil and v.components.follower ~= nil then
                        inst:PushEvent("victory", { item = item.prefab, say = STRINGS["MONKEY_COMMAND"][math.random(1,#STRINGS["MONKEY_COMMAND"])] })
                        v.components.locomotor:Stop()
                        v:DoTaskInTime(2, function()
                            giver.components.leader:AddFollower(v)
                            v.components.follower:SetLeader(giver)
                            if CONFIG.powdermonkey_time == 31 then
                                --follow forever
                            else
                                v.components.follower:AddLoyaltyTime(CONFIG.powdermonkey_time*60)
                            end
                            v.hasLeader = true
                            v:PushEvent("cheer", { item = item.prefab, say = "AYE AYE!" })
                            inst.components.talker:Say("")
                            v.components.health:SetMaxHealth(CONFIG.powdermonkey_hp)
                            v.components.locomotor.walkspeed = TUNING.MONKEY_MOVE_SPEED + 0.5
                            v.components.combat:SetDefaultDamage(CONFIG.powdermonkey_dmg)
                        end)
                    else
                        effectdone = false
                    end

                    if effectdone then
                        if v.components.sleeper and v.components.sleeper:IsAsleep() then
                            v.components.sleeper:WakeUp()
                        end
                    end
                    maxmonkeys = maxmonkeys - 1
                end
            end
        end
    end

    -- Equip hats
    if item.components.equippable ~= nil and item.components.equippable.equipslot == EQUIPSLOTS.HEAD then
        local current = inst.components.inventory:GetEquippedItem(item.components.equippable.equipslot)
        if current ~= nil then
            inst.components.inventory:DropItem(current)
        end
        inst.components.inventory:Equip(item)
        inst.AnimState:Show("hat")
    end

    -- Equip weapons
    if item.components.equippable ~= nil and item.components.equippable.equipslot == EQUIPSLOTS.HANDS then
	        local current = inst.components.inventory:GetEquippedItem(item.components.equippable.equipslot)
        if current ~= nil then
            inst.components.inventory:DropItem(current)
        end
        inst.components.inventory:Equip(item)
    end
end

local function OnTimerDone(inst, data)
    if data.name == "facetime" then
        inst.components.timer:StartTimer("dontfacetime", 10)
    end
end

local function Tricornbuff(inst)
    if inst and inst.components.follower.leader then
        local leader = inst.components.follower.leader
        if leader:HasTag("boat_health_buffer") then
            if CONFIG.tricorn_monkeydmg then
                inst.components.combat.damagemultiplier = 1.25
                inst.components.health:SetAbsorptionAmount(0.3)
            end
        else
            inst.components.combat.damagemultiplier = 1
            inst.components.health:SetAbsorptionAmount(0)
        end
    else
        inst.components.combat.damagemultiplier = 1
        inst.components.health:SetAbsorptionAmount(0)
    end
end

local function unfollowedfn(inst)
    inst.components.talker:Say(STRINGS["MONKEY_BATTLECRY_TIME_UP"][math.random(1,#STRINGS["MONKEY_BATTLECRY_TIME_UP"])])
    inst.components.health:SetMaxHealth(TUNING.POWDER_MONKEY_HEALTH)
    inst.components.locomotor.walkspeed = TUNING.MONKEY_MOVE_SPEED
    inst.components.combat:SetDefaultDamage(TUNING.POWDER_MONKEY_DAMAGE)
    inst.hasLeader = false
end

local function OnMarkForTeleport(inst, data)
    if data and data.leader then
        -- Lost loyalty with a leader, mark home for magic poofing during off-screen "traveling" when going to entitysleep.
        inst.wantstoteleport = true
    end
end

local function OnUnmarkForTeleport(inst, data)
    if data and data.leader then
        -- Gain loyalty with a leader, remove mark home for magic poofing during off-screen "traveling" when going to entitysleep.
        inst.wantstoteleport = nil
    end
end

local function OnHit(inst)
    inst.AnimState:ClearOverrideSymbol("swap_object")
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

    inst.AnimState:SetBank("monkey_small")
    inst.AnimState:SetBuild("monkey_small")
    inst.AnimState:PlayAnimation("idle", true)

    inst.AnimState:OverrideSymbol("fx_slidepuff01", "slide_puff", "fx_slidepuff01")
    inst.AnimState:OverrideSymbol("splash_water_rot", "splash_water_rot", "splash_water_rot")
    inst.AnimState:OverrideSymbol("fx_water_spot", "splash_water_rot", "fx_water_spot")
    inst.AnimState:OverrideSymbol("fx_splash_wide", "splash_water_rot", "fx_splash_wide")
    inst.AnimState:OverrideSymbol("fx_water_spray", "splash_water_rot", "fx_water_spray")

    inst.AnimState:Hide("ARM_carry")
    inst.scrapbook_hide = {"ARM_carry"}
    inst.scrapbook_specialinfo = "POWDERMONKEY"

    inst:AddTag("character")
    inst:AddTag("monkey")
    inst:AddTag("hostile")
	inst:AddTag("scarytoprey")
    inst:AddTag("pirate")
	inst:AddTag("powdermonkey")

    inst:AddComponent("talker")
    inst.components.talker.fontsize = 35
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.offset = Vector3(0, -400, 0)
    inst.components.talker:MakeChatter()
    inst.components.talker.ontalk = ontalk

    inst.speech_override_fn = speech_override_fn

    inst.scrapbook_removedeps = {"oar_monkey"}

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.soundtype = ""

    MakeMediumBurnableCharacter(inst,"m_skirt")
    MakeMediumFreezableCharacter(inst)

    inst:AddComponent("bloomer")

    inst:AddComponent("inventory")
    inst.components.inventory.maxslots = 20

    inst:AddComponent("inspectable")

    inst:AddComponent("thief")

    inst:AddComponent("locomotor")
    inst.components.locomotor:SetSlowMultiplier( 1 )
    inst.components.locomotor:SetTriggersCreep(false)
    inst.components.locomotor.pathcaps = { ignorecreep = false }
    inst.components.locomotor.walkspeed = TUNING.MONKEY_MOVE_SPEED

    inst:AddComponent("combat")
    inst.components.combat:SetAttackPeriod(TUNING.MONKEY_ATTACK_PERIOD)
    inst.components.combat:SetDefaultDamage(TUNING.POWDER_MONKEY_DAMAGE)
    inst.components.combat:SetRange(TUNING.MONKEY_MELEE_RANGE)
    inst.components.combat:SetRetargetFunction(1, retargetfn)
    --inst.components.combat:SetOnHit(function() inst:ClearBufferedAction() end)
    inst.components.combat.GetBattleCryString = battlecry
    --inst.components.combat.GetGiveUpString = giveupstring

    inst.components.combat:SetKeepTargetFunction(shouldKeepTarget)

	inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(ShouldAcceptItem)
    inst.components.trader:SetAbleToAcceptTest(IsAbleToAccept)
    inst.components.trader.onaccept = OnGetItemFromPlayer
	inst.components.trader.deleteitemonaccept = false

    if CONFIG.follower_names then
        inst:AddComponent("named")
        inst.components.named.possiblenames = STRINGS.SWAMPIGNAMES
        inst.components.named:PickNewName()
    end

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.POWDER_MONKEY_HEALTH)
    inst.components.health:StartRegen(TUNING.BEEFALO_HEALTH_REGEN, TUNING.BEEFALO_HEALTH_REGEN_PERIOD)

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('powdermonkey')

    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.VEGGIE }, { FOODTYPE.VEGGIE })
    inst.components.eater:SetOnEatFn(oneat)

    inst:AddComponent("sleeper")
    inst.components.sleeper.sleeptestfn = modifiedsleeptest
    inst.components.sleeper.waketestfn = DefaultWakeTest

    inst:AddComponent("embarker")
    inst.components.embarker.embark_speed = inst.components.locomotor.runspeed

    inst:AddComponent("drownable")

    inst.components.locomotor:SetAllowPlatformHopping(true)

    inst:AddComponent("areaaware")

    inst:AddComponent("timer")

    inst:AddComponent("follower")
	inst.components.follower.keepleaderduringminigame = true
    inst.components.follower.maxfollowtime = 1800

    inst.ClearTinkerTarget = ClearTinkerTarget

    inst:ListenForEvent("onremove", function()
        if inst.cannon then
            inst.cannon.operator = nil
        end
        inst:ClearTinkerTarget()
    end)

    inst:SetBrain(brain)
    inst:SetStateGraph("SGpowdermonkey")

    inst:AddComponent("knownlocations")

    inst:ListenForEvent("timerdone", OnTimerDone)
    inst:ListenForEvent("onpickupitem", OnPickup)
	inst:ListenForEvent("dropitem", OnDropItem)
    inst:ListenForEvent("attacked", OnAttacked)
    inst:ListenForEvent("death", OnDeath)
    inst:ListenForEvent("itemget", OnGotItem)
    --inst:ListenForEvent("abandon_ship", OnAbandonShip)
    inst:ListenForEvent("ms_seamlesscharacterspawned", onmonkeychange, TheWorld)
    inst:ListenForEvent("loseloyalty", unfollowedfn)
    inst:ListenForEvent("loseloyalty", OnMarkForTeleport)
    inst:ListenForEvent("stopfollowing", OnMarkForTeleport)
    inst:ListenForEvent("gainloyalty", OnUnmarkForTeleport)
    inst:ListenForEvent("startfollowing", OnUnmarkForTeleport)
    inst:ListenForEvent("unequip", OnHit)
    inst:DoPeriodicTask(0.5, Tricornbuff)
    MakeHauntablePanic(inst)

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    return inst
end

return Prefab("powder_monkey", fn, assets, prefabs)
