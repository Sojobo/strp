local chopShops = {
    { x = -556.02, y = -1695.28, z = 19.28 },
}
local shoppingList = {
    ["picador"] = { name = "Picador", model = "picador" },
    ["primo"] = { name = "Primo", model = "primo" },
    ["dilettante"] = { name = "Dilettante", model = "dilettante" },
    ["gauntlet"] = { name = "Gauntlet", model = "gauntlet" },
    ["huntley"] = { name = "Huntley S", model = "huntley" },
    ["buccaneer"] = { name = "Buccaneer", model = "buccaneer" },
    ["landstalker"] = { name = "Landstalker", model = "landstalker" },
    ["sentinel2"] = { name = "Sentinel", model = "sentinel2" },
    ["sentinel"] = { name = "Sentinel XS", model = "sentinel" },
    ["buffalo"] = { name = "Buffalo", model = "buffalo" },
    ["exemplar"] = { name = "Exemplar", model = "exemplar" },
    ["alpha"] = { name = "Alpha", model = "alpha" },
    ["banshee"] = { name = "Banshee", model = "banshee" },
    ["stratum"] = { name = "Stratum", model = "stratum" },
    ["sabregt"] = { name = "Sabre Turbo", model = "sabregt" },
    ["rhapsody"] = { name = "Rhapsody", model = "rhapsody" },
    ["granger"] = { name = "Granger", model = "granger" },
    ["surge"] = { name = "Surge", model = "surge" },
    ["emperor"] = { name = "Emperor", model = "emperor" },
    ["youga"] = { name = "Youga", model = "youga" },
    ["asterope"] = { name = "Asterope", model = "asterope" },
    ["sultan"] = { name = "Sultan", model = "sultan" },
    ["panto"] = { name = "Panto", model = "panto" },
    ["baller"] = { name = "Classic Baller", model = "baller" },
    ["jester"] = { name = "Jester", model = "jester" },
    ["washington"] = { name = "Washington", model = "washington" },
    ["superd"] = { name = "Super Diamond", model = "superd" },
    ["ninef"] = { name = "Obey 9F", model = "ninef" },
    ["benson"] = { name = "Benson", model = "benson" },
    ["rumpo"] = { name = "Rumpo", model = "rumpo" },
    ["ingot"] = { name = "Ingot", model = "ingot" },
    ["blista2"] = { name = "Blista XS", model = "blista2" },
    ["bobcatxl"] = { name = "BobcatXL", model = "bobcatxl" },
    ["seminole"] = { name = "Seminole", model = "seminole" },
    ["ruiner"] = { name = "Ruiner", model = "ruiner" },
    ["peyote"] = { name = "Peyote", model = "peyote" },
    ["minivan"] = { name = "Minivan", model = "minivan" },
    ["gresley"] = { name = "Gresley", model = "gresley" },
    ["blista"] = { name = "Blista", model = "blista" },
    ["futo"] = { name = "Futo", model = "futo" },
    ["flatbed"] = { name = "Flatbed", model = "flatbed" },
    ["packer"] = { name = "Packer", model = "packer" },
}
local chopWaitTime = 1000
local bonus = 1.0
local findThis = ""
local findThisId = 0
local refreshList = 600

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
    for _, item in pairs(chopShops) do
    	item.blip = AddBlipForRadius(item.x, item.y, item.z, 0)
        SetBlipHighDetail(item.blip, true)
        SetBlipColour(item.blip, 1)
        SetBlipAlpha (item.blip, 128)

        item.blip = AddBlipForCoord(item.x, item.y, item.z)
        SetBlipSprite(item.blip, 72)
        SetBlipAsShortRange(item.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Chop Shop")
        EndTextCommandSetBlipName(item.blip)
        SetBlipAsMissionCreatorBlip(item.blip, true)
        SetBlipColour(item.blip, 1)
    end

    while true do
        Citizen.Wait(chopWaitTime)
        chopWaitTime = 1000

        local ClosestChopShop = isNearChopShop(4)
        if ClosestChopShop > 0 and findThis ~= "" then -- if we have a target vehicle..
            chopWaitTime = 0
            local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false) -- true means last vehicle, false means current only
            if GetPedInVehicleSeat(vehicle, -1) == GetPlayerPed(-1) and IsVehicleModel(vehicle, GetHashKey(findThis)) then -- do not accept impounded vehicles
                drawTxt("Press ~g~Enter~s~ to chop this vehicle.", 0, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
            elseif refreshList <= 0 then
                drawTxt("Having no luck? Press ~g~Enter~s~ for a new job", 0, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
            else
                drawTxt("We want a " .. findThis .. " - go find it! (" .. refreshList .. "s)", 0, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
            end
            if IsControlJustPressed(1, 18) and IsVehicleModel(vehicle, GetHashKey(findThis)) then -- Do we need to check for keys too?
                TriggerServerEvent("chopshop:chopVehicle", ESX.Game.GetVehicleProperties(vehicle), findThis)
                SetEntityAsMissionEntity(vehicle, true, true)
                DeleteVehicle(vehicle)
                findThis = ""
                findThisId = 0
                refreshList = 0
            -- elseif IsControlJustPressed(1, 18) and IsVehicleModel(vehicle, GetHashKey(findThis)) then
            --     TriggerEvent("chatMessage", "Chop Shop", { 209, 0, 0 }, "Where are the keys? We need the keys for the vehicle!")
            elseif IsControlJustPressed(1, 18) and refreshList <= 0 then
                getPopularCar()
                bonus = 1.0
                ESX.ShowAdvancedNotification("Chop Shop", "Damn, alright - find me a <b>" .. shoppingList[findThisId].name .. "</b>", "fas fa-car", "red")
            end
        elseif ClosestChopShop > 0 then -- if we have no target vehicle yet..
            chopWaitTime = 0
            drawTxt("Press ~g~Enter~s~ for a chop shop job.", 0, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
            if IsControlJustPressed(1, 18) then
                local PlayerData = ESX.GetPlayerData()
                if PlayerData.job.name == "police" or PlayerData.job.name == "ambulance" then
                  ESX.ShowNotification("You are very corrupt...")
                else
                  getPopularCar()
                  refreshList = 600
                  ESX.ShowAdvancedNotification("Chop Shop", "Alright hot shot, find me a <b>" .. shoppingList[findThisId].name .. "</b>", "fas fa-car", "red")
                end
            end
        end

    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        refreshList = refreshList - 1
    end
end)

function isNearChopShop(range)
    for i = 1, #chopShops do
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        local distance = GetDistanceBetweenCoords(chopShops[i].x, chopShops[i].y, chopShops[i].z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        if (distance < 30) then
            chopWaitTime = 0
            DrawMarker(25, chopShops[i].x, chopShops[i].y, chopShops[i].z - 1, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.5, 209, 0, 0, 155, 0, 0, 2, 0, 0, 0, 0)
        end
        if (distance < range) then
            return i
        end
    end
    return 0
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

function takeNetworkControl(targetVehicle, cb)
    Citizen.CreateThread(function()
        SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(targetVehicle), true)

        if not NetworkHasControlOfEntity(targetVehicle) then
            NetworkRequestControlOfEntity(targetVehicle)

            while not NetworkHasControlOfEntity(targetVehicle) do
                Citizen.Wait(1)
            end
        end

        if NetworkHasControlOfEntity(targetVehicle) then
            cb(targetVehicle)
        end
    end)
end

function getPopularCar()
    local carList = {} -- [rumpo] = 3
    local findList = {} -- [rumpo] = 3
    local topCount = 0
    local topCar = "rumpo"
    local carsFound = false

    for veh in EnumerateVehicles() do
        if shoppingList[string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(veh)))] ~= nil then
            if carList[GetDisplayNameFromVehicleModel(GetEntityModel(veh))] ~= nil then
                --[[Citizen.Trace("Adding another " .. GetDisplayNameFromVehicleModel(GetEntityModel(veh)))
                carList[GetDisplayNameFromVehicleModel(GetEntityModel(veh))] = carList[GetDisplayNameFromVehicleModel(GetEntityModel(veh))] + 1
                table.insert(findList, string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))]]
            else
                Citizen.Trace("Adding a " .. GetDisplayNameFromVehicleModel(GetEntityModel(veh)))
                carList[GetDisplayNameFromVehicleModel(GetEntityModel(veh))] = 1
                table.insert(findList, string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
                carsFound = true
            end
        else
            Citizen.Trace("What about.. " .. GetDisplayNameFromVehicleModel(GetEntityModel(veh)))
        end
    end

    if carsFound then
        topCar = findList[math.random(1, #findList)]
    end
    Citizen.Trace("We should find a " .. topCar)
    findThis = shoppingList[topCar].model
    findThisId = topCar
    refreshList = 600
end

-- Enumerator stuff

local entityEnumerator = {
  __gc = function(enum)
    if enum.destructor and enum.handle then
      enum.destructor(enum.handle)
    end
    enum.destructor = nil
    enum.handle = nil
  end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
  return coroutine.wrap(function()
    local iter, id = initFunc()
    if not id or id == 0 then
      disposeFunc(iter)
      return
    end

    local enum = {handle = iter, destructor = disposeFunc}
    setmetatable(enum, entityEnumerator)

    local next = true
    repeat
      coroutine.yield(id)
      next, id = moveFunc(iter)
    until not next

    enum.destructor, enum.handle = nil, nil
    disposeFunc(iter)
  end)
end

function EnumerateObjects()
  return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
  return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
  return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
  return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end
