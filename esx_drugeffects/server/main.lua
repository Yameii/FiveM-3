ESX = nil


TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

ESX.RegisterUsableItem('marijuana', function(source)
        
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xRizla = xPlayer.getInventoryItem('rizla') 
	local xMarijuana = xPlayer.getInventoryItem('marijuana')

	if xRizla.count < 1 then
	TriggerClientEvent('esx:showNotification', source, '~w~You don\'t have enough ~b~Rizla\'s')
	else
	xPlayer.removeInventoryItem('marijuana', 1)
	xPlayer.removeInventoryItem('rizla', 1)
	xPlayer.addInventoryItem('joint', math.random(3,5))
	TriggerClientEvent('esx:showNotification', source, '~w~You made some ~b~Weed joint\'s')
	end
end)

ESX.RegisterUsableItem('joint', function(source)
        
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xLighter = xPlayer.getInventoryItem('lighter')

	if xLighter.count < 1 then
	TriggerClientEvent('esx:showNotification', source, '~w~You don\'t have a ~r~lighter!')
	else
	xPlayer.removeInventoryItem('joint', 1)
	TriggerClientEvent('esx_status:add', _source, 'drug', 166000)
	TriggerClientEvent('esx_drugeffects:onMarijuana', source)
	end
end)

ESX.RegisterUsableItem('heroin', function(source)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xHPipe = xPlayer.getInventoryItem('hpipe')
	local xLighter = xPlayer.getInventoryItem('lighter') 
	local xHeroin = xPlayer.getInventoryItem('heroin')

	if xHPipe.count < 1 then
	TriggerClientEvent('esx:showNotification', source, '~w~You don\'t have a ~r~heroin pipe!')
	elseif xLighter.count < 1 then
	TriggerClientEvent('esx:showNotification', source, '~w~You don\'t have a ~r~lighter!')
	else
	xPlayer.removeInventoryItem('heroin', 1)
	TriggerClientEvent('esx_status:add', _source, 'drug', 350000)
	TriggerClientEvent('esx_drugeffects:onHeroin', source)
	end
end)

ESX.RegisterUsableItem('crystal', function(source)
        
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('crystal', 1)

	TriggerClientEvent('esx_status:add', _source, 'drug', 300000)
	TriggerClientEvent('esx_drugeffects:onCrystal', source)
end)

ESX.RegisterUsableItem('cocaine', function(source)
		
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xSknife = xPlayer.getInventoryItem('sknife')
	if xSknife.count < 1 then
	TriggerClientEvent('esx:showNotification', source, '~w~You don\'t have a ~r~Razor blade!')
	else
	xPlayer.removeInventoryItem('cocaine', 1)
	xPlayer.addInventoryItem('cokep', math.random(3, 5))
	TriggerClientEvent('esx:showNotification', source, '~w~You made some ~b~Coke pouch\'s')
	end
end)

ESX.RegisterUsableItem('cokep', function(source)
        
local _source = source
local xPlayer = ESX.GetPlayerFromId(source)
xPlayer.removeInventoryItem('cokep', 1)

TriggerClientEvent('esx_status:add', _source, 'drug', 200000)
TriggerClientEvent('esx_drugeffects:onCocaine', source)
end)

ESX.RegisterUsableItem('xanax', function(source)
        
        local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('xanax', 1)

	TriggerClientEvent('esx_status:remove', _source, 'drug', 249000)
end)
