local Widget = require "widgets/widget"
local Image = require "widgets/image"
local ImageButton = require "widgets/imagebutton"
local Text = require "widgets/text"

local yasuo_skills_def = require("yasuo_skills_def")
local Yasuo_Skills = Class(Widget, function(self, owner)
    self.owner = owner
    Widget._ctor(self, "Yasuo_Skills")

    self.root = self:AddChild(Widget("root"))
    self.bg = self.root:AddChild(Image("images/skills/yasuo_skills_bg.xml", "yasuo_skills_bg.tex"))

    self.skills = {}
    for skillname, data in pairs(yasuo_skills_def) do
        self.skills[skillname] = {}
        self.skills[skillname].bg = self.root:AddChild(Image("images/skills/yasuo_skills_btn_bg.xml", "yasuo_skills_btn_bg.tex"))
        self.skills[skillname].bg:SetPosition(data.order * 90 - 275, 0, 0)
        self.skills[skillname].bg:SetScale(1.2, 1.2)

        self.skills[skillname].btn = self.root:AddChild(ImageButton("images/skills/"..skillname..".xml", skillname.."_enable.tex", skillname.."_enable.tex"))
        self.skills[skillname].btn:SetPosition(data.order * 90 - 275, 0, 0)
        self.skills[skillname].btn:SetHoverText(data.description, {offset_y = 150})
        self.skills[skillname].btn.scale_on_focus = false

        self.skills[skillname].cd = self.skills[skillname].btn:AddChild(Text(TALKINGFONT_WORMWOOD, 50))
        self.skills[skillname].cd:SetColour(UICOLOURS.WHITE)
        self.skills[skillname].cd:SetPosition(10, -5, 0)

        if skillname == "steel_tempest" then
            self.skills[skillname].hit = self.skills[skillname].btn:AddChild(Text(TALKINGFONT_WORMWOOD, 40))
            self.skills[skillname].hit:SetColour(UICOLOURS.BLACK)
            self.skills[skillname].hit:SetPosition(20, -20, 0)
        end
    end

    self:SetScale(0.6, 0.6)

    self.inst:ListenForEvent("steel_tempest_hit_delta", function (inst, data) self:UpdateHit(data) end, self.owner)
    self.inst:ListenForEvent("skills_cd_start", function () self:StartCoolDown() end, self.owner)
    self.inst:DoTaskInTime(0, function () self:StartCoolDown() end)

    self:StartUpdating()

    
    self.OnMouseButton = function(_self, button, down, x, y)    
		if button == MOUSEBUTTON_RIGHT and down then    
			 _self.draging = true    
			_self:FollowMouse()     
		elseif button == MOUSEBUTTON_RIGHT then            
			_self.draging = false        
			_self:StopFollowMouse()        
		end
	end
end)

function Yasuo_Skills:UpdateHit(hit)
    if self.skills["steel_tempest"].hit then
        if hit == 0 then
            self.skills["steel_tempest"].hit:SetString("")
        else
            self.skills["steel_tempest"].hit:SetString(tostring(hit))
        end
    end
    self.skills["steel_tempest"].hit.hit = hit
end

function Yasuo_Skills:StartCoolDown()
    for skillname, data in pairs(yasuo_skills_def) do
        local cd = self.owner.replica.yasuo_skills:GetSkillCdLeft(skillname)
        if cd ~= nil then
            self.skills[skillname].cd.cd = cd
            self.skills[skillname].btn:SetTextures("images/skills/"..skillname..".xml", skillname.."_disable.tex", skillname.."_disable.tex")
        end
    end
end

function Yasuo_Skills:OnUpdate(dt)
    if not TheNet:IsServerPaused() then
        for skillname, data in pairs(yasuo_skills_def) do
            if self.skills[skillname].cd.cd then
                self.skills[skillname].cd.cd = self.skills[skillname].cd.cd - dt
                self.skills[skillname].cd:SetString(string.format("%.1f",tostring(self.skills[skillname].cd.cd)))
                if self.skills[skillname].cd.cd < 0 then
                    self.skills[skillname].btn:SetTextures("images/skills/"..skillname..".xml", skillname.."_enable.tex", skillname.."_enable.tex")
                    self.skills[skillname].cd:SetString("")
                    self.skills[skillname].cd.cd = nil
                end
            end
        end
        if self.skills["steel_tempest"].hit.hit == 2 and not self.skills["steel_tempest"].cd.cd then
            self.skills["steel_tempest"].btn:SetTextures("images/skills/steel_tempest_tornado.xml", "steel_tempest_tornado_enable.tex", "steel_tempest_tornado_enable.tex")
        end
    end
end

return Yasuo_Skills