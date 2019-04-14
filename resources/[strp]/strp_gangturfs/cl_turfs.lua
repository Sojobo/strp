ESX = nil
local PlayerData = {}

local contendingTurf = 0
local gangColours = {
    vagos = 46,
    rednecks = 29,
    triads = 76,
    lostmc = 40,
}
local turfCoordsBlips = {}
local turfRadiusBlips = {}
local gangTurfs = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
  TriggerServerEvent("gangturf:requestTurfData")
end)

Citizen.CreateThread(function()
    while true do
        local sleeping = 1000
        local nearbyTurf = isNearCapturePoint(15)
        if (nearbyTurf > 0) then
            if PlayerData.job ~= nil then
                sleeping = 0

                -- Too recent
                if gangTurfs[nearbyTurf].securetime > 60 then
                    drawTxt("This area was recently captured Please wait another: ~r~" .. round(gangTurfs[nearbyTurf].securetime / 60, 0) .. "~s~ minutes.", 0, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
                elseif gangTurfs[nearbyTurf].securetime > 0 then
                    drawTxt("This area was recently captured Please wait another: ~r~" .. gangTurfs[nearbyTurf].securetime .. "~s~ seconds.", 0, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)

                -- Defence
                elseif PlayerData.job.name == gangTurfs[nearbyTurf].controller then
                    contendingTurf = nearbyTurf
                    drawTxt("Defending " .. gangTurfs[nearbyTurf].name .. " (" .. gangTurfs[nearbyTurf].controlStrength .. "%) for " .. gangTurfs[nearbyTurf].controller, 0, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)

                -- Assault
                elseif PlayerData.job.name == 'lostmc' or PlayerData.job.name == 'rednecks' or PlayerData.job.name == 'triads' or PlayerData.job.name == 'vagos' then
                    contendingTurf = nearbyTurf
                    drawTxt("Capturing " .. gangTurfs[nearbyTurf].name .. " (" .. gangTurfs[nearbyTurf].controlStrength .. "%) from " .. gangTurfs[nearbyTurf].controller, 0, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)

                end
            end
        else
            contendingTurf = 0
        end
        Citizen.Wait(sleeping)
    end
end)

Citizen.CreateThread(function()
    while true do
        if (contendingTurf > 0) then
            TriggerServerEvent("gangturf:contestTurf", contendingTurf)
        end
        Citizen.Wait(10000)
    end
end)

function isNearCapturePoint(range)
    for i = 1, #gangTurfs do
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        local distance = GetDistanceBetweenCoords(gangTurfs[i].x, gangTurfs[i].y, gangTurfs[i].z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        if (distance < range) then
            return i
        end
    end
    return 0
end

function round(num, idp)
    if idp and idp > 0 then
        local mult = 10 ^ idp
        return math.floor(num * mult + 0.5) / mult
    end
    return math.floor(num + 0.5)
end

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

RegisterNetEvent('gangturf:updateTurfData')
AddEventHandler('gangturf:updateTurfData', function(turfData)
	gangTurfs = turfData
    createBlips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job

	if job.name == 'lostmc' or job.name == 'rednecks' or job.name == 'triads' or job.name == 'vagos' then
        TriggerServerEvent("gangturf:requestTurfData")
	end
end)

function createBlips()
	-- Refresh all blips
	for k, existingBlip in pairs(turfRadiusBlips) do
		RemoveBlip(existingBlip)
	end
	for k, existingBlip in pairs(turfCoordsBlips) do
		RemoveBlip(existingBlip)
	end

    for k, turf in pairs(gangTurfs) do
    	local blip = AddBlipForRadius(turf.x, turf.y, turf.z, turf.radius)
        SetBlipHighDetail(blip, true)
        SetBlipColour(blip, 1)
        SetBlipAlpha (blip, 128)
		table.insert(turfRadiusBlips, blip)

        local blip = AddBlipForCoord(turf.x, turf.y, turf.z)
        SetBlipSprite(blip, 378)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(turf.name)
        EndTextCommandSetBlipName(blip)
        SetBlipAsMissionCreatorBlip(blip, true)
        SetBlipColour(blip, gangColours[turf.controller])
		table.insert(turfCoordsBlips, blip)
    end
end
