local function OnTick(inst, target)
    local pos = target:GetPosition()
    local radius = target:GetPhysicsRadius(0) + .7 + math.random() * .5
    local angle = math.random() * 2 * PI
    local x = pos.x + radius * math.cos(angle)
    local z = pos.z - radius * math.sin(angle)

    local fx = SpawnPrefab("bile_splash")
    fx.Transform:SetPosition(x, 0, z)

    if TheWorld.Map:IsAboveGroundAtPoint(x, 0, z) then   
        SpawnPrefab("butterfly").Transform:SetPosition(x, 0, z)
        target.components.talker:Say("飞舞吧!")
    end
end

local function OnAttached(inst, target)
    inst.entity:SetParent(target.entity)
    inst.Transform:SetPosition(0, 0, 0) --in case of loading
    inst.task = inst:DoPeriodicTask(4, OnTick, nil, target)
    inst:ListenForEvent("death", function()
        inst.components.debuff:Stop()
    end, target)
end

local function OnTimerDone(inst, data)
    if data.name == "regenover" then
        inst.components.debuff:Stop()
    end
end

local function OnExtended(inst, target)
    inst.components.timer:StopTimer("regenover")
    inst.components.timer:StartTimer("regenover", TUNING.JELLYBEAN_DURATION)
    inst.task:Cancel()
    inst.task = inst:DoPeriodicTask(4, OnTick, nil, target)
end

local function fn()
    local inst = CreateEntity()

    if not TheWorld.ismastersim then
        --Not meant for client!
        inst:DoTaskInTime(0, inst.Remove)

        return inst
    end

    inst.entity:AddTransform()

    --[[Non-networked entity]]
    --inst.entity:SetCanSleep(false)
    inst.entity:Hide()
    inst.persists = false

    inst:AddTag("CLASSIFIED")

    inst:AddComponent("debuff")
    inst.components.debuff:SetAttachedFn(OnAttached)
    inst.components.debuff:SetDetachedFn(inst.Remove)
    inst.components.debuff:SetExtendedFn(OnExtended)
    inst.components.debuff.keepondespawn = true

    inst:AddComponent("timer")
    inst.components.timer:StartTimer("regenover", TUNING.JELLYBEAN_DURATION)
    inst:ListenForEvent("timerdone", OnTimerDone)

    return inst
end

return Prefab("xxx3_butterflybuff", fn)
