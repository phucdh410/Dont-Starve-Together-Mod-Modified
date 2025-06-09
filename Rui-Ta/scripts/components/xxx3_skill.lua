local xxx3_skill = Class(function(self, inst)
    self.inst = inst
    self.enabled = false
end)

function xxx3_skill:SetEnabled(enable)
    self.enabled = enable
end

return xxx3_skill