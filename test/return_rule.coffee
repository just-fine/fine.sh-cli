helps = require './helps'
{ Rule } = require 'coffee'

class ReturnRule extends Rule
  constructor: (opts) ->
    super opts

  assert: (actual, expected, message) ->
    val = helps.pick 'return', @ctx.stdout
    return expected val if typeof expected is 'function'
    super.assert val, expected, message


module.exports = ReturnRule
