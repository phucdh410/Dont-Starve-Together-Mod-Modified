
local BUTTON_REPEAT_COOLDOWN = .5

local function GetBufferedAction(inst, action, position, target)
    local bufferedaction
    if position ~= nil then
        inst:ForceFacePoint(position:Get())
    end

    bufferedaction = BufferedAction(inst, target, action, nil, position)

    return bufferedaction
end

local function OnRemoteActionButton(player, actioncode, position, target, isreleased, noforce, mod_name)
    local self = player.components.playercontroller
    if self.ismastersim and self:IsEnabled() and self.handler == nil then
        self.remote_controls[CONTROL_ACTION] = 0
        local action
        SetClientRequestedAction(actioncode, mod_name)
        for k, _action in pairs(ACTIONS) do
            if _action.code == actioncode and _action.mod_name == mod_name and string.find(_action.id, "YASUO") then
                action = GetBufferedAction(player, _action, position, target)
            end
        end
        ClearClientRequestedAction()

        if action ~= nil then
            if action.action.canforce and not noforce then
                action:SetActionPoint(self:GetRemotePredictPosition() or self.inst:GetPosition())
                action.forced = true
            end
            self.locomotor:PushAction(action, true)
        end
        if isreleased then
            self.remote_controls[CONTROL_ACTION] = nil
        end
    end
end

AddModRPCHandler(YASUO_MOD_RPCNAME, "skill_rpc", function (player, actioncode, x, z, target, isreleased, noforce, mod_name)
    if not (optnumber(actioncode) and
                optentity(target) and
                optbool(isreleased) and
                optbool(noforce) and
                optstring(mod_name)) then
            return
        end
    local playercontroller = player.components.playercontroller
    if playercontroller ~= nil then
        OnRemoteActionButton(player, actioncode, x ~= nil and Vector3(x, 0, z) or nil, target, isreleased, noforce, mod_name)
    end
end)

local function RemoteActionButton(inst, action, isreleased)
    local self = inst.components.playercontroller
    local actioncode = action ~= nil and action.action.code or nil
    local action_mod_name = action ~= nil and action.action.mod_name or nil
    local position = action ~= nil and action:GetActionPoint() or nil
    local target = action ~= nil and action.target or nil
    local noforce = self.locomotor == nil and action ~= nil and action.action.canforce or nil
    self.remote_controls[CONTROL_ACTION] = action ~= nil and BUTTON_REPEAT_COOLDOWN or 0
    if position ~= nil then
        inst:ForceFacePoint(position:Get())
    end
    SendModRPCToServer(MOD_RPC[YASUO_MOD_RPCNAME]["skill_rpc"], actioncode, position ~= nil and position.x or nil, position ~= nil and position.z or nil, target, isreleased, noforce, action_mod_name)
end

local function DoActionButton(inst, buffaction)
    if buffaction ~= nil then
        local self = inst.components.playercontroller
        if self.placer == nil then
            if buffaction ~= nil then
                if self.ismastersim then
                    self.locomotor:PushAction(buffaction, true)
                    return
                elseif self.locomotor == nil then
                    if buffaction.action.pre_action_cb ~= nil then
                        buffaction.action.pre_action_cb(buffaction)
                    end
                    RemoteActionButton(inst, buffaction)
                    return
                elseif self:CanLocomote() then
                    if buffaction.action ~= ACTIONS.WALKTO then
                        buffaction.preview_cb = function()
                            RemoteActionButton(inst, buffaction)
                        end
                    end
                    self.locomotor:PreviewAction(buffaction, true)
                end
            end
        elseif self.placer.components.placer.can_build and
            self.inst.replica.builder ~= nil and
            not self.inst.replica.builder:IsBusy() then
            --do the placement
            self.inst.replica.builder:MakeRecipeAtPoint(self.placer_recipe,
                self.placer.components.placer.override_build_point_fn ~= nil and self.placer.components.placer.override_build_point_fn(self.placer) or self.placer:GetPosition(),
                self.placer:GetRotation(), self.placer_recipe_skin)
        elseif self.placer.components.placer.onfailedplacement ~= nil then
            self.placer.components.placer.onfailedplacement(self.inst, self.placer)
        end

        if not self.ismastersim and self.remote_controls[CONTROL_ACTION] == nil then
            RemoteActionButton(inst)
        end
    end
end

return DoActionButton