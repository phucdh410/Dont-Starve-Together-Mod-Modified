local assets = {
    Asset("ANIM", "anim/kkr_gemstaff.zip"),
    Asset("ANIM", "anim/swap_kkr_gemstaff.zip"),
    Asset("ATLAS", "images/inventoryimages/kkr_gemstaff.xml"),
    Asset("IMAGE", "images/inventoryimages/kkr_gemstaff.tex")
}

local function OnBroken(inst)
    inst.components.weapon:SetDamage(12.5)
    if inst.components.aoetargeting then
        inst.components.aoetargeting:SetEnabled(false)
    end
end

local function OnRepaired(inst)
    inst.components.weapon:SetDamage(42.5)
    if inst.components.aoetargeting then
        inst.components.aoetargeting:SetEnabled(true)
    end
end

local function ShouldAcceptItem(inst, item)
    if item.prefab == "goldnugget" or item.prefab == "bluegem" or item.prefab == "walrus_tusk" then
        return true
    end
    return false
end

local function OnGetItemFromPlayer(inst, giver, item)
    if item.prefab == "goldnugget" then
        inst.components.finiteuses:Use(-100)
    elseif item.prefab == "bluegem" then
        inst.components.finiteuses:Use(-200)
    else
        inst:Remove()
        giver.components.inventory:GiveItem(SpawnPrefab("kkr_elfstaff"))
    end
    if inst.components.finiteuses.current > inst.components.finiteuses.total then
        inst.components.finiteuses.current = inst.components.finiteuses.total
    end
    OnRepaired(inst)
end

local function OnLunged(inst, doer, startingpos, targetpos)
    inst.components.finiteuses:Use(4)
    inst.components.rechargeable:Discharge(2)
end

local function OnLungedHit(inst, doer, target)
end

local function ReticuleTargetFn()
    return Vector3(ThePlayer.entity:LocalToWorldSpace(6.5, 0, 0))
end

local function SpellFn(inst, doer, pos)
    doer:PushEvent("combat_lunge", {targetpos = pos, weapon = inst})
end

local function ReticuleMouseTargetFn(inst, mousepos)
    if mousepos ~= nil then
        local x, y, z = inst.Transform:GetWorldPosition()
        local dx = mousepos.x - x
        local dz = mousepos.z - z
        local l = dx * dx + dz * dz
        if l <= 0 then
            return inst.components.reticule.targetpos
        end
        l = 6.5 / math.sqrt(l)
        return Vector3(x + dx * l, 0, z + dz * l)
    end
end

local function ReticuleUpdatePositionFn(inst, pos, reticule, ease, smoothing, dt)
    local x, y, z = inst.Transform:GetWorldPosition()
    reticule.Transform:SetPosition(x, 0, z)
    local rot = -math.atan2(pos.z - z, pos.x - x) / DEGREES
    if ease and dt ~= nil then
        local rot0 = reticule.Transform:GetRotation()
        local drot = rot - rot0
        rot = Lerp((drot > 180 and rot0 + 360) or (drot < -180 and rot0 - 360) or rot0, rot, dt * smoothing)
    end
    reticule.Transform:SetRotation(rot)
end

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_kkr_gemstaff", "symbol0")

    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function OnDischarged(inst)
    if inst.components.aoetargeting then
        inst.components.aoetargeting:SetEnabled(false)
    end
end
local function OnCharged(inst)
    if inst.components.finiteuses.current <= 0 then
        OnBroken(inst)
    else
        if inst.components.aoetargeting then
            inst.components.aoetargeting:SetEnabled(true)
        end
    end
end

local function OnFinished(inst)
    OnBroken(inst)
end

local function onload(inst, data)
    if inst then
        if inst.components.finiteuses.current <= 0 then
            OnBroken(inst)
        end
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst, "med", nil, 0.75)

    inst.AnimState:SetBank("kkr_gemstaff")
    inst.AnimState:SetBuild("kkr_gemstaff")
    inst.AnimState:PlayAnimation("idle")

    inst.entity:SetPristine()

    inst:AddTag("meteor_protection")
    inst:AddTag("nosteal")
    inst:AddTag("NORATCHECK")

    if KKRENV.KKR_LUNGE_ENABLE then
        inst:AddComponent("aoetargeting")
        inst.components.aoetargeting:SetAllowRiding(false)
        inst.components.aoetargeting.reticule.reticuleprefab = "reticuleline"
        inst.components.aoetargeting.reticule.pingprefab = "reticulelineping"
        inst.components.aoetargeting.reticule.targetfn = ReticuleTargetFn
        inst.components.aoetargeting.reticule.mousetargetfn = ReticuleMouseTargetFn
        inst.components.aoetargeting.reticule.updatepositionfn = ReticuleUpdatePositionFn
        inst.components.aoetargeting.reticule.validcolour = {1, .75, 0, 1}
        inst.components.aoetargeting.reticule.invalidcolour = {.5, 0, 0, 1}
        inst.components.aoetargeting.reticule.ease = true
        inst.components.aoetargeting.reticule.mouseenabled = true
    end

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(42.5)

    if KKRENV.KKR_LUNGE_ENABLE then
        inst:AddComponent("aoeweapon_lunge")
        inst.components.aoeweapon_lunge:SetDamage(42.5)
        inst.components.aoeweapon_lunge:SetSound("meta3/wigfrid/spear_lighting_lunge")
        inst.components.aoeweapon_lunge:SetSideRange(2)
        inst.components.aoeweapon_lunge:SetOnLungedFn(OnLunged)
        inst.components.aoeweapon_lunge:SetOnHitFn(OnLungedHit)
        inst.components.aoeweapon_lunge:SetTrailFX("kkr_spear_lungefx", 1)
        inst.components.aoeweapon_lunge:SetWorkActions()
        inst.components.aoeweapon_lunge:SetTags("_combat")

        inst:AddComponent("aoespell")
        inst.components.aoespell:SetSpellFn(SpellFn)
    end

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(200)
    inst.components.finiteuses:SetUses(200)
    inst.components.finiteuses:SetOnFinished(OnFinished)

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/kkr_gemstaff.xml"

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    inst:AddComponent("trader")
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader:SetAcceptTest(ShouldAcceptItem)

    inst:AddComponent("rechargeable")
    inst.components.rechargeable:SetMaxCharge(2)
    inst.components.rechargeable:SetOnDischargedFn(OnDischarged)
    inst.components.rechargeable:SetOnChargedFn(OnCharged)

    inst.OnLoad = onload

    return inst
end

return Prefab("kkr_gemstaff", fn, assets)
