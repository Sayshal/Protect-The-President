--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

local playerMeta = FindMetaTable("Player")

function playerMeta:IsRunning()
	if (self:Alive() and !self:InVehicle()
	and !self:Crouching() and self:KeyDown(IN_SPEED)) then
		if (self:GetVelocity():Length() >= self:GetWalkSpeed()) then
			return true;
		end;
	end;

	return false;
end;

function StaminaPress( ply, key )
	local Stamina = ply:GetSharedVar("stamina")

	if key == IN_JUMP and Stamina >= 5 and ply:GetMoveType() != MOVETYPE_NOCLIP then
		ply:SetSharedVar("stamina", Stamina-5)
	end
end
hook.Add("KeyPress","StaminaPress",StaminaPress)

function StaminaThink()
	for k, ply in pairs(player.GetAll()) do

		local regen = 0.01
		local degen = 0.1

		if ply:HasItem("staminaupgrade") > 0 then
			regen = regen * ply:GetItemValue("staminaupgrade")
			degen = degen * (1 - ply:GetItemValue("staminaupgrade")/4)
		end

		if ply:GetMoveType() != MOVETYPE_NOCLIP and ply:IsRunning() then
			ply:SetSharedVar("stamina", math.Clamp(ply:GetSharedVar("stamina")-degen, 0, 100))
		elseif ply:GetMoveType() != MOVETYPE_WALK and !ply:IsRunning() then
			ply:SetSharedVar("stamina", math.Clamp(ply:GetSharedVar("stamina")+regen*2, 0, 100))
		else
			ply:SetSharedVar("stamina", math.Clamp(ply:GetSharedVar("stamina")+regen, 0, 100))
		end

		if ply:GetSharedVar("stamina") <= 5 then
			ply:SetJumpPower(0)
		else
			if ply:HasItem("jumpupgrade") > 0 then
				ply:SetJumpPower(DEFAULT_JUMPPOWER*ply:GetItemValue("jumpupgrade"))
			else
				ply:SetJumpPower(DEFAULT_JUMPPOWER)
			end
		end

		if ply:GetSharedVar("stamina") <= 0 then
			ply:SetRunSpeed(DEFAULT_WALKSPEED)
		else
			if ply:HasItem("runspeedupgrade") > 0 then
				ply:SetRunSpeed(250*ply:GetItemValue("runspeedupgrade"))
			else
				ply:SetRunSpeed(DEFAULT_RUNSPEED)
			end
		end
	end
end
hook.Add("Think", "StaminaThink", StaminaThink)
