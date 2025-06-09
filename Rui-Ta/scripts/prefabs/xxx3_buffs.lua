-------------------------------------------------------------------------
---------------------- Attach and dettach functions ---------------------
-------------------------------------------------------------------------

local function chydg_attach(inst, target)
    if target.components.health ~= nil then
        target.components.health.externalabsorbmodifiers:SetModifier(inst, 0.9)
    end
end

local function chydg_detach(inst, target)
    if target.components.health ~= nil then
        target.components.health.externalabsorbmodifiers:RemoveModifier(inst)
    end
end

-------------------------------------------------------------------------
----------------------- Prefab building functions -----------------------
-------------------------------------------------------------------------

local function OnTimerDone(inst, data)
    if data.name == 'buffover' then
        inst.components.debuff:Stop()
    end
end

local function MakeBuff(name, onattachedfn, onextendedfn, ondetachedfn, duration)
    local function OnAttached(inst, target)
        inst.entity:SetParent(target.entity)
        inst.Transform:SetPosition(0, 0, 0) --in case of loading
        inst:ListenForEvent(
            'death',
            function()
                inst.components.debuff:Stop()
            end,
            target
        )

        if onattachedfn ~= nil then
            onattachedfn(inst, target)
        end
    end

    local function OnExtended(inst, target)
        if duration ~= nil then
            inst.components.timer:StopTimer('buffover')
            inst.components.timer:StartTimer('buffover', duration)
        end

        if onextendedfn ~= nil then
            onextendedfn(inst, target)
        end
    end

    local function OnDetached(inst, target)
        if ondetachedfn ~= nil then
            ondetachedfn(inst, target)
        end

        inst:Remove()
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

        inst:AddTag('CLASSIFIED')

        inst:AddComponent('debuff')
        inst.components.debuff:SetAttachedFn(OnAttached)
        inst.components.debuff:SetDetachedFn(OnDetached)
        inst.components.debuff:SetExtendedFn(OnExtended)
        inst.components.debuff.keepondespawn = true

        if duration ~= nil then
            inst:AddComponent('timer')
            inst.components.timer:StartTimer('buffover', duration)
            inst:ListenForEvent('timerdone', OnTimerDone)
        end

        return inst
    end

    return Prefab('buff_' .. name, fn, nil)
end

return MakeBuff('xxx3_chydg', chydg_attach, nil, chydg_detach, 30)
