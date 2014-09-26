--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

local chatHints = {

"Enjoy your stay at Protect the President.",
"Check out our forums at PhunBox.eu",
"Press F2 to change teams.",
"Press F3 to change class.",
"Press F4 to access the shop",
"Propblocking is not permitted! Always have a button or keypad on both sides!",
"Teamkilling and Traitoring is against the rules. It'll be punished by ban!",
"See someone breaking the rules? Collect some proof and post a ban appeal.",
"Protect the President is made by Blt950.",
"Fancy more ammunition, health or better weapons? Check out the shop by pressing F4.",
"The admins are here to help you, please respect them.",
"Do you want more points quickly, and access to exclusive stuff? Donate for Premium at PhunBox.eu!",
"Do you see someone breaking rules? Use /report, to report them to online staff.",
"Donate for Premium at PhunBox.eu, starting on 4.99 EUR and up."

}

local function GiveHint()
	chat.AddText(Color(150,150,150), chatHints[math.random(1, #chatHints)])
end
timer.Create("hints", 60, 0, GiveHint)