local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1)
	end
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

local Melee = { -1569615261, 1737195953, 1317494643, -1786099057, 1141786504, -2067956739, -868994466 }
local Knife = { -1716189206, 1223143800, -1955384325, -1833087301, 910830060, }
local Bullet = { 453432689, 1593441988, 584646201, -1716589765, 324215364, 736523883, -270015777, -1074790547, -2084633992, -1357824103, -1660422300, 2144741730, 487013001, 2017895192, -494615257, -1654528753, 100416529, 205991906, 1119849093 }
local Animal = { -100946242, 148160082 }
local FallDamage = { -842959696 }
local Explosion = { -1568386805, 1305664598, -1312131151, 375527679, 324506233, 1752584910, -1813897027, 741814745, -37975472, 539292904, 341774354, -1090665087 }
local Gas = { -1600701090 }
local Burn = { 615608432, 883325847, -544306709 }
local Drown = { -10959621, 1936677264 }
local Car = { 133987706, -1553120962 }

function checkArray (array, val)
	for name, value in ipairs(array) do
		if value == val then
			return true
		end
	end

	return false
end

Citizen.CreateThread(function()
	Citizen.Wait(1000)
	while true do
		local sleep = 1000

		if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
			local player, distance = ESX.Game.GetClosestPlayer()
			local playerped = GetPlayerPed(player)
			if distance ~= -1 and distance < 10.0 then
				if distance ~= -1 and distance <= 2.0 then
					if IsPedDeadOrDying(playerped) or IsEntityPlayingAnim(playerped, "mp_arresting", "idle", 3) then
						Start(player, playerped)
                        sleep = 0
					end
				end
			end

		end

		Citizen.Wait(sleep)
	end
end)

function Start(player, ped)
	checking = true

	while checking do
		Citizen.Wait(0)
        local thisentity = ped

        local veh = GetVehiclePedIsIn(ped, false) -- true means last vehicle, false means current only
        local myveh = GetVehiclePedIsIn(GetPlayerPed(-1), false) -- true means last vehicle, false means current only
        if (veh > 0 and veh ~= myveh) then
            thisentity = veh -- Show options on the car instead of the person
        end
		local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(thisentity))
		local x,y,z = table.unpack(GetEntityCoords(thisentity))

		if distance < 2.0 then
			DrawText3D(x,y,z, 'Press [~b~E~s~] to manage individual', 0.4)

			if IsControlPressed(0,  Keys['E']) then
				OpenDeathMenu(player, ped)
			end
		end

		if distance > 7.5 or not IsPedDeadOrDying(ped) then
			checking = false
		end

	end

end

function Notification(x,y,z)
	local timestamp = GetGameTimer()

	while (timestamp + 4500) > GetGameTimer() do
		Citizen.Wait(0)
		DrawText3D(x, y, z, 'The wound is here', 0.4)
		checking = false
	end
end

function OpenDeathMenu(player, ped)
	loadAnimDict('amb@medic@standing@kneel@base')
	loadAnimDict('anim@gangops@facility@servers@bodysearch@')

	local myPed = PlayerPedId()
	local elements   = {}
	if ESX.PlayerData.job ~= nil then
        table.insert(elements, { label = "Drag", value = 'drag' })
        table.insert(elements, { label = "Put in vehicle", value = 'put_in_vehicle' })
        table.insert(elements, { label = "Pull out vehicle", value = 'out_the_vehicle' })

        if ESX.PlayerData.job.name == 'police' then
            ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
                if isInService then
                    table.insert(elements, { label = "Search", value = 'body_search' })
                    table.insert(elements, { label = "Handcuff", value = 'handcuff' })
                    table.insert(elements, { label = "Arrest", value = 'arrest' })
                end
            end, 'police')
        elseif ESX.PlayerData.job.name == 'ambulance' then
            ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
                table.insert(elements, { label = 'Identify where wound is', value = 'damage' })
                table.insert(elements, { label = 'Find cause of death', value = 'deathcause' })
                table.insert(elements, { label = 'Perform CPR', value = 'ems_menu_revive' })
                table.insert(elements, { label = 'Heal small wounds', value = 'ems_menu_small' })
                table.insert(elements, { label = 'Treat serious injuries', value = 'ems_menu_big' })
             end, 'ambulance')
        end
	end

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'dead_citizen',
		{
			title    = 'Choose Option',
			align    = 'top-right',
			elements = elements,
		},
		function(data, menu)
			local action = data.current.value

			-- Police Functions
			if action == 'body_search' then
				TriggerServerEvent('esx_policejob:message', GetPlayerServerId(player), "Your body was searched")
				OpenBodySearchMenu(player)
			elseif action == 'handcuff' then
				TriggerServerEvent('esx_policejob:handcuff', GetPlayerServerId(player))
			elseif action == 'drag' then
				TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(player))
			elseif action == 'put_in_vehicle' then
				TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(player))
			elseif action == 'out_the_vehicle' then
				TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(player))
			elseif action == 'arrest' then
				local result = nil
				DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP10", "", "", "", "", "", 255)
				ESX.ShowNotification("Enter the suspect's charges.")
				while (UpdateOnscreenKeyboard() == 0) do
					DisableAllControlActions(0)
					Wait(0)
				end
				if (GetOnscreenKeyboardResult()) then
					result = GetOnscreenKeyboardResult() or ""
				end
				local jailCharges = result
				DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 2)
				ESX.ShowNotification("Enter the amount of jail time in minutes.")
				while (UpdateOnscreenKeyboard() == 0) do
					DisableAllControlActions(0)
					Wait(0)
				end
				if (GetOnscreenKeyboardResult()) then
					result = tonumber(GetOnscreenKeyboardResult()) or 0
				end
				local jailTime = result
				if jailTime <= 0 then
					return TriggerEvent("chatMessage", "^1Invalid Jail Time, enter an amount greater than 0.")
				elseif jailCharges == nil or jailCharges == "" then
					return TriggerEvent("chatMessage", "^1You must enter the suspect's charges.")
				else
					TriggerServerEvent("jnj:sendToJail", GetPlayerServerId(player), jailTime, jailCharges)
				end
			end

			-- Medic Functions
			if action == 'damage' then
				local bone
				local success = GetPedLastDamageBone(ped,bone)

				local success,bone = GetPedLastDamageBone(ped)
				if success then
					--print(bone)
					local x,y,z = table.unpack(GetPedBoneCoords(ped, bone))
					Notification(x,y,z)

				else
					Notify('Where the damage occured could not get identified')
				end
			end

			if action == 'deathcause' then
				--gets deathcause
				local d = GetPedCauseOfDeath(ped)

				--starts animation
				TaskPlayAnim(myPed, "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
				TaskPlayAnim(myPed, "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
				Citizen.Wait(5000)

				--exits animation
				ClearPedTasksImmediately(myPed)

				if checkArray(Melee, d) then
					Notify(_U('hardmeele'))
				elseif checkArray(Bullet, d) then
					Notify(_U('bullet'))
				elseif checkArray(Knife, d) then
					Notify(_U('knifes'))
				elseif checkArray(Animal, d) then
					Notify(_U('bitten'))
				elseif checkArray(FallDamage, d) then
					Notify(_U('brokenlegs'))
				elseif checkArray(Explosion, d) then
					Notify(_U('explosive'))
				elseif checkArray(Gas, d) then
					Notify(_U('gas'))
				elseif checkArray(Burn, d) then
					Notify(_U('fire'))
				elseif checkArray(Drown, d) then
					Notify(_U('drown'))
				elseif checkArray(Car, d) then
					Notify(_U('caraccident'))
				else
					Notify(_U('unknown'))
				end
			end

			if data.current.value == 'ems_menu_revive' then
				ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
					if quantity > 0 then

						if IsPedDeadOrDying(ped, 1) then
							ESX.ShowNotification("a revive is in progress!")

							local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'

							for i=1, 15, 1 do
								Citizen.Wait(900)

								ESX.Streaming.RequestAnimDict(lib, function()
									TaskPlayAnim(myPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
								end)
							end

							TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
							TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(player))

							-- Show revive award?
							if Config.ReviveReward > 0 then
								ESX.ShowNotification("you have revived <b>%s</b> and earned <b>$%s</b>!", GetPlayerName(player), Config.ReviveReward)
							else
								ESX.ShowNotification("you have revived <b>%s</b>", GetPlayerName(player))
							end
						else
							ESX.ShowNotification("that player is not unconscious!")
						end
					else
						ESX.ShowNotification("You do not have a <b>medikit</b>.")
					end

					IsBusy = false

				end, 'medikit')

			elseif data.current.value == 'ems_menu_small' then
				ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
					if quantity > 0 then
						local health = GetEntityHealth(ped)

						if health > 0 then
							ESX.ShowNotification("you are healing!")
							TaskStartScenarioInPlace(myPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
							Citizen.Wait(10000)
							ClearPedTasks(myPed)

							TriggerServerEvent('esx_ambulancejob:removeItem', 'bandage')
							TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(player), 'small')
							ESX.ShowNotification("you have healed <b>%s</b>", GetPlayerName(player))
						else
							ESX.ShowNotification("that player is not conscious!")
						end
					else
						ESX.ShowNotification("You do not have a <b>bandage</b>.")
					end
				end, 'bandage')

			elseif data.current.value == 'ems_menu_big' then
				ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
					if quantity > 0 then
						local health = GetEntityHealth(ped)

						if health > 0 then
							ESX.ShowNotification("you are healing!")
							TaskStartScenarioInPlace(myPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
							Citizen.Wait(10000)
							ClearPedTasks(myPed)

							TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
							TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(player), 'big')
							ESX.ShowNotification("you have healed <b>%s</b>", GetPlayerName(player))
						else
							ESX.ShowNotification("that player is not conscious!")
						end
					else
						ESX.ShowNotification("You do not have a <b>medikit</b>.")
					end
				end, 'medikit')
			end

		end,
		function(data, menu)
			menu.close()
		end
	)
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(1)
	end
end

function Notify(message)
	ESX.ShowNotification(message)
end

function DrawText3D(x, y, z, text, scale)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 215)

	AddTextComponentString(text)
	DrawText(_x, _y)

end
