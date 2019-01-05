uploader = require './uploader'
login = require './login'

class Apis
  upload: () -> await do uploader.run
  
  login: () -> await do login.run
  
  

module.exports = new Apis
