local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNUICallback("showroomPurchaseCurrentVehicle", function(data, cb)
  TriggerServerEvent("server:showroom:purchaseVehicle", data, cb)
    
end);

RegisterNUICallback("photo", function(data, cb)
  print('tess')
  TriggerServerEvent("server:showroom:photo", data, cb)
    
end);


RegisterNetEvent("client:showroom:purchaseVehicle")
AddEventHandler("client:showroom:purchaseVehicle", function(success, model, plate)
  if success then
    DoScreenFadeOut(0)
    Wait(400)
    DoScreenFadeIn(1000)
    SetNuiFocus(false, false)
    ClearFocus()
    RenderScriptCams(false, false, 0, 1, 0)
    --DeleteEntity(vehicle)
    TakeOutVehicle(model, plate)
    Wait(1000)
  else
    print("nomoney")
  end
end)

function TakeOutVehicle(vehicle, plate)
  
  SendNUIMessage({shop = 'done' })
  local ped = PlayerPedId()
  enginePercent = 100
  bodyPercent = 100
  currentFuel = 100
  model = vehicle
  local veh = CreateVehicle(GetHashKey(model), vector3(576.0516, -222.0889, 51.3609), 334.5847, true, false)
  SetVehicleNumberPlateText(veh, plate)
  SetPedIntoVehicle(PlayerPedId(), veh, -1)
  TriggerServerEvent('MojiaVehicleKeys:server:AddVehicleKey', plate, model)
  Wait(4000)
end

RegisterCommand("cord", function()
coords = GetEntityCoords(PlayerPedId())
head = GetEntityHeading(PlayerPedId())
print(coords, head)
end)

