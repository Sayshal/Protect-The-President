--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

local surface = surface
local draw = draw

local DrawRect = surface.DrawRect
local SetDrawColor = surface.SetDrawColor
local SetDrawMaterial = surface.SetMaterial
local logo = Material("ptp/ptplogo.png")
ptp.loadAlpha = ptp.loadAlpha or 0
ptp.loadScreenAlpha = ptp.loadScreenAlpha or 255
local mysql_connected = false
local mysql_read = false

local function recieveSQLStatus()
	local status = net.ReadBit()
	mysql_connected = tobool(status)
	mysql_read = true
end
net.Receive("ptp_MySQLStatus", recieveSQLStatus)

function GM:PostRenderVGUI()
	if (!gui.IsGameUIVisible() and ptp.loadScreenAlpha > 0) then
		local scrW, scrH = surface.ScreenWidth(), surface.ScreenHeight()
		local goal = 0

		if (mysql_connected and mysql_read) then
			goal = 255
		end

		ptp.loadAlpha = math.Approach(ptp.loadAlpha, goal, FrameTime() * 60)

		if (ptp.loadAlpha == 255 and goal == 255) then
			if (ptp.loadScreenAlpha == 255) then
				surface.PlaySound("buttons/button14.wav")
				surface.PlaySound("ptp/ptpintro.mp3")
			end

			ptp.loadScreenAlpha = math.Approach(ptp.loadScreenAlpha, 0, FrameTime() * 60)
		end

		local alpha = ptp.loadScreenAlpha

		if (alpha > 0) then
			SetDrawColor(255, 255, 255, alpha)
			DrawRect(0, 0, scrW, scrH)

			local x, y, w, h = scrW*0.5 - 512, scrH*0.4 - 256, 1024, 512

			surface.SetDrawColor(255, 255, 255, alpha)
			surface.SetMaterial(logo)
			surface.DrawTexturedRect(x, y, w, h)

			draw.SimpleText("Gamemode by Blt950\n Maintained by Sayshal", "ptp_HUDFont", scrW * 0.5, scrH * 0.5, Color(2, 81, 124, alpha), 1, 1)

			if not mysql_connected then
				draw.SimpleText("MySQL Connection Failure, contact administration.", "ptp_HUDFontFat", scrW * 0.5, scrH * 0.8, Color(255, 0, 0, alpha), 1, 1)
			end

			hook.Run("DrawLoadingScreen")

			do return end
		end
	end
end