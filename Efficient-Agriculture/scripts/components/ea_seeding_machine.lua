local easing = require("easing")

local function OnRange(self)
	self.inst.components.ea_rectangle:SetSize(self.length, self.width)
end

local SeedingMachine = Class(function (self, inst)
	self.inst = inst
	self.doer = nil
    self.launch_interval = 2  --发射间隔(秒)

    self.width = 1
	self.length = 1

    self.check_interval = 4		--检查时间间隔(秒)
	self.left_time = 0

    self.is_working = false

    self.working_mode = EA_CONSTANTS.SEEDING_MACHINE_WORKING_MODES.SEQUENCE
end, nil, {
	width = OnRange,
	length = OnRange,
})


function SeedingMachine:SetRange(w, l)
	if type(w) == "number" and w > 0 then
		self.width = w
	end
	if type(l) == "number" and l > 0 then
		self.length = l
	end
end

function SeedingMachine:SetWorkingMode(mode)
    self.working_mode = mode
end

local function OnHitSeed(seed, attacker, target)
    if EA_TOOLS.IsOldFarm(seed.target) and seed.target.components.grower then   --旧农场
        seed.target.components.grower:PlantItem(seed, attacker.components.ea_seeding_machine.doer or attacker)
        seed:Remove()
        return
    end
    if EA_TOOLS.IsNewFarm(seed.target) and seed.components.farmplantable then   --新农场
        seed.components.farmplantable:Plant(seed.target, attacker.components.ea_seeding_machine.doer or attacker)
        return
    elseif EA_TOOLS.IsLegionFarm(seed.target) and ACTIONS.PLANTSOIL_LEGION then --棱镜
        for i = 1, 10 do
            local name, value = debug.getupvalue(ACTIONS.PLANTSOIL_LEGION.fn, i)
            if name == "OnPlant" and type(value) == "function" then
                value(seed, attacker.components.ea_seeding_machine.doer or attacker, seed.target)
            end
        end
        return
    end
    seed:RemoveComponent("complexprojectile")
    seed:RemoveComponent("locomotor")
    seed:RemoveTag("projectile")
    seed.Physics:SetActive(false)
    seed.entity:SetCanSleep(false)
end

function SeedingMachine:LaunchSeed(seed, target)
    --新农场在种植后会移除farm_soli，需要再次判空
    if not target or not seed then
        return
    end
    --如果农场临时发生变化不能种植了，则不发射
    if EA_TOOLS.IsOldFarm(target) and not (target.components.grower:IsEmpty() and target.components.grower:IsFertile()) then
        return
    end

    local inst = self.inst
    local x, y, z = inst.Transform:GetWorldPosition()

    seed.Transform:SetPosition(x, y, z)
    seed.target = target

    if not seed.Physics then
        seed.entity:AddPhysics()
        seed.Physics:SetMass(1)
        seed.Physics:SetFriction(0)
        seed.Physics:SetDamping(0)
        seed.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
        seed.Physics:ClearCollisionMask()
        seed.Physics:CollidesWith(COLLISION.GROUND)
        seed.Physics:SetCapsule(0.2, 0.2)
        seed.Physics:SetDontRemoveOnSleep(true)
    end
    if not seed:HasTag("projectile") then
        seed:AddTag("projectile")
    end
    if not seed.components.complexprojectile then
        seed:AddComponent("locomotor")
        seed:AddComponent("complexprojectile")
    end

    local targetpos = target:GetPosition()
    local dx = targetpos.x - x
    local dz = targetpos.z - z
    local rangesq = dx * dx + dz * dz
    local maxrange = EA_CONSTANTS.SEEDING_MAX_SIDE
    local speed = easing.linear(rangesq, 25, 3, maxrange * maxrange)

    seed.components.complexprojectile:SetHorizontalSpeed(speed)
    seed.components.complexprojectile:SetGravity(-25)
    seed.components.complexprojectile:SetLaunchOffset(Vector3(0, 3, 0))
    seed.components.complexprojectile:SetOnHit(OnHitSeed)
    seed.components.complexprojectile:Launch(targetpos, inst, inst)

    seed.entity:SetCanSleep(false)
    inst.AnimState:PlayAnimation("seed")
    inst.AnimState:PushAnimation("idle")
end

local function encode_vector(vec)
    return tostring(vec.x).." "..tostring(vec.z)
end

local function decode_vector(vec_str)
    local x, z = vec_str:match("(%-?%d+%.?%d*)%s+(%-?%d+%.?%d*)")
    if x and z then
        return Vector3(tonumber(x), 0, tonumber(z))
    end
end

--[[pos index:
    1, 2, 3,
    4, 5, 6,
    7, 8, 9,
]]
local FARM_INDEXS = {{1, 4, 7}, {2, 5, 8}, {3, 6, 9}}
local function try_get_farm_index(tile_center, farm)
    local vec = farm:GetPosition() - tile_center
    for i = 0, 2 do
        for j = 0, 2 do
            if vec.x < -2/3 + i * 4/3 and vec.z < -2/3 + j * 4/3 then
                return FARM_INDEXS[i+1][j+1]
            end
        end
    end
end

function SeedingMachine:TrySeedingToNextTile(tiles_data)
    self.is_working = true
    local inst = self.inst
    if inst:HasTag("burnt") or inst.components.container:IsEmpty() then
        inst.replica.container:SetCanBeOpened(true)
        self.is_working = false
        return
    end

    local tile_center, farms_on_tile
    for tile_center_str, farms in pairs(tiles_data) do
        tile_center = decode_vector(tile_center_str)
        farms_on_tile = farms
        tiles_data[tile_center_str] = nil
        break
    end
    if not tile_center then
        self.inst:DoTaskInTime(self.launch_interval, function ()
            inst.replica.container:SetCanBeOpened(true)
            self.is_working = false
        end)
        return
    end

    local will_launch = false
    for _, farm in ipairs(farms_on_tile) do
        local seed
        if self.working_mode == EA_CONSTANTS.SEEDING_MACHINE_WORKING_MODES.SEQUENCE then
            for k, v in pairs(inst.components.container.slots) do
                if v then
                    seed = inst.components.container:RemoveItem(v)
                    break
                end
            end
        elseif self.working_mode == EA_CONSTANTS.SEEDING_MACHINE_WORKING_MODES.BY_LOCATION then
            local index = try_get_farm_index(tile_center, farm)
            if index then
                seed = inst.components.container:RemoveItem(inst.components.container:GetItemInSlot(index))
            end
        end
        if seed then
            self:LaunchSeed(seed, farm)
            will_launch = true
        end
    end

    if will_launch then
        self.inst:DoTaskInTime(self.launch_interval, function ()
            self:TrySeedingToNextTile(tiles_data)
        end)
    else
        self:TrySeedingToNextTile(tiles_data)
    end
end

function SeedingMachine:StartSeeding(doer)
	local inst = self.inst
    if inst:HasTag("burnt") or inst.components.container:IsEmpty() then
        return
    end
    local tiles_data = {}   --Key: tile center(string), Value: {farm_inst}
    for _, ent in ipairs(self.inst.components.ea_rectangle:FindEntities(nil, {"INLIMBO"})) do
        if (EA_TOOLS.IsOldFarm(ent) and ent.components.grower:IsEmpty() and ent.components.grower:IsFertile())
        or ((EA_TOOLS.IsNewFarm(ent) or EA_TOOLS.IsLegionFarm(ent)) and not ent:HasTag("NOCLICK")) then     --注意：必须检查NOCLICK
            local tile_center = Vector3(TheWorld.Map:GetTileCenterPoint(ent.Transform:GetWorldPosition()))
            local center_str = encode_vector(tile_center)
            if not tiles_data[center_str] then
                tiles_data[center_str] = {}
            end
            table.insert(tiles_data[center_str], ent)
        end
    end

    self.doer = doer    --存储按下播种按钮的玩家
    inst.replica.container:SetCanBeOpened(false)
    if inst.components.container:IsOpen() then
        inst.components.container:Close()
    end
    self:TrySeedingToNextTile(tiles_data)
    self:StartUpdating()
end

function SeedingMachine:StartUpdating()
	self.inst:StartUpdatingComponent(self)
end

function SeedingMachine:StopUpdating()
	self.inst:StopUpdatingComponent(self)
end


function SeedingMachine:OnUpdate(dt)
	if self.inst:HasTag("burnt") or self.is_working or self.inst.components.container:IsOpen() then
		return
	end

    self.left_time = self.left_time - dt
    if self.left_time > 0 then
        return
    end
    self.left_time = self.check_interval
    self:StartSeeding(self.doer)
end


return SeedingMachine