--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--
if SERVER then
 
	AddCSLuaFile( "sui_scoreboard/admin_buttons.lua" )
	AddCSLuaFile( "sui_scoreboard/cl_tooltips.lua" )
	AddCSLuaFile( "sui_scoreboard/player_frame.lua" )
	AddCSLuaFile( "sui_scoreboard/player_row.lua" )
	AddCSLuaFile( "sui_scoreboard/scoreboard.lua" )
	AddCSLuaFile( "sui_scoreboard/vote_button.lua" )
	
else
	include( "sui_scoreboard/scoreboard.lua" )

	SuiScoreBoard = nil
	
	timer.Simple( 1.5, function()
		function GAMEMODE:CreateScoreboard()
			if ( ScoreBoard ) then
			
				ScoreBoard:Remove()
				ScoreBoard = nil
				
			end
			
			SuiScoreBoard = vgui.Create( "suiscoreboard" )
			
			return true
		end

		function GAMEMODE:ScoreboardShow()
			if not SuiScoreBoard then
				self:CreateScoreboard()
			end

			GAMEMODE.ShowScoreboard = true
			gui.EnableScreenClicker( true )

			SuiScoreBoard:SetVisible( true )
			SuiScoreBoard:UpdateScoreboard( true )
			
			return true
		end
		
		function GAMEMODE:ScoreboardHide()
			GAMEMODE.ShowScoreboard = false
			gui.EnableScreenClicker( false )
			if SuiScoreBoard then
				SuiScoreBoard:SetVisible( false )
			end
			return true
		end
	end )
end