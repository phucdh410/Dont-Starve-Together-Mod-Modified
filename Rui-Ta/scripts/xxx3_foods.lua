local foods = {
    xxx3_hbsl = {
        test = function(cooker, names, tags)
            return names.xxx3_bf and names.xxx3_bf == 4
        end,
        name = 'xxx3_hbsl', 
        weight = 1, 
        priority = 30, 
        foodtype = GLOBAL.FOODTYPE.VEGGIE, 
        health = 50 * TUNING.XXX3_FOODVALUE,
        hunger = 25 * TUNING.XXX3_FOODVALUE,
        sanity = 0,
        perishtime = TUNING.PERISH_FAST, 
        cooktime = 0.1,
        potlevel = 'high',
        cookbook_tex = 'xxx3_hbsl.tex',
        cookbook_atlas = 'images/xxx3_hbsl.xml',
        floater = {'med', nil, 0.55},
        cookbook_category = 'cookpot',
        oneat_desc = 'Attracts butterflies continuously'
    },
    xxx3_hjmdj = {
        
        test = function(cooker, names, tags)
            
            return names.xxx3_bf and names.xxx3_pollen and names.butterflywings and names.honey
        end,
        name = 'xxx3_hjmdj', 
        weight = 1, 
        priority = 30, 
        foodtype = GLOBAL.FOODTYPE.VEGGIE, 
        health = 35 * TUNING.XXX3_FOODVALUE,
        hunger = 50 * TUNING.XXX3_FOODVALUE,
        sanity = 20 * TUNING.XXX3_FOODVALUE,
        perishtime = TUNING.PERISH_MED, 
        cooktime = 0.2,
        potlevel = 'high',
        cookbook_tex = 'xxx3_hjmdj.tex',
        cookbook_atlas = 'images/xxx3_hjmdj.xml',
        floater = {'med', nil, 0.55},
        cookbook_category = 'cookpot'
    },
    xxx3_hmhb = {
        
        test = function(cooker, names, tags)
            
            return names.xxx3_bf and names.xxx3_pollen and tags.meat and tags.meat >= 1
        end,
        name = 'xxx3_hmhb', 
        weight = 1, 
        priority = 30, 
        foodtype = GLOBAL.FOODTYPE.MEAT, 
        health = 15 * TUNING.XXX3_FOODVALUE,
        hunger = 112.5 * TUNING.XXX3_FOODVALUE,
        sanity = 5 * TUNING.XXX3_FOODVALUE,
        perishtime = TUNING.PERISH_SLOW, 
        cooktime = 0.6,
        potlevel = 'high',
        cookbook_tex = 'xxx3_hmhb.tex',
        cookbook_atlas = 'images/xxx3_hmhb.xml',
        floater = {'med', nil, 0.55},
        cookbook_category = 'cookpot'
    },
    xxx3_hjdg = {
        
        test = function(cooker, names, tags)
            
            return names.xxx3_pollen and names.xxx3_pollen == 4
        end,
        name = 'xxx3_hjdg', 
        weight = 1, 
        priority = 30, 
        foodtype = GLOBAL.FOODTYPE.VEGGIE, 
        health = 40 * TUNING.XXX3_FOODVALUE,
        hunger = 85 * TUNING.XXX3_FOODVALUE,
        sanity = 5 * TUNING.XXX3_FOODVALUE,
        perishtime = TUNING.PERISH_SLOW, 
        cooktime = 1,
        potlevel = 'high',
        cookbook_tex = 'xxx3_hjdg.tex',
        cookbook_atlas = 'images/xxx3_hjdg.xml',
        floater = {'med', nil, 0.55},
        cookbook_category = 'cookpot'
    },
    xxx3_nmtd = {
        
        test = function(cooker, names, tags)
            
            return names.xxx3_pollen and names.royal_jelly and names.butterflywings and tags.sweetener and
                tags.sweetener >= 5
        end,
        name = 'xxx3_nmtd', 
        weight = 1, 
        priority = 30, 
        foodtype = GLOBAL.FOODTYPE.GOODIES, 
        health = 0,
        hunger = 2,
        sanity = 0,
        perishtime = nil, 
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
            
            
            
            
            newdata.test = function(cooker, names, tags)
                return names[foodname] and names[spicename]
            end
            newdata.priority = 100
            
            newdata.cooktime = .12
            newdata.stacksize = nil
            newdata.spice = spicenameupper
            newdata.basename = foodname
            newdata.name = foodname .. '_' .. spicename

            
            
            

            

            if newdata.float ~= nil then 
                newdata.float = {nil, 'med', 0.05, {0.8, 0.7, 0.8}}
            end
            TUNING.XXX3_FOODS_SPICED[newdata.name] = newdata

            

            if spicename == 'spice_chili' then
                if newdata.temperature == nil then
                    
                    newdata.temperature = TUNING.HOT_FOOD_BONUS_TEMP
                    newdata.temperatureduration = TUNING.FOOD_TEMP_LONG
                    newdata.nochill = true
                elseif newdata.temperature > 0 then
                    
                    newdata.temperatureduration = math.max(newdata.temperatureduration, TUNING.FOOD_TEMP_LONG)
                    newdata.nochill = true
                end
            end

            if spicedata.prefabs ~= nil then
                
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
