local assets =
{
    Asset("ANIM", "anim/xxx3_bf.zip"),
	Asset("ATLAS", "images/xxx3_bf.xml"),
	Asset("IMAGE", "images/xxx3_bf.tex"),
}

local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	
	inst.AnimState:SetBank("xxx3_bf")
	inst.AnimState:SetBuild("xxx3_bf")
	inst.AnimState:PlayAnimation("idle")

	MakeInventoryPhysics(inst)

    MakeInventoryFloatable(inst)

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("inspectable")
	inst:AddComponent("inventoryitem")

	inst:AddComponent("edible")
	inst.components.edible.healthvalue = 10

	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

	inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"

	inst:AddComponent("tradable") 

	inst.components.inventoryitem.atlasname = "images/xxx3_bf.xml"

	return inst
end

return Prefab("common/inventory/xxx3_bf", fn, assets, prefabs)