----------------------------------------------------------------------------------------------
--------------------------------------FRAMEWORK INIT------------------------------------------
----------------------------------------------------------------------------------------------

ESX	= nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
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
-----------------------------------------------
-------------- GLOBAL VARIABLES ---------------
-----------------------------------------------
local playerPed     	= PlayerPedId()
local isInBaitShopMenu  = false
local currentBaitshop   = {}
local shopMenu
local anchored = false
local boat = nil
local fishing = false
local lastInput = 0
local pause = false
local pausetimer = 0
local correct = 0
local bait = "none"

-----------------------------------------------
-------------------- SHOP ---------------------
-----------------------------------------------
local marker = {
  {title="Fishing Store", colour=2, id=498, x = 1694.823, y = 3755.388, z = 34.705, rot = 249.654, radius = 1.5},
}


local SellFishblip = AddBlipForCoord(Config.SellFish.x, Config.SellFish.y, Config.SellFish.z)
SetBlipSprite(SellFishblip, 68)
SetBlipColour(SellFishblip, 15)
SetBlipScale(SellFishblip, 0.8)
SetBlipAsShortRange(SellFishblip, true)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString("Fish Restaurant")
EndTextCommandSetBlipName(SellFishblip)


local blipFishingShop = AddBlipForCoord(1694.8238525391, 3755.3889160156, 34.705341339111)
SetBlipSprite(blipFishingShop, 68)
SetBlipColour(blipFishingShop, 15)
SetBlipScale(blipFishingShop, 0.8)
SetBlipAsShortRange(blipFishingShop, true)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString("Fishing Store")
EndTextCommandSetBlipName(blipFishingShop)


RegisterNetEvent('vg_fishing:message')
AddEventHandler('vg_fishing:message', function(text)	
	ESX.ShowAdvancedNotification("Fishing", text, "fas fa-fish", "blue")
end, false)

			
function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

----------------MENU HEADER------------------

_menuPool = NativeUI.CreatePool()
 shopMenu = NativeUI.CreateMenu("Fishing Equipment", "Buy Equipment")
_menuPool:Add(shopMenu)
_menuPool:ControlDisablingEnabled(false)
_menuPool:MouseControlsEnabled(false)

----------------MENU OPEN------------------
Citizen.CreateThread(function()
    local playerID = GetPlayerServerId(PlayerId())
	GenerateShopMenu()
    Citizen.Wait(3000)
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        if isInBaitShopMenu and IsControlJustPressed(1, 51) then
            shopMenu:Visible(not shopMenu:Visible())
        end
        if not isInBaitShopMenu then
            shopMenu:Visible(false)
        end
        if (isInBaitShopMenu == true) then
            DisplayHelpText("Press ~INPUT_CONTEXT~ to open the menu")
        end
    end
end)

----------------MENU FUNCTIONS------------------

function GenerateShopMenu()
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
	
	-- _menuPool:Remove()
    _menuPool = NativeUI.CreatePool()
    collectgarbage()
    
	
	 shopMenu = NativeUI.CreateMenu("Fishing", "Description")
    _menuPool:Add(shopMenu)
	
	local fishingrod = NativeUI.CreateItem("Fishing Rod", Config.FishingrodPrice .. " $")
    shopMenu:AddItem(fishingrod)
	
	local fishingknife = NativeUI.CreateItem("Fishing Knife", Config.FishingknifePrice .. " $")
    shopMenu:AddItem(fishingknife)
	
	local bait1 = NativeUI.CreateItem("Fish Bait", Config.FishbaitPrice .. " $")
    shopMenu:AddItem(bait1)
	
	local bait2 = NativeUI.CreateItem("Turtle Food", Config.TurtlebaitPrice .. " $")
    shopMenu:AddItem(bait2)

    shopMenu.OnItemSelect = function(sender, item, index)
				
		if item == fishingrod then
			TriggerServerEvent('vg_fishing:addItem', 'fishingrod', '1')
        end
		
		if item == fishingknife then
			TriggerServerEvent('vg_fishing:addItem', 'fishingknife', '1')
        end
		
		if item == bait1 then
			TriggerServerEvent('vg_fishing:addItem', 'fishbait', '1')
        end
		
		if item == bait2 then
			TriggerServerEvent('vg_fishing:addItem', 'turtlebait', '1')
        end		
		
	end
	_menuPool:ControlDisablingEnabled(false)
	_menuPool:MouseControlsEnabled(false)
    _menuPool:RefreshIndex()
end



Citizen.CreateThread(function() 
    while true do
		Citizen.Wait(0)

		local playerPed = PlayerPedId()
		
		local playerCoords = GetEntityCoords(PlayerPedId())
		if (GetDistanceBetweenCoords(playerCoords, Config.FishingShop.x, Config.FishingShop.y, Config.FishingShop.z, true) < 50.0) then
			DrawMarker(27, Config.FishingShop.x, Config.FishingShop.y, Config.FishingShop.z+ 0.05, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.radius, Config.Marker.radius, Config.Marker.radius, Config.Marker.colour.r, Config.Marker.colour.g, Config.Marker.colour.b, Config.Marker.colour.a, false, false, 2, false, false, false, false)	
			for k,v in pairs(marker) do
				if (GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true) < v.radius/2) then		
					isInBaitShopMenu = true
					currentBaitshop = v
					break
				else
					isInBaitShopMenu = false
					currentBaitshop = {}
				end
			end
		end

		if (GetDistanceBetweenCoords(playerCoords, Config.SellFish.x, Config.SellFish.y, Config.SellFish.z, true) < 50.0) then
			DrawMarker(27, Config.SellFish.x, Config.SellFish.y, Config.SellFish.z+ 0.05, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.radius*1.5, Config.Marker.radius*1.5, Config.Marker.radius, Config.Marker.colour.r, Config.Marker.colour.g, Config.Marker.colour.b, Config.Marker.colour.a, false, false, 2, false, false, false, false)
		end

		if IsPedInAnyBoat(playerPed) then
			boat  = GetVehiclePedIsIn(playerPed, true)
		end

		if IsControlJustPressed(1, 81) and not IsPedInAnyVehicle(playerPed) and boat ~= nil and GetDistanceBetweenCoords(playerCoords, GetEntityCoords(boat), true) < 5.0 then
			if not anchored then
				SetBoatAnchor(boat, true)
				TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
				TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "Anchordown", 0.6)
				Citizen.Wait(10000)
				ESX.ShowAdvancedNotification("Ahoy!", "You've lowered the anchor!", "fas fa-anchor", "blue")
				ClearPedTasks(playerPed)
			else
				TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
				TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "Anchorup", 0.6)
				Citizen.Wait(10000)
				SetBoatAnchor(boat, false)
				ESX.ShowAdvancedNotification("Ahoy!", "You've raised the anchor!", "fas fa-anchor", "blue")
				ClearPedTasks(playerPed)
			end
			anchored = not anchored
		end
		if IsVehicleEngineOn(boat) then
			anchored = false
		end
    end
end)

Citizen.CreateThread(function()
	while true do
		Wait(600)
		if pause and fishing then
			pausetimer = pausetimer + 1
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(5)

        if fishing and (IsControlJustReleased(0, Keys['X']) or IsControlJustReleased(0, Keys['W']) or IsControlJustReleased(0, Keys['A']) or IsControlJustReleased(0, Keys['S']) or IsControlJustReleased(0, Keys['D'])) then
            fishing = false
            ClearPedTasks(PlayerPedId())
            ESX.ShowAdvancedNotification("Fishing", "Fishing stopped", "fas fa-fish", "blue")
        end

        if fishing then
		    BlockWeaponWheelThisFrame()
		
			if IsControlJustReleased(0, Keys['1']) then
				input = 1
			elseif IsControlJustReleased(0, Keys['2']) then
				input = 2
			elseif IsControlJustReleased(0, Keys['3']) then
				input = 3
			elseif IsControlJustReleased(0, Keys['4']) then
				input = 4
			elseif IsControlJustReleased(0, Keys['5']) then
				input = 5
			elseif IsControlJustReleased(0, Keys['6']) then
				input = 6
			elseif IsControlJustReleased(0, Keys['7']) then
				input = 7
			elseif IsControlJustReleased(0, Keys['8']) then
				input = 8
			end
			
            playerPed = PlayerPedId()
            local pos = GetEntityCoords(PlayerPedId())
            if IsPedInAnyVehicle(PlayerPedId()) or IsEntityDead(playerPed) or IsEntityInWater(playerPed) then
                fishing = false
                ClearPedTasks(PlayerPedId())
                ESX.ShowAdvancedNotification("Fishing", "Fishing stopped", "fas fa-fish", "blue")
            end

			if pausetimer > 3 then
				input = 99
			end
			
			if pause and input ~= 0 then
				pause = false
				if input == correct then
					TriggerServerEvent('vg_fishing:catch', bait)
				else
					ESX.ShowAdvancedNotification("Fishing", "The fish got away", "fas fa-fish", "red")
				end
			end
		end
		
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.SellFish.x, Config.SellFish.y, Config.SellFish.z, true) <= 3 then
			TriggerServerEvent('vg_fishing:startSelling', "fish")
			Citizen.Wait(4000)
		end
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.SellShark.x, Config.SellShark.y, Config.SellShark.z, true) <= 3 then
			TriggerServerEvent('vg_fishing:startSelling', "shark")
			Citizen.Wait(4000)
		end
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.SellTurtle.x, Config.SellTurtle.y, Config.SellTurtle.z, true) <= 3 then
			TriggerServerEvent('vg_fishing:startSelling', "turtle")
			Citizen.Wait(4000)
		end
		
	end
end)
				

Citizen.CreateThread(function()
	while true do
		local wait = math.random(Config.FishTime.a , Config.FishTime.b)
		Wait(wait)
		if fishing then
			pause = true
			correct = math.random(1,8)
			ESX.ShowAdvancedNotification("Fishing", "There's a fish on the line, Press " .. correct .. " to catch it", "fas fa-fish", "green")
			input = 0
			pausetimer = 0
		end
	end
end)

RegisterNetEvent('vg_fishing:break')
AddEventHandler('vg_fishing:break', function()
	fishing = false
	ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent('vg_fishing:spawnPed')
AddEventHandler('vg_fishing:spawnPed', function()
	RequestModel( GetHashKey( "A_C_SharkTiger" ) )
	while ( not HasModelLoaded( GetHashKey( "A_C_SharkTiger" ) ) ) do
		Citizen.Wait( 1 )
	end
	local pos = GetEntityCoords(PlayerPedId())
	
	local ped = CreatePed(29, 0x06C3F072, pos.x, pos.y, pos.z, 90.0, true, false)
	SetEntityHealth(ped, 0)
end)

RegisterNetEvent('vg_fishing:setbait')
AddEventHandler('vg_fishing:setbait', function(bool)
	bait = bool
end)

RegisterNetEvent('vg_fishing:fishstart')
AddEventHandler('vg_fishing:fishstart', function()	
	local playerPed = PlayerPedId()
	local pos = GetEntityCoords(playerPed)
	if IsPedInAnyVehicle(playerPed) then
		ESX.ShowAdvancedNotification("Fishing", "You can not fish from a vehicle", "fas fa-fish", "red")
	else
		if pos.y >= 3850 or pos.y <= -2000 or pos.x <= -1850 or pos.x >= 2150 then
			ESX.ShowAdvancedNotification("Fishing", "Fishing started", "fas fa-fish", "blue")
			TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_STAND_FISHING", 0, true)
			TriggerEvent('vg_fishing:playSound', "fishing_start")
			fishing = true
		else
			ESX.ShowAdvancedNotification("Fishing", "You need to go further away from the shore", "fas fa-fish", "red")
		end
	end
end, false)

RegisterNetEvent('vg_fishing:playSound')
AddEventHandler('vg_fishing:playSound', function(sound)
	local clientNetId = GetPlayerServerId(PlayerId())
	TriggerServerEvent("InteractSound_SV:PlayOnOne", clientNetId, sound, 0.5)
end)
