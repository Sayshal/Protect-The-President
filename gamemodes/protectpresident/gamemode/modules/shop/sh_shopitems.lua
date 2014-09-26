--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

GMShopCategories = {"Secret Service", "Terrorist", "Character", "Tools", "Vehicles"}
GMShop = {}
function AddUpgrade(ScriptName, Name, Description, Model, Category, Upgrades)
	local NewItem = {description = Description, model = Model, category = Category, upgrades = Upgrades}
	NewItem.name = Name

	// WE HAVE TO MAKE THE KEYS STRINGS WITH UPGRADE NAME, ELSE IT GOES FUCK ONCE UPGRADES ARE UPDATED!

	//table.insert(GMShop, NewItem)
	GMShop[ScriptName] = NewItem
	util.PrecacheModel(NewItem.model)
end

UPGRADE_SCOUTCLASS = AddUpgrade("ss_scoutclass", "Scout Class", "Unlock the Scout class as Secret Service.", "models/player/smith.mdl", "Secret Service", {{price = 225, value = 1, donator = false}})
UPGRADE_SHIELDCLASS = AddUpgrade("shieldclass", "Shield Class", "Unlock the Shield class as Secret Service.", "models/player/smith.mdl", "Secret Service", {{price = 200, value = 1, donator = false}})
UPGRADE_GHOSTCLASS = AddUpgrade("ghostclass", "Ghost Class", "[Premium Only] Unlock the Ghost class as Secret Service.", "models/player/archer.mdl", "Secret Service", {{price = 200, value = 1, donator = true}})
UPGRADE_LEADERCLASS = AddUpgrade("leaderclass", "Leader Class", "[Premium Only] Unlock the Leader class as Secret Service.", "models/player/smith.mdl", "Secret Service", {{price = 250, value = 1, donator = true}})

UPGRADE_TSCOUTCLASS = AddUpgrade("t_scoutclass", "Scout Class", "Unlock the Scout class as Terrorist.", "models/player/phoenix.mdl", "Terrorist", {{price = 225, value = 1, donator = false}})
UPGRADE_ASSAULTCLASS = AddUpgrade("assaultclass", "Assault Class", "Unlock the Assault class as Terrorist.", "models/player/phoenix.mdl", "Terrorist", {{price = 200, value = 1, donator = false}})
UPGRADE_HEAVYCLASS = AddUpgrade("heavyclass", "Heavy Class", "[Premium Only] Unlock the Heavy class as Terrorist.", "models/player/phoenix.mdl", "Terrorist", {{price = 200, value = 1, donator = true}})
UPGRADE_BOSSCLASS = AddUpgrade("bossclass", "Boss Class", "[Premium Only] Unlock the Boss class as Terrorist.", "models/player/phoenix.mdl", "Terrorist", {{price = 250, value = 1, donator = true}})

UPGRADE_SSMEMBERWEP = AddUpgrade("ss_agentwep", "Agent Weapon Upgrade", "Upgrade your MP40 to P90 for Secret Service Agent class.", "models/weapons/w_fn_p90.mdl", "Secret Service", {{price = 100, value = 1, donator = false}})
UPGRADE_SSSHIELDWEP = AddUpgrade("ss_shieldwep", "Shield Weapon Upgrade", "Upgrade your MP5 to Honey Badger for Secret Service Shield class.", "models/weapons/w_aac_honeybadger.mdl", "Secret Service",{{price = 150, value = 1, donator = false}})
UPGRADE_SSGHOSTWEP = AddUpgrade("ss_ghostwep", "Ghost Weapon Addition", "[Premium Only] Add a Dragunov SVU silenced sniper for Secret Service Ghost class.", "models/weapons/w_snip_scout.mdl", "Secret Service",{{price = 250, value = 1, donator = true}})
UPGRADE_TMEMBERWEP = AddUpgrade("t_memberwep", "Member Wep Upgrade", "Upgrade your MAC 10 to UMP for Terrorist Member class.", "models/weapons/w_hk_ump45", "Terrorist", {{price = 100, value = 1, donator = false}})
UPGRADE_TPROXMINE = AddUpgrade("t_proxmine", "Prox Mine", "Add an Proximity mine to your loadout as Terrorist Technician.", "models/weapons/w_px.mdl", "Terrorist", {{price = 100, value = 1, donator = false}})
UPGRADE_TC4 = AddUpgrade("t_c4", "C4 Bomb", "Add an C4 bomb to your loadout as Terrorist Technician.", "models/weapons/w_sb_planted.mdl", "Terrorist", {{price = 150, value = 1, donator = false}})
UPGRADE_SSPROXMINE = AddUpgrade("ss_proxmine", "Prox Mine", "Add an Proximity mine to your loadout as Secret Service Technician.", "models/weapons/w_px.mdl", "Secret Service", {{price = 100, value = 1, donator = false}})
UPGRADE_SSNERVEGAS = AddUpgrade("ss_nervegas", "Nerve Gas", "Add an Nerve Gas to your loadout as Secret Service Technician.", "models/weapons/w_sticky_grenade_thrown.mdl", "Secret Service", {{price = 150, value = 1, donator = false}})

UPGRADE_TOOLGUN = AddUpgrade("toolgun", "Toolgun", "Unlock Toolgun for permanent useage.", "models/weapons/w_toolgun.mdl", "Tools", {{price = 100, value = 1, donator = false}})
UPGRADE_WIRETOOLGUN = AddUpgrade("wiretoolgun", "Wire Toolgun", "Unlock Wire Toolgun for permanent useage.", "models/weapons/w_toolgun.mdl", "Tools", {{price = 200, value = 1, donator = false}})
UPGRADE_PHYSGUN = AddUpgrade("physgun", "Physgun", "Unlock Physgun for permanent useage.", "models/weapons/w_physics.mdl", "Tools", {{price = 50, value = 1, donator = false}})

UPGRADE_E2TOOL = AddUpgrade("expression2tool", "Expression 2", "[Premium Only] Unlock Expression 2 tool", "models/beer/wiremod/gate_e2.mdl", "Tools", {{price = 400, value = 1, donator = true}})
UPGRADE_MATCOLTOOL = AddUpgrade("materialcolortool", "Material & Color Tool", "[Premium Only] Unlock Material and Color tool", "models/weapons/w_toolgun.mdl", "Tools", {{price = 200, value = 1, donator = true}})
UPGRADE_CAMERATOOL = AddUpgrade("cameratool", "Camera Tool", "[Premium Only] Unlock Camera tool", "models/dav0r/camera.mdl", "Tools", {{price = 100, value = 1, donator = true}})

UPGRADE_GENERALCARS = AddUpgrade("generalcarsupgrade", "General Cars", "Unlock the general cars. It's most of the cars under Misc category in SCars.", "models/vigilante8/huntley1.mdl", "Vehicles", {{price = 50, value = 1, donator = false}})
UPGRADE_SPORTCARS = AddUpgrade("sportcarsupgrade", "Sport Cars", "Unlock the fast sport cars for easier escapes. It's the Sport category cars in SCars.", "models/vigilante8/dean/gtaiv/vehicles/banshee_sep.mdl", "Vehicles", {{price = 125, value = 1, donator = false}})

UPGRADE_HACKSOUND = AddUpgrade("hacksound", "Silent Cracker", "Unlock the more silent cracker, which makes much less noise than the orignial one.", "models/weapons/w_c4_planted.mdl", "Terrorist", {{price = 75, value = 1, donator = false}})
UPGRADE_HACKSPEED = AddUpgrade("hackspeed", "Cracker Speed", "Upgrade your keypad cracker to crack faster.\n\nLevel 1: 2x faster\nLevel 2: 3x faster\nLevel 3: 4x faster\n(Premium) Level 4: 5x faster\n(Premium) Level 5: 6x faster", "models/weapons/w_c4_planted.mdl", "Terrorist", {
	{price = 50, value = 2, donator = false}, 
	{price = 75, value = 3, donator = false}, 
	{price = 100, value = 4, donator = false},
	{price = 200, value = 5, donator = true},
	{price = 250, value = 6, donator = true}
})

UPGRADE_HEALTH = AddUpgrade("healthupgrade", "Health", "Increase your max health, to survive longer.\n\nLevel 1: +10 HP\nLevel 2: +20 HP\nLevel 3: +30 HP\nLevel 4: +40 HP\nLevel 5: +50 HP\n(Premium) Level 6: +70 HP\n(Premium) Level 7: +100 HP", "models/healthvial.mdl", "Character",{
	{price = 50, value = 10, donator = false}, 
	{price = 100, value = 20, donator = false}, 
	{price = 150, value = 30, donator = false},
	{price = 200, value = 40, donator = false},
	{price = 250, value = 50, donator = false},
	{price = 300, value = 70, donator = true},
	{price = 400, value = 100, donator = true}
})

UPGRADE_ARMOR = AddUpgrade("armorupgrade", "Kevlar Suit", "Incrase your armor and survive more bullets.\n\nLevel 1: 10 Armor\nLevel 2: 20 Armor\nLevel 3: 30 Armor\nLevel 4: 40 Armor\nLevel 5: 50 Armor\n(Premium) Level 6: 70 Armor\n(Premium) Level 7: 100 Armor", "models/props_combine/suit_charger001.mdl", "Character",{
	{price = 50, value = 10, donator = false}, 
	{price = 100, value = 20, donator = false}, 
	{price = 100, value = 30, donator = false},
	{price = 125, value = 40, donator = false},
	{price = 150, value = 50, donator = false},
	{price = 200, value = 70, donator = true},
	{price = 250, value = 100, donator = true}
})

UPGRADE_PROPLIMIT = AddUpgrade("proplimitupgrade", "Proplimit", "Increase your proplimit by purchasing this upgrade.\n\nLevel 1: 10 props\nLevel 2: 20 props\nLevel 3: 30 props\nLevel 4: 40 props\nLevel 5: 50 props\n(Premium) Level 6: 75 props\n(Premium) Level 7: 100 props", "models/props_junk/wood_crate001a.mdl", "Character",{
	{price = 50, value = 10, donator = false}, 
	{price = 50, value = 20, donator = false}, 
	{price = 75, value = 30, donator = false},
	{price = 100, value = 40, donator = false},
	{price = 100, value = 50, donator = false},
	{price = 125, value = 75, donator = true},
	{price = 150, value = 100, donator = true}
})

UPGRADE_AMMO = AddUpgrade("ammoupgrade", "Ammo", "Increase your starting ammo.\n\nLevel 1: +25 rounds\nLevel 2: +50 rounds\nLevel 3: +75 rounds\nLevel 4: +100 rounds\nLevel 5: +125 rounds\n(Premium) Level 6: +200 rounds\n(Premium) Level 7: +300 rounds", "models/Items/BoxBuckshot.mdl", "Character",{
	{price = 75, value = 25, donator = false}, 
	{price = 125, value = 50, donator = false}, 
	{price = 225, value = 75, donator = false},
	{price = 250, value = 100, donator = false},
	{price = 275, value = 125, donator = false},
	{price = 300, value = 200, donator = true},
	{price = 325, value = 300, donator = true}
})

UPGRADE_JUMP = AddUpgrade("jumpupgrade", "Jumpheight", "Increase your jumping height.\n\nLevel 1: 10% stronger\n(Premium) Level 2: 20% stronger\n(Premium) Level 3: 30% stronger", "models/Items/combine_rifle_ammo01.mdl", "Character", {
	{price = 50, value = 1.1, donator = false}, 
	{price = 100, value = 1.2, donator = true},
	{price = 200, value = 1.3, donator = true}
})

UPGRADE_STAMINA = AddUpgrade("staminaupgrade", "Stamina", "Increase your running length and time by purchasing additional stamina.\n\nLevel 1: 15% longer\nLevel 2: 30% longer\n(Premium) Level 3: 45% longer\n(Premium) Level 4: 60% longer", "models/props_junk/PopCan01a.mdl", "Character", {
	{price = 50, value = 1.15, donator = false}, 
	{price = 100, value = 1.30, donator = false}, 
	{price = 200, value = 1.45, donator = true},
	{price = 300, value = 1.60, donator = true}
})

UPGRADE_RUNSPEED = AddUpgrade("runspeedupgrade", "Run Speed", "Increase your running speed.\n\nLevel 1: 15% faster\nLevel 2: 30% faster\n(Premium) Level 3: 45% faster\n(Premium) Level 4: 60% faster", "models/props_c17/statue_horse.mdl", "Character",{
	{price = 50, value = 1.15, donator = false}, 
	{price = 100, value = 1.30, donator = false}, 
	{price = 125, value = 1.45, donator = true},
	{price = 150, value = 1.60, donator = true}
})

