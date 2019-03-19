--[[
FiveM-JailNJury
A Jail and Justice System that gives power back to the players.
Copyright (C) 2018  Jarrett Boice

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]

JailConfig = {}
JailConfig = setmetatable(JailConfig, {})

jurors = {}
jailedPlayers = {}
JailConfig.jailFile = "jailed.json"
JailConfig.stateName = "San Andreas"

JailConfig.courtStartTime = 5

JailConfig.courtEntraceLocation = { x = 237.55, y = -406.18, z = 47.59 }
-- JailConfig.defendantLocation = { x = 218.19, y = -424.23, z = 55.677, h = 165.24 }
JailConfig.defendantLocation = {  x = 240.6935, y = -313.0234, z = -118.7999, h = -118.7999 }
JailConfig.jurorLocations = {
  { x = 236.5611, y = -309.9198, z = -120.2765, h = -118.2765 },
  { x = 236.1705, y = -311.1291, z = -120.2999, h = -118.2999 },
  { x = 235.6936, y = -312.3421, z = -120.2902, h = -118.2902 },
  { x = 235.0856, y = -309.2023, z = -119.9191, h = -117.9191 },
  { x = 234.6380, y = -310.5253, z = -119.9200, h = -117.9200 },
  { x = 234.1418, y = -311.7669, z = -119.9088, h = -117.9088 },
}
JailConfig.prisonLocation = { x = 1727.49, y = 2538.06, z = 44.94 }
JailConfig.prisonEntraceLocation = { x = 1854.42, y = 2586.12, z = 45.05}

function shuffle(tbl)
  size = #tbl
  for i = size, 1, -1 do
    local rand = math.random(i)
    tbl[i], tbl[rand] = tbl[rand], tbl[i]
  end
  return tbl
end

function getPlayerID(source)
  local identifiers = GetPlayerIdentifiers(source)
  local player = getIdentifiant(identifiers)
  return player
end

function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end

function isPolice()
  inService = false
  ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
    if isInService then
      inService = true
    end
  end, 'police')
  return inService
end

function isJailed(permId)
  for i, jailedPlayer in ipairs(jailedPlayers) do
    if permId == jailedPlayer[1] then
      return jailedPlayer
    end
  end
  return false
end

function inJailCells(targetPedId)
  local missionRowCellArea = pArea()
  missionRowCellArea.addBulk(
  vector3(461.5078, -992.9688, 24.9147),
  vector3(461.3973, -1003.0148, 24.9148),
  vector3(457.4088, -1002.9898, 24.9147),
  vector3(458.5728, -993.0632, 25.9561)
  )
  return missionRowCellArea.isInside(GetEntityCoords(targetPedId, true))
end

function updateJailTime(permId, newTime)
  for i, jailedPlayer in ipairs(jailedPlayers) do
    if permId == jailedPlayer[1] then
      jailedPlayer[2] = newTime
    end
  end
end

function removedJailedPlayer(permId)
  for i, jailedPlayer in ipairs(jailedPlayers) do
    if permId == jailedPlayer[1] then
      table.remove(jailedPlayers, i)
    end
  end
end

function updateTrialRequest(permId, boolean)
  for i, jailedPlayer in ipairs(jailedPlayers) do
    if permId == jailedPlayer[1] then
      jailedPlayer[4] = boolean
    end
  end
end

function getJuror()
  shuffle(jurors)
  return jurors[1]
end

function inJurorPool(id)
  for i, juror in ipairs(jurors) do
    if id == juror then
      return true
    end
  end
  return false
end

function removeJuror(id)
  for i, juror in ipairs(jurors) do
    if id == juror then
      jurors[i] = nil
    end
  end
end
