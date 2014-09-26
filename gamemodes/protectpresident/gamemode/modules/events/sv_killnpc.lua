--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

function RewardNPCKill(npc, attacker, inflictor)
	if attacker:IsPlayer() and attacker:IsValid() then
		attacker:Notify("You've earned 3 points for killing a NPC.")
		attacker:GivePoints(3)
	end
end
hook.Add("OnNPCKilled", "RewardNPCKill", RewardNPCKill)