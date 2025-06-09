local assets =
{
    Asset("ANIM", "anim/xxx3_seed.zip"),
	Asset("ATLAS", "images/xxx3_seed.xml"),
	Asset("IMAGE", "images/xxx3_seed.tex"),
}

require "prefabs/xxx3_sf"

local function OnDeploy (inst, pt, deployer)
    inst = inst.components.stackable:Get()
    inst.Physics:Teleport(pt:Get())
	local sapling = SpawnPrefab("xxx3_sf_nf")
	sapling.Transform:SetPosition(pt.x, pt.y, pt.z)
    sapling.SoundEmitter:PlaySound("dontstarve/wilson/plant_tree")
	inst:Remove()
	SpawnPrefab("bile_splash").Transform:SetPosition(pt.x, pt.y, pt.z)
end


local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	
	inst.AnimState:SetBank("xxx3_seed")
	inst.AnimState:SetBuild("xxx3_seed")
	inst.AnimState:PlayAnimation("idle")

	MakeInventoryPhysics(inst)

    MakeInventoryFloatable(inst)

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("inspectable")
	inst:AddComponent("inventoryitem")

	inst:AddComponent("deployable")
	inst.components.deployable:SetDeployMode(DEPLOYMODE.PLANT)
	inst.components.deployable.ondeploy = OnDeploy

	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

	inst.components.inventoryitem.atlasname = "images/xxx3_seed.xml"

	return inst
end

return Prefab("common/inventory/xxx3_seed", fn, assets, prefabs),
MakePlacer("common/xxx3_seed_placer", "xxx3_sf", "xxx3_sf", "NewAnimation")