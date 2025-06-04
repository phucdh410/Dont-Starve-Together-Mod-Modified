
--<打开Screen动作>
AddAction("EA_POPUP_SCREEN", STRINGS.ACTIONS.EA_POPUP_SCREEN, function(act)
    if act.target and act.target:IsValid() then
		local popupscreen = act.target.components.ea_popupscreen
		if popupscreen then
			return popupscreen:Show(act.doer)
		end
    end
	return false
end)
STRINGS.ACTIONS.EA_POPUP_SCREEN = STRINGS.ACTIONS.EA_POPUP_SCREEN_OVERRIDE
--为EA_POPUP_SCREEN行为的目标配置ea_popupscreen_action_strid属性，可以改变行为的显示文本
ACTIONS.EA_POPUP_SCREEN.strfn = function(act)
    return act.target ~= nil and act.target.ea_popupscreen_action_strid or nil
end
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.EA_POPUP_SCREEN, "doshortaction"))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.EA_POPUP_SCREEN, "doshortaction"))

AddComponentAction("SCENE", "ea_popupscreen", function(inst, doer, actions, right)
	if right then
		table.insert(actions, ACTIONS.EA_POPUP_SCREEN)
	end
end)


-- 启动肥料制造机
AddAction("TUNRON_FERTILIZER_MACHINE", STRINGS.ACTIONS.TUNRON_FERTILIZER_MACHINE, function (act)
	if act.target.components.ea_fertilizer_machine then
		act.target.components.ea_fertilizer_machine:Produce()
		return true
	end
	return false
end)
AddComponentAction("USEITEM", "ea_fertilizer_machine", function (inst, doer, target, actions)
    if not target:HasTag("burnt") and target.replica.container ~= nil and not target.replica.container:IsEmpty() then
        table.insert(actions, ACTIONS.TUNRON_FERTILIZER_MACHINE)
    end
end)
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.TUNRON_FERTILIZER_MACHINE, "domediumaction"))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.TUNRON_FERTILIZER_MACHINE, "domediumaction"))