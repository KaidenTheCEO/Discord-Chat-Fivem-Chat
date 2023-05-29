-- FIVEM INTEGRATION BELOW

-- function to send Discord message
local function sendWebhookMessage(content, username, timestamp, serverId)
    local payload = {
        username = username,
        content = content,
        timestamp = timestamp,
        serverId = serverId
    }
    PerformHttpRequest(Config.webhookUrl, function(err, text, headers) end, 'POST', json.encode(payload), { ['Content-Type'] = 'application/json' })
end

local serverName = Config.serverName -- Pulling server name from Config and saving to Variable.

-- Function to get the server id # of player
local serverId = GetConvar("sv_enforceGameBuild", "1") -- Replace with the appropriate convar for the server

-- Log Chat messages 
if Config.enableChat then
    AddEventHandler("chatMessage", function(source, name, message)
        local playerName = GetPlayerName(source)
        local chatMessage = string.format("[%s] [Server ID: %s] [Chat] %s: %s", os.date("%Y-%m-%d %H:%M:%S"), serverId, playerName, message)
        sendWebhookMessage(chatMessage, playerName, os.time(), serverId)
    
    end)
end

-- Log Commands
if Config.enableCommands then
    AddEventHandler("rconCommand", function(commandName, args)
        local playerName = GetPlayerName(source)
        local commandMessage = string.format("[%s] [Server ID: %s] Command used: %s", os.date("%Y-%m-%d %H:%M:%S"), serverId, commandName)
        sendWebhookMessage(commandMessage, playerName, os.time(), serverId)
    end)
end

-- Player Joining The server
if Config.enableJoin then
    AddEventHandler("playerConnecting", function(playerName, setKickReason, deferrals)
        local joinMessage = string.format("[%s] [Server ID: %s] 📥 Player joined the server: %s", os.date("%Y-%m-%d %H:%M:%S"), serverId, playerName)
        sendWebhookMessage(joinMessage, serverName, os.time(), serverId)
    end)
end

-- Player Leaving
if Config.enableLeave then
    AddEventHandler("playerDropped", function(reason)
        local playerName = GetPlayerName(source)
        local leaveMessage = string.format("[%s] [Server ID: %s] 📤 Player left the server: %s", os.date("%Y-%m-%d %H:%M:%S"), serverId, playerName)
        sendWebhookMessage(leaveMessage, serverName, os.time(), serverId)
    end)
end

-- Player respawning
if Config.enableRespawn then
    AddEventHandler("respawnPlayerPedEvent", function(player, content)
        local playerName = GetPlayerName(player)
        local respawnMessage = string.format("[%s] [Server ID: %s] [Respawn] Player %s has respawned.", os.date("%Y-%m-%d %H:%M:%S"), serverId, playerName)
        sendWebhookMessage(respawnMessage, serverName, os.time(), serverId)
    end)
end

-- FIVEM INTEGRATION ABOVE
