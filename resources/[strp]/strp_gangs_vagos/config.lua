Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor                = { r = 255, g = 255, b = 0 }

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society
Config.Locale                     = 'en'

Config.VagosStations = {
	Vagos = {

		Blip = {
			Coords  = vector3(425.1, -979.5, 30.7),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},

		Armories = {
			vector3(360.70, -2043.02, 22.35)
		},

		Vehicles = {
			{
				Spawner = vector3(337.85, -2036.55, 21.35),
				InsideShop = vector3(334.68, -2039.87, 21.09),
				SpawnPoints = {
					{ coords = vector3(326.81, -2040.75, 20.74), heading = 321.0, radius = 6.0 },
					{ coords = vector3(320.04, -2034.98, 20.61), heading = 321.0, radius = 6.0 },
					{ coords = vector3(310.58, -2027.49, 20.49), heading = 321.0, radius = 6.0 },
					{ coords = vector3(321.16, -2021.61, 20.81), heading = 140, radius = 6.0 },
					{ coords = vector3(325.73, -2025.58, 21.00), heading = 140, radius = 6.0 },
					{ coords = vector3(332.65, -2031.37, 21.21), heading = 140, radius = 6.0 }
				}
			}
		},

	}
}

Config.WeaponDealer = {
	{ weapon = 'WEAPON_KNIFE', price = 50 },
	{ weapon = 'WEAPON_BAT', price = 50 },
	{ weapon = 'WEAPON_PISTOL', price = 500 },
	{ weapon = 'WEAPON_SAWNOFFSHOTGUN', price = 9000 },
}

Config.VehicleList = {
	{ model = 'bmx', label = 'BMX',	price = 200 },
	{ model = 'peyote', label = 'Peyote',	price = 2000 },
	{ model = 'chino2',	label = 'Chino',	price = 3000 },
	{ model = 'baller',	label = 'Baller',	price = 5000 },
	{ model = 'buccaneer2',	label = 'Buccaneer',	price = 7000 },
	{ model = 'manana',	label = 'Manana',	price = 7000 },
}
