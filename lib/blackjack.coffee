Deck = require './deck'
Player = require './player'
util = require 'util'

class Blackjack

  constructor: ->
    @deck = new Deck('blackjack')
    @deck.shuffle()
    @players = []
    @state = 'idle'
    @maxPlayers = 6

  restart: ->
    @deck = new Deck('blackjack')
    @deck.shuffle()
    @players= []
    @state = 'idle'

  addPlayer: (name, houseFlag) ->
    houseFlag ?= false
    return false if @players.length == @maxPlayers && !houseFlag
    player = new Player(name, houseFlag)
    @players.push player
    player

  start: ->
    return 'No players brosef, that\'s stupid.' unless @players.length > 0
    @state = 'ongoing'
    for player in @players
      @activePlayer = player
      @deal(player.name)
      @deal(player.name)
    @step()
    @activePlayer = @players[0]
    @report()

  deal: (name) ->
    player = @_findPlayer(name)
    return 'You\'re not playing, bro.' unless player?
    return 'You\'re out, bro.' if player.state == 'lose'
    return 'Not your turn, bro' unless @activePlayer == player || player == @house
    card = @deck.pick()
    # updates player score
    player.addCard(card)
    if player.hand.length > 1
      state = @_getPlayerState(player)
    else
      state = 'playing'
    player.state = state
    { card: card, score: player.score, status: state }

  stand: (name) ->
    player = @_findPlayer(name)
    return 'You\'re not playing, bro.' unless player?
    return 'Not your turn, bro' unless @activePlayer == player
    player.state = 'stand'
    'Pussy.'

  # main game loop, always called after a deal.
  step: ->
    return @activePlayer if @activePlayer && @activePlayer.state == 'playing'
    @activePlayer = null
    unless @activePlayer?
      # find next candidate
      for player in @players
        # not done yet
        @activePlayer = player if player.state == 'playing'
    @activePlayer

  report: ->
    report = ''
    for player in @players
      report += "#{player.stringify()} "
    "#{report}. The first player is #{@activePlayer.name}."

  finishThis: ->
    scores = []

    candidates = @players.filter (player) ->
      player.state != 'lose'

    @_addHouse()
    # everyone loses, you guys suck.
    if candidates.length == 0 then @_allLose()

    for player in candidates
      scores.push player.score

    @_houseCheck() # check if the house has a blackjack
    while scores.max() > @house.score && @house.state == 'playing'
      @deal('house')
      @_houseCheck()

    # the house stands at 17+
    for player in candidates
      if player.score > @house.score
        player.state = 'win'
      else
        player.state = 'lose'

    winners = @players.filter (player) ->
      player.state == 'win'

    if winners.length == @players.length
      @house.state = 'lose'
    else if winners.length == 0
      @house.state = 'win'
    else
      @house.state = 'tie'

    @state = 'done'

    report = ''

    for player in @players
      report += "#{player.report()} "
    report

  # private API

  _getPlayerState: (player) ->
    if @_checkBust(player.score)
      'lose'
    else
      'playing'

  _findPlayer: (name) ->
    result = @players.filter (player) ->
      player.name == name
    result[0]

  _checkBust: (score) ->
    score > 21

  _addHouse: ->
    @house = @addPlayer('house', true)
    @deal('house')
    @deal('house')

  _houseCheck: ->
    return @_allWin() if @_checkBust(@house.score)
    return @_allLose() if @_blackJack(@house)
    # the house stops at 17
    @house.state = 'stand' if @house.score >= 17

  _blackJack: (player) ->
    player.hand.length == 2 && player.score == 21

  _allWin: ->
    @house.state = 'lose'
    for player in @players
      player.state = 'win' unless player.state == 'lose'

  _allLose: ->
    @house.state = 'win'
    for player in @players
      if player == @house then player.state = 'win' else player.state = 'lose'

module.exports = Blackjack
