require "behaviours/faceentity"
require "behaviours/chaseandattack"
require "behaviours/follow"
require "behaviours/standstill"
require "behaviours/chattynode"

local xxx3_killerbutterfly_brain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

local MIN_FOLLOW_LEADER = 2
local MAX_FOLLOW_LEADER = 6
local TARGET_FOLLOW_LEADER = (MAX_FOLLOW_LEADER+MIN_FOLLOW_LEADER)/2

local RUN_AWAY_DIST = 5
local STOP_RUN_AWAY_DIST = 8
local MAX_CHASE_TIME = 15
local MIN_FOLLOW_CLOSE = 0
local TARGET_FOLLOW_CLOSE = 2
local MAX_FOLLOW_CLOSE = 3
local MIN_FOLLOW = 5
local TARGET_FOLLOW = 10
local MAX_FOLLOW = 15
local MAX_WANDER_DIST = 20

local function GetLeader(inst)
    return inst.components.follower.leader
end

function xxx3_killerbutterfly_brain:OnStart()
    local root = PriorityNode(
    {
        WhileNode(function()
            return self.inst.components.combat.target ~= nil and ((self.inst.components.follower.leader and
            self.inst.components.follower.leader:GetDistanceSqToInst(self.inst) < 225) )end,
            "doattack",
            ChaseAndAttack(self.inst, MAX_CHASE_TIME)
        ),
		Follow(self.inst, GetLeader, MIN_FOLLOW_LEADER, TARGET_FOLLOW_LEADER, MAX_FOLLOW_LEADER),
        -- DoAction(self.inst, AttackAction, "attack", true),
    }, .25)

    self.bt = BT(self.inst, root)
end

return xxx3_killerbutterfly_brain