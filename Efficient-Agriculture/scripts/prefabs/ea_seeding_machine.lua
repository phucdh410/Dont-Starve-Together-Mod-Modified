local assets = {
    Asset("ANIM", "anim/ea_seeding_machine.zip"),
    Asset("IMAGE", "images/inventoryimages/ea_seeding_machine.tex"),
    Asset("ATLAS", "images/inventoryimages/ea_seeding_machine.xml"),
}


local function OnBurnt(inst)
    DefaultBurntStructureFn(inst)
end

local function OnHammered(inst, worker)
    if inst.components.burnable and inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
    end
    if not inst:HasTag("burnt") then
        inst.components.container:DropEverything()
    end
    inst.SoundEmitter:KillSound("firesuppressor_idle")
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("metal")
    inst:Remove()
end

local function OnHit(inst, worker, workleft, numworks)
    if not inst:HasTag("burnt") then
        inst.AnimState:PlayAnimation("hit")
        inst.AnimState:PushAnimation("idle",true)
    end
end

local function OnSave(inst, data)
    data.burnt = inst.components.burnable and inst.components.burnable:IsBurning() or inst:HasTag("burnt")
end

local function OnLoad(inst, data)
    if data then
        if data.burnt and inst.components.burnable and type(inst.components.burnable.onburnt) == "function" then
            inst.components.burnable.onburnt(inst)
        end
    end
end

local function OnBuilt(inst)
    inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/firesupressor_craft")
    inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("idle", true)
end



local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
    inst.entity:AddLightWatcher()

    MakeObstaclePhysics(inst, .5)

    inst.MiniMapEntity:SetIcon("ea_seeding_machine_mini.tex")

    inst.AnimState:SetBank("ea_seeding_machine")
    inst.AnimState:SetBuild("ea_seeding_machine")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("fridge")       --冰箱保鲜功能
    inst:AddTag("structure")

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetCanSleep(false)

    inst:AddComponent("inspectable")
    inst:AddComponent("lootdropper")

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
    inst.components.workable:SetOnFinishCallback(OnHammered)
    inst.components.workable:SetOnWorkCallback(OnHit)

    inst:AddComponent("container")
    inst.components.container:WidgetSetup( "ea_seeding_machine")
    inst.components.container.skipclosesnd = true
    inst.components.container.skipopensnd = true

    inst:AddComponent("ea_rectangle")

    inst:AddComponent("ea_seeding_machine")
    inst.components.ea_seeding_machine:SetRange(EA_CONSTANTS.SEEDING_MAX_SIDE, EA_CONSTANTS.SEEDING_MAX_SIDE)

    MakeMediumBurnable(inst, nil, nil, true)
    MakeMediumPropagator(inst)
    inst.components.burnable:SetOnBurntFn(OnBurnt)

    inst:ListenForEvent("onbuilt", OnBuilt)

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    return inst
end


return Prefab("ea_seeding_machine", fn, assets),
    MakePlacer("ea_seeding_machine_placer", "ea_seeding_machine", "ea_seeding_machine", "idle", nil, nil, nil, nil, nil, nil, function (inst)
        --生成区域范围预览
        inst:AddComponent("ea_rectangle_replica")
        inst.components.ea_rectangle_replica:SetSize(EA_CONSTANTS.SEEDING_MAX_SIDE, EA_CONSTANTS.SEEDING_MAX_SIDE)
        inst.components.ea_rectangle_replica:ShowArea(true)
    end)