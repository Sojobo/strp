ESX = nil
PlayerData = nil

local doorsToDraw = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)


function DrawText3Ds(x, y, z, text)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local px, py, pz = table.unpack(GetGameplayCamCoords())

  SetTextScale(0.35, 0.35)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 215)
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x, _y)
end

RegisterNetEvent("doorLocks:syncDoors")
AddEventHandler("doorLocks:syncDoors", function(doors)
  DoorConfig.doors = doors
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
		for _, doorInfo in ipairs(doorsToDraw) do
			local door = DoorConfig.doors[doorInfo[1]]
			local distance = doorInfo[2]
			local doorEntity = doorInfo[3]
			if door.isLocked then
				DrawText3Ds(door.x, door.y, door.z + 0.3, "~b~[E] - ~r~[LOCKED]")
				FreezeEntityPosition(doorEntity, true)
			else
				DrawText3Ds(door.x, door.y, door.z + 0.3, "~b~[E] - ~g~[UNLOCKED]")
				FreezeEntityPosition(doorEntity, false)
			end

			if distance <= 1.0 then
				if IsControlJustPressed(1, 86) then
					if PlayerData.job.name == door.jobRestriction and door.gradeRestriction == nil then
						TriggerServerEvent("doorLocks:updateDoor", doorInfo[1], not door.isLocked)
					elseif PlayerData.job.name == door.jobRestriction and (tonumber(PlayerData.job.grade) >= door.gradeRestriction) then
						TriggerServerEvent("doorLocks:updateDoor", doorInfo[1], not door.isLocked)
					else
						ESX.ShowNotification("You do not have keys to this door!")
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(250)
		doorsToDraw = {}
    local ped = GetPlayerPed(PlayerId())
    local plyCoords = GetEntityCoords(ped, false)
    for i, door in ipairs(DoorConfig.doors) do
      local distance = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, door.x, door.y, door.z)
      if distance <= 3.0 then
				local doorEntity = GetClosestObjectOfType(door.x, door.y, door.z, 3.0, GetHashKey(door.model), 0, 0, 0)
				table.insert(doorsToDraw, {i, distance, doorEntity})
      end
    end
  end
end)

Citizen.CreateThread(function()
  Citizen.Wait(0)
  TriggerServerEvent("doorLocks:syncDoors")
end)

