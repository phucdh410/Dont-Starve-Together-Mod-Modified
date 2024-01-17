local ItemSlot = require "widgets/itemslot"
local Widget = require "widgets/widget"
local UIAnim = require "widgets/uianim"
local Image = require "widgets/image"
local ImageButton = require "widgets/imagebutton"
local Text = require "widgets/text"

local PersistentData = require("persistentdata")
local DataContainer = PersistentData("mod_attack_reset")

local TotalItemList = {}
local Set
local TotalSlots = 3

local sacred_chest =
{
    { image = "equip_slot.tex" },
    { image = "equip_slot_body.tex" },
    { image = "equip_slot_head.tex" },
}


local SetID = {
	hands = 0,
	body = 1,
	head = 2,
}

local ActivateMode = {
	[0] = "Unpress",
	[1] = "Press"
}

local AttackRate = 3
local IsActive = true
local IsHide = false
local IsSwap = false

local ShowPosition = Vector3(192,200,0)
local HidePosition = Vector3(192,-20,0)

local function AddToSet(CurrentSet, SetTier, ItemReplica)
	if ItemReplica and ItemReplica.replica.equippable then
				local ID = SetID[ItemReplica.replica.equippable:EquipSlot()]
				Set[CurrentSet][SetTier][ID] = ItemReplica.replica.inventoryitem
				if Set[CurrentSet][(SetTier + 1)%2][ID] == ItemReplica.replica.inventoryitem and CurrentSet < 3 then
					Set[CurrentSet][(SetTier + 1)%2][ID] = nil
				end
	end
end


local SetSelectionWidget = Class(Widget, function(self, owner)
    Widget._ctor(self, "Container")
    local scale = .6
    self:SetScale(scale,scale,scale)
    self.inv = {}
    self.owner = owner
    self:SetPosition(0, 0, 0)

    self.bganim = self:AddChild(UIAnim())
    self.bganim:GetAnimState():AnimateWhilePaused(false)
	self.KnownSet = nil
	self.CurrentSet = 0
end)

function SetSelectionWidget:ApplyItem(x, y)
	local ID = y
	local HoldingItem = ThePlayer.replica.inventory:GetActiveItem()
	if HoldingItem then
		AddToSet(self.CurrentSet,ID,HoldingItem)
	else
		Set[self.CurrentSet][y][x] = nil
	end
end

function SetSelectionWidget:ApplyAllITems()
	for  x = 0, 2  do
		local Activated = false
		for y = 0, 1 do
			if self.CurrentSet>2 and self.HotKeyData then
				local KeyBind = string.upper(self.HotKeyData[self.CurrentSet][2 - y])
				if KeyBind~= "DISABLED" then
					KeyBind = string.sub(KeyBind,5)
					self.inv[y][x].Slotnum:SetString(KeyBind)
					self.inv[y][x]:SetHoverText(ActivateMode[y].." "..KeyBind.." to equip this set.")
				else
					self.inv[y][x].Slotnum:SetString("")
					self.inv[y][x]:SetHoverText("Bind a key to this set in mod setting.")
				end
			else
				self.inv[y][x].Slotnum:SetString(tostring(self.CurrentSet + 1))
				self.inv[y][x]:SetHoverText("Drop item here to apply set.")
			end
			if Set[self.CurrentSet][y][x] and Set[self.CurrentSet][y][x].classified then
				self.inv[y][x].ItemAnimate:SetTexture(Set[self.CurrentSet][y][x]:GetAtlas(),Set[self.CurrentSet][y][x]:GetImage())
				self.inv[y][x].ItemAnimate:SetPosition(Vector3(0, 0, 0))
				self.inv[y][x].ItemAnimate:Show()
				Activated = true
			else
				self.inv[y][x].ItemAnimate:Hide()
			end
		end
		if Activated then
			self.inv[0][x].bgimage:SetTint(0.9,1,0.9,1)
			self.inv[1][x].bgimage:SetTint(0.9,1,0.9,1)
		else
			self.inv[0][x].bgimage:SetTint(0.75,0.75,0.75,1)
			self.inv[1][x].bgimage:SetTint(0.75,0.75,0.75,1)
		end
	end
	self.button:SetText(self:GetBtnText())
	self:SaveSet()
end

function SetSelectionWidget:GetBtnText()
	local Text = ""
	if self.CurrentSet < 3 then
		self.button:SetHoverText("Enable or disable swap set")
		if IsActive then 
			Text = Text.."Speed = "..AttackRate
		else
			Text = "Disabled"
		end
	else
		self.button:SetHoverText("Equip set before or after you attack\n While in this menu, swap is disabled")
		if IsSwap then 
			Text = "First hit"
		else
			Text = "Second hit"
		end
	end
	return Text
end

function SetSelectionWidget:Install(BonusSlots,KeyData)
	Set = {}
	TotalSlots = 3 + (BonusSlots or 0)
	for setTier = 0, TotalSlots do
		Set[setTier] = {}
		for  y = 0, 1  do
			Set[setTier][y] = {}
			for x = 0, 2 do
				Set[setTier][y][x] = nil
			end
		end
	end
	self.HotKeyData = KeyData
	self.bganim:GetAnimState():SetBank("ui_chest_3x3")
    self.bganim:GetAnimState():SetBuild("ui_chest_3x3")
	self.bganim:GetAnimState():PlayAnimation("open")
	self:MoveToBack()
	local scale = 0.6
    self:SetScale(scale,scale,scale)
	self:SetPosition(Vector3(192, 200, 0))
	
	for y = 0, 1 do
		self.inv[y] = {}
		for x = 0, 2 do
			local slot = ItemSlot("images/hud.xml",sacred_chest[x + 1].image,self.owner)
			slot:SetPosition(Vector3(80 * x - 80 * 2 + 80, 80 * y - 80 * 2 + 160, 0))
			slot.ItemAnimate = slot:AddChild(Image())
			slot.xPos = x
			slot.yPos = y
			
			slot.OnMouseButton = function(Slef, button, down, xx, yy)
				if not Slef.focus then return false end
				for k,v in pairs (Slef.children) do
					if v.focus and v:OnMouseButton(button, down, xx, yy) then return true end
				end
                if button == 1000 and down then
					self:ApplyItem(Slef.xPos, Slef.yPos)
					self:ApplyAllITems()
                end
				return true
            end
			
			slot.Slotnum = slot:AddChild(Text(BODYTEXTFONT, 64))
			slot.Slotnum:SetHAlign(ANCHOR_MIDDLE)
			slot.Slotnum:SetVAlign(ANCHOR_MIDDLE)
			slot.Slotnum:SetColour(1,1,1,0.25)
			slot.Slotnum:SetPosition(5, 0, 0)
			slot.Slotnum:SetClickable(false)
			
			slot.ItemAnimate:MoveToFront()
			
			self.inv[y][x] = self:AddChild(slot)
			self.inv[y][x]:Show()
		end
	end
	
	self.button = self:AddChild(ImageButton())
    self.button:SetPosition(0, -80)
	self.button:SetText(self:GetBtnText())
    self.button.text:SetPosition(0, 0)
    self.button:SetFont(BUTTONFONT)
	self.button.image:SetScale(.4, 1.1)
	self.button:SetOnClick(function()
		if self.CurrentSet < 3 then
			IsActive = not IsActive
			self.button:SetText(self:GetBtnText())
		else
			IsSwap = not IsSwap
			self.button:SetText(self:GetBtnText())
		end
    end)
	
	self.LeftBtn = self:AddChild( ImageButton("images/ui.xml", "crafting_inventory_arrow_l_idle.tex", "crafting_inventory_arrow_l_hl.tex", "arrow_left_disabled.tex", "crafting_inventory_arrow_l_hl.tex",nil,{1,1}, {0,0}) )
	self.LeftBtn:SetPosition(-90, -80)
	self.LeftBtn:SetHoverText("Decrease speed.")
	self.LeftBtn:SetOnClick(function()
		AttackRate = AttackRate - 1
		IsActive = true
		self:SaveSet()
		self.button:SetText(self:GetBtnText())
    end)
	
	self.RightBtn = self:AddChild( ImageButton("images/ui.xml", "crafting_inventory_arrow_r_idle.tex", "crafting_inventory_arrow_r_hl.tex", "arrow_right_disabled.tex", "crafting_inventory_arrow_r_hl.tex",nil,{1,1}, {0,0}) )
	self.RightBtn:SetPosition(90, -80)
	self.RightBtn:SetHoverText("Increase speed.")
	self.RightBtn:SetOnClick(function()
		AttackRate = AttackRate + 1
		IsActive = true
		self:SaveSet()
		self.button:SetText(self:GetBtnText())
    end)
	
	self.TopBtn = self:AddChild( ImageButton("images/ui.xml", "crafting_inventory_arrow_r_idle.tex", "crafting_inventory_arrow_r_hl.tex", "arrow_right_disabled.tex", "crafting_inventory_arrow_r_hl.tex",nil,{1,1}, {0,0}) )
	self.TopBtn:SetPosition(0, 160)
	self.TopBtn:SetRotation(90)
	self.TopBtn:SetHoverText("Hide Ui.")
	self.TopBtn:SetOnClick(function()
		IsHide = not IsHide
		if IsHide then 
			self:SetPosition(HidePosition)
			self.TopBtn:SetRotation(-90)
			self.TopBtn:SetHoverText("Show Ui.")
		else 
			self:SetPosition(ShowPosition)
			self.TopBtn:SetRotation(90)
			self.TopBtn:SetHoverText("Hide Ui.")
		end
    end)
	
	self.LeftChangeBtn = self:AddChild( ImageButton("images/ui.xml", "crafting_inventory_arrow_l_idle.tex", "crafting_inventory_arrow_l_hl.tex", "arrow_left_disabled.tex", "crafting_inventory_arrow_l_hl.tex",nil,{1,1}, {0,0}) )
	self.LeftChangeBtn:SetPosition(-130, 40)
	self.LeftChangeBtn:SetHoverText("Change current active set.")
	self.LeftChangeBtn:SetOnClick(function()
		self.CurrentSet = (self.CurrentSet + TotalSlots - 1) % TotalSlots
		IsActive = true
		self:ApplyAllITems()
		self.button:SetText(self:GetBtnText())
    end)
	
	self.RightChangeBtn = self:AddChild( ImageButton("images/ui.xml", "crafting_inventory_arrow_r_idle.tex", "crafting_inventory_arrow_r_hl.tex", "arrow_right_disabled.tex", "crafting_inventory_arrow_r_hl.tex",nil,{1,1}, {0,0}) )
	self.RightChangeBtn:SetPosition(130, 40)
	self.RightChangeBtn:SetHoverText("Change current active set.")
	self.RightChangeBtn:SetOnClick(function()
		self.CurrentSet = (self.CurrentSet + 1) % TotalSlots
		IsActive = true
		self:ApplyAllITems()
		self.button:SetText(self:GetBtnText())
    end)
	
	self:LoadSet()
	self:Show()
end

function SetSelectionWidget:GetData()
	self:ApplyAllITems()
	return IsActive, Set, AttackRate
end

function SetSelectionWidget:GetRate()
	return AttackRate
end

function SetSelectionWidget:IsActivated()
	return IsActive and self.CurrentSet < 3
end

function SetSelectionWidget:GetIsSwap()
	return IsSwap
end

function SetSelectionWidget:GetSet()
	self:ApplyAllITems()
	return Set[self.CurrentSet]
end

function SetSelectionWidget:GetInstantSet(instantSetID)
	local CurrentSetID = instantSetID % 2
	local TotalSet = math.floor(instantSetID/2)
	return Set[TotalSet + 3][CurrentSetID]
end

function SetSelectionWidget:GetCurrentSet(CurrentSetID)
	return Set[self.CurrentSet][CurrentSetID]
end

function SetSelectionWidget:SaveSet()
	local Server_name = TheNet and TheNet:GetServerListing() and TheNet:GetServerListing().name or "NONE"
	self.KnownSet = {}
	self.KnownSet.SetData = {}
	for setnum = 0, TotalSlots do
		self.KnownSet.SetData[setnum] = {}
		for y = 0, 1 do
			self.KnownSet.SetData[setnum][y] = {}
			for x = 0, 2 do
				if Set[setnum][y][x] and Set[setnum][y][x].classified then
					self.KnownSet.SetData[setnum][y][x] = tostring(Set[setnum][y][x].inst.prefab)
				else
					self.KnownSet.SetData[setnum][y][x] = "nothing"
				end
			end
		end
	end
	self.KnownSet.AttackRate = AttackRate
	self.KnownSet.CurrentSet = self.CurrentSet
	DataContainer:SetValue(Server_name, self.KnownSet)
	DataContainer:Save()
end

function SetSelectionWidget:GetItemList()
	TotalItemList = {}
	local items = ThePlayer.replica.inventory:GetItems()
	local equips = ThePlayer.replica.inventory:GetEquips()
	for i,v in pairs(equips) do
		table.insert(TotalItemList, v)
	end
	for i,v in pairs(items) do
		table.insert(TotalItemList, v)
	end
end

function SetSelectionWidget:LoadSet()
	local Server_name = TheNet and TheNet:GetServerListing() and TheNet:GetServerListing().name or "NONE"
	DataContainer:Load()
	self.KnownSet = DataContainer:GetValue(Server_name) or {}
	if self.KnownSet and self.KnownSet.SetData then
		for setnum, allSets in pairs(self.KnownSet.SetData) do 	
		self:GetItemList()
			if type(allSets) == 'table' then
			for y , completeSet in pairs(allSets) do
				if type(completeSet) == 'table' then
				for x , itemPrefab in pairs(completeSet) do
					if itemPrefab and itemPrefab~= "nothing" then
					for k, itemEnt in pairs(TotalItemList) do
						if itemEnt and itemEnt.prefab == itemPrefab then
							Set[tonumber(setnum)][tonumber(y)][tonumber(x)] = itemEnt.replica.inventoryitem
							table.remove(TotalItemList,k)
							break
						end
					end
					end
				end
				end
			end
			end
		end
		AttackRate = self.KnownSet.AttackRate or AttackRate
		self.CurrentSet =  self.KnownSet.CurrentSet or self.CurrentSet
		self:ApplyAllITems()
	end
end

return SetSelectionWidget

