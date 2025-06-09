local assets =
{
    Asset("ANIM", "anim/xxx3_pollen.zip"),
	Asset("ATLAS", "images/xxx3_pollen.xml"),
	Asset("IMAGE", "images/xxx3_pollen.tex"),
}

local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	
	inst.AnimState:SetBank("xxx3_pollen")
	inst.AnimState:SetBuild("xxx3_pollen")
	inst.AnimState:PlayAnimation("idle")

	MakeInventoryPhysics(inst)

    MakeInventoryFloatable(inst)

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("inspectable")
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/xxx3_pollen.xml"

	inst:AddComponent("edible")
	inst.components.edible.healthvalue = 10 * TUNING.XXX3_FOODVALUE
	inst.components.edible.hungervalue = 20 * TUNING.XXX3_FOODVALUE

	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

	inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(3600)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"

	return inst
end

return Prefab("common/inventory/xxx3_pollen", fn, assets, prefabs)