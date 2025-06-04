require("prefabs/veggies")
local WEED_DEFS = require("prefabs/weed_defs").WEED_DEFS


local function OnRange(self)
	self.inst.components.ea_rectangle:SetSize(self.length, self.width)
end

local function OnOffset(self)
	self.inst.components.ea_rectangle:SetOffset(self.offset)
end

local function OnItemLose(inst, data)
	if not inst.components.ea_harvest_machine then
		return
	end
	inst.components.ea_harvest_machine.cant_hold_items = {}	--在失去物品时，清除数据
end


local HarvestMachine = Class(function (self, inst)
	self.inst = inst

	self.offset = 1.5
	self.width = 2
	self.length = 12

	self.attraction_speed = 5	--吸引速度
	self.check_interval = 4		--检查是否需要收获的时间间隔(秒)
	self.left_time = 0
	self.is_picking_up_items = false
	self.pick_up_left_time = 0

	self.cant_hold_items = {}	--装不下的物品(由于容器满了)

	self.inst:ListenForEvent("itemlose", OnItemLose)
end, nil, {
	width = OnRange,
	length = OnRange,
	offset = OnOffset,
})


function HarvestMachine:OnRemoveFromEntity()
	self.inst:RemoveEventCallback("itemlose", OnItemLose)
end

local function CheckAndResetOversizedPlantPosition(item, target_pos)
	if not item:IsValid() or not string.find(item.prefab, "_oversized") then
		return
	end
	local pos = item:GetPosition()
	if pos:Dist(target_pos) > 1.2 then
		item.Transform:SetPosition(target_pos.x, 0, target_pos.z)
	end
end

local function HarvestCrop(inst, target)
	if not target then
		return
	end

	--如果是巨大蔬菜，锤它
	if target.components.workable and target.components.equippable and target.components.lootdropper then
		target.components.lootdropper:DropLoot()
		target:Remove()
		return
	end

	if target.components.crop and target:HasTag("readyforharvest") then	--旧农场
		target.components.crop:Harvest()
		return
	end

	if target.components.pickable and target.components.pickable.canbepicked then	--新农场
		local target_pos = target:GetPosition()

		local function ResetOversizedPlantPosition(ent, data)
			if not data or type(data.loot) ~= "table" then
				return
			end
			local loot = data.loot
			if loot.prefab then
				CheckAndResetOversizedPlantPosition(loot, target_pos)
			else
				for _, item in ipairs(loot) do
					CheckAndResetOversizedPlantPosition(item, target_pos)
				end
			end
			inst:RemoveEventCallback("picked", ResetOversizedPlantPosition, target)
		end

		inst:ListenForEvent("picked", ResetOversizedPlantPosition, target)	--兼容永不妥协对Pick函数的修改

		target.components.pickable:Pick(inst)
		for k, v in ipairs(TheSim:FindEntities(target_pos.x, 0, target_pos.z, 1.2, nil, {"FX", "INLIMBO"})) do	--如果是巨大蔬菜，锤它
			if v.components.workable and v.components.equippable and v.components.lootdropper then
				v.components.lootdropper:DropLoot()
				v:Remove()
			end
		end
	end
end

function HarvestMachine:Check()
	local inst = self.inst
	local will_harvest = false

	for k, v in ipairs(self.inst.components.ea_rectangle:FindEntities(nil, {"FX", "INLIMBO"})) do
		--成熟作物
		if v.components.pickable and v.components.pickable.canbepicked or v:HasTag("readyforharvest") then
			will_harvest = true
			inst:DoTaskInTime(FRAMES * 5, function()
				HarvestCrop(inst, v)
			end)
		end
		--巨大作物
		if v.components.workable and v.components.equippable and v.components.lootdropper then
			will_harvest = true
			inst:DoTaskInTime(FRAMES * 5, function()
				HarvestCrop(inst, v)
			end)
		end
		if not self.cant_hold_items[v.prefab] and EA_CONSTANTS.ENABLE_HARVEST_MACHINE_AUTO_PICKING_UP then
			--直接捡起蔬菜、种子和杂草
			if EA_TOOLS.IsValidVeggie(v) or EA_TOOLS.IsValidSeed(v) or EA_TOOLS.IsValidFarmPlant(v) or EA_TOOLS.IsWeed(v) then
				will_harvest = true
			end
		end
	end

	if not will_harvest then
		return
	end

	if self.on_harvest then
		self.on_harvest(inst)
	end
	if EA_CONSTANTS.ENABLE_HARVEST_MACHINE_AUTO_PICKING_UP then
		self.inst:DoTaskInTime(10 * FRAMES, function ()
			self:StartPickUpItem()
		end)
	end
end

function HarvestMachine:StartPickUpItem()
	if not EA_CONSTANTS.ENABLE_HARVEST_MACHINE_AUTO_PICKING_UP then
		self:StopPickUpItem()
		return
	end
	self.is_picking_up_items = true
end

function HarvestMachine:StopPickUpItem()
	self.is_picking_up_items = false
	self.left_time = self.check_interval
end

function HarvestMachine:PickUpItem()
	local inst_pos = self.inst:GetPosition()
	local ents = self.inst.components.ea_rectangle:FindEntities(nil, {"FX", "INLIMBO"})

	local no_vaild_item = true
	local inst_radius = self.inst.Physics and self.inst.Physics:GetRadius() or 0.5
	local will_pick_up = false
	for _, ent in ipairs(ents) do
		if ent:IsValid() and ent.prefab and not self.cant_hold_items[ent.prefab]
		and (EA_TOOLS.IsValidVeggie(ent) or EA_TOOLS.IsValidSeed(ent) or EA_TOOLS.IsValidFarmPlant(ent) or EA_TOOLS.IsWeed(ent)) then
			no_vaild_item = false
			local prefab = ent.prefab
			local dir = inst_pos - ent:GetPosition()
			local ent_radius = ent.Physics and ent.Physics:GetRadius() or 0.5
			if ent.Physics and dir:LengthSq() > (math.max(inst_radius + ent_radius, self.offset - self.length * 0.5) + 0.2) ^ 2 then
				local velocity = dir:GetNormalized() * self.attraction_speed
				ent.Physics:SetVel(velocity.x, 0, velocity.z)
				-- ent.Physics:SetDontRemoveOnSleep(true)
			else
				SpawnAt("ea_fx_trans", ent:GetPosition())
				if not self.inst.components.container:GiveItem(ent) then
					self.cant_hold_items[prefab] = true
				else
					will_pick_up = true
				end
			end
		end
	end
	if will_pick_up then
		self.inst.AnimState:PlayAnimation("trans")
		self.inst.AnimState:PushAnimation("idle", true)
	end
	if no_vaild_item then
		self:StopPickUpItem()
	end
end



function HarvestMachine:SetOffset(val)
	if type(val) == "number" then
		self.offset = val
	end
end

function HarvestMachine:SetRange(w, l)
	if type(w) == "number" and w > 0 then
		self.width = w
	end
	if type(l) == "number" and l > 0 then
		self.length = l
	end
end

function HarvestMachine:SetInterval(val)
	if type(val) ~= "number" or val <= 0 then
		return
	end
	self.check_interval = val
	if self.left_time > val then
		self.left_time = val
	end
end

function HarvestMachine:SetOnHarvestFn(fn)
	if fn == nil or type(fn) == "function" then
		self.on_harvest = fn
	end
end


function HarvestMachine:StartUpdating()
	self.inst:StartUpdatingComponent(self)
end

function HarvestMachine:StopUpdating()
	self.inst:StopUpdatingComponent(self)
end


function HarvestMachine:OnUpdate(dt)
	if self.inst:HasTag("burnt") then
		return
	end
	if self.is_picking_up_items then
		if self.pick_up_left_time <= 0  then
			self:PickUpItem()
			self.pick_up_left_time = 0.8
		end
		self.pick_up_left_time = self.pick_up_left_time - dt
	else
		self.left_time = self.left_time - dt
		if self.left_time > 0 then
			return
		end
		self.left_time = self.check_interval
		self:Check()
	end
end


return HarvestMachine