util = require 'util'
BlackJack = require '../lib/blackjack'
config = require '../config'

config.init()

@game = new BlackJack()
@game.addPlayer('marvin')
@game.addPlayer('arthur')
@game.addPlayer('trillian')
@game.addPlayer('zaphod')
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
