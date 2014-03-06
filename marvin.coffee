irc = require 'irc'
config = require('./config').config

client = new irc.Client(config.server, config.nick, config.options)
config.init()

client.addListener 'registered', (message) ->
	client.join('#mplol')

client.addListener 'netError', (error) ->
  console.log('netError: ' + error)

client.addListener 'message', (from, to, message) ->
	messageParser(from, to, message)

messageParser = (from, to, message) ->
	skovlyEmitter() if from == 'skovly'
	retardedEmitter() if message.contains "there's a retarded fellow on the bus"
	greetingEmitter(from) if message.contains "hello #{config.nick}"

skovlyEmitter = ->
	client.say('#nplol', 'Shut up, Jørgen - no one likes you.')

retardedEmitter = ->
	client.say('#nplol', "HE'S JAPANEEEEEESE")

greetingEmitter = (greeter) ->
	client.say('#nplol', "Hello, #{greeter} - you smell exceptionally well today.")
