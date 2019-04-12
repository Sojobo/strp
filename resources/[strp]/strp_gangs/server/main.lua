ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_society:registerSociety', 'vagos', 'Vagos', 'society_vagos', 'society_vagos', 'society_vagos', {type = 'public'})
TriggerEvent('esx_service:activateService', 'vagos', -1)
TriggerEvent('esx_society:registerSociety', 'lostmc', 'Lost MC', 'society_lostmc', 'society_lostmc', 'society_lostmc', {type = 'public'})
TriggerEvent('esx_service:activateService', 'lostmc', -1)
TriggerEvent('esx_society:registerSociety', 'triads', 'Triads', 'society_triads', 'society_triads', 'society_triads', {type = 'public'})
TriggerEvent('esx_service:activateService', 'triads', -1)

ESX.RegisterServerCallback('strp_gangs:getOtherPlayerData', function(source, cb, target)
	if Config.EnableESXIdentity then
		local xPlayer = ESX.GetPlayerFromId(target)

		local result = MySQL.Sync.fetchAll('SELECT firstname, lastname, sex, dateofbirth, height FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		})

		local firstname = result[1].firstname
		local lastname  = result[1].lastname
		local sex       = result[1].sex
		local dob       = result[1].dateofbirth
		local height    = result[1].height

		local data = {
			name      = GetPlayerName(target),
			job       = xPlayer.job,
			inventory = xPlayer.inventory,
			accounts  = xPlayer.accounts,
			weapons   = xPlayer.loadout,
			firstname = firstname,
			lastname  = lastname,
			sex       = sex,
			dob       = dob,
			height    = height
		}

		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
			if status ~= nil then
				data.drunk = math.floor(status.percent)
			end
		end)

		if Config.EnableLicenses then
			TriggerEvent('esx_license:getLicenses', target, function(licenses)
				data.licenses = licenses
				cb(data)
			end)
		else
			cb(data)
		end

	else

		local xPlayer = ESX.GetPlayerFromId(target)

		local data = {
			name       = GetPlayerName(target),
			job        = xPlayer.job,
			inventory  = xPlayer.inventory,
			accounts   = xPlayer.accounts,
			weapons    = xPlayer.loadout
		}

		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
			if status ~= nil then
				data.drunk = math.floor(status.percent)
			end
		end)

		TriggerEvent('esx_license:getLicenses', target, function(licenses)
			data.licenses = licenses
		end)

		cb(data)

	end

end)

ESX.RegisterServerCallback('strp_gangs:buyWeapon', function(source, cb, weaponName, type, componentNum)
	local xPlayer = ESX.GetPlayerFromId(source)
	local authorizedWeapons, selectedWeapon = Config.WeaponDealer

	local price
    local ammopurchase = false

	for k,v in ipairs(authorizedWeapons) do
		if v.weapon == weaponName then
			selectedWeapon = v
			break
		end
	end

	if not selectedWeapon then
		print(('strp_gangs: %s attempted to buy an invalid weapon.'):format(xPlayer.identifier))
        TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, "Arms Dealer", "Something went wrong", 'fas fa-exclamation-triangle', "red")
		cb(false)
	end

	-- Weapon
	if type == 1 then
        price = selectedWeapon.price

        if xPlayer.hasWeapon(weaponName) then
            price = math.ceil(price / 2)
            ammopurchase = true
        end

		if xPlayer.getMoney() >= price then
			xPlayer.removeMoney(price)
			xPlayer.addWeapon(weaponName, 100)
            TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, "Arms Dealer", "You successfully purchased a " .. weaponName, 'fas fa-suitcase', "green")
			cb(true)
		else
            TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, "Arms Dealer", "You can't afford that transaction", 'fas fa-exclamation-triangle', "red")
			cb(false)
		end

	-- Weapon Component
	elseif type == 2 then
		price = selectedWeapon.components[componentNum]
		local weaponNum, weapon = ESX.GetWeapon(weaponName)

		local component = weapon.components[componentNum]

		if component then
			if xPlayer.getMoney() >= price then
				xPlayer.removeMoney(price)
				xPlayer.addWeaponComponent(weaponName, component.name)
                TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, "Arms Dealer", "You successfully purchased an upgrade for your " .. weaponName, 'fas fa-suitcase', "green")
				cb(true)
			else
                TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, "Arms Dealer", "You can't afford that transaction", 'fas fa-exclamation-triangle', "red")
				cb(false)
			end
		else
			print(('strp_gangs: %s attempted to buy an invalid weapon component.'):format(xPlayer.identifier))
            TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, "Arms Dealer", "Something went wrong", 'fas fa-exclamation-triangle', "red")
			cb(false)
		end
	end
end)


ESX.RegisterServerCallback('strp_gangs:buyJobVehicle', function(source, cb, vehicleProps, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.name, xPlayer.job.grade_name, type)

	-- vehicle model not found
	if price == 0 then
		print(('strp_gangs: %s attempted to exploit the shop! (invalid vehicle model)'):format(xPlayer.identifier))
		cb(false)
	end

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)

		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, vehicle, plate, type, job, `stored`) VALUES (@owner, @vehicle, @plate, @type, @job, @stored)', {
			['@owner'] = xPlayer.identifier,
			['@vehicle'] = json.encode(vehicleProps),
			['@plate'] = vehicleProps.plate,
			['@type'] = type,
			['@job'] = xPlayer.job.name,
			['@stored'] = true
		}, function (rowsChanged)
			cb(true)
		end)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('strp_gangs:storeNearbyVehicle', function(source, cb, nearbyVehicles)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundPlate, foundNum

	for k,v in ipairs(nearbyVehicles) do
		local result = MySQL.Sync.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = v.plate,
			['@job'] = xPlayer.job.name
		})

		if result[1] then
			foundPlate, foundNum = result[1].plate, k
			break
		end
	end

	if not foundPlate then
		cb(false)
	else
		MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = foundPlate,
			['@job'] = xPlayer.job.name
		}, function (rowsChanged)
			if rowsChanged == 0 then
				print(('strp_gangs: %s has exploited the garage!'):format(xPlayer.identifier))
				cb(false)
			else
				cb(true, foundNum)
			end
		end)
	end

end)

function getPriceFromHash(hashKey, job, jobGrade, type)
	if type == 'helicopter' then
		local vehicles = Config.AuthorizedHelicopters[jobGrade]

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	elseif type == 'car' then
		local vehicles = Config.GangBases[job].VehicleList

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	end

	return 0
end

ESX.RegisterServerCallback('strp_gangs:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)

AddEventHandler('playerDropped', function()
	-- Save the source in case we lose it (which happens a lot)
	local _source = source

	-- Did the player ever join?
	if _source ~= nil then
		local xPlayer = ESX.GetPlayerFromId(_source)

		-- Is it worth telling all clients to refresh?
		if xPlayer ~= nil and xPlayer.job ~= nil and Config.GangBases[xPlayer.job.name] ~= nil then
			Citizen.Wait(5000)
			TriggerEvent('esx_service:updateBlips', { xPlayer.job.name })
		end
	end
end)

RegisterServerEvent('strp_gangs:spawned')
AddEventHandler('strp_gangs:spawned', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer ~= nil and xPlayer.job ~= nil and Config.GangBases[xPlayer.job.name] ~= nil then
		Citizen.Wait(5000)
		TriggerEvent('esx_service:updateBlips', { xPlayer.job.name })
	end
end)

RegisterServerEvent('strp_gangs:forceBlip')
AddEventHandler('strp_gangs:forceBlip', function(job)
	TriggerEvent('esx_service:updateBlips', { job })
end)

RegisterServerEvent('strp_gangs:message')
AddEventHandler('strp_gangs:message', function(target, msg)
	TriggerClientEvent('esx:showNotification', target, msg)
end)
