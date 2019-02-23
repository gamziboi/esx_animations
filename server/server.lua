ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
    local result = MySQL.Async.fetchAll("SELECT * FROM `favoriteanimation` WHERE `identifier` = @identifier", {['@identifier'] = xPlayer.identifier})
    if not result then
	MySQL.Sync.execute("INSERT IGNORE INTO favoriteanimation (`identifier`) VALUES (@identifier)",{['@identifier'] = xPlayer.identifier})
    end
end)

RegisterServerEvent('esx_animations:newFavorite')
AddEventHandler('esx_animations:newFavorite', function(lib, dict, scenario)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	MySQL.Async.execute("UPDATE favoriteanimation SET lib=@lib,animation=@animation,scenario=@scenario WHERE identifier=@identifier", 
		{
			['@identifier'] = xPlayer.identifier, ['@lib'] = lib, ['@animation'] = dict, ['@scenario'] = scenario
		}
	)
end)

ESX.RegisterServerCallback('esx_animations:getFavorite', function(source, cb)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

		MySQL.Async.fetchAll("SELECT * FROM `favoriteanimation` WHERE `identifier` = @identifier",
		{
			['@identifier'] = xPlayer.identifier
		}, function(result)
		local data = {
			lib			= result[1].lib,
			animation	= result[1].animation,
			scenario 	= result[1].scenario
		}
		cb(data)
	end)
end)

RegisterServerEvent('esx_animations:sync')
AddEventHandler('esx_animations:sync', function(target, animationLib, animation, animation2, distans, distans2, height)
	local targetPlayer = ESX.GetPlayerFromId(target)

	TriggerClientEvent('esx_animations:syncTarget', targetPlayer.source, source, animationLib, animation2, distans, distans2, height, spin)
	TriggerClientEvent('esx_animations:syncMe', source, animationLib, animation, distans, distans2)
end)
