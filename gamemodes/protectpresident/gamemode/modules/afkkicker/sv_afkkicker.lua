--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]

local sTime = CurTime()

function AFKTimer()
	if (CurTime() > sTime) then
		sTime = CurTime() + 5
		for k,ply in pairs(player.GetAll()) do
			if !ply:IsAdmin() and !ply:IsSuperAdmin() then

				if(ply.lastAngles != ply:EyeAngles().pitch)then

					ply.AFK = CurTime()
					ply.lastAngles = ply:EyeAngles().pitch

				elseif(#player.GetAll() >= 28 and ply.AFK < CurTime() - 900)then
					PrintChatAll(COLOR_CONNECT, "System has kicked '"..ply:Name().."' (AFK more than 15 minutes).")
					ply:Kick("AFK more than 15 minutes");
					writeLog("System has kicked '"..ply:Nick().."' (AFK more than 15 minutes).")
				elseif(#player.GetAll() <= 27 and ply.AFK < CurTime() - 1800)then
					PrintChatAll(COLOR_CONNECT, "System has kicked '"..ply:Nick().."' (AFK more than 30 minutes).")
					ply:Kick("AFK more than 30 minutes");
					writeLog("System has kicked '"..ply:Name().."' (AFK more than 30 minutes).")
				end
			end
		end
	end
end
hook.Add("Think", "AFKTimer", AFKTimer)
