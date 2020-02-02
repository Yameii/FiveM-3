local spawnedMethCs = 0
local methCPlants = {}
local isPickingUp, isProcessing = false, false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.MethCField.coords, true) < 50 then
			SpawnMethCPlants()
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

		for i=1, #methCPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(methCPlants[i]), false) < 1 then
				nearbyObject, nearbyID = methCPlants[i], i
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
						TaskPlayAnim(playerPed, "anim@heists@money_grab@briefcase", "loop", 8.0, 1.0, -1, 1, 0, 0, 0, 0 )

						Citizen.Wait(2000)
						ClearPedTasks(playerPed)
						Citizen.Wait(1500)
		
						ESX.Game.DeleteObject(nearbyObject)
		
						table.remove(methCPlants, nearbyID)
						spawnedMethCs = spawnedMethCs - 1
		
						TriggerServerEvent('esx_drugs:pickedUpCrystalC')
					else
						ESX.ShowNotification(_U('methC_inventoryfull'))
					end

					isPickingUp = false

				end, 'meth3')
			end

		else
			Citizen.Wait(500)
		end

	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(methCPlants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnMethCPlants()
	while spawnedMethCs < 5 do
		Citizen.Wait(0)
		local methCCoords = GenerateMethCCoords()

		ESX.Game.SpawnLocalObject('xm_prop_x17_bag_med_01a', methCCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(methCPlants, obj)
			spawnedMethCs = spawnedMethCs + 1
		end)
	end
end

function ValidateMethCCoord(plantCoord)
	if spawnedMethCs > 0 then
		local validate = true

		for k, v in pairs(methCPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.MethCField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateMethCCoords()
	while true do
		Citizen.Wait(1)

		local methCCoordX, methCCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-5, 5)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-5, 5)

		methCCoordX = Config.CircleZones.MethCField.coords.x + modX
		methCCoordY = Config.CircleZones.MethCField.coords.y + modY

		local coordZ = 28.69
		local coord = vector3(methCCoordX, methCCoordY, coordZ)

		if ValidateMethCCoord(coord) then
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
	local groundCheckHeights = { 28.69 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = 28.69

		if foundGround then
			return z
		end
	end

	return 28.69
end
