exports.config = {
  server: 'leguin.freenode.net',
  nick: 'nplol-marvin2',
  options: { channels: ['#derp'], debug: true},
  init: ->
    String::contains = (substring) ->
      console.log substring
      console.log @.toLowerCase().indexOf(substring) > -1
      @.toLowerCase().indexOf(substring) > -1
}
