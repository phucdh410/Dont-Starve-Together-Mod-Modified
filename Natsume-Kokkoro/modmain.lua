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

modimport("kkrmain/strings")

modimport("kkrmain/kkrtuning")

modimport("kkrmain/skins")

modimport('kkrmain/kkrfood')

modimport("kkrmain/kkrrecipes")

modimport("kkrmain/kkrhook")

modimport("kkrmain/kkraction")

modimport("kkrmain/kkrcontainers")

modimport("kkrmain/kkrrpc")

modimport("scripts/stategraphs/kkr_sg_attack")

modimport("kkrmain/kkrui")

AddMinimapAtlas("images/map_icons/kkr.xml")

AddModCharacter("kkr", "FEMALE")


