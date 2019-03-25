local boloPlates = {}
local syncTime = 120000

function grabBolos()
  boloPlates = {}
  -- TODO WITH CAD
  --table.insert(boloPlates, boloVehicle.plate)
end

RegisterServerEvent("wraithalpr:syncBolos")
AddEventHandler("wraithalpr:syncBolos", function()
  local _source = source
  TriggerClientEvent("wraithalpr:syncBolos", _source, boloPlates)
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    grabBolos()
    Citizen.Wait(syncTime)
  end
end)
