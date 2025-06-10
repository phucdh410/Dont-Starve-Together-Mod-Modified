local function lightfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    inst:AddTag("FX")

	inst.Light:SetIntensity(0.5)
	inst.Light:SetRadius(4)
	inst.Light:Enable(true)
	inst.Light:SetFalloff(0.8)
	inst.Light:SetColour(200/255, 200/255, 200/255)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    return inst
end

local function light1fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    inst:AddTag("FX")

	inst.Light:SetIntensity(0.5)
	inst.Light:SetRadius(4)
	inst.Light:Enable(true)
	inst.Light:SetFalloff(0.8)
	inst.Light:SetColour(200/255, 200/255, 200/255)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    return inst
end

return Prefab("kkr_light", lightfn),
Prefab("kkr_light1", light1fn)