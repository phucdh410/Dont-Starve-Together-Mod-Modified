local tradabletable = {'walrus_tusk','bluegem','goldnugget','purebrilliance','lunarplant_husk'}
if  TheNet:GetIsServer() then
    for _, v in ipairs(tradabletable) do
        AddPrefabPostInit(v, function(inst)
            if  inst.components.tradable == nil then
                inst:AddComponent("tradable") -- 可交易
            end
        end)
    end

end

AddIngredientValues({"kkr_dragon_meat"}, { -- 龙尾肉
    meat = 1 -- 1点肉度
})

--让缝纫包可以修复可可萝的护甲
AddComponentPostInit("sewing", function(sewing)
    local OldDoSewing = sewing.DoSewing
    
	sewing.DoSewing = function(self, target, doer)
        if not sewing.oldrepair_value then
            sewing.oldrepair_value = sewing.repair_value
        end

        if doer:HasTag("kkr") then
            self.repair_value = self.oldrepair_value * 2
        else
            self.repair_value = self.oldrepair_value
        end
		if  target:HasTag("kkr_sewing") then
			if target.components.armor then
                target.components.armor.condition = target.components.armor.condition + target.components.armor.maxcondition * 0.6
                target.components.armor:SetPercent(target.components.armor:GetPercent(target.components.armor.condition))
                if target.components.armor.condition > target.components.armor.maxcondition then
                    target.components.armor.condition = target.components.armor.maxcondition
                end
            end

            if self.inst.components.finiteuses then
                self.inst.components.finiteuses:Use(1)
            elseif self.inst.components.stackable then
                self.inst.components.stackable:Get(1):Remove()
            end

            if self.onsewn then
                self.onsewn(self.inst, target, doer)
            end

            AwardPlayerAchievement("sewing_kit", doer)

		    return true
        else
            return OldDoSewing(self, target, doer)
		end
		
	end
end)

--对话作物回san，减少作物压力值
AddComponentPostInit("farmplanttendable", function(farmplanttendable)
    local OldTendTo = farmplanttendable.TendTo
	farmplanttendable.TendTo = function(self, doer)
		if doer and doer:HasTag("kkr") then
            if doer.components.sanity then
                doer.components.sanity:DoDelta(3)
            end
            
            if self.inst.components.farmplantstress ~= nil then
                self.inst.components.farmplantstress.stress_points = math.max(0, self.inst.components.farmplantstress.stress_points - 1)
            end
        end
        return OldTendTo(self, doer)
	end
end)

--双倍浇水
AddComponentPostInit("wateryprotection", function(wateryprotection)
    local OldSpreadProtectionAtPoint = wateryprotection.SpreadProtectionAtPoint
    
	wateryprotection.SpreadProtectionAtPoint = function(self, x, y, z, dist, noextinguish)
        -- if not wateryprotection.oldaddwetness then
        --     wateryprotection.oldaddwetness = wateryprotection.addwetness
        -- end
        local oldaddwetness = wateryprotection.addwetness
        if self.inst:HasTag("wateringcan") then
            if self.inst.components.inventoryitem then
                local owner = self.inst.components.inventoryitem.owner
                if owner and owner:HasTag("kkr") then
                    self.addwetness = oldaddwetness * 2
                end
            end
            
        end
        local result = OldSpreadProtectionAtPoint(self, x, y, z, dist, noextinguish)
        self.addwetness = oldaddwetness
        return result
	end
end)

--双倍施肥
local OldMakeDeployableFertilizer = _G.MakeDeployableFertilizer
_G.MakeDeployableFertilizer = function (inst)
    OldMakeDeployableFertilizer(inst)
    local oldOnDeploy = inst.components.deployable.ondeploy
    inst.components.deployable.ondeploy = function(inst, pt, deployer)
        if deployer ~= nil and deployer:HasTag("kkr") then
            local tile_x, tile_z = TheWorld.Map:GetTileCoordsAtPoint(pt:Get())
            local nutrients = inst.components.fertilizer.nutrients
            TheWorld.components.farming_manager:AddTileNutrients(tile_x, tile_z, nutrients[1], nutrients[2], nutrients[3])
 
        end
        oldOnDeploy(inst, pt, deployer)
    end
end


--护盾(不用原版铥矿头的逻辑了，不然一个物品既有使用次数有护甲会导致耐久显示有问题)
AddComponentPostInit("inventory", function(inventory)
    local ApplyDamage = inventory.ApplyDamage
	inventory.ApplyDamage = function(self, damage, attacker, weapon, spdamage)
		if self.inst.components.inventory and self.inst.components.inventory:EquipHasTag('kkr_forcefield') then
            damage = 0
        end
        return ApplyDamage(self, damage, attacker, weapon, spdamage)
	end
end)

--烹饪时间减半,概率双倍锅
local cooking = require("cooking")
AddComponentPostInit("stewer", function(stewer)
    local OldStartCooking = stewer.StartCooking
    
    stewer.StartCooking = function(self, doer)
        -- if not stewer.oldcooktimemult then
        --     stewer.oldcooktimemult = stewer.cooktimemult
        -- end
        local oldcooktimemult =  stewer.cooktimemult
        
        if doer ~= nil and doer:HasTag("kkr") then
            self.cooktimemult = oldcooktimemult / 2
        end
        local result = OldStartCooking(self, doer)
        self.cooktimemult = oldcooktimemult
        return result
    end

    local OldHarvest = stewer.Harvest
    stewer.Harvest = function(self, picker, ...)
        if not picker then return OldHarvest(self, picker, ...) end
        local rec = cooking.GetRecipe(self.inst.prefab, self.testproduct)
        local sta = rec and rec.stacksize or 1
        if self.done and picker:HasTag("kkr") and math.random() <= 0.2 then
            if self.product ~= nil then
                local loot = GLOBAL.SpawnPrefab(self.product)
                if  loot ~= nil then
                    if sta > 1 then
                        loot.components.stackable:SetStackSize(sta)
                    end
                    if picker ~= nil and picker.components.inventory ~= nil then
                        picker.components.inventory:GiveItem(loot, nil, self.inst:GetPosition())
                    else
                        GLOBAL.LaunchAt(loot, self.inst, nil, 1, 1)
                    end
                end
            end
        end
        return OldHarvest(self, picker)
    end
end)

--烤制食物概率多一份
AddComponentPostInit("cooker", function(cooker)
    local OldCookItem = cooker.CookItem
    cooker.CookItem = function(self, item, chef)

        local newitem = OldCookItem(self, item, chef)

        if math.random() <= 0.2 and chef:HasTag("kkr") then
            local extraItem = SpawnPrefab(newitem.prefab)
            if extraItem ~= nil and chef.components.inventory ~= nil then
                chef.components.inventory:GiveItem(extraItem)
            end
        end

        return newitem
    end
end)


--雇佣时间翻倍，雇佣的时候清一个诅咒
AddComponentPostInit("follower", function(follower)
    local OldAddLoyaltyTime = follower.AddLoyaltyTime
    follower.AddLoyaltyTime = function(self, time)
        local leader = self.leader
        if leader and leader:HasTag("kkr") then
            time = time * 2
            if leader.components.inventory then
                if leader.components.inventory:HasItemWithTag("monkey_token", 1) then
                    if leader.components.cursable then
                        leader.components.cursable:RemoveCurse('MONKEY', 1)
                    end
                end
            end
        end

        return OldAddLoyaltyTime(self, time)
    end
end)

AddPrefabPostInit("pigman", function (inst)
    if inst.components.trader and inst.components.trader.test then
        local oldtest = inst.components.trader.test
        inst.components.trader.test = function (inst, item, giver, ...)
            if giver and giver:HasTag("kkr") and (item.prefab == "monstermeat" or item.prefab == "cookedmonstermeat" or item.prefab == "monstermeat_dried") then
                return true
            else
                if oldtest then
                    return oldtest(inst, item, giver, ...)
                end
            end
        end
    end
end)

--喂食玩家可以恢复双方10点san值，并移除2个猴子诅咒
local OldFeedPlayerFn = ACTIONS.FEEDPLAYER.fn
ACTIONS.FEEDPLAYER.fn = function(act, ...)
    if act.target and act.target:IsValid() then
        if act.doer and act.doer.components.inventory then

            if act.doer:HasTag("kkr") then
                --双方回san
                if act.doer.components.sanity then
                    act.doer.components.sanity:DoDelta(10)
                end
                if act.target.components.sanity then
                    act.target.components.sanity:DoDelta(10)
                end

                --双方移除猴子诅咒
                if act.doer.components.inventory then
                    if act.doer.components.inventory:HasItemWithTag("monkey_token", 1) then
                        if act.doer.components.cursable then
                            act.doer.components.cursable:RemoveCurse('MONKEY', 2)
                        end
                    end
                end
                if act.target.components.inventory then
                    if act.target.components.inventory:HasItemWithTag("monkey_token", 1) then
                        if act.target.components.cursable then
                            act.target.components.cursable:RemoveCurse('MONKEY', 2)
                        end
                    end
                end
            end

        end
    end
    return OldFeedPlayerFn(act, ...)
end

--喂食动物移除一个猴子诅咒
local OldFeedFn = ACTIONS.FEED.fn
ACTIONS.FEED.fn = function(act, ...)
    if act.target and act.target:IsValid() then
        if act.doer and act.doer.components.inventory then

            if act.doer:HasTag("kkr") then

                --移除猴子诅咒
                if act.doer.components.inventory then
                    if act.doer.components.inventory:HasItemWithTag("monkey_token", 1) then
                        if act.doer.components.cursable then
                            act.doer.components.cursable:RemoveCurse('MONKEY', 1)
                        end
                    end
                end
            end

        end
    end
    return OldFeedFn(act, ...)
end

--霸体（关东煮）
AddStategraphPostInit(
    'wilson',
    function(sg)
        if sg.events and sg.events.attacked then
            local oldattackedfn = sg.events.attacked.fn
            sg.events.attacked.fn = function(inst, data)
                if inst:HasDebuff("kkr_kantostyle_stew_debuff") then
                    return
                elseif oldattackedfn then
                    return oldattackedfn(inst, data)
                end
            end
        end
    end
)


AddComponentPostInit("health", function(self)
    --防火相关,就不用原版的方式了，不然还得判断几下
    local oldGetFireDamageScale = self.GetFireDamageScale
    self.GetFireDamageScale = function (s,...)
        if  not s.inst:HasTag("player") then
            return oldGetFireDamageScale(self, ...)
        end
        return s.inst and s.inst:HasTag("sea_snowsugar") and 0 or oldGetFireDamageScale(self, ...)
    end

    --免疫一次致命伤害(大地仙人掌蜜汁松饼)
    local oldDoDelta = self.DoDelta
    self.DoDelta = function(self, amount, overtime, cause, ignore_invincible, afflicter, ignore_absorb,...)
        if amount < 0 and self.currenthealth <= -amount then
            if self.inst.kkr_cactus_pancake == true then
                local shieldfx = SpawnPrefab('abigailforcefieldbuffed')
                shieldfx.Transform:SetScale(0.6, 0.6, 0.6)
                shieldfx.AnimState:SetAddColour(0 / 255, 255 / 255, 255 / 255, 1)
                shieldfx.AnimState:SetMultColour(204 / 255, 255 / 255, 255 / 255, 0.5)
                shieldfx.entity:SetParent(self.inst.entity)
                amount = 0
                self.inst.kkr_cactus_pancake = nil
            end
            
        end
		return oldDoDelta(self, amount, overtime, cause, ignore_invincible, afflicter, ignore_absorb,...)
	end
    
end)

--免疫冰冻(沧海淡雪糖)
AddComponentPostInit("freezable", function(self)
    local OldAddColdness = self.AddColdness
	self.AddColdness = function(s,...)
		if  self.inst and s.inst:HasTag('sea_snowsugar') then
			return false
		end
		return OldAddColdness(s,...)
	end
    local OldFreeze = self.Freeze
    self.Freeze = function(self, freezetime, ...)
        if self.inst and self.inst:HasTag('sea_snowsugar') then
            return
        end
        return OldFreeze(self, freezetime, ...)
    end
end)

--免疫睡眠(沧海淡雪糖)
AddComponentPostInit("grogginess", function(self)
    for k, v in pairs({"AddGrogginess", "GoToSleep"}) do
        local old = self[v]
        self[v] = function(s, ...)
            local inst = s.inst
            if inst and inst:HasTag("player") and inst:HasTag('sea_snowsugar') then
                return
            end
            return old(s, ...)
        end
    end
end)

AddStategraphPostInit("wilson", function(sg)
    if sg.events and sg.events['yawn'] then
        local old = sg.events['yawn'].fn
        sg.events['yawn'].fn = function(inst, ...)
            if  inst and inst:HasTag("player") and inst:HasTag('sea_snowsugar') then
                return true
            end
            return old(inst, ...)
        end
    end
end)

local states = {
    "run_start","run","run_stop","idle"
}
local nofn = function () end
AddStategraphPostInit("wilson", function(self)
    for _, name in ipairs(states) do
        local state = self.states[name]
        if  state then
            local old_entar = state.onenter or nofn
            state.onenter = function (inst,...)
                old_entar(inst,...)
                if  inst:HasTag("kkr_fly") then
                    inst.AnimState:PlayAnimation("kkr_fly",true)
                end
            end
        end
    end
end)

AddStategraphPostInit("wilson_client", function(self)
    for _, name in ipairs(states) do
        local state = self.states[name]
        if  state then
            local old_entar = state.onenter or nofn
            state.onenter = function (inst,...)
                old_entar(inst,...)
                if  inst:HasTag("kkr_fly") then
                    inst.AnimState:PlayAnimation("kkr_fly",true)
                end
            end
        end
    end
end)

local while_state = {"run","run_start","run_stop","idle","hop_pre","hop_loop","talk"} --飞行中不会掉下来的动作
local exclude_state = {"funnyidle","talk","item_hat","item_in","item_out"} --飞行中不会进入新状态的动作
local function onnewstate(inst,data)
    
	if  inst.components.kkrfly:IsFly() and not table.contains(while_state,data.statename)   then
        inst.components.kkrfly:Land()
    end
end

if  TheNet:GetIsServer() then
    AddPrefabPostInit("kkr", function(inst)
        inst:ListenForEvent("newstate",onnewstate)
    end)
end

AddGlobalClassPostConstruct("stategraph","StateGraphInstance", function(self)
    if  self.inst:HasTag("kkr") then
        local oldGoToState = self.GoToState
        self.GoToState = function (s,statename, params,...)
            if  self.inst:HasTag("kkr_fly") and table.contains(exclude_state,statename) then
                return
            end
            return oldGoToState(s,statename, params,...)
        end
    end
end)

--飞行无脚步声
local oldPlayFootstep = _G.PlayFootstep
_G.PlayFootstep = function (inst, volume, ispredicted)
    if inst and inst:HasTag("kkr_fly") then
        return
    else
        return oldPlayFootstep(inst, volume, ispredicted)
    end
end

--飞行不滑倒
AddComponentPostInit("slipperyfeet", function(self)
    local oldDodelta = self.DoDelta
    self.DoDelta = function (self, delta)
        if self.inst.components.kkrfly and self.inst.components.kkrfly.kkr_fly == true then
            self:SetCurrent(0)
            return
        else
            oldDodelta(self, delta)
        end
    end

end)

-- 飞行上船问题
AddComponentPostInit("locomotor", function(self)

    local oldStarthopping = self.StartHopping
    self.StartHopping = function (self,x,z,target_platform)
        if self.inst.components.kkrfly and self.inst.components.kkrfly.kkr_fly == true then
            return
        else
            oldStarthopping(self,x,z,target_platform)
        end
    end

end)

