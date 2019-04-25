ESX        = nil
cachedBins = {}
closestBin = {
    'prop_dumpster_01a',
    'prop_dumpster_02a',
    'prop_dumpster_02b',
    'prop_dumpster_4a',
    'prop_dumpster_4b',
    "prop_bin_01a",
    "prop_bin_03a",
    "prop_bin_05a"
}

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(5)

		TriggerEvent("esx:getSharedObject", function(library)
			ESX = library
		end)
    end

    if ESX.IsPlayerLoaded() then
		ESX.PlayerData = ESX.GetPlayerData()
	end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(response)
	ESX.PlayerData = response
end)

Citizen.CreateThread(function()
    while true do
        
        local sleep = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        for i = 1, #closestBin do
            local x = GetClosestObjectOfType(playerCoords, 2.0, GetHashKey(closestBin[i]), false, false, false)
            local entity = nil
            if DoesEntityExist(x) then
                entity = x
                bin    = GetEntityCoords(entity)
                sleep  = 5
                DrawText3D(bin.x, bin.y, bin.z + 1.5, 'Press [~g~E~s~] to search ~b~bin~s~')  
                if IsControlJustReleased(0, 38) then
                    if not cachedBins[entity] then
                        OpenBin(entity)
                    else
                        ESX.ShowNotification('~r~You or someone has already been looking here!~s~')
                    end
                end
                break
            else
                sleep = 1000
            end
        end
        Citizen.Wait(sleep)
    end
end)