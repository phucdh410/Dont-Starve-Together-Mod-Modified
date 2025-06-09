require("stategraphs/commonstates")

local events=
{
    EventHandler("doattack", function(inst)
        if not inst.sg:HasStateTag("busy") then
            inst.sg:GoToState("attack")

        end
    end),
}

local states=
{
    State{
        name = "idle",
        tags = {"idle", "canrotate"},
        onenter = function(inst)
            inst.AnimState:PlayAnimation("idle", true)
        end,
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State{
        name = "attack",
        tags = {"attack", "canrotate"},
        onenter = function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/eyeballturret/charge")
            inst.AnimState:PlayAnimation("attack", false)
        end,
        timeline=
        {
            TimeEvent(20*FRAMES, function(inst)
                inst.components.combat:StartAttack()
                inst.components.combat:DoAttack()
                inst.SoundEmitter:PlaySound("dontstarve/creatures/eyeballturret/shoot")
            end),
        },

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },
}

return StateGraph("xxx3_flgun_plant", states, events, "idle")
