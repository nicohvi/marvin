irc = require 'irc'
config = require('./config').config


client = new irc.Client(config.server, config.nick, config.options)

client.addListener 'registered', (message) ->
	client.join('#nplol')

client.addListener 'netError', (error) -> 
  console.log('netError: ' + error)

client.addListener 'message', (from, to, message) ->
	client.say('#nplol', 'shut up') if from == 'skovly'



