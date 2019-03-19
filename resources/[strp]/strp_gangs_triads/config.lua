Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor                = { r = 255, g = 0, b = 0 }

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society
Config.Locale                     = 'en'

Config.TriadStations = {
	Triads = {

		Blip = {
			Coords  = vector3(425.1, -979.5, 30.7),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},

		Armories = {
			vector3(-786.75, -911.74, 18.13)
		},

		Vehicles = {
			{
				Spawner = vector3(-766.30, -912.88, 18.07),
				InsideShop = vector3(-729.59, -914.91, 19.01),
				SpawnPoints = {
					{ coords = vector3(-761.24, -905.84, 19.76), heading = 264.0, radius = 6.0 },
					{ coords = vector3(-760.53, -900.21, 20.10), heading = 264.0, radius = 6.0 },
					{ coords = vector3(-759.47, -894.69, 20.44), heading = 264.0, radius = 6.0 },
					{ coords = vector3(-723.44, -913.09, 19.01), heading = 19.0, radius = 6.0 }
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
	{ model = 'Hakuchou', label = 'Hakuchou',	price = 4000 },
	{ model = 'Bison', label = 'Bison',	price = 4000 },
	{ model = 'Cavalcade',	label = 'Cavalcade',	price = 7000 },
	{ model = 'Washington',	label = 'Washington',	price = 7000 },
	{ model = 'Fugitive',	label = 'Fugitive',	price = 7000 }
}
