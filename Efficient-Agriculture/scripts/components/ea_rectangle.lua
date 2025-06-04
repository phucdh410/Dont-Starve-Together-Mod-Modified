local Area = Class(function (self, inst)
	self.inst = inst

	self.size = {w = 1, h = 1}
	self.offset = Vector3()
end)

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

function Area:SetSize(w, h)
	if (type(w) ~= "number" or w < 0) or (type(h) ~= "number" or h < 0) then
		return
	end
	self.size.w = w
	self.size.h = h
	if self.inst.replica.ea_rectangle then
		self.inst.replica.ea_rectangle:SetSize(w, h)
	end
end

function Area:GetSize()
	return self.size or {w = 0, h = 0}
end

function Area:SetOffset(x, z)
	if type(x) == "number" then
		self.offset.x = x
	end
	if type(z) == "number" then
		self.offset.z = z
	end
	self.inst.replica.ea_rectangle:SetOffset(x, z)
end

function Area:GetOffset()
	return self.offset or Vector3()
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

function Area:SetCanShowArea(val)
	self.inst.replica.ea_rectangle:SetCanShowArea(val)
end

return Area