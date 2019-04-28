DrawText3D = function(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
  
	local scale = 0.40
   
	if onScreen then
		SetTextScale(scale, scale)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextEntry("STRING")
		SetTextCentre(1)
		SetTextColour(255, 255, 255, 255)
		SetTextOutline()

		AddTextComponentString(text)
		DrawText(_x, _y)
        local factor = (string.len(text)) / 350
        DrawRect(_x, _y + 0.0150, 0.030 + factor , 0.030, 66, 66, 66, 150)
	end
end

OpenBin = function(entity)
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
    Citizen.Wait(10000)
    cachedBins[entity] = true
    TriggerServerEvent('esx-sopletare:getItem')
    ClearPedTasksImmediately(PlayerPedId())
end