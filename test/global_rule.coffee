helps = require './helps'
{ Rule } = require 'coffee'

class GlobalRule extends Rule
  constructor: (opts) -> super opts

  assert: (actual, expected, message) ->
    val = helps.pick 'fine', @ctx.stdout
    return expected val if typeof expected is 'function'
    @assert val, expected, message


module.exports = GlobalRule
