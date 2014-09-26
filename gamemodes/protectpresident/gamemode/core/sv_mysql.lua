--[[

    Protect The President - Created by Blt950, Maintained by Sayshal
    Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

//  ==============================
//          CONFIGURATION
//  ==============================

util.AddNetworkString("ptp_DataVars_SQL")
util.AddNetworkString("ptp_MySQLStatus")

local mysql_hostname = 'localhost' -- Your MySQL server address.
local mysql_username = 'root' -- Your MySQL username.
local mysql_password = 'rootpass' -- Your MySQL password.
local mysql_database = 'ptp' -- Your MySQL database.
local mysql_port = 3306 -- Your MySQL port. Most likely is 3306.
local mysql_savetime = 30

//  ==============================
//          CONNECT
//  ==============================

require('mysqloo')

mysql_connected = false

local db = {}

if not mysql_connected then
    db = mysqloo.connect(sql_host, sql_usr, sql_pass, sql_db, sql_port)
end

function db:onConnected()
    CreateConVar( "mysql_connected", "true", FCVAR_REPLICATED, "If the MySQl is connected" )
    MsgN('>>> PTP --> MySQL: =CONNECTED=')
    mysql_connected = true

    ProccessData()
    timer.Create("ProccessData", sql_savetime, 0, ProccessData)
end

function db:onConnectionFailed(err)
    MsgN('>>> PTP --> MySQL: =CONNECTION FAILED= ('..err..')')
end

db:connect()

//  ==============================
//         DECIDE FUNCTION
//  ==============================

function ProccessData()
	for k,v in pairs(player.GetAll()) do
		if v:GetSharedVar("sqlready") then
			UpdateData(v)
		else
			CheckData(v)
		end
	end
end

//  ==============================
//         SEND SQL STATUS
//  ==============================

function sendStatus()
    net.Start("ptp_MySQLStatus")
        net.WriteBit(mysql_connected)
    net.Send(player.GetAll())
end
hook.Add("PlayerInitialSpawn", "sendStatus", sendStatus)

//  ==============================
//       INSERT/UPDATE DATA
//  ==============================

function UpdateData(ply)
    if ply:IsBot() then return end
	local qs = [[
    INSERT INTO `ptp_players` (id, steamid, steamname, data)
    VALUES ('%s', '%s', '%s', '%s')
    ON DUPLICATE KEY UPDATE 
        data = VALUES(data)
    ]]
    qs = string.format(qs, ply:UniqueID(), ply:SteamID(), db:escape(ply:Name()), util.TableToJSON(ply.ptpData or {}))
    local q = db:query(qs)
     
    function q:onError(err, sql)
        if db:status() ~= mysqloo.DATABASE_CONNECTED then
            db:connect()
            db:wait()
        if db:status() ~= mysqloo.DATABASE_CONNECTED then
            ErrorNoHalt(">>> PTP --> MySQL: =CONNECTION FAILED= (Re-connection to database server failed)")
            return
            end
        end
        MsgN('>>> PTP --> MySQL: =QUERY FAILED= ' .. err .. ' (' .. sql .. ')')
    end
     
    q:start()
end

//  ==============================
//       	SELECT DATA
//  ==============================
	
function CheckData(ply, callback)
    if ply:IsBot() then return end

	local qs = [[
    SELECT *
    FROM `ptp_players`
    WHERE id = '%s'
    ]]

    qs = string.format(qs, ply:UniqueID())

    local q = db:query(qs)
    local recievedData = false
     
    function q:onSuccess(result)
        if table.Count(result) > 0 then
            local row = result[1]

            ply.ptpData = util.JSONToTable(row.data or '{}')
            ply:SetSharedVar("sqlready", true)

            target = target or player.GetAll()
            net.Start("ptp_DataVars_SQL")
				net.WriteFloat(ply:UserID())
				net.WriteTable(ply.ptpData)
			net.Send(target)
        else
        	ply:SetSharedVar("sqlready", true)
        end
    end
     
    function q:onError(err, sql)
        if db:status() ~= mysqloo.DATABASE_CONNECTED then
            db:connect()
            db:wait()
        if db:status() ~= mysqloo.DATABASE_CONNECTED then
            ErrorNoHalt(">>> PTP --> MySQL: =CONNECTION FAILED= (Re-connection to database server failed)")
            return
            end
        end
        MsgN('>>> PTP --> MySQL: =QUERY FAILED= ' .. err .. ' (' .. sql .. ')')
    end
     
    q:start()
end