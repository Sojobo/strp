local currentLaunderer = math.random(1, 15) -- up to 15

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('dirtyMoney:getLaunderer')
AddEventHandler('dirtyMoney:getLaunderer', function()
    TriggerClientEvent('dirtyMoney:updateLaunderer', source, currentLaunderer)
end)

RegisterServerEvent('dirtyMoney:setLaunderer')
AddEventHandler('dirtyMoney:setLaunderer', function()
    setNewlaunderer()
end)

RegisterServerEvent('dirtyMoney:launderMoney')
AddEventHandler('dirtyMoney:launderMoney', function(launderer)
    local source = source
    local launderer = launderer
    SetTimeout(1200, function()
        getCleanMoney(source, launderer)
    end)
end)

function getCleanMoney(source, launderer)
    local xPlayer = ESX.GetPlayerFromId(source)
    local player = source
    local launderer = launderer
    
    local moneyLaundered = 0
    local moomoo = 0

    if launderer == currentLaunderer then
        SetTimeout(2500, function()
            local dirty_money = xPlayer.getAccount('black_money').money
            if dirty_money > 1000 then
                moneyLaundered = math.random(100, 1000)
            elseif dirty_money > 0 then
                moneyLaundered = dirty_money
            end

            if moneyLaundered > 0 then
                xPlayer.removeAccountMoney('black_money', moneyLaundered)
                moomoo = math.floor(moneyLaundered * 0.70)
                xPlayer.addMoney(moomoo)
                
                TriggerClientEvent('esx:showAdvancedNotification', player, "Money Laundering", "I've been able to launder <b>$" .. moneyLaundered .. "</b> into <b>$" .. moomoo .. "</b> for you. Stick around, I got more for ya!", 'fas fa-money-bill', "green")
                getCleanMoney(player, launderer)
            else
                TriggerClientEvent('esx:showAdvancedNotification', player, "Money Laundering", "That's it! You've got no more money to clean, pleasure doing business!", 'fas fa-money-bill', "blue")
            end
        end)
    else
        SetTimeout(2500, function()
            TriggerClientEvent('esx:showAdvancedNotification', player, "Money Laundering", "I've laundered what I can, there's too much heat around here, I'm out!", 'fas fa-money-bill', "blue")
        end)
    end
end

function setNewlaunderer()
    local oldLaunderer = currentLaunderer

    while currentLaunderer == oldLaunderer do -- ensure new launderer is different from current
        local rn = math.random(1, 15)
        currentLaunderer = rn
    end
    
    TriggerClientEvent('dirtyMoney:updateLaunderer', -1, currentLaunderer)
end

RegisterServerEvent('dirtyMoney:transfer')
AddEventHandler('dirtyMoney:transfer', function(to, amount)
    local xFromPlayer = ESX.GetPlayerFromId(source)
    local xToPlayer = ESX.GetPlayerFromId(to)
    local player = source

    if to and amount then
        if xFromPlayer.getAccount('black_money').money > amount then
            xFromPlayer.removeAccountMoney('black_money', amount)
            TriggerClientEvent('esx:showAdvancedNotification', player, "Money Laundering", "You sent $" .. amount .. " dirty money succesfully!", 'fas fa-money-bill', "green")

            xToPlayer.addAccountMoney('black_money', amount)
            TriggerClientEvent('esx:showAdvancedNotification', to, "Money Laundering", "You just received $" .. amount .. " dirty money!", 'fas fa-money-bill', "green")
        else
            TriggerClientEvent('esx:showAdvancedNotification', player, "Money Laundering", "You do not have enough dirty money!", 'fas fa-money-bill', "red")
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', player, "Money Laundering", "Failed to transfer dirty money!", 'fas fa-money-bill', "red")
    end
end)

-- transfer dirty money
TriggerEvent('commands:add', 'transferdirty', 'user', function(source, args)
    local player = source
    local to = tonumber(args[2])
    local amount = tonumber(args[3])

    if to and amount then
        local recipient = exports['character']:characterIdToServerId(to)

        if recipient then
            TriggerClientEvent('dirtyMoney:transferCheck', player, recipient, amount)
        else
            TriggerClientEvent('esx:showAdvancedNotification', player, "Money Laundering", "Invalid recipient!", 'fas fa-money-bill', "red")
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', player, "Money Laundering", "Use format /transferdirty [id] [amount]", 'fas fa-money-bill', "red")
        return false
    end
end)