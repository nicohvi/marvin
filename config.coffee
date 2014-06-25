module.exports =  {
  server: 'leguin.freenode.net',
  nick: 'beta-marvin',
  options: { channels: ['#nplol'], debug: true},
  init: ->
    String::contains = (substring) ->
      @.toLowerCase().indexOf(substring) > -1
    String::isAllCaps = ->
      @.toUpperCase() == @
    Array::max = ->
      Math.max.apply(null, @)
    String::trim = ->
      @.replace(/\s/g,'')
}
