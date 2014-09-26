--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

function FontScreenScale(size)
	return ScreenScale(size);
end;

surface.CreateFont( "ptp_TypingFont", {
	font = "Trebuchet",
	size = FontScreenScale(100),
	weight = 500,
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


surface.CreateFont( "ptp_HUDFont", {
	font = "Trebuchet",
	size = FontScreenScale(6),
	weight = 500,
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

surface.CreateFont( "ptp_HUDFontSmall", {
	font = "Trebuchet",
	size = FontScreenScale(4),
	weight = 500,
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

surface.CreateFont( "ptp_HUDFontFat", {
	font = "Trebuchet",
	size = FontScreenScale(7),
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


surface.CreateFont( "ptp_BigMenu", {
	font = "Trebuchet",
	size = FontScreenScale(13),
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

surface.CreateFont( "ptp_TeamTitle", {
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

surface.CreateFont( "ptp_ItemTitle", {
	font = "Trebuchet",
	size = 30,
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

surface.CreateFont( "ptp_playerInfo", {
		size = 23,
		weight = 400,
		antialias = true,
		shadow = false,
		font = "Trebuchet"})

surface.CreateFont( "ptp_playerInfoHealth", {
		size = 12,
		weight = 400,
		antialias = true,
		shadow = false,
		font = "Trebuchet"})

surface.CreateFont( "ptp_HelpFont", {
		size = 18,
		weight = 400,
		antialias = true,
		shadow = false,
		font = "Trebuchet"})
