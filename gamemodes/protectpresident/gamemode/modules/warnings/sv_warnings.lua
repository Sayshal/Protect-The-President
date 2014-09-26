--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

local maxwarnings = 3
local banreason = "Maximum warning level reached."
local meta = FindMetaTable("Player")

//	==============================
//		  GIVE WARNING
//	==============================

function meta:GiveWarning(reason)
	if self:IsAdmin() then return end
	local points = self:GetPlayerData("warningpoints") or 0
	self:SetPlayerData("warningpoints", points + 1)
	self:SetPlayerData("warningcool", os.time() + 3600)
	self:Notify("You've recieved a warning for " .. reason, 1)
	self:PrintChat(Color(255,0,0), "You've recieved a warning for "..reason)
	self:PrintChat(Color(255,0,0), "Warning points: "..self:GetPlayerData("warningpoints").."/"..maxwarnings)
	self:PrintChat(Color(255,255,0), "Once you hit the last warning point, you'll be automatically banned. The ban length will be decided by number of bans earlier.")
	writeLog(self:Nick() .. " ["..self:SteamID().."] has been warned for "..reason..". Warning points: "..self:GetPlayerData("warningpoints").."/"..maxwarnings, Color(255, 190, 0))
	CheckMax(self)
end

//	==============================
//		  CHECK MAX
//	==============================

function CheckMax(ply)
	if ply:GetPlayerData("warningpoints") >= maxwarnings then
		local previousbans = ply:GetPlayerData("previouswarningbans") or 0
		ply:SetPlayerData("previouswarningbans", previousbans + 1)
		ply:SetPlayerData("warningpoints", 0)

		if previousbans == 0 or previousbans == 1 then
			RunConsoleCommand("ulx", "ban", ply:Name(), 60, "1h ban: "..banreason)
		elseif previousbans == 2 then
			RunConsoleCommand("ulx", "ban", ply:Name(), 1440, "1d ban: "..banreason)
		elseif previousbans == 3 then
			RunConsoleCommand("ulx", "ban", ply:Name(), 10080, "1w ban: "..banreason)
		elseif previousbans == 4 then
			RunConsoleCommand("ulx", "ban", ply:Name(), 0, "Perm ban: "..banreason)
		end
		
	end
end

//	==============================
//		  PLAYER DEATH
//	==============================

function Death(victim, weapon, killer)
	if victim:IsPlayer() and killer:IsPlayer() and killer != victim then
		if killer:Team() == victim:Team() then
			killer:GiveWarning("teamkilling")
		elseif (killer:Team() == TEAM_SECRETSERVICE and victim:Team() == TEAM_PRESIDENT) or (killer:Team() == TEAM_PRESIDENT and victim:Team() == TEAM_SECRETSERVICE) then
			killer:GiveWarning("teamkilling")
		elseif victim:Team() == TEAM_CITIZEN then
			killer:GiveWarning("killing innocent citizen.")
		end
	end
end
hook.Add("PlayerDeath", "Death", Death)


//	==============================
//		COOL DOWN TIMER
//	==============================

local sTime = CurTime()

function CooldownTimer()
	if (CurTime() > sTime) then
		sTime = CurTime() + 60
		
		for k,ply in pairs(player.GetAll()) do

			if ply:GetPlayerData("warningcool") and ply:GetPlayerData("warningpoints") and os.time() > ply:GetPlayerData("warningcool") and ply:GetPlayerData("warningpoints") > 0 then
				ply:SetPlayerData("warningpoints", ply:GetPlayerData("warningpoints")-1)
				ply:SetPlayerData("warningcool", os.time() + 3600)
				ply:PrintChat(Color(255,0,0), "An hour has passed, you've lost a warning point in cooldown.")
				writeLog(self:Nick() .. " ["..self:SteamID().."] has been cooled down for 1 warning point. Warning points: "..self:GetPlayerData("warningpoints").."/"..maxwarnings, Color(255, 190, 0))
			end
			
		end

	end
end
hook.Add("Think", "CooldownTimer", CooldownTimer)