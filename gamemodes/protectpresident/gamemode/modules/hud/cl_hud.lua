--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--


//	==============================
//		HUD PAINT
//	==============================

local smoothhealth = 0
local smoothstamina = 0
local smootharmor = 0

local smoothhealthtext = 0

local smoothpoints = 0
local growth = 50
function GM:HUDPaint()
	if !LocalPlayer():Alive() then return end
	
	local x = 60
	local y = ScrH() - 140
	
	/*
	if ScrH() <= 1050 then
		y = ScrH()-ScrH()/7.5 //10 was before
	else
		y = ScrH()-ScrH()/10 //10 was before
	end
*/
	local health = LocalPlayer():Health()
	local stamina = LocalPlayer():GetSharedVar("stamina") or 0
	local armor = LocalPlayer():Armor() or 0
	local points = LocalPlayer():GetPlayerData("points") or 0
	local playtime = LocalPlayer():GetPlayerData("playtime") or 0

	// Smoothies
	local health = math.Clamp(LocalPlayer():Health(), 0, 100)
	smoothhealth = math.Approach(smoothhealth, health, 50*FrameTime())	

	local stamina = math.Clamp(LocalPlayer():GetSharedVar("stamina") or 0, 0, 100)
	smoothstamina = math.Approach(smoothstamina, stamina, 50*FrameTime())	

	local armor = math.Clamp(LocalPlayer():Armor(), 0, 100)
	smootharmor = math.Approach(smootharmor, armor, 50*FrameTime())

	smoothhealthtext = math.Approach(smoothhealthtext, LocalPlayer():Health(), 50*FrameTime())	
	
	growth = math.Approach(growth, 100000, 25*FrameTime())
	smoothpoints = math.Approach(smoothpoints, points, growth*FrameTime())

	// DRAWIES
	draw.RoundedBox(0, x, y-20, 350, 35, LocalPlayer():GetTeamColor()) // Teambase
	draw.RoundedBox(0, x, y+20, 350, 110, Color(25,25,25,220)) // Base

	// Draw team and points
	local jobname = LocalPlayer():GetTeamName()
	if LocalPlayer():GetSharedVar("class") then
		jobname = jobname .. " "..LocalPlayer():GetClassName()
	end

	draw.SimpleText( jobname, "ptp_HUDFontFat", x+177, y-3, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	
	draw.SimpleText( "Points: " .. math.Round(smoothpoints, 0), "ptp_HUDFont", x+10, y+25, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
	draw.SimpleText( "Played: "..math.Round(playtime/60/60, 1).."h", "ptp_HUDFont", x+340, y+25, Color(255,255,255,255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_RIGHT)

	// Bar outlines
	draw.RoundedBox(0, x+10, y+55, 330, 25, Color(255,255,255,25)) // Health
	draw.RoundedBox(0, x+10, y+85, 330, 15, Color(255,255,255,25)) // Stamina
	draw.RoundedBox(0, x+10, y+105, 330, 15, Color(255,255,255,25)) // Armor

	// Bar fills
	draw.RoundedBox(0, x+10, y+55, (smoothhealth*330)/100, 25, Color(225,0,0,2225)) // Health
	draw.SimpleText( math.Round(smoothhealthtext, 0), "ptp_HUDFont", x+177, y+68, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	draw.RoundedBox(0, x+10, y+85, (smoothstamina*330)/100, 15, Color(63,127,0,2225)) // Health
	draw.SimpleText( "Stamina", "ptp_HUDFontSmall", x+177, y+92, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	draw.RoundedBox(0, x+10, y+105, (smootharmor*330)/100, 15, Color(10,41,170,225)) // Armor
	if smootharmor == 0 then
		draw.SimpleText( "No Armor", "ptp_HUDFontSmall", x+177, y+112, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	else
		draw.SimpleText( "Armor", "ptp_HUDFontSmall", x+177, y+112, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	local ply = LocalPlayer():GetEyeTrace().Entity
	if ply:IsPlayer() and ply:GetPos():Distance(LocalPlayer():GetPos()) < 400 then
		DrawPlayerInfo(ply)
	end

	if LocalPlayer():Team() == TEAM_CITIZEN and not LocalPlayer():IsAdmin() and LocalPlayer():GetMoveType() != MOVETYPE_NOCLIP then
		draw.SimpleText( "Press F2 to change team and start killing!", "ptp_deathBig", ScrW()/2, ScrH()/2-100, Color(255,0,0,15), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	self.BaseClass:HUDPaint()
end


//	==============================
//		HUD SHOULD DRAW
//	==============================


function DrawPlayerInfo(ply)
	if !ply:GetColor().a then return end

	local pos = ply:EyePos()

	pos.z = pos.z - 25 -- The position we want is a bit above the position of the eyes
	pos = pos:ToScreen()
	pos.y = pos.y - 50 -- Move the text up a few pixels to compensate for the height of the text

	local jobname = ply:GetTeamName()
	if ply:GetSharedVar("class") then
		jobname = jobname .. " "..ply:GetClassName()
	end

	draw.DrawText(ply:GetTeamName(), "ptp_playerInfo", pos.x, pos.y, ply:GetTeamColor(), TEXT_ALIGN_CENTER)
	draw.DrawText(ply:Name(), "ptp_playerInfo", pos.x, pos.y+22, Color(255,255,255), TEXT_ALIGN_CENTER)

	local health = ply:Health()

	if health < 80 and health > 50 then
		draw.DrawText("Lightly injured", "ptp_playerInfoHealth", pos.x, pos.y-22, Color(255,255,0), TEXT_ALIGN_CENTER)
	elseif health <= 50 and health > 20 then
		draw.DrawText("Heavily injured", "ptp_playerInfoHealth", pos.x, pos.y-22, Color(255,93,0), TEXT_ALIGN_CENTER)
	elseif health <= 20 and health > 0 then
		draw.DrawText("Critically injured", "ptp_playerInfoHealth", pos.x, pos.y-22, Color(255,0,0), TEXT_ALIGN_CENTER)
	end

end

//	==============================
//		HUD SHOULD DRAW
//	==============================

function GM:HUDShouldDraw(name)
	if name == "CHudHealth" or
		name == "CHudBattery" or
		name == "CHudSuitPower" or
		(HelpToggled and name == "CHudChat") then
			return false
	else
		return true
	end
end

//	==============================
//	 DISABLE DRAWING TARGET ID
//	==============================

function GM:HUDDrawTargetID()
    return false
end