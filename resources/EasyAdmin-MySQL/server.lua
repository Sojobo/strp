local dbReady = false
local tableQuery = "CREATE TABLE IF NOT EXISTS `ea_bans`( `banid` int(11) NOT NULL UNIQUE AUTO_INCREMENT, `expire` double NOT NULL DEFAULT '10444633200', `identifier` text NOT NULL, `steam` text NOT NULL, `reason` text NOT NULL, `discord` text NOT NULL, PRIMARY KEY(`banid`)) "

updateScripts = {
	"ALTER TABLE `ea_bans` ADD COLUMN `discord` text NOT NULL",
}

AddEventHandler('onMySQLReady', function ()
	MySQL.Async.execute(tableQuery, {}, function() end)
	print("executed table query")

	-- perform upgrades if necesarry
	MySQL.Async.execute("SELECT count(*) FROM information_schema.COLUMNS WHERE COLUMN_NAME = 'discord' and TABLE_NAME = 'ea_bans'", {}, function(count)
		if count == 0 then
			MySQL.Async.execute(updateScripts[1], {}, function() end)
			print("Performed ea_bans Database Upgrade, no further action is necesarry.")
		end
	end)
	
	Wait(100)
	dbReady = true
end)

AddEventHandler('ea_data:retrieveBanlist', function(callback)
	local callback = callback
	while not dbReady do
		Wait(1000)
	end
	MySQL.Async.fetchAll('SELECT * FROM ea_bans', {}, function(bans)
		callback(bans)
		print("retrieved banlist")
	end)
end)

AddEventHandler('ea_data:addBan', function(data)
	while not dbReady do
		Wait(1000)
	end
	MySQL.Async.execute("INSERT INTO ea_bans (`banid`, `expire`, `identifier`, `steam`, `reason`, `discord`) VALUES (NULL, @expire, @identifier, @steam, @reason, @discord);", {expire = data.expire, identifier = data.identifier, steam = data.steam, reason = data.reason, discord = data.discord or "" }, function() end)
	print("added new ban")
end)

AddEventHandler('ea_data:removeBan', function(data)
	while not dbReady do
		Wait(1000)
	end
	MySQL.Async.execute("DELETE FROM ea_bans WHERE identifier = @identifier AND steam = @steam;", {identifier = data.identifier, steam = data.steam }, function() end)
	print("deleted old ban")
end)