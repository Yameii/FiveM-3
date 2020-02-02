ESX                  = nil
local IsAlreadyDrug = false
local DrugLevel     = -1
local toggleBong = false 
local bong = nil
local bongActive = false
local bongEntity = nil
local toggleJoint = false
local joint = nil
local jointActive = false
local jointEntity = nil


-- ANIM
local animDict = "anim@safehouse@bong" --bong anim dict
local animName = "bong_stage1" --bong anim name
local anim2Dict = "amb@world_human_aa_smoke@male@idle_a" --smoking joint anim dict
local anim2Name = "idle_a" --smoking joint anim name
local anim3Dict = "anim@mp_player_intcelebrationmale@smoke_flick" --flicking joint after finishing (anim dict)
local anim3Name = "smoke_flick" --flicks joint after finishing. (anim name)

local prop = "prop_bong_01" --Bong prop name can use meth pipe with prop: prop_cs_meth_pipe
local prop2 = "prop_sh_joint_01" --Joint prop name

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

AddEventHandler('esx_status:loaded', function(status)

  TriggerEvent('esx_status:registerStatus', 'drug', 0, '#ff0000', 
    function(status)
      if status.val > 0 then
        return false
      else
        return false
      end
    end,
    function(status)
      status.remove(1500)
    end
  )

	Citizen.CreateThread(function()

		while true do

			Wait(1000)

			TriggerEvent('esx_status:getStatus', 'drug', function(status)
				
				if status.val > 0 then
					
          local start = true

          if IsAlreadyDrug then
            start = false
          end

          local level = 0

          if status.val <= 999999 then
            level = 0
          else
            overdose()
          end

          if level ~= DrugLevel then
          end

          IsAlreadyDrug = true
          DrugLevel     = level
				end

				if status.val == 0 then
          
          if IsAlreadyDrug then
            Normal()
          end

          IsAlreadyDrug = false
          DrugLevel     = -1

				end

			end)

		end

	end)

end)

--When effects ends go back to normal
function Normal()

  Citizen.CreateThread(function()
    
    local playerPed = GetPlayerPed(-1)
			
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(playerPed, 0)
    SetPedIsDrug(playerPed, false)
    SetPedMotionBlur(playerPed, false)
  end)

end

--In case too much drugs dies of overdose set everything back
function overdose()

  Citizen.CreateThread(function()

    local playerPed = GetPlayerPed(-1)
	
    SetEntityHealth(playerPed, 0)
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(playerPed, 0)
    SetPedIsDrug(playerPed, false)
    SetPedMotionBlur(playerPed, false)

  end)

end

--Brings out the bong and plays the animation! (animDict) (animName) in locals
function EnableBong()
  bongActive = true
  local ped = GetPlayerPed(-1)
  local pedPos = GetEntityCoords(ped, false)
  
  RequestAnimDict(animDict)
  while not HasAnimDictLoaded(animDict) do
      Citizen.Wait(100)
  end

  TaskPlayAnim(ped, animDict, animName, 8.0, 8.0, -1, (2 + 16 + 32), 0.0, 0, 0, 0)
  Citizen.Wait(2000)
  RequestModel(GetHashKey(prop))
  while not HasModelLoaded(GetHashKey(prop)) do
      Citizen.Wait(100)
  end

  local bong = CreateObject(GetHashKey(prop), pedPos.x, pedPos.y, pedPos.z, 1, 1, 1)
  bongEntity = bong
  AttachEntityToEntity(bongEntity, ped, GetEntityBoneIndexByName(ped, "IK_R_Hand"), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 1)

end

--Brings out the joint and plays the animation! (anim2Dict) (anim2Name) in locals
function EnableJoint()
  jointActive = true
  local ped = GetPlayerPed(-1)
  local pedPos = GetEntityCoords(ped, false)
  
  RequestAnimDict(anim2Dict)
  while not HasAnimDictLoaded(anim2Dict) do
      Citizen.Wait(100)
  end

  TaskPlayAnim(ped, anim2Dict, anim2Name, 8.0, -8.0, -1, (2 + 16 + 32), 0.0, 0, 0, 0)

  RequestModel(GetHashKey(prop2))
  while not HasModelLoaded(GetHashKey(prop2)) do
      Citizen.Wait(100)
  end

  local joint = CreateObject(GetHashKey(prop2), pedPos.x, pedPos.y, pedPos.z, 1, 1, 1)
  jointEntity = joint
  AttachEntityToEntity(jointEntity, ped, GetEntityBoneIndexByName(ped, "BONETAG_R_FINGER11"), 0.0, 0.0, -0.01, 0.0, 0.0, 70.0, 0, 0, 0, 0, 0, 1)

end

--Removes bong (prop) and clears tasks
function DisableBong()
  local ped = GetPlayerPed(-1)
  DeleteEntity(bongEntity)
  ClearPedTasks(ped)
  --ClearPedTasksImmediately(ped)
  bongActive = false
end

--Removes joint (prop) and clears tasks
function DisableJoint()
  local ped = GetPlayerPed(-1)

  DeleteEntity(jointEntity)
  ClearPedTasks(ped)
  --ClearPedTasksImmediately(ped)
  jointActive = false
end

--Drugs Effects

--Cocaine
RegisterNetEvent('esx_drugeffects:onCocaine')
AddEventHandler('esx_drugeffects:onCocaine', function()
  
  local playerPed = GetPlayerPed(-1)
  local maxHealth = GetEntityMaxHealth(playerPed)

        loadAnimDict("anim@mp_player_intincarnose_pickbodhi@ds@")
        RequestAnimSet("move_m@hurry_butch@a") 
    while not HasAnimSetLoaded("move_m@hurry_butch@a") do
      Citizen.Wait(0)
    end    

    TaskPlayAnim(playerPed, "anim@mp_player_intincarnose_pickbodhi@ds@", "enter", 8.0, 1.0, 1000, 50, 0, 0, 0, 0 )
    Citizen.Wait(1000)
    ClearPedTasks(ped)
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "move_m@hurry_butch@a", true)
    SetPedIsDrunk(playerPed, true)
  --Efects
  local player = PlayerId()
  SetRunSprintMultiplierForPlayer(player, 1.3)
        
  Wait(300000)

  SetRunSprintMultiplierForPlayer(player, 1.0)		
end)

--Weed
RegisterNetEvent('esx_drugeffects:onMarijuana')
AddEventHandler('esx_drugeffects:onMarijuana', function()

  local playerPed = GetPlayerPed(-1)
  
  RequestAnimSet("move_m@hipster@a") 
  while not HasAnimSetLoaded("move_m@hipster@a") do
    Citizen.Wait(0)
  end    

    EnableJoint()
    Citizen.Wait(7500)
    DisableJoint()
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "move_m@drunk@moderatedrunk", true)
    SetPedIsDrunk(playerPed, true)
    
    --Efects
    local player = PlayerId()
    SetRunSprintMultiplierForPlayer(player, 1.2)
    SetSwimMultiplierForPlayer(player, 1.3)

    Wait(520000)

    SetRunSprintMultiplierForPlayer(player, 1.0)
    SetSwimMultiplierForPlayer(player, 1.0)
 end)

--Heroin
RegisterNetEvent('esx_drugeffects:onHeroin')
AddEventHandler('esx_drugeffects:onHeroin', function()
  
  local playerPed = GetPlayerPed(-1)
  local maxHealth = GetEntityMaxHealth(playerPed)

  loadAnimDict("mp_safehousebong@")

        RequestAnimSet("move_injured_generic") 
    while not HasAnimSetLoaded("move_injured_generic") do
      Citizen.Wait(0)
    end    
    EnableBong()
    Citizen.Wait(7500)
    DisableBong()
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "move_injured_generic", true)
    SetPedIsDrunk(playerPed, true)
    
   --Efects
    local player = PlayerId()  
    local health = GetEntityHealth(playerPed)
    local newHealth = math.min(maxHealth , math.floor(health + maxHealth/8))
    SetEntityHealth(playerPed, newHealth)
    
end)

--Meth
RegisterNetEvent('esx_drugeffects:onCrystal')
AddEventHandler('esx_drugeffects:onCrystal', function()
  
  local playerPed = GetPlayerPed(-1)
  local maxHealth = GetEntityMaxHealth(playerPed)

        RequestAnimSet("move_m@hurry_butch@a") 
    while not HasAnimSetLoaded("move_m@hurry_butch@a") do
      Citizen.Wait(0)
    end    

    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    Citizen.Wait(3000)
    ClearPedTasksImmediately(playerPed)
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "move_m@hurry_butch@a", true)
    SetPedIsDrunk(playerPed, true)
    
    --Efects
    local player = PlayerId()
    AddArmourToPed(playerPed, 100)
    local health = GetEntityHealth(playerPed)
    local newHealth = math.min(maxHealth , math.floor(health + maxHealth/6))
    SetEntityHealth(playerPed, newHealth)
    
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