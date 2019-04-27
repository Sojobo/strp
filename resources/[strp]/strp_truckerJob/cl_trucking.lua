--use this for debugging
function Chat(t)
    TriggerEvent("chatMessage", 'TRUCKER', { 0, 255, 255 }, "" .. tostring(t))
end

--locations
local TruckingCompany = {
    { x = 572.381164550781, y = -2733.16186523438, z = 6.05601692199707 }, -- docks
    { x = 609.25366210938, y = 2801.71484375, z = 41.9049949646 }, -- harmony
    { x = 124.2859954834, y = 6418.126953125, z = 31.350793838501 }, -- paleto
}

local TruckingTrailer = {
    { x = 562.52325439453, y = -2749.9963378906, z = 6.0561451911926 }, -- docks
    { x = 586.24780273438, y = 2796.7827148438, z = 42.073097229004 }, -- harmony
    { x = 154.07713317871, y = 6426.6508789063, z = 31.299301147461 }, -- paleto
}

function isNearTruckingCompany()
    for i = 1, #TruckingCompany do
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        local distance = GetDistanceBetweenCoords(TruckingCompany[i].x, TruckingCompany[i].y, TruckingCompany[i].z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        if (distance < 10) then
            return true
        end
    end
end

function getNearTruckingCompany(id)
    for i = 1, #TruckingCompany do
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        local distance = GetDistanceBetweenCoords(TruckingCompany[i].x, TruckingCompany[i].y, TruckingCompany[i].z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        if (distance < 15 and not id) then
            return TruckingCompany[i]
        elseif (distance < 15 and id) then
            return i
        end
    end
end

function round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.abs(math.floor(num * mult + 0.5) / mult)
end

local Truck = { "PACKER", "HAULER" }
local Trailer = { "TANKER", "TRAILERS", "TRAILERS2", "TRAILERLOGS", "ARMYTANKER", "TR2", "TR4", "TRFLAT", "TVTRAILER" }

local nextMission, currentMission

local MISSION = {}
MISSION.start = false
MISSION.trailer = false
MISSION.truck = false
MISSION.depo = {}

MISSION.hashTruck = 0
MISSION.hashTrailer = 0

local playerCoords
local playerPed

local GUI = {}
GUI.showStartText = false
GUI.showMenu = false
GUI.selected = {}
GUI.menu = -1 --current menu

GUI.title = {}
GUI.titleCount = 0

GUI.desc = {}
GUI.descCount = 0

GUI.button = {}
GUI.buttonCount = 0

GUI.time = 0

--text for mission
local text1 = false
local text2 = false

--blips
local BLIP = {}

BLIP.company = 0

BLIP.trailer = {}
BLIP.trailer.i = 0

BLIP.destination = {}
BLIP.destination.i = 0

--focus button color
local r = 0
local g = 128
local b = 192
local alpha = 200

function clear()
    MISSION.start = false
    SetBlipRoute(BLIP.destination[BLIP.destination.i], false)
    SetEntityAsNoLongerNeeded(BLIP.destination[BLIP.destination.i])

    if (DoesEntityExist(MISSION.trailer)) then
        SetEntityAsNoLongerNeeded(MISSION.trailer)
    end
    --if (DoesEntityExist(MISSION.truck)) then
    --    SetEntityAsNoLongerNeeded(MISSION.truck)
    --end
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(MISSION.trailer))
    --Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(MISSION.truck))

    MISSION.depo = {}
    MISSION.trailer = 0
    MISSION.truck = 0
    MISSION.hashTruck = 0
    MISSION.hashTrailer = 0
    currentMission = nil
end

local initload = false
Citizen.CreateThread(function()
    TriggerServerEvent('truckerJob:requestCurrentMission')
    while true do
        Wait(0)
        playerPed = GetPlayerPed(-1)
        playerCoords = GetEntityCoords(playerPed, 0)
        if (not initload) then
            init()
            initload = true
        end
        tick()
    end
end)

function init()
    for i = 1, #TruckingCompany do
        BLIP.company = AddBlipForCoord(TruckingCompany[i].x, TruckingCompany[i].y, TruckingCompany[i].z)
        SetBlipSprite(BLIP.company, 67)
        SetBlipDisplay(BLIP.company, 4)
        SetBlipScale(BLIP.company, 0.8)
        SetBlipAsShortRange(BLIP.company, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Trucking Job")
        EndTextCommandSetBlipName(BLIP.company)
    end    
    Citizen.Trace("Truck Blips added.")
end

--Draw Text / Menus
function tick()
    --debugging stange things
    if (type(BLIP.trailer[BLIP.trailer.i]) == "boolean") then
        --Citizen.Trace("-FAIL!-")
    elseif (BLIP.trailer[BLIP.trailer.i] == nil) then
        --Citizen.Trace("-nil-")
    else
        BLIP.trailer[BLIP.trailer.i] = BLIP.trailer[BLIP.trailer.i]
        BLIP.destination[BLIP.destination.i] = BLIP.destination[BLIP.destination.i]
    end

    --Show menu, when player is near
    if (MISSION.start == false) then
        if isNearTruckingCompany() then
            if (GUI.showStartText == false) then
                GUI.drawStartText()
            end
            --key controlling
            if IsControlPressed(1, 38) then
                GUI.mission(nextMission)
                GUI.menu = getNearTruckingCompany(true)
            end
        else
            GUI.showStartText = false
        end
    elseif (MISSION.start == true) then
        MISSION.markerUpdate(IsEntityAttached(MISSION.trailer))
        if (IsEntityAttached(MISSION.trailer) and text1 == false) then
            TriggerEvent("mt:missiontext", "Drive to the marked ~g~destination~w~.", 10000)
            text1 = true
        elseif (not IsEntityAttached(MISSION.trailer) and text2 == false) then
            TriggerEvent("mt:missiontext", "Attach the ~o~trailer~w~.", 15000)
            text2 = true
        end
        Wait(2000)
        local trailerCoords = GetEntityCoords(MISSION.trailer, 0)
        if (GetDistanceBetweenCoords(currentMission[1], currentMission[2], currentMission[3], trailerCoords) < 25 and not IsEntityAttached(MISSION.trailer)) then
            MISSION.removeMarker()
            MISSION.finishMission()
            clear()
        elseif (GetDistanceBetweenCoords(currentMission[1], currentMission[2], currentMission[3], trailerCoords) < 25 and IsEntityAttached(MISSION.trailer)) then
            TriggerEvent("mt:missiontext", "Arrived. Hold ~r~H~w~ to detach your ~o~trailer~w~", 15000)
        end

        if (IsEntityDead(MISSION.trailer) or IsEntityDead(MISSION.truck)) then
            MISSION.removeMarker()
            clear()
        end
    end
end

function GUI.mission(missionN)
    --select random trailer
    MISSION.hashTrailer = GetHashKey(nextMission[5])
    RequestModel(MISSION.hashTrailer)

    while not HasModelLoaded(MISSION.hashTrailer) do
        Wait(1)
    end

    --select random truck
    MISSION.hashTruck = GetHashKey(nextMission[4])
    RequestModel(MISSION.hashTruck)

    while not HasModelLoaded(MISSION.hashTruck) do
        Wait(1)
    end

    --currently one destination per ride
    BLIP.trailer.i = BLIP.trailer.i + 1
    BLIP.destination.i = BLIP.destination.i + 1
    currentMission = nextMission

    --mission start
    MISSION.start = true
    MISSION.depo = getNearTruckingCompany(false)
    MISSION.spawnTrailer()

    local myTruck = GetVehiclePedIsIn(playerPed, false) -- true means last vehicle, false means current only
    if myTruck ~= 0 then -- are we in a vehicle?
        if IsVehicleModel(myTruck, GetHashKey("Phantom")) or 
            IsVehicleModel(myTruck, GetHashKey("Phantom3")) or 
            IsVehicleModel(myTruck, GetHashKey("Packer")) or 
            IsVehicleModel(myTruck, GetHashKey("Hauler")) or 
            IsVehicleModel(myTruck, GetHashKey("Hauler2")) then -- is that vehicle a truck?
            MISSION.truck = myTruck
        else
            MISSION.spawnTruck()
        end
    else
        MISSION.spawnTruck()
    end
end

function MISSION.spawnTruck()
    MISSION.truck = CreateVehicle(MISSION.hashTruck, getNearTruckingCompany(false).x, getNearTruckingCompany(false).y, getNearTruckingCompany(false).z, 160.488662719727, true, false)
    SetVehicleOnGroundProperly(MISSION.trailer)
    SetVehRadioStation(MISSION.truck, "OFF")
    SetPedIntoVehicle(playerPed, MISSION.truck, -1)
    SetVehicleEngineOn(MISSION.truck, true, false, false)

    -- TriggerServerEvent('vehicleManager:removeTrunk', GetVehicleNumberPlateText(MISSION.truck))
end

function MISSION.spawnTrailer()
    MISSION.trailer = CreateVehicle(MISSION.hashTrailer, TruckingTrailer[getNearTruckingCompany(true)].x, TruckingTrailer[getNearTruckingCompany(true)].y, TruckingTrailer[getNearTruckingCompany(true)].z, 333.239807128906, true, false)
    SetVehicleOnGroundProperly(MISSION.trailer)
    -- TriggerServerEvent('vehicleManager:removeTrunk', GetVehicleNumberPlateText(MISSION.trailer))
    
    --setMarker on trailer
    MISSION.trailerMarker()
end

local oneTime = false

function MISSION.trailerMarker()
    BLIP.trailer[BLIP.trailer.i] = AddBlipForEntity(MISSION.trailer)
    SetBlipSprite(BLIP.trailer[BLIP.trailer.i], 1)
    SetBlipColour(BLIP.trailer[BLIP.trailer.i], 17)
    SetBlipRoute(BLIP.trailer[BLIP.trailer.i], false)
    Wait(50)
end

function MISSION.markerUpdate(trailerAttached)
    if (not BLIP.destination[BLIP.destination.i] and trailerAttached) then
        BLIP.destination[BLIP.destination.i] = AddBlipForCoord(currentMission[1], currentMission[2], currentMission[3])
        SetBlipSprite(BLIP.destination[BLIP.destination.i], 1)
        SetBlipColour(BLIP.destination[BLIP.destination.i], 2)
        SetBlipRoute(BLIP.destination[BLIP.destination.i], true)
    end
    if (trailerAttached) then
        SetBlipSprite(BLIP.trailer[BLIP.trailer.i], 2) --invisible
    elseif (not trailerAttached and BLIP.trailer[BLIP.trailer.i]) then
        SetBlipSprite(BLIP.trailer[BLIP.trailer.i], 1) --visible
        SetBlipColour(BLIP.trailer[BLIP.trailer.i], 17)
    end
    Wait(50)
end

function MISSION.removeMarker()
    SetBlipSprite(BLIP.destination[BLIP.destination.i], 2) --invisible
    SetBlipSprite(BLIP.trailer[BLIP.trailer.i], 2) --invisible
end

function MISSION.finishMission()
    local trailerDamage = GetEntityMaxHealth(MISSION.trailer) - GetEntityHealth(MISSION.trailer)
    local distanceCovered = math.floor(GetDistanceBetweenCoords(MISSION.depo.x, MISSION.depo.y, MISSION.depo.z, currentMission[1], currentMission[2], currentMission[3]))
    TriggerServerEvent("truckerJob:completeMission", trailerDamage, distanceCovered, currentMission)

    if (DoesEntityExist(MISSION.trailer)) then
        SetEntityAsMissionEntity(MISSION.trailer, true, true)
        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(MISSION.trailer))
    end
end

function GUI.drawStartText()
    TriggerEvent("mt:missiontext", "Press ~r~E~w~ to take a trucking job.", 500)
    --GUI.showStartText = true
end

RegisterNetEvent('truckerJob:updateCurrentMission')
AddEventHandler('truckerJob:updateCurrentMission', function(mission)
    nextMission = mission
end)