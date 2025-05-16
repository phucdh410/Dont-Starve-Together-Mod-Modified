local STRINGS = GLOBAL.STRINGS
local TECH = GLOBAL.TECH

AddRecipe2("bundle_cutstones",
  {Ingredient("rocks", 150)},
    TECH.SCIENCE_ONE,
  {
    atlas = "images/inventoryimages/bundle_cutstones.xml",
    image = "bundle_cutstones.tex",
    product = "cutstone",
    numtogive = 50 
  },
  { "REFINE" }
)

STRINGS.NAMES.BUNDLE_CUTSTONES = "50x Cutstones"
STRING.RECIPE_DESC.BUNDLE_CUTSTONES = "Craft instantly 50 cutstones"

-- AddRecipe2("bundle_ropes", {Ingredient("cutgrass", 150)}, TECH.SCIENCE_ONE, {atlas = "images/inventoryimages/rope.xml", image = "rope.tex", product = "rope", numtogive = 50 }, { "REFINE" })
-- AddRecipe2("bundle_boards", {Ingredient("log", 200)}, TECH.SCIENCE_ONE, {atlas = "images/inventoryimages/boards.xml", image = "boards.tex", product = "boards", numtogive = 50 }, { "REFINE" })