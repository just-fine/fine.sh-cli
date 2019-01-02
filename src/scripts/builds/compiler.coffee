os = require 'os'
home = os.homedir()






compiler = () ->
  console.log home

  
  
  

module.exports =
  run: compiler
