local function ShouldAcceptItem(inst, item)
    if item.prefab == 'xxx3_bf' then
        return true
    end
    return false
end

local function OnGetItemFromPlayer(inst, giver, item)
    inst.components.perishable:AddTime(TUNING.PERISH_FAST)
end

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol('swap_hat', inst.prefab, 'swap_hat')
    owner.AnimState:Show('HAT')
    owner.AnimState:Show('HAT_HAIR')
    owner:AddTag('eyeplant_friend')
    if inst.prefab == 'xxx3_summerhat' and owner.components.health ~= nil then
        owner.components.health.externalfiredamagemultipliers:SetModifier(inst, 0)
    end

    if inst.prefab == 'xxx3_lunarhat' then
        if inst._light == nil then
            inst._light = {}
            local fx = SpawnPrefab('alterguardianhatlight')
            fx.Light:SetColour(180 / 255, 195 / 255, 150 / 255)
            fx.Light:Enable(true)
            fx.entity:SetParent(owner.entity)
            table.insert(inst._light, fx)
        end
    end
end

local function onunequip(inst, owner)
    owner.AnimState:Hide('HAT')
    owner.AnimState:Hide('HAT_HAIR')
    owner.AnimState:Show('HAIR_NOHAT')
    owner.AnimState:Show('HAIR')
    if owner.prefab ~= 'xxx3' then
        owner:RemoveTag('eyeplant_friend')
    end
    if inst.prefab == 'xxx3_summerhat' and owner.components.health ~= nil then
        owner.components.health.externalfiredamagemultipliers:RemoveModifier(inst)
    end

    if inst._light ~= nil then
        for i, fx in ipairs(inst._light) do
            fx:Remove()
        end
        inst._light = nil
    end
end

local function hatfn(name, ex1, ex2)
    local function fn()
        local inst = CreateEntity()
        local trans = inst.entity:AddTransform()
        local anim = inst.entity:AddAnimState()
        MakeInventoryPhysics(inst)
        inst.entity:AddNetwork()

        inst:AddTag('hat')
        if ex1 then
            inst:AddTag('xxx3_spechat')
            ex1(inst)
        end

        -- anim:SetBank("xxx3_hat")
        -- anim:SetBuild("xxx3_hat")
        anim:SetBank(name)
        anim:SetBuild(name)
        anim:PlayAnimation('anim')

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent('tradable')
        inst:AddComponent('inspectable')

        inst:AddComponent('inventoryitem')
        inst.components.inventoryitem.atlasname = 'images/' .. name .. '.xml'
        -- inst.components.inventoryitem.atlasname = "images/xxx3_hat.xml"

        inst:AddComponent('equippable')
        inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
        inst.components.equippable.dapperness = 0.1

        inst.components.equippable:SetOnEquip(onequip)
        inst.components.equippable:SetOnUnequip(onunequip)

        if ex2 then
            ex2(inst)
        end

        if TUNING.XXX3_ITEMDURING == true then
            inst:AddTag('show_spoilage')

            inst:AddComponent('perishable')
            inst.components.perishable:SetPerishTime(TUNING.PERISH_SLOW)
            inst.components.perishable:StartPerishing()
            inst.components.perishable:SetOnPerishFn(inst.Remove)

            inst:AddComponent('forcecompostable')
            inst.components.forcecompostable.green = true

            inst:AddComponent('trader')
            inst.components.trader.onaccept = OnGetItemFromPlayer
            inst.components.trader:SetAcceptTest(ShouldAcceptItem)
        end

        return inst
    end

    -- return Prefab( "common/inventory/"..name, fn, {Asset("ANIM", "anim/xxx3_hat.zip"), Asset("ATLAS", "images/xxx3_hat.xml")})
    return Prefab(
        'common/inventory/' .. name,
        fn,
        {
            Asset('ANIM', 'anim/' .. name .. '.zip'),
            Asset('ATLAS', 'images/' .. name .. '.xml'),
            Asset('IMAGE', 'images/' .. name .. '.tex')
        }
    )
end

return hatfn('xxx3_hat', nil, nil), hatfn(
    'xxx3_springhat',
    function(inst)
        inst:AddTag('xxx3_springhat')
    end,
    nil
), hatfn(
    'xxx3_summerhat',
    function(inst)
        inst:AddTag('xxx3_summerhat')
    end,
    nil
), hatfn(
    'xxx3_autumnhat',
    function(inst)
        inst:AddTag('xxx3_autumnhat')
    end,
    nil
), hatfn(
    'xxx3_winterhat',
    function(inst)
        inst:AddTag('xxx3_winterhat')
    end,
    nil
), hatfn(
    'xxx3_shadowhat',
    function(inst)
        inst:AddTag('xxx3_shadowhat')
        inst:AddTag('shadowlevel')
        inst:AddTag('shadow_item')
    end,
    function(inst)
        inst:AddComponent('shadowdominance')

        inst.components.equippable.dapperness = TUNING.CRAZINESS_MED
        inst.components.equippable.is_magic_dapperness = true

        inst:AddComponent('shadowlevel')
        inst.components.shadowlevel:SetDefaultLevel(TUNING.SKELETONHAT_SHADOW_LEVEL)
    end
), hatfn(
    'xxx3_shadowhat',
    function(inst)
        inst:AddTag('xxx3_shadowhat')
        inst:AddTag('shadowlevel')
        inst:AddTag('shadow_item')
    end,
    function(inst)
        inst:AddComponent('shadowdominance')

        inst.components.equippable.dapperness = TUNING.CRAZINESS_MED
        inst.components.equippable.is_magic_dapperness = true

        inst:AddComponent('shadowlevel')
        inst.components.shadowlevel:SetDefaultLevel(TUNING.SKELETONHAT_SHADOW_LEVEL)
    end
), hatfn(
    'xxx3_lunarhat',
    function(inst)
        inst:AddTag('xxx3_lunarhat')
        inst:AddTag('gestaltprotection')
    end,
    function(inst)
        inst.components.equippable.dapperness = -TUNING.CRAZINESS_SMALL
        inst.components.equippable.is_magic_dapperness = true
    end
)
