local json = require "json"

-------------------------
-- [Server Handle]
-------------------------

AddModRPCHandler(EA_CONSTANTS.RPC_NAMESPACE, "spawn_plowsolid", function(player, tiles)
	tiles = json.decode(tiles)
	if player._current_operate_plow_tile_machine and player._current_operate_plow_tile_machine.doer == player then
		player._current_operate_plow_tile_machine:SetTilesAndStart(tiles)
	end
end)

AddModRPCHandler(EA_CONSTANTS.RPC_NAMESPACE, "start_seeding", function(player, machine, mode)
	if machine ~= nil and type(mode) == "number" then
		for key, v in pairs(EA_CONSTANTS.SEEDING_MACHINE_WORKING_MODES) do
			if v == mode then
				machine.components.ea_seeding_machine:SetWorkingMode(mode)
				break
			end
		end
		machine.components.ea_seeding_machine:StartSeeding(player)
	end
end)

-------------------------
-- [Client Handle]
-------------------------