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

make_html_to_cache = (file) ->
  content = await marked (fs.readFileSync file.path, 'utf-8')
  file.hash = make_hash content
  target_path = path.join fine.storage.cache.path, "#{file.name}.#{file.hash}.html"
  fs.writeFileSync target_path, content, 'utf-8'
  file

# file = { path: string, name: string, category?: string }
compiler = (files = [], settings) ->
  await do fine.storage.cache.clear
  hashed_files = (await make_html_to_cache file for file in files)
  runtime_apis = runtime.run hashed_files, settings
  make_entry_to_cache runtime_apis

module.exports =
  run: compiler
