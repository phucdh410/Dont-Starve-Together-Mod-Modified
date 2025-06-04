require "prefabutil"

local assets = {
    Asset("ANIM", "anim/ea_farm_plow_machine.zip"),
}

local assets_item = {
	Asset("ANIM", "anim/ea_farm_plow_machine.zip"),
	Asset("ATLAS", "images/inventoryimages/ea_farm_plow_machine_item.xml"),
	Asset("IMAGE", "images/inventoryimages/ea_farm_plow_machine_item.tex")
}

local prefabs = {
    "farm_soil",
	"dirt_puff",
}

local prefabs_item = {
	"tile_outline",
}

local ANIM_SCALE = 1.5

--[[
	逻辑流程：
	客户端发送RPC，接受后调用inst.SetTilesAndStart函数
	SetTilesAndStart对传入的地块进行排序后，调用ea_move_queue组件的方法开始移动
	ea_move_queue组件会在到达一个目标点之后触发OnReach函数，并等待下一次调用组件的Move函数方法继续移动
	OnReach函数中处理到达一个目标点时的逻辑，首先会判断耐久还够不够，如果不够就会停止工作，否则扣除耐久，然后播放开始工作的动画，当动画播完时调用DoDrilling函数
	DoDrilling函数会播放挖地的动画，然后判断是否需要开垦耕地
		如果需要就会定时一段时间后调用reclaim函数
		否则在一段时间后调用spawn_next_soil进行耕地
	reclaim函数中会调用terraformer组件的Terraform方法改变地皮
		如果返回值为true，就会定时一段时间后调用spawn_next_soil进行耕地
		否则会调用try_continue_moving函数，继续移动到下一个目标点
	spawn_next_soil函数会生成一个种植坑，然后继续在一段时间后调用自己生成下一个种植坑，直到数量超过最大值，就会调用try_continue_moving函数，继续移动到下一个目标点
	当ea_move_queue组件的Move函数返回false的时候就表示已经完成了所有的移动，则会调用StopWorking函数处理完成工作的逻辑
]]

--------------------------------------------------
-- ea_farm_plow_machine
--------------------------------------------------

local function OnRemoveEntity(inst)
	local x, y, z = inst.Transform:GetWorldPosition()
	if inst.deploy_item_save_record ~= nil then
        local item = SpawnSaveRecord(inst.deploy_item_save_record)
		if not item then return end

		item.Transform:SetPosition(x, y, z)
		item.components.fueled:InitializeFuelLevel(inst.components.fueled.currentfuel)

		inst.AnimState:PlayAnimation("item")
	    item.SoundEmitter:PlaySound("farming/common/farm/plow/collapse")

		SpawnPrefab("dirt_puff").Transform:SetPosition(x, y, z)
	    item.SoundEmitter:PlaySound("farming/common/farm/plow/dirt_puff")
	else
		SpawnPrefab("collapse_small").Transform:SetPosition(x, y, z)
	end
end

local function OnTerraform(inst, pt, old_tile_type, old_tile_turf_prefab)
    local cx, cy, cz = TheWorld.Map:GetTileCenterPoint(pt:Get())
	SpawnPrefab("dirt_puff").Transform:SetPosition(cx + math.random() + 1, cy, cz + math.random() + 1)
	SpawnPrefab("dirt_puff").Transform:SetPosition(cx - math.random() - 1, cy, cz + math.random() + 1)
	SpawnPrefab("dirt_puff").Transform:SetPosition(cx + math.random() + 1, cy, cz - math.random() - 1)
	SpawnPrefab("dirt_puff").Transform:SetPosition(cx - math.random() - 1, cy, cz - math.random() - 1)
end

local function move(inst)
	inst.AnimState:PushAnimation("move", true)
	inst.AnimState:SetDeltaTimeMultiplier(inst.components.locomotor.runspeed / 0.8)
	inst.components.ea_move_stack:Move()
end

local function try_continue_moving(inst)
	if inst.components.fueled:IsEmpty() then
		return
	end
	inst.SoundEmitter:KillSound("loop")
	if inst.AnimState:IsCurrentAnimation("drill_loop") or inst.AnimState:IsCurrentAnimation("drill_pre") then
		inst.AnimState:PlayAnimation("drill_pst")
		inst:DoTaskInTime(0.4, move)
	else
		move(inst)
	end
end

local function get_till_pt(center_pos, index)
	local x_offset = index % 3
	x_offset = x_offset == 0 and 3 or x_offset
	local z_offset = math.ceil(index / 3)
	local x = center_pos.x - 2 - 2/3 + x_offset * 4/3
	local z = center_pos.z - 2 - 2/3 + z_offset * 4/3
	return x, z
end

local function till_next_soil(inst, center_pos, index)
	while index <= 9 do
		local x, z = get_till_pt(center_pos, index)
		if #(TheSim:FindEntities(x, 0, z, 0.2, {"soil"}, {"NOCLICK"})) > 0 then
			index = index + 1
		else
			if TheWorld.Map:CanTillSoilAtPoint(x, 0, z) then
				TheWorld.Map:CollapseSoilAtPoint(x, 0, z)
				SpawnPrefab("farm_soil").Transform:SetPosition(x, 0, z)
			end
			break
		end
	end

	if index < 9 then
		inst.task = inst:DoTaskInTime(EA_CONSTANTS.TILL_DURATION, till_next_soil, center_pos, index + 1)
		return
	end

	try_continue_moving(inst)
end

local function reclaim(inst)
	local inst_pos = inst:GetPosition()
	if inst.components.terraformer:Terraform(inst_pos) then
		inst.task = inst:DoTaskInTime(EA_CONSTANTS.TILL_DURATION, till_next_soil, Vector3(TheWorld.Map:GetTileCenterPoint(inst_pos:Get())), 1)
	else
		try_continue_moving(inst)
	end
end

local function DoDrilling(inst)
	inst:RemoveEventCallback("animover", DoDrilling)
	inst.AnimState:PlayAnimation("drill_loop", true)
    inst.SoundEmitter:PlaySound("farming/common/farm/plow/LP", "loop")
	if not TheWorld.Map:IsFarmableSoilAtPoint(inst.Transform:GetWorldPosition()) then
		inst.task = inst:DoTaskInTime(EA_CONSTANTS.FARM_PLOW_DRILLING_DURATION, reclaim)
	else
		inst.task = inst:DoTaskInTime(EA_CONSTANTS.TILL_DURATION, till_next_soil, Vector3(TheWorld.Map:GetTileCenterPoint(inst.Transform:GetWorldPosition())), 1)
	end
end

local function re_order(inst, tiles)	--对地块列表重新排序, 尽可能不绕路
	local res = {}
	local cur_pt = inst:GetPosition()
	cur_pt = {cur_pt.x, cur_pt.z}
	tiles = deepcopy(tiles)
	while #tiles > 0 do
		table.sort(tiles, function(a, b)
			return (a[1] - cur_pt[1])^2 + (a[2] - cur_pt[2])^2 > (b[1] - cur_pt[1])^2 + (b[2] - cur_pt[2])^2
		end)
		cur_pt = table.remove(tiles)
		table.insert(res, cur_pt)
	end
	return res
end

local function StartWorking(inst, tiles)		--{{x, z}, {x, z}, ...}
	if inst.components.fueled:IsEmpty() then
		return
	end

	tiles = re_order(inst, tiles)
	local recover_pt = inst.deploy_pos
	if not recover_pt then
		local inst_pos = inst:GetPosition()
		recover_pt = {inst_pos.x, inst_pos.z}
	end
	table.insert(tiles, 1, recover_pt)
	inst.components.ea_move_stack:SetStack(tiles)
	inst.components.fueled:StartConsuming()
	inst.is_working = true

	if inst.AnimState:IsCurrentAnimation("drill_loop") or inst.AnimState:IsCurrentAnimation("drill_pre") then
		inst.AnimState:PlayAnimation("drill_pst")
		inst:DoSimTaskInTime(0.4, move)
	else
		move(inst)
	end
end

local function StopWorking(inst)
	inst.components.ea_move_stack:StopMoving()
	inst.components.fueled:StopConsuming()
	if inst.task then
		inst.task:Cancel()
		inst.task = nil
	end
	inst:RemoveEventCallback("animover", DoDrilling)
	inst.SoundEmitter:KillSound("loop")
	if inst.AnimState:IsCurrentAnimation("drill_loop") or inst.AnimState:IsCurrentAnimation("drill_pre") then
		inst.AnimState:PlayAnimation("drill_pst")
		inst.AnimState:PushAnimation("idle")
	else
		inst.AnimState:PlayAnimation("idle")
	end
	inst.AnimState:SetDeltaTimeMultiplier(1)
	inst.is_working = false
end

local function GetWorkableTiles(inst, tiles)			--{{x, z}, {x, z}, ...}
	if not inst.tiles or inst.is_working then
		return
	end

	local res = {}
	for _, tile in ipairs(tiles) do
		if not TheWorld.Map:IsFarmableSoilAtPoint(tile[1], 0, tile[2]) then
			table.insert(res, tile)
		else
			for index = 1, 9 do
				local x, z = get_till_pt(Vector3(tile[1], 0, tile[2]), index)
				if TheWorld.Map:CanTillSoilAtPoint(x, 0, z) and #(TheSim:FindEntities(x, 0, z, 0.2, {"soil"}, {"NOCLICK"})) == 0 then
					table.insert(res, tile)
					break
				end
			end
		end
	end

	if #res > 0 then
		return res
	end
end

local function SetTilesAndStart(inst, tiles)	--{{x, z}, {x, z}, ...}
	if inst.doer then
		inst.doer._current_operate_plow_tile_machine = nil
		inst.doer = nil
	end
	inst.tiles = tiles
	local _tiles = GetWorkableTiles(inst, tiles)
	if type(_tiles) == "table" then
		StartWorking(inst, _tiles)
	end
end

--------------------------------------------------
-- ea_move_stack
--------------------------------------------------

local function OnReach(inst, pt)
	if inst.components.fueled:IsEmpty() or inst.components.ea_move_stack:IsEmpty() then
		StopWorking(inst)
		return
	end
	inst.AnimState:PlayAnimation("drill_pre")
	inst.AnimState:SetDeltaTimeMultiplier(1)
	inst.SoundEmitter:PlaySound("farming/common/farm/plow/drill_pre")
	inst:ListenForEvent("animover", DoDrilling)
end

--------------------------------------------------
-- ea_popupscreen
--------------------------------------------------

local function CanShowScreen(inst, doer)
	return inst.components.ea_move_stack:IsEmpty() and not inst.components.fueled:IsEmpty()
end

local function GetScreenData(inst, doer)
	return inst.tiles
end

local function OnShowScreen(inst, doer)
	doer._current_operate_plow_tile_machine = inst
	inst.doer = doer
end

--------------------------------------------------
-- fueled
--------------------------------------------------

local function OnTakeFuel(inst, fuelvalue)
	-- if not inst.components.fueled:IsEmpty() then
	-- end
end


--------------------------------------------------
-- Save & Load
--------------------------------------------------

local function OnSave(inst, data)
	data.deploy_item = inst.deploy_item_save_record
	data.tiles = inst.tiles
end

local function OnLoadPostPass(inst, newents, data)
	if data ~= nil then
		inst.deploy_item_save_record = data.deploy_item
		if data.tiles then
			inst:SetTilesAndStart(data.tiles)
		end
	end
end


local function DescriptionFn(inst, viewer)
	return STRINGS.EA_FARM_PLOW_MACHINE_DESCRIBE..tostring(math.floor(inst.components.fueled:GetPercent() * 1000) / 10).."%"
end


--------------------------------------------------

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.entity:AddSoundEmitter()
	inst.entity:AddMiniMapEntity()
	inst.entity:AddDynamicShadow()

	MakeObstaclePhysics(inst, 0.75)

	inst.MiniMapEntity:SetIcon("ea_farm_plow_machine_mini.tex")

    inst.AnimState:SetBank("ea_farm_plow_machine")
    inst.AnimState:SetBuild("ea_farm_plow_machine")
	inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("idle", true)
	inst.AnimState:SetScale(ANIM_SCALE, ANIM_SCALE)

	inst.Transform:SetTwoFaced()
	inst.DynamicShadow:SetSize(2, 1)

    inst:AddTag("scarytoprey")	--会惊吓到小动物
	inst:AddTag("NOBLOCK")

	inst.ea_popupscreen_action_strid = "PLOW_TILE_SELECT"

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

	inst.entity:SetCanSleep(false)

	inst.tasks = {}

    inst:AddComponent("inspectable")
	inst.components.inspectable.descriptionfn = DescriptionFn

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(2)
    inst.components.workable:SetOnFinishCallback(inst.Remove)

	inst:AddComponent("locomotor")
	inst.components.locomotor.runspeed = EA_CONSTANTS.PLOW_TILE_MACHINE_MOVE_SPEED
    inst.components.locomotor.walkspeed = EA_CONSTANTS.PLOW_TILE_MACHINE_MOVE_SPEED

    inst:AddComponent("terraformer")
    inst.components.terraformer.turf = WORLD_TILES.FARMING_SOIL
	inst.components.terraformer.onterraformfn = OnTerraform
	inst.components.terraformer.plow = true

	inst:AddComponent("ea_move_stack")
	inst.components.ea_move_stack:SetOnReach(OnReach)

	inst:AddComponent("ea_popupscreen")
	inst.components.ea_popupscreen:SetPopUpID("EA_PLOW_TILE_SELECT")
	inst.components.ea_popupscreen.can_show_fn = CanShowScreen
	inst.components.ea_popupscreen.get_data_fn = GetScreenData
	inst.components.ea_popupscreen.on_show_fn = OnShowScreen

	inst:AddComponent("fueled")
    inst.components.fueled.fueltype = FUELTYPE.BURNABLE
	inst.components.fueled.rate = 0.75
	inst.components.fueled.accepting = true
    inst.components.fueled:InitializeFuelLevel(TUNING.LARGE_FUEL)
	inst.components.fueled:SetTakeFuelFn(OnTakeFuel)
	inst.components.fueled:SetDepletedFn(StopWorking)

	-- inst.tiles = nil
	-- inst.deploy_pos = nil --{[1] = x, [2] = z}
	-- inst.deploy_item_save_record = nil

	inst.SetTilesAndStart = SetTilesAndStart
	inst.OnSave = OnSave
	inst.OnLoadPostPass = OnLoadPostPass
	inst.OnRemoveEntity  = OnRemoveEntity

	inst.update_task = inst:DoPeriodicTask(EA_CONSTANTS.PLOW_MACHINE_CHECK_INTERVAL, function ()
		local tiles = GetWorkableTiles(inst, inst.tiles)
		if type(tiles) == "table" then
			StartWorking(inst, tiles)
		end
	end)

    return inst
end


--------------------------------------------------
-- ea_farm_plow_machine_item
--------------------------------------------------

local function OnDeploy(inst, pt, deployer)
    local cx, cy, cz = TheWorld.Map:GetTileCenterPoint(pt:Get())

    local obj = SpawnPrefab("ea_farm_plow_machine")
	obj.Transform:SetPosition(cx, cy, cz)
	obj.deploy_pos = {cx, cz}

	if inst:IsValid() then
		obj.deploy_item_save_record = inst:GetSaveRecord()
		obj.components.fueled:InitializeFuelLevel(inst.components.fueled.currentfuel)
		inst:Remove()
	end
end

local function CanPlowTile(inst, pt, mouseover, deployer)
	local x, z = pt.x, pt.z
	if not TheWorld.Map:CanPlantAtPoint(x, 0, z) then
		return false
	end

	for _, ent in ipairs(TheWorld.Map:GetEntitiesOnTileAtPoint(x, 0, z)) do
		if ent ~= inst and ent ~= deployer and not (ent:HasTag("NOBLOCK") or ent:HasTag("locomotor") or ent:HasTag("NOCLICK") or ent:HasTag("FX") or ent:HasTag("DECOR")) then
			return false
		end
	end

	return true
end


local function item_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("ea_farm_plow_machine")
    inst.AnimState:SetBuild("ea_farm_plow_machine")
    inst.AnimState:PlayAnimation("item")
    inst.scrapbook_anim = "item"
	inst.AnimState:SetScale(ANIM_SCALE, ANIM_SCALE)

    inst:AddTag("usedeploystring")
    inst:AddTag("tile_deploy")

	MakeInventoryFloatable(inst, "small", 0.1, 0.8)

	inst._custom_candeploy_fn = CanPlowTile	-- for DEPLOYMODE.CUSTOM

	inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
	inst.components.inspectable.descriptionfn = DescriptionFn

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/ea_farm_plow_machine_item.xml"

    inst:AddComponent("deployable")
	inst.components.deployable:SetDeployMode(DEPLOYMODE.CUSTOM)
    inst.components.deployable.ondeploy = OnDeploy

	inst:AddComponent("fueled")
    inst.components.fueled.fueltype = FUELTYPE.BURNABLE
	inst.components.fueled.accepting = true
    inst.components.fueled:InitializeFuelLevel(TUNING.LARGE_FUEL)
    -- inst.components.fueled:SetDepletedFn(inst.Remove)

    MakeSmallBurnable(inst)
    MakeSmallPropagator(inst)
    MakeHauntableLaunch(inst)

    return inst
end


--------------------------------------------------
-- ea_farm_plow_machine_item_placer
--------------------------------------------------

local function placer_fn()
    local inst = CreateEntity()

    inst:AddTag("CLASSIFIED")
    inst:AddTag("NOCLICK")
    inst:AddTag("placer")

    inst.entity:SetCanSleep(false)
    inst.persists = false

    inst.entity:AddTransform()
    inst.entity:AddAnimState()

    inst.AnimState:SetBank("ea_farm_plow_machine")
    inst.AnimState:SetBuild("ea_farm_plow_machine")
    inst.AnimState:PlayAnimation("idle")
	inst.AnimState:SetScale(ANIM_SCALE, ANIM_SCALE)
    inst.AnimState:SetLightOverride(1)

    inst:AddComponent("placer")
    inst.components.placer.snap_to_tile = true

	inst.outline = SpawnPrefab("tile_outline")
	inst.outline.entity:SetParent(inst.entity)

	inst.components.placer:LinkEntity(inst.outline)

    return inst
end

RegisterInventoryItemAtlas("images/inventoryimages/ea_farm_plow_machine_item.xml", "ea_farm_plow_machine_item.tex")

return Prefab("ea_farm_plow_machine", fn, assets, prefabs),
	Prefab("ea_farm_plow_machine_item", item_fn, assets_item, prefabs_item),
	Prefab("ea_farm_plow_machine_item_placer", placer_fn)