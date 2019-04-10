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