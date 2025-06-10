name = 'Rui Ta - DHPModified'
description = 'No Description'
author = 'PhucDH410'
version = '1.0.0'

api_version = 10

dst_compatible = true

dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false

all_clients_require_mod = true

icon_atlas = 'modicon.xml'
icon = 'modicon.tex'

server_filter_tags = {
    'character',
    'ruita',
    'Rui Ta'
}

configuration_options = {
    {
        name = 'xxx3_wf_producebutterfly',
        label = 'Butterfly Spawn',
        hover = 'Should the World Flower spawn butterflies?',
        options = {
            {description = 'Enable', data = true},
            {description = 'Disable', data = false}
        },
        default = true
    },
    {
        name = 'xxx3_wf_producefirefly',
        label = 'Firefly Spawn',
        hover = 'Should the World Flower spawn fireflies?',
        options = {
            {description = 'Enable', data = true},
            {description = 'Disable', data = false}
        },
        default = true
    },
    {
        name = 'xxx3_wf_produceitem',
        label = 'World Flower Drop',
        hover = 'Should the World Flower drop items every morning?',
        options = {
            {description = 'Enable', data = true},
            {description = 'Disable', data = false}
        },
        default = true
    },
    {
        name = 'xxx3_itemduring',
        label = 'Item Durability',
        hover = 'Should bouquets and all types of Eyebrella garlands have durability?',
        options = {
            {description = 'Enable', data = true},
            {description = 'Disable', data = false}
        },
        default = false
    },
    {
        name = 'xxx3_foodvalue',
        label = 'Food Values',
        hover = "Ruita's exclusive food healing effects",
        options = {
            {description = '50%', data = 0.5},
            {description = '75%', data = 0.75},
            {description = '100%', data = 1},
            {description = '150%', data = 1.5},
            {description = '200%', data = 2}
        },
        default = 1
    }
}
