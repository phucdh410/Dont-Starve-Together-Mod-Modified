local AddRecipe2 = AddRecipe2

AddRecipeFilter({
    name = "EFFICIENT_AGRICULTURE",
    atlas = "images/ea_filter.xml",
    image = "ea_filter.tex",
})

AddRecipe2("ea_jinkela",
{Ingredient("ea_jinkela_ash", 8, "images/inventoryimages/ea_jinkela_ash.xml"), Ingredient("goldnugget", 1)},
    TECH.SCIENCE_ONE, {
        atlas = "images/inventoryimages/ea_jinkela.xml",
        image = "ea_jinkela.tex",
		numtogive = 2,
    },
    {CRAFTING_FILTERS.GARDENING.name, CRAFTING_FILTERS.EFFICIENT_AGRICULTURE.name}
)

AddRecipe2("ea_fertilizer_machine",
    {Ingredient("boards", 4), Ingredient("transistor", 2), Ingredient("cutstone", 2)},
    TECH.SCIENCE_ONE, {
        atlas = "images/inventoryimages/ea_fertilizer_machine.xml",
        image = "ea_fertilizer_machine.tex",
        placer = "ea_fertilizer_machine_placer",
        min_spacing = 1.5,
    },
    {CRAFTING_FILTERS.GARDENING.name, CRAFTING_FILTERS.EFFICIENT_AGRICULTURE.name}
)

if EA_CONSTANTS.ADDED_SEEDING then
    AddRecipe2("ea_seeding_machine",
        {Ingredient("gears", 3), Ingredient("transistor", 6), Ingredient("seeds", 4)},
        TECH.SCIENCE_TWO, {
            atlas = "images/inventoryimages/ea_seeding_machine.xml",
            image = "ea_seeding_machine.tex",
            placer = "ea_seeding_machine_placer",
            min_spacing = 1.5,
        },
        {CRAFTING_FILTERS.GARDENING.name, CRAFTING_FILTERS.EFFICIENT_AGRICULTURE.name}
    )
end

if EA_CONSTANTS.ADDED_HARVEST then
    AddRecipe2("ea_harvest_machine",
        {Ingredient("gears", 1), Ingredient("boards", 4), Ingredient("transistor", 2)},
        TECH.SCIENCE_TWO, {
            atlas = "images/inventoryimages/ea_harvest_machine.xml",
            image = "ea_harvest_machine.tex",
            placer = "ea_harvest_machine_placer",
            min_spacing = 2,
        },
        {CRAFTING_FILTERS.GARDENING.name, CRAFTING_FILTERS.EFFICIENT_AGRICULTURE.name}
    )

    AddRecipe2("ea_harvest_machine2",
    {Ingredient("gears", 2), Ingredient("boards", 4), Ingredient("transistor", 2)},
    TECH.SCIENCE_TWO, {
        atlas = "images/inventoryimages/ea_harvest_machine2.xml",
        image = "ea_harvest_machine2.tex",
        placer = "ea_harvest_machine2_placer",
        min_spacing = 2,
    },
    {CRAFTING_FILTERS.GARDENING.name, CRAFTING_FILTERS.EFFICIENT_AGRICULTURE.name}
)
end

if EA_CONSTANTS.ADDED_SHOP then
    AddRecipe2("ea_shop",
        {Ingredient("gears", 2), Ingredient("boards", 16), Ingredient("transistor", 8), Ingredient("pigskin", 4)},
        TECH.SCIENCE_TWO, {
            atlas = "images/inventoryimages/ea_shop.xml",
            image = "ea_shop.tex",
            placer = "ea_shop_placer",
            min_spacing = 4,
        },
        {CRAFTING_FILTERS.GARDENING.name, CRAFTING_FILTERS.EFFICIENT_AGRICULTURE.name}
    )
end

AddRecipe2("ea_well",
    {Ingredient("cutstone", 16)},
    TECH.NONE, {
        atlas = "images/inventoryimages/ea_well.xml",
        image = "ea_well.tex",
        placer = "ea_well_placer",
        min_spacing = 4,
    },
    {CRAFTING_FILTERS.GARDENING.name, CRAFTING_FILTERS.EFFICIENT_AGRICULTURE.name}
)

if EA_CONSTANTS.ADDED_PLOW then
    AddRecipe2("ea_farm_plow_machine_item",
        {Ingredient("gears", 2), Ingredient("cutstone", 16), Ingredient("transistor", 8)},
        TECH.MAGIC_TWO, {
            atlas = "images/inventoryimages/ea_farm_plow_machine_item.xml",
            image = "ea_farm_plow_machine_item.tex",
        },
        {CRAFTING_FILTERS.GARDENING.name, CRAFTING_FILTERS.EFFICIENT_AGRICULTURE.name}
    )
end