GLOBAL.setmetatable(GLOBAL.getfenv(1), {__index = function(self, index)
	return GLOBAL.rawget(GLOBAL, index)
end})

--冲刺，梳妆台问题，大象返生问题，象鼻背心上牛
--原武击剑bug
--露西抛出，月后头盔免疫月圆，鹿平衡

PrefabFiles = {
 "koalebeef_summer",
 "koalebeef_winter",
 "koalebeef_summer_bell",
 "koalebeef_winter_bell",
}
local require = GLOBAL.require

local UpvalueHacker = require("tools/upvaluehacker3")
local writeables = require("writeables")
local kinds = UpvalueHacker.GetUpvalue(writeables.makescreen, "kinds")

local beefalo_names 
local myprompt 
local mycancel 
local mymiddle
local myaccept
beefalo_names = {
	"滑稽",
	"编名字好累",
	"牛排",
	"雨落枫台",
	"牢白",
	"尘",
	"尘虵",
	"老祥瑞",
	"肉块",
	"土豆之神",
	"胖球",
	"斑羚 飞渡",
	"血蹄",
	"卡特",
	"已格式化",
	"刚角",
	"里脊肉",
	"咬人猪",
	"从册",
	"六花",
	"Alt",
	"用释然接受不能避免的结果取代了存在的绝望",
	"鱼香肉丝",
	"秋风",
}
myprompt = "想给你的牛起个什么名?"
mycancel = "取消"
mymiddle = "随机"
myaccept = "命名"

kinds.koalebeef_summer = {
    prompt = myprompt,
    animbank = "ui_board_5x3",
    animbuild = "ui_board_5x3",
    menuoffset = GLOBAL.Vector3(6, -70, 0),
	maxcharacters = GLOBAL.TUNING.BEEFALO_NAMING_MAX_LENGTH,
	
    defaulttext = function(inst, doer)
        return "友好考拉象"
    end,
	
    cancelbtn = { text = mycancel, cb = nil, control = GLOBAL.CONTROL_CANCEL },
    middlebtn = { text = mymiddle, cb = function(inst, doer, widget)
            widget:OverrideText( beefalo_names[math.random(#beefalo_names)] )
        end, control = GLOBAL.CONTROL_MENU_MISC_2 },
    acceptbtn = { text = myaccept, cb = nil, control = GLOBAL.CONTROL_ACCEPT },
}
kinds.koalebeef_winter = {
    prompt = myprompt,
    animbank = "ui_board_5x3",
    animbuild = "ui_board_5x3",
    menuoffset = GLOBAL.Vector3(6, -70, 0),
	maxcharacters = GLOBAL.TUNING.BEEFALO_NAMING_MAX_LENGTH,
	
    defaulttext = function(inst, doer)
        return "友好考拉象"
    end,
	
    cancelbtn = { text = mycancel, cb = nil, control = GLOBAL.CONTROL_CANCEL },
    middlebtn = { text = mymiddle, cb = function(inst, doer, widget)
            widget:OverrideText( beefalo_names[math.random(#beefalo_names)] )
        end, control = GLOBAL.CONTROL_MENU_MISC_2 },
    acceptbtn = { text = myaccept, cb = nil, control = GLOBAL.CONTROL_ACCEPT },
}



GLOBAL.STRINGS.NAMES.KOALEBEEF_SUMMER = "友好考拉象"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.KOALEBEEF_SUMMER = "这只大象跟我建立了友谊，不再害怕我了。"
GLOBAL.STRINGS.CHARACTERS.WILLOW.DESCRIBE.KOALEBEEF_SUMMER = "哈哈，你不怕我烧你？就因为我给了你一口吃的？"
GLOBAL.STRINGS.CHARACTERS.WENDY.DESCRIBE.KOALEBEEF_SUMMER = "我轻而易举的获得了这个生物的信任，它真傻。"
GLOBAL.STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.KOALEBEEF_SUMMER = "沃尔夫冈跟小象建立了友谊！"
GLOBAL.STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.KOALEBEEF_SUMMER = "投喂食物可以有效获得考拉象的信任。"
GLOBAL.STRINGS.CHARACTERS.WAXWELL.DESCRIBE.KOALEBEEF_SUMMER = "我记得我并没有让它们可以这样……"
GLOBAL.STRINGS.CHARACTERS.WX78.DESCRIBE.KOALEBEEF_SUMMER = "有机物的信任真是廉价"
GLOBAL.STRINGS.CHARACTERS.WOODIE.DESCRIBE.KOALEBEEF_SUMMER = "我给你口吃的，你帮我运送木头，很合理吧伙计。"
GLOBAL.STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.KOALEBEEF_SUMMER = "你愿意成为我的战象吗？"
GLOBAL.STRINGS.CHARACTERS.WEBBER.DESCRIBE.KOALEBEEF_SUMMER = "我们跟考拉象做朋友了，耶！"
GLOBAL.STRINGS.CHARACTERS.WINONA.DESCRIBE.KOALEBEEF_SUMMER = "哈，你这家伙一口吃的就被收买了！"
GLOBAL.STRINGS.CHARACTERS.WURT.DESCRIBE.KOALEBEEF_SUMMER = "浮浪噗，是朋友了。"
GLOBAL.STRINGS.CHARACTERS.WARLY.DESCRIBE.KOALEBEEF_SUMMER = "我暂时不会把你端上餐桌。"
GLOBAL.STRINGS.CHARACTERS.WORTOX.DESCRIBE.KOALEBEEF_SUMMER = "你比皮弗娄牛还柔软！"
GLOBAL.STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.KOALEBEEF_SUMMER = "毛绒绒朋友是朋友了"
GLOBAL.STRINGS.CHARACTERS.WALTER.DESCRIBE.KOALEBEEF_SUMMER = "沃比，我们可能有新朋友了！"
GLOBAL.STRINGS.CHARACTERS.WANDA.DESCRIBE.KOALEBEEF_SUMMER = "你比皮弗娄牛好在哪呢？"

GLOBAL.STRINGS.NAMES.KOALEBEEF_WINTER = "友好考拉象"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.KOALEBEEF_WINTER = "这只大象跟我建立了友谊，不再害怕我了。"
GLOBAL.STRINGS.CHARACTERS.WILLOW.DESCRIBE.KOALEBEEF_WINTER = "哈哈，你不怕我烧你？就因为我给了你一口吃的？"
GLOBAL.STRINGS.CHARACTERS.WENDY.DESCRIBE.KOALEBEEF_WINTER = "我轻而易举的获得了这个生物的信任，它真傻。"
GLOBAL.STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.KOALEBEEF_WINTER = "沃尔夫冈跟小象建立了友谊！"
GLOBAL.STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.KOALEBEEF_WINTER = "投喂食物可以有效获得考拉象的信任。"
GLOBAL.STRINGS.CHARACTERS.WAXWELL.DESCRIBE.KOALEBEEF_WINTER = "我记得我并没有让它们可以这样……"
GLOBAL.STRINGS.CHARACTERS.WX78.DESCRIBE.KOALEBEEF_WINTER = "有机物的信任真是廉价"
GLOBAL.STRINGS.CHARACTERS.WOODIE.DESCRIBE.KOALEBEEF_WINTER = "我给你口吃的，你帮我运送木头，很合理吧伙计。"
GLOBAL.STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.KOALEBEEF_WINTER = "你愿意成为我的战象吗？"
GLOBAL.STRINGS.CHARACTERS.WEBBER.DESCRIBE.KOALEBEEF_WINTER = "我们跟考拉象做朋友了，耶！"
GLOBAL.STRINGS.CHARACTERS.WINONA.DESCRIBE.KOALEBEEF_WINTER = "哈，你这家伙一口吃的就被收买了！"
GLOBAL.STRINGS.CHARACTERS.WURT.DESCRIBE.KOALEBEEF_WINTER = "浮浪噗，是朋友了。"
GLOBAL.STRINGS.CHARACTERS.WARLY.DESCRIBE.KOALEBEEF_WINTER = "我暂时不会把你端上餐桌。"
GLOBAL.STRINGS.CHARACTERS.WORTOX.DESCRIBE.KOALEBEEF_WINTER = "你比皮弗娄牛还柔软！"
GLOBAL.STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.KOALEBEEF_WINTER = "毛绒绒朋友是朋友了"
GLOBAL.STRINGS.CHARACTERS.WALTER.DESCRIBE.KOALEBEEF_WINTER = "沃比，我们可能有新朋友了！"
GLOBAL.STRINGS.CHARACTERS.WANDA.DESCRIBE.KOALEBEEF_WINTER = "你比皮弗娄牛好在哪呢？"


GLOBAL.STRINGS.NAMES.KOALEBEEF_SUMMER_BELL = "考拉象铃"
GLOBAL.STRINGS.RECIPE_DESC.KOALEBEEF_SUMMER_BELL = "友好考拉象喜欢它。"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.KOALEBEEF_SUMMER_BELL = "它会让考拉象变得更友好，我相信科学对此一定有解释。"
GLOBAL.STRINGS.CHARACTERS.WILLOW.DESCRIBE.KOALEBEEF_SUMMER_BELL = "哇，跟考拉象交朋友好简单啊!"
GLOBAL.STRINGS.CHARACTERS.WENDY.DESCRIBE.KOALEBEEF_SUMMER_BELL = "可惜不是真正的象钟。"
GLOBAL.STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.KOALEBEEF_SUMMER_BELL = "叮叮叮！"
GLOBAL.STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.KOALEBEEF_SUMMER_BELL = "它的某种音色会引起考拉象的好感。"
GLOBAL.STRINGS.CHARACTERS.WAXWELL.DESCRIBE.KOALEBEEF_SUMMER_BELL = "它好像能催眠考拉象。"
GLOBAL.STRINGS.CHARACTERS.WX78.DESCRIBE.KOALEBEEF_SUMMER_BELL = "获得考拉象忠诚的有效工具"
GLOBAL.STRINGS.CHARACTERS.WOODIE.DESCRIBE.KOALEBEEF_SUMMER_BELL = "考拉象好像喜欢它的声音。"
GLOBAL.STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.KOALEBEEF_SUMMER_BELL = "肉乎乎的野兽会为这只铃铛献出忠诚。"
GLOBAL.STRINGS.CHARACTERS.WEBBER.DESCRIBE.KOALEBEEF_SUMMER_BELL = "考拉象真的很喜欢这个铃铛，谁敲喜欢谁！"
GLOBAL.STRINGS.CHARACTERS.WINONA.DESCRIBE.KOALEBEEF_SUMMER_BELL = "那头考拉象很喜欢那个铃铛！"
GLOBAL.STRINGS.CHARACTERS.WURT.DESCRIBE.KOALEBEEF_SUMMER_BELL = "大胖球可真喜欢铃铛啊。"
GLOBAL.STRINGS.CHARACTERS.WARLY.DESCRIBE.KOALEBEEF_SUMMER_BELL = "这不是开饭的铃铛吗？"
GLOBAL.STRINGS.CHARACTERS.WORTOX.DESCRIBE.KOALEBEEF_SUMMER_BELL = "多么奇怪的魔法！"
GLOBAL.STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.KOALEBEEF_SUMMER_BELL = "叮咚"
GLOBAL.STRINGS.CHARACTERS.WALTER.DESCRIBE.KOALEBEEF_SUMMER_BELL = "这只考拉象似乎很喜欢它发出的声音!"
GLOBAL.STRINGS.CHARACTERS.WANDA.DESCRIBE.KOALEBEEF_SUMMER_BELL = "它使驯服考拉象的速度大大加快!"

GLOBAL.STRINGS.NAMES.KOALEBEEF_WINTER_BELL = "冬考拉象铃"
GLOBAL.STRINGS.RECIPE_DESC.KOALEBEEF_WINTER_BELL = "友好考拉象喜欢它。"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.KOALEBEEF_WINTER_BELL = "它会让考拉象变得更友好，我相信科学对此一定有解释。"
GLOBAL.STRINGS.CHARACTERS.WILLOW.DESCRIBE.KOALEBEEF_WINTER_BELL = "哇，跟考拉象交朋友好简单啊!"
GLOBAL.STRINGS.CHARACTERS.WENDY.DESCRIBE.KOALEBEEF_WINTER_BELL = "可惜不是真正的象钟。"
GLOBAL.STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.KOALEBEEF_WINTER_BELL = "叮叮叮！"
GLOBAL.STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.KOALEBEEF_WINTER_BELL = "它的某种音色会引起考拉象的好感。"
GLOBAL.STRINGS.CHARACTERS.WAXWELL.DESCRIBE.KOALEBEEF_WINTER_BELL = "它好像能催眠考拉象。"
GLOBAL.STRINGS.CHARACTERS.WX78.DESCRIBE.KOALEBEEF_WINTER_BELL = "获得考拉象忠诚的有效工具"
GLOBAL.STRINGS.CHARACTERS.WOODIE.DESCRIBE.KOALEBEEF_WINTER_BELL = "考拉象好像喜欢它的声音。"
GLOBAL.STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.KOALEBEEF_WINTER_BELL = "肉乎乎的野兽会为这只铃铛献出忠诚。"
GLOBAL.STRINGS.CHARACTERS.WEBBER.DESCRIBE.KOALEBEEF_WINTER_BELL = "考拉象真的很喜欢这个铃铛，谁敲喜欢谁！"
GLOBAL.STRINGS.CHARACTERS.WINONA.DESCRIBE.KOALEBEEF_WINTER_BELL = "那头考拉象很喜欢那个铃铛！"
GLOBAL.STRINGS.CHARACTERS.WURT.DESCRIBE.KOALEBEEF_WINTER_BELL = "大胖球可真喜欢铃铛啊。"
GLOBAL.STRINGS.CHARACTERS.WARLY.DESCRIBE.KOALEBEEF_WINTER_BELL = "这不是开饭的铃铛吗？"
GLOBAL.STRINGS.CHARACTERS.WORTOX.DESCRIBE.KOALEBEEF_WINTER_BELL = "多么奇怪的魔法！"
GLOBAL.STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.KOALEBEEF_WINTER_BELL = "叮咚"
GLOBAL.STRINGS.CHARACTERS.WALTER.DESCRIBE.KOALEBEEF_WINTER_BELL = "这只考拉象似乎很喜欢它发出的声音!"
GLOBAL.STRINGS.CHARACTERS.WANDA.DESCRIBE.KOALEBEEF_WINTER_BELL = "它使驯服考拉象的速度大大加快!"

--新物品配方
AddRecipe2("koalebeef_summer_bell", {Ingredient("goldnugget", 3), Ingredient("flint", 1)},GLOBAL.TECH.SCIENCE_ONE,{image = "beef_bell.tex"}, {"RIDING"})
AddRecipe2("koalebeef_winter_bell", {Ingredient("goldnugget", 3), Ingredient("flint", 1)},GLOBAL.TECH.SCIENCE_ONE,{image = "beef_bell.tex"}, {"RIDING"})


--排序函数
local CRAFTING_FILTERS = GLOBAL.CRAFTING_FILTERS
local function ChangeSortKey(recipe_name, recipe_reference, filter, after)
    local recipes = CRAFTING_FILTERS[filter].recipes
    local recipe_name_index
    local recipe_reference_index

    for i = #recipes, 1, -1 do
        if recipes[i] == recipe_name then
            recipe_name_index = i
        elseif recipes[i] == recipe_reference then
            recipe_reference_index = i + (after and 1 or 0)
        end
        if recipe_name_index and recipe_reference_index then
            if recipe_name_index >= recipe_reference_index then
                table.remove(recipes, recipe_name_index)
                table.insert(recipes, recipe_reference_index, recipe_name)
            else
                table.insert(recipes, recipe_reference_index, recipe_name)
                table.remove(recipes, recipe_name_index)
            end
            break
        end
    end
end
ChangeSortKey("koalebeef_summer_bell", "beef_bell", "RIDING", true)
ChangeSortKey("koalebeef_winter_bell", "koalebeef_summer_bell", "RIDING", true)


local function ShouldAcceptItema(inst, item)
    return inst.components.eater:CanEat(item)
end

local function OnGetItemFromPlayera(inst, giver, item)
    if inst.components.eater:CanEat(item) then
	item:DoTaskInTime(0, item.Remove)
    local grown = GLOBAL.SpawnPrefab("koalebeef_summer")
    grown.Transform:SetPosition(inst.Transform:GetWorldPosition() )
    grown.Transform:SetRotation(inst.Transform:GetRotation() )
	grown.components.hunger:SetPercent(0.25)
	grown.sg:GoToState("graze")
    inst:Remove()
    end
end

local function OnRefuseItema(inst, item)
end

local function Koalebeefsummerint(inst)
if GLOBAL.TheWorld.ismastersim then
    inst.components.eater:SetDiet({ GLOBAL.FOODTYPE.VEGGIE, GLOBAL.FOODTYPE.ROUGHAGE }, { GLOBAL.FOODTYPE.VEGGIE, GLOBAL.FOODTYPE.ROUGHAGE })
    inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(ShouldAcceptItema)
    inst.components.trader.onaccept = OnGetItemFromPlayera
    inst.components.trader.onrefuse = OnRefuseItema
    inst.components.trader.deleteitemonaccept = false
	end
end
AddPrefabPostInit("koalefant_summer", Koalebeefsummerint)

local function ShouldAcceptItemaa(inst, item)
    return inst.components.eater:CanEat(item)
end

local function OnGetItemFromPlayeraa(inst, giver, item)
    if inst.components.eater:CanEat(item) then
	item:DoTaskInTime(0, item.Remove)
    local grown = GLOBAL.SpawnPrefab("koalebeef_winter")
    grown.Transform:SetPosition(inst.Transform:GetWorldPosition() )
    grown.Transform:SetRotation(inst.Transform:GetRotation() )
	grown.components.hunger:SetPercent(0.25) --防止喂花瓣荧光果这种无饱食度食物时在考拉和友好考拉间反复横跳
	grown.sg:GoToState("graze")
    inst:Remove()
    end
end

local function OnRefuseItemaa(inst, item)
end

local function Koalebeefwinterint(inst)
if GLOBAL.TheWorld.ismastersim then
    inst.components.eater:SetDiet({ GLOBAL.FOODTYPE.VEGGIE, GLOBAL.FOODTYPE.ROUGHAGE }, { GLOBAL.FOODTYPE.VEGGIE, GLOBAL.FOODTYPE.ROUGHAGE })
    inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(ShouldAcceptItemaa)
    inst.components.trader.onaccept = OnGetItemFromPlayeraa
    inst.components.trader.onrefuse = OnRefuseItemaa
    inst.components.trader.deleteitemonaccept = false
	end
end
AddPrefabPostInit("koalefant_winter", Koalebeefwinterint)


--兼容牛牛数据显示
if GLOBAL.KnownModIndex:IsModEnabled("workshop-2477889104") then
local function OnMount2(rider, data)
    local mount = data.target
    if mount and (mount.prefab == "koalebeef_winter" or mount.prefab == "koalebeef_summer") then
        local saddle = rider.replica.rider:GetSaddle()
        local mountData = {
            health = mount.replica.health:GetCurrent(),
            maxHealth = mount.replica.health:Max(),
            domestication = mount.components.domesticatable:GetDomestication() * 100,
            tendency = mount.tendency,
            obedience = mount.components.domesticatable:GetObedience() * 100,
            bucktime = GLOBAL.GetTaskRemaining(mount._bucktask),
            hunger = mount.replica.hunger:GetCurrent(),
            maxHunger = mount.replica.hunger:Max(),
            saddleUses = (saddle and saddle.components.finiteuses) and saddle.components.finiteuses:GetUses() or 0
        }

        rider.player_classified.beefaloData:set(GLOBAL.json.encode(mountData))
        rider.player_classified.beefaloHealth:set_local(mountData.health)
        rider.player_classified.beefaloDomestication:set_local(GLOBAL.json.encode({domestication = mountData.domestication, tendency = mountData.tendency}))
        rider.player_classified.beefaloObedience:set_local(mountData.obedience)
        rider.player_classified.beefaloHunger:set_local(mountData.hunger)
        rider:ListenForEvent("healthdelta", rider.player_classified.OnBeefaloHealthDelta, mount)
        rider:ListenForEvent("domesticationdelta", rider.player_classified.OnBeefaloDomesticationDelta, mount)
        rider:ListenForEvent("obediencedelta", rider.player_classified.OnBeefaloObedienceDelta, mount)
        rider:ListenForEvent("hungerdelta", rider.player_classified.OnBeefaloHungerDelta, mount)
    end
end

local function OnDismount2(rider, data)
    local mount = data.target
    if mount and (mount.prefab == "koalebeef_winter" or mount.prefab == "koalebeef_summer") then
        rider.player_classified.beefaloData:set("dismount")
        rider:RemoveEventCallback("healthdelta", rider.player_classified.OnBeefaloHealthDelta, mount)
        rider:RemoveEventCallback("domesticationdelta", rider.player_classified.OnBeefaloDomesticationDelta, mount)
        rider:RemoveEventCallback("obediencedelta", rider.player_classified.OnBeefaloObedienceDelta, mount)
        rider:RemoveEventCallback("hungerdelta", rider.player_classified.OnBeefaloHungerDelta, mount)
    end
end


-- Network setup

AddPrefabPostInit("player_classified", function(inst)
    if GLOBAL.TheWorld.ismastersim then
        inst:DoStaticTaskInTime(0.2, function()
            local parent2 = inst.entity:GetParent()
            inst:ListenForEvent("mounted", OnMount2, parent2)
            inst:ListenForEvent("dismounted", OnDismount2, parent2)
        end)
    end
end)

end

local function OnSetOwner(inst)
inst:DoTaskInTime(0,function() 
    if inst.components.playeractionpicker ~= nil then
        local _pointspecialactionsfn = inst.components.playeractionpicker.pointspecialactionsfn
        inst.components.playeractionpicker.pointspecialactionsfn = function(inst, pos, useitem, right)
			if inst.replica.rider and inst.replica.rider:IsRiding() and inst.replica.rider:GetMount() and inst.replica.rider:GetMount():HasTag("Fant_CC") and not inst.replica.rider:GetMount():HasTag("FeiDuCD") then
                if inst.replica.inventory:Has("wortox_soul",1) then
				    if right and inst.components.playercontroller and inst.components.playercontroller:IsControlPressed(GLOBAL.CONTROL_FORCE_INSPECT) then
                        return {ACTIONS.FANT_CHARGE}
                    end				
				else
				    if right then
                        return {ACTIONS.FANT_CHARGE}
                    end
				end
            end
            return _pointspecialactionsfn ~= nil and _pointspecialactionsfn(inst, pos, useitem, right) or {}
        end
    end
end)
end

--添加考拉象冲刺标签,象鼻背心快速上牛
local MOUNT_fn_old = ACTIONS.MOUNT.fn
ACTIONS.MOUNT.fn = function(act)
    if act.doer.components.inventory and act.doer.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY) and (act.doer.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY).prefab == "trunkvest_winter" or act.doer.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY).prefab == "trunkvest_summer") then
        if act.target:HasTag("koalefant") and act.target.components.domesticatable ~= nil and act.target.components.domesticatable:GetObedience() < act.target.components.domesticatable.maxobedience then
            act.target.components.domesticatable:DeltaObedience(1) 
        end
        if act.target.components.combat then
            act.target.components.combat:DropTarget()
        end
    end

    if act.target:HasTag("koalefant") and act.target.components.domesticatable and act.target.components.domesticatable:IsDomesticated() and act.target.tendency and act.target.tendency ~= TENDENCY.PUDGY then
	    act.target:AddTag("Fant_CC")
	end
    return MOUNT_fn_old(act)
end

--行象和战象的冲刺能力
local LEAP_MAX_DIST = 18
local LEAP_MIN_DIST = 3
local LEAP_MAX_SPEED = 30
local LEAP_MIN_SPEED = LEAP_MAX_SPEED * LEAP_MIN_DIST / LEAP_MAX_DIST
local LEAP_MAX_DIST_SQ = LEAP_MAX_DIST * LEAP_MAX_DIST
local LEAP_MIN_DIST_SQ = LEAP_MIN_DIST * LEAP_MIN_DIST

local leap_action = AddAction("FANT_CHARGE", "冲刺！冲！", function(act)
		if act.doer ~= nil and act.doer.sg ~= nil and act.doer.sg.currentstate.name == "fant_cc_pre" then
			act.doer.sg:GoToState("fant_cc", { pos = act.pos })
			return true
		end
end)

	leap_action.priority = 1
	leap_action.rmb = true
	leap_action.mount_valid = true
	leap_action.distance = 36

--免疫硬直相关
AddStategraphPostInit("wilson", function(sg)
    local old_onattacked = sg.events['attacked'].fn
    sg.events['attacked'] = EventHandler('attacked', function(inst,data,...)
		if inst.fantchongfeng then 
		    if not inst.sg:HasStateTag('frozen') and not inst.sg:HasStateTag('sleeping') then
                if inst.hurtsoundoverride ~= nil then
                    inst.SoundEmitter:PlaySound(inst.hurtsoundoverride, nil, inst.hurtsoundvolume)
                elseif not inst:HasTag("mime") then
                    inst.SoundEmitter:PlaySound((inst.talker_path_override or "dontstarve/characters/")..(inst.soundsname or inst.prefab).."/hurt", nil, inst.hurtsoundvolume)
                end
			    return	   
			end
		end
        return old_onattacked(inst,data,...)
    end)
end)

AddPlayerPostInit(function(inst)
    inst:ListenForEvent("setowner", OnSetOwner)
end)

local function AddEnemyDebuffFx(fx, target)
	if target and target.components.health and not target.components.health:IsDead() then
	target:DoTaskInTime(math.random() * 0.25, function()
		local x, y, z = target.Transform:GetWorldPosition()
		local fx = SpawnPrefab(fx)
		if fx then
			fx.Transform:SetPosition(x, y, z)
		end

		return fx
	end)
	end
end
local WORKABLES_CANT_TAGS = { "insect", "INLIMBO" }
local WORKABLES_ONEOF_TAGS = {"MINE_workable","CHOP_workable","heavy"}
--------------------------------------------------------------------------

	AddStategraphState("wilson", State{
		name = "fant_cc_pre",
		tags = { "doing", "busy", "canrotate" },

		onenter = function(inst)
			inst.components.locomotor:Stop()
			inst.AnimState:PlayAnimation("emoteXL_angry")
			inst.SoundEmitter:PlaySound("dontstarve/creatures/koalefant/angry")
			
			if inst.components.playercontroller ~= nil then
				inst.components.playercontroller:Enable(false)
			end
			
			inst.fantchongfeng = true
			local fant = inst.components.rider.mount
			fant:AddTag("FeiDuCD")
			fant:DoTaskInTime(15,function()
                if fant then
			        fant:RemoveTag("FeiDuCD")
			    end
			end)
        
		local PL = inst
	    if PL.prefab == "willow" then
	        PL.components.talker:Say("把它们碾成灰烬！！！")
		elseif PL.prefab == "wolfgang" then
		    PL.components.talker:Say("沃尔夫冈是最强悍的骑兵！！")
		elseif PL.prefab == "wendy" then
		    PL.components.talker:Say("把它们践踏到地狱里去！")
		elseif PL.prefab == "wx78" then
		    PL.components.talker:Say("启用过载加速！")
		elseif PL.prefab == "wickerbottom" then
		    PL.components.talker:Say("哈啊，向不尊重知识的人冲锋！")
		elseif PL.prefab == "woodie" then
		    PL.components.talker:Say("撞倒那些树！")
		elseif PL.prefab == "waxwell" then
		    PL.components.talker:Say("我是唯一的王！")
		elseif PL.prefab == "wathgrithr" then
		    PL.components.talker:Say("以英灵殿之名！！！")
		elseif PL.prefab == "webber" then
		    PL.components.talker:Say("我们冲！！")
		elseif PL.prefab == "winona" then
		    PL.components.talker:Say("去吧，就像齿轮碾过废铁！")
		elseif PL.prefab == "warly" then
		    PL.components.talker:Say("把他们变成食材！")
		elseif PL.prefab == "wortox" then
		    PL.components.talker:Say("Q打断它的E啊！！！！")
		elseif PL.prefab == "wormwood" then
		    PL.components.talker:Say("朋友生气了！")
		elseif PL.prefab == "wurt" then
		    PL.components.talker:Say("浮浪噗，都去死！")
		elseif PL.prefab == "walter" then
		    PL.components.talker:Say("沃比，跟紧了！！")
		elseif PL.prefab == "wanda" then
		    PL.components.talker:Say("向时间和空间冲刺！！")
		elseif PL.prefab == "wirlywings" then
		    PL.components.talker:Say("唔姆，要加速了！")
		elseif PL.prefab == "daidai" then
		    PL.components.talker:Say("象象飞起来！")
		elseif PL.prefab == "wathom" then
		    PL.components.talker:Say("冲！")
		elseif PL.prefab == "winky" then
		    PL.components.talker:Say("吱！！")
		elseif PL.prefab == "wixie" then
		    PL.components.talker:Say("让我们像子弹一样飞起来！")
		else
		    PL.components.talker:Say("科学啊，让我们加速吧！")
		end
		
			local x, y, z = inst.Transform:GetWorldPosition()
			inst:DoTaskInTime(0.2,function() 
			local fx = SpawnPrefab("spider_heal_ground_fx")
			inst.SoundEmitter:PlaySound("dontstarve/common/deathpoof")
			if fx ~= nil  then
				fx.Transform:SetScale(.6, .6, .6)
				fx.Transform:SetPosition(x, 0, z)
			end
			end)
			
		    local ents = TheSim:FindEntities(x,0,z,15,nil, { "epic", "companion", "notraptrigger", "ghost", "player", "INLIMBO", "flight", "invisible", "notarget" })
			SpawnPrefab("groundpoundring_fx").Transform:SetPosition(inst.Transform:GetWorldPosition())
            for k,v in pairs(ents) do
		        if v and v.components.hauntable and v.components.hauntable.panicable then
				    if v.components.follower and not v.components.follower.leader then 
			            v.components.hauntable:Panic(4)
						AddEnemyDebuffFx("battlesong_instant_panic_fx", v)
					elseif v.components.follower == nil then
					    v.components.hauntable:Panic(4)
						AddEnemyDebuffFx("battlesong_instant_panic_fx", v)
			        end
				end
		    end
			
			
		end,

		events =
		{
			EventHandler("animover", function(inst)
				if inst.AnimState:AnimDone() then
					if inst.bufferedaction ~= nil then
						inst:PerformBufferedAction()
					else
						inst.sg:GoToState("idle")
					end
				end
			end),
		},
		onexit = function(inst)
			if inst.components.playercontroller ~= nil then
				inst.components.playercontroller:Enable(true)
			end
			if inst.fantchongfeng then
				inst.fantchongfeng = false
			end
		end,
	})

	local function ToggleOffPhysics(inst)
		inst.sg.statemem.isphysicstoggle = true
		inst.Physics:ClearCollisionMask()
		inst.Physics:CollidesWith(COLLISION.GROUND)
	end

	local function ToggleOnPhysics(inst)
		inst.sg.statemem.isphysicstoggle = nil
		inst.Physics:ClearCollisionMask()
		inst.Physics:CollidesWith(COLLISION.WORLD)
		inst.Physics:CollidesWith(COLLISION.OBSTACLES)
		inst.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
		inst.Physics:CollidesWith(COLLISION.CHARACTERS)
		inst.Physics:CollidesWith(COLLISION.GIANTS)
	end

	AddStategraphState("wilson", State{
		name = "fant_cc",
		tags = { "doing", "busy", "canrotate", "nopredict", "nomorph" },

		onenter = function(inst, data)
		
		    inst.components.locomotor:SetExternalSpeedMultiplier(inst, "TT2",2)
            inst.components.locomotor:RunForward()
			local pos = data.pos:GetPosition()
			inst:ForceFacePoint(pos.x, 0, pos.z)
			
            if not inst.AnimState:IsCurrentAnimation("run_loop") then
                inst.AnimState:PlayAnimation("run_loop", true)
            end

			PlayFootstep(inst)

			if inst.components.playercontroller ~= nil then
				inst.components.playercontroller:Enable(false)
			end
			inst.fantchongfeng = true
			
			inst.pohuai = inst:DoPeriodicTask(0.1,function() --真的一坨代码

	local x, y, z = inst.Transform:GetWorldPosition()
    local heading_angle = inst.Transform:GetRotation() * DEGREES
    local x1, z1 = math.cos(heading_angle), -math.sin(heading_angle)
	
    for i, v in ipairs(TheSim:FindEntities(x, 0, z, 3, nil, WORKABLES_CANT_TAGS, WORKABLES_ONEOF_TAGS)) do
        local x2, y2, z2 = v.Transform:GetWorldPosition()
        local dx, dz = x2 - x, z2 - z
        local len = math.sqrt(dx * dx + dz * dz)
        if len <= 0 or x1 * dx / len + z1 * dz / len > .3 then
			if v.prefab == "marbleshrub" and v.statedata and v.statedata.name == "short" then
				
			else
                v.components.workable:WorkedBy(inst,20)
			    SpawnPrefab("collapse_small").Transform:SetPosition(v.Transform:GetWorldPosition())
				if not v:HasTag("heavy") then
				    inst.components.combat:GetAttacked(v,math.random(15,30))
			        --inst.components.rider.mount.components.health:DoDelta(-math.random(15,30))
				end
			end
        end
	end		

    for i, v in ipairs(TheSim:FindEntities(x, 0, z, 3)) do
	local target = v
    if target and target:IsValid() and target.prefab ~= "williambrute" and not target:HasTag("companion") and not target:HasTag("player") and target.components and target.components.locomotor and 
	   not target:HasTag("stageusher") and not (target.components.follower and target.components.follower.leader and target.components.follower.leader:HasTag("player")) then
        
        local x, y, z = inst.Transform:GetWorldPosition()
        local tx, ty, tz = target.Transform:GetWorldPosition()

        local rad = math.rad(inst:GetAngleToPoint(tx, ty, tz))
        inst.powerlevel = 10
		if target.components.combat then
	        if target.components.inventoryitem and target.components.inventoryitem.owner then
		    
			else
				target.components.combat:GetAttacked(inst,34)
			end
		end
        SpawnPrefab("collapse_small").Transform:SetPosition(target.Transform:GetWorldPosition())
        for i = 1, 50 do
            target:DoTaskInTime((i - 1) / 50, function(target)
                
				if target ~= nil and inst ~= nil then
                    local tx2, ty2, tz2 = target.Transform:GetWorldPosition()
                    local velx = math.cos(rad) -- * 4.5
                    local velz = -math.sin(rad) -- * 4.5
                    local giantreduction = target:HasTag("epic") and 8 or target:HasTag("smallcreature") and 2 or 3
                    if tx2 then
					local dx, dy, dz = tx2 + (((inst.powerlevel) / (i + 1)) * velx) / giantreduction, ty2, tz2 + (((inst.powerlevel) / (i + 1)) * velz) / giantreduction
                    local ground = TheWorld.Map:IsPassableAtPoint(dx, dy, dz)
                    local boat = TheWorld.Map:GetPlatformAtPoint(dx, dz)
                    local ocean = TheWorld.Map:IsOceanAtPoint(dx, dy, dz)
                    local on_water = nil

                    if GLOBAL.KnownModIndex:IsModEnabled("workshop-1467214795") then
                        on_water = IsOnWater(dx, dy, dz)
                    end

                    if not (target.sg ~= nil and (target.sg:HasStateTag("swimming") or target.sg:HasStateTag("invisible"))) then
                        if target ~= nil and target.components.locomotor ~= nil and dx ~= nil and (ground or boat or ocean and target.components.locomotor:CanPathfindOnWater() or target.components.tiletracker ~= nil and not target:HasTag("whale")) then
                            if not target:HasTag("aquatic") and not on_water or target:HasTag("aquatic") and on_water then
                                target.Transform:SetPosition(dx, dy, dz)
                            end
                        end
                    end
					end
					
                end
				
            end)
        end
    end
	
	end		
			end)
		end,

		onupdate = function(inst)
			if inst.sg.statemem.isphysicstoggle then
				local x, y, z = inst.Transform:GetWorldPosition()
				local angle = inst.Transform:GetRotation() * DEGREES
				local radius = .5
				x = x + .75 * radius * math.cos(angle)
				z = z - .75 * radius * math.sin(angle)
				local ents = TheSim:FindEntities(x, 0, z, radius, { "wall" })
				for i, v in ipairs(ents) do
					if v.components.health ~= nil and v.components.health:GetPercent() > .5 then
						ToggleOnPhysics(inst)
						return
					end
				end
			end
		end,

		timeline =
		{
                TimeEvent(5*FRAMES, function(inst)
                                        SpawnPrefab("ground_chunks_breaking").Transform:SetPosition(inst.Transform:GetWorldPosition())
										
                                    end ),
				TimeEvent(8*FRAMES, function(inst)
                                        SpawnPrefab("ground_chunks_breaking").Transform:SetPosition(inst.Transform:GetWorldPosition())
										
                                    end ),
				TimeEvent(10*FRAMES, PlayFootstep),
				TimeEvent(12*FRAMES, function(inst)
                                        SpawnPrefab("ground_chunks_breaking").Transform:SetPosition(inst.Transform:GetWorldPosition())
										
                                    end ),
				TimeEvent(13*FRAMES, PlayFootstep),
				TimeEvent(14*FRAMES, function(inst)
                                        SpawnPrefab("ground_chunks_breaking").Transform:SetPosition(inst.Transform:GetWorldPosition())
										
                                    end ),
				TimeEvent(17*FRAMES, PlayFootstep),
				TimeEvent(18*FRAMES, function(inst)
                                        SpawnPrefab("ground_chunks_breaking").Transform:SetPosition(inst.Transform:GetWorldPosition())
										
                                    end ),
                TimeEvent(20*FRAMES, function(inst)
                                        SpawnPrefab("ground_chunks_breaking").Transform:SetPosition(inst.Transform:GetWorldPosition())
										
                                    end ),
				TimeEvent(22*FRAMES, function(inst)
                                        SpawnPrefab("ground_chunks_breaking").Transform:SetPosition(inst.Transform:GetWorldPosition())
										
                                    end ),
				TimeEvent(24*FRAMES, PlayFootstep),
				TimeEvent(26*FRAMES, function(inst)
                                        SpawnPrefab("ground_chunks_breaking").Transform:SetPosition(inst.Transform:GetWorldPosition())
										
                                    end ),
				TimeEvent(28*FRAMES, PlayFootstep),
				TimeEvent(30*FRAMES, function(inst)
                                        SpawnPrefab("ground_chunks_breaking").Transform:SetPosition(inst.Transform:GetWorldPosition())
										
                                    end ),
				TimeEvent(32*FRAMES, PlayFootstep),
				TimeEvent(34*FRAMES, function(inst)
                                        SpawnPrefab("ground_chunks_breaking").Transform:SetPosition(inst.Transform:GetWorldPosition())
										
                                    end ),
				TimeEvent(38*FRAMES, PlayFootstep),
				TimeEvent(40*FRAMES, function(inst)
                                        SpawnPrefab("ground_chunks_breaking").Transform:SetPosition(inst.Transform:GetWorldPosition())
										
                                    end ),
				TimeEvent(44*FRAMES, PlayFootstep),
				TimeEvent(46*FRAMES, function(inst)
                                        SpawnPrefab("ground_chunks_breaking").Transform:SetPosition(inst.Transform:GetWorldPosition())
										
                                    end ),
				TimeEvent(48*FRAMES, PlayFootstep),
				TimeEvent(50*FRAMES, function(inst)
                                        SpawnPrefab("ground_chunks_breaking").Transform:SetPosition(inst.Transform:GetWorldPosition())
										
                                    end ),
				TimeEvent(52*FRAMES, PlayFootstep),
				TimeEvent(54*FRAMES, function(inst)
                                        SpawnPrefab("ground_chunks_breaking").Transform:SetPosition(inst.Transform:GetWorldPosition())
										
                                    end ),
				TimeEvent(56*FRAMES, PlayFootstep),
				TimeEvent(58*FRAMES, function(inst)
                                        SpawnPrefab("ground_chunks_breaking").Transform:SetPosition(inst.Transform:GetWorldPosition())
										
                                    end ),
			TimeEvent(58 * FRAMES, function(inst)
				inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt")
			end),
			TimeEvent(60 * FRAMES, function(inst)
				inst.Physics:Stop()
				inst.sg:GoToState("run_stop")
			end),
		},

		onexit = function(inst)
		    inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "TT2")
			if inst.sg.statemem.isphysicstoggle then
				ToggleOnPhysics(inst)
			end
            if inst.pohuai then
			    inst.pohuai:Cancel()
			end
			if inst.fantchongfeng then
				inst.fantchongfeng = false
			end
			if inst.components.playercontroller ~= nil then
				inst.components.playercontroller:Enable(true)
			end
		end,
	})

	AddStategraphState("wilson_client", State{
		name = "fant_cc_pre",
		tags = { "doing", "busy", "canrotate" },

		onenter = function(inst)
			inst.components.locomotor:Stop()
			inst.AnimState:PlayAnimation("emoteXL_angry")
			inst.SoundEmitter:PlaySound("dontstarve/creatures/koalefant/angry")
			
			if inst.components.playercontroller ~= nil then
				inst.components.playercontroller:Enable(false)
			end
			
			inst.fantchongfeng = true
			-- local fant = inst.replica.rider:GetMount()
			-- fant:AddTag("FeiDuCD")
			-- fant:DoTaskInTime(15,function()
                -- if fant then
			        -- fant:RemoveTag("FeiDuCD")
			    -- end
			-- end)
			
			-- local x, y, z = inst.Transform:GetWorldPosition()
			-- inst:DoTaskInTime(0.2,function() 
			-- local fx = SpawnPrefab("spider_heal_ground_fx")
			-- inst.SoundEmitter:PlaySound("dontstarve/common/deathpoof")
			-- if fx ~= nil  then
				-- fx.Transform:SetScale(.6, .6, .6)
				-- fx.Transform:SetPosition(x, 0, z)
			-- end
			-- end)
			
		    -- local ents = TheSim:FindEntities(x,0,z,15,nil, { "epic", "companion", "notraptrigger", "ghost", "player", "INLIMBO", "flight", "invisible", "notarget" })
			-- SpawnPrefab("groundpoundring_fx").Transform:SetPosition(inst.Transform:GetWorldPosition())
            -- for k,v in pairs(ents) do
		        -- if v and v.components.hauntable and v.components.hauntable.panicable then
				    -- if v.components.follower and not v.components.follower.leader then 
			            -- v.components.hauntable:Panic(4)
						-- AddEnemyDebuffFx("battlesong_instant_panic_fx", v)
					-- elseif v.components.follower == nil then
					    -- v.components.hauntable:Panic(4)
						-- AddEnemyDebuffFx("battlesong_instant_panic_fx", v)
			        -- end
				-- end
		    -- end

			inst:PerformPreviewBufferedAction()
		end,

		onupdate = function(inst)
			if inst:HasTag("doing") then
				if inst.entity:FlattenMovementPrediction() then
					inst.sg:GoToState("idle", "noanim")
				end
			elseif inst.bufferedaction == nil then
				inst.sg:GoToState("idle")
			end
		end,

		ontimeout = function(inst)
			inst:ClearBufferedAction()
			inst.sg:GoToState("idle")
		end,
		
		onexit = function(inst)
			if inst.components.playercontroller ~= nil then
				inst.components.playercontroller:Enable(true)
			end
			if inst.fantchongfeng then
				inst.fantchongfeng = false
			end
		end,
	})

	AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.FANT_CHARGE, function(inst)
		return not inst.sg:HasStateTag("busy")
			and (inst.sg:HasStateTag("moving") or inst.sg:HasStateTag("idle"))
			and "fant_cc_pre"
			or nil
	end))

	AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.FANT_CHARGE, function(inst)
		return not (inst.sg:HasStateTag("busy") or inst:HasTag("busy"))
			and inst.entity:CanPredictMovement()
			and (inst.sg:HasStateTag("moving") or inst.sg:HasStateTag("idle"))
			and "fant_cc_pre"
			or nil
	end))