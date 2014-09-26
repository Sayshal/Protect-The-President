--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

//	==============================
//		  RECIEVE ADMIN LOG
//	==============================

local function recieveAdminLog()
	local text = net.ReadString() .. "\n"
	local color = net.ReadTable()

	MsgC(Color(255,0,0), "[PtP] ")
	MsgC(color, text)
end
net.Receive("ptp_AdminLog", recieveAdminLog)