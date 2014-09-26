--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

local cheapCars = {
	"sent_sakarias_car_junker1",
	"sent_sakarias_car_junker2",
	"sent_sakarias_car_junker3",
	"sent_sakarias_car_junker4"
}

local generalCars = {
	"sent_sakarias_car_belair",
	"sent_sakarias_car_bobcat",
	"sent_sakarias_car_cadillac",
	"sent_sakarias_car_chevy66",
	"sent_sakarias_car_clydesdale",
	"sent_sakarias_car_delorean",
	"sent_sakarias_car_hummer",
	"sent_sakarias_car_huntley",
	"sent_sakarias_car_impala88",
	"sent_sakarias_car_sabre",
	"sent_sakarias_car_stagpickup",
	"sent_sakarias_car_studebaker"
}

local sportCars = {
	"sent_sakarias_car_banshee",
	"sent_sakarias_car_camaro",
	"sent_sakarias_car_comet",
	"sent_sakarias_car_fordgt",
	"sent_sakarias_car_mustang"
}

//	==============================
//		PLAYER SPAWN VEHICLE
//	==============================

function GM:PlayerSpawnVehicle(ply, model, name, stable)
	
	if table.HasValue(cheapCars, name) then
		if PayCar(ply, 1) then
			return true
		end
	elseif table.HasValue(generalCars, name) and ply:HasItem("generalcarsupgrade") > 0 then
		if PayCar(ply, 2) then
			return true
		end
	elseif table.HasValue(sportCars, name) and ply:HasItem("sportcarsupgrade") > 0 then
		if PayCar(ply, 3) then
			return true
		end
	elseif !table.HasValue(cheapCars, name) and !table.HasValue(generalCars, name) and !table.HasValue(sportCars, name) then
		ply:Notify("You don't have access to this vehicle!", 1)
		return false
	else
		ply:Notify("This vehicle needs to be purchased from the shop first!", 1)
		return false
	end

end

//	==============================
//		PLAYER PAY FOR SPAWN VEH
//	==============================

function PayCar(ply, price)
	local nextCarSpawn = ply:GetSharedVar("nextcarspawn")
	if nextCarSpawn and nextCarSpawn > CurTime() and not ply:IsAdmin() then
		ply:Notify("You need to wait "..math.Round((nextCarSpawn - CurTime())/60).." minutes before you can spawn a vehicle again.", 1)
		return false
	end

	if ply:CanAfford(price) then
		ply:GivePoints(-price)
		ply:Notify("You've paid "..price.." points to spawn this vehicle.")
		ply:SetSharedVar("nextcarspawn", CurTime() + 600)
		return true
	else
		ply:Notify("You can't afford to spawn this car. It costs "..price.." points!", 1)
		return false
	end
end

//	==============================
//	RESET CAR TIMER ON DEATH
//	==============================

hook.Add("PlayerDeath", "ResetCartimerDeath", function(victim, inflictor, killer)
	victim:SetSharedVar("nextcarspawn", CurTime())
end)



