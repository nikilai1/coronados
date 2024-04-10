local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('facuG:client:dardinero', function(idTest)
    local ped = PlayerPedId()
    if not IsPedRagdoll(ped) then
        local player, distance = QBCore.Functions.GetClosestPlayer()
        print('efasdas')
        local playerId = idTest
        print(idTest)
        if  playerId ~= -1 and distance < 2.5 then
            if not IsPedInAnyVehicle(GetPlayerPed(playerId)) and not IsPedInAnyVehicle(ped) then
                TriggerEvent("facuG:client:bill", playerId)
            else
                QBCore.Functions.Notify('No puedes dar dinero si esta dentro de un vehiculo', "error")
            end
        else
            QBCore.Functions.Notify('No tienes a nadie cerca!', "error")
        end
    end
end)

-- Register --

RegisterNetEvent("facuG:client:bill", function(id)
    local bill = exports["qb-input"]:ShowInput({
        header = "Entregar dinero a id:"..id.."",
        submitText = "Entregar",
        inputs = {
            {
                type = 'number',
                name = "amount",
                text = '$',
                isRequired = true
            },
        }
    })
    bill.id = id or 0
    if bill ~= nil then
        if not bill.id or not bill.amount then
            return
        end
        TriggerServerEvent("facuG:client:bill:player", bill.id, bill.amount)
    end
end)



-- Register --

RegisterNetEvent("facuG:client:removekey", function(id)
    local platesxd2 = exports["qb-input"]:ShowInput({
        header = "Retirar llave a: "..id.."",
        submitText = "Quitar",
        inputs = {
            {
                type = 'text',
                name = "plate",
                text = 'Plate',
                isRequired = true
            },
        }
    })
    platesxd2.id = id
    if platesxd2 ~= nil then
        if platesxd2.id ~= nil and platesxd2.plate ~= nil then
            print(platesxd2.id..platesxd2.plate)
            TriggerServerEvent("facug:server:quitarllave", platesxd2.id, platesxd2.plate)
        end
        
    end
end)



exports['qb-target']:AddGlobalPlayer {
    options = {
        {
            type = "client",
            --event = "facuG:client:dardinero", 
            icon = "fas fa-hands",
            label = "Dar dinero",   
            action = function(entity) 
                    if IsPedAPlayer(entity) then 
                        local idtest22 = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
                        TriggerEvent('facuG:client:dardinero', idtest22) -- Triggers a client event called testing:event and sends the argument 'test' with it
                    end 
                end,
        }--[[,
        {
            type = "client",
            --event = "facuG:client:dardinero", 
            icon = "fas fa-hands",
            label = "Dar llaves",   
            action = function(entity) 
                    if IsPedAPlayer(entity) then 
                        local idtest22 = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
                        TriggerEvent('qb-vehiclekeys:client:GiveKeys', idtest22) -- Triggers a client event called testing:event and sends the argument 'test' with it
                    end 
                end,
        },
        {
            type = "client",
            --event = "facuG:client:dardinero", 
            icon = "fas fa-hands",
            label = "Quitar llave",   
            action = function(entity) 
                    if IsPedAPlayer(entity) then 
                        local idtest22 = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
                        TriggerEvent('facuG:client:removekey', idtest22) -- Triggers a client event called testing:event and sends the argument 'test' with it
                    end 
                end, 
        }]]
    },
    distance = 1.5,
}