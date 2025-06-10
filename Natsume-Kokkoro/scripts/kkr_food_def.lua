local foods = {
	kkr_kantostyle_stew = {
			name = "kkr_kantostyle_stew",
			test = function(cooker, names, tags)
					return names.kkr_dragon_meat and names.twigs and not tags.monster
			end,
			priority = 60,
			weight = 1,
			foodtype = FOODTYPE.MEAT,
			health = 20,
			hunger = 50,
			sanity = 5,
			perishtime = 7200,
			cooktime = 0.4,
			temperature = 50,
			temperatureduration = 120,
			potlevel = "high",
			cookbook_tex = "kkr_kantostyle_stew.tex",
			cookbook_atlas = "images/inventoryimages/kkr_foods.xml",
			floater = {"med", nil, 0.55},
			oneatenfn = function(inst, eater)
					if eater:HasTag("player") and eater.components.playercontroller then
							eater:AddDebuff("kkr_kantostyle_stew_debuff", "kkr_kantostyle_stew_debuff")
					end
			end,
			tag = {},
			no_cookpot = true
	},
	kkr_cactus_pancake = {
			name = "kkr_cactus_pancake",
			test = function(cooker, names, tags)
					return (names.cactus_meat or names.cactus_meat_cooked) and names.honey and not tags.monster and
							not tags.meat
			end,
			priority = 60,
			weight = 1,
			foodtype = FOODTYPE.GOODIES,
			health = 40,
			hunger = 20,
			sanity = 30,
			perishtime = 7200,
			cooktime = 0.4,
			potlevel = "high",
			cookbook_tex = "kkr_cactus_pancake.tex",
			cookbook_atlas = "images/inventoryimages/kkr_foods.xml",
			floater = {"med", nil, 0.55},
			oneatenfn = function(inst, eater)
					if eater:HasTag("player") and eater.components.playercontroller then
							if not eater.kkr_cactus_pancake then
									eater.kkr_cactus_pancake = true
							end
					end
			end,
			tag = {},
			no_cookpot = true
	},
	kkr_sea_snowsugar = {
			name = "kkr_sea_snowsugar",
			test = function(cooker, names, tags)
					return tags.fruit and tags.fruit >= 1 and tags.frozen and tags.frozen >= 1.5 and not tags.monster and
							not tags.meat
			end,
			priority = 60,
			weight = 1,
			foodtype = FOODTYPE.GOODIES,
			health = 0,
			hunger = 25,
			sanity = 30,
			perishtime = 7200,
			cooktime = 0.4,
			temperature = -50,
			temperatureduration = 120,
			potlevel = "high",
			cookbook_tex = "kkr_sea_snowsugar.tex",
			cookbook_atlas = "images/inventoryimages/kkr_foods.xml",
			floater = {"med", nil, 0.55},
			oneatenfn = function(inst, eater)
					if eater:HasTag("player") and eater.components.playercontroller then
							eater:AddDebuff("kkr_sea_snowsugar_debuff", "kkr_sea_snowsugar_debuff")
					end
			end,
			tag = {},
			no_cookpot = true
	},
	kkr_cloudsea_monstermeat = {
			name = "kkr_cloudsea_monstermeat",
			test = function(cooker, names, tags)
					return tags.monster and tags.monster >= 2 and tags.magic and tags.magic >= 1
			end,
			priority = 60,
			weight = 1,
			foodtype = FOODTYPE.MEAT,
			health = 0,
			hunger = 150,
			sanity = 0,
			perishtime = 7200,
			cooktime = 0.4,
			potlevel = "high",
			cookbook_tex = "kkr_cloudsea_monstermeat.tex",
			cookbook_atlas = "images/inventoryimages/kkr_foods.xml",
			floater = {"med", nil, 0.55},
			oneatenfn = function(inst, eater)
					if eater:HasTag("player") and eater.components.locomotor then
							eater.components.locomotor:SetExternalSpeedMultiplier(inst, "kkr_cloudsea_monstermeat", 1.5)
					end
					eater:DoTaskInTime(
							5,
							function()
									if eater and eater:IsValid() then
											if eater:HasTag("player") then
													if eater.components.locomotor then
															eater.components.locomotor:RemoveExternalSpeedMultiplier(
																	inst,
																	"kkr_cloudsea_monstermeat"
															)
													end
													if eater.components.health then
															eater.components.health:DoDelta(-100)
													end
											end
											local x, y, z = eater.Transform:GetWorldPosition()
											local fx = SpawnPrefab("explode_small")
											fx.Transform:SetScale(3, 3, 3)
											fx.Transform:SetPosition(x, y, z)
											local ents =
													TheSim:FindEntities(
													x,
													y,
													z,
													4,
													{"_combat", "_health"},
													{
															"INLIMBO",
															"companion",
															"wall",
															"abigail",
															"shadowminion",
															"player",
															"playerghost",
															"erd_doll"
													}
											)
											for _, v in ipairs(ents) do
													if
															v.components.health and not v.components.health:IsDead() and v.components.combat and
																	v ~= inst
													 then
															local val = v.components.health.maxhealth * 0.05

															v.components.health:DoDelta(-val, nil, inst.prefab, false, eater, true)
													end
											end
									end
							end
					)
			end,
			tag = {},
			no_cookpot = true
	}
}

return foods
