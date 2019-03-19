
function UpdateDoorStatus(doorId, doorStatus)
  for i, door in ipairs(DoorConfig.doors) do
    if i == doorId then
      DoorConfig.doors[i].isLocked = doorStatus
      TriggerClientEvent("doorLocks:syncDoors", -1, DoorConfig.doors)
    end
  end
end

RegisterServerEvent("doorLocks:syncDoors")
AddEventHandler("doorLocks:syncDoors", function()
  local _source = source
  TriggerClientEvent("doorLocks:syncDoors", _source, DoorConfig.doors)
end)

RegisterServerEvent("doorLocks:updateDoor")
AddEventHandler("doorLocks:updateDoor", function(doorId, doorStatus)
  UpdateDoorStatus(doorId, doorStatus)
end)