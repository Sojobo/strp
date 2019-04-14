--[[

  Made with love by Cheleber, you can join my RP Server here: www.grandtheftlusitan.com
  Just add your admins steam id to server and client!

--]]

--- ADD YOUR STEAM ID OR LICENSE FROM YOUR ADMINS!
local admins = {
    'license:2524921ce9778db979b0bf297a99edd65a837da8', --frankie
	'license:05a09ffadcdd4fad0f75d36c702e4492cbb91bf0', -- zevo
	'license:8e9b7c196612d48c8f3109a48ab9bae5dc5b6a2a', -- sojo
	'license:31e40ddd4737fe9ffed5bde84d24f2ec3d8e7ab0', --kevin
	'license:66dedb5678c489162a3a264f0a64c5f4411c3366', -- santa
	'steam:11000010400b1fc', --jamie
	'steam:110000101a7a8e' --bean
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

RegisterServerEvent('idonlyforadmin:checkadmin')
AddEventHandler('idonlyforadmin:checkadmin', function()
	local id = source
	if isAdmin(id) then
		TriggerClientEvent("setgroup", source)
	end
end)