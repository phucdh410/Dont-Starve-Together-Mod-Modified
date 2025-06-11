if TUNING.UPDATELIST then
    AddModRPCHandler(
        "SimpleEconomy",
        "updatelist",
        function(player)
            GLOBAL.package.loaded["SEscripts/itemlist"] = nil

            TheWorld.components.seworldstatus:makelist()
            local tabhost = {
                TUNING.selist_food,
                TUNING.selist_cloth,
                TUNING.selist_smithing,
                TUNING.selist_resource,
                TUNING.selist_precious,
                TUNING.selist_special
            }
            local data = {}

            for k, v in ipairs(tabhost) do
                data[k] = {unpack(v)}
            end
            local tabs = GLOBAL.json.encode(data)

            SendModRPCToClient(GetClientModRPC("SimpleEconomy", "updatelist"), player, tabs)
        end
    )

    AddClientModRPCHandler(
        "SimpleEconomy",
        "updatelist",
        function(tabs)
            TUNING.tabc = GLOBAL.json.decode(tabs)
        end
    )
end

AddModRPCHandler(
    "SimpleEconomy",
    "sebuy",
    function(player, iname, more, lastskin)
        local alllist = {}

        for key, value in pairs(TUNING.allgoods) do
            table.insert(alllist, value)
        end

        for key, value in pairs(TUNING.selist_low) do
            table.insert(alllist, value)
        end
        local iprice = 100000
        for k, v in pairs(alllist) do
            if iname == v.name then
                iprice = v.price
                if not iprice then
                    return
                end
                if TUNING.FIXTWOPRICE and iname == "luckamulet" or TUNING.FIXTWOPRICE and iname == "goldstaff" then
                else
                    iprice = iprice * TUNING.PRICERATE
                end

                break
            end
        end
        local iiname = iname
        local multi = 1
        if more then
            multi = 10
        end

        local discount = player.components.seplayerstatus.discount
        if iiname == "vipcard" or iiname == "luckamulet" then
            discount = 1
            TUNING.discount_new = 1
        end

        if player.components.health.currenthealth > 0 and not player:HasTag("playerghost") then
            if player.components.seplayerstatus.coin >= math.ceil(iprice * discount) * multi then
                for i = 1, multi do
                    if iname == "blueprint" and math.random(0, 20) <= 1 then
                        iiname = TUNING.selist_blueprint[math.random(#TUNING.selist_blueprint)].name
                    end
                    if iname == "medal_losswetpouch" then
                        iiname = "medal_losswetpouch" .. tostring(math.random(1, 7))
                    end
                    if iname == "ndnr_roe" then
                        if math.random(1, 2) == 1 then
                            iiname = "ndnr_roe_oceanfish_medium_" .. tostring(math.random(1, 9))
                        else
                            iiname = "ndnr_roe_oceanfish_small_" .. tostring(math.random(1, 9))
                        end
                    end
                    local item = GLOBAL.SpawnPrefab(iiname, lastskin, nil, player.userid)
                    player.components.inventory:GiveItem(item, nil, player:GetPosition())

                    for _, blueprint in ipairs(TUNING.selist_blueprint) do
                        if iiname == blueprint.name then
                            iiname = "blueprint"
                            break
                        end
                    end
                end
                player.components.seplayerstatus:DoDeltaCoin(-iprice, multi)
            end
        else
            if TUNING.GHOSTSHOPPING then
                if player.components.seplayerstatus.coin >= math.ceil(iprice * discount) * multi then
                    local pt = Point(player.Transform:GetWorldPosition())
                    for i = 1, multi do
                        if iname == "blueprint" and math.random(0, 40) <= 1 then
                            iiname = TUNING.selist_blueprint[math.random(#TUNING.selist_blueprint)].name
                        end
                        if iname == "medal_losswetpouch" then
                            iiname = "medal_losswetpouch" .. tostring(math.random(1, 7))
                        end
                        if iname == "ndnr_roe" then
                            if math.random(1, 2) == 1 then
                                iiname = "ndnr_roe_oceanfish_medium_" .. tostring(math.random(1, 9))
                            else
                                iiname = "ndnr_roe_oceanfish_small_" .. tostring(math.random(1, 9))
                            end
                        end
                        local angle = math.random() * 2 * GLOBAL.PI
                        local loots = GLOBAL.SpawnPrefab(iiname, lastskin, nil, player.userid)
                        loots.Transform:SetPosition(pt.x, pt.y, pt.z)
                        loots.Physics:SetVel(2 * math.cos(angle), 10, 2 * math.sin(angle))

                        for _, blueprint in ipairs(TUNING.selist_blueprint) do
                            if iiname == blueprint.name then
                                iiname = "blueprint"
                                break
                            end
                        end
                    end
                    player.components.seplayerstatus:DoDeltaCoin(-iprice, multi)
                end
            end
        end
    end
)

AddModRPCHandler(
    "SimpleEconomy",
    "refresh",
    function(player)
        if player.components.seplayerstatus.coin >= TUNING.Refresh_Price then
            player.components.seplayerstatus:preciousbuild()
            if player.components.seplayerstatus.preciouschange == true then
                player.components.seplayerstatus.preciouschange = false
            else
                player.components.seplayerstatus.preciouschange = true
            end
            player.components.seplayerstatus:DoDeltaCoin(-TUNING.Refresh_Price)
        end
    end
)
