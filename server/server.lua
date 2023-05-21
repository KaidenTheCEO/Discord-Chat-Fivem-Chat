-- Function to send a Discord webhook message
local function sendWebhookMessage(content, username)
    local payload = {
        username = username,
        content = content
    }
    PerformHttpRequest(Config.webhookUrl, function(err, text, headers) end, 'POST', json.encode(payload), { ['Content-Type'] = 'application/json' })
end

-- Log player deaths
if Config.enableDeaths then
    AddEventHandler("playerDied", function()
        local player = source
        local playerName = GetPlayerName(player)
        local deathMessage = "A player died."
        sendWebhookMessage(deathMessage, playerName)
    end)
end

-- Log chat messages
if Config.enableChat then
    AddEventHandler("chatMessage", function(source, name, message)
        local chatMessage = string.format("%s", message)
        sendWebhookMessage(chatMessage, name)
    end)
end

-- Log commands used
if Config.enableCommands then
    AddEventHandler("rconCommand", function(commandName, args)
        local playerName = GetPlayerName(source)
        local commandMessage = string.format("Command used: %s", commandName)
        sendWebhookMessage(commandMessage, playerName)
    end)
end

-- Player joining server
if Config.enableJoin then
    AddEventHandler("playerConnecting", function(playerName, setKickReason, deferrals)
        local joinMessage = "**📥 Player joined the server: **" .. playerName
        sendWebhookMessage(joinMessage, "Server")
    end)
end

-- Player leaving server
if Config.enableLeave then
    AddEventHandler("playerDropped", function(reason)
        local playerName = GetPlayerName(source)
        local leaveMessage = "**📤  Player left the server: **" .. playerName
        sendWebhookMessage(leaveMessage, "Server")
    end)
end