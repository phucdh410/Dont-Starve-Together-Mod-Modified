
local MakePlayerCharacter = require "prefabs/player_common"


local assets = {
	Asset( "ANIM", "anim/kkr.zip" ),
    Asset( "ANIM", "anim/kkr_skin_uniform.zip" ),
	Asset( "ANIM", "anim/ghost_kkr_build.zip" ),

    Asset( "IMAGE", "images/saveslot_portraits/kkr.tex" ), --存档图片
    Asset( "ATLAS", "images/saveslot_portraits/kkr.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/kkr.tex" ), --单机选人界面
    Asset( "ATLAS", "images/selectscreen_portraits/kkr.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/kkr_silho.tex" ), --单机未解锁界面
    Asset( "ATLAS", "images/selectscreen_portraits/kkr_silho.xml" ),

    Asset( "IMAGE", "bigportraits/kkr.tex" ), --人物立绘
    Asset( "ATLAS", "bigportraits/kkr.xml" ),
	
	Asset( "IMAGE", "images/map_icons/kkr.tex" ), --小地图
	Asset( "ATLAS", "images/map_icons/kkr.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_kkr.tex" ), --tab键人物列表显示的头像
    Asset( "ATLAS", "images/avatars/avatar_kkr.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_kkr.tex" ),--tab键人物列表显示的头像（死亡）
    Asset( "ATLAS", "images/avatars/avatar_ghost_kkr.xml" ),
	
	Asset( "IMAGE", "images/avatars/self_inspect_kkr.tex" ), --人物检查按钮的图片
    Asset( "ATLAS", "images/avatars/self_inspect_kkr.xml" ),
	
	Asset( "IMAGE", "images/names_kkr.tex" ),  --人物名字
    Asset( "ATLAS", "images/names_kkr.xml" ),
	
	Asset( "ANIM", "anim/player_lunge_kkr.zip" ),
	Asset( "ANIM", "anim/kkr_fly.zip" ),

}
local prefabs = {}

-- 初始物品
local start_inv = {"kkr_gemstaff","kkr_elfrobe","kkr_pocket","sewing_kit"}
if  TUNING.GAMEMODE_STARTING_ITEMS and  TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT then
    TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.KKR = start_inv
    for _, item in ipairs(start_inv) do
		if item  ~= "sewing_kit" then
			TUNING.STARTING_ITEM_IMAGE_OVERRIDE[item] = {atlas = "images/inventoryimages/" .. item .. ".xml", image = item .. ".tex" }
		end
        
    end
end

local function DoPlantBonus(inst)
    if inst and inst.components.sanity then
		inst.components.sanity:DoDelta(3)
	end
end

local function WatchWorldPlants(inst)
    if not inst._onitemplanted then
        inst._onitemplanted = function(src, data)
            if not data then
                --shouldn't happen
            elseif data.doer == inst then
                DoPlantBonus(inst)
            end
        end
        inst:ListenForEvent("itemplanted", inst._onitemplanted, TheWorld)
    end

end

local function StopWatchingWorldPlants(inst)
    if inst._onitemplanted then
        inst:RemoveEventCallback("itemplanted", inst._onitemplanted, TheWorld)
        inst._onitemplanted = nil
    end

end

--命中
local function onhitother(inst, data)

	if inst:IsValid() then
		inst:AddDebuff("kkr_speedup", "kkr_speedup")
	end

end

local function CustomCombatDamage(inst, target, weapon, multiplier, mount)
    local mul = 1
    if  inst:IsValid() then
        --获取移速倍率
		if inst.components.locomotor then
			local speedMultiplier = inst.components.locomotor:GetSpeedMultiplier() 
			if speedMultiplier < 1 then
				speedMultiplier = 1
			end

			mul = mul + (speedMultiplier - 1) * KKRENV.KKR_SPEEDATKMUL
		end
        
    end
    
    return mul
end


local function SpawnButterfly(inst)
    -- 检查角色是否已经有领袖
    if not inst.kkr_wind_spirit_leader then
        local leader = SpawnPrefab("kkr_wind_spirit_leader")
        inst.kkr_wind_spirit_leader = leader
        leader.components.kkrspiritleader:SetTarget(inst)
    end

    -- 检查已生成的蝴蝶数量
    local num_spirits = inst.kkr_wind_spirit_leader.components.kkrspiritleader:GetFormationSize()
    if num_spirits >= 3 then
        return
    end

    local x, y, z = inst.Transform:GetWorldPosition()
    local offset_x = math.cos(PI / 3) * 3  -- 生成精灵的 X 坐标偏移量
    local offset_z = math.sin(PI / 3) * 3  -- 生成精灵的 Z 坐标偏移量

    local spirit = SpawnPrefab("kkr_wind_spirit")
    spirit.Transform:SetPosition(x + offset_x, y, z + offset_z)

    inst.kkr_wind_spirit_leader.components.kkrspiritleader:SetMember(spirit)
    inst.kkr_wind_spirit_leader.components.kkrspiritleader:StartUpdatingComponent()
end

--内置cd
local function OnCooldown(inst)
    inst._cdtaskd = nil
end

local function kkr_domain(inst)

    -- 检查输入参数是否有效
    if not inst or not inst.kkr_wind_spirit_leader then
        inst.components.talker:Say("目前没有跟随的风精灵")
        return false
    end

    -- 获取跟随的风精灵数量
    local num_spirits = inst.kkr_wind_spirit_leader.components.kkrspiritleader:GetFormationSize()
    if num_spirits <= 0 then
        inst.components.talker:Say("目前没有跟随的风精灵")
        return false
    end

    -- 飞行状态下和非飞行状态下的施法条件判断
    local is_flying = inst:HasTag("kkr_fly")
    local spirits_required = is_flying and 1 or 2

    if inst._cdtaskd == nil and num_spirits >= spirits_required then
        inst._cdtaskd = inst:DoTaskInTime(KKRENV.KKR_DOMAINCD, OnCooldown)

        -- 移除相应数量的风精灵
        local formation = inst.kkr_wind_spirit_leader.components.kkrspiritleader.formation
        for i = 1, spirits_required do
            local random_index = math.random(1, #formation)
            if formation[random_index] and formation[random_index]:IsValid() then
                formation[random_index]:Remove()
                table.remove(formation, random_index) -- 移除已选中的风精灵
            end
        end

        local pos = inst:GetPosition()
        if is_flying then
            local domain = SpawnPrefab("kkr_domain")
            domain.Transform:SetPosition(pos:Get())
            inst.components.talker:Say("极光圣域！")
        else
            inst.components.talker:Say("极光绽放！")
        end
        
        local cure_flower = SpawnPrefab("kkr_cureflower")
        if is_flying then
            cure_flower.ongroundmode = false
        end
        cure_flower.Transform:SetPosition(pos:Get())
        cure_flower:Start(cure_flower)


        
        return true
    else
        inst.components.talker:Say("领域还处于冷却时间或没有足够的风精灵")
        return false
    end
end



local function RemoveButterfly(inst)
    if  inst.kkr_wind_spirit_leader then
        inst.kkr_wind_spirit_leader.components.kkrspiritleader:DisbandFormation()
        inst.kkr_wind_spirit_leader = nil
    end
    if inst.kkr_wind_spirit_leader_task then
        inst.kkr_wind_spirit_leader_task:Cancel()
        inst.kkr_wind_spirit_leader_task  = nil
    end

end


-- 当人物复活的时候
local function onbecamehuman(inst)
	-- 设置人物的移速（1表示1倍于wilson）
	inst.components.locomotor:SetExternalSpeedMultiplier(inst, "kkr_speed_mod", 1)
	--（也可以用以前的那种
	--inst.components.locomotor.walkspeed = 4
	--inst.components.locomotor.runspeed = 6）
	WatchWorldPlants(inst)
end
--当人物死亡的时候
local function onbecameghost(inst)
	-- 变成鬼魂的时候移除速度修正
   inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "kkr_speed_mod")
   StopWatchingWorldPlants(inst)
end

-- 重载游戏或者生成一个玩家的时候
local function onload(inst)
    

    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end


-- This initializes for both the server and client. Tags can be added here.
local common_postinit = function(inst) 
	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "kkr.tex" )
	inst:AddTag("kkr")
    inst:AddTag("expertchef") --火女的快速烤食物
	inst.AnimState:OverrideSymbol("fx_lunge_streak", "player_lunge_kkr", "fx_lunge_streak") --替换动画贴图
end

-- This initializes for the server only. Components are added here.
local master_postinit = function(inst)
	-- choose which sounds this character will play
	
	-- Uncomment if "wathgrithr"(Wigfrid) or "webber" voice is used
    --inst.talker_path_override = "dontstarve_DLC001/characters/"

	-- 人物音效
	inst.soundsname = "wendy"
	
	inst:AddComponent("kkrfly")

	-- 三维	
	inst.components.health:SetMaxHealth(KKRENV.TUNING.KKR_HEALTH)
	inst.components.hunger:SetMax(KKRENV.TUNING.KKR_SANITY)
	inst.components.sanity:SetMax(KKRENV.TUNING.KKR_HUNGER)
	
	-- 伤害系数
    inst.components.combat.damagemultiplier = KKRENV.KKR_DAMAGEMULTIPLIER

	-- 基础防御
	inst.components.health.absorb = KKRENV.KKR_HEALTHABSORB
	
	-- 饥饿速度
	inst.components.hunger.hungerrate = 1 * TUNING.WILSON_HUNGER_RATE

	--温度
	inst.components.temperature.mintemp = -10
	inst.components.temperature.maxtemp = 80
	inst.components.freezable.resistance = 180

	WatchWorldPlants(inst)
	inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)
    if KKRENV.KKR_ATKBUFF_ENABLE then
        inst:ListenForEvent("onhitother", onhitother)
    end
	inst.components.combat.customdamagemultfn = CustomCombatDamage
	inst.kkr_wind_spirit_leader_task = inst:DoPeriodicTask(KKRENV.KKR_SPIRITCD, SpawnButterfly)
    inst.kkr_domain = kkr_domain
	inst.OnLoad = onload
    inst.OnNewSpawn = onload
	
end

KKRENV.MakeCharacterSkin("kkr","kkr_none",{
    name = "可可萝",
    des = "可可萝",
    quotes = "可可萝",
    rarity = "可可萝",
	rarityorder = 1,
    raritycorlor = {123 / 255, 104 / 255, 238 / 255, 1},
    skins = {normal_skin = "kkr", ghost_skin = "ghost_kkr_build"},
    skin_tags = {"BASE", "kkr", "CHARACTER"},
    build_name_override = "kkr",
    share_bigportrait_name = "kkr"
})
KKRENV.MakeCharacterSkin("kkr","kkr_skin_uniform",{
    name = "可可萝（学生服）",
    des = "可可萝（学生服）",
    quotes = "可可萝（学生服）",
    rarity = "可可萝（学生服）",
	rarityorder = 1,
    raritycorlor = {135 / 255, 206 / 255, 250 / 255, 1},
    skins = {normal_skin = "kkr_skin_uniform", ghost_skin = "ghost_kkr_build"},
    skin_tags = {"BASE", "kkr", "CHARACTER"},
    build_name_override = "kkr",
    share_bigportrait_name = "kkr"
})

return MakePlayerCharacter("kkr", prefabs, assets, common_postinit, master_postinit, start_inv)
