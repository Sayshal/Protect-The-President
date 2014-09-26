--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

local meta = FindMetaTable("Player")
util.AddNetworkString("ptp_Notify")
util.AddNetworkString("ptp_PrintChat")

//  ==============================
//         HINT NOTIFY
//  ==============================

function meta:Notify(text, type, length)
	if not IsValid(self) then return end
	net.Start("ptp_Notify")
		net.WriteString(text)
		net.WriteInt(type or 0, 8)
		net.WriteInt(length or 5, 32)
	net.Send(self)
end

function NotifyAll(text, type, length)
	net.Start("ptp_Notify")
		net.WriteString(text)
		net.WriteInt(type or 0, 8)
		net.WriteInt(length or 5, 32)
	net.Send(player.GetAll())
end

//  ==============================
//         CHAT NOTIFY
//  ==============================

function meta:PrintChat(color, text, c2, t2, c3, t3)
	if not IsValid(self) then return end

	local amount
	if c3 and t3 then
		amount = 3
	elseif c2 and t2 then
		amount = 2
	else
		amount = 1
	end

	net.Start("ptp_PrintChat")
		net.WriteInt(amount, 8)
		net.WriteTable(color)
		net.WriteString(text)
		if c3 and t3 then
			net.WriteTable(c2)
			net.WriteString(t2)
			net.WriteTable(c3)
			net.WriteString(t3)
		elseif c2 and t2 then
			net.WriteTable(c2)
			net.WriteString(t2)
		end
	net.Send(self)
end

function PrintChatAll(color, text, c2, t2, c3, t3)
	local amount
	if c3 and t3 then
		amount = 3
	elseif c2 and t2 then
		amount = 2
	else
		amount = 1
	end

	net.Start("ptp_PrintChat")
		net.WriteInt(amount, 8)
		net.WriteTable(color)
		net.WriteString(text)
		if c3 and t3 then
			net.WriteTable(c2)
			net.WriteString(t2)
			net.WriteTable(c3)
			net.WriteString(t3)
		elseif c2 and t2 then
			net.WriteTable(c2)
			net.WriteString(t2)
		end
	net.Send(player.GetAll())
end

function PrintChatAudience(audience, color, text, c2, t2, c3, t3)
	local amount
	if c3 and t3 then
		amount = 3
	elseif c2 and t2 then
		amount = 2
	else
		amount = 1
	end

	net.Start("ptp_PrintChat")
		net.WriteInt(amount, 8)
		net.WriteTable(color)
		net.WriteString(text)
		if c3 and t3 then
			net.WriteTable(c2)
			net.WriteString(t2)
			net.WriteTable(c3)
			net.WriteString(t3)
		elseif c2 and t2 then
			net.WriteTable(c2)
			net.WriteString(t2)
		end
	net.Send(audience)
end
