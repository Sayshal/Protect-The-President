--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]

function FriendlyFire(victim, killer)
	if not killer:IsPlayer() then return end
	local Kteam, Vteam = killer:Team(), victim:Team()
	if (Kteam == TEAM_SECRETSERVICE or Kteam == TEAM_PRESIDENT) and (Vteam == TEAM_SECRETSERVICE or Vteam == TEAM_PRESIDENT) then
		return false
	elseif Kteam == TEAM_TERRORIST and Vteam == TEAM_TERRORIST then
		return false
	elseif Kteam == Vteam then
		return false
	end
end
hook.Add("PlayerShouldTakeDamage", "FriendlyFire", FriendlyFire)