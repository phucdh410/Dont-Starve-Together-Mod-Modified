require("stategraphs/commonstates")

local actionhandlers =
{
    ActionHandler(ACTIONS.GOHOME, "action"),
    ActionHandler(ACTIONS.PICKUP, "action"),
    ActionHandler(ACTIONS.STEAL, "action"),
    ActionHandler(ACTIONS.PICK, "action"),
    ActionHandler(ACTIONS.HARVEST, "action"),
    ActionHandler(ACTIONS.ATTACK, "throw"),
    ActionHandler(ACTIONS.EAT, "eat"),
    ActionHandler(ACTIONS.ROW, "row"),
    ActionHandler(ACTIONS.REPAIR_LEAK, "action"),
    ActionHandler(ACTIONS.ABANDON, "dive"),
    ActionHandler(ACTIONS.TOSS, "action"),
    ActionHandler(ACTIONS.MINE, "mine"),
	ActionHandler(ACTIONS.CHOP, "chop"),
    ActionHandler(ACTIONS.DIG, "dig"),
}

local events=
{
    CommonHandlers.OnLocomote(true, true),
    CommonHandlers.OnFreeze(),
    CommonHandlers.OnAttacked(1),
    CommonHandlers.OnDeath(),
    CommonHandlers.OnHop(),
    CommonHandlers.OnSink(),
    CommonHandlers.OnSleep(),
    EventHandler("doattack", function(inst, data)
        if not ((inst.components.health ~= nil and inst.components.health:IsDead())
                or inst.sg:HasStateTag("busy")) and data.target:IsValid() then
            if not inst.components.timer:TimerExists("divecooldown")
                    and data.target:IsOnValidGround()
                    and CONFIG.diveatk_toggle then
                inst.sg:GoToState("dive_attack", data.target)
            else
                inst.sg:GoToState("attack", data.target)
            end
        end
    end),
    EventHandler("command", function(inst, data)
        if not ((inst.components.health ~= nil and inst.components.health:IsDead())
                or inst.sg:HasStateTag("busy")) then
            inst.sg:GoToState("taunt")
        end
    end),
    EventHandler("cheer", function(inst)
        if not ((inst.components.health ~= nil and inst.components.health:IsDead())
                or inst.sg:HasStateTag("busy")) then
            inst.sg:GoToState("cheer")
        end
    end),
    EventHandler("eat", function(inst)
        if not ((inst.components.health ~= nil and inst.components.health:IsDead())
                or inst.sg:HasStateTag("busy")) then
            inst.sg:GoToState("eat")
        end
    end),
    EventHandler("doaction", function(inst, data)
        if data.action == GLOBAL.ACTIONS.CHOP and not (inst.sg:HasStateTag("busy") or inst.components.health:IsDead()) then
            inst.sg:GoToState("chop", data.target)
        end
        if data.action == GLOBAL.ACTIONS.MINE and not (inst.sg:HasStateTag("busy") or inst.components.health:IsDead()) then
            inst.sg:GoToState("mine", data.target)
        end
        if data.action == GLOBAL.ACTIONS.DIG and not (inst.sg:HasStateTag("busy") or inst.components.health:IsDead()) then
            inst.sg:GoToState("dig", data.target)
        end
    end)
}

local states =
{
    State{

        name = "idle",
        tags = {"idle", "canrotate"},
        onenter = function(inst, playanim)
            inst.Physics:Stop()
            if playanim then
                inst.AnimState:PlayAnimation(playanim)
                inst.AnimState:PushAnimation("idle_loop", true)
            else
                inst.AnimState:PlayAnimation("idle_loop", true)
            end
            inst.SoundEmitter:PlaySound("monkeyisland/primemate/idle")
        end,

        events=
        {
            EventHandler("animover", function(inst)
                local combat = inst.components.combat
                local next_state = (combat ~= nil
                    and combat.target ~= nil
                    and math.random() < 0.05
                    and combat.target:HasTag("player")
                    and "taunt")
                    or "idle"
                inst.sg:GoToState(next_state)
            end),
        },
    },

    State{

        name = "action",
        tags = {"busy"},
        onenter = function(inst, playanim)
            -- (SAM): actions other than patching the boat might hit this timer;
            -- unsure if we want to reset in those cases or not, so, for now, just test
            -- for existence to avoid the warning message that gets printed.
            if not inst.components.timer:TimerExists("patch_boat_cooldown") then
                inst.components.timer:StartTimer("patch_boat_cooldown", 3)
            end
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("pig_pickup", true)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/make_trap", "make")
        end,
        onexit = function(inst)
            inst.SoundEmitter:KillSound("make")
        end,
        events=
        {
            EventHandler("animover", function (inst)
                inst:PerformBufferedAction()
                inst.sg:GoToState("idle")
            end),
        }
    },

    State{
        name = "row",
        onenter = function(inst, playanim)
            inst.Physics:Stop()

			local equipped = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
			if equipped ~= nil and not equipped.components.oar then
				inst.components.inventory:Unequip(equipped)
				inst.components.inventory:GiveItem(equipped)
				equipped = nil
			end
			if not equipped then
				equipped = SpawnPrefab("oar_monkey")
				equipped:AddTag("personal_possession")
				inst.components.inventory:Equip(equipped)
			end
            inst.AnimState:PlayAnimation("row_pre",false)
            inst.AnimState:PushAnimation("row_loop",false)
            inst.AnimState:PushAnimation("row_pst",false)
        end,

        timeline =
        {
            TimeEvent(8*FRAMES, function(inst)
               inst:PerformBufferedAction()
               inst.SoundEmitter:PlaySound("monkeyisland/primemate/row")
            end),
            TimeEvent(13*FRAMES, function(inst)
               inst.SoundEmitter:PlaySound("monkeyisland/primemate/row")
            end),
        },

        events=
        {
			EventHandler("unequip", function(inst, data)
				if data ~= nil and data.item ~= nil and data.item.components.oar ~= nil then
					inst:ClearBufferedAction()
					inst.sg:GoToState("idle")
				end
			end),
            EventHandler("animqueueover", function (inst)
                inst.sg:GoToState("idle")
            end),
        }
    },

    State{
        name = "eat",
        onenter = function(inst, playanim)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("eat", true)
            inst.SoundEmitter:PlaySound("monkeyisland/primemate/eat")
        end,

        onexit = function(inst)
            inst:PerformBufferedAction()
        end,

        events=
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        }
    },

    State{
        name = "taunt",
        tags = {"busy"},

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("idle_angry")
            inst.components.talker:Say(STRINGS["MONKEY_COMMAND"][math.random(1,#STRINGS["MONKEY_COMMAND"])])
            inst.SoundEmitter:PlaySound("monkeyisland/primemate/taunt")
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State{
        name = "dive",
        tags = {"busy", "nomorph", },

        onenter = function(inst)
            local platform = inst:GetCurrentPlatform()
            if platform then
                local pt = inst:GetPosition()
                local angle = platform:GetAngleToPoint(pt)
                inst.Transform:SetRotation(angle)
            end

            inst.AnimState:PlayAnimation("dive")
            inst.Physics:Stop()
            inst.components.locomotor:Stop()
            inst.components.locomotor:EnableGroundSpeedMultiplier(false)
        end,

        timeline =
        {
            TimeEvent(10*FRAMES, function(inst)

                inst.sg.statemem.collisionmask = inst.Physics:GetCollisionMask()
                inst.Physics:SetCollisionMask(COLLISION.GROUND)
                if not TheWorld.ismastersim then
                    inst.Physics:SetLocalCollisionMask(COLLISION.GROUND)
                end

                inst.Physics:SetMotorVelOverride(5,0,0)
            end),
        },

        onexit = function(inst)
            inst.components.locomotor:Stop()
            inst.components.locomotor:EnableGroundSpeedMultiplier(true)
            inst.Physics:ClearMotorVelOverride()

            inst.Physics:ClearLocalCollisionMask()
            if inst.sg.statemem.collisionmask ~= nil then
                inst.Physics:SetCollisionMask(inst.sg.statemem.collisionmask)
            end
        end,

        events=
        {
            EventHandler("animover", function(inst)
                if TheWorld.Map:IsVisualGroundAtPoint(inst.Transform:GetWorldPosition()) or inst:GetCurrentPlatform() then
                    inst.sg:GoToState("dive_pst_land")
                else
                    SpawnPrefab("splash_green").Transform:SetPosition(inst.Transform:GetWorldPosition())

                    if inst.components.inventory and inst.components.inventory.dropondeath then
                        inst.components.inventory:DropEverything(true)
                    end
                    inst.sg:GoToState("sink")
                end
            end),
        },
    },

    State{
        name = "dive_pst_land",
        tags = {"busy"},

        onenter = function(inst)
            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end
            inst.AnimState:PlayAnimation("dive_pst_land")
            PlayFootstep(inst)
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State{
        name = "dive_attack",
        tags = {"busy", "nomorph", "jumping"},

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.components.locomotor:EnableGroundSpeedMultiplier(false)
            inst.components.health:SetInvincible(true)

            inst.AnimState:PlayAnimation("dive")
            inst.components.talker:Say(STRINGS["SUPERMONKEY_TALK_DIVEATTACK"][math.random(1,#STRINGS["SUPERMONKEY_TALK_DIVEATTACK"])])
        end,

        timeline =
        {
            TimeEvent(10*FRAMES, function(inst)

                inst.sg.statemem.collisionmask = inst.Physics:GetCollisionMask()
                inst.Physics:SetCollisionMask(COLLISION.GROUND)
                if not TheWorld.ismastersim then
                    inst.Physics:SetLocalCollisionMask(COLLISION.GROUND)
                end

                inst.Physics:SetMotorVelOverride(4,0,0)
                inst.SoundEmitter:PlaySound("monkeyisland/primemate/taunt")
            end),
        },

        onexit = function(inst)
            inst.components.locomotor:Stop()
            inst.components.locomotor:EnableGroundSpeedMultiplier(true)
            inst.Physics:ClearMotorVelOverride()

            inst.Physics:ClearLocalCollisionMask()
            if inst.sg.statemem.collisionmask ~= nil then
                inst.Physics:SetCollisionMask(inst.sg.statemem.collisionmask)
            end
        end,

        events=
        {
            EventHandler("animover", function(inst)
                if TheWorld.Map:IsVisualGroundAtPoint(inst.Transform:GetWorldPosition()) or inst:GetCurrentPlatform() then
                    inst.sg:GoToState("dive_attack_land")
                end
            end),
        },
    },

    State{
        name = "dive_attack_land",
        tags = {"attack", "busy"},

        onenter = function(inst, target)
            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end
            inst.components.health:SetInvincible(false)
            inst.components.combat:StartAttack()
            inst.AnimState:PlayAnimation("dive_pst_land")
            inst.sg.statemem.target = target
            PlayFootstep(inst)
        end,

        timeline =
        {
            TimeEvent(0, function(inst) inst:DiveAttack(inst.sg.statemem.target) end),
        },

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State{
        name = "cheer",
        tags = { "busy", "cheering" },

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("buff")
        end,

        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State{
        name = "mine",
        tags = { "mining" },

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("atk_weapon")
        end,

        timeline =
        {
            TimeEvent(13 * FRAMES, function(inst)
                if inst.bufferedaction ~= nil then
                    PlayMiningFX(inst, inst.bufferedaction.target)
                end
                inst:PerformBufferedAction()
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
    },
    State{
        name = "chop",
        tags = { "chopping" },

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("atk_weapon")
        end,

        timeline =
        {
            TimeEvent(13 * FRAMES, function(inst)
                inst:PerformBufferedAction()
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
    },
    State{
        name = "dig",
        tags = { "digging" },

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("atk_weapon")
        end,

        timeline =
        {
            TimeEvent(13 * FRAMES, function(inst)
                inst:PerformBufferedAction()
                inst.SoundEmitter:PlaySound("dontstarve/wilson/dig")
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
    }
}

CommonStates.AddWalkStates(states,
{
    walktimeline =
    {
        TimeEvent(0, PlayFootstep),
        TimeEvent(12 * FRAMES, PlayFootstep),
    },
})

CommonStates.AddRunStates(states,
{
    runtimeline =
    {
        TimeEvent(0, PlayFootstep),
        TimeEvent(10 * FRAMES, PlayFootstep),
    },
})


CommonStates.AddSleepStates(states,
{
    starttimeline =
    {
        TimeEvent(1*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("monkeyisland/powdermonkey/sleep_pre")
        end),
    },

    sleeptimeline =
    {
        TimeEvent(1*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("monkeyisland/powdermonkey/sleep_lp", "sleep_lp")
        end),
    },

    endtimeline =
    {
        TimeEvent(1*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("monkeyisland/powdermonkey/sleep_pst")
        end),
    },
},{
    onsleepexit = function(inst)
        inst.SoundEmitter:KillSound("sleep_lp")
    end,
})

CommonStates.AddCombatStates(states,
{
    attacktimeline =
    {
		TimeEvent(9 * FRAMES, function(inst)
            inst.components.combat:DoAttack()
        end),
    },

    hittimeline =
    {
        TimeEvent(1*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("monkeyisland/primemate/hit")
        end),
    },

    deathtimeline =
    {
        TimeEvent(1*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("monkeyisland/primemate/death")
        end),
    },
},nil,{attackanimfn= function(inst) 
    if inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) and inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS).components.weapon then
		return "atk_weapon"
    end
    return nil
end})

CommonStates.AddFrozenStates(states)
CommonStates.AddHopStates(states, true, { pre = "boat_jump_pre", loop = "boat_jump_loop", pst = "boat_jump_pst"})
CommonStates.AddSinkAndWashAshoreStates(states)
CommonStates.AddSimpleActionState(states, "pickup", "pig_pickup", 10 * FRAMES, { "busy" })

return StateGraph("superprimemate", states, events, "idle", actionhandlers)
