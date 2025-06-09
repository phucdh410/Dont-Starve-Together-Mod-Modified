local foods = {
    xxx3_hbsl = {
        --花瓣沙拉
        test = function(cooker, names, tags)
            --定义这个食物需要什么食材 ,完整的花*4
            return names.xxx3_bf and names.xxx3_bf == 4
        end,
        name = 'xxx3_hbsl', -- 料理名
        weight = 1, -- 食谱权重
        priority = 30, -- 食谱优先级
        foodtype = GLOBAL.FOODTYPE.VEGGIE, --菜类
        health = 50 * TUNING.XXX3_FOODVALUE,
        hunger = 25 * TUNING.XXX3_FOODVALUE,
        sanity = 0,
        perishtime = TUNING.PERISH_FAST, --6天
        cooktime = 0.1,
        potlevel = 'high',
        cookbook_tex = 'xxx3_hbsl.tex',
        cookbook_atlas = 'images/xxx3_hbsl.xml',
        floater = {'med', nil, 0.55},
        cookbook_category = 'cookpot',
        oneat_desc = '持续吸引蝴蝶'
    },
    xxx3_hjmdj = {
        --黄金蜜蝶卷
        test = function(cooker, names, tags)
            --定义这个食物需要什么食材 ,完整的花+黄金花粉+蝴蝶翅膀+蜂蜜
            return names.xxx3_bf and names.xxx3_pollen and names.butterflywings and names.honey
        end,
        name = 'xxx3_hjmdj', -- 料理名
        weight = 1, -- 食谱权重
        priority = 30, -- 食谱优先级
        foodtype = GLOBAL.FOODTYPE.VEGGIE, --菜类
        health = 35 * TUNING.XXX3_FOODVALUE,
        hunger = 50 * TUNING.XXX3_FOODVALUE,
        sanity = 20 * TUNING.XXX3_FOODVALUE,
        perishtime = TUNING.PERISH_MED, --10天
        cooktime = 0.2,
        potlevel = 'high',
        cookbook_tex = 'xxx3_hjmdj.tex',
        cookbook_atlas = 'images/xxx3_hjmdj.xml',
        floater = {'med', nil, 0.55},
        cookbook_category = 'cookpot'
    },
    xxx3_hmhb = {
        --花蜜汉堡
        test = function(cooker, names, tags)
            --定义这个食物需要什么食材 ,完整的花+黄金花粉+肉度大于=1
            return names.xxx3_bf and names.xxx3_pollen and tags.meat and tags.meat >= 1
        end,
        name = 'xxx3_hmhb', -- 料理名
        weight = 1, -- 食谱权重
        priority = 30, -- 食谱优先级
        foodtype = GLOBAL.FOODTYPE.MEAT, --肉类
        health = 15 * TUNING.XXX3_FOODVALUE,
        hunger = 112.5 * TUNING.XXX3_FOODVALUE,
        sanity = 5 * TUNING.XXX3_FOODVALUE,
        perishtime = TUNING.PERISH_SLOW, --15天
        cooktime = 0.6,
        potlevel = 'high',
        cookbook_tex = 'xxx3_hmhb.tex',
        cookbook_atlas = 'images/xxx3_hmhb.xml',
        floater = {'med', nil, 0.55},
        cookbook_category = 'cookpot'
    },
    xxx3_hjdg = {
        --黄金蛋糕
        test = function(cooker, names, tags)
            --定义这个食物需要什么食材 ,黄金花粉=4
            return names.xxx3_pollen and names.xxx3_pollen == 4
        end,
        name = 'xxx3_hjdg', -- 料理名
        weight = 1, -- 食谱权重
        priority = 30, -- 食谱优先级
        foodtype = GLOBAL.FOODTYPE.VEGGIE, --菜类
        health = 40 * TUNING.XXX3_FOODVALUE,
        hunger = 85 * TUNING.XXX3_FOODVALUE,
        sanity = 5 * TUNING.XXX3_FOODVALUE,
        perishtime = TUNING.PERISH_SLOW, --15天
        cooktime = 1,
        potlevel = 'high',
        cookbook_tex = 'xxx3_hjdg.tex',
        cookbook_atlas = 'images/xxx3_hjdg.xml',
        floater = {'med', nil, 0.55},
        cookbook_category = 'cookpot'
    },
    xxx3_nmtd = {
        --纳米糖豆
        test = function(cooker, names, tags)
            --定义这个食物需要什么食材 ,黄金花粉+蜂王浆+蝴蝶翅膀+甜度大于等于5
            return names.xxx3_pollen and names.royal_jelly and names.butterflywings and tags.sweetener and
                tags.sweetener >= 5
        end,
        name = 'xxx3_nmtd', -- 料理名
        weight = 1, -- 食谱权重
        priority = 30, -- 食谱优先级
        foodtype = GLOBAL.FOODTYPE.GOODIES, --零食类
        health = 0,
        hunger = 2,
        sanity = 0,
        perishtime = nil, --无
        cooktime = 2,
        potlevel = 'high',
        cookbook_tex = 'xxx3_nmtd.tex',
        cookbook_atlas = 'images/xxx3_nmtd.xml',
        floater = {'med', nil, 0.55},
        cookbook_category = 'cookpot'
    }
}

GLOBAL.XXX3_FOODS = foods

for k, recipe in pairs(foods) do
    AddCookerRecipe('cookpot', recipe)
    AddCookerRecipe('portablecookpot', recipe)
    recipe.cookbook_tex = k .. '.tex'
    recipe.cookbook_atlas = 'images/' .. k .. '.xml'
    RegisterInventoryItemAtlas('images/' .. k .. '.xml', k .. '.tex')
end

AddIngredientValues({'xxx3_pollen'}, {decoration = 1, sweetener = 1})
AddIngredientValues({'xxx3_bf'}, {decoration = 2})
RegisterInventoryItemAtlas('images/xxx3_pollen.xml', 'xxx3_pollen.tex')
RegisterInventoryItemAtlas('images/xxx3_bf.xml', 'xxx3_bf.tex')

-----------------------------------------------------------------------------

require('tuning')

TUNING.XXX3_FOODS_SPICED = {}
local function oneaten_garlic(inst, eater)
    eater:AddDebuff('buff_playerabsorption', 'buff_playerabsorption')
end
local function oneaten_sugar(inst, eater)
    eater:AddDebuff('buff_workeffectiveness', 'buff_workeffectiveness')
end
local function oneaten_chili(inst, eater)
    eater:AddDebuff('buff_attack', 'buff_attack')
end

local SPICES = {
    SPICE_GARLIC = {oneatenfn = oneaten_garlic, prefabs = {'buff_playerabsorption'}},
    SPICE_SUGAR = {oneatenfn = oneaten_sugar, prefabs = {'buff_workeffectiveness'}},
    SPICE_CHILI = {oneatenfn = oneaten_chili, prefabs = {'buff_attack'}},
    SPICE_SALT = {}
}

local function GenerateSpicedFoods(foods)
    for foodname, fooddata in pairs(foods) do
        for spicenameupper, spicedata in pairs(SPICES) do
            local newdata = shallowcopy(fooddata)
            local spicename = string.lower(spicenameupper)
            -- if foodname == "wetgoop" then
            --     newdata.test = function(cooker, names, tags) return names[spicename] end
            --     newdata.priority = -10
            -- else
            newdata.test = function(cooker, names, tags)
                return names[foodname] and names[spicename]
            end
            newdata.priority = 100
            -- end
            newdata.cooktime = .12
            newdata.stacksize = nil
            newdata.spice = spicenameupper
            newdata.basename = foodname
            newdata.name = foodname .. '_' .. spicename

            --这两个设置应该没用吧
            -- newdata.official = true
            -- newdata.cookbook_category = fooddata.cookbook_category ~= nil and ("spiced_"..fooddata.cookbook_category) or nil

            ------------

            if newdata.float ~= nil then --原本就会沉的料理，即使加了调料一样会沉
                newdata.float = {nil, 'med', 0.05, {0.8, 0.7, 0.8}}
            end
            TUNING.XXX3_FOODS_SPICED[newdata.name] = newdata

            ------------

            if spicename == 'spice_chili' then
                if newdata.temperature == nil then
                    --Add permanent "heat" to regular food
                    newdata.temperature = TUNING.HOT_FOOD_BONUS_TEMP
                    newdata.temperatureduration = TUNING.FOOD_TEMP_LONG
                    newdata.nochill = true
                elseif newdata.temperature > 0 then
                    --Upgarde "hot" food to permanent heat
                    newdata.temperatureduration = math.max(newdata.temperatureduration, TUNING.FOOD_TEMP_LONG)
                    newdata.nochill = true
                end
            end

            if spicedata.prefabs ~= nil then
                --make a copy (via ArrayUnion) if there are dependencies from the original food
                newdata.prefabs =
                    newdata.prefabs ~= nil and ArrayUnion(newdata.prefabs, spicedata.prefabs) or spicedata.prefabs
            end

            if spicedata.oneatenfn ~= nil then
                if newdata.oneatenfn ~= nil then
                    local oneatenfn_old = newdata.oneatenfn
                    newdata.oneatenfn = function(inst, eater)
                        spicedata.oneatenfn(inst, eater)
                        oneatenfn_old(inst, eater)
                    end
                else
                    newdata.oneatenfn = spicedata.oneatenfn
                end
            end
        end
    end
end

GenerateSpicedFoods(foods)

for k, recipe in pairs(TUNING.XXX3_FOODS_SPICED) do
    AddCookerRecipe('portablespicer', recipe)
end
