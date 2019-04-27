ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local MissionData = { --x,y,z,money
    [1] = { 1212.4463, 2667.4351, 38.79, "HAULER", "TANKER" },
    [2] = { 2574.5144, 328.5554, 108.45, "PACKER", "TRAILERS" },
    [3] = { -2565.0894, 2345.8904, 33.06, "PACKER", "TRAILERS2" },
    [4] = { 1706.7966, 4943.9897, 42.16, "HAULER", "TRAILERLOGS" },
    [5] = { 1212.4463, 2667.4351, 38.79, "HAULER", "ARMYTANKER" },
    [6] = { 2574.5144, 328.5554, 108.45, "HAULER", "TR2" },
    [7] = { -2565.0894, 2345.8904, 33.06, "PACKER", "TR4" },
    [8] = { 1706.7966, 4943.9897, 42.16, "PACKER", "TVTRAILER" },
    [9] = { 1212.4463, 2667.4351, 38.79, "HAULER", "TRFLAT" },
    [10] = { 2574.5144, 328.5554, 108.45, "HAULER", "TR4" },
    [11] = { -2565.0894, 2345.8904, 33.06, "PACKER", "TR2" },
    [12] = { 1706.7966, 4943.9897, 42.16, "PACKER", "ARMYTANKER" },
    [13] = { 1007.805847168, -2516.2065429688, 28.301975250244, "HAULER", "TRAILERLOGS" },
    [14] = { 762.59429931641, -1407.3121337891, 26.534646987915, "HAULER", "TRAILERS2" },
    [15] = { 729.73889160156, -556.20983886719, 26.512950897217, "PACKER", "TRAILERS" },
    [16] = { 873.23352050781, -949.66497802734, 26.282367706299, "HAULER", "TANKER" },
    [17] = { -1146.3988037109, -1255.3034667969, 6.7305421829224, "PACKER", "TANKER" },
    [18] = { -262.65377807617, 6056.5170898438, 31.706836700439, "HAULER", "TRAILERS" },
    [19] = { -2172.8088378906, 4271.5805664063, 48.954746246338, "PACKER", "TRAILERS2" },
    [20] = { -1456.4193115234, -382.94967651367, 38.539203643799, "HAULER", "TRAILERLOGS" },
}
local currentMission = math.random(1,#MissionData)

RegisterServerEvent('truckerJob:completeMission')
AddEventHandler('truckerJob:completeMission', function(dmg, distance, mission)
    local xPlayer = ESX.GetPlayerFromId(source)
    print("dist: " .. distance)
    local amount = math.ceil(tonumber((distance / 10) - (dmg / 70)))
    print("dist: " .. amount)

    xPlayer.addMoney(amount)
    TriggerClientEvent('esx:showAdvancedNotification', source, "Trucking", "You've been paid $" .. amount .. " for completing delivery", 'fas fa-truck-moving', "green")

    currentMission = math.random(1,#MissionData)
    TriggerClientEvent('truckerJob:updateCurrentMission', -1, MissionData[currentMission])
end)

RegisterServerEvent('truckerJob:requestCurrentMission')
AddEventHandler('truckerJob:requestCurrentMission', function()
    TriggerClientEvent('truckerJob:updateCurrentMission', source, MissionData[currentMission])
end)