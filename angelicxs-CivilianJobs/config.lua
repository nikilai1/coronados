----------------------------------------------------------------------
-- Thanks for supporting AngelicXS Scripts!							--
-- Support can be found at: https://discord.gg/tQYmqm4xNb			--
-- More paid scripts at: https://angelicxs.tebex.io/ 				--
-- More FREE scripts at: https://github.com/GouveiaXS/ 				--
-- Images are provided for new items if you choose to add them 		--
----------------------------------------------------------------------

----------------------------------------------------------------------
--						Main Configuration 							--
--			To configure jobs uniquely see each client file			--
--			for additional config options specific to the job		--
----------------------------------------------------------------------

-- Model info: https://docs.fivem.net/docs/game-references/ped-models/
-- Blip info: https://docs.fivem.net/docs/game-references/blips/

Config = {}

Config.UseESX = false						-- Use ESX Framework
Config.UseQBCore = true						-- Use QBCore Framework (Ignored if Config.UseESX = true)

Config.NHInput = false						-- Use NH-Input [https://github.com/nerohiro/nh-keyboard]
Config.NHMenu = false						-- Use NH-Menu [https://github.com/whooith/nh-context]
Config.QBInput = true						-- Use QB-Input (Ignored if Config.NHInput = true) [https://github.com/qbcore-framework/qb-input]
Config.QBMenu = true						-- Use QB-Menu (Ignored if Config.NHMenu = true) [https://github.com/qbcore-framework/qb-menu]
Config.OXLib = false						-- Use the OX_lib (Ignored if Config.NHInput or Config.QBInput = true) [https://github.com/overextended/ox_lib]  !! must add shared_script '@ox_lib/init.lua' and lua54 'yes' to fxmanifest!!

Config.UseCustomNotify = false				-- Use a custom notification script, must complete event below.
-- Only complete this event if Config.UseCustomNotify is true; mythic_notification provided as an example
RegisterNetEvent('angelicxs-CivilianJobs:CustomNotify')
AddEventHandler('angelicxs-CivilianJobs:CustomNotify', function(message, type)
    --exports.mythic_notify:SendAlert(type, message, 4000)
end)

-- Visual Preference
Config.Use3DText = false 					-- Use 3D text for NPC/Job interactions; only turn to false if Config.UseThirdEye is turned on and IS working.
Config.UseThirdEye = true 					-- Enables using a third eye (third eye requires the following arguments debugPoly, useZ, options {event, icon, label}, distance)
Config.ThirdEyeName = 'qb-target' 			-- Name of third eye aplication
Config.UsePedAsJobBoss = true				-- Creates a ped at the interaction location to initiate each job (required if Config.UseThirdEye = true)

-- General Blip Preference
Config.JobBlipSize = 0.7
Config.BlipMarkerColour = 24
Config.BlipRouteColour = 15


-- Rewards Configuration
Config.AccountMoney = 'bank' 				-- How you want the job completion to be paid.

-- Usable Item Config
Config.ScubaItemName = 'diving_gear'		-- Name of scuba gear item to put on/take off scuba gear

-- General Configuration
Config.UsePlayerJob = true					-- If true requires the player to have the appropriate job; job uses and names identified next
Config.VehicleSteward = false				-- If true, will not let the player do any more jobs if they have returned a destroyed vehicle (they will need to relog to reset this)
Config.BusJobOn = false						-- If true allows the bus job
Config.BusJobName = 'bus-driver'			-- Name of the bus job, used if Config.UsePlayerJob = true
Config.ForkliftJobOn = false					-- If true allows the forklift job
Config.ForkliftJobName = 'forklift-driver'	-- Name of the forklift job, used if Config.UsePlayerJob = true
Config.TaxiJobOn = false					-- If true allows the taxi job
Config.TaxiJobName = 'taxi-driver'			-- Name of the taxi job, used if Config.UsePlayerJob = true
Config.ScubaJobOn = false					-- If true allows the scuba job
Config.ScubaJobName = 'scuba-diver'			-- Name of the scuba job, used if Config.UsePlayerJob = true
Config.JetSkiJobOn = false					-- If true allows the JetSKi job
Config.JetSkiJobName = 'lifeguard'			-- Name of the JetSKi job, used if Config.UsePlayerJob = true
Config.HeliJobOn = true						-- If true allows the Heli job
Config.HeliJobName = 'heli-driver'			-- Name of the Heli job, used if Config.UsePlayerJob = true
Config.GarbageJobOn = false					-- If true allows the Garbage job
Config.GarbageJobName = 'garbage-driver'	-- Name of the Garbage job, used if Config.UsePlayerJob = true


-- Vehicle Keys and Fuel; set the below event to give the player keys and fuel for the vehicle (if applicable)
RegisterNetEvent('angelicxs-CivilianJobs:VehicleInitation')
AddEventHandler('angelicxs-CivilianJobs:VehicleInitation', function(vehicle)
	-- Example provided:
	TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
    exports["ps-fuel"]:SetFuel(vehicle, 99)
end)

-- Language Configuration
Config.LangType = {
	['error'] = 'error',
	['success'] = 'success',
	['info'] = 'primary'
}

Config.Lang = {
	['request_job_3d'] = 'Presiona ~r~[E]~w~ para cambiar de trabajo.',
	['request_job'] = 'Cambiar Trabajo',
	['request_work_3d'] = 'Presiona ~r~[E]~w~ para solicitar trabajo. \n Presiona ~r~[G]~w~ para devolver el vehículo de trabajo. \n Presiona ~r~[F]~w~ para saber cómo funciona el trabajo.',
	['request_work'] = 'Solicitar Trabajo',
	['ask_how_to'] = 'Preguntar cómo funciona el trabajo',
	['wrong_job'] = '¡No tienes el trabajo correcto para hacer este trabajo!',
	['at_route_marker'] = '¡Has llegado al destino indicado!',
	['vehicle_out'] = '¡Ya se te ha proporcionado un vehículo!',
	['gen_how_to'] = 'Presiona F8 para ver tu consola y leer cómo funciona el trabajo.',
	['vehicle_return_request'] = 'Devolver Vehículo',
	['vehicle_return'] = '¡Has devuelto tu vehículo de trabajo!',
	['vehicle_far'] = '¡Acércate más con tu vehículo para devolverlo!',
	['vehicle_not_out'] = '¡No tienes actualmente un vehículo fuera!',
	['vehicle_destroyed'] = '¡Has destruido nuestro vehículo, lo estoy diciendo a todo el mundo en la ciudad y no recibirás otro hoy!',
	['vehicle_destroyed_notice'] = '¡Has destruido un vehículo de trabajo, vuelve mañana para otra oportunidad!',
	['payment_notice_money'] = 'Has recibido la siguiente cantidad por tu trabajo: $',
	['payment_notice_item'] = 'Has recibido el siguiente artículo por tu trabajo:',
	['gen_anchor_boat'] = 'Debes estar en un bote para usar este comando.',
	['gen_anchor_boat_activate'] = 'Debes estar en el asiento del conductor para anclar o desanclar un bote.',
	['gen_anchor_boat_off'] = 'Has desanclado el bote.',
	['gen_anchor_boat_on'] = 'Has anclado el bote.',

-- Bus Language
	['bus_how_to'] = 'Conduce a cada lugar marcado en tu ruta y espera a que un pasajero suba o baje. El pago se realiza cuando el pasajero baja del autobús. Si omites una parada, debes regresar allí para recoger/dejar al pasajero.',
	['bus_route_complete'] = 'Has completado la ruta, ¡regresa a la terminal de autobuses para devolver tu vehículo o solicitar una nueva ruta!',
	['bus_on_route'] = 'Ya se te ha asignado una ruta, ¡por favor termínala antes de solicitar una nueva!',
	['bus_start'] = '¡Adelante y completa la ruta que te envié!',
	['bus_get_on'] = 'Un pasajero está subiendo.',
	['bus_get_off'] = 'Un pasajero está bajando.',

-- Forklift Language
	['forklift_how_to'] = 'Lleva la carretilla elevadora al lugar indicado para recoger el palet, usa el tecla ALT y el tecla CTRL para bajar/levantar la uña. Deja el palet en el camión indicado para recibir el pago.',
	['forklift_start'] = '¡Ve a buscar el palet pedido y colócalo en el camión marcado!',
	['forklift_on_job'] = '¡Todavía no has terminado el pedido actual!',
	['forklift_job_complete'] = 'Has completado el pedido, ¡devuelve la carretilla elevadora o solicita un nuevo pedido!',


-- Taxi Language
	['taxi_how_to'] = 'Después de un período de tiempo se te proporcionará una tarifa que puedes elegir aceptar o rechazar. Si rechazas, deberás esperar a que aparezca otra tarifa. Al aceptar, recoge a la persona y llévala a su destino para recibir el pago.',
	['taxi_start'] = '¡Sal ahí fuera y conduce, pronto te enviaré tu primera tarifa!',
	['taxi_working'] = '¡Sal ahí fuera y completa algunas tarifas!',
	['taxi_menu_header_1'] = 'Solicitud de Taxi Entrante:\n Nombre: ',
	['taxi_menu_header_2'] = '\n Tarifa Estimada: $',
	['taxi_menu_yes'] = 'Aceptar Tarifa',
	['taxi_menu_no'] = 'Rechazar Tarifa',
	['taxi_get_on'] = 'Un pasajero está subiendo.',
	['taxi_get_off'] = 'Un pasajero está bajando.',
	['taxi_bring_client'] = '¡Lleva al cliente a su destino!',
	['taxi_fare_accepted'] = 'Has aceptado la tarifa, ve a recoger a ',
	['taxi_fare_declined'] = 'Has rechazado la tarifa, ¡espera otra solicitud!',
	['taxi_route_complete'] = 'Has completado la tarifa, ¡recibirás otra tarifa cuando esté disponible!',


-- Scuba Language
	['scuba_how_to'] = 'Explicación larga aquí',
	['scuba_start'] = 'Ve al área indicada y busca las cajas, ¡asegúrate de tener tu equipo antes de ir! Se detectaron la siguiente cantidad de cajas en el área:',
	['scuba_on_job'] = '¡Ya tienes una ubicación de buceo con escafandra indicada!',
	['scuba_salvage'] = 'Recuperar Caja',
	['scuba_salvage_3d'] = 'Presiona ~r~[E]~w~ para recuperar la caja.',
	['scuba_salvage_complete'] = '¡Has recuperado exitosamente la caja!',
	['scuba_75'] = '¡El oxígeno del tanque está al 75%!',
	['scuba_50'] = '¡El oxígeno del tanque está al 50%!',
	['scuba_25'] = '¡El oxígeno del tanque está al 25%!',
	['scuba_in_water'] = '¡No puedes hacer esto mientras estás en el agua!',
	
-- Heli Language
	['heli_how_to'] = 'Explicación larga aquí',
	['heli_start'] = '¡Ve a recoger la entrega de la caja prioritaria y entrégasela al cliente!',
	['heli_on_job'] = '¡No has terminado el pedido actual!',
	['heli_job_complete'] = 'Has completado el pedido, regresa al helipuerto y devuelve el helicóptero o solicita un nuevo pedido.',


-- Lifeguard Language
	['jetski_how_to'] = 'Ve al lugar indicado para recoger al civil que se está ahogando, luego llévalo de vuelta al socorrista para salvarlo y recibir el pago.',
	['jetski_start'] = '¡Ve a revisar esta área, nos llamaron diciendo que alguien necesita ayuda!',
	['jetski_on_job'] = '¡No has revisado ese último reporte!',
	['jetski_job_complete'] = '¡Los has salvado! Devuelve tu vehículo o busca más informes hablando con el socorrista.',
	['jetski_help_civ'] = '¡Encontraste el informe! Detente cerca del civil para ayudarlo.',
	['jetski_return_civ'] = '¡Devuelve al civil al socorrista para asegurarte de que esté bien!',

	
-- Garbage Language
	['garbage_how_to'] = 'Conduce a cada ubicación marcada para recoger la basura y luego arroja la bolsa de basura al camión. Una vez completadas todas las paradas, se realizará el pago.',
	['garbage_start'] = 'Sigue la ruta marcada para recoger la basura y arrojarla al camión.',
	['garbage_on_job'] = '¡No has terminado la ruta actual asignada!',
	['garbage_search_bin_3D'] = 'Presiona ~r~[E]~w~ para buscar basura.',
	['garbage_search_bin'] = 'Buscar Basura',
	['garbage_route_complete'] = '¡Ruta completa! Ve al Maestro de la Basura para devolver el camión o recibir una nueva ruta.',
	['garbage_get_garbage'] = 'Presiona ~r~[G]~w~ para recoger la basura.',
	['garbage_put_garbage'] = 'Presiona ~r~[G]~w~ para poner la basura en el camión.',
	['garbage_item_find'] = '¡Encontraste un artículo en la basura!',
	['garbage_item_nofind'] = 'No hay nada en la basura.',
	['garbage_in_truck'] = '¡La basura ha sido cargada, dirígete al siguiente lugar!',

}

Config.ErrorCodes = {
	['dev'] = 'Por favor, proporciona la siguiente información a tu equipo de desarrollo:',
	['001'] = 'La función Randomizer encontrada en la configuración principal falló. La lista se encontró como nula y fue llamada desde el siguiente evento:',
	['002'] = 'Un bucle de retorno/ruptura ha finalizado involuntariamente. El bucle fue llamado desde el siguiente evento:',
	['003'] = 'Advertencia, el siguiente modelo tardó más de un (1) segundo en cargarse (referencia desde HashGrabber - main.lua):',
	['004'] = 'Se solicitó crear una ruta no definida desde el siguiente evento:',
	['005'] = 'Un segundo spawn de peatón ha sido abortado automáticamente, solicitando eventor:',
	['006'] = 'Un segundo spawn de vehículo ha sido abortado automáticamente, solicitando eventor:',
	['007'] = 'Advertencia, error detectado, consulta el comentario para más detalles, solicitando eventor:', -- !!!! Si ves este error, probablemente fue desencadenado por un inyector !!!!
	['008'] = 'Se intentó despawnear un vehículo sin un NPC de trabajo spawnado',
	['009'] = '¡Falló un pago! (referencia desde DistancePayment - main.lua)', -- !!!! Si ves este error, probablemente fue desencadenado por un inyector !!!!
	['010'] = '¡Falló un pago! (referencia desde PaymentFlat - main.lua)', -- !!!! Si ves este error, probablemente fue desencadenado por un inyector !!!!
	['011'] = '¡Falló un pago! (referencia desde PaymentItem - main.lua)', -- !!!! Si ves este error, probablemente fue desencadenado por un inyector !!!!
	['012'] = 'Se detectó una explotación.',
	['013'] = 'El jugador con la siguiente ID de servidor y licencia ha sido expulsado por sospecha de explotación (activó múltiples eventos de pago/ganancia de artículo dentro de 1 segundo): ',





}
