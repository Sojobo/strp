local currentLaunderer = 0
local launderBlip = nil
local launderRadius = nil
local lastSpot = 1
local laundering = -1
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
    TriggerServerEvent('dirtyMoney:getLaunderer')
end)

local launderLocations = {
    { name = "Money Launderer", active = 0, id = 408, x = -1318.62, y = -594.27, z = 28.60 },
    { name = "Money Launderer", active = 0, id = 408, x = -1359.47, y = -757.29, z = 22.30 },
    { name = "Money Launderer", active = 0, id = 408, x = -583.70, y = 225.55, z = 78.29 },
    { name = "Money Launderer", active = 0, id = 408, x = -164.20, y = 146.74, z = 73.58 },
    { name = "Money Launderer", active = 0, id = 408, x = 334.64, y = -152.95, z = 62.14 },
    { name = "Money Launderer", active = 0, id = 408, x = 802.11, y = -105.26, z = 80.56 },
    { name = "Money Launderer", active = 0, id = 408, x = 483.14, y = -1305.01, z = 29.24 },
    { name = "Money Launderer", active = 0, id = 408, x = -227.91, y = -1635.77, z = 33.61 },
    { name = "Money Launderer", active = 0, id = 408, x = -183.33, y = -1278.10, z = 31.29 },
    { name = "Money Launderer", active = 0, id = 408, x = -667.53, y = -169.48, z = 37.67 },
    { name = "Money Launderer", active = 0, id = 408, x = -3157.80, y = 1126.55, z = 20.84 },
    { name = "Money Launderer", active = 0, id = 408, x = -1109.30, y = 2726.49, z = 18.80 },
    { name = "Money Launderer", active = 0, id = 408, x = 638.69, y = 2773.60, z = 42.00 },
    { name = "Money Launderer", active = 0, id = 408, x = 1223.53, y = 2742.31, z = 38.22 },
    { name = "Money Launderer", active = 0, id = 408, x = 159.48, y = 6659.72, z = 31.46 },
}

function drawTxt(text, font, centre, x, y, scale, r, g, b, a)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

function isNearMoneyLaunderer()
    for i = 1, #launderLocations do
        if (launderLocations[i].active == 1) and laundering <= 0 then
            local ply = GetPlayerPed(-1)
            local plyCoords = GetEntityCoords(ply, 0)
            local distance = GetDistanceBetweenCoords(launderLocations[i].x, launderLocations[i].y, launderLocations[i].z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if isEmergencyStaff() and distance < 200 then
                -- move the launderer
                TriggerServerEvent('dirtyMoney:setLaunderer')
            end
            if (distance < 30) then
                DrawMarker(25, launderLocations[i].x, launderLocations[i].y, launderLocations[i].z - 1, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 0, 0, 255, 155, 0, 0, 2, 0, 0, 0, 0)
            end
            if (distance <= 1) then
                lastSpot = i
                return true
            end
        end
    end
end

function isNearSpecificMoneyLaunderer(launderer)
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    local distance = GetDistanceBetweenCoords(launderLocations[launderer].x, launderLocations[launderer].y, launderLocations[launderer].z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
    if (distance < 5) then
        return true
    end
end

function isEmergencyStaff()
    if PlayerData.job ~= nil and (PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance') then
        return true
    else
        return false
    end
end

Citizen.CreateThread(function()
    local dirtyWaitTime = 20000
    while true do
        Citizen.Wait(dirtyWaitTime)
        dirtyWaitTime = 1000

        local ply = GetPlayerPed(-1)
        if (isNearMoneyLaunderer()) then
            dirtyWaitTime = 0
            drawTxt("Press ~g~E~s~ to begin laundering your money.", 0, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)

            if IsControlJustPressed(1, 38) then
                local plyPos = GetEntityCoords(GetPlayerPed(-1), true)
                local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
                local street1 = GetStreetNameFromHashKey(s1)
                local street2 = GetStreetNameFromHashKey(s2)

                TriggerServerEvent('launderInProgressPos', plyPos.x, plyPos.y, plyPos.z)
                if s2 == 0 then
                    TriggerServerEvent('launderInProgressS1', street1)
                elseif s2 ~= 0 then
                    TriggerServerEvent('launderInProgress', street1, street2)
                end

                ESX.ShowAdvancedNotification("Money Laundering", "Stick around, I need to take a look at the cash first, I won't be long!", "fas fa-money-bill", "blue")
                Citizen.Wait(30000)
                if isNearSpecificMoneyLaunderer(lastSpot) then
	                TriggerServerEvent('dirtyMoney:launderMoney', lastSpot)
                    laundering = lastSpot
	            else
                    ESX.ShowAdvancedNotification("Money Laundering", "Hey, where'd you go?", "fas fa-money-bill", "blue")
	            end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if laundering > 0 and (not isNearSpecificMoneyLaunderer(laundering) or IsPedBeingStunned(closestPed) or IsEntityPlayingAnim(closestPed, "random@mugging3", "handsup_standing_base", 3)) then
            TriggerServerEvent('dirtyMoney:setLaunderer')
            laundering = -1
        end
    end
end)

RegisterNetEvent('dirtyMoney:updateLaunderer')
AddEventHandler('dirtyMoney:updateLaunderer', function(launderer)
    if currentLaunderer > 0 then
        launderLocations[currentLaunderer].active = 0
    end

    currentLaunderer = launderer
    launderLocations[launderer].active = 1
    laundering = -1

    if launderBlip ~= nil then
        RemoveBlip(launderBlip)
    end
    if launderRadius ~= nil then
        RemoveBlip(launderRadius)
    end

    if not isEmergencyStaff() then
    	launderRadius = AddBlipForRadius(launderLocations[launderer].x, launderLocations[launderer].y, launderLocations[launderer].z, 30.0)
        SetBlipHighDetail(launderRadius, true)
        SetBlipColour(launderRadius, 1)
        SetBlipAlpha (launderRadius, 128)

        launderBlip = AddBlipForCoord(launderLocations[launderer].x, launderLocations[launderer].y, launderLocations[launderer].z)
        SetBlipSprite(launderBlip, launderLocations[launderer].id)
        SetBlipAsShortRange(launderBlip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(launderLocations[launderer].name)
        EndTextCommandSetBlipName(launderBlip)
    end
end)

RegisterNetEvent('dirtyMoney:toggleLaunderer')
AddEventHandler('dirtyMoney:toggleLaunderer', function()
    if launderBlip ~= nil then
        RemoveBlip(launderBlip)
    end
    if launderRadius ~= nil then
        RemoveBlip(launderRadius)
    end

    if not isEmergencyStaff() then
    	launderRadius = AddBlipForRadius(launderLocations[currentLaunderer].x, launderLocations[currentLaunderer].y, launderLocations[currentLaunderer].z, 30.0)
        SetBlipHighDetail(launderRadius, true)
        SetBlipColour(launderRadius, 1)
        SetBlipAlpha (launderRadius, 128)

        launderBlip = AddBlipForCoord(launderLocations[currentLaunderer].x, launderLocations[currentLaunderer].y, launderLocations[currentLaunderer].z)
        SetBlipSprite(launderBlip, launderLocations[currentLaunderer].id)
        SetBlipAsShortRange(launderBlip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(launderLocations[currentLaunderer].name)
        EndTextCommandSetBlipName(launderBlip)
    end
end)

RegisterNetEvent("dirtyMoney:transferCheck")
AddEventHandler("dirtyMoney:transferCheck", function(to, amount)
    if not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
        local myCoords = GetEntityCoords(GetPlayerPed(-1), 0)
        local targetCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(to)), 0)
        local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], myCoords["x"], myCoords["y"], myCoords["z"], true)

        if distance <= 10 then
            TriggerServerEvent("dirtyMoney:transfer", to, amount)
        else
            ESX.ShowAdvancedNotification("Money Laundering", "You're not close enough to give this person dirty money!", "fas fa-money-bill", "red")
        end
    else
        ESX.ShowAdvancedNotification("Money Laundering", "You can't pass someone dirty money when you're cuffed!", "fas fa-money-bill", "red")
    end
end)