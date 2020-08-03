local helpers = Aptechka.helpers
local _, playerClass = UnitClass("player")
local isHealer = (playerClass == "PRIEST" or playerClass == "PALADIN" or playerClass == "SHAMAN" or playerClass == "DRUID")
local A = helpers.AddAura
local Trace = helpers.AddTrace
local config = AptechkaDefaultConfig


config.TargetStatus = { name = "Target", assignto = "border", color = {0.7,0.2,0.5}, priority = 65 }
config.MouseoverStatus = { name = "Mouseover", assignto = "border", color = {1,0.5,0.8}, priority = 66 }

config.LeaderStatus = { name = "Leader", priority = 59, assignto = "LeaderIndicator", color = {1,.8,.2} }
config.AssistStatus = { name = "Assist", priority = 59, assignto = "AssistantIndicator", color = {1,.8,.2} }

if playerClass == "DRUID" then
    --A{ id = 1126,  type = "HELPFUL", assignto = { "bars" }, color = { 235/255 , 145/255, 199/255}, isMissing = true } --Mark of the Wild
    A{ id = 33763, type = "HELPFUL", assignto = { "spell3", }, showDuration = true, isMine = true, color = { 0.5, 1, 0.5}, } --Lifebloom
    A{ id = 102351, type = "HELPFUL", assignto = { "spell2" }, priority = 70, color = {38/255, 221/255, 163/255}, isMine = true } --Cenarion Ward
    --A{ id = 774,   type = "HELPFUL", assignto = { "spell1"}, pulse = true, color = { 1, 0.2, 1}, showDuration = true, isMine = true } --Rejuvenation
    A{ id = 8936,  type = "HELPFUL", assignto = { "spell3" }, priority = 82, color = { 198/255, 233/255, 80/255}, showDuration = true, isMine = true } --Regrowth
    A{ id = 48438, type = "HELPFUL", assignto = { "spell5" }, pulse = true, color = { 0.4, 1, 0.4}, priority = 70, showDuration = true, isMine = true } --Wild Growth
end

config.OfflineStatus = { name = "OFFLINE", assignto = { "text2","text3","health","power" }, color = {.15,.15,.15}, textcolor = {1,1,0}, text = "OFFLINE",  priority = 70}
config.AwayStatus = { name = "AFK", assignto = { "text2","text3" }, color = {.15,.15,.15}, textcolor = {0,128,0}, text = "AFK",  priority = 60}

Aptechka.PostFrameCreate = function(self)
    self.LeaderIndicator = self.health:CreateTexture("$parentLeaderIcon", "OVERLAY", nil, 7)
    self.LeaderIndicator:SetSize(12, 12)
    self.LeaderIndicator:SetPoint("LEFT", self.health, "TOPLEFT", 1, 3)
    self.LeaderIndicator:SetTexture([[Interface\GroupFrame\UI-Group-LeaderIcon]])
    self.LeaderIndicator.SetJob = function() end
    self.LeaderIndicator:Hide()

    self.AssistantIndicator = self.health:CreateTexture("$parentAssistIcon", "OVERLAY", nil, 7)
    self.AssistantIndicator:SetSize(12, 12)
    self.AssistantIndicator:SetPoint("LEFT", self.health, "TOPLEFT", 1, 3)
    self.AssistantIndicator:SetTexture([[Interface\GroupFrame\UI-Group-AssistantIcon]])
    self.AssistantIndicator.SetJob = function() end
    self.AssistantIndicator:Hide()

    self.spell4 = config.GridSkin_CreateIndicator(self,6,6,"TOPLEFT",self,"TOPLEFT",0,0)

    self.spell5 = config.GridSkin_CreateIndicator(self,6,6,"RIGHT",self,"RIGHT",0,0)  -- w/h = 6
end

Aptechka.PostFrameUpdate = function(self)
    self.roleicon:ClearAllPoints()
    self.roleicon:SetPoint("CENTER",self.health,"LEFT", 0, -5)
    self.roleicon:SetWidth(12)
    self.roleicon:SetHeight(12)
    self.text1:SetPoint("CENTER",self,"CENTER",0,10)
    --self.raidicon:SetWidth(12)
    --self.raidicon:SetHeight(12)
    self.raidicon:ClearAllPoints()
    self.raidicon:SetPoint("CENTER",self.health,"TOP",0,0)
    self.raidicon:SetAlpha(0.7)


    if self.spell3 then
        self.spell3:SetWidth(10)
        self.spell3:SetHeight(10)
    end
    if self.spell2 then
        self.spell2:ClearAllPoints()
        self.spell2:SetPoint("LEFT",self,"LEFT",0,0)
    end
    self.text3:ClearAllPoints()
    self.text3:SetPoint("CENTER",self,"BOTTOM",0,0)

end
