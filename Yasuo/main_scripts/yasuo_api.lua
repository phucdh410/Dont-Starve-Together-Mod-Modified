local function yasuo_run_way(sg)
    local run = sg.states.run
    if run then
        local onupdate = run.onupdate
        run.onupdate = function (inst, ...)

            if not inst.sg.statemem.normalwonkey and inst.components.locomotor:GetTimeMoving() >= 1 then
                if inst.components.yasuo_skills then
                    inst.components.yasuo_skills:StartRegenWay()
                end
            end
            if onupdate then
                onupdate(inst, ...)
            end
        end
    end

    local old_castaoe = sg.actionhandlers[ACTIONS.CASTAOE].deststate
    sg.actionhandlers[ACTIONS.CASTAOE].deststate = function(inst, action)
        if action.invobject ~= nil and action.invobject.yasuo_aoespellsg ~= nil then
            return action.invobject:yasuo_aoespellsg(inst, action)
        end
        return old_castaoe(inst, action)
    end
end

AddStategraphPostInit("wilson", yasuo_run_way)
AddStategraphPostInit("wilson_client", yasuo_run_way)


AddComponentPostInit("combat", function (self)
    local GetAttacked = self.GetAttacked
    function self:GetAttacked(attacker, damage, ...)
        if self.inst.components.yasuo_skills and self.inst.components.yasuo_skills:IsFullWay() then
            self.inst.components.yasuo_skills:SpawnShield()
            return
        else
            return GetAttacked(self, attacker, damage, ...)
        end
    end
end)