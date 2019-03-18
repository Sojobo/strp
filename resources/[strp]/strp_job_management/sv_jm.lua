ESX = nil
TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

function log(sourcePlayer, targetPlayer, message)
	MySQL.Async.execute("INSERT INTO logs_job_management (sourcePlayer, targetPlayer, message) VALUES (@sourcePlayer, @targetPlayer, @message)", {
		["@sourcePlayer"] = sourcePlayer.identifier,
		["@targetPlayer"] = targetPlayer.identifier,
		["@message"] = message,
	})
end

function promotePlayer(sourcePlayer, targetPlayer)
	targetPlayer.setJob(targetPlayer.job.name, math.floor(targetPlayer.job.grade + 1))
	MySQL.Async.execute("UPDATE users SET job = @job, job_grade = @job_grade WHERE identifier = @identifier", {
		["@job"]        = targetPlayer.job.name,
		["@job_grade"]  = targetPlayer.job.grade + 1,
		["@identifier"] = targetPlayer.identifier
	})
	log(sourcePlayer, targetPlayer, "PROMOTED TO " .. string.upper(targetPlayer.getJob().grade_label))

	TriggerClientEvent("esx:showAdvancedNotification", sourcePlayer.source, "Job Management", "Player has been promoted to " .. targetPlayer.getJob().grade_label .. ".", "fas fa-suitcase", "blue")
	TriggerClientEvent("esx:showAdvancedNotification", targetPlayer.source, "Job Management", "You have been promoted to " .. targetPlayer.getJob().grade_label .. ".", "fas fa-suitcase", "blue")
end

function demotePlayer(sourcePlayer, targetPlayer)
	targetPlayer.setJob(targetPlayer.job.name, math.floor(targetPlayer.job.grade - 1))
	MySQL.Async.execute("UPDATE users SET job = @job, job_grade = @job_grade WHERE identifier = @identifier", {
		["@job"]        = targetPlayer.job.name,
		["@job_grade"]  = targetPlayer.job.grade - 1,
		["@identifier"] = targetPlayer.identifier
	})
	log(sourcePlayer, targetPlayer, "DEMOTED TO " .. string.upper(targetPlayer.getJob().grade_label))

	TriggerClientEvent("esx:showAdvancedNotification", sourcePlayer.source, "Job Management", "Player has been demoted to " .. targetPlayer.getJob().grade_label .. ".", "fas fa-suitcase", "red")
	TriggerClientEvent("esx:showAdvancedNotification", targetPlayer.source, "Job Management", "You have been demoted to " .. targetPlayer.getJob().grade_label .. ".", "fas fa-suitcase", "red")
end

function hirePlayer(sourcePlayer, targetPlayer)
	targetPlayer.setJob(sourcePlayer.job.name, 0)
	MySQL.Async.execute("UPDATE users SET job = @job, job_grade = @job_grade WHERE identifier = @identifier", {
		["@job"]        = sourcePlayer.job.name,
		["@job_grade"]  = 0,
		["@identifier"] = targetPlayer.identifier
	})
	log(sourcePlayer, targetPlayer, "HIRED TO " .. targetPlayer.getJob().label)

	TriggerClientEvent("esx:showAdvancedNotification", sourcePlayer.source, "Job Management",  "Player has been hired to the " .. targetPlayer.getJob().label .. " job.", "fas fa-suitcase", "blue")
	TriggerClientEvent("esx:showAdvancedNotification", targetPlayer.source, "Job Management", "You have been hired to the " .. targetPlayer.getJob().label .. " job.", "fas fa-suitcase", "blue")
end

function firePlayer(sourcePlayer, targetPlayer)
	targetPlayer.setJob("unemployed", 0)
	MySQL.Async.execute("UPDATE users SET job = @job, job_grade = @job_grade WHERE identifier = @identifier", {
		["@job"]        = "unemployed",
		["@job_grade"]  = 0,
		["@identifier"] = targetPlayer.identifier
	})
	log(sourcePlayer, targetPlayer, "FIRED FROM " .. targetPlayer.job.label)

	TriggerClientEvent("esx:showAdvancedNotification", sourcePlayer.source, "Job Management",  "Player has been fired and set to Unemployed.", "fas fa-suitcase", "red")
	TriggerClientEvent("esx:showAdvancedNotification", targetPlayer.source, "Job Management", "You have been fired and set to Unemployed.", "fas fa-suitcase", "red")
end


function checkJobGradeRestriction(sourceGroup, sourceUser, targetUser)
	if (JMConfig[sourceUser.job.name] == nil) then return false end
	local gradeRestriction = JMConfig[sourceUser.job.name].gradeRestriction
	if gradeRestriction ~= nil and (sourceGroup == "admin" or ((sourceUser.job.grade >= targetUser.job.grade and sourceUser.job == targetUser.job) and sourceUser.job.grade >= gradeRestriction)) then
		return true
	end
	return false
end

function checkJobRestriction(sourceGroup, sourceUser, targetUser)
	if (JMConfig[sourceUser.job.name] == nil) then return false end
	local gradeRestriction = JMConfig[sourceUser.job.name].gradeRestriction
	if gradeRestriction ~= nil and (sourceGroup == "admin" or ((sourceUser.job == targetUser.job) and sourceUser.job.grade >= gradeRestriction)) then
		return true
	end
	return false
end

TriggerEvent("es:addCommand", "promote", function(source, args, user)
	local _source = source
	local sourcePlayer = ESX.GetPlayerFromId(_source)
	local targetPlayer = ESX.GetPlayerFromId(args[1])
	if ESX.GetPlayerFromId(args[1]) == nil then
		TriggerClientEvent("chatMessage", _source, "^1Invalid Player ID.")
		return
	end
	if checkJobGradeRestriction(user.getGroup(), sourcePlayer, targetPlayer) then
		promotePlayer(sourcePlayer, targetPlayer)
	else
		TriggerClientEvent("chatMessage", _source, "^1Insufficient Permission.")
	end
end, {"Promote user within their current job."})

TriggerEvent("es:addCommand", "demote", function(source, args, user)
	local _source = source
	local sourcePlayer = ESX.GetPlayerFromId(_source)
	local targetPlayer = ESX.GetPlayerFromId(args[1])
	if ESX.GetPlayerFromId(args[1]) == nil then
		TriggerClientEvent("chatMessage", _source, "^1Invalid Player ID.")
		return
	end
	if checkJobGradeRestriction(user.getGroup(), sourcePlayer, targetPlayer) then
		demotePlayer(sourcePlayer, targetPlayer)
	else
		TriggerClientEvent("chatMessage", _source, "^1Insufficient Permission.")
	end
end, {"Demote user within their current job."})

TriggerEvent("es:addCommand", "hire", function(source, args, user)
	local _source = source
	local sourcePlayer = ESX.GetPlayerFromId(_source)
	local targetPlayer = ESX.GetPlayerFromId(args[1])
	if ESX.GetPlayerFromId(args[1]) == nil then
		TriggerClientEvent("chatMessage", _source, "^1Invalid Player ID.")
		return
	end
	if checkJobRestriction(user.getGroup(), sourcePlayer, targetPlayer) then
		hirePlayer(sourcePlayer, targetPlayer)
	else
		TriggerClientEvent("chatMessage", _source, "^1Insufficient Permission.")
	end
end, {"Hire user to current job."})

TriggerEvent("es:addCommand", "fire", function(source, args, user)
	local _source = source
	local sourcePlayer = ESX.GetPlayerFromId(_source)
	local targetPlayer = ESX.GetPlayerFromId(args[1])
	if ESX.GetPlayerFromId(args[1]) == nil then
		TriggerClientEvent("chatMessage", _source, "^1Invalid Player ID.")
		return
	end
	if checkJobRestriction(user.getGroup(), sourcePlayer, targetPlayer) then
		firePlayer(sourcePlayer, targetPlayer)
	else
		TriggerClientEvent("chatMessage", _source, "^1Insufficient Permission.")
	end
end, {"Fire user from current job."})