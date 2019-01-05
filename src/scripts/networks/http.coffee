request = require 'request-promise'

auto_parse = (body, response, full) ->
  return JSON.parse body if /application\/json/.test response.headers['content-type']
  return body

request.defaults
  jar: true
  headers:
    'Content-Type': 'application/json'
    'Authorization': ''

argv = process.argv or []
is_dev = argv.reverse()[0] is 'test'
host = (is_dev and '127.0.0.1:1337') or 'api.fine.sh'

request.make_options = (options) ->
  Object.assign {
    simple: false
    transform: auto_parse
    baseUrl: "http://#{host}/api/v1/"
  }, options

module.exports = request

