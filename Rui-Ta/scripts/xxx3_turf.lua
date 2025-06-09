local tile_assets = {
    -- 地皮的资源文件
    Asset('ANIM', 'anim/xxx3_turf.zip'),
    Asset('IMAGE', 'images/inventoryimages/xxx3_turf_item.tex'),
    Asset('ATLAS', 'images/inventoryimages/xxx3_turf_item.xml')
}

for _, asset in ipairs(tile_assets) do
    table.insert(Assets, asset)
end

AddTile(
    'XXX3_TURF', --地皮名称
    'LAND', --地皮类型
    {
        ground_name = 'xxx3_turf' --自定义名字
    },
    {
        name = 'yellowgrass', --边缘样式 比如 牛毛地毯carpet 棋盘blocky 也可以自己做。这里设置为我们文件里的
        noise_texture = 'xxx3_turf', --这里是图片
        --定义在地皮上行走的声音
        runsound = 'dontstarve/movement/run_grass',
        walksound = 'dontstarve/movement/run_grass',
        snowsound = 'dontstarve/movement/run_snow',
        mudsound = 'dontstarve/movement/run_mud',
        cannotbedug = nil --标记为true则不能挖掉
    },
    {
        name = 'map_edge',
        noise_texture = 'quagmire_parkfield_mini' --小地图图片
    },
    --挖掉的定义，如果这个表为空则挖掉之后不掉地皮
    {
        name = 'xxx3_item', -- 掉落物的代码
        anim = 'idle', -- Ground item
        bank_build = 'xxx3_turf'
    }
)

AddTile(
    'XXX3_TURF_SP', --地皮名称
    'LAND', --地皮类型
    {
        ground_name = 'xxx3_turf_sp' --自定义名字
    },
    {
        name = 'yellowgrass', --边缘样式 比如 牛毛地毯carpet 棋盘blocky 也可以自己做。这里设置为我们文件里的
        noise_texture = 'xxx3_turf', --这里是图片
        --定义在地皮上行走的声音
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
        noise_texture = 'quagmire_parkfield_mini' --小地图图片
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
