local assets = {
    Asset('ANIM', 'anim/swap_xxx3_flgun.zip'),
    Asset('ANIM', 'anim/xxx3_flgun.zip'),
    Asset('IMAGE', 'images/xxx3_flgun.tex'),
    Asset('ATLAS', 'images/xxx3_flgun.xml')
}

local assets_projectile = {
    Asset('ANIM', 'anim/xxx3_flgun_projectile.zip'),
    Asset('ANIM', 'anim/explode.zip')
}

local assets_plant = {
    Asset('ANIM', 'anim/xxx3_flgun_plant.zip')
}

local brain = require 'brains/eyeturretbrain'

local function transferEverything(inst, obj)
    if inst.components.container and not inst.components.container:IsEmpty() then
        if obj.components.container then
            inst.components.container:Close()
            inst.components.container.canbeopened = false
            local allitems = inst.components.container:RemoveAllItems()
            for i, v in ipairs(allitems) do
                obj.components.container:GiveItem(v)
            end
        end
    end
end

local function onequip(inst, owner, force)
    owner.AnimState:OverrideSymbol('swap_object', 'swap_xxx3_flgun', 'swap_xxx3_flgun')
    owner.AnimState:Show('ARM_carry')
    owner.AnimState:Hide('ARM_normal')
    inst.components.container:Open(owner)
end

local function onunequip(inst, owner)
    owner.AnimState:ClearOverrideSymbol('swap_object')
    owner.AnimState:Hide('ARM_carry')
    owner.AnimState:Show('ARM_normal')
    inst.components.container:Close(owner)
end

local function ondeploy(inst, pt, deployer)
    local plant = SpawnPrefab('xxx3_flgun_plant')
    if plant ~= nil then
        plant.Physics:SetCollides(false)
        plant.Physics:Teleport(pt.x, 0, pt.z)
        plant.Physics:SetCollides(true)
        transferEverything(inst, plant)
        inst:Remove()
    end
end

local function OnProjectileLaunched(inst, attacker, target)
    if inst.components.container ~= nil then
        local ammo_stack = inst.components.container:GetItemInSlot(1)
        local item = inst.components.container:RemoveItem(ammo_stack, false)
        if item ~= nil then
            item:Remove()
        end
    end
end

local function OnAmmoLoaded(inst, data)
    if inst.components.weapon ~= nil then
        if data ~= nil and data.item ~= nil then
            if data.item.prefab == 'xxx3_ydg' then
                inst.components.weapon:SetProjectile('xxx3_flgun_projectile2')
            elseif data.item.prefab == 'xxx3_pollen' then
                inst.components.weapon:SetProjectile('xxx3_flgun_projectile1')
            elseif data.item.prefab == 'nl_essence_nature' then
                inst.components.weapon:SetProjectile('xxx3_flgun_projectile3')
            elseif data.item.prefab == 'xxx3_seed' then
                inst.components.weapon:SetProjectile('xxx3_flgun_projectile4')
            elseif data.item.prefab == 'xxx3_chydg' then
                inst.components.weapon:SetProjectile('xxx3_flgun_projectile5')
            else
                inst:DoTaskInTime(
                    0.5,
                    function()
                        inst.components.container:DropEverything()
                    end
                )
            end
        end
    end
end

local function OnAmmoUnloaded(inst, data)
    if inst.components.weapon ~= nil then
        inst.components.weapon:SetProjectile(nil)
    end
end

local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst:AddTag('xxx3_shoot')

    inst.AnimState:SetBank('xxx3_flgun')
    inst.AnimState:SetBuild('xxx3_flgun')
    inst.AnimState:PlayAnimation('idle')

    inst.Transform:SetScale(1.3, 1.3, 1.3)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        inst.OnEntityReplicated = function(inst)
            if inst.replica.container then
                inst.replica.container:WidgetSetup('xxx3_flgun')
            end
        end
        return inst
    end

    inst:AddComponent('inspectable')

    inst:AddComponent('weapon')
    inst.components.weapon:SetRange(12, 15)
    inst.components.weapon:SetDamage(0)
    inst.components.weapon:SetProjectile(nil)
    -- inst.components.weapon.attackwear = 0
    inst.components.weapon:SetOnProjectileLaunched(OnProjectileLaunched)

    inst:AddComponent('container')
    inst.components.container:WidgetSetup('xxx3_flgun')
    inst:ListenForEvent('itemget', OnAmmoLoaded)
    inst:ListenForEvent('itemlose', OnAmmoUnloaded)

    inst:AddComponent('inventoryitem')
    inst.components.inventoryitem.imagename = 'xxx3_flgun'
    inst.components.inventoryitem.atlasname = 'images/xxx3_flgun.xml'

    inst:AddComponent('equippable')
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    inst:AddComponent('deployable')
    inst.components.deployable.ondeploy = ondeploy

    return inst
end

------------------------------------------------------------------

local RETARGET_MUST_TAGS = {'_combat'}
local RETARGET_CANT_TAGS = {'INLIMBO', 'player', 'companion', 'eyeplant', 'lureplant', 'abigail'}
local function retargetfn(inst)
    local playertargets = {}
    for i = 1, #AllPlayers do
        local v = AllPlayers[i]
        if v.components.combat.target ~= nil then
            playertargets[v.components.combat.target] = true
        end
    end

    return FindEntity(
        inst,
        15,
        function(guy)
            return (playertargets[guy] or
                (guy.components.combat.target ~= nil and guy.components.combat.target:HasTag('player'))) and
                inst.components.combat:CanTarget(guy)
        end,
        RETARGET_MUST_TAGS,
        RETARGET_CANT_TAGS
    )
end

local function shouldKeepTarget(inst, target)
    return target ~= nil and target:IsValid() and target.components.health ~= nil and
        not target.components.health:IsDead() and
        inst:IsNear(target, 20)
end

local function onopen(inst)
    inst.SoundEmitter:PlaySound('dontstarve/wilson/chest_open')
end

local function onclose(inst)
    inst.SoundEmitter:PlaySound('dontstarve/wilson/chest_close')
end

local function OnProjectileLaunched_Plant(inst, attacker, target)
    local owner = inst.components.inventoryitem.owner
    if owner.components.container ~= nil then
        local ammo_stack = owner.components.container:GetItemInSlot(1)
        local item = owner.components.container:RemoveItem(ammo_stack, false)
        if item ~= nil then
            item:Remove()
        end
    end
end

local function OnAmmoLoaded_Plant(inst, data)
    local weapon = inst.components.combat:GetWeapon()
    if weapon ~= nil and weapon.components.weapon ~= nil then
        if data ~= nil and data.item ~= nil then
            if data.item.prefab == 'xxx3_ydg' then
                weapon.components.weapon:SetProjectile('xxx3_flgun_projectile2')
            elseif data.item.prefab == 'xxx3_pollen' then
                weapon.components.weapon:SetProjectile('xxx3_flgun_projectile1')
            elseif data.item.prefab == 'nl_essence_nature' then
                weapon.components.weapon:SetProjectile('xxx3_flgun_projectile3')
            elseif data.item.prefab == 'xxx3_seed' then
                weapon.components.weapon:SetProjectile('xxx3_flgun_projectile4')
            elseif data.item.prefab == 'xxx3_chydg' then
                weapon.components.weapon:SetProjectile('xxx3_flgun_projectile5')
            else
                inst:DoTaskInTime(
                    0.5,
                    function()
                        inst.components.container:DropEverything()
                    end
                )
            end
        end
    end
end

local function OnAmmoUnloaded_Plant(inst, data)
    local weapon = inst.components.combat:GetWeapon()
    if weapon.components.weapon ~= nil then
        weapon.components.weapon:SetProjectile(nil)
    end
end

local function EquipWeapon(inst)
    if inst.components.inventory and not inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
        local weapon = CreateEntity()
        weapon.entity:AddTransform()
        weapon:AddComponent('weapon')
        weapon.components.weapon:SetDamage(0)
        weapon.components.weapon:SetRange(12, 15)
        weapon.components.weapon:SetProjectile(nil)
        weapon.components.weapon:SetOnProjectileLaunched(OnProjectileLaunched_Plant)
        weapon:AddComponent('inventoryitem')
        weapon.persists = false
        weapon.components.inventoryitem:SetOnDroppedFn(weapon.Remove)
        weapon:AddComponent('equippable')

        inst.components.inventory:Equip(weapon)
        if inst.components.container.slots[1] ~= nil then
            if inst.components.container.slots[1].prefab == 'xxx3_ydg' then
                weapon.components.weapon:SetProjectile('xxx3_flgun_projectile2')
            elseif inst.components.container.slots[1].prefab == 'xxx3_pollen' then
                weapon.components.weapon:SetProjectile('xxx3_flgun_projectile1')
            elseif inst.components.container.slots[1].prefab == 'nl_essence_nature' then
                weapon.components.weapon:SetProjectile('xxx3_flgun_projectile3')
            elseif inst.components.container.slots[1].prefab == 'xxx3_seed' then
                weapon.components.weapon:SetProjectile('xxx3_flgun_projectile4')
            elseif inst.components.container.slots[1].prefab == 'xxx3_chydg' then
                weapon.components.weapon:SetProjectile('xxx3_flgun_projectile5')
            else
                inst:DoTaskInTime(
                    0.5,
                    function()
                        inst.components.container:DropEverything()
                    end
                )
            end
        end
    end
end

local function ondigged(inst, worker)
    local flgun = SpawnPrefab('xxx3_flgun')
    if flgun ~= nil then
        transferEverything(inst, flgun)
        flgun.Transform:SetPosition(inst.Transform:GetWorldPosition())
        flgun.components.inventoryitem:OnDropped(true)
        inst:Remove()
    end
end

local function fn_plant()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank('xxx3_flgun_plant')
    inst.AnimState:SetBuild('xxx3_flgun_plant')
    inst.AnimState:PlayAnimation('idle')

    inst.Transform:SetFourFaced()
    inst.Transform:SetScale(1.3, 1.3, 1.3)

    inst.entity:SetPristine()

    inst:AddTag('companion')

    if not TheWorld.ismastersim then
        inst.OnEntityReplicated = function(inst)
            if inst.replica.container then
                inst.replica.container:WidgetSetup('xxx3_flgun_plant')
            end
        end
        return inst
    end

    inst:AddComponent('inspectable')

    inst:AddComponent('combat')
    inst.components.combat:SetRange(12)
    inst.components.combat:SetDefaultDamage(0)
    inst.components.combat:SetAttackPeriod(2)
    inst.components.combat:SetRetargetFunction(1, retargetfn)
    inst.components.combat:SetKeepTargetFunction(shouldKeepTarget)

    inst:AddComponent('inventory')
    inst:DoTaskInTime(1, EquipWeapon)

    inst:AddComponent('container')
    inst.components.container:WidgetSetup('xxx3_flgun_plant')
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
    inst:ListenForEvent('itemget', OnAmmoLoaded_Plant)
    inst:ListenForEvent('itemlose', OnAmmoUnloaded_Plant)

    inst:AddComponent('preserver')
    inst.components.preserver:SetPerishRateMultiplier(0)

    inst:AddComponent('workable')
    inst.components.workable:SetWorkAction(ACTIONS.DIG)
    inst.components.workable:SetWorkLeft(1)
    inst.components.workable:SetOnFinishCallback(ondigged)

    inst:SetStateGraph('SGxxx3_flgun_plant')
    inst:SetBrain(brain)

    return inst
end

------------------------------------------------------------------

local function SpikeLaunch(inst, launcher, basespeed, startheight)
    local x0, y0, z0 = launcher.Transform:GetWorldPosition()
    local x1, y1, z1 = inst.Transform:GetWorldPosition()
    local dx, dz = x1 - x0, z1 - z0
    local dsq = dx * dx + dz * dz
    local angle
    if dsq > 0 then
        local dist = math.sqrt(dsq)
        angle = math.atan2(dz / dist, dx / dist) + (math.random() * 20 - 10) * DEGREES
    else
        angle = 2 * PI * math.random()
    end
    local sina, cosa = math.sin(angle), math.cos(angle)
    local speed = basespeed + math.random()
    -- inst.Physics:Teleport(x0 + startradius * cosa, startheight, z0 + startradius * sina)
    inst.Physics:SetVel(cosa * speed, speed * 5 + math.random() * 2, sina * speed)
end

local function DoToss(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local totoss = TheSim:FindEntities(x, 0, z, 4, {'_inventoryitem'}, {'locomotor', 'INLIMBO'})
    for i, v in ipairs(totoss) do
        if v.components.mine ~= nil then
            v.components.mine:Deactivate()
        end
        if not v.components.inventoryitem.nobounce and v.Physics ~= nil and v.Physics:IsActive() then
            SpikeLaunch(v, inst, 2, 0.2)
        end
    end
end

local function oncollide(inst, other)
    local attacker = inst.components.complexprojectile.attacker
    -- if other ~= attacker and attacker and attacker.components.combat and attacker.components.combat:CanTarget(other) then
    inst.components.complexprojectile:Hit(other)
    -- end
end

local INITIAL_LAUNCH_HEIGHT = 0.1
local SPEED = 8
local function launch_away(inst, position)
    local ix, iy, iz = inst.Transform:GetWorldPosition()
    inst.Physics:Teleport(ix, iy + INITIAL_LAUNCH_HEIGHT, iz)

    local px, py, pz = position:Get()
    local angle = (180 - inst:GetAngleToPoint(px, py, pz)) * DEGREES
    local sina, cosa = math.sin(angle), math.cos(angle)
    inst.Physics:SetVel(SPEED * cosa, 4 + SPEED, SPEED * sina)
end

local function do_water_explosion_effect(inst, affected_entity, owner, position)
    if affected_entity.components.oceanfishable ~= nil then
        if affected_entity.components.weighable ~= nil then
            affected_entity.components.weighable:SetPlayerAsOwner(owner)
        end

        local projectile = affected_entity.components.oceanfishable:MakeProjectile()

        local ae_cp = projectile.components.complexprojectile
        if ae_cp then
            ae_cp:SetHorizontalSpeed(16)
            ae_cp:SetGravity(-30)
            ae_cp:SetLaunchOffset(Vector3(0, 0.5, 0))
            ae_cp:SetTargetOffset(Vector3(0, 0.5, 0))

            local v_position = affected_entity:GetPosition()
            local launch_position = v_position + (v_position - position):Normalize() * SPEED
            ae_cp:Launch(launch_position, projectile)
        else
            launch_away(projectile, position)
        end
    elseif affected_entity.components.inventoryitem ~= nil then
        launch_away(affected_entity, position)
        affected_entity.components.inventoryitem:SetLanded(false, true)
    elseif affected_entity.waveactive then
        affected_entity:DoSplash()
    elseif
        affected_entity.components.workable ~= nil and
            affected_entity.components.workable:GetWorkAction() == ACTIONS.MINE
     then
        affected_entity.components.workable:WorkedBy(owner, TUNING.TRIDENT.SPELL.MINES)
    end
end

local function OnProjectileHit(inst, attacker, target)
    if inst:IsOnOcean(true) then
        local MUST_HAVE_SPELL_TAGS = nil
        local CANT_HAVE_SPELL_TAGS = {'INLIMBO', 'outofreach', 'DECOR'}
        local MUST_HAVE_ONE_OF_SPELL_TAGS = nil
        local FX_RADIUS = 1.25
        local owner = attacker
        local position = inst:GetPosition()
        local px, py, pz = position:Get()

        -- Do gameplay effects.
        local affected_entities =
            TheSim:FindEntities(px, py, pz, 4, MUST_HAVE_SPELL_TAGS, CANT_HAVE_SPELL_TAGS, MUST_HAVE_ONE_OF_SPELL_TAGS)
        for _, v in ipairs(affected_entities) do
            if v:IsOnOcean(false) then
                do_water_explosion_effect(inst, v, owner, position)
            end
        end

        local angle = GetRandomWithVariance(-45, 20)
        for _ = 1, 4 do
            angle = angle + 90
            local offset_x = FX_RADIUS * math.cos(angle * DEGREES)
            local offset_z = FX_RADIUS * math.sin(angle * DEGREES)
            local ox = px + offset_x
            local oz = pz - offset_z

            if TheWorld.Map:IsOceanTileAtPoint(ox, py, oz) and not TheWorld.Map:IsVisualGroundAtPoint(ox, py, oz) then
                local platform_at_point = TheWorld.Map:GetPlatformAtPoint(ox, oz)
                if platform_at_point ~= nil then
                    -- Spawn a boat leak slightly further in to help avoid being on the edge of the boat and sliding off.
                    local bx, by, bz = platform_at_point.Transform:GetWorldPosition()
                    if bx == ox and bz == oz then
                        platform_at_point:PushEvent(
                            'spawnnewboatleak',
                            {pt = Vector3(ox, 0, oz), leak_size = 'med_leak', playsoundfx = true}
                        )
                    else
                        local p_to_ox, p_to_oz = VecUtil_Normalize(bx - ox, bz - oz)
                        local ox_mod, oz_mod = ox + (0.5 * p_to_ox), oz + (0.5 * p_to_oz)
                        platform_at_point:PushEvent(
                            'spawnnewboatleak',
                            {pt = Vector3(ox_mod, 0, oz_mod), leak_size = 'med_leak', playsoundfx = true}
                        )
                    end

                    local boatphysics = platform_at_point.components.boatphysics
                    if boatphysics ~= nil then
                        boatphysics:ApplyForce(offset_x, -offset_z, 1)
                    end
                else
                    local fx = SpawnPrefab('crab_king_waterspout')
                    fx.Transform:SetPosition(ox, py, oz)
                end
            end
        end
    end

    SpawnAt('xxx3_flgun_projectile_hit', inst)

    local pos = inst:GetPosition()
    local x, y, z = pos:Get()
    local ents = TheSim:FindEntities(x, y, z, 4, nil, {'INLIMBO', 'NOCLICK'}, {'_combat'})

    for k, v in pairs(ents) do
        if v and v:IsValid() and v ~= attacker then
            local is_direct_hit = (v == target) or (k == 1)
            if
                v.components.combat and not (v.components.health and v.components.health:IsDead()) and
                    not v:HasTag('player')
             then
                if attacker ~= nil and attacker.components.combat ~= nil then
                    -- local weapon = attacker.components.combat:GetWeapon()
                    if attacker.components.combat.ignorehitrange then
                        attacker.components.combat:DoAttack(v, inst, inst, nil, is_direct_hit and 2 or 1)
                    else
                        attacker.components.combat.ignorehitrange = true
                        attacker.components.combat:DoAttack(v, inst, inst, nil, is_direct_hit and 2 or 1)
                        attacker.components.combat.ignorehitrange = false
                    end
                end
            end
        end
    end
    DoToss(inst)
    inst:Remove()
end

local function makebullet(name, scale, damage, spdamage, speed)
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddPhysics()
        inst.entity:AddNetwork()

        inst.Transform:SetScale(scale, scale, scale)

        inst.AnimState:SetBank('xxx3_flgun_projectile')
        inst.AnimState:SetBuild('xxx3_flgun_projectile')
        inst.AnimState:PlayAnimation('fall', true)
        inst.AnimState:SetLightOverride(1)

        inst.Physics:SetMass(1)
        inst.Physics:SetFriction(10)
        inst.Physics:SetDamping(5)
        inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
        inst.Physics:ClearCollisionMask()
        inst.Physics:CollidesWith(COLLISION.GROUND)
        inst.Physics:CollidesWith(COLLISION.OBSTACLES)
        inst.Physics:CollidesWith(COLLISION.CHARACTERS)
        inst.Physics:SetCapsule(0.02, 0.02)

        inst:AddTag('projectile')

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent('weapon')
        inst.components.weapon:SetDamage(damage)

        inst:AddComponent('planardamage')
        inst.components.planardamage:SetBaseDamage(spdamage)

        inst.Physics:SetCollisionCallback(oncollide)

        inst:AddComponent('complexprojectile')
        inst.components.complexprojectile:SetOnHit(OnProjectileHit)
        inst.components.complexprojectile:SetHorizontalSpeed(speed)
        inst.components.complexprojectile:SetGravity(-0.01)
        inst.components.complexprojectile:SetLaunchOffset(Vector3(1, 1.75, 0))
        inst.components.complexprojectile:SetTargetOffset(Vector3(-0.5, 0.5, 0))
        inst.components.complexprojectile.usehigharc = false

        inst:DoTaskInTime(
            1,
            function()
                inst.components.complexprojectile:SetGravity(-9.8)
            end
        )

        return inst
    end

    return Prefab(name, fn, assets_projectile)
end

local function hit_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddNetwork()

    inst:AddTag('FX')

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false
    inst:DoTaskInTime(1, inst.Remove)

    inst:SpawnChild('xxx3_flgun_projectile_hit_vfxeffect')
    inst:DoTaskInTime(
        0,
        function()
            ShakeAllCameras(CAMERASHAKE.FULL, .7, .02, 1, inst, 40)
        end
    )

    return inst
end

return Prefab('xxx3_flgun', fn, assets), Prefab('xxx3_flgun_plant', fn_plant, assets_plant), makebullet(
    'xxx3_flgun_projectile1',
    0.8,
    50,
    0,
    37
), makebullet('xxx3_flgun_projectile2', 0.95, 500, 0, 35), makebullet('xxx3_flgun_projectile3', 0.9, 75, 0, 35), makebullet(
    'xxx3_flgun_projectile4',
    0.9,
    50,
    25,
    35
), makebullet('xxx3_flgun_projectile5', 1, 250, 500, 35), Prefab('xxx3_flgun_projectile_hit', hit_fn), MakePlacer(
    'common/xxx3_flgun_placer',
    'xxx3_flgun_plant',
    'xxx3_flgun_plant',
    'idle'
)
