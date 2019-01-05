uploader = require './uploader'

class Apis
  upload: () -> await do uploader.run

module.exports = new Apis
