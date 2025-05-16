local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local RECIPETABS = GLOBAL.RECIPETABS
local Recipe = GLOBAL.Recipe
local Ingredient = GLOBAL.Ingredient
local TECH = GLOBAL.TECH

Assets = {
  Asset("ATLAS", "images/inventoryimages/bundle_cutstones.xml"),
  Asset("IMAGE", "images/inventoryimages/bundle_cutstones.tex"),
  
  -- Have not yet image - please fill
  Asset("ATLAS", "images/inventoryimages/bundle_boards.xml"),
  Asset("IMAGE", "images/inventoryimages/bundle_boards.tex"),
  
  -- Have not yet image - please fill
  Asset("ATLAS", "images/inventoryimages/bundle_ropes.xml"),
  Asset("IMAGE", "images/inventoryimages/bundle_ropes.tex"),
}

-- Cutstone
AddRecipe2("bundle_cutstones",
  {Ingredient("rocks", 150)},
  TECH.SCIENCE_ONE,
  {
    product = "cutstone",
    numtogive = 50,
    atlas = "images/inventoryimages/bundle_cutstones.xml",
    image = "bundle_cutstones.tex"
  },
  { "REFINE" }
)
STRINGS.NAMES.BUNDLE_CUTSTONES = "50x Cutstones"
STRINGS.RECIPE_DESC.BUNDLE_CUTSTONES = "Craft instantly 50 cutstones"

-- Board
AddRecipe2("bundle_boards",
  {Ingredient("log", 200)},
  TECH.SCIENCE_ONE,
  {
    product = "boards",
    numtogive = 50,
    atlas = "images/inventoryimages/bundle_boards.xml",
    image = "bundle_boards.tex"
  },
  { "REFINE" }
)
STRINGS.NAMES.BUNDLE_BOARDS = "50x Boards"
STRINGS.RECIPE_DESC.BUNDLE_BOARDS = "Craft instantly 50 boards"

-- Rope
AddRecipe2("bundle_ropes",
  {Ingredient("cutgrass", 150)},
  TECH.SCIENCE_ONE,
  {
    product = "rope",
    numtogive = 50,
    atlas = "images/inventoryimages/bundle_ropes.xml",
    image = "bundle_ropes.tex"
  },
  { "REFINE" }
)
STRINGS.NAMES.BUNDLE_ROPES = "50x Ropes"
STRINGS.RECIPE_DESC.BUNDLE_ROPES = "Craft instantly 50 ropes"