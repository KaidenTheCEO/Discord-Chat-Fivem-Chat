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



-- Function to log staff actions to the webhook
local function logStaffAction(action, target, staffMember)
    local message = string.format("**Staff Action**: %s\n**Target**: %s\n**Staff Member**: %s", action, target, staffMember)
    sendWebhookMessage(message, "Server")
end

-- Log vMenu bans (Not Working?)
if Config.enableVMenuBans then
    RegisterServerEvent("vMenu:BanPlayer")
    AddEventHandler("vMenu:BanPlayer", function(target, staffMember)
        logStaffAction("Ban", target, staffMember)
    end)
end

-- Log vMenu kicks (Not Working?)
if Config.enableVMenuKicks then
    RegisterServerEvent("vMenu:KickPlayer")
    AddEventHandler("vMenu:KickPlayer", function(target, staffMember)
        logStaffAction("Kick", target, staffMember)
    end)
end

-- Log vMenu noclip (Not Working?)
if Config.enableVMenuNoClip then
    RegisterServerEvent("vMenu:ToggleNoClip")
    AddEventHandler("vMenu:ToggleNoClip", function()
        local playerName = GetPlayerName(source)
        local message = string.format("**Noclip Activated**: %s", playerName)
        sendWebhookMessage(message, "Server")
    end)
end