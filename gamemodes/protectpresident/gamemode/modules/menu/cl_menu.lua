--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

local Menu
local MenuSheet
local menuOpen = false

//	==============================
//			PRINTING MENU
//	==============================

function drawMenu()

	Menu:SetSize( 1024, 768 )
	Menu:SetPos((ScrW() / 2) - (Menu:GetWide() / 2), (ScrH() / 2) - (Menu:GetTall() / 2))
	Menu:SetTitle( "" )
	Menu:SetVisible( true )
	Menu:SetDraggable( false )
	Menu:ShowCloseButton( true )
	Menu:SetSkin("ptpSkin")
	Menu:MakePopup()

	local PtLabel = vgui.Create("DLabel", Menu)
	PtLabel:SetPos(10, 10)
	PtLabel:SetText("Protect the President")
	PtLabel:SetColor(Color(255,255,255,255))
	PtLabel:SetFont("ptp_BigMenu")
	PtLabel:SizeToContents()

	MenuSheet = vgui.Create( "DPropertySheet", Menu )
	MenuSheet:SetPos( 10, 75 )
	MenuSheet:SetSize( 1000, 675 )

	// JOBS PANEL
	local JobPanel = vgui.Create("DPanel")
	JobPanel:SetPos(25,50)
	JobPanel:SetSize(800, 500)
	
	local jump = 0
	for teamid, team in pairs(GMTeams) do
		local TeamPanel = vgui.Create( "DPanel", JobPanel )
		TeamPanel:SetPos( 20, 20 + jump )
		TeamPanel:SetSize( 945, 100 )
		TeamPanel.Paint = function() -- Paint function
		    surface.SetDrawColor( 50, 50, 50, 255 ) -- Set our rect color below us; we do this so you can see items added to this panel
		    surface.DrawRect( 0, 0, TeamPanel:GetWide(), TeamPanel:GetTall() ) -- Draw the rect
		end

		local TeamIcon = vgui.Create( "SpawnIcon", TeamPanel)
		TeamIcon:SetPos( 20, 15 )

		if istable(team.model) then
			TeamIcon:SetModel( team.model[math.random(1, #team.model)] )
		else
			TeamIcon:SetModel( team.model )
		end
		TeamIcon:SetToolTip(team.name)

		TeamTitle = vgui.Create("DLabel", TeamPanel)
		TeamTitle:SetPos(100, 10)
		TeamTitle:SetFont("ptp_TeamTitle")
		TeamTitle:SetText(team.name)
		TeamTitle:SizeToContents()
		TeamTitle:SetTextColor( team.color )

		TeamButton = vgui.Create( "DButton", TeamPanel )
		TeamButton:SetPos( 100 , 60 )
		TeamButton:SetSize( 150, 20 )
		TeamButton:SetText( "Select "..team.name )
		TeamButton.DoClick = function()
		    RunConsoleCommand( "ptp_setTeam", teamid )
			Menu:SetVisible(false)
		end

		TeamDesc = vgui.Create("DLabel", TeamPanel)
		TeamDesc:SetPos(500,20)
		TeamDesc:SetText(team.description)
		TeamDesc:SizeToContents()
		TeamDesc:SetTextColor( Color(255, 255, 255, 255) )

		jump = jump + 105
	end

	

	// CLASSES PANEL
	local ClassesPanel = vgui.Create("DPanel")
	ClassesPanel:SetPos(25,50)
	ClassesPanel:SetSize(800, 500)

	local classjump = 0
	local once = false
	for classid, class in pairs(GMClasses) do
		if class.team == LocalPlayer():Team() then
			once = true
			local ClassPanel = vgui.Create( "DPanel", ClassesPanel )
			ClassPanel:SetPos( 20, 20 + classjump )
			ClassPanel:SetSize( 945, 100 )
			ClassPanel.Paint = function() -- Paint function
			    surface.SetDrawColor( 50, 50, 50, 255 ) -- Set our rect color below us; we do this so you can see items added to this panel
			    surface.DrawRect( 0, 0, ClassPanel:GetWide(), ClassPanel:GetTall() ) -- Draw the rect
			end

			local ClassIcon = vgui.Create( "SpawnIcon", ClassPanel)
			ClassIcon:SetPos( 20, 15 )

			if istable(class.model) then
				ClassIcon:SetModel( class.model[math.random(1, #class.model)] )
			else
				ClassIcon:SetModel( class.model )
			end
			ClassIcon:SetToolTip(class.name)

			ClassTitle = vgui.Create("DLabel", ClassPanel)
			ClassTitle:SetPos(100, 10)
			ClassTitle:SetFont("ptp_TeamTitle")
			ClassTitle:SetText(class.name)
			ClassTitle:SizeToContents()
			ClassTitle:SetTextColor( LocalPlayer():GetTeamColor() )

			ClassButton = vgui.Create( "DButton", ClassPanel )
			ClassButton:SetPos( 100 , 60 )
			ClassButton:SetSize( 150, 20 )
			ClassButton:SetText( "Select "..class.name )
			if class.shopitem and LocalPlayer():HasItem(class.shopitem) < 1 then
				ClassButton:SetDisabled(true)
				ClassButton:SetText("Purchase in shop")
			end
			ClassButton.DoClick = function()
			    RunConsoleCommand( "ptp_setClass", classid )
				Menu:SetVisible(false)
			end

			TeamDesc = vgui.Create("DLabel", ClassPanel)
			TeamDesc:SetPos(500,20)
			TeamDesc:SetText(class.description)
			TeamDesc:SizeToContents()
			TeamDesc:SetTextColor( Color(255, 255, 255, 255) )

			classjump = classjump + 105
		end
	end

	if !once then
		NoClasses = vgui.Create("DLabel", ClassesPanel)
		NoClasses:SetPos(100, 30)
		NoClasses:SetFont("ptp_TeamTitle")
		NoClasses:SetText("There are no classes in your team")
		NoClasses:SizeToContents()
		NoClasses:SetTextColor( Color(0,0,0) )
	end

	// SHOP PANEL
	local ShopPanel = vgui.Create("DPanel")
	ShopPanel:SetPos(25,50)
	ShopPanel:SetSize(800, 500)

	CategoryList = vgui.Create( "DPanelList", ShopPanel)
	CategoryList:SetPos( 10,10 )
	CategoryList:SetSize(965, 620)
	CategoryList:SetSpacing( 5 )
	CategoryList:EnableHorizontal( false )
	CategoryList:EnableVerticalScrollbar( true )

	CollapsibleCategoryTable = {}

	local iteration = 1
	for k,v in pairs( GMShopCategories ) do
		CollapsibleCategoryTable[k] = {}
		CollapsibleCategoryTable[k] = vgui.Create("DCollapsibleCategory", CategoryList)
		CollapsibleCategoryTable[k]:SetPos( 25,50*iteration )
		CollapsibleCategoryTable[k]:SetSize( 965, 50 )
		CollapsibleCategoryTable[k]:SetExpanded( 1 )
		CollapsibleCategoryTable[k]:SetLabel( v )
		CollapsibleCategoryTable[k]:SetSkin("ptpSkin")
		iteration = iteration + 1

		local List = vgui.Create( "DIconLayout", CollapsibleCategoryTable[k] ) //Create the DIconLayout and put it inside of the Scroll Panel.
		List:SetSize( 965, 500 )
		List:SetPos( 5, 30 )
		List:SetSpaceY( 5 )
		List:SetSpaceX( 5 )

		for itemid, item in pairs(GMShop) do
			if item.category == v then
				local model = vgui.Create('DShopItem')
				model:SetData(itemid, item, Menu)
				model:SetSize(126, 126)
				List:Add(model)
			end
		end

		CategoryList:AddItem(CollapsibleCategoryTable[k])
	end

	/*
	//for _, cat in pairs(GMShopCategories) do
		local ShopCollapse = vgui.Create( "DCollapsibleCategory", ShopPanel )    // Create a collapsible category
		//ShopCollapse:SetPos( 10, 10 )                                             // Set position
		//ShopCollapse:SetSize( 250, 100 )                                          // Set size
		ShopCollapse:SetExpanded( 0 )                                             // Is it expanded when you open the panel?
		ShopCollapse:SetLabel( "Secret Service" )

		local ShopScroll = vgui.Create( "DScrollPanel", ShopCollapse ) //Create the Scroll panel
		ShopScroll:SetSize( 890, 500 )
		ShopScroll:SetPos( 10, 10 )

		local ShopList = vgui.Create( "DIconLayout", ShopScroll) //Create the DIconLayout and put it inside of the Scroll Panel.
		ShopList:SetSize( 850, 500 )
		ShopList:SetPos( 0, 0 )
		ShopList:SetSpaceY( 5 ) //Sets the space inbetween the panels on the X Axis by 5
		ShopList:SetSpaceX( 5 ) //Sets the space inbetween the panels on the Y Axis by 5
		
		for itemid, item in pairs(GMShop) do
			if item.category == "Secret Service" then
				local model = vgui.Create('DShopItem')
				model:SetData(item)
				model:SetSize(126, 126)
				ShopList:Add(model)
			end
		end

	//end

	/*
	local nextitem = 0
	local nextjump = 0
	local jump = 0
	for itemid, item in pairs(GMShop) do

		

		local upgradeid = 1
		if LocalPlayer():HasItem(itemid) > 0 then
			if GMShop[itemid].upgrades[LocalPlayer():HasItem(itemid)+1] != nil then
				upgradeid = LocalPlayer():HasItem(itemid) + 1
			end
		end

		local ItemPanel = vgui.Create( "DPanel", ShopPanel )
		ItemPanel:SetPos( 20 + nextitem, 20 + jump )
		ItemPanel:SetSize( 310, 100 )
		ItemPanel.Paint = function() -- Paint function
		    surface.SetDrawColor( 50, 50, 50, 255 ) -- Set our rect color below us; we do this so you can see items added to this panel
		    surface.DrawRect( 0, 0, ItemPanel:GetWide(), ItemPanel:GetTall() ) -- Draw the rect
		end

		ItemTitle = vgui.Create("DLabel", ItemPanel)
		ItemTitle:SetPos(75, 25)
		ItemTitle:SetContentAlignment(5)
		ItemTitle:SetFont("ptp_ItemTitle")
		if #GMShop[itemid].upgrades > 1 then
			if LocalPlayer():MaxedItem(itemid) then
				ItemTitle:SetText(item.name .." ("..#GMShop[itemid].upgrades.."/"..#GMShop[itemid].upgrades..")")
			else
				ItemTitle:SetText(item.name .." ("..upgradeid.."/"..#GMShop[itemid].upgrades..")")
			end
		else
			ItemTitle:SetText(item.name)
		end
		ItemTitle:SizeToContents()
		ItemTitle:SetTextColor( Color(255,255,255) )

		local ClassIcon = vgui.Create( "SpawnIcon", ItemPanel)
		ClassIcon:SetPos( 15, 15 )
		ClassIcon:SetModel( item.model )
		ClassIcon:SetToolTip(item.description)

		ClassButton = vgui.Create( "DButton", ItemPanel )
		ClassButton:SetPos( 75 , 55 )
		ClassButton:SetSize( 100, 20 )
		ClassButton:SetContentAlignment(5)
		if LocalPlayer():MaxedItem(itemid) then
			ClassButton:SetDisabled(true)
			ClassButton:SetText( "Purchased" )
		else
			ClassButton:SetText( GMShop[itemid].upgrades[upgradeid].price.." points" )
		end
		ClassButton.DoClick = function()
		    net.Start( "ptp_shopPurchase" )
				net.WriteString( itemid )
				net.WriteInt(upgradeid ,8)
			net.SendToServer()
			Menu:SetVisible(false)
		end

		nextitem = nextitem + 320
		if nextjump >= 2 then
			nextjump = 0
			nextitem = 0
			jump = jump + 105
		else
			nextjump = nextjump + 1
		end
	end
	*/

	// HELP PANEL
	local HelpPanel = vgui.Create("DPanel")
	HelpPanel:SetPos(25,50)
	HelpPanel:SetSize(800, 500)

	HelpText = vgui.Create("HTML", HelpPanel)
	HelpText:SetHTML([[
		<body style="background-color: white; font-family: Helvetica, sans-serif;">
		<h1>Need some help?</h1>

		<b>Press F2</b> for Jobs<br>
		<b>Press F3</b> for Classes<br>
		<b>Press F4</b> for Shop
		<br><br>
		<i>Normal chat is range based, if you'd like to speak to the whole server. Use /ooc or //</i><br><br>
		<b>/y</b> - To yell in a greater range.<br>
		<b>/w</b> - To whisper in a smaller range.<br>
		<b>/me</b> - is for performances.
		<br><br>
		<b>/radio</b> or <b>/r</b> - All teams have a radio, use this to communicate.<br>
		<b>/broadcast</b> - President only command, to broadcast a message to everyone.<br>
		<br><br>
		<h2>Gameplay help</h2>
		<b>What are Reward Points?</b><br>
		Reward points are points you gain when you do a certain action (such as killing a player). <br>
		These points can be used in the point-shop to unlock new benefits and classes.
		<br><br>
		<b>How can I earn Reward Points?</b>
		<br>* Kill a player of the opposite team. + 3 point.
		<br>* You kill the president as Terrorist. + 20 points. + 5 point to team.
		<br>* Remain alive as president for 15 minutes. + 5 points.
		<br>* Playtime of 30 minutes on the server. + 10 points.
		<br>* President Reaches checkpoint + 5 points. -3 on failure.
		</body>
	]])
	HelpText:SetPos(0,0)
	HelpText:SetSize(1100,700)

	// RULES PANEL
	local RulesPanel = vgui.Create("DPanel")
	RulesPanel:SetPos(25,50)
	RulesPanel:SetSize(800, 500)

	RulesText = vgui.Create("HTML", RulesPanel)
	RulesText:OpenURL("http://phunbox.eu/index.php?threads/server-rules.4/")
	RulesText:SetPos(0,0)
	RulesText:SetSize(985,700)

	// PREMIUM PANEL
	local PremiumPanel = vgui.Create("DPanel")
	PremiumPanel:SetPos(25,50)
	PremiumPanel:SetSize(800, 500)

	PremiumText = vgui.Create("HTML", PremiumPanel)
	PremiumText:SetHTML([[
		<body style="background-color: white; font-family: Helvetica, sans-serif;">
		<div style="padding-top: -100px;">
		<h1>Premium Membership</h1>
		<p>Would you like more points quicker and more exclusive access? Check out our Premium plans!<br><b>Donate at www.phunbox.eu/premium</b></p>
		<img src="http://phunbox.eu/premiums.png" height="70%"/>
		</div>
		</body>
	]])
	PremiumText:SetPos(0,0)
	PremiumText:SetSize(985,700)

	// CREDITS PANEL
	local CreditsPanel = vgui.Create("DPanel")
	CreditsPanel:SetPos(25,50)
	CreditsPanel:SetSize(800, 500)

	CreditsText = vgui.Create("HTML", CreditsPanel)
	CreditsText:SetHTML([[
		<center>
		<body style="background-color: white; font-family: Helvetica, sans-serif;">
		<img src="http://phunbox.eu/PtPLogo.png" width="50%"/>
		<div style="padding-top: -100px;">
		<b>Blt950</b> - Creating the gamemode from scratch<br><br>

		<b>Hats</b> - for using his HatsChat base for the chatbox.<br>
		<b>adamdburton</b> - using bits of his code for the shop.<br>
		<b>Facepunch Members</b> - Problem solving<br>
		<br><br><br><br>
		<img src="http://phunbox.eu/PhunBox%20Logo.png" width="23%"/>
		</div>
		</body>
		</center>
	]])
	CreditsText:SetPos(0,0)
	CreditsText:SetSize(985,700)

	/*

	CreditsText = vgui.Create("DLabel", CreditsPanel)
	CreditsText:SetPos(25,10)
	CreditsText:SetFont("ptp_HelpFont")
	CreditsText:SetText([[
		_Protect the President_

		Blt950 - Creating the gamemode from scratch

		_ Special thanks to _
		Hats - for using his HatsChat base for the chatbox.
		adamdburton - using bits of his code for the shop.
		Facepunch Members - Problem solving
		]])
	CreditsText:SizeToContents()
	CreditsText:SetTextColor( Color(0,0,0) )
*/
	// MERGE THE PIZZA
	 
	jobsSheet = MenuSheet:AddSheet( "Jobs          ", JobPanel, "icon16/user.png", false, false )
	classesSheet = MenuSheet:AddSheet( "Classes          ", ClassesPanel, "icon16/group.png", false, false )
	shopSheet = MenuSheet:AddSheet( "Shop           ", ShopPanel, "icon16/cart.png", false, false )
	MenuSheet:AddSheet( "Premium          ", PremiumPanel, "icon16/heart.png", false, false )
	MenuSheet:AddSheet( "Rules          ", RulesPanel, "icon16/report.png", false, false )
	MenuSheet:AddSheet( "Help          ", HelpPanel, "icon16/exclamation.png", false, false )
	MenuSheet:AddSheet( "Credits          ", CreditsPanel, "icon16/medal_gold_2.png", false, false )
end

//	==============================
//		TOGGELING THE MENU
//	==============================

function openMenu(sheet)
	Menu = vgui.Create("DFrame")
	drawMenu()

	if sheet == "1" then
		MenuSheet:SetActiveTab( jobsSheet.Tab )
	elseif sheet == "2" then
		MenuSheet:SetActiveTab( classesSheet.Tab )
	elseif sheet == "3" then
		MenuSheet:SetActiveTab( shopSheet.Tab )
	else
		MenuSheet:SetActiveTab( jobsSheet.Tab )
	end
	
end

function closeMenu()
	Menu:Hide()
end

function toggleMenu(palyer, command, args)
	if not ValidPanel(Menu) or not Menu:IsVisible() then
		openMenu(args[1])
	else
		closeMenu()
	end
end
concommand.Add("ptp_toggleMenu", toggleMenu)

