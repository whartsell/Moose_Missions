CC = COMMANDCENTER:New(GROUP:FindByName("FFG-58"),"FFG-58")

NavalSetGroup = SET_GROUP:New():FilterPrefixes( "FFG-58" ):FilterStart()
--NavalDetection = DETECTION_UNITS:New( NavalSetGroup )
NavalDetection = DETECTION_AREAS:New(NavalSetGroup,2000)
NavalDetection:SetRefreshTimeInterval(30)
NavalDetection:Start()
function NavalDetection:OnAfterDetect(From,Event,To)

  local DetectionReport = NavalDetection:DetectedReportDetailed()
  --local DetectionReport = NavalDetection:DetectedItemReportSummary()
  CC:GetPositionable():MessageToAll( DetectionReport, 15, "" )
end