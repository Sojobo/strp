ESX = nil
local hasShot = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/gsr', _U('help_gsr'), {{name = _U('help_gsr_value'), help = _U('help_gsr')}})
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        ped = GetPlayerPed(-1)
        if IsPedShooting(ped) then
            TriggerServerEvent('esx_gsr:SetGSR', timer)
            hasShot = true
            Citizen.Wait(Config.gsrUpdate)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(2000)
        if Config.waterClean and hasShot then
            ped = GetPlayerPed(-1)
            if IsEntityInWater(ped) then
                TriggerEvent('esx_gsr:Notify', _U('gsr_clean_wait'), "error")
                Citizen.Wait(Config.waterCleanTime)
                if IsEntityInWater(ped) then
                    hasShot = false
                    TriggerServerEvent('esx_gsr:Remove')
                    TriggerEvent('esx_gsr:Notify', _U('gsr_cleaned'), "success")
                else
                    TriggerEvent('esx_gsr:Notify', _U('gsr_clean_failed'), "error")
                end
            end
        end
    end
end)

RegisterNetEvent('esx_gsr:Notify')
AddEventHandler('esx_gsr:Notify', function(text, type)
    exports.pNotify:SetQueueMax("left", 1)
    exports.pNotify:SendNotification({
        text = text,
        type = type,
        timeout = 5000,
        layout = "centerLeft",
        queue = "left",
    })
end)

function status()
    if hasShot then
        ESX.TriggerServerCallback('esx_gsr:Status', function(cb)
            if not cb then
                hasShot = false
            end
        end)
    end
    SetTimeout(Config.gsrUpdateStatus, status)
end

status()
