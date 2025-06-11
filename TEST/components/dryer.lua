local FREEZE_TIME = 40000 * 60 -- 40000 minutes
AddComponentPostInit("dryer",function(self)
  local function NewResume()
    print("*** CHẠY RESUME NÈ !!!!!!")
    if self.remainingtime ~= nil then
      if self.task ~= nil then
          self.task:Cancel()
      end
      if self.ingredient == nil then
        print("*** THỊT ĐÃ KHÔ, ĐÓNG BĂNG NÈ !!!!!")
        self.tasktotime = GLOBAL.GetTime() + FREEZE_TIME
        self.task = self.inst:DoTaskInTime(FREEZE_TIME, DoSpoil, self)
      else
        print("*** PHƠI THỊT BT !@#!#!@#!")
        self.task = self.inst:DoTaskInTime(self.remainingtime, DoDry, self)
        self.tasktotime = GLOBAL.GetTime() + self.remainingtime
      end
      self.remainingtime = nil
    end
  end
  self.Resume = NewResume
  self.DoSpoil = function() end
end)