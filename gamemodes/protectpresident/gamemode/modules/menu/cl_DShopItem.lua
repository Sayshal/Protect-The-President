--[[

	Protect The President - Created by Blt950, Maintained by Sayshal
	Help Us Develop: https://github.com/Sayshal/Protect-The-President

]]--

local PANEL = {}

local purchased = Material("icon16/tick.png")

local canbuycolor = Color(0, 200, 0, 125)
local cantbuycolor = Color(200, 0, 0, 125)
local ownedcolor = Color(0, 0, 200, 125)

function PANEL:Init()
	self.Info = ""
	self.InfoHeight = 14
end

function PANEL:DoClick()
	if !LocalPlayer():MaxedItem(self.ID) then
		net.Start( "ptp_shopPurchase" )
			net.WriteString( self.ID )
			net.WriteInt(self.upgradeid, 8)
		net.SendToServer()
		self.MENU:SetVisible(false)
	end
end

function PANEL:SetData(id, data, closepanel)
	self.ID = id
	self.Data = data

	self.MENU = closepanel

	self.upgradeid = 1
	if LocalPlayer():HasItem(self.ID) > 0 then
		if GMShop[self.ID].upgrades[LocalPlayer():HasItem(self.ID)+1] != nil then
			self.upgradeid = LocalPlayer():HasItem(self.ID) + 1
		end
	end

	if #GMShop[self.ID].upgrades > 1 then
		if LocalPlayer():MaxedItem(self.ID) then
			self.Info = data.name .." ("..#GMShop[self.ID].upgrades.."/"..#GMShop[self.ID].upgrades..")"
		else
			self.Info = data.name .." ("..self.upgradeid.."/"..#GMShop[self.ID].upgrades..")"
		end
	else
		self.Info = data.name
	end
	
	if data.model then
		local DModelPanel = vgui.Create('DModelPanel', self)
		DModelPanel:SetModel(data.model)
		DModelPanel:Dock(FILL)
		
		if data.Skin then
			DModelPanel:SetSkin(data.Skin)
		end
		
		local PrevMins, PrevMaxs = DModelPanel.Entity:GetRenderBounds()
		DModelPanel:SetCamPos(PrevMins:Distance(PrevMaxs) * Vector(0.5, 0.5, 0.5))
		DModelPanel:SetLookAt((PrevMaxs + PrevMins) / 2)
		
		function DModelPanel:LayoutEntity(ent)
			if self:GetParent().Hovered then
				ent:SetAngles(Angle(0, ent:GetAngles().y + 2, 0))
			end
			
			//local ITEM = GMShop
			
			//ITEM:ModifyClientsideModel(LocalPlayer(), ent, Vector(), Angle())
		end
		
		function DModelPanel:DoClick()
			self:GetParent():DoClick()
		end
		
		function DModelPanel:OnCursorEntered()
			self:GetParent():OnCursorEntered()
		end
		
		function DModelPanel:OnCursorExited()
			self:GetParent():OnCursorExited()
		end
		
		local oldPaint = DModelPanel.Paint
		
		function DModelPanel:Paint()
			local x, y = self:LocalToScreen( 0, 0 )
			local w, h = self:GetSize()
			 
			local sl, st, sr, sb = x, y, x + w, y + h
			 
			local p = self
			while p:GetParent() do
				p = p:GetParent()
				local pl, pt = p:LocalToScreen( 0, 0 )
				local pr, pb = pl + p:GetWide(), pt + p:GetTall()
				sl = sl < pl and pl or sl
				st = st < pt and pt or st
				sr = sr > pr and pr or sr
				sb = sb > pb and pb or sb
			end
			 
			render.SetScissorRect( sl, st, sr, sb, true )
				oldPaint(self)
			render.SetScissorRect( 0, 0, 0, 0, false )
		end
	end
	
	if self.Data.description then
		self:SetTooltip(self.Data.description)
	end
end

function PANEL:PaintOver()/*
	if self.Data.AdminOnly then
		surface.SetMaterial(adminicon)
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.DrawTexturedRect(5, 5, 16, 16)
	end
	

	if LocalPlayer():PS_HasItemEquipped(self.Data.ID) then
		surface.SetMaterial(equippedicon)
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.DrawTexturedRect(self:GetWide() - 5 - 16, 5, 16, 16)
	end
	
	if self.Data.AllowedUserGroups and #self.Data.AllowedUserGroups > 0 then
		surface.SetMaterial(groupicon)
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.DrawTexturedRect(5, self:GetTall() - self.InfoHeight - 5 - 16, 16, 16)
	end
	*/

	if LocalPlayer():MaxedItem(self.ID) then
		surface.SetMaterial(purchased)
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.DrawTexturedRect(self:GetWide() - 5 - 16, 5, 16, 16)
	end

	self.itemcost = GMShop[self.ID].upgrades[self.upgradeid].price
	
	if LocalPlayer():CanAfford(self.itemcost) then
		self.BarColor = canbuycolor
	else
		self.BarColor = cantbuycolor
	end
	
	if LocalPlayer():MaxedItem(self.ID) then
		self.BarColor = ownedcolor
	end
	
	surface.SetDrawColor(self.BarColor)
	surface.DrawRect(0, self:GetTall() - self.InfoHeight, self:GetWide(), self.InfoHeight)
	
	draw.SimpleText(self.Info, "DefaultSmall", self:GetWide() / 2, self:GetTall() - (self.InfoHeight / 2), Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

function PANEL:OnCursorEntered()
	self.Hovered = true
	
	if LocalPlayer():HasItem(self.ID) > 0 and LocalPlayer():MaxedItem(self.ID) then
		self.Info = "(Purchased)"
	else
		self.Info = self.itemcost.." points"
	end
end

function PANEL:OnCursorExited()
	self.Hovered = false

	if #GMShop[self.ID].upgrades > 1 then
		if LocalPlayer():MaxedItem(self.ID) then
			self.Info = self.Data.name .." ("..#GMShop[self.ID].upgrades.."/"..#GMShop[self.ID].upgrades..")"
		else
			self.Info = self.Data.name .." ("..self.upgradeid.."/"..#GMShop[self.ID].upgrades..")"
		end
	else
		self.Info = self.Data.name
	end
end

vgui.Register('DShopItem', PANEL, 'DPanel')