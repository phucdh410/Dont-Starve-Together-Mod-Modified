GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end}) --GLOBAL相关照抄
require "recipe"
GLOBAL.AllRecipes["rope_bridge_kit"].numtogive = 4
-- GLOBAL.AllRecipes["rope_bridge_kit"].numtogive=GetModConfigData("craft_count")

TUNING.DSTU =
{
    ROPEBRIDGE_LENGTH_TILES = GetModConfigData("rope_bridge_kit"),
}

AddPrefabPostInit("forest", function(inst)
	if not TheWorld.ismastersim then
		return
	end

	inst:AddComponent("ropebridgemanager")
end)

-- AddPrefabPostInit("rope_bridge_kit",function (inst)
-- 	local RopeBridge_Options=(function()
-- 		local i=1
-- 		while true do
-- 			local name,value=GLOBAL.debug.getupvalue(inst._custom_candeploy_fn,i)
-- 			if name=="RopeBridge_Options"then
-- 				return value
-- 			end
-- 		end
-- 	end)()
-- 	RopeBridge_Options.candeploybridgeatpointfn=function()return true end
-- end
-- )

