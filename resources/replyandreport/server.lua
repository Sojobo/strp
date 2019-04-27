--[[

  Made with love by Cheleber, you can join my RP Server here: www.grandtheftlusitan.com
  Just add your admins steam id!

--]]

--- ADD STEAM ID OR LICENSE FROM YOUR ADMINS!
local admins = {
    --'steam:110000105c4d991',
	'license:2524921ce9778db979b0bf297a99edd65a837da8', --frankie
	'license:05a09ffadcdd4fad0f75d36c702e4492cbb91bf0', -- zevo
	'license:8e9b7c196612d48c8f3109a48ab9bae5dc5b6a2a', -- sojo
	'license:31e40ddd4737fe9ffed5bde84d24f2ec3d8e7ab0', --kevin
	'license:66dedb5678c489162a3a264f0a64c5f4411c3366', -- santa
	'steam:11000010400b1fc', --jamie
    'steam:110000101a7a8ea', --bean
    'license:127fe8e5ff21680085b65454bd5d6c07046e23d1',  -- hoover
    'license:622f0a9d6bcf42158bdced35d2e8a1ac7349eaa4', --holder
    'license:af6b7476fd02f0eb0af09f9d0df2269999669ce5', -- jerry
    'license:d556be5e5e8c496f128561b704d895540b2a7ae6' -- terry
}

function isAdmin(player)
    local allowed = false
    for i,id in ipairs(admins) do
        for x,pid in ipairs(GetPlayerIdentifiers(player)) do
            if string.lower(pid) == string.lower(id) then
                allowed = true
            end
        end
    end
    return allowed
end

RegisterCommand('report', function(source, args, rawCommand)
	if source == 0 then
		print('replayandreport: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)

    TriggerClientEvent("sendReport", -1, source, name, args)
end, false)

RegisterCommand('reply', function(source, args, rawCommand)
	if source == 0 then
		print('replayandreport: you can\'t use this command from rcon!')
		return
	end

    local message = table.concat(args, ' ')
    message = string.sub(message, string.len(args[1]) + 2)
    local targetplayer = args[1]

    local names2 = GetPlayerName(targetplayer)
    local names3 = GetPlayerName(source)

    if isAdmin(source) then
        TriggerClientEvent('textmsg', targetplayer, message, names3)
        TriggerClientEvent('textsent', source, targetplayer, names2)
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insuficient Premissions!")
    end
end, false)

RegisterServerEvent('replyandreport:checkadmin')
AddEventHandler('replyandreport:checkadmin', function(n1, tmsg, ii)
	local id = source
	if isAdmin(id) then
		TriggerClientEvent("sendReportToAllAdmins", -1, source, n1, tostring(tmsg), ii)
	else
	end
end)


function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end



function tablelength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end
