local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

-- internal variables
local hasAlreadyEnteredMarker = false
local isInATMMarker = false
local menuIsShowed = false
local currentMDT = 0
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('strp_mdt:closeMDT')
AddEventHandler('strp_mdt:closeMDT', function()
	SetNuiFocus(false)
	menuIsShowed = false
	SendNUIMessage({
		hideAll = true
	})

	RequestAnimDict("mini@atmexit")
	while not HasAnimDictLoaded("mini@atmexit") do
		Wait(1)
	end
	TaskPlayAnim(GetPlayerPed(-1), "mini@atmexit", "exit", 8.0, 1.0, -1, 0, 0.0, 0, 0, 0)
	RemoveAnimDict("mini@atmexit")
end)

RegisterNUICallback('escape', function(data, cb)
	TriggerEvent('strp_mdt:closeMDT')
	cb('ok')
end)

local MDTMachines = {
	[1] = {"hei_prop_hei_cs_keyboard"},
	[2] = {"prop_cs_keyboard_01"},
	[3] = {"prop_keyboard_01a"},
	[4] = {"prop_keyboard_01b"},
}

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())
		local canSleep = true
		isInATMMarker = false
		currentMDT = 0
		local playerCoords = GetEntityCoords(GetPlayerPed(-1), true)

		for a,b in pairs(MDTMachines) do
			local closestMDT = GetClosestObjectOfType(playerCoords.x, playerCoords.y, playerCoords.z, 5.0, GetHashKey(b[1]), false, false, false)

			if (DoesEntityExist(closestMDT)) then
				local objPos = GetEntityCoords(closestMDT)
				local distance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, objPos.x, objPos.y, objPos.z, true)

				if (distance <= 1.5) then
					isInATMMarker, canSleep = true, false
					currentMDT = closestMDT
					break
				end
			end
		end

		if isInATMMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			canSleep = false
		end

		if not isInATMMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			SetNuiFocus(false)
			menuIsShowed = false
			canSleep = false

			SendNUIMessage({
				hideAll = true
			})
		end

		if canSleep then
			Citizen.Wait(500)
		end
	end
end)

-- Menu interactions
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if isInATMMarker and not menuIsShowed then
			ESX.ShowHelpNotification("Press ~INPUT_PICKUP~ to log in to the MDT")

			if IsControlJustReleased(0, Keys['E']) and IsPedOnFoot(PlayerPedId()) then
				local playerPed = GetPlayerPed(-1)
				local atmcoords = GetEntityCoords(currentMDT)

				local PlayerData = ESX.GetPlayerData()

				if PlayerData.job.name ~= "police" or PlayerData.job.name ~= "ambulance" then
					ESX.ShowNotification("You cannot use this...")
					return
				end

				menuIsShowed = true

				RequestAnimDict("mini@atmbase")
				RequestAnimDict("mini@atmenter")
				while not HasAnimDictLoaded("mini@atmenter") do
					Wait(1)
				end

				SetCurrentPedWeapon(playerPed, GetHashKey("weapon_unarmed"), true)
				TaskLookAtEntity(playerPed, currentMDT, 2000, 2048, 2)
				Wait(500)
				TaskGoStraightToCoord(playerPed, atmcoords.x, atmcoords.y, atmcoords.z, 0.1, 4000, GetEntityHeading(currentMDT), 0.5)
				Wait(2000)
				TaskPlayAnim(playerPed, "mini@atmenter", "enter", 8.0, 1.0, -1, 0, 0.0, 0, 0, 0)
				RemoveAnimDict("mini@atmenter")

				PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
				ESX.TriggerServerCallback('esx:getPlayerData', function(data)
					SendNUIMessage({
						openMDT = true,
						player = {
							money = data.money,
							accounts = data.accounts
						}
					})
				end)
				SetNuiFocus(true, true)

				Wait(4000)
				TaskPlayAnim(playerPed, "mini@atmbase", "base", 8.0, 1.0, -1, 0, 0.0, 0, 0, 0)
				RemoveAnimDict("mini@atmbase")
			end

		else
			Citizen.Wait(500)
		end
	end
end)

-- close the menu when script is stopping to avoid being stuck in NUI focus
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if menuIsShowed then
			TriggerEvent('strp_mdt:closeMDT')
		end
	end
end)
