Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor                = { r = 0, g = 0, b = 0 }

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society
Config.Locale                     = 'en'

Config.LostMCStations = {
	LostMC = {

		Blip = {
			Coords  = vector3(425.1, -979.5, 30.7),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},

		Armories = {
			vector3(972.18, -99.14, 74.84)
		},

		Vehicles = {
			{
				Spawner = vector3(985.69, -138.71, 73.09),
				InsideShop = vector3(978.75, -143.69, 74.23),
				SpawnPoints = {
					{ coords = vector3(971.39, -114.84, 74.35), heading = 217.0, radius = 6.0 },
					{ coords = vector3(965.73, -120.20, 74.35), heading = 217.0, radius = 6.0 },
					{ coords = vector3(982.37, -113.10, 74.04), heading = 134.0, radius = 6.0 }
				}
			}
		},

	}
}

Config.WeaponDealer = {
	{ weapon = 'WEAPON_KNIFE', price = 50 },
	{ weapon = 'WEAPON_BAT', price = 50 },
	{ weapon = 'WEAPON_PISTOL', price = 1000 },
	{ weapon = 'WEAPON_SAWNOFFSHOTGUN', price = 9000 },
}

Config.VehicleList = {
	{ model = 'Zombiea',	label = 'Zombiea',	price = 7000 },
	{ model = 'Zombieb',	label = 'Zombieb',	price = 7000 },
	{ model = 'SlamVan2',	label = 'SlamVan2',	price = 7000 },
	{ model = 'gburrito',	label = 'gburrito',	price = 7000 },
}
