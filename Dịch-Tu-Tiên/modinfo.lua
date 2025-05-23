name = "【登仙】"
description = ""
author = "薪人小黄、路障僵尸、吃不吃大肉丸子"
version = "10.10"
forumthread = ""
dst_compatible = true
all_clients_require_mod = true
api_version = 10
priority = -10
icon_atlas = "modicon.xml"
icon = "modicon.tex"
server_filter_tags = {"登仙", "我欲修仙"}
local Q = {
    {"BACKSPACE", 8},
    {"TAB", 9},
    {"ENTER", 13},
    {"PAUSE", 19},
    {"ESCAPE", 27},
    {"SPACE", 32},
    {"MINUS", 45},
    {"PERIOD", 46},
    {"SLASH", 47},
    {"0", 48},
    {"1", 49},
    {"2", 50},
    {"3", 51},
    {"4", 52},
    {"5", 53},
    {"6", 54},
    {"7", 55},
    {"8", 56},
    {"9", 57},
    {"EQUALS", 61},
    {"LEFTBRACKET", 91},
    {"BACKSLASH", 92},
    {"RIGHTBRACKET", 93},
    {"TILDE", 96},
    {"A", 97},
    {"B", 98},
    {"C", 99},
    {"D", 100},
    {"E", 101},
    {"F", 102},
    {"G", 103},
    {"H", 104},
    {"I", 105},
    {"J", 106},
    {"K", 107},
    {"L", 108},
    {"M", 109},
    {"N", 110},
    {"O", 111},
    {"P", 112},
    {"Q", 113},
    {"R", 114},
    {"S", 115},
    {"T", 116},
    {"U", 117},
    {"V", 118},
    {"W", 119},
    {"X", 120},
    {"Y", 121},
    {"Z", 122},
    {"DELETE", 127},
    {"KP_PERIOD", 266},
    {"KP_DIVIDE", 267},
    {"KP_MULTIPLY", 268},
    {"KP_MINUS", 269},
    {"KP_PLUS", 270},
    {"KP_ENTER", 271},
    {"KP_EQUALS", 272},
    {"UP", 273},
    {"DOWN", 274},
    {"RIGHT", 275},
    {"LEFT", 276},
    {"INSERT", 277},
    {"HOME", 278},
    {"END", 279},
    {"PAGEUP", 280},
    {"PAGEDOWN", 281},
    {"F1", 282},
    {"F2", 283},
    {"F3", 284},
    {"F4", 285},
    {"F5", 286},
    {"F6", 287},
    {"F7", 288},
    {"F8", 289},
    {"F9", 290},
    {"F10", 291},
    {"F11", 292},
    {"F12", 292},
    {"CAPSLOCK", 301},
    {"SCROLLOCK", 302},
    {"RSHIFT", 303},
    {"LSHIFT", 304},
    {"RCTRL", 305},
    {"LCTRL", 306},
    {"RALT", 307},
    {"LALT", 308},
    {"ALT", 400},
    {"CTRL", 401},
    {"SHIFT", 402}
}
local ZA = {}
for _IQQ = 1, #Q do
    ZA[_IQQ] = {description = Q[_IQQ][1], data = Q[_IQQ][2]}
end
configuration_options = {
    {
        name = "set00",
        label = "Extra Backpack Slot",
        options = {{description = "No", data = 0}, {description = "Four Slots", data = 1}, {description = "Five Slots", data = 2}},
        default = 0
    },
    {
        name = "set1",
        label = "All Realms",
        options = {{description = "Yes", data = true}, {description = "No", data = false}},
        default = true
    },
    {
        name = "set2",
        label = "Exclusive HP Bar",
        options = {{description = "Yes", data = true}, {description = "No", data = false}},
        default = true
    },
    {
        name = "set5",
        label = "Damage Display",
        options = {{description = "Yes", data = true}, {description = "No", data = false}},
        default = true
    },
    {
        name = "set3",
        label = "Spirit Stone Lottery Machine",
        options = {{description = "Yes", data = true}, {description = "No", data = false}},
        default = true
    },
    {
        name = "set4",
        label = "Drop Stack",
        options = {{description = "Yes", data = true}, {description = "No", data = false}},
        default = false
    },
    {
        name = "set6",
        label = "Enable Monkey Character",
        options = {{description = "Yes", data = true}, {description = "No", data = false}},
        default = true
    },
    {
        name = "set7",
        label = "Enable Item Information Display",
        options = {{description = "Yes", data = true}, {description = "No", data = false}},
        default = true
    },
    {
        name = "set10",
        label = "Double the effect of high-quality and top-quality Spirit Stones",
        options = {{description = "Do not double", data = 0}, {description = "5 times", data = 5}, {description = "10 times", data = 10}},
        default = 5
    },
    {name = "key_z", label = "Magic Skill Key", options = ZA, default = 122},
    {name = "key_x", label = "Immortal Sword Key", options = ZA, default = 120},
    {name = "key_v", label = "Summon Recall Key", options = ZA, default = 118},
    {name = "wukongkey", label = "Wukong Transformation Key", options = ZA, default = 114},
    {
        name = "set11",
        label = "Whether to display wearing equipment (armor/helmet)",
        options = {{description = "Yes", data = true}, {description = "No", data = false}},
        default = true
    },
    {
        name = "set12",
        label = "Whether to display wearing equipment (clothes)",
        options = {{description = "Yes", data = true}, {description = "No", data = false}},
        default = true
    },
    {
        name = "set13",
        label = "Whether to display wearing equipment (backpack)",
        options = {{description = "Yes", data = true}, {description = "No", data = false}},
        default = true
    },
    {
        name = "set14",
        label = "Whether to display wearing equipment (weapon)",
        options = {{description = "Yes", data = true}, {description = "No", data = false}},
        default = true      
    }
}
