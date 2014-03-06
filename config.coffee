exports.config = {
  server: 'leguin.freenode.net',
  nick: 'nplol-bot-marvin',
  options: { channels: ['#nplol'], debug: true}
}

exports.init = ->
  String::contains = (substring) ->
    ~@.toLowerCase().indexOf substring
