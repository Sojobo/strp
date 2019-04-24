ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_carwash:canAfford', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if Config.EnablePrice then
		if xPlayer.getBank() >= Config.Price then
			xPlayer.removeBank(Config.Price)
			cb(true)
		else
			cb(false)
		end
	else
		cb(true)
	end
end)