local player = PlayerPedId()
local inside = 0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        player = PlayerPedId()
        local plyCoords = GetEntityCoords(player, false)
        local vehicle = VehicleInFront()

        if IsDisabledControlPressed(0, 19) and IsDisabledControlJustReleased(1, 44) and GetVehiclePedIsIn(player, false) == 0 and ((DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle)) or (inside ~= 0 and DoesEntityExist(inside) and IsEntityAVehicle(inside))) then
          if (GetVehicleDoorLockStatus(vehicle) ~= 1) then return end
            SetVehicleDoorOpen(vehicle, 5, false, false)
            if inside == 0 then
                AttachEntityToEntity(player, vehicle, -1, 0.0, -2.2, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
                RaiseConvertibleRoof(vehicle, false)
                if IsEntityAttached(player) then
                    SetTextComponentFormat("STRING")
                    AddTextComponentString('~s~~INPUT_CHARACTER_WHEEL~+~INPUT_COVER~ Get out')
                    DisplayHelpTextFromStringLabel(0, 1, 1, -1)
                    ClearPedTasksImmediately(player)
                    Citizen.Wait(100)
                    TaskPlayAnim(player, 'timetable@floyd@cryingonbed@base', 'base', 1.0, -1, -1, 1, 0, 0, 0, 0)
                    if not (IsEntityPlayingAnim(player, 'timetable@floyd@cryingonbed@base', 'base', 3) == 1) then
                        Streaming('timetable@floyd@cryingonbed@base', function()
                            TaskPlayAnim(playerPed, 'timetable@floyd@cryingonbed@base', 'base', 1.0, -1, -1, 49, 0, 0, 0, 0)
                        end)
                    end
                    inside = vehicle
                else
                    inside = 0
                end
            elseif inside ~= 0 and IsDisabledControlPressed(0, 19) and IsDisabledControlJustReleased(1, 44) then
                DetachEntity(player, true, true)
                SetEntityVisible(player, true, true)
                ClearPedTasks(player)
                inside = 0
                ClearAllHelpMessages()
            end
            Citizen.Wait(2000)
            SetVehicleDoorShut(vehicle, 5, false)
        end
        if DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) and inside == 0 and GetVehiclePedIsIn(player, false) == 0 then
            SetTextComponentFormat("STRING")
            AddTextComponentString('~s~~INPUT_CHARACTER_WHEEL~+~INPUT_COVER~ Get in trunk')
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
        elseif DoesEntityExist(vehicle) and inside ~= 0 then
            car = GetEntityAttachedTo(player)
            carxyz = GetEntityCoords(car, 0)
            local visible = true
            DisableAllControlActions(0)
            DisableAllControlActions(1)
            DisableAllControlActions(2)
            EnableControlAction(0, 0, true) --- V - camera
            EnableControlAction(0, 249, true) --- N - push to talk
            EnableControlAction(2, 1, true) --- camera moving
            EnableControlAction(2, 2, true) --- camera moving
            EnableControlAction(0, 177, true) --- BACKSPACE
            EnableControlAction(0, 200, true) --- ESC
            -- if IsDisabledControlJustPressed(1, 22) then
            --     if visible then
            --         SetEntityVisible(player, false, false)
            --         visible = false
            --     end
            -- end
        elseif not DoesEntityExist(inside) and inside ~= 0 then
            DetachEntity(player, true, true)
            SetEntityVisible(player, true, true)
            ClearPedTasks(player)
            inside = 0
            ClearAllHelpMessages()
        end
    end
end)

function Streaming(animDict, cb)
	if not HasAnimDictLoaded(animDict) then
		RequestAnimDict(animDict)

		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(1)
		end
	end

	if cb ~= nil then
		cb()
	end
end

function VehicleInFront()
    local pos = GetEntityCoords(player)
    local entityWorld = GetOffsetFromEntityInWorldCoords(player, 0.0, 2.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, player, 0)
    local _, _, _, _, result = GetRaycastResult(rayHandle)
    return result
end
