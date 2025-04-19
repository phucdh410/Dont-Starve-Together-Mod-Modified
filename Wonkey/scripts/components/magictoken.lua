local Magictoken = Class(function(self, inst)
    self.inst = inst
    self.sanity_gain = 0
    self.health = 0
end)

function Magictoken:GetSanityGain()
    return self.sanity_gain
end

function Magictoken:SetSanityGain(val)
    if val then
        self.sanity_gain = val
    end
end

function Magictoken:GetHealthGain()
    return self.health
end

function Magictoken:SetHealthGain(val)
    if val then
        self.health = val
    end
end

function Magictoken:Break(doer)
    if doer and doer.components.sanity then
        doer.components.sanity:DoDelta(self.sanity_gain)
    end
    if doer and doer.components.health then
        doer.components.health:DoDelta(self.health)
    end
    self.inst:PushEvent("onbroken")
    self.inst.components.stackable:Get():Remove()
end


return Magictoken