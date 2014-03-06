exports.config = {
  server: 'leguin.freenode.net',
  nick: 'marvin_den_andre',
  options: { channels: ['#nplol'], debug: true},
  init: ->
    String::contains = (substring) ->
      @.toLowerCase().indexOf(substring) > -1
}
