fx_version 'cerulean'
game 'gta5'

name 'discord-logger'
description 'Logs deaths, chat messages, commands, and more to a Discord webhook'
author 'Kmatt & Day Light Development'

-- Specify the resource version
version '1.0.0'

shared_script 'config/config.lua'

-- Specify the server script entry point
server_script {
    'server/server.lua'
}


-- ... any other configurations or dependencies ...

