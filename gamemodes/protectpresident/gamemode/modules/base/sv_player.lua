--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

local meta = FindMetaTable("Player")

//	==============================
//		  PLAYER INIT SPAWN
//	==============================

function GM:PlayerInitialSpawn(ply)
	ply:SetPlayerData("points", 0)
	ply:SetSharedVar("sqlready", false)
	ply:SetSharedVar("stamina", 100)
	ply:SetSharedVar("teamchange", 0)
	ply:SetSharedVar("classchange", 0)
	CheckData(ply)

	timer.Simple(2, function()
		if ply:HasItem("jumpupgrade") > 0 then
			ply:SetJumpPower(DEFAULT_JUMPPOWER*ply:GetItemValue("jumpupgrade"))
		else
			ply:SetJumpPower(DEFAULT_JUMPPOWER)
		end

		if ply:HasItem("runspeedupgrade") > 0 then
			ply:SetRunSpeed(250*ply:GetItemValue("runspeedupgrade"))
		else
			ply:SetRunSpeed(DEFAULT_RUNSPEED)
		end
		
		ply:SetWalkSpeed(DEFAULT_WALKSPEED)

		GAMEMODE:PlayerLoadout(ply)
	end)
	
	
	ply:SetTeam( TEAM_CITIZEN )
	SpawnGod(ply)

	PrintChatAll(COLOR_CONNECT, ply:Nick().." has joined the server.")
	writeLog(ply:Nick() .. " ["..ply:SteamID().."] has joined the server.", Color(255, 190, 0))
end

//	==============================
//		  PLAYER SPAWN
//	==============================

function GM:PlayerSpawn(ply)
	ply:SetSharedVar("stamina", 100)

	timer.Simple(2, function()
		if ply:HasItem("jumpupgrade") > 0 then
			ply:SetJumpPower(DEFAULT_JUMPPOWER*ply:GetItemValue("jumpupgrade"))
		else
			ply:SetJumpPower(DEFAULT_JUMPPOWER)
		end

		if ply:HasItem("runspeedupgrade") > 0 then
			ply:SetRunSpeed(DEFAULT_RUNSPEED*ply:GetItemValue("runspeedupgrade"))
		else
			ply:SetRunSpeed(DEFAULT_RUNSPEED)
		end
		
		ply:SetWalkSpeed(DEFAULT_WALKSPEED)
	end)

	SpawnGod(ply)

	GAMEMODE:PlayerLoadout( ply )
	self.BaseClass:PlayerSpawn(ply)
end

function SpawnGod(ply)
	if ply:IsPlayer() and ply:IsValid() then
		ply:GodEnable()
		ply:SetMaterial("models/alyx/emptool_glow")
		timer.Simple(8, function()
			if ply:Alive() and ply:IsValid() then
				ply:GodDisable()
				ply:SetMaterial("")
			end
		end)
	end
end

//	==============================
//		  PLAYER LOADOUT
//	==============================

function GM:PlayerLoadout( ply )
	ply:SetSharedVar("stamina", 100)
	ply:StripWeapons()
	
	ply:Give("weapon_physcannon")
	ply:Give( "gmod_camera" )

	if ply:HasItem("physgun") > 0 or ply:IsAdmin() then
		ply:Give("weapon_physgun")
	end

	if ply:HasItem("toolgun") > 0 or ply:IsAdmin() then
		ply:Give("gmod_tool")
	end

	if ply:Team() == TEAM_SECRETSERVICE then

		if ply:Class() == CLASS_SS_AGENT then
			ply:Give( "m9k_usp" )

			if ply:HasItem("ss_agentwep") > 0 then
				ply:Give( "m9k_famas" )
			else
				ply:Give( "m9k_mp5" )
			end

		elseif ply:Class() == CLASS_SS_TECH then
			ply:Give( "m9k_usp" )
			ply:Give( "keypad_cracker" )

			if ply:HasItem("ss_proxmine") > 0 then
				ply:Give( "m9k_proxy_mine" )
			end

			if ply:HasItem("ss_nervegas") > 0 then
				ply:Give( "m9k_nerve_gas" )
			end
		elseif ply:Class() == CLASS_SS_SCOUT then
			ply:Give( "m9k_usp" )
			ply:Give( "m9k_aw50" )
		elseif ply:Class() == CLASS_SS_SHIELD then
			ply:Give( "m9k_usp" )

			if ply:HasItem("ss_shieldwep") > 0 then
				ply:Give( "m9k_m4a1" )
			else
				ply:Give( "m9k_mp9" )
			end
		elseif ply:Class() == CLASS_SS_LEADER then
			ply:Give( "m9k_usp" )
			ply:Give( "m9k_f2000" )
		elseif ply:Class() == CLASS_SS_GHOST then
			ply:Give( "m9k_machete" )
			ply:Give( "m9k_mp5sd" )

			if ply:HasItem("ss_ghostwep") > 0 then
				ply:Give( "m9k_svu" )
			end
		end

	elseif ply:Team() == TEAM_PRESIDENT then
		ply:Give( "m9k_deagle" )
		//ply:Give( "m9k_m3" )
	elseif ply:Team() == TEAM_TERRORIST then
		if ply:Class() == CLASS_T_MEMBER then
			ply:Give( "m9k_sig_p229r" )

			if ply:HasItem("t_memberwep") > 0 then
				ply:Give( "m9k_fal" )
			else
				ply:Give( "m9k_ump45" )
			end
			
		elseif ply:Class() == CLASS_T_ASSAULT then
			ply:Give( "m9k_sig_p229r" )
			ply:Give( "m9k_ak47" )
		elseif ply:Class() == CLASS_T_TECH then
			ply:Give( "m9k_sig_p229r" )
			ply:Give( "keypad_cracker" )

			if ply:HasItem("t_proxmine") > 0 then
				ply:Give( "m9k_proxy_mine" )
			end

			if ply:HasItem("t_c4") > 0 then
				ply:Give( "m9k_suicide_bomb" )
			end
		elseif ply:Class() == CLASS_T_HEAVY then
			ply:Give( "m9k_sig_p229r" )
			ply:Give( "m9k_m249lmg" )
		elseif ply:Class() == CLASS_T_SCOUT then
			ply:Give( "m9k_sig_p229r" )
			ply:Give( "m9k_m24" )
		elseif ply:Class() == CLASS_T_BOSS then
			ply:Give( "m9k_sig_p229r" )
			ply:Give( "m9k_ak74" )
		end

	end

	// Give pistol and SMG ammo according to shop
	if ply:HasItem("ammoupgrade") > 0 then
		ply:GiveAmmo(ply:GetItemValue("ammoupgrade"), "pistol")
		ply:GiveAmmo(ply:GetItemValue("ammoupgrade"), "ar2")
		ply:GiveAmmo(ply:GetItemValue("ammoupgrade"), "SniperPenetratedRound")
		ply:GiveAmmo(ply:GetItemValue("ammoupgrade"), "smg1")
		ply:GiveAmmo(ply:GetItemValue("ammoupgrade"), "buckshot")
	end

	// Set health according to shop
	if ply:HasItem("healthupgrade") > 0 then
		ply:SetHealth(100 + ply:GetItemValue("healthupgrade"))
	else
		ply:SetHealth(100)
	end

	// Set armor according to shop
	if ply:HasItem("armorupgrade") > 0 then
		ply:SetArmor(ply:GetItemValue("armorupgrade"))
	end

	GAMEMODE:PlayerSetModel( ply )
end

//	==============================
//		  PLAYER SET MODEL
//	==============================

function GM:PlayerSetModel( ply )
	local team = GMTeams[ply:Team()]

	if istable(team.model) then
			ply:SetModel( team.model[math.random(1, #team.model)] )
	else
		ply:SetModel( team.model )
	end

	if ply:Class() == CLASS_SS_GHOST then
		ply:SetModel( "models/player/archer.mdl" )
	end

end

//	==============================
//		  PLAYER DISCONNECT
//	==============================

function GM:PlayerDisconnected(ply)
	UpdateData(ply) // Save their last data to MySQL

	PrintChatAll(COLOR_CONNECT, ply:Nick().." has left the server.")
	writeLog(ply:Nick() .. " ["..ply:SteamID().."] has left the server.", Color(255, 190, 0))
end

//	==============================
//		  PLAYER DEATH
//	==============================

function GM:PlayerDeath(victim, weapon, killer)
	local KillerName = (killer:IsPlayer() and killer:Nick()) or tostring(killer)

	local WeaponName = IsValid(weapon) and ((weapon:IsPlayer() and IsValid(weapon:GetActiveWeapon()) and weapon:GetActiveWeapon():GetClass()) or weapon:GetClass()) or "unknown"
	if IsValid(weapon) and weapon:GetClass() == "prop_physics" then
		WeaponName = weapon:GetClass() .. " (" .. (weapon:GetModel() or "unknown") .. ")"
	end

	if killer == victim then
		KillerName = "Himself"
		WeaponName = "suicide trick"
	end

	writeLog(victim:Nick() .. " was killed by " .. KillerName .. " with a " .. WeaponName, Color(255, 190, 0))

	// Presidency Functions

	if victim:Team() == TEAM_PRESIDENT then
		if ( victim == killer ) then
			PrintChatAll(Color(255,0,0), "[Breaking News]: ", Color(255,255,255), "The president has committed suicide!")
	    else
	    	if killer:IsNPC() then
	    		PrintChatAll(Color(255,0,0), "[Breaking News]: ", Color(255,255,255), "The president '"..victim:Name().."' has been KILLED BY "..tostring(killer:GetClass()))
	    	elseif killer:IsPlayer() then
	    		if killer:Team() != TEAM_SECRETSERVICE then
	    			PrintChatAll(Color(255,0,0), "[Breaking News]: ", Color(255,255,255), "The president '"..victim:Name().."' has been KILLED BY "..tostring(killer:Name()))
		    		killer:SetTeam(TEAM_PRESIDENT)
		    		killer:SetClass(nil)
		    		GAMEMODE:PlayerLoadout(killer)
		    		GAMEMODE:PlayerSelectSpawn(killer)
		    	else
		    		killer:PrintChat(Color(255,0,0), "Killing teammates will not give you presidency.")
		    	end
	    	else
	    		PrintChatAll(Color(255,0,0), "[Breaking News]: ", Color(255,255,255), "The president has died!")
	    	end
	    	
	    end

		if killer:IsPlayer() and killer:Team() != TEAM_SECRETSERVICE then
			victim:SetTeam( TEAM_CITIZEN )
			victim:PrintChat(Color(255,0,0), "You've been killed! You're now a citizen.")
		end
	end

	self.BaseClass:PlayerDeath(victim, weapon, killer)
end

//	==============================
//		  PLAYER SET TEAM
//	==============================

function ChangeTeam(ply, command, args)
	if CurTime() >= ply:GetSharedVar("teamchange")+60 then

		if tonumber(args[1]) == ply:Team() then ply:Notify("You're already in this team.", 1) return end
		if getTeamRate(tonumber(args[1])) > 50 then ply:Notify("You can not change to this team. We need balanced teams, try the opposite team instead!", 1) return end

		// TEAM LIMIT PRESIDENT
		if tonumber(args[1]) == TEAM_PRESIDENT then
			for k,v in pairs(player.GetAll()) do
				if v:Team() == TEAM_PRESIDENT then
					ply:Notify("There is already one president, there can only be one at the time.", 1)
					return
				end
			end
		end

		ply:SetTeam( tonumber(args[1]) )
		ply:SetSharedVar("teamchange", CurTime())
		ply:Notify("You've changed job to "..ply:GetTeamName(), 2)
		writeLog(ply:Nick() .. " has changed team to "..ply:GetTeamName(), Color(255, 190, 0))
		NotifyAll(ply:Nick() .. " has become "..ply:GetTeamName(), 2)

		// Set class
		if GMTeams[ply:Team()].defaultclass != false then
			ply:SetClass(GMTeams[ply:Team()].defaultclass)
		else
			ply:SetClass(nil)
		end

		if ply:Team() == TEAM_PRESIDENT then
			PrintChatAll(Color(255,0,0), "[Breaking News]: ", Color(255,255,255), "The new president is "..ply:Name())
			if pointsEnabled then
				ply:PrintChat(Color(255,100,0), "[Checkpoint] ", Color(255,255,255), "Welcome Mr. President! Please reach the checkpoint within time and get 5 points, or loose 3 if you fail. Good luck!")
				CheckpointReset()
			end
		end

		GAMEMODE:PlayerSelectSpawn(ply)
		GAMEMODE:PlayerLoadout( ply )
	else
		ply:Notify("Please wait "..math.Round(ply:GetSharedVar("teamchange")+60-CurTime()).." seconds before changing teams.", 1)
	end
end
concommand.Add( "ptp_setTeam", ChangeTeam )

//	==============================
//		 PLAYER CHANGE CLASS CMD
//	==============================
function ChangeClass(ply, command, args)
	local class = tonumber(args[1])
	if CurTime() >= ply:GetSharedVar("classchange")+60 then

		if ply:Team() == GMClasses[class].team then

			if GMClasses[class].shopitem and ply:HasItem(GMClasses[class].shopitem) < 1 then ply:Notify("You need to purchase this class in the shop first.", 1) return end
			if GMClasses[class].donatoronly and !ply:IsPremium() then ply:Notify("This class is for Premium members only.", 1) return end
			if class == ply:GetSharedVar("class") then ply:Notify("You're already in this class.", 1) return end
			if GMClasses[class].maxslots and CountClassPlayers(class) >= GMClasses[class].maxslots then ply:Notify("Maximum players within this class reached, try something else.", 1) return end

			ply:SetClass(tonumber(args[1]))
			ply:SetSharedVar("classchange", CurTime())
			ply:Notify("You've changed class to "..ply:GetClassName(), 2)
			GAMEMODE:PlayerSelectSpawn(ply)
			GAMEMODE:PlayerLoadout( ply )
			writeLog(ply:Nick() .. " has changed class to "..ply:GetClassName(), Color(255, 190, 0))
			NotifyAll(ply:Nick() .. " has changed class to "..ply:GetClassName(), 2)

		else
			ply:Notify("This class is not available at your current team.", 1)
		end

	else
		ply:Notify("Please wait "..math.Round(ply:GetSharedVar("classchange")+60-CurTime()).." seconds before changing class.", 1)
	end
end
concommand.Add( "ptp_setClass", ChangeClass )

//	==============================
//		 PLAYER SELECT SPAWN
//	==============================


function GM:PlayerSelectSpawn( ply )
	if ply:InVehicle() then ply:ExitVehicle() end

	local cSpawns = {
		Vector(-7307.244141, -9927.548828, -431.968750),
		Vector(-7312.332520, -10053.871094, -431.968750),
		Vector(-7324.468750, -10186.401367, -431.968750),
		Vector(-7322.985352, -10306.871094, -431.968750),
		Vector(-7637.416992, -10312.932617, -431.968750),
		Vector(-7645.861328, -10180.256836, -431.968750),
		Vector(-7639.664063, -10053.757813, -431.968750),
		Vector(-7640.298828, -9918.913086, -431.968750)
	}

    local pSpawns = {
    	Vector(-7297.250000, -8892.629883, 72.03125),
    	Vector(-7471.792969, -6863.904785, 72.031),
    	Vector(-6923.707520, -8796.479492, -183.40),
    	Vector(-5717.739746, -10306.751953, 72.031250),
    	Vector(-5501.784180, -6864.120117, 72.031250)
    }
    local tSpawns = {
    	Vector(-1406.220825, -5298.254395, 64.031250),
    	Vector(1556.575317, -6036.851074, 67.042542),
    	Vector(1571.766357, -7776.995117, 95.723511),
    	Vector(-391.447876, -7910.993652, 73.539055),
    	Vector(-737.569885, -8561.248047, 64.031250),
    	Vector(3685.457520, -6938.162598, 65.239189)
    }

    if ply:Team() == TEAM_SECRETSERVICE or ply:Team() == TEAM_PRESIDENT then
    	ply:SetPos(table.Random(pSpawns))
    elseif ply:Team() == TEAM_TERRORIST then
    	ply:SetPos(table.Random(tSpawns))
    elseif ply:Team() == TEAM_CITIZEN then
    	ply:SetPos(table.Random(cSpawns))
    else
    	local spawns = ents.FindByClass( "info_player_start" )
    	local random_entry = math.random( #spawns )
    
    	ply:SetPos(spawns[ random_entry ]:GetPos())
    end

	
end

//	==============================
//		 SCALE PLAYER DAMAGE
//	==============================

function GM:ScalePlayerDamage( ply, hitgroup, dmginfo )
	 if ( hitgroup == HITGROUP_HEAD ) then
 		dmginfo:ScaleDamage( 4 )
	 end
end

//	==============================
//		 PLAYER TEAM CHAT
//	==============================

function OnTeamChat( ply, string, teamchat )
	if teamchat then
		for k,v in pairs(player.GetAll()) do
	        if ply:Team() == v:Team() or (ply:Team() == TEAM_PRESIDENT and v:Team() == TEAM_SECRETSERVICE) or (ply:Team() == TEAM_SECRETSERVICE and v:Team() == TEAM_PRESIDENT) then
	            local text = string
	            if v:Class() == CLASS_SS_LEADER then
	                v:PrintChat(Color(255,85,125), "[RADIO] ", Color(255,0,0), "(Leader) ", ply:GetTeamColor(), ply:Name()..": ", Color(255,255,255), text)
	            elseif v:Class() == CLASS_T_BOSS then
	                v:PrintChat(Color(255,85,125), "[RADIO] ", Color(255,0,0), "(Boss) ", ply:GetTeamColor(), ply:Name()..": ", Color(255,255,255), text)
	            else
	                v:PrintChat(Color(255,85,125), "[RADIO] ", ply:GetTeamColor(), ply:Name()..": ", Color(255,255,255), text)
	            end
	        end
	    end
		return false
	end
end
hook.Add("PlayerSay", "OnTeamChat", OnTeamChat)

//	==============================
//		 PLAYER SET CLASS
//	==============================

function meta:SetClass(class)
	self:SetSharedVar("class", class)
end

//	==============================
//	 COUNT PLAYERS WITHIN CLASS
//	==============================

function CountClassPlayers(class)
	local count = 0
	for k,v in pairs(player.GetAll()) do
		if v:Class() == class then
			count = count + 1
		end
	end
	return count
end

//	==============================
//	 GET TEAM RATE
//	==============================


function getTeamRate(team)
	local rate = 0
	local players = 0
	for k,v in pairs(player.GetAll()) do
		if v:Team() == TEAM_SECRETSERVICE or v:Team() == TEAM_TERRORIST then
			players = players + 1
		end
		if v:Team() == team then
			rate = rate + 1
		end
	end
	local total = (rate / players) * 100
	return total
end
