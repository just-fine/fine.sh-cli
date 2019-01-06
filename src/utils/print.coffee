chalk = require 'chalk'

class Print
  
  constructor: (args) ->
  
  success: (text) ->
    console.log chalk.green "\n #{text}"

  error: (err) ->
    console.log chalk.red "\n #{err}"
    

    
module.exports = new Print
