if (SERVER) then
	CreateConVar('sbox_maxfingerpads', 10)
end

TOOL.Category = "Construction"
TOOL.Name = "Fingerpad"
TOOL.Command = nil

TOOL.ClientConVar['allow_citizen'] = '1'
TOOL.ClientConVar['allow_president'] = '1'
TOOL.ClientConVar['allow_secretservice'] = '1'
TOOL.ClientConVar['allow_terrorist'] = '1'

TOOL.ClientConVar['weld'] = '1'
TOOL.ClientConVar['freeze'] = '1'

TOOL.ClientConVar['repeats_granted'] = '0'
TOOL.ClientConVar['repeats_denied'] = '0'

TOOL.ClientConVar['length_granted'] = '0.1'
TOOL.ClientConVar['length_denied'] = '0.1'

TOOL.ClientConVar['delay_granted'] = '0'
TOOL.ClientConVar['delay_denied'] = '0'

TOOL.ClientConVar['init_delay_granted'] = '0'
TOOL.ClientConVar['init_delay_denied'] = '0'

TOOL.ClientConVar['key_granted'] = '0'
TOOL.ClientConVar['key_denied'] = '0'

cleanup.Register("fingerpads")

if(CLIENT) then
	language.Add("tool.fingerpad.name", "Fingerpad")
	language.Add("tool.fingerpad.0", "Left Click: Create, Right Click: Update")
	language.Add("tool.fingerpad.desc", "Creates Fingerpads for secure team-based access")

	language.Add("Undone_Fingerpad", "Undone Fingerpad")
	language.Add("Cleanup_fingerpads", "Fingerpads")
	language.Add("Cleaned_fingerpads", "Cleaned up all Fingerpads")

	language.Add("SBoxLimit_fingerpads", "You've hit the Fingerpad limit!")
end

function TOOL:SetupFingerpad(ent, access)
	local data = {
		Access = access,

		RepeatsGranted = self:GetClientNumber("repeats_granted"),
		RepeatsDenied = self:GetClientNumber("repeats_denied"),

		LengthGranted = self:GetClientNumber("length_granted"),
		LengthDenied = self:GetClientNumber("length_denied"),

		DelayGranted = self:GetClientNumber("delay_granted"),
		DelayDenied = self:GetClientNumber("delay_denied"),

		InitDelayGranted = self:GetClientNumber("init_delay_granted"),
		InitDelayDenied = self:GetClientNumber("init_delay_denied"),

		KeyGranted = self:GetClientNumber("key_granted"),
		KeyDenied = self:GetClientNumber("key_denied"),

		Owner = self:GetOwner()
	}

	ent:SetData(data)
end

function TOOL:RightClick(tr)
	if(IsValid(tr.Entity) and tr.Entity:GetClass() ~= "fingerpad") then return false end

	if(CLIENT) then return true end

	local ply = self:GetOwner()
	local access = tonumber(ply:GetInfo("fingerpad_access"))

	local access = ""
	if util.tobool(ply:GetInfo("fingerpad_allow_citizen")) then access = access..",1" end
	if util.tobool(ply:GetInfo("fingerpad_allow_president")) then access = access..",2" end
	if util.tobool(ply:GetInfo("fingerpad_allow_secretservice")) then access = access..",3" end
	if util.tobool(ply:GetInfo("fingerpad_allow_terrorist")) then access = access..",4" end

	local spawn_pos = tr.HitPos
	local trace_ent = tr.Entity

	if access == "" then
		ply:PrintMessage(3, "Invalid access!")
		return false
	end

	if(trace_ent:GetClass() == "fingerpad" and trace_ent.KeypadData.Owner == ply) then
		self:SetupFingerpad(trace_ent, access) -- validated access

		return true
	end
end

function TOOL:LeftClick(tr)
	if(IsValid(tr.Entity) and tr.Entity:GetClass() == "player") then return false end

	if(CLIENT) then return true end

	local ply = self:GetOwner()

	local access = ""
	if util.tobool(self:GetClientNumber("allow_citizen")) then access = access..",1" end
	if util.tobool(self:GetClientNumber("allow_president")) then access = access..",2" end
	if util.tobool(self:GetClientNumber("allow_secretservice")) then access = access..",3" end
	if util.tobool(self:GetClientNumber("allow_terrorist")) then access = access..",4" end

	local spawn_pos = tr.HitPos + tr.HitNormal
	local trace_ent = tr.Entity

	if access == "" then
		ply:PrintMessage(3, "Invalid access!")
		return false
	end

	if(not self:GetWeapon():CheckLimit("fingerpads")) then return false end

	local ent = ents.Create("fingerpad")
	ent:SetPos(spawn_pos)
	ent:SetAngles(tr.HitNormal:Angle())
	ent:Spawn()
	ent:SetPlayer(ply)
	ent:SetAngles(tr.HitNormal:Angle())
	ent:Activate()

	local phys = ent:GetPhysicsObject() -- rely on this being valid

	self:SetupFingerpad(ent, access)

	undo.Create("Fingerpad")
		if(util.tobool(self:GetClientNumber("freeze"))) then
			phys:EnableMotion(false)
		end

		if(util.tobool(self:GetClientNumber("weld"))) then
			phys:EnableMotion(false) -- The timer allows the fingerpad to fall slightly, no thanks

			timer.Simple(0, function()
				if(IsValid(ent) and IsValid(trace_ent)) then
					local weld = constraint.Weld(ent, trace_ent, 0, 0, 0, true, false)

					if(not util.tobool(self:GetClientNumber("freeze"))) then
						phys:EnableMotion(true)
					end
				end
			end)

			ent:GetPhysicsObject():EnableCollisions(false)
		end

		undo.AddEntity(ent)
		undo.SetPlayer(ply)
	undo.Finish()

	ply:AddCount("fingerpads", ent)
	ply:AddCleanup("fingerpads", ent)

	return true
end


if(CLIENT) then
	local function ResetSettings(ply)
		ply:ConCommand("fingerpad_repeats_granted 0")
		ply:ConCommand("fingerpad_repeats_denied 0")
		ply:ConCommand("fingerpad_length_granted 0.1")
		ply:ConCommand("fingerpad_length_denied 0.1")
		ply:ConCommand("fingerpad_delay_granted 0")
		ply:ConCommand("fingerpad_delay_denied 0")
		ply:ConCommand("fingerpad_init_delay_granted 0")
		ply:ConCommand("fingerpad_init_delay_denied 0")
	end

	concommand.Add("fingerpad_reset", ResetSettings)

	function TOOL.BuildCPanel(CPanel)
		CPanel:Help("")
		CPanel:ControlHelp("Select teams who can use the fingerpad.")
		CPanel:CheckBox("Citizen", "fingerpad_allow_citizen")
		CPanel:CheckBox("President", "fingerpad_allow_president")
		CPanel:CheckBox("Secret Service", "fingerpad_allow_secretservice")
		CPanel:CheckBox("Terrorist", "fingerpad_allow_terrorist")
		CPanel:Help("")
		CPanel:CheckBox("Weld", "fingerpad_weld")
		CPanel:CheckBox("Freeze", "fingerpad_freeze")

		local ctrl = vgui.Create("CtrlNumPad", CPanel)
			ctrl:SetConVar1("fingerpad_key_granted")
			ctrl:SetConVar2("fingerpad_key_denied")
			ctrl:SetLabel1("Access Granted Key")
			ctrl:SetLabel2("Access Denied Key")
		CPanel:AddPanel(ctrl)

		local granted = vgui.Create("DForm")
			granted:SetName("Access Granted Settings")

			granted:NumSlider("Hold Length:", "fingerpad_length_granted", 0.1, 10, 2)
			granted:NumSlider("Initial Delay:", "fingerpad_init_delay_granted", 0, 10, 2)
			granted:NumSlider("Multiple Press Delay:", "fingerpad_delay_granted", 0, 10, 2)
			granted:NumSlider("Additional Repeats:", "fingerpad_repeats_granted", 0, 5, 0)
		CPanel:AddItem(granted)

		local denied = vgui.Create("DForm")
			denied:SetName("Access Denied Settings")

				denied:NumSlider("Hold Length:", "fingerpad_length_denied", 0.1, 10, 2)
				denied:NumSlider("Initial Delay:", "fingerpad_init_delay_denied", 0, 10, 2)
				denied:NumSlider("Multiple Press Delay:", "fingerpad_delay_denied", 0, 10, 2)
				denied:NumSlider("Additional Repeats:", "fingerpad_repeats_denied", 0, 5, 0)
		CPanel:AddItem(denied)

		CPanel:Button("Default Settings", "fingerpad_reset")

		CPanel:Help("")

		local faq = CPanel:Help("Information")
			faq:SetFont("GModWorldtip")

		CPanel:Help("Keypad created originaly by Willox, edit into fingerpad by Blt950")
	end
end