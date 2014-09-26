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
include("core/cl_networking.lua")
DeriveGamemode("sandbox")

ptp = ptp or GM


//	==============================
//			LOAD MODULES
//	==============================

local root = GM.FolderName.."/gamemode/modules/"
local _, folders = file.Find(root.."*", "LUA")
for _, folder in SortedPairs(folders, true) do
	for _, File in SortedPairs(file.Find(root .. folder .."/sh_*.lua", "LUA"), true) do	include(root.. folder .. "/" ..File) end
	for _, File in SortedPairs(file.Find(root .. folder .."/cl_*.lua", "LUA"), true) do	include(root.. folder .. "/" ..File) end
end


//	==============================
//			FINIZILIATION
//	==============================

print(">>> PTP --> CLIENT Initialized")