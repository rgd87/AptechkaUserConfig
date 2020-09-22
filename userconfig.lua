local helpers = Aptechka.util or Aptechka.helpers
local _, playerClass = UnitClass("player")
local isHealer = (playerClass == "PRIEST" or playerClass == "PALADIN" or playerClass == "SHAMAN" or playerClass == "DRUID")
local A = helpers.AddAura
local Trace = helpers.AddTrace
local config = AptechkaDefaultConfig
local set = helpers.set

-- config.initialConfigPostHookSnippet = [[
--     UnregisterUnitWatch(self)
--     RegisterStateDriver(self, 'visibility', '[mod:shift][combat][@target,exists] show; hide')
-- ]]

config.TargetStatus = { name = "Target", assignto = set("border"), color = {0.7,0.2,0.5}, priority = 65 }
config.MouseoverStatus = { name = "Mouseover", assignto = set("border"), color = {1,0.5,0.8}, priority = 66 }

config.LeaderStatus = { name = "Leader", priority = 59, assignto = set("LeaderIndicator"), color = {1,.8,.2} }
config.AssistStatus = { name = "Assist", priority = 59, assignto = set("AssistantIndicator"), color = {1,.8,.2} }

if playerClass == "DRUID" then
    -- A{ id = 1126,  type = "HELPFUL", assignto = set("bars"), color = { 235/255 , 145/255, 199/255}, isMissing = true } --Mark of the Wild
    -- A{ id = 33763, type = "HELPFUL", assignto = set("spell3")}, showDuration = true, isMine = true, color = { 0.5, 1, 0.5}, } --Lifebloom
    -- A{ id = 102351, type = "HELPFUL", assignto = set("spell2"), priority = 70, color = {38/255, 221/255, 163/255}, isMine = true } --Cenarion Ward
    -- A{ id = 774,   type = "HELPFUL", assignto = set("spell1"), pulse = true, color = { 1, 0.2, 1}, showDuration = true, isMine = true } --Rejuvenation
    -- A{ id = 8936,  type = "HELPFUL", assignto = set("spell3"), priority = 82, color = { 198/255, 233/255, 80/255}, showDuration = true, isMine = true } --Regrowth
end

config.OfflineStatus = { name = "OFFLINE", assignto = set("text2","text3","health","power"), color = {.15,.15,.15}, textcolor = {1,1,0}, text = "OFFLINE",  priority = 70}
config.AwayStatus = { name = "AFK", assignto = set("text2","text3"), color = {.15,.15,.15}, textcolor = {0,128,0}, text = "AFK",  priority = 60}

Aptechka:RegisterWidget("LeaderIndicator", function(self)
    local LeaderIndicator = self.health:CreateTexture("$parentLeaderIcon", "OVERLAY", nil, 7)
    LeaderIndicator:SetSize(12, 12)
    LeaderIndicator:SetPoint("LEFT", self.health, "TOPLEFT", 1, 3)
    LeaderIndicator:SetTexture([[Interface\GroupFrame\UI-Group-LeaderIcon]])
    LeaderIndicator:Hide()
    return LeaderIndicator
end)
Aptechka:RegisterWidget("AssistantIndicator", function(self)
    local AssistantIndicator = self.health:CreateTexture("$parentAssistIcon", "OVERLAY", nil, 7)
    AssistantIndicator:SetSize(12, 12)
    AssistantIndicator:SetPoint("LEFT", self.health, "TOPLEFT", 1, 3)
    AssistantIndicator:SetTexture([[Interface\GroupFrame\UI-Group-AssistantIcon]])
    AssistantIndicator:Hide()
    return AssistantIndicator
end)

Aptechka.PostFrameCreate = function(self)
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
end
