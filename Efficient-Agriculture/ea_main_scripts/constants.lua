_G.EA_CONSTANTS = {
	RPC_NAMESPACE = "EFFICIENT_AGRICULTURE",
	ADDED_HARVEST = GetModConfigData("harvest_machine"),		
	ADDED_SEEDING = GetModConfigData("seeding_machine"),		
	ADDED_SHOP = GetModConfigData("vending_machine"),			
	ADDED_PLOW = GetModConfigData("farm_plow_machine"),			

	MAX_ACCEPT_ITEM_NUM = GetModConfigData("max_store_num") or 20,			

	PRICE_COEFFICIENT = GetModConfigData("coefficient_of_price") or 1,		
	SHOP_REFRESH_FREQUENCY = GetModConfigData("refresh_frequency") or 2,	

	SEEDING_MAX_SIDE = 40,		

	HARVEST_MACHINE_CHECK_INTERVAL = GetModConfigData("harvest_machine_check_interval") or 4,	
	HARVEST_MACHINE_CHECK_WIDTH = 4,	
	HARVEST_MACHINE_CHECK_LENGTH = 12,	
	HARVEST_MACHINE_CHECK_SIDE = 8,		
	HARVEST_MACHINE_PLACER_ROTATE_KEY = GetModConfigData("harvest_machine_rotate_key") or "R",	

	SELECT_UNIT_BUTTON = MOUSEBUTTON_LEFT,		
	DISELECT_TILE_BUTTON = MOUSEBUTTON_RIGHT,	
	FARM_PLOW_DRILLING_DURATION = 5,			
	TILL_DURATION = 0.5,						
	PLOW_TILE_MACHINE_MOVE_SPEED = 2,			
	PLOW_MACHINE_CHECK_INTERVAL = 4,			

	MOD_PLANTS = {	
		pineananas = "pineananas",
		catmint = "catmint",
	},

	ENABLED_MODS = {		
		legion = _G.KnownModIndex:IsModEnabled("workshop-1392778117") and TUNING.LEGION_NEWCROPS,	
	},

	ENABLE_HARVEST_MACHINE_AREA_SHOW = GetModConfigData("enable_harvest_machine_area_show"),
	ENABLE_HARVEST_MACHINE_AUTO_PICKING_UP = GetModConfigData("enable_harvest_machine_auto_pickup"),

	SEEDING_MACHINE_WORKING_MODES = {
		SEQUENCE = 1,       
		BY_LOCATION = 2,    
	},
}