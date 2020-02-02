resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Bank Robbing'

version '0.0.1'

server_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'locales/en.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'client/main.lua',
	'locales/en.lua',
	'config.lua'
}

dependencies {
	'es_extended'
}

export 'progressBars'
export 'progressBars2'