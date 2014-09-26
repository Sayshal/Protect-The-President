--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--
 
local SKIN = {}

SKIN.PrintName			= "ptpSkin"
SKIN.Author				= "Blt950"
SKIN.DermaVersion		= 1
SKIN.text_normal		= Color( 0, 0, 0, 255 )
SKIN.control_color_active = Color(120, 180, 120, 255)
SKIN.tooltip			= Color( 145, 215, 45, 255 )

function SKIN:PaintFrame( panel )
	surface.SetDrawColor( Color(25,25,25,220) )
	surface.DrawRect( 0, 0, panel:GetWide(), panel:GetTall() )
	
	surface.SetTexture( surface.GetTextureID( "gui/center_gradient" ) )
	surface.SetDrawColor( Color(0,42,62,100) )
	surface.DrawTexturedRect( 0, 0, panel:GetWide(), panel:GetTall() )
	
	surface.SetDrawColor( Color(25,25,25,220) )
	surface.DrawOutlinedRect( 0, 0, panel:GetWide(), panel:GetTall() )
end

function SKIN:PaintPropertySheet(panel, w, h)
	local ActiveTab = panel:GetActiveTab()
	local Offset = 0
	if ActiveTab then Offset = ActiveTab:GetTall() - 8 end

	draw.RoundedBox(8, 0, 0, w, h, Color(255,255,255,25))
	draw.RoundedBox(0, 0, 23, panel:GetWide(), 1, Color(0,0,0,255))
end

function SKIN:PaintTab(panel, w, h)
	if panel:GetPropertySheet():GetActiveTab() == panel then
		return self:PaintActiveTab(panel, w, h)
	end

	draw.RoundedBox(0, 0, 0, w-5, h-20, Color(200,200,200,255))
end

function SKIN:PaintActiveTab(panel, w, h)
	draw.RoundedBox(0, -5, 0, w, h-5, Color(25,25,25,255))
end

function SKIN:PaintCollapsibleCategory( panel )
    draw.RoundedBox( 4, 0, 0, panel:GetWide(), 20, Color(0,0,110,100) )
end
 
derma.DefineSkin( "ptpSkin", "Protect the President SKIN.", SKIN )