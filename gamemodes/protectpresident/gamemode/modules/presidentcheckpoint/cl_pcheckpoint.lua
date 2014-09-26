--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

local index
local duetime
local icon = Material( "icon16/flag_red.png" )

function doRetrieve_position()
	index = net.ReadInt(8)
	duetime = net.ReadInt(32)
end
net.Receive("ptp_selectedCheckpoint", doRetrieve_position)

function CheckpointMark()
	if (LocalPlayer():Team() == TEAM_SECRETSERVICE or LocalPlayer():Team() == TEAM_PRESIDENT) and CurrentPresident() and index and pointsEnabled then
		surface.SetMaterial( icon )

		local pos
		pos = Vector(PresidentCheckpoints[index].x, PresidentCheckpoints[index].y, PresidentCheckpoints[index].z)
		pos = pos + Vector(0,0,80)
		pos = pos:ToScreen()

		local textcol
		if duetime-CurTime() < 60 then
			textcol = Color(255,0,0,196)
		else
			textcol = Color(255,255,255, 196)
		end

		if LocalPlayer():Team() == TEAM_SECRETSERVICE then
			draw.SimpleText( "President reach checkpoint", "Default", pos.x + 1, pos.y + 19, Color( 0, 0, 0, 196 ), TEXT_ALIGN_CENTER )
			draw.SimpleText( "President reach checkpoint", "Default", pos.x, pos.y + 18, Color( 255, 255, 255, 196 ), TEXT_ALIGN_CENTER )
		else
			draw.SimpleText( "Reach Checkpoint", "Default", pos.x + 1, pos.y + 19, Color( 0, 0, 0, 196 ), TEXT_ALIGN_CENTER )
			draw.SimpleText( "Reach Checkpoint", "Default", pos.x, pos.y + 18, Color( 255, 255, 255, 196 ), TEXT_ALIGN_CENTER )
		end

		draw.SimpleText( string.ToMinutesSeconds(duetime-CurTime()), "Default", pos.x + 1, pos.y + 29, Color( 0, 0, 0, 196 ), TEXT_ALIGN_CENTER )
		draw.SimpleText( string.ToMinutesSeconds(duetime-CurTime()), "Default", pos.x, pos.y + 28, textcol, TEXT_ALIGN_CENTER )
		
		surface.SetDrawColor( Color( 115, 45, 45, 255 ) )
		surface.DrawTexturedRect( pos.x - 16, pos.y - 16, 32, 32 )
		
		local y = pos.y + math.sin( CurTime() * 2 ) * 28
		render.SetScissorRect( pos.x - 16, y - 8, pos.x + 16, y + 8, true )
		
		surface.SetDrawColor( Color( 255, 255, 255, 128 ) )
		surface.DrawTexturedRect( pos.x - 16, pos.y - 16, 32, 32 )
		
		render.SetScissorRect( 0, 0, 0, 0, false )
	end
end
hook.Add( "HUDPaint", "CheckpointMark", CheckpointMark )