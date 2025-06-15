GLOBAL.setmetatable(
    GLOBAL.getfenv(1),
    {
        __index = function(self, index)
            return GLOBAL.rawget(GLOBAL, index)
        end
    }
)

PrefabFiles = {
    "koalebeef_summer",
    "koalebeef_winter",
    "koalebeef_summer_bell",
    "koalebeef_winter_bell"
}
local require = GLOBAL.require

local UpvalueHacker = require("tools/upvaluehacker3")
local writeables = require("writeables")
local kinds = UpvalueHacker.GetUpvalue(writeables.makescreen, "kinds")

if kinds == nil then
    return
end

local beefalo_names
local myprompt
local mycancel
local mymiddle
local myaccept
beefalo_names = {
    "Trunky",
    "Snuffles",
    "KoalaKing",
    "Tuskster",
    "Stomper",
    "Woolumbo",
    "Snorty",
    "Puffhide",
    "Mammufuzz",
    "Huffernut",
    "Snorb",
    "Waddlemount",
    "Trompo",
    "Thudthud",
    "Fuzzelump",
    "Nuzzlehorn",
    "Furble",
    "Blubberton",
    "Trumpado",
    "Kuffles"
}
myprompt = "What would you like to name your koalefant?"
mycancel = "Cancel"
mymiddle = "Random"
myaccept = "Accept"

kinds.koalebeef_summer = {
    prompt = myprompt,
    animbank = "ui_board_5x3",
    animbuild = "ui_board_5x3",
    menuoffset = GLOBAL.Vector3(6, -70, 0),
    maxcharacters = GLOBAL.TUNING.BEEFALO_NAMING_MAX_LENGTH,
    defaulttext = function(inst, doer)
        return "Friendly koalefant"
    end,
    cancelbtn = {text = mycancel, cb = nil, control = GLOBAL.CONTROL_CANCEL},
    middlebtn = {
        text = mymiddle,
        cb = function(inst, doer, widget)
            widget:OverrideText(beefalo_names[math.random(#beefalo_names)])
        end,
        control = GLOBAL.CONTROL_MENU_MISC_2
    },
    acceptbtn = {text = myaccept, cb = nil, control = GLOBAL.CONTROL_ACCEPT}
}
kinds.koalebeef_winter = {
    prompt = myprompt,
    animbank = "ui_board_5x3",
    animbuild = "ui_board_5x3",
    menuoffset = GLOBAL.Vector3(6, -70, 0),
    maxcharacters = GLOBAL.TUNING.BEEFALO_NAMING_MAX_LENGTH,
    defaulttext = function(inst, doer)
        return "Friendly koalefant"
    end,
    cancelbtn = {text = mycancel, cb = nil, control = GLOBAL.CONTROL_CANCEL},
    middlebtn = {
        text = mymiddle,
        cb = function(inst, doer, widget)
            widget:OverrideText(beefalo_names[math.random(#beefalo_names)])
        end,
        control = GLOBAL.CONTROL_MENU_MISC_2
    },
    acceptbtn = {text = myaccept, cb = nil, control = GLOBAL.CONTROL_ACCEPT}
}
GLOBAL.STRINGS.NAMES.KOALEBEEF_SUMMER = "Friendly Koalefant"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.KOALEBEEF_SUMMER =
    "This koalefant has developed a friendship with me and is no longer afraid of me."
GLOBAL.STRINGS.CHARACTERS.WILLOW.DESCRIBE.KOALEBEEF_SUMMER =
    "Haha, aren't you afraid that I will burn you? Just because I gave you a bite to eat?"
GLOBAL.STRINGS.CHARACTERS.WENDY.DESCRIBE.KOALEBEEF_SUMMER =
    "I easily gained the trust of this creature, it's so stupid."
GLOBAL.STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.KOALEBEEF_SUMMER =
    "Wolfgang has established a friendship with the baby koalefant!"
GLOBAL.STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.KOALEBEEF_SUMMER =
    "Feeding food is an effective way to gain the trust of koalefants."
GLOBAL.STRINGS.CHARACTERS.WAXWELL.DESCRIBE.KOALEBEEF_SUMMER = "I remember that I didn't let them do this..."
GLOBAL.STRINGS.CHARACTERS.WX78.DESCRIBE.KOALEBEEF_SUMMER = "Trust in organic matter is really cheap."
GLOBAL.STRINGS.CHARACTERS.WOODIE.DESCRIBE.KOALEBEEF_SUMMER =
    "I give you food and you help me carry wood. It makes sense, man."
GLOBAL.STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.KOALEBEEF_SUMMER = "Will you be my war koalefant?"
GLOBAL.STRINGS.CHARACTERS.WEBBER.DESCRIBE.KOALEBEEF_SUMMER = "We're friends with the Koalefant, yay!"
GLOBAL.STRINGS.CHARACTERS.WINONA.DESCRIBE.KOALEBEEF_SUMMER = "Ha, you're bought off at one stroke!"
GLOBAL.STRINGS.CHARACTERS.WURT.DESCRIBE.KOALEBEEF_SUMMER = "Wandering, we're friends now."
GLOBAL.STRINGS.CHARACTERS.WARLY.DESCRIBE.KOALEBEEF_SUMMER = "I won't be serving you to the table just yet."
GLOBAL.STRINGS.CHARACTERS.WORTOX.DESCRIBE.KOALEBEEF_SUMMER = "You're softer than a Piffle Bull!"
GLOBAL.STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.KOALEBEEF_SUMMER = "Fluffy friends are friends now"
GLOBAL.STRINGS.CHARACTERS.WALTER.DESCRIBE.KOALEBEEF_SUMMER = "Walter, we may have a new friend!"
GLOBAL.STRINGS.CHARACTERS.WANDA.DESCRIBE.KOALEBEEF_SUMMER = "How are you better than a Piffle Bull?"
GLOBAL.STRINGS.NAMES.KOALEBEEF_WINTER = "Friendly koalefant"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.KOALEBEEF_WINTER =
    "This koalefant has developed a friendship with me and is no longer afraid of me."
GLOBAL.STRINGS.CHARACTERS.WILLOW.DESCRIBE.KOALEBEEF_WINTER =
    "Haha, aren't you afraid that I'll burn you? Just because I gave you a bite to eat?"
GLOBAL.STRINGS.CHARACTERS.WENDY.DESCRIBE.KOALEBEEF_WINTER =
    "I easily gained the trust of this creature, it's so stupid."
GLOBAL.STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.KOALEBEEF_WINTER =
    "Wolfgang has developed a friendship with the baby koalefant!"
GLOBAL.STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.KOALEBEEF_WINTER =
    "Feeding food is an effective way to gain the trust of koalefants."
GLOBAL.STRINGS.CHARACTERS.WAXWELL.DESCRIBE.KOALEBEEF_WINTER = "I remember that I didn't let them do this..."
GLOBAL.STRINGS.CHARACTERS.WX78.DESCRIBE.KOALEBEEF_WINTER = "Trust in organic matter is really cheap."
GLOBAL.STRINGS.CHARACTERS.WOODIE.DESCRIBE.KOALEBEEF_WINTER =
    "I give you food, and you help me carry wood. It makes sense, man."
GLOBAL.STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.KOALEBEEF_WINTER = "Would you like to be my war koalefant?"
GLOBAL.STRINGS.CHARACTERS.WEBBER.DESCRIBE.KOALEBEEF_WINTER = "We're friends with the koalefant, yay!"
GLOBAL.STRINGS.CHARACTERS.WINONA.DESCRIBE.KOALEBEEF_WINTER = "Ha, you're bought at one morsel!"
GLOBAL.STRINGS.CHARACTERS.WURT.DESCRIBE.KOALEBEEF_WINTER = "Wandering, we're friends now."
GLOBAL.STRINGS.CHARACTERS.WARLY.DESCRIBE.KOALEBEEF_WINTER = "I won't be serving you to the table just yet."
GLOBAL.STRINGS.CHARACTERS.WORTOX.DESCRIBE.KOALEBEEF_WINTER = "You're softer than a bull!"
GLOBAL.STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.KOALEBEEF_WINTER = "Fluffy friends are friends now"
GLOBAL.STRINGS.CHARACTERS.WALTER.DESCRIBE.KOALEBEEF_WINTER = "Walter, we may have a new friend!"
GLOBAL.STRINGS.CHARACTERS.WANDA.DESCRIBE.KOALEBEEF_WINTER = "How are you better than Piffle Bull?"
GLOBAL.STRINGS.NAMES.KOALEBEEF_SUMMER_BELL = "Koala Bell"
GLOBAL.STRINGS.RECIPE_DESC.KOALEBEEF_SUMMER_BELL = "Friendly koalas love it."
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.KOALEBEEF_SUMMER_BELL =
    "It makes koalas friendlier, I'm sure science has an explanation for this."
GLOBAL.STRINGS.CHARACTERS.WILLOW.DESCRIBE.KOALEBEEF_SUMMER_BELL = "Wow, it's so easy to make friends with koalas!"
GLOBAL.STRINGS.CHARACTERS.WENDY.DESCRIBE.KOALEBEEF_SUMMER_BELL = "It's a shame it's not a real elephant bell."
GLOBAL.STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.KOALEBEEF_SUMMER_BELL = "Ding ding ding!"
GLOBAL.STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.KOALEBEEF_SUMMER_BELL =
    "Something about its sound will appeal to Koala elephants."
GLOBAL.STRINGS.CHARACTERS.WAXWELL.DESCRIBE.KOALEBEEF_SUMMER_BELL = "It seems to hypnotize Koala elephants."
GLOBAL.STRINGS.CHARACTERS.WX78.DESCRIBE.KOALEBEEF_SUMMER_BELL =
    "An effective tool for gaining the loyalty of Koala elephants."
GLOBAL.STRINGS.CHARACTERS.WOODIE.DESCRIBE.KOALEBEEF_SUMMER_BELL = "The Koala seems to like the sound of it."
GLOBAL.STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.KOALEBEEF_SUMMER_BELL = "The fleshy beast will be loyal to this bell."
GLOBAL.STRINGS.CHARACTERS.WEBBER.DESCRIBE.KOALEBEEF_SUMMER_BELL =
    "The Koala really likes this bell, whoever knocks it likes it!"
GLOBAL.STRINGS.CHARACTERS.WINONA.DESCRIBE.KOALEBEEF_SUMMER_BELL = "The Koala really likes that bell!"
GLOBAL.STRINGS.CHARACTERS.WURT.DESCRIBE.KOALEBEEF_SUMMER_BELL = "The big fat ball really likes the bell."
GLOBAL.STRINGS.CHARACTERS.WARLY.DESCRIBE.KOALEBEEF_SUMMER_BELL = "Isn't this the dinner bell?"
GLOBAL.STRINGS.CHARACTERS.WORTOX.DESCRIBE.KOALEBEEF_SUMMER_BELL = "What a strange magic!"
GLOBAL.STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.KOALEBEEF_SUMMER_BELL = "Ding Dong"
GLOBAL.STRINGS.CHARACTERS.WALTER.DESCRIBE.KOALEBEEF_SUMMER_BELL = "This koala seems to like the sound it makes!"
GLOBAL.STRINGS.CHARACTERS.WANDA.DESCRIBE.KOALEBEEF_SUMMER_BELL = "It makes taming koalas much faster!"
GLOBAL.STRINGS.NAMES.KOALEBEEF_WINTER_BELL = "Winter Koala Bell"
GLOBAL.STRINGS.RECIPE_DESC.KOALEBEEF_WINTER_BELL = "Friendly koalas love it."
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.KOALEBEEF_WINTER_BELL =
    "It makes koalas friendlier. I'm sure science has an explanation for this."
GLOBAL.STRINGS.CHARACTERS.WILLOW.DESCRIBE.KOALEBEEF_WINTER_BELL = "Wow, it's so easy to make friends with koalas!"
GLOBAL.STRINGS.CHARACTERS.WENDY.DESCRIBE.KOALEBEEF_WINTER_BELL = "Too bad it's not a real elephant bell."
GLOBAL.STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.KOALEBEEF_WINTER_BELL = "Ding ding ding!"
GLOBAL.STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.KOALEBEEF_WINTER_BELL =
    "Its sound has a certain quality that Koalas like."
GLOBAL.STRINGS.CHARACTERS.WAXWELL.DESCRIBE.KOALEBEEF_WINTER_BELL = "It seems to hypnotize Koalas."
GLOBAL.STRINGS.CHARACTERS.WX78.DESCRIBE.KOALEBEEF_WINTER_BELL = "An effective tool for gaining Koalas' loyalty."
GLOBAL.STRINGS.CHARACTERS.WOODIE.DESCRIBE.KOALEBEEF_WINTER_BELL = "Koalas seem to like the sound of it."
GLOBAL.STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.KOALEBEEF_WINTER_BELL =
    "Flesh beasts will pledge their loyalty to this bell."
GLOBAL.STRINGS.CHARACTERS.WEBBER.DESCRIBE.KOALEBEEF_WINTER_BELL =
    "The koala elephant really likes this bell, whoever knocks it likes it!"
GLOBAL.STRINGS.CHARACTERS.WINONA.DESCRIBE.KOALEBEEF_WINTER_BELL = "The koala elephant really likes that bell!"
GLOBAL.STRINGS.CHARACTERS.WURT.DESCRIBE.KOALEBEEF_WINTER_BELL = "The big fat ball really likes the bell."
GLOBAL.STRINGS.CHARACTERS.WARLY.DESCRIBE.KOALEBEEF_WINTER_BELL = "Isn't this the bell for dinner?"
GLOBAL.STRINGS.CHARACTERS.WORTOX.DESCRIBE.KOALEBEEF_WINTER_BELL = "What a strange magic!"
GLOBAL.STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.KOALEBEEF_WINTER_BELL = "Ding Dong"
GLOBAL.STRINGS.CHARACTERS.WALTER.DESCRIBE.KOALEBEEF_WINTER_BELL = "This koalefant seems to like the sound it makes!"
GLOBAL.STRINGS.CHARACTERS.WANDA.DESCRIBE.KOALEBEEF_WINTER_BELL = "It makes taming koalefants a lot faster!"

AddRecipe2(
    "koalebeef_summer_bell",
    {Ingredient("goldnugget", 3), Ingredient("flint", 1)},
    GLOBAL.TECH.SCIENCE_ONE,
    {image = "beef_bell.tex"},
    {"RIDING"}
)
AddRecipe2(
    "koalebeef_winter_bell",
    {Ingredient("goldnugget", 3), Ingredient("flint", 1)},
    GLOBAL.TECH.SCIENCE_ONE,
    {image = "beef_bell.tex"},
    {"RIDING"}
)

local CRAFTING_FILTERS = GLOBAL.CRAFTING_FILTERS
local function ChangeSortKey(recipe_name, recipe_reference, filter, after)
    local recipes = CRAFTING_FILTERS[filter].recipes
    local recipe_name_index
    local recipe_reference_index

    for i = #recipes, 1, -1 do
        if recipes[i] == recipe_name then
            recipe_name_index = i
        elseif recipes[i] == recipe_reference then
            recipe_reference_index = i + (after and 1 or 0)
        end
        if recipe_name_index and recipe_reference_index then
            if recipe_name_index >= recipe_reference_index then
                table.remove(recipes, recipe_name_index)
                table.insert(recipes, recipe_reference_index, recipe_name)
            else
                table.insert(recipes, recipe_reference_index, recipe_name)
                table.remove(recipes, recipe_name_index)
            end
            break
        end
    end
end
ChangeSortKey("koalebeef_summer_bell", "beef_bell", "RIDING", true)
ChangeSortKey("koalebeef_winter_bell", "koalebeef_summer_bell", "RIDING", true)

local function ShouldAcceptItema(inst, item)
    return inst.components.eater:CanEat(item)
end

local function OnGetItemFromPlayera(inst, giver, item)
    if inst.components.eater:CanEat(item) then
        item:DoTaskInTime(0, item.Remove)
        local grown = GLOBAL.SpawnPrefab("koalebeef_summer")
        grown.Transform:SetPosition(inst.Transform:GetWorldPosition())
        grown.Transform:SetRotation(inst.Transform:GetRotation())
        grown.components.hunger:SetPercent(0.25)
        grown.sg:GoToState("graze")
        inst:Remove()
    end
end

local function OnRefuseItema(inst, item)
end

local function Koalebeefsummerint(inst)
    if GLOBAL.TheWorld.ismastersim then
        inst.components.eater:SetDiet(
            {GLOBAL.FOODTYPE.VEGGIE, GLOBAL.FOODTYPE.ROUGHAGE},
            {GLOBAL.FOODTYPE.VEGGIE, GLOBAL.FOODTYPE.ROUGHAGE}
        )
        inst:AddComponent("trader")
        inst.components.trader:SetAcceptTest(ShouldAcceptItema)
        inst.components.trader.onaccept = OnGetItemFromPlayera
        inst.components.trader.onrefuse = OnRefuseItema
        inst.components.trader.deleteitemonaccept = false
    end
end
AddPrefabPostInit("koalefant_summer", Koalebeefsummerint)

local function ShouldAcceptItemaa(inst, item)
    return inst.components.eater:CanEat(item)
end

local function OnGetItemFromPlayeraa(inst, giver, item)
    if inst.components.eater:CanEat(item) then
        item:DoTaskInTime(0, item.Remove)
        local grown = GLOBAL.SpawnPrefab("koalebeef_winter")
        grown.Transform:SetPosition(inst.Transform:GetWorldPosition())
        grown.Transform:SetRotation(inst.Transform:GetRotation())
        grown.components.hunger:SetPercent(0.25)
        grown.sg:GoToState("graze")
        inst:Remove()
    end
end

local function OnRefuseItemaa(inst, item)
end

local function Koalebeefwinterint(inst)
    if GLOBAL.TheWorld.ismastersim then
        inst.components.eater:SetDiet(
            {GLOBAL.FOODTYPE.VEGGIE, GLOBAL.FOODTYPE.ROUGHAGE},
            {GLOBAL.FOODTYPE.VEGGIE, GLOBAL.FOODTYPE.ROUGHAGE}
        )
        inst:AddComponent("trader")
        inst.components.trader:SetAcceptTest(ShouldAcceptItemaa)
        inst.components.trader.onaccept = OnGetItemFromPlayeraa
        inst.components.trader.onrefuse = OnRefuseItemaa
        inst.components.trader.deleteitemonaccept = false
    end
end
AddPrefabPostInit("koalefant_winter", Koalebeefwinterint)

local function OnSetOwner(inst)
    inst:DoTaskInTime(
        0,
        function()
            if inst.components.playeractionpicker ~= nil then
                local _pointspecialactionsfn = inst.components.playeractionpicker.pointspecialactionsfn
                inst.components.playeractionpicker.pointspecialactionsfn = function(inst, pos, useitem, right)
                    if
                        inst.replica.rider and inst.replica.rider:IsRiding() and inst.replica.rider:GetMount() and
                            inst.replica.rider:GetMount():HasTag("Fant_CC") and
                            not inst.replica.rider:GetMount():HasTag("FeiDuCD")
                     then
                        if inst.replica.inventory:Has("wortox_soul", 1) then
                            if
                                right and inst.components.playercontroller and
                                    inst.components.playercontroller:IsControlPressed(GLOBAL.CONTROL_FORCE_INSPECT)
                             then
                                return {ACTIONS.FANT_CHARGE}
                            end
                        else
                            if right then
                                return {ACTIONS.FANT_CHARGE}
                            end
                        end
                    end
                    return _pointspecialactionsfn ~= nil and _pointspecialactionsfn(inst, pos, useitem, right) or {}
                end
            end
        end
    )
end

local MOUNT_fn_old = ACTIONS.MOUNT.fn
ACTIONS.MOUNT.fn = function(act)
    if
        act.doer.components.inventory and act.doer.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY) and
            (act.doer.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY).prefab == "trunkvest_winter" or
                act.doer.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY).prefab == "trunkvest_summer")
     then
        if
            act.target:HasTag("koalefant") and act.target.components.domesticatable ~= nil and
                act.target.components.domesticatable:GetObedience() < act.target.components.domesticatable.maxobedience
         then
            act.target.components.domesticatable:DeltaObedience(1)
        end
        if act.target.components.combat then
            act.target.components.combat:DropTarget()
        end
    end

    if
        act.target:HasTag("koalefant") and act.target.components.domesticatable and
            act.target.components.domesticatable:IsDomesticated() and
            act.target.tendency and
            act.target.tendency ~= TENDENCY.PUDGY
     then
        act.target:AddTag("Fant_CC")
    end
    return MOUNT_fn_old(act)
end

local LEAP_MAX_DIST = 18
local LEAP_MIN_DIST = 3
local LEAP_MAX_SPEED = 30
local LEAP_MIN_SPEED = LEAP_MAX_SPEED * LEAP_MIN_DIST / LEAP_MAX_DIST
local LEAP_MAX_DIST_SQ = LEAP_MAX_DIST * LEAP_MAX_DIST
local LEAP_MIN_DIST_SQ = LEAP_MIN_DIST * LEAP_MIN_DIST

local leap_action =
    AddAction(
    "FANT_CHARGE",
    "Sprint! Sprint!",
    function(act)
        if act.doer ~= nil and act.doer.sg ~= nil and act.doer.sg.currentstate.name == "fant_cc_pre" then
            act.doer.sg:GoToState("fant_cc", {pos = act.pos})
            return true
        end
    end
)

leap_action.priority = 1
leap_action.rmb = true
leap_action.mount_valid = true
leap_action.distance = 36

AddStategraphPostInit(
    "wilson",
    function(sg)
        local old_onattacked = sg.events["attacked"].fn
        sg.events["attacked"] =
            EventHandler(
            "attacked",
            function(inst, data, ...)
                if inst.fantchongfeng then
                    if not inst.sg:HasStateTag("frozen") and not inst.sg:HasStateTag("sleeping") then
                        if inst.hurtsoundoverride ~= nil then
                            inst.SoundEmitter:PlaySound(inst.hurtsoundoverride, nil, inst.hurtsoundvolume)
                        elseif not inst:HasTag("mime") then
                            inst.SoundEmitter:PlaySound(
                                (inst.talker_path_override or "dontstarve/characters/") ..
                                    (inst.soundsname or inst.prefab) .. "/hurt",
                                nil,
                                inst.hurtsoundvolume
                            )
                        end
                        return
                    end
                end
                return old_onattacked(inst, data, ...)
            end
        )
    end
)

AddPlayerPostInit(
    function(inst)
        inst:ListenForEvent("setowner", OnSetOwner)
    end
)

local function AddEnemyDebuffFx(fx, target)
    if target and target.components.health and not target.components.health:IsDead() then
        target:DoTaskInTime(
            math.random() * 0.25,
            function()
                local x, y, z = target.Transform:GetWorldPosition()
                local fx = SpawnPrefab(fx)
                if fx then
                    fx.Transform:SetPosition(x, y, z)
                end

                return fx
            end
        )
    end
end
local WORKABLES_CANT_TAGS = {"insect", "INLIMBO"}
local WORKABLES_ONEOF_TAGS = {"MINE_workable", "CHOP_workable", "heavy"}
--------------------------------------------------------------------------

AddStategraphState(
    "wilson",
    State {
        name = "fant_cc_pre",
        tags = {"doing", "busy", "canrotate"},
        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("emoteXL_angry")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/koalefant/angry")

            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(false)
            end

            inst.fantchongfeng = true
            local fant = inst.components.rider.mount
            fant:AddTag("FeiDuCD")
            fant:DoTaskInTime(
                15,
                function()
                    if fant then
                        fant:RemoveTag("FeiDuCD")
                    end
                end
            )

            local PL = inst
            if PL.prefab == "willow" then
                PL.components.talker:Say("Crush them to ashes!!!")
            elseif PL.prefab == "wolfgang" then
                PL.components.talker:Say("Wolfgang is the strongest cavalryman!!")
            elseif PL.prefab == "wendy" then
                PL.components.talker:Say("Trample them into hell!")
            elseif PL.prefab == "wx78" then
                PL.components.talker:Say("Enable overload acceleration!")
            elseif PL.prefab == "wickerbottom" then
                PL.components.talker:Say("Haha, charge at those who don't respect knowledge!")
            elseif PL.prefab == "woodie" then
                PL.components.talker:Say("Knock down those trees!")
            elseif PL.prefab == "waxwell" then
                PL.components.talker:Say("I am the only king!")
            elseif PL.prefab == "wathgrithr" then
                PL.components.talker:Say("In the name of Valhalla!!!")
            elseif PL.prefab == "webber" then
                PL.components.talker:Say("Let’s go!!")
            elseif PL.prefab == "winona" then
                PL.components.talker:Say("Go ahead, like gears rolling over scrap metal!")
            elseif PL.prefab == "warly" then
                PL.components.talker:Say("Turn them into ingredients!")
            elseif PL.prefab == "wortox" then
                PL.components.talker:Say("Q interrupts its E! ! ! !")
            elseif PL.prefab == "wormwood" then
                PL.components.talker:Say("My friend is angry!")
            elseif PL.prefab == "wurt" then
                PL.components.talker:Say("You vagrants, go to hell!")
            elseif PL.prefab == "walter" then
                PL.components.talker:Say("Wobi, follow closely!!")
            elseif PL.prefab == "wanda" then
                PL.components.talker:Say("Dash into time and space!!")
            else
                PL.components.talker:Say("Science, let's speed up!")
            end

            local x, y, z = inst.Transform:GetWorldPosition()
            inst:DoTaskInTime(
                0.2,
                function()
                    local fx = SpawnPrefab("spider_heal_ground_fx")
                    inst.SoundEmitter:PlaySound("dontstarve/common/deathpoof")
                    if fx ~= nil then
                        fx.Transform:SetScale(.6, .6, .6)
                        fx.Transform:SetPosition(x, 0, z)
                    end
                end
            )

            local ents =
                TheSim:FindEntities(
                x,
                0,
                z,
                15,
                nil,
                {"epic", "companion", "notraptrigger", "ghost", "player", "INLIMBO", "flight", "invisible", "notarget"}
            )
            SpawnPrefab("groundpoundring_fx").Transform:SetPosition(inst.Transform:GetWorldPosition())
            for k, v in pairs(ents) do
                if v and v.components.hauntable and v.components.hauntable.panicable then
                    if v.components.follower and not v.components.follower.leader then
                        v.components.hauntable:Panic(4)
                        AddEnemyDebuffFx("battlesong_instant_panic_fx", v)
                    elseif v.components.follower == nil then
                        v.components.hauntable:Panic(4)
                        AddEnemyDebuffFx("battlesong_instant_panic_fx", v)
                    end
                end
            end
        end,
        events = {
            EventHandler(
                "animover",
                function(inst)
                    if inst.AnimState:AnimDone() then
                        if inst.bufferedaction ~= nil then
                            inst:PerformBufferedAction()
                        else
                            inst.sg:GoToState("idle")
                        end
                    end
                end
            )
        },
        onexit = function(inst)
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(true)
            end
            if inst.fantchongfeng then
                inst.fantchongfeng = false
            end
        end
    }
)

local function ToggleOffPhysics(inst)
    inst.sg.statemem.isphysicstoggle = true
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.GROUND)
end

local function ToggleOnPhysics(inst)
    inst.sg.statemem.isphysicstoggle = nil
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.WORLD)
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)
    inst.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
    inst.Physics:CollidesWith(COLLISION.CHARACTERS)
    inst.Physics:CollidesWith(COLLISION.GIANTS)
end

AddStategraphState(
    "wilson",
    State {
        name = "fant_cc",
        tags = {"doing", "busy", "canrotate", "nopredict", "nomorph"},
        onenter = function(inst, data)
            inst.components.locomotor:SetExternalSpeedMultiplier(inst, "TT2", 2)
            inst.components.locomotor:RunForward()
            local pos = data.pos:GetPosition()
            inst:ForceFacePoint(pos.x, 0, pos.z)

            if not inst.AnimState:IsCurrentAnimation("run_loop") then
                inst.AnimState:PlayAnimation("run_loop", true)
            end

            PlayFootstep(inst)

            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(false)
            end
            inst.fantchongfeng = true

            inst.pohuai =
                inst:DoPeriodicTask(
                0.1,
                function()
                    local x, y, z = inst.Transform:GetWorldPosition()
                    local heading_angle = inst.Transform:GetRotation() * DEGREES
                    local x1, z1 = math.cos(heading_angle), -math.sin(heading_angle)

                    for i, v in ipairs(TheSim:FindEntities(x, 0, z, 3, nil, WORKABLES_CANT_TAGS, WORKABLES_ONEOF_TAGS)) do
                        local x2, y2, z2 = v.Transform:GetWorldPosition()
                        local dx, dz = x2 - x, z2 - z
                        local len = math.sqrt(dx * dx + dz * dz)
                        if len <= 0 or x1 * dx / len + z1 * dz / len > .3 then
                            if v.prefab == "marbleshrub" and v.statedata and v.statedata.name == "short" then
                            else
                                v.components.workable:WorkedBy(inst, 20)
                                SpawnPrefab("collapse_small").Transform:SetPosition(v.Transform:GetWorldPosition())
                                if not v:HasTag("heavy") then
                                    inst.components.combat:GetAttacked(v, math.random(15, 30))
                                end
                            end
                        end
                    end

                    for i, v in ipairs(TheSim:FindEntities(x, 0, z, 3)) do
                        local target = v
                        if
                            target and target:IsValid() and target.prefab ~= "williambrute" and
                                not target:HasTag("companion") and
                                not target:HasTag("player") and
                                target.components and
                                target.components.locomotor and
                                not target:HasTag("stageusher") and
                                not (target.components.follower and target.components.follower.leader and
                                    target.components.follower.leader:HasTag("player"))
                         then
                            local x, y, z = inst.Transform:GetWorldPosition()
                            local tx, ty, tz = target.Transform:GetWorldPosition()

                            local rad = math.rad(inst:GetAngleToPoint(tx, ty, tz))
                            inst.powerlevel = 10
                            if target.components.combat then
                                if target.components.inventoryitem and target.components.inventoryitem.owner then
                                else
                                    target.components.combat:GetAttacked(inst, 34)
                                end
                            end
                            SpawnPrefab("collapse_small").Transform:SetPosition(target.Transform:GetWorldPosition())
                            for i = 1, 50 do
                                target:DoTaskInTime(
                                    (i - 1) / 50,
                                    function(target)
                                        if target ~= nil and inst ~= nil then
                                            local tx2, ty2, tz2 = target.Transform:GetWorldPosition()
                                            local velx = math.cos(rad) -- * 4.5
                                            local velz = -math.sin(rad) -- * 4.5
                                            local giantreduction =
                                                target:HasTag("epic") and 8 or target:HasTag("smallcreature") and 2 or 3
                                            if tx2 then
                                                local dx, dy, dz =
                                                    tx2 + (((inst.powerlevel) / (i + 1)) * velx) / giantreduction,
                                                    ty2,
                                                    tz2 + (((inst.powerlevel) / (i + 1)) * velz) / giantreduction
                                                local ground = TheWorld.Map:IsPassableAtPoint(dx, dy, dz)
                                                local boat = TheWorld.Map:GetPlatformAtPoint(dx, dz)
                                                local ocean = TheWorld.Map:IsOceanAtPoint(dx, dy, dz)
                                                local on_water = nil

                                                if GLOBAL.KnownModIndex:IsModEnabled("workshop-1467214795") then
                                                    on_water = IsOnWater(dx, dy, dz)
                                                end

                                                if
                                                    not (target.sg ~= nil and
                                                        (target.sg:HasStateTag("swimming") or
                                                            target.sg:HasStateTag("invisible")))
                                                 then
                                                    if
                                                        target ~= nil and target.components.locomotor ~= nil and
                                                            dx ~= nil and
                                                            (ground or boat or
                                                                ocean and
                                                                    target.components.locomotor:CanPathfindOnWater() or
                                                                target.components.tiletracker ~= nil and
                                                                    not target:HasTag("whale"))
                                                     then
                                                        if
                                                            not target:HasTag("aquatic") and not on_water or
                                                                target:HasTag("aquatic") and on_water
                                                         then
                                                            target.Transform:SetPosition(dx, dy, dz)
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                )
                            end
                        end
                    end
                end
            )
        end,
        onupdate = function(inst)
            if inst.sg.statemem.isphysicstoggle then
                local x, y, z = inst.Transform:GetWorldPosition()
                local angle = inst.Transform:GetRotation() * DEGREES
                local radius = .5
                x = x + .75 * radius * math.cos(angle)
                z = z - .75 * radius * math.sin(angle)
                local ents = TheSim:FindEntities(x, 0, z, radius, {"wall"})
                for i, v in ipairs(ents) do
                    if v.components.health ~= nil and v.components.health:GetPercent() > .5 then
                        ToggleOnPhysics(inst)
                        return
                    end
                end
            end
        end,
        timeline = {
            TimeEvent(
                5 * FRAMES,
                function(inst)
                    SpawnPrefab("ground_chunks_breaking").Transform:SetPosition(inst.Transform:GetWorldPosition())
                end
            ),
            TimeEvent(
                8 * FRAMES,
                function(inst)
                    SpawnPrefab("ground_chunks_breaking").Transform:SetPosition(inst.Transform:GetWorldPosition())
                end
            ),
            TimeEvent(10 * FRAMES, PlayFootstep),
            TimeEvent(
                12 * FRAMES,
                function(inst)
                    SpawnPrefab("ground_chunks_breaking").Transform:SetPosition(inst.Transform:GetWorldPosition())
                end
            ),
            TimeEvent(13 * FRAMES, PlayFootstep),
            TimeEvent(
                14 * FRAMES,
                function(inst)
                    SpawnPrefab("ground_chunks_breaking").Transform:SetPosition(inst.Transform:GetWorldPosition())
                end
            ),
            TimeEvent(17 * FRAMES, PlayFootstep),
            TimeEvent(
                18 * FRAMES,
                function(inst)
                    SpawnPrefab("ground_chunks_breaking").Transform:SetPosition(inst.Transform:GetWorldPosition())
                end
            ),
            TimeEvent(
                20 * FRAMES,
                function(inst)
                    SpawnPrefab("ground_chunks_breaking").Transform:SetPosition(inst.Transform:GetWorldPosition())
                end
            ),
            TimeEvent(
                22 * FRAMES,
                function(inst)
                    SpawnPrefab("ground_chunks_breaking").Transform:SetPosition(inst.Transform:GetWorldPosition())
                end
            ),
            TimeEvent(24 * FRAMES, PlayFootstep),
            TimeEvent(
                26 * FRAMES,
                function(inst)
                    SpawnPrefab("ground_chunks_breaking").Transform:SetPosition(inst.Transform:GetWorldPosition())
                end
            ),
            TimeEvent(28 * FRAMES, PlayFootstep),
            TimeEvent(
                30 * FRAMES,
                function(inst)
                    SpawnPrefab("ground_chunks_breaking").Transform:SetPosition(inst.Transform:GetWorldPosition())
                end
            ),
            TimeEvent(32 * FRAMES, PlayFootstep),
            TimeEvent(
                34 * FRAMES,
                function(inst)
                    SpawnPrefab("ground_chunks_breaking").Transform:SetPosition(inst.Transform:GetWorldPosition())
                end
            ),
            TimeEvent(38 * FRAMES, PlayFootstep),
            TimeEvent(
                40 * FRAMES,
                function(inst)
                    SpawnPrefab("ground_chunks_breaking").Transform:SetPosition(inst.Transform:GetWorldPosition())
                end
            ),
            TimeEvent(44 * FRAMES, PlayFootstep),
            TimeEvent(
                46 * FRAMES,
                function(inst)
                    SpawnPrefab("ground_chunks_breaking").Transform:SetPosition(inst.Transform:GetWorldPosition())
                end
            ),
            TimeEvent(48 * FRAMES, PlayFootstep),
            TimeEvent(
                50 * FRAMES,
                function(inst)
                    SpawnPrefab("ground_chunks_breaking").Transform:SetPosition(inst.Transform:GetWorldPosition())
                end
            ),
            TimeEvent(52 * FRAMES, PlayFootstep),
            TimeEvent(
                54 * FRAMES,
                function(inst)
                    SpawnPrefab("ground_chunks_breaking").Transform:SetPosition(inst.Transform:GetWorldPosition())
                end
            ),
            TimeEvent(56 * FRAMES, PlayFootstep),
            TimeEvent(
                58 * FRAMES,
                function(inst)
                    SpawnPrefab("ground_chunks_breaking").Transform:SetPosition(inst.Transform:GetWorldPosition())
                end
            ),
            TimeEvent(
                58 * FRAMES,
                function(inst)
                    inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt")
                end
            ),
            TimeEvent(
                60 * FRAMES,
                function(inst)
                    inst.Physics:Stop()
                    inst.sg:GoToState("run_stop")
                end
            )
        },
        onexit = function(inst)
            inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "TT2")
            if inst.sg.statemem.isphysicstoggle then
                ToggleOnPhysics(inst)
            end
            if inst.pohuai then
                inst.pohuai:Cancel()
            end
            if inst.fantchongfeng then
                inst.fantchongfeng = false
            end
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(true)
            end
        end
    }
)

AddStategraphState(
    "wilson_client",
    State {
        name = "fant_cc_pre",
        tags = {"doing", "busy", "canrotate"},
        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("emoteXL_angry")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/koalefant/angry")

            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(false)
            end

            inst.fantchongfeng = true

            inst:PerformPreviewBufferedAction()
        end,
        onupdate = function(inst)
            if inst:HasTag("doing") then
                if inst.entity:FlattenMovementPrediction() then
                    inst.sg:GoToState("idle", "noanim")
                end
            elseif inst.bufferedaction == nil then
                inst.sg:GoToState("idle")
            end
        end,
        ontimeout = function(inst)
            inst:ClearBufferedAction()
            inst.sg:GoToState("idle")
        end,
        onexit = function(inst)
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(true)
            end
            if inst.fantchongfeng then
                inst.fantchongfeng = false
            end
        end
    }
)

AddStategraphActionHandler(
    "wilson",
    ActionHandler(
        ACTIONS.FANT_CHARGE,
        function(inst)
            return not inst.sg:HasStateTag("busy") and (inst.sg:HasStateTag("moving") or inst.sg:HasStateTag("idle")) and
                "fant_cc_pre" or
                nil
        end
    )
)

AddStategraphActionHandler(
    "wilson_client",
    ActionHandler(
        ACTIONS.FANT_CHARGE,
        function(inst)
            return not (inst.sg:HasStateTag("busy") or inst:HasTag("busy")) and inst.entity:CanPredictMovement() and
                (inst.sg:HasStateTag("moving") or inst.sg:HasStateTag("idle")) and
                "fant_cc_pre" or
                nil
        end
    )
)
