ESX = nil
local playersProcessingCannabis = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_drugs:sellDrug')
AddEventHandler('esx_drugs:sellDrug', function(dealer, itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = Config[dealer][itemName]
	local xItem = xPlayer.getInventoryItem(itemName)

	if not price then
		print(('esx_drugs: %s attempted to sell an invalid drug!'):format(xPlayer.identifier))
		return
	end

	if xItem.count < amount then
		TriggerClientEvent('esx:showNotification', source, _U('dealer_notenough'))
		return
	end

	price = ESX.Math.Round(price * amount)

	if Config[dealer].GiveBlack then
		xPlayer.addAccountMoney('black_money', price)
	else
		xPlayer.addMoney(price)
	end

	xPlayer.removeInventoryItem(xItem.name, amount)

	TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', amount, xItem.label, ESX.Math.GroupDigits(price)))
end)

ESX.RegisterServerCallback('esx_drugs:buyLicense', function(source, cb, licenseName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local license = Config.LicensePrices[licenseName]

	if license == nil then
		print(('esx_drugs: %s attempted to buy an invalid license!'):format(xPlayer.identifier))
		cb(false)
	end

	if xPlayer.getMoney() >= license.price then
		xPlayer.removeMoney(license.price)

		TriggerEvent('esx_license:addLicense', source, licenseName, function()
			cb(true)
		end)
	else
		cb(false)
	end
end)

RegisterServerEvent('esx_drugs:pickedUpCannabis')
AddEventHandler('esx_drugs:pickedUpCannabis', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source
	local xItem = xPlayer.getInventoryItem('cannabis')
	local xInventoryWeight = xPlayer.getInventoryWeight()
	local xInventorylimit = xPlayer.getInventoryWeightMax()

	if xInventorylimit ~= -1 and (1 + xInventoryWeight) > xInventorylimit then
		TriggerClientEvent('esx:showNotification', _source, _U('weed_inventoryfull'))
	else
		xPlayer.addInventoryItem(xItem.name, 1)
	end
end)

RegisterServerEvent('esx_drugs:pickedUpGrapes')
AddEventHandler('esx_drugs:pickedUpGrapes', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source
	local xItem = xPlayer.getInventoryItem('grapes')
	local xInventoryWeight = xPlayer.getInventoryWeight()
	local xInventorylimit = xPlayer.getInventoryWeightMax()

	if xInventorylimit ~= -1 and (1 + xInventoryWeight) > xInventorylimit then
		TriggerClientEvent('esx:showNotification', _source, _U('wine_inventoryfull'))
	else
		xPlayer.addInventoryItem(xItem.name, 1)
	end
end)

ESX.RegisterServerCallback('esx_drugs:canPickUp', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)
	local xInventoryWeight = xPlayer.getInventoryWeight()
	local xInventorylimit = xPlayer.getInventoryWeightMax()

	if xInventorylimit ~= -1 and 1 + xInventoryWeight > xInventorylimit then
		cb(false)
	else
		cb(true)
	end
end)

RegisterServerEvent('esx_drugs:processCannabis')
AddEventHandler('esx_drugs:processCannabis', function()
	if not playersProcessingCannabis[source] then
		local _source = source
        local conversionRate = 3

		playersProcessingCannabis[_source] = ESX.SetTimeout(Config.Delays.WeedProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xCannabis, xMarijuana = xPlayer.getInventoryItem('cannabis'), xPlayer.getInventoryItem('marijuana')
			local xInventoryWeight = xPlayer.getInventoryWeight()
			local xInventorylimit = xPlayer.getInventoryWeightMax()

            if xPlayer.job.name == exports.strp_gangturfs:getTurfOwner(2) then
                conversionRate = 2
            end

			if xInventorylimit ~= -1 and (1 + xInventoryWeight) > xInventorylimit then
				TriggerClientEvent('esx:showNotification', _source, _U('weed_processingfull'))
			elseif xCannabis.count < conversionRate then
				TriggerClientEvent('esx:showNotification', _source, _U('weed_processingenough'))
			else
				xPlayer.removeInventoryItem('cannabis', conversionRate)
				xPlayer.addInventoryItem('marijuana', 1)

				TriggerClientEvent('esx:showNotification', _source, _U('weed_processed'))
			end

			playersProcessingCannabis[_source] = nil
		end)
	else
		print(('esx_drugs: %s attempted to exploit weed processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

RegisterServerEvent('esx_drugs:processGrapes')
AddEventHandler('esx_drugs:processGrapes', function()
	if not playersProcessingCannabis[source] then
		local _source = source

		playersProcessingCannabis[_source] = ESX.SetTimeout(Config.Delays.WineProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xCannabis, xMarijuana = xPlayer.getInventoryItem('grapes'), xPlayer.getInventoryItem('wine')
			local xInventoryWeight = xPlayer.getInventoryWeight()
			local xInventorylimit = xPlayer.getInventoryWeightMax()

			if xInventorylimit ~= -1 and (1 + xInventoryWeight) > xInventorylimit then
				TriggerClientEvent('esx:showNotification', _source, _U('wine_processingfull'))
			elseif xCannabis.count < 3 then
				TriggerClientEvent('esx:showNotification', _source, _U('wine_processingenough'))
			else
				xPlayer.removeInventoryItem('grapes', 3)
				xPlayer.addInventoryItem('wine', 1)

				TriggerClientEvent('esx:showNotification', _source, _U('wine_processed'))
			end

			playersProcessingCannabis[_source] = nil
		end)
	else
		print(('esx_drugs: %s attempted to exploit wine processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

function CancelProcessing(playerID)
	if playersProcessingCannabis[playerID] then
		ESX.ClearTimeout(playersProcessingCannabis[playerID])
		playersProcessingCannabis[playerID] = nil
	end
end

RegisterServerEvent('esx_drugs:cancelProcessing')
AddEventHandler('esx_drugs:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('esx:playerDropped', function(playerID, reason)
	CancelProcessing(playerID)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)
