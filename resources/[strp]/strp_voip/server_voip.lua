TriggerEvent('commands:add', 'voip', 'user', function(source, args)
    if args[2] then
   		TriggerClientEvent('changeProximity', source, args[2])
   	else
   		TriggerClientEvent('chatMessage', source, "SYSTEM", { 255, 0, 0 }, "Usage: /voip <whisper, normal, yell>")
   	end
end)