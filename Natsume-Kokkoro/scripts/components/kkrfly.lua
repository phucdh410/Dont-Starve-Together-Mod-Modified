local kkrfly =
    Class(
    function(self, inst)
        self.inst = inst
        self.kkr_fly = false

        self.inst:ListenForEvent(
            "death",
            function()
                if self.kkr_fly == true then
                    self:Land()
                end
            end
        )
    end
)

function kkrfly:IsFly()
    return self.kkr_fly
end

local function onequip(inst, data)
    if inst.components.kkrfly.kkr_fly == true then
        inst.components.kkrfly:Land()
    end
end
local function onunequip(inst, data)
    if inst.components.kkrfly.kkr_fly == true then
        inst.components.kkrfly:Land()
    end
end

local function FlyConsume(inst)
    if inst.components.hunger then
        inst.components.hunger:DoDelta(-5, true)
    end
end

function kkrfly:Fly()
    self.kkr_fly = true
    self.inst:AddTag("kkr_fly")
    if self.inst.Physics then
        RemovePhysicsColliders(self.inst)
    end
    local inv = self.inst.components.inventory
    local equip_slots = inv.equipslots
    for k, _ in pairs(equip_slots) do
        if k ~= "hands" then
            local item = inv:GetEquippedItem(k)
            if item and not item.components.container then
                local item1 = inv:Unequip(k)
                if item1 then
                    inv:GiveItem(item1)
                end
            end
        end
    end
    if self.inst.components.drownable then
        self.inst.components.drownable.enabled = false
    end
    if self.inst then
        local fx = SpawnPrefab("spawn_fx_small")
        fx.entity:SetParent(self.inst.entity)
        self.inst.components.locomotor:SetExternalSpeedMultiplier(self.inst, "kkr_fly", 1.25)
        self.inst.components.locomotor:SetTriggersCreep(false)
        if not self.inst.kkr_fly_task then
            self.inst.kkr_fly_task = self.inst:DoPeriodicTask(5, FlyConsume)
        end

        self.inst.AnimState:PlayAnimation("kkr_fly", true)
        self.inst.AnimState:ClearOverrideSymbol("swap_body_tall")
        self.inst.AnimState:OverrideSymbol("cope", "kkr_fly", "cope")
        self.inst.AnimState:OverrideSymbol("wing", "kkr_fly", "wing")
        self.inst.AnimState:OverrideSymbol("hemlines", "kkr_fly", "hemlines")
        self.inst.AnimState:OverrideSymbol("torso", "kkr_fly", "torso")
        self.inst.AnimState:OverrideSymbol("arm_upper", "kkr_fly", "arm_upper")
        self.inst.AnimState:OverrideSymbol("arm_upper_skin", "kkr_fly", "arm_upper_skin")
        self.inst.AnimState:OverrideSymbol("arm_lower", "kkr_fly", "arm_lower")
        self.inst.AnimState:OverrideSymbol("headbase", "kkr_fly", "headbase")
        self.inst.AnimState:OverrideSymbol("leg", "kkr_fly", "leg")
        self.inst.AnimState:OverrideSymbol("hand", "kkr_fly", "hand")
        self.inst:ListenForEvent("equip", onequip)
        self.inst:ListenForEvent("unequip", onunequip)
    end

    --self.inst:StartUpdatingComponent(self)
end

function kkrfly:Land()
    self.kkr_fly = false
    self.inst:RemoveTag("kkr_fly")
    if self.inst.Physics then
        ChangeToCharacterPhysics(self.inst)
    end

    if self.inst.components.drownable then
        self.inst.components.drownable.enabled = true
    end
    if self.inst then
        local fx = SpawnPrefab("spawn_fx_small")
        fx.entity:SetParent(self.inst.entity)
        self.inst.components.locomotor:RemoveExternalSpeedMultiplier(self.inst, "kkr_fly")
        self.inst.components.locomotor:SetTriggersCreep(true)
        if self.inst.kkr_fly_task then
            self.inst.kkr_fly_task:Cancel()
            self.inst.kkr_fly_task = nil
        end
        self.inst.AnimState:PlayAnimation("idle")
        self.inst.AnimState:ClearOverrideSymbol("cope")
        self.inst.AnimState:ClearOverrideSymbol("wing")
        self.inst.AnimState:ClearOverrideSymbol("hemlines")
        self.inst.AnimState:ClearOverrideSymbol("torso")
        self.inst.AnimState:ClearOverrideSymbol("arm_upper")
        self.inst.AnimState:ClearOverrideSymbol("arm_upper_skin")
        self.inst.AnimState:ClearOverrideSymbol("arm_lower")
        self.inst.AnimState:ClearOverrideSymbol("headbase")
        self.inst.AnimState:ClearOverrideSymbol("leg")
        self.inst.AnimState:ClearOverrideSymbol("hand")
        self.inst:RemoveEventCallback("equip", onequip)
        self.inst:RemoveEventCallback("unequip", onunequip)
    end
    --self.inst:StopUpdatingComponent(self)
end

function kkrfly:OnSave()
    return {
        isfly = self:IsFly()
    }
end

function kkrfly:OnLoad(data)
    if data then
        if data.isfly ~= nil and data.isfly == true then
            self:Fly()
        end
    end
end

return kkrfly
