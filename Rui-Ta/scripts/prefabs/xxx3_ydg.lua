local assets = {
    Asset('ANIM', 'anim/xxx3_ydg.zip'),
    Asset('ANIM', 'anim/xxx3_chydg.zip'),
    Asset('ATLAS', 'images/xxx3_ydg.xml'),
    Asset('IMAGE', 'images/xxx3_ydg.tex'),
    Asset('ATLAS', 'images/xxx3_chydg.xml'),
    Asset('IMAGE', 'images/xxx3_chydg.tex')
}

local function oneaten(inst, eater)
    if
        eater.components.debuffable ~= nil and eater.components.debuffable:IsEnabled() and
            not (eater.components.health ~= nil and eater.components.health:IsDead()) and
            not eater:HasTag('playerghost')
     then
        eater.components.debuffable:AddDebuff('xxx3_healthregenbuff', 'xxx3_healthregenbuff')
        eater.components.debuffable:AddDebuff('buff_xxx3_chydg', 'buff_xxx3_chydg')
    end
end

local function makeydg(name, ex)
    local function fn()
        local inst = CreateEntity()
        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()
        inst.entity:AddLight()

        inst.AnimState:SetBank(name)
        inst.AnimState:SetBuild(name)
        inst.AnimState:PlayAnimation('idle')

        inst.Light:Enable(true)
        inst.Light:SetRadius(.5)
        inst.Light:SetFalloff(.7)
        inst.Light:SetIntensity(.5)
        inst.Light:SetColour(255 / 255, 255 / 255, 0 / 255)

        MakeInventoryPhysics(inst)

        MakeInventoryFloatable(inst)

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent('inspectable')
        inst:AddComponent('inventoryitem')
        inst.components.inventoryitem.atlasname = 'images/' .. name .. '.xml'

        inst:AddComponent('edible')
        inst.components.edible.sanityvalue = 1000

        inst:AddComponent('stackable')
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

        if ex then
            ex(inst)
        end

        return inst
    end

    return Prefab(name, fn, assets)
end

return makeydg('xxx3_ydg', nil), makeydg(
    'xxx3_chydg',
    function(inst)
        inst.components.edible.hungervalue = 75
        inst.components.edible.healthvalue = 75
        inst.components.edible:SetOnEatenFn(oneaten)
    end
)
