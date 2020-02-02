Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local DoorT = 250.0
local IsHackingDoor = false
local HackedDoor = 0
local IsLockDownFinished = false
local IsBlocked = false

local DoorV = 160.0
local IsHackingVault = false
local HackedVault = 0

local DoorB1 = 250.0
local IsBlowtorching = false

local IsCompleted1 = false
local IsCompleted2 = true
local IsCompleted3 = true
local IsCompleted4 = true
local IsCompleted5 = true
local IsCompleted6 = true
local IsCompleted7 = true

local IsLockpicking = false

local IsBlocked = false

local MarkerID = 32 --DrawMarker id,
local CoordZ = 101.68 --Ground level in vault
local X1, Y1 = 258.12, 218.51 --Marker 1 coord X and Y
local X2, Y2 = 261.16, 217.43 --Marker 2 coord X and Y
local X3, Y3 = 256.66, 214.71 --Marker 3 coord X and Y
local X4, Y4 = 259.82, 213.66 --Marker 4 coord X and Y
local X5, Y5 = 266.15, 213.65 --Marker 5 coord X and Y
local X6, Y6 = 264.97, 216.13 --Marker 6 coord X and Y
local X7, Y7 = 263.46, 212.25 --Marker 7 coord X and Y
local BoB = true --Make the marker bob up and down true or false.
local FCam = true --Make the marker follow the players camera true or false.

local AnimDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
local AnimName = "machinic_loop_mechandplayer"

local blipRobbery = nil

local blips = {
    -- Bank Robbery
    {title="Bank Robbery", colour=59, id=586, x =261.93, y=223.13, z=106.28},
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
  while true do
		Citizen.Wait(0)
		BankDoor = GetClosestObjectOfType(262.1981, 222.5188, 106.4296, 100.0, 746855201, 0, 0, 0)
		FreezeEntityPosition(BankDoor, true)
		BankVault = GetClosestObjectOfType(255.24, 223.75, 102.82, 100.0, 961976194, 0, 0, 0)
		FreezeEntityPosition(BankVault, true)
		BankDoorB1 = GetClosestObjectOfType(253.16, 221.36, 101.68, 100.0, -1508355822, 0, 0, 0)
		FreezeEntityPosition(BankDoorB1, true)
		BankDoorB2 = GetClosestObjectOfType(261.11, 215.87, 101.68, 100.0, -1508355822, 0, 0, 0)
		FreezeEntityPosition(BankDoorB2, true)
		if not IsDoorHacked then
		DrawMarker(20, 262.0, 223.08, 107.28, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 55, true, true, 2, false, nil, nil, false)
		elseif not IsVaultHacked then
		DrawMarker(20, 253.28, 228.44, 102.68, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 55, true, true, 2, false, nil, nil, false)
		elseif not IsDoor1Torched then
		DrawMarker(20, 253.16, 221.36, 101.68, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 55, true, true, 2, false, nil, nil, false)
		elseif not IsDoor2Torched then
		DrawMarker(20, 261.11, 215.87, 101.68, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 55, true, true, 2, false, nil, nil, false)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsCompleted1 == false then	
			DrawMarker(MarkerID, X1, Y1, CoordZ, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.25, 0.25, 0, 255, 0, 55, BoB, FCam, 2, false, nil, nil, false)--first left
		elseif IsCompleted2 == false then
			DrawMarker(MarkerID, X2, Y2, CoordZ, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.25, 0.25, 0, 255, 0, 55, BoB, FCam, 2, false, nil, nil, false)--second left
		elseif IsCompleted3 == false then
			DrawMarker(MarkerID, X3, Y3, CoordZ, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.25, 0.25, 0, 255, 0, 55, BoB, FCam, 2, false, nil, nil, false)--first right	
		elseif IsCompleted4 == false then
			DrawMarker(MarkerID, X4, Y4, CoordZ, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.25, 0.25, 0, 255, 0, 55, BoB, FCam, 2, false, nil, nil, false)--second right
		elseif IsCompleted5 == false then
			DrawMarker(MarkerID, X5, Y5, CoordZ, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.25, 0.25, 0, 255, 0, 55, BoB, FCam, 2, false, nil, nil, false)--last room middle
		elseif IsCompleted6 == false then
			DrawMarker(MarkerID, X6, Y6, CoordZ, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.25, 0.25, 0, 255, 0, 55, BoB, FCam, 2, false, nil, nil, false)--last room left
		elseif IsCompleted7 == false then
			DrawMarker(MarkerID, X7, Y7, CoordZ, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.25, 0.25, 0, 255, 0, 55, BoB, FCam, 2, false, nil, nil, false)--last room left
		else
			Citizen.Wait(500)
		end
	end
end)
----------------------------------------------
RegisterNetEvent('bankrob:killblip')
AddEventHandler('bankrob:killblip', function()
    RemoveBlip(blipRobbery)
end)

RegisterNetEvent('bankrob:setblip')
AddEventHandler('bankrob:setblip', function(position)
    blipRobbery = AddBlipForCoord(255.00, 225.85, 101.00)
    SetBlipSprite(blipRobbery , 161)
    SetBlipScale(blipRobbery , 2.0)
    SetBlipColour(blipRobbery, 3)
    PulseBlip(blipRobbery)
end)

-- Set status for every client (door opens)
RegisterNetEvent('bankrob:SetDoorTOpened')
AddEventHandler('bankrob:SetDoorTOpened', function(DoorT)
	GetEntityHeading(BankDoor)
	SetEntityHeading(BankDoor, DoorT)
	IsDoorHacked = true
end)

-- Set status for every client (door closes)
RegisterNetEvent('bankrob:SetDoorTClosed')
AddEventHandler('bankrob:SetDoorTClosed', function(DoorT)
	GetEntityHeading(BankDoor)
	SetEntityHeading(BankDoor, DoorT)
end)

RegisterNetEvent('bankrob:IsLockDownFinished')
AddEventHandler('bankrob:IsLockDownFinished', function(IsLockDownFinished)
		Citizen.Wait(Config.LockDown)
		--IsLockDownFinished = true
		TriggerServerEvent('bankrob:ToggleDoorTClosed')
		TriggerServerEvent('bankrob:ToggleDoorVClosed')
		TriggerServerEvent('bankrob:ToggleDoorB1Closed')
		TriggerServerEvent('bankrob:ToggleDoorB2Closed')
		IsLockDownFinished = false
		HackedDoor = 0
		IsHackingDoor = false
		IsDoorHacked = false
		IsHackingVault = false
		HackedVault = 0
		IsVaultHacked = false
		IsDoor1Torched = false
		IsDoor2Torched = false
		IsCompleted1 = false
		IsCompleted2 = true
		IsCompleted3 = true
		IsCompleted4 = true
		IsCompleted5 = true
		IsCompleted6 = true
		IsCompleted7 = true
end)

-- Set Vault Door Opened
RegisterNetEvent('bankrob:SetDoorVOpened')
AddEventHandler('bankrob:SetDoorVOpened', function(DoorV)
  GetEntityHeading(BankVault)
	SetEntityHeading(BankVault, DoorV)
	IsVaultHacked = true
end)

-- Set Vault Door Closed
RegisterNetEvent('bankrob:SetDoorVClosed')
AddEventHandler('bankrob:SetDoorVClosed', function(DoorV)
  GetEntityHeading(BankVault)
  SetEntityHeading(BankVault, DoorV)
end)

-- Set status for every client (door opens)
RegisterNetEvent('bankrob:SetDoorB1Opened')
AddEventHandler('bankrob:SetDoorB1Opened', function(DoorB1)
	GetEntityHeading(BankDoorB1)
	SetEntityHeading(BankDoorB1, DoorB1)
	IsDoor1Torched = true
end)

-- Set status for every client (door closes)
RegisterNetEvent('bankrob:SetDoorB1Closed')
AddEventHandler('bankrob:SetDoorB1Closed', function(DoorB1)
	GetEntityHeading(BankDoorB1)
	SetEntityHeading(BankDoorB1, DoorB1)
end)

-- Set status for every client (door opens)
RegisterNetEvent('bankrob:SetDoorB2Opened')
AddEventHandler('bankrob:SetDoorB2Opened', function(DoorB2)
	GetEntityHeading(BankDoorB2)
	SetEntityHeading(BankDoorB2, DoorB2)
	IsDoor2Torched = true
end)
  
-- Set status for every client (door closes)
RegisterNetEvent('bankrob:SetDoorB2Closed')
AddEventHandler('bankrob:SetDoorB2Closed', function(DoorB2)
	GetEntityHeading(BankDoorB2)
	SetEntityHeading(BankDoorB2, DoorB2)
end)

-- Does the player have the correct item? is there enough cops online? top door.
RegisterNetEvent('bankrob:HasGotRaspDoor')
AddEventHandler('bankrob:HasGotRaspDoor', function(GotRaspDoor)
	local playerPed = PlayerPedId()

		ESX.ShowNotification("hacking started")
		TaskGoStraightToCoord(playerPed, 261.56, 223.26, 106.287, 1.0, -1, 251.41, 0.0)
		IsBlocked = true
		IsHackingDoor = true
		Citizen.Wait(2500)
		TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_STAND_MOBILE', 0, true)
		Citizen.Wait(1000)
		TriggerEvent("mhacking:show")
		TriggerEvent("mhacking:start",7,25,hacking)
end)

RegisterNetEvent('bankrob:HasGotRaspVault')
AddEventHandler('bankrob:HasGotRaspVault', function(GotRaspVault)
	local playerPed = PlayerPedId()

		ESX.ShowNotification("hacking started")
		TaskGoStraightToCoord(playerPed, 253.62, 228.31, 101.68, 1.0, -1, 71.83, 0.0)
		IsHackingVault = true
		IsBlocked = true
		Citizen.Wait(2500)
		TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_STAND_MOBILE', 0, true)
		Citizen.Wait(1000)
		TriggerEvent("mhacking:show")
		TriggerEvent("mhacking:start",7,25,hacking2)
		IsHackingVault = true
end)

RegisterNetEvent('bankrob:HasGotBlowB1')
AddEventHandler('bankrob:HasGotBlowB1', function(GotBlowB1)
	local playerPed = PlayerPedId()

		IsBlocked = true
		IsBlowtorching = true
		TaskGoStraightToCoord(playerPed, 253.13, 221.27, 101.68, 1.0, -1, 188.73, 0.0)
		Citizen.Wait(2500)
		SetEntityHeading(playerPed, 188.73)
		SetEntityCoords(playerPed, 253.13, 221.27, 100.68, 1, 0, 0, 1)
		TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, false)
		exports['progressBars']:startUI(Config.BlowTime, "Blowtorching")
		Citizen.Wait(Config.BlowTime)
		ClearPedTasks(playerPed)
		IsBlocked = false
		TriggerServerEvent('bankrob:ToggleDoorB1Opened')
		IsDoor1Torched = true
		IsBlowtorching = false
end)

RegisterNetEvent('bankrob:HasGotBlowB2')
AddEventHandler('bankrob:HasGotBlowB2', function(GotBlowB2)
	local playerPed = PlayerPedId()

		IsBlocked = true
		IsBlowtorching = true
		TaskGoStraightToCoord(playerPed, 261.23, 215.99, 101.68, 1.0, -1, 255.02, 0.0)
		Citizen.Wait(2500)
		SetEntityHeading(playerPed, 255.02)
		SetEntityCoords(playerPed, 261.23, 215.99, 100.68, 1, 0, 0, 1)
		TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, false)
		exports['progressBars']:startUI(Config.BlowTime, "Blowtorching")
		Citizen.Wait(Config.BlowTime)
		ClearPedTasks(playerPed)
		IsBlocked = false
		TriggerServerEvent('bankrob:ToggleDoorB2Opened')
		TriggerServerEvent('bankrob:RemoveBlow')
		IsDoor2Torched = true
		IsBlowtorching = false
end)

RegisterNetEvent('bankrob:LockPick1')
AddEventHandler('bankrob:LockPick1', function(LockPick1)
	local playerPed = PlayerPedId()
	local AnimDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
	local AnimName = "machinic_loop_mechandplayer"

		IsLockpicking = true
		ESX.ShowNotification("Lockpicking started")
		IsBlocked = true
		TaskGoStraightToCoord(playerPed, 257.94, 218.07, 101.68, 1.0, -1, 341.42, 0.0)
		Citizen.Wait(2000)
		SetEntityHeading(playerPed, 341.42)
		exports['progressBars']:startUI(Config.LockPickTimer, "Lockpicking")
		TaskPlayAnim(playerPed, AnimDict, AnimName, 8.0, 1.0, -1, 40, 0, 0, 0, 0 )
		Citizen.Wait(Config.LockPickTimer)
		ClearPedTasks(playerPed)
		IsBlocked = false
		IsCompleted1 = true
		IsCompleted2 = false
		TriggerServerEvent("bankrob:loot")
		IsLockpicking = false
end)

RegisterNetEvent('bankrob:LockPick2')
AddEventHandler('bankrob:LockPick2', function(LockPick2)
	local playerPed = PlayerPedId()
	local AnimDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
	local AnimName = "machinic_loop_mechandplayer"

		IsLockpicking = true
		ESX.ShowNotification("Lockpicking started")
		IsBlocked = true
		TaskGoStraightToCoord(playerPed, 261.1, 216.95, 101.68, 1.0, -1, 341.42, 0.0)
		Citizen.Wait(2000)
		SetEntityHeading(playerPed, 341.42)
		exports['progressBars']:startUI(Config.LockPickTimer, "Lockpicking")
		TaskPlayAnim(playerPed, AnimDict, AnimName, 8.0, 1.0, -1, 40, 0, 0, 0, 0 )
		Citizen.Wait(Config.LockPickTimer)
		ClearPedTasks(playerPed)
		IsBlocked = false
		IsCompleted2 = true
		IsCompleted3 = false
		TriggerServerEvent("bankrob:loot")
		IsLockpicking = false
end)

RegisterNetEvent('bankrob:LockPick3')
AddEventHandler('bankrob:LockPick3', function(LockPick3)
	local playerPed = PlayerPedId()
	local AnimDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
	local AnimName = "machinic_loop_mechandplayer"

		IsLockpicking = true
		ESX.ShowNotification("Lockpicking started")
		IsBlocked = true
		TaskGoStraightToCoord(playerPed, 256.84, 215.27, 101.68, 1.0, -1, 160.25, 0.0)
		Citizen.Wait(2000)
		SetEntityHeading(playerPed, 160.25)
		exports['progressBars']:startUI(Config.LockPickTimer, "Lockpicking")
		TaskPlayAnim(playerPed, AnimDict, AnimName, 8.0, 1.0, -1, 40, 0, 0, 0, 0 )
		Citizen.Wait(Config.LockPickTimer)
		ClearPedTasks(playerPed)
		IsBlocked = false
		IsCompleted3 = true
		IsCompleted4 = false
		TriggerServerEvent("bankrob:loot")
		IsLockpicking = false
end)

RegisterNetEvent('bankrob:LockPick4')
AddEventHandler('bankrob:LockPick4', function(LockPick4)
	local playerPed = PlayerPedId()
	local AnimDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
	local AnimName = "machinic_loop_mechandplayer"

		IsLockpicking = true
		ESX.ShowNotification("Lockpicking started")
		IsBlocked = true
		TaskGoStraightToCoord(playerPed, 259.96, 214.18, 101.68, 1.0, -1, 160.25, 0.0)
		Citizen.Wait(2000)
		SetEntityHeading(playerPed, 160.25)
		exports['progressBars']:startUI(Config.LockPickTimer, "Lockpicking")
		TaskPlayAnim(playerPed, AnimDict, AnimName, 8.0, 1.0, -1, 40, 0, 0, 0, 0 )
		Citizen.Wait(Config.LockPickTimer)
		ClearPedTasks(playerPed)
		IsBlocked = false
		IsCompleted4 = true
		IsCompleted5 = false
		TriggerServerEvent("bankrob:loot")
		IsLockpicking = false
end)

RegisterNetEvent('bankrob:LockPick5')
AddEventHandler('bankrob:LockPick5', function(LockPick5)
	local playerPed = PlayerPedId()
	local AnimDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
	local AnimName = "machinic_loop_mechandplayer"

		IsLockpicking = true
		ESX.ShowNotification("Lockpicking started")
		IsBlocked = true
		TaskGoStraightToCoord(playerPed, 265.63, 213.92, 101.68, 1.0, -1, 249.28, 0.0)
		Citizen.Wait(2000)
		SetEntityHeading(playerPed, 249.28)
		exports['progressBars']:startUI(Config.LockPickTimer, "Lockpicking")
		TaskPlayAnim(playerPed, AnimDict, AnimName, 8.0, 1.0, -1, 40, 0, 0, 0, 0 )
		Citizen.Wait(Config.LockPickTimer)
		ClearPedTasks(playerPed)
		IsBlocked = false
		IsCompleted5 = true
		IsCompleted6 = false
		TriggerServerEvent("bankrob:loot")
		IsLockpicking = false
end)

RegisterNetEvent('bankrob:LockPick6')
AddEventHandler('bankrob:LockPick6', function(LockPick6)
	local playerPed = PlayerPedId()
	local AnimDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
	local AnimName = "machinic_loop_mechandplayer"

		IsLockpicking = true
		ESX.ShowNotification("Lockpicking started")
		IsBlocked = true
		TaskGoStraightToCoord(playerPed, 264.75, 215.65, 101.68, 1.0, -1, 341.42, 0.0)
		Citizen.Wait(2000)
		SetEntityHeading(playerPed, 341.42)
		exports['progressBars']:startUI(Config.LockPickTimer, "Lockpicking")
		TaskPlayAnim(playerPed, AnimDict, AnimName, 8.0, 1.0, -1, 40, 0, 0, 0, 0 )
		Citizen.Wait(Config.LockPickTimer)
		ClearPedTasks(playerPed)
		IsBlocked = false
		IsCompleted6 = true
		IsCompleted7 = false
		TriggerServerEvent("bankrob:loot")
		IsLockpicking = false
end)

RegisterNetEvent('bankrob:LockPick7')
AddEventHandler('bankrob:LockPick7', function(LockPick7)
	local playerPed = PlayerPedId()
	local AnimDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
	local AnimName = "machinic_loop_mechandplayer"

		IsLockpicking = true
		ESX.ShowNotification("Lockpicking started")
		IsBlocked = true
		TaskGoStraightToCoord(playerPed, 263.61, 212.71, 101.68, 1.0, -1, 160.25, 0.0)
		Citizen.Wait(2000)
		SetEntityHeading(playerPed, 160.25)
		exports['progressBars']:startUI(Config.LockPickTimer, "Lockpicking")
		TaskPlayAnim(playerPed, AnimDict, AnimName, 8.0, 1.0, -1, 40, 0, 0, 0, 0 )
		Citizen.Wait(Config.LockPickTimer)
		ClearPedTasks(playerPed)
		IsBlocked = false
		IsCompleted7 = true
		TriggerServerEvent("bankrob:loot")
		TriggerServerEvent('bankrob:RemoveHeavylock')
		IsLockpicking = false
		HackedDoor = 0
end)

function hacking(success, timeremaining)

	local playerPed = PlayerPedId()

	if HackedDoor >= 2 and success then
		print('Success with '..timeremaining..'s remaining.')
		TriggerEvent('mhacking:hide')
		ESX.ShowNotification("~h~~g~Hacking sucessful")
		HackedDoor = 0
		IsDoorHacked = true
		IsBlocked = false
		TriggerServerEvent('bankrob:NotifyPolice')
		ClearPedTasks(playerPed)
		exports['progressBars2']:startUI(Config.LockDown, "Time Until Bank Lockdown...")
		TriggerServerEvent('bankrob:ToggleDoorTOpened')
		TriggerServerEvent('bankrob:IsLockDownFinished')
	elseif HackedDoor >= 1 and success then
		print('Success with '..timeremaining..'s remaining.')
		TriggerEvent('mhacking:hide')
		HackedDoor = 2
		ESX.ShowNotification("Hacking stage two ~h~~g~sucessful")
		Citizen.Wait(500)
		TriggerEvent("mhacking:show")
		TriggerEvent("mhacking:start",5,35,hacking)
	elseif success then
		print('Success with '..timeremaining..'s remaining.')
		TriggerEvent('mhacking:hide')
		HackedDoor = 1
		ESX.ShowNotification("Hacking stage one ~h~~g~sucessful")
		Citizen.Wait(500)
		TriggerEvent("mhacking:show")
		TriggerEvent("mhacking:start",6,30,hacking)
	else
		print('Failure')
		TriggerEvent('mhacking:hide')
		HackedDoor = 0
		ClearPedTasks(playerPed)
		ESX.ShowNotification("~h~~r~Hacking failed returned to stage one.")
		IsBlocked = false
		Citizen.Wait(Config.LockOutHackTimer)
		IsHackingDoor = false
	end
end

function hacking2(success, timeremaining)

	local playerPed = PlayerPedId()

	if HackedVault >= 7 and success then
		print('Success with '..timeremaining..'s remaining.')
		TriggerEvent('mhacking:hide')
		ESX.ShowNotification("~g~Hacking sucessful")
		HackedVault = 0
		IsVaultHacked = true
		IsBlocked = false
		ClearPedTasks(playerPed)
		TriggerServerEvent('bankrob:ToggleDoorVOpened')
		TriggerServerEvent('bankrob:RemovePi')
	elseif HackedVault >= 6 and success then
		print('Success with '..timeremaining..'s remaining.')
		TriggerEvent('mhacking:hide')
		HackedVault = 7
		ESX.ShowNotification("Hacking stage seven ~h~~g~sucessful")
		Citizen.Wait(500)
		TriggerEvent("mhacking:show")
		TriggerEvent("mhacking:start",4,30,hacking2)
	elseif HackedVault >= 5 and success then
		print('Success with '..timeremaining..'s remaining.')
		TriggerEvent('mhacking:hide')
		HackedVault = 6
		ESX.ShowNotification("Hacking stage six ~h~~g~sucessful")
		Citizen.Wait(500)
		TriggerEvent("mhacking:show")
		TriggerEvent("mhacking:start",4,30,hacking2)
	elseif HackedVault >= 4 and success then
		print('Success with '..timeremaining..'s remaining.')
		TriggerEvent('mhacking:hide')
		HackedVault = 5
		ESX.ShowNotification("Hacking stage five ~h~~g~sucessful")
		Citizen.Wait(500)
		TriggerEvent("mhacking:show")
		TriggerEvent("mhacking:start",4,30,hacking2)
	elseif HackedVault >= 3 and success then
		print('Success with '..timeremaining..'s remaining.')
		TriggerEvent('mhacking:hide')
		HackedVault = 4
		ESX.ShowNotification("Hacking stage four ~h~~g~sucessful")
		Citizen.Wait(500)
		TriggerEvent("mhacking:show")
		TriggerEvent("mhacking:start",5,30,hacking2)
	elseif HackedVault >= 2 and success then
		print('Success with '..timeremaining..'s remaining.')
		TriggerEvent('mhacking:hide')
		HackedVault = 3
		ESX.ShowNotification("Hacking stage three ~h~~g~sucessful")
		Citizen.Wait(500)
		TriggerEvent("mhacking:show")
		TriggerEvent("mhacking:start",6,30,hacking2)
	elseif HackedVault >= 1 and success then
		print('Success with '..timeremaining..'s remaining.')
		TriggerEvent('mhacking:hide')
		HackedVault = 2
		ESX.ShowNotification("Hacking stage two ~h~~g~sucessful")
		Citizen.Wait(500)
		TriggerEvent("mhacking:show")
		TriggerEvent("mhacking:start",7,30,hacking2)
	elseif success then
		print('Success with '..timeremaining..'s remaining.')
		TriggerEvent('mhacking:hide')
		HackedVault = 1
		ESX.ShowNotification("Hacking stage one ~h~~g~sucessful")
		Citizen.Wait(500)
		TriggerEvent("mhacking:show")
		TriggerEvent("mhacking:start",7,30,hacking2)
	else
		print('Failure')
		TriggerEvent('mhacking:hide')
		HackedVault = 0
		IsBlocked = false
		ClearPedTasks(playerPed)
		ESX.ShowNotification("~h~~r~Hacking failed returned to stage one.")
		Citizen.Wait(Config.LockOutHackTimer)
		IsHackingVault = false
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, 261.87, 223.13, 106.28, true) < 0.5 then
			if not IsHackingDoor and not IsDoorHacked then
				ESX.ShowHelpNotification('~h~Press ~INPUT_CONTEXT~ to hack the door!')
			end
			if IsControlJustReleased(0, Keys['E']) and not IsHackingDoor and not IsDoorHacked then
				TriggerServerEvent('bankrob:HasGotRaspDoor')
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, 253.28, 228.44, 101.68, true) < 0.5 then
			if not IsHackingVault and not IsVaultHacked and IsDoorHacked and not IsVaultHacked then
				ESX.ShowHelpNotification('~h~Press ~INPUT_CONTEXT~ to hack the vault!')
			end
			if IsControlJustReleased(0, Keys['E']) and not IsHackingVault and IsDoorHacked and not IsVaultHacked then
				TriggerServerEvent('bankrob:HasGotRaspVault')
			end
		end
	end
end)

--Blow torch doors start here

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, 253.16, 221.36, 101.68, true) < 0.5 then
			if not IsBlowtorching and not IsDoor1Torched and IsVaultHacked then
				ESX.ShowHelpNotification('~h~Press ~INPUT_CONTEXT~ to blowtorch the door!')
			end
			if IsControlJustReleased(0, Keys['E']) then
				if not IsBlowtorching and IsVaultHacked and not IsDoor1Torched then
					TriggerServerEvent('bankrob:HasGotBlowB1')
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, 261.11, 215.87, 101.68, true) < 0.5 then
			if not IsBlowtorching and not IsDoor2Torched and IsDoor1Torched then
				ESX.ShowHelpNotification('~h~Press ~INPUT_CONTEXT~ to blowtorch the door!')
			end
			if IsControlJustReleased(0, Keys['E']) then
				if not IsBlowtorching and IsDoor1Torched and not IsDoor2Torched then
					TriggerServerEvent('bankrob:HasGotBlowB2')
				end
			end
		end
	end
end)

--Lock picking starts here
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, X1, Y1, CoordZ, true) < 0.5 then
			if not IsLockpicking and not IsCompleted1 then
				ESX.ShowHelpNotification('~h~Press ~INPUT_CONTEXT~ to Lockpick!')
				loadAnimDict(AnimDict)
			end
			if IsControlJustPressed(0, Keys['E']) and not IsCompleted1 and not IsLockpicking then
				TriggerServerEvent('bankrob:LockPick1')
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, X2, Y2, CoordZ, true) < 0.5 then
			if not IsLockpicking and not IsCompleted2 then
				ESX.ShowHelpNotification('~h~Press ~INPUT_CONTEXT~ to Lockpick!')
				loadAnimDict(AnimDict)
			end
			if IsControlJustPressed(0, Keys['E']) and not IsLockpicking and not IsCompleted2 then
				TriggerServerEvent('bankrob:LockPick2')
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, X3, Y3, CoordZ, true) < 0.5 then
			if not IsLockpicking and not IsCompleted3 then
				ESX.ShowHelpNotification('~h~Press ~INPUT_CONTEXT~ to Lockpick!')
				loadAnimDict(AnimDict)
			end
			if IsControlJustPressed(0, Keys['E']) and not IsLockpicking and not IsCompleted3 then
				TriggerServerEvent('bankrob:LockPick3')
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, X4, Y4, CoordZ, true) < 0.5 then
			if not IsLockpicking and not IsCompleted4 then
				ESX.ShowHelpNotification('~h~Press ~INPUT_CONTEXT~ to Lockpick!')
				loadAnimDict(AnimDict)
			end
			if IsControlJustPressed(0, Keys['E']) and not IsLockpicking and not IsCompleted4 then
				TriggerServerEvent('bankrob:LockPick4')
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, X5, Y5, CoordZ, true) < 0.5 then
			if not IsLockpicking and not IsCompleted5 then
				ESX.ShowHelpNotification('~h~Press ~INPUT_CONTEXT~ to Lockpick!')
				loadAnimDict(AnimDict)
			end
			if IsControlJustPressed(0, Keys['E']) and not IsLockpicking and not IsCompleted5 then
				TriggerServerEvent('bankrob:LockPick5')
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		
		if GetDistanceBetweenCoords(coords, X6, Y6, CoordZ, true) < 0.5 then
			if not IsLockpicking and not IsCompleted6 then
				ESX.ShowHelpNotification('~h~Press ~INPUT_CONTEXT~ to Lockpick!')
				loadAnimDict(AnimDict)
			end
			if IsControlJustPressed(0, Keys['E']) and not IsLockpicking and not IsCompleted6 then
				TriggerServerEvent('bankrob:LockPick6')
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, X7, Y7, CoordZ, true) < 0.5 then
			if not IsLockpicking and not IsCompleted7 then
				ESX.ShowHelpNotification('~h~Press ~INPUT_CONTEXT~ to Lockpick!')
				loadAnimDict(AnimDict)
			end
			if IsControlJustPressed(0, Keys['E']) and not IsLockpicking and not IsCompleted7 then
				TriggerServerEvent('bankrob:LockPick7')
			end
		end
	end
end)

-- disable controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local playerPed = PlayerPedId()

		if IsBlocked then
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, Keys['W'], true) -- W
			DisableControlAction(0, Keys['A'], true) -- A
			DisableControlAction(0, 31, true) -- S (fault in Keys table!)
			DisableControlAction(0, 30, true) -- D (fault in Keys table!)

			DisableControlAction(0, Keys['R'], true) -- Reload
			DisableControlAction(0, Keys['SPACE'], true) -- Jump
			DisableControlAction(0, Keys['Q'], true) -- Cover
			DisableControlAction(0, Keys['TAB'], true) -- Select Weapon
			DisableControlAction(0, Keys['F'], true) -- Also 'enter'?

			DisableControlAction(0, Keys['F1'], true) -- Disable phone
			DisableControlAction(0, Keys['F2'], true) -- Inventory
			DisableControlAction(0, Keys['F3'], true) -- Animations
			DisableControlAction(0, Keys['F6'], true) -- Job

			DisableControlAction(0, Keys['V'], true) -- Disable changing view
			DisableControlAction(0, Keys['C'], true) -- Disable looking behind
			DisableControlAction(0, Keys['X'], true) -- Disable clearing animation
			DisableControlAction(2, Keys['P'], true) -- Disable pause screen

			DisableControlAction(2, Keys['LEFTCTRL'], true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		end
	end
end)  

Citizen.CreateThread(function()

  for _, info in pairs(blips) do
    info.blip = AddBlipForCoord(info.x, info.y, info.z)
    SetBlipSprite(info.blip, info.id)
    SetBlipDisplay(info.blip, 4)
    SetBlipScale(info.blip, 0.75)
    SetBlipColour(info.blip, info.colour)
    SetBlipAsShortRange(info.blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(info.title)
    EndTextCommandSetBlipName(info.blip)
  end
end)

function loadAnimDict(dict)
	while ( not HasAnimDictLoaded(dict)) do
			RequestAnimDict(dict)
			Citizen.Wait(0)
	end
end

function loadAnimDict( dict )
	while ( not HasAnimDictLoaded( dict ) ) do
			RequestAnimDict( dict )
			Citizen.Wait( 1500 )
	end
end