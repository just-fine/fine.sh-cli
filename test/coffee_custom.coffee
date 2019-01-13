helps = require './helps'
{ Coffee, Rule } = require 'coffee'
ReturnRule = require './return_rule'
GlobalRule = require './global_rule'


class CoffeeCustom extends Coffee
  constructor: (args) ->
    super args
    @setRule 'global', GlobalRule
    @setRule 'return', ReturnRule

  @run: (module_path, opt) ->
    args = [
      '-eb'
      "
      global.fine={};
      do () -> \n
        stringify = (r) -> JSON.stringify {$$$:r}\n
        result = await do require(\"#{module_path}\").run;
        console.log 'return&&' + (stringify result) + 'return&&';
        console.log 'fine&&' + (stringify global.fine) + 'fine&&';
      "
    ]
    new CoffeeCustom {
      method: 'spawn'
      cmd: 'coffee'
      args
      opt
    }



module.exports = CoffeeCustom
