--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

local icon = Material( "icon16/status_online.png" )
local function BossMark()
	
	surface.SetMaterial( icon )
	
	local pos
	local drawIt = false
	for k,v in pairs(player.GetAll()) do
		if v:Team() == TEAM_TERRORIST and v:Class() == CLASS_T_BOSS and v:Alive() and v:IsPlayer() then
			pos = v:GetPos()
			pos = pos + Vector(0,0,80)
			pos = pos:ToScreen()
			drawIt = true
		end
	end
	
	if drawIt and LocalPlayer():Team() == TEAM_TERRORIST then
		draw.SimpleText( "Boss", "Default", pos.x + 1, pos.y + 19, Color( 0, 0, 0, 196 ), TEXT_ALIGN_CENTER )
		draw.SimpleText( "Boss", "Default", pos.x, pos.y + 18, Color( 255, 255, 255, 196 ), TEXT_ALIGN_CENTER )
		
		surface.SetDrawColor( Color( 115, 45, 45, 255 ) )
		surface.DrawTexturedRect( pos.x - 16, pos.y - 16, 32, 32 )
		
		local y = pos.y + math.sin( CurTime() * 2 ) * 28
		render.SetScissorRect( pos.x - 16, y - 8, pos.x + 16, y + 8, true )
		
		surface.SetDrawColor( Color( 255, 255, 255, 128 ) )
		surface.DrawTexturedRect( pos.x - 16, pos.y - 16, 32, 32 )
		
		render.SetScissorRect( 0, 0, 0, 0, false )
	end
	
end
hook.Add( "HUDPaint", "BossMark", BossMark )
