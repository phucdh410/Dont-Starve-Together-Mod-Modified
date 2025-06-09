local assets =
{
    Asset("ANIM", "anim/xxx3_bulbfx.zip"),
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
   
	inst.AnimState:SetBank("xxx3_bulbfx")
    inst.AnimState:SetBuild("xxx3_bulbfx")
    inst.AnimState:PlayAnimation("idle",true)
    
    inst:AddTag("FX")
    inst:AddTag("NOCLICK")
    MakeObstaclePhysics(inst, .1)
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false
    return inst
end

return Prefab("common/objects/xxx3_bulbfx", fn, assets)