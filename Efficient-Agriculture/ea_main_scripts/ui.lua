local json = require "json"

AddClassPostConstruct("widgets/widget", function(self)
	local old_kill = self.Kill
	function self:Kill()
		if self.OnKill then
			self:OnKill()
		end
		old_kill(self)
	end
end)

--@region 选择开垦地块Screen
local PlowTileSelectScreen = require "screens/ea_farm_plow_tile_select_screen"
AddClassPostConstruct("screens/playerhud", function(self)
	function self:Open_EA_TileSelectScreen(data)
		self:Close_EA_TileSelectScreen()
		self.ea_plow_tile_select_screen = PlowTileSelectScreen(self.owner, data)
		self:OpenScreenUnderPause(self.ea_plow_tile_select_screen)
		return true
	end

	function self:Close_EA_TileSelectScreen()
		if self.ea_plow_tile_select_screen ~= nil then
			if self.ea_plow_tile_select_screen.inst:IsValid() then
				TheFrontEnd:PopScreen(self.ea_plow_tile_select_screen)
			end
			self.ea_plow_tile_select_screen = nil
		end
	end
end)

local popup_plow_tile_select = AddPopup("EA_PLOW_TILE_SELECT")
popup_plow_tile_select.fn = function(inst, show, data)
	if type(data) == "string" then
		data = json.decode(data)
	end
    if inst.HUD then
        if not show then
            inst.HUD:Close_EA_TileSelectScreen()
        elseif not inst.HUD:Open_EA_TileSelectScreen(data) then
            POPUPS.EA_PLOW_TILE_SELECT:Close(inst)
        end
    end
end


--@region 修改containerwidget，增加额外按钮
local ImageButton = require "widgets/imagebutton"
local function RefreshButton(inst, self)
	if self.isopen then
        local widget = self.container.replica.container:GetWidget()
        if widget ~= nil and widget.buttoninfo2 ~= nil and widget.buttoninfo2.validfn ~= nil then
            if widget.buttoninfo2.validfn(self.container) then
                self.button2:Enable()
            else
                self.button2:Disable()
            end
        end
    end
end
AddClassPostConstruct("widgets/containerwidget", function (self)
	local old_Open = self.Open
	function self:Open(container, doer)
		local result = old_Open(self, container, doer)
		local widget = container.replica.container:GetWidget()
		if widget.buttoninfo and widget.buttoninfo.hover_text then
			self.button:SetHoverText(widget.buttoninfo.hover_text, widget.buttoninfo.hover_params)
		end
		if not widget.buttoninfo2 then
			return result
		end

		self.button2 = self:AddChild(ImageButton("images/ui.xml", "button_small.tex", "button_small_over.tex", "button_small_disabled.tex", nil, nil, {1,1}, {0,0}))
		self.button2.image:SetScale(1.07)
        self.button2.text:SetPosition(2,-2)
        self.button2:SetPosition(widget.buttoninfo2.position)
        self.button2:SetText(widget.buttoninfo2.text)
        if widget.buttoninfo2.fn ~= nil then
            self.button2:SetOnClick(function()
                if doer ~= nil then
                    if doer:HasTag("busy") then
                        --Ignore button2 click when doer is busy
                        return
                    elseif doer.components.playercontroller ~= nil then
                        local iscontrolsenabled, ishudblocking = doer.components.playercontroller:IsEnabled()
                        if not (iscontrolsenabled or ishudblocking) then
                            --Ignore button2 click when controls are disabled
                            --but not just because of the HUD blocking input
                            return
                        end
                    end
                end
                widget.buttoninfo2.fn(container, doer)
            end)
        end
        self.button2:SetFont(BUTTONFONT)
        self.button2:SetDisabledFont(BUTTONFONT)
        self.button2:SetTextSize(33)
        self.button2.text:SetVAlign(ANCHOR_MIDDLE)
        self.button2.text:SetColour(0, 0, 0, 1)

        if widget.buttoninfo2.validfn ~= nil then
            if widget.buttoninfo2.validfn(container) then
                self.button2:Enable()
            else
                self.button2:Disable()
            end
        end

        if TheInput:ControllerAttached() then
            self.button2:Hide()
        end

        self.button2.inst:ListenForEvent("continuefrompause", function()
            if TheInput:ControllerAttached() then
                self.button2:Hide()
            else
                self.button2:Show()
            end
        end, TheWorld)

		if widget.buttoninfo2.hover_text then
			self.button2:SetHoverText(widget.buttoninfo2.hover_text, widget.buttoninfo2.hover_params)
		end
		return result
	end


	local old_OnItemGet = self.OnItemGet
	function self:OnItemGet(data)
		local result = old_OnItemGet(self, data)
		if self.button2 ~= nil and self.container ~= nil then
			RefreshButton(self.inst, self)
			self.inst:DoTaskInTime(0, RefreshButton, self)
		end
		return result
	end


	local old_OnItemLose = self.OnItemLose
	function self:OnItemLose(data)
		local result = old_OnItemLose(self, data)
		if self.button2 ~= nil and self.container ~= nil then
			RefreshButton(self.inst, self)
			self.inst:DoTaskInTime(0, RefreshButton, self)
		end
		return result
	end


	local old_Close = self.Close
	function self:Close()
		if self.isopen and self.button2 ~= nil then
			self.button2:Kill()
			self.button2 = nil
		end
		local result = old_Close(self)
		return result
	end
end)