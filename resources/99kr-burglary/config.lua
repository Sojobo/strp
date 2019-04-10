Config                         = {}

Config.useQalleCameraSystem    = false       --( https://github.com/qalle-fivem/esx-qalle-camerasystem )
Config.chancePoliceNoti        = 40          -- the percent police get notified (only numbers like 30, 10, 40. You get it.)
Config.useBlip                 = true      -- if u want blip
Config.useInteractSound        = false       -- if you wanna use InteractSound (when u lockpick the door)
Config.cooldownTime            = 30        -- cooldown Time in minutes

Config.CheckTime               = true
Config.StartHour               = 0 -- 0 to 24 h
Config.EndHour                 = 23

Config.sellPoint = {x = 412.31, y = 314.11, z = 103.02, sprite = 267, color = 56, name = 'Pawn Shop'}

Config.burglaryPlaces = {
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
}

Config.burglaryInside = {
    --Tinsel Towers Apt 42 - $705---
	["ifruit X1"] = { x = -601.45, y = 45.85, z = 97.40, items = {'ifruit'}, names = {'junk'}, amount = math.random(0,1)},
	["Broken ifruit X10"] = { x = -601.45, y = 43.62, z = 97.40, items = {'junk'}, names = {'junk'}, amount = math.random(0,1)},
	["Bose Speaker"] = { x = -604.26, y = 40.90, z = 97.40, items = {'speaker'}, names = {'junk'}, amount = math.random(0,2)},
	["Broken Wires"] = { x = -608.47, y = 40.79, z = 97.40, items = {'junk'}, names = {'junk'}, amount = math.random(0,2)},
	["Smashed Mirror"] = { x = -598.58, y = 49.69, z = 97.03, items = {'junk'}, names = {'junk'}, amount = math.random(0,2)},
	["Twix"] = { x = -598.58, y = 47.81, z = 97.11, items = {'chocolate'}, names = {'junk'}, amount = math.random(0,3)},
	--bedroom
	["9ct Diamond Ring"] = { x = -593.20, y = 50.45, z = 96.50, items = {'diamondring'}, names = {'junk'}, amount = math.random(0,2)},
	["Dictionary"] = { x = -597.42, y = 52.15, z = 97.00, items = {'book'}, names = {'junk'}, amount = math.random(0,4)},
	["HSBC Credit"] = { x = -593.20, y = 47.00, z = 96.50, items = {'creditcard'}, names = {'junk'}, amount = math.random(0,2)},
	["High Heels"] = { x = -595.95, y = 56.13, z = 97.0, items = {'junk'}, names = {'junk'}, amount = math.random(0,2)},
	--office
	["Dell Laptop"] = { x = -625.50, y = 50.14, z = 97.50, items = {'laptop'}, names = {'junk'}, amount = math.random(0,1)},
	--bathroom
	["Colgate"] = { x = -589.89, y = 52.70, z = 97.00, items = {'toothpaste'}, names = {'junk'}, amount = math.random(0,5)},
	 
	 
	--apt-hill-crest1 - $606(has lotto)---
	["ifruit X"] = { x = -672.68, y = 581.6, z = 144.97, items = {'ifruit'}, names = {'junk'}, amount = math.random(0,1)},
	["Wooden Spoon"] = { x = -674.76, y = 584.88, z = 145.00, items = {'junk'}, names = {'junk'}, amount = math.random(0,5)},
	["Broken Skybox"] = { x = -664.40, y = 585.27, z = 144.30, items = {'junk'}, names = {'junk'}, amount = math.random(0,2)},
	 --kitchen
	["Lotto1"] = { x = -675.73, y = 595.65, z = 145.38, items = {'lotteryticket'}, names = {'junk'}, amount = math.random(0,5)},
	["Silver Spoon"] = { x = -674.09, y = 593.43, z = 145.38, items = {'junk'}, names = {'junk'}, amount = math.random(0,3)},
	["Bottle of Vodka"] = { x = -673.00, y = 595.06, z = 145.38, items = {'alcohol'}, names = {'junk'}, amount = math.random(0,2)},
	--bedroom
	["Asda Speaker"] = { x = -672.00, y = 581.21, z = 141.57, items = {'speaker'}, names = {'junk'}, amount = math.random(0,3)},
	["Natwest Credit"] = { x = -664.45, y = 584.89, z = 141.40, items = {'creditcard'}, names = {'junk'}, amount = math.random(0,1)},
	["Ripped Shirt"] = { x = -672.00, y = 587.6, z = 141.57, items = {'junk'}, names = {'junk'}, amount = math.random(0,1)},
	--bathroom
	["18ct Diamond Ring"] = { x = -674.27, y = 595.29, z = 141.50, items = {'diamondring'}, names = {'junk'}, amount = math.random(0,2)},
	["Hairspray"] = { x = -673.40, y = 595.80, z = 141.50, items = {'junk'}, names = {'junk'}, amount = math.random(0,1)},
	--downstairs
	["1930's Coin"] = { x = -682.05, y = 596.33, z = 137.88, items = {'oldcoin'}, names = {'junk'}, amount = math.random(0,2)},
	
	
	--apt-hill-crest2 - $625---
	["ifruit X2"] = { x = -768.24, y = 615.00, z = 143.33, items = {'ifruit', 'junk', 'omega'}, names = {'ifruit', 'junk', 'omega'}, amount = math.random(0,1)},
	["Broken Spoon"] = { x = -758.26, y = 611.59, z = 144.00, items = {'junk'}, names = {'junk'}, amount = math.random(0,5)},
	["Omega Seamaster"] = { x = -768.05, y = 608.07, z = 143.93, items = {'omega'}, names = {'junk'}, amount = math.random(0,1)},
	["Treasure Map"] = { x = -773.13, y = 613.82, z = 143.73, items = {'treasuremap'}, names = {'junk'}, amount = math.random(0,3)},
	["Sojo Beans"] = { x = -759.46, y = 609.63, z = 144.14, items = {'sojobeans'}, names = {'junk'}, amount = math.random(0,1)},
	["Ketchup"] = { x = -761.59, y = 613.22, z = 144.14, items = {'junk'}, names = {'junk'}, amount = math.random(0,1)},
	--downstairs
	["Book of Ree"] = { x = -755.02, y = 617.38, z = 136.88, items = {'book'}, names = {'junk'}, amount = math.random(0,1)},
	["Cracked Ornament"] = { x = -760.85, y = 619.01, z = 136.52, items = {'junk'}, names = {'junk'}, amount = math.random(0,1)},
	["Broken Mouse"] = { x = -763.41, y = 613.43, z = 136.53, items = {'junk'}, names = {'junk'}, amount = math.random(0,1)},
	["Smashed Tablet"] = { x = -760.74, y = 614.33, z = 136.53, items = {'junk'}, names = {'junk'}, amount = math.random(0,1)},
	
	
	--apt-hill-crest3 - $631---
	["Rusty Spoon"] = { x = -859.50, y = 675.05, z = 152.45, items = {'junk'}, names = {'junk'}, amount = math.random(0,5)},
	["Mars Bar"] = { x = -856.12, y = 686.08, z = 152.88, items = {'chocolate'}, names = {'junk'}, amount = math.random(0,5)},
	["Rare 1832's Coins"] = { x = -852.16, y = 687.18, z = 152.88, items = {'rarecoin'}, names = {'junk'}, amount = math.random(0,1)},
	["Bluray 100"] = { x = -851.18, y = 674.83, z = 152.45, items = {'blurayplayer'}, names = {'junk'}, amount = math.random(0,1)},
	--downstairs
	["Panther Ornament"] = { x = -860.95, y = 693.26, z = 149.45, items = {'rareornament'}, names = {'junk'}, amount = math.random(0,1)},
	["Breath Fresh"] = { x = -853.52, y = 687.72, z = 149.07, items = {'toothpaste'}, names = {'junk'}, amount = math.random(0,3)},
	["9ct Ring"] = { x = -852.08, y = 687.72, z = 149.07, items = {'ring'}, names = {'junk'}, amount = math.random(0,1)},
	["Omega MemeMaster"] = { x = -854.72, y = 680.32, z = 149.05, items = {'omega'}, names = {'junk'}, amount = math.random(0,1)},
	["Pot Ornament"] = { x = -859.2, y = 695.81, z = 145.24, items = {'rareornament'}, names = {'junk'}, amount = math.random(0,1)},
	["Proto GPS"] = { x = -856.1, y = 699.15, z = 145.25, items = {'gpspill'}, names = {'junk'}, amount = math.random(0,2)},
	["Socks"] = { x = -859.53, y = 675.24, z = 148.85, items = {'junk'}, names = {'junk'}, amount = math.random(0,2)},
	["Broken Watch"] = { x = -851.13, y = 677.22, z = 148.85, items = {'junk'}, names = {'junk'}, amount = math.random(0,2)},
	
	--corkers-ave - $ 369 (near pawnshop)---
	["ifruit Tab"] = { x = 368.80, y = 408.21, z = 145.5, items = {'tablet'}, names = {'junk'}, amount = math.random(0,2)},
	["Bottle of Jack"] = { x = 368.80, y = 407.68, z = 145.5, items = {'alcohol'}, names = {'junk'}, amount = math.random(0,2)},
	["Book of Memes"] = { x = 373.31 , y = 426.03, z = 143.10, items = {'book'}, names = {'junk'}, amount = math.random(0,2)},
	["Bowl"] = { x = 377.75, y = 419.67, z = 145.9, items = {'junk'}, names = {'junk'}, amount = math.random(0,3)},
	--downstairs
	["SteelSeries Headphones"] = { x = 373.35, y = 433.39, z = 138.30, items = {'gamingperipherals'}, names = {'junk'}, amount = math.random(0,1)},
	--bedroom
	["Pink Thing"] = { x = 376.69, y = 404.06, z = 141.75, items = {'dildo'}, names = {'junk'}, amount = math.random(0,1)},
	["Amber Leaf"] = { x = 373.62, y = 412.50, z = 142.10, items = {'tobacco'}, names = {'junk'}, amount = math.random(0,2)},
	["Lotto2"] = { x = 368.61, y = 406.54, z = 142.10, items = {'lotteryticket'}, names = {'junk'}, amount = math.random(0,3)},
	["Zevas Jar of Pickled Animals"] = { x = 369.11, y = 403.36, z = 141.50, items = {'pickledanimal'}, names = {'junk'}, amount = math.random(0,1)},
	["Diamond"] = { x = 377.57, y = 419.12, z = 141.40, items = {'diamond'}, names = {'junk'}, amount = math.random(0,1)},
	
	
	--apt-de-base(nesr PD) - $574---
	--bed
	["Rolex"] = { x = 262.95, y = -1004.51, z = -98.90, items = {'rolex'}, names = {'junk'}, amount = math.random(0,1)},
	--main room
	["Leather Wallet"] = { x = 266.10, y = -999.4, z = -99.01, items = {'wallet'}, names = {'junk'}, amount = math.random(0,1)},
	["Fake Passport"] = { x = 260.19, y = -997.11, z = -97.30, items = {'passport'}, names = {'junk'}, amount = math.random(0,2)},
	["Mouldy Spoon"] = { x = 266.11, y = -996.59, z = -99.01, items = {'junk'}, names = {'junk'}, amount = math.random(0,2)},
	["18ct Ring"] = { x = 256.90, y = -1001.49, z = -99.01, items = {'ring'}, names = {'junk'}, amount = math.random(0,1)},
	["FHM"] = { x = 260.42, y = -994.87, z = -99.50, items = {'magazine'}, names = {'junk'}, amount = math.random(0,3)},
	["Packet of RAWS"] = { x = 262.53, y = -1000.27, z = -99.30, items = {'bread'}, names = {'bread'}, amount = math.random(0,2)},
	["Picture Frame"] = { x = 256.00, y = -997.07, z = -98.41, items = {'junk'}, names = {'junk'}, amount = math.random(0,3)},
	["Ripped Clothes"] = { x = 260.68, y = -1004.6, z = -99.01, items = {'junk'}, names = {'junk'}, amount = math.random(0,2)},
	["Xbox One"] = { x = 263.03, y = -1002.47, z = -99.00, items = {'junk'}, names = {'junk'}, amount = math.random(0,2)},
	
	--integirty-way - $530---
	["Wires"] = { x = -19.80, y = -579.81, z = 79.24, items = {'junk'}, names = {'junk'}, amount = math.random(0,1)},
	["Rokkit 6"] = { x = -24.06, y = -578.50, z = 79.23, items = {'speaker'}, names = {'junk'}, amount = math.random(0,1)},
	--bedroom
	["9c Ring"] = { x = -37.40, y = -583.82, z = 78.55, items = {'ring'}, names = {'junk'}, amount = math.random(0,2)},
	["Packet of Tissues"] = { x = -37.40, y = -583.82, z = 78.55, items = {'junk'}, names = {'junk'}, amount = math.random(0,2)},
	--ward
	["Rolex Submariner"] = { x = -36.87, y = -588.90, z = 78.83, items = {'rolex'}, names = {'junk'}, amount = math.random(0,1)},
	--bathroom
	["Showercap"] = { x = -40.57, y = -582.22, z = 78.0, items = {'junk'}, names = {'junk'}, amount = math.random(0,3)},
	["22ct Diamond Ring"] = { x = -41.40, y = -584.80, z = 78.65, items = {'junk'}, names = {'junk'}, amount = math.random(0,2)},
	["Remote"] = { x = -31.76, y = -583.29, z = 78.87, items = {'junk'}, names = {'junk'}, amount = math.random(0,2)},
	["PS4"] = { x = -22.69, y = -579.47, z = 78.80, items = {'console'}, names = {'junk'}, amount = math.random(0,1)},
	["Olive Oil"] = { x = -10.50, y = -584.59, z = 79.6, items = {'junk'}, names = {'junk'}, amount = math.random(0,3)},
	["Spices"] = { x = -13.01, y = -589.67, z = 79.43, items = {'junk'}, names = {'junk'}, amount = math.random(0,2)},
	["Folder of Memes"] = { x = -7.20, y = -594.15, z = 79.43, items = {'junk'}, names = {'junk'}, amount = math.random(0,3)},
}

Config.closets = {
    ["Robban's Closet"] = { x = 351.24, y = -993.53, z = -99.2, items = {'shirt', 'pants', 'hat', 'shoes'}, shirtAmount = math.random(1,3), pantsAmount = math.random(1,3), hatAmount = math.random(1,2), shoesAmount = math.random(1,2)},
}
