commander = require 'commander'
commands =
  login: require './login'
  ls: require './list'
  who: require './who'
  rm: require './remove'
  report: require './report'


dispense_command = () ->
  arg = commander.args[0]
  return false if not arg
  
  handler = commands[arg]
  return fine.exit "not found command: [#{arg}]" if arg and not handler

  process.on 'unhandledRejection', () ->

  try
    await do handler.run
  catch err
  true

module.exports =
  run: dispense_command
