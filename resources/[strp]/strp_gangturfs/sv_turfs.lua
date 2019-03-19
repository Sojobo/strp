ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local gangTurfs = {
    {
        name = "El Burro Industrial",
        controller = "vagos",
        controlStrength = 100,
        securetime = 0,
        x = 1543.43,
        y = -2117.60,
        z = 77.05,
        radius = 100.0,
    },
    {
        name = "Pacific Bluffs Complex",
        controller = "triads",
        controlStrength = 100,
        securetime = 0,
        x = -2242.14,
        y = 262.28,
        z = 174.61,
        radius = 100.0,    },
    {
        name = "McKenzie Field Airport",
        controller = "lostmc",
        controlStrength = 100,
        securetime = 0,
        x = 2131.59,
        y = 4785.76,
        z = 40.97,
        radius = 60.0,
    },
}

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
