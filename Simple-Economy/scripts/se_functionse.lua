AddPlayerPostInit(
    function(inst)
        inst.seccoin = GLOBAL.net_int(inst.GUID, "seccoin")
        inst.secexp = GLOBAL.net_int(inst.GUID, "secexp")
        inst.seclevel = GLOBAL.net_shortint(inst.GUID, "seclevel")
        inst.secvip = GLOBAL.net_shortint(inst.GUID, "secvip")
        inst.secprecious = GLOBAL.net_bytearray(inst.GUID, "secprecious")
        inst.secpreciouschange = GLOBAL.net_bool(inst.GUID, "secpreciouschange")
        inst.secsoundm = GLOBAL.net_bool(inst.GUID, "secsoundm", "secsoundm")
        if not GLOBAL.TheNet:GetIsClient() then
            inst:AddComponent("seplayerstatus")
            inst.components.seplayerstatus:Init(inst)
        end
    end
)

AddPrefabPostInit(
    "forest",
    function(inst)
        GLOBAL.TheWorld:AddComponent("seworldstatus")
    end
)
AddPrefabPostInit(
    "cave",
    function(inst)
        GLOBAL.TheWorld:AddComponent("seworldstatus")
    end
)

local function ScaleUI(self, screensize)
    local hudscale = self.top_root:GetScale()
    self.uiseconomy:SetScale(.75 * hudscale.x, .75 * hudscale.y, 1)
end

local uiseconomy = require("widgets/uiseconomy")
local function Adduiseconomy(self)
    self.uiseconomy = self.top_root:AddChild(uiseconomy(self.owner))
    local screensize = {GLOBAL.TheSim:GetScreenSize()}
    ScaleUI(self, screensize)
    self.uiseconomy:SetHAnchor(0)
    self.uiseconomy:SetVAnchor(0)
    self.uiseconomy:MoveToFront()
    local OnUpdate_base = self.OnUpdate
    self.OnUpdate = function(self, dt)
        OnUpdate_base(self, dt)
        local curscreensize = {GLOBAL.TheSim:GetScreenSize()}
        if curscreensize[1] ~= screensize[1] or curscreensize[2] ~= screensize[2] then
            ScaleUI(self)
            screensize = curscreensize
        end
    end
end

AddClassPostConstruct("widgets/controls", Adduiseconomy)

local function CheckMod(name)
    for k, v in pairs(GLOBAL.ModManager.mods) do
        if v.modinfo.name == name then
            return true
        end
    end
    return false
end

TUNING.autoLegion = CheckMod("[DST] Legion") or CheckMod("[DST] 棱镜")
TUNING.UNCOMPROMISING_MODE = CheckMod("󰀕 Uncompromising Mode")
TUNING.Island_Adventures_se = CheckMod("Island Adventures - Shipwrecked") or CheckMod("岛屿冒险")

local creaturesdeath = GetModConfigData("creaturesdeath")
local limitphmod = GetModConfigData("limitphmod")
local limitcoin = GetModConfigData("limitcoin")

if creaturesdeath then
    local function ShouldReward(inst)
        return not inst:HasTag("wall") and inst:IsValid() and inst.components.lootdropper and inst.components.health and
            not inst.components.health.invincible and
            inst.components.combat and
            inst.components.combat.target and
            inst.components.combat.defaultdamage > 0
    end
    local function RewardPlayers(inst)
        local mob_namesd = inst.prefab
        local mobPosition = inst:GetPosition()
        local bounty = math.floor(inst.components.health.maxhealth * creaturesdeath)
        if bounty > 0 then
            for k, player in pairs(
                GLOBAL.FindPlayersInRange(
                    mobPosition.x,
                    mobPosition.y,
                    mobPosition.z,
                    GLOBAL.TUNING.BOOMERANG_DISTANCE * 2,
                    true
                )
            ) do
                local item = inst.components.lootdropper:SpawnLootPrefab("secoin")
                item.components.secoin.amount = bounty

                if item.components.secoin.amount > limitcoin and limitcoin ~= 0 then
                    item.components.secoin.amount = limitcoin
                end

                item.components.secoin.amount = math.ceil(item.components.secoin.amount)
                if item.components.secoin.amount > 0 then
                    player:DoTaskInTime(
                        .3,
                        function()
                            player.components.seplayerstatus:givesecoin(item)
                        end
                    )
                end
            end
        end
    end
    AddPrefabPostInitAny(
        function(inst)
            inst:ListenForEvent(
                "death",
                function()
                    if ShouldReward(inst) then
                        RewardPlayers(inst)
                    end
                end
            )
        end
    )
end

AddPlayerPostInit(
    function(inst)
        local Old_SaveFn = inst.OnSave
        local Old_LoadFn = inst.OnLoad

        inst.OnSave = function(inst, data)
            if inst.components.seplayerstatus then
                data.seplayerstatus = {
                    coin = inst.components.seplayerstatus.coin,
                    exp = inst.components.seplayerstatus.exp,
                    level = inst.components.seplayerstatus.level,
                    vip = inst.components.seplayerstatus.vip,
                    discount = inst.components.seplayerstatus.discount,
                    slist = inst.components.seplayerstatus.slist,
                    precious = inst.components.seplayerstatus.precious,
                    alreadyspawn = inst.components.seplayerstatus.alreadyspawn,
                    presciouschange = inst.components.seplayerstatus.presciouschange,
                    soundm = inst.components.seplayerstatus.soundm,
                    day = inst.components.seplayerstatus.day
                }
            end
            if Old_SaveFn then
                Old_SaveFn(inst, data)
            end
        end

        inst.OnLoad = function(inst, data)
            if data.seplayerstatus and next(data.seplayerstatus) and inst.components.seplayerstatus then
                local status = inst.components.seplayerstatus
                local source = data.seplayerstatus

                if source.coin then
                    status.coin = source.coin
                end
                if source.exp then
                    status.exp = source.exp
                end
                if source.level then
                    status.level = source.level
                end
                if source.vip then
                    status.vip = source.vip
                end
                if source.discount then
                    status.discount = source.discount
                end
                if source.slist then
                    status.slist = source.slist
                end
                if source.precious then
                    status.precious = source.precious
                end
                if source.alreadyspawn then
                    status.alreadyspawn = source.alreadyspawn
                end
                if source.presciouschange then
                    status.presciouschange = source.presciouschange
                end
                if source.soundm then
                    status.soundm = source.soundm
                end
                if source.day then
                    status.day = source.day
                end
            end

            if Old_LoadFn then
                Old_LoadFn(inst, data)
            end
        end

        local Old_SaveForReroll = inst.SaveForReroll
        inst.SaveForReroll = function(inst)
            local data = Old_SaveForReroll(inst)
            if data then
                data.seplayerstatus = {
                    coin = inst.components.seplayerstatus.coin,
                    exp = inst.components.seplayerstatus.exp,
                    level = inst.components.seplayerstatus.level,
                    vip = inst.components.seplayerstatus.vip,
                    discount = inst.components.seplayerstatus.discount,
                    slist = inst.components.seplayerstatus.slist,
                    precious = inst.components.seplayerstatus.precious,
                    alreadyspawn = inst.components.seplayerstatus.alreadyspawn,
                    presciouschange = inst.components.seplayerstatus.presciouschange,
                    soundm = inst.components.seplayerstatus.soundm,
                    day = inst.components.seplayerstatus.day
                }
            end
            return data
        end
        local Old_LoadForReroll = inst.LoadForReroll
        inst.LoadForReroll = function(inst, data)
            if data.seplayerstatus and next(data.seplayerstatus) and inst.components.seplayerstatus then
                local status = inst.components.seplayerstatus
                local source = data.seplayerstatus

                if source.coin then
                    status.coin = source.coin
                end
                if source.exp then
                    status.exp = source.exp
                end
                if source.level then
                    status.level = source.level
                end
                if source.vip then
                    status.vip = source.vip
                end
                if source.discount then
                    status.discount = source.discount
                end
                if source.slist then
                    status.slist = source.slist
                end
                if source.precious then
                    status.precious = source.precious
                end
                if source.alreadyspawn then
                    status.alreadyspawn = source.alreadyspawn
                end
                if source.presciouschange then
                    status.presciouschange = source.presciouschange
                end
                if source.soundm then
                    status.soundm = source.soundm
                end
                if source.day then
                    status.day = source.day
                end
            end
            if Old_LoadForReroll then
                Old_LoadForReroll(inst, data)
            end
        end
    end
)
