name = "More Drops - DHPModified"
description = [[
Original mod: https://steamcommunity.com/sharedfiles/filedetails/?id=3433071145&searchtext=More+Drops+JEM
From update version: 24 February 2025
-------------------------------------------------------
I updated with more options for loot amount (easier). 
Loot options:
- Pickable plants (grass, twigs, reeds, berries, juicy berries, bananas, mushrooms)
- Trees
- Crops farm
- Mining entities (rocks, flint, gems, ice, thulecite fragments)
- Birdcage (invicible; more seeds & eggs)
- Beebox
- Nightmare fuel (Crawlinghorror, Terrorbeak)
- Living log (Treeguard)
*** Infinite fertilized (replanted plants only need to be fertilized once)
*** Jackpot reward when break rocks/boulders. 
*** Mandrake (You are cheater). When you pick grass or berries, maybe a mandrake hides in it
]]
author = "PhucDH410"
edited = "PhucDH410"
version = "1.8.33"

api_version = 6
api_version_dst = 10
dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = false
dst_compatible = true

icon_atlas = "modicon.xml"
icon = "modicon.tex"

forumthread = ""

all_clients_require_mod = true
clients_only_mod = false

server_filter_tags = {"utility", "tweak"}

chances = 
{
	{description = "0%", data = 0.00},
	{description = "1%", data = 0.01},
	{description = "5%", data = 0.05},
	{description = "10%", data = 0.1},
	{description = "15%", data = 0.15},
	{description = "20%", data = 0.2},
	{description = "25%", data = 0.25},
	{description = "30%", data = 0.3},
	{description = "35%", data = 0.35},
	{description = "40%", data = 0.4},
	{description = "45%", data = 0.45},
	{description = "50%", data = 0.5},
	{description = "55%", data = 0.55},
	{description = "60%", data = 0.6},
	{description = "65%", data = 0.65},
	{description = "70%", data = 0.7},
	{description = "75%", data = 0.75},
	{description = "80%", data = 0.8},
	{description = "85%", data = 0.85},
	{description = "90%", data = 0.9},
	{description = "95%", data = 0.95},
	{description = "100%", data = 1.0}
}

mining = 
{
	{description = "0%", data = 0.00},
	{description = "1%", data = 0.01},
	{description = "5%", data = 0.05},
	{description = "10%", data = 0.1},
	{description = "15%", data = 0.15},
	{description = "20%", data = 0.2},
	{description = "25%", data = 0.25},
	{description = "30%", data = 0.3},
	{description = "35%", data = 0.35},
	{description = "40%", data = 0.4},
	{description = "45%", data = 0.45},
	{description = "50%", data = 0.5},
	{description = "75%", data = 0.75},
	{description = "100%", data = 1.0}
}

amounts = 
{
	{description = "None", data = 0},
	{description = "1", data = 1},
	{description = "2", data = 2},
	{description = "3", data = 3},
	{description = "4", data = 4},
	{description = "5", data = 5},
	{description = "6", data = 6},
	{description = "7", data = 7},
	{description = "8", data = 8},
	{description = "9", data = 9},
	{description = "10", data = 10}
}

local empty_options = {{description = "", data = 0 }}

local function Title(title,hover)
	return {
		name = "",
		label = title,
		hover=hover,
		options = empty_options,
		default = 0,
	}
end

SEPARATOR = Title("")


configuration_options =
{
  {
    name = "infinitefertilize",
    label = "Infinite Fertilized",
    hover = "Whether or not replanted plants need to be fertilized only once",
    options = 
      {
        {description = "False", data = false}, 
        {description = "True", data = true},
      }, 
       default = true,
  },
  
  SEPARATOR,

  {
    name = "grassAmount",
    label = "Extra Cut Grass",
    hover = "How many extra cut grass you can get",
    options = amounts,
    default = 1,
  },
  {
    name = "grassChance",
    label = "Extra Grass Chance",
    hover = "Chance to get extra cut grass",
    options = chances,
	  default = .25
  },
  
  SEPARATOR,
  
	{
    name = "twigAmount",
    label = "Extra Twigs",
    hover = "How many extra twigs you can get",
    options = amounts,
    default = 1
  },
  {
    name = "twigChance",
    label = "Extra Twig Chance",
    hover = "Chance to get extra twigs",
    options = chances,
    default = .25
  },
  
  SEPARATOR,
  
	{
    name = "reedAmount",
    label = "Extra Reeds",
    hover = "How many extra reeds you can get",
    options = amounts,
	  default = 1
  },
  {
    name = "reedChance",
    label = "Extra Reed Chance",
    hover = "Chance to get extra reeds",
    options = chances,
	  default = .25
  },
  
  SEPARATOR,
  
  {
    name = "berryAmount",
    label = "Extra Berries",
    hover = "How many extra berries you can get",
    options = amounts,
	  default = 1
  },
  {
    name = "berryChance",
    label = "Extra Berry Chance",
    hover = "Chance to get extra berries",
    options = chances,
	  default = .25
  },
  
  SEPARATOR,
  
  {
    name = "berry_JuicyAmount",
    label = "Extra Juicy Berries",
    hover = "How many extra juicy berries you can get",
    options = amounts,
    default = 3
  },
  {
    name = "berry_JuicyChance",
    label = "Extra Juicy Berry Chance",
    hover = "Chance to get extra juicy berries",
    options = chances,
	  default = .25
  },
  
  SEPARATOR,
  
  {
    name = "bananaAmount",
    label = "Extra Bananas",
    hover = "How many extra bananas you can get",
    options = amounts,
    default = 1,
  },
  {
    name = "bananaChance",
    label = "Extra Banana Chance",
    hover = "Chance to get extra bananas",
    options = chances,
	  default = .25
  },

  SEPARATOR,
  
  {
    name = "mushroomAmount",
    label = "Extra Mushrooms",
    hover = "How many extra mushrooms you can get",
    options = amounts,
    default = 1,
  },
  {
    name = "mushroomChance",
    label = "Extra Mushroom Chance",
    hover = "Chance to get extra mushrooms",
    options = chances,
	  default = .25
  },
  
  SEPARATOR,

  {
    name = "mandrakeChance",
    label = "Mandrake Chance",
    hover = "Chance for mandrake found from picking something",
    options = chances,
    default = 0
  },
  
  SEPARATOR,
  
  {
    name = "extralogs",
    label = "Extra Logs",
    hover = "How many extra logs you can get when chopping a tree",
    options = amounts,
    default = 1
  },
  {
    name = "extralogstall",
    label = "Extra Tall Logs",
    hover = "How many extra logs you can get when chopping a tall tree",
    options = amounts,
	  default = 2
  },
  {
    name = "logChance",
    label = "Extra Logs Chance",
    hover = "Chance to get extra logs after chopping tree",
    options = chances,
	  default = .25
  },
  {
    name = "treeseedchance",
    label = "Tree Seed Chance",
    hover = "Chance for trees to drop an additional seed",
    options = chances,
    default = .25
  },
  
  SEPARATOR,
  
  {
    name = "extracrops",
    label = "Extra Crops",
    hover = "How many extra crops gained when harvesting a farm",
    options = amounts,
    default = 1
  },
  {
    name = "cropChance",
    label = "Extra Crops Chance",
    hover = "Chance to get extra crops while harvesting",
    options = chances,
    default = .25
  },
  
  SEPARATOR,
  
  {
    name = "rockChance",
    label = "Extra Rocks Chance",
    hover = "Chance to get extra rocks while mining",
    options = mining,
    default = .30
  },
  {
    name = "flintChance",
    label = "Extra Flint Chance",
    hover = "Chance to get extra flint while mining",
    options = mining,
	  default = .15
  },
  {
    name = "specialChance",
    label = "Extra Specialty Rocks Chance",
    hover = "Chance to get extra nitre, gold, and moon rocks while mining",
    options = mining,
	  default = .15
  },
  {
    name = "redChance",
    label = "Extra Red Gems Chance",
    hover = "Chance to get red gems while mining",
    options = mining,
	  default = 0.01
  },
  {
    name = "blueChance",
    label = "Extra Blue Gems Chance",
    hover = "Chance to get blue gems while mining",
    options = mining,
	  default = 0.01
  },
  {
    name = "purpleChance",
    label = "Extra Purple Gems Chance",
    hover = "Chance to get purple gems while mining",
    options = mining,
	  default = 0.01
  },
  {
    name = "orangeChance",
    label = "Extra Orange Gems Chance",
    hover = "Chance to get orange gems while mining",
    options = mining,
	  default = 0.01
  }, 
  {
    name = "yellowChance",
    label = "Extra Yellow Gems Chance",
    hover = "Chance to get yellow gems while mining",
    options = mining,
	  default = 0.01
  },
  {
    name = "greenChance",
    label = "Extra Green Gems Chance",
    hover = "Chance to get green gems while mining",
    options = mining,
	  default = 0.01
  },
  {
    name = "thuleciteChance",
    label = "Extra Thulecite Fragments Chance",
    hover = "Chance to get thulecite fragments while mining",
    options = mining,
	  default = 0
  },
  {
    name = "jackpotChance",
    label = "Mining Jackpot Chance",
    hover = "Chance to get super loot when break rock",
    options = mining,
	  default = 0
  },
  {
    name = "jackpotAmount",
    label = "Amount Jackpot",
    hover = "Amount loot you can get from jackpot",
    options = amounts,
	  default = 0
  },
  
  SEPARATOR,
  
  {
    name = "glacierChance",
    label = "Extra Glaciers Chance",
    hover = "Chance to get extra glaciers while mining",
    options = mining,
    default = .1
  },
  {
    name = "glacierAmount",
    label = "Extra Ice",
    hover = "How many extra ices you can get",
    options = amounts,
    default = 1,
  },

  SEPARATOR,
  
  {
    name = "marbleChance",
    label = "Extra Marbles Chance",
    hover = "Chance to get extra marbles when destroying marbleshrub",
    options = mining,
    default = .1
  },
  {
    name = "marbleAmount",
    label = "Extra Marble",
    hover = "How many extra marbles you can get",
    options = amounts,
    default = 1,
  },
  {
    name = "marblebeanChance",
    label = "Extra Marble Beans Chance",
    hover = "Chance to get extra marble beans when destroying marbleshrub",
    options = chances,
    default = .3
  },
  {
    name = "marblebeanAmount",
    label = "Extra Marble Bean",
    hover = "How many extra marble beans you can get",
    options = amounts,
    default = 1,
  },

  SEPARATOR,
  
  {
    name = "immortalBird",
    label = "Immortal Imprison Bird",
    hover = "Bird in birdcage still alive without feeding",
    options = {
      { description = "Disable", data = false },
      { description = "Enable", data = true }
    },
    default = true,
  },
  {
    name = "birdcageTradeAmount",
    label = "Birdcage Trade Amount",
    hover = "How many extra loot you can get when feeding bird",
    options = amounts,
    default = 1,
  },

  SEPARATOR,
  
  {
    name = "honeyAmount",
    label = "Extra Honey Amount",
    hover = "How many extra honey you can get when harvest beebox",
    options = amounts,
    default = 1,
  },

  SEPARATOR,
  
  {
    name = "nightmareFuelAmount",
    label = "Extra Nightmare Fuels",
    hover = "How many extra nightmare fuels you can get when killing shadow creatures",
    options = amounts,
	  default = 1
  },
  {
    name = "nightmareFuelChance",
    label = "Extra Nightmare Fuels Chance",
    hover = "Chance to get extra nightmare fuels",
    options = chances,
	  default = .25
  },

  SEPARATOR,
  
  {
    name = "treeguardLoot",
    label = "Treeguard Loot",
    hover = "Select the range of loot you can get from killing treeguard",
    options = {
      { description = "Default", data = 1, hover = "6 Living logs, 1 Monster meat" },
      { description = "More", data = 2, hover = "10 Living logs, 3 Monster meat" },
      { description = "Rich", data = 3, hover = "15 Living logs, 5 Monster meat" },
      { description = "Max", data = 4, hover = "20 Living logs, 10 Monster meat" },
    },
	  default = 1
  },
}