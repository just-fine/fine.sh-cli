request = require 'request-promise'
emoji = require 'node-emoji'
chalk = require 'chalk'

auto_parse = (body, response, full) ->
  if response.statusCode is 403
    console.log ''
    console.log chalk.red " #{emoji.get 'raised_hand'}  authentication failure, access is denied."
    console.log chalk.cyan " #{emoji.get 'point_right'} try use [#{chalk.yellow 'fine login'}]"
    process.exit 1
    
  return JSON.parse body if /application\/json/.test response.headers['content-type']
  return body

make_session = () ->
  fine.storage.find 'session'

request.defaults
  jar: true
  headers:
    'Content-Type': 'application/json'

host = 'api.fine.sh'
#host = '127.0.0.1:1337'

request.make_options = (options) ->
  Object.assign {
    simple: false
    transform: auto_parse
    baseUrl: "http://#{host}/api/v1/"
    headers:
      'authentication': do make_session
  }, options

module.exports = request

