local assets =
{
    Asset("ANIM", "anim/kkr_flower_amulet.zip"),  --对应在anim里面的文件 加载动画文件
    Asset("ANIM", "anim/kkr_flower_amulet_head.zip"),  --对应在anim里面的文件 加载动画文件
	Asset("ATLAS", "images/inventoryimages/kkr_flower_amulet.xml"), --加载物品栏贴图
    Asset("IMAGE", "images/inventoryimages/kkr_flower_amulet.tex"),
}

local function ShouldAcceptItem(inst, item)
    if item.prefab == 'opalpreciousgem' then
        return true
    end
    return false
end

local function OnGetItemFromPlayer(inst, giver, item)
    if item.prefab == 'opalpreciousgem' then
        inst:Remove()
        giver.components.inventory:GiveItem(SpawnPrefab('kkr_ameth_amulet'))
    end
    
end

local function CreateLight(owner)
    --检查是否已经存在光源实例
    if owner and not owner._kkr_light then
        --生成光源
        local light = SpawnPrefab("kkr_light")
        --将光源添加到owner下面作为子节点
        owner:AddChild(light)
        --设置光源位置,局部坐标不偏移
        light.Transform:SetPosition(0, 0, 0)
        --将光源实例存储在owner中
        owner._kkr_light = light
    end
end

local function RemoveLight(owner)
    --检查是否存在光源实例
    if owner._kkr_light then
        --移除光源
        owner._kkr_light:Remove()
        owner._kkr_light = nil
    end
end

local function OnSanityDelta(owner)
    if owner and owner.components.sanity then
        if owner.components.sanity.current > 120 then
            CreateLight(owner)
        else
            RemoveLight(owner)
        end
    end
end


local function onequip(inst, owner)
    if not owner then
        return
    end

    if owner:HasTag("kkr") then
        owner.AnimState:OverrideSymbol("headbase", "kkr_flower_amulet_head", "headbase")
        owner.AnimState:OverrideSymbol("headbase_hat", "kkr_flower_amulet_head", "headbase_hat")
        inst:ListenForEvent("sanitydelta", OnSanityDelta, owner)

    else
        owner:DoTaskInTime(
            0,
            function()
                local inventory = owner.components.inventory
                if inventory then
                    inventory:DropItem(inst)
                end
            end
        )
    end


end

local function onunequip(inst,owner)
    if owner:HasTag("kkr") then
        owner.AnimState:ClearOverrideSymbol("headbase")
        owner.AnimState:ClearOverrideSymbol("headbase_hat")
        inst:RemoveEventCallback("sanitydelta", OnSanityDelta, owner)
        RemoveLight(owner)

    end
    
end
--加载
local function onload(inst, data)

end

--保存
local function onsave(inst, data)

end

local function fn(Sim)
	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("kkr_flower_amulet")
    inst.AnimState:SetBuild("kkr_flower_amulet")
    inst.AnimState:PlayAnimation("idle")
	-- inst.AnimState:SetScale(.6,.6,.6)

    inst:AddTag("amulet")

    MakeInventoryFloatable(inst, "med",nil, 0.75)

    inst.entity:SetPristine()

    inst:AddTag("meteor_protection") --防止被流星破坏
    inst:AddTag("nosteal") --防止被火药猴偷走
    inst:AddTag("NORATCHECK") --mod兼容：永不妥协。该道具不算鼠潮分
    inst:AddTag("kkr_sewing")

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable") --可被检查组件

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/kkr_flower_amulet.xml" --加载物品栏贴图 mod物品必须有

	inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.NECK or EQUIPSLOTS.HEAD 
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
	inst.components.equippable.walkspeedmult = 1.2 --移速
    inst.components.equippable.dapperness = 5/60
    inst.components.equippable.restrictedtag = "kkr"

    inst:AddComponent('trader')
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader:SetAcceptTest(ShouldAcceptItem)

	inst.OnSave = onsave
	inst.OnPreLoad = onload


    return inst
end

return Prefab( "kkr_flower_amulet", fn, assets)
