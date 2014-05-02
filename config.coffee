exports.config = {
  server: 'leguin.freenode.net',
  nick: 'beta-marvin',
  options: { channels: ['#nplol'], debug: true},
  init: ->
    String::contains = (substring) ->
      console.log substring
      console.log @.toLowerCase().indexOf(substring) > -1
      @.toLowerCase().indexOf(substring) > -1
    String::isAllCaps = ->
      @.toUpperCase() == @
}
