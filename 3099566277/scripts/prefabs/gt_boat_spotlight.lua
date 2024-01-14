require("prefabutil")

local assets = {
    Asset("ANIM", "anim/winona_spotlight.zip"),
    Asset("ANIM", "anim/winona_moonlight.zip"),
}

local light_length = {
	normal = 9,
	moon = 12
}

local light_width = {
	normal = 2.5,
	moon = 2
}

local scale = {
	normal = .6,
	moon = .8
}

local function PlacerPostInit(inst)
    inst.AnimState:OverrideSymbol("light_shimmer", "winona_spotlight", "dummy")
end

local function CreateLight(inst)
	local length = light_length[inst.type]
	local width = light_width[inst.type]
    local multiplier = 1/scale[inst.type] --Для того чтобы scale не влияли на реальное расстояние

	for i=0,length do 
		local fx=SpawnPrefab("gt_boat_spotlight_light")
		fx.Light:SetRadius(i/width)
		inst:AddChild(fx) 
		table.insert(inst.lights, fx) 
		fx.Transform:SetPosition(i^1.2*2*multiplier,0,0) 
		
		if inst.type == "moon" then
			fx.Light:SetColour(0.25, 0.25, 1)
		end
	end
end




local function RemoveLight(inst)
	for k,v in ipairs(inst.lights) do 
		v:Remove() 
	end 
	inst.lights={}
end

local function OnUpdate(inst)
    local x,y,z=inst.Transform:GetWorldPosition()
    if inst.boat~=nil and inst.boat:IsValid() then 
        local boatphysics = inst.boat.components.boatphysics
        inst:FacePoint(boatphysics.rudder_direction_x+x,0,boatphysics.rudder_direction_z+z)
    end
end

local function OnWorked(inst)
    inst.AnimState:PlayAnimation("hit")
    inst.AnimState:PushAnimation("idle", true)
    inst.SoundEmitter:PlaySound("dontstarve/common/together/catapult/hit")
end

local function OnWorkFinished(inst)
    inst.components.workable:SetWorkable(false)
    inst:AddTag("NOCLICK")
    inst.persists = false
    if inst.components.burnable ~= nil then
        if inst.components.burnable:IsBurning() then
            inst.components.burnable:Extinguish()
        end
        inst.components.burnable.canlight = false
    end

    inst.Physics:SetActive(false)
    inst.components.lootdropper:DropLoot()
    inst.AnimState:PlayAnimation("death_pst")
    inst.SoundEmitter:PlaySound("dontstarve/common/together/spot_light/destroy")

    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("none")
    
    RemoveLight(inst)
    
    inst:DoTaskInTime(2, ErodeAway)
end

local function OnDepleted(inst)
    inst.components.machine:TurnOff()
end

local function GetDescription(inst)
    return "Fuel "..math.ceil(inst.components.fueled:GetPercent()*100).."%."
end

local function TurnOn(inst)
    if not inst.components.fueled:IsEmpty() then 
        inst.components.fueled:StartConsuming()
        CreateLight(inst)
		if inst.type == "moon" then
			inst.AnimState:OverrideSymbol("light_shimmer", "winona_moonlight", "light_shimmer")
		else
			inst.AnimState:ClearOverrideSymbol("light_shimmer")
		end
	else
        OnDepleted(inst)
    end
end

local function TurnOff(inst)
    inst.components.fueled:StopConsuming()
    RemoveLight(inst)
    inst.AnimState:OverrideSymbol("light_shimmer", "winona_moonlight", "dummy")
end

local function light()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddLight()
	inst.entity:AddNetwork()
	inst.Light:Enable(true) 
	inst.Light:SetFalloff(.3) 
	inst.Light:SetIntensity(.9) 
	inst.Light:SetColour(1, 1, .5) 
	inst.persists = false
	return inst 
end

local function fn(typeof)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
    
    inst.Transform:SetRotation(90)

    MakeObstaclePhysics(inst, .5)

    inst.Transform:SetEightFaced()

    inst:AddTag("spotlight")
    inst:AddTag("structure")

    inst:AddTag("structure")
	
    inst.AnimState:SetBank("winona_spotlight")
    inst.AnimState:SetBuild("winona_spotlight")
    inst.AnimState:PlayAnimation("idle", true)
    
    inst.AnimState:OverrideSymbol("light_shimmer", "winona_spotlight", "dummy")

	if not typeof then typeof = "normal" end
    
    local s=scale[typeof]
    inst.Transform:SetScale(s,s,s)
	
	if typeof == "moon" then
		inst.AnimState:OverrideSymbol("wire", "winona_moonlight", "wire")
		inst.AnimState:OverrideSymbol("sparks2", "winona_moonlight", "sparks2")
		inst.AnimState:OverrideSymbol("sprk_1", "winona_moonlight", "sprk_1")
		inst.AnimState:OverrideSymbol("sprk_2", "winona_moonlight", "sprk_2")
		inst.AnimState:OverrideSymbol("cap_OL", "winona_moonlight", "cap_OL")
		inst.AnimState:OverrideSymbol("light_base", "winona_moonlight", "light_base")
	end
	
    inst.MiniMapEntity:SetIcon("winona_spotlight.png")

	inst.type = typeof
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
    inst.components.inspectable.getspecialdescription=GetDescription

    inst:AddComponent("lootdropper")
    
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
    inst.components.workable:SetOnWorkCallback(OnWorked)
    inst.components.workable:SetOnFinishCallback(OnWorkFinished)
    
    inst:AddComponent("machine")
    inst.components.machine.turnonfn=TurnOn
    inst.components.machine.turnofffn=TurnOff
    inst.components.machine.cooldowntime=0
    
    inst:AddComponent("fueled")
	
	if (not TUNING.GT_LIGHT_LIFETIME_FUELTYPE) or (TUNING.GT_LIGHT_LIFETIME_FUELTYPE == 0) then
	
	elseif TUNING.GT_LIGHT_LIFETIME_FUELTYPE == 1 then
		inst.components.fueled.fueltype = FUELTYPE.CAVE
		
	elseif TUNING.GT_LIGHT_LIFETIME_FUELTYPE == 2 then		
		inst.components.fueled.fueltype = FUELTYPE.NIGHTMARE
	end	
    ---inst.components.fueled.fueltype=FUELTYPE.CAVE
    
    inst.components.fueled.bonusmult = TUNING.GT_LIGHT_LIFETIME_FUELMULT
	
	if typeof == "normal" then
		inst.components.fueled:InitializeFuelLevel(TUNING.GT_LIGHT_LIFETIME)
	elseif typeof == "moon" then
		inst.components.fueled:InitializeFuelLevel(TUNING.GT_LIGHT_LIFETIME_MOON)
	end
	
	inst.components.fueled:SetDepletedFn(OnDepleted)
    inst.components.fueled:SetFirstPeriod(TUNING.TURNON_FUELED_CONSUMPTION, TUNING.TURNON_FULL_FUELED_CONSUMPTION)
    inst.components.fueled.accepting=true

    MakeHauntableWork(inst)
    
    inst.lights={}
    inst:DoTaskInTime(0,function(inst)
        local x,y,z=inst.Transform:GetWorldPosition()
        inst.boat=TheWorld.Map:GetPlatformAtPoint(x,y,z)
        inst:DoPeriodicTask(0,OnUpdate)
    end)

    return inst
end

return Prefab("gt_boat_spotlight", function() return fn("normal") end, assets),
	Prefab("gt_boat_spotlight_moon", function() return fn("moon") end, assets),
    Prefab("gt_boat_spotlight_light", light),
    MakePlacer("gt_boat_spotlight_placer", "winona_spotlight", "winona_spotlight", "idle", false, nil, nil, .6, 0, "eight", PlacerPostInit),
    MakePlacer("gt_boat_spotlight_moon_placer", "winona_spotlight", "winona_spotlight", "idle", false, nil, nil, .8, 0, "eight", PlacerPostInit)