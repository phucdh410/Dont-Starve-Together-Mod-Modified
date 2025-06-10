local assets = {
    Asset("ANIM", "anim/kkr_elfstaff_plus.zip"),
    Asset("ANIM", "anim/swap_kkr_elfstaff_plus.zip"),
    Asset("ATLAS", "images/inventoryimages/kkr_elfstaff_plus.xml"),
    Asset("IMAGE", "images/inventoryimages/kkr_elfstaff_plus.tex")
}

local prefabs = {
    "kkr_spear_lungefx"
}

local function OnCooldown(inst)
    inst._cdtask = nil
end

local AtkTags = {
    {name = "kkratk_multithrust", rand = 0.23}
}

local function RemoveAllAtkTags(inst)
    for _, v in pairs(AtkTags) do
        if inst:HasTag(tostring(v.name)) then
            inst:RemoveTag(tostring(v.name))
        end
    end
end

local function lunge(inst, player, target)
    local dmg, spdmg
    if inst.purebrilliance_count == 1 then
        dmg, spdmg = player.components.combat:CalcDamage(target, inst, 1)
    else
        dmg, spdmg = player.components.combat:CalcDamage(target, inst, 0.5)
    end
    local newnums = 3
    local roa_little = math.random() * math.pi - math.random() * 2 * math.pi
    local sleeptime = math.min(0.1, 0.4 / newnums)
    local rad = 4.5
    player:StartThread(
        function()
            for roa = roa_little, 2 * math.pi + roa_little, 2 * math.pi / newnums do
                local pos = target:GetPosition()
                local offset = Vector3(math.cos(roa) * rad, 0, math.sin(roa) * rad)
                local shadow = SpawnPrefab("kkr_striker")
                shadow:SetPlayer(player)
                shadow:SetPosition(pos, offset)
                shadow:SetDamage(dmg)
                shadow:SetPlanardamage(spdmg)
                shadow:SetTarget(target)
                Sleep(sleeptime)
            end
        end
    )
end

local function OnBroken(inst)
    inst.components.weapon:SetDamage(21)
    inst.components.planardamage:SetBaseDamage(0)
    if inst.components.aoetargeting then
        inst.components.aoetargeting:SetEnabled(false)
    end
end

local function OnRepaired(inst)
    inst.components.weapon:SetDamage(51)
    if inst.purebrilliance_count == 1 then
        inst.components.planardamage:SetBaseDamage(20)
    else
        inst.components.planardamage:SetBaseDamage(10)
    end

    if inst.components.aoetargeting then
        inst.components.aoetargeting:SetEnabled(true)
    end
end

local function ShouldAcceptItem(inst, item)
    if item.prefab == "goldnugget" or item.prefab == "bluegem" then
        return true
    end
    if item.prefab == "purebrilliance" and inst.purebrilliance_count == 0 then
        return true
    end
    return false
end

local function OnGetItemFromPlayer(inst, giver, item)
    if item.prefab == "goldnugget" then
        inst.components.finiteuses:Use(-100)
    elseif item.prefab == "bluegem" then
        inst.components.finiteuses:Use(-200)
    elseif item.prefab == "purebrilliance" then
        inst.components.planardamage:SetBaseDamage(20)
        inst.purebrilliance_count = 1
        inst.components.named:SetName("大精灵之杖+")
        local inventory = giver.components.inventory
        if inventory then
            local hand_item = inventory:Unequip("hands")
            if hand_item then
                inventory:GiveItem(hand_item)
            end
        end
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
    if inst and inst.components.finiteuses.current > 0 then
        lunge(inst, doer, target)
    end
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

local function OnAttack(weapon, attacker, target)
    RemoveAllAtkTags(weapon)
    if weapon and weapon.components.finiteuses.current > 0 then
        local speedMultiplier = 1
        if attacker and attacker.components.locomotor then
            speedMultiplier = attacker.components.locomotor:GetSpeedMultiplier()
        end

        if attacker and weapon:HasTag("multithrust_mode") and weapon._cdtask == nil then
            if math.random() <= math.min((speedMultiplier - 1) / 2, 0.66) then
                weapon:AddTag("kkratk_multithrust")
                weapon._cdtask = weapon:DoTaskInTime(2, OnCooldown)
            end
        end

        if attacker and math.random() < 0.25 and weapon.purebrilliance_count == 1 then
            local attacker_pos = attacker:GetPosition()
            local target_pos = target:GetPosition()
            local SPEED = 20
            local dist = math.sqrt((target_pos.x - attacker_pos.x) ^ 2 + (target_pos.z - attacker_pos.z) ^ 2)
            local sin = (target_pos.z - attacker_pos.z) / dist
            local cos = (target_pos.x - attacker_pos.x) / dist
            local speed_x = sin * SPEED
            local speed_z = cos * SPEED
            local scale = .8
            local radius = 2
            local dmg, spdmg = attacker.components.combat:CalcDamage(target, weapon, 0.5)
            local fx = SpawnPrefab("kkr_spear_tornado")
            fx.AnimState:SetScale(scale, scale, scale)
            fx.radius = radius
            fx.WIND_CASTER = attacker
            fx.dmg = dmg
            fx.spdmg = spdmg
            fx.Transform:SetPosition(attacker:GetPosition():Get())
            fx.Physics:SetMotorVel(speed_z, 0, speed_x)
        end
    end
end

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_kkr_elfstaff_plus", "symbol0")

    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")

    if inst.purebrilliance_count == 1 then
        if inst._vfx_fx_inst == nil then
            inst._vfx_fx_inst = SpawnPrefab("cane_victorian_fx")
            inst._vfx_fx_inst.entity:AddFollower()
        end
        inst._vfx_fx_inst.entity:SetParent(owner.entity)
        inst._vfx_fx_inst.Follower:FollowSymbol(owner.GUID, "swap_object", 0, -190, 0)
    end
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")

    if inst._vfx_fx_inst ~= nil then
        inst._vfx_fx_inst:Remove()
        inst._vfx_fx_inst = nil
    end
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

local function switchdrown(inst)
    local owner = inst.components.inventoryitem.owner
    if not owner then
        return false
    end
    if inst:HasTag("multithrust_mode") then
        inst:RemoveTag("multithrust_mode")

        owner.components.talker:Say("现在不能触发连刺攻击")
    else
        inst:AddTag("multithrust_mode")
        owner.components.talker:Say("现在可以触发连刺攻击")
    end
    return false
end

local function onsave(inst, data)
    data.purebrilliance_count = inst.purebrilliance_count or 0
end

local function onload(inst, data)
    if inst then
        if inst.components.finiteuses.current <= 0 then
            OnBroken(inst)
        end
    end

    if data then
        inst.purebrilliance_count = data.purebrilliance_count or 0
        if inst.purebrilliance_count == 1 then
            inst.components.planardamage:SetBaseDamage(20)
            inst.components.named:SetName("大精灵之杖+")
        else
            inst.components.planardamage:SetBaseDamage(10)
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

    inst.AnimState:SetBank("kkr_elfstaff_plus")
    inst.AnimState:SetBuild("kkr_elfstaff_plus")
    inst.AnimState:PlayAnimation("idle")

    inst.entity:SetPristine()

    inst:AddTag("meteor_protection")
    inst:AddTag("nosteal")
    inst:AddTag("NORATCHECK")
    inst:AddTag("multithrust_mode")
    inst:AddTag("sharp")

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

    inst.purebrilliance_count = 0

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(51)
    inst.components.weapon:SetRange(1.3)
    inst.components.weapon:SetOnAttack(OnAttack)

    inst:AddComponent("planardamage")
    inst.components.planardamage:SetBaseDamage(10)

    if KKRENV.KKR_LUNGE_ENABLE then
        inst:AddComponent("aoeweapon_lunge")
        inst.components.aoeweapon_lunge:SetDamage(51)
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
    inst.components.finiteuses:SetMaxUses(300)
    inst.components.finiteuses:SetUses(300)
    inst.components.finiteuses:SetOnFinished(OnFinished)

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/kkr_elfstaff_plus.xml"

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.equippable.walkspeedmult = 1.25
    inst.components.equippable.restrictedtag = "kkr"

    inst:AddComponent("useableitem")
    inst.components.useableitem:SetOnUseFn(switchdrown)

    inst:AddComponent("trader")
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader:SetAcceptTest(ShouldAcceptItem)

    inst:AddComponent("rechargeable")
    inst.components.rechargeable:SetMaxCharge(2)
    inst.components.rechargeable:SetOnDischargedFn(OnDischarged)
    inst.components.rechargeable:SetOnChargedFn(OnCharged)

    inst:AddComponent("named")

    inst.OnSave = onsave
    inst.OnLoad = onload

    return inst
end

return Prefab("kkr_elfstaff_plus", fn, assets, prefabs)
