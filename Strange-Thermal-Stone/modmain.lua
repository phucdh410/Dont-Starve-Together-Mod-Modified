relative_temperature_thresholds = { -30, -10, 10, 30 }

function GetRangeForTemperature(temp, ambient)
    local range = 1
    for i,v in ipairs(relative_temperature_thresholds) do
        if temp > ambient + v then
            range = range + 1
        end
    end
    return range
end

function UpdateImages(inst, range)
    inst.currentTempRange = range

    inst.AnimState:PlayAnimation(tostring(range), true)

    local skinname = inst:GetSkinName()
    inst.components.inventoryitem:ChangeImageName((skinname or "heat_rock")..tostring(range))
    if range == 5 then
        inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
        inst._light.Light:Enable(true)
    else
        inst.AnimState:ClearBloomEffectHandle()
        inst._light.Light:Enable(false)
    end
end

function AdjustLighting(inst, range, ambient)
    if range == 5 then
        local relativetemp = inst.components.temperature:GetCurrent() - ambient
        local baseline = relativetemp - relative_temperature_thresholds[4]
        local brightline = relative_temperature_thresholds[4] + 20
        inst._light.Light:SetIntensity( math.clamp(0.5 * baseline/brightline, 0, 0.5 ) )
    else
        inst._light.Light:SetIntensity(0)
    end
end

local max_threshold = 35
local min_threshold = -20

local max_temperature = 80
local min_temperature = -40

AddPrefabPostInit("heatrock", function (inst)
    if not GLOBAL.TheWorld.ismastersim then
        return
    end

    -- Removes the old temperaturedelta EventListener function
    inst.event_listeners["temperaturedelta"] = {}
    -- Alter the TemperatureChange(inst, data) function
    inst:ListenForEvent("temperaturedelta", function (inst, data)
        -- //TODO: add tag and change examine description
        -- if inst:HasTag("superhot") or inst:HasTag("supercold") then
        --     return
        -- end
        local ambient_temp = GLOBAL.TheWorld.state.temperature
        local cur_temp = inst.components.temperature:GetCurrent()
        if cur_temp >= max_threshold then
            inst.components.temperature.current = max_temperature
            -- inst.AddTag("superhot")
        elseif cur_temp <= min_threshold then
            inst.components.temperature.current = min_temperature
            -- inst.AddTag("supercold")
        end

        local range = GetRangeForTemperature(cur_temp, ambient_temp)

        AdjustLighting(inst, range, ambient_temp)

        if range <= 1 then
            if inst.lowTemp == nil or inst.lowTemp > cur_temp then
                inst.lowTemp = math.floor(cur_temp)
            end
            inst.highTemp = nil
        elseif range >= 5 then
            if inst.highTemp == nil or inst.highTemp < cur_temp then
                inst.highTemp = math.ceil(cur_temp)
            end
            inst.lowTemp = nil
        elseif inst.lowTemp ~= nil then
            if GetRangeForTemperature(inst.lowTemp, ambient_temp) >= 3 then
                inst.lowTemp = nil
            end
        elseif inst.highTemp ~= nil and GetRangeForTemperature(inst.highTemp, ambient_temp) <= 3 then
            inst.highTemp = nil
        end

        if range ~= inst.currentTempRange then
            UpdateImages(inst, range)

            if (inst.lowTemp ~= nil and range >= 3) or
                (inst.highTemp ~= nil and range <= 3) then
                inst.lowTemp = nil
                inst.highTemp = nil
                --inst.components.fueled:SetPercent(inst.components.fueled:GetPercent() - 1 / TUNING.HEATROCK_NUMUSES)
            end
        end
    end)

    inst.currentTempRange = 0

    if inst and inst.components and inst.components.fueled then
        inst:RemoveComponent("fueled")
    end
end)
