local assets =
{
    Asset("ANIM", "anim/des_bcannon.zip"),
    --Asset("ANIM", "anim/ds_pig_basic.zip"),
   -- Asset("ANIM", "anim/ds_pig_actions.zip"),
   -- Asset("ANIM", "anim/ds_pig_attacks.zip"),
  --  Asset("SOUND", "sound/merm.fsb"),
}

local function OnWorked(inst, worker)
    inst.SoundEmitter:PlaySound("dontstarve/common/together/catapult/hit")
end

local function OnWorkFinished(inst, worker)
    --inst.components.lootdropper:DropLoot()
	
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("none")
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_metal")
	
	inst:Remove()
end


local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, .2)

    inst.DynamicShadow:SetSize(1.5, .75)

    inst:AddTag("des_bcannon")
   
    inst.AnimState:SetBank("des_bcannon")
    inst.AnimState:SetBuild("des_bcannon")
	inst.AnimState:PlayAnimation("idle")

	local s = 3.7	
	inst.Transform:SetScale(s,s,s )
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("container")
	inst.components.container:WidgetSetup("des_bcannon")
   
    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(5)
	inst.components.workable:SetOnFinishCallback(OnWorkFinished)
	inst.components.workable:SetOnWorkCallback(OnWorked)
	-- inst.components.lootdropper:SetLoot(loot)


    inst:AddComponent("inspectable")

    --MakeMediumBurnableCharacter(inst, "pig_torso")
    --MakeMediumFreezableCharacter(inst, "pig_torso")

   --- inst:ListenForEvent("attacked", OnAttacked)

    return inst
end

return Prefab("des_bcannon", fn, assets, prefabs),
    MakePlacer("des_bcannon_placer", "des_bcannon", "des_bcannon", "placer" ) 

