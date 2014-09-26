--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

secondTime = CurTime()

//	==============================
//		  	GET PLAYER TIME
//	==============================


local playerMeta = FindMetaTable("Player")
function playerMeta:GetPlayTime()
	return self:GetPlayerData("playTime") or 0
end

//	==============================
//			 COUNT THE TIME
//	==============================

function Think()
	if (CurTime() > secondTime) then
		secondTime = CurTime() + 1
		for k, v in pairs(player.GetAll()) do
			if (!v:GetPlayerData("playtime")) then
				v:SetPlayerData("playtime", 0)
			else
				v:SetPlayerData("playtime", v:GetPlayerData("playtime") + 1)
			end
		end
	end
end
hook.Add("Think", "TimelogThink", Think)