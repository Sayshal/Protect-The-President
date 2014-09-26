--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

function CustomCanTool(ply, trace, tool, ENT)
	// Wire Toolgun
	if ply:HasItem("wiretoolgun") < 1 and string.StartWith( tool, "wire_" ) then
		FPP.Notify(ply, "You need to purchase Wire Toolgun in shop, to use Wiremod.", false)
		return false
	end

	// Expression 2 
	if ply:HasItem("expression2tool") > 0 and tool == "wire_expression2" and !ply:IsPremium() then
		FPP.Notify(ply, "You need to be a Premium member to use this tool.", false)
		return false
	elseif ply:HasItem("expression2tool") < 1 and tool == "wire_expression2" then
		FPP.Notify(ply, "You need to purchase 'Expression 2' in shop to use it.", false)
		return false
	end

	
	// Material and Color 
	if ply:HasItem("materialcolortool") > 0 and (tool == "material" or tool == "colour") and !ply:IsPremium() then
		FPP.Notify(ply, "You need to be a Premium member to use this tool.", false)
		return false
	elseif ply:HasItem("materialcolortool") < 1 and (tool == "material" or tool == "colour") then
		FPP.Notify(ply, "You need to purchase 'Material & Color' in shop to use it.", false)
		return false
	end

	// Camera 
	if ply:HasItem("cameratool") > 0 and tool == "camera" and !ply:IsPremium() then
		FPP.Notify(ply, "You need to be a Premium member to use this tool.", false)
		return false
	elseif ply:HasItem("cameratool") < 1 and tool == "camera" then
		FPP.Notify(ply, "You need to purchase 'Camera Tool' in shop to use it.", false)
		return false
	end

end
hook.Add("CanTool", "CustomCanTool", CustomCanTool)

hook.Add( "CanProperty", "block_context_menu", function( ply, property, ent )
	if (  !ply:IsAdmin() and property != "skin" ) then return false end
end )