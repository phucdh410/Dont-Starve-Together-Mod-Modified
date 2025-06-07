local function OnHitDirty(inst)
    inst:PushEvent("steel_tempest_hit_delta", inst.replica.yasuo_skills.steel_tempest_hit:value())
end

local function SpecialSkill(inst)
    local weapon = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    if weapon and weapon.components.aoetargeting then
        weapon.components.aoetargeting.reticule.reticuleprefab = "reticulelongmulti"
        weapon.components.aoetargeting.reticule.pingprefab = "reticulelongmultiping"
    end
end

local function DontSpecialSkill(inst)
    local weapon = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    if weapon and weapon.components.aoetargeting then
        weapon.components.aoetargeting.reticule.reticuleprefab = "reticuleline"
        weapon.components.aoetargeting.reticule.pingprefab = "reticulelineping"
    end
end

local function OnSkillCd(inst)
    inst:PushEvent("skills_cd_start")
end

local Yasuo_Skills = Class(function (self, inst)
    self.inst = inst
    self.steel_tempest_hit = net_ushortint(inst.GUID, "yasuo_skills.steel_tempest_hit", "steel_tempest_hitdirty")
    self.steel_tempest_maxhit = net_ushortint(inst.GUID, "yasuo_skills.steel_tempest_maxhit", "steel_tempest_maxhitdirty")
    self.should_steel_tempest_tornado = net_event(inst.GUID, "yasuo_skills.should_steel_tempest_tornado")
    self.shouldnot_steel_tempest_tornado = net_event(inst.GUID, "yasuo_skills.shouldnot_steel_tempest_tornado")

    self.way_of_wander = net_ushortint(inst.GUID, "yasuo_skills.way_of_wander", "way_of_wanderdirty")
    self.way_of_wander_max = net_ushortint(inst.GUID, "yasuo_skills.way_of_wander_max", "way_of_wander_maxdirty")

    self.skills_cd = net_string(inst.GUID, "yasuo_skills.skills_cd", "skills_cddirty")

    self.inst:ListenForEvent("steel_tempest_hitdirty", OnHitDirty)
    self.inst:ListenForEvent("yasuo_skills.should_steel_tempest_tornado", SpecialSkill)
    self.inst:ListenForEvent("yasuo_skills.shouldnot_steel_tempest_tornado", DontSpecialSkill)
    self.inst:ListenForEvent("skills_cddirty", OnSkillCd)

    self.steel_tempest_hit:set(0)
    self.steel_tempest_maxhit:set(0)
    self.way_of_wander:set(100)
    self.way_of_wander_max:set(100)
end)

function Yasuo_Skills:ShouldDoSpecialSkill(skill)
    return self[skill.."_hit"]:value() == self[skill.."_maxhit"]:value()
end

function Yasuo_Skills:GetSkillCdLeft(skill)
    if self.skills_cd:value() ~= "" then
        local skills_cd = json.decode(self.skills_cd:value())
        return skills_cd[skill]
    end
    return nil
end

function Yasuo_Skills:CanDoSkill(skill)
    return self:GetSkillCdLeft(skill) == nil
end


return Yasuo_Skills