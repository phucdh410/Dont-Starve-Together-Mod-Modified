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
		if y2 == y1 or y2 == y3 then --开了三维mod
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
    --GetWorldPosition获得的坐标是基于屏幕原点的，默认为左下角，当单独设置了原点的时候，这个函数返回的结果和GetPosition的结果一样了，达不到我们需要的效果
    --因为官方没有提供查询原点坐标的接口，所以需要修改设置原点的两个函数，将原点位置记录在widget上
    --注意：虽然默认的屏幕原点为左下角，但是每个widget默认的坐标原点为其父级的屏幕坐标；
        --而当你单独设置了原点坐标后，不仅其屏幕原点改变了，而且坐标原点的位置也改变为屏幕原点了
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

    --默认的原点坐标为父级的坐标，如果widget上有v_anchor和h_anchor这两个变量，就说明改变了默认的原点坐标
    --我们会在GetMouseLocalPos函数里检查这两个变量，以对这种情况做专门的处理
    --这个函数可以将鼠标坐标从屏幕坐标系下转换到和wiget同一个坐标系下
    local function GetMouseLocalPos(ui, mouse_pos)        --ui: 要拖拽的widget, mouse_pos: 鼠标的屏幕坐标(Vector3对象)
        local g_s = ui:GetScale()                    --ui的全局缩放值
        local l_s = Vector3(0,0,0)
        l_s.x, l_s.y, l_s.z = ui:GetLooseScale()    --ui本身的缩放值
        local scale = Vector3(g_s.x/l_s.x, g_s.y/l_s.y, g_s.z/l_s.z)    --父级的全局缩放值

        local ui_local_pos = ui:GetPosition()        --ui的相对位置（也就是SetPosition的时候传递的坐标）
        ui_local_pos = Vector3(ui_local_pos.x * scale.x, ui_local_pos.y * scale.y, ui_local_pos.z * scale.z)
        local ui_world_pos = ui:GetWorldPosition()
        --如果修改过ui的屏幕原点，就重新计算ui的屏幕坐标（基于左下角为原点的）
        if not (not ui.v_anchor or ui.v_anchor == ANCHOR_BOTTOM) or not (not ui.h_anchor or ui.h_anchor == ANCHOR_LEFT) then
            local screen_w, screen_h = TheSim:GetScreenSize()        --获取屏幕尺寸（宽度，高度）
            if ui.v_anchor and ui.v_anchor ~= ANCHOR_BOTTOM then    --如果修改了原点的垂直坐标
                ui_world_pos.y = ui.v_anchor == ANCHOR_MIDDLE and screen_h/2 + ui_world_pos.y or screen_h - ui_world_pos.y
            end
            if ui.h_anchor and ui.h_anchor ~= ANCHOR_LEFT then        --如果修改了原点的水平坐标
                ui_world_pos.x = ui.h_anchor == ANCHOR_MIDDLE and screen_w/2 + ui_world_pos.x or screen_w - ui_world_pos.x
            end
        end

        local origin_point = ui_world_pos - ui_local_pos    --原点坐标
        mouse_pos = mouse_pos - origin_point

        return Vector3(mouse_pos.x/ scale.x, mouse_pos.y/ scale.y, mouse_pos.z/ scale.z)    --鼠标相对于UI父级坐标的局部坐标
    end

    --修改官方的鼠标跟随，以适应所有情况(垃圾科雷)
    self.FollowMouse = function(_self)
        if _self.followhandler == nil then
            _self.followhandler = TheInput:AddMoveHandler(function(x, y)
                local loc_pos = GetMouseLocalPos(_self, Vector3(x, y, 0))    --主要是将原本的x,y坐标进行了坐标系的转换，使用转换后的坐标来更新widget位置
                _self:UpdatePosition(loc_pos.x, loc_pos.y)
            end)
            _self:SetPosition(GetMouseLocalPos(_self, TheInput:GetScreenPosition()))
        end
    end
end
AddClassPostConstruct("widgets/widget", ModFollowMouse)