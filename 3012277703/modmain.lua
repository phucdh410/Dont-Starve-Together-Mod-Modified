local SetSelection
local ResetTask
local RehitTask
local PreviousTarget

local KeyBinds = {
	GetModConfigData("SETBIND1"),
	GetModConfigData("SETBIND2"),
}

local AttackList = {
	["dart_pre"] = 3,
	["slingshot_pre"] = 3,
	["throw_pre"] = 6,
	["atk_pre"] = 9,
	["spearjab_pre"] = 9,
    ["punch"] = 9,
	["toolpunch"] = 9,
    ["pocketwatch_atk_pre"] = 11,
    ["pocketwatch_atk_pre_2"] = 11,
    ["whip_pre"] = 11,
}

local function EquipItem(item)
	if not GLOBAL.TheInput:IsKeyDown(GLOBAL.KEY_LSHIFT) then
		GLOBAL.ThePlayer.replica.inventory:UseItemFromInvTile(item)
	end
end

local function FindNextSetID()
	local SetList = SetSelection:GetSet()
	local hands = GLOBAL.ThePlayer.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS)
	if hands then 
		local Eqp = hands.replica.inventoryitem
		if SetList[0][0] == Eqp then return 1 end
		if SetList[1][0] == Eqp then return 0 end
	end
	local body = GLOBAL.ThePlayer.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.BODY)
	if body then 
		local Eqp = body.replica.inventoryitem
		if SetList[0][1] == Eqp then return 1 end
		if SetList[1][1] == Eqp then return 0 end
	end
	local head = GLOBAL.ThePlayer.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HEAD)
	if head then 
		local Eqp = head.replica.inventoryitem
		if SetList[0][2] == Eqp then return 1 end
		if SetList[1][2] == Eqp then return 0 end
	end
	return 0 
end


local function EquipSet()
	local SetList = SetSelection:GetSet()
	local NextID = FindNextSetID()
	for k = 0, 2 do
			if SetList[NextID][k] and SetList[NextID][k].classified then
				EquipItem(SetList[NextID][k].inst)
			else
				if SetList[(NextID+1)%2][k] and SetList[(NextID+1)%2][k].classified then
					EquipItem(SetList[(NextID+1)%2][k].inst)
				end
			end
	end
end

local function EquipInstantSet(InstantSet)
	if InstantSet then
		local hands = GLOBAL.ThePlayer.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS)
		if hands then 
			local Eqp = hands.replica.inventoryitem
			if InstantSet[0] and InstantSet[0] ~= Eqp then 
				EquipItem(InstantSet[0].inst)
			end
		elseif InstantSet[0] and InstantSet[0] ~= Eqp then 
				EquipItem(InstantSet[0].inst)
		end
		local body = GLOBAL.ThePlayer.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.BODY)
		if body then 
			local Eqp = body.replica.inventoryitem
			if InstantSet[1] and InstantSet[1] ~= Eqp then 
				EquipItem(InstantSet[1].inst)
			end
		elseif InstantSet[1] and InstantSet[1] ~= Eqp then 
				EquipItem(InstantSet[1].inst)
		end
		local head = GLOBAL.ThePlayer.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HEAD)
		if head then 
			local Eqp = head.replica.inventoryitem
			if InstantSet[2] and InstantSet[2] ~= Eqp then 
				EquipItem(InstantSet[2].inst)
			end
		elseif InstantSet[2] and InstantSet[2] ~= Eqp then 
				EquipItem(InstantSet[2].inst)
		end
	end
end

local function GetGears()
	local Active = GLOBAL.ThePlayer.replica.inventory:GetActiveItem()
	if Active and Active.replica.equippable then 
		return true 
		end
	return false
end


local function CanAttack(target)
    local combat = GLOBAL.ThePlayer.replica.combat
	if combat.classified ~= nil then
        if not combat:IsValidTarget(target) then
            return false
        end
        local range = math.max(0, target:GetPhysicsRadius(0) + combat:GetAttackRangeWithWeapon())
        return GLOBAL.distsq(target:GetPosition(), combat.inst:GetPosition()) <= range * range
    else
        return false
    end
end

AddComponentPostInit(
    "playercontroller",
    function(playercontroller, player)
        if player ~= GLOBAL.ThePlayer then
            return
        end
        local old_GetAttackTarget = playercontroller.GetAttackTarget

        playercontroller.GetAttackTarget = function(self, force_attack, force_target, isretarget, use_remote_predict)
            local TargetAqquire = old_GetAttackTarget(self, force_attack, force_target, isretarget, use_remote_predict)
			PreviousTarget = TargetAqquire or PreviousTarget
			return TargetAqquire
        end
    end
)

local function SendAttackSignal(Target)
	local ForcedAttack = GLOBAL.TheInput:IsControlPressed(GLOBAL.CONTROL_FORCE_ATTACK)
	local px,py,pz = GLOBAL.ThePlayer:GetPosition():Get()
	GLOBAL.SendRPCToServer(GLOBAL.RPC.AttackButton, Target, ForcedAttack)
end

local function GetDecentTarget()

	local Combat = GLOBAL.ThePlayer.replica.combat
	local MainTarget = Combat:GetTarget()
	if MainTarget and CanAttack(MainTarget) then
		return MainTarget
	end
	
	local reTarget = GLOBAL.ThePlayer.components.playercontroller:GetAttackTarget(GLOBAL.TheInput.IsControlPressed,MainTarget,MainTarget~=nil)
	if reTarget and CanAttack(reTarget) then
		return reTarget
	end
	
	if PreviousTarget and CanAttack(PreviousTarget) then
		return PreviousTarget
	end
end

local function ReHit()

	if ResetTask then
		ResetTask:Cancel()
		ResetTask = nil
	end
	
	local TheTarget = GetDecentTarget()
	SendAttackSignal(TheTarget)
end

local function ReHitTask()
	if RehitTask then
		RehitTask:Cancel()
		RehitTask = nil
	end
	RehitTask = GLOBAL.ThePlayer:DoTaskInTime(GLOBAL.FRAMES,ReHit)
end

local function SwitchActiveGear()
	if  GetGears() then
		GLOBAL.ThePlayer.replica.inventory:SwapEquipWithActiveItem()
		ReHitTask()
	else
		EquipSet()
		ReHitTask()
	end
end

local function AttackRecord(inst)
	--local Debug = GLOBAL.ThePlayer:GetDebugString()
	--local ziplocate = string.find(Debug,".zip")
	--local FirstSpace = string.find(Debug,":",ziplocate)
	--local EndSpace = string.find(Debug," ",FirstSpace + 1)
	--local Animation = string.sub(Debug,FirstSpace,EndSpace)
	--GLOBAL.ThePlayer.components.talker:Say(Animation)
	--print(Animation)
	if SetSelection~=nil and SetSelection:IsActivated() then
		if inst.AnimState:IsCurrentAnimation("hit") and ResetTask and GLOBAL.TheInput:IsKeyDown(GLOBAL.KEY_F) then
			ResetTask:Cancel()
			ResetTask = nil
			ReHitTask()
			return
		end
		
		if not ResetTask and GLOBAL.TheInput:IsKeyDown(GLOBAL.KEY_F) then
			for animate, eFrame in pairs(AttackList) do
				if inst.AnimState:IsCurrentAnimation(animate) then
					local CurrentFrame = inst.AnimState:GetCurrentAnimationFrame()
					if (animate == "punch" or animate == "toolpunch") and CurrentFrame > 3 then return end			
					--print("Current animation: "..animate.." Current frame:"..tostring(CurrentFrame))
					local PingD = GLOBAL.TheNet:GetAveragePing()/2000
					local TotalDelay = GLOBAL.FRAMES*(eFrame-SetSelection:GetRate()-CurrentFrame) - PingD
					ResetTask = inst:DoTaskInTime(TotalDelay,SwitchActiveGear)
					return
				end
			end
		end
	end
end

AddComponentPostInit(
    "playercontroller",
    function(self, inst)
        if inst ~= GLOBAL.ThePlayer then
            return
        end
		
        
    end
)

local function InGame()
    return GLOBAL.ThePlayer and GLOBAL.ThePlayer.HUD and not GLOBAL.ThePlayer.HUD:HasInputFocus() and SetSelection~=nil and SetSelection:IsActivated()
end

AddPlayerPostInit(function(inst)
	inst:DoTaskInTime(
	GLOBAL.FRAMES,
	function()
		if inst == GLOBAL.ThePlayer then
			SetSelection = GLOBAL.ThePlayer.HUD.controls.bottom_root:AddChild(GLOBAL.require("widgets/setselection")(inst))
			local KeyData = {
				[3] = KeyBinds,
			}
			SetSelection:Install(1,KeyData)
			inst:DoPeriodicTask(GLOBAL.FRAMES, AttackRecord)
			
			GLOBAL.TheInput:AddKeyUpHandler(GLOBAL.KEY_F, function() 
				if ResetTask then 
					ResetTask:Cancel()
					ResetTask= nil
				end
			end)
			
			local pressedF = false
			GLOBAL.TheInput:AddKeyDownHandler(GLOBAL.KEY_F, function()
				if not InGame() then return end
				local CurrentID = (FindNextSetID() + 1)%2
				if SetSelection:GetIsSwap() and not pressedF then
					EquipInstantSet(SetSelection:GetCurrentSet(CurrentID))
				end
				pressedF = true
			end)
			GLOBAL.TheInput:AddKeyUpHandler(GLOBAL.KEY_F, function()
				if not InGame() then return end
				pressedF = false
			end)
			
			local Tkey = -1
			if type(KeyBinds[1]) == "string" and GLOBAL:rawget(KeyBinds[1]) then
				Tkey = GLOBAL[KeyBinds[1]]
			end
			Tkey = type(Tkey) == "number" and Tkey or -1
			
			GLOBAL.TheInput:AddKeyDownHandler(Tkey, function()
				if not InGame() then return end
				local InstantSet = SetSelection:GetInstantSet(1)
				EquipInstantSet(InstantSet)
			end)
			
			local Fkey = -1
			if type(KeyBinds[2]) == "string" and GLOBAL:rawget(KeyBinds[2]) then
				Fkey = GLOBAL[KeyBinds[2]]
			end
			Fkey = type(Fkey) == "number" and Fkey or -1
			
			GLOBAL.TheInput:AddKeyUpHandler(Fkey, function()
				--print("unpressed F")
				if not InGame() then return end
				local InstantSet = SetSelection:GetInstantSet(0)
				EquipInstantSet(InstantSet)
			end)

		end
	end)
end)

