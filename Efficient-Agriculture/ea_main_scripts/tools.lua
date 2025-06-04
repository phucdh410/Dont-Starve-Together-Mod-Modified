local PLANT_DEFS = require("prefabs/farm_plant_defs").PLANT_DEFS
local function IsValidFarmPlant(item)
	return PLANT_DEFS[item.prefab] ~= nil
end

local function IsValidVeggie(item)
	if VEGGIES[item.prefab] or EA_CONSTANTS.MOD_PLANTS[item.prefab] then
		return true
	end
	return false
end

local function IsValidSeed(item)
	return ((item:HasTag("deployedplant") and item:HasTag("cookable")) or item:HasTag("deployedfarmplant")) and item.prefab ~= "acorn"
end

local WEED_DEFS = require("prefabs/weed_defs").WEED_DEFS
local function IsWeed(item)
	for weed, data in pairs(WEED_DEFS) do
		if data.product == item.prefab then
			return true
		end
	end
	return false
end

local function IsOldFarm(ent)
	return ent ~= nil and (ent.prefab == "slow_farmplot" or ent.prefab == "fast_farmplot")
end

local function IsNewFarm(ent)
	return ent ~= nil and ent.prefab == "farm_soil"
end

local function IsLegionFarm(ent)
	return ent ~= nil and ent:HasTag("soil_legion")
end

local function RotAbs(rot)
    if rot < 0 then
        rot = rot + 360
    end
    if rot >= 360 then
        rot = rot - 360
    end
    return rot
end

local function IsPointInsideConvexQuad(pos, quad)
    local side = nil
    for i = 1, 4 do
        local x1, z1 = quad[i].x, quad[i].z
        local next = i % 4 + 1
        local x2, z2 = quad[next].x, quad[next].z
        local currSide = (x2 - x1) * (pos.z - z1) - (z2 - z1) * (pos.x - x1)
        if side == nil then
            side = currSide
        elseif side * currSide < 0 then
            return false
        end
    end
    return true
end

local function GetAngleToPoint(pt1, pt2)
	local x, y, z = pt2:Get()
    local x1, y1, z1 = pt1:Get()
	return x1 == x and z1 == z and 0 or math.deg(math.atan2(z1 - z, x - x1))
end

local function GetGlobalRotation(inst)
	local rot = inst:GetRotation()
	if inst.parent then
		local parent_rot = GetGlobalRotation(inst.parent)
		rot = rot + parent_rot
	end
	return rot
end

local tile_size = 4
local function GetTiles(x, z, radius)
	if radius == 0 then return {} end
	local tiles = {}
	local org = Vector3(x, 0, z)
	local org_tile_center = Vector3(TheWorld.Map:GetTileCenterPoint(x, 0, z))
	local org_offset = org - org_tile_center
	local top_count = math.ceil((org_offset.z + radius) / tile_size)
	local bottom_count = math.floor((org_offset.z - radius) / tile_size)
	local right_count = math.ceil((org_offset.x + radius) / tile_size)
	local left_count = math.floor((org_offset.x - radius) / tile_size)
	local radiusq = radius * radius

	for i = math.ceil(org_tile_center.x+left_count*tile_size), math.floor(org_tile_center.x+right_count*tile_size), 4 do
		for j = math.ceil(org_tile_center.z+bottom_count*tile_size), math.floor(org_tile_center.z+top_count*tile_size), 4 do
			local cur_pos = Vector3(i, 0, j)
			if org:DistSq(cur_pos) <= radiusq then
				table.insert(tiles, cur_pos)
			end
		end
	end

	return tiles
end

_G.EA_TOOLS = {
	IsValidFarmPlant = IsValidFarmPlant,
	IsValidSeed = IsValidSeed,
	IsValidVeggie = IsValidVeggie,
	IsWeed = IsWeed,
	IsOldFarm = IsOldFarm,
	IsNewFarm = IsNewFarm,
	IsLegionFarm = IsLegionFarm,
	RotAbs = RotAbs,
	IsPointInsideConvexQuad = IsPointInsideConvexQuad,
	GetAngleToPoint = GetAngleToPoint,
	GetGlobalRotation = GetGlobalRotation,
	GetTiles = GetTiles,
}