local steel_tempest_key =  GetModConfigData("steel_tempest_key") or KEY_Z
local wind_wall_key = GetModConfigData("wind_wall_key") or KEY_X
local sweeping_blade_key = GetModConfigData("sweeping_blade_key") or KEY_G
local last_breath_key = GetModConfigData("last_breath_key") or KEY_R

_G.YASUO_MOD_RPCNAME = "yasuo"
local DoActionButton = require "yasuo_doactions"

TheInput:AddKeyHandler(function (key, down)
    local doskill_way = GetModConfigData("doskill_way")
    if doskill_way == "only_mouse" then
        return
    end
    if TheNet:IsServerPaused() then
        return
    end
    if ThePlayer == nil or not ThePlayer.components.playercontroller:IsEnabled() then
        return
    end
    if key == steel_tempest_key and down then
        local pos = TheInput:GetWorldPosition()
        local weapon = ThePlayer.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        if not (ThePlayer.replica.rider and ThePlayer.replica.rider:IsRiding()) and weapon ~= nil and weapon:HasTag("yasuo_sword")
        and ThePlayer.replica.yasuo_skills ~= nil and ThePlayer.replica.yasuo_skills:CanDoSkill("steel_tempest") then
            DoActionButton(ThePlayer, BufferedAction(ThePlayer, nil, ACTIONS.YASUO_STEEL_TEMPEST, weapon, pos))
        end
    end
end)

TheInput:AddKeyHandler(function (key, down)
    local doskill_way = GetModConfigData("doskill_way")
    if doskill_way == "only_mouse" then
        return
    end
    if TheNet:IsServerPaused() then
        return
    end
    if ThePlayer == nil or not ThePlayer.components.playercontroller:IsEnabled() then
        return
    end
    if key == wind_wall_key and down then
        local pos = TheInput:GetWorldPosition()
        local weapon = ThePlayer.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        if not (ThePlayer.replica.rider and ThePlayer.replica.rider:IsRiding()) and weapon ~= nil and weapon:HasTag("yasuo_sword")
        and ThePlayer.replica.yasuo_skills ~= nil and ThePlayer.replica.yasuo_skills:CanDoSkill("wind_wall") then
            DoActionButton(ThePlayer, BufferedAction(ThePlayer, nil, ACTIONS.YASUO_WIND_WALL, weapon, pos))
        end
    end
end)

local function FindClosest(inst, x, y, z, radius, ignoreheight, musttags, canttags, mustoneoftags, fn)
    local ents = TheSim:FindEntities(x, ignoreheight and 0 or y, z, radius, musttags, canttags, mustoneoftags)
    local closestEntity = nil
    local rangesq = radius * radius
    for i, v in ipairs(ents) do
        if v ~= inst and v:IsValid() and (not IsEntityDeadOrGhost(v)) and v.entity:IsVisible() and (fn == nil or fn(v, inst)) then
            local distsq = v:GetDistanceSqToPoint(x, y, z)
            if distsq < rangesq then
                rangesq = distsq
                closestEntity = v
            end
        end
    end
    return closestEntity, closestEntity ~= nil and rangesq or nil
end

TheInput:AddKeyHandler(function (key, down)
    local doskill_way = GetModConfigData("doskill_way")
    if doskill_way == "only_mouse" then
        return
    end
    if TheNet:IsServerPaused() then
        return
    end
    if ThePlayer == nil or not ThePlayer.components.playercontroller:IsEnabled() then
        return
    end
    if key == sweeping_blade_key and down then
        local x, y, z = TheInput:GetWorldPosition():Get()
        local target = FindClosest(ThePlayer, x, 0, z, 3, true, nil, {"yasuo_sweeping_blade", "FX", "DECOR", "yasuo_shadow"})
        local weapon = ThePlayer.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        if target ~= nil and not (ThePlayer.replica.rider and ThePlayer.replica.rider:IsRiding()) and weapon ~= nil and weapon:HasTag("yasuo_sword")
        and ThePlayer.replica.yasuo_skills ~= nil and ThePlayer.replica.yasuo_skills:CanDoSkill("sweeping_blade") then
            DoActionButton(ThePlayer, BufferedAction(ThePlayer, target, ACTIONS.YASUO_SWEEPING_BLADE, weapon))
        end
    end
end)

TheInput:AddKeyHandler(function (key, down)
    local doskill_way = GetModConfigData("doskill_way")
    if doskill_way == "only_mouse" then
        return
    end
    if TheNet:IsServerPaused() then
        return
    end
    if ThePlayer == nil or not ThePlayer.components.playercontroller:IsEnabled() then
        return
    end
    if key == last_breath_key and down then
        local target = FindEntity(ThePlayer, 24, nil, {"yasuo_tornado_knocked"})
        local weapon = ThePlayer.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        if target ~= nil and not (ThePlayer.replica.rider and ThePlayer.replica.rider:IsRiding()) and weapon ~= nil and weapon:HasTag("yasuo_sword")
        and ThePlayer.replica.yasuo_skills ~= nil and ThePlayer.replica.yasuo_skills:CanDoSkill("last_breath") then
            DoActionButton(ThePlayer, BufferedAction(ThePlayer, target, ACTIONS.YASUO_LAST_BREATH, weapon))
        end
    end
end)