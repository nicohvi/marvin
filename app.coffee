Marvin = require './marvin'
irc = require 'irc'
config = require('./config').config
cronJob = require('cron').CronJob
http = require ('http')
time = require('time')
date = new time.Date()

config.init()
@marvin = new Marvin(config.nick)
@channel = '#nplol'
# @client = new irc.Client(config.server, config.nick, config.options)
#
# @client.addListener 'netError', (error) ->
#   console.log('netError: ' + error)
#
# @client.addListener 'message', (from, to, message) =>
#   @client.say @channel, @marvin.messageParser(from, to, message)
#
# @client.addListener 'join', (channel, nick, message) =>
#   console.log "ch: #{channel}, nick: #{nick}, message: #{message}"
#   @client.say @channel, @marvin.greetingParser(nick) unless nick == config.nick
#
# # cron job to post an interesting message very day at 13:37
# job = new cronJob('00 37 13 * * *', @marvin.leet_action, null, true, 'Europe/Amsterdam')

# dummy web server due to Nodejitsu config.
http.createServer().listen(8080)
