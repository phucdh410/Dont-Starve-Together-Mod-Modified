local _G = GLOBAL
local FRAMES = _G.FRAMES
local TimeEvent = _G.TimeEvent
local EventHandler = _G.EventHandler
local EQUIPSLOTS = _G.EQUIPSLOTS
local ACTIONS = _G.ACTIONS
local IsServer = _G.TheNet:GetIsServer() or _G.TheNet:IsDedicated()

AddPrefabFiles(
    'xxx3_eyeplant_0',
    'xxx3_eyeplant_1',
    'xxx3_eyeplant_2',
    'xxx3_eyeplant_3',
    'xxx3_eyeplant_4',
    'xxx3_eyeplant_shadow',
    'xxx3_eyeplant_lunar',
    'xxx3_eyeplant_1_cloud',
    'xxx3_eyeplant_4_icespike'
)