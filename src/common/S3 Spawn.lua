

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
--local Spawn_Shell = SPAWN:New("Shell"):InitLimit(1,10)
--Spawn_Shell:InitRepeatOnEngineShutDown()
--Spawn_Shell:SpawnScheduled(30,0)
--local Spawn_Arco = SPAWN:New("Arco"):InitLimit(1,10)
--Spawn_Arco:InitRepeatOnEngineShutDown()
--Spawn_Arco:SpawnScheduled(30,0)
local Spawn_Texaco = SPAWN:New("Texaco"):InitLimit(1,10)
Spawn_Texaco:InitRepeatOnEngineShutDown()
Spawn_Texaco:SpawnScheduled(30,0)

--Missile Trainer
--local Trainer = MISSILETRAINER
--  :New( 300, "Missile Training Script is active" )
--  :InitMessagesOnOff(true)
--  :InitAlertsToAll(true) 
--  :InitAlertsHitsOnOff(true)
--  :InitAlertsLaunchesOnOff(false)
--  :InitBearingOnOff(true)
--  :InitRangeOnOff(true)
--  :InitTrackingOnOff(true)
--  :InitTrackingToAll(true)
--  :InitMenusOnOff(true)
--
--Trainer:InitAlertsToAll(true)
 
 
 
function launchTanker(SpawnTanker)
  local Spawn_S3 = SPAWN:New(SpawnTanker):InitLimit(1,1)
  Spawn_S3:InitRepeatOnLanding()
  Spawn_S3:Spawn()
end

--Menu
local Menu_CSG1 = MENU_COALITION:New(coalition.side.BLUE,"CSG-1")
local Menu_CSG2 = MENU_COALITION:New(coalition.side.BLUE,"CSG-2")
MENU_COALITION_COMMAND:New(coalition.side.BLUE,"Launch Shell",Menu_CSG1,launchTanker,"Shell")
MENU_COALITION_COMMAND:New(coalition.side.BLUE,"Launch Arco",Menu_CSG2,launchTanker,"Arco")