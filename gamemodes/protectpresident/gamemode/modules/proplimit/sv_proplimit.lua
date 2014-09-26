--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

function Proplimit(ply, models)
	ply.proplimit = 5
	if ply:HasItem("proplimitupgrade") > 0 then
		ply.proplimit = ply:GetItemValue("proplimitupgrade")
	end

	if ply:GetCount("props") >= ply.proplimit and !ply:IsSuperAdmin() then
		ply:Notify("Maximum props reached. Purchase higher proplimit in shop!", 1)
		return false
	end
end
hook.Add("PlayerSpawnProp", "Proplimit", Proplimit)