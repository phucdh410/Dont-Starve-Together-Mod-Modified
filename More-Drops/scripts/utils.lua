local utils = {}

utils.Bind = function(fn, ...)
	local args = {...}
	return function(...)
		local placeholders = {...}
		return fn(unpack(args), unpack(placeholders))
	end
end

utils.RunFunctionServerOnly = function(fn, ...)
	local args = {...}
	--Check for multiplayer
	if TheSim:GetGameID() == "DST" then
		--Make sure this is only being done on the server
		if TheWorld.ismastersim then
			fn(unpack(args))
		end
	else
		--SP doesn't need to check for server
		fn(unpack(args))
	end
end

utils.DropLootRandom = function(inst, prefab, chance)
	local rand = math.random() - chance
	if rand <= 0 then
		inst.components.lootdropper:SpawnLootPrefab(prefab)
    return true
	end
end
utils.DropLootRandomWithAmount = function(inst, prefab, chance, amount)
	local rand = math.random() - chance
	if rand <= 0 then
		for i = 1, amount do
			inst.components.lootdropper:SpawnLootPrefab(prefab)
		end
    return true
	end
end
utils.DropLootRandomPick = function(inst, prefab_list, chances)
	assert(#prefab_list == #chances, "Number of prefab_list specified does not match number of chances specified")
	local rand = math.random(#prefab_list)
	return utils.DropLootRandom(inst, prefab_list[rand], chances[rand])
end

utils.GiveLootRandom = function(owner, prefab, chance)
	local rand = math.random() - chance
	if rand <= 0 then
			owner.components.inventory:GiveItem(SpawnPrefab(prefab), nil)
    return true
	end
end

utils.LootRandom = function(chance)
	if math.random() - chance <= 0 then
		return true
	end
end

utils.GiveLootRandomPick = function(owner, prefab_list, chances)
	assert(#prefab_list == #chances, "Number of prefab_list specified does not match number of chances specified")
	local rand = math.random(#prefab_list)
	return utils.GiveLootRandom(owner, prefab_list[rand], chances[rand])
end

utils.DoTimes = function(times, fn, ...)
  if times == 0 then
    return
  end
	for i = 1, times do
		fn(...)
	end
end

utils.PrintMembers = function(object)
	for i,v in pairs(object) do
		print(v)
	end
end

utils.setSeed = function()
	math.random(os.time())
end

utils.Jackpot = function(inst, worker, amount, prefabsList)
	for _,prefab in ipairs(prefabsList) do
		-- local loot = SpawnPrefab(prefab)
		-- if loot and worker then
		-- 	for i = 1, amount do
		-- 		worker.components.inventory:GiveItem(loot)
		-- 	end
		-- end
		if loot and inst then
			for i = 1, amount do
				inst.components.lootdropper:SpawnLootPrefab(prefab)
			end
		end
	end

	-- Sound still not working
	if worker and worker:HasTag("player") then
		worker.components.talker:Say("Jackpot!")

		if worker.SoundEmitter then
			print("PLAYER HAS SOUND")
			worker.SoundEmitter:PlaySound("dontstarve/HUD/research_available")
		end
	end
end

return utils