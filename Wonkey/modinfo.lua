name = "Wonkey, the Monkey Buccaneer"
description = "Adds Wonkey as a full-fledged character, with his own unique perks and crafts!"
author = "Lugon"
version = "1.2.5"

api_version = 10

dst_compatible = true

dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false

all_clients_require_mod = true

icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = {
"character","item",
}

local function AddConfig(label, name, options, default, hover)
    return {label = label, name = name, options = options, default = default, hover = hover}
end

local function InsertOption(options, new_option, default)
    if new_option.data == default then new_option.hover = "Default" end
    options[#options + 1] = new_option
end

local function GenerateNumericOptions(start, total, step, default, config)
    local config = config or {}
    local prefix = config.prefix or ""
    local suffix = config.suffix or ""

    local options = {}

    if config.first then InsertOption(options, config.first, default) end

    for i = start, total, step do
        local value = i
        options[#options + 1] = {data = value, description = prefix .. value .. suffix, hover = value == default and "Default" or nil}
    end

    if config.last then InsertOption(options, config.last, default) end

    return options
end

local booleantrue = {{description = "Enabled", data = true, hover = "Default"}, {description = "Disabled", data = false}}
local booleanfalse = {{description = "Enabled", data = true}, {description = "Disabled", data = false, hover = "Default"}}

local basecast = {
    {description = "Wilson", data = "wilson", hover = "Default"},
    {description = "Willow", data = "willow"},
    {description = "Wolfgang", data = "wolfgang"},
    {description = "Wendy", data = "wendy"},
    {description = "WX-78", data = "wx78"},
    {description = "Wickerbottom", data = "wickerbottom"},
    {description = "Woodie", data = "woodie"},
    {description = "Maxwell", data = "waxwell"},
    {description = "Wigfrid", data = "wathgrithr"},
    {description = "Webber", data = "webber"},
    {description = "Winona", data = "winona"},
    {description = "Warly", data = "warly"},
    {description = "Wortox", data = "wortox"},
    {description = "Wormwood", data = "wormwood"},
    {description = "Wurt", data = "wurt"},
    {description = "Walter", data = "walter"},
    {description = "Wanda", data = "wanda"},
}

local banner_sanity = {
    {description = "None", data = "None"},
    {description = "Wonkey", data = "Wonkey"},
    {description = "All Characters", data = "All Characters", hover = "Default"},
}

local wonkey_hunger = GenerateNumericOptions(75, 250, 5, 175)
local wonkey_sanity = GenerateNumericOptions(75, 250, 5, 100)
local wonkey_health = GenerateNumericOptions(75, 250, 5, 125)
local wonkey_run_start = GenerateNumericOptions(1, 10, 1, 3, {first = {data = 0, description = "Instant"}, suffix = " sec"})
local trinket_health = GenerateNumericOptions(0, 50, 5, 30)
local trinket_sanity = GenerateNumericOptions(0, 50, 5, 20)
local buff_duration = GenerateNumericOptions(0, 60, 5, 30, {first = {data = 0, description = "None"}, suffix = " sec"})
local powdermonkey_hp = GenerateNumericOptions(200, 1000, 50, 350)
local powdermonkey_dmg = GenerateNumericOptions(20, 100, 5, 30)
local powdermonkey_time = GenerateNumericOptions(1, 30, 1, 31, {last = {data = 31, description = "Permanent"}, suffix = " min"})
local supermonkey_hp = GenerateNumericOptions(350, 1000, 50, 500)
local supermonkey_dmg = GenerateNumericOptions(0, 200, 10, 60, {suffix = "%"})
local supermonkey_time = GenerateNumericOptions(1, 30, 1, 16, {last = {data = 31, description = "Permanent"}, suffix = " min"})
local diveatk_cooldown = GenerateNumericOptions(0, 20, 1, 10)
--local splumonkey_hp = GenerateNumericOptions(100, 1000, 50, 200)
--local splumonkey_dmg = GenerateNumericOptions(10, 100, 5, 20)
--local splumonkey_time = GenerateNumericOptions(1, 30, 1, 5, {last = {data = 31, description = "Permanent"}, suffix = " min"})

configuration_options = {
	{
        name = "separator_wonkey_stats",
        label = "Wonkey Stats",
        options = {{description = "", data = 1}},
        default = 1
    },
    AddConfig("Hunger", "wonkey_hunger", wonkey_hunger, 175, "Select Wonkey's base stats."),
    AddConfig("Sanity", "wonkey_sanity", wonkey_sanity, 100, "Select Wonkey's base stats."),
    AddConfig("Health", "wonkey_health", wonkey_health, 125, "Select Wonkey's base stats."),
    AddConfig("Run start-up", "wonkey_run_start", wonkey_run_start, 3, "Select how long it takes for Wonkey to start running."),
    AddConfig("Accursed Trinket sanity penalty", "wonkey_notrinkets", booleantrue, true, "Select if Wonkey should lose max sanity while having under 10 Trinkets.\nIf disabled, Wonkey will start the game without any Trinkets."),
    AddConfig("Keep trinkets on death", "wonkey_keep_trinkets", booleanfalse, false, "Wonkey will keep his trinkets after dying."),
    AddConfig("Health gain from trinkets", "trinket_health", trinket_health, 30, "Select how much health Wonkey will gain from breaking his trinkets."),
    AddConfig("Sanity gain from trinkets", "trinket_sanity", trinket_sanity, 20, "Select how much sanity Wonkey will gain from breaking his trinkets."),
    AddConfig("Trinket buff duration", "buff_duration", buff_duration, 30, "Select how long the health regeneration buff lasts."),
    AddConfig("Use monkey speech", "wonkey_enable_speech", booleantrue, true, "Select whether Wonkey should use monkey speech.\n(Overrides character selection below)"),
    AddConfig("Choose character lines", "wonkey_line_replace", basecast, "wilson", "Select which character's voice lines to use for Wonkey."),
	{
        name = "separator_items",
        label = "Items",
        options = {{description = "", data = 1}},
        default = 1
    },
	AddConfig("Bandana extra durability", "bandana_rate", booleantrue, true, "Adds extra durability to the Pirate Bandana while Wonkey is wearing it."),
	AddConfig("Bandana sanity gain", "bandana_sanity", booleantrue, true, "Adds a small sanity gain to the Pirate Bandana while Wonkey is wearing it."),
	AddConfig("Tricorn damage buff", "tricorn_dmg", booleantrue, true, "Adds a damage multipler to Wonkey while he's wearing it."),
	AddConfig("Tricorn follower buff", "tricorn_monkeydmg", booleantrue, true, "Adds damage and reduces damage taken to Wonkey's Powder Monkey followers while he's wearing it."),
	AddConfig("Polly Roger's extra durability", "pollys_rate", booleantrue, true, "Adds extra durability to Polly Roger's Hat while Wonkey is wearing it."),
	AddConfig("Polly Roger's both hat buffs", "pollys_masterhat", booleantrue, true, "Adds the buffs from both the Tricorn and the Bandana to Polly Roger's Hat while Wonkey is wearing it."),
	AddConfig("Polly Roger's speed buff", "pollys_speed", booleantrue, true, "Adds a speed multipler to anyone wearing Polly Roger's Hat."),
	AddConfig("Unkillable Polly", "polly_immortal", booleanfalse, false, "Makes Polly immortal."),
	AddConfig("Dismissable Polly", "polly_dismiss", booleantrue, true, "Gives you the option to whistle, calling or dismissing Polly while wearing her hat."),
	AddConfig("Cutless damage bonus", "cutless_dmg", booleantrue, true, "Adds a damage multiplier when it's used by Wonkey."),
	AddConfig("Battle Paddle damage bonus", "oarmonkey_dmg", booleantrue, true, "Adds a damage multiplier when it's used by Wonkey."),
	AddConfig("Pirate Banner sanity aura", "banner_sanity", banner_sanity, "All Characters", "Select which characters should gain the sanity boost from the Pirate Banner.\n(If enabled for all characters Wonkey gets extra)"),
    {
        name = "separator_followers",
        label = "Followers",
        options = {{description = "", data = 1}},
        default = 1
    },
    AddConfig("Enable follower names", "follower_names", booleantrue, true, "Followers will have randomly selected names."),
	AddConfig("Powder Monkey health", "powdermonkey_hp", powdermonkey_hp, 350, "Select stats for follower Powder Monkeys."),
	AddConfig("Powder Monkey base damage", "powdermonkey_dmg", powdermonkey_dmg, 30, "Select stats for follower Powder Monkeys."),
	AddConfig("Powder Monkey loyalty", "powdermonkey_time", powdermonkey_time, 31, "Select stats for follower Powder Monkeys."),
	AddConfig("Prime Mate health", "supermonkey_hp", supermonkey_hp, 500, "Select stats for follower Prime Mates."),
    AddConfig("Prime Mate damage bonus", "supermonkey_dmg", supermonkey_dmg, 60, "Select stats for follower Prime Mates."),
    AddConfig("Prime Mate upgrade duration", "supermonkey_time", supermonkey_time, 16, "Select stats for follower Prime Mates."),
	AddConfig("Enable special attack", "diveatk_toggle", booleantrue, true, "Enables special attack for follower Prime Mates."),
	AddConfig("Special attack cooldown", "diveatk_cooldown", diveatk_cooldown, 10, "Select the cooldown duration for the Prime Mate's special attack."),
	--AddConfig("Recruit Splumonkeys", "splumonkey_recruit", booleanfalse, false, "Enables recruiting Splumonkeys as followers."),
	--AddConfig("Splumonkey health", "splumonkey_hp", splumonkey_hp, 200, "Select stats for follower Splumonkeys."),
	--AddConfig("Splumonkey damage", "splumonkey_dmg", splumonkey_dmg, 20, "Select stats for follower Splumonkeys."),
	--AddConfig("Splumonkey loyalty", "splumonkey_time", splumonkey_time, 5, "Select stats for follower Splumonkeys."),
    {
        name = "separator_regular_wonkey",
        label = "Global changes",
        options = {{description = "", data = 1}},
        default = 1
    },
	AddConfig("Enable regular Wonkey", "wonkeycurse_on", booleantrue, true, "If disabled, the Accursed Trinket will no longer inflict the Wonkey curse."),
	AddConfig("Give new crafts to regular Wonkey", "wonkeycurse_crafts", booleantrue, true, "Allows regular curse Wonkey to craft pirate items."),
	AddConfig("Moon Quay map in pirate stash", "islandmap_toggle", booleantrue, true, "Enables Moon Quay map as added loot to the Pirate Stash."),
}
