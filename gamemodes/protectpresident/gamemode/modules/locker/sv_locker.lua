--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

entLock = {
	"floordoor_1",
	"sallsmalldoor",
	"sallyport",
	"liftbutton",
	"cellbtn1",
	"cellbtn2",
	"cellbtn3",
	"cellbtn4",
	"cellbtn5",
	"cellbtn6",
	"cellbtn7",
	"cellbtn8",
	"doordeath"
}

entOpen = {
	"cell1",
	"cell2",
	"cell3",
	"cell4",
	"cell5",
	"cell6",
	"cell7",
	"cell8",
	"cellblockrear",
	"cafeteria"
}

function LockEntities()
	for x, y in pairs(entLock) do
		for k,v in pairs(ents.FindByName(y)) do
			v:Fire("close", "", 0.1)
			v:Fire("lock", "", 0.1)
		end
	end
end
hook.Add("InitPostEntity", "LockEntities", LockEntities)

function OpenEntities()
	for x, y in pairs(entOpen) do
		for k,v in pairs(ents.FindByName(y)) do
			v:Fire("unlock", "", 0.1)
			v:Fire("open", "", 0.1)
		end
	end
end
hook.Add("InitPostEntity", "OpenEntities", OpenEntities)