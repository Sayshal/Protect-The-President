--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

// Checkpoints

PresidentCheckpoints = {
	Vector(-3810.786865, -9282.891602, 1480.031250), // High tower
	Vector(-6677.589844, -10231.113281, 72.031250), // Store behind PD
	Vector(-7034.366699, -13679.994141, 58.031250), // Izzies
	Vector(-8861.489258, -10150.458008, 72.031242), // City Park
	Vector(-7670.203125, -4588.120605, 72.031250), // Burger
	Vector(-3444.672119, -4620.312988, 200.031250), // Tides Hotel
	Vector(-3556.474121, -7945.623535, 198.031250), // Emergency Station
	Vector(-2821.532471, 334.589142, 72.031250), // Crossway Garage
	Vector(-2264.293945, 6672.306152, 64.031250), // Industrial Big warehouse
	Vector(-1923.693481, 8632.895508, 64.031250), // Industrial Small warehouse, north
	Vector(1516.571167,  5972.868164,  580.031250), // Industrial, yellow factory top
	Vector(3596.491211, 4431.115234, 64.031250), // Industrial - Brick factory
	Vector(3907.184082, 7115.740723, 64.031250), // Industrial - Store
	Vector(5111.295410, -3555.585938, 228.031250), // Downtown Motors
	Vector(5129.864746, -7675.303223, 104.031250), // Horse Barm
	Vector(9899.484375, 4476.019531, 16.031250), // Ghost Town
	Vector(10398.985352, 13439.349609, 66.031250), // Petrol station
	Vector(2169.702881, 11411.245117, 186.031250), // Suburb House 1
	Vector(3199.504639, 14184.573242, 122.031250), // Suburb House 2
	Vector(4979.333984, 14040.034180, 90.031250), // Suburb House 3
	Vector(4457.914063, 11140.691406, 196.031250), // Suburb House 4 (Old one)
	Vector(-5874.771973, 12915.968750, 234.031250), // Lake house by road
	Vector(-13706.975586, 12134.985352, 234.031250), // Lake house by lake
	Vector(-10487.957031, 9364.819336, 72.031250) // Hospital
}

function CurrentPresident()
	local found = false
	for k,v in pairs(player.GetAll()) do
		if v:Team() == TEAM_PRESIDENT then
			found = true
			return v
		end
	end

	if !found then
		return false
	end
end