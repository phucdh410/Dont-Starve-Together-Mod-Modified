local function onsteel_tempest_hit(self, hit)
    if self.inst.replica.yasuo_skills and self.inst.replica.yasuo_skills.steel_tempest_hit then
        self.inst.replica.yasuo_skills.steel_tempest_hit:set(hit)
        if hit >= 2 then
            self.inst.replica.yasuo_skills.should_steel_tempest_tornado:push()
        else
            self.inst.replica.yasuo_skills.shouldnot_steel_tempest_tornado:push()
        end
    end
end

local function onsteel_tempest_maxhit(self, hit)
    if self.inst.replica.yasuo_skills and self.inst.replica.yasuo_skills.steel_tempest_maxhit then
        self.inst.replica.yasuo_skills.steel_tempest_maxhit:set(hit)
    end
end

local function onway_of_wander(self, way)
    if self.inst.replica.yasuo_skills and self.inst.replica.yasuo_skills.way_of_wander then
        self.inst.replica.yasuo_skills.way_of_wander:set(way)
    end
end

local function onway_of_wander_max(self, way)
    if self.inst.replica.yasuo_skills and self.inst.replica.yasuo_skills.way_of_wander_max then
        self.inst.replica.yasuo_skills.way_of_wander_max:set(way)
    end
end

local function OnTimerDone(inst, data)
    local self = inst.components.yasuo_skills
    for name, def in pairs(self.skills) do
        if name.."_cd" == data.name then
            self.skills_cd[name] = nil
            self:PushEvent()
        end
    end
end

local yasuo_skills_def = require("yasuo_skills_def")
local Yasuo_Skills = Class(function (self, inst)
    self.inst = inst
    self.steel_tempest_hit = 0
    self.steel_tempest_maxhit = 2
    self.steel_tempest_hit_droptime = 8
    self.way_of_wander = 100
    self.way_of_wander_max = 100
    self.shieldprefab = "yasuo_shield"
    self.regen =
    {
        amount = YASUO.WAY_OF_WANDER_REGEN_AMOUNT,
        period = YASUO.WAY_OF_WANDER_REGEN_PERIOD
    }
    self.skills = yasuo_skills_def
    self.skills_cd = {}
    self.sweeping_blade_targets = {}
    self.sweeping_blade_circle_targets = {}
    self.sweeping_blade_circle_knocked = {}
    self.steel_tempest_hited_targets = {}

    self.inst:ListenForEvent("timerdone", OnTimerDone)

    self.inst:StartUpdatingComponent(self)
end, nil,
{
    steel_tempest_hit = onsteel_tempest_hit,
    steel_tempest_maxhit = onsteel_tempest_maxhit,
    way_of_wander = onway_of_wander,
    way_of_wander_max = onway_of_wander_max,
})

function Yasuo_Skills:PushEvent()
    local str = json.encode(self.skills_cd)
    if self.inst.replica.yasuo_skills and self.inst.replica.yasuo_skills.skills_cd then
        self.inst.replica.yasuo_skills.skills_cd:set(str)
    end
end

local function DropSkillHit(inst, self, skill)
    self[skill.."_hit"] = math.max(self[skill.."_hit"] - 1, 0)
    if self.wind_circle_task then
        self.wind_circle_task:Cancel()
        self.wind_circle_task = nil
    end
    self.inst.SoundEmitter:KillSound("steel_tempest_secondhit")
    self.inst.SoundEmitter:KillSound("steel_tempest_can_tornado")
end

function Yasuo_Skills:AddSkillHit(skill, hit)
    self[skill.."_hit"] = math.min(self[skill.."_hit"] + hit, self[skill.."_maxhit"])
    if self.drop_task then
        self.drop_task:Cancel()
        self.drop_task = nil
    end

    if self[skill.."_hit"] == self[skill.."_maxhit"] then
        self:SpawnWindFlow()
        if self.inst.replica.yasuo_skills.should_steel_tempest_tornado then
            self.inst.replica.yasuo_skills.should_steel_tempest_tornado:push()
        end
    end
    self.drop_task = self.inst:DoPeriodicTask(self.steel_tempest_hit_droptime, DropSkillHit, nil, self, "steel_tempest")
    self.steel_tempest_hited_targets = {}
end

function Yasuo_Skills:SpawnWindFlow()
    self.inst.SoundEmitter:PlaySound("yasuo/yasuo_sfx/steel_tempest_secondhit", "steel_tempest_secondhit")
    self.inst:DoTaskInTime(2, function ()
        self.inst.SoundEmitter:KillSound("steel_tempest_secondhit")
        self.inst.SoundEmitter:PlaySound("yasuo/yasuo_sfx/steel_tempest_can_tornado", "steel_tempest_can_tornado")
    end)
    self.wind_circle_task = self.inst:DoPeriodicTask(15 * FRAMES, function ()
        local fx = SpawnPrefab("yasuo_steel_tempest_flow")
        fx.entity:SetParent(self.inst.entity)
    end, 0)
end

function Yasuo_Skills:ClearSkillHit(skill)
    self[skill.."_hit"] = 0
    if self.wind_circle_task then
        self.wind_circle_task:Cancel()
        self.wind_circle_task = nil
    end
    self.inst.SoundEmitter:KillSound("steel_tempest_secondhit")
    self.inst.SoundEmitter:KillSound("steel_tempest_can_tornado")
end

function Yasuo_Skills:GetSkillCdLeft(skill)
    return self.inst.components.timer:GetTimeLeft(skill.."_cd")
end

function Yasuo_Skills:CanDoSkill(skill, target)
    if self.skills[skill] == nil then
        return false
    end
    if self.skills_cd[skill] ~= nil and self:GetSkillCdLeft(skill) ~= nil then
        return false
    end
    if skill == "sweeping_blade" and target ~= nil then
        if self.sweeping_blade_targets[target] then
            return false
        end
    end
    return true
end

function Yasuo_Skills:DoSkill(skill, target)
    self.skills_cd[skill] = self.skills[skill].cd
    self.inst.components.timer:StartTimer(skill.."_cd", self.skills[skill].cd)
    if skill == "sweeping_blade" and target ~= nil then
        self:UseWay(-5)
        self.sweeping_blade_targets[target] = true

        self.inst:DoTaskInTime(self.skills[skill].cd_enemy, function ()
            self.sweeping_blade_targets[target] = nil
        end)
    end
end

local function DoRegenWay(inst, self)
    self.way_of_wander = math.min(self.way_of_wander + self.regen.amount, self.way_of_wander_max)
end

function Yasuo_Skills:StartRegenWay()
    if not self.regen.task then
        self.regen.task = self.inst:DoPeriodicTask(self.regen.period, DoRegenWay, nil, self)
    end
end

function Yasuo_Skills:StopRegenWay()
    if self.regen.task then
        self.regen.task:Cancel()
        self.regen.task = nil
    end
end

function Yasuo_Skills:UseWay(way)
    self.way_of_wander = math.max(self.way_of_wander - way, 0)
    self.way_of_wander = math.min(self.way_of_wander, self.way_of_wander_max)
end

function Yasuo_Skills:FillWay()
    self.way_of_wander = self.way_of_wander_max
end

function Yasuo_Skills:ShouldDoSpecialSkill(skill)
    return self[skill.."_hit"] == self[skill.."_maxhit"]
end

function Yasuo_Skills:IsFullWay()
    return self.way_of_wander == self.way_of_wander_max
end

function Yasuo_Skills:SpawnShield()
    self.shield = SpawnPrefab(self.shieldprefab)
    self.shield.Transform:SetPosition(self.inst.Transform:GetWorldPosition())
    self.shield:SetOwner(self.inst)
    self:UseWay(self.way_of_wander_max)
end

function Yasuo_Skills:OnSave()
    local data = {}
    data.way_of_wander = self.way_of_wander
    data.way_of_wander_max = self.way_of_wander_max
    data.skills_cd = {}
    for skill, cd in pairs(self.skills_cd) do
        data.skills_cd[skill] = cd
    end
    return data
end

function Yasuo_Skills:OnLoad(data)
    if data and data.way_of_wander then
        self.way_of_wander = data.way_of_wander
    end
    if data and data.way_of_wander_max then
        self.way_of_wander_max = data.way_of_wander_max
    end
    if data and data.skills_cd then
        for skill, cd in pairs(data.skills_cd) do
            self.skills_cd[skill] = cd
            self:PushEvent()
        end
    end
end

function Yasuo_Skills:OnUpdate(dt)
    for skill, cd in pairs(self.skills_cd) do
        self.skills_cd[skill] = self:GetSkillCdLeft(skill)
            self:PushEvent()
    end
end

return Yasuo_Skills