require "behaviours/wander"
require "behaviours/runaway"
require "behaviours/doaction"
require "behaviours/chaseandattack"
require "behaviours/leash"
local BrainCommon = require("brains/braincommon")

local MIN_FOLLOW_DIST = 2
local TARGET_FOLLOW_DIST = 7
local MAX_FOLLOW_DIST = 15

local RUN_AWAY_DIST = 7
local STOP_RUN_AWAY_DIST = 15

local MAX_WANDER_DIST = 20

local MAX_CHASE_TIME = 20
local MAX_CHASE_DIST = 40

local FACETIME_BASE = 4
local FACETIME_RAND = 3

local TRADE_DIST = 20
local SEE_PLAYER_DIST = 5

local SEE_TREE_DIST = 20
local SEE_ROCK_DIST = 20

local KEEP_CHOPPING_DIST = 15
local KEEP_MINING_DIST = 15

local SuperprimemateBrain = Class(Brain, function(self, inst)
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

function rowboat(inst)

    if not inst.components.crewmember or not inst.components.crewmember:Shouldrow() then
        return nil
    end

    local pos = inst.rowpos
    local boat = inst:GetCurrentPlatform() == inst.components.crewmember.boat and inst:GetCurrentPlatform()

    if boat and not pos then
        local radius = boat.components.walkableplatform.platform_radius - 0.35 
        pos = boat:GetPosition()

        local offset = FindWalkableOffset(pos, math.random()*TWOPI, radius, 12, false,false,nil,false,true)
        if offset then
            pos = pos + offset
        end
    end
    if pos and boat then
        inst.rowpos = pos
        return BufferedAction(inst, nil, ACTIONS.ROW, nil, pos)
    end
end

local NO_TAGS = { "FX", "NOCLICK", "DECOR", "INLIMBO" }

function shouldfix(inst)
    if inst.components.timer:TimerExists("patch_boat_cooldown") then
        return nil
    end

    local leaktarget = nil
    local item = inst.components.inventory:FindItem(function(testitem)
        if testitem.components.boatpatch then

            return true
        end
    end)

    local pos = inst.components.crewmember and inst.components.crewmember.boat and Vector3(inst.components.crewmember.boat.Transform:GetWorldPosition()) or nil

    if pos then
        local ents = TheSim:FindEntities(pos.x, pos.y, pos.z, 4, nil, NO_TAGS)

        for i, ent in ipairs(ents) do
            if ent.components.boatleak and ent.components.boatleak.has_leaks ~= false then
                leaktarget = ent
                break
            end
        end
    end

    if item and leaktarget then
        inst.fixboat = {item = item, leaktarget = leaktarget}
        return true
    end
end

function fixboat(inst) 
   if inst.components.timer:TimerExists("patch_boat_cooldown") then
        return nil
    end

    local leaktarget = nil
    local item = inst.components.inventory:FindItem(function(testitem)
        if testitem.components.boatpatch then

            return true
        end
    end)

    local pos = inst.components.crewmember and inst.components.crewmember.boat and Vector3(inst.components.crewmember.boat.Transform:GetWorldPosition()) or nil

    if pos then
        local ents = TheSim:FindEntities(pos.x, pos.y, pos.z, 4, nil, NO_TAGS)

        for i, ent in ipairs(ents) do
            if ent.components.boatleak and ent.components.boatleak.has_leaks ~= false then
                leaktarget = ent
                break
            end
        end
    end

    if item and leaktarget then
        return BufferedAction(inst, leaktarget, ACTIONS.REPAIR_LEAK, item)
    end
end

local function DoAbandon(inst)
    if inst:GetCurrentPlatform() and inst:GetCurrentPlatform().components.health:IsDead() then
        inst.abandon = true
    end

    if not inst.abandon then
        return
    end

    local pos = Vector3(0,0,0)
    local platform = inst:GetCurrentPlatform()
    if platform then
        local x,y,z = inst.Transform:GetWorldPosition()
        local theta = platform:GetAngleToPoint(x, y, z)* DEGREES
        local radius = platform.components.walkableplatform.platform_radius - 0.5
        local offset = Vector3(radius * math.cos( theta ), 0, -radius * math.sin( theta ))

        local boat_x, boat_y, boat_z = platform.Transform:GetWorldPosition()

        pos = Vector3( boat_x+offset.x, 0, boat_z+offset.z )

        return BufferedAction(inst, nil, ACTIONS.ABANDON, nil, pos)
    end

    return nil
end

local function cangettotarget(inst)
    -- IF NOT ON A BOAT, IGNORE ALL THIS
    if not inst:GetCurrentPlatform() and inst.components.combat and inst.components.combat.target then
        return true
    end

    local boat = inst:GetCurrentPlatform()
    if inst.components.combat and inst.components.combat.target then
        local target = inst.components.combat.target
        local range = inst.components.combat:GetAttackRange() + boat.components.walkableplatform.platform_radius
        if target:GetCurrentPlatform() == inst:GetCurrentPlatform() or boat:GetDistanceSqToInst(target) <  range*range then
            return true
        end
    end
end

local DIG_TAGS = { "DIG_workable", "tree" }
local DIG_CANT_TAGS = { "carnivalgame_part", "event_trigger", "waxedplant" }
local function HasDigTool(inst)
    local tool = inst.components.inventory ~= nil and inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) or nil

    return tool ~= nil
end

local function dig_stump_starter(inst,finddist)
    local target = FindEntity(inst, finddist, nil, DIG_TAGS, DIG_CANT_TAGS)
    return inst.stump_target or target or nil
end

local function dig_stump_keepgoing(inst, leaderdist, finddist)
    return inst.stump_target ~= nil
        or (inst.components.follower.leader ~= nil and
            inst:IsNear(inst.components.follower.leader, leaderdist))
end

local function dig_stump_finder(inst, leaderdist, finddist)
    local target = FindEntity(inst, finddist, nil, DIG_TAGS, DIG_CANT_TAGS)
    if target == nil and inst.components.follower.leader ~= nil then
        target = FindEntity(inst.components.follower.leader, finddist, nil, DIG_TAGS, DIG_CANT_TAGS)
    end
    if target ~= nil then
        if inst.stump_target ~= nil then
            target = inst.stump_target
            inst.stump_target = nil
        end

        return BufferedAction(inst, target, ACTIONS.DIG)
    end
end

local function IsDeciduousTreeMonster(guy)
    return guy.monster and guy.prefab == "deciduoustree"
end

local MINE_TAGS = { "MINE_workable" }
local MINE_CANT_TAGS = { "carnivalgame_part", "event_trigger", "waxedplant" }
local CHOP_MUST_TAGS = { "CHOP_workable" }
local CHOP_CANT_TAGS = { "carnivalgame_part", "event_trigger", "waxedplant" }
local function FindDeciduousTreeMonster(inst)
    return FindEntity(inst, SEE_TREE_DIST / 3, IsDeciduousTreeMonster, CHOP_MUST_TAGS)
end

local function KeepChoppingAction(inst)
    return inst.tree_target ~= nil
        or (inst.components.follower.leader ~= nil and
            inst:IsNear(inst.components.follower.leader, KEEP_CHOPPING_DIST))
        or FindDeciduousTreeMonster(inst) ~= nil
end

local function StartChoppingCondition(inst)
    return inst.tree_target ~= nil
        or (inst.components.follower.leader ~= nil and
            inst.components.follower.leader.sg ~= nil and
            inst.components.follower.leader.sg:HasStateTag("chopping"))
        or FindDeciduousTreeMonster(inst) ~= nil
end

local function FindTreeToChopAction(inst)
    local target = FindEntity(inst, SEE_TREE_DIST, nil, CHOP_MUST_TAGS, CHOP_CANT_TAGS)

    if target == nil and inst.components.follower.leader ~= nil then
        target = FindEntity(inst.components.follower.leader, SEE_TREE_DIST, nil, CHOP_MUST_TAGS, CHOP_CANT_TAGS)
    end

    if target ~= nil then
        if inst.tree_target ~= nil then
            target = inst.tree_target
            inst.tree_target = nil
        else
            target = FindDeciduousTreeMonster(inst, SEE_TREE_DIST) or target
        end

        return BufferedAction(inst, target, ACTIONS.CHOP)
    end
end

local function KeepMiningAction(inst)
    return inst.rock_target ~= nil
        or (inst.components.follower.leader ~= nil and
            inst:IsNear(inst.components.follower.leader, KEEP_MINING_DIST))
end

local function StartMiningCondition(inst)
    return inst.rock_target ~= nil
        or (inst.components.follower.leader ~= nil and
            inst.components.follower.leader.sg ~= nil and
            inst.components.follower.leader.sg:HasStateTag("mining"))
end

local function FindRockToMineAction(inst)

    local target = FindEntity(inst, SEE_ROCK_DIST, nil, MINE_TAGS, MINE_CANT_TAGS)

    if target == nil and inst.components.follower.leader ~= nil then
        target = FindEntity(inst.components.follower.leader, SEE_ROCK_DIST, nil, MINE_TAGS, MINE_CANT_TAGS)
    end

    if target ~= nil then
        if inst.rock_target ~= nil then
            target = inst.rock_target
            inst.rock_target = nil
        end

        return BufferedAction(inst, target, ACTIONS.MINE)
    end
end

function SuperprimemateBrain:OnStart()

    local root = PriorityNode(
    {
		BrainCommon.PanicTrigger(self.inst),

        ChattyNode(self.inst, "MONKEY_TALK_ABANDON",
            DoAction(self.inst, DoAbandon, "abandon", true )),

        WhileNode(function() return self.inst.components.combat.target == nil or not self.inst.components.combat:InCooldown() end, "AttackMomentarily",
            ChaseAndAttack(self.inst, SpringCombatMod(MAX_CHASE_TIME), SpringCombatMod(MAX_CHASE_DIST))),
        WhileNode(function() return self.inst.components.combat.target ~= nil and self.inst.components.combat:InCooldown() end, "Dodge",
            RunAway(self.inst, function() return self.inst.components.combat.target end, RUN_AWAY_DIST, STOP_RUN_AWAY_DIST)),

        ChattyNode(self.inst, "MONKEY_TALK_RETREAT",
            FaceEntity(self.inst, GetTraderFn, KeepTraderFn)),

        WhileNode(function() return HasDigTool(self.inst) end, "dig stump with tool",
            BrainCommon.NodeAssistLeaderDoAction(self, {
                action = "CHOP", -- Required.
                chatterstring = "",
                starter = dig_stump_starter,
                keepgoing = dig_stump_keepgoing,
                finder = dig_stump_finder,
            })),

        IfThenDoWhileNode(function() return StartChoppingCondition(self.inst) end, function() return KeepChoppingAction(self.inst) end, "chop",
            LoopNode{
                ChattyNode(self.inst, "SUPERMONKEY_TALK_HELP_CHOP_WOOD",
                    DoAction(self.inst, FindTreeToChopAction ))}),
        IfThenDoWhileNode(function() return StartMiningCondition(self.inst) end, function() return KeepMiningAction(self.inst) end, "mine",
            LoopNode{
                ChattyNode(self.inst, "SUPERMONKEY_TALK_HELP_MINE_ROCK",
                    DoAction(self.inst, FindRockToMineAction ))}),

        Follow(self.inst, GetLeader, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST, 1),

        IfNode(function() return self.inst.components.follower.leader ~= nil end, "HasLeader",
            ChattyNode(self.inst, "MONKEY_TALK_RETREAT",
                FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn ))),

        DoAction(self.inst, rowboat, "rowing", nil, 3),

        FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn),
        Wander(self.inst, function() return findwanderpointfn(self.inst) end, function() return findmaxwanderdistfn(self.inst) end, {minwalktime=0.7,randwalktime=1.5,minwaittime=1.5,randwaittime=6})
    }, .25)
    self.bt = BT(self.inst, root)
end

return SuperprimemateBrain