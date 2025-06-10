GLOBAL.KKRENV =  env  --设定mod环境，方便调用mod内部的全局变量
CONFIG_VERSION = 1
--角色三维
TUNING.KKR_HEALTH = 150  --生命值，用tuning是因为这样才会在选人界面显示，否则就是问号了
TUNING.KKR_SANITY = 150
TUNING.KKR_HUNGER = 150


KKR_DAMAGEMULTIPLIER = GetModConfigData("kkr_atkmul")  --初始攻击倍率
KKR_SPEEDATKMUL = GetModConfigData("kkr_speedatkmul")  --移速增益的攻击倍率
KKR_HEALTHABSORB = 0  --初始防御
KKR_SPIRITCD = 120 --精灵生成速度
KKR_HEALAMOUNT = 1 --领域的回血量(飞行状态，地面状态的数值为飞行状态+1)
KKR_DOMAINCD = 60 --领域的cd

KkrFoodsDef = require("kkr_food_def")


KKR_FLY_SKILL = GetModConfigData("kkr_fly_skill") --飞行按键
KKR_DOMAIN_SKILL = GetModConfigData("kkr_domain_skill") --领域按键
KKR_DOMAIN_SKILL_ENABLE = GetModConfigData("kkr_domain_skill_enable")
KKR_FLY_SKILL_ENABLE = GetModConfigData("kkr_fly_skill_enable")
KKR_ATKBUFF_ENABLE = GetModConfigData("kkr_atkbuff_enable")
KKR_LUNGE_ENABLE = GetModConfigData("kkr_lunge_enable")