name = "Fast equip set - DHPModified"
version = "1.1"
description = ("Equip your set when attacking")
author = "Tranoze - DHPModified"


api_version = 10

local opt_Empty = {{description = "", data = 0}}
local function Title(title,hover)
	return {
		name=title,
		--label=title,
		hover=hover,
		options=opt_Empty,
		default=0,
	}
end
local SEPARATOR = Title("")

local string = ""
local keys = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","F1","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11","F12","LAlt","RAlt","LCtrl","RCtrl","LShift","RShift","Tab","Capslock","Space","Minus","Equals","Backspace","Insert","Home","Delete","End","Pageup","Pagedown","Print","Scrollock","Pause","Period","Slash","Semicolon","Leftbracket","Rightbracket","Backslash","Up","Down","Left","Right"}
local keylist = {}
for i = 1, #keys do
    keylist[i] = {description = keys[i], data = "KEY_"..string.upper(keys[i])}
end
keylist[#keylist + 1] = {description = "Disabled", data = false}

local tf_options = {
	{description = "Yes", data = true},
	{description = "No", data = false},
}
local swap_option = {
	{description = "Key F", data = true},
	{description = "Mouse click", data = false},
}

configuration_options =
{
	Title("Control setting"),
    {
        name = "SETBIND1",
        label = "Key down custom set",
        options = keylist,
        default = "KEY_T",
		hover = "Press this key to swap to custom set 1.",
    }, 
	{
        name = "SETBIND2",
        label = "Key up custom set(default kite set)",
        options = keylist,
        default = "KEY_F",
		hover = "Unpress this key to swap to custom set 2.",
    },
}

all_clients_require_mod = false
client_only_mod = true
dont_starve_compatible = false
dst_compatible = true
reign_of_giants_compatible = false
shipwrecked_compatible = false

icon_atlas = "modicon.xml"
icon = "modicon.tex"
