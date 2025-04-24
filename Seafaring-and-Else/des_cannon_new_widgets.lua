------------------------------------------------------
----------------------- WIDGET -----------------------
------------------------------------------------------
_G = GLOBAL
local Recipe = GLOBAL.Recipe
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local STRINGS = GLOBAL.STRINGS
local TUNING = GLOBAL.TUNING
local ACTIONS = GLOBAL.ACTIONS
local STRINGS = GLOBAL.STRINGS
local TECH = GLOBAL.TECH
local STRINGS = GLOBAL.STRINGS
local Action = GLOBAL.Action
local require = GLOBAL.require
local EQUIPSLOTS = GLOBAL.EQUIPSLOTS
local GetString=GLOBAL.GetString
local SpawnPrefab=GLOBAL.SpawnPrefab
local FOODTYPE = GLOBAL.FOODTYPE
local TheSim = GLOBAL.TheSim
local Vector3 = GLOBAL.Vector3

---------------------- function ----------------------
local function widgetcreation()
	---TUNING.DES_CANNON_WIDGETS = {}
	------CANNON! 4 SLOTs ----- 
	
	local des_water_backpocket_y = -4
	local des_water_backpocket_y2 = -12
	
	TUNING.DES_CANNON_WIDGETS.des_bcannon =
	{
		widget =
		{
			slotpos =
			{
				Vector3(0, 64 + 32 + 8 + des_water_backpocket_y, 0), 
				Vector3(0, 32  + des_water_backpocket_y, 0),
				Vector3(0, -(32) + des_water_backpocket_y2, 0), 
				Vector3(0, -(64 + 32 + 8) + des_water_backpocket_y2, 0),
			},
			animbank = "ui_cookpot_1x4",
			animbuild = "ui_cookpot_1x4",
			pos = Vector3(100, -150, 0),
			side_align_tip = 100,
		},
	type = "chest",
	}
	function TUNING.DES_CANNON_WIDGETS.des_bcannon.itemtestfn(container, item, slot)
		--if item:HasTag("des_bottle") and not item:HasTag("des_bucket") then
			return true
		--end
		--return false
	end	
	
	
	
	
	
	local containers = _G.require("containers")
	-- containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, params.des_unibucket_one_slot.widget.slotpos ~= nil and #params.des_unibucket_one_slot.widget.slotpos or 0)

	local old_widgetsetup = containers.widgetsetup
	function containers.widgetsetup(container, prefab, data, ...)
		local pref = prefab or container.inst.prefab
		local name = pref 
		if container.inst:HasTag("des_bcannon") then
			name = "des_bcannon"
		end
		if name == "des_bcannon" then
			local t = TUNING.DES_CANNON_WIDGETS[name]
			if t ~= nil then
				for k, v in pairs(t) do
					container[k] = v
				end
			container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
			end
		else
			return old_widgetsetup(container, prefab, data, ...)
		end
	end
end


---------------------- call function ----------------------
widgetcreation()

---------------------------------------------------