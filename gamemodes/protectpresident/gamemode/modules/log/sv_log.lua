--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

util.AddNetworkString("ptp_AdminLog")

//	==============================
//		  	  ADMIN LOG
//	==============================

local function AdminLog(text, color)
	if not text then return end
	net.Start("ptp_AdminLog")
		net.WriteString(text)
		net.WriteTable(color)
	net.Send(GetAdmins())
end


//	==============================
//		  	 SERVER LOG
//	==============================

local Logfile
function writeLog(text, color)
	if color then
		AdminLog(text, color)
	end
	if not text then return end
	if not Logfile then -- The log file of this session, if it's not there then make it!
		if not file.IsDir("ptp_logs", "DATA") then
			file.CreateDir("ptp_logs")
		end
		if file.Exists( "ptp_logs/"..os.date("%d_%m_%Y")..".txt", "DATA") then
			Logfile = "ptp_logs/"..os.date("%d_%m_%Y")..".txt"
			file.Open("ptp_logs/"..os.date("%d_%m_%Y")..".txt", "a", "DATA")
		else
			Logfile = "ptp_logs/"..os.date("%d_%m_%Y")..".txt"
			file.Write(Logfile, os.date().. "\t".. text)
			return
		end
	end
	file.Append(Logfile, "\n"..os.date().. "\t"..(text or ""))
	print("[PtP Log] "..text) -- Show the text in console
end
