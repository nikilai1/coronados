local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('emn:sv:itemSil')
AddEventHandler('emn:sv:itemSil', function(count)

    count = tonumber(count)
    if (not count or count <= 0) then return end
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if (Player) then
        Player.Functions.RemoveMoney('bank', count, "Mechanic")
    end
end)

