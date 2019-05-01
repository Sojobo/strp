ESX = nil
local selling = false
local secondsRemaining
local sold = false
local playerHasDrugs = false
local pedIsTryingToSellDrugs = false
local PlayerData		= {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()

	while true do
		Wait(2000)
        if (playerHasDrugs == false) then
            TriggerServerEvent('check')
        end
    end
end)

--TIME TO SELL
Citizen.CreateThread(function()
	while true do
		if selling then
			if secondsRemaining > 0 then
				secondsRemaining = secondsRemaining - 1
				-- ESX.ShowNotification(_U('remained') .. secondsRemaining .. 's')
			end
			Citizen.Wait(1000)
		end
		Citizen.Wait(100)
	end
end)

currentped = 0
playerloc = GetEntityCoords(player, 0)
pedAvailable = false

-- Thread for selling drugs to any NPC
Citizen.CreateThread(function()
    local drugWaitTime = 1000
    while true do
        Citizen.Wait(drugWaitTime)
        drugWaitTime = 500
        pedAvailable = false

        if not selling and playerHasDrugs then
            local ped = GetPlayerPed(-1)
            local coordFrom = GetEntityCoords(ped, 1)
            local coordTo = GetOffsetFromEntityInWorldCoords(ped, 0.0, 4.0, 0.0)
            local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 4, ped, 0)
            local _, _, _, _, npc = GetRaycastResult(rayHandle)

            if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then
                if DoesEntityExist(npc)then
                    if IsPedDeadOrDying(npc) == false then
                        if IsPedInAnyVehicle(npc) == false then
                            local pedType = GetPedType(npc)
                            if pedType ~= 28 and IsPedAPlayer(npc) == false then
                                if npc ~= GetPlayerPed(-1) and npc ~= oldped then
                                    drugWaitTime = 10
                                    pedAvailable = true
                                    currentped = npc
                                    ESX.ShowHelpNotification(_U('input'))
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    waitTime = 100
	while true do
        if (pedAvailable) then
            waitTime = 0
        else
            waitTime = 100
        end

		Wait(waitTime)
		if selling then
			local player = GetPlayerPed(-1)
  			playerloc = GetEntityCoords(player, 0)
			local distance = GetDistanceBetweenCoords(pos1.x, pos1.y, pos1.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
			local pid = PlayerPedId()

			--TOO FAR
			if distance > 5 then
				ESX.ShowNotification(_U('too_far_away'))
				selling = false
				SetEntityAsMissionEntity(oldped)
				SetPedAsNoLongerNeeded(oldped)
				FreezeEntityPosition(oldped,false)
			end

			--SUCCESS
			if secondsRemaining <= 1 then
				selling = false
				SetEntityAsMissionEntity(oldped)
				SetPedAsNoLongerNeeded(oldped)
				FreezeEntityPosition(oldped,false)
				StopAnimTask(pid, "amb@prop_human_bum_bin@idle_b","idle_d", 1.0)
				playerHasDrugs = false
				sold = false
				TriggerServerEvent('sellDrugs')
			end	
			
			if secondsRemaining == 5 and Config.PlayAnimation then
				Citizen.Wait(1000) 
				RequestAnimDict("amb@prop_human_bum_bin@idle_b")
				while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do 
					Citizen.Wait(0) 
				end
				TaskPlayAnim(pid,"amb@prop_human_bum_bin@idle_b","idle_d",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
			end
		end	

        if selling == false and pedAvailable and IsControlJustPressed(1, 38) then
            local distanceFromCity = GetDistanceBetweenCoords(Config.CityPoint.x, Config.CityPoint.y, Config.CityPoint.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
            if distanceFromCity < Config.DistanceFromCity then
                if playerHasDrugs and sold == false and selling == false then 
                    --PED REJECT OFFER
                    local random = math.random(1, Config.PedRejectPercent)
                    if random == Config.PedRejectPercent then
                        ESX.ShowNotification(_U('reject'))
                        oldped = currentped
                        --PED CALLING COPS
                        if Config.CallCops then
                            local randomReport = math.random(1, Config.CallCopsPercent)
                            if randomReport == Config.CallCopsPercent then
                                TriggerServerEvent('drugsNotify')
                            end
                        end
                        TriggerEvent("sold")
                    --PED ACCEPT OFFER
                    else
                        SetEntityAsMissionEntity(currentped)
                        ClearPedTasks(currentped)
                        FreezeEntityPosition(currentped,true)
                        oldped = currentped
                        TaskStandStill(currentped, 9)
                        pos1 = GetEntityCoords(currentped)
                        TriggerEvent("sellingdrugs")
                        ESX.ShowNotification('This person accepted your offer!')
                    end
                end
            else
                ESX.ShowNotification(_U('too_far_away_from_city'))
            end
        end
	end
end)	
		
RegisterNetEvent('sellingdrugs')
AddEventHandler('sellingdrugs', function()
	secondsRemaining = Config.TimeToSell + 1
	selling = true
end)

RegisterNetEvent('sold')
AddEventHandler('sold', function()
	sold = false
	selling = false
	secondsRemaining = 0
end)

--Info that you dont have drugs
RegisterNetEvent('nomoredrugs')
AddEventHandler('nomoredrugs', function()
	ESX.ShowNotification(_U('no_more_drugs'))
	playerHasDrugs = false
	sold = false
	selling = false
	secondsRemaining = 0
end)

--Show help notification ("PRESS E...")
RegisterNetEvent('playerhasdrugs')
AddEventHandler('playerhasdrugs', function()
	playerHasDrugs = true
end)

--Config
local timer = 1 --in minutes - Set the time during the player is outlaw
local blipTime = 25 --in second
--End config

Citizen.CreateThread(function()
    while true do
        Wait(100)
        if NetworkIsSessionStarted() then
            DecorRegister("IsOutlaw",  3)
            DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 1)
            return
        end
    end
end)

Citizen.CreateThread( function()
    while true do
        Wait(500)
        if pedIsTryingToSellDrugs then
            DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 2)
            alertPolice("Reports of a suspected drug deal in progress")
            Wait(3000)
            pedIsTryingToSellDrugs = false
        end
    end
end)

RegisterNetEvent('drugsEnable')
AddEventHandler('drugsEnable', function()
	pedIsTryingToSellDrugs = true
end)

function alertPolice(message)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local notification = {
        subject  = 'Suspected Drug Deal',
        msg      = message,
        icon = 'fas fa-headset',
        iconStyle = 'red',
        locationX = coords.x,
        locationY = coords.y,
        caller = 0,
    }

    TriggerServerEvent('esx_service:callAllInService', notification, "police")
end
-- --DISPATCH END
