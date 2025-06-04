local assets = {
    Asset("ANIM", "anim/ea_fertilizer_machine.zip"),
    Asset("IMAGE", "images/inventoryimages/ea_fertilizer_machine.tex"),
    Asset("ATLAS", "images/inventoryimages/ea_fertilizer_machine.xml"),
}

local prefabs = {
    "ea_jinkela_ash",
}


local function OnBurnt(inst)
    DefaultBurntStructureFn(inst)
end

local function OnHammered(inst, worker)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
    end
    inst.SoundEmitter:KillSound("firesuppressor_idle")
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("metal")
    inst:Remove()
end

local function OnHit(inst, worker)
    local num = inst.components.ea_fertilizer_machine.fertilizer_num
    if not inst:HasTag("burnt") then
        if num == 0 then
            inst.AnimState:PlayAnimation("hit")
            inst.AnimState:PushAnimation("idle")
        elseif num > 0 and num <=5 then
            inst.AnimState:PlayAnimation("hit_five")
            inst.AnimState:PushAnimation("idle_five")
        elseif num > 5 and num <=10 then
            inst.AnimState:PlayAnimation("hit_ten")
            inst.AnimState:PushAnimation("idle_ten")
        elseif num > 10 and num <=15 then
            inst.AnimState:PlayAnimation("hit_fiveteen")
            inst.AnimState:PushAnimation("idle_fiveteen")
        elseif num > 15 then
            inst.AnimState:PlayAnimation("hit_twenty")
            inst.AnimState:PushAnimation("idle_twenty")
        end
    end
end

local function OnSave(inst, data)
    if inst:HasTag("burnt") or (inst.components.burnable ~= nil and inst.components.burnable:IsBurning()) then
        data.burnt = true
    end
end

local function OnLoad(inst, data)
    if data ~= nil then
        if data.burnt and inst.components.burnable ~= nil and inst.components.burnable.onburnt ~= nil then
            inst.components.burnable.onburnt(inst)
        end
    end
end

local function OnBuilt(inst)
    inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/firesupressor_craft")
    inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("idle", true)
end

local function OnHarvest(inst, picker, produce)
    if not inst:HasTag("burnt") then
        if inst.components.ea_fertilizer_machine then
            inst.components.ea_fertilizer_machine:Clean()
        end
        inst.AnimState:PlayAnimation("idle",true)
    end
end

local function OnFertilizerNumChanged(inst, data)
    if type(data) ~= "table" then
        return
    end
    if data.percent == 0 then
        inst.AnimState:PlayAnimation("idle", true)
    elseif data.percent <= 0.25 then
        inst.AnimState:PlayAnimation("idle_five", true)
    elseif data.percent <= 0.5 then
        inst.AnimState:PlayAnimation("idle_ten", true)
    elseif data.percent <= 0.75 then
        inst.AnimState:PlayAnimation("idle_fiveteen", true)
    else
        inst.AnimState:PlayAnimation("idle_twenty", true)
    end
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

    inst.MiniMapEntity:SetIcon("ea_fertilizer_machine_mini.tex")

    inst.AnimState:SetBank("ea_fertilizer_machine")
    inst.AnimState:SetBuild("ea_fertilizer_machine")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("structure")

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("lootdropper")

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
    inst.components.workable:SetOnFinishCallback(OnHammered)
    inst.components.workable:SetOnWorkCallback(OnHit)

    inst:AddComponent("container")
    inst.components.container:WidgetSetup( "ea_fertilizer_machine")
    inst.components.container.skipclosesnd = true
    inst.components.container.skipopensnd = true

    inst:AddComponent("harvestable")
    inst.components.harvestable:SetUp("ea_jinkela_ash", EA_CONSTANTS.MAX_ACCEPT_ITEM_NUM, nil, OnHarvest)

    inst:AddComponent("ea_fertilizer_machine")
    inst:ListenForEvent("fertilizer_num_changed", OnFertilizerNumChanged)

    MakeMediumBurnable(inst, nil, nil, true)
    MakeMediumPropagator(inst)
    inst.components.burnable:SetOnBurntFn(OnBurnt)

    inst:ListenForEvent("onbuilt", OnBuilt)

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    return inst
end


return Prefab("ea_fertilizer_machine", fn, assets, prefabs),
    MakePlacer("ea_fertilizer_machine_placer", "ea_fertilizer_machine", "ea_fertilizer_machine", "idle")