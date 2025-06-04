local function OnBurnt(inst)
    DefaultBurntStructureFn(inst)
end

local function OnHammered(inst, worker)
    if inst.components.burnable and inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
    end
    if not inst:HasTag("burnt") then
        inst.components.container:DropEverything()
    end
    inst.SoundEmitter:KillSound("firesuppressor_idle")
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("metal")
    inst:Remove()
end

local function OnHit(inst, worker)
    if not inst:HasTag("burnt") then
        inst.AnimState:PlayAnimation("hit")
        inst.AnimState:PushAnimation("idle", true)
        inst.components.container:Close()
    end
end

local function OnSave(inst, data)
    if inst:HasTag("burnt") or (inst.components.burnable ~= nil and inst.components.burnable:IsBurning()) then
        data.burnt = true
    end
    data.rotation = inst:GetRotation()
end

local function OnLoad(inst, data)
    if data ~= nil then
        if data.burnt and inst.components.burnable ~= nil and inst.components.burnable.onburnt ~= nil then
            inst.components.burnable.onburnt(inst)
        end
        if data.rotation then
            inst.Transform:SetRotation(data.rotation)
        end
    end
end

local function OnBuilt(inst)
    inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("idle", true)
    inst.SoundEmitter:PlaySound("dontstarve/common/icebox_craft")
end

local function OnHarvest(inst)
    local fx = inst:SpawnChild("ea_fx_harvest")
    fx.Transform:SetPosition(0.4, 2, 0)
    inst.AnimState:PlayAnimation("hit")
    inst.AnimState:PushAnimation("idle", true)
end

local function OnHarvest2(inst)
    for i = 1, 4 do
        local rot = 90 * i
        local fx = inst:SpawnChild("ea_fx_harvest")
        fx.Transform:SetPosition(0, 2, 0)
        fx.Transform:SetRotation(rot)
    end
    inst.AnimState:PlayAnimation("hit")
    inst.AnimState:PushAnimation("idle", true)
end


local function MakeHarvestMachine(name, assets, prefabs, build, bank, length, width, offset, placer_rotate, on_harvest)
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddMiniMapEntity()
        inst.entity:AddNetwork()
        inst.entity:AddLightWatcher()

        inst.Transform:SetEightFaced()

        MakeObstaclePhysics(inst, .5)

        inst.MiniMapEntity:SetIcon(name.."_mini.tex")

        inst.AnimState:SetBank(bank)
        inst.AnimState:SetBuild(build)
        inst.AnimState:PlayAnimation("idle", true)

        inst:AddTag("fridge")   --冰箱保鲜功能
        inst:AddTag("structure")
        inst:AddTag("NOBLOCK")

        inst.entity:SetPristine()
        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("inspectable")
        inst:AddComponent("lootdropper")

        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
        inst.components.workable:SetWorkLeft(4)
        inst.components.workable:SetOnFinishCallback(OnHammered)
        inst.components.workable:SetOnWorkCallback(OnHit)

        inst:AddComponent("container")
        inst.components.container:WidgetSetup( "ea_harvest_machine")
        inst.components.container.onopenfn = function ()
            inst.AnimState:PlayAnimation("trans", true)
        end
        inst.components.container.onclosefn = function ()
            inst.AnimState:PlayAnimation("idle", true)
        end
        inst.components.container.skipclosesnd = true
        inst.components.container.skipopensnd = true

        inst:AddComponent("ea_rectangle")
        inst.components.ea_rectangle:SetCanShowArea(EA_CONSTANTS.ENABLE_HARVEST_MACHINE_AREA_SHOW)

        inst:AddComponent("ea_harvest_machine")
        inst.components.ea_harvest_machine:SetInterval(EA_CONSTANTS.HARVEST_MACHINE_CHECK_INTERVAL)
        inst.components.ea_harvest_machine:SetRange(width, length)
        inst.components.ea_harvest_machine:SetOffset(offset)
        inst.components.ea_harvest_machine:SetOnHarvestFn(type(on_harvest) == "function" and on_harvest or OnHarvest)
        inst.components.ea_harvest_machine:StartUpdating()

        MakeMediumBurnable(inst, nil, nil, true)
        MakeMediumPropagator(inst)
        inst.components.burnable:SetOnBurntFn(OnBurnt)

        inst:ListenForEvent("onbuilt", OnBuilt)

        inst.OnSave = OnSave
        inst.OnLoad = OnLoad

        return inst
    end

    local function placer_post_fn(inst)
        --生成区域范围预览
        inst:AddComponent("ea_rectangle_replica")
        inst.components.ea_rectangle_replica:SetSize(length, width)
        inst.components.ea_rectangle_replica:SetOffset(offset)
        inst.components.ea_rectangle_replica:ShowArea(true)

        if placer_rotate and TheInput
        and type(EA_CONSTANTS.HARVEST_MACHINE_PLACER_ROTATE_KEY) =="string"
        and type(_G["KEY_"..EA_CONSTANTS.HARVEST_MACHINE_PLACER_ROTATE_KEY]) == "number" then
            inst.rot_handler = TheInput:AddKeyDownHandler(_G["KEY_"..EA_CONSTANTS.HARVEST_MACHINE_PLACER_ROTATE_KEY], function(key)
                if inst:IsValid() then
                    inst.Transform:SetRotation(inst:GetRotation() + 90)
                end
            end)

            inst:ListenForEvent("onremove", function ()
                if inst.rot_handler then
                    TheInput.onkeydown:RemoveHandler(inst.rot_handler)
                end
            end)
        end
    end

    if placer_rotate then
        RegisterRotablePlacer(name)
    end

    return Prefab(name, fn, assets, prefabs),
    MakePlacer(name.."_placer", bank, build, "idle", nil, nil, nil, nil, nil, "eight", placer_post_fn)
end


-- 需要在ea_main_scripts/containers.lua里注册容器
-- 需要在ea_main_scripts/recipes.lua里注册配方
-- 需要在scripts/localization里添加多语言文本
local machines = {
    ea_harvest_machine = {
        assets = {
            Asset("ANIM", "anim/ea_harvest_machine.zip"),
            Asset("IMAGE", "images/inventoryimages/ea_harvest_machine.tex"),
            Asset("ATLAS", "images/inventoryimages/ea_harvest_machine.xml"),
        },
        prefabs = {
            "ea_fx_harvest",
            "ea_fx_trans"
        },
        bank = "ea_harvest_machine",
        build = "ea_harvest_machine",
        length = EA_CONSTANTS.HARVEST_MACHINE_CHECK_LENGTH + 1, --放弃使用offset来偏移区域，因为会在收获时出现物品离得太近检查不到的问题
        width = EA_CONSTANTS.HARVEST_MACHINE_CHECK_WIDTH,
        offset = 0.5 + EA_CONSTANTS.HARVEST_MACHINE_CHECK_LENGTH * 0.5,
        placer_rotate = true,
    },
    ea_harvest_machine2 = {
        assets = {
            Asset("ANIM", "anim/ea_harvest_machine2.zip"),
            Asset("IMAGE", "images/inventoryimages/ea_harvest_machine2.tex"),
            Asset("ATLAS", "images/inventoryimages/ea_harvest_machine2.xml"),
        },
        prefabs = {
            "ea_fx_harvest",
            "ea_fx_trans"
        },
        bank = "ea_harvest_machine2",
        build = "ea_harvest_machine2",
        length = EA_CONSTANTS.HARVEST_MACHINE_CHECK_SIDE,
        width = EA_CONSTANTS.HARVEST_MACHINE_CHECK_SIDE,
        offset = 0,
        placer_rotate = false,
        on_harvest = OnHarvest2
    },
}


local prefs = {}
for machine, data in pairs(machines) do
    local pref, placer = MakeHarvestMachine(machine, data.assets, data.prefabs, data.build, data.bank, data.length, data.width, data.offset, data.placer_rotate, data.on_harvest)
    table.insert(prefs, pref)
    table.insert(prefs, placer)
end

return unpack(prefs)