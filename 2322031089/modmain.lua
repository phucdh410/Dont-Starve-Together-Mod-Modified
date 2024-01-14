local AMOUNT = GetModConfigData("seed_amount") -- default is 2 seed

local TYPE = GetModConfigData("drop_type") -- default is random

local REGULARSEED = GetModConfigData("regular_seed") -- default is disabled

local SEEDCHANCE = GetModConfigData("seed_chance") -- default is 50% chance

AddPrefabPostInit("birdcage", function(inst)    
	if not GLOBAL.TheWorld.ismastersim then 
		return
	end 

local old_onaccept = inst.components.trader.onaccept    
local function DigestFoodNew(inst, food)        
    local seed_name = string.lower(food.prefab .. "_seeds")
	if GLOBAL.Prefabs[seed_name] ~= nil then
		-- Mod script start
		if TYPE < 2 then -- Add random specific seed drop
			local num_seeds = math.random(AMOUNT + 1)
				for k = 1, num_seeds do
				inst.components.lootdropper:SpawnLootPrefab(seed_name)
			end
		else --Add fixed seed drop
			local num_seeds = AMOUNT
			for k = 1, num_seeds do
				inst.components.lootdropper:SpawnLootPrefab(seed_name)
			end
		end -- Add Regular seed to drop
		if REGULARSEED < 2 then
			if math.random() < SEEDCHANCE then
				inst.components.lootdropper:SpawnLootPrefab("seeds")
			end
		end
		-- Mod script end 
	end
end    

local function OnGetItemNew(inst, giver, item)        
	old_onaccept(inst, giver, item)        
	if inst.components.trader.test(inst, item) then            
		inst:DoTaskInTime(63 * GLOBAL.FRAMES, DigestFoodNew, item)        
	end    
end    

inst.components.trader.onaccept = OnGetItemNew
	
end)