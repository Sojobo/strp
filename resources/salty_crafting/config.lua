Config = {}

-- Ammo given by default to crafted weapons
Config.WeaponAmmo = 140

Config.Recipes = {
	-- Can be a normal ESX item
	["WEAPON_PETROLCAN"] = { 
		{item = "metal", quantity = 10 },
		{item = "cloth", quantity = 5 }, 
	},

	["bandage"] = { 
		{item = "cloth", quantity = 1 }, 
	},
	
	["lockpick"] = { 
		{item = "bobbypin", quantity = 3 }, 
		{item = "rubberband", quantity = 1 },
	},

	-- 'Weapon parts'
	["trigger"] = { 
		{item = "metal", quantity = 1 }, 
		{item = "spring", quantity = 1 },
	},

	["semiautotrigger"] = { 
		{item = "metal", quantity = 3 }, 
		{item = "spring", quantity = 3 },
	},

	["autotrigger"] = { 
		{item = "metal", quantity = 5 }, 
		{item = "spring", quantity = 5 },
	},

	["pistolbody"] = { 
		{item = "metal", quantity = 2 }, 
	},
	
	["semiautobody"] = { 
		{item = "metal", quantity = 5 },
		{item = "spring", quantity = 2 }, 
	},

	["smgbody"] = { 
		{item = "metal", quantity = 10 },
		{item = "spring", quantity = 5 }, 
	},

	["smgclip"] = { 
		{item = "metal", quantity = 8 },
		{item = "spring", quantity = 5 }, 
	},

	["pistolclip"] = { 
		{item = "metal", quantity = 4 },
		{item = "spring", quantity = 3 }, 
	},


	-- melee
	['WEAPON_BAT'] = { 
		{item = "metal", quantity = 2 }, 
		{item = "cloth", quantity = 1},
	},
	
	['WEAPON_KNIFE'] = { 
		{item = "metal", quantity = 1 }, 
		{item = "cloth", quantity = 1},
	},

	['WEAPON_POOLCUE'] = { 
		{item = "wood", quantity = 3 }, 
	},

	['WEAPON_BOTTLE'] = { 
		{item = "brokenbottle", quantity = 1 },
		{item = "cloth", quantity = 1 }, 
	},

--guns
	['WEAPON_PISTOL'] = { 
		{item = "metal", quantity = 2 }, 
		{item = "cloth", quantity = 2},
		{item = "metalpipe", quantity = 1},
		{item = "trigger", quantity = 1},
		{item = "pistolclip", quantity = 1},

	},

	['WEAPON_VINTAGEPISTOL'] = { 
		{item = "metal", quantity = 3}, 
		{item = "cloth", quantity = 3},
		{item = "metalpipe", quantity = 1},
		{item = "trigger", quantity = 1},
		{item = "pistolbody", quantity = 1},
		{item = "pistolclip", quantity = 1},
	},

	['WEAPON_MACHINEPISTOL'] = { 
		{item = "metal", quantity = 5}, 
		{item = "cloth", quantity = 5},
		{item = "metalpipe", quantity = 1},
		{item = "semiautotrigger", quantity = 1},
		{item = "semiautobody", quantity = 1},
		{item = "pistolclip", quantity = 1},

	},

	['WEAPON_SMG'] = { 
		{item = "metal", quantity = 5}, 
		{item = "cloth", quantity = 5},
		{item = "metalpipe", quantity = 2},
		{item = "autotrigger", quantity = 1},
		{item = "smgbody", quantity = 1},
		{item = "smgclip", quantity = 1},
	},

	
}

-- Enable a shop to access the crafting menu
Config.Shop = {
	useShop = true,
	shopCoordinates = { x=1208.17, y=-3113.13, z=4.60},
	shopName = "Crafting Station",
	shopBlipID = 446,
	zoneSize = { x = 2.5, y = 2.5, z = 1.5 },
	zoneColor = { r = 255, g = 0, b = 0, a = 100 }
}

-- Enable crafting menu through a keyboard shortcut
Config.Keyboard = {
	useKeyboard = false,
	keyCode = 303
}
