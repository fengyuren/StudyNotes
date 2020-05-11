
--每日倒计时
--cc.globalVar.sysTime 当前系统时间
local scheduler = cc.Director:getInstance():getScheduler()
--调用
self._schedulerUpdateID = scheduler:scheduleScriptFunc(handler(self, self.updateTime), 1.0, false)
--移除
if self._schedulerUpdateID then
   scheduler:unscheduleScriptEntry(self._schedulerUpdateID)
   self._schedulerUpdateID = nil
end
--方法   
function utiltool:updateTime(dt)
   local sumTime = 24*60*60
    local curTime = string.split(os.date("%H:%M:%S", cc.globalVar.sysTime), ":")
    local leftTime = sumTime-curTime[1]*60*60-curTime[2]*60-curTime[3]
    local h = math.floor(leftTime/3600)
    local m = math.floor((leftTime%3600)/60)
    local s = math.floor(leftTime%3600)%60
    if string.len(h) == 1 then h = "0"..h end
    if string.len(m) == 1 then m = "0"..m end
    if string.len(s) == 1 then s = "0"..s end
    self.pnl_time:getChildByName("txt_time"):setString(h..":"..m..":"..s)
end
--求相差几天
function NoviceTargetTips:updateSysTims()
   local function getDays(day2, longTime2)
      local sumTime = 24*60*60
      if  longTime2 > sumTime then
	 day2 = day2 + 1
	 longTime2 = longTime2 - sumTime
	 getDays(day2, longTime2)
      else
	 day2 = day2 + 1
      end
      return day2
   end
   local function getTampDays(curSysTime, longTimes)
      local day  = 0
      local today = os.date("*t")
      local secondOfToday = os.time({day=today.day, month=today.month,
				     year=today.year, hour=0, minute=0, second=0})
      local longTime1 = curSysTime - secondOfToday
      if longTimes > longTime1 then
	 day = 1
	 longTimes = longTimes -  longTime1
      else
	 return 0
      end
      day = getDays(day, longTimes)
      return day
   end
   
   local create_time = cc.userData.createTime
   --isToday(create_time)
   local sysTime = cc.globalVar.sysTime * 1000
   local sysTime2 = cc.globalVar.sysTime
   local longTimes = (sysTime - create_time) / 1000
   self.now_days = getTampDays(sysTime2, longTimes)
   print("oooooooooooooooooooooself.now_days："..self.now_days)
   print("updateSysTims:"..self.now_days)
end

