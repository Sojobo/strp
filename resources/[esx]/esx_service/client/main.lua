local serviceBlips = {}
ESX = nil

local calls = {}
local callAvailable = nil
local callTimer = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_service:notifyAllInService')
AddEventHandler('esx_service:notifyAllInService', function(notification)
	ESX.ShowAdvancedNotification(notification.subject, notification.msg, notification.icon, notification.iconStyle)
end)

RegisterNetEvent('esx_service:receiveCallout')
AddEventHandler('esx_service:receiveCallout', function(notification)
    table.insert(calls, notification)
end)

Citizen.CreateThread(function()
	while true do
        if callTimer > 0 then
            callTimer = callTimer - 500
        else
            callTimer = 0
            callAvailable = nil
            for i, notification in ipairs(calls) do
                ESX.ShowAdvancedNotification(
                    notification.subject,
                    notification.msg .. "<div class='callOptions'><div class='green'>Accept (Z)</div><div class='red'>Decline (X)</div></div>",
                    notification.icon,
                    notification.iconStyle
                )

                callAvailable = notification
                callTimer = 10500
                table.remove(calls, i)
                break
            end
        end
		Citizen.Wait(500)
	end
end)
Citizen.CreateThread(function()
	while true do
        if (callAvailable ~= nil) then
            if (IsControlJustPressed(1, 20)) then -- 20 is Z
                SetNewWaypoint(callAvailable.locationX, callAvailable.locationY)
                TriggerEvent("pNotify:SendNotification", { clearall = true })
                callAvailable = nil
                callTimer = 0
            elseif (IsControlJustPressed(1, 73)) then -- 73 is X
                TriggerEvent("pNotify:SendNotification", { clearall = true })
                callAvailable = nil
                callTimer = 0
            end
        end
		Citizen.Wait(0)
	end
end)


function createBlip(id, color)
	local ped = GetPlayerPed(id)
	local blip = GetBlipFromEntity(ped)

	if not DoesBlipExist(blip) then -- Add blip and create head display on player
		blip = AddBlipForEntity(ped)
		SetBlipSprite(blip, 1)
		ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator
		SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
		SetBlipNameToPlayerName(blip, id) -- update blip name
		SetBlipScale(blip, 0.85) -- set scale
		SetBlipAsShortRange(blip, false)
		SetBlipColour(blip, color)

		table.insert(serviceBlips, blip) -- add blip to array so we can remove it later
	end
end

RegisterNetEvent('esx_service:updateServiceBlips')
AddEventHandler('esx_service:updateServiceBlips', function(incomingBlips)
	-- Refresh all blips
	for k, existingBlip in pairs(serviceBlips) do
		RemoveBlip(existingBlip)
	end

	-- Clean the blip table
	serviceBlips = {}

	for _, blipInfo in ipairs(incomingBlips) do
		local player = blipInfo[1]
		local color = blipInfo[2]
		local id = GetPlayerFromServerId(player)
		if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
			createBlip(id, color)
		end
	end
end)

RegisterNetEvent('esx_service:removeServiceBlips')
AddEventHandler('esx_service:removeServiceBlips', function(incomingBlips)
	-- Refresh all blips
	for k, existingBlip in pairs(serviceBlips) do
		RemoveBlip(existingBlip)
	end

	-- Clean the blip table
	serviceBlips = {}
end)

RegisterCommand("911", function(source, args, rawCommand)
    local message = table.concat(args, ' ')
    message = string.sub(message, string.len(args[1]) + 2)
    local department = args[1]

    if (department ~= "police" and department ~= "ambulance") then
        ESX.ShowAdvancedNotification("Dispatch", "We only accept calls for police & ambulance services", 'fas fa-headset', 'red')
    else
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local notification = {
            subject  = 'Emergency Call',
            msg      = message,
            icon = 'fas fa-headset',
            iconStyle = 'red',
            locationX = coords.x,
            locationY = coords.y,
            caller = PlayerId(),
        }

        TriggerServerEvent('esx_service:callAllInService', notification, department)
        ESX.ShowAdvancedNotification("Dispatch", "Your call has been received successfully", 'fas fa-headset', 'blue')
    end
end)

RegisterCommand("311", function(source, args, rawCommand)
    local message = table.concat(args, ' ')
    message = string.sub(message, string.len(args[1]) + 2)
    local department = args[1]

    if (department ~= "police" and department ~= "ambulance") then
        ESX.ShowAdvancedNotification("Dispatch", "We only accept calls for police & ambulance services", 'fas fa-headset', 'red')
    else
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local notification = {
            subject  = 'Non-Emergency Call',
            msg      = message,
            icon = 'fas fa-headset',
            iconStyle = 'blue',
            locationX = coords.x,
            locationY = coords.y,
            caller = PlayerId(),
        }

        TriggerServerEvent('esx_service:callAllInService', notification, department)
        ESX.ShowAdvancedNotification("Dispatch", "Your call has been received successfully", 'fas fa-headset', 'blue')
    end
end)
