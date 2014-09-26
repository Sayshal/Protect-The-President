AddCSLuaFile("cl_init.lua")
AddCSLuaFile("sh_init.lua")

include("sh_init.lua")

util.AddNetworkString("fingerpad_command")

net.Receive("fingerpad_command", function(len, ply)
	if(IsValid(ply)) then
		local ent = net.ReadEntity()

		if(ent:GetClass() == "fingerpad" and ply:EyePos():Distance(ent:GetPos()) <= 50) then
			local cmd = net.ReadUInt(3)
			if(cmd == ent.Command_Enter) then
				local num = net.ReadUInt(4)

				if(num <= 9) then
					num = tostring(num)

					ent:EnterNum(num)
				end
			elseif(cmd == ent.Command_Reset) then
				ent:ResetButton()
			elseif(cmd == ent.Command_Accept) then
				ent:Submit(ply)
			end
		end
	end
end)

util.PrecacheSound("buttons/button14.wav")
util.PrecacheSound("buttons/button9.wav")
util.PrecacheSound("buttons/button11.wav")
util.PrecacheSound("buttons/button15.wav")

AccessorFunc(ENT, "var_Input", "Input", FORCE_STRING)


function ENT:Initialize()
	self:SetModel("models/props_lab/keypad.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()

	if(IsValid(phys)) then
		phys:Wake()
	end

	self.Password = false

	if(not self.KeypadData) then
		self.KeypadData = {
			Access = nil,

			RepeatsGranted = 0,
			RepeatsDenied = 0,

			LengthGranted = 0,
			LengthDenied = 0,

			DelayGranted = 0,
			DelayDenied = 0,

			InitDelayGranted = 0,
			InitDelayDenied = 0,

			KeyGranted = 0,
			KeyDenied = 0,

			Owner = NULL
		}
	end

	self:Reset()
end

function ENT:GetAccess(access)
	return self.KeypadData.Access or ""
end

function ENT:SetData(data)
	self.KeypadData = data

	self:Reset()
end

function ENT:EnterNum(num)
	if(self:GetStatus() == self.Status_None) then
		local num = tostring(num)
		local new_input = self:GetInput()..num

		self:SetInput(new_input:sub(1, 4))

		if(self.KeypadData.Secure) then
			self:SetDisplayText(string.rep("*", #self:GetInput()))
		else
			self:SetDisplayText(self:GetInput())
		end

		self:EmitSound("buttons/button15.wav")
	end
end

function ENT:Submit(ply)
	if(self:GetStatus() == self.Status_None) and ply:IsPlayer() then

		local allowedteams = string.Explode(",", self:GetAccess())
		if table.HasValue(allowedteams, tostring(ply:Team())) then
			self:Process(true)
		else
			self:Process(false)
		end
		
	end
end

function ENT:ResetButton()
	if(self:GetStatus() == self.Status_None) then
		self:EmitSound("buttons/button14.wav")
		self:Reset()
	end
end

function ENT:Reset()
	self:SetDisplayText("")
	self:SetInput("")
	self:SetStatus(self.Status_None)
	self:SetSecure(self.KeypadData.Secure)
end


function ENT:Process(granted)
	local length, repeats, delay, initdelay, owner, key

	if(granted) then
		self:SetStatus(self.Status_Granted)

		length = self.KeypadData.LengthGranted
		repeats = math.min(self.KeypadData.RepeatsGranted, 50)
		delay = self.KeypadData.DelayGranted
		initdelay = self.KeypadData.InitDelayGranted
		owner = self.KeypadData.Owner
		key = tonumber(self.KeypadData.KeyGranted) or 0
	else
		self:SetStatus(self.Status_Denied)

		length = self.KeypadData.LengthDenied
		repeats = math.min(self.KeypadData.RepeatsDenied, 50)
		delay = self.KeypadData.DelayDenied
		initdelay = self.KeypadData.InitDelayDenied
		owner = self.KeypadData.Owner
		key = tonumber(self.KeypadData.KeyDenied) or 0
	end

	timer.Simple(math.max(initdelay + length * (repeats + 1) + delay * repeats + 0.25, 2), function() -- 0.25 after last timer
		if(IsValid(self)) then
			self:Reset()
		end
	end)

	timer.Simple(initdelay, function()
		if(IsValid(self)) then
			for i = 0, repeats do
				timer.Simple(length * i + delay * i, function()
					if(IsValid(self) and IsValid(owner)) then
						numpad.Activate(owner, key)
					end
				end)

				timer.Simple(length * (i + 1) + delay * i, function()
					if(IsValid(self) and IsValid(owner)) then
						numpad.Deactivate(owner, key)
					end
				end)
			end
		end
	end)

	if(granted) then
		self:EmitSound("buttons/button9.wav")
	else
		self:EmitSound("buttons/button11.wav")
	end
end

local function HandleDuplication(ply, data, dupedata)
	local ent = ents.Create("fingerpad")
	duplicator.DoGeneric(ent, dupedata)

	ent:Spawn()

	duplicator.DoGenericPhysics(ent, ply, dupedata)

	data['Owner'] = ply
	ent:SetData(data)

	if(IsValid(ply)) then
		ply:AddCount("fingerpads", ent)
	end
	
	return ent
end

duplicator.RegisterEntityClass("fingerpad", HandleDuplication, "FingerpadData", "Data")