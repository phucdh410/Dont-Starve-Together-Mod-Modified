local WayOfWanderBadge = require("widgets/wayofwander_badge")
local function Add_WayOfWander(self)
	self.owner:DoTaskInTime(0.1, function()
		if not self.owner.replica.yasuo_skills then
			return
		end
		self.way_of_wander = self:AddChild(WayOfWanderBadge(self.owner))
		local x1 ,y1,z1 = self.stomach:GetPosition():Get()
		local x2 ,y2,z2 = self.brain:GetPosition():Get()
		local x3 ,y3,z3 = self.heart:GetPosition():Get()
		if y2 == y1 or y2 == y3 then 
			self.way_of_wander:SetPosition(self.stomach:GetPosition() + Vector3(x1-x2, 0, 0))
		else
			self.way_of_wander:SetPosition(self.stomach:GetPosition() + Vector3(x1-x3, 0, 0))
		end

		self.inst:ListenForEvent("way_of_wanderdirty", function(inst)
			local percent = self.owner.replica.yasuo_skills.way_of_wander:value() / self.owner.replica.yasuo_skills.way_of_wander_max:value()
			self.way_of_wander:SetPercent(percent, self.owner.replica.yasuo_skills.way_of_wander_max:value())
		end,self.owner)
	end)


	local old_SetGhostMode = self.SetGhostMode
	function self:SetGhostMode(ghostmode,...)
		old_SetGhostMode(self,ghostmode,...)
		if ghostmode then
			if self.way_of_wander ~= nil then
				self.way_of_wander:Hide()
			end
		else
			if self.way_of_wander ~= nil then
				self.way_of_wander:Show()
			end
		end
	end
end
AddClassPostConstruct("widgets/statusdisplays", Add_WayOfWander)



local YasuoSkills = require("widgets/yasuo_skills")
local function AddYasuo_Skills(self)
	self.owner:DoTaskInTime(0.5, function ()
		if not self.owner.replica.yasuo_skills then
			return
		end
		self.yasuo_skills = self.bottom_root:AddChild(YasuoSkills(self.owner))
		self.yasuo_skills:SetPosition(0, 90, 0)
		self.yasuo_skills:MoveToBack()
	end)

	local HideCraftingAndInventory = self.HideCraftingAndInventory
	function self:HideCraftingAndInventory(...)
		HideCraftingAndInventory(self,...)
		if self.yasuo_skills ~= nil then
			self.yasuo_skills:Hide()
		end
	end

	local ShowCraftingAndInventory = self.ShowCraftingAndInventory
	function self:ShowCraftingAndInventory(...)
		ShowCraftingAndInventory(self,...)
		if self.yasuo_skills ~= nil then
			self.yasuo_skills:Show()
		end
	end
end

AddClassPostConstruct("widgets/controls", AddYasuo_Skills)


local function ModFollowMouse(self)
    local old_sva = self.SetVAnchor
    self.SetVAnchor = function (_self, anchor)
        self.v_anchor = anchor
        return old_sva(_self, anchor)
    end

    local old_sha = self.SetHAnchor
    self.SetHAnchor = function (_self, anchor)
        self.h_anchor = anchor
        return old_sha(_self, anchor)
    end

    local function GetMouseLocalPos(ui, mouse_pos)        
        local g_s = ui:GetScale()                    
        local l_s = Vector3(0,0,0)
        l_s.x, l_s.y, l_s.z = ui:GetLooseScale()    
        local scale = Vector3(g_s.x/l_s.x, g_s.y/l_s.y, g_s.z/l_s.z)    

        local ui_local_pos = ui:GetPosition()        
        ui_local_pos = Vector3(ui_local_pos.x * scale.x, ui_local_pos.y * scale.y, ui_local_pos.z * scale.z)
        local ui_world_pos = ui:GetWorldPosition()
        
        if not (not ui.v_anchor or ui.v_anchor == ANCHOR_BOTTOM) or not (not ui.h_anchor or ui.h_anchor == ANCHOR_LEFT) then
            local screen_w, screen_h = TheSim:GetScreenSize()        
            if ui.v_anchor and ui.v_anchor ~= ANCHOR_BOTTOM then    
                ui_world_pos.y = ui.v_anchor == ANCHOR_MIDDLE and screen_h/2 + ui_world_pos.y or screen_h - ui_world_pos.y
            end
            if ui.h_anchor and ui.h_anchor ~= ANCHOR_LEFT then        
                ui_world_pos.x = ui.h_anchor == ANCHOR_MIDDLE and screen_w/2 + ui_world_pos.x or screen_w - ui_world_pos.x
            end
        end

        local origin_point = ui_world_pos - ui_local_pos    
        mouse_pos = mouse_pos - origin_point

        return Vector3(mouse_pos.x/ scale.x, mouse_pos.y/ scale.y, mouse_pos.z/ scale.z)    
    end

    
    self.FollowMouse = function(_self)
        if _self.followhandler == nil then
            _self.followhandler = TheInput:AddMoveHandler(function(x, y)
                local loc_pos = GetMouseLocalPos(_self, Vector3(x, y, 0))    
                _self:UpdatePosition(loc_pos.x, loc_pos.y)
            end)
            _self:SetPosition(GetMouseLocalPos(_self, TheInput:GetScreenPosition()))
        end
    end
end
AddClassPostConstruct("widgets/widget", ModFollowMouse)