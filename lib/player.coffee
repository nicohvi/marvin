util = require 'util'
class Player

  constructor: (@name, @house) ->
    @hand = []
    @score = 0
    @state = 'playing'

  addCard: (card) ->
    @hand.push card
    @score += card.value

  stringify: ->
    cards = ""
    for card in @hand
      if card == @hand[@hand.length-1]
        cards += "#{card.stringify()}."
      else
        cards += "#{card.stringify()}, "
    "#{@name} has cards #{cards} (score: #{@score})"

  report: ->
    result = ''
    if @state == 'lose'
      result = 'lost :-('
    else if @state == 'win'
      result = 'won :-O'
    else if @state == 'tie'
      result = 'beat some, but not all'
    else
      result = 'apparently done something else entirely.'
    "{ #{@name} has #{result} with a score of #{@score} }"

module.exports = Player
