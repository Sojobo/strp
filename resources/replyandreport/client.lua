RegisterNetEvent("textsent")
AddEventHandler('textsent', function(tPID, name)
	TriggerEvent('chatMessage', "", {255, 0, 0}, " Reply sent to:^0 " .. name .."  ".."^0  - " .. tPID)
end)

RegisterNetEvent("textmsg")
AddEventHandler('textmsg', function(textmsg, name)
	TriggerEvent('chatMessage', "", {255, 0, 0}, "  ADMIN " .. name .."  ".."^0: " .. textmsg)
end)


RegisterNetEvent('sendReport')
AddEventHandler('sendReport', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage', "", {255, 0, 0}, "Report sent to the admins online!")
	TriggerServerEvent("replyandreport:checkadmin", name, message, id)
  elseif pid ~= myId then
    TriggerServerEvent("replyandreport:checkadmin", name, message, id)
  end
end)


RegisterNetEvent('sendReportToAllAdmins')
AddEventHandler('sendReportToAllAdmins', function(id, name, message, i)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage', "", {255, 0, 0}, " [REPORT] | [".. i .."]" .. name .."  "..":^0  " .. message)
  end
end)