local Recipe = GLOBAL.Recipe
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local STRINGS = GLOBAL.STRINGS
local TUNING = GLOBAL.TUNING
local ACTIONS = GLOBAL.ACTIONS
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local STRINGS = GLOBAL.STRINGS
local TECH = GLOBAL.TECH
local STRINGS = GLOBAL.STRINGS
local ACTIONS = GLOBAL.ACTIONS
local Action = GLOBAL.Action
local require = GLOBAL.require
local EQUIPSLOTS = GLOBAL.EQUIPSLOTS
local GetString=GLOBAL.GetString
local SpawnPrefab=GLOBAL.SpawnPrefab



local function SuggetTarget(inst, attacker, target)

	local pt = inst:GetPosition()    
	local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 3)
    for i, v in ipairs(ents) do

	if v.components.health ~= nil and v.components.combat ~= nil then
		v.components.combat:SuggestTarget(attacker)
	end
	end

end


------- Small -------


local function Small(inst, attacker, target)
	local pt = inst:GetPosition()    

	SuggetTarget(inst, attacker, target)

    inst.SoundEmitter:KillSound("hiss")
	SpawnPrefab("smallbombactive").Transform:SetPosition(inst.Transform:GetWorldPosition())
inst.SoundEmitter:PlaySound("dontstarve/common/dropwood")

	
	

	

	
    inst:Remove()
end

------- Ice -------



local function Ice(inst, attacker, target)
	local pt = inst:GetPosition()    
SuggetTarget(inst, attacker, target)


    inst.SoundEmitter:KillSound("hiss")
	SpawnPrefab("icebombactive").Transform:SetPosition(inst.Transform:GetWorldPosition())
    inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")

	
	

	

	
    inst:Remove()
end


------- Volt -------

local function Volt(inst, attacker, target)
	local pt = inst:GetPosition()    
SuggetTarget(inst, attacker, target)


    inst.SoundEmitter:KillSound("hiss")
	SpawnPrefab("voltbombactive").Transform:SetPosition(inst.Transform:GetWorldPosition())
    inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")

	
	

	

	
    inst:Remove()
end


------- Sticky -------


local function Sticky(inst, attacker, target)
	local pt = inst:GetPosition()    
SuggetTarget(inst, attacker, target)

	
		SpawnPrefab("spat_splash_fx_full").Transform:SetPosition(inst.Transform:GetWorldPosition())
    inst.SoundEmitter:KillSound("hiss")
	SpawnPrefab("stickybombactive").Transform:SetPosition(inst.Transform:GetWorldPosition())
inst.SoundEmitter:PlaySound("dontstarve/creatures/spat/spit_hit")

	
	

	

	
    inst:Remove()
end

------- Shadow -------
local function Shadow(inst, attacker, target)
	local pt = inst:GetPosition()    
SuggetTarget(inst, attacker, target)

	SpawnPrefab("shadowbombactive").Transform:SetPosition(inst.Transform:GetWorldPosition())

	
    inst:Remove()
end











local function ChangeOnHit(inst, tag)
	if inst.components.complexprojectile then
		if tag == "Small" then
			inst.components.complexprojectile:SetOnHit(Small)
		
		elseif tag == "Shadow" then
			inst.components.complexprojectile:SetOnHit(Shadow)

		elseif tag == "Sticky" then
			inst.components.complexprojectile:SetOnHit(Sticky)

		elseif tag == "Volt" then
			inst.components.complexprojectile:SetOnHit(Volt)

		elseif tag == "Ice" then
			inst.components.complexprojectile:SetOnHit(Ice)
			
		end
	end
end


AddPrefabPostInit("smallbomb", function(inst) ChangeOnHit(inst, "Small") end)
AddPrefabPostInit("shadowbomb", function(inst) ChangeOnHit(inst, "Shadow") end)
AddPrefabPostInit("stickybomb", function(inst) ChangeOnHit(inst, "Sticky") end)
AddPrefabPostInit("voltbomb", function(inst) ChangeOnHit(inst, "Volt") end)
AddPrefabPostInit("icebomb", function(inst) ChangeOnHit(inst, "Ice") end)


