Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society
Config.Locale                     = 'en'

Config.GangBases = {
    lostmc = {
        AIgroup = "AMBIENT_GANG_LOST",
        color1 = 1,
        color2 = 1,
        MarkerColor = { r = 0, g = 0, b = 0 },

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

        VehicleList = {
            { model = 'Zombiea',	label = 'Zombiea',	price = 3000 },
            { model = 'Zombieb',	label = 'Zombieb',	price = 3000 },
            { model = 'SlamVan2',	label = 'SlamVan2',	price = 7000 },
            { model = 'gburrito',	label = 'gburrito',	price = 7000 },
        },
	},

    rednecks = {
        AIgroup = "AMBIENT_GANG_CULT",
        color1 = 12,
        color2 = 12,
        MarkerColor = { r = 78, g = 105, b = 176 },

		Armories = {
			vector3(2448.61, 4980.56, 46.81)
		},

		Vehicles = {
			{
				Spawner = vector3(2484.82, 4953.03, 44.84),
				InsideShop = vector3(2481.05, 4953.57, 45.01),
				SpawnPoints = {
					{ coords = vector3(2509.14, 4963.59, 44.71), heading = 5.0, radius = 6.0 },
					{ coords = vector3(2522.66, 4969.82, 44.53), heading = 95.0, radius = 6.0 },
					{ coords = vector3(2498.60, 4983.63, 44.50), heading = 213.0, radius = 6.0 }
				}
			}
		},

        VehicleList = {
            { model = 'Sanchez',	label = 'Sanchez',	price = 3000 },
            { model = 'bfinjection',	label = 'BF Injection',	price = 7000 },
            { model = 'bifta',	label = 'Bifta',	price = 8000 },
            { model = 'Rebel',	label = 'Rebel',	price = 18000 },
        },
	},

	triads = {
        AIgroup = "AMBIENT_GANG_WEICHENG",
        color1 = 1,
        color2 = 29,
        MarkerColor = { r = 255, g = 0, b = 0 },

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

        VehicleList = {
            { model = 'Hakuchou', label = 'Hakuchou',	price = 2000 },
            { model = 'Bison', label = 'Bison',	price = 3000 },
            { model = 'Cavalcade',	label = 'Cavalcade',	price = 5000 },
            { model = 'Washington',	label = 'Washington',	price = 3000 },
            { model = 'Fugitive',	label = 'Fugitive',	price = 7000 }
        },
	},

	vagos = {
        AIgroup = "AMBIENT_GANG_MEXICAN",
        color1 = 89,
        color2 = 1,
        MarkerColor = { r = 255, g = 255, b = 0 },

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

        VehicleList = {
            { model = 'bmx', label = 'BMX',	price = 200 },
            { model = 'peyote', label = 'Peyote',	price = 2000 },
            { model = 'chino2',	label = 'Chino',	price = 3000 },
            { model = 'baller',	label = 'Baller',	price = 5000 },
            { model = 'buccaneer2',	label = 'Buccaneer',	price = 7000 },
            { model = 'manana',	label = 'Manana',	price = 7000 },
        },
	},
}

Config.WeaponDealer = {
	{ weapon = 'WEAPON_KNIFE', price = 50 },
	{ weapon = 'WEAPON_BAT', price = 50 },
	{ weapon = 'WEAPON_PISTOL', price = 500 },
	{ weapon = 'WEAPON_SAWNOFFSHOTGUN', price = 9000 },
}
