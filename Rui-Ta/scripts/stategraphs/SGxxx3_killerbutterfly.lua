require('stategraphs/commonstates')

local actionhandlers = {
    ActionHandler(ACTIONS.GOHOME, 'land')
    -- ActionHandler(ACTIONS.ATTACK, "attack"),
}

local function CheckLeaderShadowLevel(inst, target)
    local level = 0
    local leader = inst.components.follower:GetLeader()
    if leader ~= nil and leader.components.inventory ~= nil then
        for k, v in pairs(EQUIPSLOTS) do
            local equip = leader.components.inventory:GetEquippedItem(v)
            if equip ~= nil and equip.components.shadowlevel ~= nil then
                level = level + equip.components.shadowlevel:GetCurrentLevel()
            end
        end
    end

    --Scale damage
    inst.components.combat:SetDefaultDamage(15 + level)
end

local events = {
    EventHandler(
        'locomote',
        function(inst)
            if not inst.sg:HasStateTag('busy') then
                local is_moving = inst.sg:HasStateTag('moving')
                local wants_to_move = inst.components.locomotor:WantsToMoveForward()
                if is_moving ~= wants_to_move then
                    if wants_to_move then
                        inst.sg.statemem.wantstomove = true
                    else
                        inst.sg:GoToState('idle')
                    end
                end
            end
        end
    ),
    -- CommonHandlers.OnLocomote(true, false),
    EventHandler(
        'death',
        function(inst)
            inst.sg:GoToState('death')
        end
    ),
    EventHandler(
        'doattack',
        function(inst)
            if not inst.components.health:IsDead() then
                inst.sg:GoToState('attack')
            end
        end
    )
}

local states = {
    State {
        name = 'moving',
        tags = {'moving', 'canrotate'},
        onenter = function(inst)
            inst.components.locomotor:WalkForward()
            inst.AnimState:PlayAnimation('flight_cycle', true)
        end
    },
    State {
        name = 'death',
        tags = {'busy'},
        onenter = function(inst)
            inst.AnimState:PlayAnimation('death')
            inst.Physics:Stop()
            RemovePhysicsColliders(inst)
        end,
        timeline = {
            TimeEvent(10 * FRAMES, LandFlyingCreature)
        }
    },
    State {
        name = 'idle',
        tags = {'idle'},
        onenter = function(inst)
            inst.Physics:Stop()
            if not inst.AnimState:IsCurrentAnimation('idle_flight_loop') then
                inst.AnimState:PlayAnimation('idle_flight_loop', true)
            end
            inst.sg:SetTimeout(inst.AnimState:GetCurrentAnimationLength())
        end,
        ontimeout = function(inst)
            if inst.sg.statemem.wantstomove then
                inst.sg:GoToState('moving')
            else
                inst.sg:GoToState('idle')
            end
        end
    },
    State {
        name = 'attack',
        tags = {'attack'},
        onenter = function(inst)
            inst.components.combat:StartAttack()
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation('land')
        end,
        timeline = {
            TimeEvent(
                15 * FRAMES,
                function(inst)
                    if inst.prefab == 'xxx3_killerbutterfly_shadow' then
                        local target = inst.sg.statemem.target
                        CheckLeaderShadowLevel(inst, target ~= nil and target:IsValid() and target or nil)
                    end
                    inst.components.combat:DoAttack()
                end
            )
        },
        events = {
            EventHandler(
                'animover',
                function(inst)
                    inst.sg:GoToState('idle')
                end
            )
        }
    }
}

return StateGraph('xxx3_killerbutterfly', states, events, 'idle', actionhandlers)
