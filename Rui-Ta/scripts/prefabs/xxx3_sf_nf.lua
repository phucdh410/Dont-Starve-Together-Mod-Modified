local assets =
{
    Asset("ANIM", "anim/xxx3_sf_nf.zip"),
}

local function changeintosf(inst)
    local fx = SpawnPrefab("bile_splash")
    local x,y,z = inst.Transform:GetWorldPosition()
    inst:Remove()
    fx.Transform:SetPosition(x,y,z)
	SpawnPrefab("xxx3_sf").Transform:SetPosition(x,y,z)
end

local function ondigged(inst, worker)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
    end
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("wood")
	inst.components.lootdropper:SpawnLootPrefab("plantmeat")
    inst:Remove()
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

	inst.MiniMapEntity:SetIcon("xxx3_sf.tex")
    
	inst.AnimState:SetBank("xxx3_sf_nf")
    inst.AnimState:SetBuild("xxx3_sf_nf")
    inst.AnimState:PlayAnimation("NewAnimation",true)

    inst:AddTag("structure")
    inst:AddTag("flower")
    
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("lootdropper")
    
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.DIG)
    inst.components.workable:SetWorkLeft(1)
    inst.components.workable:SetOnFinishCallback(ondigged)

    MakeMediumBurnable(inst)
    MakeSmallPropagator(inst)

    inst:DoTaskInTime(480,changeintosf)

    return inst
end

return Prefab("common/objects/xxx3_sf_nf", fn, assets),
    MakePlacer("common/xxx3_sf_nf_placer", "xxx3_sf_nf", "xxx3_sf_nf", "NewAnimation")
