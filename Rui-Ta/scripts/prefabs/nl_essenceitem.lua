
local function itemfn(name, build, sizemult)
    local function fn()
        local inst = CreateEntity()
		inst.entity:AddTransform()
		inst.entity:AddAnimState()
		inst.entity:AddNetwork()

        inst.Transform:SetScale(sizemult, sizemult, sizemult)
		
		MakeInventoryPhysics(inst)
        MakeInventoryFloatable(inst)
		
		inst.AnimState:SetBank(name)
		inst.AnimState:SetBuild(build)
		inst.AnimState:PlayAnimation("idle", true)

        inst.AnimState:SetLightOverride(1)	
        inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")	 

        inst.entity:SetPristine()

        inst:AddTag("nosteal")

		if not TheWorld.ismastersim then
			return inst
		end
	
		inst:AddComponent("inspectable")

		inst:AddComponent("inventoryitem")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/" .. name .. ".xml"

	    inst:AddComponent("stackable")
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

        -- inst:AddComponent("nl_essenceabsorb")

        return inst
    end

    return Prefab("common/inventory/"..name, fn, {Asset("ANIM", "anim/" .. build .. ".zip"), Asset("ATLAS", "images/inventoryimages/" .. name .. ".xml")})
end

return 

itemfn("nl_essence_shadow", "nl_essence", 1.6),
itemfn("nl_essence_nature", "nl_essence", 1.4),
itemfn("nl_essence_plague", "nl_essence", 1.9),  
itemfn("nl_essence_stars", "nl_essence", 1.4)

