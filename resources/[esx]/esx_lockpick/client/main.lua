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

ESX						= nil
local CurrentAction		= nil
local PlayerData		= {}
local ThreadID = nil
local successOdds = 1

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

function GetNearDoorInfo()
  local DoorConfig = exports.doorLocks:getDoorConfig()
  local ped = GetPlayerPed(PlayerId())
  local plyCoords = GetEntityCoords(ped, false)

  for i, door in ipairs(DoorConfig.doors) do
    local distance = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, door.x, door.y, door.z)
    if distance <= 1.0 then
      return i
    end
  end
  return false
end

RegisterNetEvent('esx_lockpick:onUse')
AddEventHandler('esx_lockpick:onUse', function()
	local playerPed		= GetPlayerPed(-1)
	local coords		= GetEntityCoords(playerPed)
  local doorInfo = GetNearDoorInfo()
  local vehicleNear = IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0)
  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

  if closestPlayer ~= -1 and closestDistance <= 1.0 and IsEntityPlayingAnim(GetPlayerPed(closestPlayer), 'mp_arresting', 'idle', 3) then
    closestPlayer = closestPlayer
  else
    closestPlayer = -1
  end

	if vehicleNear or doorInfo ~= false or closestPlayer ~= -1 then
		local vehicle = nil

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) or doorInfo ~= false or closestPlayer ~= -1 then
			TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)

			Citizen.CreateThread(function()
				ThreadID = GetIdOfThisThread()
        CurrentAction = true

				Citizen.Wait(Config.LockTime * 1000)

        successOdds = math.random(Config.SuccessChance[1], Config.SuccessChance[2])

        if successOdds ~= 1 then
          TerminateThread(ThreadID)
          ESX.ShowNotification(_U('lockpick_break'))
          CurrentAction = nil
          ClearPedTasksImmediately(playerPed)
        end

				if CurrentAction ~= nil then
          if doorInfo ~= false then
            TriggerServerEvent("doorLocks:updateDoor", doorInfo, false)
          elseif closestPlayer ~= -1 then
            TriggerServerEvent("esx_policejob:unrestrain", GetPlayerServerId(closestPlayer))
          elseif vehicle ~= -1 then
            SetVehicleDoorsLocked(vehicle, 1)
  					SetVehicleDoorsLockedForAllPlayers(vehicle, false)
          end
					ClearPedTasksImmediately(playerPed)
					ESX.ShowNotification(_U('vehicle_unlocked'))
				end

				CurrentAction = nil
				TerminateThisThread()
			end)
		end
  else
		ESX.ShowNotification(_U('no_vehicle_nearby'))
	end
end)

Citizen.CreateThread(function()
  while true do
    Wait(0)
    if CurrentAction ~= nil and ThreadID ~= nil then
      SetTextComponentFormat('STRING')
      AddTextComponentString(_U('abort_hint'))
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)

      if IsControlJustReleased(1, 323) then
        TerminateThread(ThreadID)
        ESX.ShowNotification(_U('aborted_lockpicking'))
        CurrentAction = nil
        local playerPed		= GetPlayerPed(-1)
        ClearPedTasksImmediately(playerPed)
      end
    end
  end
end)
