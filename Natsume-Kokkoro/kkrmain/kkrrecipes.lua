RegisterInventoryItemAtlas("images/inventoryimages/kkr_gemstaff.xml","kkr_gemstaff.tex")
AddRecipe2(
    'kkr_gemstaff',
    {Ingredient('goldnugget', 2), Ingredient('bluegem', 1), Ingredient('twigs', 2)},
    TECH.NONE,
    {builder_tag = 'kkr', atlas = 'images/inventoryimages/kkr_gemstaff.xml', image = 'kkr_gemstaff.tex'},
    {'CHARACTER'}
)
RegisterInventoryItemAtlas("images/inventoryimages/kkr_elfstaff_plus.xml","kkr_elfstaff_plus.tex")
AddRecipe2(
    'kkr_elfstaff_plus',
    {Ingredient('kkr_elfstaff', 1,'images/inventoryimages/kkr_elfstaff.xml'), Ingredient('moonglass', 9), Ingredient('thulecite', 4)},
    TECH.NONE,
    {builder_tag = 'kkr', atlas = 'images/inventoryimages/kkr_elfstaff_plus.xml', image = 'kkr_elfstaff_plus.tex'},
    {'CHARACTER'}
)
RegisterInventoryItemAtlas("images/inventoryimages/kkr_elfrobe.xml","kkr_elfrobe.tex")
AddRecipe2(
    'kkr_elfrobe',
    {Ingredient('silk', 4), Ingredient('pigskin', 2), Ingredient('rope', 2)},
    TECH.NONE,
    {builder_tag = 'kkr', atlas = 'images/inventoryimages/kkr_elfrobe.xml', image = 'kkr_elfrobe.tex'},
    {'CHARACTER'}
)
RegisterInventoryItemAtlas("images/inventoryimages/kkr_elfcloak_wing.xml","kkr_elfcloak_wing.tex")
AddRecipe2(
    'kkr_elfcloak',
    {Ingredient('goose_feather', 8), Ingredient('feather_canary', 2), Ingredient('kkr_elfrobe', 1,'images/inventoryimages/kkr_elfrobe.xml')},
    TECH.NONE,
    {builder_tag = 'kkr', atlas = 'images/inventoryimages/kkr_elfcloak_wing.xml', image = 'kkr_elfcloak_wing.tex'},
    {'CHARACTER'}
)
RegisterInventoryItemAtlas("images/inventoryimages/kkr_flower_ribbon.xml","kkr_flower_ribbon.tex")
AddRecipe2(
    'kkr_flower_ribbon',
    {Ingredient('goldnugget', 1), Ingredient('petals', 9)},
    TECH.NONE,
    {builder_tag = 'kkr', atlas = 'images/inventoryimages/kkr_flower_ribbon.xml', image = 'kkr_flower_ribbon.tex'},
    {'CHARACTER'}
)
RegisterInventoryItemAtlas("images/inventoryimages/kkr_flower_amulet.xml","kkr_flower_amulet.tex")
AddRecipe2(
    'kkr_flower_amulet',
    {Ingredient('kkr_flower_ribbon', 1,'images/inventoryimages/kkr_flower_ribbon.xml'), Ingredient('yellowamulet', 1)},
    TECH.NONE,
    {builder_tag = 'kkr', atlas = 'images/inventoryimages/kkr_flower_amulet.xml', image = 'kkr_flower_amulet.tex'},
    {'CHARACTER'}
)
RegisterInventoryItemAtlas("images/inventoryimages/kkr_newyear_staff.xml","kkr_newyear_staff.tex")
AddRecipe2(
    'kkr_newyear_staff',
    {Ingredient('goldnugget', 5), Ingredient('manrabbit_tail', 2), Ingredient('minifan', 1)},
    TECH.NONE,
    {builder_tag = 'kkr', atlas = 'images/inventoryimages/kkr_newyear_staff.xml', image = 'kkr_newyear_staff.tex'},
    {'CHARACTER'}
)
RegisterInventoryItemAtlas("images/inventoryimages/kkr_pocket.xml","kkr_pocket.tex")
AddRecipe2(
    'kkr_pocket',
    {Ingredient('pigskin', 1), Ingredient('waxpaper', 1), Ingredient('silk', 1)},
    TECH.NONE,
    {builder_tag = 'kkr', atlas = 'images/inventoryimages/kkr_pocket.xml', image = 'kkr_pocket.tex'},
    {'CHARACTER'}
)
RegisterInventoryItemAtlas("images/inventoryimages/kkr_pocket_plus.xml","kkr_pocket_plus.tex")
AddRecipe2(
    'kkr_pocket_plus',
    {Ingredient('kkr_pocket', 1,'images/inventoryimages/kkr_pocket.xml'), Ingredient('pigskin', 3), Ingredient('bluegem', 1)},
    TECH.NONE,
    {builder_tag = 'kkr', atlas = 'images/inventoryimages/kkr_pocket_plus.xml', image = 'kkr_pocket_plus.tex'},
    {'CHARACTER'}
)
RegisterInventoryItemAtlas("images/inventoryimages/kkr_dragon_meat.xml","kkr_dragon_meat.tex")
AddRecipe2(
    'kkr_dragon_meat',
    {Ingredient('dragon_scales', 1)},
    TECH.NONE,
    {builder_tag = 'kkr', atlas = 'images/inventoryimages/kkr_dragon_meat.xml', image = 'kkr_dragon_meat.tex',numtogive = 4},
    {'CHARACTER'}
)
AddRecipe2(
    'kkr_meat',
    {Ingredient('monstermeat', 3)},
    TECH.NONE,
    {builder_tag = 'kkr', 
    atlas = 'images/inventoryimages2.xml', 
    image = 'meat.tex',
    product = 'meat',
    numtogive = 2},
    {'CHARACTER'}
)

