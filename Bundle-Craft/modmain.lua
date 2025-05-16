local STRINGS = GLOBAL.STRINGS
local TECH = GLOBAL.TECH

AddRecipe2("bundle_cutstones",
  {Ingredient("rocks", 150)},
    TECH.SCIENCE_ONE,
  {
    atlas = "images/inventoryimages/cutstone.xml",
    image = "cutstone.tex",
    product = "cutstone",
    numtogive = 50 
  },
  { "REFINE" }
)

STRINGS.NAMES.BUNDLE_CUTSTONES = "50x Cutstones"
STRINGS.RECIPE_DESC.BUNDLE_CUTSTONES = "Craft instantly 50 cutstones"