name = "More Drops JEM"
description = "Makes trees, boulders, and other resource sources drop more. Also Adds a configurable chance to drop gems."
author = "Dante12129"
edited = "Amnesiac"
version = "1.0"

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
	{description = "0.01%", data = 0.0001},
	{description = "0.02%", data = 0.0002},
	{description = "0.03%", data = 0.0003},
	{description = "0.04%", data = 0.0004},
	{description = "0.05%", data = 0.0005},
	{description = "0.1%", data = 0.001},
	{description = "0.2%", data = 0.002},
	{description = "0.3%", data = 0.003},
	{description = "0.4%", data = 0.004},
	{description = "0.5%", data = 0.005},
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
	{description = "4", data = 4}
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
    label = "Infinite Regrowth",
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
    name = "grassamount",
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
    name = "twigamount",
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
    name = "reedamount",
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
    options = 
      {
        {description = "None", data = 0}, 
        {description = "1", data = 1},
        {description = "2", data = 2},
        {description = "3", data = 3}
      }, 
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
    name = "treeseedchance",
    label = "Tree Seed Chance",
    hover = "Chance for trees to drop an additional seed",
    options = chances,
    default = .25
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
	default = 0.0002
  },
    {
    name = "blueChance",
    label = "Extra Blue Gems Chance",
    hover = "Chance to get blue gems while mining",
    options = mining,
	default = 0.0004
  },
    {
    name = "purpleChance",
    label = "Extra Purple Gems Chance",
    hover = "Chance to get purple gems while mining",
    options = mining,
	default = 0.0001
  },
      {
    name = "orangeChance",
    label = "Extra Orange Gems Chance",
    hover = "Chance to get orange gems while mining",
    options = mining,
	default = 0.0002
  }, 
    {
    name = "yellowChance",
    label = "Extra Yellow Gems Chance",
    hover = "Chance to get yellow gems while mining",
    options = mining,
	default = 0.0001
  },
    {
    name = "greenChance",
    label = "Extra Green Gems Chance",
    hover = "Chance to get green gems while mining",
    options = mining,
	default = 0.0002
  }   
}