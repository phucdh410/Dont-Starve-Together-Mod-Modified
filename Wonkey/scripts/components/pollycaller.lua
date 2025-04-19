local function TogglePolly(inst)
    local owner = inst.components.inventoryitem.owner
    if inst.polly then
        if inst.pollytask then
            inst.pollytask:Cancel()
            inst.pollytask = nil
        end

        if inst.polly then
            inst.polly.flyaway = true
            inst.polly:PushEvent("flyaway")
        end
    end

    if not inst.polly then
        if not inst.polly and not inst.components.spawner:IsSpawnPending() then
            inst.components.spawner:ReleaseChild()
        end

        inst.polly = inst.components.spawner.child
        if inst.polly then
            inst.polly.components.follower:SetLeader(owner)
            inst.polly.flyaway = nil
        end
    end
end

local PollyCaller = Class(function(self, inst)
	self.inst = inst
	self.ontogglefn = TogglePolly
    self.on = false
	self.ondismissfn = nil
end)

function PollyCaller:DoUpdate()
    self.inst:PushEvent("pollytoggled")
end

function PollyCaller:TogglePolly()
	if self.on then
		self.on = false
	else
		self.on = true
	end
	if self.ontogglefn then
		self.ontogglefn(self.inst,self.on)
	end
    self:DoUpdate()
end

return PollyCaller