local MAX_ITEM_NUM = EA_CONSTANTS.MAX_ACCEPT_ITEM_NUM

local FertilizerMachine = Class(function (self, inst)
	self.inst = inst
	self.fertilizer_num = 0
end)

function FertilizerMachine:Produce()
	local inst = self.inst
    local item = inst.components.container:GetItemInSlot(1)
    if not item then return end

    local item_num = item.components.stackable and item.components.stackable.stacksize or 1
    local valid_num = MAX_ITEM_NUM - self.fertilizer_num
    if item_num > valid_num then
        item_num = valid_num
    end

    inst:DoTaskInTime(5 * FRAMES, function()
        self.fertilizer_num = self.fertilizer_num + item_num
        inst.components.container:ConsumeByName(item.prefab, item_num)
        if inst.components.harvestable then
            for i = 1, item_num do
                inst.components.harvestable:Grow()
            end
        end
        self.inst:PushEvent("fertilizer_num_changed", {num = self.fertilizer_num, percent = math.clamp(self.fertilizer_num / MAX_ITEM_NUM, 0, 1)})
    end)
end

function FertilizerMachine:Clean()
	self.fertilizer_num = 0
end

function FertilizerMachine:OnSave()
	return {
		fertilizer_num = self.fertilizer_num
	}
end

function FertilizerMachine:OnLoad(data, newents)
	if data ~= nil then
        self.fertilizer_num = data.fertilizer_num or 0
        self.inst:PushEvent("fertilizer_num_changed", {num = self.fertilizer_num, percent = math.clamp(self.fertilizer_num / MAX_ITEM_NUM, 0, 1)})
	end
end


return FertilizerMachine