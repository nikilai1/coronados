local packageCache = {}

--- Events

RegisterNetEvent('ps-weedplanting:server:CollectPackageGoods', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local citizenid = Player.PlayerData.citizenid
    if not packageCache[citizenid] then return end

    if packageCache[citizenid] == 'waiting' then
        TriggerClientEvent('QBCore:Notify', src, _U('still_waiting'), 'error', 2500)
    elseif packageCache[citizenid] == 'done' then
        packageCache[citizenid] = nil
        TriggerClientEvent('ps-weedplanting:client:PackageGoodsReceived', src)
        if Player.Functions.AddItem(Shared.SusPackageItem, 1) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Shared.SusPackageItem], 'add', 1)
        end
    end
end)

RegisterNetEvent('ps-weedplanting:server:DestroyWaitForPackage', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local citizenid = Player.PlayerData.citizenid
    if not packageCache[citizenid] then return end
    
    packageCache[citizenid] = nil
    TriggerClientEvent('QBCore:Notify', src, _U('moved_too_far'), 'error', 2500)
end)

RegisterNetEvent('ps-weedplanting:server:WeedrunDelivery', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    if Player.Functions.RemoveItem(Shared.SusPackageItem, 1) then
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Shared.SusPackageItem], 'remove', 1)
        Wait(2000)
        local payout = math.random(Shared.PayOut[1], Shared.PayOut[2])
        Player.Functions.AddMoney('cash', payout)
    end
end)

--- Callbacks

QBCore.Functions.CreateCallback('ps-weedplanting:server:PackageGoods', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid

    local weedcard = Player.Functions.GetItemsByName('weedcard')
    local packed = Player.Functions.GetItemsByName(Shared.PackedWeedItem)
    QBCore.Debug(weedcard[1])
    QBCore.Debug(packed)
    local countpacked = 0
    if packed[1] then
        for _, v in pairs(packed) do
            countpacked += v.amount 
        end
    end
    if weedcard[1] and countpacked >= 10 and not packageCache[citizenid] then
        
        weedcard[1].info.quality = (weedcard[1].info.quality - 25) or 0
        
        Player.PlayerData.items[ weedcard[1].slot] = weedcard[1]
        Player.Functions.SetInventory(Player.PlayerData.items)
        TriggerClientEvent("inventory:client:UpdatePlayerInventory", Player.PlayerData.source, false)
        if Player.PlayerData.items[weedcard[1].slot].info.quality <= 0 then
            Player.Functions.RemoveItem(weedcard[1].name, 1, weedcard[1].slot)
			TriggerClientEvent('inventory:client:ItemBox',src, weedcard[1], "remove") 
        end
        local cntpacked = 0
        for _, v in pairs(packed) do
            if cntpacked <= 10 then
                if v.amount > 10 then
                    Player.Functions.RemoveItem(v.name, 10, v.slot)
                else
                    local dsc = cntpacked + v.amount
                    if dsc  > 10 then 
                        Player.Functions.RemoveItem(v.name, (10-cntpacked), v.slot)
                    else
                        Player.Functions.RemoveItem(v.name, v.amount, v.slot)
                    end
                end
                cntpacked += v.amount
            end
        end
        
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Shared.PackedWeedItem], 'remove', 10)
    else
        
        cb(false)
        return
    end

    packageCache[citizenid] = 'waiting'
    cb(true)

    CreateThread(function()
        Wait(Shared.PackageTime * 60 * 1000)
        if packageCache[citizenid] then
            packageCache[citizenid] = 'done'
        end
    end)
end)
