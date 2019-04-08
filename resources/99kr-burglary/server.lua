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
	--hjigh
	["rolex"] = 400,
	["omega"] = 400,
	["laptop"] = 200,
	["pickledanimal"] = 100,
	["santashat"] = 100,
	["ifruit"] = 150,
	["wallet"] = 120,
	["gpspill"] = 110,
	["sojobeans"] = 100,
	--mid
	["diamondring"] = 90,
	["goldchain"] = 80,
	["creditcard"] = 75,
	["ring"] = 70,
	["console"] = 60,
	["oldcoin"] = 50,
	["passport"] = 40,
	["rarecoin"] = 55,
	["diamond"] = 85,
	--low
	["tablet"] = 45,
	["goldbracelet"] = 40,
	["treasuremap"] = 35,
	["rareornament"] = 45,
	["gamingperipherals"] = 15,
	["speaker"] = 10,
	["dildo"] = 5,
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
    local xItem = xPlayer.getInventoryItem(itemName)

    if count > xItem.count then
        TriggerClientEvent('esx:showNotification', _source, "You don't have enough of that item")
	elseif count > 0 then
		xPlayer.removeInventoryItem(itemName, count)
		xPlayer.addMoney(price*count)
		TriggerClientEvent('esx:showNotification', _source, 'You have sold ' .. itemName ..  ' ' .. count)
	else
		TriggerClientEvent('esx:showNotification', _source, "Invalid Quantity")
	end
end)

RegisterServerEvent('99kr-burglary:Add')
AddEventHandler('99kr-burglary:Add', function(item, qtty, iname)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
    --local xInventoryWeight = xPlayer.getInventoryWeight()
	--local xInventorylimit = xPlayer.getInventoryWeightMax()

    --if xInventoryWeight + qtty > xInventorylimit then
        --TriggerClientEvent('esx:showNotification', src, "You're carrying too much")
    --else
        TriggerClientEvent('esx:showNotification', src, "You found " .. qtty .. " " .. iname)
        xPlayer.addInventoryItem(item, qtty)
   --end
end)

RegisterServerEvent('99kr-burglary:Remove')
AddEventHandler('99kr-burglary:Remove', function(item, qtty)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
    --local xItem = xPlayer.getInventoryItem(item)

	--if xItem.count < amount then
		TriggerClientEvent('esx:showNotification', src, "You don't have enough of that item")
		--return
	--else
	    xPlayer.removeInventoryItem(item, qtty)
    --end
end)

ESX.RegisterUsableItem('lotteryticket', function(source)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local rndm = math.random(1,25)
	xPlayer.removeInventoryItem('lotteryticket', 1)

	if rndm == 1 then              -- WIN 1
		xPlayer.addMoney(win1)
		TriggerClientEvent('99kr-burglary:Sound', src, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
		TriggerClientEvent('esx:showAdvancedNotification', src, "Lottery Results", 'That\'s a winning ticket! You get $' .. win1, 'fas fa-splotch', "green")
	elseif rndm == 2 or rndm == 3 then              -- WIN 2
		xPlayer.addMoney(win2)
		TriggerClientEvent('99kr-burglary:Sound', src, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
		TriggerClientEvent('esx:showAdvancedNotification', src, "Lottery Results", 'That\'s a winning ticket! You get $' .. win2, 'fas fa-splotch', "green")
	elseif rndm < 6 then              -- WIN 3
		xPlayer.addMoney(win3)
		TriggerClientEvent('99kr-burglary:Sound', src, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
		TriggerClientEvent('esx:showAdvancedNotification', src, "Lottery Results", 'That\'s a winning ticket! You get $' .. win3, 'fas fa-splotch', "green")
	else
		TriggerClientEvent('99kr-burglary:Sound', src, "NO", "HUD_FRONTEND_DEFAULT_SOUNDSET")
		TriggerClientEvent('esx:showAdvancedNotification', src, "Lottery Results", "This ticket's not a winner, it's worthless.", 'fas fa-splotch', "red")
	end

end)

RegisterNetEvent('99kr-burglary:cooldown')
AddEventHandler('99kr-burglary:cooldown', function (place)
	Config.burglaryPlaces[place].cooldown = Config.cooldownTime
	TriggerClientEvent('99kr-burglary:cooldown', -1, place)
end)