----Frankies gangster weapon animation

local holstered = true

local weapons = {
    "WEAPON_PISTOL",
    "WEAPON_SNSPISTOL",
    "WEAPON_SNSPISTOL_MK2",
    "WEAPON_PISTOL50",
    "WEAPON_REVOLVER",
    "WEAPON_PISTOL_MK2",
    "WEAPON_COMBATPISTOL",
	"WEAPON_HEAVYPISTOL",
    "WEAPON_MACHINEPISTOL",
    "WEAPON_MICROSMG",
    "WEAPON_STUNGUN",
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        if DoesEntityExist( ped ) and not IsEntityDead( ped ) and not IsPedInAnyVehicle(PlayerPedId(), true) then
            loadAnimDict( "reaction@intimidation@1h" )
            if CheckWeapon(ped) then
                if holstered then
                    TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 5.0, 1.0, -1, 30, 0, 0, 0, 0 )
                    Citizen.Wait(1400)
                    ClearPedTasks(ped)
                    holstered = false
                end
                SetPedComponentVariation(ped, 0, 0, 0, 0)
            elseif not CheckWeapon(ped) then
                if not holstered then
                    TaskPlayAnim(ped, "reaction@intimidation@1h", "outro", 8.0, 1.0, -1, 30, 0, 0, 0, 0 )
                    Citizen.Wait(1300)
                    ClearPedTasks(ped)
                    holstered = true
                end
                SetPedComponentVariation(ped, 0, 0, 0, 0)
            end
        end
    end
end)

function CheckWeapon(ped)
    for i = 1, #weapons do
        if GetHashKey(weapons[i]) == GetSelectedPedWeapon(ped) then
            return true
        end
    end
    return false
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 1500 )
    end
end