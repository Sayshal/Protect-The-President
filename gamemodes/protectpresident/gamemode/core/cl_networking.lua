--[[

    Protect The President - Created by Blt950, Maintained by Sayshal
    Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

local meta = FindMetaTable("Player")


//  ==============================
//         PERMANENT DATA
//  ==============================

function meta:GetPlayerData(var)
	self.ptpData = self.ptpData or {}
	return self.ptpData[var]
end


local function RetrieveDataVar(userID, var, value, tries)
	local ply = Player(userID)

	-- Usermessages _can_ arrive before the player is valid.
	-- In this case, chances are huge that this player will become valid.
	if not IsValid(ply) then
		if (tries or 0) >= 5 then return end

		timer.Simple(0.5, function() RetrieveDataVar(userID, var, value, (tries or 0) + 1) end)
		return
	end

	ply.ptpData = ply.ptpData or {}
	ply.ptpData[var] = value
end

local function RetrieveDataVar_SQL(userID, table, tries)
	local ply = Player(userID)

	-- Usermessages _can_ arrive before the player is valid.
	-- In this case, chances are huge that this player will become valid.
	if not IsValid(ply) then
		if (tries or 0) >= 5 then return end

		timer.Simple(0.5, function() RetrieveDataVar_SQL(userID, table, (tries or 0) + 1) end)
		return
	end

	ply.ptpData = table
end


local function doRetrieve()
	local userID = net.ReadFloat()
	local var = net.ReadString()
	local valueType = net.ReadUInt(8)
	local value = net.ReadType(valueType)

	RetrieveDataVar(userID, var, value)
end
net.Receive("ptp_DataVars", doRetrieve)

local function doRetrieve_SQL()
	local userID = net.ReadFloat()
	local table = net.ReadTable()

	RetrieveDataVar_SQL(userID, table)
end
net.Receive("ptp_DataVars_SQL", doRetrieve_SQL)


//  ==============================
//         TEMPORARY DATA
//  ==============================

function meta:GetSharedVar(var)
	self.ptpSharedVar = self.ptpSharedVar or {}
	return self.ptpSharedVar[var]
end


local function RetrieveSharedVar(userID, var, value, tries)
	local ply = Player(userID)

	-- Usermessages _can_ arrive before the player is valid.
	-- In this case, chances are huge that this player will become valid.
	if not IsValid(ply) then
		if (tries or 0) >= 5 then return end

		timer.Simple(0.5, function() RetrieveSharedVar(userID, var, value, (tries or 0) + 1) end)
		return
	end

	ply.ptpSharedVar = ply.ptpSharedVar or {}
	ply.ptpSharedVar[var] = value
end

local function RetrieveSharedVar_all(userID, table, tries)
	local ply = Player(userID)

	-- Usermessages _can_ arrive before the player is valid.
	-- In this case, chances are huge that this player will become valid.
	if not IsValid(ply) then
		if (tries or 0) >= 5 then return end

		timer.Simple(0.5, function() RetrieveSharedVar_all(userID, table, (tries or 0) + 1) end)
		return
	end

	ply.ptpSharedVar = table
end


local function doRetrieve()
	local userID = net.ReadFloat()
	local var = net.ReadString()
	local valueType = net.ReadUInt(8)
	local value = net.ReadType(valueType)

	RetrieveSharedVar(userID, var, value)
end
net.Receive("ptp_SharedVars", doRetrieve)


local function doRetrieve_all()
	local user = net.ReadFloat()
	local table = net.ReadTable()
	RetrieveSharedVar_all(user, table)
end
net.Receive("ptp_SharedVars_all", doRetrieve_all)