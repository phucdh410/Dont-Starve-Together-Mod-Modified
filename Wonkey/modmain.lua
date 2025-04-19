PrefabFiles = {
	"wonkey2",
	"wonkey2_none",
    "monkeyhut2",
    "powdermonkey",
    "cursed_monkey_token",
    "monkeyisland_map",
    "superprimemate"
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/wonkey2.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/wonkey2.xml" ),

    Asset( "IMAGE", "bigportraits/wonkey2.tex" ),
    Asset( "ATLAS", "bigportraits/wonkey2.xml" ),

	Asset( "IMAGE", "images/map_icons/wonkey2.tex" ),
	Asset( "ATLAS", "images/map_icons/wonkey2.xml" ),

	Asset( "IMAGE", "images/avatars/avatar_wonkey2.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_wonkey2.xml" ),

	Asset( "IMAGE", "images/avatars/avatar_ghost_wonkey2.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_wonkey2.xml" ),

	Asset( "IMAGE", "images/avatars/self_inspect_wonkey2.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_wonkey2.xml" ),

	Asset( "IMAGE", "images/names_wonkey2.tex" ),
    Asset( "ATLAS", "images/names_wonkey2.xml" ),

	Asset( "IMAGE", "images/names_gold_wonkey2.tex" ),
    Asset( "ATLAS", "images/names_gold_wonkey2.xml" ),

    Asset( "IMAGE", "images/names_gold_wonkey2.tex" ),
    Asset( "ATLAS", "images/names_gold_wonkey2.xml" ),

    Asset( "IMAGE", "images/inventoryimages/cursed_monkey_token.tex" ),
    Asset( "ATLAS", "images/inventoryimages/cursed_monkey_token.xml" ),

    Asset("ATLAS", "images/inventoryimages/monkeyhut2.xml"),
    Asset( "ANIM", "anim/monkeyisland_map.zip"),
    Asset("SOUNDPACKAGE", "sound/monkeyisland.fev"),
	Asset("SOUND", "sound/monkeyisland.fsb"),
}

AddMinimapAtlas("images/map_icons/wonkey2.xml")
RegisterInventoryItemAtlas(GLOBAL.resolvefilepath("images/inventoryimages/cursed_monkey_token.xml"), "cursed_monkey_token.tex")

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local Ingredient = GLOBAL.Ingredient
local TECH = GLOBAL.TECH

GLOBAL.CONFIG = {
    wonkey_hunger = GetModConfigData("wonkey_hunger"),
    wonkey_sanity = GetModConfigData("wonkey_sanity"),
    wonkey_health = GetModConfigData("wonkey_health"),
    wonkey_run_start = GetModConfigData("wonkey_run_start"),
    wonkey_notrinkets = GetModConfigData("wonkey_notrinkets"),
    wonkey_keep_trinkets = GetModConfigData("wonkey_keep_trinkets"),
    trinket_health = GetModConfigData("trinket_health"),
    trinket_sanity = GetModConfigData("trinket_sanity"),
    buff_duration = GetModConfigData("buff_duration"),
    wonkey_enable_speech = GetModConfigData("wonkey_enable_speech"),
    wonkey_line_replace = GetModConfigData("wonkey_line_replace"),
    bandana_rate = GetModConfigData("bandana_rate"),
    bandana_sanity = GetModConfigData("bandana_sanity"),
    tricorn_dmg = GetModConfigData("tricorn_dmg"),
    tricorn_monkeydmg = GetModConfigData("tricorn_monkeydmg"),
    pollys_rate = GetModConfigData("pollys_rate"),
    pollys_masterhat = GetModConfigData("pollys_masterhat"),
    pollys_speed = GetModConfigData("pollys_speed"),
    polly_immortal = GetModConfigData("polly_immortal"),
    polly_dismiss = GetModConfigData("polly_dismiss"),
    cutless_dmg = GetModConfigData("cutless_dmg"),
    oarmonkey_dmg = GetModConfigData("oarmonkey_dmg"),
    banner_sanity = GetModConfigData("banner_sanity"),
    follower_names = GetModConfigData("follower_names"),
    powdermonkey_hp = GetModConfigData("powdermonkey_hp"),
    powdermonkey_dmg = GetModConfigData("powdermonkey_dmg"),
    powdermonkey_time = GetModConfigData("powdermonkey_time"),
    supermonkey_hp = GetModConfigData("supermonkey_hp"),
    supermonkey_dmg = GetModConfigData("supermonkey_dmg"),
    supermonkey_time = GetModConfigData("supermonkey_time"),
    diveatk_toggle = GetModConfigData("diveatk_toggle"),
    diveatk_cooldown = GetModConfigData("diveatk_cooldown"),
    --splumonkey_recruit = GetModConfigData("splumonkey_recruit"),
    --splumonkey_hp = GetModConfigData("splumonkey_hp"),
    --splumonkey_dmg = GetModConfigData("splumonkey_dmg"),
    --splumonkey_time = GetModConfigData("splumonkey_time"),
    wonkeycurse_on = GetModConfigData("wonkeycurse_on"),
    wonkeycurse_crafts = GetModConfigData("wonkeycurse_crafts"),
    islandmap_toggle = GetModConfigData("islandmap_toggle"),
}

if GLOBAL.CONFIG.wonkeycurse_crafts then
    AddRecipe2("cursed_monkey_token", {Ingredient("rope", 1), Ingredient("boneshard", 2), Ingredient("palmcone_scale", 2)}, TECH.NONE, {builder_tag="monkeypirate", numtogive = 1}, {"CHARACTER"})
    AddRecipe2("cutless", {Ingredient("twigs", 1), Ingredient("log", 1)}, TECH.NONE, {builder_tag="monkey", numtogive = 1}, {"CHARACTER", "WEAPONS"})
    AddRecipe2("oar_monkey", {Ingredient("oar", 1), Ingredient("rope", 1), Ingredient("palmcone_scale", 3)}, TECH.NONE, {builder_tag="monkey", numtogive = 1}, {"CHARACTER", "WEAPONS"})
    AddRecipe2("monkey_smallhat", {Ingredient("silk", 4)}, TECH.NONE, {builder_tag="monkey", numtogive = 1}, {"CHARACTER", "CLOTHING"})
    AddRecipe2("monkey_mediumhat", {Ingredient("silk", 6), Ingredient("charcoal", 3), Ingredient("cursed_monkey_token", 2)}, TECH.NONE, {builder_tag="monkeypirate", numtogive = 1}, {"CHARACTER", "CLOTHING"})
    AddRecipe2("blackflag", {Ingredient("beardhair", 6), Ingredient("silk", 4)}, TECH.NONE, {builder_tag="monkey", numtogive = 1}, {"CHARACTER"})
    AddRecipe2("stash_map", {Ingredient("papyrus", 1), Ingredient("featherpencil", 1), Ingredient("cursed_monkey_token", 2)}, TECH.NONE, {builder_tag="monkeypirate", numtogive = 1}, {"CHARACTER"})

    local monkeyhut2 = Ingredient("monkeyhut2", 1)
    monkeyhut2.atlas = "images/inventoryimages/monkeyhut2.xml"
    RegisterInventoryItemAtlas("images/inventoryimages/monkeyhut2.xml", "monkeyhut2.tex")
    AddRecipe2("monkeyhut2", {Ingredient("boards", 4), Ingredient("cutstone", 3), Ingredient("palmcone_scale", 6)}, TECH.NONE, {builder_tag="monkey", placer="monkeyhut2_placer"}, {"CHARACTER", "STRUCTURES"})
else
    AddRecipe2("cursed_monkey_token", {Ingredient("rope", 1), Ingredient("boneshard", 2), Ingredient("palmcone_scale", 2)}, TECH.NONE, {builder_tag="monkeypirate", numtogive = 1}, {"CHARACTER"})
    AddRecipe2("cutless", {Ingredient("twigs", 1), Ingredient("log", 1)}, TECH.NONE, {builder_tag="monkeypirate", numtogive = 1}, {"CHARACTER", "WEAPONS"})
    AddRecipe2("oar_monkey", {Ingredient("oar", 1), Ingredient("rope", 1), Ingredient("palmcone_scale", 3)}, TECH.NONE, {builder_tag="monkeypirate", numtogive = 1}, {"CHARACTER", "WEAPONS"})
    AddRecipe2("monkey_smallhat", {Ingredient("silk", 4)}, TECH.NONE, {builder_tag="monkeypirate", numtogive = 1}, {"CHARACTER", "CLOTHING"})
    AddRecipe2("monkey_mediumhat", {Ingredient("silk", 6), Ingredient("charcoal", 3), Ingredient("cursed_monkey_token", 2)}, TECH.NONE, {builder_tag="monkeypirate", numtogive = 1}, {"CHARACTER", "CLOTHING"})
    AddRecipe2("blackflag", {Ingredient("beardhair", 6), Ingredient("silk", 4)}, TECH.NONE, {builder_tag="monkeypirate", numtogive = 1}, {"CHARACTER"})
    AddRecipe2("stash_map", {Ingredient("papyrus", 1), Ingredient("featherpencil", 1), Ingredient("cursed_monkey_token", 2)}, TECH.NONE, {builder_tag="monkeypirate", numtogive = 1}, {"CHARACTER"})

    local monkeyhut2 = Ingredient("monkeyhut2", 1)
    monkeyhut2.atlas = "images/inventoryimages/monkeyhut2.xml"
    RegisterInventoryItemAtlas("images/inventoryimages/monkeyhut2.xml", "monkeyhut2.tex")
    AddRecipe2("monkeyhut2", {Ingredient("boards", 4), Ingredient("cutstone", 3), Ingredient("palmcone_scale", 6)}, TECH.NONE, {builder_tag="monkeypirate", placer="monkeyhut2_placer"}, {"CHARACTER", "STRUCTURES"})
end

STRINGS.CHARACTER_TITLES.wonkey2 = "The Monkey Buccaneer"
STRINGS.CHARACTER_NAMES.wonkey2 = "Wonkey"
STRINGS.CHARACTER_DESCRIPTIONS.wonkey2 = "*Is a monkey\n*Is also a pirate!\n*Loves his trinkets"
STRINGS.CHARACTER_QUOTES.wonkey2 = "\"Ook OOK!\""
STRINGS.CHARACTER_SURVIVABILITY.wonkey2 = "Grim"
STRINGS.CHARACTER_ABOUTME.wonkey2 = "The Moon Quay Island is too small for this simian adventurer!"
STRINGS.CHARACTER_BIOS.wonkey2 = {
            { title = "Birthday", desc = "December 14" },
            { title = "Favorite Food", desc = "Banana Shake" },
			{ title = "His Past...", desc = "Is yet to be revealed." },
}
STRINGS.RECIPE_DESC.CURSED_MONKEY_TOKEN = "Friendship bracelet!"
STRINGS.RECIPE_DESC.CUTLESS = "Fight like a pirate."
STRINGS.RECIPE_DESC.OAR_MONKEY = "A captain's best friend."
STRINGS.RECIPE_DESC.MONKEY_SMALLHAT = "Ahoy, matey!"
STRINGS.RECIPE_DESC.MONKEY_MEDIUMHAT = "Apes together strong"
STRINGS.RECIPE_DESC.BLACKFLAG = "Raise your spirits, adventurer!"
STRINGS.RECIPE_DESC.STASH_MAP = "Go on a treasure hunt."

STRINGS.NAMES.MONKEYHUT2 = "Monkey Hut"
STRINGS.RECIPE_DESC.MONKEYHUT2 = "Perfectly shaped for a monkey."

STRINGS.NAMES.WONKEY2 = "Wonkey"
STRINGS.SKIN_NAMES.wonkey2_none = "Wonkey"

STRINGS.NAMES.MONKEYISLAND_MAP = "Island Map"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MONKEYISLAND_MAP = "More treasure?!"

STRINGS.NAMES.SUPERPRIMEMATE = "Prime Mate"
STRINGS.SUPERMONKEY_TALK_HELP_CHOP_WOOD = { "TAKE 'EM DOWN", "BRING IT DOWN!", "CHOP IT UP!", "", "" }
STRINGS.SUPERMONKEY_TALK_HELP_MINE_ROCK = { "BRRREAK IT!", "SMASH!", "PILLAGE!" }
STRINGS.SUPERMONKEY_TALK_DIVEATTACK = { "CANNONBALL!", "DIVEBOMB!", "BOMBS AWAY!", "INTO THE BLUE!" }

local skin_modes = {
    { 
        type = "ghost_skin",
        anim_bank = "ghost",
        idle_anim = "idle",
        scale = 0.75,
        offset = { 0, -25 }
    },
}

if GLOBAL.CONFIG.wonkey_enable_speech then
    STRINGS.CHARACTERS.WONKEY2 = require "speech_wonkey2"
else
    STRINGS.CHARACTERS.WONKEY2 = require ("speech_" .. GLOBAL.CONFIG.wonkey_line_replace)
end


--Component for breaking trinket---------------------------------------------------------
AddAction("USETOKEN", "Break", function(act)
    if act.invobject then
        act.invobject.components.magictoken:Break(act.doer)
        return true
    end

    return false
end)

AddComponentAction("INVENTORY", "magictoken", function(inst, doer, actions, right)
    if doer.prefab == "wonkey2" and doer.replica.inventory:GetActiveItem() == nil and (doer.replica.rider ~= nil or not doer.replica.rider:IsRiding()) then
        table.insert(actions, GLOBAL.ACTIONS.USETOKEN)
    end
end)

local break_state = GLOBAL.State{
    name = "break_token",
    tags = { "doing", "busy", "canrotate" },

    onenter = function(inst)
        inst.AnimState:PlayAnimation("useitem_pre")
        inst.AnimState:PushAnimation("pocketwatch_portal", false)
        inst.AnimState:PushAnimation("useitem_pst", false)
        inst.components.locomotor:Stop()
    end,
    timeline =
    {
        GLOBAL.TimeEvent(18 * GLOBAL.FRAMES, function(inst)
            inst:PerformBufferedAction()
            inst.SoundEmitter:PlaySound("turnoftides/common/together/moon_glass/mine")
            inst.components.talker:Say("Ooooo-ki!")
        end),
        GLOBAL.TimeEvent(37 * GLOBAL.FRAMES, function(inst)
            inst.sg:RemoveStateTag("busy")
        end),
    },

    events =
    {
        GLOBAL.EventHandler("animqueueover", function(inst)
            if inst.AnimState:AnimDone() then
                inst.sg:GoToState("idle")
            end
        end),
    },
}

local break_state_client = GLOBAL.State{
    name = "break_token",
    server_states = {"break_token"},
    farward_server_states = true,
    onenter = function(inst) inst.sg.GoToState("useitem_busy") end
}

AddStategraphState("wilson", break_state)
AddStategraphState("wilson_client", break_state_client)

AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.USETOKEN, "break_token"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.USETOKEN, "break_token"))


--Component for calling/dismissing polly-------------------------------------------------
AddAction("TOGGLEPOLLY", "Whistle", function(act)
    if act.invobject then
        act.invobject.components.pollycaller:TogglePolly(fn)
        return true
    end

    return false
end)

AddComponentAction("INVENTORY", "pollycaller", function(inst, doer, actions, right)
    if inst.replica.equippable:IsEquipped() then
        if doer.replica.inventory:GetActiveItem() == nil and (doer.replica.rider ~= nil or not doer.replica.rider:IsRiding()) then
            table.insert(actions, GLOBAL.ACTIONS.TOGGLEPOLLY)
        end
    end
end)

AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.TOGGLEPOLLY, "play_whistle"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.TOGGLEPOLLY, "play_whistle"))


--Monkey run-----------------------------------------------------------------------------
TUNING.WONKEY_TIME_TO_RUN = GLOBAL.CONFIG.wonkey_run_start

function Wonkey2SGPostInit(inst)
	local UpvalueHacker = require("tools/upvaluehacker")
	local ConfigureRunState
	do
    local _run_start_onenter = inst.states["run_start"].onenter
    ConfigureRunState = UpvalueHacker.GetUpvalue(_run_start_onenter, "ConfigureRunState")
    UpvalueHacker.SetUpvalue(_run_start_onenter, function(...) ConfigureRunState(...) end, "ConfigureRunState")

    local _ConfigureRunState = ConfigureRunState
    ConfigureRunState = function(inst, ...)
    _ConfigureRunState(inst, ...)
		if inst:HasTag("monkey") and not (inst.components.rider:IsRiding() or inst.components.inventory:IsHeavyLifting() or inst:HasTag("groggy") or inst:IsCarefulWalking()) then
			inst.sg.statemem.normalwonkey = inst:HasTag("monkey") or nil
		end
    end
	end

end
AddStategraphPostInit("wilson", Wonkey2SGPostInit)

function Wonkey2ClientSGPostInit(inst)
	local UpvalueHacker = require("tools/upvaluehacker")
	local ConfigureRunState
	do
    local _run_start_onenter = inst.states["run_start"].onenter
    ConfigureRunState = UpvalueHacker.GetUpvalue(_run_start_onenter, "ConfigureRunState")
    UpvalueHacker.SetUpvalue(_run_start_onenter, function(...) ConfigureRunState(...) end, "ConfigureRunState")
    local _ConfigureRunState = ConfigureRunState
    ConfigureRunState = function(inst, ...)
    _ConfigureRunState(inst, ...)
		if inst:HasTag("monkey") and inst.replica.rider ~= nil and not (inst.replica.rider:IsRiding() or inst.replica.inventory:IsHeavyLifting() or inst:HasTag("groggy") or inst:IsCarefulWalking()) then
			inst.sg.statemem.normalwonkey = inst:HasTag("monkey") or nil
		end
    end
	end
end
AddStategraphPostInit("wilson_client", Wonkey2ClientSGPostInit)


--Monkey speech--------------------------------------------------------------------------
local Mkt_endings = { "", "e", "h", "k", "ki" }
local Mkt_punc = { ".", "?", "!" }

local function NumInRange(num, min, max)
    return (num <= max) and (num > min)
end

local function mktstart(isstart)
    local str = isstart and "O" or "O"
    local l = math.random(2, 4)
    for i = 2, l do
        str = str..(math.random() > 0.3 and "o" or "a")
    end
    return str
end

local function mktspace()
    local c = math.random()
    local str =
    (NumInRange(c, 0.4, 1.5) and " ") or
    (NumInRange(c, 0.3, 0.4) and ", ") or
    (NumInRange(c, 0.2, 0.3) and "? ") or
    (NumInRange(c, 0.1, 0.2) and ". ") or
    (NumInRange(c, 0, 0.1) and "! ") or
    "! "
    return str, c <= .3
end

local function mktend()
    return Mkt_endings[math.random(#Mkt_endings)]
end

local function mktpunc()
    return Mkt_punc[math.random(#Mkt_punc)]
end

local function CraftMonkeyTalk()
    local isstart = true
    local length = math.random(6)
    local str = ""
    for i = 1, length do
        str = str..mktstart(isstart)..mktend()
        if i ~= length then
            str = str..mktspace()
        end
    end
    return str..mktpunc()
end

local _GetSpecialCharacterString = GLOBAL.GetSpecialCharacterString
if GLOBAL.CONFIG.wonkey_enable_speech then
    GLOBAL.GetSpecialCharacterString = function(character)
        character = character and string.lower(character)
        return (character == "wonkey2" and CraftMonkeyTalk()) or _GetSpecialCharacterString(character)
    end
end


--Understanding monkey language----------------------------------------------------------
local function KnowsMonkeyLanguagePostInit(inst)

    local function speech_override_fn(inst, speech)
        if not GLOBAL.ThePlayer or GLOBAL.ThePlayer:HasTag("monkey") then
            return speech
        else
            return GLOBAL.CraftMonkeySpeech()
        end
    end
    inst.speech_override_fn = speech_override_fn
end
AddPrefabPostInit("monkeyqueen", KnowsMonkeyLanguagePostInit)
AddPrefabPostInit("prime_mate", KnowsMonkeyLanguagePostInit)


--Pirate banner aura---------------------------------------------------------------------
AddPrefabPostInit("pirate_flag_pole", function(inst)
    if not inst:HasTag("burnt") then
        if not inst.components.sanityaura then
            if GLOBAL.CONFIG.banner_sanity == "All Characters" then
                inst:AddComponent("sanityaura")
                inst.components.sanityaura.aura = TUNING.SANITYAURA_TINY
            end
        end
    end
    inst:AddTag("piratebanner")
end)


--Pirate loot has monkey island map------------------------------------------------------
AddPrefabPostInit("pirate_stash", function(inst)
    local TheWorld = GLOBAL.TheWorld
    local SpawnPrefab = GLOBAL.SpawnPrefab

    if not TheWorld.ismastersim then
        return inst
    end

    inst:ListenForEvent("onremove", function()
        if TheWorld.components.piratespawner then
            TheWorld.components.piratespawner:ClearCurrentStash()
        end
        if GLOBAL.CONFIG.islandmap_toggle then
            inst:DoTaskInTime(1, SpawnPrefab("monkeyisland_map").Transform:SetPosition(inst.Transform:GetWorldPosition()))
        end
    end)
end)


--Custom loot from monkey huts-----------------------------------------------------------
AddPrefabPostInit("monkeyhut", function(inst)
    local loot =
    {
        "boards",
        "boards",
        "cutstone",
        "cutstone",
        "palmcone_scale",
        "palmcone_scale",
    }
    if inst.components.lootdropper  then
       inst.components.lootdropper:SetLoot(loot)
    end
end)


--Slower usage from pirate hats (small and polly)----------------------------------------
local function piratehatPostInit(inst)
    if inst.components.fueled then
        local _DoDelta = inst.components.fueled.DoDelta
        inst.components.fueled.DoDelta = function(self, amount)
            local owner = inst.components.inventoryitem.owner
            if owner and owner.prefab == "wonkey2" then
                inst.components.fueled.rate_modifiers:SetModifier(owner, 0.75)
            end
            _DoDelta(self, amount)
        end
    end
end
if GLOBAL.CONFIG.bandana_rate then
    AddPrefabPostInit("monkey_smallhat", piratehatPostInit)
end
if GLOBAL.CONFIG.pollys_rate then
    AddPrefabPostInit("polly_rogershat", piratehatPostInit)
end


--Pirate hat buffs-----------------------------------------------------------------------
AddPrefabPostInit("monkey_smallhat", function(inst)
    inst:AddTag("monkeybandana")
end)
AddPrefabPostInit("monkey_mediumhat", function(inst)
    inst:AddTag("captainhat")
end)

AddPrefabPostInit("polly_rogershat", function(inst)
    inst:AddTag("pollyshat")
    if not GLOBAL.TheWorld.ismastersim then
        return inst
    end
    if GLOBAL.CONFIG.pollys_speed then
        if inst.components.equippable then
            inst.components.equippable.walkspeedmult = TUNING.CANE_SPEED_MULT
        end
    end
end)


--Immortal Polly-------------------------------------------------------------------------
AddPrefabPostInit("polly_rogers", function(inst)
    if GLOBAL.CONFIG.polly_immortal then
        if inst.components.health then
            inst.components.health.invincible = true
        end
    end
end)


--Call and dismiss Polly-----------------------------------------------------------------
AddPrefabPostInit("polly_rogershat", function(inst)
    inst.whistle_build = "wolfgang_whistle"
    inst.whistle_symbol = "wolfgang_whistle01"
    inst.whistle_sound = "dontstarve/common/together/houndwhistle"

    if GLOBAL.CONFIG.polly_dismiss then
        inst:AddComponent("pollycaller")
    end
end)


--Pirate weapon buffs--------------------------------------------------------------------
AddPrefabPostInit("cutless", function(inst)
    local function onequip(inst, owner)
        local skin_build = inst:GetSkinBuild()
        if skin_build ~= nil then
            owner:PushEvent("equipskinneditem", inst:GetSkinName())
            owner.AnimState:OverrideItemSkinSymbol("swap_object", skin_build, "cutless", inst.GUID, "swap_cutless")
        else
            owner.AnimState:OverrideSymbol("swap_object", "cutless", "swap_cutless")
        end
        owner.AnimState:Show("ARM_carry")
        owner.AnimState:Hide("ARM_normal")
        if owner and owner:HasTag("monkey") then
            if GLOBAL.CONFIG.cutless_dmg then
                inst.components.weapon:SetDamage(TUNING.CUTLESS_DAMAGE * 1.3)
            end
        end
    end

    local function onunequip(inst, owner)
        owner.AnimState:Hide("ARM_carry")
        owner.AnimState:Show("ARM_normal")
        local skin_build = inst:GetSkinBuild()
        if skin_build ~= nil then
            owner:PushEvent("unequipskinneditem", inst:GetSkinName())
        end
        inst.components.weapon:SetDamage(TUNING.CUTLESS_DAMAGE)
    end
    if not GLOBAL.TheWorld.ismastersim then
        return inst
    end
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
end)

AddPrefabPostInit("oar_monkey", function(inst)
    local function onequip(inst, owner, swap_build, swap_symbol)
        local skin_build = inst:GetSkinBuild()
        local swap_build = "swap_oar_monkey"
        local swap_symbol = "swap_oar_monkey"
        if skin_build ~= nil then
            owner:PushEvent("equipskinneditem", inst:GetSkinName())
            owner.AnimState:OverrideItemSkinSymbol("swap_object", skin_build, swap_build, inst.GUID, swap_symbol or swap_build)
        else
            owner.AnimState:OverrideSymbol("swap_object", swap_build, swap_symbol or swap_build)
        end

        owner.AnimState:Show("ARM_carry")
        owner.AnimState:Hide("ARM_normal")
        if owner and owner:HasTag("monkeypirate") then
            if GLOBAL.CONFIG.oarmonkey_dmg then
                inst.components.weapon:SetDamage(51 * 1.3)
            end
            inst.components.weapon:SetDamage(51 * 1.3)
        end
    end

    local function onunequip(inst, owner)
        owner.AnimState:Hide("ARM_carry")
        owner.AnimState:Show("ARM_normal")
        inst.components.weapon:SetDamage(51)
    end
    if not GLOBAL.TheWorld.ismastersim then
        return inst
    end
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
end)


--Make powdermonkeys accept weapons------------------------------------------------------
AddComponentAction("USEITEM", "equippable", function(inst, doer, target, actions)
    if target:HasTag("trader") and target:HasTag("powdermonkey") and
        not (target:HasTag("player") or target:HasTag("ghost")) and
        not (doer.replica.rider ~= nil and doer.replica.rider:IsRiding() and
        not (target.replica.inventoryitem ~= nil and target.replica.inventoryitem:IsGrandOwner(doer))) then
            table.insert(actions, GLOBAL.ACTIONS.GIVE)
    end
end)


--Make wonkey/anyone not cursable--------------------------------------------------------
AddComponentPostInit("cursable", function(self)
    local Cursable = require("components/cursable")
    local curse_monkey = require("curse_monkey_util")

    function Cursable:ApplyCurse(item,curse)

        if GLOBAL.CONFIG.wonkeycurse_on == false then
            if self.inst:HasTag("player") then
                return nil
            end
        end

        local num = 1
        if item then
            curse = item.components.curseditem.curse
            item.components.curseditem.cursed_target = self.inst
            if item.components.stackable then
                num = item.components.stackable:StackSize()
            end
        end

        if self.inst:HasTag("monkey") then
            return nil
        end

        self.curses[curse] = (self.curses[curse] or 0) + num
        if curse == "MONKEY" then
            curse_monkey.docurse(self.inst, self.curses[curse])
        end

        item:AddTag("applied_curse")
    end
end)

AddComponentPostInit("curseditem", function(self)
    local Curseditem = require("components/curseditem")

    function Curseditem:lookforplayer()

        if self.inst.findplayertask then
            self.inst.findplayertask:Cancel()
            self.inst.findplayertask = nil
        end

        self.inst.findplayertask = self.inst:DoPeriodicTask(1,function()
            local x,y,z = self.inst.Transform:GetWorldPosition()
            local player = GLOBAL.FindClosestPlayerInRangeSq(x,y,z,10*10,true)

            if player and not self:checkplayersinventoryforspace(player)  then
                player = nil
            end

            if GLOBAL.CONFIG.wonkeycurse_on == false then
                --don't move
            elseif player and player.components.cursable and player.components.cursable:IsCursable(self.inst) and not player.components.debuffable:HasDebuff("spawnprotectionbuff") then
                if self.inst.findplayertask then
                    self.inst.findplayertask:Cancel()
                    self.inst.findplayertask = nil
                end

                self.target = player
                self.starttime = GLOBAL.GetTime()
                self.startpos = GLOBAL.Vector3(self.inst.Transform:GetWorldPosition())
            end
        end)
    end
end)


--Remove followerfn on regular wonkey----------------------------------------------------
AddPrefabPostInit("wonkey", function(inst)
    local function oneatfn(inst, food)
        if food ~= nil and food.prefab == "cave_banana_cooked" then
            if inst.components.leader and not inst.components.health:IsDead() then
                for follower, _ in pairs(inst.components.leader.followers) do
                    if follower:HasTag("monkey") then
                        follower.components.follower:StopFollowing()
                    end
                end
            end
        end
    end

    if inst.components.eater then
        inst.components.eater:SetOnEatFn(oneatfn)
    end
end)


--Recruit Splumonkeys/Remove nightmare---------------------------------------------------
--[[ AddPrefabPostInit("monkey", function (inst)
    local followerbrain = require "brains/followermonkeybrain"

    local function OnTimerDone2(inst, data)
        if data.name == "facetime" then
            inst.components.timer:StartTimer("dontfacetime", 10)
        end
    end

    local function IsAbleToAccept(inst, item, giver)
        if inst.components.health ~= nil and inst.components.health:IsDead() then
            return false, "DEAD"
        elseif inst.sg ~= nil and inst.sg:HasStateTag("busy") then
            if inst.sg:HasStateTag("sleeping") then
                return true
            end
            return false, "BUSY"
        end
        return true
    end

    local function ShouldAcceptItem(inst, item, giver)
        if inst.components.sleeper and inst.components.sleeper:IsAsleep() then
            inst.components.sleeper:WakeUp()
        end

        return (giver:HasTag("monkey") and item.prefab == "cave_banana" or item.prefab == "cave_banana_cooked" or
            (giver:HasTag("monkey") and inst.components.follower.leader and item.components.equippable ~= nil and (item.components.equippable.equipslot == EQUIPSLOTS.HEAD)))
    end

    local function OnGetItemFromPlayer(inst, giver, item)
        if item.prefab == "cave_banana" or item.prefab == "cave_banana_cooked" then
            giver:PushEvent("makefriend")
            giver.components.leader:AddFollower(inst)
            inst.components.follower:SetLeader(giver)
            if GLOBAL.CONFIG.splumonkey_time == 31 then
                --follow forever
            else
                inst.components.follower:AddLoyaltyTime(GLOBAL.CONFIG.splumonkey_time*60)
            end
            inst.hasLeader = true
            if inst and inst:HasTag("hostile") then
                inst:RemoveTag("hostile")
            end
            inst.components.health:SetMaxHealth(GLOBAL.CONFIG.splumonkey_hp)
            inst.components.combat:SetDefaultDamage(GLOBAL.CONFIG.splumonkey_dmg)
            inst:SetBrain(followerbrain)
        end
    end

    local function StartedFollowing(inst)
        inst:SetBrain(followerbrain)
    end

    local function StoppedFollowing(inst)
        local brain = require("brains/monkeybrain")
        inst:SetBrain(brain)
    end

    if not GLOBAL.TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("follower")
    inst.components.follower.keepleaderduringminigame = true
    inst.components.follower.maxfollowtime = 1800

    inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(ShouldAcceptItem)
    inst.components.trader:SetAbleToAcceptTest(IsAbleToAccept)
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader.deleteitemonaccept = false

    inst:ListenForEvent("stopfollowing", StartedFollowing)
    inst:ListenForEvent("startfollowing", StoppedFollowing)
    inst:ListenForEvent("timerdone", OnTimerDone2)
end) ]]

--Superprimemate conversion--------------------------------------------------------------
AddAction("POWERUPMONKEY", "Power Up", function(act)
    if act.invobject then
        act.target.components.inventory:DropEverything()
        act.target:Remove()
        local fx = GLOBAL.SpawnPrefab("monkey_morphin_power_players_fx")
        fx.Transform:SetScale(1.5,1.5,1.5)
        fx.Transform:SetPosition(act.target.Transform:GetWorldPosition())
        local fx2 = GLOBAL.SpawnPrefab("explode_reskin")
        fx2.Transform:SetScale(2,2,2)
        fx2.Transform:SetPosition(act.target.Transform:GetWorldPosition())

        local monkeyupgrade = GLOBAL.SpawnPrefab("superprimemate")
        monkeyupgrade.Transform:SetPosition(act.target.Transform:GetWorldPosition())

        if GLOBAL.CONFIG.follower_names then
            monkeyupgrade.components.named:SetName(act.target.name)
        end
        monkeyupgrade.components.follower:SetLeader(act.doer)
        act.doer.components.leader:AddFollower(monkeyupgrade)

        monkeyupgrade:DoTaskInTime(1, function(monkeyupgrade)
            local oar = GLOBAL.SpawnPrefab("oar_monkey")
            monkeyupgrade.components.inventory:GiveItem(oar)
            monkeyupgrade.components.inventory:Equip(oar)
        end)

        local hat = GLOBAL.SpawnPrefab("monkey_mediumhat")
        monkeyupgrade.components.inventory:GiveItem(hat)
        monkeyupgrade.components.inventory:Equip(hat)

        if act.target.prefab == "powder_monkey" then
            monkeyupgrade:DoTaskInTime(0, function(inst)
                inst:PushEvent("cheer")
                inst.components.talker:Say("YARRRR!")
            end)
            if GLOBAL.CONFIG.supermonkey_time == 31 then
                --upgrade forever
            else
                monkeyupgrade.components.timer:StartTimer("supermonkey", GLOBAL.CONFIG.supermonkey_time*60)
            end
        end

        act.invobject.components.stackable:Get():Remove()
        return true
    end

    return false
end)

AddComponentAction("USEITEM", "curseditem", function(inst, doer, target, actions)
    if target:HasTag("pirate") and
        not (target:HasTag("player") or target:HasTag("ghost")) and
        not (doer.replica.rider ~= nil and doer.replica.rider:IsRiding() and
        not (target.replica.inventoryitem ~= nil and target.replica.inventoryitem:IsGrandOwner(doer))) then
            table.insert(actions, GLOBAL.ACTIONS.POWERUPMONKEY)
    end
end)

AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.POWERUPMONKEY, "give"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.POWERUPMONKEY, "give"))

AddPrefabPostInit("prime_mate", function (inst)
    if GLOBAL.CONFIG.follower_names then
        inst:AddComponent("named")
        inst.components.named.possiblenames = STRINGS.SWAMPIGNAMES
        inst.components.named:PickNewName()
    end
end)


AddModCharacter("wonkey2", "NEUTRAL", skin_modes)
