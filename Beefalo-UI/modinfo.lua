name = "Beefalo Status Bar - DHPModified"
version = "1.0.0"
author = "PhucDH410"
description = [[
Original mod: https://steamcommunity.com/sharedfiles/filedetails/?id=2477889104
From update version: 27 Feb 2025 
A status bar for your beefalo mount.

Shows health, domestication and tendency, obedience, ride timer, saddle uses and hunger when riding a beefalo.

Server configuration is used by default and will apply to all clients.
Clients can override this from the client configuration screen.

Server Configuration: Host Game -> World -> Mods
Client Configuration: Main Menu -> Mods -> Server Mods
]]
forumthread = ""
server_filter_tags = {"Beefalo Status Bar", "Beefalo UI"}

dont_starve_compatible = false
reign_of_giants_compatible = true
dst_compatible = true

api_version = 10

all_clients_require_mod = true
client_only_mod = false

icon_atlas = "icon.xml"
icon = "icon.tex"

local KEYS = {
    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
    "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12",
    "Minus", "Equals", "Backspace", "Leftbracket", "Rightbracket", "Backslash", "Semicolon", "Enter", "Period", "Slash",
    "Left", "Right", "Up", "Down", "Insert", "Delete", "Home", "End", "Pageup", "Pagedown", "Print", "Scrollock", "Pause",
    "Escape", "Tilde", "Tab", "Capslock", "Shift", "LShift", "RShift", "Ctrl", "LCtrl", "RCtrl", "Alt", "LAlt", "RAlt", "Space",
    "KP_1", "KP_2", "KP_3", "KP_4", "KP_5", "KP_6", "KP_7", "KP_8", "KP_9", "KP_0",
    "KP_Divide", "KP_Multiply", "KP_Minus", "KP_Plus", "KP_Enter", "KP_Period", "KP_Equals",
}

local COLORS = {
    {name = "ORANGE", description = "Orange"},
    {name = "ORANGE_ALT", description = "Orange Alt"},
    {name = "BLUE", description = "Blue"},
    {name = "BLUE_ALT", description = "Blue Alt"},
    {name = "PURPLE", description = "Purple"},
    {name = "PURPLE_ALT", description = "Purple Alt"},
    {name = "RED", description = "Red"},
    {name = "RED_ALT", description = "Red Alt"},
    {name = "GREEN", description = "Green"},
    {name = "GREEN_ALT", description = "Green Alt"},
    {name = "BEIGE", description = "Beige"},
    {name = "WHITE", description = "White"},
    {name = "YELLOW", description = "Yellow"}
}

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
        local value = (not config.divide and not config.multiply) and i or (config.divide and i / config.divide or i * config.multiply)
        options[#options + 1] = {data = value, description = prefix .. value .. suffix, hover = value == default and "Default" or nil}
    end

    if config.last then InsertOption(options, config.last, default) end

    return options
end

local function GenerateColorOptions(default)
    local colorOptions = {}
    for i = 1, #COLORS do
        colorOptions[i] = {data = COLORS[i].name, description = COLORS[i].description}
        if default == COLORS[i].name then colorOptions[i].hover = "Default" end
    end
    return colorOptions
end

local function GenerateKeyboardOptions(default)
    local options = {{description = "Disabled", data = false, hover = "Toggling will be disabled."}}
    
    for i = 1, #KEYS do
        local key = "KEY_" .. KEYS[i]:upper()
        options[i + 1] = {description = KEYS[i], data = key, hover = key == default and "Default" or nil}
    end

    return options
end

local offsets = GenerateNumericOptions(-200, 200, 5, 0)
local fineOffsets = GenerateNumericOptions(-50, 50, 1, 0)
local offsetMultipliers = GenerateNumericOptions(2, 20, 1, 1, {first = {data = 1, description = "None"}, suffix = "x"})

configuration_options = {
    {
        name = "SEPARATOR_GENERAL",
        label = "General",
        options = {{description = "", data = 1}},
        default = 1
    },
    {
        name = "ShowByDefault",
        label = "Show Automatically",
        hover = "Show the status bar automatically when you mount a beefalo.",
        options = {
            {description = "Enabled", data = true, hover = "Default"},
            {description = "Disabled", data = false}
        },
        default = true
    },
    {
        name = "ToggleKey",
        label = "Toggle Key",
        hover = "Press this key (when mounted) to toggle the status bar.\nToggling will override \"Show Automatically\" for the current world session.",
        options = GenerateKeyboardOptions("KEY_T"),
        default = "KEY_T"
    },
    {
        name = "EnableSounds",
        label = "Sounds",
        hover = "Play a sound when showing or hiding the status bar.",
        options = {
            {description = "Disabled", data = false, hover = "Default"},
            {description = "Enabled", data = true}
        },
        default = false
    },
    {
        name = "ClientConfig",
        label = "Prefer Client Configuration",
        hover = "When enabled, server configuration will be ignored.\nConfigurations from this screen will be used on every server you join or host.",
        options = {
            {description = "Disabled", data = false, hover = "Default"},
            {description = "Enabled", data = true}
        },
        default = false,
        client = true
    },
    {
        name = "SEPARATOR_BADGE_SETTINGS",
        label = "Badge Settings",
        options = {{description = "", data = 1}},
        default = 1
    },
    {
        name = "Theme",
        label = "Theme",
        hover = "Change the theme of the badges.",
        options = {
            {description = "The Forge", data = "TheForge", hover = "Default"},
            {description = "Default Theme", data = "Default", hover = "Uses the default game theme. Compatible with most HUD reskin mods."}
        },
        default = "TheForge"
    },
    {
        name = "Scale",
        label = "Scale",
        hover = "Controls the scale (size) of the badges.",
        options = GenerateNumericOptions(50, 200, 5, 1, {divide = 100}),
        default = 1
    },
    {
        name = "HungerThreshold",
        label = "Hunger Badge Threshold",
        hover = "A beefalo needs to have at least this amount of hunger to activate the badge.\nThis badge can also be disabled by setting this to \"Never Show\".",
        options = GenerateNumericOptions(5, 375, 5, 15, {first = {data = false, description = "Never Show"}}),
        default = 15
    },
    {
        name = "HEALTH_BADGE_CLEAR_BG",
        label = "Health Badge Background",
        hover = "Distinct: Uses a distinct background. Brightness and opacity will not apply.\nStandard: Uses a standard background. Brightness and opacity will apply.",
        options = {
            {description = "Distinct", data = false, hover = "Default"},
            {description = "Standard", data = true}
        },
        default = false
    },
    {
        name = "BADGE_BG_BRIGHTNESS",
        label = "Background Brightness",
        hover = "Controls the background brightness of the badges.",
        options = GenerateNumericOptions(0, 100, 5, 60, {suffix = "%"}),
        default = 60
    },
    {
        name = "BADGE_BG_OPACITY",
        label = "Background Opacity",
        hover = "Controls the background opacity (transparency) of the badges.\n100% - No transparency, 0% - Fully transparent.",
        options = GenerateNumericOptions(0, 100, 5, 100, {suffix = "%"}),
        default = 100
    },
    {
        name = "GapModifier",
        label = "Gap Modifier",
        hover = "Controls the empty space between the badges.\nNegative values - less space, positive values - more space.",
        options = GenerateNumericOptions(-15, 30, 1, 0),
        default = 0
    },
    {
        name = "SEPARATOR_BADGE_COLORS",
        label = "Badge Colors",
        options = {{description = "", data = 1}},
        default = 1
    },
    {
        name = "COLOR_DOMESTICATION_ORNERY",
        label = "Domestication (Ornery)",
        hover = "Domestication badge color for Ornery beefalo.",
        options = GenerateColorOptions("ORANGE"),
        default = "ORANGE"
    },
    {
        name = "COLOR_DOMESTICATION_RIDER",
        label = "Domestication (Rider)",
        hover = "Domestication badge color for Rider beefalo.",
        options = GenerateColorOptions("BLUE"),
        default = "BLUE"
    },
    {
        name = "COLOR_DOMESTICATION_PUDGY",
        label = "Domestication (Pudgy)",
        hover = "Domestication badge color for Pudgy beefalo.",
        options = GenerateColorOptions("PURPLE"),
        default = "PURPLE"
    },
    {
        name = "COLOR_DOMESTICATION_DEFAULT",
        label = "Domestication (Default)",
        hover = "Domestication badge color for Default beefalo.",
        options = GenerateColorOptions("BEIGE"),
        default = "BEIGE"
    },
    {
        name = "COLOR_OBEDIENCE",
        label = "Obedience",
        hover = "Obedience badge color.",
        options = GenerateColorOptions("RED"),
        default = "RED"
    },
    {
        name = "COLOR_TIMER",
        label = "Ride Timer",
        hover = "Ride Timer badge color.",
        options = GenerateColorOptions("GREEN"),
        default = "GREEN"
    },
    {
        name = "SEPARATOR_POSITIONING_X",
        label = "Positioning X",
        options = {{description = "", data = 1}},
        default = 1
    },
    {
        name = "OffsetX",
        label = "X Offset (Horizontal)",
        hover = "Negative values - move left, positive values - move right.",
        options = offsets,
        default = 0
    },
    {
        name = "OffsetXMult",
        label = "X Offset Multiplier",
        hover = "Multiplier for the \"X Offset\" setting.\nHas no effect on the \"Fine Tune\" setting.",
        options = offsetMultipliers,
        default = 1
    },
    {
        name = "OffsetXFine",
        label = "X Offset Fine Tune",
        hover = "Fine tune X Offset",
        options = fineOffsets,
        default = 0
    },
    {
        name = "SEPARATOR_POSITIONING_Y",
        label = "Positioning Y",
        options = {{description = "", data = 1}},
        default = 1
    },
    {
        name = "OffsetY",
        label = "Y Offset (Vertical)",
        hover = "Negative values - move down, positive values - move up.",
        options = offsets,
        default = 0
    },
    {
        name = "OffsetYMult",
        label = "Y Offset Multiplier",
        hover = "Multiplier for the \"Y Offset\" setting.\nHas no effect on the \"Fine Tune\" setting.",
        options = offsetMultipliers,
        default = 1
    },
    {
        name = "OffsetYFine",
        label = "Y Offset Fine Tune",
        hover = "Fine tune Y Offset",
        options = fineOffsets,
        default = 0
    },
    {
        name = "SEPARATOR_TAME_SETTINGS",
        label = "Buff Taming",
        options = {{description = "", data = 1}},
        default = 1
    },
    {
        name = "isBuffDomestication",
        label = "Easier Domestication",
        hover = "Beefalo domestication is faster and ridetime is longer",
        options = {
            {description = "Disabled", data = false, hover = "Taming beefalo like base game"},
            {description = "Enabled", data = true, hover = "Superfast taming & Superlong riding"}
        },
        default = false
    },
}