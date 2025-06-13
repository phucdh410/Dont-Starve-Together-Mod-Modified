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
local SEE_BUSH_DIST = 30
local SEE_SHRINE_DIST = 30
local MIN_SHRINE_WANDER_DIST = 4
local MAX_SHRINE_WANDER_DIST = 15
local MAX_WANDER_DIST = 20
local SHRINE_LOITER_TIME = 4
local SHRINE_LOITER_TIME_VAR = 3
local LEASH_RETURN_DIST = 10
local LEASH_MAX_DIST = 20

local COOLING_TIME = 5

local prefab_name = {
    -- FOOD
    berries = true,
    berries_juicy = true,
    carrot = true,
    watermelon = true,
    dragonfruit = true,
    corn = true,
    eggplant = true,
    durian = true,
    pumpkin = true,
    pomegranate = true,
    tomato = true,
    potato = true,
    onion = true,
    garlic = true,
    pepper = true,
    asparagus = true,
    cave_banana = true,
    cactus_meat = true,
    kelp = true,
    butter = true,
    goatmilk = true,

    -- MUSHROOM
    blue_cap = true,
    green_cap = true,
    red_cap = true,

    -- MEAT
    eel = true,
    batwing = true,
    bird_egg = true,
    drumstick = true,
    froglegs = true,
    meat = true,
    smallmeat = true,
    monstermeat = true,
    fish = true,

    -- SPOIL/ROT/POOP
    spoiled_food = true,
    rottenegg = true,
    poop = true,
    guano = true,
    fertilizer = true,

    -- DRIED
    smallmeat_dried = true,
    meat_dried = true,
    monstermeat_dried = true,

    -- SEED
    seeds = true,

    -- PICKUP ITEMS
    cutgrass = true,
    twigs = true,
    log = true,
    charcoal = true,
    livinglog = true,
    cactus_flower = true,

    -- MINING ITEMS
    flint = true,
    rocks = true,
    nitre = true,
    goldnugget = true,
    thulecite_pieces = true,
    ice = true,
    redgem = true,
    bluegem = true,
    purplegem = true,
    orangegem = true,
    yellowgem = true,
    greengem = true,
    marble = true,
    marblebean = true,
    rock_avocado_fruit_ripe = true,
    rock_avocado_fruit_ripe_cooked = true,
    rock_avocado_fruit_sprout = true,

    -- PLANT
    pinecone = true,
    acorn = true,
    twiggy_nut = true,
    dug_sapling = true,
    dug_sapling_moon = true,
    dug_grass = true,
    dug_marsh_bush = true,
    dug_berrybush = true,
    dug_berrybush2 = true,
    dug_berrybush_juicy = true,
    dug_rock_avocado_bush = true,

    -- OTHERS
    wormlight = true,
    wormlight_lesser = true,
    cutlichen = true,

    -- Công cụ / vũ khí
    hambat = true,

    -- Đồ chế tạo
    boards = true,
}

local excludes = { "INLIMBO","burnt","oldfish_farmer","oldfish_farmhome","insect", "playerghost","animal","player","spider" }

local function changeEquipment(inst,item)
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

local function speak(inst,content)
    if inst.isSpeak == false then
        inst.isSpeak = true
        inst.components.talker:Say(content)
        inst:DoTaskInTime(COOLING_TIME,function(inst)
            inst.isSpeak  = false
        end)
    end
end

local function findHome(inst)
    if inst.myHome == nil
            or not inst.myHome:IsValid()
            or not inst.myHome:IsNear(inst, SEE_SHRINE_DIST)
            or (inst.myHome.components.burnable ~= nil
            and inst.myHome.components.burnable:IsBurning()
            or inst.myHome:HasTag("burnt")) then
        local x, y, z = inst.Transform:GetWorldPosition()
        inst.myHome = TheSim:FindEntities(x, y, z, SEE_SHRINE_DIST, { "oldfish_farmhome" }, { "burnt", "fire" })[1]
    end
    return inst.myHome
end

local farmerBrain = Class(Brain,
    function(self, inst)
        Brain._ctor(self, inst)
    end)


local function IsPrefab(item, inst)

    if not findHome(inst) then
        return
    end

    if not item:IsNear(inst.myHome, near) then
        return false
    end

    if prefab_name[item.prefab] then
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

local pickable_products = {
    berries = true,
    berries_juicy = true,
    rock_avocado_fruit = true,
    cutgrass = true,
    twigs = true,
}

local function IsValidProduct(prefab)
    return pickable_products[prefab]
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
    elseif item.components.harvestable
            and item.components.harvestable:CanBeHarvested()
            and (item:HasTag("beebox") or item:HasTag("mushroom_farm")) then
        return true
    elseif item.components.crop ~= nil then
        if item.components.crop:IsReadyForHarvest() or item:HasTag("withered") then
            return true
        end
    else
        if item.components.pickable ~= nil then
            return item.components.pickable.canbepicked and IsValidProduct(item.components.pickable.product)
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
    return item.prefab == "slow_farmplot"
            or item.prefab == "fast_farmplot"
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
    return item.prefab == "berrybush"
            or item.prefab == "grass"
            or item.prefab == "berrybush2"
            or item.prefab == "berrybush_juicy"
            or item.prefab == "rock_avocado_bush"
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
    return item.prefab == "berrybush"
            or item.prefab == "grass"
            or item.prefab == "berrybush2"
            or item.prefab == "berrybush_juicy"
            or item.prefab == "rock_avocado_bush"
end

local function hasTree(item, inst)

    if not findHome(inst) then
        return
    end

    if not item:IsNear(inst.myHome, near) then
        return
    end
    return item.prefab == "evergreen"
            or item.prefab == "evergreen_sparse"
            or item.prefab == "evergreen_burnt"
            or item.prefab == "deciduoustree"
            or item.prefab == "deciduoustree_burnt"
            or item.prefab == "twiggytree"
end

local function hasRock(item, inst)

    if not findHome(inst) then
        return
    end

    if not item:IsNear(inst.myHome, near) then
        return
    end
    return item ~= nil
            and item.components.workable ~= nil
            and item.components.workable.action == ACTIONS.MINE
            and item.components.workable:CanBeWorked()
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

local posx
local posz

local function makeNewPlantAction(inst)

    if not findHome(inst) then
        return
    end

    local seends = inst.components.container:FindItem(function(v)
        return v.prefab == "dug_sapling"
                or v.prefab == "dug_berrybush"
                or v.prefab == "dug_berrybush2"
                or v.prefab == "dug_berrybush_juicy"
                or v.prefab == "dug_marsh_bush"
                or v.prefab == "dug_grass"
                or v.prefab == "dug_rock_avocado_bush"
                or v.prefab == "dug_sapling_moon"
                or v.prefab == "pinecone"
                or v.prefab == "twiggy_nut"
                or v.prefab == "acorn"
                or v.prefab == "marblebean"
                or v.prefab == "peach"
                or v.prefab == "rock_avocado_fruit_sprout"
    end)

    local localPos = inst.myHome:GetPosition()

    if seends then
        if inst.posPlant == nil then
            inst.posPlant = { x = localPos.x-11,y = 0,z = localPos.z-11 }
        end
        local count = 0
        while 1 do

            if seends.components.deployable == nil then
                break
            end

            if seends.components.deployable:CanDeploy(Vector3(inst.posPlant.x,inst.posPlant.y,inst.posPlant.z)) then
                break
            else
                if inst.posPlant.x + 3 > localPos.x + 11 then
                    if inst.posPlant.z + 1 > localPos.z + 11 then
                        count = count + 1
                        if count >= 1 then
                            inst.posPlant = nil
                            break
                        end
                        inst.posPlant = { x = localPos.x - 11,y = 0,z = localPos.z-11 }
                    else
                        inst.posPlant = { x = localPos.x - 11, y = 0, z = inst.posPlant.z + 1 }
                    end
                else
                    inst.posPlant = { x = inst.posPlant.x + 3, y = 0, z = inst.posPlant.z }
                end
                if seends.components.deployable:CanDeploy(Vector3(inst.posPlant.x,inst.posPlant.y,inst.posPlant.z)) then
                    break
                end
            end
        end
        if inst.posPlant ~= nil then
            return BufferedAction(inst, nil, ACTIONS.AUTO_FARM_PLANT, seends , Vector3(inst.posPlant.x,inst.posPlant.y,inst.posPlant.z))
        end

    end
end

local function PickBerriesAction(inst)
    if inst.components.container:IsFull() then
        return
    end
    if inst.myHome == nil then
        return
    end

    local target = FindEntity(inst, SEE_BUSH_DIST, HasBerry, nil ,excludes)
    if target then
        if target:HasTag("dried") then
            return BufferedAction(inst, target, ACTIONS.HARVEST)
        elseif target:HasTag("beebox") and target.components.harvestable.produce >= target.components.harvestable.maxproduce then
            return BufferedAction(inst, target, ACTIONS.HARVEST)
        elseif target.components.crop ~= nil then
            if target.components.crop:IsReadyForHarvest() or target:HasTag("withered") then
                return BufferedAction(inst, target, ACTIONS.HARVEST)
            end
        elseif target:HasTag("mushroom_farm") and target.components.harvestable.produce >= 4 then
            return BufferedAction(inst, target, ACTIONS.HARVEST)
        elseif  target.components.pickable then
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
                changeEquipment(inst,"goldenshovel")
                return BufferedAction(inst, target, ACTIONS.DIG)
            end
        end
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

local function canPlant(inst)
    if inst.myHome == nil then
        return
    end

    local meatrack = FindEntity(inst, SEE_BUSH_DIST, hasMeatrock, {"oldfish_meatrack"}, excludes)
    if meatrack
            and meatrack.prefab == "meatrack"
            and meatrack.components.dryer ~= nil then
        local seends = inst.components.container:FindItem(function(v)
            return v.components.dryable ~= nil
        end)
        if seends and meatrack.components.dryer:CanDry(seends) then
            return BufferedAction(inst, meatrack, ACTIONS.DRY,seends)
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
                local seends = inst.components.container:FindItem(function(v)
                    return v.prefab == "poop"
                            or v.prefab == "spoiled_food"
                            or v.prefab == "guano"
                            or v.prefab == "rottenegg"
                            or v.prefab == "fertilizer"
                end)
                if seends == nil then
                    speak(inst,STRINGS.FERTILIZER_NOTIFICATION)
                else
                    return BufferedAction(inst, target, ACTIONS.AUTO_FERTILIZE, seends)
                end
            end

            if target.components.grower:IsEmpty() then
                local seends = inst.components.container:FindItem(function(v)
                    return string.find(v.prefab, "seeds") ~= nil
                            and v.components.deployable ~= nil
                            and v.components.deployable.ondeploy  ~= nil
                            and v.components.deployable.mode == DEPLOYMODE.CUSTOM
                end)
                if seends == nil then
                    speak(inst,STRINGS.PLANT_NOTIFICATION)
                else
                    return BufferedAction(inst, target, ACTIONS.AUTO_PLANT,seends)
                end
            end
        end
    end


    local target = FindEntity(inst, SEE_BUSH_DIST, hasMushroomFarm, {"oldfish_mushroom_farm"}, excludes)
    if target and target.components.harvestable and target.components.harvestable.produce == 0 then
        if target.prefab == "mushroom_farm" then
            local seends
            if target.remainingharvests == 0 then
                seends = inst.components.container:FindItem(function(v)
                    return v.prefab == "livinglog"
                end)
                if seends == nil then
                    speak(inst,STRINGS.ACTIVATE_MUSHROOM)
                end
            else
                seends = inst.components.container:FindItem(function(v)
                    return v.prefab == "blue_cap"
                            or v.prefab == "green_cap"
                            or v.prefab == "red_cap"
                end)
            end
            if seends then
                if TheWorld.state.iswinter then
                    return
                end
                return BufferedAction(inst, target, ACTIONS.GIVE,seends)
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
            if target.components.fueled ~= nil
                    and target.components.fueled.currentfuel / target.components.fueled.maxfuel < 0.5 then
                local seends = inst.components.container:FindItem(function(v)
                    return v.components.fuel ~= nil
                end)
                if seends == nil then
                    speak(inst,STRINGS.FIRESUPPRESSOR_FUEL)
                else
                    return BufferedAction(inst, target, ACTIONS.ADDFUEL, seends)
                end
            end
        end
    end

    local target = FindEntity(inst, SEE_BUSH_DIST, needActivation, {"plant"}, excludes)
    if target and target.components.pickable ~= nil and  target.components.pickable:CanBeFertilized() then
        local seends = inst.components.container:FindItem(function(v)
            return v.prefab == "poop"
                    or v.prefab == "spoiled_food"
                    or v.prefab == "guano"
                    or v.prefab == "rottenegg"
                    or v.prefab == "fertilizer"
        end)
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
    local target = FindEntity(inst, SEE_BUSH_DIST, hasTree, nil, excludes)
    if target then
        if not target:HasTag("stump") then
            if target.components.growable and target.components.growable.stage == 3  then
                changeEquipment(inst,"goldenaxe")
                return BufferedAction(inst, target, ACTIONS.CHOP)
            end
        else
            changeEquipment(inst,"goldenshovel")
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

        changeEquipment(inst,"goldenpickaxe")
        return BufferedAction(inst, target, ACTIONS.MINE)
    end
end

local function HasValidHome(inst)
    local home = inst.components.homeseeker ~= nil and inst.components.homeseeker.home or nil
    return home ~= nil
            and home:IsValid()
            and not (home.components.burnable ~= nil and home.components.burnable:IsBurning())
            and not home:HasTag("burnt")
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


function farmerBrain:OnStart()
    local root = PriorityNode({
        WhileNode(function()return self.inst.components.health.takingfiredamage or self.inst.components.hauntable.panic end, "Panic", Panic(self.inst)),
        IfNode(function()
            return self.inst.myHome or findHome(self.inst) end, "find home",
            WhileNode(function()
                return self.inst.myHome end, "approach home",
                PriorityNode({
                    EventNode(self.inst, "gohome", DoAction(self.inst, goHomeAction, "go home", true )),
                    DoAction(self.inst, isDiseased, "is diseased", true),
                    DoAction(self.inst, makeNewPlantAction, "plannt pos", true),
                    DoAction(self.inst, needFertilize, "need fertilize", true),
                    DoAction(self.inst, canPlant, "can plant", true),
                    DoAction(self.inst, pickUpAction, "pick up", true),
                    DoAction(self.inst, PickBerriesAction, "Pick Thing", true),
                    DoAction(self.inst, chopTree, "chop tree", true),
                    DoAction(self.inst, mineRock, "mine rock", true),
                    Leash(self.inst, getNoLeaderHomePos, MAX_SHRINE_WANDER_DIST, MIN_SHRINE_WANDER_DIST),
                    Wander(self.inst, getNoLeaderHomePos, MAX_SHRINE_WANDER_DIST - MIN_SHRINE_WANDER_DIST,{ minwaittime = SHRINE_LOITER_TIME * .5, randwaittime = SHRINE_LOITER_TIME_VAR })
                }, .2)

            )
        ),
        RunAway(self.inst, "hostile", SEE_PLAYER_DIST, STOP_RUN_DIST),
    },.2)
    self.bt = BT(self.inst, root)
end

return farmerBrain
