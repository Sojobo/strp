ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('sellDrugs')
AddEventHandler('sellDrugs', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local weedqtySingle = xPlayer.getInventoryItem('cannabis').count
	local cokeqtySingle = xPlayer.getInventoryItem('cocaine').count
	local x = 0
	local blackMoney = 0
	local drugType = nil
	
	if Config.SellWeed and weedqtySingle > 0 then

		if weedqtySingle > 0 and Config.SellSingle then
			drugType = 'cannabis'
			if weedqtySingle == 1 then
				x = 1
			elseif weedqtySingle == 2 then
				x = math.random(1,2)
			elseif weedqtySingle == 3 then
				x = math.random(1,3)
			elseif weedqtySingle >= 5 then
				x = math.random(1,4)
			end
		end
	elseif Config.SellCoke and cokeqtySingle > 0 then
			
		if cokeqtySingle > 0 and Config.SellSingle then
			drugType = 'cocaine'
			if cokeqtySingle == 1 then
				x = 1
			elseif cokeqtySingle == 2 then
				x = math.random(1,2)
			elseif cokeqtySingle >= 5 then
				x = math.random(1,3)
			end
		end
	else
		TriggerClientEvent('nomoredrugs', _source)
		return
	end
	
	
	if drugType=='cannabis' then	--single
		blackMoney = Config.WeedPrice * x
	elseif drugType=='cocaine' then
		blackMoney = Config.CokePrice * x
	end
	
	if drugType ~= nil then
		xPlayer.removeInventoryItem(drugType, x)
	end
	
	xPlayer.addAccountMoney('black_money', blackMoney)
	TriggerClientEvent('sold', _source)
	TriggerClientEvent('esx:showNotification', _source, _U('you_have_sold') .. '~b~'..x..'~w~ ' .. (drugType) .. blackMoney .. '$')
end)


RegisterServerEvent('check')
AddEventHandler('check', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	local weedqtySingle = xPlayer.getInventoryItem('cannabis').count
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
		TriggerClientEvent('nomoredrugs', _source)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('must_be') .. Config.CopsRequiredToSell .. _U('to_sell_drugs'))
	end
end)


RegisterServerEvent('drugsNotify')
AddEventHandler('drugsNotify', function()
	TriggerClientEvent("drugsEnable", source)
end)

--cads
RegisterServerEvent('drugsInProgress')
AddEventHandler('drugsInProgress', function(street1, street2, sex)
      --TriggerClientEvent("outlawNotify", -1, "~r~Selling drugs by ~w~"..sex.."~r~near~w~"..street1.."~r~ and ~w~"..street2)
	TriggerClientEvent("esx:showNotification", -1, "~r~Someone is selling drugs. A ~w~"..sex..", ~r~between ~w~"..street1.."~r~ and ~w~"..street2)
end)
--if you need you can translate it to your language too
RegisterServerEvent('drugsInProgressS1')
AddEventHandler('drugsInProgressS1', function(street1, sex)
      --TriggerClientEvent("outlawNotify", -1, "~r~Selling drugs by ~w~"..sex.."~r~near~w~"..street1)
	TriggerClientEvent("esx:showNotification", -1, "~r~Someone is selling drugs. A ~w~"..sex..", ~r~on ~w~"..street1)
end)

RegisterServerEvent('drugsInProgressPos')
AddEventHandler('drugsInProgressPos', function(gx, gy, gz)
	TriggerClientEvent('drugsPlace', -1, gx, gy, gz)
end)
