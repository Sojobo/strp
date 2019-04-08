ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('playerDropped', function()
    local _source = source
    TriggerClientEvent('strp_racing:end_race_cl', _source)
end)

local readyPlayers = {}
local online_race_leaderboard = {}
local online_race_in_progress = {}
local readyRaces = {}

RegisterServerEvent('strp_racing:online_race_update')
AddEventHandler('strp_racing:online_race_update', function(race, player, position)
    for i=1, #online_race_leaderboard do
        if online_race_leaderboard[i].R == race then
            if online_race_leaderboard[i][race].p == player then
                TriggerClientEvent('strp_racing:print', source, online_race_leaderboard[i][race].checkpoints)
                online_race_leaderboard[i][race].checkpoints = position
            end
        end
    end
end)

RegisterServerEvent('strp_racing:end_online_race')
AddEventHandler('strp_racing:end_online_race', function(race, checkpoint)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if checkpoint == Config.OnlineRace[race].NumberOfZones then
        local prizeAmount = readyRaces[race].P * 175
        TriggerClientEvent('esx:showAdvancedNotification', _source, "Street Race", "You won $" .. prizeAmount .. " for first place, congratulations!", 'fas fa-trophy', "green")
        xPlayer.addMoney(prizeAmount)
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, "Street Race", "The race is over, you lost!", 'fas fa-car', "red")
    end

    for i=1, #online_race_in_progress do
        if online_race_in_progress[i].R == race then
            online_race_in_progress[i].R = false
        end
    end
    for i=1, #online_race_leaderboard do
        if online_race_leaderboard[i].R == race then
            online_race_leaderboard[i].R = false
        end
    end
end)

RegisterServerEvent('strp_racing:get_online_race_position')
AddEventHandler('strp_racing:get_online_race_position', function(race)
    local _source = source

    for i=1, readyRaces[race].P do
        for x=1, #online_race_leaderboard do
            if online_race_leaderboard[x].R == race then
                TriggerClientEvent('strp_racing:get_online_race_position_client', _source, race, online_race_leaderboard[x][race].checkpoints, online_race_leaderboard[x][race].p)
            end
        end
    end
end)

RegisterServerEvent('strp_racing:ready_online_race')
AddEventHandler('strp_racing:ready_online_race', function(race)
    local _source = source
    local can_start = true
    for i=1, #online_race_in_progress do
        if online_race_in_progress[i].R == race then
            can_start = false
        end
    end
    if can_start then
        local xPlayer = ESX.GetPlayerFromId(_source)
        if xPlayer.getMoney() < 200 then
            TriggerClientEvent('esx:showNotification', _source, "You don't have the $200 signup fee.")
            return
        end

        local steam = GetPlayerIdentifiers(_source)[1]
        local is_source_ready = false
        for i=1, #readyPlayers do
            if readyPlayers[i]['r'].source == _source then
                readyPlayers[i]['r'].Race = race
                is_source_ready = true
            end
        end
        if not is_source_ready then
            table.insert(readyPlayers, {['r'] = {Race = race, source = _source}})
        end
        local ready = 0
        for i=1, #readyPlayers do
            Wait(0)
            if readyPlayers[i]['r'].Race ~= false then
                if readyPlayers[i]['r'].Race == race then
                    ready = ready + 1
                end
            end
        end
        
        if ready >= 2 then
            beginRace(race, ready)
        end
    else
        TriggerClientEvent('strp_racing:onlinerace_cantstart', _source)
    end
end)

function beginRace(race, ready)
    Citizen.CreateThread(function()
        if readyRaces[race] ~= nil and readyRaces[race].starting then
            print("Ready players: " .. ready)
            readyRaces[race].P = ready
            return
        end

        readyRaces[race] = { R = race, P = ready, starting = true }
        print("Ready players: " .. readyRaces[race].P)
        Citizen.Wait(10000)
        print("Launching with players: " .. readyRaces[race].P)

        local position = 1
        for i=1, readyRaces[race].P do
            local data = {R = race, [race] = {checkpoints = 0, p = i}}
            table.insert(online_race_leaderboard, data)
        end
        for i=1, #readyPlayers do
            if readyPlayers[i]['r'].Race ~= false then
                if readyPlayers[i]['r'].Race == race then
                    table.insert(online_race_in_progress, {R = race})
                    TriggerClientEvent('strp_racing:start_online_race', readyPlayers[i]['r'].source, race, position, readyRaces[race].P)
                    local tRacer = ESX.GetPlayerFromId(readyPlayers[i]['r'].source)
                    tRacer.removeMoney(200)
                    position = position + 1
                end
            end
        end
        readyRaces[race].starting = false
    end)
end

RegisterServerEvent('strp_racing:countdown')
AddEventHandler('strp_racing:countdown', function()
    local _source = source
    TriggerClientEvent('strp_racing:scaleform_showfreemodemessage', _source, '3', '', 0.6)
    Wait(1175)
    TriggerClientEvent('strp_racing:scaleform_showfreemodemessage', _source, '2', '', 0.6)
    Wait(1175)
    TriggerClientEvent('strp_racing:scaleform_showfreemodemessage', _source, '1', '', 0.55)
    Wait(1100)
    TriggerClientEvent('strp_racing:scaleform_showfreemodemessage', _source, 'GO!', '', 0.4)
end)

RegisterServerEvent('strp_racing:not_ready_online_race')
AddEventHandler('strp_racing:not_ready_online_race', function(race)
    local _source = source
    local steam = GetPlayerIdentifiers(_source)[1]
    for i=1, #readyPlayers do
        Wait(0)
        if readyPlayers[i]['r'].Race ~= false then
            if readyPlayers[i]['r'].source == _source then
                readyPlayers[i]['r'].Race = {false}
            end
        end
    end
end)

local offlineRace = true

RegisterServerEvent('strp_racing:offlineRace_sv')
AddEventHandler('strp_racing:offlineRace_sv', function(type)
    if type == 'can_i_start' then
        TriggerClientEvent('strp_racing:offlineRace_cl', source, offlineRace)
    else
        offlineRace = not offlineRace
    end
end)
