isOpen, TestDriveTime, SpawnCoords, Coords, TestDrive, lastPlayerCoords, Framework = {}, true, nil, nil, nil, nil, nil, nil, nil
local openTest = false
RegisterNUICallback("TestDrive", function(data, cb)
    SetEntityVisible(PlayerPedId(), 1)

    local hash = GetHashKey(data.car)
    lastPlayerCoords = GetEntityCoords(PlayerPedId())
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Citizen.Wait(10)
    end
    local testDriveEntity = CreateVehicle(hash, vector4(TestDrive), 1, 1)
    SetPedIntoVehicle(PlayerPedId(), testDriveEntity, -1)
    SetVehicleNumberPlateText(testDriveEntity, "TestCar")
    local Plate = Trim(GetVehicleNumberPlateText(testDriveEntity))
    SetVehicleCustomPrimaryColour(testDriveEntity, data.color.R, data.color.G, data.color.B)
    SetVehicleCustomSecondaryColour(testDriveEntity, data.color.R, data.color.G, data.color.B)
    TriggerServerEvent('MojiaVehicleKeys:server:AddVehicleKey', Plate, data.car)

    startCountDown = true
    local timeGG = GetGameTimer()

    Citizen.CreateThread(function()
        while startCountDown do
            SendNUIMessage({type = "close"})
            Citizen.Wait(1)
            if GetGameTimer() < timeGG + tonumber(1000*TestDriveTime) then
                drawTxt(' ~r~ TEST DRIVE:' .. math.ceil(TestDriveTime - (GetGameTimer() - timeGG)/1000) ,4,0.5,0.93,0.50,255,255,255,180)
            else
                DeleteEntity(testDriveEntity)
                SetEntityCoords(PlayerPedId(), lastPlayerCoords)
                TriggerServerEvent('MojiaVehicleKeys:server:DeleteVehicleKey2',Plate)
                startCountDown = false
            end
        end
    end)
end)

    function Draw3DText(x, y, z, text)
        local onScreen, _x, _y = World3dToScreen2d(x, y, z)
        local px,py,pz=table.unpack(GetGameplayCamCoords())
        if onScreen then
            SetTextScale(0.35, 0.35)
            SetTextFont(4)
            SetTextProportional(1)
            SetTextColour(255, 255, 255, 215)
            SetTextDropShadow(0, 0, 0, 55)
            SetTextEdge(0, 0, 0, 150)
            SetTextDropShadow()
            SetTextOutline()
            SetTextEntry("STRING")
            SetTextCentre(1)
            AddTextComponentString(text)
            DrawText(_x,_y)
        end
    end


    RegisterNUICallback("rotateright", function()
        SetEntityHeading(currentVeh, GetEntityHeading(currentVeh) - 2)
    end)

    RegisterNUICallback("rotateleft", function()
        SetEntityHeading(currentVeh, GetEntityHeading(currentVeh) + 2)
    end)

      RegisterNUICallback("Vehicle",function(data, cb)
        local model = GetHashKey(data.vehicle)
        local vehClass = GetVehicleClassFromName(model)
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(7)
        end
        if not DoesEntityExist(currentVeh) then
        currentVeh = CreateVehicle(model, Coords, false, true)
        SetVehicleEngineOn(currentVeh, true, true, false)
        SetVehicleCustomPrimaryColour(currentVeh, data.color.R, data.color.G, data.color.B)
        SetVehicleCustomSecondaryColour(currentVeh, data.color.R, data.color.G, data.color.B)
        if vehClass == 14 then 
            FreezeEntityPosition(currentVeh, true)
        end
        cb(
            {
               maxSpeed = GetVehicleEstimatedMaxSpeed(currentVeh),
               Fuel = Config.GetVehFuel(currentVeh),
               Handling = GetVehicleMaxTraction(currentVeh) *12.6,
               Acceleration = GetVehicleAcceleration(currentVeh) *12.6,
               Brake = GetVehicleMaxBraking(currentVeh) *12.6
            }
        )
        end
    end
)           
         RegisterNUICallback("Delete",function()
                 EYESDeleteVehicle(currentVeh)
             end
         )

         function EYESDeleteVehicle(vehicle)
          SetEntityAsMissionEntity(vehicle, true, true)
          DeleteVehicle(vehicle)
      end

      RegisterNUICallback("SelectColor", function(data)
          RGB = data.color
          SetVehicleCustomPrimaryColour(currentVeh, data.color.R, data.color.G, data.color.B)
          SetVehicleCustomSecondaryColour(currentVeh, data.color.R, data.color.G, data.color.B)
      end)
      


     function OpenNui(data)
          SetDisplay(true, true)
          local cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",data.NuiCarViewCameraPosition.posX, data.NuiCarViewCameraPosition.posY, data.NuiCarViewCameraPosition.posZ,data.NuiCarViewCameraPosition.rotX, data.NuiCarViewCameraPosition.rotY, data.NuiCarViewCameraPosition.rotZ,data.NuiCarViewCameraPosition.fov,true,0)
          RequestCollisionAtCoord(data.NuiCarViewCameraPosition.posX, data.NuiCarViewCameraPosition.posY, data.NuiCarViewCameraPosition.posZ)
          RenderScriptCams(true, true, 1, true, true)
          PointCamAtCoord(cam, data.NuiCarViewCameraPosition.posX, data.NuiCarViewCameraPosition.posY, data.NuiCarViewCameraPosition.posZ)
          SetFocusPosAndVel(data.NuiCarViewCameraPosition.posX, data.NuiCarViewCameraPosition.posY, data.NuiCarViewCameraPosition.posZ, 0.0, 0.0, 0.0)
          CustomizeCamera(isOpen)
      end


 function CloseNui()
    Citizen.Wait(1)
     CustomizeCamera(isOpen)
     SetDisplay(false)
     DestroyAllCams(true)
     RenderScriptCams(false, true, 75, true, false, false)
     SetFocusEntity(GetPlayerPed(PlayerId()))
     EYESDeleteVehicle(currentVeh)
     DisplayRadar(true)
     DisplayHud(true)
     openTest = false
 end


 if Config.Framework == "ESX" or Config.Framework == "NewESX" then
    Citizen.CreateThread(function()
      Framework = GetFramework()
      while Framework == nil do
        Citizen.Wait(0)
        TriggerEvent('esx:getSharedObject', function(obj) Framework = obj end)
        while Framework.GetPlayerData().job == nil do
            Citizen.Wait(10)
        end
        Framework.PlayerData = Framework.GetPlayerData()
      end

      Citizen.CreateThread(function()
        Framework.PlayerData = Framework.GetPlayerData()
        while Framework.GetPlayerData().job == nil do
            Citizen.Wait(0)
            Framework.PlayerData = Framework.GetPlayerData()
        end
      end)
  

        RegisterNetEvent('esx:setJob')
        AddEventHandler('esx:setJob', function(job)
          Framework.PlayerData.job = job
        end)


      Citizen.CreateThread(function()
        Framework.PlayerData = Framework.GetPlayerData()
        while true do
          Citizen.Wait(0)
          local getPed = PlayerPedId()
          local entity = GetEntityCoords(getPed)
    
          for k,v in pairs(Config.Locations) do
            local dist = #(entity - v.coords)

            if dist < 10 then
              if dist < 3 then
                x = v.coords[1]
                y = v.coords[2]
                z = v.coords[3]
                DrawText3D(x,y,z+2.2,v.marker, 1.2, 1)
                DrawText3D(x,y,z+2.05, "~w~[E]", 1.5, 1)
                if IsControlJustPressed(0,38) then
                  if v.job == Framework.PlayerData.job.name or v.job == 'all' then
                    SendNUIMessage({
                      type = "ui",
                      vehicle = Config.Vehicles.Car[v.type],
                      color = Config.Vehicles.Color[v.type],
                      category = Config.Vehicles.Category[v.type]
                    })
    
                    Coords = v.NuiCarViewSpawnPosition
                    TestDrive = v.TestDriveSpawnPosition
                    TestDriveTime = v.TestDriveTime
                    SpawnCoords = v.BuyCarSpawnPositions
    
                    OpenNui(v)
                  end
                end
              end
            end
          end
        end
      end)

      function sellVehicle(model, plate)
        local car = GetVehiclePedIsIn(PlayerPedId())
        for _,v in pairs(Config.Vehicles.Car['car']) do
            if v.model == model then
                Framework.TriggerServerCallback("SellVehicles", function(result, cb)
                    if result then
                        Framework.ShowNotification("The gallery owner has agreed to buy your vehicle! You have received $"..v.price * (Config.RefundPercent * 0.01))
                        DeleteVehicle(car)
                    else
                        Framework.ShowNotification("This vehicle does not belong to you! ("..plate..")")
                    end
                end, plate, v.price, Config.RefundPercent)
            end
        end
    end
    
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local vehicle = GetVehiclePedIsIn(PlayerPedId())
            if IsPedInVehicle(PlayerPedId(), vehicle, true) and GetPedInVehicleSeat(vehicle, -1) then
                local entity = GetEntityCoords(PlayerPedId())
                for _,v in pairs(Config.SellVehicles) do
                    local dist = #(entity - v)
                    if dist <= 5.0 then
                        DrawText3D(v.x, v.y, v.z + 0.4, '~g~SELL ~w~YOUR VEHICLE ~r~')
                        DrawMarker(2, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 255, 255, 255, 255, false, false, false, true, false, false, false)
                        if IsControlJustPressed(0,38) then
                            local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)):lower()
                            local plate = GetVehicleNumberPlateText(vehicle)
                            sellVehicle(model, plate)
                        end
                        break
                    end
                end
            end
        end
    end)


   RegisterNUICallback("Buy", function(data, cb)
    Framework.TriggerServerCallback("isPrice", function(result)
        if result then 
        local hash = GetHashKey(data.model)
        local coords = konumfor(SpawnCoords)
        if coords ~= nil then
        if not HasModelLoaded(hash) then RequestModel(hash) while not HasModelLoaded(hash) do Citizen.Wait(10) end end
        local buycar = CreateVehicle(hash, coords.x,coords.y,coords.z, coords.w, true, false)
        local netid = NetworkGetNetworkIdFromEntity(buycar)
        local NewPlate = CustomizePlate()
        SetPedIntoVehicle(PlayerPedId(), buycar, -1)
        SetVehicleNumberPlateText(buycar, NewPlate)
        SetVehicleCustomPrimaryColour(buycar,  data.color.R, data.color.G, data.color.B)
        SetVehicleCustomSecondaryColour(buycar, data.color.R, data.color.G, data.color.B)
        SetPedIntoVehicle(PlayerPedId(), buycar, -1)
        SetVehicleHasBeenOwnedByPlayer(buycar, true)
        SetNetworkIdCanMigrate(netid, true)
        SetVehicleNeedsToBeHotwired(buycar, false)
        SetVehRadioStation(buycar, 'OFF')
        local Plate = GetVehicleNumberPlateText(buycar)
        Plate = Trim(GetVehicleNumberPlateText(buycar))
        CloseNui()
        CustomizeCamera(isOpen)
        TriggerServerEvent("vehicleshop:setVehicleOwned", Plate, Framework.Game.GetVehicleProperties(buycar), data.model)
        SendNUIMessage({type = "close"})
        TriggerServerEvent('MojiaVehicleKeys:server:AddVehicleKey', Plate, data.car)
    end
else
    Framework.ShowNotification("Insufficient Money")
    end
end, data.price)
end)


end)

elseif Config.Framework == 'QBCore' or Config.Framework == 'OLDQBCore'  then
     if Config.Framework == "OLDQBCore" then
          while Framework == nil do
               TriggerEvent('QBCore:GetObject', function(obj) Framework = obj end)
               Citizen.Wait(4)
          end
          Framework.PlayerData = Framework.Functions.GetPlayerData()
     else  Framework = exports['qb-core']:GetCoreObject() end

     Citizen.CreateThread(function()
        Framework.PlayerData = Framework.Functions.GetPlayerData()
        while Framework.Functions.GetPlayerData().job == nil do
            Citizen.Wait(0)
            Framework.PlayerData = Framework.Functions.GetPlayerData()
        end
      end)
    

            Citizen.CreateThread(function()
                local notify
                while true do
                    Citizen.Wait(0)
                    local getPed = PlayerPedId()
                    local entity = GetEntityCoords(getPed)
                    for k, v in pairs(Config.Locations) do
                        local dist = #(entity - v.coords)
                        if dist < 10 then
                            if dist < 3  and not openTest then
                                local x, y, z = v.coords[1], v.coords[2], v.coords[3]
                                
								if not notify then
									notify = exports["notify"]:CreateHelp("E", v.marker)
								else
									notify = exports["notify"]:UpdateHelp(notify, "E", v.marker)
								end
                                
                                if IsControlJustPressed(0, 38) then
                                    if v.job == Framework.PlayerData.job.name or v.job == 'all' then
                                        SendNUIMessage({
                                            type = "ui",
                                            vehicle = Config.Vehicles.Car[v.type],
                                            color = Config.Vehicles.Color[v.type],
                                            category = Config.Vehicles.Category[v.type]
                                        })
                                        Coords = v.NuiCarViewSpawnPosition
                                        TestDrive = v.TestDriveSpawnPosition
                                        TestDriveTime = v.TestDriveTime
                                        SpawnCoords = v.BuyCarSpawnPositions
                                        openTest = true
                                        OpenNui(v)
                                    end
                                end
                            elseif notify then
                                exports["notify"]:RemoveHelp(notify)
                                notify = nil
                            end
                        end
                    end
                end
        end)  

        RegisterNUICallback("Buy", function(data, cb)
            Framework.Functions.TriggerCallback("isPrice", function(result)
                if not result then
                    print('Insufficient Money')
                    return
                end
        
                local hash = GetHashKey(data.model)
                local coords = konumfor(SpawnCoords)
                if coords == nil then return end
        
                RequestModel(hash)
                while not HasModelLoaded(hash) do
                    Citizen.Wait(10)
                end
        
                local buycar = CreateVehicle(hash, coords.x, coords.y, coords.z, coords.w, true, false)
                local netid = NetworkGetNetworkIdFromEntity(buycar)
                SetPedIntoVehicle(PlayerPedId(), buycar, -1)
                SetVehicleNumberPlateText(buycar, CustomizePlate())
                SetVehicleCustomPrimaryColour(buycar, data.color.R, data.color.G, data.color.B)
                SetVehicleCustomSecondaryColour(buycar, data.color.R, data.color.G, data.color.B)
                SetVehicleHasBeenOwnedByPlayer(buycar, true)
                SetNetworkIdCanMigrate(netid, true)
                SetVehicleNeedsToBeHotwired(buycar, false)
                SetVehRadioStation(buycar, 'OFF')
        
                local Plate = Trim(GetVehicleNumberPlateText(buycar))
                CloseNui()
                CustomizeCamera(isOpen)
                TriggerServerEvent('MojiaVehicleKeys:server:AddVehicleKey', Plate, data.car)
                TriggerServerEvent("vehicleshop:setVehicleOwned", Plate, Framework.Functions.GetVehicleProperties(buycar), data.model)
                SendNUIMessage({type = "close"})
            end, data.price)
        end)

     end


 function randomNumber(length)
	local res = ""
	for i = 1, length do res = res .. string.char(math.random(48,  57)) end
	return res
end

function randomCharacter(length)
	local res = ""
	for i = 1, length do res = res .. string.char(math.random(97, 122))	end
	return res
end


 function Trim(value)
    return (string.gsub(value, '^%s*(.-)%s*$', '%1'))
end

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end
		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)
		local next = true
		repeat
			coroutine.yield(id)
			next, id = moveFunc(iter)
		until not next
		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumerateEntitiesWithinDistance(entities, isPlayerEntities, coords, maxDistance)
	local nearbyEntities = {}
	if coords then
		coords = vector3(coords.x, coords.y, coords.z)
	else
		local playerPed = PlayerPedId()
		coords = GetEntityCoords(playerPed)
	end
	for k,entity in pairs(entities) do
		local distance = #(coords - GetEntityCoords(entity))
		if distance <= maxDistance then
			table.insert(nearbyEntities, isPlayerEntities and k or entity)
		end
	end
	return nearbyEntities
end

function GetVehicles()
	local vehicles = {}
	for vehicle in EnumerateVehicles() do
		table.insert(vehicles, vehicle)
	end
	return vehicles
end

function konumfor(getkonum)
    for k, v in pairs(getkonum) do
        local konum = EnumerateEntitiesWithinDistance(GetVehicles(), false, v, 2.5)
        Wait(4)
        if konum[1] == nil then
            return v
        end
    end
end
 
 local display = false
 
 RegisterNUICallback("exit", function(data)
     CloseNui()
 end)
 
 function SetDisplay(bool)
     display = bool
     SetNuiFocus(bool, bool)
 end


 _RequestModel = function(hash)
    if type(hash) == "string" then hash = GetHashKey(hash) end
    RequestModel(hash)
    while not HasModelLoaded(hash) do
    Wait(0)
    end
end


EYES.Create = function()
    local locations = Config.Locations
    for i=1, #locations do
        local pedHash = GetHashKey(locations[i].hash)
        if DoesEntityExist(pedHash) then
            DeletePed(pedHash)
            SetPedAsNoLongerNeeded(pedHash)
        end
    end
end

Citizen.CreateThread(function()
    EYES.Functions.CreateBlips()
    local locations = Config.Locations
    for i=1, #locations do
        local pedHash = GetHashKey(locations[i].hash)
        local coords = locations[i].coords
        local heading = locations[i].heading
        if pedHash then
            _RequestModel(pedHash)
            if not DoesEntityExist(pedHash) then
                pedHash = CreatePed(4, pedHash, coords.x, coords.y, coords.z, heading, true, false)
                SetEntityAsMissionEntity(pedHash, true, true)
                SetBlockingOfNonTemporaryEvents(pedHash, true)
                FreezeEntityPosition(pedHash, true)
                SetEntityInvincible(pedHash, true)
            end
            SetModelAsNoLongerNeeded(pedHash)
        end
    end
end)


AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        print(GetCurrentResourceName() .. ' [PED] New pads added, old pad data deleted!')
        EYES.Create()
    end
end)


 
 DrawText3D = function(x, y, z, text)
     SetTextScale(0.35, 0.35)
     SetTextFont(2)
     SetTextProportional(1)
     SetTextColour(255, 255, 255, 215)
     SetTextEntry("STRING")
     SetTextCentre(true)
     AddTextComponentString(text)
     SetDrawOrigin(x,y,z, 0)
     DrawText(0.0, 0.0)
     local factor = (string.len(text)) / 370
     DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
     ClearDrawOrigin()
 end

 

 function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(5)
     SetTextFont(8)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

