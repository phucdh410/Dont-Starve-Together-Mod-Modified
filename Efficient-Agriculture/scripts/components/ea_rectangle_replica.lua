local function OnSizeChanged(inst)
	if inst.replica.ea_rectangle then
		inst.replica.ea_rectangle:CreateEdges()
	end
end

local function OnCanShowArea(inst)
	if inst.replica.ea_rectangle then
		if not inst.replica.ea_rectangle._can_show_area:value() then
			inst.replica.ea_rectangle:ShowArea(false)
		end
	end
end

local function OnMouseOver(inst)
    if inst.replica.ea_rectangle and inst.replica.ea_rectangle._can_show_area:value() then
        inst.replica.ea_rectangle:ShowArea(true)
    end
end

local function OnMouseOut(inst)
    if inst.replica.ea_rectangle and inst.replica.ea_rectangle._can_show_area:value() then
        inst.replica.ea_rectangle:ShowArea(false)
    end
end


local Area = Class(function (self, inst)
	self.inst = inst

	self._size = net_string(inst.GUID, "ea_rectangle._size", "ea_rectangle._size")
	self._offset = net_string(inst.GUID, "ea_rectangle._offset", "ea_rectangle._offset")
	self._can_show_area = net_bool(inst.GUID, "ea_rectangle._can_show_area", "ea_rectangle._can_show_area")
	if not TheNet:IsDedicated() then
		self.show_area = false
		self.edges = {}
		self.area = nil
		inst:ListenForEvent("ea_rectangle._size", OnSizeChanged)
		inst:ListenForEvent("ea_rectangle._can_show_area", OnCanShowArea)
		inst:ListenForEvent("mouseover", OnMouseOver)
		inst:ListenForEvent("mouseout", OnMouseOut)
	end
	if TheWorld.ismastersim then
		self._can_show_area:set(true)
	end
end)


function Area:SetCanShowArea(val)
	if TheWorld.ismastersim then
		self._can_show_area:set(val == true)
	end
end

function Area:GetVertexsGlobalPosition()
	local inst_pos = self.inst:GetPosition()
	local rot = EA_TOOLS.GetGlobalRotation(self.inst)
	local deg = math.rad(rot)
	local local_vertexs = self:GetVertexsLocalPosition()
	local local_coord = {
		x = Vector3(math.cos(deg), 0, -math.sin(deg)),
		z = Vector3(-math.sin(deg), 0, -math.cos(deg))
	}
	return {
		inst_pos + local_coord.x * local_vertexs[1].x + local_coord.z * local_vertexs[1].z,
		inst_pos + local_coord.x * local_vertexs[2].x + local_coord.z * local_vertexs[2].z,
		inst_pos + local_coord.x * local_vertexs[3].x + local_coord.z * local_vertexs[3].z,
		inst_pos + local_coord.x * local_vertexs[4].x + local_coord.z * local_vertexs[4].z,
	}
end

function Area:GetVertexsLocalPosition()
	local size = self:GetSize()
	local half_w = size.w * 0.5
	local half_h = size.h * 0.5
	local offset = self:GetOffset()
	return {
		Vector3(-half_w, 0, -half_h) + offset,
		Vector3(-half_w, 0, half_h) + offset,
		Vector3(half_w, 0, half_h) + offset,
		Vector3(half_w, 0, -half_h) + offset,
	}
end

function Area:IsPointInArea(point)
	local vertexs = self:GetVertexsGlobalPosition()
	return EA_TOOLS.IsPointInsideConvexQuad(point, vertexs)
end

function Area:SetSize(w, h)		--z轴的长度对应宽度
	if (type(w) ~= "number" or w < 0) or (type(h) ~= "number" or h < 0) then
		return
	end
	if TheWorld.ismastersim then
		self._size:set(tostring(w).."x"..tostring(h))
	else
		self._size:set_local(tostring(w).."x"..tostring(h))
	end
end

function Area:GetSize()
	local w, h = string.match(self._size:value(), "(%-?%d+%.?%d*)x(%-?%d+%.?%d*)")	--使用模式匹配来提取宽度和高度
	return (w and h) and {w = w, h = h} or {w = 0, h = 0}
end

function Area:SetOffset(x, z)
	local offset = self:GetOffset()
	if type(x) == "number" then
		offset.x = x
	end
	if type(z) == "number" then
		offset.z = z
	end
	if TheWorld.ismastersim then
		self._offset:set(tostring(offset.x).."x"..tostring(offset.z))
	else
		self._offset:set_local(tostring(offset.x).."x"..tostring(offset.z))
	end
end

function Area:GetOffset()
	local x, z = string.match(self._offset:value(), "(%-?%d+%.?%d*)x(%-?%d+%.?%d*)")
	return (x and z) and Vector3(x, 0, z) or Vector3()
end

function Area:GetCenterGlobalPosition()
	local inst_pos = self.inst:GetPosition()
	local offset = self:GetOffset()
	local rot = EA_TOOLS.GetGlobalRotation(self.inst)
	local deg = math.rad(rot)
	local local_coord = {
		x = Vector3(math.cos(deg), 0, -math.sin(deg)),
		z = Vector3(-math.sin(deg), 0, -math.cos(deg))
	}
	return inst_pos + local_coord.x * offset.x + local_coord.z * offset.z
end

function Area:GetDiagonalLength()
	local size = self:GetSize()
	return math.sqrt(size.w*size.w + size.h*size.h)
end

function Area:FindEntities(must_tags, ignore_tags, one_of_tags)
	local res = {}
	local center_pos = self:GetCenterGlobalPosition()
	for i, ent in ipairs(TheSim:FindEntities(center_pos.x, 0, center_pos.z, self:GetDiagonalLength()/2+0.2, must_tags, ignore_tags, one_of_tags)) do
		if self:IsPointInArea(ent:GetPosition()) then
			table.insert(res, ent)
		end
	end
	return res
end

------------------------------
-- Only Client
------------------------------

function Area:RemoveEdeges()
	if TheNet:IsDedicated() then
		return
	end
	if type(self.edges) == "table" then
		for i, edge in pairs(self.edges) do
			edge:Remove()
		end
	end
	self.edges = {}
	if self.area then
		self.area:Remove()
		self.area = nil
	end
end

local EDGE_SPACING = 1
function Area:CreateEdges()
	if TheNet:IsDedicated() then
		return
	end
	self:RemoveEdeges()
	if not self.show_area then
		return
	end

	local vertexs = self:GetVertexsLocalPosition()
	for i = 1, 4 do
		local cur_vert = vertexs[i]
		local next_index = i + 1
		local next_vert = vertexs[next_index <= 4 and next_index or 1]
		if cur_vert and next_vert then
			local vector = next_vert - cur_vert
			local normal, len = vector:GetNormalizedAndLength()
			local edge_num = math.floor(len + 0.5)
			local edge_scale = len / (EDGE_SPACING * edge_num)
			local angle = EA_TOOLS.GetAngleToPoint(cur_vert, next_vert)
			local scaled_spacing = EDGE_SPACING * edge_scale
			for j = 1, edge_num do
				local edge = self.inst:SpawnChild("ea_area_edge")
				edge.Transform:SetPosition((cur_vert + normal * ((j-1) * scaled_spacing)):Get())
				edge.Transform:SetRotation(angle)
				edge.AnimState:SetScale(edge_scale, 1)
				table.insert(self.edges, edge)
			end
		end
	end

	self.area = self.inst:SpawnChild("ea_rectangle")
	self.area.Transform:SetPosition(((vertexs[1] + vertexs[3])/2):Get())
	local size = self:GetSize()
	self.area:SetSize(size.w, size.h)
end

function Area:ShowArea(show)
	if TheNet:IsDedicated() or show == self.show_area then
		return
	end
	if show then
		self.show_area = true
		self:CreateEdges()
	else
		self.show_area = false
		self:RemoveEdeges()
	end
end


return Area