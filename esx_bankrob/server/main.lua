ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('bankrob:ToggleDoorTOpened')
AddEventHandler('bankrob:ToggleDoorTOpened', function()
    local DoorT = 320.0
    local IsDoorHacked = true

    TriggerClientEvent('bankrob:SetDoorTOpened', -1, DoorT)
end)

RegisterServerEvent('bankrob:NotifyPolice')
AddEventHandler('bankrob:NotifyPolice', function()
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()

    
    
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            TriggerClientEvent('esx:showNotification', xPlayers[i], '~h~~y~Robbery in progress at Pacific Bank')
            TriggerClientEvent('bankrob:setblip', xPlayers[i])
            Wait(10000)
            TriggerClientEvent('bankrob:killblip', xPlayers[i])
        end
    end
end)

RegisterServerEvent('bankrob:HasGotRaspDoor')
AddEventHandler('bankrob:HasGotRaspDoor', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local raspberrypi = xPlayer.getInventoryItem('raspberrypi')
    local xPlayers = ESX.GetPlayers()

    local cops = 0
    for i=1, #xPlayers, 1 do
     local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
     if xPlayer.job.name == 'police' then
            cops = cops + 1
        end
    end


    if xPlayer.getInventoryItem('raspberrypi').count <= 0 then
        TriggerClientEvent('esx:showNotification', source, '~h~~r~You don\'t have the correct equipment.')
    elseif (cops < Config.NumberOfCopsRequired)then
        TriggerClientEvent('esx:showNotification', source, '~h~~r~Not enough cops in town.')
    elseif (os.time() - Config.lastrobbed) < 600 and Config.lastrobbed ~= 0 then
        TriggerClientEvent('esx:showNotification', source, _U('already_robbed') .. (1800 - (os.time() - Config.lastrobbed)) .. _U('seconds'))
    elseif (cops >= Config.NumberOfCopsRequired)then
        if xPlayer.getInventoryItem('raspberrypi').count >= 1 then
        TriggerClientEvent('bankrob:HasGotRaspDoor', source, GotRaspDoor)
        end
    end
end)

RegisterServerEvent('bankrob:HasGotRaspVault')
AddEventHandler('bankrob:HasGotRaspVault', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local raspberrypi = xPlayer.getInventoryItem('raspberrypi')

    if xPlayer.getInventoryItem('raspberrypi').count <= 0 then
        TriggerClientEvent('esx:showNotification', source, '~h~~r~You don\'t have the correct equipment.')
    elseif xPlayer.getInventoryItem('raspberrypi').count >= 1 then
        TriggerClientEvent('bankrob:HasGotRaspVault', source, GotRaspVault)
    end
end)

RegisterServerEvent('bankrob:HasGotBlowB1')
AddEventHandler('bankrob:HasGotBlowB1', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local blowtorch = xPlayer.getInventoryItem('blowtorch')

    if xPlayer.getInventoryItem('blowtorch').count <= 0 then
        TriggerClientEvent('esx:showNotification', source, '~h~~r~You don\'t have the correct equipment.')
    elseif xPlayer.getInventoryItem('blowtorch').count >= 1 then
        TriggerClientEvent('bankrob:HasGotBlowB1', source, GotBlowB1)
    end
end)

RegisterServerEvent('bankrob:HasGotBlowB2')
AddEventHandler('bankrob:HasGotBlowB2', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local blowtorch = xPlayer.getInventoryItem('blowtorch')

    if xPlayer.getInventoryItem('blowtorch').count <= 0 then
        TriggerClientEvent('esx:showNotification', source, '~h~~r~You don\'t have the correct equipment.')
    elseif xPlayer.getInventoryItem('blowtorch').count >= 1 then
        TriggerClientEvent('bankrob:HasGotBlowB2', source, GotBlowB2)
    end
end)

RegisterServerEvent('bankrob:LockPick1')
AddEventHandler('bankrob:LockPick1', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local blowtorch = xPlayer.getInventoryItem('heavylock')

    if xPlayer.getInventoryItem('heavylock').count <= 0 then
        TriggerClientEvent('esx:showNotification', source, '~h~~r~You don\'t have the correct equipment.')
    elseif xPlayer.getInventoryItem('heavylock').count >= 1 then
        TriggerClientEvent('bankrob:LockPick1', source, LockPick1)
    end
end)

RegisterServerEvent('bankrob:LockPick2')
AddEventHandler('bankrob:LockPick2', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local blowtorch = xPlayer.getInventoryItem('heavylock')

    if xPlayer.getInventoryItem('heavylock').count <= 0 then
        TriggerClientEvent('esx:showNotification', source, '~h~~r~You don\'t have the correct equipment.')
    elseif xPlayer.getInventoryItem('heavylock').count >= 1 then
        TriggerClientEvent('bankrob:LockPick2', source, LockPick2)
    end
end)

RegisterServerEvent('bankrob:LockPick3')
AddEventHandler('bankrob:LockPick3', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local blowtorch = xPlayer.getInventoryItem('heavylock')

    if xPlayer.getInventoryItem('heavylock').count <= 0 then
        TriggerClientEvent('esx:showNotification', source, '~h~~r~You don\'t have the correct equipment.')
    elseif xPlayer.getInventoryItem('heavylock').count >= 1 then
        TriggerClientEvent('bankrob:LockPick3', source, LockPick3)
    end
end)

RegisterServerEvent('bankrob:LockPick4')
AddEventHandler('bankrob:LockPick4', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local blowtorch = xPlayer.getInventoryItem('heavylock')

    if xPlayer.getInventoryItem('heavylock').count <= 0 then
        TriggerClientEvent('esx:showNotification', source, '~h~~r~You don\'t have the correct equipment.')
    elseif xPlayer.getInventoryItem('heavylock').count >= 1 then
        TriggerClientEvent('bankrob:LockPick4', source, LockPick4)
    end
end)

RegisterServerEvent('bankrob:LockPick5')
AddEventHandler('bankrob:LockPick5', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local blowtorch = xPlayer.getInventoryItem('heavylock')

    if xPlayer.getInventoryItem('heavylock').count <= 0 then
        TriggerClientEvent('esx:showNotification', source, '~h~~r~You don\'t have the correct equipment.')
    elseif xPlayer.getInventoryItem('heavylock').count >= 1 then
        TriggerClientEvent('bankrob:LockPick5', source, LockPick5)
    end
end)

RegisterServerEvent('bankrob:LockPick6')
AddEventHandler('bankrob:LockPick6', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local blowtorch = xPlayer.getInventoryItem('heavylock')

    if xPlayer.getInventoryItem('heavylock').count <= 0 then
        TriggerClientEvent('esx:showNotification', source, '~h~~r~You don\'t have the correct equipment.')
    elseif xPlayer.getInventoryItem('heavylock').count >= 1 then
        TriggerClientEvent('bankrob:LockPick6', source, LockPick6)
    end
end)

RegisterServerEvent('bankrob:LockPick7')
AddEventHandler('bankrob:LockPick7', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local blowtorch = xPlayer.getInventoryItem('heavylock')

    if xPlayer.getInventoryItem('heavylock').count <= 0 then
        TriggerClientEvent('esx:showNotification', source, '~h~~r~You don\'t have the correct equipment.')
    elseif xPlayer.getInventoryItem('heavylock').count >= 1 then
        TriggerClientEvent('bankrob:LockPick7', source, LockPick7)
        TriggerClientEvent('bankrob:CoolDownIsFinished', -1, CoolDownIsFinished)
    end
end)

RegisterServerEvent('bankrob:ToggleDoorTClosed')
AddEventHandler('bankrob:ToggleDoorTClosed', function()
    DoorT = 250.0

    TriggerClientEvent('bankrob:SetDoorTClosed', -1, DoorT)
end)

RegisterServerEvent('bankrob:IsLockDownFinished')
AddEventHandler('bankrob:IsLockDownFinished', function()
    TriggerClientEvent('bankrob:IsLockDownFinished', -1, IsLockDownFinished)
end)

RegisterServerEvent('bankrob:ToggleDoorVOpened')
AddEventHandler('bankrob:ToggleDoorVOpened', function()

    local Timer = 75

    DoorV = 158.0
    IsVaultHacked = true
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 156.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 154.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 152.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 150.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 148.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 146.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 144.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 142.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 140.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 138.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 136.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 134.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 132.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 130.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 128.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 126.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 124.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 122.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 120.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 118.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 116.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 114.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 112.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 110.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 108.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 106.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 104.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 102.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 100.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 98.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 96.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 94.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 92.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 90.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 88.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 86.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 84.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 82.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 80.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
    Wait(Timer)
    DoorV = 80.0
    TriggerClientEvent('bankrob:SetDoorVOpened', -1, DoorV)
end)

RegisterServerEvent('bankrob:ToggleDoorVClosed')
AddEventHandler('bankrob:ToggleDoorVClosed', function()
    DoorV = 160.0

    TriggerClientEvent('bankrob:SetDoorVClosed', -1, DoorV)
end)

RegisterServerEvent('bankrob:ToggleDoorB1Opened')
AddEventHandler('bankrob:ToggleDoorB1Opened', function()
    DoorB1 = 0.0
    IsDoor1Torched = true

    TriggerClientEvent('bankrob:SetDoorB1Opened', -1, DoorB1)
end)

RegisterServerEvent('bankrob:ToggleDoorB1Closed')
AddEventHandler('bankrob:ToggleDoorB1Closed', function()
    DoorB1 = 160.0

    TriggerClientEvent('bankrob:SetDoorB1Closed', -1, DoorB1)
end)

RegisterServerEvent('bankrob:ToggleDoorB2Opened')
AddEventHandler('bankrob:ToggleDoorB2Opened', function()
    DoorB2 = 160.0
    IsDoor2Torched = true
    Config.lastrobbed = os.time()

    TriggerClientEvent('bankrob:SetDoorB2Opened', -1, DoorB2)
end)

RegisterServerEvent('bankrob:ToggleDoorB2Closed')
AddEventHandler('bankrob:ToggleDoorB2Closed', function()
    DoorB2 = 250.0

    TriggerClientEvent('bankrob:SetDoorB2Closed', -1, DoorB2)
end)

Rarity = {
    "Common", "Common", "Common", "Common", "Common", "Common", "Common", "Common", "Common", "Common", "Common",
    "Uncommon", "Uncommon", "Uncommon", "Uncommon", "Uncommon", "Uncommon", "Uncommon",
    "Rare", "Rare"
}
CItems = {
    "chains", "rings"
} 
UItems = { 
    "rolex", "customchain", "classifiedusb"
} 
RItems = {
    "deeds", "icedrolex", "federalgold", "champring"
}
  
function RandomLoot()
    math.randomseed( GetGameTimer() )
    local chosen = Rarity[math.random(1,#Rarity)]

    if chosen == "Common" then
      for i=1, #CItems do
        return CItems[math.random(#CItems)]
      end
    elseif chosen == "Uncommon" then
      for i=1, #UItems do
        return UItems[math.random(#UItems)]
      end
    elseif chosen == "Rare" then
      for i=1, #RItems do
        return RItems[math.random(#RItems)]
      end
    end
end
  
function RandomNumber()
    math.randomseed( GetGameTimer() )
    local chosen = Rarity[math.random(1,#Rarity)]
    if chosen == "Common" then
      return math.random(2,6)
    elseif chosen == "Uncommon" then
      return math.random(2,4)
    elseif chosen == "Rare" then
        return math.random(1,2)
    end
end
  
RegisterServerEvent('bankrob:loot')
AddEventHandler('bankrob:loot', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem(RandomLoot(), RandomNumber())
    xPlayer.addMoney(math.random(10000,30000))
end)
----------------------------------
Destroy = {
    "Destroy", "Destroy", "Destroy", "Keep" 
}

RegisterServerEvent('bankrob:RemovePi')
AddEventHandler('bankrob:RemovePi', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local picked = Destroy[math.random(1,#Destroy)]

    if picked == "Keep" then
        TriggerClientEvent('esx:showNotification', source, '~h~~g~Your Raspbberry Pi seems to be fine')
    elseif picked == "Destroy" then
        TriggerClientEvent('esx:showNotification', source, '~h~~r~Your Raspbberry Pi was toasted.')
        xPlayer.removeInventoryItem('raspberrypi', 1)
    end
end)

RegisterServerEvent('bankrob:RemoveBlow')
AddEventHandler('bankrob:RemoveBlow', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('blowtorch', 1)
    TriggerClientEvent('esx:showNotification', source, '~h~~r~Your Blow torch has ran out of gas.')
end)

RegisterServerEvent('bankrob:RemoveHeavylock')
AddEventHandler('bankrob:RemoveHeavylock', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('heavylock', 1)
    TriggerClientEvent('esx:showNotification', source, '~h~~r~Your heavy duty lockpick has broke.')
end)