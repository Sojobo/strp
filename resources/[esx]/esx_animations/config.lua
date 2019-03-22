Config = {}

Config.Animations = {

	{
		name  = 'festives',
		label = 'Festives',
		items = {
			{label = "Smoking", type = "scenario", data = {anim = "WORLD_HUMAN_SMOKING"}},
			{label = "Musician", type = "scenario", data = {anim = "WORLD_HUMAN_MUSICIAN"}},
			{label = "Dj", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@dj", anim = "dj"}},
			{label = "Drinking", type = "scenario", data = {anim = "WORLD_HUMAN_DRINKING"}},
			{label = "Partying", type = "scenario", data = {anim = "WORLD_HUMAN_PARTYING"}},
			{label = "Air Guitar", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@air_guitar", anim = "air_guitar"}},
			{label = "Air Shagging", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@air_shagging", anim = "air_shagging"}},
			{label = "Rock'n'roll", type = "anim", data = {lib = "mp_player_int_upperrock", anim = "mp_player_int_rock"}},
			-- {label = "Fumer un joint", type = "scenario", data = {anim = "WORLD_HUMAN_SMOKING_POT"}},
			{label = "Drunk Standing", type = "anim", data = {lib = "amb@world_human_bum_standing@drunk@idle_a", anim = "idle_a"}},
			{label = "Vomir en voiture", type = "anim", data = {lib = "oddjobs@taxi@tie", anim = "vomit_outside"}},
		}
	},

	{
		name  = 'greetings',
		label = 'Greetings',
		items = {
			{label = "Wave", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_hello"}},
			{label = "Shake", type = "anim", data = {lib = "mp_common", anim = "givetake1_a"}},
			{label = "Shake2", type = "anim", data = {lib = "mp_ped_interaction", anim = "handshake_guy_a"}},
			{label = "Bro Hug", type = "anim", data = {lib = "mp_ped_interaction", anim = "hugs_guy_a"}},
			{label = "Salute", type = "anim", data = {lib = "mp_player_int_uppersalute", anim = "mp_player_int_salute"}},
		}
	},

	{
		name  = 'work',
		label = 'Work',
		items = {
			{label = "Kneel with Hands Up", type = "anim", data = {lib = "random@arrests@busted", anim = "idle_c"}},
			{label = "Fishing", type = "scenario", data = {anim = "world_human_stand_fishing"}},
			{label = "Investigate", type = "anim", data = {lib = "amb@code_human_police_investigate@idle_b", anim = "idle_f"}},
			{label = "Radio", type = "anim", data = {lib = "random@arrests", anim = "generic_radio_chatter"}},
			{label = "Traffic", type = "scenario", data = {anim = "WORLD_HUMAN_CAR_PARK_ATTENDANT"}},
			{label = "Binoculars", type = "scenario", data = {anim = "WORLD_HUMAN_BINOCULARS"}},
			{label = "Dig", type = "scenario", data = {anim = "world_human_gardener_plant"}},
			{label = "Repair", type = "anim", data = {lib = "mini@repair", anim = "fixing_a_ped"}},
			{label = "Observe", type = "scenario", data = {anim = "CODE_HUMAN_MEDIC_KNEEL"}},
			{label = "Pour Shot", type = "anim", data = {lib = "mini@drinking", anim = "shots_barman_b"}},
			{label = "Camera", type = "scenario", data = {anim = "WORLD_HUMAN_PAPARAZZI"}},
			{label = "Clipboard", type = "scenario", data = {anim = "WORLD_HUMAN_CLIPBOARD"}},
			{label = "Hammer", type = "scenario", data = {anim = "WORLD_HUMAN_HAMMERING"}},
			{label = "Bumsign", type = "scenario", data = {anim = "WORLD_HUMAN_BUM_FREEWAY"}},
			{label = "Statue", type = "scenario", data = {anim = "WORLD_HUMAN_HUMAN_STATUE"}},
		}
	},

	{
		name  = 'humors',
		label = 'Humors',
		items = {
			{label = "Cherring", type = "scenario", data = {anim = "WORLD_HUMAN_CHEERING"}},
			{label = "Thanks", type = "anim", data = {lib = "mp_action", anim = "thanks_male_06"}},
			{label = "Point", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_point"}},
			{label = "Come Here", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_come_here_soft"}}, 
			{label = "Bring it on", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_bring_it_on"}},
			{label = "Me", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_me"}},
			{label = "Shoplift", type = "anim", data = {lib = "anim@am_hold_up@male", anim = "shoplift_high"}},
			{label = "Facepalm", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@face_palm", anim = "face_palm"}},
			{label = "Easy Now", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_easy_now"}},
			{label = "Shocked", type = "anim", data = {lib = "oddjobs@assassinate@multi@", anim = "react_big_variations_a"}},
			{label = "Cower", type = "anim", data = {lib = "amb@code_human_cower_stand@male@react_cowering", anim = "base_right"}},
			{label = "Fight", type = "anim", data = {lib = "anim@deathmatch_intros@unarmed", anim = "intro_male_unarmed_e"}},
			{label = "No Way", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_damn"}},
			{label = "Kiss", type = "anim", data = {lib = "mp_ped_interaction", anim = "kisses_guy_a"}},
			{label = "Both Middle Fingers", type = "anim", data = {lib = "mp_player_int_upperfinger", anim = "mp_player_int_finger_01_enter"}},
			{label = "Wank", type = "anim", data = {lib = "mp_player_int_upperwank", anim = "mp_player_int_wank_01"}},
		}
	},

	{
		name  = 'sports',
		label = 'Sports',
		items = {
			{label = "Flex", type = "anim", data = {lib = "amb@world_human_muscle_flex@arms_at_side@base", anim = "base"}},
			{label = "Lift", type = "anim", data = {lib = "amb@world_human_muscle_free_weights@male@barbell@base", anim = "base"}},
			{label = "Push Ups", type = "anim", data = {lib = "amb@world_human_push_ups@male@base", anim = "base"}},
			{label = "Sit Ups", type = "anim", data = {lib = "amb@world_human_sit_ups@male@base", anim = "base"}},
			{label = "Yoga", type = "anim", data = {lib = "amb@world_human_yoga@male@base", anim = "base_a"}},
		}
	},

	{
		name  = 'misc',
		label = 'Misc',
		items = {
			{label = "Lean", type = "scenario", data = {anim = "world_human_leaning"}},
			{label = "Sunbathe Back", type = "scenario", data = {anim = "WORLD_HUMAN_SUNBATHE_BACK"}},
			{label = "Sunbathe", type = "scenario", data = {anim = "WORLD_HUMAN_SUNBATHE"}},
			{label = "Clean", type = "scenario", data = {anim = "world_human_maid_clean"}},
			{label = "BBQ", type = "scenario", data = {anim = "PROP_HUMAN_BBQ"}},
			{label = "Selfie", type = "scenario", data = {anim = "world_human_tourist_mobile"}},
			{label = "Safe Cracking", type = "anim", data = {lib = "mini@safe_cracking", anim = "idle_base"}}, 
		}
	},

	{
		name  = 'attitudem',
		label = 'Attitudes',
		items = {
			{label = "Normal M", type = "attitude", data = {lib = "move_m@confident", anim = "move_m@confident"}},
			{label = "Normal F", type = "attitude", data = {lib = "move_f@heels@c", anim = "move_f@heels@c"}},
			{label = "Depressed F", type = "attitude", data = {lib = "move_m@depressed@a", anim = "move_m@depressed@a"}},
			{label = "Depressed F", type = "attitude", data = {lib = "move_f@depressed@a", anim = "move_f@depressed@a"}},
			{label = "Business", type = "attitude", data = {lib = "move_m@business@a", anim = "move_m@business@a"}},
			{label = "Brave", type = "attitude", data = {lib = "move_m@brave@a", anim = "move_m@brave@a"}},
			{label = "Casual", type = "attitude", data = {lib = "move_m@casual@a", anim = "move_m@casual@a"}},
			{label = "Fat", type = "attitude", data = {lib = "move_m@fat@a", anim = "move_m@fat@a"}},
			{label = "Hipster", type = "attitude", data = {lib = "move_m@hipster@a", anim = "move_m@hipster@a"}},
			{label = "Injured", type = "attitude", data = {lib = "move_m@injured", anim = "move_m@injured"}},
			{label = "Hurry", type = "attitude", data = {lib = "move_m@hurry@a", anim = "move_m@hurry@a"}},
			{label = "Hobo", type = "attitude", data = {lib = "move_m@hobo@a", anim = "move_m@hobo@a"}},
			{label = "Sad", type = "attitude", data = {lib = "move_m@sad@a", anim = "move_m@sad@a"}},
			{label = "Muscle", type = "attitude", data = {lib = "move_m@muscle@a", anim = "move_m@muscle@a"}},
			{label = "Shocked M", type = "attitude", data = {lib = "move_m@shocked@a", anim = "move_m@shocked@a"}},
			{label = "Shady", type = "attitude", data = {lib = "move_m@shadyped@a", anim = "move_m@shadyped@a"}},
			{label = "Fatigue", type = "attitude", data = {lib = "move_m@buzzed", anim = "move_m@buzzed"}},
			{label = "Hurry Butch", type = "attitude", data = {lib = "move_m@hurry_butch@a", anim = "move_m@hurry_butch@a"}},
			{label = "Money", type = "attitude", data = {lib = "move_m@money", anim = "move_m@money"}},
			{label = "Quick", type = "attitude", data = {lib = "move_m@quick", anim = "move_m@quick"}},
			{label = "Man Eater", type = "attitude", data = {lib = "move_f@maneater", anim = "move_f@maneater"}},
			{label = "Sassy", type = "attitude", data = {lib = "move_f@sassy", anim = "move_f@sassy"}},	
			{label = "Arrogant", type = "attitude", data = {lib = "move_f@arrogant@a", anim = "move_f@arrogant@a"}},
		}
	},
}