fx_version 'cerulean'
game 'gta5'

name 'discord-logger'
description 'Logs Chat Messages, Respawns, & commands, & joining and leaving.'
author 'Kmatt'

-- Specify the resource version
version '1.1.0'

shared_script 'Config/config.lua'

-- Specify the server script entry point
server_scripts {
    'server/server.lua',
    'server/discord-bot.js',
}


-- ... any other configurations or dependencies ...

