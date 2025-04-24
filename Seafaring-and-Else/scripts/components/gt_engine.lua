require("util/sourcemodifierlist")

local function on_remove(inst)
    local engine=inst.components.gt_engine
    if engine ~= nil then
        engine:SetBoat(nil)
    end
end

local GT_Engine = Class(function(self, inst)
    self.inst = inst
    self.sail_force = TUNING.BOAT.MAST.BASIC.SAIL_FORCE
    --self.has_speed = false
    self.boat = nil
    self.rudder = nil
    --self.max_velocity_mod = TUNING.BOAT.MAST.BASIC.MAX_VELOCITY_MOD
    self.max_velocity = TUNING.BOAT.MAST.BASIC.MAX_VELOCITY
    --self.rudder_turn_drag = TUNING.BOAT.MAST.BASIC.RUDDER_TURN_DRAG
    
    self.multipliers=SourceModifierList(inst)

    --self.inst:StartUpdatingComponent(self)

    self.inst:ListenForEvent("onremove", on_remove)

    self.inst:DoTaskInTime(0,
    	function() 
			local mast_x, mast_y, mast_z = self.inst.Transform:GetWorldPosition()
    		self:SetBoat(TheWorld.Map:GetPlatformAtPoint(mast_x, mast_z))
    	end)
end,
nil,
{	
})

function GT_Engine:SetModifier(source, key, m)
    self.multipliers:SetModifier(source, m, key)
end

function GT_Engine:RemoveModifier(source, key)
    self.multipliers:RemoveModifier(source, key)
end

function GT_Engine:SetMaxVelocity(vel)
    self.max_velocity = vel
end

function GT_Engine:SetSailForce(set)
    self.sail_force = set
end

function GT_Engine:CalcSailForce()
    return self.sail_force * self.multipliers:Get()
end

function GT_Engine:CalcMaxVelocity()
	return self.max_velocity * self.multipliers:Get()
end

function GT_Engine:SetBoat(boat)
    if boat == self.boat then return end

    if self.boat ~= nil then
        self.boat.components.boatphysics:RemoveMast(self)
    end

    self.boat = boat

    if boat ~= nil then        
        boat.components.boatphysics:AddMast(self)
    end

    
end

function GT_Engine:OnRemoveFromEntity()  
    self.inst:RemoveEventCallback("onremove", on_remove)    
end

function GT_Engine:SetRudderDirection(rudder_direction_x, rudder_direction_z)
    --Функция пустая, я оставил её здесь только чтоб игра не ругалась
end

function GT_Engine:CloseSail()
    --Функция пустая, я оставил её здесь только чтоб игра не ругалась
end

--function GT_Engine:OnUpdate(dt)    
--    local mast_x, mast_y, mast_z = self.inst.Transform:GetWorldPosition()
--
--    if self.boat == nil then return end
--
--    local boat_physics = self.boat.components.boatphysics
--    local rudder_direction_x, rudder_direction_z = boat_physics.rudder_direction_x, boat_physics.rudder_direction_z
--	self.inst:FacePoint(rudder_direction_x + mast_x, 0, rudder_direction_z + mast_z)
--end

return GT_Engine
