local yasuo_skills_def = require "yasuo_skills_def"


--<给按键准备的斩钢闪动作,鼠标动作已经和CASTAOE绑定>
local yasuo_steel_tempest = Action({priority = 99, distance = 9999})
yasuo_steel_tempest.str = "斩钢闪"
yasuo_steel_tempest.id = "YASUO_STEEL_TEMPEST"
yasuo_steel_tempest.fn = function (act)
    local pos = act:GetActionPoint()
    if yasuo_skills_def.steel_tempest.canskill(act.doer) then
        local weapon = act.doer.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        yasuo_skills_def.steel_tempest.fn(act.doer, weapon, pos)
        return true
    end
end

AddAction(yasuo_steel_tempest)

AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.YASUO_STEEL_TEMPEST, "yasuo_steel_tempest_pre"))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.YASUO_STEEL_TEMPEST, "yasuo_steel_tempest_pre"))

local yasuo_wind_wall = Action({priority = 99, distance = 9999})
yasuo_wind_wall.str = "风之障壁"
yasuo_wind_wall.id = "YASUO_WIND_WALL"
yasuo_wind_wall.fn = function (act)
    local pos = act:GetActionPoint()
    if yasuo_skills_def.wind_wall.canskill(act.doer) then
        yasuo_skills_def.wind_wall.fn(act.doer, pos)
        return true
    end
end

AddAction(yasuo_wind_wall)

AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.YASUO_WIND_WALL, "yasuo_wind_wall_pre"))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.YASUO_WIND_WALL, "yasuo_wind_wall_pre"))

local yasuo_sweeping_blade = Action({priority = 99, distance = 6})
yasuo_sweeping_blade.str = "踏前斩"
yasuo_sweeping_blade.id = "YASUO_SWEEPING_BLADE"
yasuo_sweeping_blade.fn = function (act)
    local target = act.target
    if yasuo_skills_def.sweeping_blade.canskill(act.doer) then
        if act.doer ~= nil and act.doer.sg ~= nil and act.doer.sg.currentstate.name == "yasuo_sweeping_blade_pre" then
            if act.doer.components.yasuo_skills ~= nil then
                if act.doer.components.yasuo_skills:ShouldDoSpecialSkill("steel_tempest") then
                    act.doer.sg:GoToState("yasuo_sweeping_blade_circle", target)
                else
                    act.doer.sg:GoToState("yasuo_sweeping_blade", target)
                end
                return true
            end
            act.doer.sg:GoToState("idle")
        end
    end
end

AddAction(yasuo_sweeping_blade)

local doskill_way = GetModConfigData("doskill_way")
if doskill_way == "only_mouse" or doskill_way == "all" then
    AddComponentAction("EQUIPPED", "inspectable", function (inst, doer, target, actions, right)
        if right and target and doer ~= target and inst:HasTag("yasuo_sword") and not target:HasTag("yasuo_sweeping_blade")
        and doer.replica.yasuo_skills:CanDoSkill("sweeping_blade")
        then
            table.insert(actions, ACTIONS.YASUO_SWEEPING_BLADE)
        end
    end)
end

AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.YASUO_SWEEPING_BLADE, "yasuo_sweeping_blade_pre"))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.YASUO_SWEEPING_BLADE, "yasuo_sweeping_blade_pre"))

local yasuo_last_breath = Action({priority = 99, distance = 24})
yasuo_last_breath.str = "狂风绝息斩"
yasuo_last_breath.id = "YASUO_LAST_BREATH"
yasuo_last_breath.fn = function (act)
    return yasuo_skills_def.last_breath.canskill(act.doer)
end

AddAction(yasuo_last_breath)

AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.YASUO_LAST_BREATH, "yasuo_last_breath_pre"))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.YASUO_LAST_BREATH, "yasuo_last_breath_pre"))