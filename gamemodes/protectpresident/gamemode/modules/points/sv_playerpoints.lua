--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

local meta = FindMetaTable("Player")

function meta:GivePoints(amount)
	local points = self:GetPlayerData("points") or 0
	points = points + amount

	if points < 0 then points = 0 end // We don't want to give players below 0 points.

	self:SetPlayerData("points", points)
end