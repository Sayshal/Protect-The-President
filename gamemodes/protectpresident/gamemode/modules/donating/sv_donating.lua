--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

local sTime = CurTime()

function DonatorTimer()
	if CurTime() > sTime then
		sTime = CurTime() + 120
		getDonatorsSource()
	end
end
hook.Add("Think", "DonatorTimer", DonatorTimer)

//	==============================
//	Gather donators
//	==============================

function getDonatorsSource()

	local TheReturnedHTML = ""; -- Blankness

	http.Fetch( "http://google.ca", -- This needs to point to a config value.
		function( body, len, headers, code )
			TheReturnedHTML = body;
			proccessDonators(TheReturnedHTML)
		end,
		function( error )
			proccessDonators("Error")
		end
	 );
end

//	==============================
//	Proccess the donators
//	==============================

function proccessDonators(data)
	if data == "Error" then return end

	local data = string.Explode(";", data)
	local donators = {}

	for _, ply in pairs(player.GetAll()) do
		for k,v in pairs(data) do
			local newstring = string.Explode("#", data[k])

			local d_steamid = newstring[1]
			local d_type = tonumber(newstring[2])
			local d_expire = tonumber(newstring[3])

			local donationexpire = ply:GetPlayerData("donationexpire") or 0
			local prevbalance = ply:GetPlayerData("points")
			local givenpoints = 0

			if ply:SteamID() == d_steamid then
				table.insert(donators, ply)
			end

			if ply:SteamID() == d_steamid and not ply:IsPremium() and not ply:IsAdmin() then

				RunConsoleCommand("ulx", "adduser", ply:Name(), "premium")

				if os.time() >= tonumber(donationexpire) then
					if d_type == 1 then
						givenpoints = 5000
						ply:GivePoints(givenpoints)
					elseif d_type == 2 then
						givenpoints = 3000
						ply:GivePoints(givenpoints)
					elseif d_type == 3 then
						givenpoints = 1000
						ply:GivePoints(givenpoints)
					end
				end

				ply:SetPlayerData("donationexpire", d_expire)

				if givenpoints > 0 then
					ply:PrintChat(Color(255,100,100), "Thank you for donating to Phunbox Roleplay. You've been applied your points and Premium status.")
				else
					ply:PrintChat(Color(255,100,100), "Thank you for donating to Phunbox Roleplay. You've been applied your Premium status.")
				end
				timer.Simple(10, function() PrintChatAll(Color(200,100,100), "PhunBox would like to thank "..ply:Name().. " for donating to the server <3") end)

				writeLog(ply:Nick() .. " ["..ply:SteamID().."] has been applied Premium status with "..givenpoints.."p. | Prev balance: "..prevbalance.."p | New balance: "..ply:GetPlayerData("points").."p", Color(255, 190, 0))

			elseif ply:SteamID() == d_steamid and ply:IsPremium() and d_expire != tonumber(donationexpire) and d_expire >= tonumber(donationexpire) then
				if d_type == 1 then
					givenpoints = 5000
					ply:GivePoints(givenpoints)
				elseif d_type == 2 then
					givenpoints = 3000
					ply:GivePoints(givenpoints)
				elseif d_type == 3 then
					givenpoints = 1000
					ply:GivePoints(givenpoints)
				end

				ply:PrintChat(Color(255,100,100), "Your donation has been renewed. You've been applied your new points and Premium status.")
				timer.Simple(10, function() PrintChatAll(Color(200,100,100), "PhunBox would like to thank "..ply:Name().. " for donating to the server <3") end)
				writeLog(ply:Nick() .. " ["..ply:SteamID().."] has been renewed Premium status with "..givenpoints.."p. | Prev balance: "..prevbalance.."p | New balance: "..ply:GetPlayerData("points").."p", Color(255, 190, 0))

				ply:SetPlayerData("donationexpire", d_expire)
			end

		end
	end

	for x, y in pairs(player.GetAll()) do
		if not table.HasValue(donators, y) and y:IsPremium() and not y:IsAdmin() then
				
			RunConsoleCommand("ulx", "removeuser", y:Name())
			y:PrintChat(Color(255,100,100), "Your Premium has expired. Your Premium advantages are now disabled. If you believe this is a error, please contact the administration.")

			writeLog(y:Nick() .. "'s ["..y:SteamID().."] premium has expired.", Color(255, 190, 0))

		end
	end

end