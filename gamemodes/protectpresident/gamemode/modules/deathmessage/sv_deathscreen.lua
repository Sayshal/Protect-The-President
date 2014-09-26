--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

function OnDeathPrepare(ply,cmd,args) 
	ply.canSpawn = false
	if ply:IsPremium() then
    	ply.TimeToWait = 5
	else
	    ply.TimeToWait = 10
	end
	timer.Simple(ply.TimeToWait, function() ply.canSpawn = true end)
end 
hook.Add("PlayerDeath", "OnDeathPrepare", OnDeathPrepare) 

function PlayerDeathDelay( ply )
	if ply.canSpawn then
		if ply:KeyPressed( IN_ATTACK ) or ply:KeyPressed( IN_ATTACK2 ) or ply:KeyPressed( IN_JUMP ) then
			ply:Spawn()
			ply:ConCommand("ptp_resetSpawnClient")
		end
		return true
	else
		return false
	end
end
hook.Add("PlayerDeathThink", "PlayerDeathDelay", PlayerDeathDelay) 

hook.Add("PlayerInitSpawn", "SetSpawnTime", function(ply)
	timer.Simple(3, function() ply:ConCommand("ptp_resetSpawnClient") end)
end)