--New custom animations based off DavesEmotes from @davewazere
--https://forum.fivem.net/t/release-daves-emotes/140216 
--Finger Pointing is taken from @Geekness and @Hallux
--https://forum.fivem.net/t/release-finger-pointing-by-geekness/103722
--Ragdoll is from here @callmejaf
--https://forum.fivem.net/t/release-toggle-ragdoll/53668
--Crouch is from wolfknights script @WolfKnight
--https://forum.fivem.net/t/release-crouch-script-1-0-1-now-button-based/14742


-- Commands
-- Salute: 		/e salute 		: Salute your commrads!
-- Bird 1: 		/e finger 		: One hand middle Finger
-- Bird 2: 		/e finger2 		: 2 hands middle finger
-- Surrender: 	/e surrender	: Kneeldown hands behind head surrender
-- Facepalm: 	/e palm			: Facepalm
-- Notes: 		/e notes		: Write down notes on paper
-- Brief:		/e brief		: Equip a tactical brief case
-- Brief2:		/e brief2		: Equip a leather brief case
-- Foldarms:	/e foldarms		: Cross your arms 
-- Foldarms2: 	/e foldarms2	: Cross arms v2
-- Damn:		/e damn			: Throw your arms in disbelief
-- Fail:		/e fail			: Become visibly dissapointed
-- Gang1:		/e gang1		: Gang sign 1
-- Gang2:		/e gang2		: Gang sign 2
-- No:			/e no			: Shake your head no
-- Pickbutt:	/e pickbutt		: Pick your butt
-- Grab Crotch:	/e grabcrotch	: Grab your crotch
-- Peace:		/e peace		: Hold peace sign
-- Cigar:		/e cigar		: Place cigar in your mouth
-- Cigar2:		/e cigar2		: Place a burnt cigar in your mouth
-- Joint:		/e joint		: Place a joint in your mouth
-- Cig:			/e cig			: Place a cig in your mouth
-- Holdcigar:	/e holdcigar	: Hold a cigar in your hand 
-- Holdcig:		/e holdcig		: Hold a cig in your hand 
-- Holdjoint:	/e holdjoint	: Hold a joint in your hand
-- Dead:		/e dead			: Play dead
-- Holster:		/e holster		: Hand hovers over holster 
-- Aim:			/e aim			: Aim a pistol at the floor 
-- Aim2:		/e aim2			: Aim a pistol up to your shoulder
-- 				/e slowclap		: Slowly clap your hands
--				/e box			: Pull out a box and walk around with it
--				/e cheer		: Cheer
--				/e bum			: Lay on the ground like a bum
--				/e leanwall		: Lean against a wall
--				/e copcrowd1	: Calm down a crowd like a cop
--				/e copcrowd2	: Control a scene like a cop
--				/e copidle		: idle like a cop

RegisterCommand('emotes', function()
	msg("salute, finger(1/2), surrender, palm, notes, foldarms, foldarms2, umbrella, brief, brief2, damn, fail, gang(1/2), no, pickbutt, peace, guard, cigar, cigar2, cig, joint, holdcig(tog), holdcigar(tog), holdjoint, dead, holster, guard, box, slowclap, cheer, bum, leanwall, copcrowd, copcrowd2, copidle, sit, hoe, hoe2, investigate, pushups, situps, camera, impatient, diggit, flex, jog, sunbath, sunbath2, yoga, kneel, fidget, wash, clean, map, selfie, bongos, workout, leafblower, rest, broom, binoculars, weld, hangout, statue")
	msg("Example: /e sit")
	msg("Press X to cancel")
end, false)


function msg(text)
    TriggerEvent("chatMessage",  "[Emotes]", {5,96,251}, text)
end

RegisterCommand("e",function(source, args)
	local player = PlayerPedId()
	if tostring(args[1]) == nil then
		print("Invalid syntax, correct syntax is: /e <animation> ")
		return
	else
		if tostring(args[1]) ~= nil then
            local argh = tostring(args[1])

			if argh == 'surrender' then
				local surrendered = false
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then 
					loadAnimDict( "random@arrests" )
					loadAnimDict( "random@arrests@busted" )
					if ( IsEntityPlayingAnim( player, "random@arrests@busted", "idle_a", 3 ) ) then 
						TaskPlayAnim( player, "random@arrests@busted", "exit", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
						Wait (3000)
						TaskPlayAnim( player, "random@arrests", "kneeling_arrest_get_up", 8.0, 1.0, -1, 128, 0, 0, 0, 0 )
						surrendered = false
					else
						TaskPlayAnim( player, "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
						Wait (4000)
						TaskPlayAnim( player, "random@arrests", "kneeling_arrest_idle", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
						Wait (500)
						TaskPlayAnim( player, "random@arrests@busted", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
						Wait (1000)
						TaskPlayAnim( player, "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, 0, 0, 0 )
						Wait(100)
						surrendered = true
					end     
				end

				Citizen.CreateThread(function() --disabling controls while surrendured
					while surrendered do
						Citizen.Wait(0)
						if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests@busted", "idle_a", 3) then
							DisableControlAction(1, 140, true)
							DisableControlAction(1, 141, true)
							DisableControlAction(1, 142, true)
							DisableControlAction(0,21,true)
						end
					end
				end)


			elseif argh == 'salute' then
				local ad = "anim@mp_player_intuppersalute"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "idle_a", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (600)
						ClearPedSecondaryTask(PlayerPedId())
					else
						TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end     
				end
			elseif argh == 'finger' then
				local ad = "anim@mp_player_intselfiethe_bird"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "idle_a", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
						ClearPedSecondaryTask(PlayerPedId())
					else
						TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end     
				end
			elseif argh == 'finger2' then
				local ad = "anim@mp_player_intupperfinger"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "idle_a", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
						ClearPedSecondaryTask(PlayerPedId())
					else
						TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end     
				end
			elseif argh == 'palm' then
				local ad = "anim@mp_player_intupperface_palm"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "idle_a", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
						ClearPedSecondaryTask(PlayerPedId())
					else
						TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end     
				end
			elseif argh == 'notes' then
				local ad = "missheistdockssetup1clipboard@base"
				
				local prop_name = prop_name or 'prop_notepad_01'
				local secondaryprop_name = secondaryprop_name or 'prop_pencil_01'
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "base", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
						ClearPedSecondaryTask(PlayerPedId())
						DetachEntity(prop, 1, 1)
						DeleteObject(prop)
						DetachEntity(secondaryprop, 1, 1)
						DeleteObject(secondaryprop)
					else
						local x,y,z = table.unpack(GetEntityCoords(player))
						prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
						secondaryprop = CreateObject(GetHashKey(secondaryprop_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 18905), 0.1, 0.02, 0.05, 10.0, 0.0, 0.0, true, true, false, true, 1, true) -- notepad
						AttachEntityToEntity(secondaryprop, player, GetPedBoneIndex(player, 58866), 0.12, 0.0, 0.001, -150.0, 0.0, 0.0, true, true, false, true, 1, true) -- pencil
						TaskPlayAnim( player, ad, "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end     
				end
			elseif argh == 'foldarms2' then
				local ad = "missfbi_s4mop"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "guard_idle_a", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					else
						TaskPlayAnim( player, ad, "guard_idle_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end 
				end
			elseif argh == 'umbrella' then
				local ad = "amb@world_human_drinking@coffee@male@base"
				
				local prop_name = prop_name or 'p_amb_brolly_01'
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "base", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
						DetachEntity(prop, 1, 1)
						DeleteObject(prop)
						ClearPedSecondaryTask(PlayerPedId())
					else
						local x,y,z = table.unpack(GetEntityCoords(player))
						prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 57005), 0.15, 0.005, -0.02, 80.0, -20.0, 175.0, true, true, false, true, 1, true)
						TaskPlayAnim( player, ad, "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end 
				end
			elseif argh == 'brief' then
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then 
					GiveWeaponToPed(player, 0x88C78EB7, 1, false, true);
				end
			elseif argh == 'brief2' then
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then 
					GiveWeaponToPed(player, 0x01B79F17, 1, false, true);
				end
			elseif argh == 'foldarms' then
				local ad = "oddjobs@assassinate@construction@"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "unarmed_fold_arms", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					else
						TaskPlayAnim( player, ad, "unarmed_fold_arms", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )

					end     
				end
			elseif argh == 'damn' then
				local ad = "gestures@m@standing@casual"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "gesture_damn", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					else
						TaskPlayAnim( player, ad, "gesture_damn", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end     
				end
			elseif argh == 'fail' then
				local ad = "random@car_thief@agitated@idle_a"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "agitated_idle_a", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					else
						TaskPlayAnim( player, ad, "agitated_idle_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end     
				end
			elseif argh == 'gang1' then
				local ad = "mp_player_int_uppergang_sign_a"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "mp_player_int_gang_sign_a", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					else
						TaskPlayAnim( player, ad, "mp_player_int_gang_sign_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end     
				end
			elseif argh == 'gang2' then
				local ad = "mp_player_int_uppergang_sign_b"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "mp_player_int_gang_sign_b", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					else
						TaskPlayAnim( player, ad, "mp_player_int_gang_sign_b", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end     
				end
			elseif argh == 'no' then
				local ad = "mp_player_int_upper_nod"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "mp_player_int_nod_no", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					else
						TaskPlayAnim( player, ad, "mp_player_int_nod_no", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end     
				end
			elseif argh == 'pickbutt' then
				local ad = "mp_player_int_upperarse_pick"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "mp_player_int_arse_pick", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					else
						TaskPlayAnim( player, ad, "mp_player_int_arse_pick", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end     
				end
			elseif argh == 'grabcrotch' then
				local ad = "mp_player_int_uppergrab_crotch"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "mp_player_int_grab_crotch", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					else
						TaskPlayAnim( player, ad, "mp_player_int_grab_crotch", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end     
				end
			elseif argh == 'peace' then
				local ad = "mp_player_int_upperpeace_sign"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "mp_player_int_peace_sign", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					else
						TaskPlayAnim( player, ad, "mp_player_int_peace_sign", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end     
				end
			elseif argh == 'cigar' then
				local cigar_name = cigar_name or 'prop_cigar_02' --noprop
				local playerPed = PlayerPedId()
				
				if ( DoesEntityExist( playerPed ) and not IsEntityDead( playerPed )) then 
					if IsCigar then
						Wait(500)
						DetachEntity(cigar, 1, 1)
						DeleteObject(cigar)
						IsCigar = false
					else
						IsCigar = true
						Wait(500)
						local x,y,z = table.unpack(GetEntityCoords(playerPed))
						cigar = CreateObject(GetHashKey(cigar_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(cigar, playerPed, GetPedBoneIndex(playerPed, 47419), 0.015, -0.0001, 0.003, 55.0, 0.0, -85.0, true, true, false, true, 1, true)
					end     
				end
			elseif argh == 'cigar2' then
				local cigar_name = cigar_name or 'prop_cigar_01' --noprop
				local playerPed = PlayerPedId()
				
				if ( DoesEntityExist( playerPed ) and not IsEntityDead( playerPed )) then 
					if IsCigar then
						Wait(500)
						DetachEntity(cigar, 1, 1)
						DeleteObject(cigar)
						IsCigar = false
					else
						IsCigar = true
						Wait(500)
						local x,y,z = table.unpack(GetEntityCoords(playerPed))
						cigar = CreateObject(GetHashKey(cigar_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(cigar, playerPed, GetPedBoneIndex(playerPed, 47419), 0.015, -0.0001, 0.003, 55.0, 0.0, -85.0, true, true, false, true, 1, true)
					end     
				end
			elseif argh == 'joint' then
				local cigar_name = cigar_name or 'p_cs_joint_02' --noprop
				local playerPed = PlayerPedId()
				
				if ( DoesEntityExist( playerPed ) and not IsEntityDead( playerPed )) then 
					if IsCigar then
						Wait(500)
						DetachEntity(cigar, 1, 1)
						DeleteObject(cigar)
						IsCigar = false
					else
						IsCigar = true
						Wait(500)
						local x,y,z = table.unpack(GetEntityCoords(playerPed))
						cigar = CreateObject(GetHashKey(cigar_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(cigar, playerPed, GetPedBoneIndex(playerPed, 47419), 0.015, -0.009, 0.003, 55.0, 0.0, 110.0, true, true, false, true, 1, true)
					end     
				end
			elseif argh == 'cig' then
				local cigar_name = cigar_name or 'prop_amb_ciggy_01' --noprop
				local playerPed = PlayerPedId()
				
				if ( DoesEntityExist( playerPed ) and not IsEntityDead( playerPed )) then 
					if IsCigar then
						Wait(500)
						DetachEntity(cigar, 1, 1)
						DeleteObject(cigar)
						IsCigar = false
					else
						IsCigar = true
						Wait(500)
						local x,y,z = table.unpack(GetEntityCoords(playerPed))
						cigar = CreateObject(GetHashKey(cigar_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(cigar, playerPed, GetPedBoneIndex(playerPed, 47419), 0.015, -0.009, 0.003, 55.0, 0.0, 110.0, true, true, false, true, 1, true)
					end     
				end
			elseif argh == 'holdcigar' then
				local cigar_name = cigar_name or 'prop_cigar_03' --noprop
				local playerPed = PlayerPedId()
				
				if ( DoesEntityExist( playerPed ) and not IsEntityDead( playerPed )) then 
					if IsCigar then
						Wait(500)
						DetachEntity(cigar, 1, 1)
						DeleteObject(cigar)
						IsCigar = false
					else
						IsCigar = true
						Wait(500)
						local x,y,z = table.unpack(GetEntityCoords(playerPed))
						cigar = CreateObject(GetHashKey(cigar_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(cigar, playerPed, GetPedBoneIndex(playerPed, 26611), 0.045, -0.05, -0.010, -75.0, 0.0, 65.0, true, true, false, true, 1, true)
					end     
				end
			elseif argh == 'holdcig' then
				local cigar_name = cigar_name or 'prop_amb_ciggy_01' --noprop
				local playerPed = PlayerPedId()
				
				if ( DoesEntityExist( playerPed ) and not IsEntityDead( playerPed )) then 
					if IsCigar then
						Wait(500)
						DetachEntity(cigar, 1, 1)
						DeleteObject(cigar)
						IsCigar = false
					else
						IsCigar = true
						Wait(500)
						local x,y,z = table.unpack(GetEntityCoords(playerPed))
						cigar = CreateObject(GetHashKey(cigar_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(cigar, playerPed, GetPedBoneIndex(playerPed, 26611), 0.035, -0.01, -0.010, 100.0, 0.0, -100.0, true, true, false, true, 1, true)
					end     
				end
			elseif argh == 'holdjoint' then
				local cigar_name = cigar_name or 'p_cs_joint_02' --noprop
				local playerPed = PlayerPedId()
				
				if ( DoesEntityExist( playerPed ) and not IsEntityDead( playerPed )) then 
					if IsCigar then
						Wait(500)
						DetachEntity(cigar, 1, 1)
						DeleteObject(cigar)
						IsCigar = false
					else
						IsCigar = true
						Wait(500)
						local x,y,z = table.unpack(GetEntityCoords(playerPed))
						cigar = CreateObject(GetHashKey(cigar_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(cigar, playerPed, GetPedBoneIndex(playerPed, 26611), 0.035, -0.01, -0.010, 100.0, 0.0, -100.0, true, true, false, true, 1, true)
					end     
				end
			elseif argh == 'dead' then
				local ad = "misslamar1dead_body"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "dead_idle", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 33, 0, 0, 0, 0 )
					else
						TaskPlayAnim( player, ad, "dead_idle", 8.0, 1.0, -1, 33, 0, 0, 0, 0 )
					end     
				end
			elseif argh == 'holster' then
				local ad = "move_m@intimidation@cop@unarmed"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "idle", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					else
						TaskPlayAnim( player, ad, "idle", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end     
				end
			elseif argh == 'guard' then
				local ad = "rcmepsilonism8"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "base_carrier", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					else
						TaskPlayAnim( player, ad, "base_carrier", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end     
				end

			elseif argh == 'box' then
				local ad = "anim@heists@box_carry@"
				
				local prop_name = prop_name or 'hei_prop_heist_box'
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "idle", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 49, 0, 0, 0, 0 )
						DetachEntity(prop, 1, 1)
						DeleteObject(prop)
						Wait(1000)
						ClearPedSecondaryTask(PlayerPedId())
					else
						local x,y,z = table.unpack(GetEntityCoords(player))
						prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
						TaskPlayAnim( player, ad, "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
					end 
				end
			elseif argh == 'slowclap' then
				local ad = "anim@mp_player_intcelebrationmale@slow_clap"
			
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then 
					if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then 
						loadAnimDict( ad )
						if ( IsEntityPlayingAnim( player, ad, "slow_clap", 3 ) ) then 
							TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 49, 0, 0, 0, 0 )
							ClearPedSecondaryTask(player)
							Wait (100)
						else
							TaskPlayAnim( player, ad, "slow_clap", 3.0, 1.0, -1, 49, 0, 0, 0, 0 )
							Wait (500)
						end       
					end
				end

			elseif argh == 'cheer' then
				local ad = "amb@world_human_cheering@male_a"
			
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then 
					if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then 
						loadAnimDict( ad )
						if ( IsEntityPlayingAnim( player, ad, "base", 3 ) ) then 
							TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 49, 0, 0, 0, 0 )
							ClearPedSecondaryTask(player)
							Wait (100)
						else
							TaskPlayAnim( player, ad, "base", 3.0, 1.0, -1, 49, 0, 0, 0, 0 )
							Wait (500)
						end       
					end
				end

			elseif argh == 'bum' then
				local ad = "amb@lo_res_idles@"
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "world_human_bum_slumped_left_lo_res_base", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 33, 0, 0, 0, 0 )
						Wait (100)
					else
						TaskPlayAnim( player, ad, "world_human_bum_slumped_left_lo_res_base", 5.0, 1.0, -1, 33, 0, 0, 0, 0 )
						Wait (500)
					end     
				end
			elseif argh == 'leanwall' then
				local ad = "amb@lo_res_idles@"
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "world_human_lean_male_foot_up_lo_res_base", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 33, 0, 0, 0, 0 )
						Wait (100)
					else
						TaskPlayAnim( player, ad, "world_human_lean_male_foot_up_lo_res_base", 8.0, 1.0, -1, 33, 0, 0, 0, 0 )
						Wait (500)
					end     
				end
			elseif argh == 'copcrowd' then
				local ad = "amb@code_human_police_crowd_control@idle_a" --- insert the animation dic here
				local anim = "idle_a" --- insert the animation name here
				
			
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
						ClearPedSecondaryTask(player)
					else
						TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
					end       
				end
			elseif argh == 'copcrowd2' then
				local ad = "amb@code_human_police_crowd_control@idle_b" --- insert the animation dic here
				local anim = "idle_d" --- insert the animation name here
				local player = PlayerPedId()
				
			
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
						ClearPedSecondaryTask(player)
					else
						TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
					end       
				end
				
			elseif argh == 'copidle' then

				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
					if IsPedActiveInScenario(player) then
						ClearPedTasks(player)
					else
						TaskStartScenarioInPlace(player, 'WORLD_HUMAN_COP_IDLES', 0, 1)   
					end 
				end
			elseif argh == 'sit' then

				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
					if IsPedActiveInScenario(player) then
						ClearPedTasks(player)
					else
						TaskStartScenarioInPlace(player, 'WORLD_HUMAN_PICNIC', 0, 1)   
					end 
				end
			elseif argh == 'hoe' then

				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
					if IsPedActiveInScenario(player) then
						ClearPedTasks(player)
					else
						TaskStartScenarioInPlace(player, 'WORLD_HUMAN_PROSTITUTE_HIGH_CLASS', 0, 1)
					end
				end 
			elseif argh == 'hoe2' then

				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
					if IsPedActiveInScenario(player) then
						ClearPedTasks(player)
					else
						TaskStartScenarioInPlace(player, 'WORLD_HUMAN_PROSTITUTE_LOW_CLASS', 0, 1)
					end
				end
			elseif argh == 'investigate' then

				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
					if IsPedActiveInScenario(player) then
						ClearPedTasks(player)
					else
						TaskStartScenarioInPlace(player, 'CODE_HUMAN_POLICE_INVESTIGATE', 0, 1)
					end
				end 
			elseif argh == 'camera' then

				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
					if IsPedActiveInScenario(player) then
						ClearPedTasks(player)
					else
						TaskStartScenarioInPlace(player, 'WORLD_HUMAN_PAPARAZZI', 0, 1)
					end
				end 
			elseif argh == 'pushups' then

				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
					if IsPedActiveInScenario(player) then
						ClearPedTasks(player)
					else
						TaskStartScenarioInPlace(player, 'WORLD_HUMAN_PUSH_UPS', 0, 1)
					end
				end 
			elseif argh == 'situps' then

				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
					if IsPedActiveInScenario(player) then
						ClearPedTasks(player)
					else
						TaskStartScenarioInPlace(player, 'WORLD_HUMAN_SIT_UPS', 0, 1)
					end
				end
			elseif argh == 'impatient' then

				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
					if IsPedActiveInScenario(player) then
						ClearPedTasks(player)
					else
						TaskStartScenarioInPlace(player, 'WORLD_HUMAN_STAND_IMPATIENT', 0, 1)
					end
				end 
			elseif argh == 'diggit' then

				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
					if IsPedActiveInScenario(player) then
						ClearPedTasks(player)
					else
						TaskStartScenarioInPlace(player, 'WORLD_HUMAN_STRIP_WATCH_STAND', 0, 1)
					end
				end
			elseif argh == 'flex' then

				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
					if IsPedActiveInScenario(player) then
						ClearPedTasks(player)
					else
						TaskStartScenarioInPlace(player, 'WORLD_HUMAN_MUSCLE_FLEX', 0, 1)
					end
				end 
				elseif argh == 'jog' then

				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
					if IsPedActiveInScenario(player) then
						ClearPedTasks(player)
					else
						TaskStartScenarioInPlace(player, 'WORLD_HUMAN_JOG_STANDING', 0, 1)
					end
				end  
			elseif argh == 'sunbath' then

				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
					if IsPedActiveInScenario(player) then
						ClearPedTasks(player)
					else
						TaskStartScenarioInPlace(player, 'WORLD_HUMAN_SUNBATHE_BACK', 0, 1)
					end
				end
			elseif argh == 'sunbath2' then

				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
					if IsPedActiveInScenario(player) then
						ClearPedTasks(player)
					else
						TaskStartScenarioInPlace(player, 'WORLD_HUMAN_SUNBATHE', 0, 1)
					end
				end 
			elseif argh == 'yoga' then

				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
					if IsPedActiveInScenario(player) then
						ClearPedTasks(player)
					else
						TaskStartScenarioInPlace(player, 'WORLD_HUMAN_YOGA', 0, 1)
					end
				end
			elseif argh == 'kneel' then

				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
					if IsPedActiveInScenario(player) then
						ClearPedTasks(player)
					else
						TaskStartScenarioInPlace(player, 'CODE_HUMAN_MEDIC_KNEEL', 0, 1)
					end
				end
			elseif argh == 'fidget' then

				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
					if IsPedActiveInScenario(player) then
						ClearPedTasks(player)
					else
						TaskStartScenarioInPlace(player, 'WORLD_HUMAN_BUM_STANDING', 0, 1)
					end
				end
			elseif argh == 'wash' then

				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
					if IsPedActiveInScenario(player) then
						ClearPedTasks(player)
					else
						TaskStartScenarioInPlace(player, 'WORLD_HUMAN_BUM_WASH', 0, 1)
					end
				end
			elseif argh == 'clean' then

				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
					if IsPedActiveInScenario(player) then
						ClearPedTasks(player)
					else
						TaskStartScenarioInPlace(player, 'WORLD_HUMAN_MAID_CLEAN', 0, 1)
					end
				end
			elseif argh == 'map' then

				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
					if IsPedActiveInScenario(player) then
						ClearPedTasks(player)
					else
						TaskStartScenarioInPlace(player, 'WORLD_HUMAN_TOURIST_MAP', 0, 1)
					end
				end
			elseif argh == 'selfie' then

				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
					if IsPedActiveInScenario(player) then
						ClearPedTasks(player)
					else
						TaskStartScenarioInPlace(player, 'WORLD_HUMAN_TOURIST_MOBILE', 0, 1)
					end
				end
			elseif argh == 'bongos' then

				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
					if IsPedActiveInScenario(player) then
						ClearPedTasks(player)
					else
						TaskStartScenarioInPlace(player, 'WORLD_HUMAN_MUSICIAN', 0, 1)
					end
				end
			elseif argh == 'workout' then

				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
					if IsPedActiveInScenario(player) then
						ClearPedTasks(player)
					else
						TaskStartScenarioInPlace(player, 'WORLD_HUMAN_MUSCLE_FREE_WEIGHTS', 0, 1)
					end
				end
			elseif argh == 'leafblower' then

				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
					if IsPedActiveInScenario(player) then
						ClearPedTasks(player)
					else
						TaskStartScenarioInPlace(player, 'WORLD_HUMAN_GARDENER_LEAF_BLOWER', 0, 1)
					end
				end
			elseif argh == 'rest' then

				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
					if IsPedActiveInScenario(player) then
						ClearPedTasks(player)
					else
						TaskStartScenarioInPlace(player, 'WORLD_HUMAN_BUM_SLUMPED', 0, 1)
					end
				end
			elseif argh == 'broom' then

				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
					if IsPedActiveInScenario(player) then
						ClearPedTasks(player)
					else
						TaskStartScenarioInPlace(player, 'WORLD_HUMAN_JANITOR', 0, 1)
					end
				end
			elseif argh == 'hangout' then

				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
					if IsPedActiveInScenario(player) then
						ClearPedTasks(player)
					else
						TaskStartScenarioInPlace(player, 'WORLD_HUMAN_HANG_OUT_STREET', 0, 1)
					end
				end
			elseif argh == 'binoculars' then

				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
					if IsPedActiveInScenario(player) then
						ClearPedTasks(player)
					else
						TaskStartScenarioInPlace(player, 'WORLD_HUMAN_BINOCULARS', 0, 1)
					end
				end
			elseif argh == 'weld' then

				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
					if IsPedActiveInScenario(player) then
						ClearPedTasks(player)
					else
						TaskStartScenarioInPlace(player, 'WORLD_HUMAN_WELDING', 0, 1)
					end
				end
			elseif argh == 'statue' then

				if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
					if IsPedActiveInScenario(player) then
						ClearPedTasks(player)
					else
						TaskStartScenarioInPlace(player, 'WORLD_HUMAN_HUMAN_STATUE', 0, 1)
					end
				end
			end
		end
	end
end, false)

----Use /testanimation command, you can use this to easily test new animations---

RegisterCommand("testanimation",function(source, args)

	local ad = "amb@code_human_police_crowd_control@idle_b" --- insert the animation dic here
	local anim = "idle_d" --- insert the animation name here
	local player = PlayerPedId()
	

	if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
		loadAnimDict( ad )
		TriggerEvent('chatMessage', '^2 Testing Animation')
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

--limp animation (prevents crouch, and you limp, im evil i know)-----------------------
local hurt = false
Citizen.CreateThread(function()
    while true do
        Wait(0)
        if GetEntityHealth(GetPlayerPed(-1)) <= 150 then
            setHurt()
        elseif hurt and GetEntityHealth(GetPlayerPed(-1)) > 151 then
            setNotHurt()
        end
    end
end)

function setHurt()
    hurt = true
    RequestAnimSet("move_m@injured")
    SetPedMovementClipset(GetPlayerPed(-1), "move_m@injured", true)
end

function setNotHurt()
    hurt = false
    ResetPedMovementClipset(GetPlayerPed(-1))
    ResetPedWeaponMovementClipset(GetPlayerPed(-1))
    ResetPedStrafeClipset(GetPlayerPed(-1))
end


-----crouch-----
local crouched = false

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

        local ped = GetPlayerPed(-1)

        if DoesEntityExist(ped) and not IsEntityDead(ped) then 
            DisableControlAction(0, 36, true) -- INPUT_DUCK  

            if not IsPauseMenuActive() then 
                if IsDisabledControlJustPressed( 0, 36 ) then 
                    RequestAnimSet('move_ped_crouched')

                    while not HasAnimSetLoaded('move_ped_crouched') do 
                        Citizen.Wait(100)
                    end 

                    if crouched == true then 
                        ResetPedMovementClipset(ped, 0)
                        crouched = false 
                    elseif crouched == false then
                        SetPedMovementClipset(ped, 'move_ped_crouched', 0.25)
                        crouched = true 
                    end 
                end
            end 
        end 
    end
end)

-----------------knockout-------------
local knockedOut = false
local wait = 15
local count = 60

Citizen.CreateThread(function()
	while true do
		Wait(1)
		local myPed = GetPlayerPed(-1)
		if IsPedInMeleeCombat(myPed) then
			if GetEntityHealth(myPed) < 115 then
				SetPedToRagdoll(myPed, 1000, 1000, 0, 0, 0, 0)
				ShowNotification("~r~You were knocked out!")
				wait = 7
				knockedOut = true
				SetEntityHealth(myPed, 116)
			end
		end
		if knockedOut == true then
			DisablePlayerFiring(PlayerId(), true)
			SetPedToRagdoll(myPed, 1000, 1000, 0, 0, 0, 0)
			ResetPedRagdollTimer(myPed)
			
			if wait >= 0 then
				count = count - 1
				if count == 0 then
					count = 60
					wait = wait - 1
					SetEntityHealth(myPed, GetEntityHealth(myPed)+4)
				end
			else
				SetPlayerInvincible(PlayerId(), false)
				knockedOut = false
			end
		end
	end
end)
	
----------------------------------------------------------------------------------------------------------------------------
------------------------------------------------ functions -----------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
----knckout----
function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

--limp--------
function setHurt()
	hurt = true
	RequestAnimSet("move_m@injured")
	SetPedMovementClipset(GetPlayerPed(-1), "move_m@injured", true)
end

function setNotHurt()
	hurt = false
	ResetPedMovementClipset(GetPlayerPed(-1))
	ResetPedWeaponMovementClipset(GetPlayerPed(-1))
	ResetPedStrafeClipset(GetPlayerPed(-1))
end
------------------------------------------------------
Citizen.CreateThread(function(prop_name, secondaryprop_name)
	while true do
		Citizen.Wait(500)
		if IsPedRagdoll(PlayerPedId()) then 
			local playerPed = PlayerPedId()
			local prop_name = prop_name
			local secondaryprop_name = secondaryprop_name
			DetachEntity(prop, 1, 1)
			DeleteObject(prop)
			DetachEntity(secondaryprop, 1, 1)
			DeleteObject(secondaryprop)
		end
	end
end)	

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(0)
		if IsControlJustReleased(0, 73) then
			ClearPedTasks(GetPlayerPed(-1))
		  DetachEntity(prop, 1, 1)
		  DeleteObject(prop)
		  DetachEntity(secondaryprop, 1, 1)
		  DeleteObject(secondaryprop)
		end
  
	end
	end)


	-------------------------
-- NoGrip 
-------------------------

local ragdoll_chance = 0.20 -- edit this decimal value for chance of falling (e.g. 80% = 0.8    75% = 0.75    32% = 0.32)

-- code, not recommended to edit below this point
print('chance of falling set to: ' .. ragdoll_chance)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100) -- check every 100 ticks, performance matters
		local ped = PlayerPedId()
		if IsPedOnFoot(ped) and not IsPedSwimming(ped) and (IsPedRunning(ped) or IsPedSprinting(ped)) and not IsPedClimbing(ped) and IsPedJumping(ped) and not IsPedRagdoll(ped) then
			local chance_result = math.random()
			print('lose grip result: ' .. chance_result)
			if chance_result < ragdoll_chance then 
				Citizen.Wait(600) -- roughly when the ped loses grip
                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.02) -- change this float to increase/decrease camera shake
				SetPedToRagdoll(ped, 5000, 1, 2)
				print('falling!')
			else
				Citizen.Wait(2000) -- cooldown before continuing
			end
		end
	end
end)

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

-----pointing

local mp_pointing = false
local keyPressed = false

local function startPointing()
    local ped = GetPlayerPed(-1)
    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do
        Wait(0)
    end
    SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
    SetPedConfigFlag(ped, 36, 1)
    Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")
end

local function stopPointing()
    local ped = GetPlayerPed(-1)
    Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
    if not IsPedInjured(ped) then
        ClearPedSecondaryTask(ped)
    end
    if not IsPedInAnyVehicle(ped, 1) then
        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
    end
    SetPedConfigFlag(ped, 36, 0)
    ClearPedSecondaryTask(PlayerPedId())
end

local once = true
local oldval = false
local oldvalped = false

Citizen.CreateThread(function()
    while true do
        Wait(0)

        if once then
            once = false
        end

        if not keyPressed then
            if IsControlPressed(0, 29) and not mp_pointing and IsPedOnFoot(PlayerPedId()) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
                Wait(200)
                if not IsControlPressed(0, 29) then
                    keyPressed = true
                    startPointing()
                    mp_pointing = true
                else
                    keyPressed = true
                    while IsControlPressed(0, 29) do
                        Wait(50)
                    end
                end
            elseif (IsControlPressed(0, 29) and mp_pointing) or (not IsPedOnFoot(PlayerPedId()) and mp_pointing) then
                keyPressed = true
                mp_pointing = false
                stopPointing()
            end
        end

        if keyPressed then
            if not IsControlPressed(0, 29) then
                keyPressed = false
            end
        end

        -- stop pointing when cuffed
        if IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) and mp_pointing then
            mp_pointing = false
            stopPointing()
        end
        
        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) and not mp_pointing then
            stopPointing()
        end

        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) then
            if not IsPedOnFoot(PlayerPedId()) then
                stopPointing()
            else
                local ped = GetPlayerPed(-1)
                local camPitch = GetGameplayCamRelativePitch()
                if camPitch < -70.0 then
                    camPitch = -70.0
                elseif camPitch > 42.0 then
                    camPitch = 42.0
                end
                camPitch = (camPitch + 70.0) / 112.0

                local camHeading = GetGameplayCamRelativeHeading()
                local cosCamHeading = Cos(camHeading)
                local sinCamHeading = Sin(camHeading)
                if camHeading < -180.0 then
                    camHeading = -180.0
                elseif camHeading > 180.0 then
                    camHeading = 180.0
                end
                camHeading = (camHeading + 180.0) / 360.0

                local blocked = 0
                local nn = 0

                local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
                nn,blocked,coords,coords = GetRaycastResult(ray)

                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", camPitch)
                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", camHeading * -1.0 + 1.0)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", blocked)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)

            end
        end
    end
end)

