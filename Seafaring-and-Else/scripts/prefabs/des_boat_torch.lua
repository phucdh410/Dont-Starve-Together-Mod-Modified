local assets =
{
    Asset("ANIM", "anim/des_boat_torch.zip"),
    Asset("SOUND", "sound/wilson.fsb"),
}

local prefabs =
{
    "lanternlight",
}

local function DoTurnOffSound(inst)
    inst._soundtask = nil
    inst.SoundEmitter:PlaySound("dontstarve/wilson/lantern_off")
end

local function PlayTurnOffSound(inst)
    if inst._soundtask == nil and inst:GetTimeAlive() > 0 then
        inst._soundtask = inst:DoTaskInTime(0, DoTurnOffSound, inst)
    end
end

local function PlayTurnOnSound(inst)
    if inst._soundtask ~= nil then
        inst._soundtask:Cancel()
        inst._soundtask = nil
    elseif not POPULATING then
        inst._light.SoundEmitter:PlaySound("dontstarve/wilson/lantern_on")
    end
end

local function fuelupdate(inst)
    if inst._light ~= nil then
        local fuelpercent = inst.components.fueled:GetPercent()
        inst._light.Light:SetIntensity(Lerp(.5, .6, fuelpercent))
        inst._light.Light:SetRadius(Lerp(1, 2, fuelpercent))
        inst._light.Light:SetFalloff(.9)
    end
end

local function onremovelight(light)
    light._lantern._light = nil
end



local function turnon(inst)
    if not inst.components.fueled:IsEmpty() then
        inst.components.fueled:StartConsuming()


        if inst._light == nil then
            inst._light = SpawnPrefab("lanternlight")
            inst._light._lantern = inst
            inst:ListenForEvent("onremove", onremovelight, inst._light)
            fuelupdate(inst)
            PlayTurnOnSound(inst)
        end
        inst._light.entity:SetParent(inst.entity)


		inst.AnimState:ClearOverrideSymbol("glow")


        inst.components.machine.ison = true
        inst:PushEvent("lantern_on")
    end
end

local function turnoff(inst)

    inst.components.fueled:StopConsuming()

    if inst._light ~= nil then
        inst._light:Remove()
        PlayTurnOffSound(inst)
    end

	inst.AnimState:OverrideSymbol("glow", "des_boat_torch", "dummy")
	

    inst.components.machine.ison = false
    inst:PushEvent("lantern_off")
end

local function OnRemove(inst)
    if inst._light ~= nil then
        inst._light:Remove()
    end
    if inst._soundtask ~= nil then
        inst._soundtask:Cancel()
    end
end

local function ondropped(inst)
    turnoff(inst)
    turnon(inst)
end





--------------------------------------------------------------------------

local function OnLightWake(inst)
    if not inst.SoundEmitter:PlayingSound("loop") then
        inst.SoundEmitter:PlaySound("dontstarve/wilson/lantern_LP", "loop")
    end
end

local function OnLightSleep(inst)
    inst.SoundEmitter:KillSound("loop")
end








local function GetDescription(inst)
    return "Fuel "..math.ceil(inst.components.fueled:GetPercent()*100).."%."
end




local function LightAllLanterns(caster, should_turn_on_off, turn_on, max_fuel)

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
	local wish_max_range = 16 ---math.max(WISH_GRANTER_RANGE, amp_percent * (TUNING.SB_WAND_MAGIC_POWER_SPELLS[4][2]))

	---print("amp_percent, wish_max_targets, wish_max_range", amp_percent, wish_max_targets, wish_max_range)

	--- /amplify by gems ---
    local x1, y1, z1 = caster.Transform:GetWorldPosition()
	local cur_boat = TheWorld.Map:GetPlatformAtPoint( x1, y1, z1 )
	
	
	--local projectile = SpawnPrefab("des_bcannon")
   -- projectile.Transform:SetPosition(x1, 0, z1)	
	
    local ents = TheSim:FindEntities(x1, y, z1, wish_max_range, nil, { "INLIMBO" })

	local fuel = 0
	
	local j = 0

	
	if should_turn_on_off then
	
	print("should_turn_on_off!")
	
    for i, v in ipairs(ents) do
        if v:IsValid() and not v:IsInLimbo() then
	
            if v.prefab == "des_boat_torch"
			then
			
				local x5, y5, z5 = v.Transform:GetWorldPosition()
				local cannon_boat = TheWorld.Map:GetPlatformAtPoint( x5, y5, z5 )
				
				if (cur_boat and cannon_boat and cannon_boat == cur_boat) or ( not cannon_boat and not cur_boat) then 
					if turn_on == true then
						turnon(v)
					elseif turn_on == false then
						turnoff(v)
					end
					if max_fuel and v.components.fueled.currentfuel > fuel then
						fuel = v.components.fueled.currentfuel
						print("fuel", fuel)
					end
				end

			end



        end
    end

	end
	
	j = 0
	
	if max_fuel then
	
	print("changeing fuel!")
	
    for i, v in ipairs(ents) do
        if v:IsValid() and not v:IsInLimbo() then
	
            if v.prefab == "des_boat_torch"
			then
			
				local x5, y5, z5 = v.Transform:GetWorldPosition()
				local cannon_boat = TheWorld.Map:GetPlatformAtPoint( x5, y5, z5 )
				
				if (cur_boat and cannon_boat and cannon_boat == cur_boat) or ( not cannon_boat and not cur_boat) then 
					if v.components.fueled.currentfuel < fuel then
						v.components.fueled.currentfuel = fuel
					end
				end

			end



        end
    end
	
	end
	
	
	
	
	return cannon
end


local function nofuel(inst)
	turnoff(inst)
end

local function ontakefuel(inst)
   -- if inst.components.equippable:IsEquipped() then
   
	LightAllLanterns(inst, true, true, true)   
	--turnon(inst)
    --end
end

local function OnWorked(inst)
    -- inst.AnimState:PlayAnimation("hit")
    -- inst.AnimState:PushAnimation("idle", true)
	turnoff(inst)
    inst.SoundEmitter:PlaySound("dontstarve/common/together/catapult/hit")
end

local function OnWorkFinished(inst)
    inst.components.workable:SetWorkable(false)
    inst:AddTag("NOCLICK")
    inst.persists = false
    -- if inst.components.burnable ~= nil then
        -- if inst.components.burnable:IsBurning() then
            -- inst.components.burnable:Extinguish()
        -- end
        -- inst.components.burnable.canlight = false
    -- end

    ---inst.SoundEmitter:PlaySound("dontstarve/common/together/spot_light/destroy")
	
	---inst.components.lootdropper:DropLoot()
	
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("none")
    
	inst:Remove()
end

--------------------------------------------------------------------------

local function onbuilt(inst, data)	
    local x1, y1, z1 = inst.Transform:GetWorldPosition()
	local cur_boat = TheWorld.Map:GetPlatformAtPoint( x1, y1, z1 )

	print("des_boat_torch ON built")
	if (not cur_boat) or (cur_boat and not cur_boat.components.walkableplatform) then
		print("No boat ON built")

	return end
	
	local boat_x, boat_y, boat_z = cur_boat.Transform:GetWorldPosition()

	local radius = cur_boat.components.walkableplatform.platform_radius * 0.66
	
	local torch1 = SpawnPrefab("des_boat_torch")
	torch1.Transform:SetPosition(boat_x + radius, boat_y, boat_z + radius)

	local torch2 = SpawnPrefab("des_boat_torch")
	torch2.Transform:SetPosition(boat_x - radius, boat_y, boat_z - radius)

	local torch3 = SpawnPrefab("des_boat_torch")
	torch3.Transform:SetPosition(boat_x + radius, boat_y, boat_z - radius)

	local torch4 = SpawnPrefab("des_boat_torch")
	torch4.Transform:SetPosition(boat_x - radius, boat_y, boat_z + radius)

	if radius > 4 then
	local torch5 = SpawnPrefab("des_boat_torch")
	torch5.Transform:SetPosition(boat_x, boat_y, boat_z)	
	end

	inst:Remove()
end

--------------------------------------------------------------------------

local function lanternlightfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst:AddTag("FX")

    inst.Light:SetColour(245 / 255, 60 / 255, 24 / 255)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    inst.OnEntityWake = OnLightWake
    inst.OnEntitySleep = OnLightSleep

    return inst
end





local function onsave(inst, data)
	data.des_boat_torch_fuel = inst.components.fueled.currentfuel
	print("loaded", data.des_boat_torch_fuel)
end

local function onload(inst, data)
    if data ~= nil and data.des_boat_torch_fuel ~= nil then
		inst:DoTaskInTime(0.1, function()
			print("loaded", data.des_boat_torch_fuel)
			inst.components.fueled.currentfuel = data.des_boat_torch_fuel
		end)
	end
end



local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
   -- inst.Transform:SetFourFaced()

   -- MakeObstaclePhysics(inst, 0.01)

    inst.AnimState:SetBank("des_boat_torch")
    inst.AnimState:SetBuild("des_boat_torch")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("light")

    --MakeInventoryFloatable(inst, "med", 0.2, 0.65)

	inst.AnimState:OverrideSymbol("glow", "des_boat_torch", "dummy")
	
    local s = 1.25
    inst.Transform:SetScale(s,s,s)
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
    inst.components.inspectable.getspecialdescription=GetDescription
    inst.components.inspectable.nameoverride = "torch"
	

    inst:AddComponent("fueled")

    inst:AddComponent("machine")
    inst.components.machine.turnonfn = function(inst) LightAllLanterns(inst, true, true, true) end  --(caster, should_turn_on_off, turn_on, max_fuel)
    inst.components.machine.turnofffn = function(inst) LightAllLanterns(inst, true, false, true) end
    inst.components.machine.cooldowntime = 1

	--[[
	if (not TUNING.DES_BOAT_TORCH_LIFETIME_FUELTYPE) or (TUNING.DES_BOAT_TORCH_LIFETIME_FUELTYPE == 0) then
	
	
	elseif TUNING.DES_BOAT_TORCH_LIFETIME_FUELTYPE == 1 then
		inst.components.fueled.fueltype = FUELTYPE.CAVE
		
	elseif TUNING.DES_BOAT_TORCH_LIFETIME_FUELTYPE == 2 then		
		inst.components.fueled.fueltype = FUELTYPE.NIGHTMARE

	end	
	--]]
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(3)
    inst.components.workable:SetOnWorkCallback(OnWorked)
    inst.components.workable:SetOnFinishCallback(OnWorkFinished)

	
    inst.components.fueled:InitializeFuelLevel(TUNING.DES_BOAT_TORCH_LIFETIME)
	inst.components.fueled.bonusmult = 1*TUNING.DES_BOAT_TORCH_LIFETIME_FUELMULT
	
    inst.components.fueled:SetDepletedFn(nofuel)
    inst.components.fueled:SetUpdateFn(fuelupdate)
    inst.components.fueled:SetTakeFuelFn(ontakefuel)
    inst.components.fueled:SetFirstPeriod(TUNING.TURNON_FUELED_CONSUMPTION, TUNING.TURNON_FULL_FUELED_CONSUMPTION)
    inst.components.fueled.accepting = true

    inst._light = nil

	
	
    inst:ListenForEvent("onbuilt", onbuilt)
	
	inst.OnLoad = onload
    inst.OnSave = onsave
	
    ---MakeHauntableLaunch(inst)

    -- inst.components.equippable:SetOnEquip(onequip)
    -- inst.components.equippable:SetOnUnequip(onunequip)

    inst.OnRemoveEntity = OnRemove



    return inst
end

return Prefab("des_boat_torch", fn, assets, prefabs),
    Prefab("des_boat_torchlight", lanternlightfn),
    MakePlacer("des_boat_torch_placer", "des_boat_torch", "des_boat_torch", "idle", false, nil, nil, nil, 0)