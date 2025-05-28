local function WobsterOnLand(inst)
  local lobsterAmount = GetModConfigData("lobsterAmount", KnownModIndex:GetModActualName("More Drops - DHPModified"))
  local lobsterType = GetModConfigData("lobsterType", KnownModIndex:GetModActualName("More Drops - DHPModified"))

	local x, y, z = inst.Transform:GetWorldPosition()
	if TheWorld.Map:IsPassableAtPoint(x, y, z) then
			local num = lobsterType and lobsterAmount or math.random(1, lobsterAmount)
			for i = 1, num do
					local angle = (i - 1) * (360 / num)
					local rad = math.rad(angle)
					local offset = 0.35
					local wobster = SpawnPrefab(inst.fish_def.prefab.."_land")
					wobster.Transform:SetPosition(
							x + math.cos(rad) * offset,
							y,
							z + math.sin(rad) * offset
					)
					wobster.Transform:SetRotation(inst.Transform:GetRotation())
					wobster.components.inventoryitem:SetLanded(true, false)
					if inst.components.weighable ~= nil and wobster.components.weighable ~= nil then
							wobster.components.weighable:CopyWeighable(inst.components.weighable)
					end
			end
			inst:Remove()
	else
			inst:RemoveComponent("complexprojectile")
			inst.Physics:SetCollisionMask(COLLISION.GROUND + COLLISION.LAND_OCEAN_LIMITS + COLLISION.OBSTACLES + COLLISION.SMALLOBSTACLES)
			inst.AnimState:SetSortOrder(ANIM_SORT_ORDER_BELOW_GROUND.UNDERWATER)
			inst.AnimState:SetLayer(LAYER_WIP_BELOW_OCEAN)
			inst.sg:GoToState("idle", "jump_pst")
			inst:RestartBrain()
			SpawnPrefab("splash").Transform:SetPosition(x, y, z)
			if inst.components.weighable ~= nil then
					inst.components.weighable:SetPlayerAsOwner(nil)
			end
	end
end

local function ImproveLobster(inst)
  inst.components.oceanfishable.makeprojectilefn = function(inst)
    inst:AddComponent("complexprojectile")
    inst.components.complexprojectile:SetOnHit(WobsterOnLand)
    inst:StopBrain()
    inst.sg:GoToState("launched_out_of_water")
    inst.Physics:SetCollisionMask(COLLISION.GROUND)
    inst.AnimState:SetSortOrder(0)
    inst.AnimState:SetLayer(LAYER_WORLD)
    SpawnPrefab("splash").Transform:SetPosition(inst.Transform:GetWorldPosition())
    return inst
  end
end

return ImproveLobster