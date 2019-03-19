local voiceEnabled = true

local prox = 12.0
local proxString = "Talk"
local newbieString = "Hold ~b~N~s~ to Voice Chat - ~b~F9~s~ to Toggle Voice Distance "
local voipChanged = true
local displayingTempMarker = false

RegisterNetEvent("changeProximity")
AddEventHandler('changeProximity', function(vprox)
    if vprox == "whisper" then
        prox = 3.01
        voipChanged = true
    elseif vprox == "talk" then
        prox = 12.0
        voipChanged = true
    elseif vprox == "shout" then
        prox = 20.01
        voipChanged = true
    else
        TriggerClientEvent('chatMessage', "SYSTEM", { 255, 0, 0 }, "Invalid VOIP Proximity. Use: /voip <whisper, talk, yell>")
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if voipChanged then
            NetworkSetTalkerProximity(prox)
            NetworkClearVoiceChannel()
            NetworkSetVoiceActive(voiceEnabled)
            voipChanged = false
        end

        if IsControlJustPressed(1, 56) then -- F9
            if prox == 12.0 then
                prox = 20.01
            elseif prox == 20.01 then
                prox = 3.01
            elseif prox == 3.01 then
                prox = 12.0
            end
            newbieString = ""
            voipChanged = true
        end

        if NetworkIsPlayerTalking(PlayerId()) then
            if prox == 12.0 then
                proxString = "Talking"
            elseif prox == 3.01 then
                proxString = "Whispering"
            elseif prox == 20.01 then
                proxString = "Shouting"
            end
            newbieString = ""
        else
            if prox == 12.0 then
                proxString = "Talk"
            elseif prox == 3.01 then
                proxString = "Whisper"
            elseif prox == 20.01 then
                proxString = "Shout"
            end
        end

        drawLevel(185, 185, 185, 255)
    end
end)

Citizen.CreateThread(function()
    local voipTime = 1000
    while true do
        Citizen.Wait(voipTime)
        voipTime = 1000

        x1, y1, z1 = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
        for id = 0, 255 do
            if NetworkIsPlayerActive(id) and id ~= PlayerId() then
                local serverId = GetPlayerServerId(id)

                x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
                if IsEntityVisible(GetPlayerPed(id)) and not IsPedInAnyVehicle(GetPlayerPed(id)) then
                    if Vdist2(x1, y1, z1, x2, y2, z2) < 7 then
                        voipTime = 0
                        -- if NetworkIsPlayerTalking(id) and characterFriend then
                        --     DrawMarker(25, x2, y2, z2 - 0.95, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 10.3, 51, 178, 51, 105, 0, 0, 2, 0, 0, 0, 0)
                        if NetworkIsPlayerTalking(id) then
                            DrawMarker(25, x2, y2, z2 - 0.95, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 10.3, 55, 160, 205, 105, 0, 0, 2, 0, 0, 0, 0)
                        -- elseif characterFriend then
                        --     DrawMarker(25, x2, y2, z2 - 0.95, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 8, 178, 2, 50, 0, 0, 2, 0, 0, 0, 0)
                        else
                            DrawMarker(25, x2, y2, z2 - 0.95, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 0, 133, 178, 50, 0, 0, 2, 0, 0, 0, 0)
                        end
                    end
                end
            end
        end
    end
end)

function drawLevel(r, g, b, a)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextScale(0.5, 0.5)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")

    if NetworkIsPlayerTalking(PlayerId()) then
        AddTextComponentString(newbieString .. "~b~VOIP: " .. proxString)
    else
        AddTextComponentString(newbieString .. "~b~VOIP:~w~ " .. proxString)
    end

    DrawText(0.175, 0.89)
end
