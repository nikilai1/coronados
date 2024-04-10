fx_version 'cerulean'
games { 'gta5' }
author 'thedoc'
Description 'Job Notifications'
version '1.0.0'

ui_page 'ui/index.html'

files {
    'ui/**'
}

client_scripts {
    'client/**'
}

server_scripts {
    'server/**'
}

shared_scripts {
    'config.lua'
}

lua54 'yes'


escrow_ignore {
    "config.lua"
}