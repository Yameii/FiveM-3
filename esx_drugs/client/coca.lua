local spawnedCocas = 0
local cocaPlants = {}
local isPickingUp, isProcessing = false, false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.CocaField.coords, true) < 50 then
			SpawnCocaPlants()
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

		if GetDistanceBetweenCoords(coords, Config.CircleZones.CocaProcessing.coords, true) < 1 then
			if not isProcessing then
				ESX.ShowHelpNotification(_U('coca_processprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isProcessing then

				if Config.LicenseEnable then
					ESX.TriggerServerCallback('esx_license:checkLicense', function(hasProcessingLicense)
						if hasProcessingLicense then
							ProcessCoca()
						else
							OpenBuyLicenseMenu('coca_processing')
						end
					end, GetPlayerServerId(PlayerId()), 'coca_processing')
				else
					ProcessCoca()
				end

			end
		else
			Citizen.Wait(500)
		end
	end
end)

function ProcessCoca()
	isProcessing = true

	ESX.ShowNotification(_U('coca_processingstarted'))
	TriggerServerEvent('esx_drugs:processCocaine')
	local timeLeft = Config.Delays.CocaProcessing / 1000
	local playerPed = PlayerPedId()

	while timeLeft > 0 do
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1

		if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.CocaProcessing.coords, false) > 4 then
			ESX.ShowNotification(_U('coca_processingtoofar'))
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

		for i=1, #cocaPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(cocaPlants[i]), false) < 1 then
				nearbyObject, nearbyID = cocaPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				ESX.ShowHelpNotification(_U('coca_pickupprompt'))
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
		
						table.remove(cocaPlants, nearbyID)
						spawnedCocas = spawnedCocas - 1
		
						TriggerServerEvent('esx_drugs:pickedUpCocaine')
					else
						ESX.ShowNotification(_U('coca_inventoryfull'))
					end

					isPickingUp = false

				end, 'coca')
			end

		else
			Citizen.Wait(500)
		end

	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(cocaPlants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnCocaPlants()
	while spawnedCocas < 25 do
		Citizen.Wait(0)
		local cocaCoords = GenerateCocaCoords()

		ESX.Game.SpawnLocalObject('prop_plant_cane_01b', cocaCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(cocaPlants, obj)
			spawnedCocas = spawnedCocas + 1
		end)
	end
end

function ValidateCocaCoord(plantCoord)
	if spawnedCocas > 0 then
		local validate = true

		for k, v in pairs(cocaPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.CocaField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateCocaCoords()
	while true do
		Citizen.Wait(1)

		local cocaCoordX, cocaCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-30, 30)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-30, 30)

		cocaCoordX = Config.CircleZones.CocaField.coords.x + modX
		cocaCoordY = Config.CircleZones.CocaField.coords.y + modY

		local coordZ = GetCoordZ(cocaCoordX, cocaCoordY)
		local coord = vector3(cocaCoordX, cocaCoordY, coordZ)

		if ValidateCocaCoord(coord) then
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
