--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

local meta = FindMetaTable("Player")

function meta:IsPremium()
	return self:GetUserGroup() == "premium" or self:IsAdmin()
end