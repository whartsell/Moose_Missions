

--adding our EWR and SAM groups to the detection group
DetectionSetGroup = SET_GROUP:New()
DetectionSetGroup:FilterPrefixes({"EWR Red", "SAM Red"})
DetectionSetGroup:_FilterStart()

-- want to detect multiple aircraft withing 30km as a single group
Detection = DETECTION_AREAS:New(DetectionSetGroup,30000)

Red_A2ADDispatcher = AI_A2A_DISPATCHER:New(Detection)

-- enable the tactical display for debugging
Red_A2ADDispatcher:SetTacticalDisplay( false )

-- Iran's border zone
Red_BorderZone = ZONE_POLYGON:NewFromGroupName("Red Border",GROUP:FindByName("Red Border"))



-- Dispatcher setup
-- border
Red_A2ADDispatcher:SetBorderZone(Red_BorderZone)

-- Engagement
Red_A2ADDispatcher:SetEngageRadius(100000) -- 100km engagement zone


--Squadrons
Red_A2ADDispatcher:SetSquadron("Bandar AbbasSQ","Bandar Abbas Intl",{"Red Squadron Bandar Abbas"},6)
Red_A2ADDispatcher:SetSquadronGci("Bandar AbbasSQ",1000,1800)
Red_A2ADDispatcher:SetSquadronOverhead("Bandar AbbasSQ",1)
Red_A2ADDispatcher:SetSquadronGrouping("Bandar AbbasSQ",2)
Red_A2ADDispatcher:SetSquadronTakeoffFromRunway("Bandar AbbasSQ")
Red_A2ADDispatcher:SetSquadronLandingAtRunway("Bandar AbbasSQ")

-- CAP zones
CAPZoneSouth = ZONE_POLYGON:NewFromGroupName("Bandar Abbas CAP",GROUP:FindByName("Bandar Abbas CAP"))
Red_A2ADDispatcher:SetSquadronCap("Bandar AbbasSQ",CAPZoneSouth,7620,7620,750,950,950,1800,"BARO")
Red_A2ADDispatcher:SetSquadronCapInterval("Bandar AbbasSQ",1,300,600,1)


function launchTanker(SpawnTanker)
  local Spawn_S3 = SPAWN:New(SpawnTanker):InitLimit(1,1)
  Spawn_S3:InitRepeatOnLanding()
  Spawn_S3:Spawn()
end

--Menu
local Menu_CSG3 = MENU_COALITION:New(coalition.side.BLUE,"CSG-3")
MENU_COALITION_COMMAND:New(coalition.side.BLUE,"Launch Shell",Menu_CSG3,launchTanker,"Shell")


--debug
local TestScheduler = SCHEDULER:New( nil, 
  function()
    local boat = UNIT:FindByName("Iranian FFG")
    local total = boat:GetLife0()
    local current = boat:GetLife()
    MESSAGE:New(current.." out of "..total,10):ToAll()
  end, {}, 10, 30
  )