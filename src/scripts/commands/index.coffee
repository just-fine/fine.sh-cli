commander = require 'commander'
commands =
  login: require './login'
  ls: require './list'


dispense_command = () ->
  arg = commander.args[0]
  return false if not arg
  
  handler = commands[arg]
  return fine.exit "not found command: [#{arg}]" if arg and not handler
  
  await do handler.run
  true

module.exports =
  run: dispense_command
