--特殊攻击
AddStategraphPostInit("wilson", function(sg)
    local old_ATTACK = sg.actionhandlers[ACTIONS.ATTACK].deststate
    sg.actionhandlers[ACTIONS.ATTACK].deststate = function(inst, action,...)
		local weapon = inst.components.combat:GetWeapon()
        if  weapon then
            if  weapon.prefab == "kkr_elfstaff_plus" then --and weapon.components.finiteuses and weapon.components.finiteuses.current > 0  
                if  weapon:HasTag("kkratk_multithrust") and weapon:HasTag("multithrust_mode") then 
                    return "kkratk_multithrust"
                elseif weapon:HasTag("kkratk_lunge") then 
                    return "kkratk_lunge"
                end

            end
        end
        return old_ATTACK(inst, action,...)
    end
end)
AddStategraphPostInit("wilson_client", function(sg)
    local old_ATTACK = sg.actionhandlers[ACTIONS.ATTACK].deststate
    sg.actionhandlers[ACTIONS.ATTACK].deststate = function(inst, action,...)
		local weapon = inst.replica.combat:GetWeapon()
        if  weapon then
            if  weapon.prefab == "kkr_elfstaff_plus" then
                if  weapon:HasTag("kkratk_multithrust") and weapon:HasTag("multithrust_mode") then 
                    return "kkratk_multithrust"
                elseif weapon:HasTag("kkratk_lunge") then 
                    return "kkratk_lunge"
                end
            end
        end
        return old_ATTACK(inst, action,...)
    end
end)


local function DoThrust(inst, nosound)
    local weapon = inst.components.combat:GetWeapon()
    if  weapon then
        inst.components.combat:DoAttack(inst.sg.statemem.target, inst.components.combat:GetWeapon(), nil, nil, 0.66)
        if not nosound then
            inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
        end
    end
end

--连刺
AddStategraphState("wilson", 
 State{
		name = "kkratk_multithrust",
        tags = { "attack", "notalking", "abouttoattack", "autopredict" },
		onenter = function(inst)
			local target = nil 
			inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("multithrust")
            inst.Transform:SetEightFaced()
			
			if inst.bufferedaction ~= nil and inst.bufferedaction.target ~= nil and inst.bufferedaction.target:IsValid() then
                inst.sg.statemem.target = inst.bufferedaction.target
                inst.components.combat:SetTarget(inst.sg.statemem.target)
                inst:ForceFacePoint(inst.sg.statemem.target.Transform:GetWorldPosition())
				target = inst.sg.statemem.target
            end

            if target ~= nil and target:IsValid() then
                inst.sg.statemem.target = target
                inst:ForceFacePoint(target.Transform:GetWorldPosition())
            end

            inst.sg:SetTimeout(20 * FRAMES)
		end,
		timeline =
		{
			TimeEvent(7 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
				inst:PerformBufferedAction()
            end),
            TimeEvent(9 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
				-- if inst.components.combat.target then 
				-- 	inst.components.combat:DoAreaAttack(inst.components.combat.target,1.5, 
				-- 		inst.components.combat:GetWeapon(), nil, nil, { "INLIMBO" ,"companion"})
				-- end 
            end),
            -- TimeEvent(10 * FRAMES, function(inst)
			-- 	inst.sg.statemem.weapon = inst.components.combat:GetWeapon()
			-- 	inst.components.combat:DoAttack(inst.components.combat.target,inst.sg.statemem.weapon,nil,nil,0.66)
            -- end),
            TimeEvent(11 * FRAMES, function(inst)
				inst.sg.statemem.weapon = inst.components.combat:GetWeapon()
                inst:PerformBufferedAction()
                DoThrust(inst)
            end),

            TimeEvent(15 * FRAMES, DoThrust),

            TimeEvent(19 * FRAMES, function(inst)
                DoThrust(inst, true)
            end),
		},

    ontimeout = function(inst)
        inst.sg:GoToState("idle", true)
    end,

    events =
    {
        EventHandler("equip", function(inst) inst.sg:GoToState("idle") end),
        EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end),
        EventHandler("animover", function(inst)
            if inst.AnimState:AnimDone() then
                inst.sg:GoToState("idle")
            end
        end),
    },

    onexit = function(inst)
        inst.components.combat:SetTarget(nil)
        inst.Transform:SetFourFaced()
    end,
		
}
)

--划

AddStategraphState("wilson", 
 State{
		name = "kkratk_lunge",
        tags = { "attack", "notalking", "abouttoattack", "autopredict" ,"nointerrupt"},
		onenter = function(inst,data)
			local target = nil  
			inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("lunge_pst")
            inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon",nil,nil,true)
			
			
			if inst.bufferedaction ~= nil and inst.bufferedaction.target ~= nil and inst.bufferedaction.target:IsValid() then
                inst.sg.statemem.target = inst.bufferedaction.target
                inst.components.combat:SetTarget(inst.sg.statemem.target)
                inst:ForceFacePoint(inst.sg.statemem.target.Transform:GetWorldPosition())
				target = inst.sg.statemem.target
            end
			if data and data.target then 
				target = data.target
			end 
            if target ~= nil and target:IsValid() then
                inst.sg.statemem.target = target
				inst.components.combat:SetTarget(target)
                inst:ForceFacePoint(target.Transform:GetWorldPosition())
            end
			
			inst.SoundEmitter:PlaySound("dontstarve/common/lava_arena/fireball",nil,nil,true)
			inst.components.bloomer:PushBloom("lunge", "shaders/anim.ksh", -2)
            inst.components.colouradder:PushColour("lunge", 1, 1, 0.2, 0)
			inst.sg.statemem.flash = 0.8
            inst.sg:SetTimeout(8 * FRAMES)

		end,
		
		onupdate = function(inst)
            if inst.sg.statemem.flash and inst.sg.statemem.flash > 0 then
                inst.sg.statemem.flash = math.max(0, inst.sg.statemem.flash - .1)
                inst.components.colouradder:PushColour("lunge", inst.sg.statemem.flash, inst.sg.statemem.flash,0, 0)
            end
        end,
		
		timeline =
		{
			TimeEvent(2 * FRAMES, function(inst)
				
                inst:PerformBufferedAction()
				
				if inst.components.combat.target then 
					inst.components.combat:DoAreaAttack(inst.components.combat.target,1.5, 
						inst.components.combat:GetWeapon(), nil, nil, { "INLIMBO","companion" })
				end 
				inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon", nil, nil, true)
            end),
			
			TimeEvent(7 * FRAMES, function(inst)
                inst.components.bloomer:PopBloom("lunge")
            end),
		},

    ontimeout = function(inst)
        inst.sg:GoToState("idle", true)
    end,

    events =
    {
        EventHandler("equip", function(inst) inst.sg:GoToState("idle") end),
        EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end),
        EventHandler("animover", function(inst)
            if inst.AnimState:AnimDone() then
                inst.sg:GoToState("idle")
            end
        end),
        
    },

    onexit = function(inst)
        inst.components.combat:SetTarget(nil)
		inst.components.bloomer:PopBloom("lunge")
        inst.components.colouradder:PopColour("lunge")
    end,
		
}
)

----------客机部分---------
--前刺

AddStategraphState("wilson_client", 
 State{
		name = "kkratk_multithrust",
        tags = { "attack", "notalking", "abouttoattack", "autopredict" },
		onenter = function(inst)
            local buffaction = inst:GetBufferedAction()
			local target = buffaction ~= nil and buffaction.target or nil
			if inst.replica.combat ~= nil then
				inst.replica.combat:StartAttack()
			end
			inst.components.locomotor:Stop()
			inst.Transform:SetEightFaced()
			if target ~= nil then
				inst.AnimState:PlayAnimation("multithrust")
				if buffaction ~= nil then
					inst:PerformPreviewBufferedAction()
					if buffaction.target ~= nil and buffaction.target:IsValid() then
						inst:FacePoint(buffaction.target:GetPosition())
						inst.sg.statemem.attacktarget = buffaction.target
					end
				end
				inst.sg:SetTimeout(20 * FRAMES)
			end 
		end,
		timeline =
		{
			TimeEvent(7 * FRAMES, function(inst)
				inst:ClearBufferedAction()
				 inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
            end),
            TimeEvent(9 * FRAMES, function(inst)
				inst:ClearBufferedAction()
				inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
            end),
            TimeEvent(11 * FRAMES, function(inst)
                inst:ClearBufferedAction()
				inst.sg:RemoveStateTag("abouttoattack")
            end),
            TimeEvent(19 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("nointerrupt")
            end),
		},

    ontimeout = function(inst)
		inst.sg:RemoveStateTag("abouttoattack")
        inst.sg:RemoveStateTag("attack")
        inst.sg:AddStateTag("idle")
        inst.sg:GoToState("idle", true)
    end,

    events =
    {
        EventHandler("animqueueover", function(inst)
            if inst.AnimState:AnimDone() then
                inst.sg:GoToState("idle")
            end
        end),
    },

    onexit = function(inst)
        inst.Transform:SetFourFaced()
		if inst.sg:HasStateTag("abouttoattack") and inst.replica.combat ~= nil then
            inst.replica.combat:CancelAttack()
        end
    end,
		
}
)

--划

AddStategraphState("wilson_client", 
 State{
		name ="kkratk_lunge",
        tags = { "attack", "notalking", "abouttoattack", "autopredict","nointerrupt" },
		onenter = function(inst,data)
        local buffaction = inst:GetBufferedAction()
		local target = (buffaction ~= nil and buffaction.target) or (data and data.target) or nil 
        if inst.replica.combat ~= nil then
            inst.replica.combat:StartAttack()
        end
        inst.components.locomotor:Stop()
        
		if target ~= nil then
			inst:ForceFacePoint(target:GetPosition():Get())
			inst.AnimState:PlayAnimation("lunge_pst")
			inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon",nil,nil,true)
			inst.SoundEmitter:PlaySound("dontstarve/common/lava_arena/fireball",nil,nil,true)
			if buffaction ~= nil then
				inst:PerformPreviewBufferedAction()
				if buffaction.target ~= nil and buffaction.target:IsValid() then
					inst.sg.statemem.attacktarget = buffaction.target
				end
			end
			inst.sg:SetTimeout(8 * FRAMES)
		end 

		end,
		timeline =
		{
			TimeEvent(2 * FRAMES, function(inst)
                inst:ClearBufferedAction()
				inst.sg:RemoveStateTag("abouttoattack")
				inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon", nil, nil, true)
            end),
		},

    ontimeout = function(inst)
		inst.sg:RemoveStateTag("abouttoattack")
        inst.sg:RemoveStateTag("attack")
        inst.sg:AddStateTag("idle")
        inst.sg:GoToState("idle", true)
    end,

    events =
    {
        EventHandler("animqueueover", function(inst)
            if inst.AnimState:AnimDone() then
                inst.sg:GoToState("idle")
            end
        end),
    },

	onexit = function(inst)
        if inst.sg:HasStateTag("abouttoattack") and inst.replica.combat ~= nil then
            inst.replica.combat:CancelAttack()
        end
    end,
}
)
