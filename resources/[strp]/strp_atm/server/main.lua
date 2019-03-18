ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('strp_atm:deposit')
AddEventHandler('strp_atm:deposit', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	amount = tonumber(amount)

	if not tonumber(amount) then return end
	amount = ESX.Math.Round(amount)

	if amount == nil or amount <= 0 or amount > xPlayer.getMoney() then
		TriggerClientEvent('esx:showAdvancedNotification', _source, _U('atm_blip'), _U('invalid_amount'), 'fas fa-exclamation-triangle', "red")
	else
		xPlayer.removeMoney(amount)
		xPlayer.addAccountMoney('bank', amount)
		TriggerClientEvent('esx:showAdvancedNotification', _source, _U('atm_blip'), _U('deposit_money', amount), 'fas fa-dollar-sign', "green")
	end
end)

RegisterServerEvent('strp_atm:withdraw')
AddEventHandler('strp_atm:withdraw', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	amount = tonumber(amount)
	local accountMoney = xPlayer.getAccount('bank').money

	if not tonumber(amount) then return end
	amount = ESX.Math.Round(amount)

	if amount == nil or amount <= 0 or amount > accountMoney then
	TriggerClientEvent('esx:showAdvancedNotification', _source, _U('atm_blip'), _U('invalid_amount'), 'fas fa-exclamation-triangle', "red")
else
		xPlayer.removeAccountMoney('bank', amount)
		xPlayer.addMoney(amount)
		TriggerClientEvent('esx:showAdvancedNotification', _source, _U('atm_blip'), _U('withdraw_money', amount), 'fas fa-dollar-sign', "green")
	end
end)
