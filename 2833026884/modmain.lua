-- TUNING.BEEFALO_ORNERY_DOATTACK = 0.004 * 10
-- TUNING.BEEFALO_ORNERY_ATTACKED = 0.004 * 10
local domestication_accelerate = GetModConfigData("domestication_accelerate")
local domestication_dont_loss = GetModConfigData("domestication_dont_loss")
local ornery_min_domesticated_obedience = GetModConfigData("ornery_min_domesticated_obedience")

TUNING.BEEFALO_DOMESTICATION_GAIN_DOMESTICATION = 1 / (480 * (20 / domestication_accelerate))
TUNING.BEEFALO_MIN_DOMESTICATED_OBEDIENCE = {
    DEFAULT = 0.8,
    ORNERY = ornery_min_domesticated_obedience, -- 0.45
    RIDER = 0.95,
    PUDGY = 0.6
}
if domestication_dont_loss then
    TUNING.BEEFALO_DOMESTICATION_LOSE_DOMESTICATION = 0
end

if GetModConfigData("domestication_nopoop") then
    AddPrefabPostInit("beefalo", function(inst)
        if not GLOBAL.TheWorld.ismastersim then return inst end

        if inst.components.periodicspawner ~= nil then
            local _SetSpawnTestFn = inst.components.periodicspawner.SetSpawnTestFn
            inst.components.periodicspawner:SetSpawnTestFn(function(inst)
                if inst.components.domesticatable and inst.components.domesticatable:IsDomesticated() then
                    return false
                else
                    return _SetSpawnTestFn(inst)
                end
            end)
        end
    end)
end