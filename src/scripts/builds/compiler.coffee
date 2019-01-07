fs = require 'fs'
path = require 'path'
crypto = require 'crypto'
marked = require './marked'
runtime = require './runtime'
runtime_template = require '../templates/runtime'

make_hash = (content) ->
  hash = crypto.createHash 'md5'
  hash.update content
  hash.digest 'hex'

make_entry_to_cache = (apis) ->
  content = runtime_template.replace 'FINE_INTERFACE', (JSON.stringify apis)
  target_path = path.join fine.storage.cache.path, 'index.html'
  fs.writeFileSync target_path, content, 'utf-8'

_temp_names = {}
remove_duplication = (name) ->
  if not _temp_names[name]
    _temp_names[name] = 1
    return name
  _temp_names[name] = _temp_names[name] + 1
  next = "#{name}_#{_temp_names[name]}"
  return next if next is remove_duplication next
  remove_duplication next

make_html_to_cache = (file_path) ->
  { name } = path.parse file_path
  name = remove_duplication name
  content = await marked (fs.readFileSync file_path, 'utf-8')
  hash = make_hash content
  target_path = path.join fine.storage.cache.path, "#{name}.#{hash}.html"
  fs.writeFileSync target_path, content, 'utf-8'
  { name, hash }

compiler = (files = [], settings) ->
  do fine.storage.cache.clear
  hashes = (await make_html_to_cache file for file in files)
  runtime_apis = runtime.run hashes, settings
  make_entry_to_cache runtime_apis


module.exports =
  run: compiler
