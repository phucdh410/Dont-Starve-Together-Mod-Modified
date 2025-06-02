local DPS = 8
local DURATION = 10 --Second
local STACKS = 5

local function ApplyPoisonEffect(target)
  if not target.components.health or target.components.health:IsDead() then
    return
  end
  
  if not target.poison_data = then
    target.poison_data = {
      stacks = 0,
      timer = 0,
      task = nil
    }
  end

  if target.poison_data.stacks < STACKS then
    target.poison_data.stacks = target.poison_data.stacks + 1
  end

  target.poison_data.timer = DURATION

  if not target.poison_data.task then
    target.poison_data.task = target:DoPeriodicTask(1, function()
        if target.poison_data.timer > 0 then
            local damage = DPS * target.poison_data.stacks
            target.components.health:DoDelta(-damage, false, "poison")
            target.poison_data.timer = target.poison_data.timer - 1

            if target.SoundEmitter then
                target.SoundEmitter:PlaySound("dontstarve/common/tentacle_splat")
            end
        else
            -- Stop poison effect when duration expires
            target.poison_data.task:Cancel()
            target.poison_data.task = nil
            target.poison_data.stacks = 0
            target.poison_data.timer = 0
        end
    end)
  end
end

AddPrefabPostInit("spear", function(inst)
  if not TheWorld.ismastersim then
      return inst
  end

  inst.components.weapon:SetOnAttack(function(inst, attacker, target)
      if target and target.components.health and not target.components.health:IsDead() then
          ApplyPoisonEffect(target)
      end
  end)
end)