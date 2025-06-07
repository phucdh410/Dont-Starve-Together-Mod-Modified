
local yasuo_skills =
{
    way_of_wander =
        {
            description = "亚索在移动的同时会积攒剑意，当剑意槽被充满时，在受到任意伤害的同时，".."\n"..
            "会生成一个用于抵消伤害的护盾，护盾值等于剑意值。".."\n"..
            "每次攻击可以立刻获得3点剑意值，使用一次【踏前斩】可以立刻获得5点剑意值。",
            order = 1,
        },
    steel_tempest =
        {
            description = "鼠标右键释放。向鼠标方向出剑，造成武器伤害x2倍的伤害，".."\n"..
            "在命中时，斩钢闪获得一层旋风烈斩的效果，持续8秒。".."\n"..
            "在积攒两层旋风烈斩的效果后，斩钢闪会形成一阵能够击飞敌人的旋风。",
            order = 2,
            canskill = function (inst)
                return inst.components.yasuo_skills and inst.components.yasuo_skills:CanDoSkill("steel_tempest")
            end,
            damage = function (inst)
                local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
                return weapon and weapon.components.weapon.damage * YASUO.SKILLS.STEEL_TEMPEST.DAMAGEMULTIPLIER or 0
            end,
            cd = YASUO.SKILLS.STEEL_TEMPEST.CD,
            fn = function (inst, weapon, pos)
                local function steel_tempest_fn()
                    if weapon == nil then
                        return false
                    end
                    local steel_tempest_fx = SpawnPrefab("shadowstrike_slash_fx")
                    if steel_tempest_fx.AnimState then
                        steel_tempest_fx.AnimState:SetBuild("yasuo_shadow_lunge_fx")
                    end
                    steel_tempest_fx.entity:AddFollower()
                    steel_tempest_fx.Follower:FollowSymbol(inst.GUID, "swap_object", 0, -200, 0)
                    steel_tempest_fx.Transform:SetScale(1.6, 1.6, 1.6)
                    local x1, y1, z1 = inst.Transform:GetWorldPosition()
                    local angle = inst:GetAngleToPoint(pos:Get()) * DEGREES
                    for i = 1, 5 do
                        local damage = CreateEntity()
                        damage.entity:AddTransform()
                        damage:AddTag("steel_tempest_damage")
                        local dist = i * 1
                        local newpos = Vector3(x1 + math.cos(angle) * dist, 0, z1 - math.sin(angle) * dist)
                        local x2, y2, z2 = newpos:Get()
                        damage.Transform:SetPosition(newpos:Get())
                        local ents = TheSim:FindEntities(x2, y2, z2, 1, {"_combat", "_health"}, {"steel_tempest_damage", "FX", "INLIMBO", "DECOR", "player"})
                        if ents ~= nil then
                            for _, ent in pairs(ents) do
                                if ent.components.combat and ent ~= inst and not inst.components.yasuo_skills.steel_tempest_hited_targets[ent] then
                                    local dmg = inst.components.yasuo_skills.skills["steel_tempest"].damage(inst)
                                    ent.components.combat:GetAttacked(inst, dmg)
                                    inst.components.yasuo_skills.steel_tempest_hited_targets[ent] = true
                                end
                            end
                        end
                    end
                    if GetTableSize(inst.components.yasuo_skills.steel_tempest_hited_targets) > 0 then
                        inst.components.yasuo_skills:AddSkillHit("steel_tempest", 1)
                    end
                    inst.components.yasuo_skills:DoSkill("steel_tempest")
                    weapon.components.rechargeable:Discharge(inst.components.yasuo_skills.skills["steel_tempest"].cd)
                    return true
                end

                local function steel_tempest_tornado_fn()
                    if weapon == nil then
                        return false
                    end
                    inst.sg.mem.tornado = SpawnPrefab("yasuo_tornado")
                    inst.sg.mem.tornado.Transform:SetPosition(inst.Transform:GetWorldPosition())
                    inst.sg.mem.tornado:ForceFacePoint(pos:Get())
                    inst.sg.mem.tornado.Physics:SetMotorVel(25, 0, 0)
                    inst.sg.mem.tornado.CASTER = inst
                    inst.sg.mem.tornado.CASTER_ISPLAYER = inst:HasTag("player")

                    inst.components.yasuo_skills:DoSkill("steel_tempest")
                    inst.components.yasuo_skills:ClearSkillHit("steel_tempest")
                    weapon.components.rechargeable:Discharge(inst.components.yasuo_skills.skills["steel_tempest"].cd)
                    return true
                end

                local function Lunge()
                    if inst.components.yasuo_skills:ShouldDoSpecialSkill("steel_tempest") then
                        return steel_tempest_tornado_fn()
                    else
                        return steel_tempest_fn()
                    end
                end

                if weapon ~= nil and pos ~= nil then
                    Lunge()
                end
            end
        },
    wind_wall =
        {
            description = "默认X键释放。形成一个持续10秒的气流之墙，可以阻挡任意飞行道具。",
            order = 3,
            canskill = function (inst)
                return inst.components.yasuo_skills and inst.components.yasuo_skills:CanDoSkill("wind_wall")
            end,
            sustain = YASUO.SKILLS.WIND_WALL.SUSTAIN,
            cd = YASUO.SKILLS.WIND_WALL.CD,
            fn = function (inst, pos)
                if pos ~= nil then
                    inst:ForceFacePoint(pos:Get())
                end
                local x, y, z = inst.Transform:GetWorldPosition()
                local dist = 4
                local angle = inst.Transform:GetRotation() * DEGREES
                local x1 = x + dist * math.cos(angle)
                local z1 = z - dist * math.sin(angle)
                local wind_wall = SpawnPrefab("yasuo_wind_wall")
                wind_wall.Transform:SetPosition(x1, 0.2, z1)
                wind_wall.Transform:SetRotation(inst.Transform:GetRotation())
                wind_wall:SetDestoryTime(inst.components.yasuo_skills.skills["wind_wall"].sustain)
                inst.components.yasuo_skills:DoSkill("wind_wall")
            end
        },
    sweeping_blade =
        {
            description = "鼠标选中目标释放或默认G键对鼠标附近的目标释放。".."\n"..
            "向目标突进，在4秒内无法对相同的目标释放。".."\n"..
            "在积攒两层旋风烈斩的效果后，如果踏前斩释放时，斩钢闪冷却完毕，则踏前斩会呈环状出剑，击飞自身周围的敌人。",
            order = 4,
            canskill = function (inst)
                return inst.components.yasuo_skills and inst.components.yasuo_skills:CanDoSkill("sweeping_blade")
            end,
            damage = function (_inst)
                local weapon = _inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
                return weapon and weapon.components.weapon.damage * YASUO.SKILLS.SWEEPING_BLADE.DAMAGEMULTIPLIER or 0
            end,
            cd = YASUO.SKILLS.SWEEPING_BLADE.CD,
            cd_enemy = YASUO.SKILLS.SWEEPING_BLADE.CD_ENEMY,
        },
    last_breath =
        {
            description = "默认R键释放。闪烁到一个被击飞的敌人身边。".."\n"..
            "造成武器伤害x5倍的伤害，并使敌人周围（包括敌人）击飞的效果延长。".."\n"..
            "获得满额的剑意值，但是会重置旋风烈斩的层数。".."\n"..
            "在接下来的15秒内，亚索的普通攻击伤害将提升至150%。",
            order = 5,
            canskill = function (inst)
                return inst.components.yasuo_skills and inst.components.yasuo_skills:CanDoSkill("last_breath")
            end,
            damage = function (_inst)
                local weapon = _inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
                return weapon and weapon.components.weapon.damage * YASUO.SKILLS.LAST_BREATH.DAMAGE or 0
            end,
            sustain = YASUO.SKILLS.LAST_BREATH.SUSTAIN,
            damagemultiplier = YASUO.SKILLS.LAST_BREATH.DAMAGEMULTIPLIER,
            cd = YASUO.SKILLS.LAST_BREATH.CD,
        }
}

return yasuo_skills