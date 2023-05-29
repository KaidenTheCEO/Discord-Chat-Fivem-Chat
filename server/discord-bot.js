const Discord = require('discord.js');
const client = new Discord.Client();
const path = require('path');

// Get the absolute path to the config.json file
const configPath = path.resolve(__dirname, '..', 'Config', 'config.json');

// Load the config file
const config = require(configPath);

client.once('ready', () => {
    console.log('Connected to Discord as ' + client.user.tag);
});

client.on('message', (message) => {
    const content = message.content;
    const author = message.author;
    const roleIds = config.staffRoleIds; // Staff IDs in the config

    if (content.toLowerCase() === '!announce') {
        const guild = client.guilds.cache.get(config.guildId);
        if (!guild) {
            console.error('Guild not found. Check your guildID config in config.json');
            return;
        }
        let hasRole = false;
        for (const roleId of roleIds) {
            if (member.roles.cache.has(roleId)) {
                hasRole = true;
                break;
            }
        }
        if (hasRole) {
            const announcementMessage = content.substring(content.length -7); // Extract the announcement message from command usage.
            const formattedMessage = `^1[ANNOUNCEMENT] ${announcementMessage}`; // Format the announcement message for FiveM chat

            // Send the message to the FiveM chat
            emit('chat:addMessage', {
                color: [255, 0, 0], // Color Red
                multiline: true,
                args: [formattedMessage]
            });
        } else {
            message.reply('You have insufficent permissions');
        }
    }
});

// Retrieve the bot token from the Config.
client.login(config.botToken);