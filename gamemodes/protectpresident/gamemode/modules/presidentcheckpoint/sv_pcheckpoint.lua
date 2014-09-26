--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

local index
local duetime

util.AddNetworkString("ptp_selectedCheckpoint")

function SelectCheckpoint()
	index = math.random(1, #PresidentCheckpoints)
	duetime = CurTime() + 900

	net.Start("ptp_selectedCheckpoint")
		net.WriteInt(index, 8)
		net.WriteInt(duetime, 32)
	net.Send(player.GetAll())
end
//concommand.Add("ptp_checkpoint", SelectCheckpoint)	

function CheckCheckpoint()
	if index and duetime and pointsEnabled then
		local inlocation = false
		local ply

		for k,v in pairs(ents.FindInSphere( PresidentCheckpoints[index], 50)) do
			if v:IsPlayer() and v:Alive() and v:IsValid() and v:Team() == TEAM_PRESIDENT then
				inlocation = true
				ply = v
			end
		end

		if inlocation then

			// Give SS reward
			for x, y in pairs(ents.FindInSphere( PresidentCheckpoints[index], 500)) do
				if y:IsPlayer() and y:IsValid() and y:Team() == TEAM_SECRETSERVICE then
					y:Notify("You have been awarded 2 points for safetly bringing the President to checkpoint.")
					y:GivePoints(2)
				end
			end

			ply:Notify("Congratulations! You've reached the checkpoint.")
			ply:PrintChat(Color(255,100,0), "[Checkpoint] ", Color(255,255,255), "Congratulations! You've reached the checkpoint. You've been awarded with 5 points. Hurry up for next!")
			ply:GivePoints(5)
			SelectCheckpoint()
			
		end

		if CurTime() >= duetime-1 and CurrentPresident() != false then
			CurrentPresident():Notify("You've failed to reach a checkpoint!", 1)
			CurrentPresident():PrintChat(Color(255,100,0), "[Checkpoint] ", Color(255,255,255), "Failure! You did not reach checkpoint in time. You have lost 3 points! Hurry up to the new checkpoint!")
			CurrentPresident():GivePoints(-3)
			SelectCheckpoint()
		end
	end
end
hook.Add("Think", "CheckCheckpoint", CheckCheckpoint)

function CheckpointReset()
	SelectCheckpoint()
end
hook.Add("OnReloaded", "CheckpointReset", CheckpointReset)


