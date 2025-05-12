
local CacheService = require "util/cacheservice"
local Autoswitch = Class(function(self, inst)
    self.inst = inst
    self.chipSlot = 15
    self.isSpinning = false 
    self.weaponList = {}
    self.toolList = {}
    self.isStrangeAttacks= false
    self.allowedMap = {
        ["fgc_book_emo"] = true, 
        ["orangestaff"] = true, 
        ["cane"] = true, 
        ["walking_stick"] = true,  
        ["ruins_bat"] = true, 
        ["balloonspeed"] = true, 
    }
    self.allowedArr = {
        "fgc_book_emo", 
        "orangestaff", 
        "cane", 
        "walking_stick",  
        "ruins_bat", 
        "balloonspeed", 
    }
end)

function Autoswitch:SetWeaponList(weaponList) self.weaponList = weaponList end
function Autoswitch:SetToollList(toolList) self.toolList = toolList end
function Autoswitch:IsAutoActivation(isSpinning) self.isSpinning = isSpinning end
function Autoswitch:IsStrangeAttacks(strangeAttacks) self.isStrangeAttacks = strangeAttacks end
function Autoswitch:SetchipSlot(num) self.chipSlot = num end

function Autoswitch:IsInGame()
    
    return not (TheFrontEnd:GetActiveScreen().name:find("HUD") ~= nil and not (ThePlayer.HUD:IsControllerCraftingOpen() or ThePlayer.HUD:IsControllerInventoryOpen()))
end

local ability_x = "Automatic cutting cane"
local enable_x = "Enable"
local disable_x = "Disable"


function Autoswitch:SwitchSpinning()
    
    if Autoswitch:IsInGame() then
        return
    end
    if self.isSpinning then
        
        ChatHistory:AddToHistory(ChatTypes.Message, nil, nil, ability_x, disable_x, PLAYERCOLOURS.GREEN)
        
        self.inst:StopUpdatingComponent(self)
        self.isSpinning = false
        self:IconHide()
    else
        
        ChatHistory:AddToHistory(ChatTypes.Message, nil, nil, ability_x, enable_x, PLAYERCOLOURS.GREEN)
        
        self.inst:StartUpdatingComponent(self)
        self.isSpinning = true
        self:IconHint()
    end
end

function Autoswitch:IconHint()
    if ThePlayer and ThePlayer.HUD and ThePlayer.HUD.controls and
            ThePlayer.HUD.controls.inv and ThePlayer.HUD.controls.inv.inv and
            ThePlayer.HUD.controls.inv.inv[self.chipSlot] then
        ThePlayer.HUD.controls.inv.inv[self.chipSlot]:SetBGImage2(
                "images/icon-autoswitch-hint.xml", "icon-autoswitch-hint.tex")
    end
    if ThePlayer and ThePlayer.SoundEmitter then
        ThePlayer.SoundEmitter:PlaySound("dontstarve/HUD/collect_resource")
    end
end

function Autoswitch:IconHide()
    if ThePlayer and ThePlayer.HUD and ThePlayer.HUD.controls and
            ThePlayer.HUD.controls.inv and ThePlayer.HUD.controls.inv.inv and
            ThePlayer.HUD.controls.inv.inv[self.chipSlot] then
        ThePlayer.HUD.controls.inv.inv[self.chipSlot]:SetBGImage2(
                "images/icon-autoswitch-hide.xml", "icon-autoswitch-hide.tex")
    end
    if ThePlayer and ThePlayer.SoundEmitter then
        ThePlayer.SoundEmitter:PlaySound("dontstarve/HUD/collect_resource")
    end
end


function Autoswitch:GetCachedItem(item)
    return CacheService:GetCachedItem(item)
end


function Autoswitch:GetWalkspeedMult(item)
    local cachedItem = self:GetCachedItem(item)
    if cachedItem
            and cachedItem.components.equippable
            and cachedItem.components.equippable.walkspeedmult then
        return cachedItem.components.equippable.walkspeedmult
    elseif item and self.allowedMap[item.prefab] then
        return 2 
    else
        return 0
    end
end

function Autoswitch:OnUpdate(dt)
    
    if not (ThePlayer.replica.rider.classified ~= nil and ThePlayer.replica.rider.classified.ridermount:value()) then
        if not self:IsInGame() then
            local handItem = ThePlayer.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if self:IsAttacking() then
                
                self:TryEquipWeaponItem()  
            elseif  self:IsMoving() and ( (handItem and handItem.prefab == "ruins_bat" ) or not self:IsCaneItem(handItem))  then
                
                self:TryEquipCaneItem()
            end
        end
    end
end


function Autoswitch:IsWeaponItem(item)
    return item and item:HasTag("weapon") and
            not (item.prefab == "cane" or item.prefab == "orangestaff")
end

function Autoswitch:IsCaneItem(item)
    
    
    return self:GetWalkspeedMult(item) > 1 and (item and item.prefab ~= "yellowamulet")
end

function Autoswitch:IsToolItem(item)
    return self.toolList[item.prefab] or (item and item:HasTag("dumbbell"))
end

function Autoswitch:IsStatueItem(item)
    return item and item:HasTag("heavy") and item:HasTag("_equippable")
end

function Autoswitch:IsMoving()
    return TheSim:GetDigitalControl(CONTROL_MOVE_LEFT) or
            TheSim:GetDigitalControl(CONTROL_MOVE_RIGHT) or
            TheSim:GetDigitalControl(CONTROL_MOVE_DOWN) or
            TheSim:GetDigitalControl(CONTROL_MOVE_UP)
end


function Autoswitch:CalcRange(weapon)
    return 3 + ((weapon and self.weaponList[weapon.prefab]) or 1)
end


function Autoswitch:IsAttacking()
    if TheSim:GetDigitalControl(CONTROL_ATTACK) or TheSim:GetDigitalControl(CONTROL_CONTROLLER_ATTACK) or TheSim:GetDigitalControl(CONTROL_MENU_MISC_1) or  TheInput:IsControlPressed(CONTROL_FORCE_ATTACK) then
        local x, y, z = ThePlayer:GetPosition():Get()
        local weapon = ThePlayer.replica.inventory:GetItemInSlot(self.chipSlot)
        
        
        
        
        
        
        

        if  self.isStrangeAttacks then
            return next(TheSim:FindEntities(x, y, z, self:CalcRange(weapon), nil, {
                "abigail", "wall"
            }, { "_combat", "hostile" }))
        else
            return next(TheSim:FindEntities(x, y, z, self:CalcRange(weapon), nil, {
                "abigail","player","wall"
            }, { "_combat", "hostile" }))
        end
    else
        return false
    end
end


function Autoswitch:AcceleraEquipSort(sortedItems,inventoryList)
    
    for prefab, key in pairs(self.allowedArr) do
        for i, itemPrefab in ipairs(inventoryList) do
            if itemPrefab.prefab == key then
                table.insert(sortedItems, inventoryList[i])
                table.remove(inventoryList, i)
                break
            end
        end
    end
end


function Autoswitch:AcceleraEquipFinalSort(inventoryList)
    
    local yesGameEquipmentList = {} 
    local gameEquipmentList = {} 

    for  _, item in pairs(inventoryList) do
        if self:IsCaneItem(item) then
            if self.allowedMap[item.prefab] then
                table.insert(yesGameEquipmentList,item)
            else
                table.insert(gameEquipmentList,item)
            end
        end
    end

    self:AcceleraEquipSort(gameEquipmentList,yesGameEquipmentList)

    return gameEquipmentList
end


function Autoswitch:TryEquipWeaponItem()
    local item = ThePlayer.replica.inventory:GetItemInSlot(self.chipSlot)
    if self:IsWeaponItem(item) then
        SendRPCToServer(RPC.EquipActionItem, item)
        
    end
end

function Autoswitch:TryEquipCaneItem()
    
    local inventoryList = ThePlayer.replica.inventory:GetItems()

    local handItem = ThePlayer.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    
    if handItem and self:IsToolItem(handItem) then
        return
    end

    
    local bodyItem = ThePlayer.replica.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
    if bodyItem and self:IsStatueItem(bodyItem) then
        return
    end

    
    local gameEquipmentList = self:AcceleraEquipFinalSort(inventoryList)

    
    for _, item in pairs(gameEquipmentList) do
            SendRPCToServer(RPC.EquipActionItem, item)
            return
    end
end

return Autoswitch
