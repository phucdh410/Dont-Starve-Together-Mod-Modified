local assets = {
    Asset("ANIM", "anim/kkr_elfcloak_wing.zip"),
    Asset("ANIM", "anim/kkr_elfcloak_body.zip"),
    Asset("IMAGE", "images/inventoryimages/kkr_elfcloak_wing.tex"),
    Asset("ATLAS", "images/inventoryimages/kkr_elfcloak_wing.xml"),
    Asset("ANIM", "anim/lavaarena_heal_flowers_fx.zip")
}

local function ShouldAcceptItem(inst, item)
    if item.prefab == "lunarplant_husk" and inst.lunarplant_husk_count < 5 then
        return true
    end
    return false
end

local function OnGetItemFromPlayer(inst, giver, item)
    if item.prefab == "lunarplant_husk" then
        inst.lunarplant_husk_count = inst.lunarplant_husk_count + 1
        inst.components.armor.absorb_percent = 0.8 + inst.lunarplant_husk_count * 0.01
        inst.components.planardefense:SetBaseDefense(inst.lunarplant_husk_count * 2)
        giver.components.talker:Say(("Bright eggplant shell:%d/5"):format(inst.lunarplant_husk_count))
    end
end

local function OnRefuseItem(inst, giver, item)
    if item then
        local msg = inst.lunarplant_husk_count < 5 and ("Bright eggplant shell:%d/5"):format(inst.lunarplant_husk_count) or "The quantity of bright eggplant shell is full"
        giver.components.talker:Say(msg)
    end
end

local function ChangeInsulation(inst)
    if TheWorld.state.season == "summer" then
        inst.components.insulator:SetSummer()
    else
        inst.components.insulator:SetWinter()
    end
end

local function onequip(inst, owner)
    if not owner then
        return
    end

    if owner:HasTag("kkr") then
        owner:DoTaskInTime(
            0,
            function()
                owner.AnimState:OverrideSymbol("arm_lower", "kkr_elfcloak_body", "arm_lower")
                owner.AnimState:OverrideSymbol("arm_upper", "kkr_elfcloak_body", "arm_upper")
                owner.AnimState:OverrideSymbol("arm_upper_skin", "kkr_elfcloak_body", "arm_upper_skin")
                owner.AnimState:OverrideSymbol("leg", "kkr_elfcloak_body", "leg")
                owner.AnimState:OverrideSymbol("torso", "kkr_elfcloak_body", "torso")

                owner.AnimState:OverrideSymbol("swap_body", "kkr_elfcloak_wing", "swap_body")
            end
        )

        ChangeInsulation(inst)
    end
end

local function onunequip(inst, owner)
    if owner:HasTag("kkr") then
        owner.AnimState:ClearOverrideSymbol("arm_lower")
        owner.AnimState:ClearOverrideSymbol("arm_upper")
        owner.AnimState:ClearOverrideSymbol("arm_upper_skin")
        owner.AnimState:ClearOverrideSymbol("leg")
        owner.AnimState:ClearOverrideSymbol("torso")

        owner.AnimState:ClearOverrideSymbol("swap_body")
    end
end

local function onpercent(inst, data)
    local percent = data and data.percent or inst.components.armor.condition
    if percent <= 0 then
        inst.components.armor.absorb_percent = 0
    elseif inst.lunarplant_husk_count then
        inst.components.armor.absorb_percent = 0.8 + inst.lunarplant_husk_count * 0.01
    else
        inst.components.armor.absorb_percent = 0.8
    end
end

local function onload(inst, data)
    if data then
        if data.oldpercent then
            inst.components.armor:SetPercent(data.oldpercent)
        end
        inst.lunarplant_husk_count = data.lunarplant_husk_count or 0
        inst.components.armor.absorb_percent = 0.8 + inst.lunarplant_husk_count * 0.01
        inst.components.planardefense:SetBaseDefense(inst.lunarplant_husk_count * 2)
    end
end

local function onsave(inst, data)
    local oldpercent = inst.components.armor:GetPercent()
    data.oldpercent = oldpercent
    data.lunarplant_husk_count = inst.lunarplant_husk_count
end

local function fn(Sim)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("kkr_elfcloak_wing")
    inst.AnimState:SetBuild("kkr_elfcloak_wing")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("armor")

    MakeInventoryFloatable(inst, "med", nil, 0.75)

    inst.entity:SetPristine()

    inst:AddTag("meteor_protection")
    inst:AddTag("nosteal")
    inst:AddTag("NORATCHECK")
    inst:AddTag("kkr_sewing")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.lunarplant_husk_count = 0

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/kkr_elfcloak_wing.xml"
    inst.components.inventoryitem.imagename = "kkr_elfcloak_wing"

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY

    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.equippable.walkspeedmult = 1.1
    inst.components.equippable.restrictedtag = "kkr"

    inst:AddComponent("armor")
    inst.components.armor:InitCondition(700, 0.8)
    inst.components.armor.SetCondition = function(self, amount)
        if self.indestructible then
            return
        end
        self.condition = math.max(math.min(amount, self.maxcondition), 0)
        self.inst:PushEvent("percentusedchange", {percent = self:GetPercent()})
    end
    inst:AddComponent("planardefense")
    inst.components.planardefense:SetBaseDefense(0)

    inst:AddComponent("trader")
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader:SetAcceptTest(ShouldAcceptItem)
    inst.components.trader.onrefuse = OnRefuseItem

    inst:AddComponent("insulator")
    inst.components.insulator:SetInsulation(80)
    inst:WatchWorldState("season", ChangeInsulation)
    ChangeInsulation(inst)

    inst:ListenForEvent("percentusedchange", onpercent)
    onpercent(inst)

    inst.OnSave = onsave
    inst.OnPreLoad = onload

    return inst
end

return Prefab("kkr_elfcloak", fn, assets)
