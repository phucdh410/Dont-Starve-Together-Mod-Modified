name = "Simple Economy - DHPModified"

description =
[[
Original mod: https://steamcommunity.com/sharedfiles/filedetails/?id=3016346770
From update version: 28 Mar 2025

The server owner can make real-time modifications to the store list without the need for a restart, such as adding items or changing prices.
The item list is located in your mod directory at "..\SEscripts\itemlist.lua."
This mod automatically adjusts to "Uncompromising, Functional Medals, Legion, No Danger No Rich, Island Adventures" 
adding corresponding items if the respective mod is enabled. 
It builds on the Simple Economy of the original mod with a few modifications.
You can set a gold staff multiplier to prevent rapid money farming by decomposing the same item within a certain time. 
At the start, players receive a gold staff, and luck amulet. 
The VIP card and luck amulet can be sold without loss using the gold staff for player-to-player transactions.
Players earn gold by killing creatures, wearing the luck amulet, and recycling items, 
with configurable details for creature gold drops. 
Prices for some goods are adjusted, and more game items are added.
You can set shop item prices with a multiplier (from zero cost to five times the price) 
and decide if seasonal item prices should rise or fall.
Economic data is saved when changing characters, 
and the economic icon can be moved by right-clicking the mouse. 
The gold staff's item recycling price multiplier is also customizable.
]]

author = "PhucDH410"
version = "1.0.0"
forumthread = ""
api_version = 10
dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
all_clients_require_mod = true
server_filter_tags = {"Simple Economy"}
icon_atlas = "modicon.xml"
icon = "modicon.tex"
configuration_options = {
    {
        name = "updatelist",
        label = "Real-time Item Updates",
        hover = "Items are customized by the server owner",
        options = {
            {description = "Off", data = false },
            {description = "On", data = true }
        },
        default = false
    },
    {
        name = "initialcoin",
        label = "Initial Coin",
        options = {
            {description = "0", data = 0},
            {description = "50", data = 50},
            {description = "100", data = 100},
            {description = "200", data = 200},
            {description = "400", data = 400},
            {description = "600", data = 600},
            {description = "800", data = 800},
            {description = "1000", data = 1000}
        },
        default = 200
    },
    {
        name = "Disintegrate",
        label = "Recycling Items",
        hover = "Recycling items by golden staff, Golden Staff attacks low health creatures with a 25% chance to kill them"
        options = {
            {
                description = "No",
                data = false,
                hover = "Not allow to use Midas Wand"
            },
            {
                description = "Yes",
                data = true,
                hover = "Allow to disintegrate most items"
            },
            {
                description = "Limited",
                data = 1,
                hover = "Can only decompose items sold in stores"
            }
        },
        default = true
    },
    {
        name = "givegoldstaff",
        label = "Start Goldstaff",
        hover = "You need to enable Recycling feature, a goldstaff at starting game",
        options = {
            {description = "on", data = false },
            {description = "yes", data = true }
        },
        default = true
    },
    {
        name = "giveluckamulet",
        label = "Start Luckamulet",
        hover = "A amulet at starting game",
        options = {
            {description = "no", data = false},
            {description = "yes", data = true}
        },
        default = false
    },
    {
        name = "fixtwoprice",
        label = "Fixed Price",
        hover = "Fixed price for staff and amulet",
        options = {
            {description = "No", data = false, hover = "The selling prices of the amulet and staff will change"},
            {description = "Yes", data = true, hover = "The selling prices of the amulet and staff will not change"}
        },
        default = true
    },
    {
        name = "recyclingprice1",
        label = "Common Price",
        hover = "Recycling price compares to selling price for common items",
        options = {
            {description = "Original Price", data = 1},
            {description = "Two Tenths", data = 2},
            {description = "Three Tenths", data = 3},
            {description = "Four Tenths", data = 4},
            {description = "Five Tenths", data = 5},
            {description = "Six Tenths", data = 6},
            {description = "Seven Tenths", data = 7},
            {description = "Eight Tenths", data = 8},
            {description = "Nine Tenths", data = 9},
            {description = "Ten Tenths", data = 10}
        },
        default = 4
    },
    {
        name = "recyclingprice2",
        label = "Precious Price",
        hover = "Recycling price compares to selling price for precious items",
        options = {
            {description = "Original Price", data = 1},
            {description = "Two Tenths", data = 2},
            {description = "Three Tenths", data = 3},
            {description = "Four Tenths", data = 4},
            {description = "Five Tenths", data = 5},
            {description = "Six Tenths", data = 6},
            {description = "Seven Tenths", data = 7},
            {description = "Eight Tenths", data = 8},
            {description = "Nine Tenths", data = 9},
            {description = "Ten Tenths", data = 10},
            {description = "Fifteen Tenths", data = 15},
            {description = "Twenty Tenths", data = 20}
        },
        default = 3
    },
    {
        name = "recovery_time", --//TODO: check removable
        label = "Nerf Recycling Same Item",
        hover = "The adjustment multiplier for recycling the same item over time.",
        options = {
            {description = "Off", data = false},
            {description = "30S", data = 30},
            {description = "60S", data = 60},
            {description = "120S", data = 120},
            {description = "180S", data = 180},
            {description = "240S", data = 240},
            {description = "300S", data = 300},
            {description = "480S", data = 480}
        },
        default = 120
    },
    {
        name = "recovery_t", --//TODO: check removable
        label = "The multiplier for recycling the same item again.",
        hover = "Counting stacked items as one item.",
        options = {
            {description = "0", data = 0},
            {description = "10%", data = 0.1},
            {description = "20%", data = 0.2},
            {description = "30%", data = 0.3},
            {description = "40%", data = 0.4},
            {description = "50%", data = 0.5},
            {description = "60%", data = 0.6},
            {description = "70%", data = 0.7},
            {description = "80%", data = 0.8},
            {description = "90%", data = 0.90},
            {description = "100%", data = 1.0}
        },
        default = 0.5
    },
    {
        name = "precious_sell",
        label = "All Precious Items",
        hover = "The precious items refresh every 3 days.",
        options = {
            {description = "SOME", data = false, hover = "The shop sells some precious items."},
            {description = "ALL", data = true, hover = "The shop sells all precious items."}
        },
        default = false
    },
    {
        name = "pricerate",
        label = "Shop Price",
        options = {
            {description = "free", data = 0},
            {description = "0.5 times", data = 0.5},
            {description = "1 times", data = 1},
            {description = "1.5 times", data = 1.5},
            {description = "2.0 times", data = 2.0},
            {description = "2.5 times", data = 2.5},
            {description = "3.0 times", data = 3.0},
            {description = "3.5 times", data = 3.5},
            {description = "4.0 times", data = 4.0},
            {description = "4.5 times", data = 4.5},
            {description = "5.0 times", data = 5.0},
            {description = "10.0 times", data = 10.0},
            {description = "20.0 times", data = 20.0},
            {description = "50.0 times", data = 50.0},
            {description = "100.0 times", data = 100.0}
        },
        default = 1
    },
    {
        name = "seasonalchange",
        label = "Seasonal Price",
        hover = "The price changes over seasons"
        options = {
            {description = "Yes", data = true},
            {description = "No", data = false}
        },
        default = true
    },
    {
        name = "exclusiveitem",
        label = "Unique Items",
        hover = "Is the unique item (e.g., pearls) for selling",
        options = {
            {description = "Yes", data = true},
            {description = "No", data = false}
        },
        default = true
    },
    {
        name = "allow_selist_special",
        label = "Special Items",
        hover = "Selling mod special items",
        options = {
            {description = "Yes", data = true},
            {description = "No", data = false}
        },
        default = true
    },
    {
        name = "creaturesdeath",
        label = "Creature Coins",
        hover = "Coins received depend on the target's max health."
        options = {
            {description = "None", data = false, hover = "Not receive coins by killing"},
            {description = "100%", data = 1.0, hover = "Coins = 100% max health"},
            {description = "75%", data = 0.75, hover = "Coins = 75% max health"},
            {description = "50%", data = 0.50, hover = "Coins = 50% max health"},
            {description = "25%", data = 0.25, hover = "Coins = 25% max health"},
            {description = "10%", data = 0.1, hover = "Coins = 10% max health"},
            {description = "5%", data = 0.05, hover = "Coins = 5% max health"},
            {description = "3%", data = 0.03, hover = "Coins = 3% max health"},
            {description = "1%", data = 0.01, hover = "Coins = 1% max health"},
        },
        default = 0.1
    },
    {
        name = "deathcd", --//TODO: check removable
        label = "Creature death coin multiplier adjustment timeframe.",
        hover = "Creature death coin multiplier adjustment timeframe.",
        options = {
            {description = "off", data = 0},
            {description = "10S", data = 10},
            {description = "30S", data = 30},
            {description = "50S", data = 50},
            {description = "60S", data = 60},
            {description = "120S", data = 120},
            {description = "180S", data = 180},
            {description = "240S", data = 240},
            {description = "300S", data = 300},
            {description = "480S", data = 480}
        },
        default = 120
    },
    {
        name = "coinrate", --//TODO: check removable
        label = "Coin multiplier during creature death",
        hover = "Coin multiplier during creature death",
        options = {
            {description = "0", data = 0},
            {description = "10%", data = 0.1},
            {description = "20%", data = 0.2},
            {description = "30%", data = 0.3},
            {description = "40%", data = 0.4},
            {description = "50%", data = 0.5},
            {description = "60%", data = 0.6},
            {description = "70%", data = 0.7},
            {description = "80%", data = 0.8},
            {description = "90%", data = 0.90},
            {description = "100%", data = 1.0}
        },
        default = 0.1
    },
    {
        name = "limitphmod",
        label = "Limit Creature",
        hover = "Limited creatures can drop coin, base on creature max health (≥).",
        options = {
            {description = "off", data = 0},
            {description = "100", data = 100},
            {description = "200", data = 200},
            {description = "300", data = 300},
            {description = "600", data = 600},
            {description = "900", data = 900},
            {description = "1000", data = 1000},
            {description = "3000", data = 3000},
            {description = "6000", data = 6000},
            {description = "10000", data = 10000}
        },
        default = 0
    },
    {
        name = "limitcoin",
        label = "Max Coin Kill",
        label = "Max gold coins per creature death.",
        options = {
            {description = "off", data = 0},
            {description = "100", data = 100},
            {description = "200", data = 200},
            {description = "300", data = 300},
            {description = "600", data = 600},
            {description = "900", data = 900},
            {description = "1000", data = 1000},
            {description = "3000", data = 3000},
            {description = "6000", data = 6000},
            {description = "10000", data = 10000}
        },
        default = 0
    },
    {
        name = "ghostshopping",
        label = "Ghostshopping",
        hover = "Allow shopping when you died"
        options = {
            {description = "no", data = true},
            {description = "yes", data = false}
        },
        default = true
    },
    {
        name = "Functionalswitch",
        label = "Add Medal Items",
        hover = "Manual toggle, doesn't matter if the mod is not enabled",
        options = {
            {description = "yes", data = true},
            {description = "no", data = false}
        },
        default = true
    },
    {
        name = "Functionalsell",
        label = "Does the store sell functional medal",
        hover = "Manual toggle, doesn't matter if the mod is not enabled",
        options = {
            {description = "yes", data = true},
            {description = "no", data = false}
        },
        default = false
    },
    {
        name = "Legionswitch",
        label = "Add Legion Items",
        hover = "Manual toggle, doesn't matter if the mod is not enabled",
        options = {
            {description = "yes", data = true},
            {description = "no", data = false}
        },
        default = true
    },
    {
        name = "Legionsell",
        label = "sell Legion unique items",
        hover = "Manual toggle, doesn't matter if the mod is not enabled",
        options = {
            {description = "yes", data = true},
            {description = "no", data = false}
        },
        default = true
    },
    {
        name = "ndnrswitch",
        label = "Add NoDangerNoRich Items",
        hover = "Manual toggle, doesn't matter if the mod is not enabled",
        options = {
            {description = "yes", data = true},
            {description = "no", data = false}
        },
        default = true
    },
    {
        name = "Island_switch",
        label = "Add Island Adventures Items",
        hover = "Manual toggle, doesn't matter if the mod is not enabled",
        options = {
            {description = "yes", data = true},
            {description = "no", data = false}
        },
        default = true
    },
    {
        name = "umswitch",
        label = "Enable Uncompromising Items",
        hover = "Manual toggle, doesn't matter if the mod is not enabled",
        options = {
            {description = "yes", data = true},
            {description = "no", data = false}
        },
        default = true
    },
    {
        name = "Dig",
        label = "Stealer Shovel",
        hover = "Use the stealer as a shovel",
        options = {
            {description = "No", data = false},
            {description = "Yes", data = true}
        },
        default = false
    },
    {
        name = "Hammer",
        label = "Stealer Hammer",
        hover = "Use the stealer as a hammer",
        options = {
            {description = "No", data = false},
            {description = "Yes", data = true}
        },
        default = false
    }
}
