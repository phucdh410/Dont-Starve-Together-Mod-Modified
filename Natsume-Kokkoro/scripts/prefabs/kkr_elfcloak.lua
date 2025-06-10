local assets=
{
    Asset("ANIM", "anim/kkr_elfcloak_wing.zip"),  --动画文件
    Asset("ANIM", "anim/kkr_elfcloak_body.zip"),  --动画文件
    Asset("IMAGE", "images/inventoryimages/kkr_elfcloak_wing.tex"), --物品栏贴图
	Asset("ATLAS", "images/inventoryimages/kkr_elfcloak_wing.xml"),

    Asset("ANIM", "anim/lavaarena_heal_flowers_fx.zip"),
}

local function ShouldAcceptItem(inst, item)

    if item.prefab == 'lunarplant_husk' and inst.lunarplant_husk_count < 5 then
        return true
    end
    return false
end

local function OnGetItemFromPlayer(inst, giver, item)
    if item.prefab == 'lunarplant_husk' then
        inst.lunarplant_husk_count = inst.lunarplant_husk_count + 1
        inst.components.armor.absorb_percent = 0.8 + inst.lunarplant_husk_count * 0.01
        inst.components.planardefense:SetBaseDefense(inst.lunarplant_husk_count * 2)
        giver.components.talker:Say(("亮茄外壳:%d/5"):format(inst.lunarplant_husk_count))
    end

    
end

local function OnRefuseItem(inst, giver, item)
    if item then
        local msg = inst.lunarplant_husk_count < 5 and ("亮茄外壳:%d/5"):format(inst.lunarplant_husk_count) or "亮茄外壳的数量已满"
        giver.components.talker:Say(msg)
    end
end





-- local function RemoveButterfly(owner)
--     if  owner.kkr_wind_spirit_leader then
--         owner.kkr_wind_spirit_leader.components.kkrspiritleader:DisbandFormation()
--         owner.kkr_wind_spirit_leader = nil
--     end
--     if owner.kkr_wind_spirit_leader_task then
--         owner.kkr_wind_spirit_leader_task:Cancel()
--         owner.kkr_wind_spirit_leader_task  = nil
--     end

-- end

-- local function SpawnButterfly(owner)
--     -- 检查角色是否已经有领袖
--     if not owner.kkr_wind_spirit_leader then
--         local leader = SpawnPrefab("kkr_wind_spirit_leader")
--         owner.kkr_wind_spirit_leader = leader
--         leader.components.kkrspiritleader:SetTarget(owner)
--     end

--     -- 检查已生成的蝴蝶数量
--     local num_spirits = owner.kkr_wind_spirit_leader.components.kkrspiritleader:GetFormationSize()
--     if num_spirits >= 2 then
--         return
--     end

--     local x, y, z = owner.Transform:GetWorldPosition()
--     local offset_x = math.cos(PI / 3) * 3  -- 生成精灵的 X 坐标偏移量
--     local offset_z = math.sin(PI / 3) * 3  -- 生成精灵的 Z 坐标偏移量

--     local spirit = SpawnPrefab("kkr_wind_spirit")
--     spirit.Transform:SetPosition(x + offset_x, y, z + offset_z)

--     owner.kkr_wind_spirit_leader.components.kkrspiritleader:SetMember(spirit)
--     owner.kkr_wind_spirit_leader.components.kkrspiritleader:StartUpdatingComponent()
-- end

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
        
        owner:DoTaskInTime(0,function ()
            owner.AnimState:OverrideSymbol("arm_lower", "kkr_elfcloak_body", "arm_lower")
            owner.AnimState:OverrideSymbol("arm_upper", "kkr_elfcloak_body", "arm_upper")
            owner.AnimState:OverrideSymbol("arm_upper_skin", "kkr_elfcloak_body", "arm_upper_skin")
            owner.AnimState:OverrideSymbol("leg", "kkr_elfcloak_body", "leg")
            owner.AnimState:OverrideSymbol("torso", "kkr_elfcloak_body", "torso")

            owner.AnimState:OverrideSymbol("swap_body", "kkr_elfcloak_wing", "swap_body")
        end
        )

        ChangeInsulation(inst)

        -- owner.kkr_wind_spirit_leader_task = owner:DoPeriodicTask(300, SpawnButterfly)
        

    end


end

local function onunequip(inst,owner)
    if owner:HasTag("kkr") then
        owner.AnimState:ClearOverrideSymbol("arm_lower")
        owner.AnimState:ClearOverrideSymbol("arm_upper")
        owner.AnimState:ClearOverrideSymbol("arm_upper_skin")
        owner.AnimState:ClearOverrideSymbol("leg")
        owner.AnimState:ClearOverrideSymbol("torso")

        owner.AnimState:ClearOverrideSymbol("swap_body")

        -- RemoveButterfly(owner)
        
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

--加载
local function onload(inst, data)
    if data then
        if data.oldpercent  then
            inst.components.armor:SetPercent(data.oldpercent)
        end
        inst.lunarplant_husk_count = data.lunarplant_husk_count or 0
        inst.components.armor.absorb_percent = 0.8 + inst.lunarplant_husk_count * 0.01
        inst.components.planardefense:SetBaseDefense(inst.lunarplant_husk_count * 2)
        
    end

end

--保存
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

    inst.lunarplant_husk_count = 0 --初始化数量

    inst:AddComponent("inspectable") --可被检查组件

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/kkr_elfcloak_wing.xml" --加载物品栏贴图 mod物品必须有
    inst.components.inventoryitem.imagename = "kkr_elfcloak_wing"

	inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY --装备的部位是身体

    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
	inst.components.equippable.walkspeedmult = 1.1 --移速
    inst.components.equippable.restrictedtag = "kkr"

    inst:AddComponent("armor")
    inst.components.armor:InitCondition(700,0.8) --80%防御
    inst.components.armor.SetCondition = function(self, amount)
        if self.indestructible then
            return
        end
        self.condition = math.max(math.min(amount, self.maxcondition), 0)
        self.inst:PushEvent('percentusedchange', {percent = self:GetPercent()})
    end
    inst:AddComponent("planardefense") --位面防御
    inst.components.planardefense:SetBaseDefense(0)

    inst:AddComponent('trader')
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader:SetAcceptTest(ShouldAcceptItem)
    inst.components.trader.onrefuse = OnRefuseItem   --拒绝  


    inst:AddComponent("insulator")
	inst.components.insulator:SetInsulation(80)
    inst:WatchWorldState("season",ChangeInsulation)
    ChangeInsulation(inst)

    inst:ListenForEvent('percentusedchange', onpercent)
    onpercent(inst)

    -- inst:AddComponent("useableitem")	
	-- inst.components.useableitem:SetOnUseFn(onuse)

	inst.OnSave = onsave
	inst.OnPreLoad = onload


    return inst
end



return Prefab( "kkr_elfcloak", fn, assets)
