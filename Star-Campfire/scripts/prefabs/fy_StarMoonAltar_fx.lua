local function fy_starmoonaltar_fx()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    --local inst = ThePlayer
    inst.AnimState:SetBank("heat_star_flame")
    inst.AnimState:SetBuild("heat_star_flame")
    inst.AnimState:PlayAnimation("level6", true)
    inst:AddTag("FX")
    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
    return inst
    end
    return inst
    end
    local function fy_starmoonaltar_fx2()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    --local inst = ThePlayer
    inst.AnimState:SetBank("ice_star_flame")
    inst.AnimState:SetBuild("ice_star_flame")
    inst.AnimState:PlayAnimation("level6", true)
    inst:AddTag("FX")
    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
    return inst
    end
    return inst
    end
    return Prefab("fy_starmoonaltar_fx", fy_starmoonaltar_fx),
    Prefab("fy_starmoonaltar_fx2", fy_starmoonaltar_fx2)