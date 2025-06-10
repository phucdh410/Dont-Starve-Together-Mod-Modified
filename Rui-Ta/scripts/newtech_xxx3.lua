local TechTree = GLOBAL.require("techtree")

table.insert(TechTree.AVAILABLE_TECH, "WF")

TechTree.Create = function(t)
	t = t or {}
	for i, v in ipairs(TechTree.AVAILABLE_TECH) do
	    t[v] = t[v] or 0
	end
	return t
end

GLOBAL.TECH.NONE.WF = 0
GLOBAL.TECH.WF_ONE = { WF = 1 }

for k,v in pairs(TUNING.PROTOTYPER_TREES) do
    v.WF = 0
end

TUNING.PROTOTYPER_TREES.WF_ONE = TechTree.Create({
    WF = 1,
})

for i, v in pairs(GLOBAL.AllRecipes) do
	if v.level.WF == nil then
		v.level.WF = 0
	end
end
	