--GCICAP_Red = AI_A2A_GCICAP:New("EWR Red","Red Squadron","CAP Red",1)
--GCICAP_Red:SetDefaultTakeoffFromRunway()
--GCICAP_Red:SetDefaultLandingAtRunway()
--GCICAP_Red:SetTacticalDisplay( true )



---
-- adding our EWR group to the detection group
DetectionSetGroup = SET_GROUP:New()
DetectionSetGroup:FilterPrefixes("EWR Red")
DetectionSetGroup:_FilterStart()

-- want to detect multiple aircraft withing 30km as a single group
Detection = DETECTION_AREAS:New(DetectionSetGroup,30000)

Red_A2ADDispatcher = AI_A2A_DISPATCHER:New(Detection)

-- enableing the tactical display for debugging
Red_A2ADDispatcher:SetTacticalDisplay( false )

-- Iran's border zone
Red_BorderZone = ZONE_POLYGON:NewFromGroupName("Red Border",GROUP:FindByName("Red Border"))



-- Dispatcher setup
-- border
Red_A2ADDispatcher:SetBorderZone(Red_BorderZone)

-- Engagement
Red_A2ADDispatcher:SetEngageRadius(100000)

--Squadrons
Red_A2ADDispatcher:SetSquadron("Bandar AbbasSQ","Bandar Abbas Intl",{"Red Squadron Bandar Abbas"},6)
Red_A2ADDispatcher:SetSquadronOverhead("Bandar AbbasSQ",1)
Red_A2ADDispatcher:SetSquadronGrouping("Bandar AbbasSQ",2)
Red_A2ADDispatcher:SetSquadronTakeoffFromRunway("Bandar AbbasSQ")
Red_A2ADDispatcher:SetSquadronLandingAtRunway("Bandar AbbasSQ")

-- CAP zones
CAPZoneSouth = ZONE_POLYGON:NewFromGroupName("Bandar Abbas CAP",GROUP:FindByName("Bandar Abbas CAP"))
Red_A2ADDispatcher:SetSquadronCap("Bandar AbbasSQ",CAPZoneSouth,7620,7620,750,950,950,1800,"BARO")
Red_A2ADDispatcher:SetSquadronCapInterval("Bandar AbbasSQ",1,30,30,1)


