local edge_assets = {
    Asset("ANIM", "anim/ea_area_edge.zip"),
}

local area_assets = {
	Asset("ANIM", "anim/ea_rectangle.zip"),
}

local function edge_fn()
	local inst = CreateEntity()

    inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.AnimState:SetBank("ea_area_edge")
	inst.AnimState:SetBuild("ea_area_edge")
	inst.AnimState:PlayAnimation("idle")
	inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
	inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)

	inst:AddTag("NOCLICK")
	inst.entity:SetCanSleep(false)

    return inst
end


local TEXTURE_SIZE = 6.83 * (128 / 1024)		--贴图对应地皮长度
local function SetSize(inst, w, h)	--x, z
	inst.AnimState:SetScale(w/TEXTURE_SIZE, h/TEXTURE_SIZE)
end

local function area_fn()
	local inst = CreateEntity()

    inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.AnimState:SetBank("ea_rectangle")
	inst.AnimState:SetBuild("ea_rectangle")
	inst.AnimState:PlayAnimation("idle")
	inst.AnimState:SetMultColour(1, 1, 1, 0.25)
	inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
	inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)

	inst:AddTag("NOCLICK")
	inst.entity:SetCanSleep(false)

	inst.SetSize = SetSize

    return inst
end


return Prefab("ea_area_edge", edge_fn, edge_assets),
	Prefab("ea_rectangle", area_fn, area_assets)