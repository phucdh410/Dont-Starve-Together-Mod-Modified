-- 引入预制体工具模块
require "prefabutil"
-- 当使用锤子敲击时的回调函数
local function onhammered(inst, worker)
inst.components.lootdropper:DropLoot()  -- 掉落战利品
local fx = SpawnPrefab("collapse_small")  -- 创建倒塌效果
fx.Transform:SetPosition(inst.Transform:GetWorldPosition())  -- 设置倒塌效果的位置
fx:SetMaterial("wood")  -- 设置倒塌效果的材质
inst:Remove()  -- 移除当前实体
end
-- 当受到攻击时的回调函数
local function onhit(inst, worker)
-- inst.AnimState:PlayAnimation("recharging_full")  -- 播放被击中的动画
-- inst.AnimState:PushAnimation("full", false)  -- 播放空闲动画
end
-- 建造完成时的回调函数
local function onbuilt(inst)
inst.SoundEmitter:PlaySound("dontstarve/common/sign_craft")  -- 播放建造声音
-- SpawnAt("fy_starmoonaltar_fx", inst,nil, {0, 1.5, 0})
--inst:SpawnChild("fy_starmoonaltar_fx")
end
--保存数据
local function OnSave(inst, data)
data.sz = inst.sz
data.lx = inst.lx
end
--读取数据
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
function convertSecondsToDaysAndSeconds(seconds)
local days = math.floor(seconds / 480)          -- 计算天数
local remainingSeconds = seconds % 480         -- 计算剩余秒数
return days, remainingSeconds
end
-- 创建实体的主函数
local function fn()
local inst = CreateEntity()  -- 创建一个新的实体
inst.entity:AddTransform()  -- 添加变换组件
inst.entity:AddAnimState()  -- 添加动画状态组件
inst.entity:AddSoundEmitter()  -- 添加声音发射器组件
inst.entity:AddMiniMapEntity()  -- 添加小地图实体组件
inst.entity:AddNetwork()  -- 添加网络组件
--MakeObstaclePhysics(inst, .8)  -- 设置障碍物理属性
MakeObstaclePhysics(inst, 1.7)--物理碰撞体积大小 %
--inst.MiniMapEntity:SetPriority(4)
-- inst.MiniMapEntity:SetIcon("fy_starmoonaltar_build.tex")
inst.AnimState:SetBank("heat_star_flame")
inst.AnimState:SetBuild("heat_star_flame")
inst.AnimState:PlayAnimation("idle")
local minimap = inst.entity:AddMiniMapEntity()
minimap:SetIcon("fy_starmoonaltar.tex")
inst.entity:SetPristine()  -- 设置为初始状态
inst.entity:AddLight()--光
inst:AddTag("HASHEATER")
inst:AddTag("daylight")
inst.xz = false
inst.sz = 0
inst.lx = false
if not TheWorld.ismastersim then  -- 如果不是主服务器
return inst  -- 返回实体
end
inst:AddComponent("named")
--保存和读取初始化
inst.OnSave = OnSave
inst.OnLoad = OnLoad
--监测帧
inst:DoPeriodicTask(1,function()
if inst.sz > 0 then
inst.sz = inst.sz - 1
end
if inst.components.named then
local days, remainingSeconds = convertSecondsToDaysAndSeconds(inst.sz)
inst.components.named:SetName("焚星炉".."\n".."还剩余"..days.."天"..remainingSeconds.."秒消失！")
end
--调试用测试打印 勿用 打印多文件日志量大 卡顿 因此需要禁用
--print(inst.sz)
--print(inst.lx)
-------------------
if inst.sz == 0 then
------------
--关
--if not inst.AnimState:IsCurrentAnimation("fy_StarMoonAltar_idle_2") then
--inst.AnimState:PlayAnimation("fy_StarMoonAltar_idle_2")
--end
inst.Light:Enable(false)
inst.xz = false
inst.components.heater.heat = nil
inst.components.heater:SetThermics(false, false)--参数热，冷
------------
else
--开
if inst.lx == false then--热
STRINGS.CHARACTERS.GENERIC.DESCRIBE.FY_STARMOONALTAR = "太阳的力量就在我的手中！"
local colour = { 223 / 255, 208 / 255, 69 / 255 }
inst.Light:Enable(true)
inst.Light:SetRadius(20)--距离
inst.Light:SetFalloff(.5)--衰减值
inst.Light:SetIntensity(.8)--强度
--inst.Light:SetColour(unpack(colour))
inst.Light:SetColour(248/255,197/255,181/255)--颜色
--RGB颜色用法 三个参数  R,B,G  然后每个参数里面必须/255  R/255,G/255,B/255 RGB颜色自行百度搜寻
inst.components.heater.heat = 100
inst.components.heater:SetThermics(true, false)--参数热，冷
inst.AnimState:SetBank("heat_star_flame")
inst.AnimState:SetBuild("heat_star_flame")
------------------------
if inst.fy_starmoonaltar_fx2 then
--inst.fy_starmoonaltar_fx2.entity:StopFollowing()
--inst.fy_starmoonaltar_fx2.entity:RemoveFromParent()
inst.fy_starmoonaltar_fx2:Remove()
inst.fy_starmoonaltar_fx2 = nil
end
--------------------
if not inst.fy_starmoonaltar_fx then
inst.fy_starmoonaltar_fx = SpawnPrefab("fy_starmoonaltar_fx")
inst.fy_starmoonaltar_fx.entity:AddFollower()
inst.fy_starmoonaltar_fx.entity:SetParent(inst.entity)
inst.fy_starmoonaltar_fx.Transform:SetPosition(0, 0, 0)
end
------------------
--if not inst.AnimState:IsCurrentAnimation("fy_StarMoonAltar_build") then
--inst.AnimState:PlayAnimation("fy_StarMoonAltar_build",true)
--end
end
if inst.lx == true then--冷
STRINGS.CHARACTERS.GENERIC.DESCRIBE.FY_STARMOONALTAR = "凛冬将至！"
local colour = {64/255, 64/255, 208/255}
inst.Light:Enable(true)
inst.Light:SetRadius(20)--距离
inst.Light:SetFalloff(.5)--衰减值
inst.Light:SetIntensity(.8)--强度
--inst.Light:SetColour(unpack(colour))
inst.Light:SetColour(64/255, 64/255, 208/255)--颜色
--RGB颜色用法 三个参数  R,B,G  然后每个参数里面必须/255  R/255,G/255,B/255 RGB颜色自行百度搜寻
inst.components.heater.heat = -100
inst.components.heater:SetThermics(false, true)--参数热，冷
inst.AnimState:SetBank("ice_star_flame")
inst.AnimState:SetBuild("ice_star_flame")
------------------------
if inst.fy_starmoonaltar_fx then
--inst.fy_starmoonaltar_fx.entity:StopFollowing()
--inst.fy_starmoonaltar_fx.entity:RemoveFromParent()
inst.fy_starmoonaltar_fx:Remove()
inst.fy_starmoonaltar_fx = nil
end
--------------------
if not inst.fy_starmoonaltar_fx2 then
inst.fy_starmoonaltar_fx2 = SpawnPrefab("fy_starmoonaltar_fx2")
inst.fy_starmoonaltar_fx2.entity:AddFollower()
inst.fy_starmoonaltar_fx2.entity:SetParent(inst.entity)
inst.fy_starmoonaltar_fx2.Transform:SetPosition(0, 0, 0)
end
------------------
--if not inst.AnimState:IsCurrentAnimation("fy_StarMoonAltar_build") then
--inst.AnimState:PlayAnimation("fy_StarMoonAltar_build",true)
--end
end
-------------
-------------
end
-----------------
end)
inst:AddComponent("inspectable")  -- 添加可检查组件
inst:AddComponent("lootdropper")  -- 添加掉落物组件
inst:AddComponent("workable")  -- 添加可工作组件
inst.components.workable:SetWorkAction(ACTIONS.HAMMER)  -- 设置工作动作
inst.components.workable:SetWorkLeft(10)  -- 设置剩余工作量 10下锤
inst.components.workable:SetOnFinishCallback(onhammered)  -- 设置完成回调
inst.components.workable:SetOnWorkCallback(onhit)  -- 设置工作回调
-- 添加精神光环组件
inst:AddComponent("sanityaura")
inst.components.sanityaura.aura = 3
inst:AddComponent("heater")--加热
inst.components.heater.heat = nil--初始数值
inst.components.heater:SetThermics(false, false)--参数热，冷
inst:ListenForEvent("onbuilt", onbuilt)  -- 监听建造完成事件
inst:AddComponent("trader")--交易
inst.components.trader:SetAcceptTest(function(inst, item, giver)
local xz = false
--唤星者魔杖
if item.prefab == "yellowstaff" then
--if inst.xz ~= true then inst.xz = true else return end
--if inst.xz ~= true then inst.xz = true giver.components.talker:Say("开始工作!") else giver.components.talker:Say("已经有了！") return end
inst.lx = false
inst.sz = inst.sz + (480*50)--480s 50天
if giver and giver.components.talker then
giver.components.talker:Say("太阳的力量就在我的手中！")
end
xz = true
end
-- 唤月者魔杖
if item.prefab == "opalstaff" then
--if inst.xz ~= true then inst.xz = true giver.components.talker:Say("开始工作!") else giver.components.talker:Say("已经有了！") return end
inst.lx = true
inst.sz = inst.sz + (480*50)--480s 50天
if giver and giver.components.talker then
giver.components.talker:Say("凛冬将至！")
end
xz = true
end
return xz
end)
return inst  -- 返回实体
end
local fy_starmoonaltar = "焚星炉"
STRINGS.NAMES.FY_STARMOONALTAR = fy_starmoonaltar
STRINGS.RECIPE_DESC.FY_STARMOONALTAR = fy_starmoonaltar
STRINGS.CHARACTERS.GENERIC.DESCRIBE.FY_STARMOONALTAR = fy_starmoonaltar
-- 蓝图fy_starmoonaltar_blueprint
return Prefab("fy_starmoonaltar", fn),
MakePlacer("fy_starmoonaltar_placer", "heat_star_flame", "heat_star_flame", "idle")  -- 创建放置器