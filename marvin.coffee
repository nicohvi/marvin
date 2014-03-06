irc = require 'irc'
config = require('./config').config
cronJob = require('cron').CronJob
http = require ('http')
time = require('time')
date = new time.Date()

client = new irc.Client(config.server, config.nick, config.options)
config.init()

client.addListener 'netError', (error) ->
  console.log('netError: ' + error)

client.addListener 'message', (from, to, message) ->
	messageParser(from, to, message)

messageParser = (from, to, message) ->
	# skovlyEmitter() if from == 'skovly'
	retardedEmitter() if message.contains "there's a retarded fellow on the bus"
	greetingEmitter(from) if message.contains "hello #{config.nick}"

# skovlyEmitter = ->
	# client.say('#nplol', 'Shut up, Jørgen - no one likes you.')

retardedEmitter = ->
	client.say('#nplol', "HE'S JAPANEEEEEESE")

greetingEmitter = (greeter) ->
	client.say('#nplol', "Hello, #{greeter} - you smell exceptionally well today.")

clap = ->
	client.say('#nplol', '/me claps')

# cron job to post /me claps every day at 13:37
job = new cronJob('00 36 16 * * 1-7', clap, null, true, 'Norway/Oslo')


# dummy web server due to Nodejitsu config.
http.createServer().listen(8080)
