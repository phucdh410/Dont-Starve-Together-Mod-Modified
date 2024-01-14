name = "High Stacks And Dont Die - DHPModified"
description = "Increase stack size and dont die animals. Fix bug spiders"
author = "SpiDerman58 - DHPModified" 
version = "v6.0.5"
forumthread = ""
api_version = 10
all_clients_require_mod = true
dst_compatible = true
client_only_mod = false
icon_atlas = "modicon.xml"
icon = "modicon.tex"
server_filter_tags = {"high", "stacks"}

local toggle = {{description = "Enabled", data = true}, {description = "Disabled", data = false}}

local function setCount(k)
    return {description = ""..k.."", data = k}
end

local function dontDie(name)
    return {name = "cfg"..name.."DontDieToggle", label = ""..name.." Never Die", options = toggle, default = true, hover = "Toggle whether they can die or not."}
end

local function removeMurder(name)
    return {name = "cfg"..name.."RemoveMurderToggle", label = "Can't Murder "..name, options = toggle, default = true, hover = "Toggle whether you can murder them or not while they are in your bags."}
end

local function canStack(name)
    return {name = "cfg"..name.."CanStackToggle", label = "Stackable "..name, options = toggle, default = true, hover = "Toggle whether they can stack or not."}
end

local function addOption(cfg, desc, opt, def)
    return {name = cfg, label = desc, options = opt, default = def}
end

local stacks = {} for k=1,20,1 do stacks[k] = setCount(k*5) end
    for k=1,18,1 do local m = k+20 stacks[m] = setCount(k*50+100) end
    for k=1,18,1 do local m = k+38 stacks[m] = setCount(k*500+1000) end
    stacks[#stacks] = setCount(9999)

local dontDieList = {"Bees", "Butterflies", "Rabbits", "Birds", "Moles", "Mosquitos", "Spiders"}
local removeMurderlist = dontDieList
local canStackList = {"Rabbits", "Birds", "Moles", "Spiders"}

local options = {
    {name = "cfgChangeSmallStacksSize", label = "Small Stacks", options = stacks, default = 100, hover = "Change the stack size of small items which normally stack to 40."},
    {name = "cfgChangeMediumStacksSize", label = "Medium Stacks", options = stacks, default = 100, hover = "Change the stack size of medium items which normally stack to 20."},
    {name = "cfgChangeLargeStacksSize", label = "Large Stacks", options = stacks, default = 100, hover = "Change the stack size of large items which normally stack to 10."}
}

for k=1, #canStackList, 1 do options[#options+1] = canStack(canStackList[k]) end
for k=1, #removeMurderlist, 1 do options[#options+1] = removeMurder(removeMurderlist[k]) end
for k=1, #dontDieList, 1 do options[#options+1] = dontDie(dontDieList[k]) end

options[#options+1] = addOption("cfgJerkyDoesntPerish", "Jerky Doesn't Perish", toggle, false)
options[#options+1] = addOption("cfgSeedsDontPerish", "Seeds Don't Perish", toggle, false)
options[#options+1] = addOption("cfgVegSeedsDontPerish", "Veg. Seeds Don't Perish", toggle, true)

configuration_options = options
