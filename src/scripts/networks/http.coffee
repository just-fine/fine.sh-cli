request = require 'request-promise'

auto_parse = (body, response, full) ->
  if response.statusCode is 403
    fine.print.error 'authentication failure.'
    fine.print.error 'please login with command "fine login".'
    process.exit 1
    
  return JSON.parse body if /application\/json/.test response.headers['content-type']
  return body

make_session = () ->
  fine.storage.find 'session'

request.defaults
  jar: true
  headers:
    'Content-Type': 'application/json'

argv = process.argv or []
is_dev = argv.reverse()[0] is 'test'
host = (is_dev and '127.0.0.1:1337') or 'api.fine.sh'
host = '127.0.0.1:1337'

request.make_options = (options) ->
  Object.assign {
    simple: false
    transform: auto_parse
    baseUrl: "http://#{host}/api/v1/"
    headers:
      'authentication': do make_session
  }, options

module.exports = request

