--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

//	==============================
//		UTIL .NET
//	==============================

util.AddNetworkString( "ptp_MyChat" )
util.AddNetworkString( "ptp_chatAddTextEx" )

//	==============================
//		RECIEVE CHAT
//	==============================

local function recieveMyChat()
	local ply = net.ReadEntity()
	local overhead = net.ReadString()

	ply:SetSharedVar("typing", overhead)
end
net.Receive("ptp_MyChat", recieveMyChat)

concommand.Add( "ptp_StartChat",function( ply )
    ply:SetSharedVar("istyping", true)
end )

concommand.Add( "ptp_StopChat",function( ply )
    ply:SetSharedVar("istyping", false)
end )

//	==============================
//		PLAYER RECIEVE CHAT
//	==============================

hook.Add("PlayerCanSeePlayersChat" , "ChatRadius" , function( txt, toteam, listener, speaker )  
	if speaker:IsValid() then
    	return listener:GetPos():Distance(speaker:GetPos()) < 400
    end;
end ) 

hook.Add("PlayerCanHearPlayersVoice" , "VoiceChatRadius" , function( p1 , p2 )  
    return (p1:GetPos():Distance(p2:GetPos()) <= 400) 
end ) 