local assets =
{
    Asset("ANIM", "anim/kkr_ameth_amulet.zip"),  --对应在anim里面的文件 加载动画文件
    Asset("ANIM", "anim/kkr_ameth_amulet_head.zip"),  --对应在anim里面的文件 加载动画文件
	Asset("ATLAS", "images/inventoryimages/kkr_ameth_amulet.xml"), --加载物品栏贴图
    Asset("IMAGE", "images/inventoryimages/kkr_ameth_amulet.tex"),
}

local function Oncooldown(inst)
    inst._task = nil
end

-- local function fxanim(inst)
--     inst._fx.AnimState:PlayAnimation("hit")
--     inst._fx.AnimState:PushAnimation("idle_loop")
-- end

local function fx_remove(inst)
    if inst._fx ~= nil then
        inst._fx:kill_fx()
        inst._fx = nil
    end
end

local function amulet_unproc(inst)
    if inst:HasTag("kkr_forcefield") then
        inst:RemoveTag("kkr_forcefield")
        if inst._fx ~= nil then
            inst._fx:kill_fx()
            inst._fx = nil
        end
        -- inst:RemoveEventCallback("armordamaged", fxanim)

        if inst._task ~= nil then
            inst._task:Cancel()
        end
        inst._task = inst:DoTaskInTime(10, Oncooldown) --护盾结束开始10秒cd
    end
end

local function amulet_proc(inst, owner)
    inst:AddTag("kkr_forcefield")
    if inst._fx ~= nil then
        inst._fx:kill_fx()
    end
    inst._fx = SpawnPrefab("kkr_forcefieldfx")
    inst._fx.entity:SetParent(owner.entity)
    inst._fx.Transform:SetPosition(0, 0.2, 0)
    -- inst:ListenForEvent("armordamaged", fxanim)

    if inst._task ~= nil then
        inst._task:Cancel()
    end
    inst._task = inst:DoTaskInTime(5, amulet_unproc) --5秒后移除护盾
end

local function tryproc(inst, owner, data)
    if inst._task == nil and
        not data.redirected and
        math.random() < 0.33 and
        inst.components.finiteuses.current > 0 then
            amulet_proc(inst, owner)
            inst.components.finiteuses:Use(1)
    end
end

local function ShouldAcceptItem(inst, item)
    if item:HasTag("gem") then
        return true
    end
    return false
end

local function OnGetItemFromPlayer(inst, giver, item)
    if item:HasTag("gem") then
        inst.components.finiteuses:Use(-5)
    end
    if inst.components.finiteuses.current > inst.components.finiteuses.total then
        inst.components.finiteuses.current = inst.components.finiteuses.total
    end
    inst.components.planardefense:SetBaseDefense(10)

    
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
        owner.AnimState:OverrideSymbol("headbase", "kkr_ameth_amulet_head", "headbase")
        owner.AnimState:OverrideSymbol("headbase_hat", "kkr_ameth_amulet_head", "headbase_hat")
        inst.onattach(owner)
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
        inst.ondetach()
        inst:RemoveEventCallback("sanitydelta", OnSanityDelta, owner)
        RemoveLight(owner)
    end
    


end

local function OnFinished(inst)
    inst.components.planardefense:SetBaseDefense(5)
end

--加载
local function onload(inst, data)
    if inst.components.finiteuses.current <= 0 then
        inst.components.planardefense:SetBaseDefense(5)
    end

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

    inst.AnimState:SetBank("kkr_ameth_amulet")
    inst.AnimState:SetBuild("kkr_ameth_amulet")
    inst.AnimState:PlayAnimation("idle")
	-- inst.AnimState:SetScale(.6,.6,.6)

    inst:AddTag("amulet")

    MakeInventoryFloatable(inst, "med",nil, 0.75)

    inst.entity:SetPristine()
    
    inst:AddTag("meteor_protection") --防止被流星破坏
    inst:AddTag("nosteal") --防止被火药猴偷走
    inst:AddTag("NORATCHECK") --mod兼容：永不妥协。该道具不算鼠潮分


    if not TheWorld.ismastersim then
        return inst
    end


    inst._fx = nil
    inst._task = nil
    inst._owner = nil
    inst.procfn = function(owner, data) tryproc(inst, owner, data) end
    inst.onattach = function(owner)
        if inst._owner ~= nil then
            inst:RemoveEventCallback("attacked", inst.procfn, inst._owner)
            inst:RemoveEventCallback("onremove", inst.ondetach, inst._owner)
        end
        inst:ListenForEvent("attacked", inst.procfn, owner)
        inst:ListenForEvent("onremove", inst.ondetach, owner)
        inst._owner = owner
        inst._fx = nil
    end
    inst.ondetach = function()
        amulet_unproc(inst)
        if inst._owner ~= nil then
            inst:RemoveEventCallback("attacked", inst.procfn, inst._owner)
            inst:RemoveEventCallback("onremove", inst.ondetach, inst._owner)
            inst._owner = nil
            inst._fx = nil
        end
    end
    inst.OnRemoveEntity = fx_remove

    inst:AddComponent('finiteuses')
    inst.components.finiteuses:SetMaxUses(10)
    inst.components.finiteuses:SetUses(10)
    inst.components.finiteuses:SetOnFinished(OnFinished)

    inst:AddComponent("inspectable") --可被检查组件

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/kkr_ameth_amulet.xml" --加载物品栏贴图 mod物品必须有

	inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.NECK or EQUIPSLOTS.HEAD 
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
	inst.components.equippable.walkspeedmult = 1.2 --移速
    inst.components.equippable.dapperness = 5/60
    inst.components.equippable.restrictedtag = "kkr"

    inst:AddComponent("planardefense") --位面防御
    inst.components.planardefense:SetBaseDefense(10)

    inst:AddComponent('trader')
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader:SetAcceptTest(ShouldAcceptItem)

	inst.OnSave = onsave
	inst.OnPreLoad = onload


    return inst
end

return Prefab( "kkr_ameth_amulet", fn, assets)
