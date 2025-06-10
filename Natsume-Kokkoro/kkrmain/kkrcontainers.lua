local containers = require "containers"
local params = containers.params

params.kkr_pocket =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x2",
        animbuild = "ui_chest_3x2",
        pos = Vector3(0, 200, 0),

    },
    type = "kkr_pocket",
}

for y = 1, 0, -1 do
    for x = 0, 2 do
        table.insert(params.kkr_pocket.widget.slotpos, Vector3(80 * x - 80 * 2 + 80, 80 * y - 80 * 2 + 120, 0))
    end
end
function params.kkr_pocket.itemtestfn(container, item, slot)
    return not (item:HasTag("irreplaceable") or item:HasTag("_container"))
end

params.kkr_pocket_plus =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_chest_3x3",
        pos = Vector3(0, 200, 0),

    },
    type = "kkr_pocket_plus",
}

for y = 2, 0, -1 do
    for x = 0, 2 do
        table.insert(params.kkr_pocket_plus.widget.slotpos, Vector3(80 * x - 80 * 2 + 80, 80 * y - 80 * 2 + 80, 0))
    end
end
function params.kkr_pocket_plus.itemtestfn(container, item, slot)
    return not (item:HasTag("irreplaceable") or item:HasTag("_container"))
end

params.kkr_newyear_staff = {
    widget = {
        slotpos = {
            Vector3(0, 32 + 4, 0)
        },
        animbank = 'ui_cookpot_1x2',
        animbuild = 'ui_cookpot_1x2',
        pos = Vector3(0, 15, 0)
    },
    type = 'hand_inv'
}
