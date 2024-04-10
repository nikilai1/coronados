fx_version 'cerulean'
games { 'gta5' }


ui_page 'html/ui.html'


files {
	'html/ui.html',
  'html/main.0355962e.chunk.css',
  'html/fonts/*.ttf',
	'html/*.js'
}

client_scripts {
  'client/cl_*.lua',
  "@PolyZone/client.lua",
  "@PolyZone/ComboZone.lua",
}


server_scripts {
	'@oxmysql/lib/MySQL.lua',
  'server/sv_*.lua',
}
