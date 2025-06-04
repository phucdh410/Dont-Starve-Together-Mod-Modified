local assets = {
    Asset("ANIM", "anim/ea_jinkela.zip"),
    Asset("IMAGE", "images/inventoryimages/ea_jinkela.tex"),
    Asset("ATLAS", "images/inventoryimages/ea_jinkela.xml"),
}

local function GetFertilizerKey(inst)
    return inst.prefab
end

local function FertilizerResearchFn(inst)
    return inst:GetFertilizerKey()
end

local function OnApplied(inst, final_use, doer, target)
    local tilecenter
    if target then
        tilecenter = target:GetPosition()
    else
        tilecenter = Vector3(TheWorld.Map:GetTileCenterPoint(TheWorld.Map:GetTileCoordsAtPoint(doer.Transform:GetWorldPosition())))
    end

    for k, ent in ipairs(TheSim:FindEntities(tilecenter.x, 0, tilecenter.z, 3)) do
        local x, y, z = ent.Transform:GetWorldPosition()
        if x <= tilecenter.x+2 and x >= tilecenter.x-2 and z <= tilecenter.z+2 and z >= tilecenter.z-2 then
            if ent.components.perennialcrop then
                local next_stage = ent.components.perennialcrop.stage + 1
                if ent.components.perennialcrop.stages[next_stage] then
                    ent.components.perennialcrop:DoGrowth()
                end
            elseif ent.components.growable then
                local next_stage = ent.components.growable:GetStage() + 1
                if ent.components.growable.stages[next_stage] and ent.components.growable.stages[next_stage].name ~= "rotten" then
                    ent.components.growable:DoGrowth()
                end
            end
        end
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("ea_jinkela")
    inst.AnimState:SetBuild("ea_jinkela")
    inst.AnimState:PlayAnimation("idle")

    MakeInventoryFloatable(inst)
    MakeDeployableFertilizerPristine(inst)

    inst:AddTag("heal_fertilize")
    inst:AddTag("slowfertilize") 

    inst:AddTag("fertilizerresearchable")
    inst.GetFertilizerKey = GetFertilizerKey

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/ea_jinkela.xml"

	inst:AddComponent("stackable")

    inst:AddComponent("fertilizerresearchable")
    inst.components.fertilizerresearchable:SetResearchFn(FertilizerResearchFn)

    inst:AddComponent("fertilizer")
    inst.components.fertilizer:SetHealingAmount(TUNING.POOP_FERTILIZE_HEALTH)
    inst.components.fertilizer.fertilizervalue = EA_CONSTANTS.ENABLED_MODS.legion and TUNING.POOP_FERTILIZE * 50 or TUNING.POOP_FERTILIZE * 10
    inst.components.fertilizer.soil_cycles = TUNING.POOP_SOILCYCLES
    inst.components.fertilizer.withered_cycles = TUNING.POOP_WITHEREDCYCLES
    inst.components.fertilizer:SetNutrients(8, 8, 8)
    inst.components.fertilizer.onappliedfn = OnApplied

    MakeDeployableFertilizer(inst)
    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("ea_jinkela", fn, assets)