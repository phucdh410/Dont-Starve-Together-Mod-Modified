local assets =
{
    Asset("ANIM", "anim/alterguardian_spike.zip"),
    Asset("ANIM", "anim/xxx3_eyeplant_4_icespike.zip")

}

local function spike_break(inst)
    inst:ListenForEvent("animover", inst.Remove)
    inst.AnimState:PlayAnimation("spike_pst")
    inst.SoundEmitter:PlaySound("turnoftides/common/together/moon_glass/break",nil,.25)
end
local function isnotfollower(inst)
    return not (inst.components.follower ~= nil and inst.components.follower.leader ~= nil and inst.components.follower.leader:HasTag("player"))
end
local function isfriendly(inst)
    return inst:HasTag("fruitflyfruit")
end
local function can_be_freeze(inst)
    return inst.components.freezable ~= nil
    and not inst:HasTag("structure") and
    not inst:HasTag("wall") and inst.components.health
    and not inst.components.health:IsDead() and not inst:HasTag("player")
end
local function explo(inst)
    local x,y,z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x,y,z,1.2)
    for _,v in pairs(ents) do
        if v.components.health and v.components.combat and not v.components.health:IsDead()
        and not v:HasTag("eyeplant") and not v:HasTag("wall") and not v:HasTag("structure")
        and not v:HasTag('eyeplant_friend') then
            if inst.caster and inst.caster:IsValid() then
                inst.caster.components.combat.ignorehitrange = true
                inst.caster.components.combat:DoAttack(v)
                inst.caster.components.combat.ignorehitrange = false
            else
                v.components.combat:GetAttacked(nil,18)
            end
            if v.components.freezable then
                v.components.freezable:AddColdness(0.75,10)
            end
        end
    end

end
local function spikefn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("alterguardian_spike")
    inst.AnimState:SetBuild("xxx3_eyeplant_4_icespike")
    inst.AnimState:PlayAnimation("trail")
    inst.AnimState:PushAnimation("spike_pre")
    inst.AnimState:PushAnimation("spike_loop", true)
    inst.Transform:SetScale(0.55,0.55,0.55)

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst.persists = false
    inst:DoTaskInTime(1.1,function ()
        explo(inst)
        inst.SoundEmitter:PlaySoundWithParams("moonstorm/creatures/boss/alterguardian2/spike",  { intensity = math.random() })
    end)

    inst._break_task = inst:DoTaskInTime(2.5, function()
        explo(inst)
        spike_break(inst)
    end)

    return inst
end

return Prefab("xxx3_eyeplant_4_icespike", spikefn, assets)