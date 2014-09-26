--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

-- A function to calculate alpha from a distance.
function CalculateAlphaFromDistance(maximum, start, finish)
	if (type(start) == "Player") then
		start = start:GetShootPos();
	elseif (type(start) == "Entity") then
		start = start:GetPos();
	end;

	if (type(finish) == "Player") then
		finish = finish:GetShootPos();
	elseif (type(finish) == "Entity") then
		finish = finish:GetPos();
	end;

	return math.Clamp(255 - ((255 / maximum) * (start:Distance(finish))), 0, 255);
end;