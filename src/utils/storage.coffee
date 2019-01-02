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

  
class Storage
  constructor: () ->
    do init_home

  cache_dir: cache_dir
  
  claar_cache: () ->
    child.execSync("rm -rf #{cache_dir}")




