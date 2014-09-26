--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

util.AddNetworkString("ptp_shopPurchase")

net.Receive( "ptp_shopPurchase", function( len, pl )
	if ( IsValid( pl ) and pl:IsPlayer() ) then
		RunPurchase(pl, net.ReadString(), net.ReadInt(8))
	end
end )

function RunPurchase(ply, item, upgrade)
	local itemprice = GMShop[item].upgrades[upgrade].price
	if not ply:CanAfford(itemprice) then ply:Notify("You can't afford this item!", 1) return end

	local donatoritem = GMShop[item].upgrades[upgrade].donator
	if !ply:IsPremium() and donatoritem then ply:Notify("You need to be Premium member to purchase this item!", 1) return end

	local playeritems = ply:GetPlayerData("purchaseditems") or {}
	playeritems[item] = upgrade

	ply:SetPlayerData("purchaseditems", playeritems)
	ply:GivePoints(-itemprice)
	RunNewItem(ply, item)

	local name = GMShop[item].name
	ply:Notify("You've purchased "..name.." for "..itemprice.." points.", 2)

	writeLog(ply:Nick() .. " ["..ply:SteamID().."] purchased "..name.." for "..itemprice.."p (New balance: "..ply:GetPlayerData("points").."p)", Color(255, 190, 0))
end

function RunNewItem(ply, item)
	if item == "toolgun" then
		ply:Give("gmod_tool")
	elseif item == "physgun" then
		ply:Give("weapon_physgun")
	elseif item == "healthupgrade" then
		ply:SetHealth(ply:Health() + ply:GetItemValue("healthupgrade"))
	elseif item == "armorupgrade" then
		ply:SetArmor(ply:Armor() + ply:GetItemValue("armorupgrade"))
	end
end