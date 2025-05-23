local function onmax(self, max)
  self.inst.exp_max:set(max)
end
local function oncurrent(self, current)
  self.inst.exp_current:set(current)
end
local function onlevel(self, level)
  self.inst.exp_level:set(level)
end
local exp =
  Class(
  function(self, inst)
      self.inst = inst
      self.maxtimepoint = 20
      self.currenttimepoint = 0
      self.levelpoint = 0
      self.updatefn = nil
      self.maxlevel = nil
  end,
  nil,
  {maxtimepoint = onmax, currenttimepoint = oncurrent, levelpoint = onlevel}
)
function exp:DoDelta(delta)
  local val = self.currenttimepoint + delta
  if self.levelpoint == self.maxlevel then
      self.currenttimepoint = self.maxtimepoint
      return
  end
  while val >= self.maxtimepoint do
      val = val - self.maxtimepoint
      if self.levelpoint < self.maxlevel then
          self:LevelUp()
      else
          self.currenttimepoint = self.maxtimepoint
          return
      end
  end
  self.currenttimepoint = val
end
function exp:GetPercent()
  return self.currenttimepoint / self.maxtimepoint
end
function exp:ApplyUpgrades()
  local hunger_percent = self.inst.components.hunger:GetPercent()
  local health_percent = self.inst.components.health:GetPercent()
  local sanity_percent = self.inst.components.sanity:GetPercent()
  if self.updatefn ~= nil then
      self.updatefn(self.inst)
  end
  self.inst.components.hunger:SetPercent(hunger_percent)
  self.inst.components.health:SetPercent(health_percent)
  self.inst.components.sanity:SetPercent(sanity_percent)
end
function exp:SetUpdateFn(fn)
  self.updatefn = fn
end
function exp:LevelUp()
  self.levelpoint = self.levelpoint + 1
  self.currenttimepoint = 0
  self:ApplyUpgrades()
end
function exp:OnSave()
  return {currenttimepoint = self.currenttimepoint, maxtimepoint = self.maxtimepoint, levelpoint = self.levelpoint}
end
function exp:OnLoad(data)
  self.currenttimepoint = data.currenttimepoint
  self.maxtimepoint = data.maxtimepoint
  self.levelpoint = data.levelpoint
end
return exp
