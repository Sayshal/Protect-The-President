--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

local meta = FindMetaTable("Player")

function meta:HasItem(hasitem)
	local playeritems = self:GetPlayerData("purchaseditems") or {}

	local result = 0
	for itemid, item in pairs(playeritems) do
		if itemid == hasitem then
			result = item 
		end 
	end
	return result
end

function meta:MaxedItem(maxeditem)
	local haveitem = self:HasItem(maxeditem)
	local maxofitem = #GMShop[maxeditem].upgrades

	if haveitem >= maxofitem then
		return true
	else
		return false
	end
end

function meta:GetItemValue(item)
	if !self:IsPremium() then
		if GMShop[item].upgrades[self:HasItem(item)].donator == true then

			local i = 1
			local highest = 0

			while i < #GMShop[item].upgrades do
				if GMShop[item].upgrades[self:HasItem(item)-i].donator == false then
					highest = i
					break
				end
				i = i+1
			end
			return GMShop[item].upgrades[self:HasItem(item)-highest].value

		else
			return GMShop[item].upgrades[self:HasItem(item)].value
		end
	else
		return GMShop[item].upgrades[self:HasItem(item)].value
	end
end