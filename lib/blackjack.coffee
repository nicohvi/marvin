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

  start: ->
    @state = 'ongoing'
    for player in @players
      @deal(player.name)
      @deal(player.name)
    @step()

  addPlayer: (name) ->
    return false if @players.length == @maxPlayers && name != 'house'
    player = new Player(name)
    @house = player if name == 'house'
    @players.push player
    player

  deal: (name) ->
    player = @_findPlayer(name)
    return { lose: true } if player.state == 'lose'
    card = @deck.pick()
    player.addCard(card)
    { card: card, score: player.score}

  stand: (name) ->
    @_findPlayer(name).state = 'stand'

  step: ->
    done = true
    for player in @players
      if player.state != 'lose'
        if @_checkBust(player.score)
          player.state = 'lose'
        else if player.state == 'playing'
          done = false
    @_finishThis() if done

  _findPlayer: (name) ->
    result = @players.filter (player) ->
      player.name == name
    result[0]

  _checkBust: (score) ->
    score > 21

  _blackJack: (player) ->
    player.hand.length == 2 && player.score == 21

  _finishThis: ->
    scores = []

    candidates = @players.filter (player) ->
      player.state != 'lose'

    if candidates.length == 0 then @_allLose()

    for player in candidates
      scores.push player.score

    @addPlayer('house')
    @deal('house')
    @deal('house')
    @_houseCheck()

    while scores.max() > @house.score && @house.state == 'playing'
      @deal('house')
      @_houseCheck()

    # the house stands at 17+
    if @house.state == 'stand'
      for player in candidates
        if player.score > @house.score then player.state = 'win' else player.state = 'lose'
    @state = 'done'

  _houseCheck: ->
    return @_allWin() if @_checkBust(@house.score)
    return @_allLose() if @_blackJack(@house)
    # the house stops at 17
    @house.state = 'stand' if @house.score >= 17

  _allWin: ->
    @house.state = 'lose'
    for player in @players
      player.state = 'win' unless player.state == 'lose'

  _allLose: ->
    @house.state = 'win'
    for player in @players
      if player == @house then player.state = 'win' else player.state = 'lose'

module.exports = Blackjack
