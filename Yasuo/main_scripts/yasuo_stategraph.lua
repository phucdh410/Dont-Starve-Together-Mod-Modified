local yasuo_sound = GetModConfigData("yasuo_sound")
local yasuo_skills_def = require "yasuo_skills_def"

local function ToggleOffPhysics(inst)
    inst.sg.statemem.isphysicstoggle = true
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.GROUND)
    inst.Physics:CollidesWith(COLLISION.WORLD)
end

local function ToggleOnPhysics(inst)
    inst.sg.statemem.isphysicstoggle = nil
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.WORLD)
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)
    inst.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
    inst.Physics:CollidesWith(COLLISION.CHARACTERS)
    inst.Physics:CollidesWith(COLLISION.GIANTS)
end

local steel_tempest_pre = State{
    name = "yasuo_steel_tempest_pre",
    tags = { "doing", "busy", "yasuo_skill", "yasuo_steel_tempest" },
    onenter = function (inst)
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("steel_tempest_pre")
        if not inst.components.yasuo_skills:ShouldDoSpecialSkill("steel_tempest") then
            local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if weapon ~= nil then
                weapon.SoundEmitter:PlaySound("yasuo/yasuo_sfx/steel_tempest_hit")
            end
        else
            if yasuo_sound then
                inst.SoundEmitter:PlaySound("yasuo/yasuo_sfx/steel_tempest_tornado_sound")
            end
        end
    end,

    events = {
        EventHandler("animover", function (inst)
            inst:PerformBufferedAction()
            if inst.components.yasuo_skills:ShouldDoSpecialSkill("steel_tempest") then
                inst.sg:GoToState("yasuo_steel_tempest_tornado")
            else
                inst.sg:GoToState("yasuo_steel_tempest")
            end
        end)
    },
}

local steel_tempest = State{
    name = "yasuo_steel_tempest",
    tags = { "doing", "busy", "yasuo_skill", "yasuo_steel_tempest" },
    onenter = function (inst)
        inst.components.locomotor:Stop()
        inst.Transform:SetEightFaced()
        inst.AnimState:PlayAnimation("steel_tempest_loop")
    end,

    events = {
        EventHandler("animover", function (inst)
            inst.sg:GoToState("yasuo_steel_tempest_pst")
        end)
    },

    onexit = function(inst)
        inst.Transform:SetFourFaced()
    end,
}

local steel_tempest_tornado = State{
    name = "yasuo_steel_tempest_tornado",
    tags = { "doing", "busy", "yasuo_skill", "yasuo_steel_tempest_tornado" },
    onenter = function (inst)
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("steel_tempest_tornado_loop")
    end,

    events = {
        EventHandler("animover", function (inst)
            inst.sg:GoToState("yasuo_steel_tempest_tornado_pst")
        end)
    },
}

local steel_tempest_tornado_pst = State{
    name = "yasuo_steel_tempest_tornado_pst",
    tags = { "doing", "busy", "yasuo_skill", "yasuo_steel_tempest_tornado" },
    onenter = function (inst)
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("steel_tempest_tornado_pst")
    end,

    events = {
        EventHandler("animover", function (inst)
            inst.sg:GoToState("idle")
        end)
    },
}

local steel_tempest_pst = State{
    name = "yasuo_steel_tempest_pst",
    tags = { "doing", "busy", "yasuo_skill", "yasuo_steel_tempest" },
    onenter = function (inst)
        inst.components.locomotor:Stop()
        inst.Transform:SetEightFaced()
        inst.AnimState:PlayAnimation("steel_tempest_pst")
    end,

    events = {
        EventHandler("animover", function (inst)
            inst.sg:GoToState("idle")
        end)
    },

    onexit = function(inst)
        inst.Transform:SetFourFaced()
    end,
}

local steel_tempest_pre_client = State{
    name = "yasuo_steel_tempest_pre",
    tags = {"busy", "yasuo_skill", "yasuo_steel_tempest"},
    server_states = { "yasuo_steel_tempest_pre", "yasuo_steel_tempest", "yasuo_steel_tempest_tornado" },

    onenter = function(inst)
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("steel_tempest_pre")
        inst.AnimState:PushAnimation("steel_tempest_loop", false)

        inst:PerformPreviewBufferedAction()
        inst.sg:SetTimeout(2)
    end,

    onupdate = function(inst)
        if inst.sg:ServerStateMatches() then
            if inst.entity:FlattenMovementPrediction() then
                inst.sg:GoToState("idle", "noanim")
            end
        elseif inst.bufferedaction == nil then
            inst.sg:GoToState("idle")
        end
    end,

    ontimeout = function(inst)
        inst:ClearBufferedAction()
        inst.sg:GoToState("idle")
    end,
}

AddStategraphState("wilson", steel_tempest_pre)
AddStategraphState("wilson", steel_tempest)
AddStategraphState("wilson", steel_tempest_tornado)
AddStategraphState("wilson", steel_tempest_pst)
AddStategraphState("wilson", steel_tempest_tornado_pst)
AddStategraphState("wilson_client", steel_tempest_pre_client)

local wind_wall_pre = State{
    name = "yasuo_wind_wall_pre",
    tags = { "doing", "busy", "yasuo_skill", "yasuo_wind_wall" },
    onenter = function (inst)
        inst.components.locomotor:Stop()
        local buffaction = inst:GetBufferedAction()
        if buffaction ~= nil then
            if buffaction.pos ~= nil then
                inst:ForceFacePoint(buffaction:GetActionPoint():Get())
            end
        end
        inst.AnimState:PlayAnimation("wind_wall_pre")
        local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        if weapon ~= nil then
            weapon.SoundEmitter:PlaySound("yasuo/yasuo_sfx/wind_wall")
        end
        if yasuo_sound then
            inst.SoundEmitter:PlaySound("yasuo/yasuo_sfx/wind_wall_sound")
        end
    end,

    events = {
        EventHandler("animover", function (inst)
            inst:PerformBufferedAction()
            inst.sg:GoToState("yasuo_wind_wall")
        end)
    }
}

local wind_wall = State{
    name = "yasuo_wind_wall",
    tags = { "doing", "busy", "yasuo_skill", "yasuo_wind_wall" },
    onenter = function (inst)
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("wind_wall_loop")
    end,

    events = {
        EventHandler("animover", function (inst)
            inst.sg:GoToState("yasuo_wind_wall_pst")
        end)
    }
}

local wind_wall_pst = State{
    name = "yasuo_wind_wall_pst",
    tags = { "doing", "busy", "yasuo_skill", "yasuo_wind_wall" },
    onenter = function (inst)
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("wind_wall_pst")
    end,

    events = {
        EventHandler("animover", function (inst)
            inst.sg:GoToState("idle")
        end)
    },
}

local wind_wall_pre_client = State{
    name = "yasuo_wind_wall_pre",
    tags = { "doing", "busy", "yasuo_skill", "yasuo_wind_wall" },
    server_states = { "yasuo_wind_wall_pre", "yasuo_wind_wall" },

    onenter = function(inst)
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("wind_wall_pre")
        inst.AnimState:PushAnimation("wind_wall_loop", false)

        inst:PerformPreviewBufferedAction()
        inst.sg:SetTimeout(2)
    end,

    onupdate = function(inst)
        if inst.sg:ServerStateMatches() then
            if inst.entity:FlattenMovementPrediction() then
                inst.sg:GoToState("idle", "noanim")
            end
        elseif inst.bufferedaction == nil then
            inst.sg:GoToState("idle")
        end
    end,

    ontimeout = function(inst)
        inst:ClearBufferedAction()
        inst.sg:GoToState("idle")
    end,
}

AddStategraphState("wilson", wind_wall_pre)
AddStategraphState("wilson", wind_wall)
AddStategraphState("wilson", wind_wall_pst)
AddStategraphState("wilson_client", wind_wall_pre_client)

local function SpawnShadow_sweeping(inst)
    inst.sg.statemem.shadow_sweeping_task = inst:DoPeriodicTask(0, function ()
        inst:DoTaskInTime(0, function ()
            local shadow = SpawnPrefab(inst.prefab)
            RemovePhysicsColliders(shadow)
            shadow.AnimState:SetMultColour(1, 1, 1, 0.3)
            shadow.Transform:SetRotation(inst.Transform:GetRotation())
            shadow.Transform:SetPosition(inst.Transform:GetWorldPosition())
            shadow.AnimState:PlayAnimation("sweeping_blade_loop")
            shadow.AnimState:SetFrame(inst.AnimState:GetCurrentAnimationTime() * 30)
            shadow:AddTag("yasuo_shadow")
            shadow:DoPeriodicTask(0, function ()
                local scale = shadow.Transform:GetScale()
                shadow.Transform:SetScale(0.97 * scale, 0.97 * scale, 0.97 * scale)
                shadow.Transform:SetRotation(inst.Transform:GetRotation())
            end)
            shadow:DoTaskInTime(5 * FRAMES, shadow.Remove)
        end)
    end)
end

local function SpawnPing(inst, attacker)
    inst:AddTag("yasuo_sweeping_blade")
    inst:DoTaskInTime(attacker.components.yasuo_skills.skills["sweeping_blade"].cd_enemy, function ()
        if inst.yasuo_sweeping_blade_ping then
            inst.yasuo_sweeping_blade_ping:KillFX()
            inst.yasuo_sweeping_blade_ping = nil
        end
        inst:RemoveTag("yasuo_sweeping_blade")
    end)

    inst.yasuo_sweeping_blade_ping = inst:SpawnChild("deerclops_icelance_ping_fx")
    inst.yasuo_sweeping_blade_ping.Transform:SetScale(0.5, 0.5, 0.5)
end

local WORK_ACTIONS =
{
    CHOP = true,
    DIG = true,
    HAMMER = true,
    MINE = true,
}
local TARGET_TAGS = { "_combat" }
for k, v in pairs(WORK_ACTIONS) do
    table.insert(TARGET_TAGS, k.."_workable")
end

local TARGET_IGNORE_TAGS = { "INLIMBO", "yasuo_shadow", "wall" }

local function EnableControl(inst, enable)
    if enable then
        inst:RestartBrain()
        if inst.AnimState then
            inst.AnimState:Resume()
        end
    else
        inst:StopBrain()
        if inst.AnimState then
            inst.AnimState:Pause()
        end
    end
end

local function BeKnocked(attacker, inst)
    attacker.components.yasuo_skills.sweeping_blade_circle_knocked[inst] = true
    inst:AddTag("yasuo_tornado_knocked")

    local y_speed = 0.5
    local oldx, oldy, oldz = inst.Transform:GetWorldPosition()

    EnableControl(inst, false)

    if inst.yasuo_knocked_task ~= nil then
        inst.yasuo_knocked_task:Cancel()
    end

    inst.yasuo_knocked_task = inst:DoPeriodicTask(0, function ()
        local x, y, z = inst.Transform:GetWorldPosition()
        if y >= oldy + 5 and y_speed > 0 then
            y_speed = -y_speed
        end

        if y <= oldy + 0.2 and y_speed < 0 then
            inst:RemoveTag("yasuo_tornado_knocked")
            attacker.components.yasuo_skills.sweeping_blade_circle_targets[inst] = nil
            attacker.components.yasuo_skills.sweeping_blade_circle_knocked[inst] = nil
            inst.Transform:SetPosition(x, 0, z)
            if inst.yasuo_knocked_task ~= nil then
                inst.yasuo_knocked_task:Cancel()
                inst.yasuo_knocked_task = nil
            end
            EnableControl(inst, true)
        else
            inst.Transform:SetPosition(x, y + y_speed, z)
        end
    end)
end

local function DoKnock(inst, v)
    if v.Physics ~= nil and v.Transform ~= nil and v ~= inst and not inst.components.yasuo_skills.sweeping_blade_circle_knocked[v] then
        BeKnocked(inst, v)
    end
end

local function KnockOther(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, y, z, 4, nil, TARGET_IGNORE_TAGS, TARGET_TAGS)
    for i, v in ipairs(ents) do
        if v ~= inst and v:IsValid() then
            if v.components.health ~= nil and
                not v.components.health:IsDead() and
                v.components.combat ~= nil and
                v.components.combat:CanBeAttacked() and
                (TheNet:GetPVPEnabled() or not v:HasTag("player"))
                and not inst.components.yasuo_skills.sweeping_blade_circle_targets[v] then
                local damage = inst.components.yasuo_skills.skills["steel_tempest"].damage(inst)
                v.components.combat:GetAttacked(inst, damage, nil, "yasuo_tornado")
                inst.components.yasuo_skills.sweeping_blade_circle_targets[v] = true
                DoKnock(inst, v)
            end
        end
    end
end

local function Sweeping_Blade_Circle_Atk(inst)
    local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    if weapon ~= nil then
        weapon.components.rechargeable:Discharge(inst.components.yasuo_skills.skills["steel_tempest"].cd)
        if not inst.sweeping_blade_circle_task then
            inst.sweeping_blade_circle_task = inst:DoPeriodicTask(0, KnockOther)
        end
        inst.components.yasuo_skills:DoSkill("steel_tempest")
        inst.components.yasuo_skills:ClearSkillHit("steel_tempest")
    end
end

local sweeping_blade_pre = State{
    name = "yasuo_sweeping_blade_pre",
    tags = { "doing", "busy", "yasuo_skill", "yasuo_sweeping_blade" },
    onenter = function (inst)
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("sweeping_blade_pre")
        inst.SoundEmitter:PlaySound("yasuo/yasuo_sfx/sweeping_blade")
    end,

    events =
    {
        EventHandler("animover", function(inst)
            if inst.AnimState:AnimDone() then
                if inst.bufferedaction ~= nil then
                    inst:PerformBufferedAction()
                else
                    inst.sg:GoToState("idle")
                end
            end
        end),
    },
}

local sweeping_blade = State{
    name = "yasuo_sweeping_blade",
    tags = { "doing", "busy", "yasuo_skill", "yasuo_sweeping_blade", "autopredict", "nomorph" },
    onenter = function (inst, target)
        if target == nil or not target:IsValid() then
            inst.sg:GoToState("idle")
            return
        end

        ToggleOffPhysics(inst)
        inst.components.locomotor:Stop()

        inst.AnimState:PlayAnimation("sweeping_blade_loop", false)

        local pos = target:GetPosition()
        if pos ~= nil then
            inst:ForceFacePoint(pos:Get())
        end

        inst.components.yasuo_skills:DoSkill("sweeping_blade", target)
        --SpawnShadow_sweeping(inst)
        inst:EnableWobySprintTrail(true)
        SpawnPing(target, inst)

        inst.sg.statemem.speed = 25
        inst.Physics:SetMotorVel(inst.sg.statemem.speed, 0, 0)
    end,

    timeline = {
        FrameEvent(7, function (inst)
            inst.Physics:Stop()
        end)
    },

    events = {
        EventHandler("animover", function (inst)
            if inst.AnimState:AnimDone() then
                inst.sg:GoToState("yasuo_sweeping_blade_pst")
            end
        end)
    },

    onexit = function (inst)
        ToggleOnPhysics(inst)
        if inst.sg.statemem.shadow_sweeping_task then
            inst.sg.statemem.shadow_sweeping_task:Cancel()
            inst.sg.statemem.shadow_sweeping_task = nil
        end
        if inst.EnableWobySprintTrail then
            inst:EnableWobySprintTrail(false)
        end
    end
}

local sweeping_blade_circle = State{
    name = "yasuo_sweeping_blade_circle",
    tags = { "doing", "busy", "yasuo_skill", "yasuo_sweeping_blade", "autopredict", "nomorph" },
    onenter = function (inst, target)
        if target == nil or not target:IsValid() then
            inst.sg:GoToState("idle")
            return
        end

        ToggleOffPhysics(inst)
        inst.components.locomotor:Stop()

        inst.AnimState:PlayAnimation("sweeping_blade_circle", false)

        local pos = target:GetPosition()
        if pos ~= nil then
            inst:ForceFacePoint(pos:Get())
        end

        inst.components.yasuo_skills:DoSkill("sweeping_blade", target)

        --SpawnShadow_sweeping(inst)
        inst:EnableWobySprintTrail(true)
        SpawnPing(target, inst)
        Sweeping_Blade_Circle_Atk(inst)
        inst:SpawnChild("yasuo_sweeping_blade_fx")

        inst.sg.statemem.speed = 25
        inst.Physics:SetMotorVel(inst.sg.statemem.speed, 0, 0)

    end,

    timeline = {
        FrameEvent(7, function (inst)
            inst.Physics:Stop()
        end)
    },

    events = {
        EventHandler("animover", function (inst)
            if inst.AnimState:AnimDone() then
                inst.sg:GoToState("yasuo_sweeping_blade_pst")
            end
        end)
    },

    onexit = function (inst)
        if inst.sweeping_blade_circle_task then
            inst.sweeping_blade_circle_task:Cancel()
            inst.sweeping_blade_circle_task = nil
        end
        if inst.sg.statemem.shadow_sweeping_task then
            inst.sg.statemem.shadow_sweeping_task:Cancel()
            inst.sg.statemem.shadow_sweeping_task = nil
        end
        ToggleOnPhysics(inst)
        inst.Physics:Stop()
        if inst.EnableWobySprintTrail then
            inst:EnableWobySprintTrail(false)
        end
    end
}

local sweeping_blade_pst = State{
    name = "yasuo_sweeping_blade_pst",
    tags = { "doing", "busy", "yasuo_skill", "yasuo_sweeping_blade" },
    onenter = function (inst)
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("sweeping_blade_pst")
    end,

    events = {
        EventHandler("animover", function (inst)
            inst.sg:GoToState("idle")
        end)
    },
}

local sweeping_blade_pre_client = State{
    name = "yasuo_sweeping_blade_pre",
    tags = { "doing", "busy", "yasuo_skill", "yasuo_sweeping_blade" },
    server_states = { "yasuo_sweeping_blade_pre", "yasuo_sweeping_blade", "yasuo_sweeping_blade_circle" },

    onenter = function(inst)
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("sweeping_blade_pre")
        inst.AnimState:PushAnimation("sweeping_blade_loop", false)
        inst:EnableWobySprintTrail(true)
        inst:PerformPreviewBufferedAction()
        inst.sg:SetTimeout(2)
    end,

    onupdate = function(inst)
        if inst.sg:ServerStateMatches() then
            if inst.entity:FlattenMovementPrediction() then
                inst.sg:GoToState("idle", "noanim")
            end
        elseif inst.bufferedaction == nil then
            inst.sg:GoToState("idle")
        end
    end,

    ontimeout = function(inst)
        inst:ClearBufferedAction()
        inst.sg:GoToState("idle")
    end,

    onexit = function (inst)
        if inst.EnableWobySprintTrail then
            inst:EnableWobySprintTrail(false)
        end
    end
}

AddStategraphState("wilson", sweeping_blade_pre)
AddStategraphState("wilson", sweeping_blade)
AddStategraphState("wilson", sweeping_blade_circle)
AddStategraphState("wilson", sweeping_blade_pst)
AddStategraphState("wilson_client", sweeping_blade_pre_client)

local function SpawnShadow(inst, target)
    inst.yasuo_shadow = SpawnPrefab(inst.prefab)
    inst.yasuo_shadow.Transform:SetRotation(inst.Transform:GetRotation())
    inst.yasuo_shadow.Transform:SetPosition(inst.Transform:GetWorldPosition())
    local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    if weapon ~= nil then
        local prefab = weapon.prefab
        inst.yasuo_shadow.AnimState:OverrideSymbol("swap_object", "swap_"..prefab, "swap_"..prefab)
    end
    inst.yasuo_shadow.AnimState:PlayAnimation("sweeping_blade_loop")
    inst.yasuo_shadow.AnimState:Show("ARM_carry")
    inst.yasuo_shadow.AnimState:Hide("ARM_normal")

    if target and target:IsValid() then
        local dist = inst:GetDistanceSqToInst(target)
        inst.yasuo_shadow.AnimState:SetMultColour(1, 1, 1, 0.2)
        inst.yasuo_shadow.Physics:SetMotorVel(15 * dist / 30, 0, 0)
        inst.yasuo_shadow.Physics:ClearCollisionMask()
        inst.yasuo_shadow:DoPeriodicTask(0, function ()
            if target and target:IsValid() then
                if inst.yasuo_shadow:GetDistanceSqToInst(target) < 1 * 1 then
                    inst.yasuo_shadow:Remove()
                end
            end
        end)
    end

    inst.yasuo_shadow:DoTaskInTime(0.6, inst.yasuo_shadow.Remove)
end

local function Doknock(inst, attacker)
    table.insert(attacker.last_breath_targets, inst)
    EnableControl(inst, false)
    if inst.yasuo_knocked_task ~= nil then
        inst.yasuo_knocked_task:Cancel()
    end

    inst.yasuo_knocked_task = inst:DoPeriodicTask(0, function ()
        local x1, y1, z1 = attacker.Transform:GetWorldPosition()
        local my_x, my_y, my_z = inst.Transform:GetWorldPosition()
        inst.Transform:SetPosition(my_x, y1, my_z)
    end)
end

local function Knocked(inst, attacker)
    local x, y, z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, y, z, 4, { "yasuo_tornado_knocked" })
    attacker.last_breath_targets = {}
    Doknock(inst, attacker)
    for _, ent in pairs(ents) do
        Doknock(ent, attacker)
    end
end

local function Fall(attacker)
    if attacker.last_breath_targets ~= nil then
        for _, ent in pairs(attacker.last_breath_targets) do
            if ent.yasuo_knocked_task then
                ent.yasuo_knocked_task:Cancel()
                ent.yasuo_knocked_task = nil
            end
            local x, y, z = ent.Transform:GetWorldPosition()
            ent.Transform:SetPosition(x, 0, z)
            EnableControl(ent, true)
        end
    end
end

local function DamageRecover(inst)
    inst.AnimState:OverrideSymbol("swap_object", "swap_yasuo_sword", "swap_yasuo_sword")
    inst.components.combat.externaldamagemultipliers:RemoveModifier(inst, "last_breath")
    inst.in_last_breath_damageup = nil
    local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    if weapon and weapon.StopShine ~= nil then
        weapon:StopShine()
    end
end

local function DamageUp(inst)
    local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    if weapon and weapon.Shine ~= nil then
        weapon:Shine()
    end
    inst.AnimState:OverrideSymbol("swap_object", "swap_yasuo_sword_shine", "swap_yasuo_sword_shine")

    inst.components.combat.externaldamagemultipliers:SetModifier(inst, inst.components.yasuo_skills.skills["last_breath"].damagemultiplier, "last_breath")
    inst.in_last_breath_damageup = true
    inst:DoTaskInTime(inst.components.yasuo_skills.skills["last_breath"].sustain, DamageRecover)
end

local function DoAreaAttack(inst, target, range)
    local x, y, z = target.Transform:GetWorldPosition()
    local damage = inst.components.yasuo_skills.skills["last_breath"].damage(inst)
    local ents = TheSim:FindEntities(x, y, z, range, { "_combat" }, { "INLIMBO", "player" })
    for _, ent in pairs(ents) do
        if ent ~= inst then
            ent.components.combat:GetAttacked(inst, damage)
        end
    end
    DamageUp(inst)
end

local last_breath_pre = State{
    name = "yasuo_last_breath_pre",
    tags = {"busy", "yasuo_skill", "yasuo_last_breath"},
    onenter = function (inst)
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("sweeping_blade_pre")
        local bufferedaction = inst:GetBufferedAction()
        if bufferedaction ~= nil and bufferedaction.target ~= nil then
            inst.sg.statemem.target = bufferedaction.target
            inst:ForceFacePoint(inst.sg.statemem.target.Transform:GetWorldPosition())
            SpawnShadow(inst, inst.sg.statemem.target)
        end
    end,

    timeline = {
        FrameEvent(3, function (inst)
            inst:Hide()
        end)
    },

    events = {
        EventHandler("animover", function (inst)
            if inst.AnimState:AnimDone() then
                inst.sg:GoToState("yasuo_last_breath", inst.sg.statemem.target)
            end
        end)
    }
}

local last_breath = State{
    name = "yasuo_last_breath",
    tags = {"busy", "yasuo_skill", "yasuo_last_breath", "invincible", "nopredict"},
    onenter = function (inst, target)
        inst.components.locomotor:Stop()
        inst:Show()
        inst.AnimState:SetFinalOffset(99)
        inst.AnimState:PlayAnimation("last_breath")
        inst.Physics:Teleport(target.Transform:GetWorldPosition())
        inst.sg.statemem.target = target
        inst.sg.statemem.old_invincible = inst.components.health.invincible
        inst.components.health:SetInvincible(true)

        local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        if weapon ~= nil then
            weapon.SoundEmitter:PlaySound("yasuo/yasuo_sfx/last_breath_s")
        end
        inst.components.yasuo_skills:DoSkill("last_breath")
    end,

    timeline = {
        FrameEvent(3, function (inst)
            if yasuo_sound then
                inst.SoundEmitter:PlaySound("yasuo/yasuo_sfx/last_breath_sound")
            end
        end),
        FrameEvent(5, function (inst)
            inst.Physics:SetMotorVel(0, 30, 0)
            if not inst.sg.statemem.target.components.health:IsDead() then
                Knocked(inst.sg.statemem.target, inst)
            end
        end),
        FrameEvent(10, function (inst)
            inst.Physics:SetMotorVel(0, 0, 0)
        end),
        FrameEvent(35, function (inst)
            local x, y, z = inst.Transform:GetWorldPosition()
            inst.Transform:SetPosition(x, 0, z)
            inst.Physics:Stop()
        end),
        FrameEvent(36, function (inst)
            if not inst.sg.statemem.target.components.health:IsDead() then
                Fall(inst)
            end
        end),
        FrameEvent(37, function (inst)
            local fx = SpawnPrefab("firering_fx")
            fx.Transform:SetScale(0.7, 0.7, 0.7)
            fx.Transform:SetPosition(inst.sg.statemem.target.Transform:GetWorldPosition())

            DoAreaAttack(inst, inst.sg.statemem.target, 4)
            ShakeAllCameras(CAMERASHAKE.SIDE, .5, .05, .1, inst, 40)

            inst.components.yasuo_skills:FillWay()
        end),
        FrameEvent(39, function (inst)
            SpawnPrefab("superjump_fx").Transform:SetPosition(inst.sg.statemem.target.Transform:GetWorldPosition())
        end)
    },

    events = {
        EventHandler("animover", function (inst)
            inst.sg:GoToState("yasuo_last_breath_pst")
        end)
    },

    onexit = function (inst)
        if not inst.sg.statemem.old_invincible then
            inst.components.health:SetInvincible(false)
        end
        inst.AnimState:SetFinalOffset(0)
    end
}

local last_breath_pst = State{
    name = "yasuo_last_breath_pst",
    tags = { "busy", "yasuo_skill", "yasuo_last_breath", "nopredict"},
    onenter = function (inst)
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("sweeping_blade_pst")
    end,

    events = {
        EventHandler("animover", function (inst)
            inst.sg:GoToState("idle")
        end)
    }
}

local last_breath_pre_client = State{
    name = "yasuo_last_breath_pre",
    tags = {"busy", "yasuo_skill", "yasuo_last_breath"},
    server_states = {"yasuo_last_breath_pre"},

    onenter = function(inst)
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("sweeping_blade_pre")
        inst.AnimState:PushAnimation("sweeping_blade_loop", false)

        inst:PerformPreviewBufferedAction()
        inst.sg:SetTimeout(2)
    end,

    onupdate = function(inst)
        if inst.sg:ServerStateMatches() then
            if inst.entity:FlattenMovementPrediction() then
                inst.sg:GoToState("idle", "noanim")
            end
        elseif inst.bufferedaction == nil then
            inst.sg:GoToState("idle")
        end
    end,

    ontimeout = function(inst)
        inst:ClearBufferedAction()
        inst.sg:GoToState("idle")
    end,
}

AddStategraphState("wilson", last_breath_pre)
AddStategraphState("wilson", last_breath)
AddStategraphState("wilson", last_breath_pst)
AddStategraphState("wilson_client", last_breath_pre_client)
