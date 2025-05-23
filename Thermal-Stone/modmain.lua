local Ingredient = GLOBAL.Ingredient
local TECH = GLOBAL.TECH


AddRecipe2("superhot_thermal_stone",
    { Ingredient("heatrock", 1), Ingredient("redgem", 1), Ingredient("charcoal", 5) },
    TECH.SCIENCE_TWO,
    { product = "heatrock" },
    { "TOOLS" }
)

AddRecipe2("supercold_thermal_stone",
    { Ingredient("heatrock", 1), Ingredient("bluegem", 1), Ingredient("ice", 5) },
    TECH.SCIENCE_TWO,
    { product = "heatrock" },
    { "TOOLS" }
)

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

local function AddSuperTag(inst, tag)
    if inst and inst.components.inventoryitem then
        inst:AddTag(tag)
    end
end

AddPrefabPostInit("heatrock", function (inst)
    if not GLOBAL.TheWorld.ismastersim then
        return
    end

    inst:ListenForEvent("onbuilt", function(inst, data)
        if data and data.recipe == "superhot_thermal_stone" then
            AddSuperTag(inst, "superhot")
        elseif data and data.recipe == "supercold_thermal_stone" then
            AddSuperTag(inst, "supercold")
        end
    end)

    -- Removes the old temperaturedelta EventListener function
    inst.event_listeners["temperaturedelta"] = {}
    -- Alter the TemperatureChange(inst, data) function
    inst:ListenForEvent("temperaturedelta", function (inst, data)
        if inst:HasTag("superhot") then
            if inst.components.temperature:GetCurrent() ~= 60 then
                inst.components.temperature:SetTemperature(60)
            end
            return -- stop further processing
        elseif inst:HasTag("supercold") then
            if inst.components.temperature:GetCurrent() ~= -30 then
                inst.components.temperature:SetTemperature(-30)
            end
            return -- stop further processing
        end
       
        local ambient_temp = GLOBAL.TheWorld.state.temperature
        local cur_temp = inst.components.temperature:GetCurrent()
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
