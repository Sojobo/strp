local spawnedWines = 0
local WinePlants = {}
local isPickingUp, isProcessing = false, false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.WineField.coords, true) < 50 then
			SpawnWinePlants()
			Citizen.Wait(500)
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.CircleZones.WineProcessing.coords, true) < 2 then
			if not isProcessing then
				ESX.ShowHelpNotification(_U('wine_processprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isProcessing then

				if Config.LicenseEnable then
					ESX.TriggerServerCallback('esx_license:checkLicense', function(hasProcessingLicense)
						if hasProcessingLicense then
							processGrapes()
						else
							OpenBuyLicenseMenu('wine_processing')
						end
					end, GetPlayerServerId(PlayerId()), 'wine_processing')
				else
					processGrapes()
				end

			end
		else
			Citizen.Wait(500)
		end
	end
end)

function processGrapes()
	isProcessing = true

	ESX.ShowNotification(_U('wine_processingstarted'))
	TriggerServerEvent('esx_drugs:processGrapes')
	local timeLeft = Config.Delays.WineProcessing / 1000
	local playerPed = PlayerPedId()

	while timeLeft > 0 do
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1

		if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.WineProcessing.coords, false) > 4 then
			ESX.ShowNotification(_U('wine_processingtoofar'))
			TriggerServerEvent('esx_drugs:cancelProcessing')
			break
		end
	end

	isProcessing = false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #WinePlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(WinePlants[i]), false) < 1 then
				nearbyObject, nearbyID = WinePlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				ESX.ShowHelpNotification(_U('wine_pickupprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
				isPickingUp = true

				ESX.TriggerServerCallback('esx_drugs:canPickUp', function(canPickUp)

					if canPickUp then
						TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_KNEEL', 0, false)

						Citizen.Wait(2000)
						ClearPedTasks(playerPed)
						ClearPedTasksImmediately(playerPed)
						Citizen.Wait(1500)

						ESX.Game.DeleteObject(nearbyObject)

						table.remove(WinePlants, nearbyID)
						spawnedWines = spawnedWines - 1

						TriggerServerEvent('esx_drugs:pickedUpGrapes')
					else
						ESX.ShowAdvancedNotification("Inventory", "Your inventory is full", "fas fa-exclamation-triangle", "red")
					end

					isPickingUp = false
				end, 'grapes')
			end

		else
			Citizen.Wait(500)
		end

	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(WinePlants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnWinePlants()
	while spawnedWines < 20 do
		Citizen.Wait(88)
		local WineCoords = GenerateWineCoords()

		ESX.Game.SpawnLocalObject('prop_fruit_basket', WineCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)
			SetEntityCollision(obj, false, true)

			table.insert(WinePlants, obj)
			spawnedWines = spawnedWines + 1
		end)
	end
end

function ValidateWineCoord(plantCoord)
	if spawnedWines > 0 then
		local validate = true

		for k, v in pairs(WinePlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.WineField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateWineCoords()
	while true do
		Citizen.Wait(1)

		local WineCoordX, WineCoordY

		local modX = math.random(-50, 50)
		Citizen.Wait(100)
		local modY = math.random(-50, 50)

		WineCoordX = Config.CircleZones.WineField.coords.x + modX
		WineCoordY = Config.CircleZones.WineField.coords.y + modY

		local coordZ = GetCoordZ(WineCoordX, WineCoordY)
		local coord = vector3(WineCoordX, WineCoordY, coordZ)

		if ValidateWineCoord(coord) then
			return coord
		end
	end
end

function GetCoordZ(x, y)
	local groundCheckHeights = { 110.0, 111.0, 112.0, 113.0, 114.0, 115.0, 116.0, 117.0, 118.0, 119.0,
								120.0, 121.0, 122.0, 123.0, 124.0, 125.0, 126.0, 127.0, 128.0, 129.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 115.0
end