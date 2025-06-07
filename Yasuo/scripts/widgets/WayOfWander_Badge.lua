local Badge = require "widgets/badge"

local WayOfWander_Badge = Class(Badge, function(self, owner)
    Badge._ctor(self, "way_of_wander", owner)
    self:SetPercent(1, self.owner.replica.yasuo_skills.way_of_wander_max:value())
end)

function WayOfWander_Badge:SetPercent(val, max)
    Badge.SetPercent(self, val, max)
end

return WayOfWander_Badge
