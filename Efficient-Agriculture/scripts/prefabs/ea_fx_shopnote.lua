local assets = {
    Asset("ANIM", "anim/ea_fx_shopnote.zip"),
}

local function OnHammered(inst, worker)
    inst:Remove()
end

local function OnSave(inst,data)
    if inst.shop then
        data.shop = true
    else data.shop = false
    end
end

local function OnLoad(inst,data)
    if data and data.shop then
        local x, y, z = inst.Transform:GetWorldPosition()
        for k,v in pairs(TheSim:FindEntities(x, y, z, 0.5)) do
            if v.prefab == "shop" then
                inst.shop = v
                v.note = inst
            end
        end
    end
end


local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddNetwork()
    inst.entity:AddAnimState()

    inst.AnimState:SetBank("ea_fx_shopnote")
    inst.AnimState:SetBuild("ea_fx_shopnote")
    inst.AnimState:PlayAnimation("build")
    inst.AnimState:PushAnimation("idle")

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(2)
    inst.components.workable:SetOnFinishCallback(OnHammered)

    inst.shop = nil

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    return inst
end


return Prefab("ea_fx_shopnote", fn, assets)