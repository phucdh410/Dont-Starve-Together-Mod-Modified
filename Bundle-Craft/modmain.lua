local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local RECIPETABS = GLOBAL.RECIPETABS
local Recipe = GLOBAL.Recipe
local Ingredient = GLOBAL.Ingredient
local TECH = GLOBAL.TECH

Assets = {
  Asset("ATLAS", "images/inventoryimages/bundle_cutstones.xml"),
  Asset("IMAGE", "images/inventoryimages/bundle_cutstones.tex"),
}

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