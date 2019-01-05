collector = require './collector'
compiler = require './compiler'

class Builds
  
  tourist: (settings) ->
    files = collector.run do process.cwd
    await compiler.run files, settings
  
  leaguer: (settings) ->
  
  
module.exports = new Builds
