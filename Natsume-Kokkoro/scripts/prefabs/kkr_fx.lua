local assets = {
    Asset("ANIM", "anim/kkr_elec_lunge_fx.zip"),
    Asset("ANIM", "anim/elec_lunge_fx.zip")
}

local assets_spear_tornado = {
    Asset("ANIM", "anim/tornado.zip")
}

local assets_dualslash = {
    Asset("ANIM", "anim/lavaarena_shadow_lunge.zip"),
    Asset("ANIM", "anim/kkr.zip"),
    Asset("ANIM", "anim/waxwell_shadow_mod.zip"),
    Asset("ANIM", "anim/swap_nightmaresword_shadow.zip")
}
local assets_kkr_speedboost = {
    Asset("ANIM", "anim/kkr_speedboost.zip")
}

local assets_kkr_forcefield = {
    Asset("ANIM", "anim/kkr_forcefield.zip")
}

local assets_spear_lungefx = {
    Asset("ANIM", "anim/lavaarena_staff_smoke_fx.zip"),
    Asset("ANIM", "anim/kkr_spear_lungefx.zip")
}

local assets_kkr_domain = {
    Asset("ANIM", "anim/kkr_domain.zip")
}

local assets_kkr_stalker_shield = {
    Asset("ANIM", "anim/kkr_stalker_shield.zip"),
    Asset("ANIM", "anim/stalker_shield.zip")
}

local function FX_OnUpdate(inst, dt)
    inst.Light:SetIntensity(inst.i)
    inst.i = inst.i - dt * 2
    if inst.i <= 0 then
        if inst.killfx then
            inst:Remove()
        else
            inst.task:Cancel()
            inst.task = nil
        end
    end
end

local function FX_OnAnimOver(inst)
    if inst.task == nil then
        inst:Remove()
    else
        inst:RemoveEventCallback("animover", FX_OnAnimOver)
        inst.killfx = true
    end
end

local function LungueTrailFxFn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.entity:AddLight()

    inst.Light:Enable(true)
    inst.Light:SetRadius(3.5)
    inst.Light:SetFalloff(1.5)
    inst.Light:SetIntensity(.9)
    inst.Light:SetColour(237 / 255, 237 / 255, 209 / 255)

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")

    inst.Transform:SetEightFaced()

    inst.AnimState:SetBank("elec_lunge_fx")
    inst.AnimState:SetBuild("kkr_elec_lunge_fx")
    inst.AnimState:PlayAnimation("fx")

    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetLightOverride(1)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    local scale = GetRandomMinMax(1.4, 1.7)
    inst.Transform:SetScale(scale, scale, scale)

    inst.persists = false

    local dt = 1 / 20

    inst.i = .9
    inst.task = inst:DoPeriodicTask(dt, FX_OnUpdate, nil, dt)

    inst:ListenForEvent("animover", FX_OnAnimOver)

    return inst
end

local WORK_ACTIONS = {
    CHOP = true,
    MINE = true
}
local TARGET_TAGS = {"_combat"}
for k, v in pairs(WORK_ACTIONS) do
    table.insert(TARGET_TAGS, k .. "_workable")
end
local function destroystuff(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local radius = inst.radius or 2
    local ents =
        TheSim:FindEntities(x, y, z, radius, nil, {"INLIMBO", "structure", "player", "wall", "abigail"}, TARGET_TAGS)
    for i, v in ipairs(ents) do
        if v ~= inst.WIND_CASTER and v:IsValid() then
            if
                v.components.health ~= nil and not v.components.health:IsDead() and v.components.combat ~= nil and
                    v.components.combat:CanBeAttacked()
             then
                local dmg = inst.dmg
                local spdmg = inst.spdmg
                v.components.combat:GetAttacked(inst, dmg, nil, "wind", spdmg)
            elseif
                v.components.workable ~= nil and v.components.workable:CanBeWorked() and
                    v.components.workable:GetWorkAction() and
                    WORK_ACTIONS[v.components.workable:GetWorkAction().id]
             then
                SpawnPrefab("collapse_small").Transform:SetPosition(v.Transform:GetWorldPosition())
                v.components.workable:WorkedBy(inst, 2)
            end
        end
    end
end

local function fn_kkr_spear_tornado()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetFinalOffset(2)
    inst.AnimState:SetBank("tornado")
    inst.AnimState:SetBuild("tornado")
    inst.AnimState:PlayAnimation("tornado_pre")
    inst.AnimState:PushAnimation("tornado_loop")
    inst.AnimState:SetMultColour(176 / 255, 224 / 255, 230 / 255, 0.8)

    inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/tornado", "spinLoop")

    MakeInventoryPhysics(inst)
    RemovePhysicsColliders(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("knownlocations")

    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = TUNING.TORNADO_WALK_SPEED * .2
    inst.components.locomotor.runspeed = TUNING.TORNADO_WALK_SPEED

    inst.WINDSTAFF_CASTER = nil
    inst.persists = false
    inst:DoTaskInTime(2, inst.Remove)
    inst:DoPeriodicTask(0.1, destroystuff)

    return inst
end

local function StartShadows(self)
    SpawnPrefab("statue_transition_2").Transform:SetPosition(self.Transform:GetWorldPosition())
    self.AnimState:PlayAnimation("lunge_pre")
    self.AnimState:PushAnimation("lunge_lag")

    self:ListenForEvent(
        "animover",
        function()
            if self.AnimState:IsCurrentAnimation("lunge_lag") then
                self:kkr_InitAnim(nil, nil, true)
                self.AnimState:PlayAnimation("lunge_pst")
            end
        end
    )

    self:DoTaskInTime(
        12 * FRAMES,
        function(inst)
            inst.Physics:SetMotorVel(30, 0, 0)
        end
    )
    self:DoTaskInTime(
        15 * FRAMES,
        function(inst)
            inst:Attack()
        end
    )

    self:DoTaskInTime(
        22 * FRAMES,
        function(inst)
            inst.Physics:ClearMotorVelOverride()
        end
    )
    self:DoTaskInTime(
        35 * FRAMES,
        function(inst)
            inst:Remove()
        end
    )
end

local function kkr_striker()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddPhysics()
    inst.entity:AddNetwork()

    inst.Transform:SetFourFaced(inst)

    inst.Physics:SetMass(1)
    inst.Physics:SetFriction(0)
    inst.Physics:SetDamping(5)
    inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.GROUND)
    inst.Physics:SetCapsule(.5, 1)

    inst:AddTag("scarytoprey")
    inst:AddTag("NOBLOCK")

    inst.AnimState:SetBank("wilson")
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetMultColour(195 / 255, 255 / 255, 250 / 255, 1)
    inst.AnimState:OverrideSymbol("swap_object", "swap_kkr_elfstaff_plus", "symbol0")
    inst.kkr_InitAnim = function(self, build, override)
        inst.AnimState:SetBuild("kkr")
        if override then
            inst.AnimState:AddOverrideBuild("lavaarena_shadow_lunge")
        end
    end
    inst.AnimState:OverrideSymbol("arm_lower", "kkr_elfrobe_skin", "arm_lower")
    inst.AnimState:OverrideSymbol("arm_upper", "kkr_elfrobe_skin", "arm_upper")
    inst.AnimState:OverrideSymbol("arm_upper_skin", "kkr_elfrobe_skin", "arm_upper_skin")
    inst.AnimState:OverrideSymbol("leg", "kkr_elfrobe_skin", "leg")
    inst.AnimState:OverrideSymbol("torso", "kkr_elfrobe_skin", "torso")
    inst.AnimState:OverrideSymbol("headbase", "kkr_flower_amulet_head", "headbase")
    inst.AnimState:OverrideSymbol("headbase_hat", "kkr_flower_amulet_head", "headbase_hat")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.SetPlayer = function(self, player)
        inst.player = player
    end

    inst.SetDamage = function(self, damage)
        inst.damage = damage or 0
    end

    inst.SetPlanardamage = function(self, spdamage)
        inst.planardamage = spdamage or {}
    end

    inst.SetTarget = function(self, target)
        inst.target = target
        inst.target_pos = Point(target.Transform:GetWorldPosition())
        inst:FacePoint(inst.target_pos)
    end

    inst.SetPosition = function(self, target_pos, offset)
        inst.offset = offset
        self.Transform:SetPosition(target_pos.x + offset.x, target_pos.y + offset.y, target_pos.z + offset.z)
        StartShadows(self)
    end

    inst.Attack = function(self)
        local function RotateFX(fx)
            fx.Transform:SetPosition(self.target_pos.x, self.target_pos.y, self.target_pos.z)
            fx.Transform:SetRotation(self.Transform:GetRotation())
        end
        local rand = math.random(1, 2)
        if rand == 1 then
            RotateFX(SpawnPrefab("shadowstrike_slash_fx"))
        else
            RotateFX(SpawnPrefab("shadowstrike_slash2_fx"))
        end
        local spark_offset_mult = 0.25

        if self and self:IsValid() and self.target and self.target:IsValid() then
            local dist = math.sqrt(self:GetDistanceSqToInst(self.target))
            if
                self.player and self.target and dist <= 3.5 and self.target.components.health and
                    not self.target.components.health:IsDead() and
                    self.target.components.combat
             then
                self.target.components.combat:GetAttacked(inst, self.damage, nil, nil, self.planardamage)
            end
        end
        inst.SoundEmitter:PlaySound("dontstarve/common/lava_arena/fireball")
    end

    return inst
end

local function fn_kkr_speedboost()
    local inst = CreateEntity()

    inst.entity:AddTransform()

    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")

    inst.AnimState:SetBank("kkr_speedboost")
    inst.AnimState:SetBuild("kkr_speedboost")
    inst.AnimState:PlayAnimation("idle", true)

    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    inst.persists = false

    return inst
end

local MAX_LIGHT_FRAME = 6

local function OnUpdateLight(inst, dframes)
    local done
    if inst._islighton:value() then
        local frame = inst._lightframe:value() + dframes
        done = frame >= MAX_LIGHT_FRAME
        inst._lightframe:set_local(done and MAX_LIGHT_FRAME or frame)
    else
        local frame = inst._lightframe:value() - dframes
        done = frame <= 0
        inst._lightframe:set_local(done and 0 or frame)
    end

    inst.Light:SetRadius(3 * inst._lightframe:value() / MAX_LIGHT_FRAME)

    if done then
        inst._lighttask:Cancel()
        inst._lighttask = nil
    end
end

local function OnLightDirty(inst)
    if inst._lighttask == nil then
        inst._lighttask = inst:DoPeriodicTask(FRAMES, OnUpdateLight, nil, 1)
    end
    OnUpdateLight(inst, 0)
end

local function kill_fx(inst)
    inst.AnimState:PlayAnimation("close")
    inst._islighton:set(false)
    inst._lightframe:set(inst._lightframe:value())
    OnLightDirty(inst)
    inst:DoTaskInTime(.6, inst.Remove)
end

local function fn_kkr_forcefield()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("forcefield")
    inst.AnimState:SetBuild("kkr_forcefield")
    inst.AnimState:PlayAnimation("open")
    inst.AnimState:PushAnimation("idle_loop", true)

    inst.SoundEmitter:PlaySound("dontstarve/wilson/forcefield_LP", "loop")

    inst.Light:SetRadius(0)
    inst.Light:SetIntensity(.9)
    inst.Light:SetFalloff(.9)
    inst.Light:SetColour(1, 1, 1)
    inst.Light:Enable(true)
    inst.Light:EnableClientModulation(true)

    inst._lightframe = net_tinybyte(inst.GUID, "forcefieldfx._lightframe", "lightdirty")
    inst._islighton = net_bool(inst.GUID, "forcefieldfx._islighton", "lightdirty")
    inst._lighttask = nil
    inst._islighton:set(true)

    inst.entity:SetPristine()

    OnLightDirty(inst)

    if not TheWorld.ismastersim then
        inst:ListenForEvent("lightdirty", OnLightDirty)

        return inst
    end

    inst.kill_fx = kill_fx

    return inst
end

local function FastForwardFX(inst, pct)
    if inst._task ~= nil then
        inst._task:Cancel()
    end
    local len = inst.AnimState:GetCurrentAnimationLength()
    pct = math.clamp(pct, 0, 1)
    inst.AnimState:SetTime(len * pct)
    inst._task = inst:DoTaskInTime(len * (1 - pct) + 2 * FRAMES, inst.Remove)
end

local function fn_spear_lungefx()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()

    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")

    inst.AnimState:SetBank("kkr_spear_lungefx")
    inst.AnimState:SetBuild("kkr_spear_lungefx")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false
    inst._task = inst:DoTaskInTime(inst.AnimState:GetCurrentAnimationLength() + 2 * FRAMES, inst.Remove)

    inst.FastForward = FastForwardFX

    return inst
end

local function atkup(inst)
    local pos = inst:GetPosition()
    local enta = TheSim:FindEntities(pos.x, pos.y, pos.z, 6, {"_combat", "_health", "player"}, {"playerghost"})
    for i, v in ipairs(enta) do
        if v:IsValid() and v.components.health and not v.components.health:IsDead() then
            if v.components.combat then
                v:AddDebuff("kkr_increase", "kkr_increase")
            end
        end
    end
end

local function fn_kkr_domain()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")

    inst.AnimState:SetBank("kkr_domain")
    inst.AnimState:SetBuild("kkr_domain")
    inst.AnimState:PlayAnimation("activate")
    inst.AnimState:PushAnimation("idle", true)
    inst.AnimState:SetScale(2, 2, 2)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.Light:SetColour(111 / 255, 111 / 255, 227 / 255)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetFalloff(0.6)
    inst.Light:SetRadius(4)
    inst.Light:Enable(true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:DoPeriodicTask(5, atkup)
    inst:DoTaskInTime(
        119,
        function()
            inst.AnimState:PushAnimation("end")
            inst:ListenForEvent("animover", inst.Remove)
        end
    )

    return inst
end

local function fn_kkr_stalker_shield()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("kkr_stalker_shield")
    inst.AnimState:SetBuild("kkr_stalker_shield")
    inst.AnimState:PlayAnimation("idle2")
    inst.AnimState:SetFinalOffset(2)

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    inst:ListenForEvent("animover", inst.Remove)

    return inst
end

local hua = {}
table.insert(hua, Point())
for i = 2, 6, 2 do
    local z = 2 * PI * i
    local jg = 2 + (z % 2) / (z / 2)
    for j = jg, z, jg do
        local hu = j / i
        local po = Vector3(math.cos(hu) * i, 0, math.sin(hu) * i)
        table.insert(hua, po)
    end
end

local function heal(inst)
    local pos = inst:GetPosition()
    local enta = TheSim:FindEntities(pos.x, pos.y, pos.z, 6, {"_combat", "_health", "player"}, {"playerghost"})
    local amount = KKRENV.KKR_HEALAMOUNT
    if inst.ongroundmode == true then
        amount = KKRENV.KKR_HEALAMOUNT + 1
    end
    for i, v in ipairs(enta) do
        if v:IsValid() and v.components.health and not v.components.health:IsDead() then
            v.components.health:DoDelta(amount)
        end
    end
end

local function Start(inst)
    inst:DoPeriodicTask(1, heal)
    local pos = inst:GetPosition()

    for k, v in pairs(hua) do
        inst:DoTaskInTime(
            math.random() * 0.2,
            function()
                local fx = SpawnPrefab("lavaarena_bloom" .. math.random(6))
                fx.Transform:SetPosition((pos + v):Get())
                fx.AnimState:PushAnimation("idle_" .. fx.variation)
                fx.persists = false
                fx:DoTaskInTime(120, fx.Remove)
            end
        )
    end
end

local function OnSave(inst, data)
    if inst then
        data.ongroundmode = inst.ongroundmode
    end
end

local function OnLoad(inst, data)
    if data then
        inst.ongroundmode = data.ongroundmode
    end
    inst:Start(inst)
end

local function fn1()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    inst.AnimState:SetBuild("archive_security_pulse")
    inst.AnimState:SetBank("archive_security_pulse")
    inst.AnimState:PlayAnimation("idle", true)
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    inst.ongroundmode = true
    inst:AddTag("kkr_cureflower")
    inst.Start = Start
    inst.OnSave = OnSave
    inst.OnLoad = OnLoad
    inst:DoTaskInTime(120, inst.Remove)

    return inst
end

return Prefab("kkr_spear_lunge_fx", LungueTrailFxFn, assets), Prefab(
    "kkr_spear_tornado",
    fn_kkr_spear_tornado,
    assets_spear_tornado
), Prefab("kkr_striker", kkr_striker, assets_dualslash), Prefab(
    "kkr_speedboost",
    fn_kkr_speedboost,
    assets_kkr_speedboost
), Prefab("kkr_forcefieldfx", fn_kkr_forcefield, assets_kkr_forcefield), Prefab(
    "kkr_spear_lungefx",
    fn_spear_lungefx,
    assets_spear_lungefx
), Prefab("kkr_domain", fn_kkr_domain, assets_kkr_domain), Prefab(
    "kkr_stalker_shield",
    fn_kkr_stalker_shield,
    assets_kkr_stalker_shield
), Prefab("kkr_cureflower", fn1, assets)
