
local foods = {

    kkr_kantostyle_stew = {

        --龙尾关东煮
		name = "kkr_kantostyle_stew",
		test = function(cooker, names, tags)
			return names.kkr_dragon_meat and names.twigs 
			and not tags.monster

		end,
		priority = 60, -- 食谱优先级
		weight = 1, -- 食谱权重
		foodtype = FOODTYPE.MEAT, --食物类型
		health = 20, --生命值
		hunger = 50, --饥饿
		sanity = 5, --理智
		perishtime = 7200, --腐烂时间
		cooktime = 0.4, --烹饪时间
		temperature = 50, --温度
		temperatureduration = 120, --温度持续时间
		potlevel = "high",	--在烹饪锅中的位置
		cookbook_tex = "kkr_kantostyle_stew.tex", 		-- 在游戏内食谱书里的mod食物那一栏里显示的图标
		cookbook_atlas = "images/inventoryimages/kkr_foods.xml",
        floater = {"med", nil, 0.55},
        oneatenfn = function (inst, eater)
			if eater:HasTag("player") and eater.components.playercontroller then
				eater:AddDebuff("kkr_kantostyle_stew_debuff", "kkr_kantostyle_stew_debuff")
			end
        end,
		tag = {},
		no_cookpot = true,
    },
	
	kkr_cactus_pancake = {

        --大地仙人掌松饼
		name = "kkr_cactus_pancake",
		test = function(cooker, names, tags)
			return (names.cactus_meat or names.cactus_meat_cooked) and names.honey
			and not tags.monster and not tags.meat 

		end,
		priority = 60, -- 食谱优先级
		weight = 1, -- 食谱权重
		foodtype = FOODTYPE.GOODIES, --食物类型
		health = 40, --生命值
		hunger = 20, --饥饿
		sanity = 30, --理智
		perishtime = 7200, --腐烂时间
		cooktime = 0.4, --烹饪时间
		potlevel = "high",	--在烹饪锅中的位置
		cookbook_tex = "kkr_cactus_pancake.tex", 		-- 在游戏内食谱书里的mod食物那一栏里显示的图标
		cookbook_atlas = "images/inventoryimages/kkr_foods.xml",
        floater = {"med", nil, 0.55},
        oneatenfn = function (inst, eater)
			if eater:HasTag("player") and eater.components.playercontroller then
				if not eater.kkr_cactus_pancake then
					eater.kkr_cactus_pancake = true
				end
			end
        end,
		tag = {},
		no_cookpot = true,
    },

	kkr_sea_snowsugar = {

        --沧海雪糖
		name = "kkr_sea_snowsugar",
		test = function(cooker, names, tags)
			return tags.fruit and tags.fruit >=1 and tags.frozen and tags.frozen >= 1.5
			and not tags.monster and not tags.meat 

		end,
		priority = 60, -- 食谱优先级
		weight = 1, -- 食谱权重
		foodtype = FOODTYPE.GOODIES, --食物类型
		health = 0, --生命值
		hunger = 25, --饥饿
		sanity = 30, --理智
		perishtime = 7200, --腐烂时间
		cooktime = 0.4, --烹饪时间
		temperature = -50, --温度
		temperatureduration = 120, --温度持续时间
		potlevel = "high",	--在烹饪锅中的位置
		cookbook_tex = "kkr_sea_snowsugar.tex", 		-- 在游戏内食谱书里的mod食物那一栏里显示的图标
		cookbook_atlas = "images/inventoryimages/kkr_foods.xml",
        floater = {"med", nil, 0.55},
        oneatenfn = function (inst, eater)
			if eater:HasTag("player") and eater.components.playercontroller then
				eater:AddDebuff("kkr_sea_snowsugar_debuff", "kkr_sea_snowsugar_debuff")
			end
		end,
		tag = {},
		no_cookpot = true,
    },

	kkr_cloudsea_monstermeat = {

        --云海魔物肉
		name = "kkr_cloudsea_monstermeat",
		test = function(cooker, names, tags)
			return tags.monster and tags.monster >=2 and tags.magic and tags.magic >= 1


		end,
		priority = 60, -- 食谱优先级
		weight = 1, -- 食谱权重
		foodtype = FOODTYPE.MEAT, --食物类型
		health = 0, --生命值
		hunger = 150, --饥饿
		sanity = 0, --理智
		perishtime = 7200, --腐烂时间
		cooktime = 0.4, --烹饪时间
		potlevel = "high",	--在烹饪锅中的位置
		cookbook_tex = "kkr_cloudsea_monstermeat.tex", 		-- 在游戏内食谱书里的mod食物那一栏里显示的图标
		cookbook_atlas = "images/inventoryimages/kkr_foods.xml",
        floater = {"med", nil, 0.55},
        oneatenfn = function (inst, eater)
			if eater:HasTag("player") and eater.components.locomotor then
				eater.components.locomotor:SetExternalSpeedMultiplier(inst, "kkr_cloudsea_monstermeat", 1.5)
			end
			eater:DoTaskInTime(5,function ()
				if eater and eater:IsValid() then
					if eater:HasTag("player") then
						if eater.components.locomotor then
							eater.components.locomotor:RemoveExternalSpeedMultiplier(inst, "kkr_cloudsea_monstermeat")
						end
						if eater.components.health then
							eater.components.health:DoDelta(-100)
						end
						
					end
					local x, y, z = eater.Transform:GetWorldPosition()
					local fx = SpawnPrefab("explode_small")
					fx.Transform:SetScale(3, 3, 3)
					fx.Transform:SetPosition(x,y,z)
                    local ents = TheSim:FindEntities(x, y, z, 4, {"_combat", "_health"}, { "INLIMBO", "companion", "wall", "abigail", "shadowminion", "player", "playerghost", "erd_doll" })
					for _, v in ipairs(ents) do
						if v.components.health and not v.components.health:IsDead() and v.components.combat and v ~= inst then
							local val = v.components.health.maxhealth * 0.05
			
							v.components.health:DoDelta(-val, nil, inst.prefab, false, eater, true) --造成伤害
							-- if v.components.health:IsDead() and inst.cause and inst.cause:IsValid() then --推送死亡事件。击杀者为装备者
							-- 	inst.cause:PushEvent("killed", { victim = v })
							-- 	if v.components.combat ~= nil and v.components.combat.onkilledbyother ~= nil then
							-- 		v.components.combat.onkilledbyother(v, inst.cause)
							-- 	end
							-- end
						end
					end
				end
				
			end)
        end,
		tag = {},
		no_cookpot = true,
    },
	


}

return foods
