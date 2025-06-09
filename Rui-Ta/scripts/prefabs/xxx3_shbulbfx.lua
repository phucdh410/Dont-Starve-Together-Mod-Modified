local assets =
{
    Asset("ANIM", "anim/xxx3_shbulb.zip"),
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
   
	inst.AnimState:SetBank("xxx3_shbulb")
    inst.AnimState:SetBuild("xxx3_shbulb")
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

return Prefab("xxx3_shbulbfx", fn, assets)