name = "Gem Crystal Cluster - DHPModified"
description = ""
author = "PhucDH410"
version = "1.5"

forumthread = ""

dst_compatible = true
all_clients_require_mod = true
api_version = 10

icon_atlas = "modicon.xml"
icon = "modicon.tex"

configuration_options =
{
    {
        name = "growtime",
        label = "Growth Cycle (day)",
        hover = "Growth Cycle (day)",
        options =
        {
            {description = "1", data = 1},
            {description = "3", data = 3},
            {description = "5", data = 5},
            {description = "8", data = 8},
            {description = "10", data = 10},
        },
        default = 5,
    },
    {
        name = "gemcost",
        label = "Gem Cost",
        hover = "Gem Cost",
        options =
        {
            {description = "1", data = 1},
            {description = "2", data = 2},
            {description = "3", data = 3},
            {description = "5", data = 5},
            {description = "8", data = 8},
            {description = "10", data = 10},
        },
        default = 5,
    },
    {
        name = "gemloot",
        label = "Gem Loot",
        hover = "Gem Loot",
        options =
        {
            {description = "1", data = 1},
            {description = "2", data = 2},
            {description = "3", data = 3},
            {description = "5", data = 5},
            {description = "8", data = 8},
            {description = "10", data = 10},
        },
        default = 1,
    },
}
