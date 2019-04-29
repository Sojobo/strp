ESX = nil

TriggerEvent("esx:getSharedObject", function(response)
    ESX = response
end)

RegisterServerEvent('esx-sopletare:getItem')
AddEventHandler('esx-sopletare:getItem', function()

    local luck = math.random(1, 3)

    if luck == 1 then

        local items = { -- add whatever items you want here
            'lotteryticket',
            'ring',
            'diamond',
            'junk',
            'oldcoin',
            'passport',
            'cannabis',
            'cocaine',
            'wallet',
            'dildo',
            'rubberband',
            'bobbypin',
            'metal',
            'wood',
            'spring',
            'cloth',
            'pistolclip',
            'pistolbody',
            'trigger',
            'metalpipe',
            'junk',
            'book',

        }

        local xPlayer = ESX.GetPlayerFromId(source)
        local randomItems = items[math.random(#items)]
        local quantity = math.random(5) 
        local itemfound = ESX.GetItemLabel(randomItems)
        local xInventoryWeight = xPlayer.getInventoryWeight()
	    local xInventorylimit = xPlayer.getInventoryWeightMax()
        
        if xInventoryWeight + quantity > xInventorylimit then
        TriggerClientEvent('esx:showNotification', source, "You're carrying too much")
    else
        xPlayer.addInventoryItem(randomItems, quantity)
        TriggerClientEvent('esx:showNotification', source, 'You found ' .. quantity .. ' ' .. itemfound)
    end
else
        TriggerClientEvent('esx:showNotification', source, 'You found nothing, tried getting a job?')
    end
end)
