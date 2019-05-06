ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('sellDrugs')
AddEventHandler('sellDrugs', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local weedqtySingle = xPlayer.getInventoryItem('marijuana').count
	local cokeqtySingle = xPlayer.getInventoryItem('cocaine').count
	local x = 0
	local blackMoney = 0
	local drugType = nil
	
	if Config.SellWeed and weedqtySingle > 0 then

		if weedqtySingle > 0 and Config.SellSingle then
			drugType = 'marijuana'
			if weedqtySingle == 1 then
				x = 1
			elseif weedqtySingle > 1 and weedqtySingle < 5 then
				x = math.random(1,2)
			elseif weedqtySingle >= 5 then
				x = math.random(1,4)
			end
		end
	elseif Config.SellCoke and cokeqtySingle > 0 then
			
		if cokeqtySingle > 0 and Config.SellSingle then
			drugType = 'cocaine'
			if cokeqtySingle == 1 then
				x = 1
			elseif cokeqtySingle > 1 and cokeqtySingle < 5 then
				x = math.random(1,2)
			elseif cokeqtySingle >= 5 then
				x = math.random(1,3)
			end
		end
	else
		TriggerClientEvent('nomoredrugs', _source)
		return
	end
	
	
	if drugType=='marijuana' then	--single
		blackMoney = Config.WeedPrice * x
	elseif drugType=='cocaine' then
		blackMoney = Config.CokePrice * x
	end
	
	if drugType ~= nil then
		xPlayer.removeInventoryItem(drugType, x)
	end
	
	xPlayer.addAccountMoney('black_money', blackMoney)
	TriggerClientEvent('sold', _source)
	TriggerClientEvent('esx:showNotification', _source, _U('you_have_sold') .. ' ' ..x.. ' ' .. (drugType) .. ' for $' .. blackMoney)
end)


RegisterServerEvent('check')
AddEventHandler('check', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	local weedqtySingle = xPlayer.getInventoryItem('marijuana').count
	local cokeqtySingle = xPlayer.getInventoryItem('cocaine').count
	--check cops count on server
	local cops = 0
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' then
            cops = cops + 1
		end
	end
	
	if cops >= Config.CopsRequiredToSell then
		if Config.SellWeed then
			if Config.SellSingle and weedqtySingle > 0 then
				TriggerClientEvent('playerhasdrugs', _source)
				return
			end
		end
		if Config.SellCoke then
			if Config.SellSingle and  cokeqtySingle > 0 then
				TriggerClientEvent('playerhasdrugs', _source)
				return
			end
		end
	end
end)


RegisterServerEvent('drugsNotify')
AddEventHandler('drugsNotify', function()
	TriggerClientEvent("drugsEnable", source)
end)
