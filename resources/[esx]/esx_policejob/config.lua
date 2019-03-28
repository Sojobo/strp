Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }

Config.EnablePlayerManagement     = false
Config.EnableArmoryManagement     = false
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableLicenses             = true -- enable if you're using esx_license

Config.EnableHandcuffTimer        = false -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society

Config.MaxInService               = -1
Config.Locale                     = 'en'

Config.PoliceStations = {

	LSPD = {

		Blip = {
			Coords  = vector3(425.1, -979.5, 30.7),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},

		Cloakrooms = {
			vector3(452.6, -992.8, 30.6)
		},

		Armories = {
			vector3(451.7, -980.1, 30.6)
		},

		Vehicles = {
			{
				Spawner = vector3(454.6, -1017.4, 28.4),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{ coords = vector3(438.4, -1018.3, 27.7), heading = 90.0, radius = 6.0 },
					{ coords = vector3(441.0, -1024.2, 28.3), heading = 90.0, radius = 6.0 },
					{ coords = vector3(453.5, -1022.2, 28.0), heading = 90.0, radius = 6.0 },
					{ coords = vector3(450.9, -1016.5, 28.1), heading = 90.0, radius = 6.0 }
				}
			},

			{
				Spawner = vector3(473.3, -1018.8, 28.0),
				InsideShop = vector3(228.5, -993.5, -99.0),
				SpawnPoints = {
					{ coords = vector3(475.9, -1021.6, 28.0), heading = 276.1, radius = 6.0 },
					{ coords = vector3(484.1, -1023.1, 27.5), heading = 302.5, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(461.1, -981.5, 43.6),
				InsideShop = vector3(477.0, -1106.4, 43.0),
				SpawnPoints = {
					{ coords = vector3(449.5, -981.2, 43.6), heading = 92.6, radius = 10.0 }
				}
			}
		},

		BossActions = {
			vector3(448.4, -973.2, 30.6)
		}

	}

}

Config.AuthorizedWeapons = {
	-- Recruit
    { minrank = 0, weapon = 'WEAPON_NIGHTSTICK', price = 0 },
    { minrank = 0, weapon = 'WEAPON_FLASHLIGHT', price = 0 },
    { minrank = 0, weapon = 'WEAPON_STUNGUN', price = 40 },
    { minrank = 0, weapon = 'WEAPON_PISTOL', components = { 50, 50, 400, 1600, nil }, price = 250 },

	-- Cadet
	
    -- Officer
	{ minrank = 2, weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil }, price = 3300 },
	
	-- Senior Officer
	-- Corporal

	-- Sergeant
	{ minrank = 5, weapon = 'WEAPON_ADVANCEDRIFLE', components = { 100, 6000, 1000, 4000, 8000, nil }, price = 5000 },

	-- Staff Sergeant
    -- Lieutenant
    -- Captain
    -- Chief of Police
}

Config.AuthorizedVehicles = {
	-- Recruit
	{ minrank = 0, model = 'policeb', label = 'Police Bike', price = 200 },
	
	-- Cadet 
	{ minrank = 1, model = 'police', label = 'Police Cruiser', price = 700 },

	-- Police Officer
	{ minrank = 2, model = 'police10', label = 'Police Crown Vic', price = 1500 },
	{ minrank = 2, model = 'police9', label = 'Police Taurus', price = 2400 },
	{ minrank = 2, model = 'policet', label = 'Police Transport Van', price = 1750 },

	-- Senior Officer
	{ minrank = 3, model = 'police8', label = 'Police Explorer', price = 3000 },

	-- Corporal
	{ minrank = 4, model = 'police3', label = 'Police Charger', price = 3000 },

	-- Sergeant
	{ minrank = 5, model = 'police2', label = 'Police Charger', price = 3000 },

	-- Staff Sergeant
	{ minrank = 6, model = 'police4', label = 'Police UC Explorer', price = 3000 },

	-- Lieutenant
	{ minrank = 7, model = '2015polstang', label = 'Police Mustang', price = 5500 },
	{ minrank = 7, model = 'police6', label = 'Police UC Taurus', price = 2000 },
	{ minrank = 7, model = 'police7', label = 'Police UC Crown Vic', price = 1500 },

	-- Captain
	{ minrank = 8, model = 'police5', label = 'Police UC Explorer', price = 4000 },

	-- Chief of Police
}

Config.AuthorizedHelicopters = {
	-- Recruit
	-- Cadet
	-- Officer
	-- Senior Officer
	-- Corporal

	-- Sergeant
	{ minrank = 5, model = 'polmav', label = 'Police Maverick', livery = 0, price = 16000 }

	-- Staff Sergeant
    -- Lieutenant
    -- Captain
    -- Chief of Police
}
