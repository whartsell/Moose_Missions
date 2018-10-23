local TestScheduler = SCHEDULER:New( nil, 
  function()
    local boat = UNIT:FindByName("badguy")
    local total = boat:GetLife0()
    local current = boat:GetLife()
    MESSAGE:New(current.." out of "..total,10):ToAll()
  end, {}, 10, 30
  )