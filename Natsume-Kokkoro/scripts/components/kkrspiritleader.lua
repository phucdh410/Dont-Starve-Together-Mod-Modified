local c =
    Class(
    function(self, inst)
        self.inst = inst
        self.formation = {}
        self.target = nil
        self.theta = 0
        self.thetaincrement = 0.9
        self.radius = 2
        self.reverse = false
        self.attack_cd = 0
        self.move_cd = 0
        -- self.onupdatefn = nil
        -- self.ondisbandfn = nil
    end
)

function c:StartUpdatingComponent()
    if not self.target then
        return
    end
    self.inst:StartUpdatingComponent(self)
end
function c:GetFormationSize()
    local formation = {}
    for k, v in pairs(self.formation) do
        if v and v:IsValid() then
            table.insert(formation, v)
        end
    end
    self.formation = formation
    return #formation
end
function c:SetTarget(target)
    self.target = target
end
function c:SetMember(member)
    table.insert(self.formation, member)
    if self.target.components.leader ~= nil then
        self.target.components.leader:AddFollower(member)
    end
end

function c:DisbandFormation()
    self.inst:StopUpdatingComponent(self)
    for k, v in pairs(self.formation) do
        if v and v:IsValid() then
            v:Remove()
        end
    end
    self.inst:Remove()
end

function c:Move(inst, targetpos)
    local x, y, z = inst.Transform:GetWorldPosition()
    local dist = VecUtil_Length(targetpos.x - x, targetpos.z - z)
    if dist > 100 then
        inst.Transform:SetPosition(targetpos.x, 0, targetpos.z)
    else
        inst.components.locomotor.walkspeed = math.min(dist * 8, 10.5)
        inst:FacePoint(targetpos.x, 0, targetpos.z)
        inst.components.locomotor:WalkForward(true)
    end
end

function c:OnAttack(attacker, target)
    if self.attack_cd > 0 then
        return
    end
    self.attack_cd = 0.5
    self.move_cd = 0.2
    for _, v in pairs(self.formation) do
        if v:IsValid() then
            v:OnAttack(attacker, target)
        end
    end
end

function c:GetFormationPositions()
    local pt = Vector3(self.target.Transform:GetWorldPosition())
    local theta = self.theta
    local radius = self.radius
    local size = self:GetFormationSize()
    local count = 1
    for k, v in pairs(self.formation) do
        radius = self.radius
        local offset =
            Vector3(radius * math.cos(theta + (PI2 * count / size)), 0, radius * math.sin(theta + (PI2 * count / size)))
        self:Move(v, pt + offset)
        count = count + 1
    end
end

function c:GetTheta(dt)
    if self.reverse then
        return self.theta - (dt * self.thetaincrement)
    else
        return self.theta + (dt * self.thetaincrement)
    end
end

function c:OnUpdate(dt)
    if self.attack_cd > 0 then
        self.attack_cd = self.attack_cd - dt
    end
    if self.move_cd > 0 then
        self.move_cd = self.move_cd - dt
    end
    if self.target and self.target:IsValid() then -- Is there a target?
        if self.move_cd <= 0 then
            self.theta = self:GetTheta(dt) -- Spin the formation
            self:GetFormationPositions()
        end
    else
        self:DisbandFormation()
    end
end

return c
