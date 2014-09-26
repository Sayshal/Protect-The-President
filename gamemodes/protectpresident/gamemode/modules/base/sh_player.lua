--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

local meta = FindMetaTable("Player")
DEFAULT_WALKSPEED = 175
DEFAULT_RUNSPEED = 250
DEFAULT_JUMPPOWER = 175

//	==============================
//		GET PLAYER TEAM NAME
//	==============================

function meta:GetTeamName()
	return team.GetName(self:Team())
end

//	==============================
//		GET CLASS
//	==============================

function meta:Class()
	return self:GetSharedVar("class")
end

//	==============================
//		GET CLASS  NAME
//	==============================

function meta:GetClassName()
	return GMClasses[self:GetSharedVar("class")].name
end

//	==============================
//		GET PLAYER TEAM COLOR
//	==============================

function meta:GetTeamColor()
	return team.GetColor(self:Team())
end

//	==============================
//			GET ALL ADMINS
//	==============================

function GetAdmins()
	local result = {}
	for _, v in pairs(player.GetAll())do
		if v:IsAdmin() or v:IsSuperAdmin() then
			table.insert(result, v)
		end
	end
	return result
end

//	==============================
//		GET ALL IN RADIUS
//	==============================

function GetPlayersInRadius(ply, radius)
	local result = {}
	for _,ent in pairs(ents.FindInSphere( ply:GetPos(), radius )) do
		if ent:IsPlayer() then
			table.insert(result, ent)
		end
	end
	return result
end

//	==============================
//		 PLAYER FOOTSTEPS
//	==============================

function MuteFootsteps(ply, vector, foot, sound, volume, filter)
	if ply:Class() == CLASS_SS_GHOST then
		return true -- mute the footsteps
	end
end
hook.Add("PlayerFootstep", "MuteFootsteps", MuteFootsteps)