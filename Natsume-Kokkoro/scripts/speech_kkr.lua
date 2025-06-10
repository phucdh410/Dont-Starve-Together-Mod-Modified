return
{
	ACTIONFAIL =
	{
        APPRAISE =
        {
            NOTNOW = "在下做不到",		--暂无注释
        },
        REPAIR =
        {
            WRONGPIECE = "这样拼可能不太对。",		--化石骨架拼接错误
        },
        BUILD =
        {
            MOUNTED = "在下需要脚踏实地。",		--建造失败（骑乘状态）
            HASPET = "已经有一只宠物了哦。",		--建造失败（已经有一个宠物了）
			TICOON = "如果是凯露小姐的话....",		--暂无注释
        },
		SHAVE =
		{
			AWAKEBEEFALO = "还是等晚上再说吧。",		--给醒着的牛刮毛
			GENERIC = "在下不能给它剃毛",		--刮牛毛失败
			NOBITS = "牛毛的生长需要微风与时间。",		--给没毛的牛刮毛
            REFUSE = "only_used_by_woodie",		--暂无注释
            SOMEONEELSESBEEFALO = "那样做可能不太礼貌哦。",		--暂无注释
		},
		STORE =
		{
			GENERIC = "已经装不下了哦。",		--存放东西失败
			NOTALLOWED = "装到这里可能不太对。",		--存放东西--不被允许
			INUSE = "还是让别人先用吧。",		--别人正在用箱子
            NOTMASTERCHEF = "在下需要继续精进厨艺。",		--暂无注释
		},
        CONSTRUCT =
        {
            INUSE = "还是让别人先用吧。",		--建筑正在使用
            NOTALLOWED = "不匹配。",		--建筑不允许使用
            EMPTY = "在下的准备不够充分。",		--建筑空了
            MISMATCH = "哎呀，计划错误。",		--升级套件错误（目前用不到）
            NOTREADY = "情况稳定下来之后它可能会出现。",		--暂无注释
        },
		RUMMAGE =
		{
			GENERIC = "暂时还不行哦。",		--打开箱子失败
			INUSE = "还是让别人先用吧。",		--打开箱子 正在使用
            NOTMASTERCHEF = "如果在下的料理水平再进一步的话.....",		--暂无注释
		},
		UNLOCK =
        {
        	WRONGKEY = "难以为继。",		--暂无注释
        },
		USEKLAUSSACKKEY =
        {
        	WRONGKEY = "好像不是这根角。",		--使用克劳斯钥匙
        	KLAUS = "分身乏术",		--克劳斯
        },
		ACTIVATE =
		{
			LOCKED_GATE = "大门锁上了。",		--远古钥匙
            HOSTBUSY = "他现在好像有点忙。",		--暂无注释
            CARNIVAL_HOST_HERE = "他就在附近。",		--暂无注释
            NOCARNIVAL = "鸟儿看起来都飞走了。",		--暂无注释
			EMPTY_CATCOONDEN = "这比佩可小姐的肚子还要空。",		--暂无注释
			KITCOON_HIDEANDSEEK_NOT_ENOUGH_HIDERS = "应该不会这么容易，要是再多几个小家伙就好了……",		--暂无注释
			KITCOON_HIDEANDSEEK_NOT_ENOUGH_HIDING_SPOTS = "周围没有很多地方可供它们藏身。",		--暂无注释
			KITCOON_HIDEANDSEEK_ONE_GAME_PER_DAY = "在下想今天就到此为止吧。",		--暂无注释
            MANNEQUIN_EQUIPSWAPFAILED = "他应该穿不上。",		--暂无注释
            PILLOWFIGHT_NO_HANDPILLOW = "在下需要一个枕头来战斗！",		--暂无注释
            NOTMYBERNIE = "在下的毛绒玩具可没那么可怕。",		--暂无注释
		},
		OPEN_CRAFTING =
		{
            PROFESSIONALCHEF = "如果在下的料理水平再进一步的话....。",		--暂无注释
			SHADOWMAGIC = "精灵先生也不认识这个。",		--暂无注释
		},
        COOK =
        {
            GENERIC = "暂时还不能进行料理。",		--做饭失败
            INUSE = "在下可以等等。",		--做饭失败-别人在用锅
            TOOFAR = "在下应该再近一点。",		--做饭失败-太远
        },
        START_CARRAT_RACE =
        {
            NO_RACERS = "在下的准备不足",		--暂无注释
        },
		DISMANTLE =
		{
			COOKING = "它正在工作，请稍安勿躁。",		--暂无注释
			INUSE = "在下会耐心等待。",		--暂无注释
			NOTEMPTY = "在下得先把里面的东西弄走。",		--暂无注释
        },
        FISH_OCEAN =
		{
			TOODEEP = "如果是海钓竿的话就可以给凯露小姐钓一些鱼。",		--暂无注释
		},
        OCEAN_FISHING_POND =
		{
			WRONGGEAR = "杀鸡焉用牛刀。",		--暂无注释
		},
        READ =
        {
            GENERIC = "only_used_by_waxwell_and_wicker",		--暂无注释
            NOBIRDS = "only_used_by_waxwell_and_wicker",		--暂无注释
            NOWATERNEARBY = "only_used_by_waxwell_and_wicker",		--暂无注释
            TOOMANYBIRDS = "only_used_by_waxwell_and_wicker",		--暂无注释
            WAYTOOMANYBIRDS = "only_used_by_waxwell_and_wicker",		--暂无注释
            NOFIRES =       "only_used_by_waxwell_and_wicker",		--暂无注释
            NOSILVICULTURE = "only_used_by_waxwell_and_wicker",		--暂无注释
            NOHORTICULTURE = "only_used_by_waxwell_and_wicker",		--暂无注释
            NOTENTACLEGROUND = "only_used_by_waxwell_and_wicker",		--暂无注释
            NOSLEEPTARGETS = "only_used_by_waxwell_and_wicker",		--暂无注释
            TOOMANYBEES = "only_used_by_waxwell_and_wicker",		--暂无注释
            NOMOONINCAVES = "only_used_by_waxwell_and_wicker",		--暂无注释
            ALREADYFULLMOON = "only_used_by_waxwell_and_wicker",		--暂无注释
        },
        GIVE =
        {
            GENERIC = "看来他没有办法收下。",		--给予失败
            DEAD = "在下……暂时代为保管吧。",		--给予 -目标死亡
            SLEEPING = "等他睡醒了再说吧。",		--给予--目标睡觉
            BUSY = "在下马上再试试。",		--给予--目标正忙
            ABIGAILHEART = "阿比盖尔小姐？。",		--给阿比盖尔 救赎之心
            GHOSTHEART = "不可思议的奇迹。",		--给鬼魂 救赎之心
            NOTGEM = "放错了，再尝试一下吧。",		--给的不是宝石
            WRONGGEM = "好像不是这颗宝石哦。",		--给错了宝石
            NOTSTAFF = "我们用试一下唤星法杖把。",		--给月石祭坛的物品不是法杖
            MUSHROOMFARM_NEEDSSHROOM = "把蘑菇孢子放上去试试吧。",		--蘑菇农场需要蘑菇
            MUSHROOMFARM_NEEDSLOG = "或许……可以放上一些活木试试。",		--蘑菇农场需要活木
            MUSHROOMFARM_NOMOONALLOWED = "这些蘑菇好像不愿意被种下去！",		--暂无注释
            SLOTFULL = "桌子上有材料哦，我们试着把它雕刻的漂漂亮亮吧。",		--已经放了材料后，再给雕像桌子再给一个材料
            FOODFULL = "这儿已经有一顿饭了。",		--没调用
            NOTDISH = "它肯定不想吃那个。",		--没调用
            DUPLICATE = "已经有这个图纸了。",		--给雕像桌子已经学习过的图纸
            NOTSCULPTABLE = "我们应该换一种材料试试。。",		--给陶艺圆盘的东西不对
            NOTATRIUMKEY = "何方圜之能周兮。",		--中庭钥匙不对
            CANTSHADOWREVIVE = "它还在休息。",		--中庭仍在CD
            WRONGSHADOWFORM = "拼接好像出了点问题。",		--没调用
            NOMOON = "能看到月亮就好了。",		--洞穴里建造月石科技
			PIGKINGGAME_MESSY = "清理一下场地吧。",		--猪王旁边有建筑，不能开始抢元宝
			PIGKINGGAME_DANGER = "先把不稳定因素去除再一起玩吧。",		--危险，不能开始抢元宝
			PIGKINGGAME_TOOLATE = "天黑了，我们回家吧。",		--不是白天，不能开始抢元宝
			CARNIVALGAME_INVALID_ITEM = "要有钱才行哦。",		--暂无注释
			CARNIVALGAME_ALREADY_PLAYING = "已经有游戏在进行中了。",		--暂无注释
            SPIDERNOHAT = "在下的口袋不能同时装下它们",		--暂无注释
            TERRARIUM_REFUSE = "换一种材料试试？",		--暂无注释
            TERRARIUM_COOLDOWN = "需要风带给它足够的成长。",		--暂无注释
            NOTAMONKEY = "抱歉，在下不会猴语。",		--暂无注释
            QUEENBUSY = "她好像在忙。",		--暂无注释
        },
        GIVETOPLAYER =
        {
            FULL = "如果东西太多的话，让在下代为保管吧。",		--给玩家一个东西 -但是背包满了
            DEAD = "我们还是先帮助他吧。",		--给死亡的玩家一个东西
            SLEEPING = "嘘......",		--给睡觉的玩家一个东西
            BUSY = "再等等吧。",		--给忙碌的玩家一个东西
        },
        GIVEALLTOPLAYER =
        {
            FULL = "如果东西太多的话，让在下代为保管吧。",		--给人一组东西 但是背包满了
            DEAD = "我们还是先帮助他吧。",		--给于死去的玩家一组物品
            SLEEPING = "嘘......",		--给于正在睡觉的玩家一组物品
            BUSY = "再等等。",		--给于正在忙碌的玩家一组物品
        },
        WRITE =
        {
            GENERIC = "在下觉得它现在这样挺好。",		--鞋子失败
            INUSE = "先让伙伴画。",		--写字 正在使用中
        },
        DRAW =
        {
            NOIMAGE = "放下一个物品参照才能画画哦。",		--画图缺乏图像
        },
        CHANGEIN =
        {
            GENERIC = "在下就穿这身就好。",		--换装失败 
            BURNING = "快先灭火！",		--换装失败-着火了
            INUSE = "伙伴正在使用，在下可以再等等。",		--衣橱有人占用
            NOTENOUGHHAIR = "皮毛不够用来装扮。",		--暂无注释
            NOOCCUPANT = "得在上面栓点东西。",		--暂无注释
        },
        ATTUNE =
        {
            NOHEALTH = "身体好像有些不舒服，先休息一下吧。",		--制造肉雕像血量不足
        },
        MOUNT =
        {
            TARGETINCOMBAT = "它现在很生气！",		--骑乘，牛正在战斗
            INUSE = "别人正在使用，在下可以先等等。",		--骑乘（牛被占据）
			SLEEPING = "该起床了。",		--暂无注释
        },
        SADDLE =
        {
            TARGETINCOMBAT = "在下需要用微风安抚它的情绪。",		--给战斗状态的牛上鞍
        },
        TEACH =
        {
            KNOWN = "在下已成竹在胸。",		--学习已经知道的蓝图
            CANTLEARN = "力有不逮。",		--学习无法学习的蓝图
            WRONGWORLD = "这似乎。。。不是这里的地图。",		--学习另外一个世界的地图
			MESSAGEBOTTLEMANAGER_NOT_FOUND = "光线太暗，在下看不清！",--Likely trying to read messagebottle treasure map in caves		--暂无注释
            STASH_MAP_NOT_FOUND = "恕在下不能理解。",-- Likely trying to read stash map  in world without stash                  		--暂无注释
        },
        WRAPBUNDLE =
        {
            EMPTY = "未知变成空白，真是令人失落。",		--打包纸是空的
        },
        PICKUP =
        {
			RESTRICTION = "技能不够熟练，用不了。",		--熔炉模式下捡起错误的武器
			INUSE = "应该再等等。",		--捡起已经打开的容器
            NOTMINE_SPIDER = "only_used_by_webber",		--暂无注释
            NOTMINE_YOTC =
            {
                "你可不是在下的胡萝卜鼠。",		--暂无注释
                "噢，它咬我！",		--暂无注释
            },
			NO_HEAVY_LIFTING = "only_used_by_wanda",		--暂无注释
            FULL_OF_CURSES = "在下才不想碰。",		--暂无注释
        },
        SLAUGHTER =
        {
            TOOFAR = "它逃跑了。",		--屠杀？？ 因为太远而失败
        },
        REPLATE =
        {
            MISMATCH = "它需要另一种碟子。",		--暴食-换盘子换错了 比如用碗换碟子
            SAMEDISH = "在下只需要用一个碟子。",		--暴食-换盘子已经换了
        },
        SAIL =
        {
        	REPAIR = "它不需要修理。",		--暂无注释
        },
        ROW_FAIL =
        {
            BAD_TIMING0 = "划得太快了",		--暂无注释
            BAD_TIMING1 = "时机掌握的不太好",		--暂无注释
            BAD_TIMING2 = "要更加注意",		--暂无注释
        },
        LOWER_SAIL_FAIL =
        {
            "哎呦！",		--暂无注释
            "根本慢不下来！",		--暂无注释
            "失败是成功的进行时！",		--暂无注释
        },
        BATHBOMB =
        {
            GLASSED = "表面变成了光滑的玻璃。",		--暂无注释
            ALREADY_BOMBED = "不要浪费沐浴球。",		--暂无注释
        },
		GIVE_TACKLESKETCH =
		{
			DUPLICATE = "不对，不对。",		--暂无注释
		},
		COMPARE_WEIGHABLE =
		{
            FISH_TOO_SMALL = "它太小了。",		--暂无注释
            OVERSIZEDVEGGIES_TOO_SMALL = "还不够沉。",		--暂无注释
		},
        BEGIN_QUEST =
        {
            ONEGHOST = "only_used_by_wendy",		--暂无注释
        },
		TELLSTORY =
		{
			GENERIC = "only_used_by_walter",		--暂无注释
			NOT_NIGHT = "only_used_by_walter",		--暂无注释
			NO_FIRE = "only_used_by_walter",		--暂无注释
		},
        SING_FAIL =
        {
            SAMESONG = "only_used_by_wathgrithr",		--暂无注释
        },
        PLANTREGISTRY_RESEARCH_FAIL =
        {
            GENERIC = "不剩什么需要学的了。",		--暂无注释
            FERTILIZER = "在下不求甚解。",		--暂无注释
        },
        FILL_OCEAN =
        {
            UNSUITABLE_FOR_PLANTS = "海水不可斗量。",		--暂无注释
        },
        POUR_WATER =
        {
            OUT_OF_WATER = "巧妇难为无米之炊。",		--暂无注释
        },
        POUR_WATER_GROUNDTILE =
        {
            OUT_OF_WATER = "巧妇难为无米之炊。",		--暂无注释
        },
        USEITEMON =
        {
            BEEF_BELL_INVALID_TARGET = "恕在下无能为力！",		--暂无注释
            BEEF_BELL_ALREADY_USED = "这头牛有它的主人。",		--暂无注释
            BEEF_BELL_HAS_BEEF_ALREADY = "在下不能贪得无厌。",		--暂无注释
        },
        HITCHUP =
        {
            NEEDBEEF = "有铃铛就能和牛先生结下牵绊了。",		--暂无注释
            NEEDBEEF_CLOSER = "牛伙伴离在下太远了。",		--暂无注释
            BEEF_HITCHED = "大牛不要乱跑哦。",		--暂无注释
            INMOOD = "在下的牛太好动了。",		--暂无注释
        },
        MARK =
        {
            ALREADY_MARKED = "在下已经选好了。",		--暂无注释
            NOT_PARTICIPANT = "在下没有选手参赛。",		--暂无注释
        },
        YOTB_STARTCONTEST =
        {
            DOESNTWORK = "看来这里并不支持艺术。",		--暂无注释
            ALREADYACTIVE = "他可能忙着比别的比赛呢。",		--暂无注释
        },
        YOTB_UNLOCKSKIN =
        {
            ALREADYKNOWN = "在下已了然于胸！",		--暂无注释
        },
        CARNIVALGAME_FEED =
        {
            TOO_LATE = "已经晚了",		--暂无注释
        },
        HERD_FOLLOWERS =
        {
            WEBBERONLY = "十分抱歉，在下难以与蜘蛛结友。",		--暂无注释
        },
        BEDAZZLE =
        {
            BURNING = "only_used_by_webber",		--暂无注释
            BURNT = "only_used_by_webber",		--暂无注释
            FROZEN = "only_used_by_webber",		--暂无注释
            ALREADY_BEDAZZLED = "only_used_by_webber",		--暂无注释
        },
        UPGRADE =
        {
            BEDAZZLED = "only_used_by_webber",		--暂无注释
        },
		CAST_POCKETWATCH =
		{
			GENERIC = "only_used_by_wanda",		--暂无注释
			REVIVE_FAILED = "only_used_by_wanda",		--暂无注释
			WARP_NO_POINTS_LEFT = "only_used_by_wanda",		--暂无注释
			SHARD_UNAVAILABLE = "only_used_by_wanda",		--暂无注释
		},
        DISMANTLE_POCKETWATCH =
        {
            ONCOOLDOWN = "only_used_by_wanda",		--暂无注释
        },
        ENTER_GYM =
        {
            NOWEIGHT = "only_used_by_wolfang",		--暂无注释
            UNBALANCED = "only_used_by_wolfang",		--暂无注释
            ONFIRE = "only_used_by_wolfang",		--暂无注释
            SMOULDER = "only_used_by_wolfang",		--暂无注释
            HUNGRY = "only_used_by_wolfang",		--暂无注释
            FULL = "only_used_by_wolfang",		--暂无注释
        },
        APPLYMODULE =
        {
            COOLDOWN = "only_used_by_wx78",		--暂无注释
            NOTENOUGHSLOTS = "only_used_by_wx78",		--暂无注释
        },
        REMOVEMODULES =
        {
            NO_MODULES = "only_used_by_wx78",		--暂无注释
        },
        CHARGE_FROM =
        {
            NOT_ENOUGH_CHARGE = "only_used_by_wx78",		--暂无注释
            CHARGE_FULL = "only_used_by_wx78",		--暂无注释
        },
        HARVEST =
        {
            DOER_ISNT_MODULE_OWNER = "对牛弹琴。",		--暂无注释
        },
		CAST_SPELLBOOK =
		{
			NO_TOPHAT = "only_used_by_waxwell",		--暂无注释
		},
		CASTAOE =
		{
			NO_MAX_SANITY = "only_used_by_waxwell",		--暂无注释
            NOT_ENOUGH_EMBERS = "only_used_by_willow",		--暂无注释
            NO_TARGETS = "only_used_by_willow",		--暂无注释
            CANT_SPELL_MOUNTED = "only_used_by_willow",		--暂无注释
            SPELL_ON_COOLDOWN = "only_used_by_willow", 		--暂无注释
		},
    },
	ANNOUNCE_CANNOT_BUILD =
	{
		NO_INGREDIENTS = "在下手头的材料不够。",		--暂无注释
		NO_TECH = "在下还需要继续探求未知。",		--暂无注释
		NO_STATION = "在下暂时没办法制作。",		--暂无注释
	},
	ACTIONFAIL_GENERIC = "这样好像不太对。",		--动作失败
	ANNOUNCE_BOAT_LEAK = "船漏了，我们需要补丁！。",		--暂无注释
	ANNOUNCE_BOAT_SINK = "进水了，帮帮在下！",		--暂无注释
	ANNOUNCE_DIG_DISEASE_WARNING = "它看起来已经好多了。", --removed		--挖起生病的植物
	ANNOUNCE_PICK_DISEASE_WARNING = "这株植物生病了。", --removed		--（植物生病）
	ANNOUNCE_ADVENTUREFAIL = "这次不太顺利。在下必须再试一次。",		--没调用（废案）
    ANNOUNCE_MOUNT_LOWHEALTH = "牛牛好像受伤了。",		--牛血量过低
    ANNOUNCE_TOOMANYBIRDS = "only_used_by_waxwell_and_wicker",		--暂无注释
    ANNOUNCE_WAYTOOMANYBIRDS = "only_used_by_waxwell_and_wicker",		--暂无注释
    ANNOUNCE_NOWATERNEARBY = "only_used_by_waxwell_and_wicker",		--暂无注释
	ANNOUNCE_SHADOWLEVEL_ITEM = "only_used_by_waxwell",		--暂无注释
	ANNOUNCE_EQUIP_SHADOWLEVEL_T1 = "only_used_by_waxwell",		--暂无注释
	ANNOUNCE_EQUIP_SHADOWLEVEL_T2 = "only_used_by_waxwell",		--暂无注释
	ANNOUNCE_EQUIP_SHADOWLEVEL_T3 = "only_used_by_waxwell",		--暂无注释
	ANNOUNCE_EQUIP_SHADOWLEVEL_T4 = "only_used_by_waxwell",		--暂无注释
    ANNOUNCE_NORMALTOMIGHTY = "only_used_by_wolfang",		--暂无注释
    ANNOUNCE_NORMALTOWIMPY = "only_used_by_wolfang",		--暂无注释
    ANNOUNCE_WIMPYTONORMAL = "only_used_by_wolfang",		--暂无注释
    ANNOUNCE_MIGHTYTONORMAL = "only_used_by_wolfang",		--暂无注释
    ANNOUNCE_EXITGYM = 
    {
        MIGHTY = "only_used_by_wolfang",		--暂无注释
        NORMAL = "only_used_by_wolfang",		--暂无注释
        WIMPY = "only_used_by_wolfang",		--暂无注释
    },
	ANNOUNCE_BEES = "养蜂人的智慧。",		--戴养蜂帽被蜜蜂蛰
	ANNOUNCE_BOOMERANG = "诶呀没有接住",		--回旋镖
	ANNOUNCE_CHARLIE = "好黑......",		--查理即将攻击
	ANNOUNCE_CHARLIE_ATTACK = "黑暗在啃食我！",		--被查理攻击
	ANNOUNCE_CHARLIE_MISSED = "only_used_by_winona", --winona specific		--暂无注释
	ANNOUNCE_COLD = "雪菲小姐......",		--过冷
	ANNOUNCE_HOT = "要是有凉风就好了。",		--过热
	ANNOUNCE_CRAFTING_FAIL = "缺少一些关键成分。",		--没调用
	ANNOUNCE_DEERCLOPS = "吹来了危险的风。",		--boss来袭
	ANNOUNCE_CAVEIN = "地面在晃动，要找好位置规避一下",		--要地震了？？？
	ANNOUNCE_ANTLION_SINKHOLE =
	{
		"蚁狮有些不安分！",		--蚁狮地震
		"大自然生气了！",		--蚁狮地震
		"风捎来消息，地震要来了！！",		--蚁狮地震
	},
	ANNOUNCE_ANTLION_TRIBUTE =
	{
        "你要和在下交朋友吗。",		--向蚁狮致敬
        "这个给你，要乖一点哦。",		--给蚁狮上供
        "好乖好乖，听话哦。",		--给蚁狮上供
	},
	ANNOUNCE_SACREDCHEST_YES = "大自然的回报。",		--远古宝箱物品正确给出蓝图
	ANNOUNCE_SACREDCHEST_NO = "它不喜欢那个。",		--远古宝箱
    ANNOUNCE_DUSK = "有些晚了，我们回家吧。",		--进入黄昏
    ANNOUNCE_CHARGE = "only_used_by_wx78",		--暂无注释
	ANNOUNCE_DISCHARGE = "only_used_by_wx78",		--暂无注释
	ANNOUNCE_EAT =
	{
		GENERIC = "美味的料理！",		--吃东西
		PAINFUL = "应该再料理一下的",		--吃怪物肉
		SPOILED = "不能吃坏掉的食物！",		--吃腐烂食物
		STALE = "这个食物已经不新鲜了。",		--吃黄色食物
		INVALID = "在下并不挑食，但是……",		--拒吃
        YUCKY = "这个食物快坏掉了，不能再吃了。",		--吃红色食物
		COOKED = "only_used_by_warly",		--暂无注释
		DRIED = "only_used_by_warly",		--暂无注释
        PREPARED = "only_used_by_warly",		--暂无注释
        RAW = "only_used_by_warly",		--暂无注释
		SAME_OLD_1 = "only_used_by_warly",		--暂无注释
		SAME_OLD_2 = "only_used_by_warly",		--暂无注释
		SAME_OLD_3 = "only_used_by_warly",		--暂无注释
		SAME_OLD_4 = "only_used_by_warly",		--暂无注释
        SAME_OLD_5 = "only_used_by_warly",		--暂无注释
		TASTY = "only_used_by_warly",		--暂无注释
    },
	ANNOUNCE_FOODMEMORY = "only_used_by_warly",		--暂无注释
    ANNOUNCE_ENCUMBERED =
    {
        "加.....油.......",		--搬运雕像、可疑的大理石
        "好......重.......",		--搬运雕像、可疑的大理石
        "这比安小姐要轻！",		--搬运雕像、可疑的大理石
        "再加把劲！",		--搬运雕像、可疑的大理石
        "胜利....就在......眼前！",		--搬运雕像、可疑的大理石
        "呼.......",		--搬运雕像、可疑的大理石
        "马上.......就到了！",		--搬运雕像、可疑的大理石
        "气喘...吁吁...",		--搬运雕像、可疑的大理石
        "或许.....应该养一只牛来帮在下！",		--搬运雕像、可疑的大理石
    },
    ANNOUNCE_ATRIUM_DESTABILIZING =
    {
		"在下该走了！",		--中庭击杀boss后即将刷新
		"那是什么？！",		--中庭震动
		"这里不安全。",		--中庭击杀boss后即将刷新
	},
    ANNOUNCE_RUINS_RESET = "它们休息好了！",		--地下重置
    ANNOUNCE_SNARED = "连风都没法逃脱！",		--远古嘤嘤怪的骨笼
    ANNOUNCE_SNARED_IVY = "大自然正在反击！",		--暂无注释
    ANNOUNCE_REPELLED = "需要先清理黑色的手！",		--嘤嘤怪保护状态
	ANNOUNCE_ENTER_DARK = "抓紧在下的手，不要走丢了！",		--进入黑暗
	ANNOUNCE_ENTER_LIGHT = "有光！",		--进入光源
	ANNOUNCE_FREEDOM = "在下自由了！在下终于自由了！",		--没调用（废案）
	ANNOUNCE_HIGHRESEARCH = "感觉在下现在太聪明了！",		--没调用（废案）
	ANNOUNCE_HOUNDS = "注意戒备，魔物要进攻了！",		--猎犬将至
	ANNOUNCE_WORMS = "请不要大意！",		--蠕虫袭击
	ANNOUNCE_HUNGRY = "佩可小姐一直是这样吗，太辛苦了",		--饥饿
	ANNOUNCE_HUNT_BEAST_NEARBY = "新鲜的足迹，我们马上就要抓到它了。",		--即将找到野兽
	ANNOUNCE_HUNT_LOST_TRAIL = "野兽的足迹到这里就没了。",		--猎物（大象脚印丢失）
	ANNOUNCE_HUNT_LOST_TRAIL_SPRING = "这种湿土留不下脚印。",		--大猎物丢失踪迹
    ANNOUNCE_HUNT_START_FORK = "这个踪迹看起来有危险。",		--暂无注释
    ANNOUNCE_HUNT_SUCCESSFUL_FORK = "没有野兽能难得住在下。",		--暂无注释
    ANNOUNCE_HUNT_WRONG_FORK = "有什么在看着在下。",		--暂无注释
    ANNOUNCE_HUNT_AVOID_FORK = "这个踪迹看起来安全些了。",		--暂无注释
	ANNOUNCE_INV_FULL = "在下。。。难堪重负。",		--身上的物品满了
	ANNOUNCE_KNOCKEDOUT = "眼镜睁不开了......",		--被催眠
	ANNOUNCE_LOWRESEARCH = "在下没从那儿学到什么。",		--没调用（废案）
	ANNOUNCE_MOSQUITOS = "快走开！",		--没调用
    ANNOUNCE_NOWARDROBEONFIRE = "快灭火！",		--橱柜着火
    ANNOUNCE_NODANGERGIFT = "周围还有怪物，先清理一下吧。",		--周围有危险的情况下打开礼物
    ANNOUNCE_NOMOUNTEDGIFT = "在牛牛先生身上可拆不了礼物哦。",		--骑牛的时候打开礼物
	ANNOUNCE_NODANGERSLEEP = "不能睡！",		--危险，不能睡觉
	ANNOUNCE_NODAYSLEEP = "天还早，等晚一些在休息吧。",		--白天睡帐篷
	ANNOUNCE_NODAYSLEEP_CAVE = "还不算太晚，我们先去冒险吧！",		--洞穴里白天睡帐篷
	ANNOUNCE_NOHUNGERSLEEP = "事已至此，先吃饭吧。",		--饿了无法睡觉
	ANNOUNCE_NOSLEEPONFIRE = "快点准备灭火！",		--营帐着火无法睡觉
    ANNOUNCE_NOSLEEPHASPERMANENTLIGHT = "only_used_by_wx78",		--暂无注释
	ANNOUNCE_NODANGERSIESTA = "现在午休太危险了！",		--危险，不能午睡
	ANNOUNCE_NONIGHTSIESTA = "晚上该睡觉，而不是午休。",		--夜晚睡凉棚
	ANNOUNCE_NONIGHTSIESTA_CAVE = "暂时还不行。",		--在洞穴里夜晚睡凉棚
	ANNOUNCE_NOHUNGERSIESTA = "还是先吃饭吧。",		--饱度不足无法午睡
	ANNOUNCE_NO_TRAP = "好吧，挺简单的。",		--没有陷阱？？？没调用
	ANNOUNCE_PECKED = "你不乖！",		--被小高鸟啄
	ANNOUNCE_QUAKE = "大自然在低吼。",		--地震
	ANNOUNCE_RESEARCH = "学习使在下成长。",		--没调用
	ANNOUNCE_SHELTER = "感谢大自然！",		--下雨天躲树下
	ANNOUNCE_THORNS = "大自然的反击！",		--玫瑰、仙人掌、荆棘扎手
	ANNOUNCE_BURNT = "呀！好烫！",		--烧完了
	ANNOUNCE_TORCH_OUT = "火把用完了！",		--火把用完了
	ANNOUNCE_THURIBLE_OUT = "它消耗殆尽了。",		--香炉燃尽
	ANNOUNCE_FAN_OUT = "主人喜欢的话，在下可以再做一个小风车哦。",		--小风车停了
    ANNOUNCE_COMPASS_OUT = "风会代替它继续指引我们。",		--指南针用完了
	ANNOUNCE_TRAP_WENT_OFF = "哎呀。",		--触发陷阱（例如冬季陷阱）
	ANNOUNCE_UNIMPLEMENTED = "噢！这应该还没准备好。",		--没调用
	ANNOUNCE_WORMHOLE = "黏糊糊的，不太喜欢。",		--跳虫洞
	ANNOUNCE_TOWNPORTALTELEPORT = "或许....可以通过这个去往兰德索尔？。",		--豪华传送
	ANNOUNCE_CANFIX = "\n修好的话可以更好的保护主人吧。",		--墙壁可以修理
	ANNOUNCE_ACCOMPLISHMENT = "在下觉得好有成就感！",		--没调用
	ANNOUNCE_ACCOMPLISHMENT_DONE = "如果在下的朋友现在能看到在下就好了...",		--没调用
	ANNOUNCE_INSUFFICIENTFERTILIZER = "还需要一些肥料才行。",		--土地肥力不足
	ANNOUNCE_TOOL_SLIP = "工具太滑了！",		--工具滑出
	ANNOUNCE_LIGHTNING_DAMAGE_AVOIDED = "像是凯露小姐的闪电，还好躲过去了！",		--规避闪电
	ANNOUNCE_TOADESCAPING = "癞蛤蟆正在失去兴趣。",		--蟾蜍正在逃跑
	ANNOUNCE_TOADESCAPED = "癞蛤蟆逃走了。",		--蟾蜍逃走了
	ANNOUNCE_DAMP = "风吹雨打。",		--潮湿（1级）
	ANNOUNCE_WET = "我们赶快去避雨吧。",		--潮湿（2级）
	ANNOUNCE_WETTER = "再不躲雨的话，可能会感冒！",		--潮湿（3级）
	ANNOUNCE_SOAKED = "衣服已经湿透了，身体好冷......",		--潮湿（4级）
	ANNOUNCE_WASHED_ASHORE = "衣服弄湿了，但是还活着。",		--暂无注释
    ANNOUNCE_DESPAWN = "艾梅斯大人！",		--下线
	ANNOUNCE_BECOMEGHOST = "OxO",		--变成鬼魂
	ANNOUNCE_GHOSTDRAIN = "朋友......",		--队友死亡掉san
	ANNOUNCE_PETRIFED_TREES = "大自然的奇迹。。。",		--石化树
	ANNOUNCE_KLAUS_ENRAGE = "它生气了！快躲在在下身后！",		--克劳斯被激怒（杀死了鹿）
	ANNOUNCE_KLAUS_UNCHAINED = "战斗还没结束，做好准备！",		--克劳斯-未上锁的  猜测是死亡准备变身？
	ANNOUNCE_KLAUS_CALLFORHELP = "它的救兵来了，在下会保护好你的。",		--克劳斯召唤小偷
	ANNOUNCE_MOONALTAR_MINE =
	{
		GLASS_MED = "里面有东西。",		--暂无注释
		GLASS_LOW = "快挖出来了。",		--暂无注释
		GLASS_REVEAL = "你自由了！",		--暂无注释
		IDOL_MED = "里面有东西。",		--暂无注释
		IDOL_LOW = "快挖出来了。",		--暂无注释
		IDOL_REVEAL = "你自由了！",		--暂无注释
		SEED_MED = "里面有东西。",		--暂无注释
		SEED_LOW = "快挖出来了。",		--暂无注释
		SEED_REVEAL = "你自由了！",		--暂无注释
	},
    ANNOUNCE_SPOOKED = "呀！",		--被吓到
	ANNOUNCE_BRAVERY_POTION = "为了伙伴们，在下需要更勇敢才行！",		--勇气药剂
	ANNOUNCE_MOONPOTION_FAILED = "可能没泡够时间……",		--暂无注释
	ANNOUNCE_EATING_NOT_FEASTING = "在下应该跟其他人分享的。",		--暂无注释
	ANNOUNCE_WINTERS_FEAST_BUFF = "满满的节日精神！",		--暂无注释
	ANNOUNCE_IS_FEASTING = "冬季盛宴快乐！",		--暂无注释
	ANNOUNCE_WINTERS_FEAST_BUFF_OVER = "节过的真快……",		--暂无注释
    ANNOUNCE_REVIVING_CORPSE = "让在下帮帮你。",		--没调用（熔炉）
    ANNOUNCE_REVIVED_OTHER_CORPSE = "焕然一新！",		--没调用（熔炉）
    ANNOUNCE_REVIVED_FROM_CORPSE = "好多了，谢谢啦。",		--没调用（熔炉）
    ANNOUNCE_FLARE_SEEN = "是谁发出的信号？",		--暂无注释
    ANNOUNCE_MEGA_FLARE_SEEN = "那个闪光会带来麻烦。",		--暂无注释
    ANNOUNCE_OCEAN_SILHOUETTE_INCOMING = "不好，海怪！",		--暂无注释
	ANNOUNCE_LIGHTFIRE =
	{
		"only_used_by_willow",		--暂无注释
    },
    ANNOUNCE_HUNGRY_SLOWBUILD =
    {
	    "only_used_by_winona",		--暂无注释
    },
    ANNOUNCE_HUNGRY_FASTBUILD =
    {
	    "only_used_by_winona",		--暂无注释
    },
    ANNOUNCE_KILLEDPLANT =
    {
        "only_used_by_wormwood",		--暂无注释
    },
    ANNOUNCE_GROWPLANT =
    {
        "only_used_by_wormwood",		--暂无注释
    },
    ANNOUNCE_BLOOMING =
    {
        "only_used_by_wormwood",		--暂无注释
    },
    ANNOUNCE_SOUL_EMPTY =
    {
        "only_used_by_wortox",		--暂无注释
    },
    ANNOUNCE_SOUL_FEW =
    {
        "only_used_by_wortox",		--暂无注释
    },
    ANNOUNCE_SOUL_MANY =
    {
        "only_used_by_wortox",		--暂无注释
    },
    ANNOUNCE_SOUL_OVERLOAD =
    {
        "only_used_by_wortox",		--暂无注释
    },
	ANNOUNCE_SLINGHSOT_OUT_OF_AMMO =
	{
		"only_used_by_walter",		--暂无注释
		"only_used_by_walter",		--暂无注释
	},
	ANNOUNCE_STORYTELLING_ABORT_FIREWENTOUT =
	{
        "only_used_by_walter",		--暂无注释
	},
	ANNOUNCE_STORYTELLING_ABORT_NOT_NIGHT =
	{
        "only_used_by_walter",		--暂无注释
	},
    ANNOUNCE_WX_SCANNER_NEW_FOUND = "only_used_by_wx78",		--暂无注释
    ANNOUNCE_WX_SCANNER_FOUND_NO_DATA = "only_used_by_wx78",		--暂无注释
    ANNOUNCE_ROYALTY =
    {
        "陛下。",		--向带着蜂王帽的队友鞠躬
        "殿下。",		--向带着蜂王帽的队友鞠躬
        "令人尊敬的朋友。",		--向带着蜂王帽的队友鞠躬
    },
    ANNOUNCE_ATTACH_BUFF_ELECTRICATTACK    = "哔哩哔哩的感觉！",		--暂无注释
    ANNOUNCE_ATTACH_BUFF_ATTACK            = "攻击力提升了！",		--暂无注释
    ANNOUNCE_ATTACH_BUFF_PLAYERABSORPTION  = "防御力提升了！",		--暂无注释
    ANNOUNCE_ATTACH_BUFF_WORKEFFECTIVENESS = "生产力提高！",		--暂无注释
    ANNOUNCE_ATTACH_BUFF_MOISTUREIMMUNITY  = "风带走了水分！",		--暂无注释
    ANNOUNCE_ATTACH_BUFF_SLEEPRESISTANCE   = "顿时觉得神清气爽，再也不累了！",		--暂无注释
    ANNOUNCE_DETACH_BUFF_ELECTRICATTACK    = "电击效果结束了！",		--暂无注释
    ANNOUNCE_DETACH_BUFF_ATTACK            = "攻击力加成效果结束了。",		--暂无注释
    ANNOUNCE_DETACH_BUFF_PLAYERABSORPTION  = "防御力加成结束了！",		--暂无注释
    ANNOUNCE_DETACH_BUFF_WORKEFFECTIVENESS = "拖延症又回来了...",		--暂无注释
    ANNOUNCE_DETACH_BUFF_MOISTUREIMMUNITY  = "在下的干旱期结束了。",		--暂无注释
    ANNOUNCE_DETACH_BUFF_SLEEPRESISTANCE   = "在下……（哈欠）再也……不累了……",		--暂无注释
	ANNOUNCE_OCEANFISHING_LINESNAP = "在下的新老付之一炬",		--暂无注释
	ANNOUNCE_OCEANFISHING_LINETOOLOOSE = "收线吧！",		--暂无注释
	ANNOUNCE_OCEANFISHING_GOTAWAY = "它逃回了大自然。",		--暂无注释
	ANNOUNCE_OCEANFISHING_BADCAST = "在下还需精进技术……",		--暂无注释
	ANNOUNCE_OCEANFISHING_IDLE_QUOTE =
	{
		"这里已经没有大自然的居民了。",		--暂无注释
		"好吧，这片海洋没有它的精灵了。",		--暂无注释
		"在下还以为海里到处都是鱼呢！",		--暂无注释
		"这里好像没有鱼哦。",		--暂无注释
	},
	ANNOUNCE_WEIGHT = "重量：{weight}",		--暂无注释
	ANNOUNCE_WEIGHT_HEAVY  = "重量: {weight}\n它是大海的精灵!",		--暂无注释
	ANNOUNCE_WINCH_CLAW_MISS = "好像没对准。",		--暂无注释
	ANNOUNCE_WINCH_CLAW_NO_ITEM = "竹篮打水。",		--暂无注释
    ANNOUNCE_KINGCREATED = "only_used_by_wurt",		--暂无注释
    ANNOUNCE_KINGDESTROYED = "only_used_by_wurt",		--暂无注释
    ANNOUNCE_CANTBUILDHERE_THRONE = "only_used_by_wurt",		--暂无注释
    ANNOUNCE_CANTBUILDHERE_HOUSE = "only_used_by_wurt",		--暂无注释
    ANNOUNCE_CANTBUILDHERE_WATCHTOWER = "only_used_by_wurt",		--暂无注释
    ANNOUNCE_READ_BOOK =
    {
        BOOK_SLEEP = "only_used_by_wurt",		--暂无注释
        BOOK_BIRDS = "only_used_by_wurt",		--暂无注释
        BOOK_TENTACLES =  "only_used_by_wurt",		--暂无注释
        BOOK_BRIMSTONE = "only_used_by_wurt",		--暂无注释
        BOOK_GARDENING = "only_used_by_wurt",		--暂无注释
		BOOK_SILVICULTURE = "only_used_by_wurt",		--暂无注释
		BOOK_HORTICULTURE = "only_used_by_wurt",		--暂无注释
        BOOK_FISH = "only_used_by_wurt",		--暂无注释
        BOOK_FIRE = "only_used_by_wurt",		--暂无注释
        BOOK_WEB = "only_used_by_wurt",		--暂无注释
        BOOK_TEMPERATURE = "only_used_by_wurt",		--暂无注释
        BOOK_LIGHT = "only_used_by_wurt",		--暂无注释
        BOOK_RAIN = "only_used_by_wurt",		--暂无注释
        BOOK_MOON = "only_used_by_wurt",		--暂无注释
        BOOK_BEES = "only_used_by_wurt",		--暂无注释
        BOOK_HORTICULTURE_UPGRADED = "only_used_by_wurt",		--暂无注释
        BOOK_RESEARCH_STATION = "only_used_by_wurt",		--暂无注释
        BOOK_LIGHT_UPGRADED = "only_used_by_wurt",		--暂无注释
    },
    ANNOUNCE_WEAK_RAT = "这只胡萝卜鼠不在训练的状态。",		--暂无注释
    ANNOUNCE_CARRAT_START_RACE = "比赛开始！",		--暂无注释
    ANNOUNCE_CARRAT_ERROR_WRONG_WAY = 
    {
        "方向错了！",		--暂无注释
        "胡萝卜鼠先生，快掉头！",		--暂无注释
    },
    ANNOUNCE_CARRAT_ERROR_FELL_ASLEEP = "不要睡觉了胡萝卜鼠先生,我们要加油比赛！",		--暂无注释
    ANNOUNCE_CARRAT_ERROR_WALKING = "赶快冲刺，胡萝卜鼠先生！",		--暂无注释
    ANNOUNCE_CARRAT_ERROR_STUNNED = "加油，快！",		--暂无注释
    ANNOUNCE_GHOST_QUEST = "only_used_by_wendy",		--暂无注释
    ANNOUNCE_GHOST_HINT = "only_used_by_wendy",		--暂无注释
    ANNOUNCE_GHOST_TOY_NEAR = 
    {
        "only_used_by_wendy",		--暂无注释
    },
	ANNOUNCE_SISTURN_FULL = "only_used_by_wendy",		--暂无注释
    ANNOUNCE_ABIGAIL_DEATH = "only_used_by_wendy",		--暂无注释
    ANNOUNCE_ABIGAIL_RETRIEVE = "only_used_by_wendy",		--暂无注释
	ANNOUNCE_ABIGAIL_LOW_HEALTH = "only_used_by_wendy",		--暂无注释
    ANNOUNCE_ABIGAIL_SUMMON =
	{
		LEVEL1 = "only_used_by_wendy",		--暂无注释
		LEVEL2 = "only_used_by_wendy",		--暂无注释
		LEVEL3 = "only_used_by_wendy",		--暂无注释
	},
    ANNOUNCE_GHOSTLYBOND_LEVELUP =
	{
		LEVEL2 = "only_used_by_wendy",		--暂无注释
		LEVEL3 = "only_used_by_wendy",		--暂无注释
	},
    ANNOUNCE_NOINSPIRATION = "only_used_by_wathgrithr",		--暂无注释
    ANNOUNCE_NOTSKILLEDENOUGH = "only_used_by_wathgrithr",		--暂无注释
    ANNOUNCE_BATTLESONG_INSTANT_TAUNT_BUFF = "only_used_by_wathgrithr",		--暂无注释
    ANNOUNCE_BATTLESONG_INSTANT_PANIC_BUFF = "only_used_by_wathgrithr",		--暂无注释
    ANNOUNCE_BATTLESONG_INSTANT_REVIVE_BUFF = "only_used_by_wathgrithr",		--暂无注释
    ANNOUNCE_WANDA_YOUNGTONORMAL = "only_used_by_wanda",		--暂无注释
    ANNOUNCE_WANDA_NORMALTOOLD = "only_used_by_wanda",		--暂无注释
    ANNOUNCE_WANDA_OLDTONORMAL = "only_used_by_wanda",		--暂无注释
    ANNOUNCE_WANDA_NORMALTOYOUNG = "only_used_by_wanda",		--暂无注释
	ANNOUNCE_POCKETWATCH_PORTAL = "哦，没被摔到吧？",		--暂无注释
	ANNOUNCE_POCKETWATCH_MARK = "only_used_by_wanda",		--暂无注释
	ANNOUNCE_POCKETWATCH_RECALL = "only_used_by_wanda",		--暂无注释
	ANNOUNCE_POCKETWATCH_OPEN_PORTAL = "only_used_by_wanda",		--暂无注释
	ANNOUNCE_POCKETWATCH_OPEN_PORTAL_DIFFERENTSHARD = "only_used_by_wanda",		--暂无注释
    ANNOUNCE_ARCHIVE_NEW_KNOWLEDGE = "远古的知识，好神奇！",		--暂无注释
    ANNOUNCE_ARCHIVE_OLD_KNOWLEDGE = "在下已成竹在胸。",		--暂无注释
    ANNOUNCE_ARCHIVE_NO_POWER = "它好像需要能量。",		--暂无注释
    ANNOUNCE_PLANT_RESEARCHED =
    {
        "嗯,新的植物知识！",		--暂无注释
    },
    ANNOUNCE_PLANT_RANDOMSEED = "会长成什么呢，嘿嘿，好期待呀。。",		--暂无注释
    ANNOUNCE_FERTILIZER_RESEARCHED = "对于肥料研究也是学习的一种。",		--暂无注释
	ANNOUNCE_FIRENETTLE_TOXIN =
	{
		"咳咳.....好热！",		--暂无注释
		"咳咳....咳咳....热......",		--暂无注释
	},
	ANNOUNCE_FIRENETTLE_TOXIN_DONE = "呼.....灼热的感觉消失了，下次可不能乱吃东西了。",		--暂无注释
	ANNOUNCE_TALK_TO_PLANTS =
	{
        "你好呀，小精灵！",		--暂无注释
        "要乖乖长大哦！",		--暂无注释
		"嘿嘿，见到你很开心哦~",		--暂无注释
        "嗯哼哼~",		--暂无注释
        "大自然的美丽造物！",		--暂无注释
	},
	ANNOUNCE_KITCOON_HIDEANDSEEK_START = "藏~好~了~吗~",		--暂无注释
	ANNOUNCE_KITCOON_HIDEANDSEEK_JOIN = "我们一起来玩捉迷藏吧！",		--暂无注释
	ANNOUNCE_KITCOON_HIDANDSEEK_FOUND =
	{
		"找到你了！",		--暂无注释
		"你在这。",		--暂无注释
		"嘿嘿，抓住你了哦！",		--暂无注释
		"抓到了！",		--暂无注释
	},
	ANNOUNCE_KITCOON_HIDANDSEEK_FOUND_ONE_MORE = "最后一个！",		--暂无注释
	ANNOUNCE_KITCOON_HIDANDSEEK_FOUND_LAST_ONE = "在下找到最后一个了！",		--暂无注释
	ANNOUNCE_KITCOON_HIDANDSEEK_FOUND_LAST_ONE_TEAM = "{name}无所遁形！",		--暂无注释
	ANNOUNCE_KITCOON_HIDANDSEEK_TIME_ALMOST_UP = "那些小家伙们估计不耐烦了……",		--暂无注释
	ANNOUNCE_KITCOON_HIDANDSEEK_LOSEGAME = "看来它们不想玩了……",		--暂无注释
	ANNOUNCE_KITCOON_HIDANDSEEK_TOOFAR = "它们大概率不会躲在这么远的地方，对吧？",		--暂无注释
	ANNOUNCE_KITCOON_HIDANDSEEK_TOOFAR_RETURN = "小浣猫们应该就在附近。",		--暂无注释
	ANNOUNCE_KITCOON_FOUND_IN_THE_WILD = "在下就说刚刚看到了那边有什么东西在藏着！",		--暂无注释
	ANNOUNCE_TICOON_START_TRACKING	= "他捕捉到了气味！",		--暂无注释
	ANNOUNCE_TICOON_NOTHING_TO_TRACK = "看来他什么都没找到。",		--暂无注释
	ANNOUNCE_TICOON_WAITING_FOR_LEADER = "在下应该跟着他！",		--暂无注释
	ANNOUNCE_TICOON_GET_LEADER_ATTENTION = "他很想让在下跟着。",		--暂无注释
	ANNOUNCE_TICOON_NEAR_KITCOON = "他一定是发现了什么！",		--暂无注释
	ANNOUNCE_TICOON_LOST_KITCOON = "看来别人找到了他要找的东西。",		--暂无注释
	ANNOUNCE_TICOON_ABANDONED = "在下会自己找到那些小家伙的。",		--暂无注释
	ANNOUNCE_TICOON_DEAD = "可怜的家伙……他原本想把在下带到哪里呢？",		--暂无注释
    ANNOUNCE_CALL_BEEF = "快过来！",		--暂无注释
    ANNOUNCE_CANTBUILDHERE_YOTB_POST = "放在这里裁判是看不到在下的牛牛",		--暂无注释
    ANNOUNCE_YOTB_LEARN_NEW_PATTERN =  "在下满满都是牛牛造型的灵感！",		--暂无注释
    ANNOUNCE_EYEOFTERROR_ARRIVE = "好大的大眼睛OXO",		--暂无注释
    ANNOUNCE_EYEOFTERROR_FLYBACK = "终于好了！",		--暂无注释
    ANNOUNCE_EYEOFTERROR_FLYAWAY = "快回来！",		--暂无注释
    ANNOUNCE_CANT_ESCAPE_CURSE = "当然不会那么轻松。",		--暂无注释
    ANNOUNCE_MONKEY_CURSE_1 = "在下受到了诅咒，可能要变成猴子了。",		--暂无注释
    ANNOUNCE_MONKEY_CURSE_CHANGE = "呀！在下的头发怎么了？！",		--暂无注释
    ANNOUNCE_MONKEY_CURSE_CHANGEBACK = "总算从猴身解脱了！",		--暂无注释
    ANNOUNCE_PIRATES_ARRIVE = "那个号子声只意味着一件事...",		--暂无注释
    ANNOUNCE_BOOK_MOON_DAYTIME = "only_used_by_waxwell_and_wicker",		--暂无注释
    ANNOUNCE_OFF_SCRIPT = "在下感觉剧本里没写那句。",		--暂无注释
    ANNOUNCE_COZY_SLEEP = "在下感觉神清气爽！",		--暂无注释
	ANNOUNCE_TOOL_TOOWEAK = "在下需要一把更结实的工具！",		--暂无注释
    ANNOUNCE_LUNAR_RIFT_MAX = "那道闪光！那是月光吗？",		--暂无注释
    ANNOUNCE_SHADOW_RIFT_MAX = "邪恶的家伙即将到来。",		--暂无注释
    ANNOUNCE_SCRAPBOOK_FULL = "在下并不贪婪。",		--暂无注释
    ANNOUNCE_CHAIR_ON_FIRE = "无需在意。",		--暂无注释
    ANNOUNCE_COACH = 
    {
        "only_used_by_wolfgang",		--暂无注释
        "only_used_by_wolfgang",		--暂无注释
        "only_used_by_wolfgang",		--暂无注释
        "only_used_by_wolfgang",		--暂无注释
        "only_used_by_wolfgang",		--暂无注释
        "only_used_by_wolfgang",		--暂无注释
        "only_used_by_wolfgang",		--暂无注释
        "only_used_by_wolfgang",		--暂无注释
        "only_used_by_wolfgang",		--暂无注释
    },
    ANNOUNCE_WOLFGANG_WIMPY_COACHING = "only_used_by_wolfgang",		--暂无注释
    ANNOUNCE_WOLFGANG_MIGHTY_COACHING = "only_used_by_wolfgang",		--暂无注释
    ANNOUNCE_WOLFGANG_BEGIN_COACHING = "only_used_by_wolfgang",		--暂无注释
    ANNOUNCE_WOLFGANG_END_COACHING = "only_used_by_wolfgang",		--暂无注释
    ANNOUNCE_WOLFGANG_NOTEAM = 
    {
        "only_used_by_wolfgang",		--暂无注释
        "only_used_by_wolfgang",		--暂无注释
        "only_used_by_wolfgang",		--暂无注释
    },
    ANNOUNCE_YOTD_NOBOATS = "在下得把船移到离起点塔更近的地方。",		--暂无注释
    ANNOUNCE_YOTD_NOCHECKPOINTS = "在下该先立几个检查点。",		--暂无注释
    ANNOUNCE_YOTD_NOTENOUGHBOATS = "不够空间容纳其余选手了。",		--暂无注释
	BATTLECRY =
	{
		GENERIC = "风啊！怒号吧！",		--战斗
		PIG = "全身都是破绽！",		--战斗 猪人
		PREY = "风带来了猎物的气味",		--战斗 猎物？？大象？
		SPIDER = "蜘蛛什么的在下才不会害怕！",		--战斗 蜘蛛
		SPIDER_WARRIOR = "蜘蛛什么的在下才不会害怕！！",		--战斗 蜘蛛战士
		DEER = "那里！",		--战斗 无眼鹿
	},
	COMBAT_QUIT =
	{
		GENERIC = "他暂时被困住了。",		--攻击目标被卡住，无法攻击
		PIG = "这次姑且放过他。",		--退出战斗-猪人
		PREY = "呼....呼....它们跑的太快了！",		--退出战斗 猎物？？大象？
		SPIDER = "没受伤吧？",		-- 退出战斗 蜘蛛
		SPIDER_WARRIOR = "受伤的话，就让在下来帮你治疗吧。",		--退出战斗 蜘蛛战士
	},
	DESCRIBE =
	{
		MULTIPLAYER_PORTAL = "通过这里，或许在下能看到兰德索尔。",		-- 物品名:"绚丽之门"
        MULTIPLAYER_PORTAL_MOONROCK = "好奇妙的门。",		-- 物品名:"天体传送门"
        MOONROCKIDOL = "这是月岩雕像。",		-- 物品名:"月岩雕像" 制造描述:"重要人物。"
        CONSTRUCTION_PLANS = "好耶！",		-- 物品名:未找到
        ANTLION =
        {
            GENERIC = "蚁狮先生或许想要什么？",		-- 物品名:"蚁狮"->默认
            VERYHAPPY = "蚁狮先生，我们是好朋友对吧？",		-- 物品名:"蚁狮"
            UNHAPPY = "它....为什么会生气呢？",		-- 物品名:"蚁狮"
        },
        ANTLIONTRINKET = "嘿嘿，主人要拿去玩吗？",		-- 物品名:"沙滩玩具"
        SANDSPIKE = "喔.....沙子也能变的这么尖锐吗？",		-- 物品名:"沙刺"
        SANDBLOCK = "战斗结束后，我们一起堆一个比这个还要大的吧！",		-- 物品名:"沙堡"
        GLASSSPIKE = "小心不要被划伤了哦。",		-- 物品名:"玻璃尖刺"
        GLASSBLOCK = "闪闪亮亮的......好漂亮！",		-- 物品名:"玻璃城堡"
        ABIGAIL_FLOWER =
        {
            GENERIC ="阿比盖尔小姐的花。",		-- 物品名:"阿比盖尔之花"->默认 制造描述:"一个神奇的纪念品。"
			LEVEL1 = "含苞待放。",		-- 物品名:"阿比盖尔之花" 制造描述:"一个神奇的纪念品。"
			LEVEL2 = "她.....或许想和我们说些什么？",		-- 物品名:"阿比盖尔之花" 制造描述:"一个神奇的纪念品。"
			LEVEL3 = "宫子小姐是否也有这样一朵花呢？",		-- 物品名:"阿比盖尔之花" 制造描述:"一个神奇的纪念品。"
            LONG = "好像.....有些伤心.....",		-- 物品名:"阿比盖尔之花"->还需要很久 制造描述:"一个神奇的纪念品。"
            MEDIUM = "在下感觉.....不太舒服......",		-- 物品名:"阿比盖尔之花" 制造描述:"一个神奇的纪念品。"
            SOON = "那朵花有情况！",		-- 物品名:"阿比盖尔之花" 制造描述:"一个神奇的纪念品。"
            HAUNTED_POCKET = "把它放下吧。",		-- 物品名:"阿比盖尔之花" 制造描述:"一个神奇的纪念品。"
            HAUNTED_GROUND = "在下会查明它到底做了些什么。",		-- 物品名:"阿比盖尔之花" 制造描述:"一个神奇的纪念品。"
        },
        BALLOONS_EMPTY = "呼呼，可以吹出来好多气球。",		-- 物品名:"一堆气球" 制造描述:"要是有更简单的方法该多好。"
        BALLOON = "它装满了风？",		-- 物品名:"气球" 制造描述:"谁不喜欢气球呢？"
		BALLOONPARTY = "喔！好可爱！",		-- 物品名:"派对气球" 制造描述:"散播一点欢笑。"
		BALLOONSPEED =
        {
            DEFLATED = "轻快的气球！",		-- 物品名:"迅捷气球" 制造描述:"让你的脚步变得轻盈。"
            GENERIC = "呼呼呼，小气球。",		-- 物品名:"迅捷气球"->默认 制造描述:"让你的脚步变得轻盈。"
        },
		BALLOONVEST = "哈哈，这个背心会发出吱吱的响声诶。",		-- 物品名:"充气背心" 制造描述:"划船时带上这些艳丽的气球。"
		BALLOONHAT = "气球帽子。",		-- 物品名:"气球帽" 制造描述:"开启对话的出色工具！"
        BERNIE_INACTIVE =
        {
            BROKEN = "小熊？",		-- 物品名:"伯尼" 制造描述:"这个疯狂的世界总有你熟悉的人。"
            GENERIC = "它全烧焦了。",		-- 物品名:"伯尼"->默认 制造描述:"这个疯狂的世界总有你熟悉的人。"
        },
        BERNIE_ACTIVE = "尝试拥抱一下？。",		-- 物品名:"伯尼"
        BERNIE_BIG = "喔，它动起来了！。",		-- 物品名:"伯尼！"
		BOOKSTATION =
		{
			GENERIC = "能装上几本故事书~主人要听故事吗？",		-- 物品名:"书架"->默认 制造描述:"所有图书均须遵循杜威十进制分类法整理。"
			BURNT = "希望书籍没有烧坏。",		-- 物品名:"书架"->烧焦的 制造描述:"所有图书均须遵循杜威十进制分类法整理。"
		},
        BOOK_BIRDS = "读了就会有好多小鸟。",		-- 物品名:"世界鸟类大全" 制造描述:"涵盖1000个物种：习性、栖息地及叫声。"
        BOOK_TENTACLES = "读这本书的时候要注意不要被触手伤到哦。",		-- 物品名:"触手的召唤" 制造描述:"让我们来了解一下地下的朋友们！"
        BOOK_GARDENING = "大自然在成长。",		-- 物品名:"应用园艺学" 制造描述:"讲述培育和照料植物的相关知识。"
		BOOK_SILVICULTURE = "大自然的伟力！。",		-- 物品名:"应用造林学" 制造描述:"分支管理的指引。"
		BOOK_HORTICULTURE = "植物先生最喜欢的书。",		-- 物品名:"园艺学简编版" 制造描述:"讲述培育和照料植物的相关知识。"
        BOOK_SLEEP = "要睡觉吗？在下可以为你讲故事喔~。",		-- 物品名:"睡前故事" 制造描述:"送你入梦的睡前故事。"
        BOOK_BRIMSTONE = "最好不要读。",		-- 物品名:"末日将至！" 制造描述:"世界将在火焰和灾难中终结！"
        BOOK_FISH = "小鱼要上钩了。",		-- 物品名:"垂钓者生存指南" 制造描述:"让捕鱼变得简单！"
        BOOK_FIRE = "不要乱玩火哦。",		-- 物品名:"意念控火术详解" 制造描述:"使用这些简单的技巧来化解任何火爆的场面。"
        BOOK_WEB = "蜘蛛？或许可以给佩可小姐做一顿怪物汤。",		-- 物品名:"克服蛛形纲恐惧症" 制造描述:"要在对方的网络里行走过一里路才能算真正了解一个人。"
        BOOK_TEMPERATURE = "风和日丽",		-- 物品名:"控温学" 制造描述:"通过这些简单的步骤完全控制你的个人气候。"
        BOOK_LIGHT = "神秘的书。",		-- 物品名:"永恒之光" 制造描述:"阅读后能启迪出智慧的光芒。"
        BOOK_RAIN = "下雨的时候要记得打伞哦。",		-- 物品名:"实用求雨仪式" 制造描述:"留着防备雨天，你来决定哪天是雨天。"
        BOOK_MOON = "一起来赏月吧。",		-- 物品名:"月之魔典" 制造描述:"召唤月亮的力量。"
        BOOK_BEES = "嗡嗡嗡....嗡嗡嗡.....嘿嘿 ，是小蜜蜂哦~。",		-- 物品名:"养蜂笔记" 制造描述:"学习养蜂的基本知识。"
        BOOK_HORTICULTURE_UPGRADED = "春风吹又生。",		-- 物品名:"园艺学扩展版" 制造描述:"专家分析如何进行高级农作物护理。"
        BOOK_RESEARCH_STATION = "薇克巴顿奶奶教给在下的。",		-- 物品名:"万物百科" 制造描述:"万事万物从A到Z的完整指南。"
        BOOK_LIGHT_UPGRADED = "闪亮亮！",		-- 物品名:"永恒之光之复兴" 制造描述:"全本比之前的简本散发出更闪耀的光芒。"
        FIREPEN = "呼呼，呼呼，怎么吹不灭呢？",		-- 物品名:"火焰笔" 制造描述:"小小的笔身中潜藏着暴躁的火焰。"
        PLAYER =
        {
            GENERIC = "你好，%s！",		-- 物品名:未找到
            ATTACKER = "%s 来战斗吧！",		-- 物品名:未找到
            MURDERER = "为什么......",		-- 物品名:未找到
            REVIVER = "谢谢！",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕。"
            GHOST = "先稍等一下，在下马上就会帮你。",		-- 物品名:"幽灵"
            FIRESTARTER = "不要玩火哦，%s。",		-- 物品名:未找到
        },
        WILSON =
        {
            GENERIC = "贵安，威尔逊先生，今天也要进行实验吗？",		-- 物品名:"威尔逊"->默认
            ATTACKER = "来战斗吧！",		-- 物品名:"威尔逊"
            MURDERER = "为什么......，%s！",		-- 物品名:"威尔逊"
            REVIVER = "谢谢你！",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕。"
            GHOST = "先稍等一下，在下马上就会帮你。",		-- 物品名:"幽灵"
            FIRESTARTER = "不要玩火哦，%s。",		-- 物品名:"威尔逊"
        },
        WOLFGANG =
        {
            GENERIC = "沃尔夫冈先生 ，你的肌肉看起来真结实！",		-- 物品名:"沃尔夫冈"->默认
            ATTACKER = "来战斗吧！",		-- 物品名:"沃尔夫冈"
            MURDERER = "为什么......",		-- 物品名:"沃尔夫冈"
            REVIVER = "谢谢你！",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕。"
            GHOST = "先稍等一下，在下马上就会帮你。",		-- 物品名:"幽灵"
            FIRESTARTER = "不要玩火哦，%s。",		-- 物品名:"沃尔夫冈"
        },
        WAXWELL =
        {
            GENERIC = "麦斯威尔先生是个优雅的绅士。",		-- 物品名:"麦斯威尔"->默认
            ATTACKER = "来战斗吧！",		-- 物品名:"麦斯威尔"
            MURDERER = "为什么......",		-- 物品名:"麦斯威尔"
            REVIVER = "谢谢你！",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕。"
            GHOST = "先稍等一下，在下马上就会帮你。",		-- 物品名:"幽灵"
            FIRESTARTER = "不要玩火哦，%s。",		-- 物品名:"麦斯威尔"
        },
        WX78 =
        {
            GENERIC = "喔~机器人！",		-- 物品名:"WX-78"->默认
            ATTACKER = "%s，来战斗吧！",		-- 物品名:"WX-78"
            MURDERER = "为什么......",		-- 物品名:"WX-78"
            REVIVER = "谢谢你！",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕。"
            GHOST = "先稍等一下，在下马上就会帮你。",		-- 物品名:"幽灵"
            FIRESTARTER = "不要玩火哦，%s。",		-- 物品名:"WX-78"
        },
        WILLOW =
        {
            GENERIC = "薇洛小姐 ，暖洋洋的。",		-- 物品名:"薇洛"->默认
            ATTACKER = "%s来战斗吧！",		-- 物品名:"薇洛"
            MURDERER = "为什么......",		-- 物品名:"薇洛"
            REVIVER = "谢谢你！",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕。"
            GHOST = "先稍等一下，在下马上就会帮你。",		-- 物品名:"幽灵"
            FIRESTARTER = "不要玩火哦，%s。",		-- 物品名:"薇洛"
        },
        WENDY =
        {
            GENERIC = "日安，温蒂小姐。",		-- 物品名:"温蒂"->默认
            ATTACKER = "%s来战斗吧！",		-- 物品名:"温蒂"
            MURDERER = "为什么......",		-- 物品名:"温蒂"
            REVIVER = "谢谢你！",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕。"
            GHOST = "先稍等一下，在下马上就会帮你。",		-- 物品名:"幽灵"
            FIRESTARTER = "不要玩火哦，%s。",		-- 物品名:"温蒂"
        },
        WOODIE =
        {
            GENERIC = "大胡子先生，今天也要去砍树吗？",		-- 物品名:"伍迪"->默认
            ATTACKER = "%s来战斗吧！",		-- 物品名:"伍迪"
            MURDERER = "为什么......",		-- 物品名:"伍迪"
            REVIVER = "谢谢你！",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕。"
            GHOST = "先稍等一下，在下马上就会帮你。",		-- 物品名:"幽灵"
            BEAVER = "喔！伍迪先生看起来很忙的样子。",		-- 物品名:"伍迪"
            BEAVERGHOST = "先稍等一下，在下马上就会帮你。",		-- 物品名:"伍迪"
            MOOSE = "哇，伍迪先生竟然还会变成一头鹿！",		-- 物品名:"伍迪"
            MOOSEGHOST = "先稍等一下，在下马上就会帮你。",		-- 物品名:"伍迪"
            GOOSE = "鹅！鹅！鹅！",		-- 物品名:"伍迪"
            GOOSEGHOST = "先稍等一下，在下马上就会帮你。",		-- 物品名:"伍迪"
            FIRESTARTER = "不要玩火哦，%s。",		-- 物品名:"伍迪"
        },
        WICKERBOTTOM =
        {
            GENERIC = "日安，薇克巴顿奶奶。",		-- 物品名:"薇克巴顿"->默认
            ATTACKER = "%s来战斗吧！",		-- 物品名:"薇克巴顿"
            MURDERER = "为什么......",		-- 物品名:"薇克巴顿"
            REVIVER = "谢谢你！",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕。"
            GHOST = "先稍等一下，在下马上就会帮你。",		-- 物品名:"幽灵"
            FIRESTARTER = "不要玩火哦，%s。",		-- 物品名:"薇克巴顿"
        },
        WES =
        {
            GENERIC = "你好，%s！",		-- 物品名:"韦斯"->默认
            ATTACKER = "%s来战斗吧！",		-- 物品名:"韦斯"
            MURDERER = "为什么......",		-- 物品名:"韦斯"
            REVIVER = "谢谢你！",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕。"
            GHOST = "先稍等一下，在下马上就会帮你。",		-- 物品名:"幽灵"
            FIRESTARTER = "不要玩火哦，%s。",		-- 物品名:"韦斯"
        },
        WEBBER =
        {
            GENERIC = "日安，%s！",		-- 物品名:"韦伯"->默认
            ATTACKER = "%s来战斗吧！",		-- 物品名:"韦伯"
            MURDERER = "为什么......",		-- 物品名:"韦伯"
            REVIVER = "谢谢你！",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕。"
            GHOST = "先稍等一下，在下马上就会帮你。",		-- 物品名:"幽灵"
            FIRESTARTER = "不要玩火哦，%s。",		-- 物品名:"韦伯"
        },
        WATHGRITHR =
        {
            GENERIC = "日安，%s！",		-- 物品名:"薇格弗德"->默认
            ATTACKER = "%s来战斗吧！",		-- 物品名:"薇格弗德"
            MURDERER = "为什么......",		-- 物品名:"薇格弗德"
            REVIVER = "谢谢你！",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕。"
            GHOST = "先稍等一下，在下马上就会帮你。",		-- 物品名:"幽灵"
            FIRESTARTER = "不要玩火哦，%s。",		-- 物品名:"薇格弗德"
        },
        WINONA =
        {
            GENERIC = "日安，%s！",		-- 物品名:"薇诺娜"->默认
            ATTACKER = "%s来战斗吧！",		-- 物品名:"薇诺娜"
            MURDERER = "为什么......",		-- 物品名:"薇诺娜"
            REVIVER = "谢谢你！",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕。"
            GHOST = "先稍等一下，在下马上就会帮你。",		-- 物品名:"幽灵"
            FIRESTARTER = "不要玩火哦，%s。",		-- 物品名:"薇诺娜"
        },
        WORTOX =
        {
            GENERIC = "你好，%s！",		-- 物品名:"沃拓克斯"->默认
            ATTACKER = "%s来战斗吧！",		-- 物品名:"沃拓克斯"
            MURDERER = "为什么......",		-- 物品名:"沃拓克斯"
            REVIVER = "谢谢你！",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕。"
            GHOST = "先稍等一下，在下马上就会帮你。",		-- 物品名:"幽灵"
            FIRESTARTER = "不要玩火哦，%s。",		-- 物品名:"沃拓克斯"
        },
        WORMWOOD =
        {
            GENERIC = "你好，%s！",		-- 物品名:"沃姆伍德"->默认
            ATTACKER = "%s来战斗吧！",		-- 物品名:"沃姆伍德"
            MURDERER = "为什么......",		-- 物品名:"沃姆伍德"
            REVIVER = "谢谢你！",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕。"
            GHOST = "先稍等一下，在下马上就会帮你。",		-- 物品名:"幽灵"
            FIRESTARTER = "不要玩火哦，%s。",		-- 物品名:"沃姆伍德"
        },
        WARLY =
        {
            GENERIC = "你好，%s！",		-- 物品名:"沃利"->默认
            ATTACKER = "%s来战斗吧！",		-- 物品名:"沃利"
            MURDERER = "为什么......",		-- 物品名:"沃利"
            REVIVER = "谢谢你！",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕。"
            GHOST = "先稍等一下，在下马上就会帮你。",		-- 物品名:"幽灵"
            FIRESTARTER = "不要玩火哦，%s。",		-- 物品名:"沃利"
        },
        WURT =
        {
            GENERIC = "日安，%s！",		-- 物品名:"沃特"->默认
            ATTACKER = "%s来战斗吧！",		-- 物品名:"沃特"
            MURDERER = "为什么......",		-- 物品名:"沃特"
            REVIVER = "谢谢你！",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕。"
            GHOST = "先稍等一下，在下马上就会帮你。",		-- 物品名:"幽灵"
            FIRESTARTER = "不要玩火哦，%s。",		-- 物品名:"沃特"
        },
        WALTER =
        {
            GENERIC = "日安，%s！",		-- 物品名:"沃尔特"->默认
            ATTACKER = "%s来战斗吧！",		-- 物品名:"沃尔特"
            MURDERER = "为什么......",		-- 物品名:"沃尔特"
            REVIVER = "谢谢你！",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕。"
            GHOST = "先稍等一下，在下马上就会帮你。",		-- 物品名:"幽灵"
            FIRESTARTER = "不要玩火哦，%s。",		-- 物品名:"沃尔特"
        },
        WANDA =
        {
            GENERIC = "日安，%s！",		-- 物品名:"旺达"->默认
            ATTACKER = "%s来战斗吧！",		-- 物品名:"旺达"
            MURDERER = "为什么......",		-- 物品名:"旺达"
            REVIVER = "谢谢你！",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕。"
            GHOST = "先稍等一下，在下马上就会帮你。",		-- 物品名:"幽灵"
            FIRESTARTER = "不要玩火哦，%s。",		-- 物品名:"旺达"
        },
        WONKEY =
        {
            GENERIC = "是猴子？还是朋友？",		-- 物品名:"芜猴"->默认
            ATTACKER = "%s来战斗吧！",		-- 物品名:"芜猴"
            MURDERER = "为什么......",		-- 物品名:"芜猴"
            REVIVER = "谢谢你！",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕。"
            GHOST = "先稍等一下，在下马上就会帮你。",		-- 物品名:"幽灵"
            FIRESTARTER = "不要玩火哦，%s。",		-- 物品名:"芜猴"
        },
        MIGRATION_PORTAL =
        {
        },
        GLOMMER =
        {
            GENERIC = "是格罗姆？还是咕噜咪？",		-- 物品名:"格罗姆"->默认
            SLEEPING = "呼呼，呼呼，睡~着~啦~",		-- 物品名:"格罗姆"->睡着了
        },
        GLOMMERFLOWER =
        {
            GENERIC = "格罗姆的花，带上它就能拥有一只格罗姆哦。",		-- 物品名:"格罗姆花"->默认
            DEAD = "我们没能保护好它......",		-- 物品名:"格罗姆花"->死了
        },
        GLOMMERWINGS = "是格罗姆的翅膀。",		-- 物品名:"格罗姆翅膀"
        GLOMMERFUEL = "那个不能吃！快吐出来！",		-- 物品名:"格罗姆的黏液"
        BELL = "叮呤呤。",		-- 物品名:"远古铃铛" 制造描述:"这可不是普通的铃铛。"
        STATUEGLOMMER =
        {
            GENERIC = "满月时或许可以过来看看。",		-- 物品名:"格罗姆雕像"->默认
            EMPTY = "已经被开采过了。",		-- 物品名:"格罗姆雕像"
        },
        LAVA_POND_ROCK = "这是岩石吗？",		-- 物品名:"岩石"
		WEBBERSKULL = "很久很久以前......",		-- 物品名:"韦伯的头骨"
		WORMLIGHT = "在下像精灵一样发光！",		-- 物品名:"发光浆果"
		WORMLIGHT_LESSER = "小小的，亮亮的。",		-- 物品名:"小发光浆果"
		WORM =
		{
		    PLANT = "这是.....蠕虫吗？",		-- 物品名:"洞穴蠕虫"
		    DIRT = "好像是什么.....东西？",		-- 物品名:"洞穴蠕虫"
		    WORM = "它是一只蠕虫！",		-- 物品名:"洞穴蠕虫"
		},
        WORMLIGHT_PLANT = "蠕虫？",		-- 物品名:"神秘植物"
		MOLE =
		{
			HELD = "鼹鼠~鼹鼠~",		-- 物品名:"鼹鼠"->拿在手里
			UNDERGROUND = "放在地上的东西可能会被那个家伙偷走.....",		-- 物品名:"鼹鼠"
			ABOVEGROUND = "我们拿出锤子来把它砸晕吧。",		-- 物品名:"鼹鼠"
		},
		MOLEHILL = "不知道里面都藏了什么好东西",		-- 物品名:"鼹鼠丘"
		MOLEHAT = "好奇怪的帽子，但是戴上就不怕黑了。",		-- 物品名:"鼹鼠帽" 制造描述:"为穿戴者提供夜视能力。"
		EEL = "嘿嘿今晚我们吃鳗鱼哦~",		-- 物品名:"鳗鱼"
		EEL_COOKED = "好香！",		-- 物品名:"熟鳗鱼"
		UNAGI = "鳗鱼~好多鳗鱼~",		-- 物品名:"鳗鱼料理"
		EYETURRET = "是个好帮手。",		-- 物品名:"眼睛炮塔"
		EYETURRET_ITEM = "可以放在地上让它保护我们哦。",		-- 物品名:"眼睛炮塔" 制造描述:"要远离讨厌的东西，就得杀了它们。"
		MINOTAURHORN = "尖尖的。",		-- 物品名:"守护者之角"
		MINOTAURCHEST = "战利品宝箱！",		-- 物品名:"大号华丽箱子"
		THULECITE_PIECES = "多攒一些或许可以制作成一整块的铥矿。",		-- 物品名:"铥矿碎片"
		POND_ALGAE = "池塘边的水藻。",		-- 物品名:"水藻"
		GREENSTAFF = "新的法杖！",		-- 物品名:"拆解魔杖" 制造描述:"干净而有效的摧毁。"
		GIFT = "嘿嘿~里面会有什么呢~",		-- 物品名:"礼物"
        GIFTWRAP = "可以.....给伙伴们包一些礼物......",		-- 物品名:"礼物包装" 制造描述:"把东西打包起来，好看又可爱！"
		POTTEDFERN = "养一些蕨类在家里吧。",		-- 物品名:"蕨类盆栽" 制造描述:"做个花盆，里面栽上蕨类植物。"
        SUCCULENT_POTTED = "不要乱捏哦。",		-- 物品名:"多肉盆栽" 制造描述:"塞进陶盆的漂亮多肉植物。"
		SUCCULENT_PLANT = "那里有芦荟。",		-- 物品名:"多肉植物"
		SUCCULENT_PICKED = "栽下去一定会很好看。",		-- 物品名:"多肉植物"
		SENTRYWARD = "更好的守卫。",		-- 物品名:"月眼守卫" 制造描述:"绘图者最有价值的武器。"
        TOWNPORTAL =
        {
			GENERIC = "找呀找呀找朋友~",		-- 物品名:"懒人传送塔"->默认 制造描述:"用沙子的力量聚集你的朋友们。"
			ACTIVE = "准备好分离。",		-- 物品名:"懒人传送塔"->激活了 制造描述:"用沙子的力量聚集你的朋友们。"
		},
        TOWNPORTALTALISMAN =
        {
			GENERIC = "隐隐透露着能传送的感觉。",		-- 物品名:"沙之石"->默认
			ACTIVE = "嗯？",		-- 物品名:"沙之石"->激活了
		},
        WETPAPER = "文化的承载者！",		-- 物品名:"纸张"
        WETPOUCH = "这个包裹只能勉强绑在一起。",		-- 物品名:"起皱的包裹"
        MOONROCK_PIECES = "不要被划伤哦。",		-- 物品名:"月亮石碎块"
        MOONBASE =
        {
            GENERIC = "我们可以插上一根唤星法杖试一试。",		-- 物品名:"月亮石"->默认
            BROKEN = "坏掉了，再用一些月岩修一修吧",		-- 物品名:"月亮石"
            STAFFED = "然后呢？",		-- 物品名:"月亮石"
            WRONGSTAFF = "不对，不是这个法杖哦。",		-- 物品名:"月亮石"->插错法杖
            MOONSTAFF = "风月无边。",		-- 物品名:"月亮石"->已经插了法杖的（月杖）
        },
        MOONDIAL =
        {
			GENERIC = "可以用这个来观测月相。",		-- 物品名:"月晷"->默认 制造描述:"追踪月相！"
			NIGHT_NEW = "是新月。",		-- 物品名:"月晷"->新月 制造描述:"追踪月相！"
			NIGHT_WAX = "月亮慢慢在变圆。",		-- 物品名:"月晷"->上弦月 制造描述:"追踪月相！"
			NIGHT_FULL = "是满月。",		-- 物品名:"月晷"->满月 制造描述:"追踪月相！"
			NIGHT_WANE = "月亮正在变小。",		-- 物品名:"月晷"->下弦月 制造描述:"追踪月相！"
			CAVE = "洞穴里可看不到月亮哦。",		-- 物品名:"月晷"->洞穴 制造描述:"追踪月相！"
			WEREBEAVER = "only_used_by_woodie", --woodie specific		-- 物品名:"月晷" 制造描述:"追踪月相！"
			GLASSED = "在下有种奇怪的感觉，好像有人在盯着在下。",		-- 物品名:"月晷" 制造描述:"追踪月相！"
        },
		THULECITE = "珍贵的矿物，我们可以做一些更好的装备了。",		-- 物品名:"铥矿" 制造描述:"将小碎片合成一大块。"
		ARMORRUINS = "很轻，但是非常好用。",		-- 物品名:"铥矿甲" 制造描述:"炫目并且能提供保护。"
		ARMORSKELETON = "骨头。",		-- 物品名:"骨头盔甲"
		SKELETONHAT = "戴久了会头晕。",		-- 物品名:"骨头头盔"
		RUINS_BAT = "这算是我们能做出来最好的武器了吧？",		-- 物品名:"铥矿棒" 制造描述:"尖钉让一切变得更好。"
		RUINSHAT = "皇冠！",		-- 物品名:"铥矿皇冠" 制造描述:"附有远古力场！"
		NIGHTMARE_TIMEPIECE =
		{
            CALM = "神秘的徽章，能观测出什么信息呢？",		-- 物品名:"铥矿徽章" 制造描述:"跟踪周围魔力水平的流动。"
            WARN = "感测到这里有相当强的魔法能量。",		-- 物品名:"铥矿徽章" 制造描述:"跟踪周围魔力水平的流动。"
            WAXING = "变得越来越密集了！",		-- 物品名:"铥矿徽章" 制造描述:"跟踪周围魔力水平的流动。"
            STEADY = "好像保持稳定了。",		-- 物品名:"铥矿徽章" 制造描述:"跟踪周围魔力水平的流动。"
            WANING = "感觉魔法能量正在逐渐减弱。",		-- 物品名:"铥矿徽章" 制造描述:"跟踪周围魔力水平的流动。"
            DAWN = "噩梦就要结束了！",		-- 物品名:"铥矿徽章" 制造描述:"跟踪周围魔力水平的流动。"
            NOMAGIC = "这里没有魔法能量。",		-- 物品名:"铥矿徽章" 制造描述:"跟踪周围魔力水平的流动。"
		},
		BISHOP_NIGHTMARE = "就算坏了也会给我们找麻烦。",		-- 物品名:"损坏的发条主教"
		ROOK_NIGHTMARE = "它撞进了死亡。",		-- 物品名:"损坏的发条战车"
		KNIGHT_NIGHTMARE = "损坏的棋子还有价值吗？",		-- 物品名:"损坏的发条骑士"
		MINOTAUR = "大犀牛！",		-- 物品名:"远古守护者"
		SPIDER_DROPPER = "在下.....在下才不害怕......",		-- 物品名:"穴居悬蛛"
		NIGHTMARELIGHT = "梦魇的力量.....",		-- 物品名:"梦魇灯座"
		NIGHTSTICK = "闪亮亮的武器。",		-- 物品名:"晨星锤" 制造描述:"用于夜间战斗的晨光。"
		GREENGEM = "绿色的宝石，闪亮亮的。",		-- 物品名:"绿宝石"
		MULTITOOL_AXE_PICKAXE = "真是一把好工具呀。",		-- 物品名:"多用斧镐" 制造描述:"加倍实用。"
		ORANGESTAFF = "呜呼~好神奇！",		-- 物品名:"懒人魔杖" 制造描述:"适合那些不喜欢走路的人。"
		YELLOWAMULET = "暖暖的。",		-- 物品名:"魔光护符" 制造描述:"从天堂汲取力量。"
		GREENAMULET = "有了这个，就能节约下来好多材料。",		-- 物品名:"建造护符" 制造描述:"用更少的材料合成物品！"
		SLURPERPELT = "死了的样子也没什么不同。",		-- 物品名:"铥矿徽章"->啜食者皮 制造描述:"跟踪周围魔力水平的流动。"
		SLURPER = "呀！它想咬在下的头！",		-- 物品名:"啜食者"
		SLURPER_PELT = "饥饿的力量。",		-- 物品名:"啜食者皮"
		ARMORSLURPER = "为什么穿上之后能缓解饥饿呢？",		-- 物品名:"饥饿腰带" 制造描述:"保持肚子不饿。"
		ORANGEAMULET = "呼呼呼，全到这里来！",		-- 物品名:"懒人护符" 制造描述:"适合那些不喜欢捡东西的人。"
		YELLOWSTAFF = "召唤一颗小星星~",		-- 物品名:"唤星者魔杖" 制造描述:"召唤一个小星星。"
		YELLOWGEM = "这个宝石是黄色的。",		-- 物品名:"黄宝石"
		ORANGEGEM = "一颗橙宝石。",		-- 物品名:"橙宝石"
        OPALSTAFF = "彩虹色的神秘。",		-- 物品名:"唤月者魔杖"
        OPALPRECIOUSGEM = "这真漂亮呀。",		-- 物品名:"彩虹宝石"
        TELEBASE =
		{
			VALID = "它准备好了。",		-- 物品名:"传送焦点"->有效 制造描述:"装上宝石试试。"
			GEMS = "它需要更多紫宝石。",		-- 物品名:"传送焦点"->需要宝石 制造描述:"装上宝石试试。"
		},
		GEMSOCKET =
		{
			VALID = "看起来准备就绪了。",		-- 物品名:"宝石底座"->有效
			GEMS = "它需要一颗宝石。",		-- 物品名:"宝石底座"->需要宝石
		},
		STAFFLIGHT = "小星星，可以用来做简单的料理。",		-- 物品名:"矮星"
        STAFFCOLDLIGHT = "冰冷的小星星！",		-- 物品名:"极光"
        ANCIENT_ALTAR = "古老而神秘的建筑。",		-- 物品名:"远古伪科学站"
        ANCIENT_ALTAR_BROKEN = "这个好像破损了。",		-- 物品名:"损坏的远古伪科学站"
        ANCIENT_STATUE = "没想到这里还能有这么宏伟的遗迹呀。",		-- 物品名:"远古雕像"
        LICHEN = "坚强的大自然。",		-- 物品名:"洞穴苔藓"
		CUTLICHEN = "有营养，但保存不了多久。",		-- 物品名:"苔藓"
		CAVE_BANANA = "为什么香蕉会长在洞穴里呢？",		-- 物品名:"香蕉"
		CAVE_BANANA_COOKED = "烤香蕉？",		-- 物品名:"熟香蕉"
		CAVE_BANANA_TREE = "洞穴里为什么会有香蕉树呢？",		-- 物品名:"洞穴香蕉树"
		ROCKY = "石头....虾？",		-- 物品名:"石虾"
		COMPASS =
		{
			GENERIC="在下面朝哪个方向？",		-- 物品名:"指南针"->默认 制造描述:"指向北方。"
			N = "北。",		-- 物品名:"指南针" 制造描述:"指向北方。"
			S = "南。",		-- 物品名:"指南针" 制造描述:"指向北方。"
			E = "东。",		-- 物品名:"指南针" 制造描述:"指向北方。"
			W = "西。",		-- 物品名:"指南针" 制造描述:"指向北方。"
			NE = "东北。",		-- 物品名:"指南针" 制造描述:"指向北方。"
			SE = "东南。",		-- 物品名:"指南针" 制造描述:"指向北方。"
			NW = "西北。",		-- 物品名:"指南针" 制造描述:"指向北方。"
			SW = "西南。",		-- 物品名:"指南针" 制造描述:"指向北方。"
		},
        HOUNDSTOOTH = "真锋利！",		-- 物品名:"犬牙"
        ARMORSNURTLESHELL = "缩进去就什么也不怕。",		-- 物品名:"蜗壳护甲"
        BAT = "可恶的蝙蝠。",		-- 物品名:"洞穴蝙蝠"
        BATBAT = "这已经不能吃了吧？",		-- 物品名:"蝙蝠棒" 制造描述:"所有科技都如此...耗费精神。"
        BATWING = "蝙蝠的翅膀。",		-- 物品名:"洞穴蝙蝠翅膀"
        BATWING_COOKED = "已经熟了。",		-- 物品名:"熟蝙蝠翅膀"
        BATCAVE = "嘘！我们还是绕着走吧。",		-- 物品名:"蝙蝠洞"
        BEDROLL_FURRY = "能睡个好觉~嘿嘿。",		-- 物品名:"毛皮铺盖" 制造描述:"舒适地一觉睡到天亮！"
        BUNNYMAN = "它们似乎很讨厌肉。",		-- 物品名:"兔人"
        FLOWER_CAVE = "地底下的花，不过能够发光。",		-- 物品名:"荧光花"
        GUANO = "能用来施肥。",		-- 物品名:"鸟粪"
        LANTERN = "里面或许有一只小精灵！。",		-- 物品名:"提灯" 制造描述:"可加燃料、明亮、便携！"
        LIGHTBULB = "嗯？摘下来也会发光吗？",		-- 物品名:"荧光果"
        MANRABBIT_TAIL = "软乎乎的。",		-- 物品名:"兔绒"
        MUSHROOMHAT = "戴上的话...不会被管道工踩吧？",		-- 物品名:"蘑菇帽"
        MUSHROOM_LIGHT2 =
        {
            ON = "蓝色，蓝色。",		-- 物品名:"菌伞灯"->开启 制造描述:"受到火山岩浆灯饰学问的激发。"
            OFF = "我们可以用一些主要颜色来生成一个主要光源。",		-- 物品名:"菌伞灯"->关闭 制造描述:"受到火山岩浆灯饰学问的激发。"
            BURNT = "还是再做一个新的吧。",		-- 物品名:"菌伞灯"->烧焦的 制造描述:"受到火山岩浆灯饰学问的激发。"
        },
        MUSHROOM_LIGHT =
        {
            ON = "蘑菇，亮亮的蘑菇。",		-- 物品名:"蘑菇灯"->开启 制造描述:"任何蘑菇的完美添加物。"
            OFF = "好大的蘑菇。",		-- 物品名:"蘑菇灯"->关闭 制造描述:"任何蘑菇的完美添加物。"
            BURNT = "已经成了烤蘑菇。",		-- 物品名:"蘑菇灯"->烧焦的 制造描述:"任何蘑菇的完美添加物。"
        },
        SLEEPBOMB = "啊——哈......已经有困意了 。",		-- 物品名:"睡袋" 制造描述:"可以扔掉的袋子睡意沉沉。"
        MUSHROOMBOMB = "快跑！",		-- 物品名:"炸弹蘑菇"
        SHROOM_SKIN = "如果可以的话.....在下不太想摸这个.....",		-- 物品名:"蘑菇皮"
        TOADSTOOL_CAP =
        {
            EMPTY = "真的只是一个洞吗？",		-- 物品名:"毒菌蟾蜍"
            INGROUND = "有东西伸出来了。",		-- 物品名:"毒菌蟾蜍"->在地里面
            GENERIC = "在下敢肯定底下是个大家伙。",		-- 物品名:"毒菌蟾蜍"->默认
        },
        TOADSTOOL =
        {
            GENERIC = "好多眼睛！",		-- 物品名:"毒菌蟾蜍"->默认
            RAGE = "它生气！",		-- 物品名:"毒菌蟾蜍"->愤怒
        },
        MUSHROOMSPROUT =
        {
            GENERIC = "能召唤蘑菇精灵的帽子",		-- 物品名:"孢子帽"->默认
            BURNT = "坏掉了。",		-- 物品名:"孢子帽"->烧焦的
        },
        MUSHTREE_TALL =
        {
            GENERIC = "蓝色的蘑菇树。",		-- 物品名:"蓝蘑菇树"->默认
            BLOOM = "它在制造蘑菇吗？",		-- 物品名:"蓝蘑菇树"->蘑菇树繁殖？？
        },
        MUSHTREE_MEDIUM =
        {
            GENERIC = "红色的蘑菇树。",		-- 物品名:"红蘑菇树"->默认
            BLOOM = "新的蘑菇。",		-- 物品名:"红蘑菇树"->蘑菇树繁殖？？
        },
        MUSHTREE_SMALL =
        {
            GENERIC = "绿色的蘑菇树。",		-- 物品名:"绿蘑菇树"->默认
            BLOOM = "它在努力繁殖。",		-- 物品名:"绿蘑菇树"->蘑菇树繁殖？？
        },
        MUSHTREE_TALL_WEBBED = "离这棵树远一点哦，不然会碰到蜘蛛的。",		-- 物品名:"蛛网蓝蘑菇树"
        SPORE_TALL =
        {
            GENERIC = "它四处飘荡。",		-- 物品名:"蓝色孢子"->默认
            HELD = "口袋里的光。",		-- 物品名:"蓝色孢子"->拿在手里
        },
        SPORE_MEDIUM =
        {
            GENERIC = "红色的孢子。",		-- 物品名:"红色孢子"->默认
            HELD = "口袋里的光。",		-- 物品名:"红色孢子"->拿在手里
        },
        SPORE_SMALL =
        {
            GENERIC = "飘呀飘~",		-- 物品名:"绿色孢子"->默认
            HELD = "口袋里的光。",		-- 物品名:"绿色孢子"->拿在手里
        },
        RABBITHOUSE =
        {
            GENERIC = "兔先生是不是在里面用牙咬出来一个房间？",		-- 物品名:"兔屋"->默认 制造描述:"可容纳一只巨大的兔子及其所有物品。"
            BURNT = "烤胡萝卜！",		-- 物品名:"兔屋"->烧焦的 制造描述:"可容纳一只巨大的兔子及其所有物品。"
        },
        SLURTLE = "蛞蝓？还是乌龟？",		-- 物品名:"蛞蝓龟"
        SLURTLE_SHELLPIECES = "很坚硬。",		-- 物品名:"外壳碎片"
        SLURTLEHAT = "这个真的能戴在头上吗？",		-- 物品名:"背壳头盔"
        SLURTLEHOLE = "看着不太舒服。",		-- 物品名:"蛞蝓龟窝"
        SLURTLESLIME = "噫——",		-- 物品名:"蛞蝓龟黏液"
        SNURTLE = "大大大蜗牛。",		-- 物品名:"蜗牛龟"
        SPIDER_HIDER = "新的蜘蛛。",		-- 物品名:"洞穴蜘蛛"
        SPIDER_SPITTER = "它让在下有些不太舒服。",		-- 物品名:"喷射蜘蛛"
        SPIDERHOLE = "蜘蛛在里面睡觉。",		-- 物品名:"蛛网岩"
        SPIDERHOLE_ROCK = "它外面盖满了蛛网。",		-- 物品名:"兔屋" 制造描述:"可容纳一只巨大的兔子及其所有物品。"
        STALAGMITE = "不错的石头来源。",		-- 物品名:"石笋"
        STALAGMITE_TALL = "石头，石头，石头，石头...",		-- 物品名:"石笋"
        TURF_CARPETFLOOR = "柔软的地毯，在下喜欢",		-- 物品名:"地毯地板" 制造描述:"超级柔软。闻着就像皮弗娄牛。"
        TURF_CHECKERFLOOR = "光滑的大理石，光滑的地板。",		-- 物品名:"棋盘地板" 制造描述:"精心制作成棋盘状的大理石地砖。"
        TURF_DIRT = "一块地皮。",		-- 物品名:"泥土地皮"
        TURF_FOREST = "一块地皮。",		-- 物品名:"森林地皮" 制造描述:"一块森林地皮。"
        TURF_GRASS = "一块地皮。",		-- 物品名:"长草地皮" 制造描述:"一片草地。"
        TURF_MARSH = "一块地皮。",		-- 物品名:"沼泽地皮" 制造描述:"沼泽在哪，家就在哪！"
        TURF_METEOR = "一块月球地面。",		-- 物品名:"月球环形山地皮" 制造描述:"月球表面的月坑。"
        TURF_PEBBLEBEACH = "一块海滩。",		-- 物品名:"岩石海滩地皮" 制造描述:"一块鹅卵石海滩地皮。"
        TURF_ROAD = "草草铺砌的石头。",		-- 物品名:"卵石路" 制造描述:"修建你自己的道路，通往任何地方。"
        TURF_ROCKY = "一块地皮。",		-- 物品名:"岩石地皮" 制造描述:"一块石头地皮。"
        TURF_SAVANNA = "一块地皮。",		-- 物品名:"热带草原地皮" 制造描述:"一块热带草原地皮。"
        TURF_WOODFLOOR = "这些是木地板。",		-- 物品名:"木地板" 制造描述:"优质复合地板。"
		TURF_CAVE="又一种地皮类型。",		-- 物品名:"鸟粪地皮" 制造描述:"洞穴地面冰冷的岩石。"
		TURF_FUNGUS="又一种地皮类型。",		-- 物品名:"真菌地皮" 制造描述:"一块长满了真菌的洞穴地皮。"
		TURF_FUNGUS_MOON = "又一种地皮类型。",		-- 物品名:"变异真菌地皮" 制造描述:"一块长满了变异真菌的洞穴地皮。"
		TURF_ARCHIVE = "又一种地皮类型。",		-- 物品名:"远古石刻" 制造描述:"解封档案馆中的远古石器。"
		TURF_SINKHOLE="又一种地皮类型。",		-- 物品名:"黏滑地皮" 制造描述:"一块潮湿、沾满泥巴的草地地皮。"
		TURF_UNDERROCK="又一种地皮类型。",		-- 物品名:"洞穴岩石地皮" 制造描述:"一块乱石嶙峋的洞穴地皮。"
		TURF_MUD="又一种地皮类型。",		-- 物品名:"泥泞地皮" 制造描述:"一块泥地地皮。"
		TURF_DECIDUOUS = "又一种地皮类型。",		-- 物品名:"落叶林地皮" 制造描述:"一块落叶林地皮。"
		TURF_SANDY = "又一种地皮类型。",		-- 物品名:"兔屋" 制造描述:"可容纳一只巨大的兔子及其所有物品。"
		TURF_BADLANDS = "又一种地皮类型。",		-- 物品名:"兔屋" 制造描述:"可容纳一只巨大的兔子及其所有物品。"
		TURF_DESERTDIRT = "一块地皮。",		-- 物品名:"沙漠地皮" 制造描述:"一片干燥的沙子。"
		TURF_FUNGUS_GREEN = "一块地皮。",		-- 物品名:"真菌地皮" 制造描述:"一块爬满绿菌的洞穴地皮。"
		TURF_FUNGUS_RED = "一块地皮。",		-- 物品名:"真菌地皮" 制造描述:"一块爬满红菌的洞穴地皮。"
		TURF_DRAGONFLY = "能防火的地皮。",		-- 物品名:"龙鳞地板" 制造描述:"消除火灾蔓延速度。"
        TURF_SHELLBEACH = "一块海滩。",		-- 物品名:"贝壳海滩地皮" 制造描述:"一块贝壳海岸。"
		TURF_RUINSBRICK = "又一种地皮类型。",		-- 物品名:"远古地面" 制造描述:"远古石制地面，装饰的魔法技艺早已失传。"
		TURF_RUINSBRICK_GLOW = "又一种地皮类型。",		-- 物品名:"仿远古地面" 制造描述:"远古石制地面的复刻。"
		TURF_RUINSTILES = "又一种地皮类型。",		-- 物品名:"远古瓷砖" 制造描述:"瓷砖地面，装饰的魔法技艺早已失传。"
		TURF_RUINSTILES_GLOW = "又一种地皮类型。",		-- 物品名:"仿远古瓷砖" 制造描述:"远古瓷砖地面的复刻。"
		TURF_RUINSTRIM = "又一种地皮类型。",		-- 物品名:"远古砖雕" 制造描述:"砖石地面，装饰的魔法技艺早已失传。"
		TURF_RUINSTRIM_GLOW = "又一种地皮类型。",		-- 物品名:"仿远古砖雕" 制造描述:"远古砖石地面的复刻。"
        TURF_MONKEY_GROUND = "一片沙地。",		-- 物品名:"月亮码头海滩地皮" 制造描述:"一片沙地，散发着淡淡的香蕉香。"
        TURF_CARPETFLOOR2 = "它出奇地柔软。",		-- 物品名:"茂盛地毯" 制造描述:"超级超级软。"
        TURF_MOSAIC_GREY = "又一种地皮类型。",		-- 物品名:"灰色马赛克地板" 制造描述:"优雅的碎石。灰色。"
        TURF_MOSAIC_RED = "又一种地皮类型。",		-- 物品名:"红色马赛克地板" 制造描述:"优雅的碎石。红色。"
        TURF_MOSAIC_BLUE = "又一种地皮类型。",		-- 物品名:"蓝色马赛克地板" 制造描述:"优雅的碎石。蓝色。"
        TURF_BEARD_RUG = "臭臭的地毯，在下不喜欢",		-- 物品名:"胡须地毯" 制造描述:"有些人就是喜欢行为艺术。"
		POWCAKE = "芝士芝士蛋糕。",		-- 物品名:"芝士蛋糕"
        CAVE_ENTRANCE = "是落水洞？",		-- 物品名:"被堵住的洞穴"
        CAVE_ENTRANCE_RUINS = "它有可能在隐瞒什么事情。",		-- 物品名:"被堵住的陷洞"->单机 洞二入口
       	CAVE_ENTRANCE_OPEN =
        {
            GENERIC = "大自然在排斥在下！",		-- 物品名:"洞穴"->默认
            OPEN = "在下渴求冒险。",		-- 物品名:"洞穴"->打开
            FULL = "伙伴们在里面。",		-- 物品名:"洞穴"->满了
        },
        CAVE_EXIT =
        {
            GENERIC = "有风吹过，那里就是出口。",		-- 物品名:"楼梯"->默认
            OPEN = "在下暂时不想再探险了。",		-- 物品名:"楼梯"->打开
            FULL = "上面太拥挤！",		-- 物品名:"楼梯"->满了
        },
		MAXWELLPHONOGRAPH = "音乐原来是从那来的。",--single player		-- 物品名:"麦斯威尔的留声机"->单机 麦斯威尔留声机
		BOOMERANG = "风的力量！",		-- 物品名:"回旋镖" 制造描述:"来自澳洲土著。"
		PIGGUARD = "他看起来不那么友善。",		-- 物品名:"猪人守卫"
		ABIGAIL =
		{
            LEVEL1 =
            {
                "噢，她有一个可爱的小蝴蝶结。",		-- 物品名:未找到 制造描述:未找到
                "噢，她有一个可爱的小蝴蝶结。",		-- 物品名:未找到 制造描述:未找到
            },
            LEVEL2 =
            {
                "噢，她有一个可爱的小蝴蝶结。",		-- 物品名:未找到 制造描述:未找到
                "噢，她有一个可爱的小蝴蝶结。",		-- 物品名:未找到 制造描述:未找到
            },
            LEVEL3 =
            {
                "噢，她有一个可爱的小蝴蝶结。",		-- 物品名:未找到 制造描述:未找到
                "噢，她有一个可爱的小蝴蝶结。",		-- 物品名:未找到 制造描述:未找到
            },
		},
		ADVENTURE_PORTAL = "在下不想再一次上当了。",		-- 物品名:"麦斯威尔之门"->单机 麦斯威尔之门
		AMULET = "在下将会从地狱归来。",		-- 物品名:"重生护符" 制造描述:"逃离死神的魔爪。"
		ANIMAL_TRACK = "食物留下的踪迹。在下指的是...一只动物。",		-- 物品名:"动物足迹"
		ARMORGRASS = "希望里面没虫子。",		-- 物品名:"草甲" 制造描述:"提供少许防护。"
		ARMORMARBLE = "风吹不动它。",		-- 物品名:"大理石甲" 制造描述:"它很重，但能够保护你。"
		ARMORWOOD = "那是一件非常合适的衣服。",		-- 物品名:"木甲" 制造描述:"为你抵御部分伤害。"
		ARMOR_SANITY = "它让在下如鲠在喉。",		-- 物品名:"暗夜甲" 制造描述:"保护你的躯体，但无法保护你的心智。"
		ASH =
		{
			GENERIC = "火烧完之后剩下的一切。",		-- 物品名:"灰烬"->默认
			REMAINS_GLOMMERFLOWER = "传送时，花被火焰吞噬了！",		-- 物品名:"灰烬"->单机专用
			REMAINS_EYE_BONE = "传送时，眼骨被火焰吞噬了！",		-- 物品名:"灰烬"->单机专用
			REMAINS_THINGIE = "失去了所有生命力。",		-- 物品名:"灰烬"->单机专用
		},
		AXE = "可靠的斧头。",		-- 物品名:"斧头" 制造描述:"砍倒树木！"
		BABYBEEFALO =
		{
			GENERIC = "啊。太可爱了！",		-- 物品名:"小皮弗娄牛"->默认
		    SLEEPING = "做个好梦，小宝贝。",		-- 物品名:"小皮弗娄牛"->睡着了
        },
        BUNDLE = "我们的物资都在那里面！",		-- 物品名:"捆绑物资"
        BUNDLEWRAP = "把东西打包起来应该会容易搬一点。",		-- 物品名:"捆绑包装" 制造描述:"打包东西的必要工具。"
		BACKPACK = "必不可少。",		-- 物品名:"背包" 制造描述:"携带更多物品。"
		BACONEGGS = "经典料理",		-- 物品名:"培根煎蛋"
		BANDAGE = "似乎挺卫生的。",		-- 物品名:"蜂蜜药膏" 制造描述:"愈合小伤口。"
		BASALT = "太硬了，敲不碎！", --removed		-- 物品名:"玄武岩"
		BEARDHAIR = "OXO。",		-- 物品名:"胡须"
		BEARGER = "熊一样大的獾。",		-- 物品名:"熊獾"
		BEARGERVEST = "抵御寒风！",		-- 物品名:"熊皮背心" 制造描述:"像熊一样的背心。"
		ICEPACK = "毛皮使包内有保温效果。",		-- 物品名:"保鲜背包" 制造描述:"保持新鲜感。"
		BEARGER_FUR = "一块厚毛皮。",		-- 物品名:"熊皮" 制造描述:"毛皮再生。"
		BEDROLL_STRAW = "晚安，伙伴们。",		-- 物品名:"草席卷" 制造描述:"一觉睡到天亮。"
		BEEQUEEN = "大自然的女王！",		-- 物品名:"蜂王"
		BEEQUEENHIVE =
		{
			GENERIC = "太黏了，没法走下去了。",		-- 物品名:"蜂蜜地块"->默认
			GROWING = "勃勃生机",		-- 物品名:"蜂蜜地块"->正在生长
		},
        BEEQUEENHIVEGROWN = "大自然的女王在酣眠！",		-- 物品名:"巨大蜂窝"
        BEEGUARD = "它正在守卫女王。",		-- 物品名:"嗡嗡蜜蜂"
        HIVEHAT = "在下也能成为女王吗？",		-- 物品名:"蜂王冠"
        MINISIGN =
        {
            GENERIC = "在下可以画得比那好！",		-- 物品名:"小木牌"->默认
            UNDRAWN = "我们应该在那上面画些东西。",		-- 物品名:"小木牌"->没有画画
        },
        MINISIGN_ITEM = "像这样没有太多用处。我们应该把它放下。",		-- 物品名:"小木牌" 制造描述:"用羽毛笔在这些上面画画。"
		BEE =
		{
			GENERIC = "嗡嗡嗡，嗡嗡嗡。",		-- 物品名:"蜜蜂"->默认
			HELD = "当心！",		-- 物品名:"蜜蜂"->拿在手里
		},
		BEEBOX =
		{
			READY = "它里面装满了蜂蜜。",		-- 物品名:"蜂箱"->准备好的 满的 制造描述:"贮存你自己的蜜蜂。"
			FULLHONEY = "它里面装满了蜂蜜。",		-- 物品名:"蜂箱"->蜂蜜满了 制造描述:"贮存你自己的蜜蜂。"
			GENERIC = "蜜蜂！",		-- 物品名:"蜂箱"->默认 制造描述:"贮存你自己的蜜蜂。"
			NOHONEY = "它是空的。",		-- 物品名:"蜂箱"->没有蜂蜜 制造描述:"贮存你自己的蜜蜂。"
			SOMEHONEY = "需要等一会。",		-- 物品名:"蜂箱"->有一些蜂蜜 制造描述:"贮存你自己的蜜蜂。"
			BURNT = "怎么被烧掉的？！！",		-- 物品名:"蜂箱"->烧焦的 制造描述:"贮存你自己的蜜蜂。"
		},
		MUSHROOM_FARM =
		{
			STUFFED = "那真是许许多多的蘑菇！",		-- 物品名:"蘑菇农场"->塞，满了？？ 制造描述:"种蘑菇。"
			LOTS = "木头上长满了蘑菇。",		-- 物品名:"蘑菇农场"->很多 制造描述:"种蘑菇。"
			SOME = "现在它应该继续生长。",		-- 物品名:"蘑菇农场"->有一些 制造描述:"种蘑菇。"
			EMPTY = "它可以使用一个孢子。或是一个蘑菇移植植物。",		-- 物品名:"蘑菇农场" 制造描述:"种蘑菇。"
			ROTTEN = "它需要一根活木。",		-- 物品名:"蘑菇农场"->腐烂的--需要活木 制造描述:"种蘑菇。"
			BURNT = "焚风杀害了它。",		-- 物品名:"蘑菇农场"->烧焦的 制造描述:"种蘑菇。"
			SNOWCOVERED = "寒风凛冽，万物凋敝。",		-- 物品名:"蘑菇农场"->被雪覆盖 制造描述:"种蘑菇。"
		},
		BEEFALO =
		{
			FOLLOWER = "他在静静地跟着在下。",		-- 物品名:"皮弗娄牛"->追随者
			GENERIC = "牛先生！",		-- 物品名:"皮弗娄牛"->默认
			NAKED = "它看起来很伤心。",		-- 物品名:"皮弗娄牛"->牛毛被刮干净了
			SLEEPING = "嘘，牛牛在睡觉哦。",		-- 物品名:"皮弗娄牛"->睡着了
            DOMESTICATED = "它是在下的乖宝贝。",		-- 物品名:"皮弗娄牛"->驯化牛
            ORNERY = "牛牛非常生气。",		-- 物品名:"皮弗娄牛"->战斗牛
            RIDER = "跑得快的牛牛。",		-- 物品名:"皮弗娄牛"->骑行牛
            PUDGY = "贪吃的牛牛。",		-- 物品名:"皮弗娄牛"->胖牛
            MYPARTNER = "我们永远都是朋友。",		-- 物品名:"皮弗娄牛"
		},
		BEEFALOHAT = "有了它，牛牛会乐意与在下交朋友。",		-- 物品名:"牛角帽" 制造描述:"成为牛群中的一员！连气味也变得一样。"
		BEEFALOWOOL = "牛牛可能会伤心。",		-- 物品名:"牛毛"
		BEEHAT = "养蜂人的智慧。",		-- 物品名:"养蜂帽" 制造描述:"防止被愤怒的蜜蜂蜇伤。"
        BEESWAX = "可以封印时间的流逝",		-- 物品名:"蜂蜡" 制造描述:"一种有用的防腐蜂蜡。"
		BEEHIVE = "大自然的小精灵。",		-- 物品名:"蜂窝"
		BEEMINE = "它晃动时就会嗡嗡叫。",		-- 物品名:"蜜蜂地雷" 制造描述:"变成武器的蜜蜂。会出什么问题？"
		BEEMINE_MAXWELL = "被装在地雷里的狂暴蚊子！",--removed		-- 物品名:"麦斯威尔的蚊子陷阱"->单机 麦斯威尔的蚊子陷阱
		BERRIES = "红色浆果最好吃。",		-- 物品名:"浆果"
		BERRIES_COOKED = "简单可口的料理。",		-- 物品名:"烤浆果"
        BERRIES_JUICY = "非常美味，虽然美味稍纵即逝。",		-- 物品名:"多汁浆果"
        BERRIES_JUICY_COOKED = "最好在变质前吃掉！",		-- 物品名:"烤多汁浆果"
		BERRYBUSH =
		{
			BARREN = "这里藏着火鸡吗？",		-- 物品名:"浆果丛"
			WITHERED = "这么热的天气什么也生长不了。",		-- 物品名:"浆果丛"->枯萎了
			GENERIC = "这下觉得这些应该能吃。",		-- 物品名:"浆果丛"->默认
			PICKED = "或许它们会再长出来？",		-- 物品名:"浆果丛"->被采完了
			DISEASED = "看上去病的很重。",--removed		-- 物品名:"浆果丛"->生病了
			DISEASING = "呃...有些地方不对劲。",--removed		-- 物品名:"浆果丛"->正在生病？？
			BURNING = "火焰在伤害大自然。",		-- 物品名:"浆果丛"->正在燃烧
		},
		BERRYBUSH_JUICY =
		{
			BARREN = "在这种状态下，它长不出浆果。",		-- 物品名:"多汁浆果丛"
			WITHERED = "高温将多汁的浆果脱水！",		-- 物品名:"多汁浆果丛"->枯萎了
			GENERIC = "容易腐烂的浆果。",		-- 物品名:"多汁浆果丛"->默认
			PICKED = "下一批丛林在努力生长。",		-- 物品名:"多汁浆果丛"->被采完了
			DISEASED = "它看上去很不舒服。",--removed		-- 物品名:"多汁浆果丛"->生病了
			DISEASING = "呃...有些地方不对劲。",--removed		-- 物品名:"多汁浆果丛"->正在生病？？
			BURNING = "火焰在伤害大自然。",		-- 物品名:"多汁浆果丛"->正在燃烧
		},
		BIGFOOT = "那真是一只巨大无比的脚。",--removed		-- 物品名:"大脚怪"->单机 大脚怪
		BIRDCAGE =
		{
			GENERIC = "现在只需要一只鸟。",		-- 物品名:"鸟笼"->默认 制造描述:"为你的鸟类朋友提供一个幸福的家。"
			OCCUPIED = "被囚禁的小精灵",		-- 物品名:"鸟笼"->被占领 制造描述:"为你的鸟类朋友提供一个幸福的家。"
			SLEEPING = "哇哦，它睡着了。",		-- 物品名:"鸟笼"->睡着了 制造描述:"为你的鸟类朋友提供一个幸福的家。"
			HUNGRY = "它看起来有点饿。",		-- 物品名:"鸟笼"->有点饿了 制造描述:"为你的鸟类朋友提供一个幸福的家。"
			STARVING = "好久都没人喂食了吧？",		-- 物品名:"鸟笼"->挨饿 制造描述:"为你的鸟类朋友提供一个幸福的家。"
			DEAD = "也许它只是在休息？",		-- 物品名:"鸟笼"->死了 制造描述:"为你的鸟类朋友提供一个幸福的家。"
			SKELETON = "我们忘记为它了！",		-- 物品名:"骷髅"
		},
		BIRDTRAP = "蛛网带来的收益！",		-- 物品名:"捕鸟陷阱" 制造描述:"捕捉会飞的动物。"
		CAVE_BANANA_BURNT = "火焰杀死了它！",		-- 物品名:"鸟笼"->烧焦的鸟笼 制造描述:"为你的鸟类朋友提供一个幸福的家。"
		BIRD_EGG = "一颗正常的、小小的鸟蛋。",		-- 物品名:"鸟蛋"
		BIRD_EGG_COOKED = "真好吃！",		-- 物品名:"熟鸟蛋"
		BISHOP = "小心！它会使用远程攻击！",		-- 物品名:"发条主教"
		BLOWDART_FIRE = "焚风！",		-- 物品名:"火焰吹箭" 制造描述:"向你的敌人喷火。"
		BLOWDART_SLEEP = "不要倒吸进去。",		-- 物品名:"催眠吹箭" 制造描述:"催眠你的敌人。"
		BLOWDART_PIPE = "随风而发！",		-- 物品名:"吹箭" 制造描述:"向你的敌人喷射利齿。"
		BLOWDART_YELLOW = "飙举电至！",		-- 物品名:"雷电吹箭" 制造描述:"朝你的敌人放闪电。"
		BLUEAMULET = "寒风！",		-- 物品名:"寒冰护符" 制造描述:"多么冰冷酷炫的护符。"
		BLUEGEM = "它散发着冰冷能量的光芒。",		-- 物品名:"蓝宝石"
		BLUEPRINT =
		{
            COMMON = "知识！",		-- 物品名:"蓝图"
            RARE = "稀有的知识！",		-- 物品名:"蓝图"->罕见的
        },
        SKETCH = "一张雕像的图片。要找个地方才能做出来。",		-- 物品名:"{item}草图"
		COOKINGRECIPECARD = 
		{
			GENERIC = "原来还有这样的料理。",		-- 物品名:"{item}食谱卡"->默认
		},
		BLUE_CAP = "它很古怪，还黏黏的。",		-- 物品名:"采摘的蓝蘑菇"
		BLUE_CAP_COOKED = "这回不一样了……",		-- 物品名:"熟蓝蘑菇"
		BLUE_MUSHROOM =
		{
			GENERIC = "是蘑菇。",		-- 物品名:"蓝蘑菇"->默认
			INGROUND = "它在睡觉。",		-- 物品名:"蓝蘑菇"->在地里面
			PICKED = "不知道它会不会长回来？",		-- 物品名:"蓝蘑菇"->被采完了
		},
		BOARDS = "木板。",		-- 物品名:"木板" 制造描述:"更平直的木头。"
		BONESHARD = "一小片骨头。",		-- 物品名:"骨头碎片"
		BONESTEW = "这是。。。在下的伙伴？",		-- 物品名:"炖肉汤"
		BUGNET = "抓虫子用的。",		-- 物品名:"捕虫网" 制造描述:"抓虫子用的。"
		BUSHHAT = "看着有点扎人。",		-- 物品名:"灌木丛帽" 制造描述:"很好的伪装！"
		BUTTER = "优秀的食材！",		-- 物品名:"黄油"
		BUTTERFLY =
		{
			GENERIC = "蝴蝶，扑扑翅膀飞走了。",		-- 物品名:"蝴蝶"->默认
			HELD = "总算抓到你了！",		-- 物品名:"蝴蝶"->拿在手里
		},
		BUTTERFLYMUFFIN = "听话孩子的奖励。",		-- 物品名:"蝴蝶松饼"
		BUTTERFLYWINGS = "没了这些，它只是条毛虫。",		-- 物品名:"蝴蝶翅膀"
		BUZZARD = "大自然的送葬者！",		-- 物品名:"秃鹫"
		SHADOWDIGGER = "大自然的美丽精灵。",		-- 物品名:"蝴蝶"
        SHADOWDANCER = "有些东西你看到后就想赶紧忘掉……",		-- 物品名:"暗影舞者"
		CACTUS =
		{
			GENERIC = "会自卫的大自然。",		-- 物品名:"仙人掌"->默认
			PICKED = "成长需要微风和时间。",		-- 物品名:"仙人掌"->被采完了
		},
		CACTUS_MEAT_COOKED = "来自沙漠的烤水果。",		-- 物品名:"熟仙人掌肉"
		CACTUS_MEAT = "要想把它变成一顿美味，还需要把上面的刺弄掉。",		-- 物品名:"仙人掌肉"
		CACTUS_FLOWER = "多刺植物开出的美丽花朵。",		-- 物品名:"仙人掌花"
		COLDFIRE =
		{
			EMBERS = "火要灭了，吹吹风吧。",		-- 物品名:"吸热营火"->即将熄灭 制造描述:"这火是越烤越冷的冰火。"
			GENERIC = "驱散黑暗。",		-- 物品名:"吸热营火"->默认 制造描述:"这火是越烤越冷的冰火。"
			HIGH = "火太大了！",		-- 物品名:"吸热营火"->高 制造描述:"这火是越烤越冷的冰火。"
			LOW = "火变得有点小了。",		-- 物品名:"吸热营火"->低？ 制造描述:"这火是越烤越冷的冰火。"
			NORMAL = "这似乎不是魔法。",		-- 物品名:"吸热营火"->普通 制造描述:"这火是越烤越冷的冰火。"
			OUT = "哦，火灭了。",		-- 物品名:"吸热营火"->出去？外面？ 制造描述:"这火是越烤越冷的冰火。"
		},
		CAMPFIRE =
		{
			EMBERS = "火要灭了，吹吹风吧。",		-- 物品名:"营火"->即将熄灭 制造描述:"燃烧时发出光亮。"
			GENERIC = "驱散黑暗。",		-- 物品名:"营火"->默认 制造描述:"燃烧时发出光亮。"
			HIGH = "火太大了！",		-- 物品名:"营火"->高 制造描述:"燃烧时发出光亮。"
			LOW = "火变得有点小了。",		-- 物品名:"营火"->低？ 制造描述:"燃烧时发出光亮。"
			NORMAL = "霁风朗月。",		-- 物品名:"营火"->普通 制造描述:"燃烧时发出光亮。"
			OUT = "哦，火灭了。",		-- 物品名:"营火"->出去？外面？ 制造描述:"燃烧时发出光亮。"
		},
		CANE = "乘风而行。",		-- 物品名:"步行手杖" 制造描述:"泰然自若地快步走。"
		CATCOON = "顽皮的小东西。",		-- 物品名:"浣猫"
		CATCOONDEN =
		{
			GENERIC = "树桩里的窝。",		-- 物品名:"空心树桩"->默认
			EMPTY = "猫有九命，难逃一死。",		-- 物品名:"空心树桩"
		},
		CATCOONHAT = "遮住耳朵的帽子！",		-- 物品名:"猫帽" 制造描述:"适合那些重视温暖甚于朋友的人。"
		COONTAIL = "在下觉得它还在摆动。",		-- 物品名:"猫尾"
		CARROT = "新鲜的蔬菜。",		-- 物品名:"胡萝卜"
		CARROT_COOKED = "不要挑食哦。",		-- 物品名:"烤胡萝卜"
		CARROT_PLANTED = "土地在创造植物宝宝。",		-- 物品名:"胡萝卜"
		CARROT_SEEDS = "这是一颗种子。",		-- 物品名:"椭圆形种子"
		CARTOGRAPHYDESK =
		{
			GENERIC = "告诉伙伴们！",		-- 物品名:"制图桌"->默认 制造描述:"准确地告诉别人你去过哪里。"
			BURNING = "那件事到此为止。",		-- 物品名:"制图桌"->正在燃烧 制造描述:"准确地告诉别人你去过哪里。"
			BURNT = "现在就只有灰烬了。",		-- 物品名:"制图桌"->烧焦的 制造描述:"准确地告诉别人你去过哪里。"
		},
		WATERMELON_SEEDS = "这是一颗种子。",		-- 物品名:"方形种子"
		CAVE_FERN = "不适合作为食材。",		-- 物品名:"蕨类植物"
		CHARCOAL = "还可以继续燃烧。",		-- 物品名:"木炭"
        CHESSPIECE_PAWN = "一枚棋子。",		-- 物品名:"卒子雕塑"
        CHESSPIECE_ROOK =
        {
            GENERIC = "它比看上去的更重。",		-- 物品名:"战车雕塑"->默认
            STRUGGLE = "棋子们自己在动！",		-- 物品名:"战车雕塑"->三基佬棋子晃动
        },
        CHESSPIECE_KNIGHT =
        {
            GENERIC = "它是匹马，当然。",		-- 物品名:"骑士雕塑"->默认
            STRUGGLE = "棋子们自己在动！",		-- 物品名:"骑士雕塑"->三基佬棋子晃动
        },
        CHESSPIECE_BISHOP =
        {
            GENERIC = "是个石头主教。",		-- 物品名:"主教雕塑"->默认
            STRUGGLE = "棋子们自己在动！",		-- 物品名:"主教雕塑"->三基佬棋子晃动
        },
        CHESSPIECE_MUSE = "嗯...看起来很熟悉。",		-- 物品名:"女王雕塑"
        CHESSPIECE_FORMAL = "同样也是一枚棋子。",		-- 物品名:"国王雕塑"
        CHESSPIECE_HORNUCOPIA = "丰盛的料理，与伙伴分享！",		-- 物品名:"丰饶角雕塑"
        CHESSPIECE_PIPE = "禁止吸烟！",		-- 物品名:"泡泡烟斗雕塑"
        CHESSPIECE_DEERCLOPS = "感觉它的目光在跟着你。",		-- 物品名:"独眼巨鹿雕塑"
        CHESSPIECE_BEARGER = "靠近后它大得多了。",		-- 物品名:"熊獾雕塑"
        CHESSPIECE_MOOSEGOOSE =
        {
            "呃。这太逼真了。",		-- 物品名:"麋鹿鹅雕塑" 制造描述:未找到
        },
        CHESSPIECE_DRAGONFLY = "在下击败了它！",		-- 物品名:"龙蝇雕塑"
		CHESSPIECE_MINOTAUR = "现在轮到你被在下吓得一动不动了！",		-- 物品名:"远古守护者雕塑"
        CHESSPIECE_BUTTERFLY = "看着挺美的，对吧？",		-- 物品名:"月蛾雕塑"
        CHESSPIECE_ANCHOR = "果然和看上去一样沉。",		-- 物品名:"锚雕塑"
        CHESSPIECE_MOON = "最近在下感到备受启发。",		-- 物品名:"“月亮” 雕塑"
        CHESSPIECE_CARRAT = "这算素菜还是荤菜？",		-- 物品名:"胡萝卜鼠雕塑"
        CHESSPIECE_MALBATROSS = "它不追着杀你的时候还是挺可爱的。",		-- 物品名:"邪天翁雕塑"
        CHESSPIECE_CRABKING = "可以用来做料理吗？",		-- 物品名:"帝王蟹雕塑"
        CHESSPIECE_TOADSTOOL = "不能拿来当板凳坐，对吧？",		-- 物品名:"毒菌蟾蜍雕塑"
        CHESSPIECE_STALKER = "一动不动的骨架。",		-- 物品名:"远古织影者雕塑"
        CHESSPIECE_KLAUS = "它也有很多伙伴",		-- 物品名:"克劳斯雕塑"
        CHESSPIECE_BEEQUEEN = "很有雕塑感。",		-- 物品名:"蜂王雕塑"
        CHESSPIECE_ANTLION = "蚁狮雕塑。",		-- 物品名:"蚁狮雕塑"
        CHESSPIECE_BEEFALO = "这座雕塑很牛。",		-- 物品名:"皮弗娄牛雕塑"
		CHESSPIECE_KITCOON = "这些就很容易找到。",		-- 物品名:"小浣猫雕塑"
		CHESSPIECE_CATCOON = "它做抓柱很合适。",		-- 物品名:"浣猫雕塑"
        CHESSPIECE_MANRABBIT = "这下想抱抱它，但怕石头擦破皮。",		-- 物品名:"兔人雕塑"
        CHESSPIECE_GUARDIANPHASE3 = "这下更喜欢它这样。",		-- 物品名:"天体英雄雕塑"
        CHESSPIECE_EYEOFTERROR = "大眼睛OXO。",		-- 物品名:"恐怖之眼雕塑"
        CHESSPIECE_TWINSOFTERROR = "两只大眼睛OXO。",		-- 物品名:"双子魔眼雕塑"
        CHESSPIECE_DAYWALKER = "谁知道他现在去哪儿了。",		-- 物品名:"噩梦猪人雕像"
        CHESSPIECE_DEERCLOPS_MUTATED = "这座雕塑看起来有点刺眼。",		-- 物品名:"晶体独眼巨鹿雕塑"
        CHESSPIECE_WARG_MUTATED = "就差口臭了。",		-- 物品名:"附身座狼雕塑"
        CHESSPIECE_BEARGER_MUTATED = "这还能算大自然吗？",		-- 物品名:"装甲熊獾雕塑"
        CHESSJUNK1 = "一堆烂发条装置。",		-- 物品名:"损坏的发条装置"
        CHESSJUNK2 = "另一堆烂发条装置。",		-- 物品名:"损坏的发条装置"
        CHESSJUNK3 = "更多的烂发条装置。",		-- 物品名:"损坏的发条装置"
		CHESTER = "在下的伙伴！",		-- 物品名:"切斯特"
		CHESTER_EYEBONE =
		{
			GENERIC = "伙伴喜欢这个。",		-- 物品名:"眼骨"->默认
			WAITING = "它睡着了。",		-- 物品名:"眼骨"->需要等待
		},
		COOKEDMANDRAKE = "可怜的小家伙。",		-- 物品名:"熟曼德拉草"
		COOKEDMEAT = "碳烤熟透。",		-- 物品名:"熟肉"
		COOKEDMONSTERMEAT = "只比生吃的时候好吃一点点。",		-- 物品名:"熟怪物肉"
		COOKEDSMALLMEAT = "合适的配菜！",		-- 物品名:"熟小肉"
		COOKPOT =
		{
			COOKING_LONG = "饿了吗？不要着急哦。",		-- 物品名:"烹饪锅"->饭还需要很久 制造描述:"制作更好的食物。"
			COOKING_SHORT = "准备开饭咯！",		-- 物品名:"烹饪锅"->饭快做好了 制造描述:"制作更好的食物。"
			DONE = "开饭咯！",		-- 物品名:"烹饪锅"->完成了 制造描述:"制作更好的食物。"
			EMPTY = "丰盛的料理。",		-- 物品名:"烹饪锅" 制造描述:"制作更好的食物。"
			BURNT = "不能这样料理！",		-- 物品名:"烹饪锅"->烧焦的 制造描述:"制作更好的食物。"
		},
		CORN = "高果糖！",		-- 物品名:"玉米"
		CORN_COOKED = "做熟了，高果糖！",		-- 物品名:"爆米花"
		CORN_SEEDS = "这是一颗种子。",		-- 物品名:"簇状种子"
        CANARY =
		{
			GENERIC = "在下需要它。",		-- 物品名:"金丝雀"->默认
			HELD = "在下需要它的羽毛",		-- 物品名:"金丝雀"->拿在手里
		},
        CANARY_POISONED = "它真可怜。",		-- 物品名:"金丝雀（中毒）"
		CRITTERLAB = "那里面有什么东西吗？",		-- 物品名:"岩石巢穴"
        CRITTER_GLOMLING = "你好啊，新伙伴！",		-- 物品名:"小格罗姆"
        CRITTER_DRAGONLING = "它爬进了在下的心里。",		-- 物品名:"小龙蝇"
		CRITTER_LAMB = "比起它妈妈，它的粘液少多了。",		-- 物品名:"小钢羊"
        CRITTER_PUPPY = "对一只小怪兽来说真是太可爱了！",		-- 物品名:"小座狼"
        CRITTER_KITTEN = "你会成为一位很棒的实验室助手。",		-- 物品名:"浣猫崽"
        CRITTER_PERDLING = "在下的长羽毛的朋友。",		-- 物品名:"小火鸡"
		CRITTER_LUNARMOTHLING = "优雅的小精灵。",		-- 物品名:"小蛾子"
		CROW =
		{
			GENERIC = "黑色的使者！",		-- 物品名:"乌鸦"->默认
			HELD = "鸦雀无声。",		-- 物品名:"乌鸦"->拿在手里
		},
		CUTGRASS = "割下来的草，可用于制作和合成其他东西。",		-- 物品名:"采下的草"
		CUTREEDS = "割下的芦苇，可用于合成和消遣。",		-- 物品名:"采下的芦苇"
		CUTSTONE = "光滑诱人。",		-- 物品名:"石砖" 制造描述:"切成正方形的石头。"
		DEADLYFEAST = "功效最强的大餐。", --unimplemented		-- 物品名:"致命盛宴"->致命盛宴 单机
		DEER =
		{
			GENERIC = "没有眼睛的鹿OXO",		-- 物品名:"无眼鹿"->默认
			ANTLER = "多么引人注目的一个鹿角啊！",		-- 物品名:"无眼鹿"
		},
        DEER_ANTLER = "不是在下干的",		-- 物品名:"鹿角"
        DEER_GEMMED = "它是那只怪物的伙伴吗？",		-- 物品名:"无眼鹿"
		DEERCLOPS = "它体型真大！！",		-- 物品名:"独眼巨鹿"
		DEERCLOPS_EYEBALL = "他在看着在下。",		-- 物品名:"独眼巨鹿眼球"
		EYEBRELLAHAT =	"它会守护在下。",		-- 物品名:"眼球伞" 制造描述:"面向天空的眼球让你保持干燥。"
		DEPLETED_GRASS =
		{
			GENERIC = "大自然。",		-- 物品名:"草"->默认
		},
        GOGGLESHAT = "保护在下的双眼。",		-- 物品名:"时髦的护目镜" 制造描述:"你可以瞪大眼睛看装饰性护目镜。"
        DESERTHAT = "保护在下的双眼。",		-- 物品名:"沙漠护目镜" 制造描述:"从你的眼睛里把沙子揉出来。"
        ANTLIONHAT = "在下将改变这片大地。",		-- 物品名:"刮地皮头盔" 制造描述:"旧地不去，新地不来。"
		DEVTOOL = "奇怪的工具！",		-- 物品名:"开发工具"
		DEVTOOL_NODEV = "大自然。",		-- 物品名:"草"
		DIRTPILE = "在下可以翻找它",		-- 物品名:"可疑的土堆"
		DIVININGROD =
		{
			COLD = "信号很弱。", --singleplayer		-- 物品名:"冻伤"->冷了
			GENERIC = "它是某种自动引导装置。", --singleplayer		-- 物品名:"探测杖"->默认 制造描述:"肯定有方法可以离开这里..."
			HOT = "这东西发疯了！", --singleplayer		-- 物品名:"中暑"->热了
			WARM = "在下在正确的方向上。", --singleplayer		-- 物品名:"探测杖"->温暖 制造描述:"肯定有方法可以离开这里..."
			WARMER = "肯定很接近了。", --singleplayer		-- 物品名:"探测杖" 制造描述:"肯定有方法可以离开这里..."
		},
		DIVININGRODBASE =
		{
			GENERIC = "在下想知道它有什么用。", --singleplayer		-- 物品名:"探测杖底座"->默认
			READY = "看起来它需要一把大钥匙。", --singleplayer		-- 物品名:"探测杖底座"->准备好的 满的
			UNLOCKED = "现在机器可以工作了！", --singleplayer		-- 物品名:"探测杖底座"->解锁了
		},
		DIVININGRODSTART = "那根杖子看起来很有用！", --singleplayer		-- 物品名:"探测杖底座"->单机探测杖底座
		DRAGONFLY = "那是一只龙蝇！",		-- 物品名:"龙蝇"
		ARMORDRAGONFLY = "热呼呼的盔甲！",		-- 物品名:"鳞甲" 制造描述:"脾气火爆的盔甲。"
		DRAGON_SCALES = "还是热的。",		-- 物品名:"鳞片"
		DRAGONFLYCHEST = "在下会把未来藏在这里！",		-- 物品名:"龙鳞宝箱" 制造描述:"一种结实且防火的容器。"
		DRAGONFLYFURNACE =
		{
			HAMMERED = "看起来不太对啊。",		-- 物品名:"龙鳞火炉"->被锤了 制造描述:"给自己建造一个苍蝇暖炉。"
			GENERIC = "很温暖，但亮光却不多。", --no gems		-- 物品名:"龙鳞火炉"->默认 制造描述:"给自己建造一个苍蝇暖炉。"
			NORMAL = "它是在朝在下眨眼吗？", --one gem		-- 物品名:"龙鳞火炉"->普通 制造描述:"给自己建造一个苍蝇暖炉。"
			HIGH = "滚烫！", --two gems		-- 物品名:"龙鳞火炉"->高 制造描述:"给自己建造一个苍蝇暖炉。"
		},
        HUTCH = "在下的伙伴",		-- 物品名:"哈奇"
        HUTCH_FISHBOWL =
        {
            GENERIC = "伙伴的伙伴。",		-- 物品名:"星空"->默认
            WAITING = "在下的伙伴……",		-- 物品名:"星空"->需要等待
        },
		LAVASPIT =
		{
			HOT = "它是活着的！",		-- 物品名:"中暑"->热了
			COOL = "随地吐痰可不文明。",		-- 物品名:"龙蝇唾液"
		},
		LAVA_POND = "壮观！",		-- 物品名:"岩浆池"
		LAVAE = "太烫了，没办法处理。",		-- 物品名:"岩浆虫"
		LAVAE_COCOON = "冷却下来，平静下来。",		-- 物品名:"冷冻虫卵"
		LAVAE_PET =
		{
			STARVING = "乖孩子一定很饿。",		-- 物品名:"超级可爱岩浆虫"->挨饿
			HUNGRY = "在下听到它的小肚子在咕咕叫。",		-- 物品名:"超级可爱岩浆虫"->有点饿了
			CONTENT = "孩子似乎很快乐。",		-- 物品名:"超级可爱岩浆虫"->内容？？？、
			GENERIC = "谁是乖宝宝？",		-- 物品名:"超级可爱岩浆虫"->默认
		},
		LAVAE_EGG =
		{
			GENERIC = "孕育着一个小生命。",		-- 物品名:"岩浆虫卵"->默认
		},
		LAVAE_EGG_CRACKED =
		{
			COLD = "在下觉得蛋不够热。",		-- 物品名:"冻伤"->冷了
			COMFY = "孕育着一个开心的小生命。",		-- 物品名:"岩浆虫卵"->舒服的
		},
		LAVAE_TOOTH = "一颗蛋牙！",		-- 物品名:"岩浆虫尖牙"
		DRAGONFRUIT = "好奇怪的水果。",		-- 物品名:"火龙果"
		DRAGONFRUIT_COOKED = "这水果还是很怪。",		-- 物品名:"熟火龙果"
		DRAGONFRUIT_SEEDS = "这是一颗种子。",		-- 物品名:"球茎状种子"
		DRAGONPIE = "优秀的料理。",		-- 物品名:"火龙果派"
		DRUMSTICK = "小碎骨很多。",		-- 物品名:"鸟腿"
		DRUMSTICK_COOKED = "要细嚼慢咽哦。",		-- 物品名:"炸鸟腿"
		DUG_BERRYBUSH = "带走大自然。",		-- 物品名:"浆果丛"
		DUG_BERRYBUSH_JUICY = "这树可移植到家附近。",		-- 物品名:"多汁浆果丛"
		DUG_GRASS = "大自然。",		-- 物品名:"草丛"
		DUG_MARSH_BUSH = "这需要种植。",		-- 物品名:"尖刺灌木"
		DUG_SAPLING = "这需要种植。",		-- 物品名:"树苗"
		DURIAN = "难以亲近的料理！",		-- 物品名:"榴莲"
		DURIAN_COOKED = "丢掉它！",		-- 物品名:"超臭榴莲"
		DURIAN_SEEDS = "这是一颗种子。",		-- 物品名:"脆籽荚"
		EARMUFFSHAT = "在下喜欢这个。",		-- 物品名:"兔耳罩" 制造描述:"毛茸茸的保暖物品。"
		EGGPLANT = "适合蒸和炒。",		-- 物品名:"茄子"
		EGGPLANT_COOKED = "需要放油。",		-- 物品名:"烤茄子"
		EGGPLANT_SEEDS = "这是一颗种子。",		-- 物品名:"漩涡种子"
		ENDTABLE =
		{
			BURNT = "一个放在烧焦的桌子上的烧焦的花瓶。",		-- 物品名:"茶几"->烧焦的 制造描述:"一张装饰桌。"
			GENERIC = "桌上花瓶里的一朵花。",		-- 物品名:"茶几"->默认 制造描述:"一张装饰桌。"
			EMPTY = "在下应该把一些东西放进那里。",		-- 物品名:"茶几" 制造描述:"一张装饰桌。"
			WILTED = "看起来不太新鲜。",		-- 物品名:"茶几"->枯萎的 制造描述:"一张装饰桌。"
			FRESHLIGHT = "有一点亮光真是好。",		-- 物品名:"茶几"->茶几-新的发光的 制造描述:"一张装饰桌。"
			OLDLIGHT = "有点家的感觉了", -- will be wilted soon, light radius will be very small at this point		-- 物品名:"茶几"->茶几-旧的发光的 制造描述:"一张装饰桌。"
		},
		DECIDUOUSTREE =
		{
			BURNING = "哭泣的大自然。",		-- 物品名:"桦栗树"->正在燃烧
			BURNT = "在下觉得在下本可以阻止这种事情发生的。",		-- 物品名:"桦栗树"->烧焦的
			CHOPPED = "它看起来很痛苦",		-- 物品名:"桦栗树"->被砍了
			POISON = "看来偷桦栗果惹火了它！",		-- 物品名:"桦栗树"->毒化的
			GENERIC = "千变万化的大自然。",		-- 物品名:"桦栗树"->默认
		},
		ACORN = "里边绝对有东西。",		-- 物品名:"桦栗果"
        ACORN_SAPLING = "它很快将长成一棵树！",		-- 物品名:"桦栗树树苗"
		ACORN_COOKED = "烤得很完美。",		-- 物品名:"烤桦栗果"
		BIRCHNUTDRAKE = "疯狂的小坚果。",		-- 物品名:"桦栗果精"
		EVERGREEN =
		{
			BURNING = "哭泣的大自然。",		-- 物品名:"常青树"->正在燃烧
			BURNT = "哭泣的大自然。",		-- 物品名:"常青树"->烧焦的
			CHOPPED = "它看起来很痛苦",		-- 物品名:"常青树"->被砍了
			GENERIC = "需要砍伐吗？",		-- 物品名:"常青树"->默认
		},
		EVERGREEN_SPARSE =
		{
			BURNING = "哭泣的大自然。",		-- 物品名:"臃肿常青树"->正在燃烧
			BURNT = "在下觉得在下本可以阻止这种事情发生的。",		-- 物品名:"臃肿常青树"->烧焦的
			CHOPPED = "它看起来很痛苦",		-- 物品名:"臃肿常青树"->被砍了
			GENERIC = "树的繁育方法有很多种。",		-- 物品名:"臃肿常青树"->默认
		},
		TWIGGYTREE =
		{
			BURNING = "哭泣的大自然。",		-- 物品名:"多枝树"->正在燃烧
			BURNT = "在下觉得在下本可以阻止这种事情发生的。",		-- 物品名:"多枝树"->烧焦的
			CHOPPED = "它看起来很痛苦",		-- 物品名:"多枝树"->被砍了
			GENERIC = "满是树枝。",		-- 物品名:"多枝树"->默认
			DISEASED = "它看起来很糟糕。比平常还严重。", --unimplemented		-- 物品名:"多枝树"->生病了
		},
		TWIGGY_NUT_SAPLING = "它生长不需要任何助力。",		-- 物品名:"多枝树苗"
        TWIGGY_OLD = "那棵树看起来很弱。",		-- 物品名:"多枝树"
		TWIGGY_NUT = "它里面有一棵想要出去的多枝树。",		-- 物品名:"多枝树种"->多枝树果
		EYEPLANT = "有人在看着在下。",		-- 物品名:"眼球草"
		INSPECTSELF = "在下没缺胳膊少腿吧？",		-- 物品名:"多枝树"->检查自己
		FARMPLOT =
		{
			GENERIC = "在下应该试着种一些庄稼。",		-- 物品名:未找到
			GROWING = "长啊，植物，长啊！",		-- 物品名:未找到
			NEEDSFERTILIZER = "应该需要施肥。",		-- 物品名:未找到
			BURNT = "灰烬中长不出庄稼。",		-- 物品名:未找到
		},
		FEATHERHAT = "变成鸟！",		-- 物品名:"羽毛帽" 制造描述:"头上的装饰。"
		FEATHER_CROW = "黑鸟的羽毛。",		-- 物品名:"黑色羽毛"
		FEATHER_ROBIN = "红雀的羽毛。",		-- 物品名:"红色羽毛"
		FEATHER_ROBIN_WINTER = "雪雀的羽毛。",		-- 物品名:"蓝色羽毛"
		FEATHER_CANARY = "金丝雀的羽毛。",		-- 物品名:"黄色羽毛"
		FEATHERPENCIL = "文化的创造者。",		-- 物品名:"羽毛笔" 制造描述:"是的，羽毛是必须的。"
        COOKBOOK = "在下的毕生所学。",		-- 物品名:"烹饪指南" 制造描述:"查看你收集的食谱。"
		FEM_PUPPET = "她被困住了！", --single player		-- 物品名:未找到
		FIREFLIES =
		{
			GENERIC = "可爱的精灵们！",		-- 物品名:"萤火虫"->默认
			HELD = "精灵们在发光！",		-- 物品名:"萤火虫"->拿在手里
		},
		FIREHOUND = "那东西在发红光。",		-- 物品名:"红色猎犬"
		FIREPIT =
		{
			EMBERS = "在火熄灭之前在下得加点燃料。",		-- 物品名:"火坑"->即将熄灭 制造描述:"一种更安全、更高效的营火。"
			GENERIC = "肯定能驱走黑暗。",		-- 物品名:"火坑"->默认 制造描述:"一种更安全、更高效的营火。"
			HIGH = "好在火被围起来了！",		-- 物品名:"火坑"->高 制造描述:"一种更安全、更高效的营火。"
			LOW = "火变得有点小了。",		-- 物品名:"火坑"->低？ 制造描述:"一种更安全、更高效的营火。"
			NORMAL = "真舒服。",		-- 物品名:"火坑"->普通 制造描述:"一种更安全、更高效的营火。"
			OUT = "至少在下能让它再烧起来。",		-- 物品名:"火坑"->出去？外面？ 制造描述:"一种更安全、更高效的营火。"
		},
		COLDFIREPIT =
		{
			EMBERS = "在火熄灭之前在下得加点燃料。",		-- 物品名:"吸热火坑"->即将熄灭 制造描述:"燃烧效率更高，但仍然越烤越冷。"
			GENERIC = "肯定能驱走黑暗。",		-- 物品名:"吸热火坑"->默认 制造描述:"燃烧效率更高，但仍然越烤越冷。"
			HIGH = "好在火被围起来了！",		-- 物品名:"吸热火坑"->高 制造描述:"燃烧效率更高，但仍然越烤越冷。"
			LOW = "火变得有点小了。",		-- 物品名:"吸热火坑"->低？ 制造描述:"燃烧效率更高，但仍然越烤越冷。"
			NORMAL = "真舒服。",		-- 物品名:"吸热火坑"->普通 制造描述:"燃烧效率更高，但仍然越烤越冷。"
			OUT = "这似乎比魔法更有效。",		-- 物品名:"吸热火坑"->出去？外面？ 制造描述:"燃烧效率更高，但仍然越烤越冷。"
		},
		FIRESTAFF = "危险的魔杖。",		-- 物品名:"火魔杖" 制造描述:"利用火焰的力量！"
		FIRESUPPRESSOR =
		{
			ON = "帮帮在下！",		-- 物品名:"雪球发射器"->开启 制造描述:"拯救植物，扑灭火焰，可添加燃料。"
			OFF = "好好休息吧。",		-- 物品名:"雪球发射器"->关闭 制造描述:"拯救植物，扑灭火焰，可添加燃料。"
			LOWFUEL = "燃料有点不足了。",		-- 物品名:"雪球发射器"->燃料不足 制造描述:"拯救植物，扑灭火焰，可添加燃料。"
		},
		FISH = "营养丰富的食材。",		-- 物品名:"鱼"
		FISHINGROD = "钓鱼咯！",		-- 物品名:"淡水钓竿" 制造描述:"去钓鱼。为了鱼。"
		FISHSTICKS = "这可以填饱肚子。",		-- 物品名:"炸鱼排"
		FISHTACOS = "松脆而美味！",		-- 物品名:"鱼肉玉米卷"
		FISH_COOKED = "烤得恰到好处。",		-- 物品名:"熟鱼"
		FLINT = "可以用来制作工具哦。",		-- 物品名:"燧石"
		FLOWER =
		{
            GENERIC = "花朵艳丽，终会散落。",		-- 物品名:"花"->默认
            ROSE = "适合送给心爱的人。",		-- 物品名:"花"->玫瑰
        },
        FLOWER_WITHERED = "残花败柳。",		-- 物品名:"枯萎的花"
		FLOWERHAT = "闻起来就很美。",		-- 物品名:"花环" 制造描述:"放松神经的东西。"
		FLOWER_EVIL = "啊！竟如此邪恶！",		-- 物品名:"邪恶花"
		FOLIAGE = "一些多叶植物。",		-- 物品名:"蕨叶"
		FOOTBALLHAT = "在下没接触过这种运动。",		-- 物品名:"橄榄球头盔" 制造描述:"保护你的脑壳。"
        FOSSIL_PIECE = "它似乎可以被拼起来。",		-- 物品名:"化石碎片"
        FOSSIL_STALKER =
        {
			GENERIC = "还有些碎片没找到。",		-- 物品名:"奇异的骨架"->默认
			FUNNY = "在下需要另起炉灶。",		-- 物品名:"奇异的骨架"->趣味？？
			COMPLETE = "它还差一颗心脏。",		-- 物品名:"奇异的骨架"->准备好了
        },
        STALKER = "骨架和暗影融合在一起！",		-- 物品名:"复活的骨架"
        STALKER_ATRIUM = "为什么它必须这么大呢？",		-- 物品名:"远古织影者"
        STALKER_MINION = "会咬到脚踝！",		-- 物品名:"编织暗影"
        THURIBLE = "黑暗的精灵！",		-- 物品名:"暗影香炉"
        ATRIUM_OVERGROWTH = "带有魔法力量的建筑。",		-- 物品名:"远古方尖碑"
		FROG =
		{
			DEAD = "他不再有未来了。",		-- 物品名:"青蛙"->死了
			GENERIC = "讨厌的大自然",		-- 物品名:"青蛙"->默认
			SLEEPING = "捕捉的好机会",		-- 物品名:"青蛙"->睡着了
		},
		FROGGLEBUNWICH = "美腿三文治。",		-- 物品名:"蛙腿三明治"
		FROGLEGS = "在下曾听说它是一道美味。",		-- 物品名:"蛙腿"
		FROGLEGS_COOKED = "味道像鸡肉。",		-- 物品名:"熟蛙腿"
		FRUITMEDLEY = "果香扑鼻。",		-- 物品名:"水果圣代"
		FURTUFT = "黑白毛皮。",		-- 物品名:"毛丛"
		GEARS = "在下难以理解。",		-- 物品名:"齿轮"
		GHOST = "它是一道过去的影子。",		-- 物品名:"幽灵"
		GOLDENAXE = "挺花哨的一把斧头。",		-- 物品名:"黄金斧头" 制造描述:"砍树也要有格调！"
		GOLDENPICKAXE = "金子不是软的吗？",		-- 物品名:"黄金鹤嘴锄" 制造描述:"像大Boss一样砸碎岩石。"
		GOLDENPITCHFORK = "不能用来用餐",		-- 物品名:"黄金干草叉" 制造描述:"重新布置整个世界。"
		GOLDENSHOVEL = "在下等不及要挖洞了。",		-- 物品名:"黄金铲子" 制造描述:"挖掘作用相同，但使用寿命更长。"
		GOLDNUGGET = "它不能吃，但确实闪闪发光。",		-- 物品名:"金块"
		GRASS =
		{
			BARREN = "它需要施肥。",		-- 物品名:"草"
			WITHERED = "天气这么热，它不会长回来。",		-- 物品名:"草"->枯萎了
			BURNING = "烧得好快！",		-- 物品名:"草"->正在燃烧
			GENERIC = "是一丛草。",		-- 物品名:"草"->默认
			PICKED = "它在长得最好的时候被采走了。",		-- 物品名:"草"->被采完了
			DISEASED = "它看上去很不舒服。", --unimplemented		-- 物品名:"草"->生病了
			DISEASING = "呃...有些地方不对劲。", --unimplemented		-- 物品名:"草"->正在生病？？
		},
		GRASSGEKKO =
		{
			GENERIC = "大自然的奇迹！",		-- 物品名:"草壁虎"->默认
			DISEASED = "它看上去真的很不舒服。", --unimplemented		-- 物品名:"草壁虎"->生病了
		},
		GREEN_CAP = "它看起来很正常。",		-- 物品名:"采摘的绿蘑菇"
		GREEN_CAP_COOKED = "吃这个能提神.",		-- 物品名:"熟绿蘑菇"
		GREEN_MUSHROOM =
		{
			GENERIC = "蘑菇。",		-- 物品名:"绿蘑菇"->默认
			INGROUND = "睡觉的蘑菇。",		-- 物品名:"绿蘑菇"->在地里面
			PICKED = "它在等待雨水和风",		-- 物品名:"绿蘑菇"->被采完了
		},
		GUNPOWDER = "看起来像胡椒粉。",		-- 物品名:"火药" 制造描述:"一把火药。"
		HAMBAT = "不要玩食物！",		-- 物品名:"火腿棒" 制造描述:"舍不得火腿套不着狼。"
		HAMMER = "停下！是时候了！用锤子敲点东西吧！",		-- 物品名:"锤子" 制造描述:"敲碎各种东西。"
		HEALINGSALVE = "请交给在下吧。",		-- 物品名:"治疗药膏" 制造描述:"对割伤和擦伤进行消毒杀菌。"
		HEATROCK =
		{
			FROZEN = "它比冰还冷。",		-- 物品名:"暖石"->冰冻 制造描述:"储存热能供旅行途中使用。"
			COLD = "一块冰凉的石头。",		-- 物品名:"冻伤"->冷了
			GENERIC = "在下可以控制它的温度。",		-- 物品名:"暖石"->默认 制造描述:"储存热能供旅行途中使用。"
			WARM = "虽然是块石头，但却相当温暖，让人想抱在怀里！",		-- 物品名:"暖石"->温暖 制造描述:"储存热能供旅行途中使用。"
			HOT = "很热很舒服！",		-- 物品名:"中暑"->热了
		},
		HOME = "一定有人住在这里。",		-- 物品名:"暖石"->没调用 制造描述:"储存热能供旅行途中使用。"
		HOMESIGN =
		{
			GENERIC = "上面写着“你在这里”。",		-- 物品名:"木牌"->默认 制造描述:"在世界中留下你的标记。"
            UNWRITTEN = "这块牌子现在是空白的。",		-- 物品名:"木牌"->没有写字 制造描述:"在世界中留下你的标记。"
			BURNT = "“不要玩火柴。”",		-- 物品名:"木牌"->烧焦的 制造描述:"在世界中留下你的标记。"
		},
		ARROWSIGN_POST =
		{
			GENERIC = "在下通过风认清道路。",		-- 物品名:"指路木牌"->默认 制造描述:"对这个世界指指点点。或许只是打下手势。"
            UNWRITTEN = "这块牌子现在是空白的。",		-- 物品名:"指路木牌"->没有写字 制造描述:"对这个世界指指点点。或许只是打下手势。"
			BURNT = "“不要玩火柴。”",		-- 物品名:"指路木牌"->烧焦的 制造描述:"对这个世界指指点点。或许只是打下手势。"
		},
		ARROWSIGN_PANEL =
		{
			GENERIC = "它说“那个方向”。",		-- 物品名:"指路木牌"->默认
            UNWRITTEN = "这块牌子现在是空白的。",		-- 物品名:"指路木牌"->没有写字
			BURNT = "“不要玩火柴。”",		-- 物品名:"指路木牌"->烧焦的
		},
		HONEY = "看起来很好吃！",		-- 物品名:"蜂蜜"
		HONEYCOMB = "小精灵们的加。",		-- 物品名:"蜜脾"
		HONEYHAM = "香甜可口。",		-- 物品名:"蜜汁火腿"
		HONEYNUGGETS = "香香甜甜。",		-- 物品名:"蜜汁卤肉"
		HORN = "在下可以吹奏它。",		-- 物品名:"牛角"
		HOUND = "你啥都不是，你只是条狗！",		-- 物品名:"猎犬"
		HOUNDCORPSE =
		{
			GENERIC = "不听话的坏狗狗。",		-- 物品名:"猎犬"->默认
			BURNING = "烧着的狗狗。",		-- 物品名:"猎犬"->正在燃烧
			REVIVING = "不听话的坏狗狗！",		-- 物品名:"猎犬"
		},
		HOUNDBONE = "吓人。",		-- 物品名:"犬骨"
		HOUNDMOUND = "坏狗狗们的家。",		-- 物品名:"猎犬丘"
		ICEBOX = "在下掌控了寒冷的力量！",		-- 物品名:"冰箱" 制造描述:"延缓食物变质。"
		ICEHAT = "保持冷静，孩子。",		-- 物品名:"冰帽" 制造描述:"用科学技术合成的冰帽。"
		ICEHOUND = "每个季节都有猎犬吗？",		-- 物品名:"蓝色猎犬"
		INSANITYROCK =
		{
			ACTIVE = "在下不懂这种魔法。",		-- 物品名:"方尖碑"->激活了
			INACTIVE = "在下不懂这种魔法。",		-- 物品名:"方尖碑"->没有激活
		},
		JAMMYPRESERVES = "或许该做个罐子。",		-- 物品名:"果酱"
		KABOBS = "串在棍子上的午餐。",		-- 物品名:"肉串"
		KILLERBEE =
		{
			GENERIC = "小精灵生气了！",		-- 物品名:"杀人蜂"->默认
			HELD = "这东西好像很危险。",		-- 物品名:"杀人蜂"->拿在手里
		},
		KNIGHT = "看！",		-- 物品名:"发条骑士"
		KOALEFANT_SUMMER = "吃起来一定很美味。",		-- 物品名:"考拉象"
		KOALEFANT_WINTER = "它看起来又暖和肉又多。",		-- 物品名:"考拉象"
		KOALEFANT_CARCASS = "死了也很可爱。",		-- 物品名:"考拉象尸体"
		KRAMPUS = "不可以偷东西哦，坏孩子",		-- 物品名:"坎普斯"
		KRAMPUS_SACK = "在下非常喜欢这个！",		-- 物品名:"坎普斯背包"
		LEIF = "大自然啊，请你平息愤怒！",		-- 物品名:"树精守卫"
		LEIF_SPARSE = "请息怒，大自然！",		-- 物品名:"树精守卫"
		LIGHTER  = "她的幸运打火机。",		-- 物品名:"薇洛的打火机" 制造描述:"火焰在雨中彻夜燃烧。"
		LIGHTNING_ROD =
		{
			CHARGED = "雷电也拜倒在风的力量下",		-- 物品名:"避雷针" 制造描述:"防雷劈。"
			GENERIC = "雷电也拜倒在风的力量下",		-- 物品名:"避雷针"->默认 制造描述:"防雷劈。"
		},
		LIGHTNINGGOAT =
		{
			GENERIC = "小羊妖怪哦",		-- 物品名:"伏特羊"->默认
			CHARGED = "它会疼吗。",		-- 物品名:"伏特羊"
		},
		LIGHTNINGGOATHORN = "它像一根迷你避雷针。",		-- 物品名:"伏特羊角"
		GOATMILK = "美味，还滋滋作响！",		-- 物品名:"带电的羊奶"
		LITTLE_WALRUS = "等他长大了，就不会这么天真可爱了。",		-- 物品名:"小海象"
		LIVINGLOG = "富含大自然的生命力。",		-- 物品名:"活木头" 制造描述:"投身制作，置身其中。"
		LOG =
		{
			BURNING = "好烫的木头！",		-- 物品名:"木头"->正在燃烧
			GENERIC = "又大又重的木头。",		-- 物品名:"木头"->默认
		},
		LUCY = "它会说话！",		-- 物品名:"露西斧"
		LUREPLANT = "它如此迷人。",		-- 物品名:"食人花"
		LUREPLANTBULB = "可以种在船上。",		-- 物品名:"食人花种子"
		MALE_PUPPET = "他被困住了！", --single player		-- 物品名:"木头"
		MANDRAKE_ACTIVE = "魔法材料",		-- 物品名:"曼德拉草"
		MANDRAKE_PLANTED = "魔法材料。",		-- 物品名:"曼德拉草"
		MANDRAKE = "魔法材料。",		-- 物品名:"曼德拉草"
        MANDRAKESOUP = "死掉的魔法材料。",		-- 物品名:"曼德拉草汤"
        MANDRAKE_COOKED = "它看起来没有那么奇怪了。",		-- 物品名:"木头"
        MAPSCROLL = "未来等待我们去开拓。",		-- 物品名:"地图卷轴" 制造描述:"向别人展示你看到什么！"
        MARBLE = "很重的石头！",		-- 物品名:"大理石"
        MARBLEBEAN = "这也算是生命吗。",		-- 物品名:"大理石豌豆" 制造描述:"种植一片大理石森林。"
        MARBLEBEAN_SAPLING = "生长的石头？",		-- 物品名:"大理石芽"
        MARBLESHRUB = "这个世界有很多或者的石头",		-- 物品名:"大理石灌木"
        MARBLEPILLAR = "或许能用得上它。",		-- 物品名:"大理石柱"
        MARBLETREE = "虽然是树，但是需要镐子。",		-- 物品名:"大理石树"
        MARSH_BUSH =
        {
			BURNT = "大自然在保护自己。",		-- 物品名:"尖刺灌木"->烧焦的
            BURNING = "烧得好快！",		-- 物品名:"尖刺灌木"->正在燃烧
            GENERIC = "它看起来很多刺。",		-- 物品名:"尖刺灌木"->默认
            PICKED = "哎哟！",		-- 物品名:"尖刺灌木"->被采完了
        },
        BURNT_MARSH_BUSH = "被烧得精光。",		-- 物品名:"尖刺灌木"
        MARSH_PLANT = "大自然。",		-- 物品名:"植物"
        MARSH_TREE =
        {
            BURNING = "尖刺！火！",		-- 物品名:"针刺树"->正在燃烧
            BURNT = "现在它是一棵被烧焦了的针刺树。",		-- 物品名:"针刺树"->烧焦的
            CHOPPED = "现在没那么多刺了！",		-- 物品名:"针刺树"->被砍了
            GENERIC = "那些尖刺看起来很锋利！",		-- 物品名:"针刺树"->默认
        },
        MAXWELL = "魔术师。",--single player		-- 物品名:"麦斯威尔"->单机 麦斯威尔
        MAXWELLHEAD = "在下可以看到他毛孔里面的东西。",--removed		-- 物品名:"麦斯威尔的头"->单机 麦斯威尔的头
        MAXWELLLIGHT = "在下想知道它们是怎么工作的。",--single player		-- 物品名:"麦斯威尔灯"->单机 麦斯威尔的灯
        MAXWELLLOCK = "看起来就像一个钥匙孔。",--single player		-- 物品名:"梦魇锁"->单机 麦斯威尔的噩梦锁
        MAXWELLTHRONE = "那个看起来不太舒适。",--single player		-- 物品名:"梦魇王座"->单机 麦斯威尔的噩梦王座
        MEAT = "它在等待在下的料理。",		-- 物品名:"肉"
        MEATBALLS = "简单、充饥而又美味。",		-- 物品名:"肉丸"
        MEATRACK =
        {
            DONE = "它是风制作的料理",		-- 物品名:"晾肉架"->完成了 制造描述:"晾肉的架子。"
            DRYING = "风正在料理它。",		-- 物品名:"晾肉架"->正在风干 制造描述:"晾肉的架子。"
            DRYINGINRAIN = "雨天晾干肉需要更长时间。",		-- 物品名:"晾肉架"->雨天风干 制造描述:"晾肉的架子。"
            GENERIC = "风会料理上面的食材。",		-- 物品名:"晾肉架"->默认 制造描述:"晾肉的架子。"
            BURNT = "风不喜欢这件厨具。",		-- 物品名:"晾肉架"->烧焦的 制造描述:"晾肉的架子。"
            DONE_NOTMEAT = "风的厨具。",		-- 物品名:"晾肉架" 制造描述:"晾肉的架子。"
            DRYING_NOTMEAT = "风的厨具。",		-- 物品名:"晾肉架" 制造描述:"晾肉的架子。"
            DRYINGINRAIN_NOTMEAT = "雨啊，改天来吧。",		-- 物品名:"晾肉架" 制造描述:"晾肉的架子。"
        },
        MEAT_DRIED = "它是风制作的料理。",		-- 物品名:"肉干"
        MERM = "你好，小可爱！",		-- 物品名:"鱼人"
        MERMHEAD =
        {
            GENERIC = "臭臭的。",		-- 物品名:"鱼人头"->默认
            BURNT = "更臭了。",		-- 物品名:"鱼人头"->烧焦的
        },
        MERMHOUSE =
        {
            GENERIC = "这是什么生物的居所？",		-- 物品名:"漏雨的小屋"->默认
            BURNT = "现在没地住了。",		-- 物品名:"漏雨的小屋"->烧焦的
        },
        MINERHAT = "头顶的小精灵。",		-- 物品名:"矿工帽" 制造描述:"用你脑袋上的灯照亮夜晚。"
        MONKEY = "好奇的小家伙。",		-- 物品名:"穴居猴"
        MONKEYBARREL = "那东西刚刚是不是动了？",		-- 物品名:"穴居猴桶"
        MONSTERLASAGNA = "非常糟糕的料理，不能吃哦。",		-- 物品名:"怪物千层饼"
        FLOWERSALAD = "健康的料理。",		-- 物品名:"花沙拉"
        ICECREAM = "在下太想吃冰淇淋了！",		-- 物品名:"冰淇淋"
        WATERMELONICLE = "冷冻西瓜。",		-- 物品名:"西瓜冰棍"
        TRAILMIX = "健康、天然的小点心。",		-- 物品名:"什锦干果"
        HOTCHILI = "辣到喷火！",		-- 物品名:"辣椒炖肉"
        GUACAMOLE = "很健康的料理。",		-- 物品名:"鳄梨酱"
        MONSTERMEAT = "它只是需要一点加工。",		-- 物品名:"怪物肉"
        MONSTERMEAT_DRIED = "它是风制作的料理。",		-- 物品名:"怪物肉干"
        MOOSE = "在下不清楚那东西是什么。",		-- 物品名:"漏雨的小屋"
        MOOSE_NESTING_GROUND = "在下不清楚那东西是什么。",		-- 物品名:"漏雨的小屋"
        MOOSEEGG = "在下不清楚那东西是什么。",		-- 物品名:"漏雨的小屋"
        MOSSLING = "妈妈的小可爱",		-- 物品名:"麋鹿鹅幼崽"
        FEATHERFAN = "热了的话请及时告诉在下。",		-- 物品名:"羽毛扇" 制造描述:"超柔软、超大的扇子。"
        MINIFAN = "风啊！风啊！",		-- 物品名:"旋转的风扇" 制造描述:"你得跑起来，才能带来风！"
        GOOSE_FEATHER = "毛茸茸的！",		-- 物品名:"麋鹿鹅羽毛"
        STAFF_TORNADO = "狂风的精灵啊！撕碎我的敌人！",		-- 物品名:"天气风向标" 制造描述:"把你的敌人吹走。"
        MOSQUITO =
        {
            GENERIC = "讨厌的小吸血鬼。",		-- 物品名:"蚊子"->默认
            HELD = "嘿，那是在下的血吗？",		-- 物品名:"蚊子"->拿在手里
        },
        MOSQUITOSACK = "这也许是别人的血...",		-- 物品名:"蚊子血囊"
        MOUND =
        {
            DUG = "在下不能被过去束缚。",		-- 物品名:"坟墓"->被挖了
            GENERIC = "那礼貌吗？",		-- 物品名:"坟墓"->默认
        },
        NIGHTLIGHT = "它发出阴森可怕的光。",		-- 物品名:"暗夜灯" 制造描述:"用你的噩梦点亮夜晚。"
        NIGHTMAREFUEL = "魔法的基石！",		-- 物品名:"噩梦燃料" 制造描述:"傻子和疯子使用的邪恶残渣。"
        NIGHTSWORD = "这个世界魔法力量的具象化。",		-- 物品名:"暗夜剑" 制造描述:"造成噩梦般的伤害。"
        NITRE = "在下分不清石头。",		-- 物品名:"硝石"
        ONEMANBAND = "请聆听在下的演奏。",		-- 物品名:"独奏乐器" 制造描述:"疯子音乐家也有粉丝。"
        OASISLAKE =
		{
			GENERIC = "风带来的奇迹绿洲",		-- 物品名:"湖泊"->默认
			EMPTY = "未来它会再次丰盈。",		-- 物品名:"湖泊"
		},
        PANDORASCHEST = "里面可能有很好的东西！也可能是可怕的东西。",		-- 物品名:"华丽箱子"
        PANFLUTE = "为动物们唱小夜曲。",		-- 物品名:"排箫" 制造描述:"抚慰凶猛野兽的音乐。"
        PAPYRUS = "文化的承载者。",		-- 物品名:"莎草纸" 制造描述:"用于书写。"
        WAXPAPER = "用来包装礼品。",		-- 物品名:"蜡纸" 制造描述:"用于打包东西。"
        PENGUIN = "肯定到繁殖季节了。",		-- 物品名:"企鸥"
        PERD = "坏孩子！",		-- 物品名:"火鸡"
        PEROGIES = "非常美味的料理。",		-- 物品名:"波兰水饺"
        PETALS = "随风飘落",		-- 物品名:"花瓣"
        PETALS_EVIL = "极少的魔法力量。",		-- 物品名:"深色花瓣"
        PHLEGM = "好恶心。",		-- 物品名:"脓鼻涕"
        PICKAXE = "在下会努力的",		-- 物品名:"鹤嘴锄" 制造描述:"凿碎岩石。"
        PIGGYBACK = "小猪在帮助在下。",		-- 物品名:"猪皮包" 制造描述:"能装许多东西，但会减慢你的速度。"
        PIGHEAD =
        {
            GENERIC = "魔法仪式的祭品？",		-- 物品名:"猪头"->默认
            BURNT = "本来可以成为一道料理",		-- 物品名:"猪头"->烧焦的
        },
        PIGHOUSE =
        {
            FULL = "有个鼻子贴着窗户。",		-- 物品名:"猪屋"->满了 制造描述:"可以住一只猪。"
            GENERIC = "可爱的房子。",		-- 物品名:"猪屋"->默认 制造描述:"可以住一只猪。"
            LIGHTSOUT = "喂！出来！",		-- 物品名:"猪屋"->关灯了 制造描述:"可以住一只猪。"
            BURNT = "烧焦的房子也很可爱",		-- 物品名:"猪屋"->烧焦的 制造描述:"可以住一只猪。"
        },
        PIGKING = "好臭OXO",		-- 物品名:"猪王"
        PIGMAN =
        {
            DEAD = "适合烤或红烧。",		-- 物品名:"猪人"->死了
            FOLLOWER = "在下的伙伴之一。",		-- 物品名:"猪人"->追随者
            GENERIC = "他们有点吓人。",		-- 物品名:"猪人"->默认
            GUARD = "看起来很严肃。",		-- 物品名:"猪人"->警戒
            WEREPIG = "小猪发疯了，因为孤独吗？",		-- 物品名:"猪人"->疯猪
        },
        PIGSKIN = "居然不能吃？",		-- 物品名:"猪皮"
        PIGTENT = "不错的食材。",		-- 物品名:"猪人"
        PIGTORCH = "看上去挺惬意。",		-- 物品名:"猪火炬"
        PINECONE = "蕴含着大自然的生命力",		-- 物品名:"松果"
        PINECONE_SAPLING = "它很快将长成一棵大树！",		-- 物品名:"常青树苗"
        LUMPY_SAPLING = "大自然的智慧",		-- 物品名:"臃肿树苗"
        PITCHFORK = "不是餐具",		-- 物品名:"干草叉" 制造描述:"铲地用具。"
        PLANTMEAT = "在下可以料理它。",		-- 物品名:"叶肉"
        PLANTMEAT_COOKED = "似乎不应该这样料理。",		-- 物品名:"熟叶肉"
        PLANT_NORMAL =
        {
            GENERIC = "枝繁叶茂！",		-- 物品名:"农作物"->默认
            GROWING = "要加油哦",		-- 物品名:"农作物"->正在生长
            READY = "嗯。可以采摘了。",		-- 物品名:"农作物"->准备好的 满的
            WITHERED = "它是热死的。",		-- 物品名:"农作物"->枯萎了
        },
        POMEGRANATE = "可口的水果，只是籽太多。",		-- 物品名:"石榴"
        POMEGRANATE_COOKED = "高级料理！",		-- 物品名:"切片熟石榴"
        POMEGRANATE_SEEDS = "一个生命。",		-- 物品名:"风刮来的种子"
        POND = "多少精灵藏在里面？",		-- 物品名:"池塘"
        POOP = "用来施肥",		-- 物品名:"粪肥"
        FERTILIZER = "一桶废料。",		-- 物品名:"便便桶" 制造描述:"少拉点在手上，多拉点在庄稼上。"
        PUMPKIN = "用来做什么料理好呢",		-- 物品名:"南瓜"
        PUMPKINCOOKIE = "漂亮的南瓜饼！",		-- 物品名:"南瓜饼干"
        PUMPKIN_COOKED = "它为什么没变成馅饼？",		-- 物品名:"烤南瓜"
        PUMPKIN_LANTERN = "真可怕！",		-- 物品名:"南瓜灯" 制造描述:"长着鬼脸的照明用具。"
        PUMPKIN_SEEDS = "这是一颗种子。",		-- 物品名:"尖种子"
        PURPLEAMULET = "它在向在下低语。",		-- 物品名:"梦魇护符" 制造描述:"引起精神错乱。"
        PURPLEGEM = "里面有着奇怪的魔法能量。",		-- 物品名:"紫宝石" 制造描述:"结合你们的颜色！"
        RABBIT =
        {
            GENERIC = "你好！小精灵！",		-- 物品名:"兔子"->默认
            HELD = "孤独的兔子会死去，就像人一样",		-- 物品名:"兔子"->拿在手里
        },
        RABBITHOLE =
        {
            GENERIC = "那一定通向兔子王国。",		-- 物品名:"兔洞"->默认
            SPRING = "兔子王国本季封闭。",		-- 物品名:"兔洞"->春天 or 潮湿
        },
        RAINOMETER =
        {
            GENERIC = "它能测出是否有雨。",		-- 物品名:"雨量计"->默认 制造描述:"观测降雨机率。"
            BURNT = "还是让风告诉在下吧。",		-- 物品名:"雨量计"->烧焦的 制造描述:"观测降雨机率。"
        },
        RAINCOAT = "可以防水的雨具。",		-- 物品名:"雨衣" 制造描述:"让你保持干燥的防水外套。"
        RAINHAT = "它和鼹鼠有什么关系？",		-- 物品名:"雨帽" 制造描述:"手感柔软，防雨必备。"
        RATATOUILLE = "要多吃蔬菜哦。",		-- 物品名:"蔬菜杂烩"
        RAZOR = "在下应该用不上这个",		-- 物品名:"剃刀" 制造描述:"剃掉你脏脏的山羊胡子。"
        REDGEM = "它闪着温暖的光。",		-- 物品名:"红宝石"
        RED_CAP = "闻起来怪怪的。",		-- 物品名:"采摘的红蘑菇"
        RED_CAP_COOKED = "现在跟生蘑菇不同了...",		-- 物品名:"熟红蘑菇"
        RED_MUSHROOM =
        {
            GENERIC = "是蘑菇。",		-- 物品名:"红蘑菇"->默认
            INGROUND = "它在睡觉。",		-- 物品名:"红蘑菇"->在地里面
            PICKED = "它在等待雨水和风",		-- 物品名:"红蘑菇"->被采完了
        },
        REEDS =
        {
            BURNING = "烧的真旺！",		-- 物品名:"芦苇"->正在燃烧
            GENERIC = "一簇芦苇。",		-- 物品名:"芦苇"->默认
            PICKED = "所有有用的芦苇都已采摘下来。",		-- 物品名:"芦苇"->被采完了
        },
        RELIC = "远古家居用品。",		-- 物品名:"遗物"
        RUINS_RUBBLE = "这个可以修复。",		-- 物品名:"损毁的废墟"
        RUBBLE = "只是些碎石块。",		-- 物品名:"碎石"
        RESEARCHLAB =
        {
            GENERIC = "它教会了在下很多。",		-- 物品名:"科学机器"->默认 制造描述:"解锁新的合成配方！"
            BURNT = "在下不会忘记这位老师。",		-- 物品名:"科学机器"->烧焦的 制造描述:"解锁新的合成配方！"
        },
        RESEARCHLAB2 =
        {
            GENERIC = "它教会了在下更多。",		-- 物品名:"炼金引擎"->默认 制造描述:"解锁更多合成配方！"
            BURNT = "在下不会忘记这位老师。",		-- 物品名:"炼金引擎"->烧焦的 制造描述:"解锁更多合成配方！"
        },
        RESEARCHLAB3 =
        {
            GENERIC = "在下学会了这个世界的魔法",		-- 物品名:"暗影操控器"->默认 制造描述:"这还是科学吗？"
            BURNT = "看来这个世界的魔法并不防火",		-- 物品名:"暗影操控器"->烧焦的 制造描述:"这还是科学吗？"
        },
        RESEARCHLAB4 =
        {
            GENERIC = "在下了解了这个世界的魔法",		-- 物品名:"灵子分解器"->默认 制造描述:"增强高礼帽的魔力。"
            BURNT = "看来这个世界的魔法并不防火",		-- 物品名:"灵子分解器"->烧焦的 制造描述:"增强高礼帽的魔力。"
        },
        RESURRECTIONSTATUE =
        {
            GENERIC = "这是禁忌的魔法",		-- 物品名:"肉块雕像"->默认 制造描述:"以肉的力量让你重生。"
            BURNT = "再也没用了。",		-- 物品名:"肉块雕像"->烧焦的 制造描述:"以肉的力量让你重生。"
        },
        RESURRECTIONSTONE = "这到底是何种魔法？",		-- 物品名:"试金石"
        ROBIN =
        {
            GENERIC = "它与春风一同到来",		-- 物品名:"红雀"->默认
            HELD = "乖哦，别害怕。",		-- 物品名:"红雀"->拿在手里
        },
        ROBIN_WINTER =
        {
            GENERIC = "寒荒之地的生命。",		-- 物品名:"雪雀"->默认
            HELD = "它如此柔软。",		-- 物品名:"雪雀"->拿在手里
        },
        ROBOT_PUPPET = "被困住了！", --single player		-- 物品名:"雪雀"
        ROCK_LIGHT =
        {
            GENERIC = "裹了石皮的熔岩坑。",--removed		-- 物品名:"熔岩坑"->默认
            OUT = "看起来很易碎。",--removed		-- 物品名:"熔岩坑"->出去？外面？
            LOW = "那块熔岩正在裹上石皮。",--removed		-- 物品名:"熔岩坑"->低？
            NORMAL = "真舒服。",--removed		-- 物品名:"熔岩坑"->普通
        },
        CAVEIN_BOULDER =
        {
            GENERIC = "等待在下的开采。",		-- 物品名:"岩石"->默认
            RAISED = "太远了够不着。",		-- 物品名:"岩石"->提高了？
        },
        ROCK = "等待在下的开采。",		-- 物品名:"岩石"
        PETRIFIED_TREE = "等待在下的开采。",		-- 物品名:"岩石"
        ROCK_PETRIFIED_TREE = "它有生命吗？",		-- 物品名:"石化树"
        ROCK_PETRIFIED_TREE_OLD = "等待在下的开采。",		-- 物品名:"岩石"
        ROCK_ICE =
        {
            GENERIC = "冰块也可以制作料理。",		-- 物品名:"迷你冰川"->默认
            MELTED = "它在等待寒风。",		-- 物品名:"迷你冰川"->融化了
        },
        ROCK_ICE_MELTED = "它在等待寒风。",		-- 物品名:"融化的迷你冰川"
        ICE = "冰块也可以制作料理。",		-- 物品名:"冰"
        ROCKS = "在下分不清石头。",		-- 物品名:"石头"
        ROOK = "它是生命吗？",		-- 物品名:"发条战车"
        ROPE = "一种短绳。",		-- 物品名:"绳子" 制造描述:"紧密编成的草绳，非常有用。"
        ROTTENEGG = "不能吃！",		-- 物品名:"腐烂鸟蛋"
        ROYAL_JELLY = "珍稀食材！",		-- 物品名:"蜂王浆"
        JELLYBEAN = "一部分是果冻，一部分是豌豆。",		-- 物品名:"彩虹糖豆"
        SADDLE_BASIC = "有了它就可以骑牛牛了。",		-- 物品名:"鞍具" 制造描述:"你坐在动物身上。仅仅是理论上。"
        SADDLE_RACE = "这鞍具真的在飞！",		-- 物品名:"闪亮鞍具" 制造描述:"抵消掉完成目标所花费的时间。或许。"
        SADDLE_WAR = "冲锋，牛牛！。",		-- 物品名:"战争鞍具" 制造描述:"战场首领的王位。"
        SADDLEHORN = "这能够卸下鞍具。",		-- 物品名:"鞍角" 制造描述:"把鞍具撬开。"
        SALTLICK = "这能吃饱吗？",		-- 物品名:"舔盐块" 制造描述:"好好喂养你家的牲畜。"
        BRUSH = "牛牛肯定很喜欢这个。",		-- 物品名:"刷子" 制造描述:"减缓皮弗娄牛毛发的生长速度。"
		SANITYROCK =
		{
			ACTIVE = "这是什么魔法？",		-- 物品名:"方尖碑"->激活了
			INACTIVE = "它躲在地下",		-- 物品名:"方尖碑"->没有激活
		},
		SAPLING =
		{
			BURNING = "烧得好快！",		-- 物品名:"树苗"->正在燃烧
			WITHERED = "风啊，帮帮它吧。",		-- 物品名:"树苗"->枯萎了
			GENERIC = "小树苗真可爱！",		-- 物品名:"树苗"->默认
			PICKED = "它需要时间和风。",		-- 物品名:"树苗"->被采完了
			DISEASED = "它看上去很不舒服。", --removed		-- 物品名:"树苗"->生病了
			DISEASING = "呃...有些地方不对劲。", --removed		-- 物品名:"树苗"->正在生病？？
		},
   		SCARECROW =
   		{
			GENERIC = "它能引来金丝雀。",		-- 物品名:"友善的稻草人"->默认 制造描述:"模仿最新的秋季时尚。"
			BURNING = "真可怜……",		-- 物品名:"友善的稻草人"->正在燃烧 制造描述:"模仿最新的秋季时尚。"
			BURNT = "真可怜……",		-- 物品名:"友善的稻草人"->烧焦的 制造描述:"模仿最新的秋季时尚。"
   		},
   		SCULPTINGTABLE=
   		{
			EMPTY = "我们可以用这东西来做个石雕。",		-- 物品名:"陶轮" 制造描述:"大理石在你手里将像黏土一样！"
			BLOCK = "准备雕刻。",		-- 物品名:"陶轮"->锁住了 制造描述:"大理石在你手里将像黏土一样！"
			SCULPTURE = "一个杰作！",		-- 物品名:"陶轮"->雕像做好了 制造描述:"大理石在你手里将像黏土一样！"
			BURNT = "完全烧焦。",		-- 物品名:"陶轮"->烧焦的 制造描述:"大理石在你手里将像黏土一样！"
   		},
        SCULPTURE_KNIGHTHEAD = "其余部分在哪里？",		-- 物品名:"可疑的大理石"
		SCULPTURE_KNIGHTBODY =
		{
			COVERED = "是一个古怪的大理石雕像。",		-- 物品名:"大理石雕像"->被盖住了-三基佬雕像可以敲大理石的时候
			UNCOVERED = "似乎缺少一部分	",-- 物品名:"大理石雕像"->没有被盖住-三基佬雕像被开采后
			FINISHED = "终于又弄到一起了。",		-- 物品名:"大理石雕像"->三基佬雕像修好了
			READY = "里面有东西在动。",		-- 物品名:"大理石雕像"->准备好的 满的
		},
        SCULPTURE_BISHOPHEAD = "那是一颗头吗？",		-- 物品名:"可疑的大理石"
		SCULPTURE_BISHOPBODY =
		{
			COVERED = "看起来很老，但感觉挺新。",		-- 物品名:"大理石雕像"->被盖住了-三基佬雕像可以敲大理石的时候
			UNCOVERED = "有一个大的碎片没找到。",		-- 物品名:"大理石雕像"->没有被盖住-三基佬雕像被开采后
			FINISHED = "然后呢？",		-- 物品名:"大理石雕像"->三基佬雕像修好了
			READY = "里面有东西在动。",		-- 物品名:"大理石雕像"->准备好的 满的
		},
        SCULPTURE_ROOKNOSE = "这是哪儿来的？",		-- 物品名:"可疑的大理石"
		SCULPTURE_ROOKBODY =
		{
			COVERED = "一种大理石雕像。",		-- 物品名:"大理石雕像"->被盖住了-三基佬雕像可以敲大理石的时候
			UNCOVERED = "它不在最佳状态。",		-- 物品名:"大理石雕像"->没有被盖住-三基佬雕像被开采后
			FINISHED = "所有都修补好了。",		-- 物品名:"大理石雕像"->三基佬雕像修好了
			READY = "里面有东西在动。",		-- 物品名:"大理石雕像"->准备好的 满的
		},
        GARGOYLE_HOUND = "OXO",		-- 物品名:"可疑的月岩"
        GARGOYLE_WEREPIG = "它看起来栩栩如生。",		-- 物品名:"可疑的月岩"
		SEEDS = "每一颗都是一个小小的谜。",		-- 物品名:"种子"
		SEEDS_COOKED = "很想！",		-- 物品名:"烤种子"
		SEWING_KIT = "临行密密缝",		-- 物品名:"针线包" 制造描述:"缝补受损的衣物。"
		SEWING_TAPE = "修补得不错。",		-- 物品名:"可靠的胶布" 制造描述:"缝补受损的衣物。"
		SHOVEL = "地下隐藏着很多秘密。",		-- 物品名:"铲子" 制造描述:"挖掘各种各样的东西。"
		SILK = "出自蜘蛛的屁股。",		-- 物品名:"蜘蛛丝"
		SKELETON = "你死好过在下死。",		-- 物品名:"骷髅"
		SCORCHED_SKELETON = "真可怕。",		-- 物品名:"易碎骷髅"
		SKULLCHEST = "不确定要不要打开。", --removed		-- 物品名:"骷髅箱"
		SMALLBIRD =
		{
			GENERIC = "好小的一只鸟。",		-- 物品名:"小鸟"->默认
			HUNGRY = "它看起来饿了。",		-- 物品名:"小鸟"->有点饿了
			STARVING = "它一定很饿。",		-- 物品名:"小鸟"->挨饿
			SLEEPING = "嘘。",		-- 物品名:"小鸟"->睡着了
		},
		SMALLMEAT = "可以用来做配菜。",		-- 物品名:"小肉"
		SMALLMEAT_DRIED = "风的杰作。",		-- 物品名:"小风干肉"
		SPAT = "看起来脾气暴躁的动物。",		-- 物品名:"钢羊"
		SPEAR = "不如在下的法杖。",		-- 物品名:"长矛" 制造描述:"使用尖的那一端。"
		SPEAR_WATHGRITHR = "它看起来很能戳。",		-- 物品名:"战斗长矛" 制造描述:"黄金使它更锋利。"
		WATHGRITHRHAT = "奇特的帽子。",		-- 物品名:"战斗头盔" 制造描述:"独角兽是你的保护神。"
		SPIDER =
		{
			DEAD = "它走向了它的归宿",		-- 物品名:"蜘蛛"->死了
			GENERIC = "在下不喜欢蜘蛛。",		-- 物品名:"蜘蛛"->默认
			SLEEPING = "可以趁机抓住它。",		-- 物品名:"蜘蛛"->睡着了
		},
		SPIDERDEN = "好黏！",		-- 物品名:"蜘蛛巢"
		SPIDEREGGSACK = "很难想象它能被装进口袋里。",		-- 物品名:"蜘蛛卵" 制造描述:"跟你的朋友寻求点帮助。"
		SPIDERGLAND = "治疗的好材料。",		-- 物品名:"蜘蛛腺"
		SPIDERHAT = "在下不太想当蜘蛛的妈妈。",		-- 物品名:"蜘蛛帽" 制造描述:"蜘蛛们会喊你\"妈妈\"。"
		SPIDERQUEEN = "她是蜘蛛们的妈妈",		-- 物品名:"蜘蛛女王"
		SPIDER_WARRIOR =
		{
			DEAD = "胜利的风",		-- 物品名:"蜘蛛战士"->死了
			GENERIC = "恼人的坏孩子。",		-- 物品名:"蜘蛛战士"->默认
			SLEEPING = "趁虚而入。",		-- 物品名:"蜘蛛战士"->睡着了
		},
		SPOILED_FOOD = "不能吃哦。",		-- 物品名:"腐烂物"
        STAGEHAND =
        {
			AWAKE = "总是跟着在下是因为饿了吗？",		-- 物品名:"舞台之手"->醒了
			HIDING = "奇怪的孩子。",		-- 物品名:"舞台之手"->藏起来了
        },
        STATUE_MARBLE =
        {
            GENERIC = "高级的大理石雕像。",		-- 物品名:"大理石雕像"->默认
            TYPE1 = "不要失去理智！",		-- 物品名:"大理石雕像"->类型1
            TYPE2 = "雕像般的。",		-- 物品名:"大理石雕像"->类型2
            TYPE3 = "在下想知道是哪个艺术家的作品。", --bird bath type statue		-- 物品名:"大理石雕像"
        },
		STATUEHARP = "他的头怎么了？",		-- 物品名:"竖琴雕像"
		STATUEMAXWELL = "魔术师先生。",		-- 物品名:"麦斯威尔雕像"
		STEELWOOL = "粗糙的金属纤维。",		-- 物品名:"钢丝绵"
		STINGER = "看起来很尖锐！",		-- 物品名:"针刺"
		STRAWHAT = "那个……适合在下吗？",		-- 物品名:"草帽" 制造描述:"帮助你保持清凉干爽。"
		STUFFEDEGGPLANT = "多吃点哦",		-- 物品名:"酿茄子"
		SWEATERVEST = "多加一件衣服吧。",		-- 物品名:"犬牙背心" 制造描述:"粗糙，但挺时尚。"
		REFLECTIVEVEST = "夏天适合穿这个",		-- 物品名:"清凉夏装" 制造描述:"穿上这件时尚的背心，让你神清气爽。"
		HAWAIIANSHIRT = "夏天适合穿这个",		-- 物品名:"花衬衫" 制造描述:"适合夏日穿着，或在周五便装日穿着。"
		TAFFY = "好孩子克不能吃太多糖哦。",		-- 物品名:"太妃糖"
		TALLBIRD = "好高的一只鸟！",		-- 物品名:"高脚鸟"
		TALLBIRDEGG = "它会孵化吗？",		-- 物品名:"高脚鸟蛋"
		TALLBIRDEGG_COOKED = "美味又营养。",		-- 物品名:"煎高脚鸟蛋"
		TALLBIRDEGG_CRACKED =
		{
			COLD = "寒风刺骨",		-- 物品名:"冻伤"->冷了
			GENERIC = "看起来它正在孵化！",		-- 物品名:"孵化中的高脚鸟蛋"->默认
			HOT = "蛋也会出汗吗？",		-- 物品名:"中暑"->热了
			LONG = "等待未来",		-- 物品名:"孵化中的高脚鸟蛋"->还需要很久
			SHORT = "破茧而出。",		-- 物品名:"孵化中的高脚鸟蛋"->很快了
		},
		TALLBIRDNEST =
		{
			GENERIC = "那真是个不一般的蛋！",		-- 物品名:"高脚鸟巢"->默认
			PICKED = "巢是空的。",		-- 物品名:"高脚鸟巢"->被采完了
		},
		TEENBIRD =
		{
			GENERIC = "可爱的小精灵。",		-- 物品名:"小高脚鸟"->默认
			HUNGRY = "想要妈妈喂你吗？",		-- 物品名:"小高脚鸟"->有点饿了
			STARVING = "小宝贝饿极了。",		-- 物品名:"小高脚鸟"->挨饿
			SLEEPING = "嘘，小可爱睡着了。",		-- 物品名:"小高脚鸟"->睡着了
		},
		TELEPORTATO_BASE =
		{
			ACTIVE = "在下可以穿越时空！", --single player		-- 物品名:"木制装置"->激活了
			GENERIC = "这似乎通向另一个世界！", --single player		-- 物品名:"木制装置"->默认
			LOCKED = "还少了些什么东西。", --single player		-- 物品名:"木制装置"->锁住了
			PARTIAL = "惊人的发明。", --single player		-- 物品名:"木制装置"->已经有部分了
		},
		TELEPORTATO_BOX = "这居然不是魔法。", --single player		-- 物品名:"盒状装置"
		TELEPORTATO_CRANK = "很结实。", --single player		-- 物品名:"曲柄装置"
		TELEPORTATO_POTATO = "这个金属土豆包含强大而又可怕的力量...", --single player		-- 物品名:"金属土豆状装置"
		TELEPORTATO_RING = "一个可以聚集空间能量的圆环。", --single player		-- 物品名:"环状装置"
		TELESTAFF = "那会揭示这个世界。",		-- 物品名:"传送魔杖" 制造描述:"穿越空间的法杖！时间要另外收费。"
		TENT =
		{
			GENERIC = "晚安，伙伴们。",		-- 物品名:"帐篷"->默认 制造描述:"回复理智值，但要花费时间并导致饥饿。"
			BURNT = "连同梦境一起被燃尽了。",		-- 物品名:"帐篷"->烧焦的 制造描述:"回复理智值，但要花费时间并导致饥饿。"
		},
		SIESTAHUT =
		{
			GENERIC = "午安，伙伴们。",		-- 物品名:"遮阳篷"->默认 制造描述:"躲避烈日，回复理智值。"
			BURNT = "连同梦境一起被燃尽了。",		-- 物品名:"遮阳篷"->烧焦的 制造描述:"躲避烈日，回复理智值。"
		},
		TENTACLE = "那个看起来很危险。",		-- 物品名:"触手"
		TENTACLESPIKE = "它又尖又黏。",		-- 物品名:"触手尖刺"
		TENTACLESPOTS = "似乎是一种魔法素材。",		-- 物品名:"触手皮"
		TENTACLE_PILLAR = "黏滑的触手。",		-- 物品名:"大触手"
        TENTACLE_PILLAR_HOLE = "它似乎通向另一个地方。",		-- 物品名:"硕大的泥坑"
		TENTACLE_PILLAR_ARM = "滑溜溜的小触手。",		-- 物品名:"小触手"
		TENTACLE_GARDEN = "又一种黏滑的触手。",		-- 物品名:"大触手"
		TOPHAT = "多好的帽子。",		-- 物品名:"高礼帽" 制造描述:"最经典的帽子款式。"
		TORCH = "秉烛夜行。",		-- 物品名:"火炬" 制造描述:"可携带的光源。"
		TRANSISTOR = "在下不太擅长这个。",		-- 物品名:"电子元件" 制造描述:"科学至上！滋滋滋！"
		TRAP = "在下把它编得很紧密。",		-- 物品名:"陷阱" 制造描述:"捕捉小型生物。"
		TRAP_TEETH = "用来对付坏狗狗。",		-- 物品名:"犬牙陷阱" 制造描述:"弹出来并咬伤任何踩到它的东西。"
		TRAP_TEETH_MAXWELL = "在下可不想踩在那上面！", --single player		-- 物品名:"麦斯威尔的犬牙陷阱" 制造描述:"弹出来并咬伤任何踩到它的东西。"
		TREASURECHEST =
		{
			GENERIC = "一个工具箱！",		-- 物品名:"箱子"->默认 制造描述:"一种结实的容器。"
			BURNT = "那个箱子被烧掉了一截。",		-- 物品名:"箱子"->烧焦的 制造描述:"一种结实的容器。"
		},
		TREASURECHEST_TRAP = "要好好收纳哦",		-- 物品名:"宝箱"
		SACRED_CHEST =
		{
			GENERIC = "它似乎想要什么东西。",		-- 物品名:"远古宝箱"->默认
			LOCKED = "它正在做出判断。",		-- 物品名:"远古宝箱"->锁住了
		},
		TREECLUMP = "是不是有人想把在下困在这里。", --removed		-- 物品名:"远古宝箱"
		TRINKET_1 = "融化了。", --Melted Marbles		-- 物品名:"熔化的弹珠"
		TRINKET_2 = "赝品", --Fake Kazoo		-- 物品名:"假卡祖笛"
		TRINKET_3 = "那是个死结。永远打不开的结。", --Gord's Knot		-- 物品名:"戈尔迪之结"
		TRINKET_4 = "它一定是某种魔法物品。", --Gnome		-- 物品名:"地精爷爷"
		TRINKET_5 = "这就是科学吗？", --Toy Rocketship		-- 物品名:"迷你火箭"
		TRINKET_6 = "这就是科学吗？", --Frazzled Wires		-- 物品名:"烂电线"
		TRINKET_7 = "没有时间享乐和游戏！", --Ball and Cup		-- 物品名:"杯子和球"
		TRINKET_8 = "太好了。堵浴缸的塞子有了。", --Rubber Bung		-- 物品名:"硬化橡胶塞"
		TRINKET_9 = "有点可爱。", --Mismatched Buttons		-- 物品名:"不搭的纽扣"
		TRINKET_10 = "在下不需要。", --Dentures		-- 物品名:"二手假牙"
		TRINKET_11 = "这就是科学吗？", --Lying Robot		-- 物品名:"机器人玩偶"
		TRINKET_12 = "它不具有魔力", --Dessicated Tentacle		-- 物品名:"干瘪的触手"
		TRINKET_13 = "它一定是某种魔法物品。", --Gnomette		-- 物品名:"地精奶奶"
		TRINKET_14 = "现在要是能喝点茶，该多好...", --Leaky Teacup		-- 物品名:"漏水的茶杯"
		TRINKET_15 = "要和在下来一盘棋吗。", --Pawn		-- 物品名:"白色主教"
		TRINKET_16 = "要和在下来一盘棋吗。", --Pawn		-- 物品名:"黑色主教"
		TRINKET_17 = "可笑的魔法。", --Bent Spork		-- 物品名:"弯曲的叉子"
		TRINKET_18 = "在下想知道它在隐藏什么？", --Trojan Horse		-- 物品名:"玩具木马"
		TRINKET_19 = "结网不是很顺利。", --Unbalanced Top		-- 物品名:"失衡陀螺"
		TRINKET_20 = "在下不需要这个", --Backscratcher		-- 物品名:"痒痒挠"
		TRINKET_21 = "要小心使用厨具哦。", --Egg Beater		-- 物品名:"破搅拌器"
		TRINKET_22 = "可惜，已经不能用了。", --Frayed Yarn		-- 物品名:"磨损的纱线"
		TRINKET_23 = "在下不需要这个", --Shoehorn		-- 物品名:"鞋拔子"
		TRINKET_24 = "它很可爱。", --Lucky Cat Jar		-- 物品名:"幸运猫扎尔"
		TRINKET_25 = "闻起来有点不新鲜。", --Air Unfreshener		-- 物品名:"臭气制造器"
		TRINKET_26 = "食物和杯子。", --Potato Cup		-- 物品名:"土豆杯"
		TRINKET_27 = "在下不需要这个。", --Coat Hanger		-- 物品名:"钢丝衣架"
		TRINKET_28 = "要和在下来一盘棋吗。", --Rook		-- 物品名:"白色战车"
        TRINKET_29 = "要和在下来一盘棋吗。", --Rook		-- 物品名:"黑色战车"
        TRINKET_30 = "要和在下来一盘棋吗。", --Knight		-- 物品名:"白色骑士"
        TRINKET_31 = "要和在下来一盘棋吗。", --Knight		-- 物品名:"黑色骑士"
        TRINKET_32 = "在下不知道这是什么", --Cubic Zirconia Ball		-- 物品名:"立方氧化锆球"
        TRINKET_33 = "希望不会引来蜘蛛。", --Spider Ring		-- 物品名:"蜘蛛指环"
        TRINKET_34 = "邪恶至极的魔法。", --Monkey Paw		-- 物品名:"猴爪"
        TRINKET_35 = "与其说是魔法，不如说是传说。", --Empty Elixir		-- 物品名:"空的长生不老药"
        TRINKET_36 = "在下不需要这个。", --Faux fangs		-- 物品名:"人造尖牙"
        TRINKET_37 = "邪恶的魔法。", --Broken Stake		-- 物品名:"断桩"
        TRINKET_38 = "这个要怎么用？", -- Binoculars Griftlands trinket		-- 物品名:"双筒望远镜"
        TRINKET_39 = "在下想知道另一只在哪里？", -- Lone Glove Griftlands trinket		-- 物品名:"单只手套"
        TRINKET_40 = "OXO。", -- Snail Scale Griftlands trinket		-- 物品名:"蜗牛秤"
        TRINKET_41 = "OXO。", -- Goop Canister Hot Lava trinket		-- 物品名:"黏液罐"
        TRINKET_42 = " OXO。", -- Toy Cobra Hot Lava trinket		-- 物品名:"玩具眼镜蛇"
        TRINKET_43= " OXO。", -- Crocodile Toy Hot Lava trinket		-- 物品名:"鳄鱼玩具"
        TRINKET_44 = "这是调料罐吗？", -- Broken Terrarium ONI trinket		-- 物品名:"破碎的玻璃罐"
        TRINKET_45 = "这就是科学吗？", -- Odd Radio ONI trinket		-- 物品名:"奇怪的收音机"
        TRINKET_46 = "这就是科学吗？", -- Hairdryer ONI trinket		-- 物品名:"损坏的吹风机"
        LOST_TOY_1  = "这就是科学吗？",		-- 物品名:"遗失的玻璃球"
        LOST_TOY_2  = "这就是科学吗？",		-- 物品名:"多愁善感的卡祖笛"
        LOST_TOY_7  = "这就是科学吗？",		-- 物品名:"珍视的抽线陀螺"
        LOST_TOY_10 = "这就是科学吗？",		-- 物品名:"缺少的牙齿"
        LOST_TOY_11 = "这就是科学吗？",		-- 物品名:"珍贵的玩具机器人"
        LOST_TOY_14 = "这就是科学吗？",		-- 物品名:"妈妈最爱的茶杯"
        LOST_TOY_18 = "这就是科学吗？",		-- 物品名:"宝贵的玩具木马"
        LOST_TOY_19 = "这就是科学吗？",		-- 物品名:"最爱的陀螺"
        LOST_TOY_42 = "这就是科学吗？",		-- 物品名:"装错的玩具眼镜蛇"
        LOST_TOY_43 = "这就是科学吗？",		-- 物品名:"宠爱的鳄鱼玩具"
        HALLOWEENCANDY_1 = "好孩子不能吃太多糖哦",		-- 物品名:"糖果苹果"
        HALLOWEENCANDY_2 = "好孩子不能吃太多糖哦",		-- 物品名:"糖果玉米"
        HALLOWEENCANDY_3 = "好孩子不能吃太多糖哦",		-- 物品名:"不太甜的玉米"
        HALLOWEENCANDY_4 = "真是新奇的食物呢。",		-- 物品名:"粘液蜘蛛"
        HALLOWEENCANDY_5 = "好孩子不能吃太多糖哦。",		-- 物品名:"浣猫糖果"
        HALLOWEENCANDY_6 = "好孩子不能吃太多糖哦。",		-- 物品名:"\"葡萄干\""
        HALLOWEENCANDY_7 = "好孩子不能吃太多糖哦。",		-- 物品名:"葡萄干"
        HALLOWEENCANDY_8 = "好孩子不能吃太多糖哦。",		-- 物品名:"鬼魂棒棒糖"
        HALLOWEENCANDY_9 = "好孩子不能吃太多糖哦。。",		-- 物品名:"果冻虫"
        HALLOWEENCANDY_10 = "好孩子不能吃太多糖哦。",		-- 物品名:"触手棒棒糖"
        HALLOWEENCANDY_11 = "好孩子不能吃太多糖哦。",		-- 物品名:"巧克力猪"
        HALLOWEENCANDY_12 = "好孩子不能吃太多糖哦。", --ONI meal lice candy		-- 物品名:"糖果虱"
        HALLOWEENCANDY_13 = "好孩子不能吃太多糖哦。", --Griftlands themed candy		-- 物品名:"无敌硬糖"
        HALLOWEENCANDY_14 = "在下吃不了这么辣。", --Hot Lava pepper candy		-- 物品名:"熔岩椒"
        CANDYBAG = "好孩子不能吃太多糖哦。",		-- 物品名:"糖果袋" 制造描述:"只带万圣夜好吃的东西。"
		HALLOWEEN_ORNAMENT_1 = "可以挂在树上的装饰",		-- 物品名:"幽灵装饰"
		HALLOWEEN_ORNAMENT_2 = "可以挂在树上的装饰。",		-- 物品名:"蝙蝠装饰"
		HALLOWEEN_ORNAMENT_3 = "可以挂在树上的装饰。",		-- 物品名:"蜘蛛装饰"
		HALLOWEEN_ORNAMENT_4 = "可以挂在树上的装饰。",		-- 物品名:"触手装饰"
		HALLOWEEN_ORNAMENT_5 = "可以挂在树上的装饰。",		-- 物品名:"穴居悬蛛装饰"
		HALLOWEEN_ORNAMENT_6 = "可以挂在树上的装饰。",		-- 物品名:"乌鸦装饰"
		HALLOWEENPOTION_DRINKS_WEAK = "原以为会更大呢。",		-- 物品名:"远古宝箱"
		HALLOWEENPOTION_DRINKS_POTENT = "强力药水。",		-- 物品名:"远古宝箱"
        HALLOWEENPOTION_BRAVERY = "满满的勇气。",		-- 物品名:"远古宝箱"
		HALLOWEENPOTION_MOON = "注入了变异的力量。",		-- 物品名:"月亮精华液"
		HALLOWEENPOTION_FIRE_FX = "烈火结晶。",		-- 物品名:"远古宝箱"
		MADSCIENCE_LAB = "这是科学还是魔法？",		-- 物品名:"疯狂科学家实验室" 制造描述:"疯狂实验无极限。唯独神智有极限。"
		LIVINGTREE_ROOT = "可以挖起来。",		-- 物品名:"完全正常的树根"
		LIVINGTREE_SAPLING = "蕴藏了巨大的生命力。",		-- 物品名:"完全正常的树苗"
        DRAGONHEADHAT = "在下好像不够高。",		-- 物品名:"幸运兽脑袋" 制造描述:"野兽装束的前端。"
        DRAGONBODYHAT = "在下好像不够高。",		-- 物品名:"幸运兽躯体" 制造描述:"野兽装束的中间部分。"
        DRAGONTAILHAT = "在下好像不够高。",		-- 物品名:"幸运兽尾巴" 制造描述:"野兽装束的尾端。"
        PERDSHRINE =
        {
            GENERIC = "感觉它想要什么东西。",		-- 物品名:"火鸡神龛"->默认 制造描述:"供奉庄严之火鸡。"
            EMPTY = "要在那里种些东西。",		-- 物品名:"火鸡神龛" 制造描述:"供奉庄严之火鸡。"
            BURNT = "完全没用了。",		-- 物品名:"火鸡神龛"->烧焦的 制造描述:"供奉庄严之火鸡。"
        },
        REDLANTERN = "这个灯笼感觉比其他灯笼特别。",		-- 物品名:"红灯笼" 制造描述:"照亮你的路的幸运灯笼。"
        LUCKY_GOLDNUGGET = "多么幸运的发现！",		-- 物品名:"幸运黄金"
        FIRECRACKERS = "东方人用它驱赶魔物。",		-- 物品名:"红鞭炮" 制造描述:"用爆炸来庆祝！"
        PERDFAN = "非常大。",		-- 物品名:"幸运扇" 制造描述:"额外的运气，超级多。"
        REDPOUCH = "里面有什么东西吗？",		-- 物品名:"红包"
        WARGSHRINE =
        {
            GENERIC = "在下得做点好玩的东西。",		-- 物品名:"座狼神龛"->默认 制造描述:"供奉陶土之座狼。"
            EMPTY = "在下需要在里面放支火把。",		-- 物品名:"座狼神龛" 制造描述:"供奉陶土之座狼。"
            BURNING = "在下得做点好玩的东西。", --for willow to override		-- 物品名:"座狼神龛"->正在燃烧 制造描述:"供奉陶土之座狼。"
            BURNT = "它烧毁了。",		-- 物品名:"座狼神龛"->烧焦的 制造描述:"供奉陶土之座狼。"
        },
        CLAYWARG =
        {
        	GENERIC = "黏土怪物！",		-- 物品名:"黏土座狼"->默认
        	STATUE = "它刚刚是不是动了？",		-- 物品名:"黏土座狼"->雕像
        },
        CLAYHOUND =
        {
        	GENERIC = "它脱离束缚了！",		-- 物品名:"黏土猎犬"->默认
        	STATUE = "它看起来好逼真。",		-- 物品名:"黏土猎犬"->雕像
        },
        HOUNDWHISTLE = "这个能阻挡坏狗狗的脚步。",		-- 物品名:"幸运哨子" 制造描述:"对野猎犬吹哨。"
        CHESSPIECE_CLAYHOUND = "坏狗狗。",		-- 物品名:"猎犬雕塑"
        CHESSPIECE_CLAYWARG = "大坏狗狗！",		-- 物品名:"座狼雕塑"
		PIGSHRINE =
		{
            GENERIC = "有更多东西要做。",		-- 物品名:"猪神龛"->默认 制造描述:"供奉富饶之猪人。"
            EMPTY = "它想要肉。",		-- 物品名:"猪神龛" 制造描述:"供奉富饶之猪人。"
            BURNT = "烧焦了。",		-- 物品名:"猪神龛"->烧焦的 制造描述:"供奉富饶之猪人。"
		},
		PIG_TOKEN = "这个看起来很重要。",		-- 物品名:"金腰带"
		PIG_COIN = "可以用来给猪王。",		-- 物品名:"猪鼻铸币"
		YOTP_FOOD1 = "可以用来给猪王。",		-- 物品名:"贡品烤肉" 制造描述:"向猪王敬肉。"
		YOTP_FOOD2 = "有点奇怪的料理。",		-- 物品名:"八宝泥馅饼" 制造描述:"那里隐藏着什么？"
		YOTP_FOOD3 = "有点奇怪的料理。",		-- 物品名:"鱼头串" 制造描述:"棍子上的荣华富贵。"
		PIGELITE1 = "看什么呢？", --BLUE		-- 物品名:"韦德"
		PIGELITE2 = "他得了淘金热！", --RED		-- 物品名:"伊格内修斯"
		PIGELITE3 = "你眼里有泥！", --WHITE		-- 物品名:"德米特里"
		PIGELITE4 = "难道你不想打其他人吗？", --GREEN		-- 物品名:"索耶"
		PIGELITEFIGHTER1 = "看什么看？", --BLUE		-- 物品名:"韦德"
		PIGELITEFIGHTER2 = "他得了淘金热！", --RED		-- 物品名:"伊格内修斯"
		PIGELITEFIGHTER3 = "你眼里有泥！", --WHITE		-- 物品名:"德米特里"
		PIGELITEFIGHTER4 = "难道你不想打其他人吗？", --GREEN		-- 物品名:"索耶"
		CARRAT_GHOSTRACER = "真令人不安啊。",		-- 物品名:"查理的胡萝卜鼠"
        YOTC_CARRAT_RACE_START = "不错的起点。",		-- 物品名:"起点" 制造描述:"冲向比赛！"
        YOTC_CARRAT_RACE_CHECKPOINT = "关键的一点。",		-- 物品名:"检查点" 制造描述:"通往光荣之路上的一站。"
        YOTC_CARRAT_RACE_FINISH =
        {
            GENERIC = "与其说是终点线，不如说是终点圈。",		-- 物品名:"终点线"->默认 制造描述:"你走投无路了。"
            BURNT = "一把火烧的干干净净！",		-- 物品名:"终点线"->烧焦的 制造描述:"你走投无路了。"
            I_WON = "将这场胜利献给主人！",		-- 物品名:"终点线" 制造描述:"你走投无路了。"
            SOMEONE_ELSE_WON = "功亏一篑，{winner}。",		-- 物品名:"终点线" 制造描述:"你走投无路了。"
        },
		YOTC_CARRAT_RACE_START_ITEM = "好吧，算是个开始。",		-- 物品名:"起点套装" 制造描述:"冲向比赛！"
        YOTC_CARRAT_RACE_CHECKPOINT_ITEM = "总会抵达终点。",		-- 物品名:"检查点套装" 制造描述:"通往光荣之路上的一站。"
		YOTC_CARRAT_RACE_FINISH_ITEM = "大限将至。",		-- 物品名:"终点线套装" 制造描述:"你走投无路了。"
		YOTC_SEEDPACKET = "许多的小生命。",		-- 物品名:"种子包" 制造描述:"一包普通的混合种子。"
		YOTC_SEEDPACKET_RARE = "更多的小生命",		-- 物品名:"高级种子包" 制造描述:"一包高质量的种子。"
		MINIBOATLANTERN = "真亮！",		-- 物品名:"漂浮灯笼" 制造描述:"闪着暖暖的光亮。"
        YOTC_CARRATSHRINE =
        {
            GENERIC = "做什么呢……",		-- 物品名:"胡萝卜鼠神龛"->默认 制造描述:"供奉灵巧之胡萝卜鼠。"
            EMPTY = "嗯……胡萝卜鼠喜欢吃什么呢？",		-- 物品名:"胡萝卜鼠神龛" 制造描述:"供奉灵巧之胡萝卜鼠。"
            BURNT = "烤胡萝卜的气味。",		-- 物品名:"胡萝卜鼠神龛"->烧焦的 制造描述:"供奉灵巧之胡萝卜鼠。"
        },
        YOTC_CARRAT_GYM_DIRECTION =
        {
            GENERIC = "为训练指明方向。",		-- 物品名:"方向健身房"->默认
            RAT = "你能当一只优秀的小白鼠。",		-- 物品名:"方向健身房"
            BURNT = "在下的训练计划灰飞烟灭。",		-- 物品名:"方向健身房"->烧焦的
        },
        YOTC_CARRAT_GYM_SPEED =
        {
            GENERIC = "在下需要提高胡萝卜鼠的速度。",		-- 物品名:"速度健身房"->默认
            RAT = "快点……快点！",		-- 物品名:"速度健身房"
            BURNT = "悲伤的故事。",		-- 物品名:"速度健身房"->烧焦的
        },
        YOTC_CARRAT_GYM_REACTION =
        {
            GENERIC = "我们来训练胡萝卜鼠的反应速度！",		-- 物品名:"反应健身房"->默认
            RAT = "它的反应时间正在稳步提高！",		-- 物品名:"反应健身房"
            BURNT = "悲伤的故事。",		-- 物品名:"反应健身房"->烧焦的
        },
        YOTC_CARRAT_GYM_STAMINA =
        {
            GENERIC = "变得更加强壮了！",		-- 物品名:"耐力健身房"->默认
            RAT = "这只胡萝卜鼠……将无人能挡！！",		-- 物品名:"耐力健身房"
            BURNT = "悲伤的故事。",		-- 物品名:"耐力健身房"->烧焦的
        },
        YOTC_CARRAT_GYM_DIRECTION_ITEM = "在下也该练练了！",		-- 物品名:"方向健身房套装" 制造描述:"提高你的胡萝卜鼠的方向感。"
        YOTC_CARRAT_GYM_SPEED_ITEM = "在下最好把这个组装起来。",		-- 物品名:"速度健身房套装" 制造描述:"增加你的胡萝卜鼠的速度。"
        YOTC_CARRAT_GYM_STAMINA_ITEM = "这个会改善胡萝卜鼠的耐力",		-- 物品名:"耐力健身房套装" 制造描述:"增强你的胡萝卜鼠的耐力。"
        YOTC_CARRAT_GYM_REACTION_ITEM = "这个应该能显著提高胡萝卜鼠的反应时间。",		-- 物品名:"反应健身房套装" 制造描述:"加快你的胡萝卜鼠的反应时间。"
        YOTC_CARRAT_SCALE_ITEM = "可以秤在下的胡萝卜鼠。",		-- 物品名:"胡萝卜鼠秤套装" 制造描述:"看看你的胡萝卜鼠的情况。"
        YOTC_CARRAT_SCALE =
        {
            GENERIC = "帮我的伙伴控制体重。",		-- 物品名:"胡萝卜鼠秤"->默认
            CARRAT = "毫无疑问，这也是一种魔法。",		-- 物品名:"胡萝卜鼠" 制造描述:"灵巧机敏，富含胡萝卜素。"
            CARRAT_GOOD = "胡萝卜鼠熟到可以赛跑了！",		-- 物品名:"胡萝卜鼠秤"
            BURNT = "悲伤的故事。",		-- 物品名:"胡萝卜鼠秤"->烧焦的
        },
        YOTB_BEEFALOSHRINE =
        {
            GENERIC = "做什么呢……",		-- 物品名:"皮弗娄牛神龛"->默认 制造描述:"供奉坚毅之皮弗娄牛。"
            EMPTY = "嗯……牛牛是什么做的呢？",		-- 物品名:"皮弗娄牛神龛" 制造描述:"供奉坚毅之皮弗娄牛。"
            BURNT = "闻起来是烤肉的味道。",		-- 物品名:"皮弗娄牛神龛"->烧焦的 制造描述:"供奉坚毅之皮弗娄牛。"
        },
        BEEFALO_GROOMER =
        {
            GENERIC = "没有牛牛让在下打扮。",		-- 物品名:"皮弗娄牛美妆台"->默认 制造描述:"美牛原型机。"
            OCCUPIED = "让我们来美化一下这头牛牛！",		-- 物品名:"皮弗娄牛美妆台"->被占领 制造描述:"美牛原型机。"
            BURNT = "悲伤的故事。",		-- 物品名:"皮弗娄牛美妆台"->烧焦的 制造描述:"美牛原型机。"
        },
        BEEFALO_GROOMER_ITEM = "在下还是换个地方把它装起来吧。",		-- 物品名:"美妆台套装" 制造描述:"美牛原型机。"
        YOTR_RABBITSHRINE =
        {
            GENERIC = "做什么呢……",		-- 物品名:"兔人神龛"->默认 制造描述:"供奉舒适之兔人。"
            EMPTY = "那只兔子看起来饿了。",		-- 物品名:"兔人神龛" 制造描述:"供奉舒适之兔人。"
            BURNT = "闻起来像素食烧烤。",		-- 物品名:"兔人神龛"->烧焦的 制造描述:"供奉舒适之兔人。"
        },
        NIGHTCAPHAT = "快点睡吧，乖孩子",		-- 物品名:"睡帽" 制造描述:"为你打瞌睡的脑袋准备的帽子。"
        YOTR_FOOD1 = "有点奇怪的料理。",		-- 物品名:"兔子卷" 制造描述:"制造这个蛋糕的过程中没有兔子受到伤害。"
        YOTR_FOOD2 = "一种东方的传统料理。",		-- 物品名:"月饼" 制造描述:"“蓝色”风味！"
        YOTR_FOOD3 = "有点奇怪的料理。",		-- 物品名:"月冻" 制造描述:"这甜点美的让人不忍心咬一口。"
        YOTR_FOOD4 = "美味的甜品",		-- 物品名:"泡芙串" 制造描述:"蓬松有嚼劲的球。"
        YOTR_TOKEN = "这个东西在下可不能给错人。",		-- 物品名:"挑战手套" 制造描述:"告诉兔人你想在枕头大战里试试手。"
        COZY_BUNNYMAN = "他们看着很舒服的样子。",		-- 物品名:"舒适的兔人"
        HANDPILLOW_BEEFALOWOOL = "与牛牛一同入眠。",		-- 物品名:"皮弗娄牛毛枕头" 制造描述:"打出一记带牛毛的重击。"
        HANDPILLOW_KELP = "海也会做梦吗？",		-- 物品名:"海带枕头" 制造描述:"没有人喜欢盖着湿毯子睡。别以为湿枕头能好到哪去。"
        HANDPILLOW_PETALS = "花也会做梦吗？",		-- 物品名:"花朵枕头" 制造描述:"枕头里装满了花的力量。"
        HANDPILLOW_STEELWOOL = "可怕",		-- 物品名:"钢丝绵枕头" 制造描述:"专为枕头大战的严肃参赛者准备。"
        BODYPILLOW_BEEFALOWOOL = "牛牛冲锋！。",		-- 物品名:"皮弗娄牛枕头盔甲" 制造描述:"加强你的枕头防卫。"
        BODYPILLOW_KELP = "在下不喜欢这么潮。",		-- 物品名:"海带枕头盔甲" 制造描述:"一套湿漉漉的枕头盔甲。"
        BODYPILLOW_PETALS = "海也会做梦吗？",		-- 物品名:"花朵枕头盔甲" 制造描述:"它提供了最低限度的保护，脱下它后你身上会有玫瑰花的香味。"
        BODYPILLOW_STEELWOOL = "可怕，",		-- 物品名:"钢丝绵枕头盔甲" 制造描述:"一个可穿戴的枕头，既有效又令人不快。"
		BISHOP_CHARGE_HIT = "噢！",		-- 物品名:"兔人神龛"->被主教攻击 制造描述:"供奉舒适之兔人。"
		TRUNKVEST_SUMMER = "不错的衣服。",		-- 物品名:"透气背心" 制造描述:"暖和，但算不上非常暖和。"
		TRUNKVEST_WINTER = "大家都要多穿点哦。",		-- 物品名:"松软背心" 制造描述:"足以抵御冬季暴雪的保暖背心。"
		TRUNK_COOKED = "很少见的料理。",		-- 物品名:"象鼻排"
		TRUNK_SUMMER = "一根轻快通风的象鼻。",		-- 物品名:"象鼻"
		TRUNK_WINTER = "一根肥厚多毛的象鼻。",		-- 物品名:"冬象鼻"
		TUMBLEWEED = "让人按捺不住好奇心。",		-- 物品名:"风滚草"
		TURKEYDINNER = "哇，好丰盛！",		-- 物品名:"火鸡正餐"
		TWIGS = "一堆小树枝。",		-- 物品名:"树枝"
		UMBRELLA = "居然不能完全挡住雨水。",		-- 物品名:"雨伞" 制造描述:"遮阳挡雨！"
		GRASS_UMBRELLA = "居然不能完全挡住雨水",		-- 物品名:"花伞" 制造描述:"漂亮轻便的保护伞。"
		UNIMPLEMENTED = "看起来还没有完工！可能有危险。",		-- 物品名:"兔人神龛" 制造描述:"供奉舒适之兔人。"
		WAFFLES = "(╯▽╰ )好香~~",		-- 物品名:"华夫饼"
		WALL_HAY =
		{
			GENERIC = "它会被点燃。",		-- 物品名:"草墙"->默认
			BURNT = "完全没用了。",		-- 物品名:"草墙"->烧焦的
		},
		WALL_HAY_ITEM = "这不像是个好主意。",		-- 物品名:"草墙" 制造描述:"草墙墙体。不太结实。"
		WALL_STONE = "不错的墙。",		-- 物品名:"石墙"
		WALL_STONE_ITEM = "它们让在下有安全感。",		-- 物品名:"石墙" 制造描述:"石墙墙体。"
		WALL_RUINS = "一段古老的墙。",		-- 物品名:"铥墙"
		WALL_RUINS_ITEM = "一段坚固的历史。",		-- 物品名:"铥墙" 制造描述:"这些墙可以承受相当多的打击。"
		WALL_WOOD =
		{
			GENERIC = "尖的！",		-- 物品名:"木墙"->默认
			BURNT = "烧焦了！",		-- 物品名:"木墙"->烧焦的
		},
		WALL_WOOD_ITEM = "木桩！",		-- 物品名:"木墙" 制造描述:"木墙墙体。"
		WALL_MOONROCK = "空灵而光滑！",		-- 物品名:"月岩墙"
		WALL_MOONROCK_ITEM = "非常轻盈，但出人意料地坚硬。",		-- 物品名:"月岩墙" 制造描述:"月球疯子之墙。"
		WALL_DREADSTONE = "这种感觉真……安全？",		-- 物品名:"绝望石墙"
		WALL_DREADSTONE_ITEM = "会出什么问题？",		-- 物品名:"绝望石墙" 制造描述:"将自己包围在最可怕的装饰之中。"
		FENCE = "不过是个木头栅栏。",		-- 物品名:"木栅栏"
        FENCE_ITEM = "有了它就能造出一个美丽牢固的栅栏。",		-- 物品名:"木栅栏" 制造描述:"木栅栏部分。"
        FENCE_GATE = "必不可少的家具。",		-- 物品名:"木门"
        FENCE_GATE_ITEM = "必不可少的家具。",		-- 物品名:"木门" 制造描述:"木栅栏的门。"
		WALRUS = "讨厌的家伙。",		-- 物品名:"海象"
		WALRUSHAT = "在下喜欢这顶帽子。",		-- 物品名:"贝雷帽"
		WALRUS_CAMP =
		{
			EMPTY = "看起来有人在这里扎营。",		-- 物品名:"海象营地"
			GENERIC = "看起来里面温暖而舒适。",		-- 物品名:"海象营地"->默认
		},
		WALRUS_TUSK = "这个可以升级在下的法杖。",		-- 物品名:"海象牙"
		WARDROBE =
		{
			GENERIC = "必不可少的家具。",		-- 物品名:"衣柜"->默认 制造描述:"随心变换面容。"
            BURNING = "烧得好快！",		-- 物品名:"衣柜"->正在燃烧 制造描述:"随心变换面容。"
			BURNT = "不要灰心哦。",		-- 物品名:"衣柜"->烧焦的 制造描述:"随心变换面容。"
		},
		WARG = "大坏狗！大坏狗！",		-- 物品名:"座狼"
        WARGLET = "大坏狗",		-- 物品名:"青年座狼"
		WASPHIVE = "大自然在生气。",		-- 物品名:"杀人蜂蜂窝"
		WATERBALLOON = "不可以乱扔哦。",		-- 物品名:"水球" 制造描述:"球体灭火。"
		WATERMELON = "非常好吃的水果。",		-- 物品名:"西瓜"
		WATERMELON_COOKED = "真的能这样料理吗？",		-- 物品名:"烤西瓜"
		WATERMELONHAT = "在下觉得这不是个好主意。",		-- 物品名:"西瓜帽" 制造描述:"提神醒脑，但感觉黏黏的。"
		WAXWELLJOURNAL =
		{
			GENERIC = "魔法、能量和……生命？。",		-- 物品名:"暗影秘典"->默认 制造描述:"这将让你大吃一惊。"
			NEEDSFUEL = "only_used_by_waxwell",		-- 物品名:"暗影秘典" 制造描述:"这将让你大吃一惊。"
		},
		WETGOOP = "算不上料理。",		-- 物品名:"潮湿黏糊"
        WHIP = "没什么比大响声更能带来宁静的了。",		-- 物品名:"三尾猫鞭" 制造描述:"提出有建设性的反馈意见。"
		WINTERHAT = "注意保暖哦。",		-- 物品名:"冬帽" 制造描述:"保持脑袋温暖。"
		WINTEROMETER =
		{
			GENERIC = "水银的。",		-- 物品名:"温度测量仪"->默认 制造描述:"测量环境气温。"
			BURNT = "小心水银泄露哦。",		-- 物品名:"温度测量仪"->烧焦的 制造描述:"测量环境气温。"
		},
        WINTER_TREE =
        {
            BURNT = "节日气氛受了影响。",		-- 物品名:"冬季盛宴树"->烧焦的
            BURNING = "燃烧的节日。",		-- 物品名:"冬季盛宴树"->正在燃烧
            CANDECORATE = "冬季盛宴快乐！",		-- 物品名:"冬季盛宴树"->烛台？？？
            YOUNG = "马上就到冬季盛宴了！",		-- 物品名:"冬季盛宴树"->还年轻
        },
		WINTER_TREESTAND =
		{
			GENERIC = "在下需要一颗松果。",		-- 物品名:"盛宴树盆"->默认 制造描述:"种植并装饰一棵冬季盛宴树！"
            BURNT = "节日气氛受了影响。",		-- 物品名:"盛宴树盆"->烧焦的 制造描述:"种植并装饰一棵冬季盛宴树！"
		},
        WINTER_ORNAMENT = "可以挂在树上的装饰。",		-- 物品名:"圣诞小玩意"
        WINTER_ORNAMENTLIGHT = "可以挂在树上的装饰。",		-- 物品名:"圣诞灯"
        WINTER_ORNAMENTBOSS = "可以挂在树上的装饰。",		-- 物品名:"华丽的装饰"
		WINTER_ORNAMENTFORGE = "可以挂在树上的装饰。",		-- 物品名:"熔炉装饰"
		WINTER_ORNAMENTGORGE = "可以挂在树上的装饰。",		-- 物品名:"暴食装饰"
        WINTER_FOOD1 = "过节的话，吃点甜点也没关系。", --gingerbread cookie		-- 物品名:"小姜饼"
        WINTER_FOOD2 = "过节的话，吃点甜点也没关系。", --sugar cookie		-- 物品名:"糖曲奇饼"
        WINTER_FOOD3 = "过节的话，吃点甜点也没关系。", --candy cane		-- 物品名:"拐杖糖"
        WINTER_FOOD4 = "在下不要吃这种料理！", --fruitcake		-- 物品名:"永远的水果蛋糕"
        WINTER_FOOD5 = "过节的话，吃点甜点也没关系。", --yule log cake		-- 物品名:"巧克力原木蛋糕"
        WINTER_FOOD6 = "过节的话，吃点甜点也没关系。", --plum pudding		-- 物品名:"李子布丁"
        WINTER_FOOD7 = "不能喝酒哦", --apple cider		-- 物品名:"苹果酒"
        WINTER_FOOD8 = "在下喜欢喝这个", --hot cocoa		-- 物品名:"热可可"
        WINTER_FOOD9 = "不能喝酒哦", --eggnog		-- 物品名:"美味的蛋酒"
		WINTERSFEASTOVEN =
		{
			GENERIC = "喜庆的炉子，用来做火烤的食物！",		-- 物品名:"砖砌烤炉"->默认 制造描述:"燃起了喜庆的火焰。"
			COOKING = "在下喜欢这件厨具。",		-- 物品名:"砖砌烤炉" 制造描述:"燃起了喜庆的火焰。"
			ALMOST_DONE_COOKING = "在下喜欢这件厨具",		-- 物品名:"砖砌烤炉" 制造描述:"燃起了喜庆的火焰。"
			DISH_READY = "料理完成咯。",		-- 物品名:"砖砌烤炉" 制造描述:"燃起了喜庆的火焰。"
		},
		BERRYSAUCE = "过节的话，吃点甜点也没关系。",		-- 物品名:"快乐浆果酱"
		BIBINGKA = "过节的话，吃点甜点也没关系。",		-- 物品名:"比宾卡米糕"
		CABBAGEROLLS = "营养均衡的料理。",		-- 物品名:"白菜卷"
		FESTIVEFISH = "要小心鱼刺哦。",		-- 物品名:"节庆鱼料理"
		GRAVY = "全是肉汁。",		-- 物品名:"好肉汁"
		LATKES = "在下喜欢这道料理。",		-- 物品名:"土豆饼"
		LUTEFISK = "要小心鱼刺哦。",		-- 物品名:"苏打鱼"
		MULLEDDRINK = "不能喝酒哦。",		-- 物品名:"香料潘趣酒"
		PANETTONE = "多吃点长高高哦。",		-- 物品名:"托尼甜面包"
		PAVLOVA = "在下喜欢这道料理。",		-- 物品名:"巴甫洛娃蛋糕"
		PICKLEDHERRING = "要小心鱼刺哦。",		-- 物品名:"腌鲱鱼"
		POLISHCOOKIE = "在下喜欢这道料理。",		-- 物品名:"波兰饼干"
		PUMPKINPIE = "在下喜欢这道料理。",		-- 物品名:"南瓜派"
		ROASTTURKEY = "多吃点长高高哦。",		-- 物品名:"烤火鸡"
		STUFFING = "都是好料！",		-- 物品名:"烤火鸡面包馅"
		SWEETPOTATO = "奇怪但是美味的料理。",		-- 物品名:"红薯焗饭"
		TAMALES = "多吃点长壮壮哦。",		-- 物品名:"塔马利"
		TOURTIERE = "多吃点长壮壮哦。",		-- 物品名:"饕餮馅饼"
		TABLE_WINTERS_FEAST =
		{
			GENERIC = "节庆餐桌。",		-- 物品名:"冬季盛宴餐桌"->默认 制造描述:"一起来享用冬季盛宴吧。"
			HAS_FOOD = "开饭咯！",		-- 物品名:"冬季盛宴餐桌" 制造描述:"一起来享用冬季盛宴吧。"
			WRONG_TYPE = "不是吃这个的季节。",		-- 物品名:"冬季盛宴餐桌" 制造描述:"一起来享用冬季盛宴吧。"
			BURNT = "谁会做这种事？",		-- 物品名:"冬季盛宴餐桌"->烧焦的 制造描述:"一起来享用冬季盛宴吧。"
		},
		GINGERBREADWARG = "它算是生命吗？",		-- 物品名:"姜饼座狼"
		GINGERBREADHOUSE = "管吃管住。",		-- 物品名:"姜饼猪屋"
		GINGERBREADPIG = "在下最好跟着他。",		-- 物品名:"姜饼猪"
		CRUMBS = "走一路掉一路。",		-- 物品名:"饼干屑"
		WINTERSFEASTFUEL = "冬季精神!",		-- 物品名:"节日欢愉"
        KLAUS = "那究竟是什么东西！",		-- 物品名:"克劳斯"
        KLAUS_SACK = "好孩子不能偷东西哦。",		-- 物品名:"赃物袋"
		KLAUSSACKKEY = "像是一把钥匙。",		-- 物品名:"麋鹿茸"
		WORMHOLE =
		{
			GENERIC = "它似乎连接着另一个地方。",		-- 物品名:"虫洞"->默认
			OPEN = "在下觉得这是个危险的想法。",		-- 物品名:"虫洞"->打开
		},
		WORMHOLE_LIMITED = "它生病了。",		-- 物品名:"生病的虫洞"->一次性虫洞 单机
		ACCOMPLISHMENT_SHRINE = "荣誉与之在下如过袖之风。", --single player		-- 物品名:"奖杯" 制造描述:"证明你作为一个人的价值。"
		LIVINGTREE = "它在看在下吗？",		-- 物品名:"完全正常的树"
		ICESTAFF = "实用的法杖。",		-- 物品名:"冰魔杖" 制造描述:"把敌人冰冻在原地。"
		REVIVER = "伙伴，在下来救你了！",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕。"
		SHADOWHEART = "它好像渴望一具躯体",		-- 物品名:"暗影心房"
        ATRIUM_RUBBLE =
        {
			LINE_1 = "它描绘了一个古老的文明。人们看起来又饿又怕。",		-- 物品名:"远古壁画"->第一行
			LINE_2 = "这块石板已经无法识别了。",		-- 物品名:"远古壁画"->第二行
			LINE_3 = "有黑暗的东西悄悄逼近这座城市和城里的人。",		-- 物品名:"远古壁画"->第三行
			LINE_4 = "人们的皮肤在脱落。他们的表里截然不同。",		-- 物品名:"远古壁画"->第四行
			LINE_5 = "这里描绘了一座科技发达的宏伟城市。",		-- 物品名:"远古壁画"->第五行
		},
        ATRIUM_STATUE = "这看起来并不全是真的。",		-- 物品名:"远古雕像"
        ATRIUM_LIGHT =
        {
			ON = "非常令人不安的光。",		-- 物品名:"远古灯柱"->开启
			OFF = "它必须有动力来源。",		-- 物品名:"远古灯柱"->关闭
		},
        ATRIUM_GATE =
        {
			ON = "回到正常运转状态。",		-- 物品名:"远古大门"->开启
			OFF = "主要部分依然完好无损。",		-- 物品名:"远古大门"->关闭
			CHARGING = "它正在获得能量。",		-- 物品名:"远古大门"->充能中
			DESTABILIZING = "大门在晃动。",		-- 物品名:"远古大门"->不稳定
			COOLDOWN = "它需要时间恢复。",		-- 物品名:"远古大门"->冷却中
        },
        ATRIUM_KEY = "它在向外发射能量。",		-- 物品名:"远古钥匙"
		LIFEINJECTOR = "蕴含生命能量的药剂！",		-- 物品名:"强心针" 制造描述:"提高下你那日渐衰退的最大健康值吧。"
		SKELETON_PLAYER =
		{
			MALE = "逝者安息。",		-- 物品名:"骷髅"->男性
			FEMALE = "逝者安息。",		-- 物品名:"骷髅"->女性
			ROBOT = "逝者安息。",		-- 物品名:"骷髅"->机器人
			DEFAULT = "逝者安息。",		-- 物品名:"物品栏物品"->默认
		},
		HUMANMEAT = "逝者安息。",		-- 物品名:"长猪"
		HUMANMEAT_COOKED = "逝者安息。",		-- 物品名:"熟长猪"
		HUMANMEAT_DRIED = "逝者安息。",		-- 物品名:"长猪肉干"
		ROCK_MOON = "那块石头来自月亮。",		-- 物品名:"岩石"
		MOONROCKNUGGET = "那块石头来自月亮。",		-- 物品名:"月岩"
		MOONROCKCRATER = "它的内心很空洞",		-- 物品名:"带孔月岩" 制造描述:"用于划定地盘的岩石。"
		MOONROCKSEED = "来自月亮的惊人魔法",		-- 物品名:"天体宝球"
        REDMOONEYE = "在下总能在地图上找到它",		-- 物品名:"红色月眼"
        PURPLEMOONEYE = "在下总能在地图上找到它",		-- 物品名:"紫色月眼"
        GREENMOONEYE = "在下总能在地图上找到它",		-- 物品名:"绿色月眼"
        ORANGEMOONEYE = "在下总能在地图上找到它",		-- 物品名:"橘色月眼"
        YELLOWMOONEYE = "在下总能在地图上找到它",		-- 物品名:"黄色月眼"
        BLUEMOONEYE = "在下总能在地图上找到它",		-- 物品名:"蓝色月眼"
        BOARRIOR = "你可真大！",		-- 物品名:"大熔炉猪战士"->大熔炉猪战士
        BOARON = "在下可以应对他！",		-- 物品名:"战猪"
        PEGHOOK = "那家伙喷出来的东西有腐蚀性！",		-- 物品名:"蝎子"
        TRAILS = "他的胳膊真壮啊。",		-- 物品名:"野猪猩"
        TURTILLUS = "它的壳有尖刺！",		-- 物品名:"坦克龟"
        SNAPPER = "这家伙会咬人。",		-- 物品名:"鳄鱼指挥官"
		RHINODRILL = "他的鼻子很适合干这个活。",		-- 物品名:"后扣帽犀牛兄弟"
		BEETLETAUR = "在下在这里都能闻到他的气味！",		-- 物品名:"地狱独眼巨猪"
        LAVAARENA_PORTAL =
        {
            ON = "在下要走了。",		-- 物品名:"远古大门"->开启
            GENERIC = "能过来，应该也能回去吧？",		-- 物品名:"远古大门"->默认
        },
        HEALINGSTAFF = "释放再生的力量。",		-- 物品名:"生命魔杖"
        FIREBALLSTAFF = "召唤流星从天而降。",		-- 物品名:"地狱魔杖"
        HAMMER_MJOLNIR = "这把敲东西的锤子可真重。",		-- 物品名:"锻锤"
        SPEAR_GUNGNIR = "在下可以用它快速充电。",		-- 物品名:"尖齿矛"
        BLOWDART_LAVA = "在下可以在范围内用这个武器。",		-- 物品名:"吹箭"
        BLOWDART_LAVA2 = "它利用一股强气流来推动抛射物。",		-- 物品名:"熔化吹箭"
        WEBBER_SPIDER_MINION = "可以说他们是在为我们战斗吧。",		-- 物品名:"蜘蛛宝宝"
        BOOK_FOSSIL = "这样能把那些怪物拖住一阵子。",		-- 物品名:"石化之书"
		SPEAR_LANCE = "它直击要害。",		-- 物品名:"螺旋矛"
		BOOK_ELEMENTAL = "在下看不清这些字。",		-- 物品名:"召唤之书"
        QUAGMIRE_ALTAR =
        {
        	GENERIC = "我们最好开始煮些祭品。",		-- 物品名:"饕餮祭坛"->默认
        	FULL = "它正在消化。",		-- 物品名:"饕餮祭坛"->满了
    	},
		QUAGMIRE_SUGARWOODTREE =
		{
			GENERIC = "它含有大量美味可口的树液。",		-- 物品名:"糖木树"->默认
			STUMP = "那棵树哪去了？真是一桩谜题。",		-- 物品名:"糖木树"->暴食模式糖木树只剩树桩了
			TAPPED_EMPTY = "丰富的汁液。",		-- 物品名:"糖木树"->暴食模式糖木树空了
			TAPPED_READY = "香甜的金黄色汁液。",		-- 物品名:"糖木树"->暴食模式糖木树好了
			TAPPED_BUGS = "蚂蚁就是这样来的。",		-- 物品名:"糖木树"->暴食模式糖木树上有蚂蚁
			WOUNDED = "它看上去生病了。",		-- 物品名:"糖木树"->暴食糖木树生病了
		},
		QUAGMIRE_SPOTSPICE_SHRUB =
		{
			GENERIC = "它让在下想起来那些带触手的怪物。",		-- 物品名:"带斑点的小灌木"->默认
			PICKED = "从那丛灌木中采集不到更多果实了。",		-- 物品名:"带斑点的小灌木"->被采完了
		},
		QUAGMIRE_SALT_RACK =
		{
			READY = "盐积聚在绳子上了。",		-- 物品名:"盐架"->准备好的 满的
			GENERIC = "科学是需要时间的。",		-- 物品名:"盐架"->默认
		},
		QUAGMIRE_SAFE =
		{
			GENERIC = "这是保险箱，用来保护物品安全的。",		-- 物品名:"保险箱"->默认
			LOCKED = "没有钥匙就打不开。",		-- 物品名:"保险箱"->锁住了
		},
		QUAGMIRE_MUSHROOMSTUMP =
		{
			GENERIC = "那些是蘑菇吗？这真是一桩难题。",		-- 物品名:"蘑菇"->默认
			PICKED = "应该不会长回来了。",		-- 物品名:"蘑菇"->被采完了
		},
        QUAGMIRE_RUBBLE_HOUSE =
        {
            "空无一人。",		-- 物品名:"残破的房子" 制造描述:未找到
            "这个小镇被摧毁了。",		-- 物品名:"残破的房子" 制造描述:未找到
            "不知道他们惹怒了谁。",		-- 物品名:"残破的房子" 制造描述:未找到
        },
        QUAGMIRE_SWAMPIGELDER =
        {
            GENERIC = "在下猜你是这里的老大？",		-- 物品名:"沼泽猪长老"->默认
            SLEEPING = "它睡着了，暂时睡着了。",		-- 物品名:"沼泽猪长老"->睡着了
        },
        QUAGMIRE_FOOD =
        {
        	GENERIC = "在下应该把它献祭在饕餮祭坛上。",		-- 物品名:未找到
            MISMATCH = "不是它想要的。",		-- 物品名:未找到
            MATCH = "科学说这样会安抚天空之神。",		-- 物品名:未找到
            MATCH_BUT_SNACK = "真的，这更像是小吃。",		-- 物品名:未找到
        },
        QUAGMIRE_PARK_GATE =
        {
            GENERIC = "没钥匙不行。",		-- 物品名:"铁门"->默认
            LOCKED = "锁得牢牢的。",		-- 物品名:"铁门"->锁住了
        },
        QUAGMIRE_PIGEON =
        {
            DEAD = "死了。",		-- 物品名:"鸽子"->死了 制造描述:"这是一只完整的活鸽。"
            GENERIC = "羽翼丰满。",		-- 物品名:"鸽子"->默认 制造描述:"这是一只完整的活鸽。"
            SLEEPING = "暂时睡着了。",		-- 物品名:"鸽子"->睡着了 制造描述:"这是一只完整的活鸽。"
        },
        WINONA_CATAPULT =
        {
        	GENERIC = "她是个了不起的天才。",		-- 物品名:"薇诺娜的投石机"->默认 制造描述:"向敌人投掷大石块"
        	OFF = "需要通电。",		-- 物品名:"薇诺娜的投石机"->关闭 制造描述:"向敌人投掷大石块"
        	BURNING = "风啊，帮帮我们！",		-- 物品名:"薇诺娜的投石机"->正在燃烧 制造描述:"向敌人投掷大石块"
        	BURNT = "别难过，抱抱你哦。",		-- 物品名:"薇诺娜的投石机"->烧焦的 制造描述:"向敌人投掷大石块"
        },
        WINONA_SPOTLIGHT =
        {
        	GENERIC = "好棒的主意！",		-- 物品名:"薇诺娜的聚光灯"->默认 制造描述:"白天夜里都发光"
        	OFF = "需要通电。",		-- 物品名:"薇诺娜的聚光灯"->关闭 制造描述:"白天夜里都发光"
        	BURNING = "风啊，帮帮我们！",		-- 物品名:"薇诺娜的聚光灯"->正在燃烧 制造描述:"白天夜里都发光"
        	BURNT = "别难过，抱抱你哦。",		-- 物品名:"薇诺娜的聚光灯"->烧焦的 制造描述:"白天夜里都发光"
        },
        WINONA_BATTERY_LOW =
        {
        	GENERIC = "她是个了不起的天才。",		-- 物品名:"薇诺娜的发电机"->默认 制造描述:"要确保电力供应充足"
        	LOWPOWER = "电量正在下降。",		-- 物品名:"薇诺娜的发电机"->没电了 制造描述:"要确保电力供应充足"
        	OFF = "她是个了不起的天才。。",		-- 物品名:"薇诺娜的发电机"->关闭 制造描述:"要确保电力供应充足"
        	BURNING = "风啊，帮帮我们！",		-- 物品名:"薇诺娜的发电机"->正在燃烧 制造描述:"要确保电力供应充足"
        	BURNT = "别难过，抱抱你哦。",		-- 物品名:"薇诺娜的发电机"->烧焦的 制造描述:"要确保电力供应充足"
        },
        WINONA_BATTERY_HIGH =
        {
        	GENERIC = "这是科学还是魔法？",		-- 物品名:"薇诺娜的宝石发电机"->默认 制造描述:"这玩意烧宝石，所以肯定不会差。"
        	LOWPOWER = "马上就没电了。",		-- 物品名:"薇诺娜的宝石发电机"->没电了 制造描述:"这玩意烧宝石，所以肯定不会差。"
        	OFF = "它似乎用魔法能量驱动。",		-- 物品名:"薇诺娜的宝石发电机"->关闭 制造描述:"这玩意烧宝石，所以肯定不会差。"
        	BURNING = "风啊，帮帮我们！",		-- 物品名:"薇诺娜的宝石发电机"->正在燃烧 制造描述:"这玩意烧宝石，所以肯定不会差。"
        	BURNT = "别难过，抱抱你哦。",		-- 物品名:"薇诺娜的宝石发电机"->烧焦的 制造描述:"这玩意烧宝石，所以肯定不会差。"
        },
        COMPOSTWRAP = "这不是料理！",		-- 物品名:"肥料包" 制造描述:"“草本”的疗法。"
        ARMOR_BRAMBLE = "感谢在下的植物伙伴",		-- 物品名:"荆棘外壳" 制造描述:"让大自然告诉你什么叫“滚开”。"
        TRAP_BRAMBLE = "以牙还牙。",		-- 物品名:"荆棘陷阱" 制造描述:"中招机会平等的扰人陷阱。"
        BOATFRAGMENT03 = "就剩下了这一点。",		-- 物品名:"船碎片"
        BOATFRAGMENT04 = "就剩下了这一点。",		-- 物品名:"船碎片"
        BOATFRAGMENT05 = "就剩下了这一点。",		-- 物品名:"船碎片"
		BOAT_LEAK = "要补漏，不然会沉。",		-- 物品名:"漏洞"
        MAST = "乘风破浪！",		-- 物品名:"桅杆" 制造描述:"乘风破浪会有时。"
        SEASTACK = "这是一块石头。",		-- 物品名:"海蚀柱"
        FISHINGNET = "就是一张网。", --unimplemented		-- 物品名:"渔网" 制造描述:"就是一张网。"
        ANTCHOVIES = "不太适合用来料理", --unimplemented		-- 物品名:"蚁头凤尾鱼"
        STEERINGWHEEL = "风会指引在下方向。",		-- 物品名:"方向舵" 制造描述:"航海必备道具。"
        ANCHOR = "风啊，请停一停。",		-- 物品名:"锚" 制造描述:"船用刹车"
        BOATPATCH = "有备无患。",		-- 物品名:"船补丁" 制造描述:"打补丁永远不晚。"
        DRIFTWOOD_TREE =
        {
            BURNING = "风啊，吹灭它！",		-- 物品名:"浮木"->正在燃烧
            BURNT = "看起来没什么用了。",		-- 物品名:"浮木"->烧焦的
            CHOPPED = "可能还有东西值得挖一挖。",		-- 物品名:"浮木"->被砍了
            GENERIC = "被冲到岸上的一颗枯树。",		-- 物品名:"浮木"->默认
        },
        DRIFTWOOD_LOG = "能浮在水上。",		-- 物品名:"浮木桩"
        MOON_TREE =
        {
            BURNING = "树在燃烧。",		-- 物品名:"月树"->正在燃烧
            BURNT = "树烧尽了。",		-- 物品名:"月树"->烧焦的
            CHOPPED = "东方传说中，有人负责砍伐它",		-- 物品名:"月树"->被砍了
            GENERIC = "这还能算大自然吗？",		-- 物品名:"月树"->默认
        },
		MOON_TREE_BLOSSOM = "从月亮树上掉下来的。",		-- 物品名:"月树花"
        MOONBUTTERFLY =
        {
        	GENERIC = "这还能算大自然吗？",		-- 物品名:"月蛾"->默认
        	HELD = "这下抓到你了。",		-- 物品名:"月蛾"->拿在手里
        },
		MOONBUTTERFLYWINGS = "好漂亮的蝴蝶翅膀。",		-- 物品名:"月蛾翅膀"
        MOONBUTTERFLY_SAPLING = "这还能算大自然吗？",		-- 物品名:"月树苗"
        ROCK_AVOCADO_FRUIT = "能储存很长时间的优秀食材。",		-- 物品名:"石果"
        ROCK_AVOCADO_FRUIT_RIPE = "有点硌牙的牛油果。",		-- 物品名:"成熟石果"
        ROCK_AVOCADO_FRUIT_RIPE_COOKED = "烤牛油果料理。",		-- 物品名:"熟石果"
        ROCK_AVOCADO_FRUIT_SPROUT = "它在等待风和未来。",		-- 物品名:"发芽的石果"
        ROCK_AVOCADO_BUSH =
        {
        	BARREN = "待君采撷。",		-- 物品名:"石果灌木丛"
			WITHERED = "被热坏了。",		-- 物品名:"石果灌木丛"->枯萎了
			GENERIC = "这还能算大自然吗？",		-- 物品名:"石果灌木丛"->默认
			PICKED = "我会陪你一起等的。",		-- 物品名:"石果灌木丛"->被采完了
			DISEASED = "看上去病的很重。", --unimplemented		-- 物品名:"石果灌木丛"->生病了
            DISEASING = "呃...有些地方不对劲。", --unimplemented		-- 物品名:"石果灌木丛"->正在生病？？
			BURNING = "风啊！",		-- 物品名:"石果灌木丛"->正在燃烧
		},
        DEAD_SEA_BONES = "悲伤的故事。",		-- 物品名:"海骨"
        HOTSPRING =
        {
        	GENERIC = "在下想和伙伴们一起泡。",		-- 物品名:"温泉"->默认
        	BOMBED = "这似乎是一种魔法反应",		-- 物品名:"温泉"
        	GLASS = "魔法反应结束了。",		-- 物品名:"温泉"
			EMPTY = "我会陪你一起等的。",		-- 物品名:"温泉"
        },
        MOONGLASS = "小心划伤手哦。",		-- 物品名:"月亮碎片"
        MOONGLASS_CHARGED = "小心划伤手！",		-- 物品名:"注能月亮碎片"
        MOONGLASS_ROCK = "可以用来当镜子。",		-- 物品名:"月光玻璃"
        BATHBOMB = "似乎包含了月亮魔法。",		-- 物品名:"沐浴球" 制造描述:"春天里来百花香？这点子把地都炸碎了"
        TRAP_STARFISH =
        {
            GENERIC = "危险！",		-- 物品名:"海星"->默认
            CLOSED = "可以铲起来！",		-- 物品名:"海星"
        },
        DUG_TRAP_STARFISH = "可恶的小家伙。",		-- 物品名:"海星陷阱"
        SPIDER_MOON =
        {
        	GENERIC = "这还算是大自然吗？",		-- 物品名:"破碎蜘蛛"->默认
        	SLEEPING = "趁虚而入。",		-- 物品名:"破碎蜘蛛"->睡着了
        	DEAD = "胜利之风庇佑我们！",		-- 物品名:"破碎蜘蛛"->死了
        },
        MOONSPIDERDEN = "里面的居民也变异了。",		-- 物品名:"破碎蜘蛛洞"
		FRUITDRAGON =
		{
			GENERIC = "可爱的小精灵。",		-- 物品名:"沙拉蝾螈"->默认
			RIPE = "可爱的小精灵。",		-- 物品名:"沙拉蝾螈"
			SLEEPING = "嘘。",		-- 物品名:"沙拉蝾螈"->睡着了
		},
        PUFFIN =
        {
            GENERIC = "勇敢的小精灵。",		-- 物品名:"海鹦鹉"->默认
            HELD = "勇敢的小精灵。",		-- 物品名:"海鹦鹉"->拿在手里
            SLEEPING = "嘘。",		-- 物品名:"海鹦鹉"->睡着了
        },
		MOONGLASSAXE = "轻拿轻放。",		-- 物品名:"月光玻璃斧" 制造描述:"脆弱而有效。"
		GLASSCUTTER = "轻拿轻放。",		-- 物品名:"玻璃刀" 制造描述:"尖端武器。"
        ICEBERG =
        {
            GENERIC = "在下应该把它收藏起来。", --unimplemented		-- 物品名:"迷你冰山"->默认
            MELTED = "完全融化了。", --unimplemented		-- 物品名:"迷你冰山"->融化了
        },
        ICEBERG_MELTED = "完全融化了。", --unimplemented		-- 物品名:"融化的迷你冰山"
        MINIFLARE = "统治伙伴们。",		-- 物品名:"信号弹" 制造描述:"为你信任的朋友照亮前路。"
        MEGAFLARE = "交给在下吧！",		-- 物品名:"敌对信号弹" 制造描述:"为你的敌人点亮一束光。"
		MOON_FISSURE =
		{
			GENERIC = "蓬勃的月亮魔法。",		-- 物品名:"天体裂隙"->默认
			NOLIGHT = "蓬勃的月亮魔法。",		-- 物品名:"天体裂隙"
		},
        MOON_ALTAR =
        {
            MOON_ALTAR_WIP = "它想被完成。",		-- 物品名:"组装一半的祭坛"
            GENERIC = "在下习得了月亮的魔法！",		-- 物品名:"天体祭坛"->默认
        },
        MOON_ALTAR_IDOL = "蕴含着月亮魔法的知识。",		-- 物品名:"天体祭坛雕像"
        MOON_ALTAR_GLASS = "蕴含着月亮魔法的知识。",		-- 物品名:"天体祭坛底座"
        MOON_ALTAR_SEED = "蕴含着月亮魔法的知识。",		-- 物品名:"天体祭坛宝球"
        MOON_ALTAR_ROCK_IDOL = "里面有东西。",		-- 物品名:"吸引人的结构"
        MOON_ALTAR_ROCK_GLASS = "里面有东西。",		-- 物品名:"吸引人的结构"
        MOON_ALTAR_ROCK_SEED = "里面有东西。",		-- 物品名:"吸引人的结构"
        MOON_ALTAR_CROWN = "现在去找个裂隙吧！",		-- 物品名:"未激活天体贡品"
        MOON_ALTAR_COSMIC = "感觉它在等什么事情发生。",		-- 物品名:"天体贡品"
        MOON_ALTAR_ASTRAL = "它似乎是一个更大机制的一部分。",		-- 物品名:"天体圣殿"
        MOON_ALTAR_ICON = "在下知道把你放哪了。",		-- 物品名:"天体圣殿象征"
        MOON_ALTAR_WARD = "它需要和其他的那些放在一起。",		-- 物品名:"天体圣殿卫戍"
        SEAFARING_PROTOTYPER =
        {
            GENERIC = "风浪不足为惧！",		-- 物品名:"智囊团"->默认 制造描述:"海上科学。"
            BURNT = "击垮它的不是风浪。",		-- 物品名:"智囊团"->烧焦的 制造描述:"海上科学。"
        },
        BOAT_ITEM = "长风破浪会有时。",		-- 物品名:"船套装" 制造描述:"让大海成为你的领地。"
        BOAT_GRASS_ITEM = "它没有未来。",		-- 物品名:"草筏套装" 制造描述:"享受周末出游的乐趣吧。"
        STEERINGWHEEL_ITEM = "风会为在下指引方向。",		-- 物品名:"方向舵套装" 制造描述:"航海必备道具。"
        ANCHOR_ITEM = "风不听话的时候需要它。",		-- 物品名:"锚套装" 制造描述:"船用刹车"
        MAST_ITEM = "乘风破浪。",		-- 物品名:"桅杆套装" 制造描述:"乘风破浪会有时。"
        MUTATEDHOUND =
        {
        	DEAD = "风为我们带来了胜利！",		-- 物品名:"恐怖猎犬"->死了
        	GENERIC = "没完没了的坏狗狗！",		-- 物品名:"恐怖猎犬"->默认
        	SLEEPING = "风声鹤唳。",		-- 物品名:"恐怖猎犬"->睡着了
        },
        MUTATED_PENGUIN =
        {
			DEAD = "风为我们带来了胜利！",		-- 物品名:"月岩企鸥"->死了
			GENERIC = "坏企鹅！",		-- 物品名:"月岩企鸥"->默认
			SLEEPING = "风声鹤唳。",		-- 物品名:"月岩企鸥"->睡着了
		},
        CARRAT =
        {
        	DEAD = "风为我们带来了胜利！",		-- 物品名:"胡萝卜鼠"->死了 制造描述:"灵巧机敏，富含胡萝卜素。"
        	GENERIC = "奇妙的大自然。",		-- 物品名:"胡萝卜鼠"->默认 制造描述:"灵巧机敏，富含胡萝卜素。"
        	HELD = "奇妙的大自然。",		-- 物品名:"胡萝卜鼠"->拿在手里 制造描述:"灵巧机敏，富含胡萝卜素。"
        	SLEEPING = "嘘。",		-- 物品名:"胡萝卜鼠"->睡着了 制造描述:"灵巧机敏，富含胡萝卜素。"
        },
		BULLKELP_PLANT =
        {
            GENERIC = "可以用来熬高汤。",		-- 物品名:"公牛海带"->默认
            PICKED = "可以用来熬高汤。",		-- 物品名:"公牛海带"->被采完了
        },
		BULLKELP_ROOT = "可以种在深海里。",		-- 物品名:"公牛海带茎"
        KELPHAT = "有时为了好受点，必须先难受一下。",		-- 物品名:"海花环" 制造描述:"让人神经焦虑的东西。"
		KELP = "可以用来熬高汤。",		-- 物品名:"海带叶"
		KELP_COOKED = "可以用来熬高汤。",		-- 物品名:"熟海带叶"
		KELP_DRIED = "酥酥脆脆的小零食。",		-- 物品名:"干海带叶"
		GESTALT = "魔法造物？",		-- 物品名:"虚影"
        GESTALT_GUARD = "魔法造物？",		-- 物品名:"大虚影"
		COOKIECUTTER = "可恶的小家伙",		-- 物品名:"饼干切割机"
		COOKIECUTTERSHELL = "或许有用？。",		-- 物品名:"饼干切割机壳"
		COOKIECUTTERHAT = "OXO",		-- 物品名:"饼干切割机帽子" 制造描述:"穿着必须犀利。"
		SALTSTACK =
		{
			GENERIC = "必不可少的调料",		-- 物品名:"盐堆"->默认
			MINED_OUT = "我会陪你一起等的。",		-- 物品名:"盐堆"
			GROWING = "它需要风和时间",		-- 物品名:"盐堆"->正在生长
		},
		SALTROCK = "必不可少的调料。",		-- 物品名:"盐晶"
		SALTBOX = "防止食物变质的灵药！",		-- 物品名:"盐盒" 制造描述:"用盐来储存食物。"
		TACKLESTATION = "在下曾和主人一起去钓鱼。",		-- 物品名:"钓具容器" 制造描述:"传统的用饵钓鱼。"
		TACKLESKETCH = "某种钓具的图片。",		-- 物品名:"{item}广告"
        MALBATROSS = "风不站在你那边！",		-- 物品名:"邪天翁"
        MALBATROSS_FEATHER = "漂亮羽毛。",		-- 物品名:"邪天翁羽毛"
        MALBATROSS_BEAK = "可以用来划船。",		-- 物品名:"邪天翁喙"
        MAST_MALBATROSS_ITEM = "唤来风的力量！",		-- 物品名:"飞翼风帆套装" 制造描述:"像海鸟一样航向深蓝。"
        MAST_MALBATROSS = "风的力量！",		-- 物品名:"飞翼风帆" 制造描述:"像海鸟一样航向深蓝。"
		MALBATROSS_FEATHERED_WEAVE = "唤来风的力量！",		-- 物品名:"羽毛帆布" 制造描述:"精美的羽毛布料。"
        GNARWAIL =
        {
            GENERIC = "天啊，你的角真大。",		-- 物品名:"一角鲸"->默认
            BROKENHORN = "你想和在下交朋友吗？",		-- 物品名:"一角鲸"
            FOLLOWER = "在下的好伙伴。",		-- 物品名:"一角鲸"->追随者
            BROKENHORN_FOLLOWER = "这就是你到处伸鼻子的下场！",		-- 物品名:"一角鲸"
        },
        GNARWAIL_HORN = "不可思议！",		-- 物品名:"一角鲸的角"
        WALKINGPLANK = "悲伤的故事。",		-- 物品名:"木板"
        WALKINGPLANK_GRASS = "悲伤的故事。",		-- 物品名:"木板"
        OAR = "无风起浪。",		-- 物品名:"桨" 制造描述:"划，划，划小船。"
		OAR_DRIFTWOOD = "无风起浪。",		-- 物品名:"浮木桨" 制造描述:"小桨要用浮木造？"
		OCEANFISHINGROD = "在下曾和主人一起钓过鱼",		-- 物品名:"海钓竿" 制造描述:"像职业选手一样钓鱼吧。"
		OCEANFISHINGBOBBER_NONE = "可以用浮标提高准度。",		-- 物品名:"鱼钩"
        OCEANFISHINGBOBBER_BALL = "鱼群会喜欢这个球的。",		-- 物品名:"木球浮标" 制造描述:"经典设计，初学者和职业钓手两相宜。"
        OCEANFISHINGBOBBER_OVAL = "那些鱼这次休想逃出在下的手掌心！",		-- 物品名:"硬物浮标" 制造描述:"在经典浮标的基础上融入了时尚设计。"
		OCEANFISHINGBOBBER_CROW = "在下吃鱼，不吃乌鸦。",		-- 物品名:"黑羽浮标" 制造描述:"深受职业钓手的喜爱。"
		OCEANFISHINGBOBBER_ROBIN = "希望别引来红鲱鱼。",		-- 物品名:"红羽浮标" 制造描述:"深受职业钓手的喜爱。"
		OCEANFISHINGBOBBER_ROBIN_WINTER = "雪鸟的羽毛十分高冷。",		-- 物品名:"蔚蓝羽浮标" 制造描述:"深受职业钓手的喜爱。"
		OCEANFISHINGBOBBER_CANARY = "快来跟在下的小伙伴问好！",		-- 物品名:"黄羽浮标" 制造描述:"深受职业钓手的喜爱。"
		OCEANFISHINGBOBBER_GOOSE = "你要完了，鱼！",		-- 物品名:"鹅羽浮标" 制造描述:"高级羽绒浮标。"
		OCEANFISHINGBOBBER_MALBATROSS = "这么漂亮的羽毛，见过没。",		-- 物品名:"邪天翁羽浮标" 制造描述:"高级巨鸟浮标。"
		OCEANFISHINGLURE_SPINNER_RED = "也许有鱼会上当！",		-- 物品名:"日出旋转亮片" 制造描述:"早起的鱼儿有虫吃。"
		OCEANFISHINGLURE_SPINNER_GREEN = "也许有鱼会上当！",		-- 物品名:"黄昏旋转亮片" 制造描述:"低光照环境里效果最好。"
		OCEANFISHINGLURE_SPINNER_BLUE = "也许有鱼会上当！",		-- 物品名:"夜间旋转亮片" 制造描述:"适用于夜间垂钓。"
		OCEANFISHINGLURE_SPOON_RED = "也许有小鱼会上当！",		-- 物品名:"日出匙型假饵" 制造描述:"早起的鱼儿有虫吃。"
		OCEANFISHINGLURE_SPOON_GREEN = "也许有小鱼会上当！",		-- 物品名:"黄昏匙型假饵" 制造描述:"在夕阳中继续垂钓。"
		OCEANFISHINGLURE_SPOON_BLUE = "也许有小鱼会上当！",		-- 物品名:"夜间匙型假饵" 制造描述:"适用于夜间垂钓。"
		OCEANFISHINGLURE_HERMIT_RAIN = "把自己弄湿能帮助在下像鱼一样思考……",		-- 物品名:"雨天鱼饵" 制造描述:"留着雨天用。"
		OCEANFISHINGLURE_HERMIT_SNOW = "鱼儿都不会知道是谁下的手！",		-- 物品名:"雪天鱼饵" 制造描述:"雪天适合用它钓鱼。"
		OCEANFISHINGLURE_HERMIT_DROWSY = "在下的大脑有一层硬科学在保护！",		-- 物品名:"麻醉鱼饵" 制造描述:"把鱼闷住就抓住了一半。"
		OCEANFISHINGLURE_HERMIT_HEAVY = "感觉有些沉重。",		-- 物品名:"重量级鱼饵" 制造描述:"钓一条大鱼！"
		OCEANFISH_SMALL_1 = "看起来是个小家伙。",		-- 物品名:"小孔雀鱼"
		OCEANFISH_SMALL_2 = "可以用来做配菜。",		-- 物品名:"针鼻喷墨鱼"
		OCEANFISH_SMALL_3 = "还没长开。",		-- 物品名:"小饵鱼"
		OCEANFISH_SMALL_4 = "小鱼小虾，成不了大气候。",		-- 物品名:"三文鱼苗"
		OCEANFISH_SMALL_5 = "这是一道素菜",		-- 物品名:"爆米花鱼"
		OCEANFISH_SMALL_6 = "这是一道素菜",		-- 物品名:"落叶比目鱼"
		OCEANFISH_SMALL_7 = "这是一道素菜",		-- 物品名:"花朵金枪鱼"
		OCEANFISH_SMALL_8 = "烫得很呢！",		-- 物品名:"炽热太阳鱼"
        OCEANFISH_SMALL_9 = "只是随便说说，不过在下应该能让你派上用场……",		-- 物品名:"口水鱼"
		OCEANFISH_MEDIUM_1 = "清洗起来很麻烦的食材。",		-- 物品名:"泥鱼"
		OCEANFISH_MEDIUM_2 = "花大力气钓的。",		-- 物品名:"斑鱼"
		OCEANFISH_MEDIUM_3 = "风为在下带来了胜利！",		-- 物品名:"浮夸狮子鱼"
		OCEANFISH_MEDIUM_4 = "不知道这个会不会带来厄运。",		-- 物品名:"黑鲶鱼"
		OCEANFISH_MEDIUM_5 = "这条鱼看着有些俗气。",		-- 物品名:"玉米鳕鱼"
		OCEANFISH_MEDIUM_6 = "好一条大肥鱼！",		-- 物品名:"花锦鲤"
		OCEANFISH_MEDIUM_7 = "好一条大肥鱼！",		-- 物品名:"金锦鲤"
		OCEANFISH_MEDIUM_8 = "冰鲷鱼。",		-- 物品名:"冰鲷鱼"
        OCEANFISH_MEDIUM_9 = "成功钓鱼之旅的甜蜜味道。",		-- 物品名:"甜味鱼"
		PONDFISH = "在下现在要吃上一整天。",		-- 物品名:"淡水鱼"
		PONDEEL = "这能做一道好菜。",		-- 物品名:"活鳗鱼"
        FISHMEAT = "一块鱼肉。",		-- 物品名:"生鱼肉"
        FISHMEAT_COOKED = "烤得恰到好处。",		-- 物品名:"鱼排"
        FISHMEAT_SMALL = "一点点鱼肉。",		-- 物品名:"小鱼块"
        FISHMEAT_SMALL_COOKED = "小心鱼刺哦。",		-- 物品名:"熟小鱼块"
		SPOILED_FISH = "不能吃了哦。",		-- 物品名:"变质的鱼"
		FISH_BOX = "用来保鲜食材",		-- 物品名:"锡鱼罐" 制造描述:"保持鱼与网捕之日一样新鲜。"
        POCKET_SCALE = "称重装置。",		-- 物品名:"弹簧秤" 制造描述:"随时称鱼的重量！"
		TACKLECONTAINER = "不要落下东西哦。",		-- 物品名:"钓具箱" 制造描述:"整齐收纳你的钓具。"
		SUPERTACKLECONTAINER = "不要落下东西哦。",		-- 物品名:"超级钓具箱" 制造描述:"更多收纳钓具的空间？在下上钩了！"
		TROPHYSCALE_FISH =
		{
			GENERIC = "在下没有夸耀的意思。",		-- 物品名:"鱼类计重器"->默认 制造描述:"炫耀你的斩获。"
			HAS_ITEM = "重量: {weight}\n捕获人: {owner}",		-- 物品名:"鱼类计重器" 制造描述:"炫耀你的斩获。"
			HAS_ITEM_HEAVY = "重量: {weight}\n捕获人: {owner}\n收获颇丰",		-- 物品名:"鱼类计重器" 制造描述:"炫耀你的斩获。"
			BURNING = "风啊，快灭火！",		-- 物品名:"鱼类计重器"->正在燃烧 制造描述:"炫耀你的斩获。"
			BURNT = "前功尽弃！",		-- 物品名:"鱼类计重器"->烧焦的 制造描述:"炫耀你的斩获。"
			OWNER = "在下没有夸耀的意思……\n重量: {weight}\n捕获人: {owner}",		-- 物品名:"鱼类计重器" 制造描述:"炫耀你的斩获。"
			OWNER_HEAVY = "重量: {weight}\n捕获人: {owner}\n在下没有夸耀的意思",		-- 物品名:"鱼类计重器" 制造描述:"炫耀你的斩获。"
		},
		OCEANFISHABLEFLOTSAM = "有音乐藏在里面。",		-- 物品名:"海洋残骸"
		CALIFORNIAROLL = "细嚼慢咽。",		-- 物品名:"加州卷"
		SEAFOODGUMBO = "一大碗海鲜浓汤。",		-- 物品名:"海鲜浓汤"
		SURFNTURF = "太完美了！",		-- 物品名:"海鲜牛排"
        WOBSTER_SHELLER = "好一只调皮的龙虾。",		-- 物品名:"龙虾"
        WOBSTER_DEN = "一块石头，里面有龙虾。",		-- 物品名:"龙虾窝"
        WOBSTER_SHELLER_DEAD = "这烹饪出来应该挺不错的。",		-- 物品名:"死龙虾"
        WOBSTER_SHELLER_DEAD_COOKED = "奢华的料理。",		-- 物品名:"美味的龙虾"
        LOBSTERBISQUE = "可以再加点盐，但是不关在下的事。",		-- 物品名:"龙虾汤"
        LOBSTERDINNER = "奢华的料理。",		-- 物品名:"龙虾正餐"
        WOBSTER_MOONGLASS = "好一只调皮的月光龙虾。",		-- 物品名:"月光龙虾"
        MOONGLASS_WOBSTER_DEN = "一块月光玻璃，里面有月光龙虾。",		-- 物品名:"月光玻璃窝"
		TRIDENT = "不如在下的法杖",		-- 物品名:"刺耳三叉戟" 制造描述:"在汹涌波涛中引领潮流吧！"
		WINCH =
		{
			GENERIC = "这个在必要时能派上用场。",		-- 物品名:"夹夹绞盘"->默认 制造描述:"让它帮你捞起重的东西吧。"
			RETRIEVING_ITEM = "重活就交给它干吧。",		-- 物品名:"夹夹绞盘" 制造描述:"让它帮你捞起重的东西吧。"
			HOLDING_ITEM = "看看这里是什么东西？",		-- 物品名:"夹夹绞盘" 制造描述:"让它帮你捞起重的东西吧。"
		},
        HERMITHOUSE = 
        {
            GENERIC = "这是一座空壳房子。",		-- 物品名:"隐士之家"->默认
            BUILTUP = "它只需要一点点的爱。",		-- 物品名:"隐士之家"
        },
        SHELL_CLUSTER = "里面藏匿着音符。",		-- 物品名:"贝壳堆"
		SINGINGSHELL_OCTAVE3 =
		{
			GENERIC = "调有点低。",		-- 物品名:"低音贝壳钟"->默认
		},
		SINGINGSHELL_OCTAVE4 =
		{
			GENERIC = "这就是大海的声音吗？",		-- 物品名:"中音贝壳钟"->默认
		},
		SINGINGSHELL_OCTAVE5 =
		{
			GENERIC = "它可以发出高音C。",		-- 物品名:"高音贝壳钟"->默认
        },
        CHUM = "鱼儿的美味佳肴！",		-- 物品名:"鱼食" 制造描述:"鱼儿的美食。"
        SUNKENCHEST =
        {
            GENERIC = "真正的宝物是我们在寻宝过程中的成长。",		-- 物品名:"沉底宝箱"->默认
            LOCKED = "贝壳闭上了！",		-- 物品名:"沉底宝箱"->锁住了
        },
        HERMIT_BUNDLE = "非常感谢！",		-- 物品名:"一包谢意"
        HERMIT_BUNDLE_SHELLS = "非常感谢！",		-- 物品名:"贝壳钟包" 制造描述:"她卖的贝壳。"
        RESKIN_TOOL = "这也是魔法。",		-- 物品名:"清洁扫把" 制造描述:"把装潢的东西清扫的干干净净。"
        MOON_FISSURE_PLUGGED = "如此解决魔法问题……",		-- 物品名:"堵住的裂隙"
        WOBYBIG =
        {
            "OXO",		-- 物品名:"沃比" 制造描述:未找到
            " OXO ",		-- 物品名:"沃比" 制造描述:未找到
        },
        WOBYSMALL =
        {
            " OXO ",		-- 物品名:"沃比" 制造描述:未找到
            " OXO ",		-- 物品名:"沃比" 制造描述:未找到
        },
		WALTERHAT = "奇怪的帽子",		-- 物品名:"松树先锋队帽子" 制造描述:"形式和功能高于时尚。"
		SLINGSHOT = "调皮的孩子。",		-- 物品名:"可靠的弹弓" 制造描述:"不带它千万别去冒险！"
		SLINGSHOTAMMO_ROCK = "即将打出的弹药。",		-- 物品名:"鹅卵石" 制造描述:"简单，低效。"
		SLINGSHOTAMMO_MARBLE = "即将打出的弹药。",		-- 物品名:"大理石弹" 制造描述:"可别把它们弄丢了！"
		SLINGSHOTAMMO_THULECITE = "即将打出的弹药。",		-- 物品名:"诅咒弹药" 制造描述:"会出什么问题？"
        SLINGSHOTAMMO_GOLD = "即将打出的弹药。",		-- 物品名:"黄金弹药" 制造描述:"因为高级，所以有效。"
        SLINGSHOTAMMO_SLOW = "即将打出的弹药。",		-- 物品名:"减速弹药" 制造描述:"什么是“物理定律”？"
        SLINGSHOTAMMO_FREEZE = "即将打出的弹药。",		-- 物品名:"冰冻弹药" 制造描述:"把敌人冰冻在原地。"
		SLINGSHOTAMMO_POOP = "粪便弹道。",		-- 物品名:"便便弹" 制造描述:"恶心，但是能让敌人分心。"
        PORTABLETENT = "晚安哦，做个好梦吧",		-- 物品名:"宿营帐篷" 制造描述:"便捷的保护设备，让你免受风吹雨打。"
        PORTABLETENT_ITEM = "晚安哦，做个好梦吧。",		-- 物品名:"帐篷卷" 制造描述:"便捷的保护设备，让你免受风吹雨打。"
        BATTLESONG_DURABILITY = "非常感谢！",		-- 物品名:"武器化的颤音" 制造描述:"让武器有更多的时间成为焦点。"
        BATTLESONG_HEALTHGAIN = "非常感谢！",		-- 物品名:"心碎歌谣" 制造描述:"一首偷心的颂歌。"
        BATTLESONG_SANITYGAIN = "非常感谢！",		-- 物品名:"醍醐灌顶华彩" 制造描述:"用歌声慰藉你的心灵。"
        BATTLESONG_SANITYAURA = "非常感谢！",		-- 物品名:"英勇美声颂" 制造描述:"无所畏惧！"
        BATTLESONG_FIRERESISTANCE = "非常感谢！",		-- 物品名:"防火假声" 制造描述:"抵御火辣的戏评人。"
        BATTLESONG_INSTANT_TAUNT = "非常感谢！",		-- 物品名:"粗鲁插曲" 制造描述:"用言语扔一个番茄。"
        BATTLESONG_INSTANT_PANIC = "非常感谢！",		-- 物品名:"惊心独白" 制造描述:"如此出色的表演，就问你怕不怕。"
        MUTATOR_WARRIOR = "它们是你的伙伴吗？",		-- 物品名:"战士变身涂鸦" 制造描述:"做最可爱的小保镖。"
        MUTATOR_DROPPER = "它们是你的伙伴吗？",		-- 物品名:"悬蛛变身涂鸦" 制造描述:"味道也许会让你惊喜。"
        MUTATOR_HIDER = "它们是你的伙伴吗？",		-- 物品名:"洞穴变身涂鸦" 制造描述:"外酥里嫩。"
        MUTATOR_SPITTER = "它们是你的伙伴吗？",		-- 物品名:"喷吐变身涂鸦" 制造描述:"喷薄而出的蜘蛛形象。"
        MUTATOR_MOON = "它们是你的伙伴吗？",		-- 物品名:"破碎变身涂鸦" 制造描述:"吃到它的人会快乐到月球去！"
        MUTATOR_HEALER = "它们是你的伙伴吗？",		-- 物品名:"护士变身涂鸦" 制造描述:"特别多的谷物，所以必须是健康的！"
        SPIDER_WHISTLE = "它们是你的伙伴吗？",		-- 物品名:"韦伯口哨" 制造描述:"呼叫可怕的爬行动物朋友吧。"
        SPIDERDEN_BEDAZZLER = "它们是你的伙伴吗？",		-- 物品名:"蛛巢装饰套装" 制造描述:"一个好的家能培育出好的性格。"
        SPIDER_HEALER = "它们是你的伙伴吗？",		-- 物品名:"护士蜘蛛"
        SPIDER_REPELLENT = "它们是你的伙伴吗？",		-- 物品名:"驱赶盒子" 制造描述:"让你的朋友知道你需要一些空间。"
        SPIDER_HEALER_ITEM = "它们是你的伙伴吗？",		-- 物品名:"治疗黏团" 制造描述:"恶心，黏糊糊的，但对你有好处！"
		GHOSTLYELIXIR_SLOWREGEN = "一种亡灵魔法。",		-- 物品名:"亡者补药" 制造描述:"时间会抚平所有伤口。"
		GHOSTLYELIXIR_FASTREGEN = "一种亡灵魔法。",		-- 物品名:"灵魂万灵药" 制造描述:"治疗重伤的强力药剂。"
		GHOSTLYELIXIR_SHIELD = "一种亡灵魔法。",		-- 物品名:"不屈药剂" 制造描述:"保护你的姐妹不受伤害。"
		GHOSTLYELIXIR_ATTACK = "一种亡灵魔法。",		-- 物品名:"夜影万金油" 制造描述:"召唤黑暗的力量。"
		GHOSTLYELIXIR_SPEED = "一种亡灵魔法。",		-- 物品名:"强健精油" 制造描述:"给你的灵魂来一剂强心针。"
		GHOSTLYELIXIR_RETALIATION = "一种亡灵魔法。",		-- 物品名:"蒸馏复仇" 制造描述:"对敌人以牙还牙。"
		SISTURN =
		{
			GENERIC = "弄点花会显得更有生机。",		-- 物品名:"姐妹骨灰罐"->默认 制造描述:"让你疲倦的灵魂休息的地方。"
			SOME_FLOWERS = "多拿些花来应该就可以了。",		-- 物品名:"姐妹骨灰罐" 制造描述:"让你疲倦的灵魂休息的地方。"
			LOTS_OF_FLOWERS = "好美的花束！",		-- 物品名:"姐妹骨灰罐" 制造描述:"让你疲倦的灵魂休息的地方。"
		},
        WORTOX_SOUL = "only_used_by_wortox", --only wortox can inspect souls		-- 物品名:"灵魂"
        PORTABLECOOKPOT_ITEM =
        {
            GENERIC = "非常高超的料理水平",		-- 物品名:"便携烹饪锅"->默认 制造描述:"随时随地为美食家服务。"
            DONE = "非常高超的料理水平！",		-- 物品名:"便携烹饪锅"->完成了 制造描述:"随时随地为美食家服务。"
			COOKING_LONG = "非常高超的料理水平！",		-- 物品名:"便携烹饪锅"->饭还需要很久 制造描述:"随时随地为美食家服务。"
			COOKING_SHORT = "非常高超的料理水平！",		-- 物品名:"便携烹饪锅"->饭快做好了 制造描述:"随时随地为美食家服务。"
			EMPTY = "非常高超的料理水平！",		-- 物品名:"便携烹饪锅" 制造描述:"随时随地为美食家服务。"
        },
        PORTABLEBLENDER_ITEM = "非常高超的料理水平",		-- 物品名:"便携研磨器" 制造描述:"把原料研磨成粉状调味品。"
        PORTABLESPICER_ITEM =
        {
            GENERIC = "它可以给食物增添辛香风味。",		-- 物品名:"便携香料站"->默认 制造描述:"调味让饭菜更可口。"
            DONE = "应该能让饭菜更可口。",		-- 物品名:"便携香料站"->完成了 制造描述:"调味让饭菜更可口。"
        },
        SPICEPACK = "非常高超的料理水平！",		-- 物品名:"厨师袋" 制造描述:"使你的食物保持新鲜。"
        SPICE_GARLIC = "威力强大的粉末。",		-- 物品名:"蒜粉" 制造描述:"用口臭防守是最好的进攻。"
        SPICE_SUGAR = "甜！真甜！",		-- 物品名:"蜂蜜水晶" 制造描述:"令人心平气和的甜美。"
        SPICE_CHILI = "料理的魔法。",		-- 物品名:"辣椒面" 制造描述:"刺激十足的粉末。"
        SPICE_SALT = "料理的魔法。",		-- 物品名:"调味盐" 制造描述:"为你的饭菜加点咸味。"
        MONSTERTARTARE = "不能吃这个哦。",		-- 物品名:"怪物鞑靼"
        FRESHFRUITCREPES = "非常高超的料理水平！",		-- 物品名:"鲜果可丽饼"
        FROGFISHBOWL = "非常高超的料理水平！",		-- 物品名:"蓝带鱼排"
        POTATOTORNADO = "非常高超的料理水平！",		-- 物品名:"花式回旋块茎"
        DRAGONCHILISALAD = "非常高超的料理水平！",		-- 物品名:"辣龙椒沙拉"
        GLOWBERRYMOUSSE = "非常高超的料理水平！",		-- 物品名:"发光浆果慕斯"
        VOLTGOATJELLY = "非常高超的料理水平！",		-- 物品名:"伏特羊肉冻"
        NIGHTMAREPIE = "非常高超的料理水平！",		-- 物品名:"恐怖国王饼"
        BONESOUP = "非常高超的料理水平！",		-- 物品名:"骨头汤"
        MASHEDPOTATOES = "非常高超的料理水平！",		-- 物品名:"奶油土豆泥"
        POTATOSOUFFLE = "非常高超的料理水平！",		-- 物品名:"蓬松土豆蛋奶酥"
        MOQUECA = "非常高超的料理水平！",		-- 物品名:"海鲜杂烩"
        GAZPACHO = "非常高超的料理水平！",		-- 物品名:"芦笋冷汤"
        ASPARAGUSSOUP = "闻起来很好吃。",		-- 物品名:"芦笋汤"
        VEGSTINGER = "精神不好时来一杯",		-- 物品名:"蔬菜鸡尾酒"
        BANANAPOP = "适合夏天吃",		-- 物品名:"香蕉冻"
        CEVICHE = "吃得惯吗？",		-- 物品名:"酸橘汁腌鱼"
        SALSA = "真...辣...！",		-- 物品名:"生鲜萨尔萨酱"
        PEPPERPOPPER = "这么一大口！",		-- 物品名:"爆炒填馅辣椒"
        TURNIP = "是个生萝卜。",		-- 物品名:"大萝卜"
        TURNIP_COOKED = "很好吃哦。",		-- 物品名:"烤大萝卜"
        TURNIP_SEEDS = "一把古怪的种子。",		-- 物品名:"圆形种子"
        GARLIC = "吃完要刷牙哦。",		-- 物品名:"大蒜"
        GARLIC_COOKED = "吃完要刷牙哦。",		-- 物品名:"烤大蒜"
        GARLIC_SEEDS = "一把古怪的种子。",		-- 物品名:"种子荚"
        ONION = "看起来很脆。",		-- 物品名:"洋葱"
        ONION_COOKED = "一次成功的化学反应。",		-- 物品名:"烤洋葱"
        ONION_SEEDS = "一把古怪的种子。",		-- 物品名:"尖形种子"
        POTATO = "完美的食材。",		-- 物品名:"土豆"
        POTATO_COOKED = "完美的料理。",		-- 物品名:"烤土豆"
        POTATO_SEEDS = "一把古怪的种子。",		-- 物品名:"毛茸茸的种子"
        TOMATO = "很开胃。",		-- 物品名:"番茄"
        TOMATO_COOKED = "很开胃的料理。",		-- 物品名:"烤番茄"
        TOMATO_SEEDS = "一把古怪的种子。",		-- 物品名:"带刺的种子"
        ASPARAGUS = "一种蔬菜。",		-- 物品名:"芦笋"
        ASPARAGUS_COOKED = "很有营养的，多吃一点哦。",		-- 物品名:"烤芦笋"
        ASPARAGUS_SEEDS = "就是些种子。",		-- 物品名:"筒状种子"
        PEPPER = "好一个火辣辣的辣椒。",		-- 物品名:"辣椒"
        PEPPER_COOKED = "本来就是辣的。",		-- 物品名:"烤辣椒"
        PEPPER_SEEDS = "一把种子。",		-- 物品名:"块状种子"
        WEREITEM_BEAVER = "这是什么魔法？",		-- 物品名:"俗气海狸像" 制造描述:"唤醒海狸人的诅咒"
        WEREITEM_GOOSE = "这是什么魔法？",		-- 物品名:"俗气鹅像" 制造描述:"唤醒鹅人的诅咒"
        WEREITEM_MOOSE = "这是什么魔法？",		-- 物品名:"俗气鹿像" 制造描述:"唤醒鹿人的诅咒"
        MERMHAT = "OXO",		-- 物品名:"聪明的伪装" 制造描述:"鱼人化你的朋友。"
        MERMTHRONE =
        {
            GENERIC = "鱼人也有王吗？",		-- 物品名:"皇家地毯"->默认
            BURNT = "王朝陨落了。",		-- 物品名:"皇家地毯"->烧焦的
        },
        MERMTHRONE_CONSTRUCTION =
        {
            GENERIC = "她是个政治家",		-- 物品名:"皇家手工套装"->默认 制造描述:"建立一个新的鱼人王朝。"
            BURNT = "王朝陨落了。",		-- 物品名:"皇家手工套装"->烧焦的 制造描述:"建立一个新的鱼人王朝。"
        },
        MERMHOUSE_CRAFTED =
        {
            GENERIC = "样子还挺可爱的。",		-- 物品名:"鱼人工艺屋"->默认 制造描述:"适合鱼人的家。"
            BURNT = "悲伤的故事",		-- 物品名:"鱼人工艺屋"->烧焦的 制造描述:"适合鱼人的家。"
        },
        MERMWATCHTOWER_REGULAR = "他们找到了国王后高兴了起来。",		-- 物品名:"鱼人工艺屋" 制造描述:"适合鱼人的家。"
        MERMWATCHTOWER_NOKING = "皇帝守卫没有皇帝可以守卫。",		-- 物品名:"鱼人工艺屋" 制造描述:"适合鱼人的家。"
        MERMKING = "国王陛下！",		-- 物品名:"鱼人之王"
        MERMGUARD = "在他们周围感觉受到了护卫……",		-- 物品名:"忠诚鱼人守卫"
        MERM_PRINCE = "他们遵循先到先得的规矩。",		-- 物品名:"过程中的皇室"
        SQUID = "在下有预感会派上用场。",		-- 物品名:"鱿鱼"
		GHOSTFLOWER = "某种亡灵魔法。",		-- 物品名:"哀悼荣耀"
        SMALLGHOST = "嗷，你是不是个小可爱啊？",		-- 物品名:"小惊吓"
        CRABKING =
        {
            GENERIC = "非常感蟹。",		-- 物品名:"帝王蟹"->默认
            INERT = "非常感蟹。",		-- 物品名:"帝王蟹"
        },
		CRABKING_CLAW = "警惕蟹爪！",		-- 物品名:"巨钳"
		MESSAGEBOTTLE = "宝物或是思恋！",		-- 物品名:"瓶中信"
		MESSAGEBOTTLEEMPTY = "空无一物。",		-- 物品名:"空瓶子"
        MEATRACK_HERMIT =
        {
            DONE = "风的料理完成了！",		-- 物品名:"晾肉架"->完成了
            DRYING = "风正在料理它。",		-- 物品名:"晾肉架"->正在风干
            DRYINGINRAIN = "风的料理受阻了。",		-- 物品名:"晾肉架"->雨天风干
            GENERIC = "这是风的厨具。",		-- 物品名:"晾肉架"->默认
            BURNT = "风的厨具坏掉了。",		-- 物品名:"晾肉架"->烧焦的
            DONE_NOTMEAT = "这是风的厨具。",		-- 物品名:"晾肉架"
            DRYING_NOTMEAT = "这是风的厨具。",		-- 物品名:"晾肉架"
            DRYINGINRAIN_NOTMEAT = "风的料理受阻了。",		-- 物品名:"晾肉架"
        },
        BEEBOX_HERMIT =
        {
            READY = "它里面装满了蜂蜜。",		-- 物品名:"蜂箱"->准备好的 满的
            FULLHONEY = "它里面装满了蜂蜜。",		-- 物品名:"蜂箱"->蜂蜜满了
            GENERIC = "不知道里面有没有些许甜蜜。",		-- 物品名:"蜂箱"->默认
            NOHONEY = "它是空的。",		-- 物品名:"蜂箱"->没有蜂蜜
            SOMEHONEY = "我会陪你一起等的。",		-- 物品名:"蜂箱"->有一些蜂蜜
            BURNT = "怎么被烧掉的？！！",		-- 物品名:"蜂箱"->烧焦的
        },
        HERMITCRAB = "一个人住多少会寂寞吧。",		-- 物品名:"寄居蟹隐士"
        HERMIT_PEARL = "在下会照顾好它。",		-- 物品名:"珍珠的珍珠"
        HERMIT_CRACKED_PEARL = "在下……没有照顾好它。",		-- 物品名:"开裂珍珠"
        WATERPLANT = "只要我们不拿它们的藤壶，它们就会跟我们做朋友。",		-- 物品名:"海草"
        WATERPLANT_BOMB = "是种子啊！",		-- 物品名:"种壳"
        WATERPLANT_BABY = "还在萌芽阶段。",		-- 物品名:"海芽"
        WATERPLANT_PLANTER = "它们在大海中的岩石上长的最好。",		-- 物品名:"海芽插穗"
        SHARK = "我们可能需要一艘更大的船……",		-- 物品名:"岩石大白鲨"
        MASTUPGRADE_LAMP_ITEM = "看清海上的风。",		-- 物品名:"甲板照明灯" 制造描述:"桅杆照明附件。"
        MASTUPGRADE_LIGHTNINGROD_ITEM = "它掌握着闪电的魔法！",		-- 物品名:"避雷导线" 制造描述:"为你的桅杆带来过电般的刺激。"
        WATERPUMP = "可以非常有效的灭火。",		-- 物品名:"消防泵" 制造描述:"水水水，到处都是水！"
        BARNACLE = "好吃。",		-- 物品名:"藤壶"
        BARNACLE_COOKED = "在下听说这是一道珍馐美味。",		-- 物品名:"熟藤壶"
        BARNACLEPITA = "你看不见它们是藤壶的时候，它们的味道会更好。",		-- 物品名:"藤壶皮塔饼"
        BARNACLESUSHI = "美味的东方料理。",		-- 物品名:"藤壶握寿司"
        BARNACLINGUINE = "冷了也很美味",		-- 物品名:"藤壶中细面"
        BARNACLESTUFFEDFISHHEAD = "吃得惯吗？",		-- 物品名:"酿鱼头"
        LEAFLOAF = "神秘叶子肉。",		-- 物品名:"叶肉糕"
        LEAFYMEATBURGER = "奇怪的料理。",		-- 物品名:"素食堡"
        LEAFYMEATSOUFFLE = "奇怪的料理，但能治愈我们的心灵",		-- 物品名:"果冻沙拉"
        MEATYSALAD = "奇怪的料理，但能治愈我们的创伤。",		-- 物品名:"牛肉绿叶菜"
		MOLEBAT = "一只标准的小吸血鬼。",		-- 物品名:"裸鼹蝠"
        MOLEBATHILL = "不知道那个老鼠窝里藏了什么。",		-- 物品名:"裸鼹蝠丘"
        BATNOSE = "有人知道这是谁的鼻子吗？",		-- 物品名:"裸露鼻孔"
        BATNOSE_COOKED = "出来的时候，闻到的是鼻子的味道。",		-- 物品名:"炭烤鼻孔"
        BATNOSEHAT = "在下好像没被别人喂过奶。",		-- 物品名:"牛奶帽"
        MUSHGNOME = "它有一点危险",		-- 物品名:"蘑菇地精"
        SPORE_MOON = "在下要尽量离这些孢子远一点。",		-- 物品名:"月亮孢子"
        MOON_CAP = "看起来不怎么好吃。",		-- 物品名:"月亮蘑菇"
        MOON_CAP_COOKED = "这真的算料理吗？",		-- 物品名:"熟月亮蘑菇"
        MUSHTREE_MOON = "这颗蘑菇树明显跟其他的有异。",		-- 物品名:"月亮蘑菇树"
        LIGHTFLIER = "发光的小精灵！",		-- 物品名:"球状光虫"
        GROTTO_POOL_BIG = "太阳照不到的地方月亮却可以。",		-- 物品名:"玻璃绿洲"
        GROTTO_POOL_SMALL = "太阳照不到的地方月亮却可以。",		-- 物品名:"小玻璃绿洲"
        DUSTMOTH = "守护知识的精灵。",		-- 物品名:"尘蛾"
        DUSTMOTHDEN = "它们在里面过得很舒服。",		-- 物品名:"整洁洞穴"
        ARCHIVE_LOCKBOX = "在下怎么把知识取出来呢？",		-- 物品名:"蒸馏的知识"
        ARCHIVE_CENTIPEDE = "你休想阻止在下和伙伴们！",		-- 物品名:"远古哨兵蜈蚣"
        ARCHIVE_CENTIPEDE_HUSK = "一堆旧零件。",		-- 物品名:"哨兵蜈蚣壳"
        ARCHIVE_COOKPOT =
        {
            COOKING_LONG = "这还需要一点时间。",		-- 物品名:"远古窑"->饭还需要很久
            COOKING_SHORT = "就快好了！",		-- 物品名:"远古窑"->饭快做好了
            DONE = "料理完成！",		-- 物品名:"远古窑"->完成了
            EMPTY = "它需要清洁",		-- 物品名:"远古窑"
            BURNT = "锅不是这么用的哦。",		-- 物品名:"远古窑"->烧焦的
        },
        ARCHIVE_MOON_STATUE = "光风霁月。",		-- 物品名:"远古月亮雕像"
        ARCHIVE_RUNE_STATUE =
        {
            LINE_1 = "如此多的知识，在下要是能看懂就好了！",		-- 物品名:"远古月亮符文石"->第一行
            LINE_2 = "这些标记看起来与其他废墟中的标记不同。",		-- 物品名:"远古月亮符文石"->第二行
            LINE_3 = "如此多的知识，在下要是能看懂就好了！",		-- 物品名:"远古月亮符文石"->第三行
            LINE_4 = "这些标记看起来与其他废墟中的标记不同。",		-- 物品名:"远古月亮符文石"->第四行
            LINE_5 = "如此多的知识，在下要是能看懂就好了！",		-- 物品名:"远古月亮符文石"->第五行
        },
        ARCHIVE_RESONATOR = 
        {
            GENERIC = "它能指引埋藏的秘密",		-- 物品名:"星象探测仪"->默认
            IDLE = "它似乎找到了什么。",		-- 物品名:"星象探测仪"
        },
        ARCHIVE_RESONATOR_ITEM = "月亮魔法与暗影魔法的结合",		-- 物品名:"星象探测仪" 制造描述:"它会出土什么秘密呢？"
        ARCHIVE_LOCKBOX_DISPENCER = 
        {
          POWEROFF = "要是有办法让它重新运作就好了……",		-- 物品名:"知识饮水机"
          GENERIC =  "它是一位值得在下尊敬的老师。",		-- 物品名:"知识饮水机"->默认
        },
        ARCHIVE_SECURITY_DESK = 
        {
            POWEROFF = "它已经失去了从前的作用。",		-- 物品名:"远古哨所"
            GENERIC = "它想亲近在下。",		-- 物品名:"远古哨所"->默认
        },
        ARCHIVE_SECURITY_PULSE = "你这是要上哪去？是个有意思的地方吗？",		-- 物品名:"远古哨所"
        ARCHIVE_SWITCH = 
        {
            VALID = "这也是这个世界的暗影魔法吗？",		-- 物品名:"华丽基座"->有效
            GEMS = "这个插槽是空的。",		-- 物品名:"华丽基座"->需要宝石
        },
        ARCHIVE_PORTAL = 
        {
            POWEROFF = "一点反应都没。",		-- 物品名:"封印的传送门"
            GENERIC = "奇怪，电源是开着的，但它却没反应。",		-- 物品名:"封印的传送门"->默认
        },
        WALL_STONE_2 = "不错的墙。",		-- 物品名:"档案馆石墙"
        WALL_RUINS_2 = "一段古老的墙。",		-- 物品名:"档案馆铥墙"
        REFINED_DUST = "啊——嚏！",		-- 物品名:"尘土块" 制造描述:"远古甜品的关键原料。"
        DUSTMERINGUE = "可以喂给尘蛾",		-- 物品名:"琥珀美食"
        SHROOMCAKE = "果然名副其实。",		-- 物品名:"蘑菇蛋糕"
        NIGHTMAREGROWTH = "这些晶体值得引起我们的警惕。",		-- 物品名:"梦魇城墙"
        TURFCRAFTINGSTATION = "它也是一位老师",		-- 物品名:"土地夯实器" 制造描述:"一点点的改变世界。"
        MOON_ALTAR_LINK = "似乎在酝酿什么。",		-- 物品名:"神秘能量"
        COMPOSTINGBIN =
        {
            GENERIC = "用来施肥。",		-- 物品名:"堆肥桶"->默认 制造描述:"能让土壤变得臭烘烘和肥沃。"
            WET = "看起来太湿了。",		-- 物品名:"堆肥桶" 制造描述:"能让土壤变得臭烘烘和肥沃。"
            DRY = "嗯……太干了。",		-- 物品名:"堆肥桶" 制造描述:"能让土壤变得臭烘烘和肥沃。"
            BALANCED = "恰到好处！",		-- 物品名:"堆肥桶" 制造描述:"能让土壤变得臭烘烘和肥沃。"
            BURNT = "在下的肥料……",		-- 物品名:"堆肥桶"->烧焦的 制造描述:"能让土壤变得臭烘烘和肥沃。"
        },
        COMPOST = "植物的食物。",		-- 物品名:"堆肥"
        SOIL_AMENDER =
		{
			GENERIC = "在下不太懂它的原理。",		-- 物品名:"催长剂起子"->默认 制造描述:"海里来的瓶装养分。"
			STALE = "它在制造我们科学家所说的化学反应!",		-- 物品名:"催长剂起子"->过期了 制造描述:"海里来的瓶装养分。"
			SPOILED = "在下不太懂它的原理。",		-- 物品名:"催长剂起子"->腐烂了 制造描述:"海里来的瓶装养分。"
		},
		SOIL_AMENDER_FERMENTED = "在下不太懂它的原理。",		-- 物品名:"超级催长剂"
        WATERINGCAN =
        {
            GENERIC = "在下可以用这个给植物浇水。",		-- 物品名:"空浇水壶"->默认 制造描述:"让植物保持快乐和水分。"
            EMPTY = "也许这附近有个池塘...",		-- 物品名:"空浇水壶" 制造描述:"让植物保持快乐和水分。"
        },
        PREMIUMWATERINGCAN =
        {
            GENERIC = "植物们一定很喜欢它！",		-- 物品名:"空鸟嘴壶"->默认 制造描述:"灌溉方面的创新!"
            EMPTY = "没有水就没用了。",		-- 物品名:"空鸟嘴壶" 制造描述:"灌溉方面的创新!"
        },
		FARM_PLOW = "在亩躬耕。",		-- 物品名:"耕地机"
		FARM_PLOW_ITEM = "在亩躬耕。",		-- 物品名:"耕地机" 制造描述:"为你的植物犁一块地。"
		FARM_HOE = "面朝黄土背朝天。",		-- 物品名:"园艺锄" 制造描述:"翻耕，为撒播农作物做准备。"
		GOLDEN_FARM_HOE = "皇帝的工具",		-- 物品名:"黄金园艺锄" 制造描述:"优雅地耕地。"
		NUTRIENTSGOGGLESHAT = "真的需要这个吗？",		-- 物品名:"高级耕作先驱帽" 制造描述:"让你看到一个成功的花园。"
		PLANTREGISTRYHAT = "真的需要这个吗？",		-- 物品名:"耕作先驱帽" 制造描述:"让你的园艺专业知识得到增长。"
        FARM_SOIL_DEBRIS = "需要先铲掉这些",		-- 物品名:"农田杂物"
		FIRENETTLES = "如果你受不了热，就不要在花园里呆着。",		-- 物品名:"火荨麻叶"
		FORGETMELOTS = "OXO",		-- 物品名:"必忘我"
		SWEETTEA = "一杯好茶，让在下忘记所有的问题。",		-- 物品名:"舒缓茶"
		TILLWEED = "铲掉！",		-- 物品名:"犁地草"
		TILLWEEDSALVE = "痛痛飞走啦。",		-- 物品名:"犁地草膏" 制造描述:"慢慢去处病痛。"
        WEED_IVY = "铲掉！",		-- 物品名:"刺针旋花"
        IVY_SNARE = "放开我！",		-- 物品名:"缠绕根须"
		TROPHYSCALE_OVERSIZEDVEGGIES =
		{
			GENERIC = "一分耕耘一分收获。",		-- 物品名:"农产品秤"->默认 制造描述:"称量你珍贵的水果和蔬菜。"
			HAS_ITEM = "重量: {weight}\n收获日: {day}\n嘿嘿。",		-- 物品名:"农产品秤" 制造描述:"称量你珍贵的水果和蔬菜。"
			HAS_ITEM_HEAVY = "重量: {weight}\n收获日: {day}\n嘿嘿",		-- 物品名:"农产品秤" 制造描述:"称量你珍贵的水果和蔬菜。"
            HAS_ITEM_LIGHT = "抱歉，在下看不清。",		-- 物品名:"农产品秤" 制造描述:"称量你珍贵的水果和蔬菜。"
			BURNING = "这算是料理吗？",		-- 物品名:"农产品秤"->正在燃烧 制造描述:"称量你珍贵的水果和蔬菜。"
			BURNT = "糟糕的烹饪方式。",		-- 物品名:"农产品秤"->烧焦的 制造描述:"称量你珍贵的水果和蔬菜。"
        },
        CARROT_OVERSIZED = "一大堆的胡萝卜!",		-- 物品名:"巨型胡萝卜"
        CORN_OVERSIZED = "好大的玉米棒！",		-- 物品名:"巨型玉米"
        PUMPKIN_OVERSIZED = "好膨胀的南瓜啊。",		-- 物品名:"巨型南瓜"
        EGGPLANT_OVERSIZED = "大自然的强大生命力。",		-- 物品名:"巨型茄子"
        DURIAN_OVERSIZED = "大自然的强大生命力。",		-- 物品名:"巨型榴莲"
        POMEGRANATE_OVERSIZED = "这可能是在下见过的最大的石榴。",		-- 物品名:"巨型石榴"
        DRAGONFRUIT_OVERSIZED = "大自然的强大生命力。",		-- 物品名:"巨型火龙果"
        WATERMELON_OVERSIZED = "又大又多汁的西瓜。",		-- 物品名:"巨型西瓜"
        TOMATO_OVERSIZED = "一颗比例惊人的西红柿。",		-- 物品名:"巨型番茄"
        POTATO_OVERSIZED = "这土豆真大。",		-- 物品名:"巨型土豆"
        ASPARAGUS_OVERSIZED = "大自然的强大生命力。",		-- 物品名:"巨型芦笋"
        ONION_OVERSIZED = "大自然的强大生命力。。",		-- 物品名:"巨型洋葱"
        GARLIC_OVERSIZED = "巨大的大蒜！",		-- 物品名:"巨型大蒜"
        PEPPER_OVERSIZED = "一种大小相当不寻常的辣椒。",		-- 物品名:"巨型辣椒"
        VEGGIE_OVERSIZED_ROTTEN = "太浪费了。",		-- 物品名:"农产品秤" 制造描述:"称量你珍贵的水果和蔬菜。"
		FARM_PLANT =
		{
			GENERIC = "那是一株植物！",		-- 物品名:未找到
			SEED = "现在等着就好了。",		-- 物品名:未找到
			GROWING = "生长吧，美丽的造物，生长吧！",		-- 物品名:未找到
			FULL = "是时候收获的成果了。",		-- 物品名:未找到
			ROTTEN = "浪费了。",		-- 物品名:未找到
			FULL_OVERSIZED = "大自然的蓬勃生命力!",		-- 物品名:未找到
			ROTTEN_OVERSIZED = "太浪费了！",		-- 物品名:未找到
			FULL_WEED = "应该铲掉",		-- 物品名:未找到
			BURNING = "这对植物来说不是好事……",		-- 物品名:未找到
		},
        FRUITFLY = "讨厌的家伙！",		-- 物品名:"果蝇"
        LORDFRUITFLY = "翠绿之风，无往不利！",		-- 物品名:"果蝇王"
        FRIENDLYFRUITFLY = "它不是战利品，它是在下的伙伴。",		-- 物品名:"友好果蝇"
        FRUITFLYFRUIT = "它不是战利品，它是在下的伙伴。",		-- 物品名:"友好果蝇果"
        SEEDPOUCH = "合理的收纳。",		-- 物品名:"种子袋" 制造描述:"妥善保管好种子。"
		CARNIVAL_HOST = "在下不擅长应付他。",		-- 物品名:"良羽鸦"
		CARNIVAL_CROWKID = "日安，小精灵。",		-- 物品名:"小乌鸦"
		CARNIVAL_GAMETOKEN = "一枚闪亮的代币。",		-- 物品名:"鸦年华代币" 制造描述:"购买代币，玩游戏，赢取奖品！"
		CARNIVAL_PRIZETICKET =
		{
			GENERIC = "就是那张奖票！",		-- 物品名:"奖票"->默认
			GENERIC_SMALLSTACK = "就是那些奖票！",		-- 物品名:"奖票"
			GENERIC_LARGESTACK = "好多的奖票啊！",		-- 物品名:"奖票"
		},
		CARNIVALGAME_FEEDCHICKS_NEST = "这是一扇小活门。",		-- 物品名:"饥饿乌鸦"
		CARNIVALGAME_FEEDCHICKS_STATION =
		{
			GENERIC = "凭票入场。",		-- 物品名:"鸟鸟吃虫虫"->默认
			PLAYING = "这个看起来有趣喔！",		-- 物品名:"鸟鸟吃虫虫"
		},
		CARNIVALGAME_FEEDCHICKS_KIT = "这还真是个快闪嘉年华。",		-- 物品名:"鸟鸟吃虫虫套装" 制造描述:"小鸟吃虫！"
		CARNIVALGAME_FEEDCHICKS_FOOD = "这是什么？",		-- 物品名:"蛴螬"
		CARNIVALGAME_MEMORY_KIT = "这还真是个快闪嘉年华。",		-- 物品名:"篮中蛋套装" 制造描述:"在你的蛋孵化前数清楚数量。"
		CARNIVALGAME_MEMORY_STATION =
		{
			GENERIC = "凭票入场。",		-- 物品名:"篮中蛋"->默认
			PLAYING = "在下会努力的！",		-- 物品名:"篮中蛋"
		},
		CARNIVALGAME_MEMORY_CARD =
		{
			GENERIC = "这是一扇小活门。",		-- 物品名:"蛋篮"->默认
			PLAYING = "是它吗？",		-- 物品名:"蛋篮"
		},
		CARNIVALGAME_HERDING_KIT = "这还真是个快闪嘉年华。",		-- 物品名:"追蛋套装" 制造描述:"追回失控的蛋。"
		CARNIVALGAME_HERDING_STATION =
		{
			GENERIC = "凭票入场。",		-- 物品名:"追蛋"->默认
			PLAYING = "这些鸡蛋看起来想跑。",		-- 物品名:"追蛋"
		},
		CARNIVALGAME_HERDING_CHICK = "回来这！",		-- 物品名:"追蛋"
		CARNIVALGAME_SHOOTING_KIT = "这还真是个快闪嘉年华。",		-- 物品名:"保卫鸟巢套装" 制造描述:"防止害虫进入巢穴。"
		CARNIVALGAME_SHOOTING_STATION =
		{
			GENERIC = "凭票入场。",		-- 物品名:"保卫鸟巢"->默认
			PLAYING = "在下可以算出弹道，但这涉及到很多复杂的数字和演算。",		-- 物品名:"保卫鸟巢"
		},
		CARNIVALGAME_SHOOTING_TARGET =
		{
			GENERIC = "这是一扇小活门。",		-- 物品名:"射击靶"->默认
			PLAYING = "这个靶子让在下心痒痒了。",		-- 物品名:"射击靶"
		},
		CARNIVALGAME_SHOOTING_BUTTON =
		{
			GENERIC = "凭票入场。",		-- 物品名:"按钮"->默认
			PLAYING = "在下难以抵御它的诱惑",		-- 物品名:"按钮"
		},
		CARNIVALGAME_WHEELSPIN_KIT = "这还真是个快闪嘉年华。",		-- 物品名:"布谷鸟转盘套装" 制造描述:"旋转然后胜利。"
		CARNIVALGAME_WHEELSPIN_STATION =
		{
			GENERIC = "凭票入场。",		-- 物品名:"布谷鸟转盘"->默认
			PLAYING = "在下喜欢这个。",		-- 物品名:"布谷鸟转盘"
		},
		CARNIVALGAME_PUCKDROP_KIT = "这还真是个快闪嘉年华。",		-- 物品名:"鸟房落球套装" 制造描述:"把球安全地弹到它的窝里。"
		CARNIVALGAME_PUCKDROP_STATION =
		{
			GENERIC = "凭票入场。",		-- 物品名:"鸟房落球"->默认
			PLAYING = "成绩不好也不要灰心。",		-- 物品名:"鸟房落球"
		},
		CARNIVAL_PRIZEBOOTH_KIT = "真正的奖品是在下制作摊位的过程。",		-- 物品名:"奖品摊位套装" 制造描述:"看看有什么奖品。"
		CARNIVAL_PRIZEBOOTH =
		{
			GENERIC = "在下已经看到了在下想要的奖品。就是那边那个！",		-- 物品名:"奖品摊位"->默认
		},
		CARNIVALCANNON_KIT = "在下在把东西弄炸方面积累了丰富的经验。",		-- 物品名:"奖品摊位"
		CARNIVALCANNON =
		{
			GENERIC = "爆炸！",		-- 物品名:未找到
			COOLDOWN = "太炸了！",		-- 物品名:未找到
		},
		CARNIVAL_PLAZA_KIT = "飞鸟也需要栖木。",		-- 物品名:"鸦年华树苗" 制造描述:"鸦年华不可或缺的中间物件。"
		CARNIVAL_PLAZA =
		{
			GENERIC = "现在看没“鸦年华”的样子，对不对？",		-- 物品名:"鸦年华树"->默认
			LEVEL_2 = "一只小鸟告诉在下，这里要多放点装饰品。",		-- 物品名:"鸦年华树"
			LEVEL_3 = "这是一棵庆祝之树！",		-- 物品名:"鸦年华树"
		},
		CARNIVALDECOR_EGGRIDE_KIT = "希望奖品就只是这些。",		-- 物品名:"鸦年华树"
		CARNIVALDECOR_EGGRIDE = "在下可以几个小时一直盯着它看。",		-- 物品名:"鸦年华树"
		CARNIVALDECOR_LAMP_KIT = "光剩下一点工作了。",		-- 物品名:"盛夏夜灯套装" 制造描述:"夏夜的梦幻之光。"
		CARNIVALDECOR_LAMP = "它的能量来自于奇思妙想。",		-- 物品名:"盛夏夜灯"
		CARNIVALDECOR_PLANT_KIT = "也许这是一棵黄杨？",		-- 物品名:"微型树套装" 制造描述:"一小块鸦年华。"
		CARNIVALDECOR_PLANT = "它年纪尚小。",		-- 物品名:"微型树"
		CARNIVALDECOR_BANNER_KIT = "在下必须自己建造它？ ",		-- 物品名:"光线捕捉器套装" 制造描述:"枝头挂着闪光的小饰品。"
		CARNIVALDECOR_BANNER = "这些闪亮的装饰品已经说明了一切。",		-- 物品名:"光线捕捉器"
		CARNIVALDECOR_FIGURE =
		{
			RARE = "千锤百炼，精益求精",		-- 物品名:未找到
			UNCOMMON = "这种设计不是很常见。",		-- 物品名:未找到
			GENERIC = "在下怎么弄到这么多的这些东西……",		-- 物品名:未找到
		},
		CARNIVALDECOR_FIGURE_KIT = "探索的刺激！",		-- 物品名:"绿色神秘盒子" 制造描述:"这个神秘的绿盒子里会有什么呢？"
		CARNIVALDECOR_FIGURE_KIT_SEASON2 = "探索的刺激！",		-- 物品名:"金色神秘盒子" 制造描述:"这个神秘的金盒子里会有什么呢？"
        CARNIVAL_BALL = "惹人爱的小物件。", --unimplemented		-- 物品名:"发光红球" 制造描述:"保证你有球必应！"
		CARNIVAL_SEEDPACKET = "在下觉得有点饿了。",		-- 物品名:"种子包" 制造描述:"鸦年华最爱的香脆小吃。"
		CARNIVALFOOD_CORNTEA = "这种饮料本该这么松脆吗？",		-- 物品名:"玉米泥" 制造描述:"出乎意料的清爽！"
        CARNIVAL_VEST_A = "这让在下看起来很有冒险精神。",		-- 物品名:"叽叽喳喳围巾" 制造描述:"用捡来的树叶做成的异想天开的围巾。"
        CARNIVAL_VEST_B = "就像穿上了自己专属的树荫。",		-- 物品名:"叽叽喳喳斗篷" 制造描述:"这东西确实值得称道。"
        CARNIVAL_VEST_C = "希望这里头没虫子……",		-- 物品名:"叽叽喳喳小披肩" 制造描述:"鸦年华游客的必备小披肩。"
        YOTB_SEWINGMACHINE = "在下很需要这个！",		-- 物品名:"缝纫机"
        YOTB_SEWINGMACHINE_ITEM = "看来需要组装一下。",		-- 物品名:"缝纫机套装" 制造描述:"做出完美的皮弗娄牛礼服吧。"
        YOTB_STAGE = "奇怪啊，在下没见到他登台和离开……",		-- 物品名:"裁判席"
        YOTB_POST =  "这场比赛将会顺利进行！",		-- 物品名:"皮弗娄牛舞台"
        YOTB_STAGE_ITEM = "看起来要搭建一下才行。",		-- 物品名:"裁判席" 制造描述:"邀请专家出席。"
        YOTB_POST_ITEM =  "在下最好先装好它。",		-- 物品名:"皮弗娄牛舞台" 制造描述:"让你的皮弗娄牛登上舞台中央。"
        YOTB_PATTERN_FRAGMENT_1 = "在下很擅长缝纫。",		-- 物品名:"恐怖款式碎片" 制造描述:"来一点恐怖的灵感。"
        YOTB_PATTERN_FRAGMENT_2 = "在下很擅长缝纫。",		-- 物品名:"正式款式碎片" 制造描述:"来一点正式的灵感。"
        YOTB_PATTERN_FRAGMENT_3 = "在下很擅长缝纫。",		-- 物品名:"喜庆款式碎片" 制造描述:"来一点喜庆的灵感。"
        YOTB_BEEFALO_DOLL_WAR = 
        {
            GENERIC = "好可爱。",		-- 物品名:"战士皮弗娄牛玩偶"->默认
            YOTB = "好可爱",		-- 物品名:"战士皮弗娄牛玩偶"
        },
        YOTB_BEEFALO_DOLL_DOLL = 
        {
            GENERIC = "好可爱。",		-- 物品名:"娃娃皮弗娄牛玩偶"->默认
            YOTB = "好可爱",		-- 物品名:"娃娃皮弗娄牛玩偶"
        },
        YOTB_BEEFALO_DOLL_FESTIVE = 
        {
            GENERIC = "好可爱。",		-- 物品名:"喜庆皮弗娄牛玩偶"->默认
            YOTB = "好可爱",		-- 物品名:"喜庆皮弗娄牛玩偶"
        },
        YOTB_BEEFALO_DOLL_NATURE = 
        {
            GENERIC = "好可爱",		-- 物品名:"花朵皮弗娄牛玩偶"->默认
            YOTB = "好可爱",		-- 物品名:"花朵皮弗娄牛玩偶"
        },
        YOTB_BEEFALO_DOLL_ROBOT = 
        {
            GENERIC = "好可爱",		-- 物品名:"铁甲皮弗娄牛玩偶"->默认
            YOTB = "好可爱",		-- 物品名:"铁甲皮弗娄牛玩偶"
        },
        YOTB_BEEFALO_DOLL_ICE = 
        {
            GENERIC = "好可爱。",		-- 物品名:"寒霜皮弗娄牛玩偶"->默认
            YOTB = "不好可爱",		-- 物品名:"寒霜皮弗娄牛玩偶"
        },
        YOTB_BEEFALO_DOLL_FORMAL = 
        {
            GENERIC = "好可爱。",		-- 物品名:"正式皮弗娄牛玩偶"->默认
            YOTB = "好可爱。",		-- 物品名:"正式皮弗娄牛玩偶"
        },
        YOTB_BEEFALO_DOLL_VICTORIAN = 
        {
            GENERIC = "好可爱。",		-- 物品名:"维多利亚皮弗娄牛玩偶"->默认
            YOTB = "好可爱。",		-- 物品名:"维多利亚皮弗娄牛玩偶"
        },
        YOTB_BEEFALO_DOLL_BEAST = 
        {
            GENERIC = "好可爱。",		-- 物品名:"幸运兽弗娄牛玩偶"->默认
            YOTB = "好可爱。",		-- 物品名:"幸运兽弗娄牛玩偶"
        },
        WAR_BLUEPRINT = "多么威猛！",		-- 物品名:"战士礼服款式"
        DOLL_BLUEPRINT = "在下的牛牛一定会可爱动人！",		-- 物品名:"娃娃礼服款式"
        FESTIVE_BLUEPRINT = "是时候来点节庆活动了！",		-- 物品名:"节日盛装款式"
        ROBOT_BLUEPRINT = "这还算是缝纫吗？。",		-- 物品名:"铁甲礼服款式"
        NATURE_BLUEPRINT = "花朵真是百搭。",		-- 物品名:"花朵礼服款式"
        FORMAL_BLUEPRINT = "在下的作品。",		-- 物品名:"正式礼服款式"
        VICTORIAN_BLUEPRINT = "在下喜欢这件。",		-- 物品名:"维多利亚礼服款式"
        ICE_BLUEPRINT = "牛牛会冷吗？",		-- 物品名:"寒霜礼服款式"
        BEAST_BLUEPRINT = "要走运了！",		-- 物品名:"幸运兽礼服款式"
        BEEF_BELL = "它能让在下和牛牛交朋友。",		-- 物品名:"皮弗娄牛铃" 制造描述:"与皮弗娄牛交朋友。"
		KITCOONDEN =
		{
			GENERIC = "个头够小才能藏在里面。",		-- 物品名:"小浣猫托儿所"->默认
            BURNT = "不！",		-- 物品名:"小浣猫托儿所"->烧焦的
			PLAYING_HIDEANDSEEK = "它们去了哪里呢……",		-- 物品名:"小浣猫托儿所"
			PLAYING_HIDEANDSEEK_TIME_ALMOST_UP = "剩下的时间不多了！它们在哪？！",		-- 物品名:"小浣猫托儿所"
		},
		KITCOONDEN_KIT = "一套都在这了。",		-- 物品名:"小浣猫托儿所套装" 制造描述:"各种条纹浣猫的家园。"
		TICOON =
		{
			GENERIC = "他看起来好像知道自己在做什么！",		-- 物品名:"大虎"->默认
			ABANDONED = "在下一定能靠自己找到它们。",		-- 物品名:"大虎"
			SUCCESS = "嘿，他找到了一个！",		-- 物品名:"大虎"
			LOST_TRACK = "有人先发现了它们。",		-- 物品名:"大虎"
			NEARBY = "看起来附近有东西。",		-- 物品名:"大虎"
			TRACKING = "在下应该紧跟他的步伐。",		-- 物品名:"大虎"
			TRACKING_NOT_MINE = "他在为我们引路。",		-- 物品名:"大虎"
			NOTHING_TO_TRACK = "看起来没有什么可找的了。",		-- 物品名:"大虎"
			TARGET_TOO_FAR_AWAY = "它们可能离得太远，他嗅不到味道。",		-- 物品名:"大虎"
		},
		YOT_CATCOONSHRINE =
        {
            GENERIC = "做什么呢……",		-- 物品名:"浣猫神龛"->默认 制造描述:"供奉无踪之浣猫。"
            EMPTY = "也许它想弄根羽毛来玩玩……",		-- 物品名:"浣猫神龛" 制造描述:"供奉无踪之浣猫。"
            BURNT = "闻起来像烧焦的毛皮。",		-- 物品名:"浣猫神龛"->烧焦的 制造描述:"供奉无踪之浣猫。"
        },
		KITCOON_FOREST = "你就是最可爱的小猫咪！",		-- 物品名:"小浣猫"
		KITCOON_SAVANNA = "你就是最可爱的小猫咪！",		-- 物品名:"小浣猫"
		KITCOON_MARSH = "在下必须多收集点",		-- 物品名:"小浣猫"
		KITCOON_DECIDUOUS = "你就是最可爱的小猫咪！",		-- 物品名:"小浣猫"
		KITCOON_GRASS = "你就是最可爱的小猫咪！",		-- 物品名:"小浣猫"
		KITCOON_ROCKY = "在下必须多收集点",		-- 物品名:"小浣猫"
		KITCOON_DESERT = "在下必须多收集点",		-- 物品名:"小浣猫"
		KITCOON_MOON = "在下必须多收集点",		-- 物品名:"小浣猫"
		KITCOON_YOT = "在下必须多收集点",		-- 物品名:"小浣猫"
        ALTERGUARDIAN_PHASE1 = 
        {
            GENERIC = "翠绿之风，无往不利！",		-- 物品名:"天体英雄"->默认
            DEAD = "胜利之风伴随我们！",		-- 物品名:"天体英雄"->死了
        },
        ALTERGUARDIAN_PHASE2 = 
        {
            GENERIC = "狂风啊，怒号吧！",		-- 物品名:"天体英雄"->默认
            DEAD = "胜利之风伴随我们！",		-- 物品名:"天体英雄"->死了
        },
        ALTERGUARDIAN_PHASE2SPIKE = "小心！",		-- 物品名:"月光玻璃尖刺"
        ALTERGUARDIAN_PHASE3 = "狂风啊，怒号吧！",		-- 物品名:"天体英雄"
        ALTERGUARDIAN_PHASE3TRAP = "在下……还不能……休息。",		-- 物品名:"启迪陷阱"
        ALTERGUARDIAN_PHASE3DEADORB = "胜利之风伴随我们！",		-- 物品名:"天体英雄"
        ALTERGUARDIAN_PHASE3DEAD = "胜利之风伴随我们！",		-- 物品名:"被击败的天体英雄"
        ALTERGUARDIANHAT = "与在下一起度过永劫",		-- 物品名:"启迪之冠"
        ALTERGUARDIANHATSHARD = "好漂亮。",		-- 物品名:"启迪碎片"
        MOONSTORM_GLASS = 
        {
            GENERIC = "它的能量在不断流逝。",		-- 物品名:"充能玻璃石"->默认
            INFUSED = "它焕发着月亮魔法。"		-- 物品名:"充能玻璃石"
        },
        MOONSTORM_STATIC = "这是科学还是魔法？",		-- 物品名:"能量静电"
        MOONSTORM_STATIC_ITEM = "这是科学还是魔法？",		-- 物品名:"约束静电"
        MOONSTORM_SPARK = "它蕴含着风险与机遇",		-- 物品名:"月熠"
        BIRD_MUTANT = "在下觉得那个以前应该是只乌鸦。",		-- 物品名:"月盲乌鸦"
        BIRD_MUTANT_SPITTER = "在下不喜欢它盯着在下的眼神……",		-- 物品名:"奇形鸟"
        WAGSTAFF_NPC = "它可以帮助科学家先生！",		-- 物品名:"颗粒状传输"
        WAGSTAFF_NPC_MUTATIONS = "它可以帮助科学家先生！",		-- 物品名:"颗粒状传输"
        WAGSTAFF_NPC_WAGPUNK = "他到底上哪去了……",		-- 物品名:"充能玻璃石"
        ALTERGUARDIAN_CONTAINED = "它正在吸收月亮的魔法！",		-- 物品名:"月亮精华提取器"
        WAGSTAFF_TOOL_1 = "它可以帮助科学家先生！",		-- 物品名:"网状缓冲器"
        WAGSTAFF_TOOL_2 = "它可以帮助科学家先生！",		-- 物品名:"装置除垢器"
        WAGSTAFF_TOOL_3 = "它可以帮助科学家先生！！",		-- 物品名:"垫圈开槽器"
        WAGSTAFF_TOOL_4 = "它可以帮助科学家先生！",		-- 物品名:"概念刷洗器"
        WAGSTAFF_TOOL_5 = "它可以帮助科学家先生！",		-- 物品名:"校准观察机"
        MOONSTORM_GOGGLESHAT = "土豆不只是完美食材",		-- 物品名:"星象护目镜" 制造描述:"利用土豆之眼来看清风暴。"
        MOON_DEVICE = 
        {
            GENERIC = "它在捕捉月亮魔法。",		-- 物品名:"月亮虹吸器"->默认
            CONSTRUCTION1 = "它在捕捉月亮魔法。",		-- 物品名:"月亮虹吸器"
            CONSTRUCTION2 = "它在捕捉月亮魔法",		-- 物品名:"月亮虹吸器"
        },
        POCKETWATCH_HEAL = 
        {
			GENERIC = "这似乎是这个世界的暗影魔法。",		-- 物品名:"不老表"->默认 制造描述:"你觉得自己是几岁，你就是几岁。"
			RECHARGING = "这似乎是这个世界的暗影魔法。",		-- 物品名:"不老表" 制造描述:"你觉得自己是几岁，你就是几岁。"
		},
        POCKETWATCH_REVIVE = 
        {
			GENERIC = "这似乎是这个世界的暗影魔法。",		-- 物品名:"第二次机会表"->默认 制造描述:"挽回一个朋友的不幸结局。"
			RECHARGING = "这似乎是这个世界的暗影魔法。",		-- 物品名:"第二次机会表" 制造描述:"挽回一个朋友的不幸结局。"
		},
        POCKETWATCH_WARP = 
        {
			GENERIC = "这似乎是这个世界的暗影魔法。",		-- 物品名:"倒走表"->默认 制造描述:"重走你的最后几步。"
			RECHARGING = "这似乎是这个世界的暗影魔法",		-- 物品名:"倒走表" 制造描述:"重走你的最后几步。"
		},
        POCKETWATCH_RECALL = 
        {
			GENERIC = "这似乎是这个世界的暗影魔法",		-- 物品名:"溯源表"->默认 制造描述:"返回到一个遥远的时间点。"
			RECHARGING = "这似乎是这个世界的暗影魔法",		-- 物品名:"溯源表" 制造描述:"返回到一个遥远的时间点。"
			UNMARKED = "only_used_by_wanda",		-- 物品名:"溯源表" 制造描述:"返回到一个遥远的时间点。"
			MARKED_SAMESHARD = "only_used_by_wanda",		-- 物品名:"溯源表" 制造描述:"返回到一个遥远的时间点。"
			MARKED_DIFFERENTSHARD = "only_used_by_wanda",		-- 物品名:"溯源表" 制造描述:"返回到一个遥远的时间点。"
		},
        POCKETWATCH_PORTAL = 
        {
			GENERIC = "这似乎是这个世界的暗影魔法",		-- 物品名:"裂缝表"->默认 制造描述:"和朋友一起穿越时间会更好。"
			RECHARGING = "这似乎是这个世界的暗影魔法",		-- 物品名:"裂缝表" 制造描述:"和朋友一起穿越时间会更好。"
			UNMARKED = "only_used_by_wanda unmarked",		-- 物品名:"裂缝表" 制造描述:"和朋友一起穿越时间会更好。"
			MARKED_SAMESHARD = "only_used_by_wanda other shard",		-- 物品名:"裂缝表" 制造描述:"和朋友一起穿越时间会更好。"
			MARKED_DIFFERENTSHARD = "only_used_by_wanda other shard",		-- 物品名:"裂缝表" 制造描述:"和朋友一起穿越时间会更好。"
		},
        POCKETWATCH_WEAPON = 
        {
			GENERIC = "这似乎是这个世界的暗影魔法",		-- 物品名:"警钟"->默认 制造描述:"这只钟敲的就是你。"
			DEPLETED = "only_used_by_wanda",		-- 物品名:"警钟" 制造描述:"这只钟敲的就是你。"
		},
        POCKETWATCH_PARTS = "这似乎是这个世界的暗影魔法",		-- 物品名:"时间碎片" 制造描述:"计时必备零件。"
        POCKETWATCH_DISMANTLER = "这似乎是这个世界的暗影魔法",		-- 物品名:"钟表匠工具" 制造描述:"修补计时装置。"
        POCKETWATCH_PORTAL_ENTRANCE =
		{
			GENERIC = "这似乎是这个世界的暗影魔法",		-- 物品名:"时间裂缝"->默认
			DIFFERENTSHARD = "这似乎是这个世界的暗影魔法",		-- 物品名:"时间裂缝"
		},
        POCKETWATCH_PORTAL_EXIT = "这似乎是这个世界的暗影魔法。",		-- 物品名:"时间裂缝"
        WATERTREE_PILLAR = "好大一棵树！",		-- 物品名:"大树干"
        OCEANTREE = "这些树应该是迷路了。",		-- 物品名:"疙瘩树"
        OCEANTREENUT = "里面有活着的东西。",		-- 物品名:"疙瘩树果"
        WATERTREE_ROOT = "惊人的大自然。",		-- 物品名:"大树根"
        OCEANTREE_PILLAR = "惊人的大自然。",		-- 物品名:"高出平均值的树干"
        OCEANVINE = "它需要时间和风。",		-- 物品名:"苔藓藤条"
        FIG = "不错的食材。",		-- 物品名:"无花果"
        FIG_COOKED = "不错的料理。",		-- 物品名:"熟无花果"
        SPIDER_WATER = "蜘蛛走开！",		-- 物品名:"海黾"
        MUTATOR_WATER = "它们是你的伙伴吗？",		-- 物品名:"海黾变身涂鸦" 制造描述:"光是看就让人流口水！"
        OCEANVINE_COCOON = "最好是不要靠近哦",		-- 物品名:"海黾巢穴"
        OCEANVINE_COCOON_BURNT = "没想到这个可以被点燃。",		-- 物品名:"海黾巢穴"
        GRASSGATOR = "它只是有点害羞。",		-- 物品名:"草鳄鱼"
        TREEGROWTHSOLUTION = "嗯，树木的食粮！",		-- 物品名:"树果酱" 制造描述:"鼓励树木到达新的高度。"
        FIGATONI = "多吃点哦！",		-- 物品名:"无花果意面"
        FIGKABAB = "简单的美味。",		-- 物品名:"无花果烤串"
        KOALEFIG_TRUNK = "这个很有营养的，多吃一点哦。",		-- 物品名:"无花果酿象鼻"
        FROGNEWTON = "无花果有效弥合了其他食材的味道。",		-- 物品名:"无花果蛙腿三明治"
        TERRARIUM = 
        {
            GENERIC = "它和在下一样不属于这个世界。",		-- 物品名:"盒中泰拉"->默认
            CRIMSON = "它和在下一样不属于这个世界。",		-- 物品名:"盒中泰拉"
            ENABLED = "它和在下一样不属于这个世界。",		-- 物品名:"盒中泰拉"
			WAITING_FOR_DARK = "它和在下一样不属于这个世界。",		-- 物品名:"盒中泰拉"
			COOLDOWN = "这之后需要冷却一下。",		-- 物品名:"盒中泰拉"->冷却中
			SPAWN_DISABLED = "它和在下一样不属于这个世界。。",		-- 物品名:"盒中泰拉"
        },
        MIGHTY_GYM =
        {
            GENERIC = "加油，大力士先生！",		-- 物品名:"强大健身房"->默认 制造描述:"拿出力量来吧！"
            BURNT = "别伤心，大力士先生！",		-- 物品名:"强大健身房"->烧焦的 制造描述:"拿出力量来吧！"
        },
        DUMBBELL = "加油，大力士先生！",		-- 物品名:"哑铃" 制造描述:"练肌肉离不开棍棒和石头。"
        DUMBBELL_GOLDEN = "精诚所至，金石为开。",		-- 物品名:"黄金哑铃" 制造描述:"举重的黄金标准。"
		DUMBBELL_MARBLE = "加油，大力士先生！",		-- 物品名:"大理石哑铃" 制造描述:"获得有棱有角体格的捷径。"
        DUMBBELL_GEM = "这加油，大力士先生！",		-- 物品名:"宝石哑铃" 制造描述:"让你锻炼的方方面面都得到打磨。"
        POTATOSACK = "加油，大力士先生！",		-- 物品名:"土豆袋" 制造描述:"马铃薯的天然栖息地。"
        DUMBBELL_HEAT = "加油，大力士先生！",		-- 物品名:"热铃" 制造描述:"进行终极热身。"
        DUMBBELL_REDGEM = "加油，大力士先生！",		-- 物品名:"火铃" 制造描述:"感受燃烧！"
        DUMBBELL_BLUEGEM = "加油，大力士先生！",		-- 物品名:"冰铃" 制造描述:"冰封妨碍锻炼的东西。"
        TERRARIUMCHEST =
		{
			GENERIC = "它和在下一样不属于这个世界。",		-- 物品名:"显眼箱子"->默认
			BURNT = "它和在下一样不属于这个世界。",		-- 物品名:"显眼箱子"->烧焦的
			SHIMMER = "它和在下一样不属于这个世界。",		-- 物品名:"显眼箱子"
		},
		EYEMASKHAT = "它和在下一样不属于这个世界。",		-- 物品名:"眼面具"
        EYEOFTERROR = "它和在下一样不属于这个世界。",		-- 物品名:"恐怖之眼"
        EYEOFTERROR_MINI = "它和在下一样不属于这个世界。",		-- 物品名:"可疑窥视者"
        EYEOFTERROR_MINI_GROUNDED = "它就要孵化了",		-- 物品名:"恐怖之蛋"
        FROZENBANANADAIQUIRI = "黄而醇厚。",		-- 物品名:"冰香蕉冻唇蜜"
        BUNNYSTEW = "有人喜欢这道料理吗？。",		-- 物品名:"炖兔子"
        MILKYWHITES = "可以用作食材哦",		-- 物品名:"乳白物"
        CRITTER_EYEOFTERROR = "它是在下的伙伴。",		-- 物品名:"友好窥视者"
        SHIELDOFTERROR ="它和在下一样不属于这个世界。",		-- 物品名:"恐怖盾牌"
        TWINOFTERROR1 = "它和在下一样不属于这个世界。",		-- 物品名:"激光眼"
        TWINOFTERROR2 = "它和在下一样不属于这个世界。",		-- 物品名:"魔焰眼"
		COTL_TRINKET = "它和在下一样不属于这个世界。。",		-- 物品名:"红眼冠"
		TURF_COTL_GOLD = "它和在下一样不属于这个世界。",		-- 物品名:"黄金地板" 制造描述:"为新的黄金时代奠定基础。"
		TURF_COTL_BRICK = "它和在下一样不属于这个世界。",		-- 物品名:"砖地板" 制造描述:"单独的砖块聚集在一起用于更大的目的。"
		COTL_TABERNACLE_LEVEL1 =
		{
			LIT = "它和在下一样不属于这个世界。",		-- 物品名:"低微咩咩雕像" 制造描述:"劣质的咩咩雕刻品。"
			GENERIC = "需要燃料。",		-- 物品名:"低微咩咩雕像"->默认 制造描述:"劣质的咩咩雕刻品。"
		},
		COTL_TABERNACLE_LEVEL2 =
		{
			LIT = "它和在下一样不属于这个世界。",		-- 物品名:"有所改进咩咩雕像" 制造描述:"一座用来歌颂咩咩的精致雕像。"
			GENERIC = "需要燃料。",		-- 物品名:"有所改进咩咩雕像"->默认 制造描述:"一座用来歌颂咩咩的精致雕像。"
		},
		COTL_TABERNACLE_LEVEL3 =
		{
			LIT = "它和在下一样不属于这个世界。",		-- 物品名:"完美无瑕咩咩雕像" 制造描述:"一座纪念咩咩荣耀的耀眼纪念碑。"
			GENERIC = "需要燃料。",		-- 物品名:"完美无瑕咩咩雕像"->默认 制造描述:"一座纪念咩咩荣耀的耀眼纪念碑。"
		},
        CATTOY_MOUSE = "送给伙伴他们会开心吗？",		-- 物品名:"发条鼠玩具" 制造描述:"开始一场猫鼠游戏。"
        KITCOON_NAMETAG = "给伙伴起什么名字好呢？",		-- 物品名:"小浣猫项圈" 制造描述:"给可爱的小脸蛋起个名字。"
		KITCOONDECOR1 =
        {
            GENERIC = "不是真鸟，但那些小家伙根本分不清。",		-- 物品名:"火鸡不倒翁"->默认
            BURNT = "烧起来了！",		-- 物品名:"火鸡不倒翁"->烧焦的
        },
		KITCOONDECOR2 =
        {
            GENERIC = "可爱的小家伙喜欢这个",		-- 物品名:"逗猫小鱼"->默认
            BURNT = "它被烧了。",		-- 物品名:"逗猫小鱼"->烧焦的
        },
		KITCOONDECOR1_KIT = "看起来需要组装一下。",		-- 物品名:"火鸡不倒翁套装" 制造描述:"属于猫科朋友的羽毛乐趣。"
		KITCOONDECOR2_KIT = "看起来不是很难制作。",		-- 物品名:"逗猫小鱼套装" 制造描述:"一场愉快的无用功。"
        WX78MODULE_MAXHEALTH = "这是机器人先生的魔法道具。",		-- 物品名:"强化电路" 制造描述:"让你的机械身躯更加健壮。"
        WX78MODULE_MAXSANITY1 = "这是机器人先生的魔法道具。",		-- 物品名:"处理器电路" 制造描述:"一点额外的处理能力有助于缓解机械思维。"
        WX78MODULE_MAXSANITY = "这是机器人先生的魔法道具。",		-- 物品名:"超级处理器电路" 制造描述:"处理能力的大幅提升将让齿轮高速转动。"
        WX78MODULE_MOVESPEED = "这是机器人先生的魔法道具。",		-- 物品名:"加速电路" 制造描述:"匆忙设计的加速器。亟待改进。"
        WX78MODULE_MOVESPEED2 = "这是机器人先生的魔法道具。",		-- 物品名:"超级加速电路" 制造描述:"一个完美的加速器，将你的引擎提到最高档。"
        WX78MODULE_HEAT = "这是机器人先生的魔法道具。",		-- 物品名:"热能电路" 制造描述:"要热起来了。"
        WX78MODULE_NIGHTVISION = "这是机器人先生的魔法道具。",		-- 物品名:"光电电路" 制造描述:"将你的光学传感器调校为夜视效果。"
        WX78MODULE_COLD = "这是机器人先生的魔法道具。",		-- 物品名:"制冷电路" 制造描述:"把你的底盘变成一个便携式冰柜。"
        WX78MODULE_TASER = "这是机器人先生的魔法道具。",		-- 物品名:"电气化电路" 制造描述:"谁敢惹你就等着被电击吧。"
        WX78MODULE_LIGHT = "这是机器人先生的魔法道具。",		-- 物品名:"照明电路" 制造描述:"用你的存在照亮一个房间。"
        WX78MODULE_MAXHUNGER1 = "这是机器人先生的魔法道具。",		-- 物品名:"胃增益电路" 制造描述:"增加一点燃料箱的容量。"
        WX78MODULE_MAXHUNGER = "这是机器人先生的魔法道具。",		-- 物品名:"超级胃增益电路" 制造描述:"能满足哪怕是最贪食的机器人的胃口。"
        WX78MODULE_MUSIC = "这是机器人先生的魔法道具。",		-- 物品名:"合唱盒电路" 制造描述:"每台机器都需要时不时地进行校准。"
        WX78MODULE_BEE = "这是机器人先生的魔法道具。",		-- 物品名:"豆增压电路" 制造描述:"让你的大脑和身体都充满嗡嗡作响的潜能！"
        WX78MODULE_MAXHEALTH2 = "这是机器人先生的魔法道具。",		-- 物品名:"超级强化电路" 制造描述:"让你的机械身躯无比健壮。"
        WX78_SCANNER =
        {
            GENERIC ="这是机器人先生的魔法道具。",		-- 物品名:"生物扫描分析仪"->默认
            HUNTING = "这是机器人先生的魔法道具",		-- 物品名:"生物扫描分析仪"
            SCANNING = "这是机器人先生的魔法道具。",		-- 物品名:"生物扫描分析仪"
        },
        WX78_SCANNER_ITEM = "这是机器人先生的魔法道具。",		-- 物品名:"生物扫描分析仪" 制造描述:"备份扫描永远不会有坏处。"
        WX78_SCANNER_SUCCEEDED = "这是机器人先生的魔法道具。",		-- 物品名:"生物扫描分析仪"
        WX78_MODULEREMOVER = "这是机器人先生的魔法道具。",		-- 物品名:"电路提取器" 制造描述:"成功的钳（前）提是努力。"
        SCANDATA = "这是机器人先生的魔法道具。",		-- 物品名:"生物数据"
		JUSTEGGS = "可以再来点培根。",		-- 物品名:"普通煎蛋"
		VEGGIEOMLET = "要吃早餐哦。",		-- 物品名:"早餐锅"
		TALLEGGS = "早餐技术的突破！",		-- 物品名:"苏格兰高鸟蛋"
		BEEFALOFEED = "牛牛喜欢这个。",		-- 物品名:"蒸树枝"
		BEEFALOTREAT = "牛牛喜欢这个。",		-- 物品名:"皮弗娄牛零食"
        BOAT_ROTATOR = "比风更可控。",		-- 物品名:"转向舵"
        BOAT_ROTATOR_KIT = "比风更可控。",		-- 物品名:"转向舵套装" 制造描述:"划，划，转动你的船。"
        BOAT_BUMPER_KELP = "夕惕若厉，则无咎矣。",		-- 物品名:"海带保险杠"
        BOAT_BUMPER_KELP_KIT = "夕惕若厉，则无咎矣。",		-- 物品名:"海带保险杠套装" 制造描述:"用海带保护你的船！"
		BOAT_BUMPER_SHELL = "夕惕若厉，则无咎矣。",		-- 物品名:"贝壳保险杠"
        BOAT_BUMPER_SHELL_KIT = "夕惕若厉，则无咎矣。",		-- 物品名:"贝壳保险杠套装" 制造描述:"用贝壳保护你的船！"
        BOAT_CANNON = 
        {
            GENERIC = "在下应该找东西装填进去。",		-- 物品名:"大炮"->默认
            AMMOLOADED = "大炮已经准备好开火了！",		-- 物品名:"大炮"
            NOAMMO = "在下会好好瞄准的！",		-- 物品名:"大炮"
        },
        BOAT_CANNON_KIT = "现在还不是大炮，不过将来会是。",		-- 物品名:"大炮套装" 制造描述:"它能把你的竞争对手从水面轰走。"
        CANNONBALL_ROCK_ITEM = "很危险哦。",		-- 物品名:"炮弹" 制造描述:"它肯定会引起轰动。"
        OCEAN_TRAWLER = 
        {
            GENERIC = "用来抓晚上吃的鱼。",		-- 物品名:"海洋拖网捕鱼器"->默认
            LOWERED = "现在我们得等等。",		-- 物品名:"海洋拖网捕鱼器"
            CAUGHT = "抓到个东西！",		-- 物品名:"海洋拖网捕鱼器"
            ESCAPED = "好像是抓到了，但又被它跑掉了……",		-- 物品名:"海洋拖网捕鱼器"
            FIXED = "又可以抓鱼了！",		-- 物品名:"海洋拖网捕鱼器"
        },
        OCEAN_TRAWLER_KIT = "应该把它放在有很多鱼的地方。",		-- 物品名:"海洋拖网捕鱼器套装" 制造描述:"海里有的是鱼。"
        BOAT_MAGNET =
        {
            GENERIC = "在下不太清楚它的原理。",		-- 物品名:"自动航行仪"->默认
            ACTIVATED = "在下不太清楚它的原理。",		-- 物品名:"自动航行仪"
        },
        BOAT_MAGNET_KIT = "在下不太清楚它的原理。",		-- 物品名:"自动航行仪套装" 制造描述:"你的个性并不是唯一具有磁性的东西。"
        BOAT_MAGNET_BEACON =
        {
            GENERIC = "在下不太清楚它的原理。",		-- 物品名:"自动航行灯塔"->默认 制造描述:"能把附近可能存在的任何滑稽的超大磁铁吸过来。"
            ACTIVATED = "在下不太清楚它的原理。",		-- 物品名:"自动航行灯塔" 制造描述:"能把附近可能存在的任何滑稽的超大磁铁吸过来。"
        },
        DOCK_KIT = "天堑变通途。",		-- 物品名:"码头套装" 制造描述:"准备好你的码头审查。"
        DOCK_WOODPOSTS_ITEM = "在下不确定这有什么用",		-- 物品名:"码头桩" 制造描述:"没有什么能比事后添加一些柱子更能说明“结构稳定”了。"
        MONKEYHUT =
        {
            GENERIC = "讨厌的坏家伙的家。",		-- 物品名:"猴子小屋"->默认
            BURNT = "在下并不可怜它们",		-- 物品名:"猴子小屋"->烧焦的
        },
        POWDER_MONKEY = "讨厌的坏家伙！",		-- 物品名:"火药猴"
        PRIME_MATE = "非常讨厌的坏家伙！",		-- 物品名:"大副"
		LIGHTCRAB = "它是发光生物！",		-- 物品名:"发光蟹"
        CUTLESS = "不如在下的法杖。",		-- 物品名:"木头短剑"
        CURSED_MONKEY_TOKEN = "远离这个！",		-- 物品名:"诅咒饰品"
        OAR_MONKEY = "拿起船桨去战斗。",		-- 物品名:"战桨"
        BANANABUSH = "那片灌木丛是香蕉！",		-- 物品名:"香蕉丛"
        DUG_BANANABUSH = "那片灌木丛是香蕉！",		-- 物品名:"香蕉丛"
        PALMCONETREE = "一颗长得像松树的棕榈树。",		-- 物品名:"棕榈松果树"
        PALMCONE_SEED = "它需要风和时间。",		-- 物品名:"棕榈松果树芽"
        PALMCONE_SAPLING = "蕴含着生命。",		-- 物品名:"棕榈松果树苗"
        PALMCONE_SCALE = "或许能有用。",		-- 物品名:"棕榈松果树鳞片"
        MONKEYTAIL = "可以移植的芦苇。",		-- 物品名:"猴尾草"
        DUG_MONKEYTAIL = "不知道能不能吃？看来要安排一个实验了。",		-- 物品名:"猴尾草"
        MONKEY_MEDIUMHAT = "这个……适合在下吗？",		-- 物品名:"船长的三角帽"
        MONKEY_SMALLHAT = "这个……适合在下吗？",		-- 物品名:"海盗头巾"
        POLLY_ROGERSHAT = "在下又多了一位伙伴！",		-- 物品名:"波莉·罗杰的帽子" 制造描述:"随帽子附送一只长羽毛的朋友。"
        POLLY_ROGERS = "在下又多了一位伙伴！",		-- 物品名:"波莉·罗杰"
        MONKEYISLAND_PORTAL = "这个世界的魔法千奇百怪",		-- 物品名:"非自然传送门"
        MONKEYISLAND_PORTAL_DEBRIS = "奇怪的东西",		-- 物品名:"损坏的机器"
        MONKEYQUEEN = "您好，女王陛下！",		-- 物品名:"月亮码头女王"
        MONKEYPILLAR = "这是做什么用的？。",		-- 物品名:"猴子柱"
        PIRATE_FLAG_POLE = "在下不需要这个",		-- 物品名:"月亮码头海盗旗" 制造描述:"挂起你自己的海盗旗来模仿猴子掠夺者吧。"
        BLACKFLAG = "在下不需要这个。",		-- 物品名:"黑旗"
        PIRATE_STASH = "宝藏！",		-- 物品名:"X"
        STASH_MAP = "讨厌的坏家伙们唯一的贡献。",		-- 物品名:"海盗地图"
        BANANAJUICE = "讨厌的坏家伙们唯二的贡献。。",		-- 物品名:"香蕉奶昔"
        FENCE_ROTATOR = "重新装修",		-- 物品名:"栅栏击剑" 制造描述:"一把用于栅栏和击剑的剑"
        CHARLIE_STAGE_POST = "我们有剧本吗？",		-- 物品名:"舞台"
        CHARLIE_LECTURN = "有人在演话剧吗？",		-- 物品名:"剧本"
        CHARLIE_HECKLER = "它们来是为了提高戏剧性。",		-- 物品名:"嘲鸫"
        PLAYBILL_THE_DOLL = "“由 C.W. 撰写”",		-- 物品名:"附魔玩偶\n舞台剧"
        STATUEHARP_HEDGESPAWNER = "花长回来了，但头却没有。",		-- 物品名:"荆棘密布的雕像"
        HEDGEHOUND = "坏狗狗！",		-- 物品名:"蔷薇狼"
        HEDGEHOUND_BUSH = "风告诉我它可能很危险。",		-- 物品名:"蔷薇"
        MASK_DOLLHAT = "这是一张玩偶面具。",		-- 物品名:"玩偶面具"
        MASK_DOLLBROKENHAT = "这是一张开裂的玩偶面具。",		-- 物品名:"开裂玩偶面具"
        MASK_DOLLREPAIREDHAT = "这是一张曾经的玩偶面具。",		-- 物品名:"破碎玩偶面具"
        MASK_BLACKSMITHHAT = "这是一张铁匠面具。",		-- 物品名:"铁匠面具"
        MASK_MIRRORHAT = "这是一张面具，但它看起来像一面镜子。",		-- 物品名:"镜子面具"
        MASK_QUEENHAT = "这是一张女王面具。",		-- 物品名:"女王面具"
        MASK_KINGHAT = "这是一张国王面具。",		-- 物品名:"国王面具"
        MASK_TREEHAT = "这是一张树的面具。",		-- 物品名:"树木面具"
        MASK_FOOLHAT = "这是一张小丑面具。",		-- 物品名:"小丑面具"
        COSTUME_DOLL_BODY = "这是玩偶的戏服。",		-- 物品名:"玩偶服"
        COSTUME_QUEEN_BODY = "这是女王的戏服。",		-- 物品名:"女王服"
        COSTUME_KING_BODY = "这是国王的戏服。",		-- 物品名:"国王服"
        COSTUME_BLACKSMITH_BODY = "这是铁匠的戏服。",		-- 物品名:"铁匠服"
        COSTUME_MIRROR_BODY = "这是一套戏服。",		-- 物品名:"镜子服"
        COSTUME_TREE_BODY = "这是树的戏服。",		-- 物品名:"树木服"
        COSTUME_FOOL_BODY = "这是小丑的戏服。",		-- 物品名:"小丑服"
        STAGEUSHER =
        {
            STANDING = "总之不要伸出你的手，好吗？",		-- 物品名:"多刺舞台之手"
            SITTING = "这里有些古怪，但在下说不出所以然。",		-- 物品名:"多刺舞台之手"
        },
        SEWING_MANNEQUIN =
        {
            GENERIC = "你想和在下交朋友吗？",		-- 物品名:"假人"->默认 制造描述:"测试所有最新可装备外观的模特。"
            BURNT = "即使烧光了，还是哪也去不了。",		-- 物品名:"假人"->烧焦的 制造描述:"看来你不能和在下交朋友了"
        },
		MAGICIAN_CHEST = "已经不能算魔术了",		-- 物品名:"魔术师箱子" 制造描述:"将你的物品囚禁在一个暗影漩涡中。"
		TOPHAT_MAGICIAN = "已经不能算魔术了。",		-- 物品名:"魔术师高礼帽" 制造描述:"百搭的黑魔法。"
        YOTR_FIGHTRING_KIT = "在下不太喜欢枕头大战",		-- 物品名:"枕头大战坑套装" 制造描述:"兔子的战斗擂台。"
        YOTR_FIGHTRING_BELL =
        {
            GENERIC = "暂时平静下来了。",		-- 物品名:"枕头大战钟"->默认
            PLAYING = "逝者如斯夫。",		-- 物品名:"枕头大战钟"
        },
        YOTR_DECOR_1 = 
        {
            GENERAL = "那只兔子真的可以点亮一个房间。",		-- 物品名:"矮兔灯"
            OUT = "这兔子什么都照不亮。",		-- 物品名:"矮兔灯"->出去？外面？
        },
        YOTR_DECOR_2 = 
        {
            GENERAL = "那只兔子真的可以点亮一个房间。",		-- 物品名:"高兔灯"
            OUT = "这兔子什么都照不亮。",		-- 物品名:"高兔灯"->出去？外面？
        },
        HAREBALL = "这是干什么用的？",		-- 物品名:"兔毛球"
        YOTR_DECOR_1_ITEM = "在下知道把它放在哪。",		-- 物品名:"矮兔灯" 制造描述:"这盏可爱的灯能使任何洞穴变得舒适起来。"
        YOTR_DECOR_2_ITEM = "在下知道把它放在哪。",		-- 物品名:"高兔灯" 制造描述:"一尊肚子里真正有火的兔子雕像！"
		DREADSTONE = "暗影能量的结晶。",		-- 物品名:"绝望石"
		HORRORFUEL = "暗影魔法的凝聚物。",		-- 物品名:"纯粹恐惧"
		DAYWALKER =
		{
			GENERIC = "恩将仇报。",		-- 物品名:"噩梦猪人"->默认
			IMPRISONED = "它会回来的。",		-- 物品名:"噩梦猪人"
		},
		DAYWALKER_PILLAR =
		{
			GENERIC = "大理石里有东西在闪烁。",		-- 物品名:"开裂的柱子"->默认
			EXPOSED = "坚不可摧的石柱。",		-- 物品名:"开裂的柱子"
		},
		ARMORDREADSTONE = "穿上它心情会变糟的",		-- 物品名:"绝望石盔甲" 制造描述:"不要怕，黑暗会保护你。"
		DREADSTONEHAT = "穿上它心情会变糟的。",		-- 物品名:"绝望石头盔" 制造描述:"由至黑的石头做成的结实头盔。"
        LUNARRIFT_PORTAL = "它为我们带来了新的力量",		-- 物品名:"裂隙"
        LUNARRIFT_CRYSTAL = "发光体结晶。",		-- 物品名:"开裂的柱子"
        LUNARTHRALL_PLANT = "魔物！",		-- 物品名:"致命亮茄"
        LUNARTHRALL_PLANT_VINE_END = "小心！",		-- 物品名:"钻地藤蔓"
		LUNAR_GRAZER = "它一定是通过那个奇怪的裂隙来的！",		-- 物品名:"牧者"
        PUREBRILLIANCE = "月亮魔法的凝聚物！",		-- 物品名:"纯粹辉煌"
        LUNARPLANT_HUSK = "掉落的战利品",		-- 物品名:"亮茄外壳"
		LUNAR_FORGE = "缝纫和锻造一样吗？",		-- 物品名:"辉煌铁匠铺"
		LUNAR_FORGE_KIT = "缝纫和锻造一样吗？",		-- 物品名:"辉煌铁匠铺套装" 制造描述:"锻造异世界的物品。"
		LUNARPLANT_KIT = "临行密密缝。",		-- 物品名:"亮茄修补套件" 制造描述:"修复损坏的设备。"
		ARMOR_LUNARPLANT = "在下感受不到风了。",		-- 物品名:"亮茄盔甲" 制造描述:"将自己包围在令人生畏的月叶中。"
		LUNARPLANTHAT = "在下感受不到风了。",		-- 物品名:"亮茄头盔" 制造描述:"用发着光的护具保护您宝贵的颅骨。"
		BOMB_LUNARPLANT = "迸发出月亮的魔法。",		-- 物品名:"亮茄炸弹" 制造描述:"用不稳定的月能取得爆炸性结果。"
		STAFF_LUNARPLANT = "不错的法杖",		-- 物品名:"亮茄魔杖" 制造描述:"扎根原地，从远处发起攻击。"
		SWORD_LUNARPLANT = "代表月亮！抱歉，开个玩笑",		-- 物品名:"亮茄剑" 制造描述:"月光宝剑。"
		PICKAXE_LUNARPLANT = "打碎！",		-- 物品名:"亮茄粉碎者" 制造描述:"随心所欲地挖掘和拆除吧。"
		SHOVEL_LUNARPLANT = "可靠的园艺工具",		-- 物品名:"亮茄锄铲" 制造描述:"铲子和园艺锄之间交叉授粉的突破性成果。"
		BROKEN_FORGEDITEM = "它破损了，但是在下可以把它修好。",		-- 物品名:"开裂的柱子"
        PUNCHINGBAG = "攻击它也能召唤风的力量。",		-- 物品名:"拳击袋" 制造描述:"测试武器的强度。并从中获得乐趣！"
        SHADOWRIFT_PORTAL = "那东西看起来像是会一直持续下去。",		-- 物品名:"裂隙"
		SHADOW_FORGE = "它教会了在下暗影魔法的知识",		-- 物品名:"暗影术基座"
		SHADOW_FORGE_KIT = "它教会了在下暗影魔法的知识。",		-- 物品名:"暗影术基座套装" 制造描述:"让恐惧为你所用。"
        FUSED_SHADELING = "暗影的力量正在扩张。",		-- 物品名:"熔合暗影"
        FUSED_SHADELING_BOMB = "魔物！",		-- 物品名:"绝望螨"
		VOIDCLOTH = "魔物掉落的战利品。",		-- 物品名:"暗影碎布"
		VOIDCLOTH_KIT = "在下对缝纫很有自信。",		-- 物品名:"虚空修补套件" 制造描述:"修复损坏的设备。"
		VOIDCLOTHHAT = "在下感受不到风了。",		-- 物品名:"虚空风帽" 制造描述:"没有光可以刺穿这个罩子里的黑暗。"
		ARMOR_VOIDCLOTH = "在下感受不到风了。",		-- 物品名:"虚空长袍" 制造描述:"一件阻隔光线的噩梦斗篷。"
        VOIDCLOTH_UMBRELLA = "可以抵挡酸雨。",		-- 物品名:"暗影伞" 制造描述:"暗影提供的保护，不惧最严峻的降雨。"
        VOIDCLOTH_SCYTHE = "在下喜欢这件工具！",		-- 物品名:"暗影收割者" 制造描述:"从容地剔除植物群落。"
		SHADOWTHRALL_HANDS = "魔物！",		-- 物品名:"墨荒"
		SHADOWTHRALL_HORNS = "准备战斗，伙伴们！",		-- 物品名:"墨荒"
		SHADOWTHRALL_WINGS = "魔物！",		-- 物品名:"墨荒"
        CHARLIE_NPC = "这位女士……",		-- 物品名:"查理"
        CHARLIE_HAND = "它想要某种可怕的东西。",		-- 物品名:"召唤之手"
        NITRE_FORMATION = "在下分不清各种石头。",		-- 物品名:"硝石堆"
        DREADSTONE_STACK = "它来自于那些裂隙深处...",		-- 物品名:"绝望石矿苗"
        SCRAPBOOK_PAGE = "好记性不如烂笔头。",		-- 物品名:"丢失的图鉴页面"
        LEIF_IDOL = "也许是某种生命魔法。",		-- 物品名:"树精守卫雕像" 制造描述:"召唤树木的力量。"
        WOODCARVEDHAT = "你很努力了呢，伐木工先生。",		-- 物品名:"硬木帽" 制造描述:"你的脑袋会被保护得很好（敲敲木头防止乌鸦嘴）。"
        WALKING_STICK = "你很努力了呢，伐木工先生。",		-- 物品名:"木手杖" 制造描述:"轻松穿越您最喜欢的自然小径。"
        IPECACSYRUP = "在下不太想吃这个。",		-- 物品名:"泻根糖浆" 制造描述:"让你保持正常。"
        BOMB_LUNARPLANT_WORMWOOD = "我们的朋友似乎对他的月亮根源有了更多的接触。", -- Unused		-- 物品名:"开裂的柱子"
        WORMWOOD_MUTANTPROXY_CARRAT =
        {
        	DEAD = "它走到了尽头。",		-- 物品名:未找到
        	GENERIC = "胡萝卜怎么还长腿了？",		-- 物品名:未找到
        	HELD = "可爱的小家伙。",		-- 物品名:未找到
        	SLEEPING = "嘘。",		-- 物品名:未找到
        },
        WORMWOOD_MUTANTPROXY_LIGHTFLIER = "可爱的小家伙。",		-- 物品名:未找到
		WORMWOOD_MUTANTPROXY_FRUITDRAGON =
		{
			GENERIC = "可爱的小家伙。。",		-- 物品名:未找到
			RIPE = "可爱的小家伙。。",		-- 物品名:未找到
			SLEEPING = "嘘。",		-- 物品名:未找到
		},
        SUPPORT_PILLAR_SCAFFOLD = "还需要很多材料，要加油哦。",		-- 物品名:"支柱脚手架" 制造描述:"我们都需要一些支持。"
        SUPPORT_PILLAR = "还需要一些材料，要加油哦。",		-- 物品名:"支柱"
        SUPPORT_PILLAR_COMPLETE = "完成了，很棒哦。",		-- 物品名:"加固支柱"
        SUPPORT_PILLAR_BROKEN = "前功尽弃。",		-- 物品名:"支柱瓦砾"
		SUPPORT_PILLAR_DREADSTONE_SCAFFOLD = "还需要很多材料，要加油哦。",		-- 物品名:"绝望石支柱脚手架" 制造描述:"黑暗的力量在压力下仍能保持良好的状态。"
		SUPPORT_PILLAR_DREADSTONE = "还需要一些材料，要加油哦。",		-- 物品名:"绝望石支柱"
		SUPPORT_PILLAR_DREADSTONE_COMPLETE = "看起来强大得可怕。",		-- 物品名:"强化绝望石支柱"
		SUPPORT_PILLAR_DREADSTONE_BROKEN = "完成了，很棒哦。",		-- 物品名:"绝望石支柱瓦砾"
        WOLFGANG_WHISTLE = "非常感谢，大力士先生！",		-- 物品名:"训练哨" 制造描述:"释放你心底潜在的教练！"
        MUTATEDDEERCLOPS = "它被灌注了月亮魔法！",		-- 物品名:"晶体独眼巨鹿"
        MUTATEDWARG = "它被灌注了月亮魔法！",		-- 物品名:"附身座狼"
        MUTATEDBEARGER = "它被灌注了月亮魔法！",		-- 物品名:"装甲熊獾"
        LUNARFROG = "它被灌注了月亮魔法！",		-- 物品名:"明眼青蛙"
        DEERCLOPSCORPSE =
        {
            GENERIC  = "结束了……吧？",		-- 物品名:未找到
            BURNING  = "小心没大错。",		-- 物品名:未找到
            REVIVING = "在下不愿相信双眼正在看到的这一切！",		-- 物品名:未找到
        },
        WARGCORPSE =
        {
            GENERIC  = "为什么在下仍然感到不安？",		-- 物品名:未找到
            BURNING  = "一切都是最好的安排。",		-- 物品名:未找到
            REVIVING = "这是什么？",		-- 物品名:未找到
        },
        BEARGERCORPSE =
        {
            GENERIC  = "好臭！",		-- 物品名:未找到
            BURNING  = "好险。",		-- 物品名:未找到
            REVIVING = "真是惊人！",		-- 物品名:未找到
        },
        BEARGERFUR_SACK = "用来储存料理再好不过。",		-- 物品名:"极地熊獾桶" 制造描述:"便携式冰箱。酷。"
        HOUNDSTOOTH_BLOWPIPE = "乘风之势！",		-- 物品名:"嚎弹炮" 制造描述:"那感觉就像远距离被咬一样。"
        DEERCLOPSEYEBALL_SENTRYWARD =
        {
            GENERIC = "呼啸寒风",    -- Enabled.		-- 物品名:"冰眼结晶器"->默认
            NOEYEBALL = "呼啸寒风",  -- Disabled.		-- 物品名:"冰眼结晶器"
        },
        DEERCLOPSEYEBALL_SENTRYWARD_KIT = "呼啸寒风",		-- 物品名:"冰眼结晶器套装" 制造描述:"用冻伤来治疗一下晒伤。"
        SECURITY_PULSE_CAGE = "它是空的。",		-- 物品名:"火花柜"
        SECURITY_PULSE_CAGE_FULL = "你是最可爱的纯能量小球吗？",		-- 物品名:"火花柜"
		CARPENTRY_STATION =
        {
            GENERIC = "它能造家具。",		-- 物品名:"锯马"->默认 制造描述:"别瞎蹦跶了，做点家具吧。"
            BURNT = "它不能造家具了。",		-- 物品名:"锯马"->烧焦的 制造描述:"别瞎蹦跶了，做点家具吧。"
        },
        {
            GENERIC = "它能造家具。",		-- 物品名:"锯马"->默认 制造描述:"别瞎蹦跶了，做点家具吧。"
            HAS_ITEM = "未找到",		-- 物品名:"锯马" 制造描述:"别瞎蹦跶了，做点家具吧。"
            BURNT = "它不能造家具了。",		-- 物品名:"锯马"->烧焦的 制造描述:"别瞎蹦跶了，做点家具吧。"
        },
        WOOD_CHAIR =
        {
            GENERIC = "在下想坐上去！",		-- 物品名:"木椅"->默认 制造描述:"一把可以坐的木椅。"
            OCCUPIED = "别人在坐着。",		-- 物品名:"木椅"->被占领 制造描述:"一把可以坐的木椅。"
            BURNT = "在下可不想坐上去。",		-- 物品名:"木椅"->烧焦的 制造描述:"一把可以坐的木椅。"
        },
        DECOR_CENTERPIECE = "要小心使用哦。",		-- 物品名:"艺术？" 制造描述:"彰显您卓越品味的餐桌摆件。"
        DECOR_LAMP = "一盏迎宾灯。",		-- 物品名:"餐桌灯" 制造描述:"一盏舒适的小灯。"
        DECOR_FLOWERVASE =
        {
            GENERIC = "插花的漂亮花瓶。",		-- 物品名:"餐桌花瓶"->默认 制造描述:"这是一个放置鲜切花的好地方。"
            EMPTY = "没有花的漂亮花瓶。",		-- 物品名:"餐桌花瓶" 制造描述:"这是一个放置鲜切花的好地方。"
            WILTED = "看起来不太新鲜。",		-- 物品名:"餐桌花瓶"->枯萎的 制造描述:"这是一个放置鲜切花的好地方。"
            FRESHLIGHT = "有一点亮光真是好。",		-- 物品名:"餐桌花瓶"->茶几-新的发光的 制造描述:"这是一个放置鲜切花的好地方。"
            OLDLIGHT = "在下会每日换水的。",		-- 物品名:"餐桌花瓶"->茶几-旧的发光的 制造描述:"这是一个放置鲜切花的好地方。"
        },
        DECOR_PICTUREFRAME =
        {
            GENERIC = "真美啊。",		-- 物品名:"空画框"->默认 制造描述:"将你最爱的物品图装裱起来。 "
            UNDRAWN = "在下应该画点东西在里面。",		-- 物品名:"空画框"->没有画画 制造描述:"将你最爱的物品图装裱起来。 "
        },
        DECOR_PORTRAITFRAME = "看上去不错！",		-- 物品名:"愉快画像" 制造描述:"把你的朋友们放进框里，这很有趣！ "
        PHONOGRAPH = "这个世界的音乐很独特。",		-- 物品名:"留声机" 制造描述:"坐下来，放松一下，听一听你噩梦中的音乐。"
        RECORD = "这个世界的音乐很独特",		-- 物品名:"唱片" 制造描述:"黑胶上的永恒经典。"
        RECORD_CREEPYFOREST = "这个世界的音乐很独特。",		-- 物品名:"惊悚森林"
        RECORD_DANGER = "不是在下最喜欢的。",		-- 物品名:"空画框" 制造描述:"将你最爱的物品图装裱起来。 "
        RECORD_DAWN = "需要多一点小号。",		-- 物品名:"空画框" 制造描述:"将你最爱的物品图装裱起来。 "
        RECORD_DRSTYLE = "这个世界的音乐很独特。",		-- 物品名:"D.R.风格"
        RECORD_DUSK = "这个世界的音乐很独特。",		-- 物品名:"空画框" 制造描述:"将你最爱的物品图装裱起来。 "
        RECORD_EFS = "这个世界的音乐很独特。",		-- 物品名:"E.F.S."
        RECORD_END = "这个世界的音乐很独特。",		-- 物品名:"空画框" 制造描述:"将你最爱的物品图装裱起来。 "
        RECORD_MAIN = "这个世界的音乐很独特。",		-- 物品名:"空画框" 制造描述:"将你最爱的物品图装裱起来。 "
        RECORD_WORKTOBEDONE = "这个世界的音乐很独特。",		-- 物品名:"空画框" 制造描述:"将你最爱的物品图装裱起来。 "
        ARCHIVE_ORCHESTRINA_MAIN = "这个世界的音乐很独特。",		-- 物品名:"远古小合奏机"
        WAGPUNKHAT = "时间和风将带给在下力量！",		-- 物品名:"W.A.R.B.I.S.头戴齿轮" 制造描述:"看起来聪明，打起来也聪明。"
        ARMORWAGPUNK = "时间和风将带给在下力量！",		-- 物品名:"W.A.R.B.I.S.盔甲" 制造描述:"开足马力，全速前进！"
        WAGSTAFF_MACHINERY = "在这堆垃圾中也许会有所发现。",		-- 物品名:"被丢弃的垃圾"
        WAGPUNK_BITS = "在下不清楚它的用途。",		-- 物品名:"废铁"
        WAGPUNKBITS_KIT = "这和缝纫不太一样",		-- 物品名:"自动修理机" 制造描述:"你得心应手的W.A.R.B.I.S.维修工具！"
        WAGSTAFF_MUTATIONS_NOTE = "看不懂OXO",		-- 物品名:"研究笔记"
        BATTLESONG_INSTANT_REVIVE = "复活吧！我的伙伴们！",		-- 物品名:"战士重奏" 制造描述:"扰动阵亡战友的心房。\n"
        WATHGRITHR_IMPROVEDHAT = "很漂亮的头盔",		-- 物品名:"统帅头盔" 制造描述:"适合女武神女王的头盔。"
        SPEAR_WATHGRITHR_LIGHTNING = "你是很厉害的战士，歌剧家女士。",		-- 物品名:"奔雷矛" 制造描述:"闪电的力量由你掌控。"
        BATTLESONG_CONTAINER = "歌剧家女士的宝物",		-- 物品名:"战斗号子罐" 制造描述:"保存你所有的金曲。"
        SADDLE_WATHGRITHR = "你是很厉害的战士，歌剧家女士。",		-- 物品名:"战斗鞍具" 制造描述:"勇士与坐骑，一起战斗吧！"
        WATHGRITHR_SHIELD = "你是很厉害的战士，歌剧家女士。",		-- 物品名:"战斗圆盾" 制造描述:"只要它相信自己，盾牌也可以是武器。"
        BATTLESONG_SHADOWALIGNED = "她将要一展歌喉。",		-- 物品名:"黑暗悲歌" 制造描述:"减少自身和盟友受到暗影攻击的伤害，增加对月亮阵营敌人的伤害。"
        BATTLESONG_LUNARALIGNED = "她将要一展歌喉。",		-- 物品名:"启迪摇篮曲" 制造描述:"减少自身和盟友受到月亮攻击的伤害，增加对暗影阵营敌人的伤害。"
		SHARKBOI = "精灵们，准备战斗！",		-- 物品名:"大霜鲨"
        BOOTLEG = "风也做不到这种事。",		-- 物品名:"出逃腿靴"
        OCEANWHIRLPORTAL = "风也做不到这种事。",		-- 物品名:"漩涡传送门"
        EMBERLIGHT = "某种火焰魔法的基底",		-- 物品名:"火球"
        WILLOW_EMBER = "only_used_by_willow",		-- 物品名:"以太余烬"
        YOTD_DRAGONSHRINE =
        {
            GENERIC = "供品会是什么？",		-- 物品名:"龙蝇神龛"->默认 制造描述:"供奉红火的龙蝇。"
            EMPTY = "它也许想要块木炭。",		-- 物品名:"龙蝇神龛" 制造描述:"供奉红火的龙蝇。"
            BURNT = "稍微有些过火了。",		-- 物品名:"龙蝇神龛"->烧焦的 制造描述:"供奉红火的龙蝇。"
        },
        DRAGONBOAT_KIT = "乘风破浪。",		-- 物品名:"龙蝇船套装" 制造描述:"启动海龙。"
        DRAGONBOAT_PACK = "让造船变得简单！",		-- 物品名:"豪华龙蝇船套装" 制造描述:"配备了所有的龙之配件。"
        BOATRACE_CHECKPOINT = "检查点就在那！",		-- 物品名:"比赛检查点"
        BOATRACE_CHECKPOINT_THROWABLE_DEPLOYKIT = "在下的清单上又多了一件要检查的事。",		-- 物品名:"比赛检查点套装" 制造描述:"重要的是旅程本身而不是终点。"
        BOATRACE_START = "总得有个起点。",		-- 物品名:"起点塔"
        BOATRACE_START_THROWABLE_DEPLOYKIT = "起点放在哪呢？",		-- 物品名:"起点塔套装" 制造描述:"各就位、预备、开划！"
        BOATRACE_PRIMEMATE = "如影随形！",		-- 物品名:"查理的选手"
        BOATRACE_SPECTATOR_DRAGONLING = "它在为在下加油！！",		-- 物品名:"小龙蝇观赛者"
        YOTD_STEERINGWHEEL = "它会让在下驶向正确的航向，左右都逢源。",		-- 物品名:"龙蝇船方向舵"
        YOTD_STEERINGWHEEL_ITEM = "它能做成方向舵。",		-- 物品名:"龙蝇船方向舵套装" 制造描述:"掌舵，驶向黄金！"
        YOTD_OAR = "好方便的船桨。",		-- 物品名:"利爪船桨" 制造描述:"关于龙蝇的一个鲜为人知的事实：它们是出人意料的游泳健将。"
        YOTD_ANCHOR = "在下可不能让在下的小船飞走了。",		-- 物品名:"巨爪船锚"
        YOTD_ANCHOR_ITEM = "现在在下能造出锚了。",		-- 物品名:"巨爪船锚套装" 制造描述:"船锚的黄金标准。"
        MAST_YOTD = "满是鳞片的帆。",		-- 物品名:"龙翼桅杆"
        MAST_YOTD_ITEM = "现在在下能造出桅杆了。",		-- 物品名:"龙翼桅杆套装" 制造描述:"制造这个桅杆时没有龙蝇受到伤害。"
        BOAT_BUMPER_YOTD = "有备无患",		-- 物品名:"獠牙保险杠"
        BOAT_BUMPER_YOTD_KIT = "夕惕若厉，则无咎矣。",		-- 物品名:"獠牙保险杠套装" 制造描述:"没有人敢招惹呲牙咧嘴的龙。"
        BOATRACE_SEASTACK = "真漂亮呀。",		-- 物品名:"黄金浮标"
        BOATRACE_SEASTACK_THROWABLE_DEPLOYKIT = "闪闪亮亮的。",		-- 物品名:"黄金浮标套装" 制造描述:"甲之浮标，乙之浮障。"
        BOATRACE_SEASTACK_MONKEY = "有些扎手，不要乱碰哦主人。",		-- 物品名:"荆棘浮标"
        BOATRACE_SEASTACK_MONKEY_THROWABLE_DEPLOYKIT = "这个浮标上有好多的刺！",		-- 物品名:"荆棘浮标套装"
        MASTUPGRADE_LAMP_YOTD = "主人你看！好漂亮的灯！",		-- 物品名:"龙蝇灯"
        MASTUPGRADE_LAMP_ITEM_YOTD = "在下有的都是闪闪发光的好主意。",		-- 物品名:"龙蝇灯套装" 制造描述:"用龙火照亮你的前路。"
        WALKINGPLANK_YOTD = "不管怎么装扮在下在用它时都不会感觉良好。",		-- 物品名:"龙鳞跳板"
        CHESSPIECE_YOTD = "好漂亮的东西。",		-- 物品名:"起点塔雕塑"
    },
    DESCRIBE_GENERIC = "这是？",		--检查物品描述的缺省值
    DESCRIBE_TOODARK = "太黑了，在下需要一些光亮。",		--天太黑
    DESCRIBE_SMOLDERING = "那东西快要着火了。",		--冒烟
    DESCRIBE_PLANTHAPPY = "嘿嘿，它看起来很开心。",		--暂无注释
    DESCRIBE_PLANTVERYSTRESSED = "植物先生压力好像有点大。",		--暂无注释
    DESCRIBE_PLANTSTRESSED = "它有点暴躁。",		--暂无注释
    DESCRIBE_PLANTSTRESSORKILLJOYS = "在下可能要除一下草……",		--暂无注释
    DESCRIBE_PLANTSTRESSORFAMILY = "它好像很孤单。",		--暂无注释
    DESCRIBE_PLANTSTRESSOROVERCROWDING = "植物太多，地方太小。",		--暂无注释
    DESCRIBE_PLANTSTRESSORSEASON = "这个季节对这株植物并不友好。",		--暂无注释
    DESCRIBE_PLANTSTRESSORMOISTURE = "看起来有点脱水。",		--暂无注释
    DESCRIBE_PLANTSTRESSORNUTRIENTS = "需要施肥啦！",		--暂无注释
    DESCRIBE_PLANTSTRESSORHAPPINESS = "植物先生好像有些不开心。",		--暂无注释
    EAT_FOOD =
    {
        TALLBIRDEGG_CRACKED = "它好像在动。",		--吃孵化的高脚鸟蛋
		WINTERSFEASTFUEL = "它尝起来是节日的味道。",		--暂无注释
    },
}
