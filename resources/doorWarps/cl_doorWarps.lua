local entrance = {
	['sandyshore_policedept'] = { x = 1848.523, y = 3690.336, z = 34.267, emergencyOnly = true },

	['mirrorpark_twentyfourseven'] = { x = 1160.910, y = -313.114, z = 69.205, emergencyOnly = false },
	['tataviam_twentyfourseven'] = { x = 2546.418, y = 385.7, z = 108.618, emergencyOnly = false },
	['senorafwy_twentyfourseven'] = { x = 2670.877, y = 3286.291, z = 55.394, emergencyOnly = false },
	['sandyshores_twentyfoursever'] = { x = 1963.615, y = 3749.655, z = 32.261, emergencyOnly = false },
	['paleto_twentyfourseven'] = { x = 1741.426, y = 6419.536, z = 35.042, emergencyOnly = false },
	['rockford_ltdgas'] = { x = -1829.165, y = 800.98, z = 138.541, emergencyOnly = false },
	['harmony_twentyfourseven'] = { x = 550.319, y = 2656.534, z = 42.217, emergencyOnly = false },
	['grapeseed_twentyfourseven'] = { x = 1702.815, y = 4917.223, z = 42.224, emergencyOnly = false },

	['court_entranceleft'] = { x = 237.77, y = -413.056, z = 48.111, emergencyOnly = false },
	['court_courtroom'] = { x = 225.338, y = -419.716, z = -118.150, emergencyOnly = false },
	['court_defencehall'] = { x = 246.438, y = -337.090, z = -118.794, emergencyOnly = false },
	['court_judgeoffice'] = { x = 241.035, y = -304.235, z = -118.794, emergencyOnly = false },
}

local exit = {
	['sandyshore_policedept'] = { x = 1844.0, y = 3660.034, z = -116.789, emergencyOnly = false }, -- unrestrained prisoners may leave the area

	['mirrorpark_twentyfourseven'] = { x = 1160.905, y = -312.096, z = 69.280, emergencyOnly = false },
	['tataviam_twentyfourseven'] = { x = 2550.894, y = 388.075, z = 108.622, emergencyOnly = false },
	['senorafwy_twentyfourseven'] = { x = 2675.718, y = 3288.612, z = 55.241, emergencyOnly = false },
	['sandyshores_twentyfoursever'] = { x = 1962.85, y = 3749.05, z = 32.343, emergencyOnly = false },
	['paleto_twentyfourseven'] = { x = 1737.007, y = 6418.122, z = 35.037, emergencyOnly = false },
	['rockford_ltdgas'] = { x = -1828.391, y = 800.355, z = 138.161, emergencyOnly = false },
	['harmony_twentyfourseven'] = { x = 543.072, y = 2663.811, z = 42.156, emergencyOnly = false },
	['grapeseed_twentyfourseven'] = { x = 1707.509, y = 4918.786, z = 42.063, emergencyOnly = false },

	['court_entranceleft'] = { x = 236.101, y = -413.360, z = -118.150, emergencyOnly = false },
	['court_courtroom'] = { x = 238.794, y = -334.078, z = -118.760, emergencyOnly = false },
	['court_defencehall'] = { x = 248.171, y = -337.797, z = -118.794, emergencyOnly = false },
	['court_judgeoffice'] = { x = -1003.101, y = -477.870, z = 50.030, emergencyOnly = false },
}

Citizen.CreateThread(function()
    local isWarpingIn = false
    local isWarpingOut = false

    while true do
        Citizen.Wait(0)

        local ped = GetPlayerPed(-1)
        local playerPos = GetEntityCoords(ped, true)

	    for k, v in pairs(entrance) do
	        local distanceEntrance = Vdist(playerPos.x, playerPos.y, playerPos.z, entrance[k].x, entrance[k].y, entrance[k].z) 
	        local distanceExit = Vdist(playerPos.x, playerPos.y, playerPos.z, exit[k].x, exit[k].y, exit[k].z)

	        if distanceExit > 2.0 and isWarpingIn then
	            isWarpingIn = false
	        end

	        if distanceEntrance > 2.0 and isWarpingOut then
	            isWarpingOut = false
	        end

	        if distanceEntrance < 0.4 and not isWarpingOut then -- need to be on duty to get in
	            if not entrance[k].emergencyOnly or (entrance[k].emergencyOnly and (exports.police:getIsInService() or exports.emergency:getIsInService())) then
		            isWarpingIn = true
		            sendPedTo(ped, exit[k].x, exit[k].y, exit[k].z)
		            Citizen.Wait(2500)
	           	end
	        end

	        if distanceExit < 0.4 and not isWarpingIn then -- don't need to be on duty to get out
	            if not exit[k].emergencyOnly or (exit[k].emergencyOnly and (exports.police:getIsInService() or exports.emergency:getIsInService())) then
		            isWarpingOut = true
		            sendPedTo(ped, entrance[k].x, entrance[k].y, entrance[k].z)
		            Citizen.Wait(2500)
		        end
	        end
	    end

    end
end)

function sendPedTo(ped, x, y, z)
    RequestCollisionAtCoord(x, y, z)
    while not HasCollisionLoadedAroundEntity(ped) do
        RequestCollisionAtCoord(x, y, z)
        Citizen.Wait(0)
    end
    SetEntityCoords(ped, x, y, z, 1, 0, 0, 1)
end