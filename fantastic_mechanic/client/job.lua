QBCore = nil
PlayerData = {}

jobName = nil

CreateThread(function()
    while (QBCore == nil) do
		QBCore = exports['qb-core']:GetCoreObject()
		Wait(100)
    end
    
    for k in pairs(Config.Locations) do
      addBlip(Config.Locations[k].blip, 446, Config.Locations[k].blipcolor, Config.Locations[k].bliplabel, 0.7)
      print(Config.Locations[k].bliplabel)
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = xPlayer
end)


