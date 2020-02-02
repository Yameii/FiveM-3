Config = {}

Config.Locale = 'en'

Config.Delays = {
	WeedProcessing = 1000 * 10,
	OpiumProcessing = 1000 * 10,
	CocaProcessing = 1000 * 10,
	MethProcessing = 1000 * 10
}

Config.DrugDealerItems = {
	marijuana = 538
}

Config.LicenseEnable = true -- enable processing licenses? The player will be required to buy a license in order to process drugs. Requires esx_license

Config.LicensePrices = {
	weed_processing = {label = _U('license_weed'), price = 7500},
	opium_processing = {label = _U('license_opium'), price = 1000},
	coca_processing = {label = _U('license_coca'), price = 1000},
	meth_processing = {label = _U('license_meth'), price = 1000}
}

Config.GiveBlack = false -- give black money? if disabled it'll give regular cash.

Config.CircleZones = {
	WeedField = {coords = vector3(310.91, 4290.87, 45.15), name = _U('blip_weedfield'), color = 25, sprite = 496, radius = 100.0},
	WeedProcessing = {coords = vector3(2329.02, 2571.29, 46.68), name = _U('blip_weedprocessing'), color = 25, sprite = 501, radius = 50.0},

	OpiumField = {coords = vector3(2854.09, 4631.74, 48.92), name = _U('blip_opiumfield'), color = 43, sprite = 496, radius = 60.0},
	OpiumProcessing = {coords = vector3(1391.9, 3605.85, 38.94), name = _U('blip_opiumprocessing'), color = 43, sprite = 501, radius = 25.0},

	CocaField = {coords = vector3(259.5, 6461.66, 31.32), name = _U('blip_cocafield'), color = 37, sprite = 496, radius = 60.0},
	CocaProcessing = {coords = vector3(2434.35, 4968.62, 42.35), name = _U('blip_cocaprocessing'), color = 37, sprite = 501, radius = 25.0},

	MethField = {coords = vector3(-1171.34, -2201.65, 13.2), name = _U('blip_methfield'), color = 80, sprite = 478, radius = 60.0},
	MethBField = {coords = vector3(1732.19, 3309.61, 41.22), name = _U('blip_methBfield'), color = 80, sprite = 478, radius = 60.0},
	MethCField = {coords = vector3(3618.13, 3738.38, 28.69), name = _U('blip_methCfield'), color = 80, sprite = 478, radius = 60.0},

	DrugDealer = {coords = vector3(-1172.02, -1571.98, 4.66), name = _U('blip_drugdealer'), color = 6, sprite = 378, radius = 25.0},
}

