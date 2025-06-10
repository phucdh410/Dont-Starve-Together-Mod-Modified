local dragpos = {}

local function loadDragPos()
    TheSim:GetPersistentString(
        "kkr_drag_pos",
        function(load_success, data)
            if load_success and data ~= nil then
                local success, allpos = RunInSandbox(data)
                if success and allpos then
                    for k, v in pairs(allpos) do
                        if dragpos[k] == nil then
                            dragpos[k] = Vector3(v.x or 0, v.y or 0, v.z or 0)
                        end
                    end
                end
            end
        end
    )
end

local function saveDragPos(dragtype, pos)
    if next(dragpos) then
        local str = DataDumper(dragpos, nil, true)
        TheSim:SetPersistentString("kkr_drag_pos", str, false)
    end
end

function GetKKRDragPos(dragtype)
    if dragpos[dragtype] == nil then
        loadDragPos()
    end
    return dragpos[dragtype]
end

function MakeKKRDragableUI(self, dragtarget, dragtype, dragdata)
    self.candrag = true

    if dragtarget then
        local oldOnControl = dragtarget.OnControl
        dragtarget.OnControl = function(self, control, down)
            local parentwidget = self:GetParent()

            if parentwidget and parentwidget.Passive_OnControl then
                parentwidget:Passive_OnControl(control, down)
            end
            if oldOnControl then
                return oldOnControl(self, control, down)
            end
        end
    end

    function self:Passive_OnControl(control, down)
        if self.focus and control == CONTROL_SECONDARY then
            if down then
                self:StartDrag()
            else
                self:EndDrag()
            end
        end
    end

    function self:SetDragPosition(x, y, z)
        local pos
        if type(x) == "number" then
            pos = Vector3(x, y, z)
        else
            pos = x
        end

        local self_scale = self:GetScale()
        local offset = dragdata and dragdata.drag_offset or 1
        local newpos = self.p_startpos + (pos - self.m_startpos) / (self_scale.x / offset)
        self:SetPosition(newpos)
    end

    function self:StartDrag()
        if not self.followhandler then
            local mousepos = TheInput:GetScreenPosition()
            self.m_startpos = mousepos
            self.p_startpos = self:GetPosition()
            self.followhandler =
                TheInput:AddMoveHandler(
                function(x, y)
                    self:SetDragPosition(x, y, 0)
                    if not Input:IsMouseDown(MOUSEBUTTON_RIGHT) then
                        self:EndDrag()
                    end
                end
            )
            self:SetDragPosition(mousepos)
        end
    end

    function self:EndDrag()
        if self.followhandler then
            self.followhandler:Remove()
        end
        self.followhandler = nil
        self.m_startpos = nil
        self.p_startpos = nil
        local newpos = self:GetPosition()
        if dragtype then
            dragpos[dragtype] = newpos
        end
        saveDragPos()
    end
end

AddClassPostConstruct(
    "widgets/containerwidget",
    function(self)
        local oldOpen = self.Open
        self.Open = function(self, ...)
            oldOpen(self, ...)
            if self.container and self.container.replica.container then
                local widget = self.container.replica.container:GetWidget()
                if widget then
                    local dragname = nil
                    if
                        self.container and
                            (self.container.prefab == "kkr_pocket" or self.container.prefab == "kkr_pocket_plus")
                     then
                        dragname = self.container.prefab
                    end
                    if dragname then
                        if not self.candrag then
                            MakeKKRDragableUI(self, self.bgimage, dragname, {drag_offset = 0.6})
                            MakeKKRDragableUI(self, self.bganim, dragname, {drag_offset = 0.6})
                        end

                        local newpos = GetKKRDragPos(dragname) or Vector3(0, 200, 0)
                        if newpos then
                            if self.container:HasTag("_equippable") and not self.container.isopended then
                                self.container:DoTaskInTime(
                                    0,
                                    function()
                                        self:SetPosition(newpos)
                                    end
                                )
                                self.container.isopended = true
                            else
                                self:SetPosition(newpos)
                            end
                        end
                    end
                end
            end
        end
    end
)

AddClassPostConstruct(
    "screens/playerhud",
    function(self)
        self.inst:DoTaskInTime(
            0.1,
            function()
                if not self.owner:HasTag("kkr") then
                    return
                end
                local oldOnRawKey = self.OnRawKey
                self.OnRawKey = function(s, key, down, ...)
                    if oldOnRawKey(self, key, down, ...) then
                        return true
                    end
                    if KKRENV.KKR_DOMAIN_SKILL_ENABLE and key == _G.KKRENV.KKR_FLY_SKILL and not down then
                        if self.owner.components.kkrfly and not self.owner:HasTag("playerghost") then
                            local num_spirits =
                                self.owner.kkr_wind_spirit_leader and
                                self.owner.kkr_wind_spirit_leader.components.kkrspiritleader:GetFormationSize() or
                                0
                            if num_spirits > 0 and self.owner.components.kkrfly.kkr_fly == false then
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
                        if self.owner.kkr_domain and not self.owner:HasTag("playerghost") then
                            self.owner:kkr_domain(self.owner)
                        else
                            SendModRPCToServer(MOD_RPC["kkr"]["kkr_domain"])
                        end
                    end
                end
            end
        )
    end
)
