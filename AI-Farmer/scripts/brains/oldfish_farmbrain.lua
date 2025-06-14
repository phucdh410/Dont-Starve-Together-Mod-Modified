require "behaviours/wander"
require "behaviours/leash"
require "behaviours/standstill"
require "behaviours/runaway"
require "behaviours/doaction"
require "behaviours/panic"

local STOP_RUN_DIST = 10
local SEE_PLAYER_DIST = 5
local SEE_FOOD_DIST = 15
local near = 20
local SEE_BUSH_DIST = 28
local SEE_SHRINE_DIST = 30
local MIN_SHRINE_WANDER_DIST = 4
local MAX_SHRINE_WANDER_DIST = 15
local MAX_WANDER_DIST = 20
local SHRINE_LOITER_TIME = 4
local SHRINE_LOITER_TIME_VAR = 3
local LEASH_RETURN_DIST = 10
local LEASH_MAX_DIST = 20

local COOLING_TIME = 5 -- 说话冷却时间

local prefabName = {
    berries = true,
    berries_juicy = true,
    palmcone_scale = true,
    palmcone_seed = true,
    cutgrass = true,
    twigs = true,
    bird_egg = true,
    seeds = true,
    poop = true,
    honey = true,
    pinecone = true,
    log = true,
    blue_cap = true,
    green_cap = true,
    red_cap = true,
    drumstick = true,
    spoiled_food = true,
    carrot = true,
    watermelon = true,
    boards = true,
    dragonfruit = true,
    corn = true,
    froglegs = true,
    livinglog = true,
    guano = true,
    rottenegg = true,
    charcoal = true,
    twiggy_nut = true,
    acorn = true,
    eggplant = true,
    durian = true,
    pumpkin = true,
    dug_sapling = true,
    dug_berrybush = true,
    dug_berrybush2 = true,
    dug_berrybush_juicy = true,
    dug_grass = true,
    dug_marsh_bush = true,
    dug_rock_avocado_bush = true,
    dug_sapling_moon = true,
    meat = true,
    monstermeat = true,
    pomegranate = true,
    fertilizer = true,
    nitre = true,
    flint = true,
    rocks = true,
    marble = true,
    marblebean = true,
    goldnugget = true,
    peach = true,
    gourd = true,
    forgetmelots = true,
    bigpeach = true,
    tillweed = true,
    houndstooth = true,
    plantmeat = true,
    firenettles = true,
    smallmeat = true,
    smallmeat_dried = true,
    meat_dried = true,
    monstermeat_dried = true,
    fish = true,
    ice = true,
    tomato = true,
    potato = true,
    onion = true,
    garlic = true,
    pepper = true,
    asparagus = true,
    cave_banana = true,
    cactus_meat = true,
    cactus_flower = true,
    kelp = true,
    eel = true,
    batwing = true,
    butter = true,
    goatmilk = true,
    wormlight = true,
    wormlight_lesser = true,
    cutlichen = true,
    hambat = true,
    rock_avocado_fruit_ripe = true,
    rock_avocado_fruit_ripe_cooked = true,
    rock_avocado_fruit_sprout = true,
    strawhat = true,
    humanmeat = true,
    goldenshovel = true,
    goldenpickaxe = true,
    goldenaxe = true,
    compost = true,
    glommerfuel = true,
    lileaves = true,
    orchitwigs = true,
    rosorns = true,
    silk = true,
    cutted_lilybush = true,
    cutted_orchidbush = true,
    cutted_rosebush = true,
    dug_lilybush = true,
    dug_orchidbush = true,
    dug_rosebush = true,
    mostrain_leaf = true,
    petals_lily = true,
    petals_rose = true,
    petals_orchid = true,
    squamousfruit = true,
    spidergland = true,
    petals = true,
    butterflywings = true,
    stinger = true,
    pineananas = true,
    shyerrylog = true,
    shyerry = true,
    boneshard = true,
    albicans_cap = true,
    fruitflyfruit = true,
    moon_tree_blossom = true,
    redgem = true,
    bluegem = true,
    purplegem = true,
    yellowgem = true,
    greengem = true,
    orangegem = true
}

local excludes = {"INLIMBO", "burnt", "oldfish_farmer", "oldfish_farmhome", "playerghost", "animal", "player", "spider"}

local function changeEquipment(inst, item)
    if inst.components.inventory ~= nil then
        local equipitem = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        if equipitem == nil or equipitem.prefab ~= item then
            if equipitem ~= nil then
                inst.components.inventory:Unequip(EQUIPSLOTS.HANDS)
                inst.components.inventory:RemoveItem(equipitem)
            end
            local temp = SpawnPrefab(item)
            inst.components.inventory:Equip(temp)
        end
    end
end

local function speak(inst, content)
    if inst.isSpeak == false then
        inst.isSpeak = true
        inst.components.talker:Say(content)
        inst:DoTaskInTime(
            COOLING_TIME,
            function(inst)
                inst.isSpeak = false
            end
        )
    end
end

local function findHome(inst)
    if
        inst.myHome == nil or not inst.myHome:IsValid() or not inst.myHome:IsNear(inst, SEE_SHRINE_DIST) or
            (inst.myHome.components.burnable ~= nil and inst.myHome.components.burnable:IsBurning() or
                inst.myHome:HasTag("burnt"))
     then
        local x, y, z = inst.Transform:GetWorldPosition()
        inst.myHome = TheSim:FindEntities(x, y, z, SEE_SHRINE_DIST, {"oldfish_farmhome"}, {"burnt", "fire"})[1]
    end
    return inst.myHome
end

local farmerBrain =
    Class(
    Brain,
    function(self, inst)
        Brain._ctor(self, inst)
    end
)

local function IsPrefab(item, inst)
    if not findHome(inst) then
        return
    end

    if not item:IsNear(inst.myHome, near) then
        return false
    end

    local brainseends =
        inst.components.container:FindItem(
        function(v)
            return v.prefab == "hammer"
        end
    )

    if brainseends then
        return false
    end

    if prefabName[item.prefab] then
        return true
    end

    if item.prefab ~= nil then
        local result = string.find(item.prefab, "seeds")
        if result ~= nil then
            return true
        end
    end

    return false
end

local function HasBerry(item, inst)
    if not findHome(inst) then
        return
    end

    if not item:IsNear(inst.myHome, near) then
        return
    end
    if item.components.dryer then
        return item:HasTag("dried")
    elseif
        item.components.harvestable and item.components.harvestable:CanBeHarvested() and
            (item:HasTag("beebox") or item:HasTag("mushroom_farm"))
     then
        return true
    elseif item.components.crop ~= nil then
        if item.components.crop:IsReadyForHarvest() or item:HasTag("withered") then
            return true
        end
    else
        if item.components.pickable ~= nil then
            return item.components.pickable.canbepicked and
                (item.components.pickable.product == "berries" or item.components.pickable.product == "berries_juicy" or
                    item.components.pickable.product == "rock_avocado_fruit" or
                    item.components.pickable.product == "cutgrass" or
                    item.components.pickable.product == "twigs" or
                    item.components.pickable.product == "cactus_meat" or
                    item.components.pickable.product == "cutreeds" or
                    item.components.pickable.product == "cutlichen" or
                    item.components.pickable.product == "red_cap" or
                    item.components.pickable.product == "blue_cap" or
                    item.components.pickable.product == "green_cap" or
                    item.components.pickable.product == "wormlight_lesser" or
                    item:HasTag("plantedsoil") and item:HasTag("farm_plant") or
                    item.components.pickable.product == "compost" or
                    item.components.pickable.product == "cave_banana" or
                    item.components.pickable.product == "peach" or
                    item.components.pickable.product == "petals_lily" or
                    item.components.pickable.product == "petals_rose" or
                    item.components.pickable.product == "petals_orchid" or
                    item.components.pickable.product == "squamousfruit" or
                    item.components.pickable.product == "shyerry")
        end
    end
end

local function hasFarm(item, inst)
    if not findHome(inst) then
        return
    end

    if not item:IsNear(inst.myHome, near) then
        return
    end
    return item.prefab == "slow_farmplot" or item.prefab == "fast_farmplot"
end

local function hasMushroomFarm(item, inst)
    if not findHome(inst) then
        return
    end

    if not item:IsNear(inst.myHome, near) then
        return
    end
    return item.prefab == "mushroom_farm"
end

local function canDiseased(item, inst)
    if not findHome(inst) then
        return
    end

    if not item:IsNear(inst.myHome, near) then
        return
    end
    return item.prefab == "berrybush" or item.prefab == "grass" or item.prefab == "berrybush2" or
        item.prefab == "berrybush_juicy" or
        item.prefab == "rock_avocado_bush"
end

local function hateWeeds(item, inst)
    if not findHome(inst) then
        return
    end

    if not item:IsNear(inst.myHome, near) then
        return
    end
    return item.prefab == "weed_ivy" or item.prefab == "farm_soil_debris"
end

local function isfiresuppressor(item, inst)
    if not findHome(inst) then
        return
    end

    if not item:IsNear(inst.myHome, near) then
        return
    end
    return item.prefab == "firesuppressor"
end

local function needActivation(item, inst)
    if not findHome(inst) then
        return
    end

    if not item:IsNear(inst.myHome, near) then
        return
    end
    return item.prefab == "berrybush" or item.prefab == "grass" or item.prefab == "berrybush2" or
        item.prefab == "berrybush_juicy" or
        item.prefab == "rock_avocado_bush" or
        item.prefab == "lilybush" or
        item.prefab == "rosebush" or
        item.prefab == "orchidbush"
end

local function hasTree(item, inst)
    if not findHome(inst) then
        return
    end

    if not item:IsNear(inst.myHome, near) then
        return
    end
    return item.prefab == "evergreen" or item.prefab == "evergreen_sparse" or item.prefab == "evergreen_burnt" or
        item.prefab == "deciduoustree" or
        item.prefab == "deciduoustree_burnt" or
        item.prefab == "moon_tree" or
        item.prefab == "twiggytree" or
        item.prefab == "shyerrytree1" or
        item.prefab == "shyerrytree2" or
        item.prefab == "shyerrytree3" or
        item.prefab == "shyerrytree4" or
        item.prefab == "palmcone" or
        item.prefab == "palmconetree"
end

local function hasRock(item, inst)
    if not findHome(inst) then
        return
    end

    if not item:IsNear(inst.myHome, near) then
        return
    end
    return item ~= nil and item.components.workable ~= nil and item.components.workable.action == ACTIONS.MINE and
        item.components.workable:CanBeWorked()
end

local function pickUpAction(inst)
    if inst.components.container:IsFull() then
        speak(inst, STRINGS.CONTAINER_FULL)
        return
    end
    if inst.myHome == nil then
        return
    end
    local target = FindEntity(inst, SEE_BUSH_DIST, IsPrefab, nil, excludes)
    return target ~= nil and BufferedAction(inst, target, ACTIONS.PICKUP) or nil
end

local function PickBerriesAction(inst)
    if inst.components.container:IsFull() then
        return
    end
    if inst.myHome == nil then
        return
    end

    local target = FindEntity(inst, SEE_BUSH_DIST, HasBerry, nil, excludes)
    if target then
        if target:HasTag("dried") then
            return BufferedAction(inst, target, ACTIONS.HARVEST)
        elseif target:HasTag("beebox") and target.components.harvestable.produce >= 6 then
            return BufferedAction(inst, target, ACTIONS.HARVEST)
        elseif target.components.crop ~= nil then
            if target.components.crop:IsReadyForHarvest() or target:HasTag("withered") then
                return BufferedAction(inst, target, ACTIONS.HARVEST)
            end
        elseif target:HasTag("mushroom_farm") and target.components.harvestable.produce >= 4 then
            return BufferedAction(inst, target, ACTIONS.HARVEST)
        elseif
            target.components.pickable and target.components.pickable.canbepicked and
                not target.components.pickable.caninteractwith == false
         then
            return BufferedAction(inst, target, ACTIONS.PICK)
        end
    end
end

local function isDiseased(inst)
    if inst.myHome == nil then
        return
    end
    local target = FindEntity(inst, SEE_BUSH_DIST, canDiseased, nil, excludes)
    if target then
        if target.components.diseaseable ~= nil and target.components.workable ~= nil then
            if target.components.diseaseable:IsDiseased() or target.components.diseaseable:IsBecomingDiseased() then
                changeEquipment(inst, "goldenshovel")
                return BufferedAction(inst, target, ACTIONS.DIG)
            end
        end
    end
end

local function isWeeds(inst)
    if inst.myHome == nil then
        return
    end
    local target = FindEntity(inst, SEE_BUSH_DIST, hateWeeds, nil, excludes)
    if target then
        changeEquipment(inst, "goldenshovel")
        return BufferedAction(inst, target, ACTIONS.DIG)
    end
end

local function hasMeatrock(item, inst)
    if not findHome(inst) then
        return
    end

    if not item:IsNear(inst.myHome, near) then
        return
    end
    return item.prefab == "meatrack"
end

local function hasSoil(item, inst)
    if not findHome(inst) then
        return
    end

    if not item:IsNear(inst.myHome, near) then
        return
    end
    return item.prefab == "farm_soil"
end

local function isSoil(inst)
    if inst.myHome == nil then
        return
    end
    local target = FindEntity(inst, SEE_BUSH_DIST, hasSoil, nil, excludes)
    if target and not target:HasTag("NOBLOCK") then
        local seends =
            inst.components.container:FindItem(
            function(v)
                return string.find(v.prefab, "seeds") ~= nil and v.components.deployable ~= nil and
                    v.components.deployable.ondeploy ~= nil and
                    v.components.deployable.mode == DEPLOYMODE.CUSTOM
            end
        )
        if seends == nil then
            speak(inst, STRINGS.PLANT_NOTIFICATION)
        else
            return BufferedAction(inst, target, ACTIONS.PLANTSOIL, seends)
        end
    end
end

local function canPlant(inst)
    if inst.myHome == nil then
        return
    end

    local meatrack = FindEntity(inst, SEE_BUSH_DIST, hasMeatrock, {"oldfish_meatrack"}, excludes)
    if meatrack and meatrack.prefab == "meatrack" and meatrack.components.dryer ~= nil then
        local seends =
            inst.components.container:FindItem(
            function(v)
                return v.components.dryable ~= nil
            end
        )
        if seends and meatrack.components.dryer:CanDry(seends) then
            return BufferedAction(inst, meatrack, ACTIONS.DRY, seends)
        end
    end

    local target = FindEntity(inst, SEE_BUSH_DIST, hasFarm, {"structure"}, excludes)
    if target and target.components.grower ~= nil then
        if target.components.crop then
            if target.components.crop.onwithered == nil then
                return
            end
        end

        if target.prefab == "slow_farmplot" or target.prefab == "fast_farmplot" then
            if target.components.grower:GetFertilePercent() < 0.5 then
                local seends =
                    inst.components.container:FindItem(
                    function(v)
                        return v.prefab == "poop" or v.prefab == "spoiled_food" or v.prefab == "guano" or
                            v.prefab == "rottenegg" or
                            v.prefab == "fertilizer" or
                            v.prefab == "compost"
                    end
                )
                if seends == nil then
                    speak(inst, STRINGS.FERTILIZER_NOTIFICATION)
                else
                    return BufferedAction(inst, target, ACTIONS.AUTO_FERTILIZE, seends)
                end
            end

            if target.components.grower:IsEmpty() then
                if TheWorld.state.iswinter then
                    return
                end

                local seends =
                    inst.components.container:FindItem(
                    function(v)
                        return string.find(v.prefab, "seeds") ~= nil and v.components.deployable ~= nil and
                            v.components.deployable.ondeploy ~= nil and
                            v.components.deployable.mode == DEPLOYMODE.CUSTOM
                    end
                )
                if seends == nil then
                    speak(inst, STRINGS.PLANT_NOTIFICATION)
                else
                    return BufferedAction(inst, target, ACTIONS.AUTO_PLANT, seends)
                end
            end
        end
    end

    local target = FindEntity(inst, SEE_BUSH_DIST, hasMushroomFarm, {"oldfish_mushroom_farm"}, excludes)
    if target and target.components.harvestable and target.components.harvestable.produce == 0 then
        if target.prefab == "mushroom_farm" then
            local seends
            if target.remainingharvests == 0 then
                seends =
                    inst.components.container:FindItem(
                    function(v)
                        return v.prefab == "livinglog" or v.prefab == "shyerrylog"
                    end
                )
                if seends == nil then
                    speak(inst, STRINGS.ACTIVATE_MUSHROOM)
                end
            else
                seends =
                    inst.components.container:FindItem(
                    function(v)
                        return v.prefab == "blue_cap" or v.prefab == "green_cap" or v.prefab == "red_cap" or
                            v.prefab == "spore_small" or
                            v.prefab == "spore_medium" or
                            v.prefab == "spore_tall" or
                            v.prefab == "albicans_cap"
                    end
                )
            end
            if seends then
                if TheWorld.state.iswinter then
                    return
                end
                return BufferedAction(inst, target, ACTIONS.GIVE, seends)
            end
        end
    end
end

local function needFertilize(inst)
    if inst.myHome == nil then
        return
    end

    local target = FindEntity(inst, SEE_BUSH_DIST, isfiresuppressor, {"oldfish_firesuppressor"}, excludes)
    if target then
        if target.prefab == "firesuppressor" then
            if
                target.components.fueled ~= nil and
                    target.components.fueled.currentfuel / target.components.fueled.maxfuel < 0.5
             then
                local seends =
                    inst.components.container:FindItem(
                    function(v)
                        return v.components.fuel ~= nil and
                            (v.prefab == "log" or v.prefab == "twigs" or v.prefab == "poop" or v.prefab == "cutgrass" or
                                v.prefab == "spoiled_food")
                    end
                )
                if seends == nil then
                    speak(inst, STRINGS.FIRESUPPRESSOR_FUEL)
                else
                    return BufferedAction(inst, target, ACTIONS.ADDFUEL, seends)
                end
            end
        end
    end

    local target = FindEntity(inst, SEE_BUSH_DIST, needActivation, {"plant"}, excludes)
    if target and target.components.pickable ~= nil and target.components.pickable:CanBeFertilized() then
        local seends =
            inst.components.container:FindItem(
            function(v)
                return v.prefab == "poop" or v.prefab == "spoiled_food" or v.prefab == "guano" or
                    v.prefab == "rottenegg" or
                    v.prefab == "fertilizer" or
                    v.prefab == "compost"
            end
        )
        if seends then
            return BufferedAction(inst, target, ACTIONS.AUTO_FERTILIZE, seends)
        end
    end
end

local function chopTree(inst)
    if inst.components.container:IsFull() then
        speak(inst, STRINGS.CONTAINER_FULL)
        return
    end
    if inst.myHome == nil then
        return
    end
    local target = FindEntity(inst, SEE_BUSH_DIST, hasTree, nil, nil)
    if target then
        if not target:HasTag("stump") then
            if
                (target.components.growable and target.components.growable.stage == 3) or
                    target.prefab == "shyerrytree1" or
                    target.prefab == "shyerrytree2" or
                    target.prefab == "shyerrytree3" or
                    target.prefab == "shyerrytree4" or
                    target.components.growable == nil
             then
                changeEquipment(inst, "moonglassaxe")
                return BufferedAction(inst, target, ACTIONS.CHOP)
            end
        else
            changeEquipment(inst, "goldenshovel")
            return BufferedAction(inst, target, ACTIONS.DIG)
        end
    end
end

local function mineRock(inst)
    if inst.components.container:IsFull() then
        speak(inst, STRINGS.CONTAINER_FULL)
        return
    end
    if inst.myHome == nil then
        return
    end
    local target = FindEntity(inst, SEE_BUSH_DIST, hasRock, nil, excludes)
    if target then
        if target.components.growable and target.components.growable.stage ~= 3 then
            return
        end

        changeEquipment(inst, "goldenpickaxe")
        return BufferedAction(inst, target, ACTIONS.MINE)
    end
end

local function HasValidHome(inst)
    local home = inst.components.homeseeker ~= nil and inst.components.homeseeker.home or nil
    return home ~= nil and home:IsValid() and
        not (home.components.burnable ~= nil and home.components.burnable:IsBurning()) and
        not home:HasTag("burnt")
end

local function goHomeAction(inst)
    if HasValidHome(inst) then
        return BufferedAction(inst, inst.components.homeseeker.home, ACTIONS.GOHOME)
    end
end

local function GetHomePos(inst)
    return HasValidHome(inst) and inst.components.homeseeker:GetHomePos()
end

local function getNoLeaderHomePos(inst)
    return GetHomePos(inst)
end

local posx
local posz

local function makeNewSmallPlantAction(inst)
    if not findHome(inst) then
        return
    end

    local lcoalPos = inst.myHome:GetPosition()

    local smallseends =
        inst.components.container:FindItem(
        function(v)
            return v.prefab == "dug_sapling" or v.prefab == "dug_sapling_moon" or v.prefab == "dug_marsh_bush" or
                v.prefab == "dug_grass" or
                v.prefab == "cutted_orchidbush" or
                v.prefab == "dug_orchidbush"
        end
    )

    if smallseends then
        if inst.posPlant == nil then
            inst.posPlant = {x = lcoalPos.x - 9.5, y = 0, z = lcoalPos.z - 9.5}
        end
        local count = 0
        while 1 do
            if smallseends.components.deployable == nil then
                break
            end

            if smallseends.components.deployable:CanDeploy(Vector3(inst.posPlant.x, inst.posPlant.y, inst.posPlant.z)) then
                break
            else
                if inst.posPlant.x + 1 > lcoalPos.x + 9.5 then
                    if inst.posPlant.z + 1 > lcoalPos.z - 3.5 then
                        count = count + 1
                        if count >= 1 then
                            inst.posPlant = nil
                            break
                        end
                        inst.posPlant = {x = lcoalPos.x - 9.5, y = 0, z = lcoalPos.z - 9.5}
                    else
                        inst.posPlant = {x = lcoalPos.x - 9.5, y = 0, z = inst.posPlant.z + 1}
                    end
                else
                    inst.posPlant = {x = inst.posPlant.x + 1, y = 0, z = inst.posPlant.z}
                end
                if
                    smallseends.components.deployable:CanDeploy(
                        Vector3(inst.posPlant.x, inst.posPlant.y, inst.posPlant.z)
                    )
                 then
                    break
                end
            end
        end
        if inst.posPlant ~= nil then
            return BufferedAction(
                inst,
                nil,
                ACTIONS.AUTO_FARM_PLANT,
                smallseends,
                Vector3(inst.posPlant.x, inst.posPlant.y, inst.posPlant.z)
            )
        end
    end
end

local function goToPlant(inst)
    if not findHome(inst) then
        return
    end

    local plant_roots = {
        ["dug_berrybush"] = 2,
        ["dug_berrybush2"] = 2,
        ["dug_berrybush_juicy"] = 2,
        ["dug_rock_avocado_bush"] = 2,
        ["rock_avocado_fruit_sprout"] = 2,
        ["pinecone"] = 2,
        ["twiggy_nut"] = 2,
        ["acorn"] = 2,
        ["marblebean"] = 2,
        ["moonbutterfly"] = 2,
        ["bigpeach"] = 2,
        ["cutted_lilybush"] = 2,
        ["cutted_rosebush"] = 2,
        ["dug_lilybush"] = 2,
        ["dug_rosebush"] = 2,
        ["miao_packbox_full"] = 2,
        ["palmcone_seed"] = 2
    }
    local plant_root =
        inst.components.container and
        inst.components.container:FindItem(
            function(item)
                if plant_roots[item.prefab] then
                    return item
                end
            end
        )

    local home_pos = inst.myHome:GetPosition()
    local plant_pos = {home_pos.x, home_pos.z}
    local can_plant = {
        {
            ["sta"] = {-10, -10},
            ["end"] = {10, -6},
            ["pad"] = {1, 1},
            cnd = function(a, b)
                return a < b
            end
        },
        {
            ["sta"] = {9, 9},
            ["end"] = {-9, -9},
            ["pad"] = {-2, -2},
            cnd = function(a, b)
                return a > b
            end
        }
    }
    if plant_root and plant_root.components.deployable then
        local size = plant_roots[plant_root.prefab]
        plant_pos[1] = plant_pos[1] + can_plant[size]["sta"][1]
        plant_pos[2] = plant_pos[2] + can_plant[size]["sta"][2]
        while not plant_root.components.deployable:CanDeploy(Vector3(plant_pos[1], 0, plant_pos[2])) do
            if can_plant[size].cnd(plant_pos[1], home_pos.x + can_plant[size]["end"][1]) then
                plant_pos[1] = plant_pos[1] + can_plant[size]["pad"][1]
            else
                plant_pos[1] = home_pos.x + can_plant[size]["sta"][1]
                if can_plant[size].cnd(plant_pos[2], home_pos.z + can_plant[size]["end"][2]) then
                    plant_pos[2] = plant_pos[2] + can_plant[size]["pad"][2]
                else
                    plant_pos = nil
                    break
                end
            end
        end
    end
    if plant_root and plant_pos then
        return BufferedAction(inst, nil, ACTIONS.AUTO_FARM_PLANT, plant_root, Vector3(plant_pos[1], 0, plant_pos[2]))
    end
end

local function hateSkeleton(item, inst)
    if not findHome(inst) then
        return
    end

    if not item:IsNear(inst.myHome, near) then
        return
    end

    if
        item.prefab ~= nil and item.components.workable ~= nil and item.components.workable.action == ACTIONS.HAMMER and
            item.components.workable:CanBeWorked() and
            item.prefab ~= "trophyscale_oversizedveggies"
     then
        local result = string.find(item.prefab, "_oversized")
        if result ~= nil then
            return true
        end
    elseif item.prefab == "houndbone" then
        return true
    end
end

local function isSkeleton(inst)
    if inst.myHome == nil then
        return
    end
    local target = FindEntity(inst, SEE_BUSH_DIST, hateSkeleton, nil, excludes)
    if target then
        changeEquipment(inst, "hammer")
        return BufferedAction(inst, target, ACTIONS.HAMMER)
    end
end

local function hateNettable(item, inst)
    if not findHome(inst) then
        return
    end

    if not item:IsNear(inst.myHome, near) then
        return
    end

    if
        item.prefab ~= nil and item.prefab ~= "raindonate" and item.prefab ~= "bee" and item.prefab ~= "mosquito" and
            item.components.workable ~= nil and
            item.components.workable.action == ACTIONS.NET and
            item.components.workable:CanBeWorked()
     then
        return true
    end
end

local function isNettable(inst)
    if inst.myHome == nil then
        return
    end

    if inst.components.container:IsFull() then
        speak(inst, STRINGS.CONTAINER_FULL)
        return
    end

    local hasnet =
        inst.components.container:FindItem(
        function(v)
            return v.prefab == "bugnet"
        end
    )

    local target = FindEntity(inst, SEE_BUSH_DIST, hateNettable, nil, excludes)

    if target and hasnet then
        changeEquipment(inst, "bugnet")
        return BufferedAction(inst, target, ACTIONS.NET)
    end
end

function farmerBrain:OnStart()
    local root =
        PriorityNode(
        {
            WhileNode(
                function()
                    return self.inst.components.health.takingfiredamage or self.inst.components.hauntable.panic
                end,
                "Panic",
                Panic(self.inst)
            ),
            IfNode(
                function()
                    return self.inst.myHome or findHome(self.inst)
                end,
                "find home",
                WhileNode(
                    function()
                        return self.inst.myHome
                    end,
                    "approach home",
                    PriorityNode(
                        {
                            EventNode(self.inst, "gohome", DoAction(self.inst, goHomeAction, "go home", true)),
                            DoAction(self.inst, isDiseased, "is diseased", true),
                            DoAction(self.inst, isWeeds, "is weeds", true),
                            DoAction(self.inst, isSoil, "is soil", true),
                            DoAction(self.inst, needFertilize, "need fertilize", true),
                            DoAction(self.inst, canPlant, "can plant", true),
                            DoAction(self.inst, pickUpAction, "pick up", true),
                            DoAction(self.inst, isSkeleton, "is skeleton", true),
                            DoAction(self.inst, isNettable, "is nettable", true),
                            DoAction(self.inst, PickBerriesAction, "Pick Thing", true),
                            DoAction(self.inst, chopTree, "chop tree", true),
                            DoAction(self.inst, makeNewSmallPlantAction, "plannt pos", true),
                            DoAction(self.inst, goToPlant, "plannt pos", true),
                            DoAction(self.inst, mineRock, "mine rock", true),
                            Leash(self.inst, getNoLeaderHomePos, MAX_SHRINE_WANDER_DIST, MIN_SHRINE_WANDER_DIST),
                            Wander(
                                self.inst,
                                getNoLeaderHomePos,
                                MAX_SHRINE_WANDER_DIST - MIN_SHRINE_WANDER_DIST,
                                {minwaittime = SHRINE_LOITER_TIME * .5, randwaittime = SHRINE_LOITER_TIME_VAR}
                            )
                        },
                        .2
                    )
                )
            ),
            RunAway(self.inst, "hostile", SEE_PLAYER_DIST, STOP_RUN_DIST)
        },
        .2
    )
    self.bt = BT(self.inst, root)
end

return farmerBrain
