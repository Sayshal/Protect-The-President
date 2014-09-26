--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

//	==============================
//			INITIALIZATION
//	==============================

GM.Name = "Protect the President"
GM.Author = "By Blt950"

include("shared.lua")
include("core/sv_mysql.lua")
include("core/sv_networking.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("core/cl_networking.lua")
AddCSLuaFile("shared.lua")

DeriveGamemode("sandbox")


//	==============================
//			CLIENT WORKSHOP
//	==============================

// This are the addons I used. Uncomment if you want to use any of them.

/*
resource.AddWorkshop( "163806212" ) -- Adv. Dupe
resource.AddWorkshop( "160250458" ) -- Wiremod
resource.AddWorkshop( "144982052" ) -- M9K Specialities
resource.AddWorkshop( "128093075" ) -- M9K Small Arms
resource.AddWorkshop( "128091208" ) -- M9K Heavy Weapons
resource.AddWorkshop( "180495527" ) -- Evocity v33x models & mat extra
resource.AddWorkshop( "185951327" ) -- Evocity v33x map (see README.txt for instructions on GMAD Extraction for server installation!)
resource.AddWorkshop( "105115318" ) -- Fading Doors
resource.AddWorkshop( "104479467" ) -- Door STool
resource.AddWorkshop( "104479831" ) -- Stacker
resource.AddWorkshop( "107432093" ) -- Precision
resource.AddWorkshop( "104815552" ) -- SmartSnap
resource.AddWorkshop( "104483020" ) -- SCars Slim
resource.AddWorkshop( "104487316" ) -- SCars Basic
resource.AddWorkshop( "233519629" ) -- Agent Model
resource.AddWorkshop( "175387367" ) -- Splinter Model
*/

//	==============================
//			LOAD MODULES
//	==============================

print(">>> PTP --> Loading modules...")

local root = GM.FolderName.."/gamemode/modules/"
local files, folds = file.Find(root .. "*", "LUA")

for k,v in pairs(files) do
	include(root .. v)
end

for _, fold in SortedPairs(folds, true) do
	for _, File in SortedPairs(file.Find(root .. fold .."/sh_*.lua", "LUA"), true) do AddCSLuaFile(root..fold .. "/" ..File) include(root.. fold .. "/" ..File) end
	for _, File in SortedPairs(file.Find(root .. fold .."/sv_*.lua", "LUA"), true) do include(root.. fold .. "/" ..File) end
	for _, File in SortedPairs(file.Find(root .. fold .."/cl_*.lua", "LUA"), true) do AddCSLuaFile(root.. fold .. "/" ..File) end
	print(">>> PTP --> Module added: "..fold)
end
	

print(">>> PTP --> SERVER Initialized")