local assets = {
    Asset("ANIM", "anim/yasuo_shield.zip")
}

local function SetOwner(inst, owner)
    inst.owner = owner
    owner:AddTag("alwaysblock")
    owner:ListenForEvent("onremove", function ()
        owner:RemoveTag("alwaysblock")
    end, inst)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.entity:AddSoundEmitter()

    inst:AddTag("FX")
    inst:AddTag("NOBLOCK")

    local n = math.random(4)
    inst.AnimState:SetBank("stalker_shield")
    inst.AnimState:SetBuild("yasuo_shield")
    inst.AnimState:PlayAnimation("idle"..tostring(math.min(3, n)))

    inst:AddTag("yasuo_shield")

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
    inst.SoundEmitter:PlaySound("yasuo/yasuo_sfx/way_of_wander")

    inst.SetOwner = SetOwner

    inst.persists = false
    inst:ListenForEvent("animover", inst.Remove)
    inst:DoTaskInTime(inst.AnimState:GetCurrentAnimationLength() + FRAMES, inst.Remove)

    return inst
end

return Prefab("yasuo_shield", fn, assets)