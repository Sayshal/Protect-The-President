--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

local playersToEnable = 0
pointsEnabled = false

//	==============================
//		  RECIEVE STATUS
//	==============================

local function recievePointStatus2()
    playersToEnable = net.ReadInt(16)
    pointsEnabled = tobool(net.ReadBit())
end
net.Receive("ptp_PointsStatus", recievePointStatus2)

//	==============================
//		  PAINT STATUS
//	==============================

function PaintPoints()
	if !pointsEnabled then
		draw.RoundedBox(0, ScrW()/2-300, 0, 600, 30, Color(0,0,0,220))
		draw.SimpleText("The server needs "..(playersToEnable - #player.GetAll()).." more players in order for reward points to enable.", "ptp_HelpFont", ScrW()/2, 6, Color(255,255,255, 255), TEXT_ALIGN_CENTER)
	end
end
hook.Add("HUDPaint", "PaintPoints", PaintPoints)