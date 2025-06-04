local assets = {
    Asset("ANIM", "anim/ea_well.zip"),
    Asset("IMAGE", "images/inventoryimages/ea_well.tex"),
    Asset("ATLAS", "images/inventoryimages/ea_well.xml"),
}

local function OnHammered(inst, worker)
    inst.SoundEmitter:KillSound("firesuppressor_idle")
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("metal")
    inst:Remove()
end

local function OnHit(inst, worker, workleft, numworks)
    inst.AnimState:PlayAnimation("on_hit")
    inst.AnimState:PushAnimation("idle", true)
end

local function OnSave(inst, data)
    data.plants = inst.plants
end

local function OnLoad(inst, data)
    if data ~= nil and data.plants ~= nil and inst.plants == nil and inst.task ~= nil then
        inst.plants = data.plants
    end
end

local function OnBuilt(inst)
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

    MakeObstaclePhysics(inst, 1.5)

    inst.AnimState:SetBuild("ea_well")
    inst.AnimState:SetBank("ea_well")
    inst.AnimState:PlayAnimation("idle", true)


    inst.MiniMapEntity:SetIcon("ea_well_mini.tex") 

    inst:AddTag("watersource")
    inst:AddTag("antlion_sinkhole_blocker")
    inst:AddTag("birdblocker")
    ---------------------------------
    inst:AddTag("well")

    inst.no_wet_prefix = true

    inst:SetDeployExtraSpacing(2)

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("lootdropper")

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(6)
    inst.components.workable:SetOnFinishCallback(OnHammered)
    inst.components.workable:SetOnWorkCallback(OnHit)

    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    inst:AddComponent("watersource")

    inst:ListenForEvent("onbuilt", OnBuilt)
    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    return inst
end

return Prefab("ea_well", fn, assets),
    MakePlacer("ea_well_placer", "ea_well", "ea_well", "idle")