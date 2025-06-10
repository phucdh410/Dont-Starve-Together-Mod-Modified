GLOBAL.setmetatable(env, {
    __index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end
})
PrefabFiles = {
    'kkr',
    'kkr_gemstaff',
    'kkr_elfstaff',
    'kkr_elfstaff_plus',
    'kkr_elfrobe',
    'kkr_flower_ribbon',
    'kkr_elfcloak',
    'kkr_light',
    'kkr_flower_amulet',
    'kkr_ameth_amulet',
    'kkr_fx',
    'kkr_debuff',
    'kkr_wind_spirit',
    'kkr_newyear_staff',
    'kkr_pocket',
    'kkr_pocket_plus',
    'kkr_dragon_meat',
    'kkr_foods'
}

--mod文本
TUNING.KKR_LANGUAGE = GetModConfigData('Language')
if TUNING.KKR_LANGUAGE == true then
    modimport("kkrmain/strings")
else
    modimport("kkrmain/strings_en")
end
--mod全局变量
modimport("kkrmain/kkrtuning")
--皮肤api
modimport("kkrmain/skins")
--食物相关
modimport('kkrmain/kkrfood')
--制作栏相关
modimport("kkrmain/kkrrecipes")
--钩子，用于修改一些原生的物品或组件
modimport("kkrmain/kkrhook")
--动作相关
modimport("kkrmain/kkraction")
--容器相关
modimport("kkrmain/kkrcontainers")
--网络rpc定义
modimport("kkrmain/kkrrpc")
--长矛攻击SG
modimport("scripts/stategraphs/kkr_sg_attack")
--UI相关
modimport("kkrmain/kkrui")
--添加角色地图图标
AddMinimapAtlas("images/map_icons/kkr.xml")
--添加角色
AddModCharacter("kkr", "FEMALE")


