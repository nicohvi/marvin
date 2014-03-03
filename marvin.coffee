irc = require 'irc'
config = require('./config').config

client = new irc.Client(config.server, config.nick, {
    channels: config.channels,
});

client.addListener 'registered', (message) ->
	client.say('#nplol', 'Hello, this is robot.')

client.addListener 'error', (error) ->
	console.log "error: #{error}"