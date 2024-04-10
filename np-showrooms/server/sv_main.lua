
local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback("showroom:purchaseVehicle",function(source, cb, model, price, amount) 
	local src = source;
	local xPlayer = QBCore.GetPlayerFromId(src);
	local bank = xPlayer.PlayerData.money['bank']
	local plate = GeneratePlate()
	if tonumber(bank)  >= price  then
       	if xPlayer.Functions.RemoveMoney('bank', amount) then
			PurchaseCar(src, model, plate)
		end
			cb(true, model)
		return
	else
		cb(false, model)
		return
	end;

end)


RegisterNetEvent('server:showroom:photo', function(data, cb)
    local src = source;
	local model = data.model
	print('dentro foto')
	TakeAndUploadPhoto(model)
end)


RegisterNetEvent('server:showroom:purchaseVehicle', function(data, cb)
    local src = source;
	local xPlayer = QBCore.Functions.GetPlayer(src)
	local bank = xPlayer.PlayerData.money['bank']
	local plate = GeneratePlate()
	local model = data.model
	local price = data.price
	if tonumber(bank)  >= price  then
       	if xPlayer.Functions.RemoveMoney('bank', price) then
			PurchaseCar(src, model, plate)
		end
		TriggerClientEvent('client:showroom:purchaseVehicle', src, true, model, plate)
	else
		TriggerClientEvent('client:showroom:purchaseVehicle', src, false, model, plate)
	end;
end)
function PurchaseCar(source, model, plate)
	local src = source;
	local xPlayer = QBCore.Functions.GetPlayer(src);
	local model = model
	local plate = plate
	local hash =  GetHashKey(model)
	MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
		xPlayer.PlayerData.license,
		xPlayer.PlayerData.citizenid,
		model,
		hash,
		'{}',
		plate,
		'pillboxgarage',
		0
	})

end

function GeneratePlate()
    local plate = math.random(0, 99)..""..GetRandomLetter(3)..""..math.random(0, 999)
	local result = MySQL.scalar.await('SELECT plate FROM player_vehicles WHERE plate = ?', { plate })
	if result then
		plate = tostring(GetRandomNumber(1)) .. GetRandomLetter(2) .. tostring(GetRandomNumber(3)) .. GetRandomLetter(2)
	end
    return plate:upper()
end

local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GetRandomLetter(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end


function TakeSnapshot()
	local success, screenshot = exports['screenshot-basic']:requestClientScreenshot(GetPlayers()[1])
	
	-- Comprobar si se tomó la captura de pantalla correctamente
	if success then
		-- Esperar a que se complete la captura de pantalla
		while not IsDuplicityVersion() and not screenshot.complete do
			Wait(0)
		end
		
		-- Comprobar si la captura de pantalla se completó y devolver los datos de la imagen
		if screenshot.complete then
			return true, screenshot.data
		end
	end
	
	-- Si la captura de pantalla falló o no se completó, devolver nil
	return false, nil
end
-- Función para tomar una foto y subirla a Google Drive
function TakeAndUploadPhoto(vehicleName)
    -- Tomar una foto con screenshot-basic
    local success, photoData = TakeSnapshot()
    
    if success then
        -- Subir la foto a Google Drive
        local drive = exports["drive"]
        if drive then
            local folderId = "ID_DE_LA_CARPETA"  -- Reemplazar con el ID de la carpeta IMG en Google Drive
            local photoName = vehicleName .. ".jpg"
            local photoPath = "img/" .. photoName  -- Ruta en la carpeta IMG en tu servidor de FiveM

            -- Guardar la foto localmente
            local file = io.open(photoPath, "wb")
            if file then
                file:write(photoData)
                file:close()
            else
                print("Error al guardar la foto localmente")
            end
        else
            print("El módulo 'drive' no está disponible")
        end
    else
        print("Error al tomar la foto")
    end
end