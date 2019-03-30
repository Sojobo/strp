ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local gangTurfs = {}

local turfs_file = LoadResourceFile(GetCurrentResourceName(), "gang_turfs.json")
gangTurfs = json.decode(turfs_file)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    Citizen.Wait(1000 * 60)
    SaveResourceFile(GetCurrentResourceName(), "gang_turfs.json", json.encode(gangTurfs), -1)
  end
end)

RegisterServerEvent('gangturf:contestTurf')
AddEventHandler('gangturf:contestTurf', function(contendingTurf)
    if gangTurfs[contendingTurf].securetime > 0 then
        return
    end

    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job ~= nil then
        -- Defence
        if xPlayer.job.name == gangTurfs[contendingTurf].controller then
            gangTurfs[contendingTurf].controlStrength = gangTurfs[contendingTurf].controlStrength + 1
            if (gangTurfs[contendingTurf].controlStrength >= 100) then
                gangTurfs[contendingTurf].controlStrength = 100
                gangTurfs[contendingTurf].securetime = 1800
            end

        -- Assault
        elseif xPlayer.job.name == 'lostmc' or xPlayer.job.name == 'triads' or xPlayer.job.name == 'vagos' then
            gangTurfs[contendingTurf].controlStrength = gangTurfs[contendingTurf].controlStrength - 1

            if (gangTurfs[contendingTurf].controlStrength <= 0) then
                local notification = {
                    subject    = "Gang Alert",
                    msg      = "Your gang has lost control of " .. gangTurfs[contendingTurf].name,
                    icon = 'fas fa-skull-crossbones',
                    iconStyle = 'red'
                }
                TriggerEvent('esx_service:notifyAllInService', notification, gangTurfs[contendingTurf].controller)
                gangTurfs[contendingTurf].controller = xPlayer.job.name
                gangTurfs[contendingTurf].controlStrength = 1
            elseif (gangTurfs[contendingTurf].controlStrength % 9) then
                local notification = {
                    subject    = "Gang Alert",
                    msg      = "Your turf (" .. gangTurfs[contendingTurf].name .. ") is under attack!",
                    icon = 'fas fa-skull-crossbones',
                    iconStyle = 'red'
                }
                TriggerEvent('esx_service:notifyAllInService', notification, gangTurfs[contendingTurf].controller)
            end
        end
    end

    TriggerClientEvent('gangturf:updateTurfData', -1, gangTurfs)
end)

RegisterServerEvent('gangturf:requestTurfData')
AddEventHandler('gangturf:requestTurfData', function(contendingTurf, contendingGang)
    TriggerClientEvent('gangturf:updateTurfData', source, gangTurfs)
end)

Citizen.CreateThread(function()
    while true do
        local changesMade = false
        for k, turf in pairs(gangTurfs) do
            if (turf.securetime > 0) then
                turf.securetime = turf.securetime -1
                changesMade = true
            end
        end
        if changesMade then
            TriggerClientEvent('gangturf:updateTurfData', -1, gangTurfs)
        end
        Citizen.Wait(1000)
    end
end)

ESX.RegisterServerCallback('gangturf:getTurfOwner', function(source, cb, turf)
	cb(gangTurfs[turf].controller)
end)

function getTurfOwner(turf)
    return gangTurfs[turf].controller
end