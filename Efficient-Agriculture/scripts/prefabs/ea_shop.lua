require "goods_list"
require "products_list"

local assets = {
    Asset("ANIM", "anim/ea_shop.zip"),
    Asset("IMAGE", "images/inventoryimages/ea_shop.tex"),
    Asset("ATLAS", "images/inventoryimages/ea_shop.xml"),
    Asset("ATLAS", "images/numberfonts.xml"),
    Asset("IMAGE", "images/numberfonts.tex"),
    Asset("ATLAS_BUILD", "images/numberfonts.xml", 64),
}

local prefabs = {
    "ea_fx_shoplight",
    "ea_fx_shopnote",
}
---------------------------------
local IconPos = {
    product1 = "P_SIGN_A",
    product2 = "P_SIGN_B",
    product3 = "P_SIGN_C",
    goods1 = "G_SIGN_A",
    goods2 = "G_SIGN_B",
    goods3 = "G_SIGN_C",
}
local NumPos = {
    product1 = "P_NUM_A",
    product2 = "P_NUM_B",
    product3 = "P_NUM_C",
    goods1 = "G_NUM_A",
    goods2 = "G_NUM_B",
    goods3 = "G_NUM_C",
}

local function GetIcon(prefab)
    local ent = SpawnPrefab(prefab)
    if ent == nil or not ent.components.inventoryitem then
        return
    end

    local atlas, bgimage, bgatlas
    local image = FunctionOrValue(ent.drawimageoverride, ent) or (#(ent.components.inventoryitem.imagename or "") > 0 and ent.components.inventoryitem.imagename) or ent.prefab or nil
    if image ~= nil then
        atlas = ent.drawatlasoverride or (#(ent.components.inventoryitem.atlasname or "") > 0 and ent.components.inventoryitem.atlasname) or nil
        if ent.inv_image_bg ~= nil and ent.inv_image_bg.image ~= nil and ent.inv_image_bg.image:len() > 4 and ent.inv_image_bg.image:sub(-4):lower() == ".tex" then
            bgimage = ent.inv_image_bg.image:sub(1, -5)
            bgatlas = ent.inv_image_bg.atlas ~= GetInventoryItemAtlas(ent.inv_image_bg.image) and ent.inv_image_bg.atlas or nil
        end
    end
    ent:Remove()
    return image, atlas, bgimage, bgatlas
end

local function DrawIcon(inst, prefab, pos)
    if prefab then
        local image, atlas, bgimage, bgatlas = GetIcon(prefab)
        if image ~= nil and IconPos[pos]then
            inst.AnimState:OverrideSymbol(IconPos[pos], atlas or GetInventoryItemAtlas(image..".tex"), image..".tex")
        elseif IconPos[pos] then
            inst.AnimState:ClearOverrideSymbol(IconPos[pos])
        end
    end
end

local function ChangeGoods(inst)
    for i = 1, 3, 1 do 
        local prob = math.floor(math.random(1,100))
        local probb = 1
        if prob <= 5 then
            probb = math.floor(math.random(1,12))
            inst.goods[i] = deepcopy(list_blueprint[probb])
            inst.goods[i].num = 1
        elseif prob <= 10 then
            probb = math.floor(math.random(1,74))
            inst.goods[i] = deepcopy(list_precious[probb])
            inst.goods[i].num = 1
        elseif prob <= 40 then
            probb = math.floor(math.random(1,84))
            inst.goods[i] = deepcopy(list_resource[probb])
        elseif prob <= 70 then
            probb = math.floor(math.random(1,55))
            inst.goods[i] = deepcopy(list_cloth[probb])
            inst.goods[i].num = math.floor(math.random(1,2))
        else
            probb = math.floor(math.random(1,71))
            inst.goods[i] = deepcopy(list_smithing[probb])
            inst.goods[i].num = math.floor(math.random(1,3))
        end
    end
    if inst.goods[1] and inst.goods[2] and inst.goods[3]then 
        local need_price_1 = math.ceil(math.random(math.ceil(inst.goods[1].price*1.2), math.ceil(inst.goods[1].price*1.3)))*inst.goods[1].num*(EA_CONSTANTS.PRICE_COEFFICIENT or 1)  --需要的产品价值在1.2到1.3倍货物价值
        local need_price_2 = math.ceil(math.random(math.ceil(inst.goods[2].price*1.2), math.ceil(inst.goods[2].price*1.3)))*inst.goods[2].num*(EA_CONSTANTS.PRICE_COEFFICIENT or 1)
        local need_price_3 = math.ceil(math.random(math.ceil(inst.goods[3].price*0.6), math.ceil(inst.goods[3].price*0.8)))*inst.goods[3].num*(EA_CONSTANTS.PRICE_COEFFICIENT or 1)  --第三条是打折栏，价格更便宜
        local products_list_1, products_list_2, products_list_3 = {},{},{}
        for k,v in ipairs(list_products) do
            if v.price <= need_price_1*2 and v.price*80 >= need_price_1 then
                table.insert(products_list_1,v)
            end
            if v.price <= need_price_2*2 and v.price*80 >= need_price_2 then
                table.insert(products_list_2,v)
            end
            if v.price <= need_price_3*3 and v.price*80 >= need_price_3 then
                table.insert(products_list_3,v)
            end
        end
        --product1
        local prob = math.floor(math.random(1, #products_list_1))
        inst.products[1] = products_list_1[prob]
        inst.products[1].num = math.ceil(need_price_1 / inst.products[1].price)
        --product2
        local count = 0
        local last_prob_a = prob
        while prob == last_prob_a do
            prob = math.floor(math.random(1, #products_list_2))
            count = count + 1
            if count > 9 then
                break
            end
            if #products_list_2 <= 1 then
                break
            elseif #products_list_2 == 2 then
                inst.products[2] = products_list_2[prob+1] or products_list_2[prob-1]
                break
            end
            inst.products[2] = products_list_2[prob]
        end
        inst.products[2].num = math.ceil(need_price_2 / inst.products[2].price)
        --product3
        local last_prob_b = prob
        count = 0
        while prob == last_prob_a or prob == last_prob_b do
            prob = math.floor(math.random(1, #products_list_3))
            count = count + 1
            if count > 9 then
                break
            end
            if #products_list_3 <= 1 then
                break
            elseif #products_list_3 == 2 then
                inst.products[3] = products_list_3[prob+1] or products_list_3[prob-1]
                break
            end
            inst.products[3] = products_list_3[prob]
        end
        inst.products[3].num = math.ceil(need_price_3 / inst.products[3].price)
    end

    for i = 1, 3, 1 do
        DrawIcon(inst, inst.goods[i].name, "goods"..i)
        DrawIcon(inst, inst.products[i].name, "product"..i)
        inst.AnimState:OverrideSymbol(NumPos["goods"..i], resolvefilepath("images/numberfonts.xml"), inst.goods[i].num..".tex")
        inst.AnimState:OverrideSymbol(NumPos["product"..i], resolvefilepath("images/numberfonts.xml"), inst.products[i].num..".tex")
        --print(inst.goods[i].num..".tex")
        --print(inst.products[i].num..".tex")
    end
    --print("Changed!")     --print
end
---------------------------------

local function onhammered(inst, worker)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
    end
    inst.SoundEmitter:KillSound("firesuppressor_idle")
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("metal")
    inst:Remove()
end

local function onhit(inst, worker)
    --[[if not inst:HasTag("burnt") then
        inst.AnimState:PlayAnimation("hit")
        inst.AnimState:PushAnimation("idle")
    end]]--
end

local function onsave(inst, data)
    if inst:HasTag("burnt") or (inst.components.burnable ~= nil and inst.components.burnable:IsBurning()) then
        data.burnt = true
    end
    data.goods = inst.goods
    data.products = inst.products
    data.refresh_rate = inst.refresh_rate
    if inst.light ~= nil then
        data.light = true
    else
        data.light = false
    end
end

local function onload(inst, data)
    if data ~= nil then
        if data.burnt and inst.components.burnable ~= nil and inst.components.burnable.onburnt ~= nil then
            inst.components.burnable.onburnt(inst)
        end
        if data.refresh_rate then
            inst.refresh_rate = data.refresh_rate
        end
        
        if data.light then
            local x, y, z = inst.Transform:GetWorldPosition()
            for k,v in pairs(TheSim:FindEntities(x, y, z, 1)) do
                if v.prefab == "ea_fx_shoplight" then
                    if inst.light == nil then
                        inst.light = v
                    end
                end
            end
        else
            local x, y, z = inst.Transform:GetWorldPosition()
            for k,v in pairs(TheSim:FindEntities(x, y, z, 0.5)) do
                if v.prefab == "ea_fx_shoplight" then
                    v:Remove()
                end
            end
        end

        if data.goods then
            inst.goods = data.goods
            for i = 1, 3, 1 do
                DrawIcon(inst, inst.goods[i].name, "goods"..i)
                inst.AnimState:OverrideSymbol(NumPos["goods"..i], resolvefilepath("images/numberfonts.xml"), inst.goods[i].num..".tex")
            end
        end
        if data.products then
            inst.products = data.products
            for i = 1, 3, 1 do
                DrawIcon(inst, inst.products[i].name, "product"..i)
                inst.AnimState:OverrideSymbol(NumPos["product"..i], resolvefilepath("images/numberfonts.xml"), inst.products[i].num..".tex")
            end
        end
    end
end

local function onbuilt(inst)
    --inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/firesupressor_craft")
    inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("idle", true)
    ChangeGoods(inst)
    if not TheWorld.state.isday then
        inst.light = SpawnPrefab("ea_fx_shoplight")
        local x,y,z = inst.Transform:GetWorldPosition()
        inst.light.Transform:SetPosition(x,y,z)
    end
end

local function shouldacceptitem(inst,item,giver)
    local number = 0
    local anything = 0
    if (item.prefab == "bundle" or item.prefab == "gift") and item.components.unwrappable then
        local items_in_bundle = item.components.unwrappable.itemdata
        for k,v in pairs(inst.products) do
            number = 0 
            if v.name then 
                for i,it in pairs(items_in_bundle) do 
                    local itt = SpawnPrefab(it.prefab, it.skinname, it.skin_id)  
                    itt:SetPersistData(it.data)
                    if it.prefab == v.name then 
                        if itt.components.stackable then 
                            number = number + itt.components.stackable.stacksize 
                        else
                            number = number + 1 
                        end
                    end
                    itt:Remove() 
                end
                if number ~= 0 and number >= v.num then 
                    return true
                end
                if number ~= 0 then
                    anything = number
                end
            end
        end
        if giver and giver.components.talker then
            if anything == 0 then
                giver.components.talker:Say(STRINGS.EA_WRONG_ITEM)
            else 
                giver.components.talker:Say(STRINGS.EA_NOT_ENOUGH)
            end
        end
    else
        if giver and giver.components.talker then
            giver.components.talker:Say(STRINGS.EA_GIVE_ME_BUNDLE)
        end
    end
    return false
end

local function ongetitem(inst,giver,item)
    local prod = nil 
    local prod_num = 0  
    local number = 1        
    local items_in_bundle = item.components.unwrappable.itemdata    

    for k,v in pairs(inst.products) do      
        for i,it in pairs(items_in_bundle) do       
            if it.prefab == v.name then     
                local itt = SpawnPrefab(it.prefab, it.skinname, it.skin_id)     
                itt:SetPersistData(it.data)
                if itt.components.stackable then
                    prod_num = prod_num + itt.components.stackable.stacksize
                else
                    prod_num = prod_num + 1
                end
                itt:Remove()
            end
        end
        if prod_num ~= 0 and prod_num >= v.num then     
            prod = SpawnPrefab(inst.goods[k].name)      
            number = inst.goods[k].num or 1             
            if prod.components.stackable then           
                prod.components.stackable.stacksize = inst.goods[k].num or 1
            end
            inst.products[k] = {name = nil, price = nil, num = 0}       
            inst.goods[k] = {name = nil, price = nil, num = 0}
            inst.AnimState:ClearOverrideSymbol(IconPos["product"..k])
            inst.AnimState:ClearOverrideSymbol(IconPos["goods"..k])
            inst.AnimState:ClearOverrideSymbol(NumPos["product"..k])
            inst.AnimState:ClearOverrideSymbol(NumPos["goods"..k])
            break       
        end
    end

    inst.AnimState:PlayAnimation("work")       
    inst.AnimState:PushAnimation("idle")
    if inst.light then
        inst.light.AnimState:PlayAnimation("work")
        inst.light.AnimState:PushAnimation("idle")
    end
    inst.SoundEmitter:PlaySound("dontstarve/common/researchmachine_science_gift_recieve")
    inst:DoTaskInTime(FRAMES, function ()  
        if item.prefab == "bundle" and giver and giver.components.inventory then     
            giver.components.inventory:GiveItem(SpawnPrefab("waxpaper"))
        end
        if not prod or not prod:IsValid() then
            return
        end
        if prod.components.inventoryitem and giver and giver.components.inventory then    
            if not prod.components.stackable then      
                local prod_prefab = prod.prefab    
                prod:Remove()
                for i = 1, number, 1 do
                    giver.components.inventory:GiveItem(SpawnPrefab(prod_prefab), nil, inst:GetPosition())
                end
            else   
                giver.components.inventory:GiveItem(prod, nil, inst:GetPosition())
            end
        else       
            if not prod.components.stackable then
                local prod_prefab = prod.prefab
                prod:Remove()
                for i = 1, number, 1 do
                    inst.components.lootdropper:FlingItem(SpawnPrefab(prod_prefab), inst:GetPosition())
                end
            else inst.components.lootdropper:FlingItem(prod, inst:GetPosition())
            end
        end
    end)
end

local function onremove(inst)
    local note = inst.note
    if note then
        note.AnimState:PlayAnimation("delete")
        note:DoTaskInTime(0.6,function ()
            if note ~= nil then
                note:Remove()
            end
        end)
    end

    if inst.light then
        inst.light:Remove()
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
    inst.entity:AddLightWatcher()

    MakeObstaclePhysics(inst, 1.2)

    inst.MiniMapEntity:SetIcon("ea_shop_mini.tex")

    inst.AnimState:SetBank("ea_shop")
    inst.AnimState:SetBuild("ea_shop")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("structure")
    --inst:AddTag("trader")

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("lootdropper")

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)

    inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(shouldacceptitem)
    inst.components.trader.onaccept = ongetitem
    inst.components.trader.acceptnontradable = true

    inst.goods = {}     
    inst.products = {}  

    inst.note = nil
    inst.refresh_rate = (EA_CONSTANTS.SHOP_REFRESH_FREQUENCY or 2)
    inst:ListenForEvent("ms_cyclecomplete",function ()
        inst.refresh_rate = inst.refresh_rate - 1       
        if inst.refresh_rate == 1 and inst.note == nil then      
            inst.note = SpawnPrefab("ea_fx_shopnote")
            local x,y,z = inst.Transform:GetWorldPosition()
            inst.note.Transform:SetPosition(x,y,z)
            inst.note.shop = inst           
            for k,v in pairs(TheSim:FindEntities(x, y, z, 1)) do
                local x1,y1,z1 = v.Transform:GetWorldPosition()
                --print(v.prefab..".x:"..x1.." z:"..z1)         --print
            end
        end
        if inst.refresh_rate <= 0 then 
            ChangeGoods(inst)
            inst.refresh_rate = (EA_CONSTANTS.SHOP_REFRESH_FREQUENCY or 2)
            if inst.note ~= nil then  
                inst.note.AnimState:PlayAnimation("delete")
                inst:DoTaskInTime(0.6,function ()
                    if inst.note ~= nil then
                        inst.note:Remove()
                        inst.note = nil
                    end
                end)
            end
        end
    end,
    TheWorld) 

    inst.light = nil
    inst:ListenForEvent("phasechanged",function (_theworld, phase)
        if phase ~= "day" and inst.light == nil then
            inst.light = SpawnPrefab("ea_fx_shoplight")
            local x,y,z = inst.Transform:GetWorldPosition()
            inst.light.Transform:SetPosition(x,y,z)
        end
        if phase == "day" then 
            if inst.light ~= nil then
                inst.light.AnimState:PlayAnimation("delete")
                inst:DoTaskInTime(0.9,function ()
                    if inst.light ~= nil then
                        inst.light:Remove()
                        inst.light = nil
                    end
                end)
            end
        end
    end,
    TheWorld)

    inst:ListenForEvent("onbuilt", onbuilt)
    inst:ListenForEvent("onremove", onremove)

    inst.OnSave = onsave
    inst.OnLoad = onload

    return inst
end

return Prefab("ea_shop", fn, assets, prefabs),
    MakePlacer("ea_shop_placer", "ea_shop", "ea_shop", "idle")