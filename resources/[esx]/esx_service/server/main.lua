ESX                = nil
local InService    = {}
local MaxInService = {}
local blipColours = {
    ["police"] = 38,
    ["ambulance"] = 11,
    ["vagos"] = 46,
    ["triads"] = 76,
    ["lostmc"] = 40,
}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function GetInServiceCount(name)
	local count = 0

	for k,v in pairs(InService[name]) do
		if v == true then
			count = count + 1
		end
	end

	return count
end

AddEventHandler('esx_service:activateService', function(name, max)
	InService[name]    = {}
	MaxInService[name] = max
end)

RegisterServerEvent('esx_service:disableService')
AddEventHandler('esx_service:disableService', function(name)
	InService[name][source] = nil
end)

RegisterServerEvent('esx_service:notifyAllInService')
AddEventHandler('esx_service:notifyAllInService', function(notification, name)
	for k,v in pairs(InService[name]) do
		if v == true then
			TriggerClientEvent('esx_service:notifyAllInService', k, notification)
		end
	end
end)

RegisterServerEvent('esx_service:callAllInService')
AddEventHandler('esx_service:callAllInService', function(notification, name)
	for k,v in pairs(InService[name]) do
		if v == true then
			TriggerClientEvent('esx_service:receiveCallout', k, notification, source)
		end
	end
end)

ESX.RegisterServerCallback('esx_service:enableService', function(source, cb, name)
	local inServiceCount = GetInServiceCount(name)
	if MaxInService[name] == -1 then
		InService[name][source] = true
		cb(true, MaxInService[name], inServiceCount)
	elseif inServiceCount >= MaxInService[name] then
		cb(false, MaxInService[name], inServiceCount)
	elseif MaxInService[name] == nil then
		InService[name][source] = true
		cb(true, -1, inServiceCount)
	else
		InService[name][source] = true
		cb(true, MaxInService[name], inServiceCount)
	end
end)

ESX.RegisterServerCallback('esx_service:isInService', function(source, cb, name)
	local isInService = false

	if InService[name][source] then
		isInService = true
	end

	cb(isInService)
end)

ESX.RegisterServerCallback('esx_service:isPlayerInService', function(source, cb, name, player)
	local isInService = false

	if InService[name][player] then
		isInService = true
	end

	cb(isInService)
end)

ESX.RegisterServerCallback('esx_service:getInServiceList', function(source, cb, name)
	cb(InService[name])
end)

AddEventHandler('playerDropped', function()
	local _source = source

	for k,v in pairs(InService) do
		if v[_source] == true then
			v[_source] = nil
		end
	end
end)

RegisterNetEvent('esx_service:updateBlips')
AddEventHandler('esx_service:updateBlips', function(societyNames)
	local serviceBlips = {}

	for _, societyName in ipairs(societyNames) do
		for k,v in pairs(InService[societyName]) do
			local color = blipColours[societyName]
			table.insert(serviceBlips, {k, color})
		end
	end

	for _, societyName in ipairs(societyNames) do
		for k,v in pairs(InService[societyName]) do
			TriggerClientEvent('esx_service:updateServiceBlips', k, serviceBlips)
		end
	end
end)
