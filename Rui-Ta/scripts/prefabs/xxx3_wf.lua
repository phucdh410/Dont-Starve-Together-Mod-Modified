local assets = {
    Asset('ANIM', 'anim/xxx3_wf.zip'),
    Asset('ANIM', 'anim/xxx3_wf_seed.zip')
}

local function get_name(inst)
    local name = STRINGS.NAMES[string.upper(inst.prefab)]
    local named = name .. '(Lv.' .. inst._level:value() .. ')'

    return named
end

local function ShouldAcceptItem(inst, item)
    if item.prefab == 'xxx3_wf_seed' then
        return true
    end
    return false
end

local function OnGetItemFromPlayer(inst, giver, item)
    inst.level = inst.level + 1
    inst._level:set(inst.level)
end

--------------------------------------------

--掉落概率表
local prizevalues = {
    petals = 0.6,
    xxx3_pollen = 0.3,
    xxx3_seed = 0.1,
    xxx3_ydg = 0.01
}

-- local easing = require('easing')
-- local function OnFalling(inst, startpos, starttime, duration)
--     local t = math.max(0, GetTime() - starttime)
--     local pos = startpos + (inst.fallingpos - startpos) * easing.inOutQuad(t, 0, 1, duration)
--     if t < duration and pos.y > 0 then
--         inst.Transform:SetPosition(pos:Get())
--     else
--         inst.Physics:Teleport(inst.fallingpos:Get())
--         inst.fallingtask:Cancel()
--         inst.fallingtask = nil
--         inst.fallingpos = nil
--         if inst.components.inventoryitem ~= nil then
--             inst.components.inventoryitem.canbepickedup = true
--         end
--     end
-- end

-- local function Spawnitems(inst)
--     if TUNING.XXX3_WF_PRODUCEITEM == true then
--         local x, y, z = inst:GetPosition():Get()
--         local space = 2
--         local offset = 5.5
--         local max_nums = 12
--         local max_tries = 25
--         local prefab1 = weighted_random_choice(prizevalues)
--         local prefab2 = weighted_random_choice(prizevalues)
--         local prefab3 = weighted_random_choice(prizevalues)

--         local ents = TheSim:FindEntities(x, y, z, 4, {prefab1})
--         if #ents < max_nums then
--             for i = 1, max_tries do
--                 local rad = math.random(2, 5)
--                 local arc = math.random(0, 360)
--                 local a, b, c = x + rad * math.cos(arc), 0, z + rad * math.sin(arc)
--                 if TheWorld.Map:IsAboveGroundAtPoint(a, b, c) then
--                     local item = SpawnPrefab(prefab1)
--                     item.Transform:SetPosition(a, b + offset, c)
--                     item.fallingpos = item:GetPosition()
--                     item.fallingpos.y = 0
--                     item.fallingtask =
--                         item:DoPeriodicTask(FRAMES, OnFalling, 0, item:GetPosition(), GetTime(), 5 * FRAMES)
--                     if item.components.inventoryitem ~= nil then
--                         item.components.inventoryitem.canbepickedup = false
--                     end
--                     SpawnPrefab('bile_splash').Transform:SetPosition(a, b + offset, c)
--                     break
--                 end
--             end
--         end

--         local ents = TheSim:FindEntities(x, y, z, 4, {prefab2})
--         if #ents < max_nums then
--             for i = 1, max_tries do
--                 local rad = math.random(2, 5)
--                 local arc = math.random(0, 360)
--                 local a, b, c = x + rad * math.cos(arc), 0, z + rad * math.sin(arc)
--                 if TheWorld.Map:IsAboveGroundAtPoint(a, b, c) then
--                     local item = SpawnPrefab(prefab2)
--                     item.Transform:SetPosition(a, b + offset, c)
--                     item.fallingpos = item:GetPosition()
--                     item.fallingpos.y = 0
--                     item.fallingtask =
--                         item:DoPeriodicTask(FRAMES, OnFalling, 0, item:GetPosition(), GetTime(), 5 * FRAMES)
--                     if item.components.inventoryitem ~= nil then
--                         item.components.inventoryitem.canbepickedup = false
--                     end
--                     SpawnPrefab('bile_splash').Transform:SetPosition(a, b + offset, c)
--                     break
--                 end
--             end
--         end

--         local ents = TheSim:FindEntities(x, y, z, 4, {prefab3})
--         if #ents < max_nums then
--             for i = 1, max_tries do
--                 local rad = math.random(2, 5)
--                 local arc = math.random(0, 360)
--                 local a, b, c = x + rad * math.cos(arc), 0, z + rad * math.sin(arc)
--                 if TheWorld.Map:IsAboveGroundAtPoint(a, b, c) then
--                     local item = SpawnPrefab(prefab3)
--                     item.Transform:SetPosition(a, b + offset, c)
--                     item.fallingpos = item:GetPosition()
--                     item.fallingpos.y = 0
--                     item.fallingtask =
--                         item:DoPeriodicTask(FRAMES, OnFalling, 0, item:GetPosition(), GetTime(), 5 * FRAMES)
--                     if item.components.inventoryitem ~= nil then
--                         item.components.inventoryitem.canbepickedup = false
--                     end
--                     SpawnPrefab('bile_splash').Transform:SetPosition(a, b + offset, c)
--                     break
--                 end
--             end
--         end
--         local ents = TheSim:FindEntities(x, y, z, 8, nil, {'INLIMBO'})
--         for _, v in pairs(ents) do
--             if
--                 v.prefab == 'spoiled_food' or v.prefab == 'rottenegg' or v.prefab == 'spoiled_fish' or
--                     v.prefab == 'spoiled_fish_small' or
--                     v.prefab == 'poop' or
--                     (v.components.perishable and v.components.perishable:GetPercent() < .25)
--              then
--                 if v.components.inventoryitem ~= nil then
--                     v.components.inventoryitem.canbepickedup = false
--                 end
--                 v:DoPeriodicTask(
--                     0.1,
--                     function()
--                         local nx, ny, nz = v.Transform:GetScale()
--                         nx = nx * 0.9
--                         ny = ny * 0.9
--                         nz = nz * 0.9
--                         v.Transform:SetScale(nx, ny, nz)
--                     end
--                 )
--                 v:DoTaskInTime(
--                     1.5,
--                     function()
--                         v:Remove()
--                     end
--                 )
--             end
--         end
--     end
-- end

--生成掉落物
local function Spawnitems(inst)
    if TUNING.XXX3_WF_PRODUCEITEM == true then
        local x, y, z = inst:GetPosition():Get()
        local itemnum = 3 * inst.level
        local items = {}

        for i = 1, itemnum do
            local prefab = weighted_random_choice(prizevalues)

            if items[prefab] == nil then
                items[prefab] = 1
            else
                items[prefab] = items[prefab] + 1
            end
        end

        for index, num in pairs(items) do
            local stacknum = math.ceil(num / 40)
            local leftnum = num
            for i = 1, stacknum do
                local rad = math.random(2, 5)
                local arc = math.random(0, 360)
                local a, b, c = x + rad * math.cos(arc), 0, z + rad * math.sin(arc)

                local item = SpawnPrefab(index)
                item.components.stackable:SetStackSize(math.min(40, leftnum))
                item.Transform:SetPosition(a, b, c)

                leftnum = num - 40
                SpawnPrefab('bile_splash').Transform:SetPosition(a, b, c)
            end
        end

        --清理腐烂物
        local ents = TheSim:FindEntities(x, y, z, 8, nil, {'INLIMBO'})
        for _, v in pairs(ents) do
            if
                v.prefab == 'spoiled_food' or v.prefab == 'rottenegg' or v.prefab == 'spoiled_fish' or
                    v.prefab == 'spoiled_fish_small' or
                    v.prefab == 'poop' or
                    (v.components.perishable and v.components.perishable:GetPercent() < .25)
             then
                if v.components.inventoryitem ~= nil then
                    v.components.inventoryitem.canbepickedup = false
                end
                v:DoPeriodicTask(
                    0.1,
                    function()
                        local nx, ny, nz = v.Transform:GetScale()
                        nx = nx * 0.9
                        ny = ny * 0.9
                        nz = nz * 0.9
                        v.Transform:SetScale(nx, ny, nz)
                    end
                )
                v:DoTaskInTime(
                    1.5,
                    function()
                        v:Remove()
                    end
                )
            end
        end
    end
end

--生成蝴蝶
local function Spawnbutterfly(inst)
    if not TheWorld.state.isday then
        return
    end
    if TUNING.XXX3_WF_PRODUCEBUTTERFLY == true then
        local x, y, z = inst:GetPosition():Get()
        local max_nums = 10
        local prefab = 'butterfly'

        local ents = TheSim:FindEntities(x, y, z, 10, {'butterfly'})
        for k, _ in pairs(ents) do
            if k >= max_nums then
                return
            end
        end

        for i = 1, max_nums do
            local rad = math.random(3, 10)
            local arc = math.random(0, 360)
            local a, b, c = x + rad * math.cos(arc), 0, z + rad * math.sin(arc)
            if TheWorld.Map:IsAboveGroundAtPoint(a, b, c) then
                local butterfly = SpawnPrefab(prefab)
                butterfly.Transform:SetPosition(a, b, c)
                break
            end
        end
    end
end
--生成萤火虫
local function SpawnFireflies(inst)
    if TUNING.XXX3_WF_PRODUCEFIREFLY == true then
        local x, y, z = inst:GetPosition():Get()
        local max_nums = 10
        local prefab = 'fireflies'

        local ents = TheSim:FindEntities(x, y, z, 10, {'firefly'})
        for k, _ in pairs(ents) do
            if k >= max_nums then
                return
            end
        end

        for i = 1, max_nums do
            local rad = math.random(3, 10)
            local arc = math.random(0, 360)
            local a, b, c = x + rad * math.cos(arc), 0, z + rad * math.sin(arc)
            if TheWorld.Map:IsAboveGroundAtPoint(a, b, c) then
                local fireflies = SpawnPrefab(prefab)
                fireflies.Transform:SetPosition(a, b, c)
                break
            end
        end
    end
end

local function onchopped(inst, worker)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
    end
    local fx = SpawnPrefab('collapse_small')
    fx.Transform:SetScale(3, 3, 3)
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial('wood')
    SpawnPrefab('plantmeat').Transform:SetPosition(inst.Transform:GetWorldPosition())
    SpawnPrefab('plantmeat').Transform:SetPosition(inst.Transform:GetWorldPosition())
    SpawnPrefab('plantmeat').Transform:SetPosition(inst.Transform:GetWorldPosition())
    SpawnPrefab('plantmeat').Transform:SetPosition(inst.Transform:GetWorldPosition())
    SpawnPrefab('plantmeat').Transform:SetPosition(inst.Transform:GetWorldPosition())
    inst:Remove()
end

local function onSave(inst, data)
    data.level = inst.level
end

local function onLoad(inst, data)
    if data and data.level then
        inst.level = data.level
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, .5)

    inst._level = net_shortint(inst.GUID, 'xxx3_wflevel')

    inst.displaynamefn = get_name

    inst.MiniMapEntity:SetIcon('xxx3_wf.tex')

    inst.AnimState:SetBank('xxx3_wf')
    inst.AnimState:SetBuild('xxx3_wf')
    inst.AnimState:PlayAnimation('NewAnimation', true)

    inst:AddTag('structure')

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.level = 1

    inst:AddComponent('inspectable')
    inst:AddComponent('lootdropper')

    inst:AddComponent('prototyper')
    inst.components.prototyper.trees = TUNING.PROTOTYPER_TREES.WF_ONE

    inst:AddComponent('workable')
    inst.components.workable:SetWorkAction(ACTIONS.CHOP)
    inst.components.workable:SetWorkLeft(15)
    inst.components.workable:SetOnFinishCallback(onchopped)

    inst:AddComponent('trader')
    inst.components.trader.acceptnontradable = true
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader:SetAcceptTest(ShouldAcceptItem)

    inst:DoPeriodicTask(60, Spawnbutterfly)
    inst:DoPeriodicTask(900, SpawnFireflies)

    inst:WatchWorldState('startday', Spawnitems)

    inst.OnLoad = onLoad
    inst.OnSave = onSave

    inst:DoTaskInTime(
        FRAMES,
        function()
            inst._level:set(inst.level)
        end
    )

    return inst
end

----------------------------------------------------------------------

local function OnDeploy(inst, pt, deployer)
    local wf = SpawnPrefab('xxx3_wf')
    wf.Transform:SetPosition(pt.x, pt.y, pt.z)
    wf.SoundEmitter:PlaySound('dontstarve/wilson/plant_tree')

    inst:Remove()

    local fx = SpawnPrefab('bile_splash')
    fx.Transform:SetScale(3, 3, 3)
    fx.Transform:SetPosition(pt.x, pt.y, pt.z)
end

local function seedfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank('xxx3_wf_seed')
    inst.AnimState:SetBuild('xxx3_wf_seed')
    inst.AnimState:PlayAnimation('idle')

    MakeInventoryFloatable(inst, 'med', 0.05, 0.68)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent('inspectable')

    inst:AddComponent('inventoryitem')
    inst.components.inventoryitem.atlasname = 'images/inventoryimages/xxx3_wf_seed.xml'

    inst:AddComponent('tradable')

    inst:AddComponent('deployable')
    inst.components.deployable:SetDeployMode(DEPLOYMODE.PLANT)
    inst.components.deployable.ondeploy = OnDeploy

    MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)

    return inst
end

return Prefab('common/objects/xxx3_wf', fn, assets), MakePlacer(
    'common/xxx3_wf_placer',
    'xxx3_wf',
    'xxx3_wf',
    'NewAnimation'
), Prefab('xxx3_wf_seed', seedfn, assets), MakePlacer('xxx3_wf_seed_placer', 'xxx3_wf', 'xxx3_wf', 'NewAnimation')
