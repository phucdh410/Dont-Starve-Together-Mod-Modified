require "behaviours/controlxxx3minions"
require "behaviours/standstill"

local Xxx3Brain = Class(Brain, function(self, inst)
	Brain._ctor(self, inst)
end)

function Xxx3Brain:OnStart()
    local root = PriorityNode(
    {
        WhileNode(function()
            return self.inst.components.xxx3_minionspawner ~= nil end,
            "eyeplant_eat",
            ControlXxx3Minions(self.inst)
        ),
        --StandStill(self.inst),
    }, .25)

    self.bt = BT(self.inst, root)
end

return Xxx3Brain