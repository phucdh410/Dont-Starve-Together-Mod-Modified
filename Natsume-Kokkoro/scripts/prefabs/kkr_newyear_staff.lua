local assets = {
    Asset("ANIM", "anim/kkr_newyear_staff.zip"),
    Asset("ANIM", "anim/swap_kkr_newyear_staff.zip"),
    Asset("ATLAS", "images/inventoryimages/kkr_newyear_staff.xml"),
    Asset("IMAGE", "images/inventoryimages/kkr_newyear_staff.tex")
}

local function OnSpell(inst, target, pos, doer)
    if inst.components.container then
        local item = inst.components.container:GetItemInSlot(1)
        if item then
            if (item.components.edible ~= nil) or (item.components.healer ~= nil) then
                if item.components.edible then
                    local healthvalue = item.components.edible.healthvalue or 0
                    local sanityvalue = item.components.edible.sanityvalue or 0

                    local x, y, z = doer.Transform:GetWorldPosition()
                    local ents = TheSim:FindEntities(x, y, z, 20, {"_combat", "_health", "player"}, {"playerghost"})
                    for _, v in ipairs(ents) do
                        if v.components.health then
                            v.components.health:DoDelta(healthvalue)
                        end

                        if v.components.sanity then
                            v.components.sanity:DoDelta(sanityvalue)
                        end

                        if item.components.edible.oneaten then
                            item.components.edible.oneaten(item, v)
                        end
                    end
                    inst.components.finiteuses:Use(1)
                    inst.components.container:ConsumeByName(item.prefab, 1)
                elseif item.components.healer then
                    local healthvalue = item.components.healer.health or 0
                    local x, y, z = doer.Transform:GetWorldPosition()
                    local ents = TheSim:FindEntities(x, y, z, 7, {"_combat", "_health", "player"}, {"playerghost"})
                    for _, v in ipairs(ents) do
                        if v.components.health then
                            v.components.health:DoDelta(healthvalue)
                        end
                    end
                    inst.components.finiteuses:Use(1)
                    inst.components.container:ConsumeByName(item.prefab, 1)
                end
            else
                doer.components.talker:Say("容器中不是需要的物品")
                return false
            end
        else
            doer.components.talker:Say("容器中没有物品")
            return false
        end
    end
end

local function OnBroken(inst)
    inst.components.spellcaster:SetSpellFn(nil)
end

local function OnRepaired(inst)
    inst.components.spellcaster:SetSpellFn(OnSpell)
end

local colour_tint = {0.4, 0.3, 0.25, 0.2, 0.1}
local mult_tint = {0.7, 0.6, 0.55, 0.5, 0.45}

local function CreateLight(item, owner)
    if owner and not owner._kkr_light1 then
        local light1 = SpawnPrefab("kkr_light1")
        local r = 0
        local g = 0
        local b = 0
        if item.prefab == "spore_medium" then
            r = 1
            light1.Light:SetColour(
                colour_tint[g + b + 1] + r / 11,
                colour_tint[r + b + 1] + g / 11,
                colour_tint[r + g + 1] + b / 11
            )
        elseif item.prefab == "spore_small" then
            g = 1
            light1.Light:SetColour(
                colour_tint[g + b + 1] + r / 11,
                colour_tint[r + b + 1] + g / 11,
                colour_tint[r + g + 1] + b / 11
            )
        elseif item.prefab == "spore_tall" then
            b = 1
            light1.Light:SetColour(
                colour_tint[g + b + 1] + r / 11,
                colour_tint[r + b + 1] + g / 11,
                colour_tint[r + g + 1] + b / 11
            )
        end

        owner:AddChild(light1)

        light1.Transform:SetPosition(0, 0, 0)

        owner._kkr_light1 = light1
    end
end

local function RemoveLight(owner)
    if not owner then
        return
    end

    if owner._kkr_light1 then
        owner._kkr_light1:Remove()
        owner._kkr_light1 = nil
    end
end

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_kkr_newyear_staff", "symbol0")

    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
    inst.components.container:Open(owner)
    local item = inst.components.container:GetItemInSlot(1)
    if
        item and
            (item.prefab == "lightbulb" or item.prefab == "spore_medium" or item.prefab == "spore_small" or
                item.prefab == "spore_tall")
     then
        CreateLight(item, owner)
    end

    if inst._vfx_fx_inst == nil then
        inst._vfx_fx_inst = SpawnPrefab("cane_victorian_fx")
        inst._vfx_fx_inst.entity:AddFollower()
    end
    inst._vfx_fx_inst.entity:SetParent(owner.entity)
    inst._vfx_fx_inst.Follower:FollowSymbol(owner.GUID, "swap_object", 0, -90, 0)
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
    inst.components.container:Close(owner)

    if inst._vfx_fx_inst ~= nil then
        inst._vfx_fx_inst:Remove()
        inst._vfx_fx_inst = nil
    end
    RemoveLight(owner)
end

local function OnFinished(inst)
    OnBroken(inst)
end

local function itemget(inst, data)
    local owner = inst.components.inventoryitem.owner
    if data.item.prefab == "petals" then
        if inst.components.finiteuses.current < inst.components.finiteuses.total then
            inst:DoTaskInTime(
                .5,
                function(inst)
                    OnRepaired(inst)

                    if data.item.components.stackable then
                        local num = math.min(data.item.components.stackable:StackSize(), 10)
                        num = math.min(inst.components.finiteuses.total - inst.components.finiteuses.current, num)
                        data.item.components.stackable:SetStackSize(data.item.components.stackable:StackSize() - num)
                        inst.components.finiteuses:Use(-num)
                        if data.item.components.stackable:StackSize() <= 0 then
                            data.item:Remove()
                        end
                    else
                        data.item:Remove()
                    end
                end
            )
        else
            if owner and owner.components.talker then
                owner.components.talker:Say("耐久已满，无法继续填充")
            end
        end
    elseif
        data.item.prefab == "lightbulb" or data.item.prefab == "spore_medium" or data.item.prefab == "spore_small" or
            data.item.prefab == "spore_tall"
     then
        CreateLight(data.item, owner)
    end
end

local function itemlose(inst, data)
    local owner = inst.components.inventoryitem.owner
    RemoveLight(owner)
end

local function onsave(inst, data)
end

local function onload(inst, data)
    if inst then
        if inst.components.finiteuses.current <= 0 then
            OnBroken(inst)
        end
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst, "med", nil, 0.75)

    inst.AnimState:SetBank("kkr_newyear_staff")
    inst.AnimState:SetBuild("kkr_newyear_staff")
    inst.AnimState:PlayAnimation("idle")

    inst.entity:SetPristine()

    inst:AddTag("meteor_protection")
    inst:AddTag("nosteal")
    inst:AddTag("NORATCHECK")

    if not TheWorld.ismastersim then
        inst.OnEntityReplicated = function(inst)
            if inst.replica.container then
                inst.replica.container:WidgetSetup("kkr_newyear_staff")
            end
        end
        return inst
    end

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(10)
    inst.components.weapon:SetRange(1)

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(10)
    inst.components.finiteuses:SetUses(10)
    inst.components.finiteuses:SetOnFinished(OnFinished)

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("kkr_newyear_staff")

    inst:ListenForEvent("itemget", itemget)
    inst:ListenForEvent("itemlose", itemlose)

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/kkr_newyear_staff.xml"

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.equippable.restrictedtag = "kkr"

    inst:AddComponent("spellcaster")
    inst.components.spellcaster.canuseonpoint = true
    inst.components.spellcaster:SetSpellFn(OnSpell)

    inst.OnSave = onsave
    inst.OnLoad = onload

    return inst
end

return Prefab("kkr_newyear_staff", fn, assets)
