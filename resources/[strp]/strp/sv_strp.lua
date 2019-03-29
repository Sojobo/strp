local uptimeMinute, uptime = 0, 0, ''

Citizen.CreateThread(function()

  while true do
    Citizen.Wait(1000 * 60) -- every minute
    uptimeMinute = uptimeMinute + 1

    uptime = string.format("%i", uptimeMinute)
    SetConvarServerInfo('Uptime', uptime)

    TriggerClientEvent('uptime:tick', -1, uptime)
    TriggerEvent('uptime:tick', uptime)
  end
end)

RegisterCommand("uptime", function()
  uptime = string.format("%i", uptimeMinute)
  Citizen.Trace(uptime)
end, false)