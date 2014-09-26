--[[

    Protect The President - Created by Blt950, Maintained by Sayshal
    Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

util.AddNetworkString("ptp_DataVars")
util.AddNetworkString("ptp_SharedVars")
util.AddNetworkString("ptp_SharedVars_all")
local meta = FindMetaTable("Player")

//  ==============================
//         PERMANENT DATA
//  ==============================

function meta:SetPlayerData(var, value)
	if not IsValid(self) then return end
	target = player.GetAll()

	self.ptpData = self.ptpData or {}
	self.ptpData[var] = value

	net.Start("ptp_DataVars")
		net.WriteFloat(self:UserID())
		net.WriteString(var)
		net.WriteType(value)
	net.Send(target)
end

function meta:GetPlayerData(var)
	self.ptpData = self.ptpData or {}
	return self.ptpData[var]
end

//  ==============================
//         TEMPORARY DATA
//  ==============================

function meta:SetSharedVar(var, value)
	if not IsValid(self) then return end
	target = player.GetAll()

	self.ptpSharedVar = self.ptpSharedVar or {}
	self.ptpSharedVar[var] = value

	net.Start("ptp_SharedVars")
		net.WriteFloat(self:UserID())
		net.WriteString(var)
		net.WriteType(value)
	net.Send(target)
end

function meta:GetSharedVar(var)
	self.ptpSharedVar = self.ptpSharedVar or {}
	return self.ptpSharedVar[var]
end

hook.Add("PlayerInitialSpawn", "SendAllSharedVars", function(ply)

	net.Start("ptp_SharedVars_all")
		net.WriteFloat(ply:UserID())
		net.WriteTable(ptpSharedVar or {})
	net.Send(ply)

end)