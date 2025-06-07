local damage_mult = GetModConfigData("damage_mult")
local cooldown_mult = GetModConfigData("cooldown_mult")
_G.YASUO =
{
    HEALTH = 200,
    HUNGER = 150,
    SANITY = 150,
    WAY_OF_WANDER_REGEN_AMOUNT = 5,
    WAY_OF_WANDER_REGEN_PERIOD = 1,
    SWORD =
    {
        DAMAGE = 51,
    },
    SKILLS =
    {
        STEEL_TEMPEST =
        {
            CD = 3 * cooldown_mult,
            DAMAGEMULTIPLIER = 2 * damage_mult,
        },
        WIND_WALL =
        {
            SUSTAIN = 10,
            CD = 20 * cooldown_mult,
        },
        SWEEPING_BLADE =
        {
            CD_ENEMY = 4,
            CD = 1 * cooldown_mult,
            DAMAGEMULTIPLIER = 0.8 * damage_mult
        },
        LAST_BREATH =
        {
            DAMAGE = 5 * damage_mult,
            SUSTAIN = 15,
            DAMAGEMULTIPLIER = 1.5,
            CD = 30 * cooldown_mult,
        }
    }
}

--添加这些变量, 用于选人界面的角色三维显示
TUNING.YASUO_HEALTH = YASUO.HEALTH
TUNING.YASUO_SANITY = YASUO.SANITY
TUNING.YASUO_HUNGER = YASUO.HUNGER

--添加这些变量, 用于选人界面的初始物品显示
TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.YASUO =
{
    "yasuo_sword"
}
TUNING.STARTING_ITEM_IMAGE_OVERRIDE.yasuo_sword =
{
    atlas = "images/inventoryimages/yasuo_sword.xml",
    image = "yasuo_sword.tex"
}