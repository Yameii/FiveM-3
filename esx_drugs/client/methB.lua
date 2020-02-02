local spawnedMethBs = 0
local methBPlants = {}
local isPickingUp, isProcessing = false, false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.MethBField.coords, true) < 50 then
			SpawnMethBPlants()
			Citizen.Wait(500)
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #methBPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(methBPlants[i]), false) < 1 then
				nearbyObject, nearbyID = methBPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				ESX.ShowHelpNotification(_U('meth_pickupprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
				isPickingUp = true

				ESX.TriggerServerCallback('esx_drugs:canPickUp', function(canPickUp)
					loadAnimDict("anim@heists@money_grab@briefcase")
					if canPickUp then
						TaskPlayAnim(playerPed, "anim@heists@money_grab@briefcase", "loop", 8.0, 1.0, -1, 17, 0, 0, 0, 0 )

						Citizen.Wait(2000)
						ClearPedTasks(playerPed)
						Citizen.Wait(1500)
		
						ESX.Game.DeleteObject(nearbyObject)
		
						table.remove(methBPlants, nearbyID)
						spawnedMethBs = spawnedMethBs - 1
		
						TriggerServerEvent('esx_drugs:pickedUpCrystalB')
					else
						ESX.ShowNotification(_U('methB_inventoryfull'))
					end

					isPickingUp = false

				end, 'meth2')
			end

		else
			Citizen.Wait(500)
		end

	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(methBPlants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnMethBPlants()
	while spawnedMethBs < 5 do
		Citizen.Wait(0)
		local methBCoords = GenerateMethBCoords()

		ESX.Game.SpawnLocalObject('prop_mb_crate_01a', methBCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(methBPlants, obj)
			spawnedMethBs = spawnedMethBs + 1
		end)
	end
end

function ValidateMethBCoord(plantCoord)
	if spawnedMethBs > 0 then
		local validate = true

		for k, v in pairs(methBPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.MethBField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateMethBCoords()
	while true do
		Citizen.Wait(1)

		local methBCoordX, methBCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-5, 5)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-5, 5)

		methBCoordX = Config.CircleZones.MethBField.coords.x + modX
		methBCoordY = Config.CircleZones.MethBField.coords.y + modY

		local coordZ = GetCoordZ(methBCoordX, methBCoordY)
		local coord = vector3(methBCoordX, methBCoordY, coordZ)

		if ValidateMethBCoord(coord) then
			return coord
		end
	end
end

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

function GetCoordZ(x, y)
	local groundCheckHeights = { 40.0, 41.0, 42.0, 43.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 41.0
end
