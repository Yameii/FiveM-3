local spawnedOpiums = 0
local opiumPlants = {}
local isPickingUp, isProcessing = false, false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.OpiumField.coords, true) < 50 then
			SpawnOpiumPlants()
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

		if GetDistanceBetweenCoords(coords, Config.CircleZones.OpiumProcessing.coords, true) < 1 then
			if not isProcessing then
				ESX.ShowHelpNotification(_U('opium_processprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isProcessing then

				if Config.LicenseEnable then
					ESX.TriggerServerCallback('esx_license:checkLicense', function(hasProcessingLicense)
						if hasProcessingLicense then
							ProcessOpium()
						else
							OpenBuyLicenseMenu('opium_processing')
						end
					end, GetPlayerServerId(PlayerId()), 'opium_processing')
				else
					ProcessOpium()
				end

			end
		else
			Citizen.Wait(500)
		end
	end
end)

function ProcessOpium()
	isProcessing = true

	ESX.ShowNotification(_U('opium_processingstarted'))
	TriggerServerEvent('esx_drugs:processHeroin')
	local timeLeft = Config.Delays.OpiumProcessing / 1000
	local playerPed = PlayerPedId()

	while timeLeft > 0 do
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1

		if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.OpiumProcessing.coords, false) > 4 then
			ESX.ShowNotification(_U('opium_processingtoofar'))
			TriggerServerEvent('esx_drugs:cancelProcessing')
			break
		end
	end

	isProcessing = false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #opiumPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(opiumPlants[i]), false) < 1 then
				nearbyObject, nearbyID = opiumPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				ESX.ShowHelpNotification(_U('opium_pickupprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
				isPickingUp = true

				ESX.TriggerServerCallback('esx_drugs:canPickUp', function(canPickUp)

					if canPickUp then
						TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)

						Citizen.Wait(2000)
						ClearPedTasks(playerPed)
						Citizen.Wait(1500)
		
						ESX.Game.DeleteObject(nearbyObject)
		
						table.remove(opiumPlants, nearbyID)
						spawnedOpiums = spawnedOpiums - 1
		
						TriggerServerEvent('esx_drugs:pickedUpHeroin')
					else
						ESX.ShowNotification(_U('opium_inventoryfull'))
					end

					isPickingUp = false

				end, 'opium')
			end

		else
			Citizen.Wait(500)
		end

	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(opiumPlants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnOpiumPlants()
	while spawnedOpiums < 15 do
		Citizen.Wait(0)
		local opiumCoords = GenerateOpiumCoords()

		ESX.Game.SpawnLocalObject('prop_plant_cane_01a', opiumCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(opiumPlants, obj)
			spawnedOpiums = spawnedOpiums + 1
		end)
	end
end

function ValidateOpiumCoord(plantCoord)
	if spawnedOpiums > 0 then
		local validate = true

		for k, v in pairs(opiumPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.OpiumField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateOpiumCoords()
	while true do
		Citizen.Wait(1)

		local opiumCoordX, opiumCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-30, 30)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-30, 30)

		opiumCoordX = Config.CircleZones.OpiumField.coords.x + modX
		opiumCoordY = Config.CircleZones.OpiumField.coords.y + modY

		local coordZ = GetCoordZ(opiumCoordX, opiumCoordY)
		local coord = vector3(opiumCoordX, opiumCoordY, coordZ)

		if ValidateOpiumCoord(coord) then
			return coord
		end
	end
end

function GetCoordZ(x, y)
	local groundCheckHeights = { 13.0, 14.0, 15.0, 16.0, 17.0, 18.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 14.0
end
