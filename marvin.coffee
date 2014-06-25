util = require 'util'
BlackJack = require './lib/blackjack'

class Marvin

  constructor: (@nick) ->

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

  messageParser: (from, to, message) ->
    switch
      when message.contains "there's a retarded fellow on the bus" then @_retardedEmitter()
      when message.contains "hello #{@nick}" then @greetingParser(from)
      when message.contains "tell me a joke #{@nick}" then @_tellJoke()
      when message.contains 'bj:' then @_blackjackParser(from, message.trim())
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
      when greeter.contains @nick then greeting = 'Oh, hello self.'
      else greeting = "Who the hell are you?"

  leet_action: ->
    @leet_messages[Math.floor(Math.random() * @leet_messages.length)]

  _blackjackParser: (player, message) ->
    # message pattern: bj:<command>
    command = message.slice(3)
    console.log command
    switch
      when command == 'new'
        @_newGame(player)
      when command == 'join'
        @_joinGame(player)
      when command == 'start'
        @_startGame()
      when command == 'hit'
        @_dealCard(player)
      when command == 'stand'
        @_stand(player)
      when command == 'restart'
        @_newGame(player)

  _newGame: (name) ->
    if @game?
      if @game.state == 'done'
        @game.restart()
        "A new game has been started by #{name}"
      else
        @_inProgress()
    else
      @game = new BlackJack()
      "A new game has been started by #{name}"

  _inProgress: ->
    'Sorry brah, a game is already in progress.'

  _noGame: ->
    'Sorry brah, gotta start a new game first.'

  _joinGame: (name) ->
    return @_noGame() unless @game?
    return @_inProgress() unless @game.state == 'idle'

    player = @game.addPlayer(name)
    "You have been added, #{name}"

  _startGame: ->
    return @_noGame() unless @game?
    return @_inProgress() unless @game.state == 'idle'

    @game.start()

  _dealCard: (player) ->
    return @_noGame() unless @game?
    return 'The game is over, doofus.' if @game.state != 'ongoing'
    result = @game.deal(player)
    newPlayer = @game.step()

    # a message is simply returned if no card is dealt, either because the
    # player is out or it's not this players' turn.
    return result unless result.card

    if result.status == 'lose'
      message = 'You totally lost.'
    else
      message = 'You\'re totally still in the game'

    if newPlayer?
      next = "The next player is #{newPlayer.name}" if newPlayer?
    else
      next = 'That\'s it, folks! Time to tally it the fuck up.'

    "You got a #{result.card.stringify()}, bitch. Your score is now #{result.score} - #{message}. #{next}"

  _stand: (player) ->
    return @_noGame() unless @game?
    return 'The game is over, doofus.' if @game.state != 'ongoing'
    result = @game.stand(player)
    newPlayer = @game.step()

    if newPlayer?
      next = "The next player is #{newPlayer.name}" if newPlayer?
      "#{result} #{next}"
    else
      # we're done
      @game.finishThis()

  _retardedEmitter: ->
    'HE\'S JAPANEEEEEESE'

  _tellJoke: ->
    @jokes[Math.floor(Math.random() * @jokes.length)]


module.exports = Marvin
