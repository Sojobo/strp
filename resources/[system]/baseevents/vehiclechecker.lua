local isInVehicle = false
local isEnteringVehicle = false
local currentVehicle = 0
local currentSeat = 0
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local bannedVehicles = {
    ['rhino'] = { hash = GetHashKey('rhino'), canDrive = nil, hasTrunkAccess = nil },
    ['hydra'] = { hash = GetHashKey('hydra'), canDrive = nil, hasTrunkAccess = nil },
    ['annihilator'] = { hash = GetHashKey('annihilator'), canDrive = nil, hasTrunkAccess = nil },
    ['buzzard'] = { hash = GetHashKey('buzzard'), canDrive = nil, hasTrunkAccess = nil },
    ['savage'] = { hash = GetHashKey('savage'), canDrive = 'nill', hasTrunkAccess = 'nill' },
    ['valkyrie'] = { hash = GetHashKey('valkyrie'), canDrive = nil, hasTrunkAccess = nil },
    ['valkyrie2'] = { hash = GetHashKey('valkyrie2'), canDrive = nil, hasTrunkAccess = nil },
    ['technical'] = { hash = GetHashKey('technical'), canDrive = nil, hasTrunkAccess = nil },
    ['technical2'] = { hash = GetHashKey('technical2'), canDrive = nil, hasTrunkAccess = nil },
    ['insurgent'] = { hash = GetHashKey('insurgent'), canDrive = nil, hasTrunkAccess = nil },
    ['insurgent2'] = { hash = GetHashKey('insurgent2'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['insurgent3'] = { hash = GetHashKey('insurgent3'), canDrive = nil, hasTrunkAccess = nil },
    ['limo2'] = { hash = GetHashKey('limo2'), canDrive = nil, hasTrunkAccess = nil },
    ['fireTruck'] = { hash = GetHashKey('fireTruck'), canDrive = nil, hasTrunkAccess = nil },
    ['lazer'] = { hash = GetHashKey('lazer'), canDrive = nil, hasTrunkAccess = nil },
    ['dump'] = { hash = GetHashKey('dump'), canDrive = nil, hasTrunkAccess = nil },
    ['swatbrickade'] = { hash = GetHashKey('swatbrickade'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['police'] = { hash = GetHashKey('Police'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['police2'] = { hash = GetHashKey('Police2'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['police3'] = { hash = GetHashKey('Police3'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['police4'] = { hash = GetHashKey('Police4'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['police5'] = { hash = GetHashKey('Police5'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['police6'] = { hash = GetHashKey('Police6'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['police7'] = { hash = GetHashKey('Police7'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['police8'] = { hash = GetHashKey('Police8'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['police9'] = { hash = GetHashKey('Police9'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['police10'] = { hash = GetHashKey('Police10'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['policet'] = { hash = GetHashKey('Policet'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['policeb'] = { hash = GetHashKey('Policeb'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['policeb2'] = { hash = GetHashKey('Policeb2'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['policeb3'] = { hash = GetHashKey('Policeb3'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['policeold1'] = { hash = GetHashKey('Policeold1'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['policeold2'] = { hash = GetHashKey('Policeold2'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['pranger'] = { hash = GetHashKey('pranger'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['riot'] = { hash = GetHashKey('riot'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['sheriff'] = { hash = GetHashKey('Sheriff'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['Sheriff2'] = { hash = GetHashKey('Sheriff2'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['sheriff3'] = { hash = GetHashKey('Sheriff3'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['sheriff4'] = { hash = GetHashKey('Sheriff4'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['sheriff5'] = { hash = GetHashKey('Sheriff5'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['sheriff6'] = { hash = GetHashKey('Sheriff6'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['fbi'] = { hash = GetHashKey('FBI'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['fbi2'] = { hash = GetHashKey('FBI2'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['fbi3'] = { hash = GetHashKey('FBI3'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['fbi4'] = { hash = GetHashKey('FBI4'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['fbi5'] = { hash = GetHashKey('FBI5'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['fbi6'] = { hash = GetHashKey('FBI6'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['pol718'] = { hash = GetHashKey('pol718'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['2015polstang'] = { hash = GetHashKey('2015polstang'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['ambulance'] = { hash = GetHashKey('ambulance'), canDrive = 'ambulance', hasTrunkAccess = 'ambulance' },
    ['ambulance2'] = { hash = GetHashKey('ambulance2'), canDrive = 'ambulance', hasTrunkAccess = 'ambulance' },
    ['emssuv'] = { hash = GetHashKey('emssuv'), canDrive = 'ambulance', hasTrunkAccess = 'ambulance' },
    ['emssuv2'] = { hash = GetHashKey('emssuv2'), canDrive = 'ambulance', hasTrunkAccess = 'ambulance' },
    ['emsvan'] = { hash = GetHashKey('emsvan'), canDrive = 'ambulance', hasTrunkAccess = 'ambulance' },
    ['emscar'] = { hash = GetHashKey('emscar'), canDrive = 'ambulance', hasTrunkAccess = 'ambulance' },
    ['emscar2'] = { hash = GetHashKey('emscar2'), canDrive = 'ambulance', hasTrunkAccess = 'ambulance' },
    ['fireTruk'] = { hash = GetHashKey('fireTruk'), canDrive = 'ambulance', hasTrunkAccess = 'ambulance' },
    ['engine'] = { hash = GetHashKey('engine'), canDrive = 'ambulance', hasTrunkAccess = 'ambulance' },
    ['fire1'] = { hash = GetHashKey('fire1'), canDrive = 'ambulance', hasTrunkAccess = 'ambulance' },
    ['fire2'] = { hash = GetHashKey('fire2'), canDrive = 'ambulance', hasTrunkAccess = 'ambulance' },
    ['fire3'] = { hash = GetHashKey('fire3'), canDrive = 'ambulance', hasTrunkAccess = 'ambulance' },
    ['cutter'] = { hash = GetHashKey('Cutter'), canDrive = nil, hasTrunkAccess = nil },
    ['handler'] = { hash = GetHashKey('Handler'), canDrive = nil, hasTrunkAccess = nil },
    ['trailersmall2'] = { hash = GetHashKey('Trailersmall2'), canDrive = nil, hasTrunkAccess = nil },
    ['apc'] = { hash = GetHashKey('APC'), canDrive = nil, hasTrunkAccess = nil },
    ['halftrack'] = { hash = GetHashKey('Halftrack'), canDrive = nil, hasTrunkAccess = nil },
    ['opressor'] = { hash = GetHashKey('Opressor'), canDrive = nil, hasTrunkAccess = nil },
    ['tampa3'] = { hash = GetHashKey('Tampa3'), canDrive = nil, hasTrunkAccess = nil },
    ['dune3'] = { hash = GetHashKey('Dune3'), canDrive = nil, hasTrunkAccess = nil },
    ['technical3'] = { hash = GetHashKey('Technical3'), canDrive = nil, hasTrunkAccess = nil },
    ['ardent'] = { hash = GetHashKey('Ardent'), canDrive = nil, hasTrunkAccess = nil },
    ['chernobog'] = { hash = GetHashKey('chernobog'), canDrive = nil, hasTrunkAccess = nil },
    ['stromberg'] = { hash = GetHashKey('stromberg'), canDrive = nil, hasTrunkAccess = nil },
    ['riot2'] = { hash = GetHashKey('riot2'), canDrive = 'police', hasTrunkAccess = 'police' },
    ['khanjali'] = { hash = GetHashKey('khanjali'), canDrive = nil, hasTrunkAccess = nil },
    ['besra'] = { hash = GetHashKey('besra'), canDrive = nil, hasTrunkAccess = nil },

}
-- Banned Vehicle Helpers

function getBannedVehicles()
    return bannedVehicles
end

function getBannedVehicleWithHash(hash)
    local vehicle = nil

    for k, v in pairs(bannedVehicles) do
        if v.hash == hash then
            vehicle = v
        end
    end

    return vehicle
end

function getBannedVehicleWithName(name)
    local vehicleName = string.lower(name)

    return bannedVehicles[vehicleName]
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local ped = PlayerPedId()
        local PlayerData = ESX.GetPlayerData()

		if not isInVehicle and not IsPlayerDead(PlayerId()) then
			if DoesEntityExist(GetVehiclePedIsTryingToEnter(ped)) and not isEnteringVehicle then
				-- trying to enter a vehicle!
				local vehicle = GetVehiclePedIsTryingToEnter(ped)
				local seat = GetSeatPedIsTryingToEnter(ped)
				local netId = VehToNet(vehicle)

                -- banned vehicle check
                for _, v in pairs(bannedVehicles) do
                    if IsVehicleModel(vehicle, v.hash) then
                        if v.canDrive ~= nil and v.canDrive == PlayerData.job.name then
                            break
                        else
                            vehicleBanned = true
                            ClearPedTasksImmediately(ped)
                            break
                        end
                    end
                end

                if not vehicleBanned then
                    isEnteringVehicle = true
                    DisplayRadar(true)
                    TriggerServerEvent('baseevents:enteringVehicle', vehicle, seat, GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)), netId)
                end
			elseif not DoesEntityExist(GetVehiclePedIsTryingToEnter(ped)) and not IsPedInAnyVehicle(ped, true) and isEnteringVehicle then
				-- vehicle entering aborted
                DisplayRadar(false)
				TriggerServerEvent('baseevents:enteringAborted')
				isEnteringVehicle = false
			elseif IsPedInAnyVehicle(ped, false) then
				-- suddenly appeared in a vehicle, possible teleport
				isEnteringVehicle = false
				isInVehicle = true
				currentVehicle = GetVehiclePedIsUsing(ped)
				currentSeat = GetPedVehicleSeat(ped)
				local model = GetEntityModel(currentVehicle)
				local name = GetDisplayNameFromVehicleModel()
				local netId = VehToNet(currentVehicle)

                -- banned vehicle check
                for _, v in pairs(bannedVehicles) do
                    if IsVehicleModel(currentVehicle, v.hash) then
                        if v.canDrive ~= nil then
                            break
                        else
                            vehicleBanned = true
                            ClearPedTasksImmediately(ped)
                            break
                        end
                    end
                end

                if not vehicleBanned then
                    DisplayRadar(true)
				    TriggerServerEvent('baseevents:enteredVehicle', currentVehicle, currentSeat, GetDisplayNameFromVehicleModel(GetEntityModel(currentVehicle)), netId)
                end
            end
		elseif isInVehicle then
			if not IsPedInAnyVehicle(ped, false) or IsPlayerDead(PlayerId()) then
				-- bye, vehicle
				local model = GetEntityModel(currentVehicle)
				local name = GetDisplayNameFromVehicleModel()
				local netId = VehToNet(currentVehicle)
                DisplayRadar(false)
				TriggerServerEvent('baseevents:leftVehicle', currentVehicle, currentSeat, GetDisplayNameFromVehicleModel(GetEntityModel(currentVehicle)), netId)
				isInVehicle = false
				currentVehicle = 0
				currentSeat = 0
			end
		end
		Citizen.Wait(50)
	end
end)

function GetPedVehicleSeat(ped)
    local vehicle = GetVehiclePedIsIn(ped, false)
    for i=-2,GetVehicleMaxNumberOfPassengers(vehicle) do
        if(GetPedInVehicleSeat(vehicle, i) == ped) then return i end
    end
    return -2
end

function driverIsNetworkPlayer(currentVehicle)
    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            if GetVehiclePedIsUsing(GetPlayerPed(i)) == currentVehicle and GetPlayerPed(i) ~= GetPlayerPed(-1) and GetPedVehicleSeat(GetPlayerPed(i)) == -1 then
                return true
            end
        end
    end

    return false
end