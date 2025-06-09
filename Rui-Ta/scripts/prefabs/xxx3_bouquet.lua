local assets = {
    Asset('ANIM', 'anim/xxx3_bouquet.zip'),
    Asset('ANIM', 'anim/swap_xxx3_bouquet.zip'),
    Asset('ANIM', 'anim/xxx3_bouquet_shadow.zip'),
    Asset('ANIM', 'anim/swap_xxx3_bouquet_shadow.zip'),
    Asset('ANIM', 'anim/xxx3_bouquet_lunar.zip'),
    Asset('ANIM', 'anim/swap_xxx3_bouquet_lunar.zip'),
    Asset('ATLAS', 'images/xxx3_bouquet.xml'),
    Asset('IMAGE', 'images/xxx3_bouquet.tex'),
    Asset('ATLAS', 'images/xxx3_bouquet_shadow.xml'),
    Asset('IMAGE', 'images/xxx3_bouquet_shadow.tex'),
    Asset('ATLAS', 'images/xxx3_bouquet_lunar.xml'),
    Asset('IMAGE', 'images/xxx3_bouquet_lunar.tex')
}

local function ShouldAcceptItem(inst, item)
    if item.prefab == 'xxx3_bf' then
        return true
    end
    return false
end

local function OnGetItemFromPlayer(inst, giver, item)
    inst.components.perishable:AddTime(TUNING.PERISH_FAST)
end

local function makebouquet(name, summoner, ex1, ex2)
    local function summon(inst)
        local x, y, z = inst.Transform:GetWorldPosition()
        if inst.killerbutterfly == nil then
            inst.killerbutterfly = {}
            for i = 1, 5, 1 do
                table.insert(inst.killerbutterfly, nil)
            end
        end
        for i = 1, 5, 1 do
            if inst.killerbutterfly[i] == nil or (inst.killerbutterfly[i] and not inst.killerbutterfly[i]:IsValid()) then
                inst.killerbutterfly[i] = SpawnPrefab(summoner)
                local radius = inst:GetPhysicsRadius(0) + .7 + math.random() * .5
                local angle = math.random() * 2 * PI
                local nx = x + radius * math.cos(angle)
                local nz = z - radius * math.sin(angle)
                inst.killerbutterfly[i].Transform:SetPosition(nx, 0, nz)
                inst.killerbutterfly[i].components.follower:SetLeader(inst)
                inst.killerbutterfly[i].master = inst

                if name == 'xxx3_bouquet_shadow' then
                    SpawnPrefab('sanity_lower').Transform:SetPosition(nx, 0, nz)
                elseif name == 'xxx3_bouquet_lunar' then
                    SpawnPrefab('planar_hit_fx').Transform:SetPosition(nx, 0, nz)
                else
                    SpawnPrefab('bile_splash').Transform:SetPosition(nx, 0, nz)
                end
            end
        end
    end

    local function remove(inst)
        for i = 1, 5, 1 do
            if inst.killerbutterfly[i] ~= nil and inst.killerbutterfly[i]:IsValid() then
                if name == 'xxx3_bouquet_shadow' then
                    SpawnPrefab('sanity_raise').Transform:SetPosition(
                        inst.killerbutterfly[i].Transform:GetWorldPosition()
                    )
                elseif name == 'xxx3_bouquet_lunar' then
                    SpawnPrefab('planar_hit_fx').Transform:SetPosition(
                        inst.killerbutterfly[i].Transform:GetWorldPosition()
                    )
                else
                    SpawnPrefab('bile_splash').Transform:SetPosition(
                        inst.killerbutterfly[i].Transform:GetWorldPosition()
                    )
                end

                inst.killerbutterfly[i]:Remove()
                inst.killerbutterfly[i] = nil
            end
        end
    end

    local function onequip(inst, owner)
        owner.AnimState:OverrideSymbol('swap_object', 'swap_' .. name, 'swap_' .. name)
        owner.AnimState:Show('ARM_carry')
        owner.AnimState:Hide('ARM_normal')
        summon(owner)

        if name == 'xxx3_bouquet_lunar' then
            if inst._carrylight == nil then
                inst._carrylight = {}
                local fx = SpawnPrefab('xxx3_bouquet_lunar_light')
                fx.entity:SetParent(owner.entity)
                table.insert(inst._carrylight, fx)
            end
        end
    end

    local function onunequip(inst, owner)
        owner.AnimState:Hide('ARM_carry')
        owner.AnimState:Show('ARM_normal')
        remove(owner)

        if inst._carrylight ~= nil then
            for i, fx in ipairs(inst._carrylight) do
                fx:Remove()
            end
            inst._carrylight = nil
        end
    end

    local function fn()
        local inst = CreateEntity()
        inst.entity:AddSoundEmitter()
        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)

        inst.AnimState:SetBank(name)
        inst.AnimState:SetBuild(name)
        inst.AnimState:PlayAnimation('idle')

        inst:AddTag('sharp')
        inst:AddTag('pointy')

        if ex1 then
            ex1(inst)
        end

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent('weapon')
        inst.components.weapon:SetDamage(1)

        inst:AddComponent('inspectable')

        inst:AddComponent('inventoryitem')
        inst.components.inventoryitem.atlasname = 'images/' .. name .. '.xml'

        inst:AddComponent('equippable')
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

        MakeHauntableLaunch(inst)

        return inst
    end

    return Prefab(name, fn, assets)
end

-------------------------------------------------------

local function fxfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    inst:AddTag('FX')

    inst.Light:SetFalloff(.5)
    inst.Light:SetIntensity(.5)
    inst.Light:SetRadius(2)
    inst.Light:SetColour(255 / 255, 255 / 255, 255 / 255)
    inst.Light:Enable(true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false
    return inst
end

return makebouquet('xxx3_bouquet', 'xxx3_killerbutterfly', nil, nil), makebouquet(
    'xxx3_bouquet_shadow',
    'xxx3_killerbutterfly_shadow',
    function(inst)
        inst:AddTag('shadowlevel')
        inst:AddTag('shadow_item')
    end,
    function(inst)
        inst.components.equippable.dapperness = -TUNING.DAPPERNESS_MED
        inst.components.equippable.is_magic_dapperness = true

        inst:AddComponent('shadowlevel')
        inst.components.shadowlevel:SetDefaultLevel(TUNING.VOIDCLOTH_SCYTHE_SHADOW_LEVEL)
    end
), makebouquet('xxx3_bouquet_lunar', 'xxx3_killerbutterfly_lunar', nil, nil), Prefab('xxx3_bouquet_lunar_light', fxfn)
