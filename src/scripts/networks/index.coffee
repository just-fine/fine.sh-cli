uploader = require './uploader'
login = require './login'

class Apis
  upload: uploader.run
  
  login: login.run
  
  

module.exports = new Apis
