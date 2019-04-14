ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Make the kit usable!
ESX.RegisterUsableItem('lockpick', function(source)
	local _source = source
    TriggerClientEvent('esx_lockpick:onUse', _source)
end)
