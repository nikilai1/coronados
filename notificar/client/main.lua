local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('Thedoc_JobNotifications:client:showui')
AddEventHandler('Thedoc_JobNotifications:client:showui', function(job, msg, idplayer)
    SendNUIMessage({
        type = 'open',
        job = job,
        msg = msg,
        id = idplayer
    })
end)


RegisterNUICallback('limitexceded', function(data, cb)
    print(json.encode(data))
    local PlayerData = QBCore.Functions.GetPlayerData()
    local id = PlayerData.metadata.id
    print(json.encode(PlayerData.source))
    if PlayerData.source == data.id then
        QBCore.Functions.Notify(Config.limitexcededMessage)
    end
    print(GetPlayerFromServerId(GetPlayerPed(-1)))
end)

