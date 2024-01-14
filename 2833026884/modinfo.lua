name = "Quicker Beefalo Domestication - DHPModified"
version = "0.1.5"
description = "It helps tame beefalo quicker."
author = "Araelynn - DHPModified"
forumthread = ""

api_version = 10

all_clients_require_mod = true
client_only_mod = false
dst_compatible = true

icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = {"beefalo"}

configuration_options = {{
    name = "domestication_accelerate",
    label = "Tame Acceleration",
    hover = "Taming Multiplier",
    options = {{
        description = "default",
        hover = "DEFAULT",
        data = 1
    },  {
        description = "x4",
        hover = "x4",
        data = 4
    }, {
        description = "Fast",
        hover = "x10",
        data = 10
    }, {
        description = "Extreme Fast",
        hover = "x20",
        data = 20
    }},
    default = 4
}, {
    name = "domestication_dont_loss",
    label = "Domestication doesn't drop",
    hover = "Domestication doesn't deplete",
    options = {{
        description = "Enable",
        hover = "Enable",
        data = true
    }, {
        description = "Disable",
        hover = "Disable",
        data = false
    }},
    default = true
}, {
    name = "ornery_min_domesticated_obedience",
    label = "Ornery Domestication Obedience",
    hover = "Retain Ornery Dom. Obedience",
    options = {{
        description = "Default",
        hover = "Default",
        data = 0.45
    }, {
        description = "Retain High Level",
        hover = "Retain High Level",
        data = 0.8
    }},
    default = 0.8
}, {
    name = "domestication_nopoop",
    label = "Tame Beefalo Poop",
    hover = "Enable/Disable Tamed Pooping",
    options = {{
        description = "Poop",
        hover = "Poop",
        data = false
    }, {
        description = "No Poop",
        hover = "No Poop",
        data = true
    }},
    default = false
}}
