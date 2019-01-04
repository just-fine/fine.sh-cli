fs = require 'fs'
path = require 'path'
marked = require './marked'



write_to_cache = (file_path) ->
  { name } = path.parse file_path
  content = await marked (fs.readFileSync file_path, 'utf-8')
  target_path = path.join fine.storage.cache.path, "#{name}.html"
  fs.writeFileSync target_path, content, 'utf-8'

compiler = (files = []) ->
  do fine.storage.cache.clear
  write_to_cache file for file in files
  
  

module.exports =
  run: compiler
