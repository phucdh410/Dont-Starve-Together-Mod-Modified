local kkr_debuffs_def = {
    {
        prefab = "kkr_speedup",
        name = "Accelerate",
        time = 10,
        OnAttached = function(inst, target)
            inst.entity:SetParent(target.entity)
            target.speedcount = inst.speedcount or 1
            if target.components.locomotor then
                target.components.locomotor:SetExternalSpeedMultiplier(
                    inst,
                    "kkr_speedup",
                    (1 + target.speedcount / 100) or 1
                )
            end

            inst.speedcount = target.speedcount

            if target.speedfx == nil then
                target.speedfx = target:SpawnChild("kkr_speedboost")
            end
        end,
        OnDetached = function(inst, target)
            target.components.talker:Say("The strengthening effect has ended")
            target.speedcount = 0
            if target.components.locomotor then
                target.components.locomotor:RemoveExternalSpeedMultiplier(inst, "kkr_speedup")
            end

            if target.speedfx then
                target.speedfx:Remove()
                target.speedfx = nil
            end
        end,
        OnExtended = function(inst, target)
            if target then
                if target.speedcount == nil then
                    target.speedcount = 1
                elseif target.speedcount and target.speedcount < 30 then
                    target.speedcount = target.speedcount + 1
                end
            end
            if target.components.locomotor then
                target.components.locomotor:SetExternalSpeedMultiplier(
                    inst,
                    "kkr_speedup",
                    (1 + target.speedcount / 100) or 1
                )
            end

            if target.speedfx == nil then
                target.speedfx = target:SpawnChild("kkr_speedboost")
            end

            inst.components.timer:StopTimer("buffover")
            inst.components.timer:StartTimer("buffover", 10)
        end,
        OnSave = function(inst, data)
            data.speedcount = inst.speedcount
        end,
        OnLoad = function(inst, data)
            if data then
                inst.speedcount = data.speedcount
            end
        end,
        OnTimerDone = function(inst, data)
            if data.name == "buffover" then
                local target = inst.entity:GetParent()
                if target then
                    target.components.talker:Say("The strengthening effect has ended")
                    target.speedcount = 0

                    if target.speedfx then
                        target.speedfx:Remove()
                        target.speedfx = nil
                    end
                    if target.components.locomotor then
                        target.components.locomotor:RemoveExternalSpeedMultiplier(inst, "kkr_speedup")
                    end
                end
                inst:Remove()
            end
        end
    },
    {
        prefab = "kkr_increase",
        name = "Aurora Sanctuary",
        time = 20,
        OnAttached = function(inst, target)
            inst.entity:SetParent(target.entity)
            if target and target.components.combat then
                target.components.combat.externaldamagemultipliers:SetModifier("kkr_increase", 1.2)
            end
        end,
        OnDetached = function(inst, target)
            if target and target.components.combat then
                target.components.combat.externaldamagemultipliers:RemoveModifier("kkr_increase")
            end
        end,
        OnExtended = function(inst, target)
            if target and target.components.combat then
                target.components.combat.externaldamagemultipliers:SetModifier("kkr_increase", 1.2)
            end

            inst.components.timer:StopTimer("buffover")
            inst.components.timer:StartTimer("buffover", 20)
        end,
        OnSave = function(inst, data)
        end,
        OnLoad = function(inst, data)
        end,
        OnTimerDone = function(inst, data)
            if data.name == "buffover" then
                local target = inst.entity:GetParent()
                if target then
                    if target.components.combat then
                        target.components.combat.externaldamagemultipliers:RemoveModifier("kkr_increase")
                    end
                end
                inst:Remove()
            end
        end
    },
    {
        prefab = "kkr_kantostyle_stew_debuff",
        name = "The finest dragon tail oden",
        time = 180,
        OnAttached = function(inst, target)
            inst.entity:SetParent(target.entity)
            if target and target.components.health then
                target.components.health.externalabsorbmodifiers:SetModifier(inst, 0.2, "kkr_kantostyle_stew_debuff")
            end
        end,
        OnDetached = function(inst, target)
            if target and target.components.health then
                target.components.health.externalabsorbmodifiers:RemoveModifier(inst, "kkr_kantostyle_stew_debuff")
            end
        end,
        OnExtended = function(inst, target)
            if target and target.components.health then
                target.components.health.externalabsorbmodifiers:SetModifier(inst, 0.2, "kkr_kantostyle_stew_debuff")
            end

            inst.components.timer:StopTimer("buffover")
            inst.components.timer:StartTimer("buffover", 180)
        end,
        OnSave = function(inst, data)
        end,
        OnLoad = function(inst, data)
        end,
        OnTimerDone = function(inst, data)
            if data.name == "buffover" then
                local target = inst.entity:GetParent()
                if target then
                    if target.components.health then
                        target.components.health.externalabsorbmodifiers:RemoveModifier(
                            inst,
                            "kkr_kantostyle_stew_debuff"
                        )
                    end
                end
                inst:Remove()
            end
        end
    },
    {
        prefab = "kkr_sea_snowsugar_debuff",
        name = "Sea Snowsugar",
        time = 640,
        OnAttached = function(inst, target)
            inst.entity:SetParent(target.entity)
            if target then
                if not target:HasTag("sea_snowsugar") then
                    target:AddTag("sea_snowsugar")
                end
                if target.components.inventory then
                    target.components.inventory.isexternallyinsulated:SetModifier(inst, true)
                end
            end
        end,
        OnDetached = function(inst, target)
            if target then
                if target:HasTag("sea_snowsugar") then
                    target:RemoveTag("sea_snowsugar")
                end
                if target.components.inventory then
                    target.components.inventory.isexternallyinsulated:RemoveModifier(inst, true)
                end
            end
        end,
        OnExtended = function(inst, target)
            if target then
                if not target:HasTag("sea_snowsugar") then
                    target:AddTag("sea_snowsugar")
                end
                if target.components.inventory then
                    target.components.inventory.isexternallyinsulated:SetModifier(inst, true)
                end
            end

            inst.components.timer:StopTimer("buffover")
            inst.components.timer:StartTimer("buffover", 180)
        end,
        OnSave = function(inst, data)
        end,
        OnLoad = function(inst, data)
        end,
        OnTimerDone = function(inst, data)
            if data.name == "buffover" then
                local target = inst.entity:GetParent()
                if target then
                    if target:HasTag("sea_snowsugar") then
                        target:RemoveTag("sea_snowsugar")
                    end
                    if target.components.inventory then
                        target.components.inventory.isexternallyinsulated:RemoveModifier(inst, true)
                    end
                end
                inst:Remove()
            end
        end
    }
}

local function MakekkrBuffs(data)
    local function fn()
        local inst = CreateEntity()

        if data.tags then
            for _, v in ipairs(data.tags) do
                inst:AddTag(v)
            end
        end
        if not TheWorld.ismastersim then
            inst:DoTaskInTime(0, inst.Remove)
            return inst
        end

        inst.entity:AddTransform()

        inst.entity:Hide()
        inst.persists = false

        inst:AddTag("CLASSIFIED")

        inst:AddComponent("debuff")
        inst.components.debuff:SetAttachedFn(data.OnAttached)
        inst.components.debuff:SetDetachedFn(data.OnDetached)
        inst.components.debuff:SetExtendedFn(data.OnExtended)
        inst.components.debuff.keepondespawn = true
        inst:AddComponent("timer")
        if inst:HasTag("indefinite") then
            inst.components.timer:StartTimer("---", data.time)
        else
            inst.components.timer:StartTimer("buffover", data.time)
            inst:ListenForEvent("timerdone", data.OnTimerDone)
        end
        inst.OnSave = data.OnSave
        inst.OnPreLoad = data.OnLoad
        return inst
    end

    return Prefab(data.prefab, fn)
end

local kkr_debuffs = {}
for _, v in ipairs(kkr_debuffs_def) do
    STRINGS.NAMES[string.upper(v.prefab)] = v.name
    table.insert(kkr_debuffs, MakekkrBuffs(v))
end
return unpack(kkr_debuffs)
