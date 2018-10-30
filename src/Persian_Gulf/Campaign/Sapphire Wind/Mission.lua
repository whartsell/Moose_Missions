local Spawn_Darkstar = SPAWN:New("Darkstar"):InitLimit(1,10)
local Spawn_Stinger = SPAWN:New("Stinger 1"):InitLimit(2,10)


function Launch_Darkstar()
  Spawn_Darkstar:Spawn()
end

function Launch_Stinger()
  Spawn_Stinger:Spawn()
end

SchedulerObject = SCHEDULER:New(Spawn_Darkstar,Launch_Darkstar,{},150)
--StingerScheduler = SCHEDULER:New(Spawn_Stinger,Launch_Stinger,{},300)
