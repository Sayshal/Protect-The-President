include("sh_init.lua")

--[[
	We are going to borrow offsets etc from Robbis_1's keypad here
]]

local X = -50
local Y = -100
local W = 100
local H = 200
local VEC_ZERO = Vector(0, 0, 0)

local KeyPos =	{	
	{X+5, Y+67.5, 90, 125, 0.3, 1.65, -0.3, 1.6}
}

surface.CreateFont("Keypad", {font = "Trebuchet", size = 34, weight = 900})
surface.CreateFont("KeypadState", {font = "Trebuchet", size = 20, weight = 600})
surface.CreateFont("KeypadButton", {font = "Trebuchet", size = 24, weight = 500})
surface.CreateFont("KeypadSButton", {font = "Trebuchet", size = 16, weight = 900})

function ENT:Draw()
	self:DrawModel()

	local key_aliases = key_aliases
	key_aliases = {1, 2, 3, 4, 5, 6, 7, 8, 9}

	local ply = LocalPlayer()

	if(IsValid(ply)) then
		local distance = ply:EyePos():Distance(self:GetPos())

		if(distance <= 750) then
			local ang = self:GetPos() - ply:EyePos()
			local tr = util.TraceLine(util.GetPlayerTrace(ply, ang))

			if(tr.Entity == self) then
				local pos = self:GetPos() + self:GetForward() * 1.1
				local ang = self:GetAngles()
				local rot = Vector(-90, 90, 0)

				ang:RotateAroundAxis(ang:Right(), rot.x)
				ang:RotateAroundAxis(ang:Up(), rot.y)
				ang:RotateAroundAxis(ang:Forward(), rot.z)

				surface.SetFont("Keypad")

				cam.Start3D2D(pos, ang, 0.05)

					local tr = util.TraceLine({
						start = ply:EyePos(),
						endpos = ply:GetAimVector() * 40 + ply:EyePos(),
						filter = ply,
					})

					local pos = self:WorldToLocal(tr.HitPos)
					local status = self:GetStatus()
					local value = self:GetDisplayText() or ""

					surface.SetDrawColor(color_black)
					surface.DrawRect(X-5, Y-5, W+10, H+10)

					surface.SetDrawColor(Color(50, 75, 50, 255))
					surface.DrawRect(X+5, Y+5, 90, 50)

					for k = 1, #KeyPos do
						local v = KeyPos[k]

						local text = key_aliases[k]
						local textx = v[1] + 9
						local texty = v[2] + 4
						local x = (pos.y - v[5]) / (v[5] + v[6])
						local y = 1 - (pos.z + v[7]) / (v[7] + v[8])

						text = "FINGER"
						textx = v[1] + 12
						texty = v[2] + 5
						surface.SetDrawColor(Color(150, 150, 150, 255))

						if(tr.Entity == self and x >= -1.25 and y >= 0 and x <= 1 and y <= 5) then
							
							surface.SetDrawColor(Color(200, 200, 200, 255))

							if(ply:KeyDown(IN_USE) and not ply.KeyPadCool) then
								if(k == 1) then
									net.Start("fingerpad_command")
										net.WriteEntity(self)
										net.WriteUInt(self.Command_Accept, 3)
									net.SendToServer()
								end

								ply.KeyPadCool = true
							end
						end

						surface.DrawRect(v[1], v[2], v[3], v[4])
						draw.SimpleText(text, "KeypadButton", v[1] + v[3] / 2, v[2] + v[4] / 2, Color(20, 20, 20, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					end

					surface.SetFont("Keypad")

					if(status == self.Status_None) then
						draw.SimpleText(value, "Keypad", X + 50, Y + 30, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					elseif(status == self.Status_Granted) then
						draw.SimpleText("ACCESS", "KeypadState", X + 50, Y + 18, Color(0, 255, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
						draw.SimpleText("GRANTED", "KeypadState", X + 50, Y + 40, Color(0, 255, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					elseif(status == self.Status_Denied) then
						draw.SimpleText("ACCESS", "KeypadState", X + 50, Y + 18, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
						draw.SimpleText("DENIED", "KeypadState", X + 50, Y + 40, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					end
				cam.End3D2D()
			end
		end
	end
end