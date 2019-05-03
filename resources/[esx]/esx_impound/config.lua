Config = {}

Config = {
	DrawDistance = 100,
	BlipInfos = {
		Sprite = 477,
		Color = 54
	}
}

-- Set to true if you are using a "plate" column on your owned_vehicles table (such as when using esx_migrate)
Config.OwnedVehiclesHasPlateColumn = true

-- Determines if the ability to impound vehicles is based upon esx jobs
Config.RestrictImpoundToJobs = true

-- The jobs that are able to impound vehicles
Config.JobsThatCanImpound = {'police', 'tow'}

-- Determines if the ability to retrieve vehicles is based upon esx jobs
Config.RestrictRetrievalToJobs = false

-- The jobs that are able to retrieve vehicles
Config.RetrievalJobs = {'unemployed'}

-- Is the user required to wait a period of time before they can get their vehicle back
Config.UserMustWaitElapsedTime = true

-- Is the user required to pay a fine before they get their vehicle back
Config.UserMustPayFine = true

-- The amount of the fine the user must pay
Config.ImpoundFineAmount = 500


-- The time in minutes before a user is able to retrieve a vehicle from the
-- impound lot.
Config.ElapsedTimeBeforeRelease = 0


Config.ImpoundLots = {
	lot = {
		Pos = {x=402.31, y= -1631.62, z= 28.50},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = -1,
		
		DropoffPoint = {
			Pos = {x=402.31, y= -1631.62, z= 28.50},
			Color = {r=58,g=100,b=122},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Marker = 27
		},
		RetrievePoint = {
			Pos = {x=408.04, y= -1638.57, z= 28.50},
			Color = {r=0,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Marker = -1
		},
	}
}
