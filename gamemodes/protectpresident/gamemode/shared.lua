--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

//	==============================
//			INITIALIZATION
//	==============================

GM.Name 	= "Protect the President"
GM.Author 	= "Blt950"
DeriveGamemode("sandbox")


//	==============================
// 		  ADDTEAM FUNCTION
//	==============================

GMTeams = {}
function AddTeam(Name, colorOrTable, model, Description, DefaultClass)
	local tableSyntaxUsed = colorOrTable.r == nil -- the color is not a color table.
	local DefaultClass = DefaultClass or false

	local NewTeam = tableSyntaxUsed and colorOrTable or {color = colorOrTable, model = model, description = Description, defaultclass = DefaultClass}
	NewTeam.name = Name

	table.insert(GMTeams, NewTeam)
	team.SetUp(#GMTeams, Name, NewTeam.color)
	local Team = #GMTeams

	if type(NewTeam.model) == "table" then
		for k,v in pairs(NewTeam.model) do util.PrecacheModel(v) end
	else
		util.PrecacheModel(NewTeam.model)
	end

	return Team
end

//	==============================
// 		  ADDCLASS FUNCTION
//	==============================

GMClasses = {}
function AddClass(Name, Model, Description, Team, ShopItem, MaxSlots, DonatorOnly)
	local NewClass = {model = Model, description = Description, team = Team, shopitem = ShopItem ,maxslots = MaxSlots, donatoronly = DonatorOnly}
	NewClass.name = Name

	table.insert(GMClasses, NewClass)
	local Class = #GMClasses

	if type(NewClass.model) == "table" then
		for k,v in pairs(NewClass.model) do util.PrecacheModel(v) end
	else
		util.PrecacheModel(NewClass.model)
	end

	return Class
end

//	==============================
//			DEFINE TEAMS 
//	==============================

TEAM_CITIZEN = AddTeam("Citizen", Color(20, 150, 20, 255), {"models/player/Group01/Female_01.mdl", "models/player/Group01/Female_02.mdl", "models/player/Group01/Female_03.mdl", "models/player/Group01/Female_04.mdl",
	"models/player/Group01/Female_06.mdl", "models/player/group01/male_01.mdl", "models/player/Group01/Male_02.mdl", "models/player/Group01/male_03.mdl",
	"models/player/Group01/Male_04.mdl", "models/player/Group01/Male_05.mdl", "models/player/Group01/Male_06.mdl", "models/player/Group01/Male_07.mdl", "models/player/Group01/Male_08.mdl",
	"models/player/Group01/Male_09.mdl"}, [[The citizens do not have any agenda. 
	They're neutral and just observe the madness happening outside.]])

TEAM_PRESIDENT = AddTeam("President", Color(255, 80, 80, 255), "models/player/breen.mdl", [[The President is constantly under danger,
	terrorists are trying to kill him each day. How long can you survive?]])
TEAM_SECRETSERVICE = AddTeam("Secret Service", Color(50, 89, 255, 255), "models/player/smith.mdl", [[The Secret Service ensure the Presidents safetly,
	their job is to protect the president, and also eliminate all potential threats.]], 1)
TEAM_TERRORIST = AddTeam("Terrorist", Color(255, 140, 0, 255) , "models/player/phoenix.mdl", [[The Terrorists are trying to kill the president, what ever it takes. 
	Their mission is to eliminate the president, and infiltrate the President Office 
	by getting presidency themselves when their mission is complete.]], 6)

//	==============================
//			DEFINE CLASSES
//	==============================

CLASS_SS_AGENT = AddClass("Agent", "models/player/smith.mdl", "A regular Secret Service member.\nArmed with standard USP, and MP5 or FAMAS.", TEAM_SECRETSERVICE, nil, nil, false)
CLASS_SS_TECH = AddClass("Technician", "models/weapons/w_c4_planted.mdl", "A technical guy with keypadcrackers and other goodies.\nArmed with USP, and Keypad Cracker.", TEAM_SECRETSERVICE, nil, 2, false)
CLASS_SS_SCOUT = AddClass("Scout", "models/weapons/w_snip_awp.mdl", "A Secret Service scout member with long-rage loadout.\nArmed with standard USP, and AW50.", TEAM_SECRETSERVICE, "ss_scoutclass", 2, false)
CLASS_SS_SHIELD = AddClass("Shield", "models/weapons/w_smg_mp5.mdl", "The agents who protects the president closest.\nArmed with standard USP, and MP9 or M4A1.", TEAM_SECRETSERVICE, "shieldclass", nil, false)
CLASS_SS_GHOST = AddClass("Ghost", "models/player/archer.mdl", "A Secret Service ghost member with silent loadout.\nArmed with knife and surpressed MP5.", TEAM_SECRETSERVICE, "ghostclass", 2, true)
CLASS_SS_LEADER = AddClass("Leader", "models/props_combine/breenbust.mdl", "A Secret Service leader to command.\nArmed with standard USP, and F2000.", TEAM_SECRETSERVICE, "leaderclass", 1, true)

CLASS_T_MEMBER = AddClass("Member", "models/player/phoenix.mdl", "You're a casual member of the terrorists.\nArmed with P229R, and STEN or FAL.", TEAM_TERRORIST, nil, nil, false)
CLASS_T_ASSAULT = AddClass("Assault", "models/weapons/w_rif_ak47.mdl", "The ones who are supposed to do direct assaults.\nArmed with P229R, and AK47.", TEAM_TERRORIST, "assaultclass", nil, false)
CLASS_T_TECH = AddClass("Technician", "models/weapons/w_c4_planted.mdl", "A technical guy with keypadcrackers and other goodies.\nArmed with P229R, and Keypad Cracker.", TEAM_TERRORIST, nil, 2, false)
CLASS_T_SCOUT = AddClass("Scout", "models/weapons/w_snip_m24_6.mdl", "A Terrorist scout member with long-rage loadout.\nArmed with P229R, and M24 SNiper.", TEAM_TERRORIST, "t_scoutclass", 2, false)
CLASS_T_HEAVY = AddClass("Heavy", "models/weapons/w_m249_machine_gun.mdl", "A guy that forces his way to the premises.\nArmed with P229R and M249 Machinegun.", TEAM_TERRORIST, "heavyclass", 2, true)
CLASS_T_BOSS = AddClass("Boss", "models/Gibs/HGIBS.mdl", "You're the one who gives your team directions.\nArmed with P229R and AK74.", TEAM_TERRORIST, "bossclass", 1, true)