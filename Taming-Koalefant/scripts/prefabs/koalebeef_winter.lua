local fns = {}
fns.RemoveName = function(inst)
    inst.components.writeable:SetText(nil)

    inst.components.named:SetName(nil)
end
fns.ClearBellOwner = function(inst)
    if inst._marked_for_despawn then
        return
    end

    fns.RemoveName(inst)

    local bell_leader = inst.components.follower:GetLeader()
    inst:RemoveEventCallback("onremove", inst._BellRemoveCallback, bell_leader)

    inst.components.follower:SetLeader(nil)
    inst.components.rideable:SetShouldSave(true)

    inst.persists = true

    inst:UpdateDomestication()
end

fns.GetBeefBellOwner = function(inst)
    local leader = inst.components.follower:GetLeader()
    return (leader ~= nil
        and leader.components.inventoryitem ~= nil
        and leader.components.inventoryitem:GetGrandOwner())
        or nil
end

fns.SetBeefBellOwner = function(inst, bell, bell_user)
    if inst.components.follower:GetLeader() == nil
            and bell ~= nil and bell.components.leader ~= nil then
        bell.components.leader:AddFollower(inst)
        inst.components.rideable:SetShouldSave(false)

        inst:ListenForEvent("onremove", inst._BellRemoveCallback, bell)

        inst.persists = false
        inst:UpdateDomestication()
        inst.components.knownlocations:ForgetLocation("herd")

        if bell_user ~= nil then
            inst.components.writeable:BeginWriting(bell_user)
        end

        return true
    else
        return false, "ALREADY_USED"
    end
end

fns.OnNamedByWriteable = function(inst, new_name, writer)
    if inst.components.named ~= nil then
        inst.components.named:SetName(new_name, writer ~= nil and writer.userid or nil)
    end
end

fns.OnWritingEnded = function(inst)
    if not inst.components.writeable:IsWritten() then
        local leader = inst.components.follower:GetLeader()
        if leader ~= nil and leader.components.inventoryitem ~= nil then
            inst.components.follower:SetLeader(nil)
        end
    end
end

local TWEEN_TARGET = {0, 0, 0, 1}
local TWEEN_TIME = 13 * FRAMES
fns.OnDespawnRequest = function(inst)
    local fx = SpawnPrefab("spawn_fx_medium")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    inst._marked_for_despawn = true
    inst.components.colourtweener:StartTween(TWEEN_TARGET, TWEEN_TIME, inst.Remove)
end


local function getbasebuild(inst)
    return (inst:HasTag("baby") and "beefalo_baby_build")
            or (not inst:HasTag("has_beard") and "beefalo_shaved_build")
            or (inst:HasTag("domesticated") and "koalebeef_summer_domesticated")
            or "koalebeef_summer_build"
end
local function dobeefalounhitch(inst)
    if inst.components.hitchable and not inst.components.hitchable.canbehitched then
        inst.components.hitchable:Unhitch()
    end
end

local function OnHitchTo(inst, data)
end

local function OnUnhitch(inst, data)
end
local function GetBaseSkin(inst)
    return inst.tendency and tendencies[inst.tendency].build or getbasebuild(inst)
end
local function onclothingchanged(inst,data)
    if data and data.type then
        inst.skins[data.type]:set(data.name)
    end
end

function fns.GetMoodComponent(inst)
    local herd = inst.components.herdmember and inst.components.herdmember:GetHerd()
    if herd then
        return herd.components.mood
    end
end

function fns.GetIsInMood(inst)
    local mood = fns.GetMoodComponent(inst)
    return mood and mood:IsInMood() or false
end

fns.testforskins = function(inst)
    if inst.components.skinner_beefalo and inst.components.skinner_beefalo.clothing then
        if inst.components.skinner_beefalo.clothing.beef_body ~= "" or
            inst.components.skinner_beefalo.clothing.beef_head ~= "" or
            inst.components.skinner_beefalo.clothing.beef_tail ~= "" or
            inst.components.skinner_beefalo.clothing.beef_horn ~= "" or
            inst.components.skinner_beefalo.clothing.beef_feet ~= "" then
            return true
        end
    end
    return false
end

fns.UnSkin = function(inst)
    if inst.components.skinner_beefalo then
        if inst.components.sleeper:IsAsleep() then

            if fns.testforskins(inst) then
                local fx = SpawnPrefab("explode_reskin")
                fx.Transform:SetScale(2,2,2)
                fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
            end

            inst.components.skinner_beefalo:ClearAllClothing()
        else
            if fns.testforskins(inst) then
                inst.sg:GoToState("skin_change", function()
                    inst.components.skinner_beefalo:ClearAllClothing()
                end)
            end
        end
    end
end

local assets =
{
    Asset("ANIM", "anim/beefalo_basic.zip"),
    Asset("ANIM", "anim/beefalo_actions.zip"),
    Asset("ANIM", "anim/beefalo_actions_domestic.zip"),
    Asset("ANIM", "anim/beefalo_actions_quirky.zip"),
    Asset("ANIM", "anim/koalebeef_winter_build.zip"),
 --   Asset("ANIM", "anim/beefalo_shaved_build.zip"),
--    Asset("ANIM", "anim/beefalo_baby_build.zip"),

    Asset("ANIM", "anim/koalebeef_winter_domesticated.zip"),
    Asset("ANIM", "anim/koalebeef_winter_rider.zip"),
    Asset("ANIM", "anim/koalebeef_winter_ornery.zip"),
    Asset("ANIM", "anim/koalebeef_winter_pudgy.zip"),

    Asset("ANIM", "anim/beefalo_fx.zip"),

    Asset("SOUND", "sound/koalefant.fsb"),
	Asset("SOUNDPACKAGE", "sound/koalebeef.fev"),
    Asset("SOUND", "sound/koalebeef.fsb"),
}

local prefabs =
{
    "meat",
    "poop",
    "trunk_winter",
 "spoiled_food",
 "koalefant_winter",
}

local brain = require("brains/koale_beefbrain")

SetSharedLootTable( 'koalebeef_winter',
{
    {'meat',            1.00},
    {'meat',            1.00},
    {'meat',            1.00},
    {'meat',            1.00},
    {'meat',            1.00},
    {'meat',            1.00},
    {'meat',            1.00},
    {'meat',            1.00},
	{'trunk_winter',            1.00},
})

local sounds = 
{
    walk = "dontstarve/creatures/beefalo_baby/walk",
    grunt = "dontstarve/creatures/koalefant/grunt",
    yell = "dontstarve/creatures/koalefant/yell",
    swish = "dontstarve/beefalo/tail_swish",
    curious = "dontstarve/creatures/koalefant/alert",
    angry = "dontstarve/creatures/koalefant/angry",
    sleep = "dontstarve/creatures/koalefant/grunt",
}

local tendencies =
{
    DEFAULT =
    {
	--build= "koalebeef_winter_build",
    },

    ORNERY =
    {
        build = "koalebeef_winter_ornery",
    },

    RIDER =
    {
        build = "koalebeef_winter_rider",
    },

    PUDGY =
    {
        build = "koalebeef_winter_pudgy",
        customactivatefn = function(inst)
            inst:AddComponent("sanityaura")
            inst.components.sanityaura.aura = TUNING.SANITYAURA_TINY*4
        end,
        customdeactivatefn = function(inst)
            inst:RemoveComponent("sanityaura")
        end,
    },
}

local function ClearBuildOverrides(inst, animstate)
    if animstate ~= inst.AnimState then
        animstate:ClearOverrideBuild("koalebeef_winter_build")
    end
    -- this presumes that all the face builds have the same symbols
    animstate:ClearOverrideBuild("koalebeef_winter_rider")
end

-- This takes an anim state so that it can apply to itself, or to its rider
local function ApplyBuildOverrides(inst, animstate)
    local herd = inst.components.herdmember and inst.components.herdmember:GetHerd()
    local basebuild = --(inst:HasTag("baby") and "beefalo_baby_build")or 
	--        (inst.components.beard.bits == 0 and "beefalo_shaved_build")
  --           (inst.components.domesticatable:IsDomesticated() and "koalebeef_winter_domesticated")
             "koalebeef_winter_build"
    if animstate ~= nil and animstate ~= inst.AnimState then
        animstate:AddOverrideBuild(basebuild)
    else
        animstate:SetBuild(basebuild)
    end

    if (herd and herd.components.mood and herd.components.mood:IsInMood())
        or (inst.components.mood and inst.components.mood:IsInMood()) then
        animstate:Show("HEAT")
    else
        animstate:Hide("HEAT")
    end

    if tendencies[inst.tendency].build ~= nil then
        animstate:AddOverrideBuild(tendencies[inst.tendency].build)
    elseif animstate == inst.AnimState then
        -- this presumes that all the face builds have the same symbols
        animstate:ClearOverrideBuild("koalebeef_winter_rider")
    end
	if inst.components.domesticatable:IsDomesticated() then
	animstate:AddOverrideBuild("koalebeef_winter_domesticated")
    end	
end

local function OnEnterMood(inst)
    inst:AddTag("scarytoprey")
    inst:ApplyBuildOverrides(inst.AnimState)
    if inst.components.rideable and inst.components.rideable:GetRider() ~= nil then
        inst:ApplyBuildOverrides(inst.components.rideable:GetRider().AnimState)
    end
end

local function OnLeaveMood(inst)
    inst:RemoveTag("scarytoprey")
    inst:ApplyBuildOverrides(inst.AnimState)
    if inst.components.rideable ~= nil and inst.components.rideable:GetRider() ~= nil then
        inst:ApplyBuildOverrides(inst.components.rideable:GetRider().AnimState)
    end
end

local function Retarget(inst)
    local herd = inst.components.herdmember ~= nil and inst.components.herdmember:GetHerd() or nil
    return herd ~= nil
        and herd.components.mood ~= nil
        and herd.components.mood:IsInMood()
        and FindEntity(
                inst,
                TUNING.BEEFALO_TARGET_DIST,
                function(guy)
                    return inst.components.combat:CanTarget(guy)
                        and (guy.components.rider == nil
                            or guy.components.rider:GetMount() == nil
                            or not guy.components.rider:GetMount():HasTag("koalefant"))
                end,
                { "_combat" }, --See entityreplica.lua (re: "_combat" tag)
                { "koalefant", "wall", "INLIMBO" }
            )
        or nil
end

local function KeepTarget(inst, target)
    local herd = inst.components.herdmember ~= nil and inst.components.herdmember:GetHerd() or nil
    return herd == nil
        or herd.components.mood == nil
        or not herd.components.mood:IsInMood()
        or inst:IsNear(herd, TUNING.BEEFALO_CHASE_DIST)
end

local function OnNewTarget(inst, data)
    if data ~= nil and data.target ~= nil and inst.components.follower ~= nil and data.target == inst.components.follower.leader then
        inst.components.follower:SetLeader(nil)
    end
end

local function CanShareTarget(dude)
    return dude:HasTag("koalefant")
        and not dude:IsInLimbo()
        and not (dude.components.health:IsDead() or dude:HasTag("player"))
end

local function OnAttacked(inst, data)
    if inst._ridersleeptask ~= nil then
        inst._ridersleeptask:Cancel()
        inst._ridersleeptask = nil
    end
    inst._ridersleep = nil
    if inst.components.rideable:IsBeingRidden() then
        if not inst.components.domesticatable:IsDomesticated() or not inst.tendency == TENDENCY.ORNERY then
            inst.components.domesticatable:DeltaDomestication(TUNING.BEEFALO_DOMESTICATION_ATTACKED_DOMESTICATION)
            inst.components.domesticatable:DeltaObedience(TUNING.BEEFALO_DOMESTICATION_ATTACKED_OBEDIENCE)
        end
        inst.components.domesticatable:DeltaTendency(TENDENCY.ORNERY, TUNING.BEEFALO_ORNERY_ATTACKED)
    else
        if data.attacker ~= nil and data.attacker:HasTag("player") then
            inst.components.domesticatable:DeltaDomestication(TUNING.BEEFALO_DOMESTICATION_ATTACKED_BY_PLAYER_DOMESTICATION)
            inst.components.domesticatable:DeltaObedience(TUNING.BEEFALO_DOMESTICATION_ATTACKED_BY_PLAYER_OBEDIENCE)
        end
        inst.components.combat:SetTarget(data.attacker)
        inst.components.combat:ShareTarget(data.attacker, 30, CanShareTarget, 5)
    end
end

local function GetStatus(inst, viewer)
    local leader = inst.components.follower:GetLeader()
    if leader ~= nil then
        return (leader.components.inventoryitem ~= nil
                and leader.components.inventoryitem:GetGrandOwner() == viewer
                and "MYPARTNER")
                or "FOLLOWER"
    else
        return (inst.components.beard ~= nil and inst.components.beard.bits == 0 and "NAKED")
            or (inst.components.domesticatable ~= nil and
                inst.components.domesticatable:IsDomesticated() and
                (inst.tendency == TENDENCY.DEFAULT and "DOMESTICATED" or inst.tendency))
            or nil
    end
end

local function getDescription(inst,viewer) 
    local desc = ""
	local owner = viewer
	local leader = inst.components.follower:GetLeader()
	if inst.components.domesticatable and inst.components.domesticatable.near_death then -- Prioritize checking near-death state
        if owner.prefab == "willow" then
            desc = "Her fire of life is about to go out. Use a booster shot to reignite it!"
        elseif owner.prefab == "wolfgang" then
            desc = "The little elephant is barely hanging on! Wolfgang must use a booster shot!"
        elseif owner.prefab == "wendy" then
            desc = "She's about to find true release, but I can drag her back with a booster shot."
        elseif owner.prefab == "wx78" then
            desc = "Life signs critical. Reboot with booster shot."
        elseif owner.prefab == "wickerbottom" then
            desc = "Hold on, dear, the booster shot is coming!"
        elseif owner.prefab == "woodie" then
            desc = "Oh Lucy, we need to give it a booster shot, quick!"
        elseif owner.prefab == "waxwell" then
            desc = "Pathetic. You're too fragile. Bring the booster shot!"
        elseif owner.prefab == "wathgrithr" then
            desc = "A Viking never abandons a comrade! I shall find the booster shot!"
        elseif owner.prefab == "webber" then
            desc = "Sorry! We didn’t mean to hurt you that badly! Let’s go get a booster shot!"
        elseif owner.prefab == "winona" then
            desc = "This koalefant won’t last much longer. I need to craft a booster shot..."
        elseif owner.prefab == "warly" then
            desc = "You're not dinner, koalefant. The booster shot will save you."
        elseif owner.prefab == "wortox" then
            desc = "Eh? You died? Where’s the booster shot, quick!"
        elseif owner.prefab == "wormwood" then
            desc = "Fleshy ball friend needs the red spiky tube thing!"
        elseif owner.prefab == "wurt" then
            desc = "Glurgh glurgh, Miss Wicker says it needs that spiky shot-thing now!"
        elseif owner.prefab == "walter" then
            desc = "Woby, fetch the booster shot! We can’t let her die!"
        elseif owner.prefab == "wanda" then
            desc = "I’m not giving my second-chance watch to a koalefant. Where’s the booster shot?"
        else
            desc = "This koalefant is near death and needs a booster shot to survive."
        end
    
    elseif leader and leader.components.inventoryitem and leader.components.inventoryitem:GetGrandOwner() == owner then 
        if owner.prefab == "willow" then
            desc = STRINGS.CHARACTERS.WILLOW.DESCRIBE.BEEFALO.FOLLOWER
        elseif owner.prefab == "wolfgang" then
            desc = "The little elephant is following me!"
        elseif owner.prefab == "wendy" then
            desc = STRINGS.CHARACTERS.WENDY.DESCRIBE.BEEFALO.FOLLOWER
        elseif owner.prefab == "wx78" then
            desc = STRINGS.CHARACTERS.WX78.DESCRIBE.BEEFALO.FOLLOWER
        elseif owner.prefab == "wickerbottom" then
            desc = STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.BEEFALO.FOLLOWER
        elseif owner.prefab == "woodie" then
            desc = STRINGS.CHARACTERS.WOODIE.DESCRIBE.BEEFALO.FOLLOWER
        elseif owner.prefab == "waxwell" then
            desc = STRINGS.CHARACTERS.WAXWELL.DESCRIBE.BEEFALO.FOLLOWER
        elseif owner.prefab == "wathgrithr" then
            desc = STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.BEEFALO.FOLLOWER
        elseif owner.prefab == "webber" then
            desc = STRINGS.CHARACTERS.WEBBER.DESCRIBE.BEEFALO.FOLLOWER
        elseif owner.prefab == "winona" then
            desc = STRINGS.CHARACTERS.WINONA.DESCRIBE.BEEFALO.FOLLOWER
        elseif owner.prefab == "warly" then
            desc = STRINGS.CHARACTERS.WARLY.DESCRIBE.BEEFALO.FOLLOWER
        elseif owner.prefab == "wortox" then
            desc = STRINGS.CHARACTERS.WORTOX.DESCRIBE.BEEFALO.FOLLOWER
        elseif owner.prefab == "wormwood" then
            desc = STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.BEEFALO.FOLLOWER
        elseif owner.prefab == "wurt" then
            desc = STRINGS.CHARACTERS.WURT.DESCRIBE.BEEFALO.FOLLOWER
        elseif owner.prefab == "walter" then
            desc = STRINGS.CHARACTERS.WALTER.DESCRIBE.BEEFALO.FOLLOWER
        elseif owner.prefab == "wanda" then
            desc = STRINGS.CHARACTERS.WANDA.DESCRIBE.BEEFALO.FOLLOWER
        else
            desc = STRINGS.CHARACTERS.GENERIC.DESCRIBE.BEEFALO.FOLLOWER
        end
    
    elseif inst.components.domesticatable and inst.components.domesticatable:IsDomesticated() then
        if owner.prefab == "willow" then
            desc = "I see fire in its eyes!"
        elseif owner.prefab == "wolfgang" then
            desc = "Wolfgang and the little elephant get along!"
        elseif owner.prefab == "wendy" then
            desc = "Its wildness is gone."
        elseif owner.prefab == "wx78" then
            desc = "Domestication complete."
        elseif owner.prefab == "wickerbottom" then
            desc = "A domesticated koalefant is a fine assistant."
        elseif owner.prefab == "woodie" then
            desc = "You don’t look so wild now, eh bud?"
        elseif owner.prefab == "waxwell" then
            desc = "It’s quite obedient now."
        elseif owner.prefab == "wathgrithr" then
            desc = "A noble war beast for a noble warrior!"
        elseif owner.prefab == "webber" then
            desc = "We're friends with the koalefant now!"
        elseif owner.prefab == "winona" then
            desc = "Alright, time to get to work!"
        elseif owner.prefab == "warly" then
            desc = "You're worth keeping off the dinner table."
        elseif owner.prefab == "wortox" then
            desc = "Fun!"
        elseif owner.prefab == "wormwood" then
            desc = "Fleshy ball friend is a good friend."
        elseif owner.prefab == "wurt" then
            desc = "Glurp! Squishy meaty friend!"
        elseif owner.prefab == "walter" then
            desc = "You're friends with Woby now!"
        elseif owner.prefab == "wanda" then
            desc = "Let’s hope you’re worth the time I spent."
        else
            desc = "Science tamed the wild in it!"
        end
    
    else
        if owner.prefab == "willow" then
            desc = "Haha, you’re not afraid of me just because I fed you?"
        elseif owner.prefab == "wolfgang" then
            desc = "Wolfgang and the little elephant are friends!"
        elseif owner.prefab == "wendy" then
            desc = "It was too easy to gain this creature’s trust. How foolish."
        elseif owner.prefab == "wx78" then
            desc = "Organic trust is so cheap."
        elseif owner.prefab == "wickerbottom" then
            desc = "Feeding is an effective way to earn a koalefant’s trust."
        elseif owner.prefab == "woodie" then
            desc = "I feed you, you haul my logs. Fair trade, pal."
        elseif owner.prefab == "waxwell" then
            desc = "I don’t recall allowing them to act like this..."
        elseif owner.prefab == "wathgrithr" then
            desc = "Would you be my mighty war elephant?"
        elseif owner.prefab == "webber" then
            desc = "We’re getting along with the koalefant now!"
        elseif owner.prefab == "winona" then
            desc = "Ha! One bite and you’re already bought!"
        elseif owner.prefab == "warly" then
            desc = "You’re safe from the plate... for now."
        elseif owner.prefab == "wortox" then
            desc = "Softer than a beefalo!"
        elseif owner.prefab == "wormwood" then
            desc = "Fleshy ball friend is less scared now."
        elseif owner.prefab == "wurt" then
            desc = "Glurp! Not scared of me anymore!"
        elseif owner.prefab == "walter" then
            desc = "Woby, we might have a new friend!"
        elseif owner.prefab == "wanda" then
            desc = "How are you better than a beefalo, really?"
        else
            desc = "This big elephant has started to trust me. It’s not afraid anymore."
        end
    end
    
	return desc 
end  

local function OnResetBeard(inst)
    inst.sg:GoToState("shaved")
    inst.components.brushable:SetBrushable(false)
    inst.components.domesticatable:DeltaObedience(TUNING.BEEFALO_DOMESTICATION_SHAVED_OBEDIENCE)
end

local function CanShaveTest(inst)
    if inst.components.sleeper:IsAsleep() then
        return true
    else
        return false, "AWAKEBEEFALO"
    end
end

local function OnShaved(inst)
    inst:ApplyBuildOverrides(inst.AnimState)
end

local function OnHairGrowth(inst)
    if inst.components.beard.bits == 0 then
        inst.hairGrowthPending = true
        if inst.components.rideable ~= nil then
            inst.components.rideable:Buck()
        end
    end
end

local function OnBrushed(inst, doer, numprizes)
    if numprizes > 0 and inst.components.domesticatable ~= nil then
        inst.components.domesticatable:DeltaDomestication(TUNING.BEEFALO_DOMESTICATION_BRUSHED_DOMESTICATION)
        inst.components.domesticatable:DeltaObedience(TUNING.BEEFALO_DOMESTICATION_BRUSHED_OBEDIENCE)
    end
end

local function ShouldAcceptItem(inst, item)
    return inst.components.eater:CanEat(item)
        and not inst.components.combat:HasTarget()
end

local function OnGetItemFromPlayer(inst, giver, item)
    if inst.components.eater:CanEat(item) then
        inst.components.eater:Eat(item, giver)
    end
end

local function OnRefuseItem(inst, item)
    inst.sg:GoToState("refuse")
    if inst.components.sleeper:IsAsleep() then
        inst.components.sleeper:WakeUp()
    end
end

local function OnDomesticated(inst, data)
    inst.components.rideable:Buck()
    inst.domesticationPending = true
end

local function DoDomestication(inst)
    --inst.components.herdmember:Enable(false)
    --inst.components.mood:Enable(true)
    --inst.components.mood:ValidateMood()

    inst:SetTendency("domestication")
end

local function Koalify(inst)
    if inst.components.health and not inst.components.health:IsDead() then --不能是死了的
    local grown = SpawnPrefab("koalefant_winter")
    grown.Transform:SetPosition(inst.Transform:GetWorldPosition() )
    grown.Transform:SetRotation(inst.Transform:GetRotation() )
	inst:Remove()
	end
end

local function DoFeral(inst)
--inst.components.rideable:SetSaddle(nil, nil)
if inst.components.rideable and inst.components.rideable:IsSaddled() then
    inst.sg:GoToState("shake_off_saddle")
	inst.components.rideable:SetSaddle(nil, nil)
	inst:DoTaskInTime(25*FRAMES,Koalify)
	else
	inst:DoTaskInTime(0,Koalify)
	end
    -- local grown = SpawnPrefab("koalefant_winter")
    -- grown.Transform:SetPosition(inst.Transform:GetWorldPosition() )
    -- grown.Transform:SetRotation(inst.Transform:GetRotation() )
    --inst:Remove()
end

local function OnFeral(inst, data)
    inst.components.rideable:Buck()
    if inst.components.domesticatable:IsDomesticated() then
        inst.domesticationPending = true
    end
	DoFeral(inst)
end

local function UpdateDomestication(inst)
    if inst.components.domesticatable:IsDomesticated() then
        DoDomestication(inst)
    else
       -- DoFeral(inst)
    end
end

local function SetTendency(inst, changedomestication)
    -- tendency is locked in after we become domesticated
    local tendencychanged = false
    local oldtendency = inst.tendency
    if not inst.components.domesticatable:IsDomesticated() then
        local tendencysum = 0
        local maxtendency = nil
        local maxtendencyval = 0
        for k, v in pairs(inst.components.domesticatable.tendencies) do
            tendencysum = tendencysum + v
            if v > maxtendencyval then
                maxtendencyval = v
                maxtendency = k
            end
        end
        inst.tendency = (tendencysum < .1 or maxtendencyval * 2 < tendencysum) and TENDENCY.DEFAULT or maxtendency
        tendencychanged = inst.tendency ~= oldtendency
    end

    if changedomestication == "domestication" then
        if tendencies[inst.tendency].customactivatefn ~= nil then
            tendencies[inst.tendency].customactivatefn(inst)
        end
    elseif changedomestication == "feral"
        and tendencies[oldtendency].customdeactivatefn ~= nil then
        tendencies[oldtendency].customdeactivatefn(inst)
    end

    if tendencychanged or changedomestication ~= nil then
        if inst.components.domesticatable:IsDomesticated() then
            inst.components.domesticatable:SetMinObedience(TUNING.BEEFALO_MIN_DOMESTICATED_OBEDIENCE[inst.tendency])

            inst.components.combat:SetDefaultDamage(TUNING.BEEFALO_DAMAGE[inst.tendency]+16)
            inst.components.locomotor.runspeed = TUNING.BEEFALO_RUN_SPEED[inst.tendency]*0.9
        else
            inst.components.domesticatable:SetMinObedience(0)

            inst.components.combat:SetDefaultDamage(TUNING.BEEFALO_DAMAGE.DEFAULT+16)
            inst.components.locomotor.runspeed = TUNING.BEEFALO_RUN_SPEED.DEFAULT*0.9
        end

        inst:ApplyBuildOverrides(inst.AnimState)
        if inst.components.rideable and inst.components.rideable:GetRider() ~= nil then
            inst:ApplyBuildOverrides(inst.components.rideable:GetRider().AnimState)
        end
    end
end

local function ShouldBeg(inst)
    local herd = inst.components.herdmember and inst.components.herdmember:GetHerd()
    return inst.components.domesticatable ~= nil
        and inst.components.domesticatable:GetDomestication() > 0.0
        and inst.components.hunger ~= nil
        and inst.components.hunger:GetPercent() < TUNING.BEEFALO_BEG_HUNGER_PERCENT
        and (not inst.components.domesticatable:IsDomesticated())
end

local function CalculateBuckDelay(inst)
    local domestication =
        inst.components.domesticatable ~= nil
        and inst.components.domesticatable:GetDomestication()
        or 0

    local moodmult =
        (   (inst.components.herdmember ~= nil and inst.components.herdmember.herd ~= nil and inst.components.herdmember.herd.components.mood ~= nil and inst.components.herdmember.herd.components.mood:IsInMood()) or
            (inst.components.mood ~= nil and inst.components.mood:IsInMood())   )
        and TUNING.BEEFALO_BUCK_TIME_MOOD_MULT
        or 1

    local beardmult =
        (inst.components.beard ~= nil and inst.components.beard.bits == 0)
        and TUNING.BEEFALO_BUCK_TIME_NUDE_MULT
        or 1

    local domesticmult =
        inst.components.domesticatable:IsDomesticated()
        and 1
        or TUNING.BEEFALO_BUCK_TIME_UNDOMESTICATED_MULT

    local basedelay = Remap(domestication, 0, 1, TUNING.BEEFALO_MIN_BUCK_TIME, TUNING.BEEFALO_MAX_BUCK_TIME)

    return basedelay * moodmult * beardmult * domesticmult
end

local function OnBuckTime(inst)
    --V2C: reschedule because :Buck() is not guaranteed!
    inst._bucktask = inst:DoTaskInTime(1 + math.random(), OnBuckTime)
    inst.components.rideable:Buck()
end

local function OnObedienceDelta(inst, data)
    inst.components.rideable:SetSaddleable(data.new >= TUNING.BEEFALO_SADDLEABLE_OBEDIENCE)

    if data.new > data.old and inst._bucktask ~= nil then
        --Restart buck timer if we gained obedience!
        inst._bucktask:Cancel()
        inst._bucktask = inst:DoTaskInTime(CalculateBuckDelay(inst), OnBuckTime)
    end
end

local function OnDeath(inst, data)
    if inst.components.rideable:IsBeingRidden() then
        --SG won't handle "death" event while we're being ridden
        --SG is forced into death state AFTER dismounting (OnRiderChanged)
        inst.components.rideable:Buck(true)
    end
end

local function DomesticationTriggerFn(inst)
    return inst.components.hunger:GetPercent() > 0
        or inst.components.rideable:IsBeingRidden() == true
end

local function OnStarving(inst, dt)
    -- apply no health damage; the stomach is just used by domesticatable
    inst.components.domesticatable:DeltaObedience(TUNING.BEEFALO_DOMESTICATION_STARVE_OBEDIENCE * dt)
    --inst.components.domesticatable:DeltaDomestication(TUNING.BEEFALO_DOMESTICATION_STARVE_DOMESTICATION * dt)
end

local function OnHungerDelta(inst, data)
    if data.oldpercent > 0 and data.delta < 0 then
        -- basically, give domestication while we are digesting
        --inst.components.domesticatable:DeltaDomestication(TUNING.BEEFALO_DOMESTICATION_WELLFED_DOMESTICATION * -data.delta)
        if data.oldpercent > 0.5 then
            inst.components.domesticatable:DeltaTendency(TENDENCY.PUDGY, TUNING.BEEFALO_PUDGY_WELLFED * -data.delta)
        end
    end
end

local function OnEat(inst, food)
    local full = inst.components.hunger:GetPercent() >= 1
    if not full then
        inst.components.domesticatable:DeltaObedience(TUNING.BEEFALO_DOMESTICATION_FEED_OBEDIENCE)

        inst.components.domesticatable:TryBecomeDomesticated()
    else
        inst.components.domesticatable:DeltaObedience(TUNING.BEEFALO_DOMESTICATION_OVERFEED_OBEDIENCE)
        inst.components.domesticatable:DeltaDomestication(TUNING.BEEFALO_DOMESTICATION_OVERFEED_DOMESTICATION)
        inst.components.domesticatable:DeltaTendency(TENDENCY.PUDGY, TUNING.BEEFALO_PUDGY_OVERFEED)
    end
    inst:PushEvent("eat", { full = full, food = food })
    inst.components.knownlocations:RememberLocation("loiteranchor", inst:GetPosition())
end

local function OnDomesticationDelta(inst, data)
    inst:SetTendency()
end

local function OnHealthDelta(inst, data)
    if data.oldpercent >= 0.2 and
        data.newpercent < 0.2 and
        inst.components.rideable.rider ~= nil then
        inst.components.rideable.rider:PushEvent("mountwounded")
    end
end

local function OnBeingRidden(inst, dt)
    inst.components.domesticatable:DeltaTendency(TENDENCY.RIDER, TUNING.BEEFALO_RIDER_RIDDEN * dt)
end

local function OnRiderDoAttack(inst, data)
    inst.components.domesticatable:DeltaTendency(TENDENCY.ORNERY, TUNING.BEEFALO_ORNERY_DOATTACK)
end

local function DoRiderSleep(inst, sleepiness, sleeptime)
    inst._ridersleeptask = nil
    inst.components.sleeper:AddSleepiness(sleepiness, sleeptime)
end

local function OnRiderChanged(inst, data)
    if inst._bucktask ~= nil then
        inst._bucktask:Cancel()
        inst._bucktask = nil
    end

    if inst._ridersleeptask ~= nil then
        inst._ridersleeptask:Cancel()
        inst._ridersleeptask = nil
    end

    if data.newrider ~= nil then
        if inst.components.sleeper ~= nil then
            inst.components.sleeper:WakeUp()
        end
        inst._bucktask = inst:DoTaskInTime(CalculateBuckDelay(inst), OnBuckTime)
        inst.components.knownlocations:RememberLocation("loiteranchor", inst:GetPosition())
    elseif inst.components.health:IsDead() then
        if inst.sg.currentstate.name ~= "death" then
            inst.sg:GoToState("death")
        end
    elseif inst.components.sleeper ~= nil then
        inst.components.sleeper:StartTesting()
        if inst._ridersleep ~= nil then
            local sleeptime = inst._ridersleep.sleeptime + inst._ridersleep.time - GetTime()
            if sleeptime > 2 then
                inst._ridersleeptask = inst:DoTaskInTime(0, DoRiderSleep, inst._ridersleep.sleepiness, sleeptime)
            end
            inst._ridersleep = nil
        end
    end
end

local function OnSaddleChanged(inst, data)
    if data.saddle ~= nil then
        inst:AddTag("companion")
    else
        inst:RemoveTag("companion")
    end
end

local function _OnRefuseRider(inst)
    if inst.components.sleeper:IsAsleep() and not inst.components.health:IsDead() then
        -- this needs to happen after the stategraph
        inst.components.sleeper:WakeUp()
    end
end

local function OnRefuseRider(inst, data)
    inst:DoTaskInTime(0, _OnRefuseRider)
end

local function OnRiderSleep(inst, data)
    inst._ridersleep = inst.components.rideable:IsBeingRidden() and {
        time = GetTime(),
        sleepiness = data.sleepiness,
        sleeptime = data.sleeptime,
    } or nil
end

local function MountSleepTest(inst)
    return not inst.components.rideable:IsBeingRidden() and DefaultSleepTest(inst)
end

local function ToggleDomesticationDecay(inst)
    inst.components.domesticatable:PauseDomesticationDecay(inst.components.saltlicker.salted or inst.components.sleeper:IsAsleep())
end

local function OnInit(inst)
    --inst.components.mood:ValidateMood()
    inst:UpdateDomestication()
end

local function CustomOnHaunt(inst)
    inst.components.periodicspawner:TrySpawn()
    return true
end

local function OnSave(inst, data)
    data.tendency = inst.tendency
end

local function OnLoad(inst, data)
    if data ~= nil and data.tendency ~= nil then
        inst.tendency = data.tendency
    end
end

local function GetDebugString(inst)
    return string.format("tendency %s nextbuck %.2f", inst.tendency, GetTaskRemaining(inst._bucktask))
end

local function koalebeef_winter()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    MakeCharacterPhysics(inst, 100, .5)

    inst.DynamicShadow:SetSize(6, 2)
    inst.Transform:SetSixFaced()

    inst.AnimState:SetBank("beefalo")
    inst.AnimState:SetBuild("koalebeef_winter_build")
    inst.AnimState:PlayAnimation("idle_loop", true)
    inst.AnimState:Hide("HEAT")

    inst:AddTag("koalefant")
    inst:AddTag("animal")
    inst:AddTag("largecreature")

    --bearded (from beard component) added to pristine state for optimization
    --inst:AddTag("bearded")

    --trader (from trader component) added to pristine state for optimization
    inst:AddTag("trader")

    --herdmember (from herdmember component) added to pristine state for optimization
    --inst:AddTag("herdmember")

    --saddleable (from rideable component) added to pristine state for optimization
    inst:AddTag("saddleable")

    --domesticatable (from domesticatable component) added to pristine state for optimization
    inst:AddTag("domesticatable")

    --saltlicker (from saltlicker component) added to pristine state for optimization
    inst:AddTag("saltlicker")

    inst.sounds = sounds

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("bloomer")

    -- inst:AddComponent("beard")
    -- -- assume the beefalo has already grown its hair
    -- inst.components.beard.bits = 3
    -- inst.components.beard.daysgrowth = TUNING.BEEFALO_HAIR_GROWTH_DAYS + 1
    -- inst.components.beard.onreset = OnResetBeard
    -- inst.components.beard.canshavetest = CanShaveTest
    -- inst.components.beard.prize = "beefalowool"
    -- inst.components.beard:AddCallback(0, OnShaved)
    -- inst.components.beard:AddCallback(TUNING.BEEFALO_HAIR_GROWTH_DAYS, OnHairGrowth)

    inst:AddComponent("brushable")
    inst.components.brushable.regrowthdays = 1
    inst.components.brushable.max = 1
    inst.components.brushable.prize = "spoiled_food"
    inst.components.brushable:SetOnBrushed(OnBrushed)

    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.VEGGIE, FOODTYPE.ROUGHAGE }, { FOODTYPE.VEGGIE, FOODTYPE.ROUGHAGE })
    inst.components.eater:SetAbsorptionModifiers(3.5,0.75,1)
    inst.components.eater:SetOnEatFn(OnEat)

    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "beefalo_body"
    inst.components.combat:SetDefaultDamage(TUNING.KOALEFANT_DAMAGE)
    inst.components.combat:SetRetargetFunction(1, Retarget)
    inst.components.combat:SetKeepTargetFunction(KeepTarget)

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.KOALEFANT_HEALTH)
    inst.components.health.nofadeout = true
    
	--inst.components.health:StartRegen(TUNING.BEEFALO_HEALTH_REGEN*1.3, TUNING.BEEFALO_HEALTH_REGEN_PERIOD)
    
    inst:ListenForEvent("death", OnDeath) -- need to handle this due to being mountable
    inst:ListenForEvent("healthdelta", OnHealthDelta) -- to inform rider

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('koalebeef_winter')

    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = GetStatus
    inst.components.inspectable.descriptionfn = getDescription 
	
    inst:AddComponent("knownlocations")
    --inst:ListenForEvent("entermood", OnEnterMood)
    --inst:ListenForEvent("leavemood", OnLeaveMood)

    inst:AddComponent("leader")
    inst:AddComponent("follower")
    inst.components.follower.maxfollowtime = TUNING.BEEFALO_FOLLOW_TIME
    inst.components.follower.canaccepttarget = false

    inst:ListenForEvent("newcombattarget", OnNewTarget)
    inst:ListenForEvent("attacked", OnAttacked)

    inst:AddComponent("periodicspawner")
    inst.components.periodicspawner:SetPrefab("poop")
    inst.components.periodicspawner:SetRandomTimes(40, 60)
    inst.components.periodicspawner:SetDensityInRange(20, 2)
    inst.components.periodicspawner:SetMinimumSpacing(8)
    inst.components.periodicspawner:Start()

    inst:AddComponent("rideable")
    inst.components.rideable:SetRequiredObedience(TUNING.BEEFALO_MIN_BUCK_OBEDIENCE)
    inst:ListenForEvent("saddlechanged", OnSaddleChanged)
    inst:ListenForEvent("refusedrider", OnRefuseRider)

    inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(ShouldAcceptItem)
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader.onrefuse = OnRefuseItem
    inst.components.trader.deleteitemonaccept = false

    inst:AddComponent("hunger")
    inst.components.hunger:SetMax(TUNING.BEEFALO_HUNGER)
    inst.components.hunger:SetRate(TUNING.BEEFALO_HUNGER_RATE)
    inst.components.hunger:SetPercent(0)
    inst.components.hunger:SetOverrideStarveFn(OnStarving)

    inst:AddComponent("domesticatable")
    inst.components.domesticatable:SetDomesticationTrigger(DomesticationTriggerFn)

    MakeLargeBurnableCharacter(inst, "beefalo_body")
    MakeLargeFreezableCharacter(inst, "beefalo_body")

    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.BEEFALO_WALK_SPEED
    inst.components.locomotor.runspeed = TUNING.BEEFALO_RUN_SPEED.DEFAULT*0.9

    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(3)
    inst.components.sleeper.sleeptestfn = MountSleepTest
	
    inst:AddComponent("colourtweener")
	
    inst:AddComponent("timer")
    inst:AddComponent("saltlicker")
    inst.components.saltlicker:SetUp(TUNING.SALTLICK_BEEFALO_USES)
    inst:ListenForEvent("saltchange", ToggleDomesticationDecay)
    inst:ListenForEvent("gotosleep", ToggleDomesticationDecay)
    inst:ListenForEvent("onwakeup", ToggleDomesticationDecay)

    inst.ApplyBuildOverrides = ApplyBuildOverrides
    inst.ClearBuildOverrides = ClearBuildOverrides

    inst.tendency = TENDENCY.DEFAULT
    inst._bucktask = nil

    -- Herdmember component is ONLY used when feral
    --inst:AddComponent("herdmember")
    --inst.components.herdmember:Enable(true)

    -- Mood component is ONLY used when domesticated, otherwise it's part of the herd
    -- inst:AddComponent("mood")
    -- inst.components.mood:SetMoodTimeInDays(TUNING.BEEFALO_MATING_SEASON_LENGTH, TUNING.BEEFALO_MATING_SEASON_WAIT)
    -- inst.components.mood:SetInMoodFn(OnEnterMood)
    -- inst.components.mood:SetLeaveMoodFn(OnLeaveMood)
    -- inst.components.mood:CheckForMoodChange()
    -- inst.components.mood:Enable(false)

    inst.UpdateDomestication = UpdateDomestication
    inst:ListenForEvent("domesticated", OnDomesticated)
    inst.DoFeral = DoFeral
    inst:ListenForEvent("goneferal", OnFeral)
    inst:ListenForEvent("obediencedelta", OnObedienceDelta)
    inst:ListenForEvent("domesticationdelta", OnDomesticationDelta)
    inst:ListenForEvent("beingridden", OnBeingRidden)
    inst:ListenForEvent("riderchanged", OnRiderChanged)
    inst:ListenForEvent("riderdoattackother", OnRiderDoAttack)
    inst:ListenForEvent("hungerdelta", OnHungerDelta)
    inst:ListenForEvent("ridersleep", OnRiderSleep)

    inst:AddComponent("uniqueid")
    inst:AddComponent("beefalometrics")
    inst:AddComponent("drownable")
	
	inst:AddComponent("named")
	
    inst:AddComponent("writeable")
    inst.components.writeable:SetDefaultWriteable(false)
    inst.components.writeable:SetAutomaticDescriptionEnabled(false)
    inst.components.writeable:SetWriteableDistance(TUNING.BEEFALO_NAMING_DIST)
    inst.components.writeable:SetOnWrittenFn(fns.OnNamedByWriteable)
    inst.components.writeable:SetOnWritingEndedFn(fns.OnWritingEnded)

    MakeHauntablePanic(inst)
    AddHauntableCustomReaction(inst, CustomOnHaunt, true, false, true)

    inst.SetTendency = SetTendency
    inst:SetTendency()
	
    inst:ListenForEvent("stopfollowing", fns.ClearBellOwner)
    inst:ListenForEvent("despawn", fns.OnDespawnRequest)
    inst.SetBeefBellOwner = fns.SetBeefBellOwner
    inst.GetBeefBellOwner = fns.GetBeefBellOwner
    inst.ClearBeefBellOwner = fns.ClearBellOwner
    inst._BellRemoveCallback = function(bell)
        fns.ClearBellOwner(inst)
    end
	
    inst.GetMoodComponent = fns.GetMoodComponent
    inst.GetIsInMood = fns.GetIsInMood
    inst.UnSkin = fns.UnSkin
	
    inst.ShouldBeg = ShouldBeg

    inst:SetBrain(brain)
    inst:SetStateGraph("SGkoalebeef")

    inst:DoTaskInTime(0, OnInit)

    inst.debugstringfn = GetDebugString
    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    return inst
end

return Prefab("koalebeef_winter", koalebeef_winter, assets, prefabs)
