local spawnedMeths = 0
local methPlants = {}
local isPickingUp, isProcessing = false, false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.MethField.coords, true) < 50 then ---(1005.74, -3200.3, -38.52)
			SpawnMethPlants()
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

		if GetDistanceBetweenCoords(coords, 1005.74, -3200.3, -38.52, true) < 1 then
			if not isProcessing then
				ESX.ShowHelpNotification(_U('meth_processprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isProcessing then

				if Config.LicenseEnable then
					ESX.TriggerServerCallback('esx_license:checkLicense', function(hasProcessingLicense)
						if hasProcessingLicense then
							ProcessMeth()
						else
							OpenBuyLicenseMenu('meth_processing')
						end
					end, GetPlayerServerId(PlayerId()), 'meth_processing')
				else
					ProcessMeth()
				end

			end
		else
			Citizen.Wait(500)
		end
	end
end)

function ProcessMeth()
	isProcessing = true

	ESX.ShowNotification(_U('meth_processingstarted'))
	TriggerServerEvent('esx_drugs:processCrystal')
	local timeLeft = Config.Delays.MethProcessing / 1000
	local playerPed = PlayerPedId()

	while timeLeft > 0 do
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1

		if GetDistanceBetweenCoords(GetEntityCoords(playerPed), 1005.74, -3200.3, -38.52, false) > 4 then
			ESX.ShowNotification(_U('meth_processingtoofar'))
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

		for i=1, #methPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(methPlants[i]), false) < 1 then
				nearbyObject, nearbyID = methPlants[i], i
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
		
						table.remove(methPlants, nearbyID)
						spawnedMeths = spawnedMeths - 1
		
						TriggerServerEvent('esx_drugs:pickedUpCrystal')
					else
						ESX.ShowNotification(_U('meth_inventoryfull'))
					end

					isPickingUp = false

				end, 'meth')
			end

		else
			Citizen.Wait(500)
		end

	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(methPlants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnMethPlants()
	while spawnedMeths < 25 do
		Citizen.Wait(0)
		local methCoords = GenerateMethCoords()

		ESX.Game.SpawnLocalObject('xm_prop_x17_torpedo_case_01', methCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(methPlants, obj)
			spawnedMeths = spawnedMeths + 1
		end)
	end
end

function ValidateMethCoord(plantCoord)
	if spawnedMeths > 0 then
		local validate = true

		for k, v in pairs(methPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.MethField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateMethCoords()
	while true do
		Citizen.Wait(1)

		local methCoordX, methCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-5, 5)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-5, 5)

		methCoordX = Config.CircleZones.MethField.coords.x + modX
		methCoordY = Config.CircleZones.MethField.coords.y + modY

		local coordZ = 13.2
		local coord = vector3(methCoordX, methCoordY, coordZ)

		if ValidateMethCoord(coord) then
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
	local groundCheckHeights = { 13.2 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 13.2
end
