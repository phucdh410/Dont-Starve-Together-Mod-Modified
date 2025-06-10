AddModRPCHandler("kkr", "Kkr_fly", function(player)
    if  player.components.kkrfly and not player:HasTag("playerghost") then
        local num_spirits = player.kkr_wind_spirit_leader and player.kkr_wind_spirit_leader.components.kkrspiritleader:GetFormationSize() or 0
        if player.components.kkrfly.kkr_fly == false and num_spirits > 0 then
            local formation = player.kkr_wind_spirit_leader.components.kkrspiritleader.formation
            local random_index = math.random(1, #formation)
            local random_element = formation[random_index]
            if random_element and random_element:IsValid() then
                random_element:Remove()
            end
            player.components.kkrfly:Fly()
        elseif player.components.kkrfly.kkr_fly == true then
            player.components.kkrfly:Land()
        end
    end
end)

AddModRPCHandler("kkr", "kkr_domain", function(player)
    if  player.kkr_domain and not player:HasTag("playerghost") then
        player:kkr_domain(player)
    end
end)
