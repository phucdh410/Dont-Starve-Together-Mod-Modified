require "behaviours/wander"
require "behaviours/runaway"
require "behaviours/doaction"
require "behaviours/panic"
require "behaviours/chaseandattack"
require "behaviours/leash"
require "behaviours/follow"
local BrainCommon = require("brains/braincommon")

local MIN_FOLLOW_DIST = 5
local TARGET_FOLLOW_DIST = 5
local MAX_FOLLOW_DIST = 13

local RUN_AWAY_DIST = 5
local STOP_RUN_AWAY_DIST = 10

local MAX_WANDER_DIST = 15

local TRADE_DIST = 20

local MAX_CHASE_TIME = 10
local MAX_CHASE_DIST = 30

local FACETIME_BASE = 4
local FACETIME_RAND = 3


local SEE_PLAYER_DIST = 5
local STOP_RUN_DIST = 10

local FollowerMonkeyBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

local function GetLeader(inst)
    return inst.components.follower.leader
end

local function GetTraderFn(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local players = FindPlayersInRange(x, y, z, TRADE_DIST, true)
    for _, v in ipairs(players) do
        if inst.components.trader:IsTryingToTradeWithMe(v) then
            return v
        end
    end
end

local function KeepTraderFn(inst, target)
    return inst.components.trader:IsTryingToTradeWithMe(target)
end

local function findmaxwanderdistfn(inst)
    local dist = MAX_WANDER_DIST
    local boat = inst:GetCurrentPlatform()
    if boat then
        dist = boat.components.walkableplatform and boat.components.walkableplatform.platform_radius -0.3 or dist
    end
    return dist
end

local function findwanderpointfn(inst)
    if inst.components.follower.leader then
        return nil
    end
    local loc = inst.components.knownlocations:GetLocation("home")
    local boat = inst:GetCurrentPlatform()
    if boat then
        loc = Vector3(boat.Transform:GetWorldPosition())
    end
    return loc
end

local function GetFaceTargetFn(inst)
    if inst.components.timer:TimerExists("dontfacetime") then
        return nil
    end
    local shouldface = inst.components.follower.leader or FindClosestPlayerToInst(inst, SEE_PLAYER_DIST, true)
    if shouldface and not inst.components.timer:TimerExists("facetime") then
        inst.components.timer:StartTimer("facetime", FACETIME_BASE + math.random()*FACETIME_RAND)
    end
    return shouldface
end

local function KeepFaceTargetFn(inst, target)
    if inst.components.timer:TimerExists("dontfacetime") then
        return nil
    end
    local keepface = (inst.components.follower.leader and inst.components.follower.leader == target) or (target:IsValid() and inst:IsNear(target, SEE_PLAYER_DIST))
    if not keepface then
        inst.components.timer:StopTimer("facetime")
    end
    return keepface
end

local function shouldrun(inst)
    return inst.components.timer:TimerExists("hit") and inst.components.combat.target
end

function FollowerMonkeyBrain:OnStart()

    local root = PriorityNode(
    {
		BrainCommon.PanicTrigger(self.inst),
		WhileNode(
			function()
				return self.inst.components.homeseeker ~= nil
					and self.inst.components.homeseeker.home
					and self.inst.components.homeseeker.home.components.burnable
					and self.inst.components.homeseeker.home.components.burnable:IsBurning()
			end,
			"OnFire", Panic(self.inst)),

        WhileNode(function() return shouldrun(self.inst) end, "Should run",
            RunAway(self.inst, function(guy) return self.inst.components.combat.target and self.inst.components.combat.target == guy or nil end, SEE_PLAYER_DIST, STOP_RUN_DIST, nil, true)),

        WhileNode(function() return self.inst.components.combat.target == nil or not self.inst.components.combat:InCooldown() end, "AttackMomentarily",
            ChaseAndAttack(self.inst, SpringCombatMod(MAX_CHASE_TIME), SpringCombatMod(MAX_CHASE_DIST))),
        WhileNode(function() return self.inst.components.combat.target ~= nil and self.inst.components.combat:InCooldown() end, "Dodge",
            RunAway(self.inst, function() return self.inst.components.combat.target end, RUN_AWAY_DIST, STOP_RUN_AWAY_DIST)),

        ChattyNode(self.inst, "",
            FaceEntity(self.inst, GetTraderFn, KeepTraderFn)),

        Follow(self.inst, GetLeader, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST),
        
        IfNode(function() return self.inst.components.follower.leader ~= nil end, "HasLeader",
            ChattyNode(self.inst, "",
                FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn ))),

        FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn),
        Wander(self.inst, function() return findwanderpointfn(self.inst) end, function() return findmaxwanderdistfn(self.inst) end, {minwalktime=0.7,randwalktime=1.5,minwaittime=1.5,randwaittime=6})
    }, 1)
    self.bt = BT(self.inst, root)
end

return FollowerMonkeyBrain
