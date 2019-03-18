local shoppingList = {
    [1507916787] = { name = "Picador", costs = 480, model = "picador", damageMultiplier = 1  },
    [-1150599089] = { name = "Primo", costs = 480, model = "primo", damageMultiplier = 1 },
    [-1130810103] = { name = "Dilettante", costs = 530, model = "dilettante", damageMultiplier = 1 },
    [-1800170043] = { name = "Gauntlet", costs = 1000, model = "gauntlet", damageMultiplier = 3 },
    [486987393] = { name = "Huntley S", costs = 1900, model = "huntley", damageMultiplier = 6 },
    [-682211828] = { name = "Buccaneer", costs = 700, model = "buccaneer", damageMultiplier = 3 },
    [1269098716] = { name = "Landstalker", costs = 1200, model = "landstalker", damageMultiplier = 4 },
    [873639469] = { name = "Sentinel", costs = 1600, model = "sentinel2", damageMultiplier = 4 },
    [1349725314] = { name = "Sentinel XS", costs = 1400, model = "sentinel", damageMultiplier = 3 },
    [-304802106] = { name = "Buffalo", costs = 1000, model = "buffalo", damageMultiplier = 3 },
    [-5153954] = { name = "Exemplar", costs = 2200, model = "exemplar", damageMultiplier = 8 },
    [767087018] = { name = "Alpha", costs = 2000, model = "alpha", damageMultiplier = 7 },
    [-1041692462] = { name = "Banshee", costs = 2900, model = "banshee", damageMultiplier = 6 },
    [1723137093] = { name = "Stratum", costs = 500, model = "stratum", damageMultiplier = 1 },
    [-1685021548] = { name = "Sabre Turbo", costs = 600, model = "sabregt", damageMultiplier = 2 },
    [841808271] = { name = "Rhapsody", costs = 700, model = "rhapsody", damageMultiplier = 2 },
    [-1775728740] = { name = "Granger", costs = 1000, model = "granger", damageMultiplier = 3 },
    [-1894894188] = { name = "Surge", costs = 1100, model = "surge", damageMultiplier = 3 },
    [-685276541] = { name = "Emperor", costs = 1200, model = "emperor", damageMultiplier = 4 },
    [65402552] = { name = "Youga", costs = 450, model = "youga", damageMultiplier = 2 },
    [-1903012613] = { name = "Asterope", costs = 1400, model = "asterope", damageMultiplier = 4 },
    [970598228] = { name = "Sultan", costs = 520, model = "sultan", damageMultiplier = 1 },
    [-431692672] = { name = "Panto", costs = 640, model = "panto", damageMultiplier = 2 },
    [-808831384] = { name = "Classic Baller", costs = 1500, model = "baller", damageMultiplier = 4 },
    [-1297672541] = { name = "Jester", costs = 2050, model = "jester", damageMultiplier = 6 },
    [1777363799] = { name = "Washington", costs = 330, model = "washington", damageMultiplier = 2 },
    [1123216662] = { name = "Super Diamond", costs = 2100, model = "superd", damageMultiplier = 8 },
    [1032823388] = { name = "Obey 9F", costs = 1900, model = "ninef", damageMultiplier = 7 },
    [2053223216] = { name = "Benson", costs = 1800, model = "benson", damageMultiplier = 8 },
    [1162065741] = { name = "Rumpo", costs = 1400, model = "rumpo", damageMultiplier = 8 },
    [-1289722222] = { name = "Ingot", costs = 600, model = "ingot", damageMultiplier = 2 },
    [1039032026] = { name = "Blista XS", costs = 1200, model = "blista2", damageMultiplier = 3 },
    [1069929536] = { name = "BobcatXL", costs = 1500, model = "bobcatxl", damageMultiplier = 4 },
    [1221512915] = { name = "Seminole", costs = 1600, model = "seminole", damageMultiplier = 4 },
    [-227741703] = { name = "Ruiner", costs = 1100, model = "ruiner", damageMultiplier = 3 },
    [1830407356] = { name = "Peyote", costs = 1900, model = "peyote", damageMultiplier = 4 },
    [-310465116] = { name = "Minivan", costs = 1300, model = "minivan", damageMultiplier = 3 },
    [-1543762099] = { name = "Gresley", costs = 1900, model = "gresley", damageMultiplier = 4 },
    [-344943009] = { name = "Blista", costs = 1300, model = "blista", damageMultiplier = 3 },
    [2016857647] = { name = "Futo", costs = 550, model = "futo", damageMultiplier = 1 },
    [1353720154] = { name = "Flatbed", costs = 1100, model = "flatbed", damageMultiplier = 3 },
    [569305213] = { name = "Packer", costs = 900, model = "packer", damageMultiplier = 2 },
}

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('chopshop:chopVehicle')
AddEventHandler('chopshop:chopVehicle', function(vehicleProps, model)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT state FROM owned_vehicles WHERE plate = @plate", { ['@plate'] = vehicleProps.plate }, function(result)
        if (result[1]) then
            TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, "Chop Shop", "That vehicle is too hot, get it out of here!", 'fas fa-car', "red")
        else
            TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, "Chop Shop", "You were paid $" .. shoppingList[vehicleProps.model].costs .. " for chopping the vehicle.", 'fas fa-car', "red")
            xPlayer.addAccountMoney('black_money', shoppingList[vehicleProps.model].costs)
        end
    end)
end)

