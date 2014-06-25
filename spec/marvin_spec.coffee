config = require '../config'
Marvin = require '../marvin'

config.init()
@marvin = new Marvin('marvin')



console.log @marvin.messageParser('tom', 'per', 'bj: new')
console.log @marvin.messageParser('tom', 'per', 'bj: join')
console.log @marvin.messageParser('per', 'per', 'bj: join')
console.log @marvin.messageParser('ola', 'per', 'bj: join')
console.log @marvin.messageParser('tom', 'per', 'bj: start')
console.log @marvin.messageParser('tom', 'per', 'bj: hit')
console.log @marvin.messageParser('tom', 'per', 'bj: stand')
console.log @marvin.messageParser('ola', 'per', 'bj: hit')
console.log @marvin.messageParser('ola', 'per', 'bj: hit')
console.log @marvin.messageParser('ola', 'per', 'bj: hit')
console.log @marvin.messageParser('tom', 'per', 'bj: stand')
console.log @marvin.messageParser('per', 'per', 'bj: hit')
console.log @marvin.messageParser('per', 'per', 'bj: stand')
console.log @marvin.messageParser('per', 'per', 'bj: restart')
console.log @marvin.messageParser('tom', 'per', 'bj: join')
console.log @marvin.messageParser('per', 'per', 'bj: join')
console.log @marvin.messageParser('ola', 'per', 'bj: join')
console.log @marvin.messageParser('tom', 'per', 'bj: start')
console.log @marvin.messageParser('tom', 'per', 'bj: hit')
console.log @marvin.messageParser('tom', 'per', 'bj: stand')
console.log @marvin.messageParser('ola', 'per', 'bj: hit')
console.log @marvin.messageParser('ola', 'per', 'bj: hit')
console.log @marvin.messageParser('ola', 'per', 'bj: hit')
console.log @marvin.messageParser('tom', 'per', 'bj: stand')
console.log @marvin.messageParser('per', 'per', 'bj: hit')
console.log @marvin.messageParser('per', 'per', 'bj: stand')
