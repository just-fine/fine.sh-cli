os = require 'os'
fs = require 'fs'
path = require 'path'
child = require 'child_process'
home = path.join os.homedir(), '.fine'
storage_file = path.join home, 'storage.json'
cache_dir = path.join home, 'cache'

init_home = () ->
  fs.mkdirSync home if not fs.existsSync home
  fs.mkdirSync cache_dir if not fs.existsSync cache_dir
  fs.writeFileSync storage_file, '{}' if not fs.existsSync storage_file

class Cache
  path: cache_dir
  
  clear: () ->
    child.execSync "rm -rf #{cache_dir}"
    fs.mkdirSync cache_dir

class BaseIO
  find_all: () ->
    json
    try
      json = JSON.parse fs.readFileSync storage_file 'utf-8'
    catch
      json = {}
    json
  
  save_dict: (dict = {}) ->
    json = Object.assign {}, do @find_all, dict
    str = JSON.stringify json
    fs.writeFileSync storage_file, str
    json

class Storage extends BaseIO
  constructor: (arg) ->
    super arg
    do init_home
    @cache = new Cache

  cache: {}
  
  save: (key, value = null) ->
    return {} if not key
    key_value = { "#{key}": value }
    next = Object.assign {}, key_value, do @find_all
    @save_dict next
    key_value
  
  find: (key) ->
    return null if not key
    json = do @find_all
    json[key] or null
  
  clear: () ->
    @save_dict {}
    true

module.exports = new Storage
