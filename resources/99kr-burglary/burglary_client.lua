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
local chancePoliceNoti        = 40          -- the percent police get notified (only numbers like 30, 10, 40. You get it.)
local useBlip                 = true      -- if u want blip
local useInteractSound        = false       -- if you wanna use InteractSound (when u lockpick the door)
local cooldownTime            = 30        -- cooldown Time in minutes
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
    ["Tinsel Towers Apt 42"] = {
        pos = { x = -619.28, y = 37.95, z = 43.6, h = 357.03},  -- door coords
        locked = true,
        cooldown = 0,
        inside = { x = -610.48 , y = 58.95 , z = 98.2, h = 81.56 },  -- Inside coords
        animPos = { x = -619.28, y = 37.95, z = 43.6, h = 357.03 },   -- The animation position
    },

    ["apartment1-hillcrest-ave"] = {
        pos = { x = -686.12, y = 596.39, z = 143.64, h = 218.12},  -- door coords
        locked = true,
        cooldown = 0,
        inside = { x = -682.47, y = 592.81, z = 145.39, h = 81.56},  -- Inside coords
        animPos = { x = -685.64, y = 596.43, z = 143.50, h = 222.52},   -- The animation position
    },
	
	["apartment2-hillcrest-ave"] = {
        pos = { x = -753.46, y = 620.40, z = 142.85, h = 104.48},  -- door coords
        locked = true,
        cooldown = 0,
        inside = { x = -758.27, y = 619.08, z = 144.15, h = 106.67},  -- Inside coords
        animPos = { x = -753.46, y = 620.40, z = 142.85, h = 104.48},   -- The animation position
    },
	
	["apartment3-hillcrest-ave"] = {
        pos = { x = -852.98, y = 695.38, z = 148.79, h = 181.07},  -- door coords
        locked = true,
        cooldown = 0,
        inside = { x = -860.09, y = 691.44, z = 152.86, h = 182.15},  -- Inside coords
        animPos = { x = -852.54, y = 695.09, z = 148.99, h = 176.50},   -- The animation position
    },

	["north-conker-ave"] = {
        pos = { x = 374.12, y = 427.75, z = 145.80, h = 181.07},  -- door coords
        locked = true,
        cooldown = 0,
        inside = { x = 373.68, y = 423.90, z = 145.91, h = 168.94},  -- Inside coords
        animPos = { x = 373.84, y = 427.37, z = 145.48, h = 256.50},   -- The animation position
    },
	
	["nspt-de-base"] = {
        pos = { x = 291.31, y = -1078.61, z = 29.4, h = 91.78},  -- door coords
        locked = true,
        cooldown = 0,
        inside = { x = 265.97, y = -1007.39, z = -101.01, h = 355.99},  -- Inside coords
        animPos = { x = 291.78, y = -1078.61, z = 29.4, h = 91.55},   -- The animation position
    },
	
	["integrity-way"] = {
        pos = { x = -46.96, y = -584.67, z = 37.95, h = 249.16},  -- door coords
        locked = true,
        cooldown = 0,
        inside = { x = -24.37, y = -597.68, z = 80.03, h = 237.79},  -- Inside coords
        animPos = { x = -46.96, y = -584.67, z = 37.95, h = 249.16},   -- The animation position
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
    --Tinsel Towers Apt 42 - $705---
	["ifruit X1"] = { x = -601.45, y = 45.85, z = 97.40, item = 'ifruit', amount = math.random(0,1)},
	["Broken ifruit X10"] = { x = -601.45, y = 43.62, z = 97.40, item = 'junk', amount = math.random(0,1)},
	["Bose Speaker"] = { x = -604.26, y = 40.90, z = 97.40, item = 'speaker', amount = math.random(0,2)},
	["Broken Wires"] = { x = -608.47, y = 40.79, z = 97.40, item = 'junk', amount = math.random(0,2)},
	["Smashed Mirror"] = { x = -598.58, y = 49.69, z = 97.03, item = 'junk', amount = math.random(0,2)},
	["Twix"] = { x = -598.58, y = 47.81, z = 97.11, item = 'chocolate', amount = math.random(0,3)},
	--bedroom
	["9ct Diamond Ring"] = { x = -593.20, y = 50.45, z = 96.50, item = 'diamondring', amount = math.random(0,2)},
	["Dictionary"] = { x = -597.42, y = 52.15, z = 97.00, item = 'book', amount = math.random(0,4)},
	["HSBC Credit"] = { x = -593.20, y = 47.00, z = 96.50, item = 'creditcard', amount = math.random(0,2)},
	["High Heels"] = { x = -595.95, y = 56.13, z = 97.0, item = 'junk', amount = math.random(0,2)},
	--office
	["Dell Laptop"] = { x = -625.50, y = 50.14, z = 97.50, item = 'laptop', amount = math.random(0,1)},
	--bathroom
	["Colgate"] = { x = -589.89, y = 52.70, z = 97.00, item = 'toothpaste', amount = math.random(0,5)},
	 
	 
	--apt-hill-crest1 - $606(has lotto)---
	["ifruit X"] = { x = -672.68, y = 581.6, z = 144.97, item = 'ifruit', amount = math.random(0,1)},
	["Wooden Spoon"] = { x = -674.76, y = 584.88, z = 145.00, item = 'junk', amount = math.random(0,5)},
	["Broken Skybox"] = { x = -664.40, y = 585.27, z = 144.30, item = 'junk', amount = math.random(0,2)},
	 --kitchen
	["Lotto1"] = { x = -675.73, y = 595.65, z = 145.38, item = 'lotteryticket', amount = math.random(0,5)},
	["Silver Spoon"] = { x = -674.09, y = 593.43, z = 145.38, item = 'junk', amount = math.random(0,3)},
	["Bottle of Vodka"] = { x = -673.00, y = 595.06, z = 145.38, item = 'alcohol', amount = math.random(0,2)},
	--bedroom
	["Asda Speaker"] = { x = -672.00, y = 581.21, z = 141.57, item = 'speaker', amount = math.random(0,3)},
	["Natwest Credit"] = { x = -664.45, y = 584.89, z = 141.40, item = 'creditcard', amount = math.random(0,1)},
	["Ripped Shirt"] = { x = -672.00, y = 587.6, z = 141.57, item = 'junk', amount = math.random(0,1)},
	--bathroom
	["18ct Diamond Ring"] = { x = -674.27, y = 595.29, z = 141.50, item = 'diamondring', amount = math.random(0,2)},
	["Hairspray"] = { x = -673.40, y = 595.80, z = 141.50, item = 'junk', amount = math.random(0,1)},
	--downstairs
	["1930's Coin"] = { x = -682.05, y = 596.33, z = 137.88, item = 'oldcoin', amount = math.random(0,2)},
	
	
	--apt-hill-crest2 - $625---
	["ifruit X2"] = { x = -768.24, y = 615.00, z = 143.33, item = 'ifruit', amount = math.random(0,1)},
	["Broken Spoon"] = { x = -758.26, y = 611.59, z = 144.00, item = 'junk', amount = math.random(0,5)},
	["Omega Seamaster"] = { x = -768.05, y = 608.07, z = 143.93, item = 'omega', amount = math.random(0,1)},
	["Treasure Map"] = { x = -773.13, y = 613.82, z = 143.73, item = 'treasuremap', amount = math.random(0,3)},
	["Sojo Beans"] = { x = -759.46, y = 609.63, z = 144.14, item = 'sojobeans', amount = math.random(0,1)},
	["Ketchup"] = { x = -761.59, y = 613.22, z = 144.14, item = 'junk', amount = math.random(0,1)},
	--downstairs
	["Book of Ree"] = { x = -755.02, y = 617.38, z = 136.88, item = 'book', amount = math.random(0,1)},
	["Cracked Ornament"] = { x = -760.85, y = 619.01, z = 136.52, item = 'junk', amount = math.random(0,1)},
	["Broken Mouse"] = { x = -763.41, y = 613.43, z = 136.53, item = 'junk', amount = math.random(0,1)},
	["Smashed Tablet"] = { x = -760.74, y = 614.33, z = 136.53, item = 'junk', amount = math.random(0,1)},
	
	
	--apt-hill-crest3 - $631---
	["Rusty Spoon"] = { x = -859.50, y = 675.05, z = 152.45, item = 'junk', amount = math.random(0,5)},
	["Mars Bar"] = { x = -856.12, y = 686.08, z = 152.88, item = 'chocolate', amount = math.random(0,5)},
	["Rare 1832's Coins"] = { x = -852.16, y = 687.18, z = 152.88, item = 'rarecoin', amount = math.random(0,1)},
	["Bluray 100"] = { x = -851.18, y = 674.83, z = 152.45, item = 'blurayplayer', amount = math.random(0,1)},
	--downstairs
	["Panther Ornament"] = { x = -860.95, y = 693.26, z = 149.45, item = 'rareornament', amount = math.random(0,1)},
	["Breath Fresh"] = { x = -853.52, y = 687.72, z = 149.07, item = 'toothpaste', amount = math.random(0,3)},
	["9ct Ring"] = { x = -852.08, y = 687.72, z = 149.07, item = 'ring', amount = math.random(0,1)},
	["Omega MemeMaster"] = { x = -854.72, y = 680.32, z = 149.05, item = 'omega', amount = math.random(0,1)},
	["Pot Ornament"] = { x = -859.2, y = 695.81, z = 145.24, item = 'rareornament', amount = math.random(0,1)},
	["Proto GPS"] = { x = -856.1, y = 699.15, z = 145.25, item = 'gpspill', amount = math.random(0,2)},
	["Socks"] = { x = -859.53, y = 675.24, z = 148.85, item = 'junk', amount = math.random(0,2)},
	["Broken Watch"] = { x = -851.13, y = 677.22, z = 148.85, item = 'junk', amount = math.random(0,2)},
	
	--corkers-ave - $ 369 (near pawnshop)---
	["ifruit Tab"] = { x = 368.80, y = 408.21, z = 145.5, item = 'tablet', amount = math.random(0,2)},
	["Bottle of Jack"] = { x = 368.80, y = 407.68, z = 145.5, item = 'alcohol', amount = math.random(0,2)},
	["Book of Memes"] = { x = 373.31 , y = 426.03, z = 143.10, item = 'book', amount = math.random(0,2)},
	["Bowl"] = { x = 377.75, y = 419.67, z = 145.9, item = 'junk', amount = math.random(0,3)},
	--downstairs
	["SteelSeries Headphones"] = { x = 373.35, y = 433.39, z = 138.30, item = 'gamingperipherals', amount = math.random(0,1)},
	--bedroom
	["Pink Thing"] = { x = 376.69, y = 404.06, z = 141.75, item = 'dildo', amount = math.random(0,1)},
	["Amber Leaf"] = { x = 373.62, y = 412.50, z = 142.10, item = 'tobacco', amount = math.random(0,2)},
	["Lotto2"] = { x = 368.61, y = 406.54, z = 142.10, item = 'lotteryticket', amount = math.random(0,3)},
	["Zevas Jar of Pickled Animals"] = { x = 369.11, y = 403.36, z = 141.50, item = 'pickledanimal', amount = math.random(0,1)},
	["Diamond"] = { x = 377.57, y = 419.12, z = 141.40, item = 'diamond', amount = math.random(0,1)},
	
	
	--apt-de-base(nesr PD) - $574---
	--bed
	["Rolex"] = { x = 262.95, y = -1004.51, z = -98.90, item = 'rolex', amount = math.random(0,1)},
	--main room
	["Leather Wallet"] = { x = 266.10, y = -999.4, z = -99.01, item = 'wallet', amount = math.random(0,1)},
	["Fake Passport"] = { x = 260.19, y = -997.11, z = -97.30, item = 'passport', amount = math.random(0,2)},
	["Mouldy Spoon"] = { x = 266.11, y = -996.59, z = -99.01, item = 'junk', amount = math.random(0,2)},
	["18ct Ring"] = { x = 256.90, y = -1001.49, z = -99.01, item = 'ring', amount = math.random(0,1)},
	["FHM"] = { x = 260.42, y = -994.87, z = -99.50, item = 'magazine', amount = math.random(0,3)},
	["Packet of RAWS"] = { x = 262.53, y = -1000.27, z = -99.30, item = 'junk', amount = math.random(0,2)},
	["Picture Frame"] = { x = 256.00, y = -997.07, z = -98.41, item = 'junk', amount = math.random(0,3)},
	["Ripped Clothes"] = { x = 260.68, y = -1004.6, z = -99.01, item = 'junk', amount = math.random(0,2)},
	["Xbox One"] = { x = 263.03, y = -1002.47, z = -99.00, item = 'junk', amount = math.random(0,2)},
	
	--integirty-way - $530---
	["Wires"] = { x = -19.80, y = -579.81, z = 79.24, item = 'junk', amount = math.random(0,1)},
	["Rokkit 6"] = { x = -24.06, y = -578.50, z = 79.23, item = 'speaker', amount = math.random(0,1)},
	--bedroom
	["9c Ring"] = { x = -37.40, y = -583.82, z = 78.55, item = 'ring', amount = math.random(0,2)},
	["Packet of Tissues"] = { x = -37.40, y = -583.82, z = 78.55, item = 'junk', amount = math.random(0,2)},
	--ward
	["Rolex Submariner"] = { x = -36.87, y = -588.90, z = 78.83, item = 'rolex', amount = math.random(0,1)},
	--bathroom
	["Showercap"] = { x = -40.57, y = -582.22, z = 78.0, item = 'junk', amount = math.random(0,3)},
	["22ct Diamond Ring"] = { x = -41.40, y = -584.80, z = 78.65, item = 'junk', amount = math.random(0,2)},
	["Remote"] = { x = -31.76, y = -583.29, z = 78.87, item = 'junk', amount = math.random(0,2)},
	["PS4"] = { x = -22.69, y = -579.47, z = 78.80, item = 'console', amount = math.random(0,1)},
	["Olive Oil"] = { x = -10.50, y = -584.59, z = 79.6, item = 'junk', amount = math.random(0,3)},
	["Spices"] = { x = -13.01, y = -589.67, z = 79.43, item = 'junk', amount = math.random(0,2)},
	["Folder of Memes"] = { x = -7.20, y = -594.15, z = 79.43, item = 'junk', amount = math.random(0,3)},
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
          local random = math.random(0, 100)
          if random <= chancePoliceNoti then -- chance police get notified
            local playerPed = PlayerPedId()
	        local coords = GetEntityCoords(playerPed)
            local notification = {
                subject  = 'Burglary in Progress',
                msg      = "Reports of a burglary in progress",
                icon = 'fas fa-headset',
                iconStyle = 'red',
                locationX = coords.x,
                locationY = coords.y,
                caller = PlayerId(),
            }

            TriggerServerEvent('esx_service:callAllInService', notification, "police")
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

    local amnt = 1
    if values.amount >= 2 then
        local amnt = math.random(1,2)
    end

    TriggerServerEvent('99kr-burglary:Add', values.item, amnt, k)
    values.amount = values.amount - amnt

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

function AddBlip(x, y, z, sprite, color)
	local blip = AddBlipForCoord(x, y, z)
    SetBlipSprite (blip, sprite)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.8)
    SetBlipColour (blip, color)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Burglary')
    EndTextCommandSetBlipName(blip)
end

if useBlip then
  Citizen.CreateThread(function()
  	AddBlip(sellPoint.x, sellPoint.y, sellPoint.z, 267, 56)
    for k,v in pairs(burglaryPlaces) do
    	AddBlip(v.pos.x, v.pos.y, v.pos.z, 40, 39)
    end
  end)
end

RegisterNetEvent('99kr-burglary:Sound')
AddEventHandler('99kr-burglary:Sound', function(sound1, sound2)
    PlaySoundFrontend(-1, sound1, sound2)
end)