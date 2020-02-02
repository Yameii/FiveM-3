ESX = nil
local playersProcessingCannabis = {}
local playersProcessingHeroin = {}
local playersProcessingCocaine = {}
local playersProcessingCrystal = {}
local playersProcessingCrystalB = {}
local playersProcessingCrystalC = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_drugs:sellDrug')
AddEventHandler('esx_drugs:sellDrug', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = Config.DrugDealerItems[itemName]
	local xItem = xPlayer.getInventoryItem(itemName)

	if not price then
		print(('esx_drugs: %s attempted to sell an invalid drug!'):format(xPlayer.identifier))
		return
	end

	if xItem.count < amount then
		TriggerClientEvent('esx:showNotification', source, _U('dealer_notenough'))
		return
	end

	price = ESX.Math.Round(price * amount)

	if Config.GiveBlack then
		xPlayer.addAccountMoney('black_money', price)
	else
		xPlayer.addMoney(price)
	end

	xPlayer.removeInventoryItem(xItem.name, amount)

	TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', amount, xItem.label, ESX.Math.GroupDigits(price)))
end)

ESX.RegisterServerCallback('esx_drugs:buyLicense', function(source, cb, licenseName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local license = Config.LicensePrices[licenseName]

	if license == nil then
		print(('esx_drugs: %s attempted to buy an invalid license!'):format(xPlayer.identifier))
		cb(false)
	end

	if xPlayer.getMoney() >= license.price then
		xPlayer.removeMoney(license.price)

		TriggerEvent('esx_license:addLicense', source, licenseName, function()
			cb(true)
		end)
	else
		cb(false)
	end
end)

RegisterServerEvent('esx_drugs:pickedUpCannabis')
AddEventHandler('esx_drugs:pickedUpCannabis', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('cannabis')

	if xItem.limit ~= -1 and (xItem.count + 1) > xItem.limit then
		TriggerClientEvent('esx:showNotification', _source, _U('weed_inventoryfull'))
	else
		xPlayer.addInventoryItem(xItem.name, 1)
	end
end)

RegisterServerEvent('esx_drugs:pickedUpHeroin')
AddEventHandler('esx_drugs:pickedUpHeroin', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('opium')

	if xItem.limit ~= -1 and (xItem.count + 1) > xItem.limit then
		TriggerClientEvent('esx:showNotification', _source, _U('opium_inventoryfull'))
	else
		xPlayer.addInventoryItem(xItem.name, 1)
	end
end)

RegisterServerEvent('esx_drugs:pickedUpCrystal')
AddEventHandler('esx_drugs:pickedUpCrystal', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('meth')

	if xItem.limit ~= -1 and (xItem.count + 1) > xItem.limit then
		TriggerClientEvent('esx:showNotification', _source, _U('meth_inventoryfull'))
	else
		xPlayer.addInventoryItem(xItem.name, 1)
	end
end)

RegisterServerEvent('esx_drugs:pickedUpCrystalB')
AddEventHandler('esx_drugs:pickedUpCrystalB', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('meth2')

	if xItem.limit ~= -1 and (xItem.count + 1) > xItem.limit then
		TriggerClientEvent('esx:showNotification', _source, _U('meth2_inventoryfull'))
	else
		xPlayer.addInventoryItem(xItem.name, 1)
	end
end)

RegisterServerEvent('esx_drugs:pickedUpCrystalC')
AddEventHandler('esx_drugs:pickedUpCrystalC', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('meth3')

	if xItem.limit ~= -1 and (xItem.count + 1) > xItem.limit then
		TriggerClientEvent('esx:showNotification', _source, _U('meth3_inventoryfull'))
	else
		xPlayer.addInventoryItem(xItem.name, 1)
	end
end)

RegisterServerEvent('esx_drugs:pickedUpCocaine')
AddEventHandler('esx_drugs:pickedUpCocaine', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('coca')

	if xItem.limit ~= -1 and (xItem.count + 1) > xItem.limit then
		TriggerClientEvent('esx:showNotification', _source, _U('coca_inventoryfull'))
	else
		xPlayer.addInventoryItem(xItem.name, 9)
	end
end)

ESX.RegisterServerCallback('esx_drugs:canPickUp', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)

	if xItem.limit ~= -1 and xItem.count >= xItem.limit then
		cb(false)
	else
		cb(true)
	end
end)

RegisterServerEvent('esx_drugs:processCannabis')
AddEventHandler('esx_drugs:processCannabis', function()
	if not playersProcessingCannabis[source] then
		local _source = source

		playersProcessingCannabis[_source] = ESX.SetTimeout(Config.Delays.WeedProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xCannabis, xMarijuana = xPlayer.getInventoryItem('cannabis'), xPlayer.getInventoryItem('marijuana')

			if xMarijuana.limit ~= -1 and (xMarijuana.count + 1) >= xMarijuana.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('weed_processingfull'))
			elseif xCannabis.count < 3 then
				TriggerClientEvent('esx:showNotification', _source, _U('weed_processingenough'))
			else
				xPlayer.removeInventoryItem('cannabis', 3)
				xPlayer.addInventoryItem('marijuana', 1)

				TriggerClientEvent('esx:showNotification', _source, _U('weed_processed'))
			end

			playersProcessingCannabis[_source] = nil
		end)
	else
		print(('esx_drugs: %s attempted to exploit weed processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

RegisterServerEvent('esx_drugs:processHeroin')
AddEventHandler('esx_drugs:processHeroin', function()
	if not playersProcessingHeroin[source] then
		local _source = source

		playersProcessingHeroin[_source] = ESX.SetTimeout(Config.Delays.OpiumProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xHeroin, xOpium = xPlayer.getInventoryItem('heroin'), xPlayer.getInventoryItem('opium')

			if xHeroin.limit ~= -1 and (xHeroin.count + 1) >= xHeroin.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('opium_processingfull'))
			elseif xOpium.count < 3 then
				TriggerClientEvent('esx:showNotification', _source, _U('opium_processingenough'))
			else
				xPlayer.removeInventoryItem('opium', 3)
				xPlayer.addInventoryItem('heroin', 1)

				TriggerClientEvent('esx:showNotification', _source, _U('opium_processed'))
			end

			playersProcessingHeroin[_source] = nil
		end)
	else
		print(('esx_drugs: %s attempted to exploit opium processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

RegisterServerEvent('esx_drugs:processCrystal')
AddEventHandler('esx_drugs:processCrystal', function()
	if not playersProcessingCrystal[source] then
		local _source = source

		playersProcessingCrystal[_source] = ESX.SetTimeout(Config.Delays.MethProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xCrystal = xPlayer.getInventoryItem('crystal');
			local xMethComponents = xPlayer.getInventoryItem('meth') and xPlayer.getInventoryItem('meth2') and xPlayer.getInventoryItem('meth3');

			if xCrystal.limit ~= -1 and (xCrystal.count + 1) >= xCrystal.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('meth_processingfull'))
			elseif xMethComponents.count < 1 then
				TriggerClientEvent('esx:showNotification', _source, _U('meth_processingenough'))
			else
				xPlayer.removeInventoryItem('meth', 1)
				xPlayer.removeInventoryItem('meth2', 1)
				xPlayer.removeInventoryItem('meth3', 1)
				xPlayer.addInventoryItem('crystal', 1)

				TriggerClientEvent('esx:showNotification', _source, _U('meth_processed'))
			end

			playersProcessingCrystal[_source] = nil
		end)
	else
		print(('esx_drugs: %s attempted to exploit meth processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

RegisterServerEvent('esx_drugs:processCocaine')
AddEventHandler('esx_drugs:processCocaine', function()
	if not playersProcessingCocaine[source] then
		local _source = source

		playersProcessingCocaine[_source] = ESX.SetTimeout(Config.Delays.CocaProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xCocaine, xCoca = xPlayer.getInventoryItem('cocaine'), xPlayer.getInventoryItem('coca')

			if xCocaine.limit ~= -1 and (xCocaine.count + 1) >= xCocaine.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('coca_processingfull'))
			elseif xCoca.count < 9 then
				TriggerClientEvent('esx:showNotification', _source, _U('coca_processingenough'))
			else
				xPlayer.removeInventoryItem('coca', 9)
				xPlayer.addInventoryItem('cocaine', 1)

				TriggerClientEvent('esx:showNotification', _source, _U('coca_processed'))
			end

			playersProcessingCocaine[_source] = nil
		end)
	else
		print(('esx_drugs: %s attempted to exploit cocaine processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

function CancelProcessing(playerID)
	if playersProcessingCannabis[playerID] then
		ESX.ClearTimeout(playersProcessingCannabis[playerID])
		playersProcessingCannabis[playerID] = nil
	end
end

function CancelProcessing(playerID)
	if playersProcessingHeroin[playerID] then
		ESX.ClearTimeout(playersProcessingHeroin[playerID])
		playersProcessingHeroin[playerID] = nil
	end
end

function CancelProcessing(playerID)
	if playersProcessingCrystal[playerID] then
		ESX.ClearTimeout(playersProcessingCrystal[playerID])
		playersProcessingCrystal[playerID] = nil
	end
end

function CancelProcessing(playerID)
	if playersProcessingCrystalB[playerID] then
		ESX.ClearTimeout(playersProcessingCrystalB[playerID])
		playersProcessingCrystalB[playerID] = nil
	end
end

function CancelProcessing(playerID)
	if playersProcessingCrystalC[playerID] then
		ESX.ClearTimeout(playersProcessingCrystalC[playerID])
		playersProcessingCrystalC[playerID] = nil
	end
end

function CancelProcessing(playerID)
	if playersProcessingCocaine[playerID] then
		ESX.ClearTimeout(playersProcessingCocaine[playerID])
		playersProcessingCocaine[playerID] = nil
	end
end

RegisterServerEvent('esx_drugs:cancelProcessing')
AddEventHandler('esx_drugs:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('esx:playerDropped', function(playerID, reason)
	CancelProcessing(playerID)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)
