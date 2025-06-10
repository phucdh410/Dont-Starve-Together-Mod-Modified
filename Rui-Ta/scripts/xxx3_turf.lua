local tile_assets = {
    
    Asset('ANIM', 'anim/xxx3_turf.zip'),
    Asset('IMAGE', 'images/inventoryimages/xxx3_turf_item.tex'),
    Asset('ATLAS', 'images/inventoryimages/xxx3_turf_item.xml')
}

for _, asset in ipairs(tile_assets) do
    table.insert(Assets, asset)
end

AddTile(
    'XXX3_TURF', 
    'LAND', 
    {
        ground_name = 'xxx3_turf' 
    },
    {
        name = 'yellowgrass', 
        noise_texture = 'xxx3_turf', 
        
        runsound = 'dontstarve/movement/run_grass',
        walksound = 'dontstarve/movement/run_grass',
        snowsound = 'dontstarve/movement/run_snow',
        mudsound = 'dontstarve/movement/run_mud',
        cannotbedug = nil 
    },
    {
        name = 'map_edge',
        noise_texture = 'quagmire_parkfield_mini' 
    },
    
    {
        name = 'xxx3_item', 
        anim = 'idle', 
        bank_build = 'xxx3_turf'
    }
)

AddTile(
    'XXX3_TURF_SP', 
    'LAND', 
    {
        ground_name = 'xxx3_turf_sp' 
    },
    {
        name = 'yellowgrass', 
        noise_texture = 'xxx3_turf', 
        
        runsound = 'dontstarve/movement/run_grass',
        walksound = 'dontstarve/movement/run_grass',
        snowsound = 'dontstarve/movement/run_snow',
        mudsound = 'dontstarve/movement/run_mud',
        cannotbedug = true,
        hard = true,
        istemptile = true
    },
    {
        name = 'map_edge',
        noise_texture = 'quagmire_parkfield_mini' 
    }
)

local function AddTurfInventoryImages(turf_data)
    for _, data in ipairs(turf_data) do
        AddPrefabPostInit(
            data.prefab,
            function(inst)
                if not TheWorld.ismastersim then
                    return inst
                end

                if inst.components.inventoryitem then
                    inst.components.inventoryitem.atlasname = 'images/inventoryimages/' .. data.atlasname .. '.xml'
                    inst.components.inventoryitem.imagename = data.imagename
                end
            end
        )
    end
end
local turf_data = {
    {prefab = 'turf_xxx3_item', atlasname = 'xxx3_turf_item', imagename = 'xxx3_turf_item'}
}
AddTurfInventoryImages(turf_data)

ChangeTileRenderOrder(WORLD_TILES.XXX3_TURF, WORLD_TILES.WOODFLOOR, true)
ChangeTileRenderOrder(WORLD_TILES.XXX3_TURF_SP, WORLD_TILES.WOODFLOOR, true)
