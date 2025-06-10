local assets=
{
	Asset("ANIM", "anim/kkr_elfrobe.zip"),  --动画文件
    Asset("ANIM", "anim/kkr_elfrobe_skin.zip"),  --动画文件
	Asset("IMAGE", "images/inventoryimages/kkr_elfrobe.tex"), --物品栏贴图
	Asset("ATLAS", "images/inventoryimages/kkr_elfrobe.xml"),
}

local function onequip(inst, owner)
    if not owner then
        return
    end

    if owner:HasTag("kkr") then
        owner:DoTaskInTime(0,function ()
            owner.AnimState:OverrideSymbol("arm_lower", "kkr_elfrobe_skin", "arm_lower")
            owner.AnimState:OverrideSymbol("arm_upper", "kkr_elfrobe_skin", "arm_upper")
            owner.AnimState:OverrideSymbol("arm_upper_skin", "kkr_elfrobe_skin", "arm_upper_skin")
            owner.AnimState:OverrideSymbol("leg", "kkr_elfrobe_skin", "leg")
            owner.AnimState:OverrideSymbol("torso", "kkr_elfrobe_skin", "torso")
        end
        )

    end


end

local function onunequip(inst,owner)
    if owner:HasTag("kkr") then
        owner.AnimState:ClearOverrideSymbol("arm_lower")
        owner.AnimState:ClearOverrideSymbol("arm_upper")
        owner.AnimState:ClearOverrideSymbol("arm_upper_skin")
        owner.AnimState:ClearOverrideSymbol("leg")
        owner.AnimState:ClearOverrideSymbol("torso")
        
    end
    


end

local function onpercent(inst, data)

    local percent = data and data.percent or inst.components.armor.condition
    if percent <= 0 then
        inst.components.armor.absorb_percent = 0
    else
        inst.components.armor.absorb_percent = 0.7
    end
end

--加载
local function onload(inst, data)
    if data and data.oldpercent then
        inst.components.armor:SetPercent(data.oldpercent)
    end

end

--保存
local function onsave(inst, data)
    local oldpercent = inst.components.armor:GetPercent()
    data.oldpercent = oldpercent

end

local function fn(Sim)
	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("kkr_elfrobe")
    inst.AnimState:SetBuild("kkr_elfrobe")
    inst.AnimState:PlayAnimation("idle")
	-- inst.AnimState:SetScale(.6,.6,.6)

    inst:AddTag("armor")

    MakeInventoryFloatable(inst, "med",nil, 0.75)

    inst.entity:SetPristine()
    

    inst:AddTag("meteor_protection") --防止被流星破坏
    inst:AddTag("nosteal") --防止被火药猴偷走
    inst:AddTag("NORATCHECK") --mod兼容：永不妥协。该道具不算鼠潮分
    inst:AddTag("kkr_sewing") --自定义修补

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable") --可被检查组件

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/kkr_elfrobe.xml" --加载物品栏贴图 mod物品必须有

	inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY --装备的部位是身体

    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
	inst.components.equippable.walkspeedmult = 1.1 --移速
    inst.components.equippable.restrictedtag = "kkr"

    inst:AddComponent("armor")
    inst.components.armor:InitCondition(700,0.7) --70%防御
    inst.components.armor.SetCondition = function(self, amount)
        if self.indestructible then
            return
        end
        self.condition = math.max(math.min(amount, self.maxcondition), 0)
        self.inst:PushEvent('percentusedchange', {percent = self:GetPercent()})
    end


    inst:ListenForEvent('percentusedchange', onpercent)
    onpercent(inst)

	inst.OnSave = onsave
	inst.OnPreLoad = onload

	MakeHauntableLaunchAndPerish(inst) --作崇
    return inst
end

return Prefab( "kkr_elfrobe", fn, assets)
