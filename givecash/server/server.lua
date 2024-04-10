local QBCore = exports['qb-core']:GetCoreObject()


function RemoveKeys(id, plate)
    local citizenid = QBCore.Functions.GetPlayer(id).PlayerData.citizenid

    if VehicleList[plate] and VehicleList[plate][citizenid] then
        VehicleList[plate][citizenid] = nil
    end

    TriggerClientEvent('qb-vehiclekeys:client:RemoveKeys', id, plate)
end

RegisterNetEvent('facug:server:removekeys', function(id, plate)
    RemoveKeys(id, plate)
end)


--Billing--
RegisterServerEvent("facuG:client:bill:player", function(playerId, amount)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local xReciv = QBCore.Functions.GetPlayer(tonumber(playerId))
    local amount = tonumber(amount)
    if xReciv and xPlayer then
        if not xPlayer.PlayerData.metadata["isdead"] then
            local distance = xPlayer.PlayerData.metadata["inlaststand"] and 1.5 or 2.5
            if #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(playerId))) < distance then
                if amount > 0 then
                    if xPlayer.Functions.RemoveMoney('cash', amount) then
                        if xReciv.Functions.AddMoney('cash', amount) then
                            TriggerClientEvent('QBCore:Notify', src, "Le entregaste $"..tostring(amount).." a "..tostring(playerId), "success")
                            TriggerClientEvent('QBCore:Notify', playerId, "Recibiste $"..tostring(amount).." de "..tostring(src), "success")
                            TriggerClientEvent("payanimation", src)
                        else
                            -- Return player cash
                            xPlayer.Functions.AddMoney('cash', amount)
                            TriggerClientEvent('QBCore:Notify', src, "Persona desconectada", "error")
                        end
                    else
                        TriggerClientEvent('QBCore:Notify', src, "No tienes el dinero suficiente", "error")
                    end
                else
                    TriggerClientEvent('QBCore:Notify', src, "Cantidad invalida", "error")
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "Estas muy lejos de la persona", "error")
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "No puedes pasar dinero estando muerto", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "No se encontro a la persona", "error")
    end

end)