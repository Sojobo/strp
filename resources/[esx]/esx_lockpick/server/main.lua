-- Make the kit usable!
ESX.RegisterUsableItem('lockpick', function(source)
	local _source = source

	if Config.AllowMecano then
		TriggerClientEvent('esx_lockpick:onUse', _source)
	else
		TriggerClientEvent('esx_lockpick:onUse', _source)
	end
end)
