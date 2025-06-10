--参考能力勋章的ui拖拽
--拖拽坐标，局部变量存储，减少io操作
local dragpos={}
--更新同步拖拽坐标(如果容器没打开过，那么存储的坐标信息就没被赋值到dragpos里，这时候直接去存储就会导致之前存储的数据缺失，所以要主动取一下数据存到dragpos里)
local function loadDragPos()
	TheSim:GetPersistentString("kkr_drag_pos", function(load_success, data)
		if load_success and data ~= nil then
            local success, allpos = RunInSandbox(data)
		    if success and allpos then
				for k, v in pairs(allpos) do
					if dragpos[k]==nil then
						dragpos[k]=Vector3(v.x or 0, v.y or 0, v.z or 0)
					end
				end
			end
		end
	end)
end
--存储拖拽后坐标
local function saveDragPos(dragtype,pos)
	if next(dragpos) then
		local str = DataDumper(dragpos, nil, true)
		TheSim:SetPersistentString("kkr_drag_pos", str, false)
	end
end
--获取拖拽坐标
function GetKKRDragPos(dragtype)
	if dragpos[dragtype]==nil then
		loadDragPos()
	end
	return dragpos[dragtype]
end
--设置UI可拖拽(self,拖拽目标,拖拽标签,拖拽信息)
function MakeKKRDragableUI(self,dragtarget,dragtype,dragdata)
	self.candrag=true--可拖拽标识(防止重复添加拖拽功能)
	--给拖拽目标添加拖拽提示
	if dragtarget then
		local oldOnControl=dragtarget.OnControl
		dragtarget.OnControl = function (self,control, down)
			local parentwidget=self:GetParent()--控制它爹的坐标,而不是它自己
			--按下右键可拖动
			if parentwidget and parentwidget.Passive_OnControl then
				parentwidget:Passive_OnControl(control, down)
			end
			if oldOnControl then
				return oldOnControl(self,control,down)
			end
		end
	end
	
	--被控制(控制状态，是否按下)
	function self:Passive_OnControl(control, down)
		if self.focus and control == CONTROL_SECONDARY then
			if down then
				self:StartDrag()
			else
				self:EndDrag()
			end
		end
	end
	--设置拖拽坐标
	function self:SetDragPosition(x, y, z)
		local pos
		if type(x) == "number" then
			pos = Vector3(x, y, z)
		else
			pos = x
		end
		
		local self_scale=self:GetScale()
		local offset=dragdata and dragdata.drag_offset or 1--偏移修正(容器是0.6)
		local newpos=self.p_startpos+(pos-self.m_startpos)/(self_scale.x/offset)--修正偏移值
		self:SetPosition(newpos)--设定新坐标
	end
	
	--开始拖动
	function self:StartDrag()
		if not self.followhandler then
			local mousepos = TheInput:GetScreenPosition()
			self.m_startpos = mousepos--鼠标初始坐标
			self.p_startpos = self:GetPosition()--面板初始坐标
			self.followhandler = TheInput:AddMoveHandler(function(x,y)
				self:SetDragPosition(x,y,0)
				if not Input:IsMouseDown(MOUSEBUTTON_RIGHT) then
					self:EndDrag()
				end
			end)
			self:SetDragPosition(mousepos)
		end
	end
	--停止拖动
	function self:EndDrag()
		if self.followhandler then
			self.followhandler:Remove()
		end
		self.followhandler = nil
		self.m_startpos = nil
		self.p_startpos = nil
		local newpos=self:GetPosition()
		if dragtype then
			dragpos[dragtype]=newpos--记录记录拖拽后坐标
		end
		saveDragPos()--存储坐标
	end
end

AddClassPostConstruct("widgets/containerwidget", function(self)
    local oldOpen = self.Open
    self.Open = function(self,...)
        oldOpen(self,...)
        if self.container and self.container.replica.container then
            local widget = self.container.replica.container:GetWidget()
            if widget then	
                --拖拽坐标标签，有则用标签，无则用容器名
                local dragname = nil
				if self.container and (self.container.prefab == "kkr_pocket" or self.container.prefab == "kkr_pocket_plus") then
					dragname = self.container.prefab
				end
                if dragname then
                    --设置可拖拽
                    if not self.candrag then
                        MakeKKRDragableUI(self,self.bgimage,dragname,{drag_offset=0.6})
                        MakeKKRDragableUI(self,self.bganim,dragname,{drag_offset=0.6})
                    end
                    --设置容器坐标(可装备的容器第一次打开做个延迟，不然加载游戏进来位置读不到)
					local newpos=GetKKRDragPos(dragname) or Vector3(0, 200, 0) 
                    if newpos then
                        if self.container:HasTag("_equippable") and not self.container.isopended then
                            self.container:DoTaskInTime(0, function()
                                self:SetPosition(newpos)
                            end)
                            self.container.isopended=true
                        else
                            self:SetPosition(newpos)
                        end
                    end
                end
            end
        end
    end
end)

AddClassPostConstruct("screens/playerhud", function(self)
    self.inst:DoTaskInTime(0.1, function()
        if  not self.owner:HasTag("kkr") then
            return
        end
        local oldOnRawKey = self.OnRawKey
		self.OnRawKey = function (s,key, down, ...)
			if oldOnRawKey(self, key, down, ...) then return true end
            if  KKRENV.KKR_DOMAIN_SKILL_ENABLE and key == _G.KKRENV.KKR_FLY_SKILL and not down then
                if  self.owner.components.kkrfly and not self.owner:HasTag("playerghost")  then
					local num_spirits = self.owner.kkr_wind_spirit_leader and self.owner.kkr_wind_spirit_leader.components.kkrspiritleader:GetFormationSize() or 0
					if  num_spirits > 0 and self.owner.components.kkrfly.kkr_fly == false then
						local formation = self.owner.kkr_wind_spirit_leader.components.kkrspiritleader.formation
						local random_index = math.random(1, #formation)
                        local random_element = formation[random_index]
						if random_element and random_element:IsValid() then
							random_element:Remove()
						end
						self.owner.components.kkrfly:Fly()
					elseif self.owner.components.kkrfly.kkr_fly == true then
						self.owner.components.kkrfly:Land()
					end
				else
					SendModRPCToServer(MOD_RPC["kkr"]["Kkr_fly"])
				end
			elseif KKRENV.KKR_FLY_SKILL_ENABLE and key == _G.KKRENV.KKR_DOMAIN_SKILL and not down then
				if  self.owner.kkr_domain and not self.owner:HasTag("playerghost") then
					self.owner:kkr_domain(self.owner)
				else
					SendModRPCToServer(MOD_RPC["kkr"]["kkr_domain"])
				end

            end
		end
    end)
end)