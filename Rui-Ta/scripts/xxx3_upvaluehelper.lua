local visit = {}    
local visitnum = 0
local function TryToClose(name,value,level)
    if name  or value then      
        visit = {}
        visitnum = 0
        return value
    end
    if level == 1 then          
        visit = {}
        visitnum = 0
    end
end
local function Get(fn,name,file)	
    local level = visitnum + 1
	if type(fn) ~= "function" then TryToClose(nil,nil,level) return end
    if visit[fn] then TryToClose(nil,nil,level) return end      
    visit[fn] = 1
    visitnum = visitnum + 1
    local i = 1
	while true do
		local upname,upvalue = debug.getupvalue(fn,i)
        if not upname then break end    
		if upname and upname == name then
			if file and type(file) == "string" then			
				local fninfo = debug.getinfo(fn)
				if fninfo.source and fninfo.source:match(file) then
					return TryToClose(upname,upvalue,level)
				end
			else
				return TryToClose(upname,upvalue,level)
			end
		end
		if upvalue and type(upvalue) == "function" and not visit[upvalue] then  
			local upupvalue  = Get(upvalue,name,file) 
			if upupvalue then return TryToClose(name,upupvalue,level) end
		end
        i = i + 1
	end
    TryToClose(nil,nil,level)   
end

local function Set(fn,name,set,file)
    local level = visitnum + 1
    if type(fn) ~= "function" then TryToClose(nil,nil,level) return end
    if visit[fn] then TryToClose(nil,nil,level) return end      
    visit[fn] = 1
    visitnum = visitnum + 1
    local i = 1
	while true do
		local upname,upvalue = debug.getupvalue(fn,i)
        if not upname then break end    
		if upname and upname == name then
			if file and type(file) == "string" then			
				local fninfo = debug.getinfo(fn)
				if fninfo.source and fninfo.source:match(file) then
					return TryToClose(debug.setupvalue(fn,i,set),nil,level)
				end
			else
				return TryToClose(debug.setupvalue(fn,i,set),nil,level)
			end
		end
		if upvalue and type(upvalue) == "function" and not visit[upvalue] then
			local upupvalue  = Set(upvalue,name,set,file) 
			if upupvalue then return TryToClose(upupvalue,nil,level) end
		end
        i = i + 1
	end
    TryToClose(nil,nil,level)   
end

local function FunctionTest(fn,file,test,source,listener)
	if fn and type(fn) ~= "function" then return false end
	local data = debug.getinfo(fn)
	if file and type(file) == "string" then		
		local matchstr = "/"..file..".lua" 
		if not data.source or not data.source:match(matchstr) then
			return false
		end
	end
	if test and type(test) == "function" and  not test(data,source,listener) then return false end	
	return true
end

local function GetEventHandle(inst,event,file,test)
	if type(inst) == "table" then
		if inst.event_listening and inst.event_listening[event] then		
			local listenings = inst.event_listening[event]
			for listening,fns in pairs(listenings) do		
				if fns and type(fns)=="table" then
					for _,fn in pairs(fns) do
						if FunctionTest(fn,file,test,listening,inst) then	
							return fn
						end
					end
				end
			end
		end
	
	
		if inst.event_listeners and inst.event_listeners[event] then	
			local listeners = inst.event_listeners[event]
			for listener,fns in pairs(listeners) do		
				if fns and type(fns)=="table" then
					for _,fn in pairs(fns) do
						if FunctionTest(fn,file,test,inst,listener) then	
							return fn
						end
					end
				end
			end
		end
	end
end


return {
	Get = Get,
	Set = Set,
	GetEventHandle = GetEventHandle,
}