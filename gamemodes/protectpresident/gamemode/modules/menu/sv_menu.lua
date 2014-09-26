--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--


hook.Add("ShowTeam", "ptp_showMenu", function(ply)
	ply:ConCommand( "ptp_toggleMenu 1" )
end)

hook.Add("ShowSpare1", "ptp_showMenu", function(ply)
	ply:ConCommand( "ptp_toggleMenu 2" )
end)

hook.Add("ShowSpare2", "ptp_showMenu", function(ply)
	ply:ConCommand( "ptp_toggleMenu 3" )
end)
