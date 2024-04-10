Framework = nil


if Config.Framework == "ESX" or Config.Framework == "NewESX" then
    Citizen.CreateThread(function()
        Framework = GetFramework()
            while Framework == nil do
                TriggerEvent(
                    "esx:getSharedObject",
                    function(obj)
                        Framework = obj
                    end
                )Citizen.Wait(4)
            end       

            Framework.RegisterServerCallback('SellVehicles', function(source, cb, Plate, Price, Refund)
                local Player = Framework.GetPlayerFromId(source)
                local Data = Framework.GetPlayerFromId(source).identifier
                if GetResourceState('mysql-async') == 'started' then
                local result = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE owner = ? AND plate = ?', {Data, Plate})
                Cash = Price * (Refund * 0.01)
                if result[1] then 
                    Player.addMoney(Cash)
                    MySQL.Sync.fetchAll('DELETE FROM owned_vehicles WHERE plate = ?', { Plate })
                    cb(true)
                else
                    cb(false)
                end
                elseif GetResourceState('ghmattimysql') == 'started' then
                local result = exports.ghmattimysql:execute('SELECT * FROM owned_vehicles WHERE owner = ? AND plate = ?', {Data, Plate})
                Cash = Price * (Refund * 0.01)
                if result[1] then 
                    Player.addMoney(Cash)
                    exports.ghmattimysql:execute('DELETE FROM owned_vehicles WHERE plate = ?', { Plate })
                    cb(true)
                else
                    cb(false)
                end
                elseif GetResourceState('oxmysql') == 'started' then
                local result = exports.oxmysql:execute('SELECT * FROM owned_vehicles WHERE owner = ? AND plate = ?', {Data, Plate})
                Cash = Price * (Refund * 0.01)
                if result[1] then 
                    Player.addMoney(Cash)
                    exports.oxmysql:execute('DELETE FROM owned_vehicles WHERE plate = ?', { Plate })
                    cb(true)
                else
                    cb(false)
                end
                end
            end)

            Framework.RegisterServerCallback("isPrice", function(source, cb, money)
                local Player = Framework.GetPlayerFromId(source)
                if Player.getMoney() >= tonumber(money) then 
                    Player.removeMoney(tonumber(money))
                    cb(true)
                else
                    cb(false)
                end
            end)

            
            RegisterServerEvent('vehicleshop:setVehicleOwned', function (Plate,Props, Model)
                local Player = Framework.GetPlayerFromId(source).identifier
                if GetResourceState('oxmysql') == 'started' then
                    exports.oxmysql:insert('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (?, ?, ?) ', {Player, Plate, json.encode(Props)})
                elseif GetResourceState('ghmattimysql') == 'started' then
                    exports.ghmattimysql:execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (?, ?, ?) ', {Player, Plate, json.encode(Props)})
                elseif GetResourceState('mysql-async') == 'started' then
                    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (?, ?, ?) ', {Player, Plate, json.encode(Props)})
                end
            end)
            
         
             end
            )         
elseif Config.Framework == "QBCore" or Config.Framework == "OLDQBCore" then
    if Config.Framework == "OLDQBCore" then
        while Framework == nil do
            TriggerEvent(
                "QBCore:GetObject",
                function(obj)
                    Framework = obj
                end
            )
            Citizen.Wait(4)
        end
    else
        Framework = exports["qb-core"]:GetCoreObject()
        

         
        Framework.Functions.CreateCallback("isPrice", function(source, cb, money)
            local Player = Framework.Functions.GetPlayer(source)
            if Player.Functions.RemoveMoney('bank', money) then
                cb(true)
            else
                cb(false)
            end
        end)

        
        RegisterServerEvent('vehicleshop:setVehicleOwned', function(Plate, Props, Model)
            local Player = Framework.Functions.GetPlayer(source)
            if GetResourceState('oxmysql') == 'started' then
                exports.oxmysql:insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?) ', {Player.PlayerData.license, Player.PlayerData.citizenid, Model, GetHashKey(Model), json.encode(Props), Plate, 0})
            elseif GetResourceState('ghmattimysql') == 'started' then
                exports.ghmattimysql:execute('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?) ', {Player.PlayerData.license, Player.PlayerData.citizenid, Model, GetHashKey(Model), json.encode(Props), Plate, 0})
            elseif GetResourceState('mysql-async') == 'started' then
                MySQL.Async.execute('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?) ', {Player.PlayerData.license, Player.PlayerData.citizenid, Model, GetHashKey(Model), json.encode(Props), Plate, 0})
            end
            TriggerClientEvent('QBCore:Notify', source, 'Buena compra!', 'success')
        end)
    end
end

