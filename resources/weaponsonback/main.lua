local Weapons = {}
local playerPed
local selectedPedWeapon
local weaponHash
local weaponName
local onPlayer
-----------------------------------------------------------
-----------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		playerPed = GetPlayerPed(-1)
        selectedPedWeapon = GetSelectedPedWeapon(playerPed)
        Wait(1000)
        collectgarbage()
	end
end)

Citizen.CreateThread(function()
	while true do
		for i=1, #Config.RealWeapons do
            weaponHash = Config.RealWeapons[i].hash
            weaponName = Config.RealWeapons[i].name

            if HasPedGotWeapon(playerPed, weaponHash, false) then
                onPlayer = false
                for k, entity in pairs(Weapons) do
                    if entity then
                        if entity.weapon == weaponName then
                            onPlayer = true
                            break
                        end
                    end
                end

                if not onPlayer and weaponHash ~= selectedPedWeapon then
                    SetGear(weaponName)
                elseif onPlayer and weaponHash == selectedPedWeapon then
                    RemoveGear(weaponName)
                end
            else
                RemoveGear(weaponName)
            end
        end
		Wait(500)
	end
end)
-----------------------------------------------------------
-----------------------------------------------------------
RegisterNetEvent('removeWeapon')
AddEventHandler('removeWeapon', function(weaponName)
	RemoveGear(weaponName)
end)
RegisterNetEvent('removeWeapons')
AddEventHandler('removeWeapons', function()
	RemoveGears()
end)
-----------------------------------------------------------
-----------------------------------------------------------
-- Remove only one weapon that's on the ped
function RemoveGear(weapon)
	local _Weapons = {}

	for i, entity in pairs(Weapons) do
		if entity.weapon ~= weapon then
			_Weapons[i] = entity
		else
			DeleteWeapon(entity.obj)
		end
	end

	Weapons = _Weapons
end
-----------------------------------------------------------
-----------------------------------------------------------
-- Remove all weapons that are on the ped
function RemoveGears()
	for i, entity in pairs(Weapons) do
		DeleteWeapon(entity.obj)
	end
	Weapons = {}
end
-----------------------------------------------------------
-----------------------------------------------------------
function SpawnObject(model, coords, cb)
    local model = (type(model) == 'number' and model or GetHashKey(model))
    Citizen.CreateThread(function()
        RequestModel(model)

        while not HasModelLoaded(model) do
            Citizen.Wait(0)
        end

        local obj = CreateObject(model, coords.x, coords.y, coords.z, true, true, true)
        if cb ~= nil then
            cb(obj)
        end
    end)
end

function DeleteWeapon(object)
  SetEntityAsMissionEntity(object,  false,  true)
  DeleteObject(object)
end

-- Add one weapon on the ped
function SetGear(weapon)
    if (#Weapons > 4) then
        return
    end

	local bone       = nil
	local boneX      = 0.0
	local boneY      = 0.0
	local boneZ      = 0.0
	local boneXRot   = 0.0
	local boneYRot   = 0.0
	local boneZRot   = 0.0
	local model      = nil
		
	for i=1, #Config.RealWeapons, 1 do
		if Config.RealWeapons[i].name == weapon then
			bone     = Config.RealWeapons[i].bone
			boneX    = Config.RealWeapons[i].x
			boneY    = Config.RealWeapons[i].y
			boneZ    = Config.RealWeapons[i].z
			boneXRot = Config.RealWeapons[i].xRot
			boneYRot = Config.RealWeapons[i].yRot
			boneZRot = Config.RealWeapons[i].zRot
			model    = Config.RealWeapons[i].model
			break
		end
	end

	SpawnObject(model, {
		x = x,
		y = y,
		z = z
	}, function(obj)
		local boneIndex = GetPedBoneIndex(playerPed, bone)
		local bonePos 	= GetWorldPositionOfEntityBone(playerPed, boneIndex)
		AttachEntityToEntity(obj, playerPed, boneIndex, boneX, boneY, boneZ, boneXRot, boneYRot, boneZRot, false, false, false, false, 2, true)
		table.insert(Weapons,{weapon = weapon, obj = obj})
	end)
end
