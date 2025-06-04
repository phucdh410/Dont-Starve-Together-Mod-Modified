local MoveStack = Class(function(self, inst)
  self.inst = inst
	self.stack = nil
	self.cur_stack = nil
end)

function MoveStack:SetStack(pts)
	self.stack = {}
	self.cur_stack = {}
	for i, pt in ipairs(pts) do
		table.insert(self.stack, pt)
		table.insert(self.cur_stack, pt)
	end
end

function MoveStack:ClearStack()
	self.stack = nil
	self.cur_stack = nil
	self:StopMoving()
end

function MoveStack:SetOnReach(fn)
	if type(fn) == "function" then
		self.on_reach_fn = fn
	end
end

function MoveStack:Move()
	if type(self.cur_stack) == "table" then
		local pt = table.remove(self.cur_stack)
		if pt then
			if self.inst.components.locomotor and self.inst.Physics then
				self.inst.components.locomotor:SetReachDestinationCallback(function()
					self.inst:StopUpdatingComponent(self)
					if self.change_physics then
						ChangeToObstaclePhysics(self.inst)
					end
					if self.on_reach_fn then
						self.on_reach_fn(self.inst, Vector3(pt[1], 0, pt[2]))
					end
				end)

				if self.inst.Physics:GetMass() == 0 then
					self.change_physics = true
					ChangeToCharacterPhysics(self.inst, 75)
				end
				self.inst.components.locomotor:GoToPoint(Vector3(pt[1], 0, pt[2]), nil, true)
				self.inst:StartUpdatingComponent(self)
			else
				self.inst.Transform:SetPosition(pt[1], 0, pt[2])
				if self.on_reach_fn then
					self.on_reach_fn(self.inst, Vector3(pt[1], 0, pt[2]))
				end
			end
			return true
		end
	end
	return false
end

function MoveStack:StopMoving()
	self.inst:StopUpdatingComponent(self)
	if self.inst.components.locomotor then
		self.inst.components.locomotor:Stop()
	end
end

function MoveStack:IsEmpty()
	return type(self.cur_stack) ~= "table" or type(self.cur_stack[1]) ~= "table"
end

function MoveStack:OnUpdate(dt)
	self.inst.components.locomotor:RunForward()
end

return MoveStack