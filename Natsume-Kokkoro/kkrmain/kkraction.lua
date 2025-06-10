local KKRSEW = Action()--添加一个动作
KKRSEW.id = "KKRSEW"--声明动作的id，全局唯一，不可重复
KKRSEW.str = "修补"--动作的名称
KKRSEW.priority = 999

KKRSEW.fn = function(act) --定义动作的函数 
    if act.target ~= nil and
        act.invobject ~= nil and
        act.target.components.armor ~= nil and
        act.target:HasTag("kkr_sewing") and
        act.invobject.components.sewing ~= nil then
        return act.invobject.components.sewing:DoSewing(act.target, act.doer)
    end
end
AddAction(KKRSEW)--添加自定义的动作到动作表中
AddComponentAction("USEITEM", "sewing", function(inst, doer, target, actions, right)
    if target:HasTag("kkr_sewing") and
                not (doer.replica.rider ~= nil and doer.replica.rider:IsRiding() and
                not (target.replica.inventoryitem ~= nil 
                and target.replica.inventoryitem:IsGrandOwner(doer))) then
                table.insert(actions, ACTIONS.KKRSEW)
    end
end)

AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(ACTIONS.KKRSEW, "dolongaction"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(ACTIONS.KKRSEW, "dolongaction"))
