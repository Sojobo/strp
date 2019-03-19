-- 'bone' use bonetag https://pastebin.com/D7JMnX1g

Config = {}
Config.RealWeapons = {
	--{name = 'WEAPON_NIGHTSTICK', hash = "", 			bone = 58271, x = -0.20, y = 0.1,  z = -0.10, xRot = -55.0,  yRot = 90.00, zRot = 5.0, category = 'melee', 		model = 'w_me_nightstick'},
	{name = 'WEAPON_HAMMER', hash = "", 				bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 265.0, zRot = 0.0, category = 'melee', 		model = 'prop_tool_hammer'},
	{name = 'WEAPON_BAT', hash = "", 				bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 265.0, zRot = 0.0, 		category = 'melee', 		model = 'w_me_bat'},
	{name = 'WEAPON_GOLFCLUB', hash = "", 			bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 265.0, zRot = 0.0, category = 'melee', 		model = 'w_me_gclub'},
	{name = 'WEAPON_HATCHET', hash = "", 				bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 265.0, zRot = 0.0, category = 'melee', 		model = 'w_me_hatchet'},
	{name = 'WEAPON_MACHETE', hash = "", 				bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 265.0, zRot = 0.0, category = 'melee', 		model = 'prop_ld_w_me_machette'},
	{name = 'WEAPON_SMG_MK2', hash = "", 			bone = 24818, x = 0.10,    y = -0.15, 	z = 0.0,     xRot = 10.0, yRot = 50.0, zRot = 0.0, category = 'machine', 	model = 'w_sb_smgmk2'},
	{name = 'WEAPON_SMG', hash = "", 				bone = 24818, x = 0.10,    y = -0.15, 	z = 0.0,     xRot = 10.0, yRot = 50.0, zRot = 0.0, category = 'machine', 	model = 'w_sb_smg'},
	{name = 'WEAPON_MG', hash = "", 				bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'machine', 	model = 'w_mg_mg'},
	{name = 'WEAPON_COMBATMG', hash = "", 			bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'machine', 	model = 'w_mg_combatmg'},
	{name = 'WEAPON_GUSENBERG', hash = "", 		bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'machine', 	model = 'w_sb_gusenberg'},
	{name = 'WEAPON_COMBATPDW', hash = "", 		bone = 24818, x = 0.10,    y = -0.15, 	z = 0.0,     xRot = 10.0, yRot = 50.0, zRot = 0.0, category = 'machine', 	model = 'w_sb_pdw'},
	{name = 'WEAPON_ASSAULTSMG', hash = "", 		bone = 24818, x = 0.10,    y = -0.15, 	z = 0.0,     xRot = 10.0, yRot = 50.0, zRot = 0.0, category = 'machine', 	model = 'w_sb_assaultsmg'},
	{name = 'WEAPON_MINISMG', hash = "", 			bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'machine', 	model = 'wb_sb_minismg'},
	{name = 'WEAPON_ASSAULTRIFLE', hash = "", 		bone = 24818, x = 0.10,    y = -0.15, 	z = 0.0,     xRot = 10.0, yRot = 50.0, zRot = 0.0, category = 'assault', 	model = 'w_ar_assaultrifle'},
	{name = 'WEAPON_CARBINERIFLE', hash = "", 		bone = 24818, x = 0.1,    y = -0.15, 	z = 0.0,     xRot = 0.0, yRot = 135.0, zRot = 0.0, category = 'assault', 	model = 'w_ar_carbinerifle'},
	{name = 'WEAPON_CARBINERIFLE_Mk2', hash = "", 	bone = 24818, x = 0.1,    y = -0.15, 	z = 0.0,     xRot = 0.0, yRot = 135.0, zRot = 0.0, category = 'assault', 	model = 'w_ar_carbineriflemk2'},
	{name = 'WEAPON_ADVANCEDRIFLE', hash = "", 	bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'assault', 	model = 'w_ar_advancedrifle'},
	{name = 'WEAPON_SPECIALCARBINE', hash = "", 	bone = 24818, x = 0.10, y = -0.15,     z = 0.0,     xRot = 0.0, yRot = 50.0, zRot = 0.0, category = 'assault', 	model = 'w_ar_specialcarbine'},
	{name = 'WEAPON_BULLPUPRIFLE', hash = "", 		bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'assault', 	model = 'w_ar_bullpuprifle'},
	{name = 'WEAPON_COMPACTRIFLE', hash = "", 		bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'assault', 	model = 'wr_ar_compact'},
	{name = 'WEAPON_SPECIALCARBINE_Mk2', hash = "", bone = 24818, x = 0.10, y = -0.15,     z = 0.0,     xRot = 0.0, yRot = 50.0, zRot = 0.0, category = 'assault', 	model = 'w_ar_specialcarbinemk2'},
	{name = 'WEAPON_PUMPSHOTGUN', hash = "", 		bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 135.0, zRot = 0.0, category = 'shotgun', 	model = 'w_sg_pumpshotgun'},
	{name = 'WEAPON_BULLPUPSHOTGUN', hash = "", 	bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 135.0, zRot = 0.0, category = 'shotgun', 	model = 'w_sg_bullpupshotgun'},
	{name = 'WEAPON_ASSAULTSHOTGUN', hash = "", 	bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'shotgun', 	model = 'w_sg_assaultshotgun'},
	{name = 'WEAPON_MUSKET', hash = "", 			bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'shotgun', 	model = 'w_ar_musket'},
	{name = 'WEAPON_HEAVYSHOTGUN', hash = "", 		bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 225.0, zRot = 0.0, category = 'shotgun', 	model = 'w_sg_heavyshotgun'},
	{name = 'WEAPON_SNIPERRIFLE', hash = "", 		bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'sniper', 	model = 'w_sr_sniperrifle'},
	{name = 'WEAPON_HEAVYSNIPER', hash = "", 		bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 135.0, zRot = 0.0, category = 'sniper', 	model = 'w_sr_heavysniper'},
	{name = 'WEAPON_MARKSMANRIFLE', hash = "", 	bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 135.0, zRot = 0.0, category = 'sniper', 	model = 'w_sr_marksmanrifle'},
	{name = 'WEAPON_FIREEXTINGUISHER', hash = "", bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'thrown', 	model = 'w_am_fire_exting'},
	{name = 'WEAPON_PETROLCAN', hash = "", 		bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'thrown', 	model = 'w_am_jerrycan'},
	{name = 'WEAPON_HANDCUFFS', hash = "", 		bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'others', 	model = ''}
}

function getRealWeapons()
	local weapons = {}
	for i=1, #Config.RealWeapons do
		table.insert(weapons, Config.RealWeapons[i].name)
	end
	return weapons
end

Citizen.CreateThread(function()
	for i=1, #Config.RealWeapons do
		Config.RealWeapons[i].hash = GetHashKey(Config.RealWeapons[i].name)
	end
end)
