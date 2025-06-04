_G.EA_CONSTANTS = {
	RPC_NAMESPACE = "EFFICIENT_AGRICULTURE",
	ADDED_HARVEST = GetModConfigData("harvest_machine"),		--是否加入收获机
	ADDED_SEEDING = GetModConfigData("seeding_machine"),		--是否加入播种机
	ADDED_SHOP = GetModConfigData("vending_machine"),			--是否加入商店
	ADDED_PLOW = GetModConfigData("farm_plow_machine"),			--是否加入耕地机

	MAX_ACCEPT_ITEM_NUM = GetModConfigData("max_store_num") or 20,			--肥料制造机最大接受物品数量

	PRICE_COEFFICIENT = GetModConfigData("coefficient_of_price") or 1,		--价格系数
	SHOP_REFRESH_FREQUENCY = GetModConfigData("refresh_frequency") or 2,	--商店刷新周期(天)

	SEEDING_MAX_SIDE = 40,		--自动播种机最大播种边长

	HARVEST_MACHINE_CHECK_INTERVAL = GetModConfigData("harvest_machine_check_interval") or 4,	--自动收获机检查周期(秒)
	HARVEST_MACHINE_CHECK_WIDTH = 4,	--单向自动收获机有效宽度
	HARVEST_MACHINE_CHECK_LENGTH = 12,	--单向自动收获机有效长度
	HARVEST_MACHINE_CHECK_SIDE = 8,		--范围自动收货机有效边长
	HARVEST_MACHINE_PLACER_ROTATE_KEY = GetModConfigData("harvest_machine_rotate_key") or "R",	--自动收获机Placer旋转按键

	SELECT_UNIT_BUTTON = MOUSEBUTTON_LEFT,		--选择地块的鼠标按键
	DISELECT_TILE_BUTTON = MOUSEBUTTON_RIGHT,	--取消选择地块的鼠标按键
	FARM_PLOW_DRILLING_DURATION = 5,			--开垦一块地的时长
	TILL_DURATION = 0.5,						--挖每个坑的时长
	PLOW_TILE_MACHINE_MOVE_SPEED = 2,			--耕地机的移速
	PLOW_MACHINE_CHECK_INTERVAL = 4,			--自动耕地机检查周期(秒)

	MOD_PLANTS = {	--其他MOD里的作物
		--棱镜
		pineananas = "pineananas",
		catmint = "catmint",
	},

	ENABLED_MODS = {		--启用的MOD
		legion = _G.KnownModIndex:IsModEnabled("workshop-1392778117") and TUNING.LEGION_NEWCROPS,	--棱镜
	},

	ENABLE_HARVEST_MACHINE_AREA_SHOW = GetModConfigData("enable_harvest_machine_area_show"),
	ENABLE_HARVEST_MACHINE_AUTO_PICKING_UP = GetModConfigData("enable_harvest_machine_auto_pickup"),

	SEEDING_MACHINE_WORKING_MODES = {
		SEQUENCE = 1,       --从第一个格子开始依次播种
		BY_LOCATION = 2,    --按照种子在格子中的位置进行播种
	},
}