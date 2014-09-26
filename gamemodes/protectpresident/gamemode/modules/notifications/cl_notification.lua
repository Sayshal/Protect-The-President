--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

//  ==============================
//         HINT NOTIFY
//  ==============================

// CLIENT SIDE VERSION
function Notify(text, type, length)
	GAMEMODE:AddNotify(text, type, length or 5)
	surface.PlaySound("buttons/lightswitch2.wav")
	print(text)
end

// SERVER SIDE VERSION
local function recieveNotify()
	local text = net.ReadString()
	local type = net.ReadInt(8)
	local length = net.ReadInt(32)

	GAMEMODE:AddNotify(text, type, length or 5)
	surface.PlaySound("buttons/lightswitch2.wav")
	print(text)
end
net.Receive("ptp_Notify", recieveNotify)

//  ==============================
//         	CHAT NOTIFY
//  ==============================

local function recievePrintChat()
	local amount = net.ReadInt(8)
	local color = net.ReadTable()
	local text = net.ReadString()

	if amount == 3 then
		local c2 = net.ReadTable()
		local t2 = net.ReadString()
		local c3 = net.ReadTable()
		local t3 = net.ReadString()
		chat.AddText(color, text, c2, t2, c3, t3)
	elseif amount == 2 then
		local c2 = net.ReadTable()
		local t2 = net.ReadString()
		chat.AddText(color, text, c2, t2)
	else
		chat.AddText(color, text)
	end
end
net.Receive("ptp_PrintChat", recievePrintChat)

//  ==============================
// 	DESTROY GMOD NOTIFICATIONS
//  ==============================

timer.Destroy("HintSystem_OpeningMenu")
timer.Destroy("HintSystem_Annoy1")
timer.Destroy("HintSystem_Annoy2")