--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

function findPly(info) 
    if not info or info == "" then return nil end
    local pls = player.GetAll()
    for k = 1, #pls do 
        local v = pls[k]
        if tonumber(info) == v:UserID() then
            return v
        end
        if info == v:SteamID() then
            return v
        end
        --if string.find(string.lower(v:SteamName()), string.lower(tostring(info)), 1, true) ~= nil then
        --  return v
        --end
        if string.find(string.lower(v:Name()), string.lower(tostring(info)), 1, true) ~= nil then
            return v
        end
    end
    return nil
end

//	==============================
//		CHAT COMMANDS ENGINE
//	==============================
 
local prefix = "/"
chatcommand = {}
chatcommand.Commands = {}
 
function chatcommand.Add( command, func )
    chatcommand.Commands[prefix .. command] = func
end
 
function chatcommand.Remove( command )
    chatcommand.Commands[prefix .. command] = nil
end
 
function chatcommand.PlayerSay( ply, text, teamchat )
 
    -- Explode the text into a table.
    local cmd = string.Explode( " ", text )
         
    for K, V in pairs( chatcommand.Commands ) do
     
        -- If the first entry in the table matches an existing command...
        if( string.lower(cmd[1]) == K ) then
             
            -- Strip the command out of the text.
            local cmd = string.gsub( text, cmd[1] .. " ", "" )
 
            -- Explode the remaining text into arguments.
            local args = string.Explode( " ", cmd )
         
            -- Run the function assigned to that command.
            chatcommand.Commands[K]( ply, K, args )
 
            -- Return false to prevent text being displayed.
            return false
             
        end
         
    end
    return text
end
hook.Add( "PlayerSay", "chatcommand_PlayerSay", chatcommand.PlayerSay )



//	==============================
//		CHAT COMMANDS
//	==============================


function OOC( ply, cmd, args )
	local text = string.Implode( " ", args )
	if not text then return end
	
    PrintChatAll(Color(125,125,125), "[OOC] ", ply:GetTeamColor(), ply:Name()..": ", Color(255,255,255), text)
    writeLog("[OOC] "..ply:Name()..": "..text)
end
chatcommand.Add( "ooc", OOC )
chatcommand.Add( "/", OOC )

function Perform( ply, cmd, args )
    local text = string.Implode( " ", args )
    if not text then return end
    
    PrintChatAudience(GetPlayersInRadius(ply, 400), ply:GetTeamColor(), "* "..ply:Name().." "..text)
end
chatcommand.Add( "me", Perform )

function Yell( ply, cmd, args )
    local text = string.Implode( " ", args )
    if not text then return end
    
    PrintChatAudience(GetPlayersInRadius(ply, 800), ply:GetTeamColor(), ply:Name().." yells: ", Color(255,0,0), text)
end
chatcommand.Add( "y", Yell )
chatcommand.Add( "yell", Yell )

function Whisper( ply, cmd, args )
    local text = string.Implode( " ", args )
    if not text then return end
    
    PrintChatAudience(GetPlayersInRadius(ply, 200), ply:GetTeamColor(), ply:Name().." whispers", Color(255,255,255), ": "..text)
end
chatcommand.Add( "w", Whisper )
chatcommand.Add( "whisper", Whisper )


function Radio(ply,cmd,args)
    for k,v in pairs(player.GetAll()) do
        if ply:Team() == v:Team() or (ply:Team() == TEAM_PRESIDENT and v:Team() == TEAM_SECRETSERVICE) or (ply:Team() == TEAM_SECRETSERVICE and v:Team() == TEAM_PRESIDENT) then
            local text = string.Implode(" ", args)
            if v:Class() == CLASS_SS_LEADER then
                v:PrintChat(Color(255,85,125), "[RADIO] ", Color(255,0,0), "(Leader) ", ply:GetTeamColor(), ply:Name()..": ", Color(255,255,255), text)
            elseif v:Class() == CLASS_T_BOSS then
                v:PrintChat(Color(255,85,125), "[RADIO] ", Color(255,0,0), "(Boss) ", ply:GetTeamColor(), ply:Name()..": ", Color(255,255,255), text)
            else
                v:PrintChat(Color(255,85,125), "[RADIO] ", ply:GetTeamColor(), ply:Name()..": ", Color(255,255,255), text)
            end
        end
    end
end
chatcommand.Add( "r", Radio  )
chatcommand.Add( "radio", Radio  )

function Broadcast( ply, cmd, args )
    local text = string.Implode(" ", args)
    if ply:Team() == TEAM_PRESIDENT then
        PrintChatAll(Color(200,125,125), "[BROADCAST] ", ply:GetTeamColor(), "President "..ply:Name()..": ", Color(255,255,255), text)
    else
        ply:Notify("You must be the president to use this command!", 1)
    end
end
chatcommand.Add( "broadcast", Broadcast )

function ReportMsg(ply, cmd, args)
    local text = string.Implode(" ", args)
    if text == "" then return end
    local audience = {}
    
    for k, v in pairs(player.GetAll()) do
        local vt = v:IsAdmin()
        if vt == true then table.insert(audience, v) end
    end
    table.insert(audience, ply)
    for k, v in pairs(audience) do
        local col = team.GetColor(ply:Team())
        v:PrintChat(Color(255,0,0), "[REPORT TO ADMIN] ", col, ply:Nick()..": ", Color(255,255,255,255), text)
    end
end
chatcommand.Add( "report", ReportMsg )

function AdminMsg(ply, cmd, args)
    local text = string.Implode(" ", args)
    if args == "" then return end
    if !ply:IsAdmin() then ply:Notify("You don't have access to this command! Use '//'' or '/ooc' for OOC.", 1) return end
    local audience = {}
    
    for k, v in pairs(player.GetAll()) do
        local vt = v:IsAdmin()
        if vt == true then table.insert(audience, v) end
    end
    for k, v in pairs(audience) do
        local col = team.GetColor(ply:Team())
        v:PrintChat(Color(255,255,0), "[ADMIN CHAT] ", col, ply:Nick()..": ", Color(255,255,255,255), text)
    end
end
chatcommand.Add( "a", AdminMsg )

function PrivateMsg(ply, cmd, args)
    if args[1] == "" or args[2] == "" then return end
    
    if findPly(args[1]) then
        local sendto = findPly(args[1])
        local newtable = args
        table.remove( newtable, 1 )
        local text = string.Implode(" ", newtable)
        sendto:PrintChat(Color(255,255,0), "[PM] ", Color(255,255,255), ply:Nick()..": ", Color(255,255,255,255), text)
        ply:PrintChat(Color(255,255,0), "[PM] ", Color(255,255,255), ply:Nick()..": ", Color(255,255,255,255), text)
    else
        ply:Notify("Could not find the player.", 1)
    end
end
chatcommand.Add( "pm", PrivateMsg )

function AdmGivePoints(ply, cmd, args)
    if args[1] == "" or args[2] == "" then return end
    if not ply:IsSuperAdmin() then ply:Notify("You don't have access to this command!", 1) return end
    
    if findPly(args[1]) then
        local sendto = findPly(args[1])
        ply:Notify("You've given '"..sendto:Name().."' "..tostring(args[2]).." points.")
        writeLog(ply:Nick() .. " has ADMIN GIVEN "..tostring(args[2]).." points to "..sendto:Name(), Color(255, 190, 0))
        sendto:GivePoints(tonumber(args[2]))
    else
        ply:Notify("Could not find the player.", 1)
    end
end
chatcommand.Add( "admgivepoints", AdmGivePoints )

function GivePoints(ply, cmd, args)
    if args[1] == "" or args[2] == "" or !isnumber(tonumber(args[2])) then ply:Notify("Usage: /givepoints <player> <amount>") return end

    if findPly(args[1]) then
        local sendto = findPly(args[1])
        local points = math.Round(tonumber(args[2]))

        if not ply:CanAfford(points) then ply:Notify("You don't have so much points!", 1) return end
        if points < 1 then ply:Notify("The points have to be above zero!", 1) return end
        if sendto == ply then ply:Notify("You can't give points to yourself!", 1) return end

        ply:Notify("You've given '"..sendto:Name().."' "..tostring(points).." points.")
        writeLog(ply:Nick() .. " has given "..tostring(points).." points to "..sendto:Name(), Color(255, 190, 0))
        sendto:GivePoints(points)
        ply:GivePoints(-points)
    else
        ply:Notify("Could not find the player.", 1)
    end
end
chatcommand.Add( "givepoints", GivePoints )

function KickPres(ply, cmd, args)
    if args[1] == "" or args[2] == "" then return end
    if not ply:IsAdmin() then ply:Notify("You don't have access to this command!", 1) return end
    
    if findPly(args[1]) then
        local sendto = findPly(args[1])

        if sendto:Team() != TEAM_PRESIDENT then ply:Notify("This player is not President!", 1) return end

        sendto:Notify("You've been kicked out of your presidency by an admin.", 1)
        ply:Notify("You've kicked out "..sendto:Name().." as President.")

        writeLog(ply:Nick() .. " has kicked out "..sendto:Name().." as President.", Color(255, 190, 0))
        sendto:SetTeam(TEAM_CITIZEN)
        sendto:SetClass(nil)
        GAMEMODE:PlayerLoadout(sendto)
        GAMEMODE:PlayerSelectSpawn(sendto)
    else
        ply:Notify("Could not find the player.", 1)
    end
end
chatcommand.Add( "kickpresident", KickPres )