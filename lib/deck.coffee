shuffle = require('knuth-shuffle').knuthShuffle
util = require 'util'

class Deck

  constructor: (@rule) ->
    @suits = ['hearts', 'cloves', 'spades', 'diamonds']
    @ranks =  [
              'two', 'three', 'four',
              'five','six','seven','eight',
              'nine', 'ten', 'jack', 'queen',
              'king', 'ace'
              ]
    @generateCards()

  generateCards: ->
    @cards = []
    for suit, index in @suits
      for rank, index in @ranks
        if @rule
          switch
            when @rule == 'blackjack'
              if index >= 10 then value = 10 else value = index+2
        else
          value = index+1
        @cards.push new Card(suit, rank, value)

  shuffle: ->
    shuffle(@cards)

  restart: ->
    @generateCards()

  pick: ->
    random = Math.floor(Math.random() * @cards.length)
    @cards.splice(0, 1)[0]

  class Card

    constructor: (@suit, @rank, @value) ->

    stringify: ->
      "{ #{@rank} of #{@suit} }"

module.exports = Deck
