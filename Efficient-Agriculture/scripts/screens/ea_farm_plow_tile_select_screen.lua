local json = require "json"
local Widget = require "widgets/widget"
local Screen = require "widgets/screen"
local Text = require "widgets/text"
local Templates = require "widgets/redux/templates"
local PlowTileSelect = require "widgets/ea_tile_selection"

local PlowTileSelectScreen = Class(Screen, function(self, owner, data)
	Screen._ctor(self, "PlowTileSelectScreen")
	self.owner = owner
    self:SetScaleMode(SCALEMODE_PROPORTIONAL)
	--ROOTS
    self.root = self:AddChild(Widget("ROOT"))
	self.top_root = self:AddChild(Widget("ROOT"))
	self.top_root:SetVAnchor(ANCHOR_TOP)
	self.top_root:SetHAnchor(ANCHOR_MIDDLE)

	self.title = self.top_root:AddChild(Text(TITLEFONT, 64, STRINGS.EA_PLAN_PLOW_TILES, RGB(255, 255, 255)))
	self.title:SetPosition(0, -50)

	self.ok_bt = self.top_root:AddChild(Templates.StandardButton(function()
		local tiles = self.selection_function and self.selection_function:GetSelectedTiles()
		if tiles then
			local _tiles = {}
			for x, zs in pairs(tiles) do
				for z, _ in pairs(zs) do
					table.insert(_tiles, {x, z})
				end
			end
			SendModRPCToServer(MOD_RPC[EA_CONSTANTS.RPC_NAMESPACE].spawn_plowsolid, json.encode(_tiles))
		end
        TheFrontEnd:PopScreen()
	end, STRINGS.EA_OK, {100, 50}))
	self.ok_bt:SetPosition(-80, -100)

	self.cancel_bt = self.top_root:AddChild(Templates.StandardButton(function()
        TheFrontEnd:PopScreen()
	end, STRINGS.EA_CANCEL, {100, 50}))
	self.cancel_bt:SetPosition(80, -100)

	self.data = data
end)

function PlowTileSelectScreen:OnDestroy()
    SetAutopaused(false)
    POPUPS.EA_PLOW_TILE_SELECT:Close(self.owner)
	PlowTileSelectScreen._base.OnDestroy(self)
end

function PlowTileSelectScreen:OnBecomeInactive()
    PlowTileSelectScreen._base.OnBecomeInactive(self)
	TheEAInteractive:StopFunction(self.selection_function)
	if self.selection_function then
		self.selection_function:Kill()
	end
end

function PlowTileSelectScreen:OnBecomeActive()
    PlowTileSelectScreen._base.OnBecomeActive(self)
	if self.selection_function then
		self.selection_function:Kill()
	end
	self.selection_function = self:AddChild(PlowTileSelect())
	-- self.selection_function:SetDisableTileType({"FARMING_SOIL"})
	TheEAInteractive:StartFunction(self.selection_function)

	if not self.data then
		return
	end

	local tiles = {}
	for _, tile in ipairs(self.data) do
		local x, z = tile[1], tile[2]
		if not tiles[x] then
			tiles[x] = {}
		end
		tiles[x][z] = true
	end
	self.selection_function:Select(tiles)
end

function PlowTileSelectScreen:OnControl(control, down)
    if PlowTileSelectScreen._base.OnControl(self, control, down) then return true end

    if not down and (control == CONTROL_MAP or control == CONTROL_CANCEL) then
		TheFrontEnd:GetSound():PlaySound("dontstarve/HUD/click_move")
        TheFrontEnd:PopScreen()
        return true
    end

	return false
end

return PlowTileSelectScreen
