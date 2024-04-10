local QBCore = exports['qb-core']:GetCoreObject()
local AlertSentUseable = {}
local AlertUsed = {}
QBCore.Commands.Add(Config.Commandjob, Config.CommandHandle, {{name='message', help='Message'}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if args[1] then
        local msg = table.concat(args, " ")
        local word = msg
        for k, v in pairs(Config.Jobs) do
            if Player.PlayerData.job.name == v then
                for k, v in pairs(Config.BlacklistedWords) do
                    if string.match(word, string.lower(v)) then return TriggerClientEvent('QBCore:Notify', src, Config.BlackListedMessage, "error") end
                     return sendnotification(src, Player.PlayerData.job.name, word)  
                end
            end
        end
    else
       return TriggerClientEvent('QBCore:Notify', src, Config.ArgMissing)
    end
end)
QBCore.Commands.Add("OpenEmpresa", "Informar que su establecimiento se encuentra disponible", {}, false, function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if true then
        local word = "El establecimiento se encuentra disponibles para la atencion al publico"
        for k, v in pairs(Config.Jobs) do
            if Player.PlayerData.job.name == v then
                for k, v in pairs(Config.BlacklistedWords) do
                    if string.match(word, string.lower(v)) then return TriggerClientEvent('QBCore:Notify', src, Config.BlackListedMessage, "error") end
                     return sendnotification(src, Player.PlayerData.job.name, word)  
                end
            end
        end
    end
end)

QBCore.Commands.Add(Config.CommandAdmin, Config.CommandAdminHandle, {{name='message', help='Message'}}, true, function(source, args)
    local msg = table.concat(args, ' ')
    TriggerClientEvent('Thedoc_JobNotifications:client:showui', -1, "admin", msg)
end, 'admin')


function sendnotification(_source, job, msg)
    --print(GetGameTimer())
    TriggerClientEvent('QBCore:Notify', _source, Config.SuccessSent, "success")
    TriggerClientEvent('Thedoc_JobNotifications:client:showui', -1, job, msg, _source)
    local data = {
        name = _source,
        job = job,
        msg = msg
    }
    sendwebhook(data)
end


--- WebHook --
function sendwebhook(data)
	local information = {
		{
			["color"] = Config.Notificationssentcolor,
			["author"] = {
				["icon_url"] = Config.IconURL,
				["name"] = Config.ServerName..' - Logs',
			},
			["title"] = 'JobNotifications',
			["description"] = '**User: **' .. GetPlayerName(data.name) .. ' \n **Job: **' .. data.job .. ' \n **msg: **' .. data.msg,

			["footer"] = {
				["text"] = os.date(Config.DateFormat),
			}
		}
	}
	PerformHttpRequest(Config.Webhook, function(err, text, headers) end, 'POST', json.encode({username = '', embeds = information}), {['Content-Type'] = 'application/json'})
end
-- WebHook END --