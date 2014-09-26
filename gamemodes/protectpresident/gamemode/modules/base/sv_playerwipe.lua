--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

function WipePlayer(ply, command, args)

	if not ply:IsSuperAdmin() then ply:Notify("You don't have access to this function!", 1) return end
	
	local userid = args[1]
	local found = false
	local foundply = nil

	for k,v in pairs(player.GetAll()) do
		if v:UserID() == tonumber(userid) then
			found = true
			foundply = v
		end
	end

	if found then
		ply:Notify("You've wiped all data of "..foundply:Name().." ["..foundply:SteamID().."]", 1)
		foundply.ptpData = {}
		RunConsoleCommand("ulx", "kick", foundply:Name(), "Account wiped. Please reconnect.")
		writeLog(ply:Nick() .. " has wiped all data to "..foundply:Name(), Color(255, 190, 0))
	else
		ply:Notify("Player was not found. Remember to use USERID from 'status'", 1)
	end
	
end
concommand.Add("ptp_wipeplayer", WipePlayer)