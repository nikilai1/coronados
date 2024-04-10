fx_version "adamant"

description "e"


game "gta5"

client_script { 
"main/client.lua"
}

server_script {
--'@mysql-async/lib/MySQL.lua',
'@oxmysql/lib/MySQL.lua',
"main/server.lua",
} 

shared_script { 
    'main/shared.lua'
}

ui_page "index.html"

files {
    'index.html',
    'vue.js',
    'assets/**/*.*'
}

lua54 'yes'
