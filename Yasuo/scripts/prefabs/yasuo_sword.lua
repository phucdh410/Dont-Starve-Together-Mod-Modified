local assets = {
    Asset("ANIM", "anim/yasuo_sword.zip"),
    Asset("ANIM", "anim/swap_yasuo_sword.zip"),
    Asset("ANIM", "anim/swap_yasuo_sword_shine.zip"),
    Asset("ATLAS", "images/inventoryimages/yasuo_sword.xml"),
    Asset("IMAGE", "images/inventoryimages/yasuo_sword.tex"),
}

local function steel_tempest_fn(inst, doer, pos)
    local steel_tempest_fx = SpawnPrefab("shadowstrike_slash_fx")
    if steel_tempest_fx.AnimState then
        steel_tempest_fx.AnimState:SetBuild("yasuo_shadow_lunge_fx")
    end

    steel_tempest_fx.entity:AddFollower()
    steel_tempest_fx.Follower:FollowSymbol(doer.GUID, "swap_object", 0, -200, 0)
    steel_tempest_fx.Transform:SetScale(1.6, 1.6, 1.6)
    local x1, y1, z1 = doer.Transform:GetWorldPosition()
    local angle = doer:GetAngleToPoint(pos:Get()) * DEGREES
    for i = 1, 5 do
        local damage = CreateEntity()
        damage.entity:AddTransform()
        damage:AddTag("NOCLICK")
        damage:AddTag("FX")
        damage:AddTag("NOBLOCK")
        damage:AddTag("steel_tempest_damage")
        local dist = i * 1
        local newpos = Vector3(x1 + math.cos(angle) * dist, 0, z1 - math.sin(angle) * dist)
        local x2, y2, z2 = newpos:Get()
        damage.Transform:SetPosition(newpos:Get())
        local ents = TheSim:FindEntities(x2, y2, z2, 1, {"_combat", "_health"}, {"steel_tempest_damage", "FX", "INLIMBO", "DECOR", "player"})
        if ents ~= nil then
            for _, ent in pairs(ents) do
                if ent.components.combat and ent ~= doer and not doer.components.yasuo_skills.steel_tempest_hited_targets[ent] then
                    local dmg = doer.components.yasuo_skills.skills["steel_tempest"].damage(doer)
                    ent.components.combat:GetAttacked(doer, dmg)
                    doer.components.yasuo_skills.steel_tempest_hited_targets[ent] = true
                end
            end
        end
        damage:Remove()
    end
    if GetTableSize(doer.components.yasuo_skills.steel_tempest_hited_targets) > 0 then
        doer.components.yasuo_skills:AddSkillHit("steel_tempest", 1)
    end
    doer.components.yasuo_skills:DoSkill("steel_tempest")

    inst.components.rechargeable:Discharge(doer.components.yasuo_skills.skills["steel_tempest"].cd)
    return true
end

local function steel_tempest_tornado_fn(inst, doer, pos)
    doer.sg.mem.tornado = SpawnPrefab("yasuo_tornado")
    doer.sg.mem.tornado.Transform:SetPosition(doer.Transform:GetWorldPosition())
    doer.sg.mem.tornado.Transform:SetRotation(doer.Transform:GetRotation())
    doer.sg.mem.tornado.Physics:SetMotorVel(25, 0, 0)
    doer.sg.mem.tornado.CASTER = doer
    doer.sg.mem.tornado.CASTER_ISPLAYER = doer:HasTag("player")

    doer.components.yasuo_skills:DoSkill("steel_tempest")
    doer.components.yasuo_skills:ClearSkillHit("steel_tempest")
    inst.components.rechargeable:Discharge(doer.components.yasuo_skills.skills["steel_tempest"].cd)
    return true
end

local function Lunge(inst, doer, pos)
    if doer.components.yasuo_skills:ShouldDoSpecialSkill("steel_tempest") then
        return steel_tempest_tornado_fn(inst, doer, pos)
    else
        return steel_tempest_fn(inst, doer, pos)
    end
end

local function aoespellsg(inst, doer, action)
    return not doer.replica.rider:IsRiding() and "yasuo_steel_tempest_pre" or nil
end

local function onequip(inst, owner)
    local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("equipskinneditem", inst:GetSkinName())
        owner.AnimState:OverrideItemSkinSymbol("swap_object", skin_build, "swap_yasuo_sword", inst.GUID, "swap_yasuo_sword")
    else
        owner.AnimState:OverrideSymbol("swap_object", "swap_yasuo_sword", "swap_yasuo_sword")
    end
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
    local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("unequipskinneditem", inst:GetSkinName())
    end
end

local function Shine(inst)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetLightOverride(1)
end

local function StopShine(inst)
    inst.AnimState:ClearBloomEffectHandle()
    inst.AnimState:SetLightOverride(0)
end

local function ReticuleTargetFn()
    --Cast range is 8, leave room for error (6.5 lunge)
    return Vector3(ThePlayer.entity:LocalToWorldSpace(6.5, 0, 0))
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

local function OnAttack(inst, attacker, target)
    if attacker.in_last_breath_damageup then
        local fx = SpawnPrefab("winona_battery_high_shatterfx")
        fx.AnimState:SetLayer(LAYER_WORLD)
        local x, y, z = target.Transform:GetWorldPosition()
        fx.Transform:SetPosition(x, y + 1.5, z)
    end
    if attacker.components.yasuo_skills then
        attacker.components.yasuo_skills:UseWay(-3)
    end
end

local function OnDischarged(inst)
    inst.components.aoetargeting:SetEnabled(false)
end

local function OnCharged(inst)
    inst.components.aoetargeting:SetEnabled(true)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("yasuo_sword")
    inst.AnimState:SetBuild("yasuo_sword")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("sharp")
    inst:AddTag("pointy")
    inst:AddTag("weapon")
    inst:AddTag("rechargeable")
    inst:AddTag("yasuo_sword")

    MakeInventoryFloatable(inst, "med", 0.05, {1.1, 0.5, 1.1}, true, -9)

    inst:AddComponent("aoetargeting")
    inst.components.aoetargeting:SetAlwaysValid(true)
    inst.components.aoetargeting.reticule.reticuleprefab = "reticuleline"
    inst.components.aoetargeting.reticule.pingprefab = "reticulelineping"
    inst.components.aoetargeting.reticule.targetfn = ReticuleTargetFn
    inst.components.aoetargeting.reticule.mousetargetfn = ReticuleMouseTargetFn
    inst.components.aoetargeting.reticule.updatepositionfn = ReticuleUpdatePositionFn
    inst.components.aoetargeting.reticule.validcolour = { 1, .75, 0, 1 }
    inst.components.aoetargeting.reticule.invalidcolour = { .5, 0, 0, 1 }
    inst.components.aoetargeting.reticule.ease = true
    inst.components.aoetargeting.reticule.mouseenabled = true

    inst.yasuo_aoespellsg = aoespellsg

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(YASUO.SWORD.DAMAGE)
    inst.components.weapon:SetOnAttack(OnAttack)

    inst:AddComponent("aoespell")
    inst.components.aoespell:SetSpellFn(Lunge)
    inst.components.aoespell.ispassableatallpoints = true

    --[[inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(YASUO.SWORD.USES)
    inst.components.finiteuses:SetUses(YASUO.SWORD.USES)
    inst.components.finiteuses:SetOnFinished(inst.Remove)]]

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "yasuo_sword"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/yasuo_sword.xml"

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.equippable.restrictedtag = "yasuo"

    inst:AddComponent("rechargeable")
    inst.components.rechargeable:SetOnDischargedFn(OnDischarged)
	inst.components.rechargeable:SetOnChargedFn(OnCharged)

    inst.Shine = Shine
    inst.StopShine = StopShine

    MakeHauntableLaunch(inst)

    return inst
end

RegisterInventoryItemAtlas("images/inventoryimages/yasuo_sword.xml", "images/inventoryimages/yasuo_sword.tex")

return Prefab("yasuo_sword", fn, assets)