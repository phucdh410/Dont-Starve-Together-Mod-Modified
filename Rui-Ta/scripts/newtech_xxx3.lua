--------------------------------------------------------------------------
--[[ 修改默认的科技树生成方式 ]]
--------------------------------------------------------------------------

local TechTree = GLOBAL.require("techtree")

table.insert(TechTree.AVAILABLE_TECH, "WF")	--其实就是加个自己的科技树名称

TechTree.Create = function(t)
	t = t or {}
	for i, v in ipairs(TechTree.AVAILABLE_TECH) do
	    t[v] = t[v] or 0
	end
	return t
end

--------------------------------------------------------------------------
--[[ 制作等级中加入自己的部分 ]]
--------------------------------------------------------------------------

GLOBAL.TECH.NONE.WF = 0
GLOBAL.TECH.WF_ONE = { WF = 1 }

--------------------------------------------------------------------------
--[[ 解锁等级中加入自己的部分 ]]
--------------------------------------------------------------------------

for k,v in pairs(TUNING.PROTOTYPER_TREES) do
    v.WF = 0
end

--WF_ONE可以改成任意的名字，这里和TECH.WF_ONE名字相同只是懒得改了
TUNING.PROTOTYPER_TREES.WF_ONE = TechTree.Create({
    WF = 1,
})

--------------------------------------------------------------------------
--[[ 修改全部制作配方，对缺失的值进行补充 ]]
--------------------------------------------------------------------------

-- AddPrefabPostInit("player_classified", function(inst)
-- 	inst.techtrees = GLOBAL.deepcopy(GLOBAL.TECH.NONE)
-- end)

for i, v in pairs(GLOBAL.AllRecipes) do
	if v.level.WF == nil then
		v.level.WF = 0
	end
end
	