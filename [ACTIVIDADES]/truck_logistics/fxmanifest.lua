fx_version 'cerulean'
game 'gta5'

description 'Truck Logistic'
lua54 'yes'
ui_page "nui/ui.html"

client_scripts {
	"lang/br.lua",
	"lang/en.lua",
	
	"config.lua",
	"utils.lua",
	"client.lua",
}

server_scripts {
	"lang/en.lua",
	"config.lua",
	"server.lua",
    '@oxmysql/lib/MySQL.lua'
}

files {
	"nui/ui.html",
	"nui/panel.js",
	"nui/style.css",
	"nui/img/*"
}