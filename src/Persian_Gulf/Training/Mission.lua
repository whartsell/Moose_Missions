

---
-- adding our EWR and SAM groups to the detection group
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
Red_A2ADDispatcher:SetSquadron("Lar Drones","Lar Airbase",{"Red Drone MiG-29","Red Drone F4","Red Drone F-14","Red Drone F-5"})
Red_A2ADDispatcher:SetSquadronOverhead("Lar Drones",1)
Red_A2ADDispatcher:SetSquadronGrouping("Lar Drones",2)
Red_A2ADDispatcher:SetSquadronTakeoffFromRunway("Lar Drones")
Red_A2ADDispatcher:SetSquadronLandingAtRunway("Lar Drones")
--
Red_A2ADDispatcher:SetSquadron("Bandar AbbasSQ","Bandar Abbas Intl",{"Red Squadron F4"},12)
Red_A2ADDispatcher:SetSquadronOverhead("Bandar AbbasSQ",1)
Red_A2ADDispatcher:SetSquadronGrouping("Bandar AbbasSQ",2)
Red_A2ADDispatcher:SetSquadronTakeoffFromRunway("Bandar AbbasSQ")
Red_A2ADDispatcher:SetSquadronLandingAtRunway("Bandar AbbasSQ")
-- without a cap zone and CAP defined (below) the squadron will do nothing
-- CAP zones
-- example
-- Bamdar Abbas CAP is name of the helo group defining the cap zone.  it must be late activated
CAPZoneBA = ZONE_POLYGON:NewFromGroupName("BandarAbbasCAP",GROUP:FindByName("BandarAbbasCAP"))
CAPZoneDrones = ZONE_POLYGON:NewFromGroupName("DroneCAP",GROUP:FindByName("DroneCAP"))
Red_A2ADDispatcher:SetSquadronCap("Lar Drones",CAPZoneDrones,5000,5000,750,950,950,1800,"BARO")
Red_A2ADDispatcher:SetSquadronCapInterval("Lar Drones",2,30,30,1)
Red_A2ADDispatcher:SetSquadronCap("Bandar AbbasSQ",CAPZoneBA,7620,7620,750,950,950,1800,"BARO")
Red_A2ADDispatcher:SetSquadronCapInterval("Bandar AbbasSQ",1,30,30,1)

--Tankers
Spawn_Shell = SPAWN:New("Shell"):InitLimit(1,10)
Spawn_Shell:InitRepeatOnEngineShutDown()
Spawn_Shell:SpawnScheduled(30,0)


--Menu
local MenuCoalitionBlue = MENU_COALITION:New(coalition.side.BLUE,"Manage Menus")