--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]

util.AddNetworkString("ptp_PointsStatus")
pointsEnabled = false
local currentPlayers = 0
local playersToEnable = 6

//	==============================
//		  INITILIZATION
//	==============================

function RefreshState()
	currentPlayers = #player.GetAll()

	if currentPlayers >= playersToEnable then
		pointsEnabled = true
	else
		pointsEnabled = false
	end

	net.Start("ptp_PointsStatus")
        net.WriteInt(playersToEnable, 16)
        net.WriteBit(pointsEnabled)
    net.Send(player.GetAll())
end
concommand.Add("ptp_refreshPoints", RefreshState)

function PrepareVars(ply)
	ply:SetSharedVar("points_30min", CurTime() + 1800)
	ply:SetSharedVar("points_president15min", 0)

	RefreshState()
end
hook.Add("PlayerInitialSpawn", "PrepareVars", PrepareVars)

function PlayerDisconnect()
	RefreshState()
end
hook.Add("PlayerDisconnected", "PlayerDisconnect", PlayerDisconnect)


//	==============================
//		  PLAYER TIMER
//	==============================

local sTime = CurTime()

function PointsTimer()
	if !pointsEnabled then return end
	if (CurTime() > sTime) then
		sTime = CurTime() + 1
		
		for k,v in pairs(player.GetAll()) do

			// Playing for 30 minutes
			if CurTime() >= v:GetSharedVar("points_30min") then
				v:Notify("You've earned 10 points by playing for 30 minutes.", 0)
				v:GivePoints(10)
				v:SetSharedVar("points_30min", CurTime() + 1800)
			end

			// Each 15 minutes as President
			if v:Team() == TEAM_PRESIDENT then
				v:SetSharedVar("points_president15min", v:GetSharedVar("points_president15min") + 1)
				if v:GetSharedVar("points_president15min") >= 900 then
					v:Notify("You've earned 5 points by surviving 15 minutes as President.", 0)
					v:GivePoints(5)
					v:SetSharedVar("points_president15min", 0)
				end
			end

		end

	end
end
hook.Add("Think", "PointsTimer", PointsTimer)

//	==============================
//		  PLAYER DEATH
//	==============================

function PlayerDeathPoints(victim, weapon, killer)
	if !pointsEnabled then return end
	if not killer:IsPlayer() or not victim:IsPlayer() then return end
	
	// Suicide
	if victim == killer then
		victim:Notify("You've lost 1 point for suicide.", 1)
		victim:GivePoints(-1)
	end

	// Killing oposite team
	if (killer:Team() == TEAM_PRESIDENT or killer:Team() == TEAM_SECRETSERVICE and victim:Team() == TEAM_TERRORIST) 
	or (killer:Team() == TEAM_TERRORIST and victim:Team() == TEAM_SECRETSERVICE) then
		if killer:IsPremium() then
			killer:Notify("You've earned 5 points for killing a enemy.", 0)
			killer:GivePoints(5)
		else
			killer:Notify("You've earned 3 points for killing a enemy.", 0)
			killer:GivePoints(3)
		end

		victim:Notify("You've lost 1 point by getting killed!", 1)
		victim:GivePoints(-1)
	end

	// Killing the president
	if killer:Team() == TEAM_TERRORIST and victim:Team() == TEAM_PRESIDENT then
		killer:Notify("You've earned 20 points for killing the president!", 0)
		killer:GivePoints(20)

		victim:Notify("You've lost 20 points for getting killed as President!", 1)
		victim:GivePoints(-20)

		for _, v in pairs(player.GetAll()) do
			if v:Team() == TEAM_SECRETSERVICE then
				v:Notify("You've lost the President on your watch. You've lost 5 points!", 1)
				v:GivePoints(-5)
			elseif v:Team() == TEAM_TERRORIST then
				v:Notify("The terrorists successfully killed the President! You've been awarded with 5 points.")
				v:GivePoints(5)
			end
		end
	end

end
hook.Add("PlayerDeath", "PlayerDeathPoints", PlayerDeathPoints)