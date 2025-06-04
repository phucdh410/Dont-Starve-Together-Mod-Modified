local containers = require("containers")
local params = {}

local WEED_DEFS = require("prefabs/weed_defs").WEED_DEFS

params.ea_seeding_machine = {
    widget = {
        slotpos = {
            Vector3(-72, 72, 0), Vector3(0, 72, 0), Vector3(72, 72, 0),
            Vector3(-72, 0, 0), Vector3(0, 0, 0), Vector3(72, 0, 0),
            Vector3(-72, -72, 0), Vector3(0, -72, 0), Vector3(72, -72, 0),
        },
        animbank = "ui_chest_3x3",
        animbuild = "ui_chest_3x3",
        pos = Vector3(),
        buttoninfo = {
            text = STRINGS.EA_SEED_BUTTON,
            position = Vector3(-60, -125, 0),
            fn = function(inst, doer)
                if inst.components.container ~= nil then
                    inst.components.ea_seeding_machine:SetWorkingMode(EA_CONSTANTS.SEEDING_MACHINE_WORKING_MODES.SEQUENCE)
                    inst.components.ea_seeding_machine:StartSeeding(doer)
                elseif inst.replica.container ~= nil and not inst.replica.container:IsBusy() then
                    SendModRPCToServer(MOD_RPC[EA_CONSTANTS.RPC_NAMESPACE].start_seeding, inst, EA_CONSTANTS.SEEDING_MACHINE_WORKING_MODES.SEQUENCE)
                end
            end,
            validfn = function(inst)
                return inst.replica.container ~= nil and not inst.replica.container:IsEmpty()
            end,
            hover_text = STRINGS.EA_SEED_BUTTON_HOVER,
            hover_params = {},
        },
        buttoninfo2 = {
            text = STRINGS.EA_SEED_BUTTON2,
            position = Vector3(60, -125, 0),
            fn = function(inst, doer)
                if inst.components.container ~= nil then
                    inst.components.ea_seeding_machine:SetWorkingMode(EA_CONSTANTS.SEEDING_MACHINE_WORKING_MODES.BY_LOCATION)
                    inst.components.ea_seeding_machine:StartSeeding(doer)
                elseif inst.replica.container ~= nil and not inst.replica.container:IsBusy() then
                    SendModRPCToServer(MOD_RPC[EA_CONSTANTS.RPC_NAMESPACE].start_seeding, inst, EA_CONSTANTS.SEEDING_MACHINE_WORKING_MODES.BY_LOCATION)
                end
            end,
            validfn = function(inst)
                return inst.replica.container ~= nil and not inst.replica.container:IsEmpty()
            end,
            hover_text = STRINGS.EA_SEED_BUTTON_HOVER2,
            hover_params = {},
        },
    },
    numslots = 9,
    acceptsstacks = true,
    usespecificslotsforitems = false,
    issidewidget = false,
    type = "seeding",
    itemtestfn = function(inst, item, slot) return EA_TOOLS.IsValidSeed(item) end
}

params.ea_fertilizer_machine = {
    widget = {
        slotpos = {Vector3(0, -10, 0)},
        animbank = "ea_ui_seeding_1x1",
        animbuild = "ea_ui_seeding_1x1",
        pos = Vector3(),
        buttoninfo = {
            text = STRINGS.EA_FERTILIZER_BUTTON,
            position = Vector3(0, -70, 0),
            fn = function(inst, doer)
                if inst.components.container ~= nil then
                    BufferedAction(doer, inst, ACTIONS.TUNRON_FERTILIZER_MACHINE):Do()
                elseif inst.replica.container ~= nil and not inst.replica.container:IsBusy() then
                    SendRPCToServer(RPC.DoWidgetButtonAction, ACTIONS.TUNRON_FERTILIZER_MACHINE.code, inst, ACTIONS.TUNRON_FERTILIZER_MACHINE.mod_name)
                end
            end,
            validfn = function(inst)
                return inst.replica.container ~= nil and not inst.replica.container:IsEmpty()
            end
        },
    },
    numslots = 1,
    acceptsstacks = true,
    usespecificslotsforitems = false,
    issidewidget = false,
    type = "seeding",
}

local harvest_slotpos = {}
    for y = 2, -4, -1 do
        for x = -3, 3 do
            table.insert(harvest_slotpos, GLOBAL.Vector3(75 * x+37.5, 75 * y+37.5, 0))
        end
    end
params.ea_harvest_machine = {
    widget = {
        slotpos = harvest_slotpos,
        animbank = "bmui_7x7",
        animbuild = "bmui_7x7",
        pos = Vector3(0, -200, 0),
    },
    numslots = 49,
    acceptsstacks = true,
    usespecificslotsforitems = false,
    issidewidget = false,
    type = "harvest",
    itemtestfn = function(inst, item, slot)
        if EA_TOOLS.IsValidVeggie(item) or EA_TOOLS.IsValidSeed(item) or EA_TOOLS.IsValidFarmPlant(item) or EA_TOOLS.IsWeed(item) then
            return true
        end
		for weed, data in pairs(WEED_DEFS) do
			if data.product == item.prefab then
				return true
			end
		end
        return false
    end,
}

params.ea_harvest_machine2 = params.ea_harvest_machine

for prefabs, data in pairs(params) do
    containers.params[prefabs] = data
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, data.widget.slotpos ~= nil and #data.widget.slotpos or 0)
end