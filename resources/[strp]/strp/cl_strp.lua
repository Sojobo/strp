local weaponHashes = {
    [-1716189206] = { name = "WEAPON_KNIFE", iid = 17, SABS = false, Concealable = true, model = "prop_w_me_knife_01" }, -- old 2578778090
    [1737195953] = { name = "WEAPON_NIGHTSTICK", iid = 18, SABS = false, Concealable = true, model = "w_me_nightstick" },
    [1317494643] = { name = "WEAPON_HAMMER", iid = 19, SABS = false, Concealable = true, model = "prop_tool_hammer" },
    [-1786099057] = { name = "WEAPON_BAT", iid = 20, SABS = false, Concealable = false, model = "w_me_bat" }, -- old 2508868239
    [1141786504] = { name = "WEAPON_GOLFCLUB", iid = 21, SABS = false, Concealable = true, model = "w_me_gclub" },
    [-2067956739] = { name = "WEAPON_CROWBAR", iid = 22, SABS = false, Concealable = true, model = "w_me_crowbar" }, -- old 2227010557
    [-102323637] = { name = "WEAPON_BOTTLE", iid = 23, SABS = false, Concealable = true, model = "prop_w_me_bottle" }, -- old 4192643659
    [-1834847097] = { name = "WEAPON_DAGGER", iid = 24, SABS = false, Concealable = true, model = "prop_w_me_dagger" }, -- old 2460120199
    [-102973651] = { name = "WEAPON_HATCHET", iid = 25, SABS = false, Concealable = true, model = "w_me_hatchet" },
    [-656458692] = { name = "WEAPON_KNUCKLE", iid = 26, SABS = false, Concealable = true, model = ""}, -- old 3638508604
    [-581044007] = { name = "WEAPON_MACHETE", iid = 27, SABS = false, Concealable = true, model = "prop_ld_w_me_machette" }, -- old 3713923289
    [2343591895] = { name = "WEAPON_FLASHLIGHT", iid = 28, SABS = false, Concealable = true, model = "" }, -- needs verified
    [-538741184] = { name = "WEAPON_SWITCHBLADE", iid = 29, SABS = false, Concealable = true, model = "" }, -- old 3756226112
    [-1810795771] = { name = "WEAPON_POOLCUE", iid = 30, SABS = true, Concealable = false, model = "prop_pool_cue" }, -- old 2484171525
    [419712736] = { name = "WEAPON_WRENCH", iid = 31, SABS = true, Concealable = true, model = "w_me_hammer" },
    [-853065399] = { name = "WEAPON_BATTLEAXE", iid = 32, SABS = true, Concealable = false, model = "prop_tool_fireaxe" }, -- old 3441901897

    [453432689] = { name = "WEAPON_PISTOL", iid = 33, SABS = false, Concealable = true, model = "w_pi_pistol" },
    [1593441988] = { name = "WEAPON_COMBATPISTOL", iid = 34, SABS = false, Concealable = true, model = "w_pi_combatpistol" },
    [-1716589765] = { name = "WEAPON_PISTOL50", iid = 35, SABS = false, Concealable = true, model = "w_pi_pistol50" },
    [-1076751822] = { name = "WEAPON_SNSPISTOL", iid = 36, SABS = false, Concealable = true, model = "w_pi_sns_pistol" }, -- old 3218215474
    [-771403250] = { name = "WEAPON_HEAVYPISTOL", iid = 37, SABS = false, Concealable = true, model = "w_pi_heavypistol" }, -- old 3523564046
    [137902532] = { name = "WEAPON_VINTAGEPISTOL", iid = 38, SABS = false, Concealable = true, model = "w_pi_vintage_pistol" },
    [-598887786] = { name = "WEAPON_MARKSMANPISTOL", iid = 39, SABS = false, Concealable = true, model = "" },
    [-1045183535] = { name = "WEAPON_REVOLVER", iid = 40, SABS = false, Concealable = true , model = "" }, -- old 3249783761
    [584646201] = { name = "WEAPON_APPISTOL", iid = 41, SABS = false, Concealable = true, model = "w_pi_appistol" },
    [911657153] = { name = "WEAPON_STUNGUN", iid = 42, SABS = false, Concealable = true , model = "w_pi_stungun" },
    [1198879012] = { name = "WEAPON_FLAREGUN", iid = 43, SABS = false, Concealable = true, model = "w_pi_flaregun" },

    [324215364] = { name = "WEAPON_MICROSMG", iid = 44, SABS = false, Concealable = false, model = "w_sb_microsmg" },
    [-619010992] = { name = "WEAPON_MACHINEPISTOL", iid = 45, SABS = false, Concealable = true, model = "" },
    [736523883] = { name = "WEAPON_SMG", iid = 46, SABS = false, Concealable = false, model = "w_sb_smg" },
    [-270015777] = { name = "WEAPON_ASSAULTSMG", iid = 47, SABS = false, Concealable = false, model = "w_sb_assaultsmg" },
    [171789620] = { name = "WEAPON_COMBATPDW", iid = 48, SABS = false, Concealable = false, model = "" },
    [2634544996] = { name = "WEAPON_MG", iid = 49, SABS = true, Concealable = false, model = "w_mg_mg" },
    [2144741730] = { name = "WEAPON_COMBATMG", iid = 50, SABS = true, Concealable = false, odel = "w_mg_combatmg"},
    [1627465347] = { name = "WEAPON_GUSENBERG", iid = 51, SABS = false, Concealable = false, model = "w_sb_gusenberg" },
    [3173288789] = { name = "WEAPON_MINISMG", iid = 52, SABS = true, Concealable = false, model = "" },

    [487013001] = { name = "WEAPON_PUMPSHOTGUN", iid = 53, SABS = false, Concealable = false, model = "w_sg_pumpshotgun" },
    [2017895192] = { name = "WEAPON_SAWNOFFSHOTGUN", iid = 54, SABS = false, Concealable = false, model = "" },
    [-1654528753] = { name = "WEAPON_BULLPUPSHOTGUN", iid = 55, SABS = false, Concealable = false, model = "w_sg_bullpupshotgun" },
    [-494615257] = { name = "WEAPON_ASSAULTSHOTGUN", iid = 56, SABS = true, Concealable = false, model = "w_sg_assaultshotgun" },
    [-1466123874] = { name = "WEAPON_MUSKET", iid = 57, SABS = true, Concealable = false, model = "w_ar_musket" },
    [984333226] = { name = "WEAPON_HEAVYSHOTGUN", iid = 58, SABS = true, Concealable = false, model = "w_sg_heavyshotgun" },
    [-275439685] = { name = "WEAPON_DBSHOTGUN", iid = 59, SABS = true, Concealable = false, model = "" },
    [317205821] = { name = "WEAPON_AUTOSHOTGUN", iid = 60, SABS = true, Concealable = false, model = "" },

    [3220176749] = { name = "WEAPON_ASSAULTRIFLE", iid = 61, SABS = true, Concealable = false, model = "w_ar_assaultrifle" },
    [-2084633992] = { name = "WEAPON_CARBINERIFLE", iid = 62, SABS = false, Concealable = false, model = "w_ar_carbinerifle" }, -- old: 2210333304
    [2937143193] = { name = "WEAPON_ADVANCEDRIFLE", iid = 63, SABS = true, Concealable = false, model = "w_ar_advancedrifle" },
    [-1063057011] = { name = "WEAPON_SPECIALCARBINE", iid = 64, SABS = false, Concealable = false, model = "w_ar_specialcarbine" }, -- manual hash
    [2132975508] = { name = "WEAPON_BULLPUPRIFLE", iid = 65, SABS = true, Concealable = false, model = "w_ar_bullpuprifle" },
    [1649403952] = { name = "WEAPON_COMPACTRIFLE", iid = 66, SABS = false, Concealable = false , model = "" }, -- manual hash

    [100416529] = { name = "WEAPON_SNIPERRIFLE", iid = 67, SABS = true, Concealable = false, model = "w_sr_sniperrifle" },
    [205991906] = { name = "WEAPON_HEAVYSNIPER", iid = 68, SABS = true, Concealable = false, model = "w_sr_heavysniper" },
    [-952879014] = { name = "WEAPON_MARKSMANRIFLE", iid = 69, SABS = false, Concealable = false, model = "w_sr_marksmanrifle" }, -- old: 3342088282

    [205991906] = { name = "WEAPON_GRENADELAUNCHER", iid = 70, SABS = true, Concealable = false, model = "w_lr_grenadelauncher" },
    [2982836145] = { name = "WEAPON_RPG", iid = 71, SABS = true, Concealable = false, model = "w_lr_rpg" },
    [1119849093] = { name = "WEAPON_MINIGUN", iid = 72, SABS = true, Concealable = false, model = "w_mg_minigun" },
    [2138347493] = { name = "WEAPON_FIREWORK", iid = 73, SABS = true, Concealable = false, model = "w_lr_firework" },
    [1834241177] = { name = "WEAPON_RAILGUN", iid = 74, SABS = true, Concealable = false, model = "w_ar_railgun" },
    [1672152130] = { name = "WEAPON_HOMINGLAUNCHER", iid = 75, SABS = true, Concealable = false, model = "w_lr_homing" },
    [1305664598] = { name = "WEAPON_GRENADELAUNCHER_SMOKE", iid = 76, SABS = false, Concealable = false, model = "" },
    [125959754] = { name = "WEAPON_COMPACTLAUNCHER", iid = 77, SABS = true, Concealable = false, model = "" },

    [2481070269] = { name = "WEAPON_GRENADE", iid = 78, SABS = true, Concealable = true, model = "w_ex_grenadefrag" },
    [741814745] = { name = "WEAPON_STICKYBOMB", iid = 79, SABS = true, Concealable = true, model = "prop_bomb_01_s" },
    [2874559379] = { name = "WEAPON_PROXMINE", iid = 80, SABS = true, Concealable = true, model = "" },
    [2694266206] = { name = "WEAPON_BZGAS", iid = 81, SABS = true, Concealable = true, model = "w_ex_grenadesmoke" },
    [615608432] = { name = "WEAPON_MOLOTOV", iid = 82, SABS = true, Concealable = true, model = "w_ex_molotov" },
    [101631238] = { name = "WEAPON_FIREEXTINGUISHER", iid = 83, SABS = false, Concealable = true, model = "w_am_fire_exting" },
    [883325847] = { name = "WEAPON_PETROLCAN", iid = 84, SABS = false, Concealable = true, model = "w_am_jerrycan" },
    [1233104067] = { name = "WEAPON_FLARE", iid = 85, SABS = false, Concealable = true, model = "" },
    [600439132] = { name = "WEAPON_BALL", iid = 86, SABS = true, Concealable = true, model = "w_am_baseball" },
    [126349499] = { name = "WEAPON_SNOWBALL", iid = 87, SABS = false, Concealable = true,model = "w_ex_snowball" },
    [4256991824] = { name = "WEAPON_SMOKEGRENADE", iid = 88, SABS = false, Concealable = true, model = "w_ex_grenadesmoke" },
    [3125143736] = { name = "WEAPON_PIPEBOMB", iid = 89, SABS = true, Concealable = true, model = "" },

    [-86904375] = { name = "WEAPON_CARBINERIFLE_MK2", iid = 93, SABS = false, Concealable = false, model = "w_ar_carbineriflemk2" },
    [-1075685676] = { name = "WEAPON_PISTOL_MK2", iid = 96, SABS = false, Concealable = true, model = "" },
    [2024373456] = { name = "WEAPON_SMG_MK2", iid = 103, SABS = false, Concealable = false, model = "w_sb_smgmk2"  },
    [-1768145561] = { name = "WEAPON_SPECIALCARBINE_MK2", iid = 135, SABS = false, Concealable = false, model = "w_ar_specialcarbinemk2" }, -- manual hash
}

-- Spawn override
AddEventHandler('onClientMapStart', function()
    exports.spawnmanager:setAutoSpawn(false)
    exports.spawnmanager:spawnPlayer({ x = 0, y = 0, z = 0 })
    AddTextEntry("FE_THDR_GTAO", "STRP - forum.spaceturtl.es")
end)

AddEventHandler("playerSpawned", function(spawn)
    NetworkSetTalkerProximity(12.0) -- VOIP Force Proximity
end)

-- Discord Rich Presence
Citizen.CreateThread(function()
	while true do
        --This is the Application ID (Replace this with you own)
		SetDiscordAppId(378278048853655552)

        --Here you will have to put the image name for the "large" icon.
		SetDiscordRichPresenceAsset('spaceturtles')

        --(11-11-2018) New Natives:

        --Here you can add hover text for the "large" icon.
        SetDiscordRichPresenceAssetText('Space Turtles Role Play Server')

        --Here you will have to put the image name for the "small" icon.
        --SetDiscordRichPresenceAssetSmall('logo_name')

        --Here you can add hover text for the "small" icon.
        --SetDiscordRichPresenceAssetSmallText('This is a lsmall icon with text')

        --It updates every one minute just in case.
		Citizen.Wait(60000)
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)

        local thisPlayerPed = GetPlayerPed(-1)
        local thisPlayerId = PlayerId()
        local plyPos = GetEntityCoords(thisPlayerPed, true)
        -- local plyPos = GetEntityCoords(thisPlayerPed, true)
        --local nearestPedId = GetClosestPed(plyPos.x, plyPos.y, plyPos.z, 20.0, 0, -1)

        --SetPedDropsWeaponsWhenDead(nearestPedId, false)
        --SetPedDropsWeaponsWhenDead(GetMeleeTargetForPed(thisPlayerPed), false)
        DisablePlayerVehicleRewards(thisPlayerId)

        SetPlayerWeaponDamageModifier(thisPlayerId, 0.8)
        -- SetPlayerVehicleDamageModifier(thisPlayerId, 0.2)
        SetPlayerMeleeWeaponDamageModifier(thisPlayerId, 0.05)
        --SetAiWeaponDamageModifier(thisPlayerId, 0.5)
        --SetAiMeleeWeaponDamageModifier(thisPlayerId, 0.4)

        -- Anticheats
        -- SetPlayerInvincible(false)

        -- Disable wanted system
        --if (IsPedModel(thisPlayerPed,GetHashKey("s_m_y_cop_01")) or IsEntityPlayingAnim(lPed, "mp_arresting", "idle", 3))then
        -- for i = 1, 12 do
        --     EnableDispatchService(i, false)
        -- end
        -- SetPlayerWantedLevel(thisPlayerId, 0, false)
        -- SetPlayerWantedLevelNow(thisPlayerId, false)
        -- SetPlayerWantedLevelNoDrop(thisPlayerId, 0, false)

        ClearPlayerWantedLevel(thisPlayerId)
        SetMaxWantedLevel(0)
        SetPoliceIgnorePlayer(thisPlayerId, true)
        --else
        --  SetMaxWantedLevel(1)
        --end

        -- Updated Version of removing pickups and drops
        RemoveWeaponDrops()

        -- RemoveAllPickupsOfType(0x550447A9)
        -- RemoveAllPickupsOfType(0xF92F486C)
        -- RemoveAllPickupsOfType(0x602941D0)
        -- RemoveAllPickupsOfType(0xE013E01C)
        -- RemoveAllPickupsOfType(0x881AB0A8)
        -- RemoveAllPickupsOfType(0xA421A532)
        -- RemoveAllPickupsOfType(0x5C517D97)
        -- RemoveAllPickupsOfType(0xDE58E0B3)
        -- RemoveAllPickupsOfType(0xF25A01B9)
        -- RemoveAllPickupsOfType(0xF99E15D0)
        -- RemoveAllPickupsOfType(0x20796A82)
        -- RemoveAllPickupsOfType(0xE4BD2FC6)
        -- RemoveAllPickupsOfType(0x84837FD7)
        -- RemoveAllPickupsOfType(0x77F3F2DD)
        -- RemoveAllPickupsOfType(0x116FC4E6)
        -- RemoveAllPickupsOfType(0xC02CF125)
        -- RemoveAllPickupsOfType(0x4BFB42D1)
        -- RemoveAllPickupsOfType(0xE33D8630)
        -- RemoveAllPickupsOfType(0x2C014CA6)
        -- RemoveAllPickupsOfType(0xE175C698)
        -- RemoveAllPickupsOfType(0x1CD2CF66)
        -- RemoveAllPickupsOfType(0x8F707C18)
        -- RemoveAllPickupsOfType(0xCE6FDD6B)
        -- RemoveAllPickupsOfType(0x20893292)
        -- RemoveAllPickupsOfType(0x14568F28)
        -- RemoveAllPickupsOfType(0x711D02A4)
        -- RemoveAllPickupsOfType(0x1E9A99F8)
        -- RemoveAllPickupsOfType(0xDE78F17E)
        -- RemoveAllPickupsOfType(0xFE18F3AF)
        -- RemoveAllPickupsOfType(0x5DE0AD3E)
        -- RemoveAllPickupsOfType(0x6773257D)
        -- RemoveAllPickupsOfType(0xEE0E26F3)
        -- RemoveAllPickupsOfType(0x6E717A95)
        -- RemoveAllPickupsOfType(0x4B5259BE)
        -- RemoveAllPickupsOfType(0xC3CD8B31)
        -- RemoveAllPickupsOfType(0x94FA0B5E)
        -- RemoveAllPickupsOfType(0x31EA45C9)
        -- RemoveAllPickupsOfType(0x80AB931C)
        -- RemoveAllPickupsOfType(0xE7CF07CC)
        -- RemoveAllPickupsOfType(0x4316CC09)
        -- RemoveAllPickupsOfType(0xA5B8CAA9)
        -- RemoveAllPickupsOfType(0x41D2CF56)
        -- RemoveAllPickupsOfType(0x098D79EF)
        -- RemoveAllPickupsOfType(0xFDEE8368)
        -- RemoveAllPickupsOfType(0x65948212)
        -- RemoveAllPickupsOfType(0xCC8B3905)
        -- RemoveAllPickupsOfType(0x68605A36)
        -- RemoveAllPickupsOfType(0xD0AACEF7)
        -- RemoveAllPickupsOfType(0xA717F898)
        -- RemoveAllPickupsOfType(0xB86AEE5B)
        -- RemoveAllPickupsOfType(0x84D676D4)
        -- RemoveAllPickupsOfType(0xA54AE7B7)
        -- RemoveAllPickupsOfType(0xD3A39366)
        -- RemoveAllPickupsOfType(0x2E071B5A)
        -- RemoveAllPickupsOfType(0xCC7CCD1B)
        -- RemoveAllPickupsOfType(0x65A7D8E9)
        -- RemoveAllPickupsOfType(0x2C804FE3)
        -- RemoveAllPickupsOfType(0xB2B5325E)
        -- RemoveAllPickupsOfType(0x3B662889)
        -- RemoveAllPickupsOfType(0xF33C83B0)
        -- RemoveAllPickupsOfType(0x9299C95B)
        -- RemoveAllPickupsOfType(0x741C684A)
        -- RemoveAllPickupsOfType(0xBCC5C1F2)
        -- RemoveAllPickupsOfType(0x81EE601E)
        -- RemoveAllPickupsOfType(0x0977C0F2)
        -- RemoveAllPickupsOfType(0xFA51ABF5)
        -- RemoveAllPickupsOfType(0x815D66E8)
        -- RemoveAllPickupsOfType(0x6E4E65C2)
        -- RemoveAllPickupsOfType(0xDF711959)
        -- RemoveAllPickupsOfType(0xB2930A14)
        -- RemoveAllPickupsOfType(0x789576E2)
        -- RemoveAllPickupsOfType(0x8967B4F3)
        -- RemoveAllPickupsOfType(0xF0EA0639)
        -- RemoveAllPickupsOfType(0x0FE73AB5)
        -- RemoveAllPickupsOfType(0x872DC888)
        -- RemoveAllPickupsOfType(0xBFEE6C3B)
        -- RemoveAllPickupsOfType(0xF9E2DF1F)
        -- RemoveAllPickupsOfType(0x22B15640)
        -- RemoveAllPickupsOfType(0xBD4DE242)
        -- RemoveAllPickupsOfType(0xBDB6FFA5)
        -- RemoveAllPickupsOfType(0x5E0683A1)
        -- RemoveAllPickupsOfType(0x2E764125)
        -- RemoveAllPickupsOfType(0x5307A4EC)
        -- RemoveAllPickupsOfType(0x88EAACA7)
        -- RemoveAllPickupsOfType(0x295691A9)
        -- RemoveAllPickupsOfType(0x4E301CD0)
        -- RemoveAllPickupsOfType(0x9CF13918)
        -- RemoveAllPickupsOfType(0xBED46EC5)
        -- RemoveAllPickupsOfType(0x693583AD)
        -- RemoveAllPickupsOfType(0xC01EB678)
        -- RemoveAllPickupsOfType(0x278D8734)
        -- RemoveAllPickupsOfType(0xFD9CAEDE)
        -- RemoveAllPickupsOfType(0xD8257ABF)
        -- RemoveAllPickupsOfType(0xF5C5DADC)
        -- RemoveAllPickupsOfType(0x8ADDEC75)
        -- RemoveAllPickupsOfType(0x079284A9)
        -- RemoveAllPickupsOfType(0x85CAA9B1)
        -- RemoveAllPickupsOfType(0x1D9588D3)
        -- RemoveAllPickupsOfType(0x2F36B434)
        -- RemoveAllPickupsOfType(0xD3722A5B)
        -- RemoveAllPickupsOfType(0x2DD30479)
        -- RemoveAllPickupsOfType(0x763F7121)
        -- RemoveAllPickupsOfType(0x5EA16D74)
        -- RemoveAllPickupsOfType(0xC69DE3FF)
        -- RemoveAllPickupsOfType(0xAF692CA9)
        -- RemoveAllPickupsOfType(0xF9AFB48F)
        -- RemoveAllPickupsOfType(0x6C5B941A)
        -- RemoveAllPickupsOfType(0x093EBB26)
        -- RemoveAllPickupsOfType(0x624F7213)
        -- RemoveAllPickupsOfType(0xA9355DCD)
        -- RemoveAllPickupsOfType(0xE46E11B4)
        -- RemoveAllPickupsOfType(0x614BFCAC)
        -- RemoveAllPickupsOfType(0x4D36C349)
        -- RemoveAllPickupsOfType(0x96B412A3)
        -- RemoveAllPickupsOfType(0x3A4C2AD2)
        -- RemoveAllPickupsOfType(0x1CD604C7)
        -- RemoveAllPickupsOfType(0xFE2A352C)
        -- RemoveAllPickupsOfType(0xC5B72713)
        -- RemoveAllPickupsOfType(0x0968339D)
        -- RemoveAllPickupsOfType(0x7C119D58)
        -- RemoveAllPickupsOfType(0xFD16169E)
        -- RemoveAllPickupsOfType(0xDDE4181A)
        -- RemoveAllPickupsOfType(0xEBF89D5F)
        -- RemoveAllPickupsOfType(0xE5121369)

        HideHudComponentThisFrame(14) -- hide reticle / crosshair
        --SetPlayerCanLeaveParachuteSmokeTrail(thisPlayerId, true)
        --SetPlayerParachuteSmokeTrailColor(thisPlayerId, 255, 0, 0)
        --if IsPedJacking(thisPlayerPed) then
        --    ClearPedTasksImmediately(thisPlayerPed)
        --end

        if IsPedInAnyVehicle(thisPlayerPed, false) and (not IsControlPressed(1, 32) or not IsControlPressed(1, 71) or IsPedJacking(thisPlayerPed)) then -- if W (32) or Controller RT (71) is pressed, jump to drivers, else, no switching of seats. Is 32 needed here? 71 - INPUT_VEH_ACCELERATE
            local myVehicle = GetVehiclePedIsIn(thisPlayerPed, false)
            if GetPedInVehicleSeat(myVehicle, 0) == thisPlayerPed then
                if GetIsTaskActive(thisPlayerPed, 165) then
                    SetPedIntoVehicle(thisPlayerPed, myVehicle, 0)
                end
            end
        end

        if IsEntityPlayingAnim(thisPlayerPed, "mp_arresting", "idle", 3) or plyPos.z < -100.0 then
            SetCurrentPedWeapon(thisPlayerPed, GetHashKey("WEAPON_UNARMED"))
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
            SetPedCanSwitchWeapon(thisPlayerPed, false)
            SetPedDensityMultiplierThisFrame(0.0)
            SetVehicleDensityMultiplierThisFrame(0.0)
        elseif IsPedFatallyInjured(thisPlayerPed) then
            SetPedDensityMultiplierThisFrame(0.0)
            SetVehicleDensityMultiplierThisFrame(0.0)
        else
            SetPedCanSwitchWeapon(thisPlayerPed, true) -- enable weapon switching
            SetPedDensityMultiplierThisFrame(0.3)
            SetVehicleDensityMultiplierThisFrame(0.4)
        end

        -- -- Ragdolling and tazering
        -- if (IsPedBeingStunned(thisPlayerPed)) then
        --     SetPedToRagdoll(thisPlayerPed, 6000, 6000, 0, 0, 0, 0)
        -- end
    end
end)

 function RemoveWeaponDrops()
    local pickupList = {"PICKUP_AMMO_BULLET_MP","PICKUP_AMMO_FIREWORK","PICKUP_AMMO_FLAREGUN","PICKUP_AMMO_GRENADELAUNCHER","PICKUP_AMMO_GRENADELAUNCHER_MP","PICKUP_AMMO_HOMINGLAUNCHER","PICKUP_AMMO_MG","PICKUP_AMMO_MINIGUN","PICKUP_AMMO_MISSILE_MP","PICKUP_AMMO_PISTOL","PICKUP_AMMO_RIFLE","PICKUP_AMMO_RPG","PICKUP_AMMO_SHOTGUN","PICKUP_AMMO_SMG","PICKUP_AMMO_SNIPER","PICKUP_ARMOUR_STANDARD","PICKUP_CAMERA","PICKUP_CUSTOM_SCRIPT","PICKUP_GANG_ATTACK_MONEY","PICKUP_HEALTH_SNACK","PICKUP_HEALTH_STANDARD","PICKUP_MONEY_CASE","PICKUP_MONEY_DEP_BAG","PICKUP_MONEY_MED_BAG","PICKUP_MONEY_PAPER_BAG","PICKUP_MONEY_PURSE","PICKUP_MONEY_SECURITY_CASE","PICKUP_MONEY_VARIABLE","PICKUP_MONEY_WALLET","PICKUP_PARACHUTE","PICKUP_PORTABLE_CRATE_FIXED_INCAR","PICKUP_PORTABLE_CRATE_UNFIXED","PICKUP_PORTABLE_CRATE_UNFIXED_INCAR","PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_SMALL","PICKUP_PORTABLE_CRATE_UNFIXED_LOW_GLOW","PICKUP_PORTABLE_DLC_VEHICLE_PACKAGE","PICKUP_PORTABLE_PACKAGE","PICKUP_SUBMARINE","PICKUP_VEHICLE_ARMOUR_STANDARD","PICKUP_VEHICLE_CUSTOM_SCRIPT","PICKUP_VEHICLE_CUSTOM_SCRIPT_LOW_GLOW","PICKUP_VEHICLE_HEALTH_STANDARD","PICKUP_VEHICLE_HEALTH_STANDARD_LOW_GLOW","PICKUP_VEHICLE_MONEY_VARIABLE","PICKUP_VEHICLE_WEAPON_APPISTOL","PICKUP_VEHICLE_WEAPON_ASSAULTSMG","PICKUP_VEHICLE_WEAPON_COMBATPISTOL","PICKUP_VEHICLE_WEAPON_GRENADE","PICKUP_VEHICLE_WEAPON_MICROSMG","PICKUP_VEHICLE_WEAPON_MOLOTOV","PICKUP_VEHICLE_WEAPON_PISTOL","PICKUP_VEHICLE_WEAPON_PISTOL50","PICKUP_VEHICLE_WEAPON_SAWNOFF","PICKUP_VEHICLE_WEAPON_SMG","PICKUP_VEHICLE_WEAPON_SMOKEGRENADE","PICKUP_VEHICLE_WEAPON_STICKYBOMB","PICKUP_WEAPON_ADVANCEDRIFLE","PICKUP_WEAPON_APPISTOL","PICKUP_WEAPON_ASSAULTRIFLE","PICKUP_WEAPON_ASSAULTSHOTGUN","PICKUP_WEAPON_ASSAULTSMG","PICKUP_WEAPON_AUTOSHOTGUN","PICKUP_WEAPON_BAT","PICKUP_WEAPON_BATTLEAXE","PICKUP_WEAPON_BOTTLE","PICKUP_WEAPON_BULLPUPRIFLE","PICKUP_WEAPON_BULLPUPSHOTGUN","PICKUP_WEAPON_CARBINERIFLE","PICKUP_WEAPON_COMBATMG","PICKUP_WEAPON_COMBATPDW","PICKUP_WEAPON_COMBATPISTOL","PICKUP_WEAPON_COMPACTLAUNCHER","PICKUP_WEAPON_COMPACTRIFLE","PICKUP_WEAPON_CROWBAR","PICKUP_WEAPON_DAGGER","PICKUP_WEAPON_DBSHOTGUN","PICKUP_WEAPON_FIREWORK","PICKUP_WEAPON_FLAREGUN","PICKUP_WEAPON_FLASHLIGHT","PICKUP_WEAPON_GRENADE","PICKUP_WEAPON_GRENADELAUNCHER","PICKUP_WEAPON_GUSENBERG","PICKUP_WEAPON_GOLFCLUB","PICKUP_WEAPON_HAMMER","PICKUP_WEAPON_HATCHET","PICKUP_WEAPON_HEAVYPISTOL","PICKUP_WEAPON_HEAVYSHOTGUN","PICKUP_WEAPON_HEAVYSNIPER","PICKUP_WEAPON_HOMINGLAUNCHER","PICKUP_WEAPON_KNIFE","PICKUP_WEAPON_KNUCKLE","PICKUP_WEAPON_MACHETE","PICKUP_WEAPON_MACHINEPISTOL","PICKUP_WEAPON_MARKSMANPISTOL","PICKUP_WEAPON_MARKSMANRIFLE","PICKUP_WEAPON_MG","PICKUP_WEAPON_MICROSMG","PICKUP_WEAPON_MINIGUN","PICKUP_WEAPON_MINISMG","PICKUP_WEAPON_MOLOTOV","PICKUP_WEAPON_MUSKET","PICKUP_WEAPON_NIGHTSTICK","PICKUP_WEAPON_PETROLCAN","PICKUP_WEAPON_PIPEBOMB","PICKUP_WEAPON_PISTOL","PICKUP_WEAPON_PISTOL50","PICKUP_WEAPON_POOLCUE","PICKUP_WEAPON_PROXMINE","PICKUP_WEAPON_PUMPSHOTGUN","PICKUP_WEAPON_RAILGUN","PICKUP_WEAPON_REVOLVER","PICKUP_WEAPON_RPG","PICKUP_WEAPON_SAWNOFFSHOTGUN","PICKUP_WEAPON_SMG","PICKUP_WEAPON_SMOKEGRENADE","PICKUP_WEAPON_SNIPERRIFLE","PICKUP_WEAPON_SNSPISTOL","PICKUP_WEAPON_SPECIALCARBINE","PICKUP_WEAPON_STICKYBOMB","PICKUP_WEAPON_STUNGUN","PICKUP_WEAPON_SWITCHBLADE","PICKUP_WEAPON_VINTAGEPISTOL","PICKUP_WEAPON_WRENCH"}
    local pedPos = GetEntityCoords(GetPlayerPed(PlayerId()), false)
    for a = 1, #pickupList do
        if IsPickupWithinRadius(GetHashKey(pickupList[a]), pedPos.x, pedPos.y, pedPos.z, 50.0) then
            RemoveAllPickupsOfType(GetHashKey(pickupList[a]))
        end
    end
end

-- -- Weapon Clean Up & Other Exploit Checking
-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(1000) -- Every second...

--         for hash, wep in pairs(weaponHashes) do
--             if wep.SABS then -- Only check for SABS weapons...
--                 if HasPedGotWeapon(thisPlayerPed, GetHashKey(wep.name), false) then
--                     TriggerServerEvent('es_admin:hasBannedWeapon', wep.name)
--                 end
--             end
--         end
--     end
-- end)
