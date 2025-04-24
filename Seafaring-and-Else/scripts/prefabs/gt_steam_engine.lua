local assets = {
    Asset("ANIM", "anim/des_steam_sail.zip"),
    Asset("ANIM", "anim/des_steam_sail_red.zip"),
}

local Modes={
    [1]={speed=1,
        fuelmult=1,
        heating=0.8},
    [2]={speed=2,
        fuelmult=2.2,
        heating=1.5},
    [5]={speed=6,
        fuelmult=7,
        heating=4.5},
}

local function EnableLight(inst)
    if inst.mode==1 then
        inst.AnimState:OverrideSymbol("glow", "des_steam_sail", "glow")
        inst.Light:SetColour(1, 1, 1)
    else
        inst.AnimState:OverrideSymbol("glow", "des_steam_sail_red", "glow")
        inst.Light:SetColour(1, .25, .25)
    end
    inst.Light:Enable(true) 
end

local function SwitchMode(inst,mode)
    if mode==nil then
        local num=inst.mode+1
        if Modes[num]~=nil then
            inst.mode=num
        else
            inst.mode=1
        end
    else
        inst.mode=mode
    end
    EnableLight(inst)
    inst.components.gt_engine:SetModifier("self", "mode", Modes[inst.mode]["speed"])
    inst.components.fueled.rate_modifiers:SetModifier("self",Modes[inst.mode]["fuelmult"],"mode")
	
end

local function OnSave(inst,data)
    data.mode=inst.mode
end

local function OnLoad(inst,data)
    if data and data.mode then
        SwitchMode(inst,data.mode)
    end
end

local function PlacerPostInit(inst)
    inst.AnimState:OverrideSymbol("glow", "des_steam_sail", "dummy")
    local thermometer=SpawnPrefab("gt_steam_engine_thermometer")
    inst:AddChild(thermometer)
    inst.components.placer:LinkEntity(thermometer)
end

local function MakeLeak(inst)
    local x,y,z=inst.Transform:GetWorldPosition()
    local boat=TheWorld.Map:GetPlatformAtPoint(x,y,z)
    if boat~=nil then
        local leak=SpawnPrefab("boat_leak")
        leak.components.boatleak.isdynamic=true
        leak.components.boatleak:SetState("small_leak")
        leak.components.boatleak:SetBoat(boat)
        leak.Transform:SetPosition(x,y,z)
		if boat.components.hullhealth and boat.components.hullhealth.leak_indicators_dynamic then
			table.insert(boat.components.hullhealth.leak_indicators_dynamic, leak)
		end
    end
end

local function FixTemperature(temperature)
    local oOU=temperature.OnUpdate
    temperature.OnUpdate=function(...)
        if temperature.inst.components.machine.ison then
            local oWt=TheWorld.state.temperature
            TheWorld.state.temperature=0
            oOU(...)
            TheWorld.state.temperature=oWt
        else
            oOU(...)
        end
    end
end

local function OnOverheat(inst)
    inst.components.explosive:OnBurnt()
end

local function HeatEngine(inst)
    inst.components.temperature:DoDelta((1/TUNING.GT_STEAM_ENGINE_OVERHEAT) * Modes[inst.mode]["heating"])
end

local function StartHeating(inst)
    inst.heattask=inst:DoPeriodicTask(1,HeatEngine)
end

local function StopHeating(inst)
    if inst.heattask~=nil then
        inst.heattask:Cancel()
        inst.heattask=nil
    end
end

local function HeatFn(inst)
    return inst.components.temperature.current
end

local function TradeCheck(inst,item)
    local edible=item.components.edible
    return (edible~=nil and edible.temperaturedelta~=nil and edible.temperaturedelta<0)
	or (item.prefab=="gunpowder" and inst.components.machine.ison)
	or (item.components.fuel and inst.components.fueled:CanAcceptFuelItem(item))
end

local function OnTrade(inst, giver, item)
    local edible=item.components.edible
    if edible~=nil then
        inst.components.temperature:DoDelta(edible.temperaturedelta/3)
    end
    if item.prefab=="gunpowder" then
        SwitchMode(inst,5)
    end
	
	if item.components.fuel then
		inst.components.fueled:TakeFuelItem(item, nil)
	end
end

local function CreateFX(inst)
    local fx=SpawnPrefab("smoke_plant")
    fx.entity:AddFollower()
    fx.Follower:FollowSymbol(inst.GUID, "tube", 35, 15, 0)
    local s=1.5
    fx.Transform:SetScale(s,s,s)
    inst.fx=fx
end

local function RemoveFX(inst)
    if inst.fx~=nil then
        ErodeAway(inst.fx)
        inst.fx=nil
    end
end

local function GetDescription(inst)
    return "Fuel "..math.ceil(inst.components.fueled:GetPercent()*100).."%."
end

local function TurnOn(inst)
    if not inst.components.fueled:IsEmpty() then
        inst.AnimState:PlayAnimation("work",true)
        EnableLight(inst)
        CreateFX(inst)
        inst.SoundEmitter:PlaySound("dontstarve/common/researchmachine_lvl1_idle_LP", "idlesound")
        inst.SoundEmitter:PlaySound("dontstarve/pig/pighut_lighton")
        inst.components.gt_engine:SetModifier("self", "switch", 1)
        inst.components.fueled:StartConsuming()
        StartHeating(inst)
		inst.components.workable:SetWorkLeft(5)
    end
end

local function TurnOff(inst)
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:OverrideSymbol("glow", "des_steam_sail", "dummy")
    inst.Light:Enable(false)
    RemoveFX(inst)    
    inst.SoundEmitter:KillSound("idlesound")
    inst.SoundEmitter:PlaySound("dontstarve/pig/pighut_lightoff")
    inst.components.gt_engine:SetModifier("self", "switch", 0)
    inst.components.fueled:StopConsuming()
    StopHeating(inst)
	inst.components.workable:SetWorkLeft(5)
    if inst.mode==5 then
        SwitchMode(inst)
    end
end

local function FuelUpdate(inst)
    local fuel=inst.components.fueled:GetPercent()
    inst.components.gt_engine:SetModifier("self", "fuel", math.min(math.sqrt(fuel)*2,1))
end

local function OnDepleted(inst)
    inst.components.machine:TurnOff()
end

local function OnWorked(inst,worker,workleft,numworks)
    local boat=inst.components.gt_engine.boat
    if inst.components.machine.ison and boat~=nil and boat.components.health.currenthealth~=0 then
        SwitchMode(inst)
        inst.components.workable.workleft=inst.components.workable.workleft+numworks
    elseif workleft<=1 and workleft>0 then
        inst.components.workable:WorkedBy(worker)
    else
        inst.AnimState:PlayAnimation("hit")
        inst.AnimState:PushAnimation("idle")
    end
    inst.SoundEmitter:PlaySound("dontstarve/common/together/catapult/hit")
end

local function OnWorkFinished(inst)
    --inst.components.lootdropper:DropLoot()
	
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("none")
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_metal")
	
	inst:Remove()
end

local function fn()
    local inst = CreateEntity()
    
    inst.entity:AddTransform()
	inst.entity:AddLight()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    
    MakeObstaclePhysics(inst, .5)
    
    local s=1.2
    inst.Transform:SetScale(s,s,s)
    
	inst.Light:SetFalloff(.3) 
	inst.Light:SetIntensity(.9) 
	inst.Light:SetColour(1, 1, 1)
    inst.Light:SetRadius(.25)
    inst.Light:Enable(false) 
    
    inst.AnimState:SetBank("des_steam_sail")
    inst.AnimState:SetBuild("des_steam_sail")
    inst.AnimState:PlayAnimation("idle")
    
    inst.AnimState:OverrideSymbol("glow", "des_steam_sail", "dummy")
    
    inst:AddTag("structure")
    --inst:AddTag("mast")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    
    inst:AddComponent("inspectable")
    inst.components.inspectable.getspecialdescription=GetDescription
    
    inst:AddComponent("hauntable")
    
    inst:AddComponent("machine")
    inst.components.machine.turnonfn=TurnOn
    inst.components.machine.turnofffn=TurnOff
    inst.components.machine.cooldowntime=0
    
    inst:AddComponent("fueled")
    inst.components.fueled:InitializeFuelLevel(TUNING.GT_STEAM_ENGINE_LIFETIME)
    inst.components.fueled:SetDepletedFn(OnDepleted)
    inst.components.fueled:SetUpdateFn(FuelUpdate)
    inst.components.fueled:SetFirstPeriod(TUNING.TURNON_FUELED_CONSUMPTION, TUNING.TURNON_FULL_FUELED_CONSUMPTION)
    inst.components.fueled.accepting = true
    
    inst:AddComponent("temperature")
    inst.components.temperature.mintemp=0
    inst.components.temperature.maxtemp=TUNING.MAX_ENTITY_TEMP*2
    inst.components.temperature.overheattemp=TUNING.MAX_ENTITY_TEMP*1.67
    inst.components.temperature.inherentinsulation=TUNING.INSULATION_SMALL
    inst.components.temperature.inherentsummerinsulation=TUNING.INSULATION_SMALL
    FixTemperature(inst.components.temperature)
    
    inst:AddComponent("heater")
    inst.components.heater.heatfn = HeatFn
    inst.components.heater:SetThermics(true, false)
    
    inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(TradeCheck)
    inst.components.trader.onaccept=OnTrade
    
    inst:AddComponent("explosive")
    inst.components.explosive.explosivedamage=100
    
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(5) --На самом деле 4
    inst.components.workable:SetOnFinishCallback(OnWorkFinished)
    inst.components.workable:SetOnWorkCallback(OnWorked)

    inst:AddComponent("lootdropper")
    
    inst:AddComponent("gt_engine")
    inst.components.gt_engine:SetSailForce(TUNING.BOAT.MAST.BASIC.SAIL_FORCE*TUNING.GT_STEAM_ENGINE_SPEED)
    inst.components.gt_engine:SetMaxVelocity(TUNING.BOAT.MAST.BASIC.MAX_VELOCITY*TUNING.GT_STEAM_ENGINE_SPEED)
    inst.components.gt_engine:SetModifier("self", "switch", 0)
    
    inst:ListenForEvent("startoverheating",OnOverheat)
    inst:ListenForEvent("onremove",MakeLeak)
    
    local thermometer=SpawnPrefab("gt_steam_engine_thermometer")
    inst.thermometer=thermometer
    inst:AddChild(thermometer) 
    thermometer.engine=inst
    
    inst.mode=1
    
    inst.OnSave=OnSave
    inst.OnLoad=OnLoad
    
    return inst
end

local function DoCheckTemperature(inst)
    if inst.engine~=nil then
        inst.AnimState:SetPercent("meter", 1 - math.clamp(inst.engine.components.temperature.current, 0, TUNING.MAX_ENTITY_TEMP*1.7) / (TUNING.MAX_ENTITY_TEMP*1.7))
    end
end

local function thermometer()
    local inst = CreateEntity()
    
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    
    local s=0.3
    inst.Transform:SetScale(s,s,s)
    
    inst.AnimState:SetBank("winter_meter")
    inst.AnimState:SetBuild("winter_meter")
    inst.AnimState:SetPercent("meter", .5)

    inst:AddTag("NOCLICK")

    MakeSnowCoveredPristine(inst)
    
    inst.entity:SetPristine()
    
    if not TheWorld.ismastersim then
        return inst
    end
    
    inst:DoPeriodicTask(1, DoCheckTemperature, 0)
    
    inst.persist=false
    
    return inst
end

return Prefab("gt_steam_engine",fn,assets),
    Prefab("gt_steam_engine_thermometer",thermometer),
    MakePlacer("gt_steam_engine_placer", "des_steam_sail", "des_steam_sail", "idle", false, nil, nil, 1.25, 0, "one", PlacerPostInit)