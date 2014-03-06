irc = require 'irc'
config = require('./config').config

client = new irc.Client(config.server, config.nick, config.options)
config.init()

client.addListener 'registered', (message) ->
	client.join('#nplol')

client.addListener 'netError', (error) ->
  console.log('netError: ' + error)

client.addListener 'message', (from, to, message) ->
	messageParser(from, to, message)

messageParser = (from, to, message) ->
	skovlyEmitter if from == 'skovly'
	retardedEmitter if message.contains "There's a retarded fellow on the bus"
	greetingEmitter(from) if message.contains? config.nick

skovlyEmitter = ->
	client.say('#nplol', 'Shut up, Jørgen - no one likes you.') if from == 'skovly'

retardedEmitter = ->
	client.say('#nplol', "HE'S JAPANEEEEEESE")

greetingEmitter = (greeter) ->
	client.say('#nplol', "Hello, #{greeter} - you smell exceptionally well today.")
