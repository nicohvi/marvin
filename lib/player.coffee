util = require 'util'
class Player

  constructor: (@name) ->
    @hand = []
    @score = 0
    @state = 'playing'

  addCard: (card) ->
    @hand.push card
    @score += card.value

module.exports = Player
