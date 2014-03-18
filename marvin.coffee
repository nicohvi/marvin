irc = require 'irc'
config = require('./config').config
cronJob = require('cron').CronJob
http = require ('http')
time = require('time')
date = new time.Date()

leet_messages = [ "There's a bunny on my pancake.",
                  "What came first - the cat or the internet?",
                  "If dogs could talk, would you listen? They'd probably not have anything interesting to say.",
                  "Potatoes do not make for very interesting conversation partners, though I don't blame them."
                ]
# each one more hilarious than the last
jokes = [ "I heard Jørgen can bench press at least 50 pounds.",
          "Can Japanese people survive without rice?",
          "What's shorter than 1m 50cm and has the personality of a lobster?"
        ]

client = new irc.Client(config.server, config.nick, config.options)
config.init()

client.addListener 'netError', (error) ->
  console.log('netError: ' + error)

client.addListener 'message', (from, to, message) ->
	messageParser(from, to, message)

retardedEmitter = ->
	client.say('#nplol', "HE'S JAPANEEEEEESE")

greetingEmitter = (greeter) ->
	client.say('#derp', "Hello, #{greeter} - you smell exceptionally well today.")

leet_action = ->
  message = leet_messages[Math.floor(Math.random() * leet_messages.length)]
  client.say('#nplol', message)

tellJoke = ->
  random = Math.floor(Math.random() * 10)

  client.say('#derp', 'Okay, try this on for size.') if random > 6
  joke = jokes[Math.floor(Math.random() * jokes.length)]
  client.say('#derp', joke)

  callback = -> client.say('#derp', 'Wow, what a terrific audience')
  setTimeout(callback, 5000) if random > 6

# cron job to post an interesting message very day at 13:37
job = new cronJob('00 37 13 * * *', leet_action, null, true, 'Europe/Amsterdam')

# message routing
messageParser = (from, to, message) ->
  switch
    when message.contains "there's a retarded fellow on the bus" then retardedEmitter()
    when message.contains "hello #{config.nick}" then greetingEmitter(from)
    when message.contains "tell me a joke #{config.nick}" then tellJoke()
    else # do nothing


# dummy web server due to Nodejitsu config.
http.createServer().listen(8080)
