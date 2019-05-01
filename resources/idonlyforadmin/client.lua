local showPlayerBlips = false
local playerNamesDist = 15.0
local displayIDHeight = 1.2 --Height of ID above players head(starts at center body mass)
--Set Default Values for Colors
local red = 255
local green = 255
local blue = 255
local isAdmin = false


RegisterNetEvent('setgroup')
AddEventHandler('setgroup', function()
	isAdmin = true
end)	


function DrawText3D(x,y,z, text) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*1.3
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    
    if onScreen then
        SetTextScale(1*scale, 2*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(red, green, blue, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
		World3dToScreen2d(x,y,z, 0) --Added Here
        DrawText(_x,_y)
    end
end


Citizen.CreateThread(function()
	while true do
		-- Wait 5 seconds after player has loaded in and trigger the event.
		Citizen.Wait( 5000 )

		if NetworkIsSessionStarted() then
			TriggerServerEvent( "idonlyforadmin:checkadmin")
		end
	end
end )


Citizen.CreateThread(function ()
    local sleepTimer = 500
    while true do
        sleepTimer = 500
        if isAdmin == true then
            local myPed = GetPlayerPed(-1)
            local x1, y1, z1 = table.unpack(GetEntityCoords(myPed, true))

            for id = 0, 255 do
                local targetped = GetPlayerPed(id)
                if targetped ~= 0 and targetped ~= myPed then
                    x2, y2, z2 = table.unpack(GetEntityCoords(targetped, true))
                    distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))

                    if (distance < playerNamesDist) then
                        sleepTimer = 0
                        DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id))
                    end
                end
            end
        end
        Citizen.Wait(sleepTimer)
    end
end)
