util = require 'util'
BlackJack = require './lib/blackjack'

class Marvin

  constructor: (@nick) ->
    @game = new BlackJack()
    @game.addPlayer('marvin')
    @game.addPlayer('arthur')
    @game.addPlayer('trillian')
    @game.addPlayer('zaphod')
    @game.addPlayer('femton')
    @game.addPlayer('sevve')

    @game.start()
    while @game.state == 'ongoing'
      for player in @game.players
        if player.score >= 10
          @game.stand(player.name)
        else
          @game.deal(player.name)
      @game.step()
    console.log "Game over, #{util.inspect(@game.players)}"

    @leet_messages =
      [
        'There\'s a bunny on my pancake.',
        'What came first - the cat or the internet?',
        'If dogs could talk, would you listen? They\'d probably not have
        anything interesting to say.',
        'Potatoes do not make for very interesting conversation partners,
        though I don\'t blame them.'
      ]

    @jokes =
      [
        'I heard Jørgen can bench press at least 50 pounds.',
        'Can Japanese people survive without rice?',
        'What\'s shorter than 1m 50cm and has the personality of a lobster?',
        'Have you ever considered the possibility that Bent\'s beard is just the result of him embracing his advanced age?'
      ]

    @insults =
      [
        'Your recent time sheets indicate you\'re only working
        60 hours a week - pathetic.',
        'My sensors indicate that your suit is of poor quality,
        and all your coworkers are totally aware of it.',
        'Nobody likes you. I\'m kidding of course, I\'ve heard great
        things about you from your close friend Nikolas Jansen.',
        'I overheard your co-workers talking about you, and the conversation
        indicated they were none too pleased with regards to your
        skills in the Office Suite.'
      ]

  blackjackParser: (player, message) ->
    switch
      when message == 'join'
        @_joinGame(player)
      when message == 'start'
        @_startGame()
      when message == 'hit'
        @_dealCard(player)

  _joinGame: (player) ->
    @game.addPlayer(player)

  _startGame: ->
    return 'Sorry brah, a game is already in progress.' unless @game.state == 'idle'?
    @game.start()

  _dealCard: (player) ->
    return 'Sorry brah, gotta start a new game first.' unless @game?
    result = @game.deal()
    @game.step()
    "You got a #{result.card.stringify()}, bitch. Your score is now #{result.score}"

  messageParser: (from, to, message) ->
    switch
      when message.contains "there's a retarded fellow on the bus" then @_retardedEmitter()
      when message.contains "hello #{@nick}" then @greetingParser(from)
      when message.contains "tell me a joke #{@nick}" then @_tellJoke()
      else # do nothing

  greetingParser: (greeter) ->
    switch
      when greeter.contains 'monark' then greeting = "Why hello, person of royal descent. You are looking quite regal today - also, have you been snaking lately?"
      when greeter.contains 'kengr' then greeting = "Herro fine person of asian origin. Have you remembered to do your daily math exercises this morning?"
      when greeter.contains 'severin' then greeting = 'A good day to you, Mr. Baxxter - have you produced any new, ground-breaking music?'
      when greeter.contains 'kentrobin' then greeting = "Still alive and well, are we #{greeter}? Impressive, considering your advancing years!"
      when greeter.contains 'howie' then greeting = 'A good day to you, Mr. White - Have you seen Lil\' Wayne around?'
      when greeter.contains 'femton' then gretting = 'A there he is - Good morning to you, Master Lil\' Wayne'
      when greeter.contains 'retardedbear' then greeting = "My nigga, #{greeter}."
      else greeting = "Who the hell are you?"

  leet_action: ->
    @leet_messages[Math.floor(Math.random() * @leet_messages.length)]

  _retardedEmitter: ->
    'HE\'S JAPANEEEEEESE'


  _tellJoke: ->
    @jokes[Math.floor(Math.random() * @jokes.length)]


module.exports = Marvin
