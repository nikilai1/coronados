local cornerselling = false
local hasTarget = false
local lastPed = {}
local stealingPed = nil
local stealData = {}
local availableDrugs = {}
local currentOfferDrug = nil
local CurrentCops = 0
local textDrawn = false
local zoneMade = false

-- Functions
local function LoadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(0)
    end
end

local function TooFarAway()
    QBCore.Functions.Notify("Te has movido demasiado lejos", 'error')
    LocalPlayer.state:set("inv_busy", false, true)
    cornerselling = false
    hasTarget = false
    availableDrugs = {}
end

-- Fixed:
-- swapped the condition to `random <= Shared.PoliceCallChance` so "Shared.PoliceCallChance", represents the call probability.
local function PoliceCall()
    local random = math.random(1, 100)
    if random <= Shared.PoliceCallChance then
        TriggerServerEvent('police:server:policeAlert', 'Drug sale in progress')
    end
end

local function RobberyPed()
    if Shared.UseTarget then
        exports['qb-target']:AddEntityZone('stealingPed', stealingPed,{
            name = 'stealingPed',
            debugPoly = false,
        },{
            options = {
                {
                    icon = 'fas fa-magnifying-glass',
                    label = "Buscar ped",
                    action = function()
                        local player = PlayerPedId()
                        RequestAnimDict("pickup_object")
                        while not HasAnimDictLoaded("pickup_object") do
                            Wait(0)
                        end
                        TaskPlayAnim(player, "pickup_object", "pickup_low", 8.0, -8.0, -1, 1, 0, false, false, false)
                        Wait(2000)
                        ClearPedTasks(player)
                        TriggerServerEvent('qb-drugs:server:giveStealItems', stealData.item, stealData.amount)
                        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[stealData.item], "add")
                        stealingPed = nil
                        stealData = {}
                        exports['qb-target']:RemoveZone('stealingPed')
                    end,
                    canInteract = function(entity)
                        if IsEntityDead(entity) then
                            return true
                        end
                    end
                }
            },
            distance = 1.5,
        })
        CreateThread(function()
            while stealingPed do
                local playerPed = PlayerPedId()
                local pos = GetEntityCoords(playerPed)
                local pedpos = GetEntityCoords(stealingPed)
                local dist = #(pos - pedpos)
                if dist > 100 then
                    stealingPed = nil
                    stealData = {}
                    exports['qb-target']:RemoveZone('stealingPed')
                    break
                end
                Wait(0)
            end
        end)
    else
        CreateThread(function()
            while stealingPed do
                if IsEntityDead(stealingPed) then
                    local playerPed = PlayerPedId()
                    local pos = GetEntityCoords(playerPed)
                    local pedpos = GetEntityCoords(stealingPed)
                    if not Shared.UseTarget and #(pos - pedpos) < 1.5 then
                        if not textDrawn then
                            textDrawn = true
                            exports['qb-core']:DrawText("[E] Recoger")
                        end
                        if IsControlJustReleased(0, 38) then
                            exports['qb-core']:KeyPressed()
                            textDrawn = false
                            RequestAnimDict("pickup_object")
                            while not HasAnimDictLoaded("pickup_object") do
                                Wait(0)
                            end
                            TaskPlayAnim(playerPed, "pickup_object", "pickup_low", 8.0, -8.0, -1, 1, 0, false, false, false)
                            Wait(2000)
                            ClearPedTasks(playerPed)
                            TriggerServerEvent('qb-drugs:server:giveStealItems', stealData.item, stealData.amount)
                            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[stealData.item], "add")
                            stealingPed = nil
                            stealData = {}
                        end
                    end
                else
                    local playerPed = PlayerPedId()
                    local pos = GetEntityCoords(playerPed)
                    local pedpos = GetEntityCoords(stealingPed)
                    if #(pos - pedpos) > 100 then
                        stealingPed = nil
                        stealData = {}
                        break
                    end
                end
                Wait(0)
            end
        end)
    end
end

local function SellToPed(ped)
    hasTarget = true

    for i = 1, #lastPed, 1 do
        if lastPed[i] == ped then
            hasTarget = false
            return
        end
    end

    local successChance = math.random(1, 100)
    local scamChance = math.random(1, 100)
    local getRobbed = math.random(1, 100)
    if successChance <= Shared.SuccessChance then hasTarget = false return end

    local drugType = math.random(1, #availableDrugs)
    local bagAmount = math.random(1, availableDrugs[drugType].amount)
    if bagAmount > 15 then bagAmount = math.random(9, 15) end

    currentOfferDrug = availableDrugs[drugType]

    local ddata = Shared.DrugsPrice[currentOfferDrug.item]
    local randomPrice = math.random(ddata.min, ddata.max) * bagAmount
    if scamChance <= Shared.ScamChance then randomPrice = math.random(3, 10) * bagAmount end

    SetEntityAsNoLongerNeeded(ped)
    ClearPedTasks(ped)

    local coords = GetEntityCoords(PlayerPedId(), true)
    local pedCoords = GetEntityCoords(ped)
    local pedDist = #(coords - pedCoords)
    if getRobbed <= Shared.RobberyChance then
        TaskGoStraightToCoord(ped, coords, 15.0, -1, 0.0, 0.0)
    else
        TaskGoStraightToCoord(ped, coords, 1.2, -1, 0.0, 0.0)
    end

    while pedDist > 1.5 do
        coords = GetEntityCoords(PlayerPedId(), true)
        pedCoords = GetEntityCoords(ped)
        if getRobbed <= Shared.RobberyChance then
            TaskGoStraightToCoord(ped, coords, 15.0, -1, 0.0, 0.0)
        else
            TaskGoStraightToCoord(ped, coords, 1.2, -1, 0.0, 0.0)
        end
        TaskGoStraightToCoord(ped, coords, 1.2, -1, 0.0, 0.0)
        pedDist = #(coords - pedCoords)
        Wait(100)
    end

    TaskLookAtEntity(ped, PlayerPedId(), 5500.0, 2048, 3)
    TaskTurnPedToFaceEntity(ped, PlayerPedId(), 5500)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT", 0, false)

    if hasTarget then
        while pedDist < 1.5 and not IsPedDeadOrDying(ped) do
            local coords2 = GetEntityCoords(PlayerPedId(), true)
            local pedCoords2 = GetEntityCoords(ped)
            local pedDist2 = #(coords2 - pedCoords2)
            if getRobbed <= Shared.RobberyChance then
                TriggerServerEvent('qb-drugs:server:robCornerDrugs', drugType, bagAmount)
                QBCore.Functions.Notify("Te han robado y has perdido %{bags} bag(s) %{drugType}", {bags = bagAmount, drugType = availableDrugs[drugType].label})
                stealingPed = ped
                stealData = {
                    item = availableDrugs[drugType].item,
                    drugType = drugType,
                    amount = bagAmount,
                }
                hasTarget = false
                local moveto = GetEntityCoords(PlayerPedId())
                local movetoCoords = {x = moveto.x + math.random(100, 500), y = moveto.y + math.random(100, 500), z = moveto.z, }
                ClearPedTasksImmediately(ped)
                TaskGoStraightToCoord(ped, movetoCoords.x, movetoCoords.y, movetoCoords.z, 15.0, -1, 0.0, 0.0)
                lastPed[#lastPed + 1] = ped
                RobberyPed()
                break
            else
                if pedDist2 < 1.5 and cornerselling then
                    if Shared.UseTarget and not zoneMade then
                        zoneMade = true
                        exports['qb-target']:AddEntityZone('sellingPed', ped, {
                            name = 'sellingPed',
                            debugPoly = false,
                        }, {
                            options = {
                                {
                                    icon = 'fas fa-hand-holding-dollar',
                                    label = "Vender %{bags}x %{drugLabel} por $%{randomPrice}?", {bags = bagAmount, drugLabel = currentOfferDrug.label, randomPrice = randomPrice},
                                    action = function(entity)
                                        if IsPedInAnyVehicle(PlayerPedId(), false) then
                                            QBCore.Functions.Notify("Baja del vehiculo para poder vender.", 'error')
                                            hasTarget = false
                                            SetPedKeepTask(entity, false)
                                            SetEntityAsNoLongerNeeded(entity)
                                            ClearPedTasksImmediately(entity)
                                            lastPed[#lastPed + 1] = entity
                                            exports['qb-target']:RemoveZone('sellingPed')
                                            return
                                        else
                                            exports['qb-target']:RemoveZone('sellingPed')
                                            QBCore.Functions.Progressbar("cornerSelling", "Intercambiando.", '5000', false, false, {
                                                disableMovement = true,
                                                disableCarMovement = true,
                                                disableMouse = false,
                                                disableCombat = false,
                                            }, {}, {}, {}, function()
                                                TriggerServerEvent('qb-drugs:server:sellCornerDrugs', drugType, bagAmount, randomPrice)
                                                hasTarget = false
                                                LoadAnimDict("gestures@f@standing@casual")
                                                TaskPlayAnim(PlayerPedId(), "gestures@f@standing@casual", "gesture_point", 3.0, 3.0, -1, 49, 0, 0, 0, 0)
                                                Wait(650)
                                                ClearPedTasks(PlayerPedId())
                                                SetPedKeepTask(entity, false)
                                                SetEntityAsNoLongerNeeded(entity)
                                                ClearPedTasksImmediately(entity)
                                                lastPed[#lastPed + 1] = entity
                                                --exports['qb-target']:RemoveZone('sellingPed')
                                                PoliceCall()
                                            end)
                                        end
                                    end,
                                },
                                {
                                    icon = 'fas fa-x',
                                    label = 'Decline offer',
                                    action = function(entity)
                                        QBCore.Functions.Notify("Declinó la oferta", 'error')
                                        hasTarget = false
                                        SetPedKeepTask(entity, false)
                                        SetEntityAsNoLongerNeeded(entity)
                                        ClearPedTasksImmediately(entity)
                                        lastPed[#lastPed + 1] = entity
                                        exports['qb-target']:RemoveZone('sellingPed')
                                    end,
                                },
                            },
                            distance = 1.5,
                        })
                    elseif not Shared.UseTarget then
                        if not textDrawn then
                            textDrawn = true
                            exports['qb-core']:DrawText("[E] %{bags}x %{drugLabel} por $%{randomPrice}? / [G] Rechazar oferta", {bags = bagAmount, drugLabel = currentOfferDrug.label, randomPrice = randomPrice})
                        end
                        if IsControlJustPressed(0, 38) then
                            if IsPedInAnyVehicle(PlayerPedId(), false) then
                                QBCore.Functions.Notify("Baja del vehiculo para poder vender.", 'error')
                                exports['qb-core']:KeyPressed()
                                textDrawn = false
                                hasTarget = false
                                SetPedKeepTask(ped, false)
                                SetEntityAsNoLongerNeeded(ped)
                                ClearPedTasksImmediately(ped)
                                lastPed[#lastPed + 1] = ped
                                break
                            else
                                exports['qb-core']:KeyPressed()
                                textDrawn = false
                                QBCore.Functions.Progressbar("cornerSelling", "Intercambiando.", '5000', false, false, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = false,
                                }, {}, {}, {}, function()
                                    TriggerServerEvent('qb-drugs:server:sellCornerDrugs', drugType, bagAmount, randomPrice)
                                    hasTarget = false
                                    LoadAnimDict("gestures@f@standing@casual")
                                    TaskPlayAnim(PlayerPedId(), "gestures@f@standing@casual", "gesture_point", 3.0, 3.0, -1, 49, 0, 0, 0, 0)
                                    Wait(650)
                                    ClearPedTasks(PlayerPedId())
                                    SetPedKeepTask(ped, false)
                                    SetEntityAsNoLongerNeeded(ped)
                                    ClearPedTasksImmediately(ped)
                                    lastPed[#lastPed + 1] = ped
                                    PoliceCall()
                                end)
                            end
                        end
                        if IsControlJustPressed(0, 47) then
                            exports['qb-core']:KeyPressed()
                            textDrawn = false
                            QBCore.Functions.Notify("Declinó la oferta", 'error')
                            hasTarget = false
                            SetPedKeepTask(ped, false)
                            SetEntityAsNoLongerNeeded(ped)
                            ClearPedTasksImmediately(ped)
                            lastPed[#lastPed + 1] = ped
                            break
                        end
                    end
                else
                    if Shared.UseTarget then
                        zoneMade = false
                        exports['qb-target']:RemoveZone('sellingPed')
                    else
                        if textDrawn then
                            exports['qb-core']:HideText()
                            textDrawn = false
                        end
                    end
                    hasTarget = false
                    SetPedKeepTask(ped, false)
                    SetEntityAsNoLongerNeeded(ped)
                    ClearPedTasksImmediately(ped)
                    lastPed[#lastPed + 1] = ped
                    break
                end
            end
            Wait(0)
        end
        Wait(math.random(4000, 7000))
    end
end

local function ToggleSelling()
    if not cornerselling then
        cornerselling = true
        LocalPlayer.state:set("inv_busy", true, true)
        QBCore.Functions.Notify("Empezaste a vender drogas")
        local startLocation = GetEntityCoords(PlayerPedId())
        CreateThread(function()
            while cornerselling do
                local player = PlayerPedId()
                local coords = GetEntityCoords(player)
                if not hasTarget then
                    local PlayerPeds = {}
                    if next(PlayerPeds) == nil then
                        for _, activePlayer in ipairs(GetActivePlayers()) do
                            local ped = GetPlayerPed(activePlayer)
                            PlayerPeds[#PlayerPeds + 1] = ped
                        end
                    end
                    local closestPed, closestDistance = QBCore.Functions.GetClosestPed(coords, PlayerPeds)
                    if closestDistance < 15.0 and closestPed ~= 0 and not IsPedInAnyVehicle(closestPed) and GetPedType(closestPed) ~= 28 then
                        SellToPed(closestPed)
                    end
                end
                local startDist = #(startLocation - coords)
                if startDist > 10 then
                    TooFarAway()
                end
                Wait(0)
            end
        end)
    else
        stealingPed = nil
        stealData = {}
        cornerselling = false
        LocalPlayer.state:set("inv_busy", false, true)
        QBCore.Functions.Notify("Dejaste de vender drogas")
    end
end

-- Events
RegisterNetEvent('qb-drugs:client:cornerselling', function()
    print('foxy')
    QBCore.Functions.TriggerCallback('qb-drugs:server:cornerselling:getAvailableDrugs', function(result)
        if CurrentCops >= Shared.MinimumDrugSalePolice then
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                QBCore.Functions.Notify("Baja del vehiculo para poder vender", 'error')
            else
                if result then
                    availableDrugs = result
                    ToggleSelling()
                else
                    QBCore.Functions.Notify("No tienes mas que ofertar", 'error')
                    LocalPlayer.state:set("inv_busy", false, true)
                end
            end
        else
            QBCore.Functions.Notify("Faltan oficiales en servicio.", "error")
        end
    end)
end)

RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

RegisterNetEvent('qb-drugs:client:refreshAvailableDrugs', function(items)
    availableDrugs = items
    if availableDrugs == nil or #availableDrugs <= 0 then
        QBCore.Functions.Notify("No tienes nada que ofertar", 'error')
        cornerselling = false
        LocalPlayer.state:set("inv_busy", false, true)
    end
end)
