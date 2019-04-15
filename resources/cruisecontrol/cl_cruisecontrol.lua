-- Title: Speed limiter.
-- Author: Serpico -- twitch.tv/SerpicoTV
-- Description: This script will restict the speed of the vehicle when
--              INPUT_MP_TEXT_CHAT_TEAM is pressed. To disable, press
--              INPUT_VEH_SUB_ASCEND + INPUT_MP_TEXT_CHAT_TEAM
-------------------------------------------------------------------------------
local useMph = true -- if false, it will display speed in kph

Citizen.CreateThread(function()
  local resetSpeedOnEnter = true
  while true do
    Citizen.Wait(0)
    local playerPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(playerPed,false)
    if GetPedInVehicleSeat(vehicle, -1) == playerPed and IsPedInAnyVehicle(playerPed, false) then

      -- This should only happen on vehicle first entry to disable any old values
      if resetSpeedOnEnter then
        maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
        SetEntityMaxSpeed(vehicle, maxSpeed)
        resetSpeedOnEnter = false
      end
      -- Disable speed limiter
      if IsControlPressed(0,31) then
        maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
        SetEntityMaxSpeed(vehicle, maxSpeed)
      -- Enable speed limiter
      elseif IsControlJustReleased(0,57) then
        cruise = GetEntitySpeed(vehicle)
        SetEntityMaxSpeed(vehicle, cruise)
        if useMph then
          cruise = math.floor(cruise * 2.23694 + 0.5)
          showHelpNotification("Speed limiter set to "..cruise.." mph. Press the Break to disable it.")
        else
          cruise = math.floor(cruise * 3.6 + 0.5)
          showHelpNotification("Speed limiter set to "..cruise.." km/h. Press the Break to disable it.")
        end
      end
    else
      resetSpeedOnEnter = true
    end
  end
end)

function showHelpNotification(msg)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end