ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--item
ESX.RegisterUsableItem('sausage', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('sausage', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 400000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, 'You ate a sausage')

end)

RegisterServerEvent('esx_korvgubbe:buy')
AddEventHandler('esx_korvgubbe:buy', function(item, price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getBank() >= price) then
		xPlayer.removeBank(price)
		
		xPlayer.addInventoryItem(item, 1)
	else
		notification("You do not have enough ~r~money")
	end
end)

function notification(text)
	TriggerClientEvent('esx:showNotification', source, text)
end