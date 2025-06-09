return {
	ACTIONFAIL =
	{
        APPRAISE =
        {
            NOTNOW = "他好像在忙。",
        },
        REPAIR =
        {
            WRONGPIECE = "这比人骨还难拼!",
        },
        BUILD =
        {
            MOUNTED = "我得先下来......",
            HASPET = "我已经有一个小跟班了",
        },
		SHAVE =
		{
			AWAKEBEEFALO = "它还醒着......",
			GENERIC = "这要我剃什么？",
			NOBITS = "我才不会剪自己的花...",
            REFUSE = "only_used_by_woodie",
		},
		STORE =
		{
			GENERIC = "它进...放不进去了...",
			NOTALLOWED = "不可以这样放进去...",
			INUSE = "让我用嘛...！",
            NOTMASTERCHEF = "我不知道怎么烹制这个...",
		},
        CONSTRUCT =
        {
            INUSE = "我得等一会儿",
            NOTALLOWED = "哪里不太对......？",
            EMPTY = "材料不够啦",
            MISMATCH = "这和我想的不太一样",
        },
		RUMMAGE =
		{
			GENERIC = "欸...？",
			INUSE = "他怎么还在箱子里翻来翻去...",
            NOTMASTERCHEF = "我不擅长烹饪...",
		},
		UNLOCK =
        {
        	WRONGKEY = "怎么回事呀...",
        },
		USEKLAUSSACKKEY =
        {
        	WRONGKEY = "对不上孔！",
        	KLAUS = "我不理解...",
			QUAGMIRE_WRONGKEY = "钥匙钥匙钥匙钥匙钥匙",
        },
		ACTIVATE =
		{
			LOCKED_GATE = "它锁上了。",
		},
        COOK =
        {
            GENERIC = "我现在做不了饭。",
            INUSE = "让一让嘛...",
            TOOFAR = "我够不着...",
        },
        
        --厨师沃利相关烹饪语句
		DISMANTLE =
		{   
			COOKING = "里面已经有东西了。",
			INUSE = "我得等它轮到我的时候。",
			NOTEMPTY = "不太会用。",
        },
        FISH_OCEAN =
		{
			TOODEEP = "脆弱的钓竿不适合这种海域...",
		},
        --图书管理员书本相关语句
        READ =
        {
            GENERIC = "完全读不懂。",
            NOBIRDS = "完全不明白。"
        },
        GIVE =
        {
            GENERIC = "我有东西要给你!",
            DEAD = "别死呀...",
            SLEEPING = "我还是等你醒了比较好。",
            BUSY = "我等你忙完！",
            ABIGAILHEART = "我觉得其实是可以的...",
            GHOSTHEART = "它要动手了！",
            NOTGEM = "这肯定不可行...",
            WRONGGEM = "不是这一种颜色...",
            NOTSTAFF = "形状对不上！",
            MUSHROOMFARM_NEEDSSHROOM = "应该是蘑菇。",
            MUSHROOMFARM_NEEDSLOG = "大概是原木...?",
            SLOTFULL = "已经放了东西了",
            FOODFULL = "可以吃东西了",
            NOTDISH = "它为什么不吃...?",
            DUPLICATE = "我已经学会这个了",
            NOTSCULPTABLE = "这东西做不了雕像...",
            NOTATRIUMKEY = "插不进去！",
            CANTSHADOWREVIVE = "死掉了吗...",
            WRONGSHADOWFORM = "没拼对...",
            NOMOON = "我需要月光...",
			PIGKINGGAME_MESSY = "我得拆掉附近的建筑",
			PIGKINGGAME_DANGER = "害怕",
			PIGKINGGAME_TOOLATE = "我得等到天亮...",
        },
        GIVETOPLAYER =
        {
            FULL = "能让你的背包给我腾一个位置吗？",
            DEAD = "他 死了 。",
            SLEEPING = "他在休息",
            BUSY = "我有东西要给你！",
        },
        GIVEALLTOPLAYER =
        {
            FULL = "能让你的背包给我腾一个位置吗？",
            DEAD = "他死掉了...",
            SLEEPING = "他在休息...",
            BUSY = "我有东西要给你！",
        },
        WRITE =
        {
            GENERIC = "我再想想。",
            INUSE = "这点空位可不够两个人一起写。",
        },
        DRAW =
        {
            NOIMAGE = "我想要一张参考图！",
        },
        CHANGEIN =
        {
            GENERIC = "我现在不想换衣服。",
            BURNING = "着火啦！",
            INUSE = "我得等你用完，对吗？",
        },
        ATTUNE =
        {
            NOHEALTH = "这么做的话，我会死的...",
        },
        MOUNT =
        {
            TARGETINCOMBAT = "你在生气吗？",
            INUSE = "已经有一位骑手了......",
        },
        SADDLE =
        {
            TARGETINCOMBAT = "它在生气...",
        },
        TEACH =
        {
            --Recipes/Teacher
            KNOWN = "我已经学会这个了...",
            CANTLEARN = "完全看不懂...",

            --MapRecorder/MapExplorer
            WRONGWORLD = "世界上真有这种东西吗？",
        },
        WRAPBUNDLE =
        {
            EMPTY = "打这种包毫无意义...",
        },
        PICKUP =
        {
			RESTRICTION = "我不会用这种东西战斗!",
			INUSE = "还没轮到我。",
        },
        SLAUGHTER =
        {
            TOOFAR = "逃掉了呢......",
        },
        REPLATE =
        {
            MISMATCH = "它得用另一种餐盘。", 
            SAMEDISH = "我只需要一个盘子。", 
        },
        SAIL =
        {
        	REPAIR = "它很好，它不需要维修！",
        },
        ROW_FAIL =
        {
            BAD_TIMING0 = "太快了!",
            BAD_TIMING1 = "我没抓住时机!",
            BAD_TIMING2 = "我不该犯那种错误...",
        },
        LOWER_SAIL_FAIL =
        {
            "唔...",
            "这次可不能停下来!",
            "有人曾说，爬起要比跌倒再多一次！",
        },
        BATHBOMB =
        {
            GLASSED = "表面和玻璃一样...",
            ALREADY_BOMBED = "浪费是不好的！",
        },
	},
	ACTIONFAIL_GENERIC = "我 做 不 到。",
	ANNOUNCE_BOAT_LEAK = "水...水太多了!",
	ANNOUNCE_BOAT_SINK = "花不会游泳啊!",
	ANNOUNCE_DIG_DISEASE_WARNING = "舒服多了...",
	ANNOUNCE_PICK_DISEASE_WARNING = "奇怪的食物...",
	ANNOUNCE_ADVENTUREFAIL = "也许需要再来一次...",
    ANNOUNCE_MOUNT_LOWHEALTH = "它好像受伤了...",

	ANNOUNCE_BEES = "嘤嘤嘤嘤嘤嘤...",
	ANNOUNCE_BOOMERANG = "抓住它们!",
	ANNOUNCE_CHARLIE = "诶?",
	ANNOUNCE_CHARLIE_ATTACK = "那是什么啊...呜呜呜...",

	ANNOUNCE_COLD = "好...冷",
	ANNOUNCE_HOT = "头发要烧起来了...",
	ANNOUNCE_CRAFTING_FAIL = "缺点东西...",
	ANNOUNCE_DEERCLOPS = "喜欢的...",
	ANNOUNCE_CAVEIN = "诶!?",
	ANNOUNCE_ANTLION_SINKHOLE = 
	{
		"快跑!地下有东西!",
		"啊啊啊啊啊——",
		"好可怕!",
	},
	ANNOUNCE_ANTLION_TRIBUTE =
	{
        "你好，沙子里的大家伙~",
        "我给你带了这个~",
        "这个送给你！",
	},
	ANNOUNCE_SACREDCHEST_YES = "可以~",
	ANNOUNCE_SACREDCHEST_NO = "哼~",
    ANNOUNCE_DUSK = "黄昏...来了呢...",

	ANNOUNCE_EAT =
	{
		GENERIC = "嗷呜~",
		PAINFUL = "怪物的肉不是很好消化...",
		SPOILED = "已经不敢吃这种东西了。",
		STALE = "有点变味了？",
		INVALID = "我宁愿饿死...",
        YUCKY = "总比饿死好......",

    },
    ANNOUNCE_ENCUMBERED =
    {
        "真重......",
        "我力气要是大点就好了...",
        "有的时候我真不想背着它......",
        "能让别的什么人或者东西来背它吗？",
        "嗨呀...!",
    },
    ANNOUNCE_ATRIUM_DESTABILIZING = 
    {
		"我觉得应该回家了...",
		"我想回家...",
		"我感觉到可怕的东西了...",
	},
    ANNOUNCE_RUINS_RESET = "我能听到这里的低语，救命!",
    ANNOUNCE_SNARED = "骨头笼子!",
    ANNOUNCE_REPELLED = "真的很吵......",
	ANNOUNCE_ENTER_DARK = "我需要光！",
	ANNOUNCE_ENTER_LIGHT = "感谢光...",
	ANNOUNCE_FREEDOM = "永别了！实验室！",
	ANNOUNCE_HIGHRESEARCH = "我能理解一切...",
	ANNOUNCE_HOUNDS = "那是什么?",
	ANNOUNCE_WORMS = "有东西来了...",
	ANNOUNCE_HUNGRY =
    {
        "呜...好想吃肉...",
		"我饿了...",
		"我想吃东西...",
	},
	ANNOUNCE_HUNT_BEAST_NEARBY = "巨大的生物",
	ANNOUNCE_HUNT_LOST_TRAIL = "啊...跟丢了",
	ANNOUNCE_HUNT_LOST_TRAIL_SPRING = "脚印不会留在这种地方",
	ANNOUNCE_INV_FULL = "包包装不下了...",
	ANNOUNCE_KNOCKEDOUT = "要晕了......",
	ANNOUNCE_LOWRESEARCH = "我没学懂！",
	ANNOUNCE_MOSQUITOS = "滚开！",
    ANNOUNCE_NOWARDROBEONFIRE = "我不可能在火里换衣服。",
    ANNOUNCE_NODANGERGIFT = "周 围 有 怪 物 在 游 荡 ！",
    ANNOUNCE_NOMOUNTEDGIFT = "牛背上怎么拆的了礼物",
	ANNOUNCE_NODANGERSLEEP = "换谁来都不能睡得着吧...",
	ANNOUNCE_NODAYSLEEP = "我很清醒！",
	ANNOUNCE_NODAYSLEEP_CAVE = "我还不困！",
	ANNOUNCE_NOHUNGERSLEEP = "我想，就算睡着了，我也会饿醒的。",
	ANNOUNCE_NOSLEEPONFIRE = "薇洛才敢睡这种帐篷...",
	ANNOUNCE_NODANGERSIESTA = "现在可不是午休的时候！",
	ANNOUNCE_NONIGHTSIESTA = "我可没有在晚上睡午觉的习惯！",
	ANNOUNCE_NONIGHTSIESTA_CAVE = "我还不累。",
	ANNOUNCE_NOHUNGERSIESTA = "我想，就算睡着了，我也会饿醒的...",
	ANNOUNCE_NODANGERAFK = "再见，灾祸。",
	ANNOUNCE_NO_TRAP = "比想象中的简单多了~",
	ANNOUNCE_PECKED = "你能不能乖一点？",
	ANNOUNCE_QUAKE = "要地震了......",
	ANNOUNCE_RESEARCH = "学一点是一点...",
	ANNOUNCE_SHELTER = "我有点怀念祈雨的那个小时候...",
	ANNOUNCE_THORNS = "你针凶！",
	ANNOUNCE_BURNT = "灰。",
	ANNOUNCE_TORCH_OUT = "你有火把吗！",
	ANNOUNCE_THURIBLE_OUT = "她熄灭了。",
	ANNOUNCE_FAN_OUT = "小风扇枯萎了。",
    ANNOUNCE_COMPASS_OUT = "这个指南针里的磁石死了。",
	ANNOUNCE_TRAP_WENT_OFF = "呃呃...",
	ANNOUNCE_UNIMPLEMENTED = "它还没部署好。",
	ANNOUNCE_WORMHOLE = "一根世界的管茎...？",
	ANNOUNCE_TOWNPORTALTELEPORT = "多么华丽的跃迁魔法！",
	ANNOUNCE_CANFIX = "该修理这堵墙了...",
	ANNOUNCE_ACCOMPLISHMENT = "I feel so accomplished!",
	ANNOUNCE_ACCOMPLISHMENT_DONE = "If only my friends could see me now...",	
	ANNOUNCE_INSUFFICIENTFERTILIZER = "需要养料么...小家伙。",
	ANNOUNCE_TOOL_SLIP = "它滑脱手了！！！",
	ANNOUNCE_LIGHTNING_DAMAGE_AVOIDED = "闪电永远慢我一步...",
	ANNOUNCE_TOADESCAPING = "它腻了。",
	ANNOUNCE_TOADESCAPED = "它跑掉了。",
	ANNOUNCE_DAMP = "湿掉了...",
	ANNOUNCE_WET = "咦...好湿...",
	ANNOUNCE_WETTER = "我的东西都要湿了...",
	ANNOUNCE_SOAKED = "这下和泡在水里没区别啦。",
	ANNOUNCE_WASHED_ASHORE = "我觉得我其实是在海里。",
    ANNOUNCE_DESPAWN = "有一束光...",
	ANNOUNCE_BECOMEGHOST = "呜...",
	ANNOUNCE_GHOSTDRAIN = "哇卟歪卜...",
	ANNOUNCE_PETRIFED_TREES = "那棵树死透了。",
	ANNOUNCE_KLAUS_ENRAGE = "它一定非常生气！",
	ANNOUNCE_KLAUS_UNCHAINED = "那些锁链松开了！",
	ANNOUNCE_KLAUS_CALLFORHELP = "它在叫谁？",
	ANNOUNCE_MOONALTAR_MINE =
	{
		GLASS_MED = "里面好像有什么。",		--暂无注释
		GLASS_LOW = "快出来了...",		--暂无注释
		GLASS_REVEAL = "如何评价新鲜空气？",		--暂无注释
		IDOL_MED = "里面有东西。",		--暂无注释
		IDOL_LOW = "快挖出来了~",		--暂无注释
		IDOL_REVEAL = "如何评价新鲜空气？",		--暂无注释
		SEED_MED = "里面有东西。",		--暂无注释
		SEED_LOW = "快挖出来了。",		--暂无注释
		SEED_REVEAL = "如何评价新鲜空气？",		--暂无注释
	},
    --hallowed nights
    ANNOUNCE_SPOOKED = "那是什么！？",
	ANNOUNCE_BRAVERY_POTION = "我现在并没有多怕他们了。",
	ANNOUNCE_MOONPOTION_FAILED = "可能我得多待一会儿。",
    --lavaarena event
    ANNOUNCE_REVIVING_CORPSE = "花苞绽放...！",
    ANNOUNCE_REVIVED_OTHER_CORPSE = "花苞绽放...",
    ANNOUNCE_REVIVED_FROM_CORPSE = "谢谢你...",
    ANNOUNCE_FLARE_SEEN = "有人放出了信号弹...我是不是该过去看看？",
    ANNOUNCE_OCEAN_SILHOUETTE_INCOMING = "是海怪...我一直想尝尝它的口感。",
   
    --quagmire event
    QUAGMIRE_ANNOUNCE_NOTRECIPE = "这起不了什么效。",
    QUAGMIRE_ANNOUNCE_MEALBURNT = "我忘记它太久了。",
    QUAGMIRE_ANNOUNCE_LOSE = "我感觉非常非常不好。",
    QUAGMIRE_ANNOUNCE_WIN = "该出发了！",

    ANNOUNCE_ROYALTY =
    {
        "蜜蜂之主！",
        "你好！大人物！",
        "蜂王陛下！",
    },

    ANNOUNCE_ATTACH_BUFF_ELECTRICATTACK    = "我是正电！",		--暂无注释
    ANNOUNCE_ATTACH_BUFF_ATTACK            = "动手！",		--暂无注释
    ANNOUNCE_ATTACH_BUFF_PLAYERABSORPTION  = "我安全到可以休息一会儿",		--暂无注释
    ANNOUNCE_ATTACH_BUFF_WORKEFFECTIVENESS = "生产力提高！",		--暂无注释
    ANNOUNCE_ATTACH_BUFF_MOISTUREIMMUNITY  = "干巴巴的。",		--暂无注释
    ANNOUNCE_ATTACH_BUFF_SLEEPRESISTANCE   = "神清气爽呢...",		--暂无注释
    ANNOUNCE_DETACH_BUFF_ELECTRICATTACK    = "电没了...?",		--暂无注释
    ANNOUNCE_DETACH_BUFF_ATTACK            = "不累啦。",		--暂无注释
    ANNOUNCE_DETACH_BUFF_PLAYERABSORPTION  = "虽然时间不长，但还不错呢。",		--暂无注释
    ANNOUNCE_DETACH_BUFF_WORKEFFECTIVENESS = "拖延症...",		--暂无注释
    ANNOUNCE_DETACH_BUFF_MOISTUREIMMUNITY  = "我的干旱期结束了。",		--暂无注释
    ANNOUNCE_DETACH_BUFF_SLEEPRESISTANCE   = "不累了......",		--暂无注释
	
   	BATTLECRY =
	{
		GENERIC = "对...对不起...原谅我...",
		PIG = "肉猪...对不起...嘻嘻...",
		PREY = "对...对不起...Wilson",
		SPIDER = "我尽量让你痛的短暂些...",
		SPIDER_WARRIOR = "抱..抱歉，弄疼你了...",
		DEER = "去死吧，活行肉！",
	},
	COMBAT_QUIT =
	{
		GENERIC = "我不想再看到它了。",
		PIG = "我改注意了。",
		PREY = "我追不上它。",
		SPIDER = "它太恶心了...算了...",
		SPIDER_WARRIOR = "黏液...我不想碰你了...",
	},
	DESCRIBE =
	{
		MULTIPLAYER_PORTAL = "那些是什么花？真顽强...",
        MULTIPLAYER_PORTAL_MOONROCK = "一个...很活跃的魔法球？",
        MOONROCKIDOL = "很有活力的石头...?",
        CONSTRUCTION_PLANS = "研究工具...?",

        ANTLION =
        {
            GENERIC = "你想要什么石头吗？",
            VERYHAPPY = "我也很喜欢你，大家伙！",
            UNHAPPY = "它好像不是很开心。",
        },
        ANTLIONTRINKET = "小花苗都不屑于玩这个的......吧...?",
        SANDSPIKE = "坏刺！叛徒!",
        SANDBLOCK = "没有什么意义的艺术品。",
        GLASSSPIKE = "作为一个尖刺来说，它还不够格。",
        GLASSBLOCK = "真漂亮，我喜欢它的光线折射。",
        ABIGAIL_FLOWER =
        {
            GENERIC ="哦，阿比盖尔...！",
            LONG = "你还在担心你的姐妹吗？",
            MEDIUM = "好的，阿比盖尔！",
            SOON = "没问题，阿比盖尔！",
            HAUNTED_POCKET = "我知道了。",
            HAUNTED_GROUND = "温蒂，你在哪儿？",
        },

        BALLOONS_EMPTY = "某种橡胶？",
        BALLOON = "这是什么漂浮魔法吗......？",

        BERNIE_INACTIVE =
        {
            BROKEN = "它的倔强还是不肯散去。",
            GENERIC = "尘归尘，土归土。",
        },

        BERNIE_ACTIVE = "熊熊卫士...你辛苦啦。",
        BERNIE_BIG = "不能让薇洛不开心。",

        BOOK_BIRDS = "我只知道这本书肯定和鸟有关系。",
        BOOK_TENTACLES = "药！药？我我我无意冒犯！",
        BOOK_GARDENING = "我小时候要是有这本书看就好了。",
        BOOK_SLEEP = "真的有点幼稚。",
        BOOK_BRIMSTONE = "我该把这本书烧了吗？",

        PLAYER =
        {
            GENERIC = "你好呀,%s!",
            ATTACKER = "%s 看起来不太好相处呀......",
            MURDERER = "你杀人也是为了吃肉吗？",
            REVIVER = "%s, 一颗心...",
            GHOST = "%s 需要一颗心。",
            FIRESTARTER = "烧掉...？%s.",
        },
        WILSON =
        {
            GENERIC = "一个精明绅士！",
            ATTACKER = "人类总是美味...",
            MURDERER = "谈心环节就到这里吧...%s!",
            REVIVER = "%s 这科学吗...科学家先生...",
            GHOST = "灵魂的合理之处！",
            FIRESTARTER = "它不会糊的...%s.",
        },
        WOLFGANG =
        {
            GENERIC = "Hi~大个子！%s!",
            ATTACKER = "我不觉得我力气比他大哎...",
            MURDERER = "你只是多了几块肥肉而已。",
            REVIVER = "%s ...我想起坚韧心脏的可口之处。",
            GHOST = "你的确无法和那种尺寸的东西抗衡。",
            FIRESTARTER = "你会枯萎的...%s!",
        },
        WAXWELL =
        {
            GENERIC = "向您问好！%s!",
            ATTACKER = "我们下次再见，小肉块绅士先生。",
            MURDERER = "你知道吗？花是因太阳光而长大的。",
            REVIVER = "%s在用黑色的力量做白色的事。",
            GHOST = "別瞪我，我尽力了。",
            FIRESTARTER = "%s看起来的确是想被烧焦。",
        },
        WX78 =
        {
            GENERIC = "你好！%s!",
            ATTACKER = "我其实不需要你的齿轮呢!",
            MURDERER = "......",
            REVIVER = "我看到你的灵魂在轻轻地漂浮...",
            GHOST = "机器人就不需要心吗？",
            FIRESTARTER = "你不会烧焦的对吧？对不对？",
        },
        WILLOW =
        {
            GENERIC = "温暖的薇洛！%s!",
            ATTACKER = "%s正在......点火吗...",
            MURDERER = "我什么都没看到...唔...",
            REVIVER = "%s是鬼魂的朋友。",
            GHOST = "让我想想办法...%s.",
            FIRESTARTER = "我知道你能处理好的。",
        },
        WENDY =
        {
            GENERIC = "支棱起来！%s!",
            ATTACKER = "%s你的“花”呢？",
            MURDERER = "我可以在阿比盖尔的面子上装作没看见。",
            REVIVER = "%s把魂灵当做亲人一样。",
            GHOST = "我需要两颗心？还是一颗？%s.",
            FIRESTARTER = "不许玩火！%s.",
        },
        WOODIE =
        {
            GENERIC = "你好......%s!",
            ATTACKER = "%s，那可不是树...", 		--Azureus
            MURDERER = "一个砍人的伐木工，砍树的刽子手。",
            REVIVER = "我猜%s偶尔也会种树？",
            GHOST = "我可以把你也装进斧子里，你想试一下吗？",
            BEAVER = "%s，獭的毛发比之前更茂密了...",
            BEAVERGHOST = "獭可能不懂高树...",
            MOOSE = "高速公鹿！",
            MOOSEGHOST = "%s大概冲得太猛了？",
            GOOSE = "现在看起来好吃多了...",
            GOOSEGHOST = "看来不止我这么想。",
            FIRESTARTER = "小心你的胡子, %s！",
        },
        WICKERBOTTOM =
        {
            GENERIC = "你好, %s!",
            ATTACKER = "我还以为学者不会打人...",
            MURDERER = "有人来把这写成小说吗？",
            FIRESTARTER = "啊，那对书籍保养不太好。",
        },
        WES =
        {
            GENERIC = "嗨, %s!",
            ATTACKER = "危险动作，请勿模仿。",
            MURDERER = "一个沉默的杀手，像食人花一样。",
            REVIVER = "%s有一个高尚的灵魂。",
            GHOST = "受到了那样的诅咒，这也是正常的事情。",
            FIRESTARTER = "那是你表演的一部分吗？",
        },
        WEBBER =
        {
            GENERIC = "你们好啊，%s!",
            ATTACKER = "现在是蜘蛛的部分占上风吗？",
            MURDERER = "%s可能真的变成了蜘蛛。",
            REVIVER = "有爱心的小家伙！",
            GHOST = "是不是有什么办法把%s分开？好吧，我不记得了。",
            FIRESTARTER = "小孩子不要玩火！",
        },
        WATHGRITHR =
        {
            GENERIC = "%s，你好呀",
            ATTACKER = "%s是不是有点太入戏了？",
            MURDERER = "%s的理性离她而去了。",
            REVIVER = "女武神一般是做相反的事情。",
            GHOST = "看来还不到%s去英灵殿的时候。",
            FIRESTARTER = "%s燃起来了！",
        },
        WINONA =
        {
            GENERIC = "你好吗，%s？",
            ATTACKER = "%s，有人惹到你了吗？",
            MURDERER = "为什么, %s？",
            REVIVER = "%s总是这么乐于助人。",
            GHOST = "让我想起她的妹妹。",
            FIRESTARTER = "真是热火朝天啊，%s。",
        },
        WORTOX =
        {
            GENERIC = "%s，你好啊！",
            ATTACKER = "%s真是旧习难改啊。",
            MURDERER = "本能总是这样难以克服。",
            REVIVER = "%s的人性闪耀着光芒...",
            GHOST = "魔鬼的鬼魂死掉会变成什么？",
            FIRESTARTER = "%s可能想家了？",
        },
        WORMWOOD =
        {
            GENERIC = "是%s！我该把它当做后辈吗？",
            ATTACKER = "植物也是会有攻击性的。",
            MURDERER = "我是不是没有成为一个好的榜样？",
            REVIVER = "那正是%s有别于普通植物的地方。",
            GHOST = "%s枯萎了...",
            FIRESTARTER = "火并不总是对植物有害。",
        },
        WARLY =
        {
            GENERIC = "哦，你好, %s!",
            ATTACKER = "%s可能想开发些新食材。",
            MURDERER = "那对%s来说是小菜一碟。",
            REVIVER = "%s总能把事情料理好。",
            GHOST = "真遗憾，他这样就没办法做饭了。",
            FIRESTARTER = "嗯...露天烧烤派对？",
        },

        WURT =
        {
            GENERIC = "你好呀，%s!",
            ATTACKER = "%s可能在效仿她的血亲。",
            MURDERER = "大鱼吃小鱼，小鱼吃虾米。",
            REVIVER = "很好，%s，他们早晚会明白的。",
            GHOST = "普通的鱼人可没有这个。",
            FIRESTARTER = "%s，那可不是好玩的！",		--Azureus.
        },

        MIGRATION_PORTAL =
        {
            GENERIC = "花也会想念太阳。",
            OPEN = "我会抵达哪里呢?",
            FULL = "我进不去。",
        },
        GLOMMER = 
        {
            GENERIC = "这个可爱的小家伙就是为花而生的。",
            SLEEPING = "嘘......",
        },
        GLOMMERFLOWER =
        {
            GENERIC = "你亮起来了！你也在开心吗？",
            DEAD = "它有点蔫了...？我不太确定它怎么了...",
        },
        GLOMMERWINGS = "对...对不起！我一定是昏了头了！",
        GLOMMERFUEL = "世界花...会喜欢这团粘粘吗？",
        BELL = "它真好听。",
        STATUEGLOMMER =
        {
            GENERIC = "花朵小飞虫...还是什么小精灵？",
            EMPTY = "对不起...!我没想着砸坏你的！！！",
        },

        LAVA_POND_ROCK = "“岩”热的造物......",
		WEBBERSKULL = "“骨组织由钙和磷混合构成。”",
		WORMLIGHT = "荧光！",
		WORMLIGHT_LESSER = "你发育不良了吗？",
		WORM =
		{
		    PLANT = "很...奇怪......",
		    DIRT = "我确信它是活的...",
		    WORM = "一个一个巨型蠕虫！",
		},
        WORMLIGHT_PLANT = "你好呀？",
		MOLE =
		{
			HELD = "它或许会很多汁。",
			UNDERGROUND = "我有预感，它煮熟了会有细腻的口感。",
			ABOVEGROUND = "可爱的，可口的小生灵。",
		},
		MOLEHILL = "一个小洞穴。",
		MOLEHAT = "我有点不喜欢这种肉做的装备。",

		EEL = "鳗鱼！一定！非常！好吃！",
		EEL_COOKED = "好香好香好香好香好香！",
		UNAGI = "我要骄傲地吃掉它！",
		EYETURRET = "别看我！",
		EYETURRET_ITEM = "它看起来在打瞌睡。",
		MINOTAURHORN = "好坚实哦。",
		MINOTAURCHEST = "我想说，毒蘑菇基本都很艳丽。",
		THULECITE_PIECES = "矿石的碎片。",
		POND_ALGAE = "你好，小水藻。",
		GREENSTAFF = "真是危险的魔法。",
		GIFT = "一个礼物！",
        GIFTWRAP = "打包工具。",
		POTTEDFERN = "你像家养小猫咪一样乖......",
        SUCCULENT_POTTED = "你好呀，小家伙。",
		SUCCULENT_PLANT = "认不太出来...某种远方朋友？",
		SUCCULENT_PICKED = "肉肉的小可爱。",
		SENTRYWARD = "某种.....魔法科技？",
        TOWNPORTAL =
        {
			GENERIC = "一个金字塔吗？",
			ACTIVE = "我感受到了某种魔力...",
		},
        TOWNPORTALTALISMAN = 
        {
			GENERIC = "一个小小魔法石。",
			ACTIVE = "还是走路好。",
		},
        WETPAPER = "水分要是能从里面跑出来就好了。",
        WETPOUCH = "皱巴巴的。",
        MOONROCK_PIECES = "我要打碎它吗？",
        MOONBASE =
        {
            GENERIC = "我要在里面种一粒种子吗？",
            BROKEN = "唔，搞砸啦。",
            STAFFED = "我想不出来。",
            WRONGSTAFF = "这样吗？",
            MOONSTAFF = "真神秘...",
        },
        MOONDIAL = 
        {
			GENERIC = "这一定有着某种魔法！",
			NIGHT_NEW = "新月！",
			NIGHT_WAX = "圆月？",
			NIGHT_FULL = "满月！",
			NIGHT_WANE = "月亮变小了。",
			CAVE = "我觉得洞穴里并不会看的到月亮。",
        },
		THULECITE = "伟大的矿物。",
		ARMORRUINS = "真轻。",
		ARMORSKELETON = "这是一件魔法骨盔。",
		SKELETONHAT = "我其实不太想戴上它。",
		RUINS_BAT = "伟大的武器！",
		RUINSHAT = "向您问好，芮塔殿下！",
		NIGHTMARE_TIMEPIECE =
		{
            CALM = "铥矿做的徽章。",
            WARN = "魔力暴动......",
            WAXING = "我觉得不太妙。",
            STEADY = "周遭魔力开始稳定下来了。",
            WANING = "快要消停下来了。",
            DAWN = "马上就要结束了。",
            NOMAGIC = "没有什么需要担心的。",
		},
		BISHOP_NIGHTMARE = "它受了重伤。",
		ROOK_NIGHTMARE = "它也受了重伤。",
		KNIGHT_NIGHTMARE = "它受了重伤。",
		MINOTAUR = "我最好离你远一点。",
		SPIDER_DROPPER = "唔......",
		NIGHTMARELIGHT = "它里面住着那种影怪。",
		NIGHTSTICK = "我是星之使者！",
		GREENGEM = "我有一颗绿宝石。",
		MULTITOOL_AXE_PICKAXE = "真是锋利。",
		ORANGESTAFF = "走路会更便利。",
		YELLOWAMULET = "暖乎乎的。",
		GREENAMULET = "真是高明的魔法！",
		SLURPERPELT = "我的奖章。",	
		SLURPER = "毛茸茸的。",
		SLURPER_PELT = "或许适合拿来当地毯。",
		ARMORSLURPER = "戴上之后我就可以假装我吃过午饭了。",
		ORANGEAMULET = "好玩的魔法。",
		YELLOWSTAFF = "我有一根黄色的法杖。",
		YELLOWGEM = "一颗香蕉宝石。",
		ORANGEGEM = "一颗橘子宝石。",
        OPALSTAFF = "月亮升起，星星来临！",
        OPALPRECIOUSGEM = "彩虹味的宝石。",
        TELEBASE = 
		{
			VALID = "可以出发了！",
			GEMS = "我得放个能源才能启动它。",
		},
		GEMSOCKET = 
		{
			VALID = "好像可以了。",
			GEMS = "这里缺了点什么。",
		},
		STAFFLIGHT = "一只小太阳。",
        STAFFCOLDLIGHT = "有点冷呀......",

        ANCIENT_ALTAR = "一个古代工作台。",
        ANCIENT_ALTAR_BROKEN = "它坏掉了。",
        ANCIENT_STATUE = "它真的属于这里吗？",

        LICHEN = "顽强的孩子。",
		CUTLICHEN = "可以吃，也可以不吃...",

		CAVE_BANANA = "光照不足的代价。",
		CAVE_BANANA_COOKED = "你可真不错呀。",
		CAVE_BANANA_TREE = "你好，香蕉。",
		ROCKY = "岩石大龙虾...我好像在哪本书里看到过。",
		
		COMPASS =
		{
			GENERIC="一个靠谱的指路工具。",
			N = "N",
			S = "S",
			E = "E",
			W = "W",
			NE = "N+E",
			SE = "S+E.",
			NW = "N+W",
			SW = "S+W",
		},

        HOUNDSTOOTH = "动物的刺。",
        ARMORSNURTLESHELL = "蜗牛的大壳。",
        BAT = "坏东西蝙蝠...",
        BATBAT = "你的遗物能助我再进一步。",
        BATWING = "死掉的蝙蝠才是好蝙蝠。",
        BATWING_COOKED = "死透了的蝙蝠更好。",
        BATCAVE = "真想一把火烧掉它。",
        BEDROLL_FURRY = "真暖和。",
        BUNNYMAN = "那是一只兔子人。",
        FLOWER_CAVE = "我能照亮他人......",
        GUANO = "我从来都不喜欢这种东西。",
        LANTERN = "一盏提灯。",
        LIGHTBULB = "一颗可爱的荧光果。",
        MANRABBIT_TAIL = "兔子尾巴？",
        MUSHROOMHAT = "可怜尸体做的小饰品。",
        MUSHROOM_LIGHT2 =
        {
            ON = "蓝色？",
            OFF = "我不明白这孩子在想什么。",
            BURNT = "坏耶...",
        },
        MUSHROOM_LIGHT =
        {
            ON = "你做的真棒。",
            OFF = "你睡着了？",
            BURNT = "哎呀......",
        },
        SLEEPBOMB = "一起睡觉吧？",
        MUSHROOMBOMB = "蘑菇炸弹？",
        SHROOM_SKIN = "有点...丑。",
        TOADSTOOL_CAP =
        {
            EMPTY = "别装了。",
            INGROUND = "我又不瞎。",
            GENERIC = "我就应该杀死它。",
        },
        TOADSTOOL =
        {
            GENERIC = "离我远一点！",
            RAGE = "它开始生气了。",
        },
        MUSHROOMSPROUT =
        {
            GENERIC = "真奇怪...",
            BURNT = "它被烧死了。",
        },
        MUSHTREE_TALL =
        {
            GENERIC = "得了巨人症的蓝蘑菇。",
            BLOOM = "真难闻！",
        },
        MUSHTREE_MEDIUM =
        {
            GENERIC = "真是可悲。",
            BLOOM = "它现在并不好闻。",
        },
        MUSHTREE_SMALL =
        {
            GENERIC = "又高又壮。",
            BLOOM = "动物到了繁殖时节也会有体味的...",
        },
        MUSHTREE_TALL_WEBBED = "韦伯会喜欢这个吗？",
        SPORE_TALL =
        {
            GENERIC = "飘啊飘...",
            HELD = "在我这里休息一会儿吧。",
        },
        SPORE_MEDIUM =
        {
            GENERIC = "我有点无所谓啦。",
            HELD = "我要用它照亮我的口袋。",
        },
        SPORE_SMALL =
        {
            GENERIC = "人生其实和飘荡的孢子差不了多少。",
            HELD = "我要用它照亮我的口袋。",
        },
        RABBITHOUSE =
        {
            GENERIC = "我饿了。",
            BURNT = "说实话，我很喜欢烤兔子。",
        },
        SLURTLE = "我还是别碰它的好。",
        SLURTLE_SHELLPIECES = "碎裂的角质吧？",
        SLURTLEHAT = "真有人喜欢这种收藏品吗？",
        SLURTLEHOLE = "真的很恶心...",
        SLURTLESLIME = "我们应当避免碰到这些东西。",
        SNURTLE = "杀死它没什么意义，但我确实想动手。",
        SPIDER_HIDER = "更难缠的蜘蛛。",
        SPIDER_SPITTER = "更加恶心的蜘蛛...",
        SPIDERHOLE = "满是蜘蛛的痕迹。",
        SPIDERHOLE_ROCK = "恶心的恶心石头。",
        STALAGMITE = "我看不太明白这是个石头。",
        STALAGMITE_TALL = "真想直接砸碎它。",
        TURF_CARPETFLOOR = "它曾经是一头牛？嗯，美味的牛？",
        TURF_CHECKERFLOOR = "优雅的大理石。",
        TURF_DIRT = "土和草的混合物。",
        TURF_FOREST = "我会在这上面种一棵可爱的树。",
        TURF_GRASS = "只是一块草皮罢了。",
        TURF_MARSH = "我在想，药药会住在那里面吗？",
        TURF_METEOR = "有月亮的香味。",
        TURF_PEBBLEBEACH = "一份岩石海滩。",
        TURF_ROAD = "帝国的基础！",
        TURF_ROCKY = "一些石子而已。",
        TURF_SAVANNA = "看到它，我有点怀念狮子的口感。",
        TURF_WOODFLOOR = "木制地板，尽显寒酸！",
		TURF_CAVE = "我比较确信大家都不会喜欢这个东西。",
		TURF_FUNGUS = "有多少人能安心的踩在这种东西上？",
		TURF_SINKHOLE = "踩上去黏黏的。",
		TURF_UNDERROCK = "洞穴里面的岩石。",
		TURF_MUD = "泥泞的土块。",
		TURF_DECIDUOUS = "有小木屋的气息。",
		TURF_SANDY = "沙漠？",
		TURF_BADLANDS = "我不太喜欢这种地皮。",
		TURF_DESERTDIRT = "一份沙漠。",
		TURF_FUNGUS_GREEN = "这只是...",
		TURF_FUNGUS_RED = "不可食用。",
		TURF_DRAGONFLY = "君主般的待遇。",

		POWCAKE = "芝士蛋糕？",
        CAVE_ENTRANCE = "一个被堵住的洞口？",
        CAVE_ENTRANCE_RUINS = "我马上就来砸开你！",
       
       	CAVE_ENTRANCE_OPEN = 
        {
            GENERIC = "我绝不会进去的！",
            OPEN = "我一点都不想靠近它。",
            FULL = "我绝不会进去的！",
        },
        CAVE_EXIT = 
        {
            GENERIC = "我宁可待在下面。",
            OPEN = "我改主意了。",
            FULL = "我暂时不想回去了。",
        },

		MAXWELLPHONOGRAPH = "陌生又熟悉的旋律。",
		BOOMERANG = "有的人能用它成就一段伟业。",
		PIGGUARD = "它或许不好惹，但一定很香脆。",
		ABIGAIL = "呀，阿比盖尔！你好！",
		ADVENTURE_PORTAL = "我又想试试它了。",
		AMULET = "额外的...生命！",
		ANIMAL_TRACK = "我一眼就看出来它会很好吃！",
		ARMORGRASS = "还不如不穿。",
		ARMORMARBLE = "在过去，只有强有力的人才配穿它。",
		ARMORWOOD = "一套坚韧的装甲。",
		ARMOR_SANITY = "这值得一穿。",
		ASH =
		{
			GENERIC = "我觉得世界上没有比这更可恨的东西了。",
			REMAINS_GLOMMERFLOWER = "它怎么化成灰烬了！",
			REMAINS_EYE_BONE = "它怎么化成灰烬了！",
			REMAINS_THINGIE = "只剩下了灰。",
		},
		AXE = "我还需要一把镐子...",
		BABYBEEFALO = 
		{
			GENERIC = "它肯定很...",
		    SLEEPING = "我不饿，但是饿了。",
        },
        BUNDLE = "装了一些东西。",
        BUNDLEWRAP = "是时候把一些东西打包起来了。",
		BACKPACK = "我有一个背包了。",
		BACONEGGS = "我希望培根能再多一些。",
		BANDAGE = "甜蜜的药药绷带...",
		BASALT = "坚不可摧的。",
		BEARDHAIR = "某个家伙的胡须。",
		BEARGER = "超大的熊哦。",
		BEARGERVEST = "穿上就会暖和到睡过去的。",
		ICEPACK = "保温小背包。",
		BEARGER_FUR = "我忘记那头熊的味道了。",
		BEDROLL_STRAW = "今晚就用草垫凑合一下吧。",
		BEEQUEEN = "我没有花蜜啊！",
		BEEQUEENHIVE = 
		{
			GENERIC = "我的鞋子都快粘住了...",
			GROWING = "快速浇筑？",
		},
        BEEQUEENHIVEGROWN = "难以想象动用了多少蜂工。",
        BEEGUARD = "真是忠心耿耿。",
        HIVEHAT = "叫我芮塔殿下！",
        MINISIGN =
        {
            GENERIC = "小木牌是这样的。",
            UNDRAWN = "我的画画水平可不低。",
        },
        MINISIGN_ITEM = "我要把你按进地里！",
		BEE =
		{
			GENERIC = "一只小蜜蜂。",
			HELD = "它不敢扎我的。",
		},
		BEEBOX =
		{
			READY = "可以采收一次了。",
			FULLHONEY = "蜂蜜都快溢出来了。",
			GENERIC = "它里面会有多少蜂蜜呢...？",
			NOHONEY = "我想里面应该是空的。",
			SOMEHONEY = "这个蜂箱是空的。",
			BURNT = "它和它们被烧死了。",
		},
		MUSHROOM_FARM =
		{
			STUFFED = "很多...蘑菇。",
			LOTS = "总之就是很多蘑菇。",
			SOME = "一些蘑菇...",
			EMPTY = "你们去哪了？",
			ROTTEN = "那块木头大概是死了。",
			BURNT = "它们被烧死了。",
			SNOWCOVERED = "那对于蘑菇来说太冷了...",		
		},
		BEEFALO =
		{
			FOLLOWER = "他在跟着我哎...",
			GENERIC = "块头很大。肉也很多。",
			NAKED = "像是叶子掉光了的灌木丛...",
			SLEEPING = "睡得很沉，看起来毫不设防。",
            --Domesticated states:
            DOMESTICATED = "我们大概可以做朋友？",
            ORNERY = "总是气冲冲的。",
            RIDER = "骑起来很舒服！",
            PUDGY = "胖乎乎毛茸茸的，手感很好。",
		},

		BEEFALOHAT = "用牛的边角料做的。",
		BEEFALOWOOL = "看起来像干草，不过闻起来不像。",
		BEEHAT = "有了它就能更安全地得到蜂蜜了。",
        BEESWAX = "嗯...这是不是可以用来保鲜？",
		BEEHIVE = "好吃的蜂蜜就藏在里面。",
		BEEMINE = "可以听见蜜蜂们的动静。",
		BEEMINE_MAXWELL = "沼泽里最常听见的声音之一。",
		BERRIES = "酸酸甜甜的，很好吃。",
		BERRIES_COOKED = "烤过的浆果别有一番风味。",
        BERRIES_JUICY = "比普通浆果多汁...所以也更容易坏。",
        BERRIES_JUICY_COOKED = "尽快吃完比较好哦？",
		BERRYBUSH =
		{
			BARREN = "它需要营养。",
			WITHERED = "普通的植物可受不了这个温度。",
			GENERIC = "真奇怪，我从来没见过它们开花。",
			PICKED = "过几天就会长出来的。",
			DISEASED = "它病了。",
			DISEASING = "怎么回事？",
			BURNING = "它烧起来了...",
		},
		BERRYBUSH_JUICY =
		{
			BARREN = "不施肥的话它是不会生长的。",
			WITHERED = "对于它来说太热了...",	
		},
    },
}
