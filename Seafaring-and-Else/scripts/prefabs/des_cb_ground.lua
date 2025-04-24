local assets =
{
	Asset("ANIM", "anim/des_cannonballs_ground.zip"),
	Asset("ANIM", "anim/des_cannonballs_air.zip"),
	
	
	
	Asset("IMAGE", "images/inventoryimages/des_cannonball_stone.tex"),
	Asset("ATLAS", "images/inventoryimages/des_cannonball_stone.xml"),
	
	Asset("IMAGE", "images/inventoryimages/des_cannonball_red.tex"),
	Asset("ATLAS", "images/inventoryimages/des_cannonball_red.xml"),
	
	Asset("IMAGE", "images/inventoryimages/des_cannonball_glass.tex"),
	Asset("ATLAS", "images/inventoryimages/des_cannonball_glass.xml"),
}

local BOMB_DAMAGE = {
	stone = TUNING.DES_CB_SMALL_DAMAGE,
	red = TUNING.DES_CB_RED_DAMAGE,
	glass = TUNING.DES_CB_GLASS_DAMAGE,
}

local BOMB_RANGE = {
	stone = 3,
	red = 3,
	glass = 4,
}

local BOMB_BUILDINGDAMAGE = {
	stone = 5,
	red = 10,
	glass = 0,
}

local function OnExplodeFn(inst)
    inst.SoundEmitter:KillSound("hiss")
    SpawnPrefab("explode_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
end

local function OnHitWater(inst, attacker, target)
	if inst.explosive_allowed then

		local pt = inst:GetPosition()    
		local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 3)
		for i, v in ipairs(ents) do
			if v.components.health ~= nil and v.components.combat ~= nil then
				v.components.combat:SuggestTarget(attacker)
			end
		end

		inst.SoundEmitter:KillSound("hiss")
		inst.SoundEmitter:PlaySound("dontstarve/common/dropwood")
		
		local houndfire1

		if inst.explosive_tag == "red" then
			local offset = 2
			for i = 1, 3, 1 do
				houndfire1 = SpawnPrefab("houndfire")
				houndfire1.Transform:SetPosition(pt.x+math.random(-offset,offset), pt.y, pt.z+math.random(-offset,offset))	
			end
			for i = 1, 3, 1 do
				houndfire1 = SpawnPrefab("deer_fire_burst")
				houndfire1.Transform:SetPosition(pt.x+math.random(-offset,offset), pt.y, pt.z+math.random(-offset,offset))	
			end
			
		elseif inst.explosive_tag == "glass" then
			local offset = 2
			for i = 1, 3, 1 do
				houndfire1 = SpawnPrefab("gestalt")
				houndfire1.Transform:SetPosition(pt.x+math.random(-offset,offset), pt.y, pt.z+math.random(-offset,offset))	
			end	
		end
		
		inst.components.explosive:OnBurnt()
		
		if inst.explosive_tag == "glass" then
			local glass_fx = SpawnPrefab("glass_fx")
			glass_fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
			
			local mining_ice_fx = SpawnPrefab("mining_ice_fx")
			mining_ice_fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
			
			local mining_moonglass_fx = SpawnPrefab("mining_moonglass_fx")
			mining_moonglass_fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
		end
        
        local platform=TheWorld.Map:GetPlatformAtPoint(pt.x, pt.y, pt.z)
        
        if platform~=nil then
            local platform_damage=BOMB_DAMAGE[inst.explosive_tag]/4
            local damage_percent=platform_damage/platform.components.health.maxhealth
            local leak_size
            if damage_percent>.4 then
                leak_size="med_leak"
            elseif damage_percent>.25 then
                leak_size="small_leak"
            elseif damage_percent>.1 then
                if math.random()>.7 then
                    leak_size="small_leak"
                end
            end
            if leak_size~=nil then
                local leak=SpawnPrefab("boat_leak")
                leak.components.boatleak.isdynamic=true
                leak.components.boatleak:SetState(leak_size)
                leak.components.boatleak:SetBoat(platform)
                leak.Transform:SetPosition(pt.x, pt.y, pt.z)
                table.insert(platform.components.hullhealth.leak_indicators_dynamic,leak)
            end
            platform.components.health:DoDelta(-platform_damage,nil,inst.prefab)
        end

		inst:Remove()
	else
		inst.AnimState:SetBuild("des_cannonballs_ground")
		inst.AnimState:SetBank("des_cannonballs_ground")
		inst.AnimState:PlayAnimation(inst.explosive_tag)
		inst:RemoveTag("NOCLICK")
		inst.persists = true

		inst.components.inventoryitem.sinks = true
		
		inst.SoundEmitter:KillSound("hiss")
		inst.SoundEmitter:PlaySound("dontstarve/common/dropwood")
		
		inst.Physics:ClearCollisionMask()
		MakeInventoryPhysics(inst)
		
		local pt = inst:GetPosition()
		
		inst.Transform:SetPosition(pt.x, pt.y, pt.z)
	end
end

local function onthrown(inst)
	inst.AnimState:SetBuild("des_cannonballs_air")
	inst.AnimState:SetBank("des_cannonballs_air")
	inst.AnimState:PlayAnimation(inst.explosive_tag)
		
	if inst.explosive_allowed then
        inst:AddTag("NOCLICK")
        inst.persists = false

        inst.SoundEmitter:PlaySound("dontstarve/common/blackpowder_fuse_LP", "hiss")
        inst.Physics:SetMass(1)
        inst.Physics:SetCapsule(0.2, 0.2)
        inst.Physics:SetFriction(0)
        inst.Physics:SetDamping(0)
        inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
        inst.Physics:ClearCollisionMask()
        inst.Physics:CollidesWith(COLLISION.WORLD)
        --inst.Physics:CollidesWith(COLLISION.OBSTACLES)
        --inst.Physics:CollidesWith(COLLISION.ITEMS)
	else
		inst.components.inventoryitem.sinks = nil
	end
end


local function defaultfn(tag)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddDynamicShadow()
	
    inst.entity:AddSoundEmitter()
	
	inst.entity:AddNetwork()
	MakeInventoryPhysics(inst)

	anim:SetBuild("des_cannonballs_ground")
	anim:SetBank("des_cannonballs_ground")
	anim:PlayAnimation(tag)

	inst.entity:SetPristine()

    inst.DynamicShadow:SetSize(1, .5)
	
    if not TheWorld.ismastersim then
        return inst
    end

	inst.explosive_tag = tag
	
	local s = 2	
	inst.Transform:SetScale(s,s,s)	

	inst:AddComponent("inspectable")
	-----------------
	inst:AddComponent("stackable")
	--inst.components.stackable.maxsize = TUNING.DES_CB_STACKSIZE
	----------------------

    inst:AddComponent("lootdropper")

	
	inst:AddComponent("locomotor")

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(10)
    inst.components.weapon:SetRange(2, 3)
	
    inst:AddComponent("explosive")
    inst.components.explosive:SetOnExplodeFn(OnExplodeFn)
	inst.components.explosive.explosivedamage = BOMB_DAMAGE[tag]
	inst.components.explosive.explosiverange = BOMB_RANGE[tag]
    inst.components.explosive.buildingdamage = BOMB_BUILDINGDAMAGE[tag]
	inst.components.explosive.lightonexplode = false

    inst:AddComponent("complexprojectile")
	
    inst.components.complexprojectile:SetHorizontalSpeed(15)
    inst.components.complexprojectile:SetGravity(-35)
    inst.components.complexprojectile:SetLaunchOffset(Vector3(.25, 1, 0))
    inst.components.complexprojectile:SetOnLaunch(onthrown)
    inst.components.complexprojectile:SetOnHit(OnHitWater)
    
	
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "des_cannonball_"..tag
	inst.components.inventoryitem.atlasname = "images/inventoryimages/des_cannonball_"..tag..".xml"
	inst.components.inventoryitem.sinks = true
	
	return inst
end

return Prefab("des_cb_ground_stone", function() return defaultfn("stone") end , assets),
 Prefab("des_cb_ground_red", function() return defaultfn("red") end , assets),
  Prefab("des_cb_ground_glass", function() return defaultfn("glass") end , assets)