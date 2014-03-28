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
          "What's shorter than 1m 50cm and has the personality of a lobster?",
          "Have you ever considered the possibility that Bent's beard is just the result of him embracing his advanced age?"
        ]

insults = [ "You smell terrible",
            "Your recent time sheets indicate you're only working 60 hours a week - pathetic",
            "My sensors indicate that your suit is of poor quality, and all your coworkers are totally aware of it",
            "Nobody likes you. I'm kidding of course, I've heard great things about you from your close friend Nikolas Jansen"
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
	client.say('#nplol', "Hello, #{greeter} - you smell exceptionally well today.")

leet_action = ->
  message = leet_messages[Math.floor(Math.random() * leet_messages.length)]
  client.say('#nplol', message)

tellJoke = ->
  random = Math.floor(Math.random() * 10)

  client.say('#nplol', 'Okay, try this on for size.') if random > 6
  joke = jokes[Math.floor(Math.random() * jokes.length)]
  client.say('#nplol', joke)

  callback = -> client.say('#nplol', 'Wow, what a terrific audience')
  setTimeout(callback, 5000) if random > 6

botFilter = (message) ->
  return false unless message.split(' ').length == 1
  return false if message.contains ":"
  return false if message.contains "haha"
  return false if message.contains "lol"

  # obviously a bot statement
  client.say('#nplol', 'Damn you, skovly - I am the only robot allowed in this channel!')
  client.say('#nplol', 'I challenge you to a duel, you may choose whatever weapon you desire. I choose insults.')
  insult = insults[Math.floor(Math.random() * insults.length)]
  client.say('#nplol', insult)

# cron job to post an interesting message very day at 13:37
job = new cronJob('00 37 13 * * *', leet_action, null, true, 'Europe/Amsterdam')

# message routing
messageParser = (from, to, message) ->
  switch
    when message.contains "there's a retarded fellow on the bus" then retardedEmitter()
    when message.contains "hello #{config.nick}" then greetingEmitter(from)
    when message.contains "tell me a joke #{config.nick}" then tellJoke()
    when from == 'skovly' then botFilter(message)
    else # do nothing


# dummy web server due to Nodejitsu config.
http.createServer().listen(8080)
