require("stategraphs/commonstates")

local actionhandlers =
{
    ActionHandler(ACTIONS.HARVEST, "eat_enter"),
    ActionHandler(ACTIONS.PICK, "eat_enter"),
    ActionHandler(ACTIONS.PICKUP, "eat_enter"),
    ActionHandler(ACTIONS.MURDER, "action"),
}

local Pi = 3.1415926535898
local Pi2 = 3.1415926535898 / 2.0
local Pi4 = 3.1415926535898 / 4.0

local function SetLightR(inst, val)
    if inst.Light ~= nil then
        inst.Light:SetRadius(val)
    end
end

local function SetLightColour(inst, a,b,c)
    if inst.Light ~= nil then
        inst.Light:SetColour(a, b, c)
    end
end

local function Fire(inst)
    local tar = inst.components.combat.target
    if tar == nil then
        return
    end
    local x1, y1, z1 = inst.Transform:GetWorldPosition()
    local angle = (inst.Transform:GetRotation())*DEGREES
    local newangle = 0
    local delta = Pi4
    if angle >= 0 and angle < Pi2 then
        if angle < Pi2 -angle then
            newangle = 0
        else
            newangle = Pi2
        end
    elseif angle >= Pi2 and angle < Pi then
        if angle - Pi2 < Pi -angle then
            newangle = Pi2
        else
            newangle = Pi
        end
    elseif angle < 0 and angle > -Pi2 then
        if -angle < angle + Pi2 then
            newangle = 0
        else
            newangle = -Pi2
        end
    elseif angle <= -Pi2 and angle > -Pi then
        if -angle - Pi2 < angle + Pi then
            newangle = -Pi2
        else
            newangle = Pi
        end
    else
        newangle = Pi
    end
    -- print("facepoint",angle,newangle)
    local ents = TheSim:FindEntities(x1, y1, z1, 8)
    for k,v in pairs(ents) do
        if (not v:HasTag("eyeplant") and not v:HasTag("eyeplant_friend") and not v:HasTag("wall") ) and (v.components.burnable or v.components.health) then
            local x, y, z = v.Transform:GetWorldPosition()
            local dx = x - x1
            local dz = z - z1
            local angleto = -math.atan2(dz, dx)
            local judge = false
            -- print(v,angleto)
            if newangle == Pi and (angleto >= Pi-delta or angleto <= -Pi+delta) then
                -- print("fuchker")
                judge = true
            elseif angleto >= newangle - delta and angleto <= newangle + delta then
                -- print("lamer")
                -- print(newangle-delta,newangle+delta)
                judge = true
            end
            if judge == true then
                if v.components.health and v.components.combat and not v.components.health:IsDead() then
                    inst.components.combat.ignorehitrange = true
                    inst.components.combat:DoAttack(v)
                    inst.components.combat.ignorehitrange = false
                    if v.components.burnable then
                        v.components.burnable:Ignite()
                    end
                elseif v.components.burnable then
                    if (v.components.inventoryitem and v.components.inventoryitem.owner==nil)
                    or v.components.inventoryitem==nil then
                        v.components.burnable:Ignite()
                    end
                end
            end
        end
    end
end

local events=
{
    CommonHandlers.OnLocomote(false, true),
    CommonHandlers.OnSleep(),
    CommonHandlers.OnFreeze(),
    CommonHandlers.OnAttack(),
    CommonHandlers.OnDeath(),
    EventHandler("attacked", function(inst)
        if not inst.components.health:IsDead() and not inst.sg:HasStateTag("attack") then
            inst.sg:GoToState("hit")
        end
    end),
}

local states=
{
    State{
        name = "spawn",
        tags = {"busy"},

        onenter = function(inst, playanim)
            inst.Physics:Stop()
            inst.Light:Enable(false)
            inst.AnimState:PlayAnimation("spawn")
            inst.AnimState:PushAnimation("idle", true)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/eyeplant/eye_emerge")
        end,
        onexit = function (inst)
            SetLightR(inst,.3)
            inst.Light:Enable(true)
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },

        timeline =
        {
            TimeEvent(2 * FRAMES, function(inst) SetLightR(inst, .03) inst.Light:Enable(true) end),
            TimeEvent(6  * FRAMES, function(inst) SetLightR(inst, .06) end),
            TimeEvent(10 * FRAMES, function(inst) SetLightR(inst, .09) end),
            TimeEvent(14 * FRAMES, function(inst) SetLightR(inst, .12) end),
            TimeEvent(18 * FRAMES, function(inst) SetLightR(inst, .15) end),
            TimeEvent(22 * FRAMES, function(inst) SetLightR(inst, .18) end),
            TimeEvent(26 * FRAMES, function(inst) SetLightR(inst, .21) end),
            TimeEvent(30 * FRAMES, function(inst) SetLightR(inst, .24) end),
            TimeEvent(34 * FRAMES, function(inst) SetLightR(inst, .27) end),
        },

    },

    State{
        name = "idle",
        tags = {"idle", "canrotate"},
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("idle", true)
        end,


    },

    State{
        name = "action",
        tags = {"idle", "canrotate"},
        onenter = function(inst, playanim)
            inst:PerformBufferedAction()
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State{

        name = "alert",
        tags = {"idle", "canrotate"},
        onenter = function(inst, playanim)
            inst.Physics:Stop()
            if inst.components.combat.target then
                inst:ForceFacePoint(inst.components.combat.target.Transform:GetWorldPosition())
            end
            inst.AnimState:PlayAnimation("lookat", true)
        end,

        onupdate = function(inst)
            if inst.components.combat.target and distsq(inst.components.combat.target:GetPosition(),inst:GetPosition())
                <= inst.components.combat:CalcAttackRangeSq(inst.components.combat.target) then
                inst.sg:GoToState("attack")
            end
        end,

    },

    State{
        name = "hit",
        tags = {"busy", "hit"},

        onenter = function(inst)
            inst.AnimState:PlayAnimation("hit")
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("attack") end),
        },

    },

    State{
        name = "attack",
        tags = {"attack", "canrotate"},
        onenter = function(inst)
            if inst.components.combat.target then
                inst:ForceFacePoint(inst.components.combat.target.Transform:GetWorldPosition())
            end
            inst.AnimState:PlayAnimation("atk")
        end,

        timeline=
        {
            TimeEvent(20 * FRAMES, function(inst) SetLightR(inst, 0.6) end),
            TimeEvent(21 * FRAMES, function(inst) SetLightR(inst, 0.9) end),
            TimeEvent(22 * FRAMES, function(inst) SetLightR(inst, 1.3) end),
            TimeEvent(23 * FRAMES, function(inst) SetLightR(inst, 2.1) SetLightColour(inst,203/255,196/255,160/255) end),
            TimeEvent(24 * FRAMES, function(inst) SetLightR(inst, 2.9) SetLightColour(inst,209/255,194/255,150/255) end),
            TimeEvent(25 * FRAMES, function(inst) SetLightR(inst, 3.7) SetLightColour(inst,212/255,193/255,140/255) end),
            TimeEvent(26 * FRAMES, function(inst)
                SetLightR(inst, 4.5) SetLightColour(inst,219/255,191/255,130/255)
                Fire(inst)
                inst.SoundEmitter:PlaySound("dontstarve/creatures/eyeplant/eye_bite")
            end),
            TimeEvent(27 * FRAMES, function(inst) SetLightR(inst, 5.3) SetLightColour(inst,255/255,190/255,121/255) end),
            TimeEvent(28 * FRAMES, function(inst) SetLightR(inst, 4.3) SetLightColour(inst,203/255,191/255,130/255) end),
            TimeEvent(29 * FRAMES, function(inst) SetLightR(inst, 3.2) SetLightColour(inst,209/255,193/255,140/255) end),
            TimeEvent(30 * FRAMES, function(inst) SetLightR(inst, 2.2) SetLightColour(inst,212/255,194/255,150/255) end),
            TimeEvent(31 * FRAMES, function(inst) SetLightR(inst, 1.2) SetLightColour(inst,219/255,196/255,160/255) end),
            TimeEvent(32 * FRAMES, function(inst) SetLightR(inst, 0.3) SetLightColour(inst,197/255,197/255,170/255) end),

        },

        events=
        {
            EventHandler("animqueueover", function(inst)
                if inst.components.combat.target and
                    distsq(inst.components.combat.target:GetPosition(),inst:GetPosition()) <=
                    inst.components.combat:CalcAttackRangeSq(inst.components.combat.target) then
                    inst.sg:GoToState("attack")
                else
                    inst.sg:GoToState("alert")
                end
            end),
        },
        onexit = function (inst)
            SetLightR(inst,.3)
            SetLightColour(inst,197/255,197/255,170/255)
            inst.components.combat.ignorehitrange = false
        end
    },

    State{
        name = "death",
        tags = {"busy"},

        onenter = function(inst)
            -- print("length:",inst.AnimState:GetCurrentAnimationLength())
            inst.AnimState:PlayAnimation("despawn")
            RemovePhysicsColliders(inst)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/eyeplant/eye_retract")

        end,
        events=
        {
            EventHandler("animqueueover", function(inst)
                inst:Remove()
            end),
        },
        timeline =
        {
            TimeEvent(1 * FRAMES, function(inst) SetLightR(inst, .30) end),
            TimeEvent(3 * FRAMES, function(inst) SetLightR(inst, .25) end),
            TimeEvent(5 * FRAMES, function(inst) SetLightR(inst, .20) end),
            TimeEvent(7 * FRAMES, function(inst) SetLightR(inst, .15) end),
            TimeEvent(9 * FRAMES, function(inst) SetLightR(inst, .10) end),
            TimeEvent(11 * FRAMES, function(inst) SetLightR(inst, .05) end),
            TimeEvent(13 * FRAMES, function(inst) SetLightR(inst, 0) end),
        },
    },

    State{
        name = "eat_enter",
        tags = {"busy", "canrotate"},

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("eat", false)
        end,

        timeline =
        {
            TimeEvent(23*FRAMES, function(inst)
            if inst:GetBufferedAction().target then
                inst:GetBufferedAction().target:PushEvent("ontrapped")
            end
            inst:PerformBufferedAction()
            inst.SoundEmitter:PlaySound("dontstarve/creatures/eyeplant/eye_bite")
            end ), --take food
        },

        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("alert") end)
        },
    },

    State{
        name = "eat_loop",
        tags = {"busy"},

        onenter = function(inst)
            inst.AnimState:PlayAnimation("hit", true)
            inst.sg:SetTimeout(1+math.random()*2)
        end,

        ontimeout= function(inst)
            inst.lastmeal = GetTime()
            inst:PerformBufferedAction()
            inst.sg:GoToState("idle")
        end,

        events =
        {
            EventHandler("attacked", function(inst) inst.components.inventory:DropEverything() inst.sg:GoToState("idle") end) --drop food
        },
    },

    State{

        name = "walk_start",
        tags = {"idle", "canrotate"},
        onenter = function(inst, playanim)
            print("EYEPLANT WALK START!")
            inst.Physics:Stop()
            if playanim then
                inst.AnimState:PlayAnimation(playanim)
                inst.AnimState:PushAnimation("idle", true)
            else
                inst.AnimState:PlayAnimation("idle", true)
            end

            inst:PerformBufferedAction()

        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },

    },
}


CommonStates.AddFrozenStates(states)

return StateGraph("SGxxx3_eyeplant_2", states, events, "idle", actionhandlers)