require "prefabutil"
local function onhammered(inst, worker)
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("wood")
    inst:Remove()
end

local function onhit(inst, worker)
end

local function onbuilt(inst)
    inst.SoundEmitter:PlaySound("dontstarve/common/sign_craft")
end

local function OnSave(inst, data)
    data.sz = inst.sz
    data.lx = inst.lx
end

local function OnLoad(inst, data)
    if data then
        if data.sz then
            inst.sz = data.sz
        end
        if data.lx then
            inst.lx = data.lx
        end
    end
end

local function TradeTest(inst,item)
  return item.prefab == "redgem" or item.prefab == "bluegem"
end

local function OnAcceptTrade(inst, giver, item)
  if item.prefab == "redgem" then
      inst.lx = false
      inst.sz = inst.sz + (480 * 50)
      if giver and giver.components.talker then
          giver.components.talker:Say("The power of the sun is in my hands")
      end
  end
  if item.prefab == "bluegem" then
      inst.lx = true
      inst.sz = inst.sz + (480 * 50)
      if giver and giver.components.talker then
          giver.components.talker:Say("Winter is coming")
      end
  end
end

local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 1.7)

    inst.AnimState:SetBank("heat_star_flame")
    inst.AnimState:SetBuild("heat_star_flame")
    inst.AnimState:PlayAnimation("idle")
    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon("fy_starmoonaltar.tex")
    inst.entity:SetPristine()
    inst.entity:AddLight()
    inst:AddTag("HASHEATER")
    inst:AddTag("daylight")
    inst.xz = false
    inst.sz = 0
    inst.lx = false
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("named")

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    inst:DoPeriodicTask(
        1,
        function()
            if inst.sz > 0 then
                inst.sz = inst.sz - 1
            end
            if inst.sz == 0 then
                inst.Light:Enable(false)
                inst.xz = false
                inst.components.heater.heat = nil
                inst.components.heater:SetThermics(false, false)
            else
                if inst.lx == false then
                    STRINGS.CHARACTERS.GENERIC.DESCRIBE.FY_STARMOONALTAR = "The power of the sun is in my hands"
                    local colour = {223 / 255, 208 / 255, 69 / 255}
                    inst.Light:Enable(true)
                    inst.Light:SetRadius(20)
                    inst.Light:SetFalloff(.5)
                    inst.Light:SetIntensity(.8)

                    inst.Light:SetColour(248 / 255, 197 / 255, 181 / 255)

                    inst.components.heater.heat = 100
                    inst.components.heater:SetThermics(true, false)
                    inst.AnimState:SetBank("heat_star_flame")
                    inst.AnimState:SetBuild("heat_star_flame")

                    if inst.fy_starmoonaltar_fx2 then
                        inst.fy_starmoonaltar_fx2:Remove()
                        inst.fy_starmoonaltar_fx2 = nil
                    end

                    if not inst.fy_starmoonaltar_fx then
                        inst.fy_starmoonaltar_fx = SpawnPrefab("fy_starmoonaltar_fx")
                        inst.fy_starmoonaltar_fx.entity:AddFollower()
                        inst.fy_starmoonaltar_fx.entity:SetParent(inst.entity)
                        inst.fy_starmoonaltar_fx.Transform:SetPosition(0, 0, 0)
                    end
                end
                if inst.lx == true then
                    STRINGS.CHARACTERS.GENERIC.DESCRIBE.FY_STARMOONALTAR = "Winter is coming"
                    local colour = {64 / 255, 64 / 255, 208 / 255}
                    inst.Light:Enable(true)
                    inst.Light:SetRadius(20)
                    inst.Light:SetFalloff(.5)
                    inst.Light:SetIntensity(.8)

                    inst.Light:SetColour(64 / 255, 64 / 255, 208 / 255)

                    inst.components.heater.heat = -100
                    inst.components.heater:SetThermics(false, true)
                    inst.AnimState:SetBank("ice_star_flame")
                    inst.AnimState:SetBuild("ice_star_flame")

                    if inst.fy_starmoonaltar_fx then
                        inst.fy_starmoonaltar_fx:Remove()
                        inst.fy_starmoonaltar_fx = nil
                    end

                    if not inst.fy_starmoonaltar_fx2 then
                        inst.fy_starmoonaltar_fx2 = SpawnPrefab("fy_starmoonaltar_fx2")
                        inst.fy_starmoonaltar_fx2.entity:AddFollower()
                        inst.fy_starmoonaltar_fx2.entity:SetParent(inst.entity)
                        inst.fy_starmoonaltar_fx2.Transform:SetPosition(0, 0, 0)
                    end
                end
            end
        end
    )
    inst:AddComponent("inspectable")
    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(10)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)

    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = 3
    inst:AddComponent("heater")
    inst.components.heater.heat = nil
    inst.components.heater:SetThermics(false, false)
    inst:ListenForEvent("onbuilt", onbuilt)
    inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(TradeTest)
    inst.components.trader.onaccept=OnAcceptTrade

    return inst
end
local fy_starmoonaltar = "Star Burning Furnace"
STRINGS.NAMES.FY_STARMOONALTAR = fy_starmoonaltar
STRINGS.RECIPE_DESC.FY_STARMOONALTAR = fy_starmoonaltar
STRINGS.CHARACTERS.GENERIC.DESCRIBE.FY_STARMOONALTAR = fy_starmoonaltar

return Prefab("fy_starmoonaltar", fn), MakePlacer(
    "fy_starmoonaltar_placer",
    "heat_star_flame",
    "heat_star_flame",
    "idle"
)
