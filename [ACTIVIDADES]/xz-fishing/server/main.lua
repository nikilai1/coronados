QBCore = nil

local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('qb-fishing:GetItemData', function(source, cb, itemName)
	local retval = false
	local Player = QBCore.Functions.GetPlayer(source)
	if Player ~= nil then 
		if Player.Functions.GetItemByName(itemName) ~= nil then
			retval = true
		end
	end
	
	cb(retval)
end)	

QBCore.Functions.CreateUseableItem("fishingrod", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)

    TriggerClientEvent('qb-fishing:tryToFish', source)
end)
RegisterServerEvent('qb-fishing:removeItemV2')
AddEventHandler('qb-fishing:removeItemV2', function (item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	randomItem = item
	itemInfo = QBCore.Shared.Items[randomItem]
	Player.Functions.RemoveItem(randomItem, 1)
	TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "remove")
end)
RegisterServerEvent('qb-fishing:receiveFish')
AddEventHandler('qb-fishing:receiveFish', function(cabin, house)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local luck = math.random(1, 100)
    local itemFound = true
    local itemCount = 1

    if itemFound then
        for i = 1, itemCount, 1 do
            local randomItem = Config.FishingItems["type"]math.random(1, 2)
            local itemInfo = QBCore.Shared.Items[randomItem]
			if luck >= 95 and luck <= 100 then
				randomItem = "bluefish"
				itemInfo = QBCore.Shared.Items[randomItem]
                Player.Functions.AddItem(randomItem, 1)
				TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "add")
			elseif luck >= 90 and luck <= 95 then
				randomItem = "largemouthbass"
				itemInfo = QBCore.Shared.Items[randomItem]
                Player.Functions.AddItem(randomItem, 1)
				TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "add")
			elseif luck >= 80 and luck <= 90 then
				randomItem = "salmon"
				itemInfo = QBCore.Shared.Items[randomItem]
                Player.Functions.AddItem(randomItem, 1)
				TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "add")
			elseif luck >= 0 and luck <= 80 then
				randomItem = "fish"
				itemInfo = QBCore.Shared.Items[randomItem]
                Player.Functions.AddItem(randomItem, 1)
				TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "add")
            end
            Citizen.Wait(500)
        end
    end
end)

RegisterServerEvent("qb-fishing:sellFish")
AddEventHandler("qb-fishing:sellFish", function()
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local price = 0
    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then 
                if Player.PlayerData.items[k].name == "fish" then 
                    price = price + (Config.FishingItems["fish"]["price"] * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("fish", Player.PlayerData.items[k].amount, k)
				elseif Player.PlayerData.items[k].name == "largemouthbass" then 
                    price = price + (Config.FishingItems["largemouthbass"]["price"] * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("largemouthbass", Player.PlayerData.items[k].amount, k)
				elseif Player.PlayerData.items[k].name == "salmon" then 
                    price = price + (Config.FishingItems["salmon"]["price"] * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("salmon", Player.PlayerData.items[k].amount, k)
				elseif Player.PlayerData.items[k].name == "bluefish" then 
                    price = price + (Config.FishingItems["bluefish"]["price"] * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("bluefish", Player.PlayerData.items[k].amount, k)
				elseif Player.PlayerData.items[k].name == "stingraymeat" then 
                    price = price + (Config.FishingItems["stingraymeat"]["price"] * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("stingraymeat", Player.PlayerData.items[k].amount, k) 
                end
            end
        end
        Player.Functions.AddMoney("cash", price, "sold-fish")
		TriggerClientEvent('QBCore:Notify', src, "You have sold your fish")
	end
end)