local assets = {
    Asset('ANIM', 'anim/xxx3_sf.zip')
}

local function ondigged(inst, worker)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
    end
    local fx = SpawnPrefab('collapse_small')
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial('wood')
    inst.components.lootdropper:SpawnLootPrefab('xxx3_pollen')
    inst.components.lootdropper:SpawnLootPrefab('plantmeat')
    inst:Remove()
end

local function onpickedfn(inst, picker)
    if math.random() < 0.1 then
        inst.components.lootdropper:SpawnLootPrefab('petals')
    end
    inst.components.lootdropper:DropLoot()
    local x, y, z = inst.Transform:GetWorldPosition()
    inst:Remove()
    SpawnPrefab('xxx3_sf_nf').Transform:SetPosition(x, y, z)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    inst.MiniMapEntity:SetIcon('xxx3_sf.tex')

    inst.AnimState:SetBank('xxx3_sf')
    inst.AnimState:SetBuild('xxx3_sf')
    inst.AnimState:PlayAnimation('NewAnimation', true)

    inst:AddTag('structure')
    inst:AddTag('flower')
    inst:AddTag('plant')

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent('inspectable')

    inst:AddComponent('lootdropper')

    -- inst:AddComponent('butterflyspawner')

    inst:AddComponent('pickable')
    inst.components.pickable.picksound = 'dontstarve/wilson/pickup_reeds'
    inst.components.pickable:SetUp('xxx3_pollen', 10)
    inst.components.pickable.onpickedfn = onpickedfn
    inst.components.pickable.wildfirestarter = true

    inst:AddComponent('workable')
    inst.components.workable:SetWorkAction(ACTIONS.DIG)
    inst.components.workable:SetWorkLeft(1)
    inst.components.workable:SetOnFinishCallback(ondigged)

    MakeMediumBurnable(inst)
    MakeSmallPropagator(inst)

    return inst
end

return Prefab('common/objects/xxx3_sf', fn, assets), MakePlacer(
    'common/xxx3_sf_placer',
    'xxx3_sf',
    'xxx3_sf',
    'NewAnimation'
)
