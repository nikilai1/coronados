Config = {}

--Job Command START --
Config.Commandjob = "alerta"
Config.CommandHandle = "Anuncio de trabajo"
--Job Command END --


--Admin Command START --
Config.CommandAdmin = "adminannounce"
Config.CommandAdminHandle = "Anuncio de administracíon"
--Admin Command END --

--Success message--
Config.SuccessSent = "Has enviado correctamente la notificación"
--Success message END--



--Error Messages--
Config.BlackListedMessage = "Estas usando una plabra blacklisteada"
Config.limitexcededMessage = "Mensaje demasiado largo"
Config.ArgMissing = "Añade el mensaje para notificar"
--Error Messages END--


--Allowed Jobs --
Config.Jobs = {
    'police',
    'ambulance',
    'burgershot',
    'mechanic',
    'lsc'
}
--Allowed Jobs END--

--BlackListed Words ---
Config.BlacklistedWords = {
    "Polla",
    "Pene"
}
--BlackListed Words END---


-------------------------- DISCORD LOGS

-- To set your Discord Webhook URL go to server.lua, line 5
Config.Webhook = 'https://discord.com/api/webhooks/1004580128820580372/FkKa14WVQ9dPE_lpfPP8e-uh9h0yoBjRFvkK1DwjGymXbwHPLg6sw56r2_yFbC_235mQ'
Config.BotName = 'JobAnuncios' -- Write the desired bot name

Config.ServerName = 'Latin Life' -- Write your server's name

Config.IconURL = 'https://cdn.discordapp.com/attachments/841804982470836244/1002698266531598447/lf_popker.png' -- Insert your desired image link

Config.DateFormat = '%d/%m/%Y [%X]' -- To change the date format check this website - https://www.lua.org/pil/22.1.html

-- To change a webhook color you need to set the decimal value of a color, you can use this website to do that - https://www.mathsisfun.com/hexadecimal-decimal-colors.html45518a

Config.Notificationssentcolor = '65352'

