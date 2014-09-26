--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

function GM:PlayerSpawnSWEP(ply, class, info)
	if not ply:IsSuperAdmin() then
		ply:Notify("You don't have access to this!", 1)
		return false
	end
	return true
end

function GM:PlayerGiveSWEP(ply, class, info)
	if not ply:IsSuperAdmin() then
		ply:Notify("You don't have access to this!", 1)
		return false
	end
	return true
end

function GM:PlayerSpawnNPC(ply, type, weapon)
	if not ply:IsSuperAdmin() then
		ply:Notify("You don't have access to this!", 1)
		return false
	end
	return true
end

function GM:PlayerSpawnRagdoll(ply, model)
	if not ply:IsSuperAdmin() then
		ply:Notify("You don't have access to this!", 1)
		return false
	end
	return true
end

function GM:PlayerSpawnSENT(ply, class)
	if not ply:IsSuperAdmin() then
		ply:Notify("You don't have access to this!", 1)
		return false
	end
	return true
end

function GM:PlayerSpawnEffect(ply, model)
	if not ply:IsSuperAdmin() then
		ply:Notify("You don't have access to this!", 1)
		return false
	end
	return true
end