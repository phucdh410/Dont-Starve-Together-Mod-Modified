local RECIPETABS = GLOBAL.RECIPETABS
local STRINGS = GLOBAL.STRINGS
local TECH = GLOBAL.TECH

AddRecipe2("bundle_cutstones",
  {Ingredient("rocks", 150)},
  TECH.SCIENCE_ONE,
  {
    product = "cutstone",
    numtogive = 50,
    atlas = "images/inventoryimages/bundle_cutstones.xml", -- Path to your custom atlas
    image = "bundle_cutstones.tex"
  },
  { "REFINE" }
)

STRINGS.NAMES.BUNDLE_CUTSTONES = "50x Cutstones"
STRINGS.RECIPE_DESC.BUNDLE_CUTSTONES = "Craft instantly 50 cutstones"