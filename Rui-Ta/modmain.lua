GLOBAL.setmetatable(
    env,
    {
        __index = function(t, k)
            return GLOBAL.rawget(GLOBAL, k)
        end
    }
)

TUNING.XXX3_WF_PRODUCEBUTTERFLY = GetModConfigData('xxx3_wf_producebutterfly')
TUNING.XXX3_WF_PRODUCEFIREFLY = GetModConfigData('xxx3_wf_producefirefly')
TUNING.XXX3_WF_PRODUCEITEM = GetModConfigData('xxx3_wf_produceitem')
TUNING.XXX3_ITEMDURING = GetModConfigData('xxx3_itemduring')
TUNING.XXX3_FOODVALUE = GetModConfigData('xxx3_foodvalue')

modimport('scripts/newtech_xxx3.lua')

PrefabFiles = {
    'xxx3',
    'xxx3_wf',
    'xxx3_sf',
    'xxx3_bf',
    'xxx3_sf_nf',
    'xxx3_hat',
    'xxx3_pollen',
    'xxx3_seed',
    'xxx3_food',
    'xxx3_ydg',
    'xxx3_bulbfx',
    'xxx3_tqbulbfx',
    'xxx3_shbulbfx',
    'xxx3_hhbulbfx',
    'xxx3_bouquet',
    'xxx3_killerbutterfly',
    'xxx3_butterflybuff',
    'xxx3_healthregenbuff',
    'xxx3_buffs',
    'xxx3_cane',
    'xxx3_flgun',
    'xxx3_flgun_projectile_hit_vfxeffect',
    'nl_essenceitem'
}

function AddPrefabFiles(...)
    for _, v in ipairs({...}) do
        table.insert(PrefabFiles, v)
    end
end
local function import(t)
    for _, v in ipairs(t) do
        modimport('main/' .. v)
    end
end
import {
    'myeyeplant'
}

Assets = {
    Asset('IMAGE', 'images/saveslot_portraits/xxx3.tex'),
    Asset('ATLAS', 'images/saveslot_portraits/xxx3.xml'),
    Asset('IMAGE', 'images/selectscreen_portraits/xxx3.tex'),
    Asset('ATLAS', 'images/selectscreen_portraits/xxx3.xml'),
    Asset('IMAGE', 'images/selectscreen_portraits/xxx3_silho.tex'),
    Asset('ATLAS', 'images/selectscreen_portraits/xxx3_silho.xml'),
    Asset('IMAGE', 'bigportraits/xxx3.tex'),
    Asset('ATLAS', 'bigportraits/xxx3.xml'),
    Asset('IMAGE', 'bigportraits/xxx3_none.tex'),
    Asset('ATLAS', 'bigportraits/xxx3_none.xml'),
    Asset('IMAGE', 'bigportraits/xxx3_victorian.tex'),
    Asset('ATLAS', 'bigportraits/xxx3_victorian.xml'),
    Asset('IMAGE', 'bigportraits/xxx3_shadow.tex'),
    Asset('ATLAS', 'bigportraits/xxx3_shadow.xml'),
    Asset('IMAGE', 'images/map_icons/xxx3.tex'),
    Asset('ATLAS', 'images/map_icons/xxx3.xml'),
    Asset('IMAGE', 'images/avatars/avatar_xxx3.tex'),
    Asset('ATLAS', 'images/avatars/avatar_xxx3.xml'),
    Asset('IMAGE', 'images/avatars/avatar_ghost_xxx3.tex'),
    Asset('ATLAS', 'images/avatars/avatar_ghost_xxx3.xml'),
    Asset('IMAGE', 'images/avatars/self_inspect_xxx3.tex'),
    Asset('ATLAS', 'images/avatars/self_inspect_xxx3.xml'),
    Asset('IMAGE', 'images/names_xxx3.tex'),
    Asset('ATLAS', 'images/names_xxx3.xml'),
    Asset('IMAGE', 'images/xxx3_butterfly.tex'),
    Asset('ATLAS', 'images/xxx3_butterfly.xml'),
    Asset('IMAGE', 'images/xxx3_wf.tex'),
    Asset('ATLAS', 'images/xxx3_wf.xml'),
    Asset('IMAGE', 'images/xxx3_sf.tex'),
    Asset('ATLAS', 'images/xxx3_sf.xml'),
    Asset('IMAGE', 'images/xxx3_bf.tex'),
    Asset('ATLAS', 'images/xxx3_bf.xml'),
    Asset('IMAGE', 'images/xxx3_lureplant.tex'),
    Asset('ATLAS', 'images/xxx3_lureplant.xml'),
    Asset('IMAGE', 'images/xxx3_hat.tex'),
    Asset('ATLAS', 'images/xxx3_hat.xml'),
    Asset('IMAGE', 'images/xxx3_springhat.tex'),
    Asset('ATLAS', 'images/xxx3_springhat.xml'),
    Asset('IMAGE', 'images/xxx3_summerhat.tex'),
    Asset('ATLAS', 'images/xxx3_summerhat.xml'),
    Asset('IMAGE', 'images/xxx3_autumnhat.tex'),
    Asset('ATLAS', 'images/xxx3_autumnhat.xml'),
    Asset('IMAGE', 'images/xxx3_winterhat.tex'),
    Asset('ATLAS', 'images/xxx3_winterhat.xml'),
    Asset('IMAGE', 'images/xxx3_pollen.tex'),
    Asset('ATLAS', 'images/xxx3_pollen.xml'),
    Asset('IMAGE', 'images/xxx3_seed.tex'),
    Asset('ATLAS', 'images/xxx3_seed.xml'),
    Asset('IMAGE', 'images/xxx3_hmhb.tex'),
    Asset('ATLAS', 'images/xxx3_hmhb.xml'),
    Asset('IMAGE', 'images/xxx3_hjmdj.tex'),
    Asset('ATLAS', 'images/xxx3_hjmdj.xml'),
    Asset('IMAGE', 'images/xxx3_hbsl.tex'),
    Asset('ATLAS', 'images/xxx3_hbsl.xml'),
    Asset('IMAGE', 'images/xxx3_ydg.tex'),
    Asset('ATLAS', 'images/xxx3_ydg.xml'),
    Asset('IMAGE', 'images/xxx3_hjdg.tex'),
    Asset('ATLAS', 'images/xxx3_hjdg.xml'),
    Asset('IMAGE', 'images/xxx3_nmtd.tex'),
    Asset('ATLAS', 'images/xxx3_nmtd.xml'),
    Asset('IMAGE', 'images/xxx3_bouquet.tex'),
    Asset('ATLAS', 'images/xxx3_bouquet.xml'),
    Asset('IMAGE', 'images/xxx3_flgun.tex'),
    Asset('ATLAS', 'images/xxx3_flgun.xml'),
    Asset('IMAGE', 'images/inventoryimages/nl_essence_nature.tex'),
    Asset('ATLAS', 'images/inventoryimages/nl_essence_nature.xml'),
    Asset('IMAGE', 'images/inventoryimages/xxx3_wf_seed.tex'),
    Asset('ATLAS', 'images/inventoryimages/xxx3_wf_seed.xml'),
    Asset('ANIM', 'anim/player_pistol.zip')
}

GLOBAL.SoraAPI = env
modimport('scripts/skins.lua')

AddMinimapAtlas('images/map_icons/xxx3.xml')

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local ACTIONS = GLOBAL.ACTIONS
local ActionHandler = GLOBAL.ActionHandler

STRINGS.CHARACTER_TITLES.xxx3 = 'Ruita'
STRINGS.CHARACTER_NAMES.xxx3 = 'Ruita'
STRINGS.CHARACTER_DESCRIPTIONS.xxx3 = "*Is a girl flower\n*Immune to attacks from eyeplants\n*Can plant the World Flower"
STRINGS.CHARACTER_QUOTES.xxx3 = '"Grow a field of flowers!"'
STRINGS.CHARACTER_SURVIVABILITY.xxx3 = 'Normal'

STRINGS.CHARACTERS.XXX3 = require 'speech_xxx3'

STRINGS.NAMES.XXX3 = 'Ruita'
STRINGS.SKIN_NAMES.xxx3_none = 'Ruita'

STRINGS.SKIN_NAMES.xxx3_victorian = 'Maid Ruita'
STRINGS.SKIN_QUOTES.xxx3_victorian = '"Need house service?"'
STRINGS.SKIN_DESCRIPTIONS.xxx3_victorian = 'Maid outfit Ruita'

STRINGS.SKIN_NAMES.xxx3_shadow = 'Tianqi Ruita'
STRINGS.SKIN_QUOTES.xxx3_shadow = '"I\'m just staring at you"'
STRINGS.SKIN_DESCRIPTIONS.xxx3_shadow = 'Tianqi Ruita'

STRINGS.SKIN_NAMES.xxx3_myth = 'Demon Flower Master Ruita'
STRINGS.SKIN_QUOTES.xxx3_myth = '"Does this flower look good?"'
STRINGS.SKIN_DESCRIPTIONS.xxx3_myth = 'Demon Flower Master Ruita'

STRINGS.SKIN_NAMES.xxx3_huohuo = 'Star Rail - Huohuo'
STRINGS.SKIN_QUOTES.xxx3_huohuo = '"I am... a zombie... please... don\'t hit me..."'
STRINGS.SKIN_DESCRIPTIONS.xxx3_huohuo = 'Is this Ruita dressed as Huohuo, or Huohuo dressed as Ruita?'

local skin_modes = {
    {
        type = 'ghost_skin',
        anim_bank = 'ghost',
        idle_anim = 'idle',
        scale = 0.75,
        offset = {0, -25}
    }
}

STRINGS.NAMES.XXX3_WF = 'World Flower'
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XXX3_WF = 'She is so beautiful'
STRINGS.RECIPE_DESC.XXX3_WF = 'Gather the beauty of the world'

STRINGS.NAMES.XXX3_WF_SEED = 'World Flower Seed'
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XXX3_WF_SEED = 'She will surely become beautiful'
STRINGS.RECIPE_DESC.XXX3_WF_SEED = 'Gather the beauty of the world'

STRINGS.NAMES.XXX3_HAT = 'Eyebrella Garland'
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XXX3_HAT = 'I am an eyeplant'
STRINGS.RECIPE_DESC.XXX3_HAT = 'I am an eyeplant'

STRINGS.NAMES.XXX3_SPRINGHAT = 'Venom Grass Garland'
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XXX3_SPRINGHAT = 'I am venom grass'
STRINGS.RECIPE_DESC.XXX3_SPRINGHAT = 'I am venom grass'

STRINGS.NAMES.XXX3_SUMMERHAT = 'Fire Dragon Grass Garland'
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XXX3_SUMMERHAT = 'I am fire dragon grass'
STRINGS.RECIPE_DESC.XXX3_SUMMERHAT = 'I am fire dragon grass'

STRINGS.NAMES.XXX3_AUTUMNHAT = 'Rock Thorn Grass Garland'
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XXX3_AUTUMNHAT = 'I am rock thorn grass'
STRINGS.RECIPE_DESC.XXX3_AUTUMNHAT = 'I am rock thorn grass'

STRINGS.NAMES.XXX3_WINTERHAT = 'Ice Hammer Grass Garland'
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XXX3_WINTERHAT = 'I am ice hammer grass'
STRINGS.RECIPE_DESC.XXX3_WINTERHAT = 'I am ice hammer grass'

STRINGS.NAMES.XXX3_SHADOWHAT = 'Shadow Grass Garland'
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XXX3_SHADOWHAT = 'I am shadow grass'
STRINGS.RECIPE_DESC.XXX3_SHADOWHAT = 'I am shadow grass'

STRINGS.NAMES.XXX3_LUNARHAT = 'Moon Grass Garland'
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XXX3_LUNARHAT = 'I am moon grass'
STRINGS.RECIPE_DESC.XXX3_LUNARHAT = 'I am moon grass'

STRINGS.NAMES.XXX3_SF = 'Golden Rose'
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XXX3_SF = 'Seems ripe'

STRINGS.NAMES.XXX3_SF_NF = 'Golden Rose'
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XXX3_SF_NF = 'Wait a bit longer to eat'

STRINGS.NAMES.XXX3_BF = 'Complete Flower'
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XXX3_BF = 'It is complete'
STRINGS.RECIPE_DESC.XXX3_BF = 'It is complete'

STRINGS.NAMES.XXX3_SEED = 'Golden Flower Seed'
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XXX3_SEED = 'Maybe it can grow something tasty'

STRINGS.NAMES.XXX3_POLLEN = 'Golden Pollen'
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XXX3_POLLEN = 'Seems edible'

STRINGS.NAMES.XXX3_YDG = 'Eden Fruit'
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XXX3_YDG = 'Golden legend!'

STRINGS.NAMES.XXX3_CHYDG = 'Rainbow Eden Fruit'
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XXX3_CHYDG = 'Colorful legend!'
STRINGS.RECIPE_DESC.XXX3_CHYDG = 'Colorful legend!'

STRINGS.NAMES.XXX3_BOUQUET = 'Bouquet'
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XXX3_BOUQUET = 'Maybe you can give it to someone you like'
STRINGS.RECIPE_DESC.XXX3_BOUQUET = 'Maybe you can give it to someone you like'

STRINGS.NAMES.XXX3_BOUQUET_SHADOW = 'Fear Bouquet'
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XXX3_BOUQUET_SHADOW = 'Love entwined with thorns in the shadows'
STRINGS.RECIPE_DESC.XXX3_BOUQUET_SHADOW = 'Love entwined with thorns in the shadows'

STRINGS.NAMES.XXX3_BOUQUET_LUNAR = 'Brilliant Bouquet'
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XXX3_BOUQUET_LUNAR = 'Warmth never lost in the moonlight'
STRINGS.RECIPE_DESC.XXX3_BOUQUET_LUNAR = 'Warmth never lost in the moonlight'

STRINGS.NAMES.XXX3_FLGUN_PLANT = 'Floral Gunner'
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XXX3_FLGUN_PLANT = 'Brings a beautiful finale'

STRINGS.NAMES.XXX3_FLGUN = 'Floral Gun'
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XXX3_FLGUN = 'Brings a beautiful finale'
STRINGS.RECIPE_DESC.XXX3_FLGUN = 'Brings a beautiful finale'

STRINGS.NAMES.XXX3_KILLERBUTTERFLY = 'Killer Butterfly'
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XXX3_KILLERBUTTERFLY = 'Beautiful death'

STRINGS.NAMES.XXX3_KILLERBUTTERFLY_SHADOW = 'Shadow Killer Butterfly'
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XXX3_KILLERBUTTERFLY_SHADOW = 'Dark threat'

STRINGS.NAMES.XXX3_KILLERBUTTERFLY_LUNAR = 'Moon Killer Butterfly'
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XXX3_KILLERBUTTERFLY_LUNAR = 'Gorgeous finale'

STRINGS.NAMES.XXX3_EYEPLANT_0 = "Ruita's Eyeplant"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XXX3_EYEPLANT_0 = 'Such big eyes!'

STRINGS.NAMES.XXX3_EYEPLANT_1 = 'Venom Grass'
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XXX3_EYEPLANT_1 = 'A big flower!'

STRINGS.NAMES.XXX3_EYEPLANT_2 = 'Fire Dragon Grass'
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XXX3_EYEPLANT_2 = 'Looks dangerous!'

STRINGS.NAMES.XXX3_EYEPLANT_3 = 'Rock Thorn Grass'
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XXX3_EYEPLANT_3 = "I don't want to hit it by hand."

STRINGS.NAMES.XXX3_EYEPLANT_4 = 'Ice Hammer Grass'
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XXX3_EYEPLANT_4 = "I'm curious how it grows."

STRINGS.NAMES.XXX3_EYEPLANT_SHADOW = 'Shadow Grass'
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XXX3_EYEPLANT_SHADOW = "It's so scary!"

STRINGS.NAMES.XXX3_EYEPLANT_LUNAR = 'Moon Grass'
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XXX3_EYEPLANT_LUNAR = "It's so crazy!"

STRINGS.NAMES.NL_ESSENCE_NATURE = 'Nature Essence'
STRINGS.CHARACTERS.GENERIC.DESCRIBE.NL_ESSENCE_NATURE = 'Magic energy surges within'
STRINGS.RECIPE_DESC.NL_ESSENCE_NATURE = 'Crystal of nature magic energy'

STRINGS.NAMES.TURF_XXX3_ITEM = 'Golden Flower Turf'
STRINGS.CHARACTERS.GENERIC.DESCRIBE.TURF_XXX3_ITEM = 'Full of the breath of life.'
STRINGS.RECIPE_DESC.TURF_XXX3_ITEM = 'Full of the breath of life.'

STRINGS.NAMES.XXX3_CANE = 'Golden Flower Cane'
STRINGS.CHARACTERS.GENERIC.DESCRIBE.XXX3_CANE = 'Full of life energy.'
STRINGS.RECIPE_DESC.XXX3_CANE = 'Golden Experience!'

AddMinimapAtlas('images/xxx3_wf.xml')
AddMinimapAtlas('images/xxx3_sf.xml')

AddRecipe2(
    'xxx3_butterfly',
    {Ingredient('petals', 1)},
    nil,
    {builder_tag = 'xxx3', atlas = 'images/xxx3_butterfly.xml', image = 'xxx3_butterfly.tex', product = 'butterfly'},
    {'CHARACTER', 'GARDENING'}
)

AddRecipe2(
    'xxx3_wf_seed',
    {Ingredient('seeds', 1), Ingredient('petals', 40)},
    nil,
    {builder_tag = 'xxx3', atlas = 'images/inventoryimages/xxx3_wf_seed.xml', image = 'xxx3_wf_seed.tex'},
    {'CHARACTER', 'PROTOTYPERS', 'GARDENING'}
)

AddRecipe2(
    'xxx3_lureplant',
    {Ingredient('xxx3_seed', 1, 'images/xxx3_seed.xml'), Ingredient('xxx3_pollen', 10, 'images/xxx3_pollen.xml')},
    TECH.WF_ONE,
    {builder_tag = 'xxx3', atlas = 'images/xxx3_lureplant.xml', image = 'xxx3_lureplant.tex', product = 'lureplantbulb'},
    {'CHARACTER', 'GARDENING'}
)

AddRecipe2(
    'xxx3_plantmeat',
    {Ingredient('xxx3_seed', 10, 'images/xxx3_seed.xml')},
    TECH.WF_ONE,
    {
        builder_tag = 'xxx3',
        product = 'plantmeat',
        numtogive = 10
    },
    {'CHARACTER', 'REFINE', 'GARDENING'}
)

AddRecipe2(
    'xxx3_hat',
    {Ingredient('petals', 30), Ingredient('lureplantbulb', 1)},
    TECH.WF_ONE,
    {builder_tag = 'xxx3', atlas = 'images/xxx3_hat.xml', image = 'xxx3_hat.tex'},
    {'CHARACTER', 'CLOTHING'}
)

AddRecipe2(
    'xxx3_springhat',
    {
        Ingredient('xxx3_hat', 1, 'images/xxx3_hat.xml'),
        Ingredient('oceanfish_small_7_inv', 1),
        Ingredient('shroom_skin', 1)
    },
    TECH.WF_ONE,
    {builder_tag = 'xxx3', atlas = 'images/xxx3_springhat.xml', image = 'xxx3_springhat.tex'},
    {'CHARACTER', 'CLOTHING'}
)

AddRecipe2(
    'xxx3_summerhat',
    {
        Ingredient('xxx3_hat', 1, 'images/xxx3_hat.xml'),
        Ingredient('oceanfish_small_8_inv', 1),
        Ingredient('dragon_scales', 1)
    },
    TECH.WF_ONE,
    {builder_tag = 'xxx3', atlas = 'images/xxx3_summerhat.xml', image = 'xxx3_summerhat.tex'},
    {'CHARACTER', 'CLOTHING'}
)

AddRecipe2(
    'xxx3_autumnhat',
    {
        Ingredient('xxx3_hat', 1, 'images/xxx3_hat.xml'),
        Ingredient('oceanfish_small_6_inv', 1),
        Ingredient('townportaltalisman', 5)
    },
    TECH.WF_ONE,
    {builder_tag = 'xxx3', atlas = 'images/xxx3_autumnhat.xml', image = 'xxx3_autumnhat.tex'},
    {'CHARACTER', 'CLOTHING'}
)

AddRecipe2(
    'xxx3_winterhat',
    {
        Ingredient('xxx3_hat', 1, 'images/xxx3_hat.xml'),
        Ingredient('oceanfish_medium_8_inv', 1),
        Ingredient('deerclops_eyeball', 1)
    },
    TECH.WF_ONE,
    {builder_tag = 'xxx3', atlas = 'images/xxx3_winterhat.xml', image = 'xxx3_winterhat.tex'},
    {'CHARACTER', 'CLOTHING'}
)

AddRecipe2(
    'xxx3_shadowhat',
    {
        Ingredient('xxx3_hat', 1, 'images/xxx3_hat.xml'),
        Ingredient('skeletonhat', 1),
        Ingredient('nightmarefuel', 8)
    },
    TECH.WF_ONE,
    {builder_tag = 'xxx3', atlas = 'images/xxx3_shadowhat.xml', image = 'xxx3_shadowhat.tex'},
    {'CHARACTER', 'CLOTHING'}
)

AddRecipe2(
    'xxx3_lunarhat',
    {
        Ingredient('xxx3_hat', 1, 'images/xxx3_hat.xml'),
        Ingredient('alterguardianhat', 1),
        Ingredient('moonglass_charged', 5)
    },
    TECH.WF_ONE,
    {builder_tag = 'xxx3', atlas = 'images/xxx3_lunarhat.xml', image = 'xxx3_lunarhat.tex'},
    {'CHARACTER', 'CLOTHING'}
)

AddRecipe2(
    'xxx3_nl_essence_nature',
    {Ingredient('butterfly', 10)},
    TECH.WF_ONE,
    {
        builder_tag = 'xxx3',
        atlas = 'images/inventoryimages/nl_essence_nature.xml',
        image = 'nl_essence_nature.tex',
        product = 'nl_essence_nature'
    },
    {'CHARACTER', 'REFINE'}
)

AddRecipe2(
    'turf_xxx3_item',
    {Ingredient('turf_grass', 4), Ingredient('xxx3_pollen', 5, 'images/xxx3_pollen.xml')},
    TECH.WF_ONE,
    {
        builder_tag = 'xxx3',
        atlas = 'images/inventoryimages/xxx3_turf_item.xml',
        image = 'xxx3_turf_item.tex',
        numtogive = 4
    },
    {'CHARACTER', 'DECOR'}
)

AddRecipe2(
    'xxx3_cane',
    {
        Ingredient('cane', 1),
        Ingredient('nl_essence_nature', 2, 'images/inventoryimages/nl_essence_nature.xml'),
        Ingredient('xxx3_pollen', 99, 'images/xxx3_pollen.xml')
    },
    TECH.WF_ONE,
    {builder_tag = 'xxx3', atlas = 'images/inventoryimages/xxx3_cane.xml', image = 'xxx3_cane.tex'},
    {'CHARACTER', 'TOOLS', 'MAGIC'}
)

AddRecipe2(
    'xxx3_bf',
    {Ingredient('petals', 10)},
    TECH.WF_ONE,
    {builder_tag = 'xxx3', atlas = 'images/xxx3_bf.xml', image = 'xxx3_bf.tex'},
    {'CHARACTER', 'REFINE'}
)

AddRecipe2(
    'xxx3_bouquet',
    {Ingredient('xxx3_bf', 9), Ingredient('nl_essence_nature', 1, 'images/inventoryimages/nl_essence_nature.xml')},
    TECH.WF_ONE,
    {builder_tag = 'xxx3', atlas = 'images/xxx3_bouquet.xml', image = 'xxx3_bouquet.tex'},
    {'CHARACTER', 'WEAPONS', 'MAGIC'}
)

AddRecipe2(
    'xxx3_bouquet_shadow',
    {
        Ingredient('xxx3_bouquet', 1, 'images/xxx3_bouquet.xml'),
        Ingredient('horrorfuel', 3),
        Ingredient('voidcloth', 1)
    },
    TECH.WF_ONE,
    {builder_tag = 'xxx3', atlas = 'images/xxx3_bouquet_shadow.xml', image = 'xxx3_bouquet_shadow.tex'},
    {'CHARACTER', 'WEAPONS', 'MAGIC'}
)

AddRecipe2(
    'xxx3_bouquet_lunar',
    {
        Ingredient('xxx3_bouquet', 1, 'images/xxx3_bouquet.xml'),
        Ingredient('purebrilliance', 3),
        Ingredient('lunarplant_husk', 3)
    },
    TECH.WF_ONE,
    {builder_tag = 'xxx3', atlas = 'images/xxx3_bouquet_lunar.xml', image = 'xxx3_bouquet_lunar.tex'},
    {'CHARACTER', 'WEAPONS', 'MAGIC'}
)

AddRecipe2(
    'xxx3_flgun',
    {
        Ingredient('xxx3_bf', 5),
        Ingredient('nl_essence_nature', 3, 'images/inventoryimages/nl_essence_nature.xml'),
        Ingredient('gunpowder', 5)
    },
    TECH.WF_ONE,
    {builder_tag = 'xxx3', atlas = 'images/xxx3_flgun.xml', image = 'xxx3_flgun.tex'},
    {'CHARACTER', 'WEAPONS', 'MAGIC'}
)

AddRecipe2(
    'xxx3_chydg',
    {
        Ingredient('xxx3_ydg', 1, 'images/xxx3_ydg.xml'),
        Ingredient('xxx3_nmtd', 1, 'images/xxx3_nmtd.xml'),
        Ingredient('nl_essence_nature', 5, 'images/inventoryimages/nl_essence_nature.xml')
    },
    TECH.WF_ONE,
    {builder_tag = 'xxx3', atlas = 'images/xxx3_chydg.xml', image = 'xxx3_chydg.tex'},
    {'CHARACTER', 'REFINE', 'GARDENING'}
)

AddModCharacter('xxx3', 'FEMALE', skin_modes)

modimport('scripts/xxx3_foods')
modimport('scripts/xxx3_turf')

AddPrefabPostInit(
    'eyeplant',
    function(inst)
        if TheWorld.ismastersim then
            local RETARGET_MUST_TAGS = {'_combat', '_health'}
            local RETARGET_CANT_TAGS = {'INLIMBO', 'plantkin'}
            local RETARGET_ONEOF_TAGS = {'character', 'monster', 'animal', 'prey', 'eyeplant', 'lureplant'}
            local function retargetfn(inst)
                return FindEntity(
                    inst,
                    TUNING.EYEPLANT_ATTACK_DIST,
                    function(guy)
                        return not (guy.components.health:IsDead() or guy:HasTag('eyeplant_friend') or
                            guy:HasTag('eyeplant') or
                            guy:HasTag('lureplant'))
                    end,
                    RETARGET_MUST_TAGS,
                    RETARGET_CANT_TAGS,
                    RETARGET_ONEOF_TAGS
                )
            end
            inst.components.combat:SetRetargetFunction(0.2, retargetfn)
        end
    end
)

AddPrefabPostInit(
    'chester',
    function(inst)
        if TheWorld.ismastersim then
            inst:AddTag('eyeplant_friend')
        end
    end
)

AddPrefabPostInit(
    'hutch',
    function(inst)
        if TheWorld.ismastersim then
            inst:AddTag('eyeplant_friend')
        end
    end
)

local containers = require('containers')
local params = containers.params

params.xxx3_flgun = {
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

function params.xxx3_flgun.itemtestfn(container, item, slot)
    return item.prefab == 'xxx3_pollen' or item.prefab == 'xxx3_ydg' or item.prefab == 'nl_essence_nature' or
        item.prefab == 'xxx3_seed' or
        item.prefab == 'xxx3_chydg'
end

params.xxx3_flgun_plant = {
    widget = {
        slotpos = {
            Vector3(0, 32, 0)
        },
        animbank = 'ui_cookpot_1x2',
        animbuild = 'ui_cookpot_1x2',
        pos = Vector3(0, 200, 0),
        side_align_tip = 160
    },
    type = 'chest'
}

function params.xxx3_flgun_plant.itemtestfn(container, item, slot)
    return item.prefab == 'xxx3_pollen' or item.prefab == 'xxx3_ydg' or item.prefab == 'nl_essence_nature' or
        item.prefab == 'xxx3_seed' or
        item.prefab == 'xxx3_chydg'
end

for k, v in pairs(params) do
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end

local function autoeat(inst, data)
    if data.newpercent and data.newpercent < .25 then
        local items =
            inst.components.inventory:FindItems(
            function(item)
                return item.components.edible and item.components.edible.hungervalue > 0 and item.components.perishable
            end
        )

        for _, item in ipairs(items) do
            if inst.components.eater:CanEat(item) then
                inst.components.eater:Eat(item)
                break
            end
        end
    end
end

local bulb_state =
    State {
    name = 'xxx3_turnintobulb',
    tags = {'hiding', 'notalking', 'nomorph', 'busy', 'nopredict', 'nodangle', 'drowning'},
    onenter = function(inst)
        inst.components.hunger.burnratemodifiers:SetModifier(inst, 4.0, 'quickconsume')
        inst:ListenForEvent('hungerdelta', autoeat)
        inst.check_starve =
            inst:DoPeriodicTask(
            3.5,
            function()
                if inst.components.hunger:IsStarving() then
                    local items =
                        inst.components.inventory:FindItems(
                        function(item)
                            return item.components.edible and item.components.edible.hungervalue > 0 and
                                item.components.perishable
                        end
                    )
                    for _, item in ipairs(items) do
                        if inst.components.eater:CanEat(item) then
                            inst.components.eater:Eat(item)
                            break
                        end
                    end
                end
            end
        )
        RemovePhysicsColliders(inst)
        inst.components.locomotor:Stop()
        if TheWorld.state.season == 'summer' then
            inst.components.health.fire_damage_scale = 0
        end
        inst.AnimState:PlayAnimation('hide')
        inst.AnimState:PushAnimation('hide_idle', false)
        inst.SoundEmitter:PlaySound('dontstarve/movement/foley/hidebush')
        inst.components.eater:SetStrongStomach(true) 
        inst.components.eater:SetCanEatRawMeat(true)
    end,
    onexit = function(inst)
        inst.components.hunger.burnratemodifiers:RemoveModifier(inst, 'quickconsume')
        inst:RemoveEventCallback('hungerdelta', autoeat)
        inst.components.eater:SetStrongStomach(false) 
        inst.components.eater:SetCanEatRawMeat(false)
        if inst.check_starve then
            inst.check_starve:Cancel()
        end

        if inst.bulbfx then
            inst.bulbfx:Remove()
            inst.bulbfx = nil
        end

        if inst.components.freezable then
            inst.components.freezable:SetResistance(4)
        end
        if inst.collectmyitems then
            inst.collectmyitems:Cancel()
        end
        if inst.components.xxx3_minionspawner then
            inst.components.xxx3_minionspawner.shouldspawn = false
            inst.components.xxx3_minionspawner:KillAllMinions()
            inst:RemoveComponent('xxx3_minionspawner')
        end
        inst.Physics:CollidesWith(COLLISION.WORLD)
        inst.Physics:CollidesWith(COLLISION.OBSTACLES)
        inst.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
        inst.Physics:CollidesWith(COLLISION.CHARACTERS)
        inst.Physics:CollidesWith(COLLISION.GIANTS)
        inst.components.xxx3_skill:SetEnabled(false)
        inst.components.health.fire_damage_scale = 1

        inst._lunarbulb = nil
    end
}
AddStategraphState('wilson', bulb_state)
AddStategraphState('wilson_client', bulb_state)

local VALID_TILE_TYPES = {
    [GROUND.DIRT] = true,
    [GROUND.SAVANNA] = true,
    [GROUND.GRASS] = true,
    [GROUND.FOREST] = true,
    [GROUND.MARSH] = true,
    -- CAVES
    [GROUND.CAVE] = true,
    [GROUND.FUNGUS] = true,
    [GROUND.SINKHOLE] = true,
    [GROUND.MUD] = true,
    [GROUND.FUNGUSRED] = true,
    [GROUND.FUNGUSGREEN] = true,
    --EXPANDED FLOOR TILES
    [GROUND.DECIDUOUS] = true,

    [WORLD_TILES.XXX3_TURF] = true,
    [WORLD_TILES.XXX3_TURF_SP] = true
}

local function OnCooldown(inst)
    inst._cdtask = nil
end

local function IsNotFull(inst, now)
    if inst == nil then
        return false
    end
    if not inst.components.inventory:IsFull() then
        return true
    else
        local items =
            inst.components.inventory:FindItems(
            function(item)
                return item.components.stackable ~= nil
            end
        )

        for i, item in ipairs(items) do
            if now.prefab == item.prefab and item.components.stackable and not item.components.stackable:IsFull() then
                return true
            end
        end
    end
    return false
end

local eattable = require('xxx3_table/eattable')

local function CollectItems(inst)
    if inst.components.xxx3_minionspawner.minions ~= nil then
        for k, v in pairs(inst.components.xxx3_minionspawner.minions) do
            if v.components.inventory ~= nil then
                for k = 1, v.components.inventory.maxslots do
                    local item = v.components.inventory.itemslots[k]
                    if item ~= nil and IsNotFull(inst, item) then
                        local it = v.components.inventory:RemoveItem(item)
                        inst.components.inventory:GiveItem(it)
                    elseif item ~= nil then
                        if inst.components.hunger and inst.components.hunger:GetPercent() < .25 then
                            if eattable[item.prefab] then
                                local health = eattable[item.prefab].health
                                local hunger = eattable[item.prefab].hunger
                                local sanity = eattable[item.prefab].sanity
                                if not inst.components.health:IsDead() then
                                    inst.components.health:DoDelta(health)
                                    inst.components.hunger:DoDelta(hunger)
                                    inst.components.sanity:DoDelta(sanity)
                                end
                                item:Remove()
                            elseif
                                item.components.edible and item.components.edible.hungervalue > 0 and
                                    item.components.perishable and
                                    inst.components.eater
                             then
                                inst.components.eater:Eat(item)
                            end
                        end
                    end
                end
            end
        end
    end
end

local function chooseeyeplant(inst)
    local inventory = inst.components.inventory or inst.replica.inventory
    if inst.components.xxx3_minionspawner then
        if inventory and inventory:EquipHasTag('xxx3_spechat') then
            if inventory:EquipHasTag('xxx3_summerhat') then
                inst.components.xxx3_minionspawner.miniontype = 'xxx3_eyeplant_2'
            elseif inventory:EquipHasTag('xxx3_winterhat') then
                inst.components.xxx3_minionspawner.miniontype = 'xxx3_eyeplant_4'
            elseif inventory:EquipHasTag('xxx3_autumnhat') then
                inst.components.xxx3_minionspawner.miniontype = 'xxx3_eyeplant_3'
            elseif inventory:EquipHasTag('xxx3_springhat') then
                inst.components.xxx3_minionspawner.miniontype = 'xxx3_eyeplant_1'
            elseif inventory:EquipHasTag('xxx3_shadowhat') then
                inst.components.xxx3_minionspawner.miniontype = 'xxx3_eyeplant_shadow'
            end
        else
            if TheWorld.state.season == 'summer' then
                inst.components.xxx3_minionspawner.miniontype = 'xxx3_eyeplant_2'
            elseif TheWorld.state.season == 'winter' then
                inst.components.xxx3_minionspawner.miniontype = 'xxx3_eyeplant_4'
            elseif TheWorld.state.season == 'autumn' then
                inst.components.xxx3_minionspawner.miniontype = 'xxx3_eyeplant_3'
            elseif TheWorld.state.season == 'spring' then
                inst.components.xxx3_minionspawner.miniontype = 'xxx3_eyeplant_1'
            end
        end
    end
end

local function gainhealth(inst)
    local healnum = 0.1
    local tile_type = inst:GetCurrentTileType()
    if tile_type == WORLD_TILES.XXX3_TURF or tile_type == WORLD_TILES.XXX3_TURF_SP then
        healnum = 0.5
    end
    inst.components.health:DoDelta(healnum, true)
    if inst.components.xxx3_skill.enabled == true then
        inst:DoTaskInTime(1, gainhealth)
    end
end

local function useskill(inst)
    inst._cdtask = inst:DoTaskInTime(1, OnCooldown)
    if inst.components.xxx3_skill.enabled == false then
        inst.components.xxx3_skill:SetEnabled(true)

        inst.sg:GoToState('xxx3_turnintobulb')
        if inst.components and inst.components.skinner then
            if inst.components.skinner.skin_name == 'xxx3_shadow' then
                inst.bulbfx = SpawnPrefab('xxx3_tqbulbfx')
            elseif inst.components.skinner.skin_name == 'xxx3_myth' then
                inst.bulbfx = SpawnPrefab('xxx3_shbulbfx')
            elseif inst.components.skinner.skin_name == 'xxx3_huohuo' then
                inst.bulbfx = SpawnPrefab('xxx3_hhbulbfx')
            else
                inst.bulbfx = SpawnPrefab('xxx3_bulbfx')
            end
        end
        inst.bulbfx.Transform:SetScale(2, 2, 2)
        inst.bulbfx:DoTaskInTime(
            0.5,
            function()
                inst.bulbfx.Transform:SetPosition(inst.Transform:GetWorldPosition())
            end
        )
        inst:DoTaskInTime(1, gainhealth)

        if inst.components.freezable then
            inst.components.freezable:SetResistance(300)
        end

        local inventory = inst.components.inventory or inst.replica.inventory
        if inventory and inventory:EquipHasTag('xxx3_lunarhat') then
            local x, y, z = inst.Transform:GetWorldPosition()
            local fx = SpawnPrefab('xxx3_eyeplant_lunar')
            fx.owner = inst
            fx.Transform:SetPosition(x, y - 4, z)
            inst._lunarbulb = true
        else
            inst:AddComponent('xxx3_minionspawner')
            chooseeyeplant(inst)
            inst.components.xxx3_minionspawner.validtiletypes = VALID_TILE_TYPES
            inst.components.xxx3_minionspawner.minionspawntime = {min = 0.08, max = 0.12}
            inst.components.xxx3_minionspawner.maxminions = 100
            inst.components.xxx3_minionspawner.distancemodifier = 10
            inst.components.xxx3_minionspawner.shouldspawn = true
            inst.components.xxx3_minionspawner:StartNextSpawn()
            inst.collectmyitems = inst:DoPeriodicTask(2.0, CollectItems)
        end
    else
        inst.sg:GoToState('idle')
    end
end

local function CheckSea(inst)
    local Pi = 3.14159265
    local num = 16
    local x, y, z = inst.Transform:GetWorldPosition()
    local r = 5
    for i = 0, num - 1, 1 do
        local db = i * 1.0
        local nx = math.cos(db / (num / 2) * Pi) * r
        local nz = math.sin(db / (num / 2) * Pi) * r
        if TheWorld.Map:IsVisualGroundAtPoint(x + nx, y, z + nz) == false then
            return false
        end
    end
    return true
end

local function GROW(inst)
    if
        not inst:HasTag('playerghost') and not inst.replica.health:IsDead() and inst.components.health.currenthealth > 0 and
            inst._cdtask == nil
     then
        if inst:HasTag('xxx3') and inst.components.rider and not inst.components.rider:IsRiding() then
            local x, y, z = inst.Transform:GetWorldPosition()
            local ents = TheSim:FindEntities(x, y, z, 5)
            local num = 0
            local hat = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
            if hat and hat.prefab == 'bushhat' then
                inst.components.talker:Say('I shouldn"t take root while wearing this!')
                return
            end
            if inst.components.xxx3_skill.enabled == false then
                for k, v in pairs(ents) do
                    if (v.prefab == 'xxx3' and v.components.xxx3_skill.enabled == true) or v.prefab == 'lureplant' then
                        inst.components.talker:Say('The nutrients here are too low, I should take root farther away!')
                        num = 1
                        break
                    end
                end
            end
            if num == 0 then
                if not CheckSea(inst) then
                    inst.components.talker:Say('I shouldn"t take root at the edge of a cliff!')
                else
                    useskill(inst)
                end
            end
        end
    end
end

AddModRPCHandler(modname, 'GROW', GROW)

TheInput:AddKeyDownHandler(
    GLOBAL.KEY_Z,
    function()
        local IsHUDscreen = GLOBAL.TheFrontEnd:GetActiveScreen() and GLOBAL.TheFrontEnd:GetActiveScreen().name == 'HUD'
        if IsHUDscreen then
            SendModRPCToServer(MOD_RPC[modname]['GROW'])
        end
    end
)

-- 收获食人花
local function collectitems(lureplant, inst)
    if lureplant == nil or lureplant.components.inventory == nil then
        return
    end

    local items =
        lureplant.components.inventory:FindItems(
        function(item)
            return not item:HasTag('nosteal') and
                (lureplant.components.shelf == nil or item ~= lureplant.components.shelf.itemonshelf)
        end
    )

    local judge = false
    for i, item in ipairs(items) do
        if not inst.components.inventory:IsFull() then
            lureplant.components.inventory:RemoveItem(item, true)
            inst.components.inventory:GiveItem(item)
            judge = true
        else
            inst.components.talker:Say('Can"t do it anymore...')
            return true
        end
    end
    return judge
end
AddPrefabPostInit(
    'lureplant',
    function(inst)
        if not inst.SoundEmitter then
            inst.entity:AddSoundEmitter()
        end
        if TheWorld.ismastersim then
            inst:AddComponent('lureplant_pick')
        end
    end
)
local lureplant_pick = Action({priority = 1, mount_valid = true})
lureplant_pick.id = 'LUREPLANT_PICK'
lureplant_pick.str = 'Collect'
lureplant_pick.fn = function(action)
    if action.doer and action.doer.prefab == 'xxx3' then
        if not collectitems(action.target, action.doer) then
            action.doer.components.talker:Say('Empty!')
        end
        return true
    else
        return false
    end
end
AddAction(lureplant_pick)
AddStategraphActionHandler('wilson', ActionHandler(lureplant_pick, 'dolongaction'))
AddStategraphActionHandler('wilson_client', ActionHandler(lureplant_pick, 'dolongaction'))
AddComponentAction(
    'SCENE',
    'lureplant_pick',
    function(inst, doer, actions, right)
        if doer:HasTag('xxx3') then
            table.insert(actions, lureplant_pick)
        end
    end
)

local function NewPickSg(sg)
    local old_pick = sg.actionhandlers[ACTIONS.PICK].deststate
    sg.actionhandlers[ACTIONS.PICK].deststate = function(inst, action)
        if not inst:HasTag('fastpicker') and inst:HasTag('xxx3_quickpick') then
            return 'attack'
        end
        return old_pick(inst, action)
    end
end
AddStategraphPostInit('wilson', NewPickSg)
AddStategraphPostInit('wilson_client', NewPickSg)

AddStategraphPostInit(
    'wilson',
    function(sg)
        local old_attacked = sg.events['attacked'].fn
        sg.events['attacked'].fn = function(inst, data)
            if not inst.components.health:IsDead() then
                local weapon = inst.components.combat and inst.components.combat:GetWeapon()
                if weapon and weapon:HasTag('xxx3_shoot') and inst.sg:HasStateTag('attack') then
                    return
                end
            end

            return old_attacked(inst, data)
        end
    end
)

AddStategraphPostInit(
    'wilson',
    function(sg)
        local old_ATTACK = sg.actionhandlers[ACTIONS.ATTACK].deststate
        sg.actionhandlers[ACTIONS.ATTACK].deststate = function(inst, action, ...)
            local weapon = inst.components.combat:GetWeapon()
            local is_riding = inst.components.rider:IsRiding()
            local is_dead =
                (inst.components.health and inst.components.health:IsDead()) or inst.sg:HasStateTag('dead') or
                inst:HasTag('playerghost')
            if weapon then
                if not is_riding and weapon:HasTag('xxx3_shoot') then
                    return 'xxx3_shoot'
                end
            else
            end

            return old_ATTACK(inst, action, ...)
        end
    end
)
AddStategraphPostInit(
    'wilson_client',
    function(sg)
        local old_ATTACK = sg.actionhandlers[ACTIONS.ATTACK].deststate
        sg.actionhandlers[ACTIONS.ATTACK].deststate = function(inst, action, ...)
            local weapon = inst.replica.combat:GetWeapon()
            local is_dead = inst.replica.health:IsDead()
            local is_riding = inst.replica.rider:IsRiding()

            if weapon then
                if not is_riding and weapon:HasTag('xxx3_shoot') then
                    return 'xxx3_shoot'
                end
            end
            return old_ATTACK(inst, action, ...)
        end
    end
)

AddStategraphState(
    'wilson',
    State {
        name = 'xxx3_shoot',
        tags = {'attack', 'notalking', 'abouttoattack', 'nopredict', 'busy'},
        onenter = function(inst)
            local buffaction = inst:GetBufferedAction()
            local target = buffaction ~= nil and buffaction.target or nil
            local equip = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            inst.components.combat:SetTarget(target)
            inst.components.combat:StartAttack()
            inst.components.locomotor:Stop()

            if not equip then
                inst.sg:GoToState('idle')
                return
            end

            inst.AnimState:PlayAnimation('hand_shoot')

            if equip.startgunsound then
                inst.SoundEmitter:PlaySound(equip.startgunsound)
            end

            if target ~= nil then
                inst.components.combat:BattleCry()
                if target:IsValid() then
                    inst:FacePoint(target:GetPosition())
                    inst.sg.statemem.attacktarget = target
                end
            end

            inst.sg.statemem.weapon = equip

            inst.sg:SetTimeout(20 * FRAMES)
        end,
        ontimeout = function(inst)
            inst.sg:RemoveStateTag('attack')
            inst.sg:AddStateTag('idle')
        end,
        timeline = {
            TimeEvent(
                17 * FRAMES,
                function(inst)
                    local weapon = inst.sg.statemem.weapon
                    inst:PerformBufferedAction()
                    if weapon and weapon:IsValid() then
                        inst.SoundEmitter:PlaySound(
                            weapon and weapon.gunshootsound or 'dontstarve_DLC003/common/items/weapon/blunderbuss_shoot'
                        )
                    end
                    inst.sg:RemoveStateTag('abouttoattack')
                end
            ),
            TimeEvent(
                20 * FRAMES,
                function(inst)
                    inst.sg:RemoveStateTag('attack')
                end
            ),
            TimeEvent(
                50 * FRAMES,
                function(inst)
                    inst:ClearBufferedAction()
                    inst.sg:GoToState('idle')
                end
            )
        },
        events = {
            EventHandler(
                'animover',
                function(inst)
                    inst.sg:GoToState('idle')
                end
            )
        }
    }
)

AddStategraphState(
    'wilson_client',
    State {
        name = 'xxx3_shoot',
        tags = {'attack', 'notalking', 'abouttoattack', 'busy'},
        onenter = function(inst)
            local weapon = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if not weapon then
                inst.sg:GoToState('idle')
                return
            end

            if inst.replica.combat ~= nil then
                inst.replica.combat:StartAttack()
            end
            inst.components.locomotor:Stop()

            inst.AnimState:PlayAnimation('hand_shoot')

            local buffaction = inst:GetBufferedAction()
            if buffaction ~= nil then
                inst:PerformPreviewBufferedAction()

                if buffaction.target ~= nil and buffaction.target:IsValid() then
                    inst:FacePoint(buffaction.target:GetPosition())
                    inst.sg.statemem.attacktarget = buffaction.target
                end
            end
            inst.sg:SetTimeout(20 * FRAMES)
        end,
        ontimeout = function(inst)
            inst.sg:RemoveStateTag('attack')
            inst.sg:AddStateTag('idle')
        end,
        timeline = {
            TimeEvent(
                17 * FRAMES,
                function(inst)
                    inst.sg:RemoveStateTag('abouttoattack')
                    inst:ClearBufferedAction()
                end
            ),
            TimeEvent(
                20 * FRAMES,
                function(inst)
                    inst.sg:RemoveStateTag('attack')
                end
            ),
            TimeEvent(
                50 * FRAMES,
                function(inst)
                    inst:ClearBufferedAction()
                    inst.sg:GoToState('idle')
                end
            )
        },
        events = {
            EventHandler(
                'animover',
                function(inst)
                    inst.sg:GoToState('idle')
                end
            )
        },
        onexit = function(inst)
            if inst.sg:HasStateTag('abouttoattack') and inst.replica.combat ~= nil then
                inst.replica.combat:CancelAttack()
            end
        end
    }
)

local upvaluehelper = require 'xxx3_upvaluehelper'

AddPrefabPostInit(
    'wolfgang',
    function(inst)
        local OnHitOther = upvaluehelper.GetEventHandle(inst, 'onhitother', 'prefabs/wolfgang')
        if OnHitOther then
            inst:RemoveEventCallback('onhitother', OnHitOther)
            inst:ListenForEvent(
                'onhitother',
                function(inst, data)
                    local target = data.target
                    if not (data.weapon ~= nil and data.weapon.components.inventoryitem == nil) then
                        OnHitOther(inst, data)
                    end
                end
            )
        end
    end
)

local xxx3_dressup_data = {
    xxx3_hat = {buildfile = 'xxx3_hat', buildsymbol = 'swap_hat'},
    xxx3_springhat = {buildfile = 'xxx3_springhat', buildsymbol = 'swap_hat'},
    xxx3_summerhat = {buildfile = 'xxx3_summerhat', buildsymbol = 'swap_hat'},
    xxx3_autumnhat = {buildfile = 'xxx3_autumnhat', buildsymbol = 'swap_hat'},
    xxx3_winterhat = {buildfile = 'xxx3_winterhat', buildsymbol = 'swap_hat'}
}

if not GLOBAL.rawget(GLOBAL, 'DRESSUP_DATA_LEGION') then
    GLOBAL.DRESSUP_DATA_LEGION = {}
end
for k, v in pairs(xxx3_dressup_data) do
    GLOBAL.DRESSUP_DATA_LEGION[k] = v
end
