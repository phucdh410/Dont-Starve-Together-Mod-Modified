require("tuning")

KKR_FOODS_SPICED = {}
for k, recipe in pairs(KKRENV.KkrFoodsDef) do
    AddCookerRecipe("portablecookpot", recipe)
    AddCookerRecipe("cookpot", recipe)
    recipe.cookbook_tex = k .. ".tex"
    recipe.cookbook_atlas = "images/inventoryimages/kkr_foods.xml"
    RegisterInventoryItemAtlas("images/inventoryimages/kkr_foods.xml", k .. ".tex")
end

local function oneaten_garlic(inst, eater)
    eater:AddDebuff("buff_playerabsorption", "buff_playerabsorption")
end
local function oneaten_sugar(inst, eater)
    eater:AddDebuff("buff_workeffectiveness", "buff_workeffectiveness")
end
local function oneaten_chili(inst, eater)
    eater:AddDebuff("buff_attack", "buff_attack")
end

local SPICES = {
    SPICE_GARLIC = {
        oneatenfn = oneaten_garlic,
        prefabs = {"buff_playerabsorption"}
    },
    SPICE_SUGAR = {
        oneatenfn = oneaten_sugar,
        prefabs = {"buff_workeffectiveness"}
    },
    SPICE_CHILI = {oneatenfn = oneaten_chili, prefabs = {"buff_attack"}},
    SPICE_SALT = {}
}

local function GenerateSpicedFoods(food)
    for spicenameupper, spicedata in pairs(SPICES) do
        local newdata = shallowcopy(food)
        local spicename = string.lower(spicenameupper)
        local foodname = food.name
        newdata.test = function(cooker, names, tags)
            return names[foodname] and names[spicename]
        end
        newdata.priority = 100

        newdata.cooktime = .12
        newdata.stacksize = nil
        newdata.spice = spicenameupper
        newdata.basename = foodname
        newdata.name = foodname .. "_" .. spicename
        newdata.overridebuild = foodname

        if newdata.float ~= nil then
            newdata.float = {nil, "med", 0.05, {0.8, 0.7, 0.8}}
        end

        if spicename == "spice_chili" then
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
        KKR_FOODS_SPICED[newdata.name] = newdata
        AddCookerRecipe("portablespicer", newdata)
    end
end

for _, food in pairs(KKRENV.KkrFoodsDef) do
    GenerateSpicedFoods(food)
end
