local KEY_SWITCH = GLOBAL["KEY_" .. GetModConfigData("KEY_SWITCH")]
local CHIP_SLOT = GLOBAL.tonumber(GetModConfigData("CHIP_SLOT"))
local IS_ACTIVATION = not GetModConfigData("isActivation")
local strangeAttacks = GetModConfigData("strangeAttacks") 

Assets = {
    Asset("IMAGE", "images/icon-autoswitch-hide.tex"),
    Asset("IMAGE", "images/icon-autoswitch-hint.tex"),
    Asset("ATLAS", "images/icon-autoswitch-hide.xml"),
    Asset("ATLAS", "images/icon-autoswitch-hint.xml")
}

local WEAPON_LIST = {
    blowdart_fire = 8, 
    blowdart_sleep = 8, 
    blowdart_pipe = 8, 
    blowdart_yellow = 8, 
    blowdart_walrus = 8, 
    firestaff = 8, 
    icestaff = 8, 
    firepen = 8,
    houndstooth_blowpipe = 12, 
    staff_lunarplant = 8, 
    pocketwatch_weapon = TUNING.WHIP_RANGE, 
    whip = TUNING.WHIP_RANGE, 
    bullkelp_root = TUNING.BULLKELP_ROOT_RANGE, 
    voidcloth_boomerang = 10, 
    boomerang =12, 
    slingshot = 10, 
    bomb_lunarplant = 8, 
    danzhu_staff = 10,  
    forgedarts = 10, 
    moltendarts = 10, 
    livingstaff = 10, 
    infernalstaff = 10, 
}


local TOOL_LIST = {
    torch = GetModConfigData("torch"), 
    lantern = GetModConfigData("lantern"), 
    umbrella = GetModConfigData("umbrella"), 
    grass_umbrella = GetModConfigData("grass_umbrella"), 
    
    lighter = GetModConfigData("lighter"), 
    reskin_tool = GetModConfigData("reskin_tool"), 
    bugnet = GetModConfigData("bugnet"), 
    shovel = GetModConfigData("shovel"), 
    goldenshovel = GetModConfigData("goldenshovel"), 
    pitchfork = GetModConfigData("pitchfork"), 
    goldenpitchfork = GetModConfigData("goldenpitchfork"), 
    wateringcan = GetModConfigData("wateringcan"), 
    premiumwateringcan = GetModConfigData("premiumwateringcan"), 
    farm_hoe = GetModConfigData("farm_hoe"), 
    golden_farm_hoe = GetModConfigData("golden_farm_hoe"), 
    oar = GetModConfigData("oar"), 
    oar_driftwood = GetModConfigData("oar_driftwood"), 
    oar_monkey = GetModConfigData("oar_monkey"), 
    malbatross_beak = GetModConfigData("malbatross_beak"), 
    yotd_oar = GetModConfigData("yotd_oar"), 


    oceanfishingrod = GetModConfigData("oceanfishingrod"), 
    voidcloth_umbrella = GetModConfigData("voidcloth_umbrella"), 
    voidcloth_scythe = GetModConfigData("voidcloth_scythe"), 
    telestaff = GetModConfigData("telestaff"), 

    yellowstaff = GetModConfigData("stars_staff"), 
    opalstaff = GetModConfigData("stars_staff"), 
    firestaff = GetModConfigData("fires_ice_staff"), 
    icestaff = GetModConfigData("fires_ice_staff"), 
    boomerang = GetModConfigData("boomerang"), 
    spear_wathgrithr_lightning = GetModConfigData("spear_wathgrithr_lightning"), 
    nightstick = GetModConfigData("nightstick"), 
    blowdart_sleep = GetModConfigData("sleep_fire_yellow_blowdart"), 
    blowdart_fire = GetModConfigData("sleep_fire_yellow_blowdart"), 
    blowdart_yellow = GetModConfigData("sleep_fire_yellow_blowdart"), 
    trident = GetModConfigData("trident"), 
    staff_tornado = GetModConfigData("staff_tornado"), 

    moonglassaxe = GetModConfigData("moonglassaxe"), 
    multitool_axe_pickaxe = GetModConfigData("multitool_axe_pickaxe"), 
    staff_lunarplant = GetModConfigData("staff_lunarplant"), 
    houndstooth_blowpipe = GetModConfigData("houndstooth_blowpipe"), 
    bomb_lunarplant = GetModConfigData("bomb_lunarplant"), 
    shovel_lunarplant = GetModConfigData("shovel_lunarplant"), 
    pickaxe_lunarplant = GetModConfigData("pickaxe_lunarplant"), 
    minifan = GetModConfigData("minifan"), 
    balloon = GetModConfigData("balloon"), 
    balloonparty = GetModConfigData("balloonparty"), 
    balloonspeed = GetModConfigData("balloonspeed"), 
    winona_telebrella = GetModConfigData("winona_telebrella"), 

    
    
    forgedarts = GetModConfigData("forgedarts"), 
    moltendarts = GetModConfigData("moltendarts"), 
    livingstaff = GetModConfigData("livingstaff"), 
    infernalstaff = GetModConfigData("infernalstaff"), 

}


AddPrefabPostInit("player_classified", function(inst)
    inst:DoTaskInTime(0.5, function(inst)
        if GLOBAL.ThePlayer then
            GLOBAL.ThePlayer:AddComponent("autoswitch")
            GLOBAL.ThePlayer.components.autoswitch:SetchipSlot(CHIP_SLOT)
            GLOBAL.ThePlayer.components.autoswitch:SetWeaponList(WEAPON_LIST)
            GLOBAL.ThePlayer.components.autoswitch:SetToollList(TOOL_LIST)
            GLOBAL.ThePlayer.components.autoswitch:IsAutoActivation(IS_ACTIVATION)
            GLOBAL.ThePlayer.components.autoswitch:IsStrangeAttacks(strangeAttacks)
            GLOBAL.ThePlayer.components.autoswitch:SwitchSpinning()
        end
    end)
end)

GLOBAL.TheInput:AddKeyUpHandler(KEY_SWITCH, function()
    if GLOBAL.TheWorld and GLOBAL.ThePlayer and
            GLOBAL.ThePlayer.components.autoswitch then
        GLOBAL.ThePlayer.components.autoswitch:SwitchSpinning()
    end
end)
