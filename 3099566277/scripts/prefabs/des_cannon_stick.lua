local assets =
{
    Asset("ANIM", "anim/torch.zip"),
    Asset("ANIM", "anim/swap_torch.zip"),
    Asset("SOUND", "sound/common.fsb"),

    Asset("IMAGE", "images/inventoryimages/des_cannon_stick.tex"),
	Asset("ATLAS", "images/inventoryimages/des_cannon_stick.xml")
}

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_object", "swap_torch", "swap_torch")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal")
	
end

local function onunequip(inst, owner) 
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal") 
end


local function ReticuleTargetFn()
    return Vector3(ThePlayer.entity:LocalToWorldSpace(5, 0.001, 0)) -- raised this off the ground a touch so it wont have any z-fighting with the ground biome transition tiles.
end

local function slowdestroy(inst)
	if not inst then return end
	local time_to_erode = 1
	local tick_time = TheSim:GetTickTime()

	if inst and inst.DynamicShadow then
        inst.DynamicShadow:Enable(false)
    end

	inst:StartThread( function()
		local ticks = 0
		while ticks * tick_time < time_to_erode do
			local erode_amount = ticks * tick_time / time_to_erode
			inst.AnimState:SetErosionParams( erode_amount, 0.1, 1.0 )
			ticks = ticks + 1
			Yield()
		end
		inst:Remove()
	end)
end

local function SmokeIt(inst)
		print("SmokeIt")

	---local owner = self.inst.components.inventoryitem.owner
	if inst and (inst.guts_smoker == nil or not inst.guts_smoker) then
		print("ADDING WAND GLOW")
			inst.guts_smoker = SpawnPrefab("smoke_plant")
			local c = 1
			inst.guts_smoker.Transform:SetScale(c,c,c)
			inst.guts_smoker.entity:AddFollower()
			inst.guts_smoker.Follower:FollowSymbol(inst.GUID, "cannon", 35, 15, 0)

		local follower = inst.guts_smoker.entity:AddFollower()
		follower:FollowSymbol(inst.GUID, "cannon", 35, 15, 0)
		
		inst.guts_smoker.SoundEmitter:KillSound("smolder")
		inst.guts_smoker.Light:Enable(false)
		
		inst.guts_smoker:DoTaskInTime(4, function()
			slowdestroy(inst.guts_smoker)
			inst.guts_smoker = nil
		end)
		
	end
	
	
end

local function onthrown(cannon)

	TheWorld:PushEvent("screenflash", 0.2)
	for i, v in ipairs(AllPlayers) do
		v:ShakeCamera(CAMERASHAKE.FULL, 0.7, 0.02, 0.5, cannon, 40)
	end

	
	
	local owner = cannon
	local pt = owner:GetPosition()
	
	SmokeIt(owner)
	
	pt.y = pt.y + 1
	local fx_smoke = SpawnPrefab("collapse_small")
	fx_smoke.Transform:SetPosition(pt.x, pt.y, pt.z)
	local smoke_scale = 0.45
	fx_smoke.Transform:SetScale(smoke_scale,smoke_scale,smoke_scale)

	pt.y = pt.y - 1.25
	local fx_smoke2 = SpawnPrefab("fireball_hit_fx")
	fx_smoke2.Transform:SetPosition(pt.x, pt.y, pt.z)
	local smoke_scale2 = 0.8
	fx_smoke2.Transform:SetScale(smoke_scale2,smoke_scale2,smoke_scale2)
	
	
end



local function DoCannonShoot(inst, targetpos, cannon)
	if not cannon then return end

    local x1, y1, z1 = inst.Transform:GetWorldPosition()
	
	
	---Container:GetItemInSlot(slot)
	
    local projectile = cannon.components.container:GetItemInSlot(1)
	local cannonball_name
	
	for slot = 4, 1, -1 do
		if cannon.components.container:GetItemInSlot(slot) and cannon.components.container:GetItemInSlot(slot).components.complexprojectile then
			projectile = cannon.components.container:GetItemInSlot(slot)
		end
	end
	
	if not projectile then
		print("NO projectile")
		return
	end
	if not projectile.components.complexprojectile then return end
	
	
	cannonball_name = projectile.prefab
	print("cannonball_name")
	cannon.components.container:ConsumeByName(cannonball_name, 1)

    local x2, y2, z2 = cannon.Transform:GetWorldPosition()
	
	projectile = SpawnPrefab(cannonball_name)
	
	
	projectile.owner_rick = inst
	
    projectile.Transform:SetPosition(x2, 0, z2)

    --V2C: scale the launch speed based on distance
    --     because 15 does not reach our max range.
    local dx = targetpos.x - x2
    local dz = targetpos.z - z2
    local rangesq = dx * dx + dz * dz
    local maxrange = 20
	local speed = 25 --easing.linear(rangesq, 8, 1, maxrange * maxrange)
	local gravity = -15
	
	projectile.components.complexprojectile:SetHorizontalSpeed(speed)
    projectile.components.complexprojectile:SetGravity(gravity)


	onthrown(cannon) ---- cannon visuals

	cannon.AnimState:PlayAnimation("shoot")
	cannon.AnimState:PlayAnimation("idle", true)
	
	
	projectile.components.complexprojectile:Launch(targetpos, inst, cannon)
	
	projectile.explosive_allowed = true
	--
	local off_time = 1.5
	inst:DoTaskInTime(off_time, function()
		if projectile and projectile:IsValid() and projectile.Transform and projectile.components.complexprojectile then
			targetpos.y = 12
			
			projectile.Physics:SetMotorVel(0,0,0)
			projectile.Physics:Stop()
			
			projectile.Transform:SetPosition(targetpos.x, 0, targetpos.z)
			projectile.Physics:Teleport(targetpos:Get())
			--projectile.components.complexprojectile:Hit()
			
			local vel_y = -15


			projectile.components.complexprojectile.velocity.x, projectile.components.complexprojectile.velocity.y, projectile.components.complexprojectile.velocity.z = 0, vel_y, 0
	
			if cannon then
				--cannon.AnimState:PlayAnimation("idle")
			end
		end
	end)
		
end



local function ShootAllCannons(caster, targetpos)

	local x
	local y = 0
	local z
	local tar_pos

	if caster then
		tar_pos = caster:GetPosition()
	end

	if caster and tar_pos.x and tar_pos.z then
		x = tar_pos.x
		z = tar_pos.z
	else
		return
	end

	
	
	local cannon 
	
	---  Amplify by gems ---
	--amp_percent changes from 0 to 1
	---local amp_percent = self.magic_power/TUNING.SB_WAND_MAGIC_POWER_MAX
--	local wish_max_targets = math.ceil(math.max(WISH_GRANTER_MAX_TARGETS, amp_percent * (TUNING.SB_WAND_MAGIC_POWER_SPELLS[4][1])))
	local wish_max_range = 6 ---math.max(WISH_GRANTER_RANGE, amp_percent * (TUNING.SB_WAND_MAGIC_POWER_SPELLS[4][2]))

	---print("amp_percent, wish_max_targets, wish_max_range", amp_percent, wish_max_targets, wish_max_range)

    local x1, y1, z1 = caster.Transform:GetWorldPosition()
	local cur_boat = TheWorld.Map:GetPlatformAtPoint( x1, y1, z1 )
	
	
	
    local ents = TheSim:FindEntities(x1, y, z1, wish_max_range, nil, { "INLIMBO" })

	local j = 0

    for i, v in ipairs(ents) do
        if v ~= caster and v:IsValid() and not v:IsInLimbo() then
	
            if v.prefab == "des_bcannon"
			then
			
				local x2, y2, z2 = v.Transform:GetWorldPosition()
				local cannon_boat = TheWorld.Map:GetPlatformAtPoint(x2, y2, z2)
				
				if (cur_boat and cannon_boat and cannon_boat == cur_boat) or ( not cannon_boat and not cur_boat) then 
				--cannon = v
					DoCannonShoot(caster, targetpos, v)
				end
				--[[
                v.components.workable:WorkedBy(self.inst, WISH_GRANTER_EFFECT)

				---- Effect ----
				WishEffect(v)
				----------------

				j = j + 1
				print("j = "..j)
				if j >= wish_max_targets then
					print("WISH MAX TARGETS")
					break
				end--]]
			end



        end
    end

	return cannon
end








local easing = require("easing")
local function teleport_func(staff, tar, pos)
	local caster = staff.components.inventoryitem.owner
	ShootAllCannons(caster, pos)	
end




local function onattack_red(inst, attacker, target, skipsanity)

    if target:IsValid() then
		local pos = target:GetPosition()

		ShootAllCannons(attacker, pos)	
    end


   -- target:PushEvent("attacked", { attacker = attacker, damage = 0, weapon = inst })
end


local discription_variants =
 {	"I am the smartest thing on every conceivable universe.",
	"The Infinite Rick, a God.",
	"That's the three lines of math that separates my life as a man \n from my life as an unfeeling ghost.",
	"It produces sci-fi noises...",
	"A sort of breakthrough..."	
}

local function onperish(inst,owner)
	if inst.fire then
		inst.fire:Remove()
		inst.fire = nil
	end
end

local function fn()
	
	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)

	inst:AddTag("des_cannon_stick")

    inst.AnimState:SetBank("torch") 
    inst.AnimState:SetBuild("swap_torch")  
    inst.AnimState:PlayAnimation("idle")
    
	inst:AddTag("rangedweapon")
	inst:AddTag("allow_action_on_impassable")
	
    inst:AddComponent("reticule")
    inst.components.reticule.targetfn = ReticuleTargetFn
    inst.components.reticule.ease = true
	inst.components.reticule.reticuleprefab = "reticuleaoe"
	
    inst.spelltype = "SCIENCE"
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("spellcaster")
    inst.components.spellcaster:SetSpellFn(teleport_func)
    inst.components.spellcaster.quickcast = true
	inst.components.spellcaster.canuseonpoint = true
    inst.components.spellcaster.canuseonpoint_water = true	
	
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(0)
    inst.components.weapon:SetRange(15, 18)
    inst.components.weapon:SetOnAttack(onattack_red)
    --inst.components.weapon:SetProjectile("des_cannon_stick_missle")
	
	inst:AddComponent("inspectable")


    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "des_cannon_stick"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/des_cannon_stick.xml"

	
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
  
    MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
  
    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("des_cannon_stick", fn, assets)
