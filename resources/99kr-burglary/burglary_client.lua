local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

local DoingBreak			        = false       -- don't touch
local GUI                     = {}          -- don't touch
ESX                           = nil         -- don't touch
GUI.Time                      = 0           -- don't touch
local PlayerData              = {}          -- don't touch
local showPro                 = false       -- don't touch
local stealing                = false       -- don't touch
local peeking                 = false       -- don't touch
local LastHouse               = ''          -- don't touch
local robing                  = false       -- don't touch
local cooldown                = 0           -- don't touch
local MenuOpened              = false


------------------------------------------------------
------------------------------------------------------
local useQalleCameraSystem    = false       --( https://github.com/qalle-fivem/esx-qalle-camerasystem )
local chancePoliceNoti        = 60          -- the procent police get notified (only numbers like 30, 10, 40. You get it.)
local useBlip                 = true      -- if u want blip
local useInteractSound        = false       -- if you wanna use InteractSound (when u lockpick the door)
local cooldownTime            = 10        -- cooldown Time in minutes
------------------------------------------------------
------------------------------------------------------

------ l o c a l e s ------

local text = "~g~[E]~w~ Lockpick" -- lockpick the door
local textUnlock = "~g~[E]~w~ Enter" -- enter the house
local textCooldown = "~r~Cooldown " -- cooldown message
local insideText = "~g~[E]~w~ Exit" -- exit the door
local searchText = "~g~[E]~w~ Search" -- search the spot
local emptyMessage = "There is nothing here!" -- if you press E where it is empty
local emptyMessage3D = "~r~Empty" -- if the spot is empty
local closetText = "~g~[E]~w~ Peek into closet" -- text at closet

local lockpickQuestionText = "Do you want to lockpick?" -- confirmation menu title
local noLockpickText = "You don't have any lockpick!" -- if you don't have a lockpick and you try to do the burglary
local yesText = "Yes" -- in confirmation menu
local noText = "No" -- -- in confirmation menu

local shirt = "Shirt" -- in menu and notification
local pants = "Pants" -- -- in menu and notification
local hat = "Hat" -- -- in menu and notification
local shoes = "Shoes" -- -- in menu and notification

local youFound = "You found" -- when you steal something
local burglaryDetected = "A burglary has been detected at" -- text 1 cops gets sent
local sentPhoto = "We've sent you a photo of the criminal." -- if you use qalle's camerasystem this will be in the message too
---------------------------


local PlayerData              = {}

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1)
    end

    while ESX.GetPlayerData() == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
end) 

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

local sellPoint = {x = 412.31, y = 314.11, z = 103.02}

local burglaryPlaces = {
    ["apartment1"] = {
        pos = { x = -619.28, y = 37.95, z = 43.6, h = 357.03},  -- door coords
        locked = true,
        cooldown = 0,
        inside = { x = -610.48 , y = 58.95 , z = 98.2, h = 81.56 },  -- Inside coords
        animPos = { x = -619.28, y = 37.95, z = 43.6, h = 357.03 },   -- The animation position
    },

    ["apartment-hillcrest-ave"] = {
        pos = { x = -686.12, y = 596.39, z = 143.64, h = 218.12},  -- door coords
        locked = true,
        cooldown = 0,
        inside = { x = -682.47, y = 592.81, z = 145.39, h = 81.56},  -- Inside coords
        animPos = { x = -685.64, y = 596.43, z = 143.50, h = 222.52},   -- The animation position
    },

    -- example to add another location --
   --[[                                     change the 000.00's
      ["name"] = {
        pos = { x = 000.00, y = 000.00, z = 000.00, h = 000.00 },  -- door coords
        locked = true,
        inside = { x = 000.00, y = 000.00, z = 000.00, h = 000.00 },  -- Inside the house coords
        animPos = { x = 000.00, y = 000.00, z = 000.00, h = 000.00 },   -- The animation position
    },
  ]]
}

local burglaryInside = {
    --apartment1
	["iphone X"] = { x = -601.97, y = 45.93, z = 97.40, item = 'phone', amount = math.random(0,1)},
	["Bose Speaker"] = { x = -604.26, y = 40.90, z = 97.40, item = 'speaker', amount = math.random(0,3)},
	--bedroom
	["Samsung S10"] = { x = -593.20, y = 50.45, z = 96.50, item = 'phone', amount = math.random(0,1)},
	["Cannabis"] = { x = -597.42, y = 52.15, z = 97.00, item = 'cannabis', amount = math.random(0,4)},
	
	 --apartment-hill-crest
	["iphone Xs"] = { x = -672.68, y = 581.6, z = 144.97, item = 'phone', amount = math.random(0,1)},
	["Lottery Ticket"] = { x = -675.5, y = 595.45, z = 145.38, item = 'lotteryticket', amount = math.random(0,3)},
	["Aldi Speaker"] = { x = -672.00, y = 581.21, z = 141.57, item = 'speaker', amount = math.random(0,3)},
	
}

local closets = {
    ["Robban's Closet"] = { x = 351.24, y = -993.53, z = -99.2, items = {'shirt', 'pants', 'hat', 'shoes'}, shirtAmount = math.random(1,3), pantsAmount = math.random(1,3), hatAmount = math.random(1,2), shoesAmount = math.random(1,2)},
}

Citizen.CreateThread(function()
  while true do
    Wait(60000)
    for k,v in pairs(burglaryPlaces) do
      if v.cooldown ~= 0 then
        v.cooldown = v.cooldown - 1
        MenuOpened = false
      end
    end
  end
end) 

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(5)
    for k,v in pairs(burglaryPlaces) do
      local playerPed = PlayerPedId()
      local house = k
      local coords = GetEntityCoords(playerPed)
      local dist   = GetDistanceBetweenCoords(v.pos.x, v.pos.y, v.pos.z, coords.x, coords.y, coords.z, false)

      if GetDistanceBetweenCoords(sellPoint.x, sellPoint.y, sellPoint.z, coords.x, coords.y, coords.z, false) < 50.0 then
        DrawMarker(25, sellPoint.x, sellPoint.y, sellPoint.z - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.2, 1.2, 1.0, 255, 255, 255, 155, false, false, 2, false)
        if GetDistanceBetweenCoords(sellPoint.x, sellPoint.y, sellPoint.z, coords.x, coords.y, coords.z, false) < 1.0 then
          DrawText3D(sellPoint.x, sellPoint.y, sellPoint.z, "~g~[E]~w~ Sell Stuff", 0.4)
          if IsControlJustPressed(0, Keys["E"]) and not MenuOpened then
            SellItems()
          end
        end
      end

      if v.cooldown > 0 and dist <= 1.2 then
        DrawText3D(v.pos.x, v.pos.y, v.pos.z, textCooldown..v.cooldown.. " minutes", 0.4)
      elseif dist <= 30.0 and DoingBreak == false and v.cooldown == 0 then
        DrawMarker(25, v.pos.x, v.pos.y, v.pos.z - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.2, 1.2, 1.0, 255, 255, 255, 155, false, false, 2, false)
        if dist <= 1.2 and DoingBreak == false then
          if v.locked then
            DrawText3D(v.pos.x, v.pos.y, v.pos.z, text, 0.4)                  
              if IsControlJustPressed(0, Keys["E"]) then
                confMenu(house)
          end
        else
          DrawText3D(v.pos.x, v.pos.y, v.pos.z, textUnlock, 0.4)                  
            if IsControlJustPressed(0, Keys["E"]) then
              fade()
              LastHouse = v
              robing = true
              SetCoords(playerPed, v.inside.x, v.inside.y, v.inside.z - 0.98)
              SetEntityHeading(playerPed, v.inside.h)
            end
          end
        end
      end
    end
  end
end)

Citizen.CreateThread(function()
    while stealing == false do
      Citizen.Wait(5)
      for k,v in pairs(burglaryInside) do
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local dist   = GetDistanceBetweenCoords(v.x, v.y, v.z, coords.x, coords.y, coords.z, false)
          if dist <= 1.2 and v.amount > 0 then
            DrawText3D(v.x, v.y, v.z, searchText, 0.4)
            if dist <= 0.5 and IsControlJustPressed(0, Keys["E"]) then
              steal(k)
            end
        elseif v.amount < 1 and dist <= 1.2 then
          DrawText3D(v.x, v.y, v.z, emptyMessage3D, 0.4)
          if IsControlJustPressed(0, Keys["E"]) and dist <= 0.5 then 
            ESX.ShowNotification(emptyMessage)
          end
        end
      end
    end
  end)

  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(5)
      for k,v in pairs(closets) do
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local dist   = GetDistanceBetweenCoords(v.x, v.y, v.z, coords.x, coords.y, coords.z, false)
          if dist <= 1.2 then
            if peeking == false then
            DrawText3D(v.x, v.y, v.z, closetText, 0.4)
            if dist <= 0.5 and IsControlJustPressed(0, Keys["E"]) then
              ClosetMenu(k)
            end
          end
        end
      end
    end
  end)

Citizen.CreateThread(function()
  while true do
    Wait(5)
    if robing then
      local playerPed = PlayerPedId()
      local coords = GetEntityCoords(playerPed)
      v = burglaryPlaces[LastHouse]
      if GetDistanceBetweenCoords(v.inside.x, v.inside.y, v.inside.z, coords.x, coords.y, coords.z, false) <= 70.0 then
        DrawMarker(25, v.inside.x, v.inside.y, v.inside.z - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.2, 1.2, 1.0, 255, 255, 255, 155, false, false, 2, false)
        if GetDistanceBetweenCoords(v.inside.x, v.inside.y, v.inside.z, coords.x, coords.y, coords.z, false) <= 3.0 then
          DrawText3D(v.inside.x, v.inside.y, v.inside.z, insideText, 0.4)
          if GetDistanceBetweenCoords(v.inside.x, v.inside.y, v.inside.z, coords.x, coords.y, coords.z, false) <= 1.2 and IsControlJustPressed(0, Keys["E"]) then
            fade()
            teleport(burglaryPlaces[LastHouse])
            v.cooldown = cooldownTime
            robing = false
            Wait(50)
            LastHouse = {}
          end
        end
      end 
    end
  end
end)

function ClosetMenu(house)
    Citizen.CreateThread(function()
    elements = {}
    for k,v in pairs(closets) do
      local playerPed = PlayerPedId()
        local house = k
        if v.hatAmount > 0 then 
            table.insert(elements, {label = hat .. ' <span style="color:#5db6e5;">(' .. v.hatAmount .. ')</span>', value = 'hat'})
        end
        if v.shirtAmount > 0 then
            table.insert(elements, {label = shirt .. ' <span style="color:#5db6e5;">(' .. v.shirtAmount .. ')</span>', value = 'shirt'})
        end
        if v.pantsAmount > 0 then
            table.insert(elements, {label = pants .. ' <span style="color:#5db6e5;">(' .. v.pantsAmount .. ')</span>', value = 'pants'})
        end
        if v.shoesAmount > 0 then
            table.insert(elements, {label = shoes .. ' <span style="color:#5db6e5;">(' .. v.shoesAmount .. ')</span>', value = 'shoes'})
        end

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'closet_menu',
        {
            title    = house,
            align    = 'center',
            elements = elements
        },
        function(data, menu)

            if data.current.value == 'shirt' then
                    peeking = true
                    menu.close()
                    stealClothes(house, data.current.value, v.shirtAmount, shirt)
                    v.shirtAmount = v.shirtAmount - v.shirtAmount
                    peeking = false
                  end
            if data.current.value == 'pants' then
                    peeking = true
                    menu.close()
                    stealClothes(house, data.current.value, v.pantsAmount, pants)
                    v.pantsAmount = v.pantsAmount - v.pantsAmount
                    peeking = false
                  end
            if data.current.value == 'hat' then
                    peeking = true
                    menu.close()
                    stealClothes(house, data.current.value, v.hatAmount, hat)
                    v.hatAmount = v.hatAmount - v.hatAmount
                    peeking = false
                  end
            if data.current.value == 'shoes' then
                    peeking = true
                    menu.close()
                    stealClothes(house, data.current.value, v.shoesAmount, shoes)
                    v.shoesAmount = v.shoesAmount - v.shoesAmount
                    peeking = false
                  end      
                end,
    function(data, menu)
        menu.close()
    end)
  end
end)
end

Citizen.CreateThread(function()
	while true do
    Citizen.Wait(6)
    if showPro == true then
      local playerPed = PlayerPedId()
		  local coords = GetEntityCoords(playerPed)
      DrawText3D(coords.x, coords.y, coords.z, TimeLeft .. '~g~%', 0.4)
    end
	end
end)

function SellItems()
  MenuOpened = true
  ESX.TriggerServerCallback('99kr-burglary:getPlayerInventory', function (inventory)
    local elements = {}

    for i=1, #inventory.items, 1 do
      local item = inventory.items[i]

      if item.count > 0 and inventory.price[item.name] ~= nil then
        table.insert(elements, {
          label = item.label .. ' x' .. item.count .. ' <span style="color:green">$'.. inventory.price[item.name].. '</span>',
          type = 'item_standard',
          value = item.name,
          price = inventory.price[item.name]
        })
      end
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu',
    {
      title    = "Inventory",
      align    = 'top-left',
      elements = elements
    }, function (data, menu)
      local itemName = data.current.value

      ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
        title = "Amout"
      }, function (data2, menu2)
        local count = tonumber(data2.value)

        if count == nil then
          ESX.ShowNotification("Invalid Quantity")
        else
          TriggerServerEvent('99kr-burglary:sellItems', itemName, count, data.current.price)
          menu2.close()
          menu.close()
          SellItems()
        end

      end, function (data2, menu2)
        menu2.close()
        MenuOpened = false
      end)

    end, function (data, menu)
      menu.close()
      MenuOpened = false
    end)
  end)
end

function confMenu(house)
  local v = GetHouseValues(house, burglaryPlaces)
  Citizen.CreateThread(function()
  ESX.UI.Menu.CloseAll()
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'conf_menu',
		{
			title = lockpickQuestionText,
			align = 'center',
			elements = {
        {label = yesText, value = 'yes'},
        {label = noText, value = 'no'}
			}
		},
		function(data, menu)
			menu.close()

      if data.current.value == 'yes' then 
        local inventory = ESX.GetPlayerData().inventory
        local LockpickAmount = nil
        for i=1, #inventory, 1 do                          
            if inventory[i].name == 'lockpick' then
                LockpickAmount = inventory[i].count
            end
        end
        if LockpickAmount > 0 then
          HouseBreak(house)
          v.locked = false
          LastHouse = house
          robing = true
          Citizen.Wait(math.random(15000,30000))
          print('snut')
          local random = math.random(0, 100)
            if useQalleCameraSystem == true then
              if random <= chancePoliceNoti then                           -- chance police get notified and they get a photo of you
                TriggerEvent('skinchanger:getSkin', function(skin)
                  TriggerServerEvent('esx-qalle-camerasystem:addWitness', skin, "Burglary")
                  TriggerServerEvent('esx_phone:send', 'police', burglaryDetected .. ' ' .. house .. '. ' .. sentPhoto, { x = v.pos.x, y = v.pos.y, z = v.pos.z })
                end)
              end
            end
              if useQalleCameraSystem == false then
                if random <= chancePoliceNoti then
                  TriggerServerEvent('esx_phone:send', 'police', burglaryDetected .. ' ' .. house, { x = v.pos.x, y = v.pos.y, z = v.pos.z })
               end
            end
        else 
          ESX.ShowNotification(noLockpickText)
      end

		elseif data.current.value == 'no' then 
			
	end
end
  )
end)
end

function steal(k)
    local values = GetHouseValues(k, burglaryInside)
    local playerPed = PlayerPedId()
    stealing = true
    FreezeEntityPosition(playerPed, true)
    TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
    Citizen.Wait(2000)
    procent(50)
    if values.amount >= 2 then
      local rndm = math.random(1,2)
      TriggerServerEvent('99kr-burglary:Add', values.item, rndm)
        ESX.ShowNotification( youFound .. ' ' .. rndm  .. ' ' .. k)
        values.amount = values.amount - rndm
    else
      TriggerServerEvent('99kr-burglary:Add', values.item, 1)
        ESX.ShowNotification(youFound .. ' 1 ' .. k)
        values.amount = values.amount - 1
    end
    ClearPedTasks(playerPed)
    FreezeEntityPosition(playerPed, false)
    stealing = false
end

function stealClothes(house, garment, amount, garmentLabel)
  local playerPed = PlayerPedId()
  local values = GetHouseValues(house, closets)
    FreezeEntityPosition(playerPed, true)
    TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
    Citizen.Wait(2000)
    procent(50)
    TriggerServerEvent('99kr-burglary:Add', garment, amount)
    ClearPedTasks(playerPed)
    FreezeEntityPosition(playerPed, false)
    ESX.ShowNotification( youFound .. ' ' .. amount .. ' ' .. garmentLabel, "error")
end


function HouseBreak(house)
  local v = GetHouseValues(house, burglaryPlaces)
  local playerPed = PlayerPedId()
  fade()
    DoingBreak = true
    FreezeEntityPosition(playerPed, true)
    SetEntityCoords(playerPed, v.animPos.x, v.animPos.y, v.animPos.z - 0.98)
    SetEntityHeading(playerPed, v.animPos.h)
    loaddict("mini@safe_cracking")
    TaskPlayAnim(playerPed, "mini@safe_cracking", "idle_base", 3.5, -8, -1, 2, 0, 0, 0, 0, 0)
    if useInteractSound then
    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'lockpick', 0.7)
    end
    procent(70)
    TriggerServerEvent('99kr-burglary:Remove', 'lockpick', 1)
    --LastHouse = v
    --robing = true
    fade()
    ClearPedTasks(playerPed)
    FreezeEntityPosition(playerPed, false)
    SetCoords(playerPed, v.inside.x, v.inside.y, v.inside.z - 0.98)
    SetEntityHeading(playerPed, v.inside.h)
end


function SetCoords(playerPed, x, y, z)
  SetEntityCoords(playerPed, x, y, z)
  Citizen.Wait(100)
  SetEntityCoords(playerPed, x, y, z)
end

function fade()
  DoScreenFadeOut(1000)
  Citizen.Wait(1000)
  DoScreenFadeIn(1000)
end

function loaddict(dict)
  while not HasAnimDictLoaded(dict) do
    RequestAnimDict(dict)
    Wait(10)
  end
end
  
function DrawText3D(x, y, z, text, scale)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

  SetTextScale(scale, scale)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextEntry("STRING")
  SetTextCentre(1)
  SetTextColour(255, 255, 255, 255)
  SetTextOutline()

  AddTextComponentString(text)
  DrawText(_x, _y)

  local factor = (string.len(text)) / 270
  DrawRect(_x, _y + 0.015, 0.005 + factor, 0.03, 31, 31, 31, 155)
end

function procent(time)
  showPro = true
  TimeLeft = 0
  repeat
  TimeLeft = TimeLeft + 1        -- thank you (github.com/Loffes)
  Citizen.Wait(time)
  until(TimeLeft == 100)
  showPro = false
end

function teleport(house)
  local values = house
  local playerPed = PlayerPedId()
  SetCoords(playerPed, values.pos.x, values.pos.y, values.pos.z - 0.98)
  SetEntityHeading(playerPed, values.pos.h)
  DoingBreak = false
  values.locked = true
end

function GetHouseValues(house, pair)
    for k,v in pairs(pair) do
        if k == house then
            return v
        end
    end
end

if useBlip then
  Citizen.CreateThread(function()
    for k,v in pairs(burglaryPlaces) do
    local blip = AddBlipForCoord(v.pos.x, v.pos.y, v.pos.z)
    SetBlipSprite (blip, 40)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.8)
    SetBlipColour (blip, 39)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Burglary')
    EndTextCommandSetBlipName(blip)
    end
  end)
end
	 
RegisterNetEvent('99kr-burglary:Sound')
AddEventHandler('99kr-burglary:Sound', function(sound1, sound2)
  PlaySoundFrontend(-1, sound1, sound2)
end)