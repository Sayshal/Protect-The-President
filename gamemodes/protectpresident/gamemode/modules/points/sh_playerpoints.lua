--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

local meta = FindMetaTable("Player")

function meta:CanAfford(amount)
	local points = self:GetPlayerData("points") or 0
	if points >= amount then
		return true
	else
		return false
	end
end