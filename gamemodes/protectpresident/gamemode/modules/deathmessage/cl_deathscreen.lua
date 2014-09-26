--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

surface.CreateFont( "ptp_deathBig", {
	font = "Trebuchet",
	size = 50,
	weight = 800,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

local tab =
{
 ["$pp_colour_addr"] = 200,
 ["$pp_colour_addg"] = 0,
 ["$pp_colour_addb"] = 0,
 ["$pp_colour_brightness"] = -0.04,
 ["$pp_colour_contrast"] = 1.35,
 ["$pp_colour_colour"] = 5,
 ["$pp_colour_mulr"] = 0,
 ["$pp_colour_mulg"] = 0,
 ["$pp_colour_mulb"] = 0
}


local function PostProcess()
    if LocalPlayer():Alive() then return end
    DrawTexturize( 1, Material( "pp/texturize/plain.png" ) )
end
hook.Add( "RenderScreenspaceEffects", "DeathEffect", PostProcess )

local sTime = CurTime()
local respawntime = 15
function SpawnClient()
		
	sTime = CurTime()
	if LocalPlayer():IsPremium() then
		respawntime = 5
	else
		respawntime = 10
	end
end
concommand.Add("ptp_resetSpawnClient", SpawnClient)

local function PaintText()
	if LocalPlayer():Alive() then return end

	if CurTime() >= sTime then
		respawntime = respawntime - 1
		sTime = CurTime() + 1
	end
	
	draw.SimpleText("You have died", "ptp_deathBig", ScrW()/2, ScrH()/2-200, Color(255,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	if respawntime > 1 then
		draw.SimpleTextOutlined("You can respawn in "..respawntime.." seconds...", "ptp_deathBig", ScrW()/2, ScrH()/2-100, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0))
	elseif respawntime == 1 then
		draw.SimpleTextOutlined("You can respawn in "..respawntime.." second...", "ptp_deathBig", ScrW()/2, ScrH()/2-100, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0))
	elseif respawntime < 1 then
		draw.SimpleTextOutlined("You can respawn now...", "ptp_deathBig", ScrW()/2, ScrH()/2-100, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0))
	end
end
hook.Add("HUDPaint", "PaintText", PaintText)