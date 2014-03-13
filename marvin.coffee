irc = require 'irc'
config = require('./config').config
cronJob = require('cron').CronJob
http = require ('http')
time = require('time')
date = new time.Date()

leet_messages = [ "There's a bunny on my pancake.", "What came first - the cat or the internet?",
                  "If dogs could talk, would you listen? They'd probably not have anything interesting to say.",
                  "Potatoes do not make for very interesting conversation partners, though I don't blame them."
                ]

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

leet_action = ->
  message = leet_messages[Math.floor(Math.random() * leet_messages.length)]
  client.say('#nplol', message)

# cron job to post an interesting message very day at 13:37
# time zones are a hassle, so just a quick fix is to set the time to UTC.
job = new cronJob('00 37 12 * * *', leet_action, null, true)

# dummy web server due to Nodejitsu config.
http.createServer().listen(8080)
