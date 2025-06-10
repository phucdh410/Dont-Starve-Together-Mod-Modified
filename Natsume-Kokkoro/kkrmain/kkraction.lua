local KKRSEW = Action()
KKRSEW.id = "KKRSEW"
KKRSEW.str = "Repair"
KKRSEW.priority = 999

KKRSEW.fn = function(act) 
    if act.target ~= nil and
        act.invobject ~= nil and
        act.target.components.armor ~= nil and
        act.target:HasTag("kkr_sewing") and
        act.invobject.components.sewing ~= nil then
        return act.invobject.components.sewing:DoSewing(act.target, act.doer)
    end
end
AddAction(KKRSEW)
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
