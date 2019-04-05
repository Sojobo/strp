ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local win1 = 100  -- lottery ticket
local win2 = 500 
local win3 = 800

-- locales --
local winText = "You won ~g~$"
local ticketEmpty = "Your ticket was ~r~empty"
-------------

local prices = {
	["speaker"] = 25,
	["laptop"] = 175,
	["toothpaste"] = 2,
	["ifruit"] = 150,
	["oldcoin"] = 50,
	["creditcard"] = 60,
	["rolex"] = 200,
	["omega"] = 200,
	["diamondring"] = 90,
	["ring"] = 60,
	["sojobeans"] = 150,
	["gpspill"] = 110,
	["wallet"] = 120,
	["console"] = 60,
	["tablet"] = 40,
	["treasuremap"] = 30,
	["dildo"] = 5,
	["pickledanimal"] = 150,
	["santashat"] = 150,
	["goldchain"] = 80,
	["goldbracelet"] = 40,
	["chocolate"] = 3,
	["tabacco"] = 8,
	["alcohol"] = 8,
	["gamingperipherals"] = 15,
	["passport"] = 60,
	["rarecoin"] = 45,
	["book"] = 5,
	["diamond"] = 85,
	["blurayplayer"] = 30,
	["rareornament"] = 45,
	["magazine"] = 4,
	["junk"] = 1,
}


ESX.RegisterServerCallback('99kr-burglary:getPlayerInventory', function (source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({ items = items, price = prices })
end)

RegisterServerEvent('99kr-burglary:sellItems')
AddEventHandler('99kr-burglary:sellItems', function (itemName, count, price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if count > 0 then
		xPlayer.removeInventoryItem(itemName, count)
		xPlayer.addMoney(price*count)
		TriggerClientEvent('esx:showNotification', _source, 'You have sold ' .. itemName ..  ' ' .. count)
	else
		TriggerClientEvent('esx:showNotification', _source, "Invalid Quantity")
	end
end)

RegisterServerEvent('99kr-burglary:Add')
AddEventHandler('99kr-burglary:Add', function(item, qtty)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	xPlayer.addInventoryItem(item, qtty)
end)

RegisterServerEvent('99kr-burglary:Remove')
AddEventHandler('99kr-burglary:Remove', function(item, qtty)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	xPlayer.removeInventoryItem(item, qtty)
end)

ESX.RegisterUsableItem('lotteryticket', function(source)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local rndm = math.random(1,11)
	xPlayer.removeInventoryItem('lotteryticket', 1)

	if rndm == 1 then              -- WIN 1
		xPlayer.addMoney(win1)
		TriggerClientEvent('99kr-burglary:Sound', src, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
		TriggerClientEvent('esx:showNotification', src, winText .. win1)
	end

	if rndm == 2 then              -- WIN 2
		xPlayer.addMoney(win2)
		TriggerClientEvent('99kr-burglary:Sound', src, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
		TriggerClientEvent('esx:showNotification', src, winText .. win2)
	end

	if rndm == 3 then              -- WIN 3
		xPlayer.addMoney(win3)
		TriggerClientEvent('99kr-burglary:Sound', src, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
		TriggerClientEvent('esx:showNotification', src, winText .. win3)
	end

	if rndm >= 4 then
		TriggerClientEvent('99kr-burglary:Sound', src, "NO", "HUD_FRONTEND_DEFAULT_SOUNDSET")
		TriggerClientEvent('esx:showNotification', src, ticketEmpty)
	end

end)